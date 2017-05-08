#import "Tweak.h"
#import "PO2Log.h"

SASSpeechPartialResult *partialResult;


// %hook SAUIAddViews
// + (id)addViewsWithDictionary:(id)arg1 context:(id)arg2 {
//      // PO2Log([NSString stringWithFormat:@"[GGGGG] addViewsWithDictionary %@ oooo %@", arg1, arg2], 1);
//      return %orig;
// }
// %end

static NSString* getCurrecnTime(){
    NSDate * now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm:ss"];
    NSString *newDateString = [outputFormatter stringFromDate:now];
    return newDateString;
}

//   

%hook AFConnection
- (void)_doCommand:(id)arg1 reply:(id /* block */)arg2 {
    if ([[arg1 encodedClassName] isEqualToString:@"AddViews"]) {
        for (id view in [arg1 views]) {

            if ([[view encodedClassName] isEqualToString:@"AssistantUtteranceView"]) {
                PO2Log([NSString stringWithFormat:@"[%@] Siri: %@",getCurrecnTime() , [view text]], 1);
            }
            else {
                PO2Log([NSString stringWithFormat:@"[%@] Siri: [複雜回覆內容，無法轉換為文字]",getCurrecnTime()], 1);
                SBScreenshotManager *manager = UIApplication.sharedApplication.screenshotManager;


                double delayInSeconds = 0.7;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [manager saveScreenshotsWithCompletion:nil];
                    // saveViewAsImage(view);
                    // PO2Log([NSString stringWithFormat:@"[GGGGG] %@",view], 1);
                });
            }
        }
    }
    %orig;
}

%end


%hook AFUISiriSession

-(void)assistantConnection:(AFConnection *)connection speechRecognized:(id)recognized {
    PO2Log([NSString stringWithFormat:@"[%@] User: %@",getCurrecnTime() , [recognized af_bestTextInterpretation]], 1);
	%orig();
}
%end


%ctor {
    dlopen("/System/Library/PrivateFrameworks/AssistantUI.framework/AssistantUI", RTLD_LAZY);
    // dlopen("/System/Library/PrivateFrameworks/SAObjects.framework/SAObjects", RTLD_LAZY);
}
