//
//  ViewController.h
//  SqliteExample
//
//  Created by Manju Sj on 5/19/16.
//  Copyright (c) 2016 Manju Sj. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface ViewController : UIViewController<UITextFieldDelegate>

{
    IBOutlet UITextField *regNoTextField;
    IBOutlet UITextField *nameTextField;
    IBOutlet UITextField *departmentTextField;
    IBOutlet UITextField *yearTextField;
    IBOutlet UITextField *findByRegisterNumberTextField;
    IBOutlet UIScrollView *myScrollView;
}

-(IBAction)saveData:(id)sender;
-(IBAction)findData:(id)sender;
@end

