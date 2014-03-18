//
//  ZZMainViewController.m
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

#import "ZZMainViewController.h"
#import "User.h"
#import <QuartzCore/QuartzCore.h>

#define kPayPalClientId @"AWbHJRADJx27NBhuRpRkvpT3ErfvDIE-ply7lT1Sf6t7cO-fI2ruKW2ce5hE"
#define testkPayPalClientId @"AdOp0xAJazi_waPx3pe20cCPBLlwp0NX9Ovh7Iw1BnSNpE0C2cnY6q4rI0jB"
#define kPayPalReceiverEmail @"bmyers@fuzionstudio.net"

#define webServiceProcessPayment @"http://www.fuzionstudio.net/includes/_paymentConfirmation.php?key=processFSPayment"

@interface ZZMainViewController ()

@property(nonatomic, strong, readwrite) IBOutlet UIButton *payButton;
@property(nonatomic, strong, readwrite) IBOutlet UIView *successView;

@end

@implementation ZZMainViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Tuition Payment";
	self.acceptCreditCards = YES;
    
    id delegate = [[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [delegate managedObjectContext];
	
	// Set the environment:
	// - For live charges, use PayPalEnvironmentProduction (default).
	// - To use the PayPal sandbox, use PayPalEnvironmentSandbox.
	// - For testing, use PayPalEnvironmentNoNetwork.
	self.environment = PayPalEnvironmentProduction;

	self.successView.hidden = YES;
    
    [self loadUser];

	NSLog(@"PayPal iOS SDK version: %@", [PayPalPaymentViewController libraryVersion]);
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:YES];

  //UIEdgeInsets insets = UIEdgeInsetsMake(0, 15.0f, 0, 14.0f);
  //UIImage *payBackgroundImage = [[UIImage imageNamed:@"button_secondary.png"] resizableImageWithCapInsets:insets];
  //UIImage *payBackgroundImageHighlighted = [[UIImage imageNamed:@"button_secondary_selected.png"] resizableImageWithCapInsets:insets];
  //[self.payButton setBackgroundImage:payBackgroundImage forState:UIControlStateNormal];
  //[self.payButton setBackgroundImage:payBackgroundImageHighlighted forState:UIControlStateHighlighted];
  //[self.payButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
  //[self.payButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
  
  // Optimization: Prepare for display of the payment UI by getting network work done early
  [PayPalPaymentViewController setEnvironment:self.environment];
  [PayPalPaymentViewController prepareForPaymentUsingClientId:kPayPalClientId];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)loadUser{
    _fetchRequest = [[NSFetchRequest alloc]init];
    _entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[self managedObjectContext]];
    [_fetchRequest setEntity:_entity];
    
    _fetchedObjects = [[self managedObjectContext] executeFetchRequest:_fetchRequest error:nil];
    
    if ([_fetchedObjects count] > 0) {
        User *user = [_fetchedObjects objectAtIndex:0];
        _name = user.name;
        _email = user.email;
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Pay action

- (IBAction)pay:(id)sender {

  // Remove our last completed payment, just for demo purposes.
	PayPalPayment *payment = [[PayPalPayment alloc] init];
	switch ([sender tag]) {
		case 0:
			_tuition = @"36.00";
			_description = @"1 class per month";
			break;
		case 1:
			_tuition = @"61.00";
			_description = @"2 classes per month";
			break;
		case 2:
			_tuition = @"86.00";
			_description = @"3 classes per month";
			break;
		case 3:
			_tuition = @"111.00";
			_description = @"4 classes per month";
			break;
		case 4:
			_tuition = @"131.00";
			_description = @"5 classes per month";
			break;
		case 5:
			_tuition = @"151.00";
			_description = @"6 classes per month";
			break;
		case 6:
			_tuition = @"161.00";
			_description = @"Unlimited classes per month";
			break;
	}
	payment.amount = [[NSDecimalNumber alloc] initWithString:_tuition];
	payment.currencyCode = @"USD";
	payment.shortDescription = _description;

	if (!payment.processable) {
		// This particular payment will always be processable. If, for
		// example, the amount was negative or the shortDescription was
		// empty, this payment wouldn't be processable, and you'd want
		// to handle that here.
	}

  // Any customer identifier that you have will work here. Do NOT use a device- or
  // hardware-based identifier.
  NSString *customerId = @"user-11723";
	
  [PayPalPaymentViewController setEnvironment:self.environment];

  PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithClientId:kPayPalClientId
                                                                                               receiverEmail:kPayPalReceiverEmail
                                                                                                     payerId:customerId
                                                                                                     payment:payment
                                                                                                    delegate:self];
  paymentViewController.hideCreditCardButton = !self.acceptCreditCards;
  
  // Setting the languageOrLocale property is optional.
  //
  // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
  // its user interface according to the device's current language setting.
  //
  // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
  // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
  // to use that language/locale.
  //
  // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
  paymentViewController.languageOrLocale = @"en";

  [self presentViewController:paymentViewController animated:YES completion:nil];
}

- (IBAction)confirmPayment {
	[self sendConfirmation];
	
}

- (void)sendConfirmation{
	NSDate *confirmationDate = [NSDate date];
	NSDateFormatter *confirmationDateFormatter = [[NSDateFormatter alloc]init];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
	[confirmationDateFormatter setDateFormat:@"MMddyy-HHmmss"];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	_today = [dateFormatter stringFromDate:[NSDate date]];
	_confirmationNum = [confirmationDateFormatter stringFromDate:confirmationDate];
	_confirmationNum = [NSString stringWithFormat:@"FS-%@-%u",_confirmationNum, arc4random_uniform(1000)];
	
	NSString *urlString = [NSString stringWithFormat:@"%@&confirmationNum=%@&name=%@&date=%@&email=%@&amount=%@", webServiceProcessPayment, _confirmationNum, _name, _today, _email, _tuition];
	NSLog(@"%@", urlString);
	NSURL *url = [[NSURL alloc]initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSData *data = [NSData dataWithContentsOfURL:url];
}

#pragma mark - Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
  // TODO: Send completedPayment.confirmation to server
  NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}

#pragma mark - PayPalPaymentDelegate methods

- (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment {
	NSLog(@"PayPal Payment Success!");
	self.completedPayment = completedPayment;
	self.successView.hidden = NO;
	
	[self sendConfirmation];
	
	[self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel {
  NSLog(@"PayPal Payment Canceled");
  self.completedPayment = nil;
  self.successView.hidden = YES;
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(ZZFlipsideViewController *)controller {
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    [self dismissViewControllerAnimated:YES completion:nil];
  } else {
    [self.flipsidePopoverController dismissPopoverAnimated:YES];
    self.flipsidePopoverController = nil;
  }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
  self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([[segue identifier] isEqualToString:@"showAlternate"]) {
    [[segue destinationViewController] setDelegate:self];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
      UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
      self.flipsidePopoverController = popoverController;
      popoverController.delegate = self;
    }
  }
}

- (IBAction)togglePopover:(id)sender {
  if (self.flipsidePopoverController) {
    [self.flipsidePopoverController dismissPopoverAnimated:YES];
    self.flipsidePopoverController = nil;
  } else {
    [self performSegueWithIdentifier:@"showAlternate" sender:sender];
  }
}

@end
