//
//  AttributorViewController.m
//  Attributor
//
//  Created by Denis C de Azevedo on 22/01/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "AttributorViewController.h"

@interface AttributorViewController ()

@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headLine;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;
@end

@implementation AttributorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupOutlineButton];
}

- (void)setupOutlineButton {
    if (self.outlineButton.currentTitle) {
        //Get the mutable attributed string from the button
        NSMutableAttributedString *title =
        [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
        //Set its attributes
        [title setAttributes:@{ NSStrokeWidthAttributeName: @3,
                                NSStrokeColorAttributeName: self.outlineButton.tintColor }
                       range:NSMakeRange(0, [title length])];
        //Set these modified attributes (mutable) to the button
        [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
    }

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontsChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (void)preferredFontsChanged:(NSNotification *)notification {
    [self usePreferredFonts];
}

- (void)usePreferredFonts {
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headLine.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (IBAction)changeBodySelectionColorToMatchBackgroundOfButton:(UIButton *)sender {
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                  value:sender.backgroundColor
                                  range:self.body.selectedRange];
}

- (IBAction)outlineBodySelection {
    [self.body.textStorage addAttributes:@{ NSStrokeWidthAttributeName: @-3,
                                            NSStrokeColorAttributeName: [UIColor blackColor] }
                                   range:self.body.selectedRange];
}

- (IBAction)unoutlineBodySelection {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName
                                     range:self.body.selectedRange];
}

@end
