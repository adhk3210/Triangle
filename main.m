#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDate *startProgram = [NSDate date];
        NSError *error;
        NSString *fileContents = [NSString stringWithContentsOfFile:@"/Users/AlbertKim/Desktop/triangle.txt"  encoding:NSUTF8StringEncoding error:&error];
        NSArray *listArray = [fileContents componentsSeparatedByString:@" \r\n"];
        NSMutableArray *triangle = [listArray mutableCopy];
        if (error)
            NSLog(@"Error reading file: %@", error.localizedDescription);
        else {
            for (int i = 0; i < [triangle count]; i++) {
                NSMutableArray *numArray = [[NSMutableArray alloc]initWithArray:[triangle[i] componentsSeparatedByString:@" "]];
                for(int i=0;i<numArray.count;i++){
                    NSString *data = numArray[i];
                    NSValue *iVal = [NSNumber numberWithInteger: [data integerValue]];
                    numArray[i] = iVal;
                }
                triangle[i] = numArray;
            }
        }
        
        for (int i = (int)[triangle count] - 1; i > 0; i--) {
            for (int j = 0; j < i; j++) {
                if (j + 1 <= i && i - 1 >= 0) {
                    int triI1J1 = [triangle[i][j] intValue];
                    int triI1J2 = [triangle[i][j+1] intValue];
                    int triI0J1 = [triangle[i-1][j] intValue];
                    if (triI1J1 > triI1J2)
                        triI0J1 += triI1J1;
                    else
                        triI0J1 += triI1J2;
                    triangle[i-1][j] = [NSNumber numberWithInteger:triI0J1];
                    
                }
            }
        }
        NSLog(@"Maximal sum for the triangle is: %@", triangle[0][0]);
        NSDate *finishProgram = [NSDate date];
        NSTimeInterval totalTime = [finishProgram timeIntervalSinceDate:startProgram];
        NSLog(@"Total Time to run the program is %f minute(s)", totalTime);
    }
    return 0;
}
