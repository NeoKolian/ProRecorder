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
import DSWaveformImage

class ViewController: UIViewController , AVAudioPlayerDelegate , AVAudioRecorderDelegate {
    
    @IBOutlet weak var waveForm: WaveformImageView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    
    var myDBManager : DBManager = DBManagerImpl()
    
    let realm = try! Realm()
    
    var fileName: String = "audioFile.m4a"
    
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
    
    func waveDrawing() {
        let audioFileName = getDocumentsDirectory().appendingPathComponent(fileName)
        let waveformImageDrawer = WaveformImageDrawer()
        waveformImageDrawer.waveformImage(fromAudioAt: audioFileName,
                                          size: waveForm.bounds.size,
                                          style: .striped,
                                          position: .middle) { image in
            DispatchQueue.main.async {
                self.waveForm.image = image
            }
        }
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
            waveDrawing()
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
        let myRecordModel = RecordModel()

        let oldAudioFileName = getDocumentsDirectory().appendingPathComponent(fileName)
        let newAudioFileName = getDocumentsDirectory().appendingPathComponent(myRecordModel.fileName)
        do {
        try? FileManager.default.copyItem(at: oldAudioFileName, to: newAudioFileName)
        } catch {
            print(error.localizedDescription)
        }

        myDBManager.save(record: myRecordModel)
        
        saveButton.isEnabled = false
    }

}
