//
//  voiceDetailViewController.h
//  VoiceApp
//
//  Created by Flloyd Pauline Kennedy on 1/01/13.
//  Copyright (c) 2013 Flloyd Pauline Kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface voiceDetailViewController : UIViewController <UISplitViewControllerDelegate>  {
	IBOutlet UIButton *playButton;
    IBOutlet UIWebView *webView;
	AVAudioPlayer *audioPlayer;
	UIImage								*playBtnBG;
	UIImage								*pauseBtnBG;
}


@property (nonatomic, retain) UIButton *playButton;
@property (nonatomic, retain) UIWebView *webView;

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
-(IBAction)playAudio;
@end
