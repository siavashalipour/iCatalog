//
//  ViewController.m
//  iCatalog
//
//  Created by Siavash on 1/26/14.
//  Copyright (c) 2014 SiavashAlp. All rights reserved.
//

#import "ViewController.h"
#import "MapViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property (strong, nonatomic) NSArray *imagesArray;

#define IMAGE_ZOOM_TAG (1)
@end

@implementation ViewController
{
    int pageNumber;
    BOOL pageControllerBeingUsed;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToTheMap"]) {
        MapViewController *mvc = segue.destinationViewController;
        if (pageNumber == 0) {
            mvc.title = @"Sydney Opera House";
            mvc.longitude = 151.2140;
            mvc.latitude = -33.8587;
            
        }
        else if (pageNumber == 1){
            mvc.title = @"Cupertino";
            mvc.longitude = -122.0419;
            mvc.latitude = 37.3175;
        }
        else if (pageNumber == 2){
            mvc.title = @"Eiffel Tower";
            mvc.longitude = 2.2945;
            mvc.latitude = 48.8582;
        }
    }
}
- (NSArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [NSArray arrayWithObjects:
                        [UIImage imageNamed:@"page1.png"],
                        [UIImage imageNamed:@"page2.png"],
                        [UIImage imageNamed:@"page3.png"],nil];
    }
    return _imagesArray;
}

- (UIScrollView *)addImageFromArray:(NSArray *)imgArray
{
    UIScrollView *mainSv = [[UIScrollView alloc] initWithFrame:self.mainScrollView.bounds];
    
    mainSv.pagingEnabled = YES;
    mainSv.showsHorizontalScrollIndicator = NO;
    mainSv.showsVerticalScrollIndicator = NO;
    
    CGRect innerScrollFrame = self.mainScrollView.bounds;
    // CGSize testsize = CGSizeMake(703, 1024);
	for (int i = 0; i < imgArray.count; i++) {
		
        
		UIImageView *img = [[UIImageView alloc] initWithImage:[imgArray objectAtIndex:i]];
        
        img.tag = IMAGE_ZOOM_TAG;
        
		UIScrollView *pageScrollView = [[UIScrollView alloc] initWithFrame:innerScrollFrame];
        
        
        pageScrollView.minimumZoomScale = 1.0f;
        pageScrollView.maximumZoomScale = 2.0f;
        pageScrollView.zoomScale = 0.33f;
        pageScrollView.contentSize = img.bounds.size;
        
        //pageScrollView.contentSize = self.testView.bounds.size;
        pageScrollView.delegate = self;
        pageScrollView.showsHorizontalScrollIndicator = NO;
        pageScrollView.showsVerticalScrollIndicator = NO;
        [pageScrollView addSubview:img];
        
        mainSv.delegate = self;
        [mainSv addSubview:pageScrollView];
        
        if (i < (imgArray.count - 1)) {
            innerScrollFrame.origin.x += innerScrollFrame.size.width;
        }
    }
    mainSv.contentSize = CGSizeMake(innerScrollFrame.origin.x + innerScrollFrame.size.width, mainSv.bounds.size.height);
    return mainSv;
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth /2)/pageWidth) + 1;
    self.pageController.currentPage = page;
    pageNumber = self.pageController.currentPage;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControllerBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControllerBeingUsed = NO;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView viewWithTag:IMAGE_ZOOM_TAG];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.title = [@"Welcome " stringByAppendingString:self.userID];
    [self.mainScrollView addSubview:[self addImageFromArray:self.imagesArray]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
