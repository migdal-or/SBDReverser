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
#import "Masonry.h"

const NSString *SBDTextFieldDefault = @"Enter string";
const NSString *SBDGreetingMessage = @"Hello";

@interface ViewController ()<UITextFieldDelegate>

@property(nonatomic, strong) UILabel *greetingLabel;
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
    self.uppercaseButton.layer.cornerRadius = CGRectGetWidth(self.uppercaseButton.frame)/2;
    
    self.sourceStringField.text = [SBDTextFieldDefault copy];
    
    self.greetingLabel = [UILabel new];
    self.greetingLabel.text = SBDGreetingMessage;
    self.greetingLabel.textColor = [UIColor whiteColor];
    
//    NSDictionary *subviews = @{
//                               @"greetingLabel":self.greetingLabel,
//                               @"sourceStringField":self.sourceStringField
//                               };
    
//    self.greetingLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.greetingLabel];

    [self.greetingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(40);
        make.height.equalTo(@20);
        make.width.lessThanOrEqualTo(@40);
        make.bottom.equalTo(self.resultLabel.mas_top);
    } ];
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom).with.offset(64);
        
    }];
    
    [NSLayoutConstraint activateConstraints:self.view.constraints];
    
    
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
        textField.text = [SBDTextFieldDefault copy]; // Перенос строки ниже условия сломает логику (можно использовать в кейсе)
    }
}

@end
