//
//  SoundHIGExample.swift
//  UIKitPlayground
//
//  Created by Minyoung Yoo on 12/1/23.
//

import UIKit
import AVFoundation

class AudioSession {
    
    static let session: AVAudioSession = AVAudioSession()
    
    private init() { }
    
}

class SoundHIGExample: UIViewController, AVAudioPlayerDelegate {
    
    //audio settings
    let audioSession = AudioSession.session
    let audioFile: URL = Bundle.main.url(forResource: "wegotogether", withExtension: "m4a")!
    var audioPlayer: AVAudioPlayer? = nil
    
    //button
    let playButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setTitle("Play Audio", for: .normal)
        btn.configuration = .borderedProminent()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        setupUI()
    }
    
    func setupUI() {
        self.view.addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
}

//target action
extension SoundHIGExample {
    
    @objc func playAudio() {
        //get audio session
        try? audioSession.setCategory(.playback, options: .duckOthers)
        try? audioSession.setActive(true)
        
        //set player
        self.audioPlayer = try? AVAudioPlayer(contentsOf: audioFile)
        self.audioPlayer?.delegate = self
        
        //play audio
        audioPlayer?.play()
        print("audio playback is started")
    }
    
}

//delegate
extension SoundHIGExample {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //stops audio
        player.stop()
        
        //release audio session
        try? audioSession.setActive(false)
        print("audio playback is finished")
    }
    
}
