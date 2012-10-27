/*
 *	Copyright David Book, buzztouch.com
 *
 *	All rights reserved.
 *
 *	Redistribution and use in source and binary forms, with or without modification, are 
 *	permitted provided that the following conditions are met:
 *
 *	Redistributions of source code must retain the above copyright notice which includes the
 *	name(s) of the copyright holders. It must also retain this list of conditions and the 
 *	following disclaimer. 
 *
 *	Redistributions in binary form must reproduce the above copyright notice, this list 
 *	of conditions and the following disclaimer in the documentation and/or other materials 
 *	provided with the distribution. 
 *
 *	Neither the name of David Book, or buzztouch.com nor the names of its contributors 
 *	may be used to endorse or promote products derived from this software without specific 
 *	prior written permission.
 *
 *	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
 *	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
 *	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
 *	IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
 *	INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT 
 *	NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
 *	PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
 *	WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
 *	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY 
 *	OF SUCH DAMAGE. 
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "iAd/ADBannerView.h"
#import "JSON.h"
#import "mygoodvoice_appDelegate.h"
#import "BT_item.h"
#import "BT_debugger.h"
#import "BT_viewControllerManager.h"
#import "BT_viewUtilities.h"
#import "BT_viewController.h"

@implementation BT_viewController
@synthesize progressView, screenData;
@synthesize adView, adBannerView, adBannerViewIsVisible;
@synthesize hasStatusBar, hasNavBar, hasToolBar;

//initWithScreenData
-(id)initWithScreenData:(BT_item *)theScreenData{
	if((self = [super init])){
		[BT_debugger showIt:self:@"INIT"];

		//set screen data
		[self setScreenData:theScreenData];
		
	}
	 return self;
}

//show progress
-(void)showProgress{
	[BT_debugger showIt:self:@"showProgress"];
	
	//show progress view if not showing
	if(progressView == nil){
		progressView = [BT_viewUtilities getProgressView:@""];
		[self.view addSubview:progressView];
	}	
	
}

//hide progress
-(void)hideProgress{
	[BT_debugger showIt:self:@"hideProgress"];
	
	//remove progress view if already showing
	if(progressView != nil){
		[progressView removeFromSuperview];
		progressView = nil;
	}

}

//left button
-(void)navLeftTap{
	[BT_debugger showIt:self:@"navLeftTap"];
    
    //child apps are handled different...
    mygoodvoice_appDelegate *appDelegate = (mygoodvoice_appDelegate *)[[UIApplication sharedApplication] delegate];
    if([appDelegate.rootApp isChildApp]){
        [BT_viewControllerManager closeChildApp];
    }else{
        //handle "left" transition
        [BT_viewControllerManager handleLeftButton:screenData];
    }
	
}

//right button
-(void)navRightTap{
	[BT_debugger showIt:self:@"navRightTap"];
	
	//handle "right" transition
	[BT_viewControllerManager handleRightButton:screenData];
	
}

//show audio controls
-(void)showAudioControls{
	[BT_debugger showIt:self:@"showAudioControls"];
	
	//appDelegate
	mygoodvoice_appDelegate *appDelegate = (mygoodvoice_appDelegate *)[[UIApplication sharedApplication] delegate];	
	[appDelegate showAudioControls];

}

//show alert
-(void)showAlert:(NSString *)theTitle:(NSString *)theMessage:(int)alertTag{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:theTitle message:theMessage delegate:self
	cancelButtonTitle:NSLocalizedString(@"ok", "OK") otherButtonTitles:nil];
	[alertView setTag:alertTag];
	[alertView show];
	[alertView release];
}

//"OK" clicks on UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	[BT_debugger showIt:self:[NSString stringWithFormat:@"alertView:clickedButtonAtIndex: %i", buttonIndex]];
	
	//handles OK click after emailing an image from BT_screen_imageEmail
	if([alertView tag] == 99){
		[self.navigationController popViewControllerAnimated:YES];
	}

	//handles OK click after sharing from BT_screen_shareFacebook or BT_screen_shareTwitter
	if([alertView tag] == 199){
		[self navLeftTap];
	}
	
}


////////////////////////////////////////////
//Ad Size Methods

//createAdBannerView
-(void)createAdBannerView{
    Class classAdBannerView = NSClassFromString(@"ADBannerView");
    if(classAdBannerView != nil){
		[BT_debugger showIt:self:[NSString stringWithFormat:@"createiAdBannerView: %@", @""]];
		self.adView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
		self.adView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth);	
		[self.adView setTag:94];
		self.adBannerView = [[[classAdBannerView alloc] initWithFrame:CGRectZero] autorelease];
		[self.adBannerView setDelegate:self];
		[self.adBannerView setTag:955];
		if(UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            [adBannerView setCurrentContentSizeIdentifier: ADBannerContentSizeIdentifierLandscape];
        }else{
            [adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];            
        }
		[self.adView setFrame:[BT_viewUtilities frameForAdView:self:screenData]];
		[adView setBackgroundColor:[UIColor clearColor]];
		[self.adView addSubview:self.adBannerView];
        [self.view addSubview:adView];
		[self.view bringSubviewToFront:adView];        
    }
}

//showHideAdView
-(void)showHideAdView{
	[BT_debugger showIt:self:[NSString stringWithFormat:@"showHideAdView: %@", @""]];
	if(adBannerView != nil){   
		//we may need to change the banner ad layout
		if(UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            [adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierLandscape];
        }else{
            [adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];
        }
        [UIView beginAnimations:@"positioniAdView" context:nil];
		[UIView setAnimationDuration:1.5];
        if(adBannerViewIsVisible){
            [self.adView setAlpha:1.0];
        }else{
			[self.adView setAlpha:.0];
       }
	   [UIView commitAnimations];
    }   
}

//banner view did load...
-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
	[BT_debugger showIt:self:[NSString stringWithFormat:@"iAd bannerViewDidLoadAd%@", @""]];
    if(!adBannerViewIsVisible) {                
        adBannerViewIsVisible = YES;
        [self showHideAdView];
    }
}
 
//banner view failed to get add
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
	[BT_debugger showIt:self:[NSString stringWithFormat:@"iAd didFailToReceiveAdWithError: %@", [error localizedDescription]]];
	if (adBannerViewIsVisible){        
        adBannerViewIsVisible = NO;
        [self showHideAdView];
    }
}


//should rotate
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	[BT_debugger showIt:self:[NSString stringWithFormat:@"shouldAutorotateToInterfaceOrientation %@", @""]];
	
	//allow / dissallow rotations
	BOOL canRotate = TRUE;
	
	//appDelegate
	mygoodvoice_appDelegate *appDelegate = (mygoodvoice_appDelegate *)[[UIApplication sharedApplication] delegate];
	if([appDelegate.rootApp.rootDevice isIPad]){
		canRotate = TRUE;
	}else{
		//should we prevent rotations on small devices?
		if([appDelegate.rootApp.jsonVars objectForKey:@"allowRotation"]){
			if([[appDelegate.rootApp.jsonVars objectForKey:@"allowRotation"] isEqualToString:@"largeDevicesOnly"]){
				canRotate = FALSE;
			}
		}
	}
	
	//can it rotate?
	if(canRotate){
		return YES;
	}else{
		return (interfaceOrientation == UIInterfaceOrientationPortrait);
	}
	
	//we should not get here
	return YES;
	
}



//will rotate
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
	[BT_debugger showIt:self:[NSString stringWithFormat:@"willRotateToInterfaceOrientation %@", @""]];
	
	//delegate
	mygoodvoice_appDelegate *appDelegate = (mygoodvoice_appDelegate *)[[UIApplication sharedApplication] delegate];
    
	//some screens need to reload...
	UIViewController *theViewController;
	int selectedTab = 0;
	if([appDelegate.rootApp.tabs count] > 0){
		selectedTab = [appDelegate.rootApp.rootTabBarController selectedIndex];
		theViewController = [[appDelegate.rootApp.rootTabBarController.viewControllers objectAtIndex:selectedTab] visibleViewController];
	}else{
		theViewController = [appDelegate.rootApp.rootNavController visibleViewController];
	}
    
    //if we have an ad view we may need to modify it's layout...
	for(UIView* subView in [theViewController.view subviews]){
		if(subView.tag == 94){
			for(UIView* subView_2 in [subView subviews]){
				if(subView_2.tag == 955){
					
                    ADBannerView *theAdView = (ADBannerView *)subView_2;
                    if([subView_2 respondsToSelector:@selector(setCurrentContentSizeIdentifier:)]){
                        if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
                            [theAdView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierLandscape];
                        }else{
                            [theAdView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];
                        }
                    }
                    
                    
				}
			}
			break;
		}
	}
    
    
    
    //if this view controller has a property named "rotating" set it to false...This for sure
    //is used in the Image Gallery plugin...
    if ([theViewController respondsToSelector:NSSelectorFromString(@"setIsRotating")]) {
        SEL s = NSSelectorFromString(@"setIsRotating");
        [theViewController performSelector:s];
    }
    
    
    
}


//did rotate
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
	[BT_debugger showIt:self:[NSString stringWithFormat:@"didRotateFromInterfaceOrientation %@", @""]];
	
	//delegate
	mygoodvoice_appDelegate *appDelegate = (mygoodvoice_appDelegate *)[[UIApplication sharedApplication] delegate];
    
	UIViewController *theViewController;
	int selectedTab = 0;
	if([appDelegate.rootApp.tabs count] > 0){
		selectedTab = [appDelegate.rootApp.rootTabBarController selectedIndex];
		theViewController = [[appDelegate.rootApp.rootTabBarController.viewControllers objectAtIndex:selectedTab] visibleViewController];
    }else{
		theViewController = [appDelegate.rootApp.rootNavController visibleViewController];
	}
    
    //if this view controller has a property named "rotating" set it to false...
    if([theViewController respondsToSelector:NSSelectorFromString(@"setNotRotating")]) {
        SEL s = NSSelectorFromString(@"setNotRotating");
        [theViewController performSelector:s];
    }
    
    
	//some screens need to re-build their layout...If a plugin has a method called
    //"layoutScreen" we trigger it everytime the device rotates. The plugin author can
    //create this method in the UIViewController (layoutScreen) if they need something to
    //happen after rotation occurs.
    
    //if this view controller has a "layoutScreen" method, trigger it...
    if([theViewController respondsToSelector:@selector(layoutScreen)]){
        SEL s = NSSelectorFromString(@"layoutScreen");
        [theViewController performSelector:s];
    }
    
    
}




//dealloc
- (void)dealloc {
    [super dealloc];
}

@end







