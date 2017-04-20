//
//  ViewController.m
//  Reverser
//
//  Created by Alexey Ulenkov on 25.02.17.
//  Copyright © 2017 Alexey Ulenkov. All rights reserved.
//

#import "ViewController.h"
#import "SBDReverser.h"
#import "SBDUpperCase.h"

const NSString *kTextFieldDefault = @"Enter string";

@interface ViewController ()<UITextFieldDelegate>

@property(nonatomic, weak) IBOutlet UITextField *sourceStringField;
@property(nonatomic, weak) IBOutlet UILabel *resultLabel;
@property(nonatomic, weak) IBOutlet UIButton *reverseButton;
@property(nonatomic, weak) IBOutlet UIButton *uppercaseButton;

@end

@implementation ViewController

#pragma mark - ViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reverseButton.layer.cornerRadius = CGRectGetWidth(self.reverseButton.frame)/2;
    self.sourceStringField.text = [kTextFieldDefault copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (IBAction)reverse:(id)sender {
    self.resultLabel.text = [SBDReverser reverseString:self.sourceStringField.text];
}

- (IBAction)upperCase:(id)sender {
    self.resultLabel.text = [SBDUpperCase upperCase:self.sourceStringField.text];
}

#pragma mark - User interations

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([self.sourceStringField isFirstResponder]
        && [touch view]!=self.sourceStringField) {
        [self.sourceStringField resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.sourceStringField isFirstResponder]) {
        [self.sourceStringField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        self.resultLabel.text = @"";
        textField.text = [kTextFieldDefault copy]; // Перенос строки ниже условия сломает логику (можно использовать в кейсе)
    }
}

@end
