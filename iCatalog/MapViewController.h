//
//  MapViewController.h
//  iCatalog
//
//  Created by Siavash on 1/26/14.
//  Copyright (c) 2014 SiavashAlp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController
{
    MKMapView *mapView;
}
@property (nonatomic) double longitude;
@property (nonatomic) double latitude;

@end
