//
//  XPWeatherData.m
//  101xp
//
//  Created by Даниил Кравчук on 26.06.2021.
//

#import "XPWeatherData.h"

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@implementation XPWeatherData

- (void)currentWeatherWithLocation:(NSString *)location withBlock: (weatherData)completed{
    
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    
    NSString *locationUrlString = [NSString stringWithFormat:@"https://www.metaweather.com/api/location/search/?query=%@", location];
    NSURL *locationUrl = [NSURL URLWithString:locationUrlString];
    NSMutableURLRequest *locationUrlRequest = [NSMutableURLRequest requestWithURL:locationUrl];
    
    NSURLSessionDataTask *dataTaskLocation = [defaultSession dataTaskWithRequest:locationUrlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        if (error) {
            completed(@"Error occured");
            return;
            }
        
        NSDictionary *jsonDictionaryLocation = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

        if (jsonDictionaryLocation.count == 0){
            completed(@"Error occured");
            return;
        }
        
        NSString *weatherUrlString = [NSString stringWithFormat:@"https://www.metaweather.com/api/location/%@/", [jsonDictionaryLocation valueForKey:@"woeid"][0]];
        
        NSURL *weatherUrl = [NSURL URLWithString:weatherUrlString];
        
        NSMutableURLRequest *weatherUrlRequest = [NSMutableURLRequest requestWithURL:weatherUrl];
        
        NSURLSessionDataTask *dataTaskWeather = [defaultSession dataTaskWithRequest:weatherUrlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSDictionary *jsonDictionaryWeather = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                
            completed([[jsonDictionaryWeather valueForKey:@"consolidated_weather"][0] valueForKey:@"the_temp"]);

        }];
        [dataTaskWeather resume];
        
    }];
    
    
    
    
    // Fire the request
    [dataTaskLocation resume];
    
}


@end
