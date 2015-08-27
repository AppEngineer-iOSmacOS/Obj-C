//
//  ViewController.m
//  30_Uchenik
//
//  Created by Nikolay Sozinov on 26.08.15.
//  Copyright (c) 2015 Nikolay Sozinov. All rights reserved.
/*
 
 1. Создайте таблицу которая содержит 1000 разных ячеек.
 2. для каждой ячейки генирируйте радномный цвет.
 3. RGB данные пишите в тексте ячейки, например: RGB(10,20,255)
 4. Также раскрашивайте текст ячейки этим цветом.
 
 */
//

#import "ViewController.h"
#import "Custom.h"

@interface ViewController ()

@property (assign, nonatomic) NSInteger  numberOfRows;

@property (assign, nonatomic) CGFloat  redColor;
@property (assign, nonatomic) CGFloat  greenColor;
@property (assign, nonatomic) CGFloat  blueColor;

@property (strong, nonatomic) Custom *custom;
@property (strong, nonatomic) NSMutableArray *customArray;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.numberOfRows = 1000;
    self.customArray = [NSMutableArray array];
    
    for (NSInteger row = 0; row < self.numberOfRows; row++)
    {
        self.custom = [[Custom alloc] init];
        self.custom.color = [self rendomColorRGB];
        self.custom.name = [NSString stringWithFormat:@"Row: %d reused cell color in RGB (%d, %d, %d)", row,
                            (int)(self.redColor * 256), (int)(self.greenColor * 256), (int)(self.blueColor * 256)];
        
        [self.customArray addObject:self.custom];
    }

//отступ сверху

    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    self.tableView.contentInset = inset;
    self.tableView.scrollIndicatorInsets = inset;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor *) rendomColorRGB {

    self.redColor = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    self.greenColor = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    self.blueColor = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithRed:self.redColor green:self.greenColor blue:self.blueColor alpha:1];

}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger nomberOfSections = 1;
    return nomberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return self.numberOfRows;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *titleForHeader = [NSString stringWithFormat:@"%d cell color", (int)self.numberOfRows];
    return titleForHeader;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* indentifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        cell.backgroundColor = [self rendomColorRGB];
        cell.textLabel.text = @"cell created for rendom Color";
        NSLog(@"cell created");
    } else {
        
        self.custom = [self.customArray objectAtIndex:indexPath.row];
        cell.textLabel.text = self.custom.name;
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:13];
        cell.backgroundColor = self.custom.color;
        
        NSLog(@"cell reused");
    }
    return cell;
}
@end
