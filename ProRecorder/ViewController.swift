//
//  ViewController.swift
//  ProRecorder
//
//  Created by Nikolay Pochekuev on 14.01.2020.
//  Copyright © 2020 Nikolay Pochekuev. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift

class ViewController: UIViewController , AVAudioPlayerDelegate , AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    var fileName: String = "audioFile.m4a"
    
    var myVoiceRecord = VoiceRecord()
//    var myVoiceRecord: Results<VoiceRecord>?
    let realm = try! Realm()
//    let defaultPath = Realm.Configuration.defaultConfiguration
//    let defaultManager = try FileManager.defaultManager().removeItemAtPath(defaultPath)
//
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
        playButton.isEnabled = false
        saveButton.isEnabled = false
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func setupRecorder() {
        let audioFileName = getDocumentsDirectory().appendingPathComponent(fileName)
        let recordSetting = [ AVFormatIDKey : kAudioFormatAppleLossless,
                              AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                              AVEncoderBitRateKey : 320000,
                              AVNumberOfChannelsKey : 2,
                              AVSampleRateKey : 44100.2] as [String : Any]
        do {
            soundRecorder = try AVAudioRecorder(url: audioFileName, settings: recordSetting)
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        } catch {
            print (error)
        }
    }
    
    func setupPlayer() {
        let audioFileName = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: audioFileName)
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 1.0
        } catch {
            print(error)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playButton.isEnabled = true
        saveButton.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
        playButton.setTitle("Play", for: .normal)
    }
    
    @IBAction func recordAct(_ sender: Any) {
        
        if recordButton.titleLabel?.text == "Record" {
            soundRecorder.record()
            recordButton.setTitle("Stop", for: .normal)
            playButton.isEnabled = false
        } else {
            soundRecorder.stop()
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = false
        }
    }
    
    @IBAction func playAct(_ sender: Any) {
        
        if playButton.titleLabel?.text == "Play" {
            playButton.setTitle("Stop", for: .normal)
            recordButton.isEnabled = false
            setupPlayer()
            soundPlayer.play()
        } else {
            soundPlayer.stop()
            playButton.setTitle("Play", for: .normal)
            recordButton.isEnabled = false
        }
    }
    
    @IBAction func saveAct(_ sender: UIButton) {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        try! realm.write {
            realm.add(myVoiceRecord)
//                       let newVoiceRecord = VoiceRecord()
//                       //                newVoiceRecord.title = title!
//                       print(title)
//                       newVoiceRecord.dateCreated = Date()
                   }
        do {
        } catch {
            print("Error saving new items, \(error)")
        }
    }
}

