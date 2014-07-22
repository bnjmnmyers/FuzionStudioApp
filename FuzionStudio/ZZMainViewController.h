//
//  ZZMainViewController.h
//  PayPal-iOS-SDK-Sample-App
//
//  Copyright (c) 2013, PayPal
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//   LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those
//  of the authors and should not be interpreted as representing official policies,
//  either expressed or implied, of the FreeBSD Project.
//

#import "ZZFlipsideViewController.h"
#import "PayPalMobile.h"
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ZZMainViewController : UIViewController <PayPalPaymentDelegate, ZZFlipsideViewControllerDelegate, UIPopoverControllerDelegate, MFMailComposeViewControllerDelegate>

@property(nonatomic, strong, readwrite) UIPopoverController *flipsidePopoverController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (strong, nonatomic) NSArray *fetchedObjects;

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) PayPalPayment *completedPayment;
@property(nonatomic, strong) NSString *tuition;
@property(nonatomic, strong) NSString *description;
@property(nonatomic, strong) NSString *confirmationNum;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *today;
@property(nonatomic, strong) NSString *email;

@property (strong, nonatomic) IBOutlet UIButton *oneClassBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoClassesBtn;
@property (strong, nonatomic) IBOutlet UIButton *threeClassesBtn;
@property (strong, nonatomic) IBOutlet UIButton *fourClassesBtn;
@property (strong, nonatomic) IBOutlet UIButton *fiveClassesBtn;
@property (strong, nonatomic) IBOutlet UIButton *sixClassesBtn;
@property (strong, nonatomic) IBOutlet UIButton *unlimitedClassesBtn;
@property (weak, nonatomic) IBOutlet UITextField *tfOtherAmount;
@property (weak, nonatomic) IBOutlet UITextField *tfDescription;

- (IBAction)pay:(id)sender;

- (IBAction)confirmPayment;

@end
