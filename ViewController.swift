//
//  ViewController.swift
//  System Volume
//
//  Created by E Launch on 24/09/19.
//  Copyright © 2019 ELaunch. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {

    private var audioLevel : Float = 0.0
    @IBOutlet var lblVolume: UILabel!
    private let volumeView: MPVolumeView = MPVolumeView()
    @IBOutlet var volumeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
    }
   
   
    @IBAction func changeVal(_ sender: UISlider) {
        setVolume(sender.value)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setVolume(0.5)
        volumeSlider?.setValue(0.5, animated: true)
    }
    
    func setVolume(_ volume: Float) {
            let volumeView = MPVolumeView()
            let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
                slider?.value = volume
                self.lblVolume.text = "\(volume)"
            }
        }
    func addObserver(){
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
            audioSession.addObserver(self, forKeyPath: "outputVolume",options: NSKeyValueObservingOptions.new, context: nil)
            audioLevel = audioSession.outputVolume
            lblVolume.text = "\(audioLevel)"
            volumeSlider.setValue(audioLevel, animated: true)
        }catch{}
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "outputVolume"{
            let audioSession = AVAudioSession.sharedInstance()
            audioLevel = audioSession.outputVolume
            lblVolume.text = "\(audioLevel)"
            volumeSlider.setValue(audioLevel, animated: true)
        }
    }
}

