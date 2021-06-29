//
//  XPWeatherData.h
//  101xp
//
//  Created by Даниил Кравчук on 26.06.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPWeatherData : NSObject

typedef void (^weatherData)(NSString *tempreture);

- (void)currentWeatherWithLocation:(NSString *)location withBlock: (weatherData)completed;

@end

NS_ASSUME_NONNULL_END
