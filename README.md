AnonymusDelegate
================

A experimental way of implement a delegate with blocks. This allows to build thinks like this:

	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Mensage de test" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
	
	alert.delegate = dynProtocol(@selector(alertView:clickedButtonAtIndex:), ^(SEL c, UIAlertView *v, NSInteger i) {
		NSLog(@"Success. alert %@ - i = %d", v, i);
	}, @selector(willPresentAlertView:), ^(SEL c, UIAlertView *v) {
		NSLog(@"Will present alert. alert = %@", v);
	}, @selector(didPresentAlertView:), ^(SEL c, UIAlertView *v) {
		NSLog(@"Did present alert. alert = %@", v);
	}, NULL);
    
	[alert show];

The code is mostly pure C but is really simple.
