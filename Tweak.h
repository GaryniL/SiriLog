#include <substrate.h>
#import <UIKit/UIKit.h>

@interface AceObject : NSObject
@property(nonatomic, readonly) NSMutableDictionary *dict;
@property(nonatomic, readonly) NSData *plistData;
- (NSString *)encodedClassName;
@end

@interface SABaseCommand : AceObject
@end

@interface SABaseClientBoundCommand : SABaseCommand
@property(nonatomic, copy) NSString *appId;
- (id)metricsContext;
@end

@interface SASSpeechPartialResult : SABaseClientBoundCommand

+ (id)speechPartialResult;
+ (id)speechPartialResultWithDictionary:(id)arg1 context:(id)arg2 ;

- (NSArray *)tokens;
- (void)setTokens:(NSArray *)tokens;

// AssistantServices
- (id)af_bestTextInterpretation;
- (id)af_correctionContext;
- (id)af_userUtteranceValue;
@end

@interface SAUIAddViews : SABaseClientBoundCommand
@property (nonatomic, copy) NSString *dialogPhase;
@property (nonatomic, copy) NSString *displayTarget;
@property (nonatomic, copy) NSArray *views;

// Image: /System/Library/PrivateFrameworks/AssistantServices.framework/AssistantServices

- (id)af_dialogPhase;
- (id)auxiliaryAnalyticsContext;
@end

@interface AFDialogPhase : NSObject
@property (nonatomic, readonly) NSString *aceDialogPhaseValue;

- (id)aceDialogPhaseValue;
- (id)description;

@end

@interface SAUIAssistantUtteranceView : UIView
@property (nonatomic, copy) NSString *text;
- (id)text;
@end


@protocol _SBScreenshotProvider // iOS 9.2+
- (UIImage *)captureScreenshot;
@end

@interface SBScreenshotManager : NSObject // iOS 9.2+
- (NSObject <_SBScreenshotProvider> *)_providerForScreen:(UIScreen *)screen;
- (void)saveScreenshotsWithCompletion:(void (^)())completionBlock;
@end



@interface UIApplication (iOS92)
- (SBScreenshotManager *)screenshotManager;
@end