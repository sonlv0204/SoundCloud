//
//  PlayerViewController.swift
//  SoundCloud
//
//  Created by admin on 29.09.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    var viewModel = PlayerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.viewModel.setupMainView(self,imageView: mainImageView, titleLabel: titileLabel, subTitleLabel: subTitle)
    }
    
    @IBAction func playPauseButtonAction(sender: AnyObject) {
        self.viewModel.playPause(playPauseButton,slider: slider)
        _ = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(PlayerViewController.updateSlide), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func nextTrackButtonAction(sender: AnyObject) {
        self.viewModel.nextTrack(playPauseButton, imageView: mainImageView, titleLabel: titileLabel, subTitleLabel: subTitle,slider: slider)
    }
    
    @IBAction func previousTrackButtonAction(sender: AnyObject) {
        self.viewModel.previousTrack(playPauseButton, imageView: mainImageView, titleLabel: titileLabel, subTitleLabel: subTitle,slider: slider)
    }
    
    @IBAction func sliderAction(sender: AnyObject) {
        self.viewModel.player?.play()
        self.viewModel.changeTime(slider)
    }
    
    func updateSlide(){
        slider.value = Float((self.viewModel.player?.currentTime().seconds)!)
        if self.viewModel.player?.currentItem?.duration.seconds.isNaN == false {
            slider.maximumValue = Float((self.viewModel.player?.currentItem?.duration.seconds)!)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.viewModel.player?.pause()
    }
    
}
