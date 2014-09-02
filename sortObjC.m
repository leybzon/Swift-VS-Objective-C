//
//  sortObjC.m
//  Swift Speed Test
//
//  Created by Gene Leybzon on 6/25/14.
//  Copyright (c) 2014 Stream11. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "sortObjC.h"

@implementation SortObjC


- (NSString *) sortAll {
    NSLog(@"Sort Obj-C Called");
    __block NSString * report = @"*****";
    
    @autoreleasepool {
        
        const NSUInteger MAX_COUNT = 10000;
        
        const NSUInteger NUM_TRIALS = 10;
        
        
        
        NSArray *sortAlgorithms = [NSArray arrayWithObjects:@(SortAlgorithmTypeObjC),
                                   @(SortAlgorithmTypeQuick),
                                   @(SortAlgorithmTypeHeap),
                                   @(SortAlgorithmTypeInsertion),
                                   @(SortAlgorithmTypeSelection),
                                   @(SortAlgorithmTypeMerge),
                                   @(SortAlgorithmTypeBubble),
                                   nil];
        
        NSMutableDictionary *averageSortTimes = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@(0.0), @(0.0), @(0.0), @(0.0), @(0.0), @(0.0), @(0.0), nil]
                                                                                   forKeys:sortAlgorithms];
        
        for (NSUInteger t = 1; t <= NUM_TRIALS; t++) {
            NSLog(@"\n\n::: TRIAL %ld :::", t);
            
            NSMutableArray *unsortedArray = randomIntegerArray(MAX_COUNT);
            
            for (NSNumber *sort in sortAlgorithms) {
                NSUInteger sortType = sort.integerValue;
                
                NSTimeInterval sortTime = 0.0;
                
                switch (sortType) {
                    case SortAlgorithmTypeObjC:
                    sortTime = sortArrayWithNameUsingBlock(unsortedArray, sortType, ^(NSMutableArray *arr) {
                        objcSort(arr);
                    });
                    break;
                    
                    case SortAlgorithmTypeQuick:
                    sortTime = sortArrayWithNameUsingBlock(unsortedArray, sortType, ^(NSMutableArray *arr) {
                        quickSort(arr);
                    });
                    break;
                    
                    case SortAlgorithmTypeHeap:
                    sortTime = sortArrayWithNameUsingBlock(unsortedArray, sortType, ^(NSMutableArray *arr) {
                        heapSort(arr);
                    });
                    break;
                    
                    case SortAlgorithmTypeInsertion:
                    sortTime = sortArrayWithNameUsingBlock(unsortedArray, sortType, ^(NSMutableArray *arr) {
                        insertionSort(arr);
                    });
                    break;
                    
                    case SortAlgorithmTypeSelection:
                    sortTime = sortArrayWithNameUsingBlock(unsortedArray, sortType, ^(NSMutableArray *arr) {
                        selectionSort(arr);
                    });
                    break;
                    
                    case SortAlgorithmTypeMerge:
                    sortTime = sortArrayWithNameUsingBlock(unsortedArray, sortType, ^(NSMutableArray *arr) {
                        mergeSort(arr);
                    });
                    break;
                    
                    case SortAlgorithmTypeBubble:
                    sortTime = sortArrayWithNameUsingBlock(unsortedArray, sortType, ^(NSMutableArray *arr) {
                        bubbleSort(arr);
                    });
                    break;
                }
                
                NSTimeInterval totalTime = [[averageSortTimes objectForKey:sort] doubleValue];
                [averageSortTimes setObject:@(totalTime + sortTime) forKey:sort];
            }
        }
        
    
        [averageSortTimes enumerateKeysAndObjectsUsingBlock:^(NSNumber *sortType, NSNumber *time, BOOL *stop) {
            
            //NSLog(@"%@ sort average time = %lf [sec]", sortAlgorithmNameForType(sortType.integerValue), time.doubleValue / NUM_TRIALS);
            
            report = [report stringByAppendingFormat: @"%@ sort average time = %lf [sec]\n", sortAlgorithmNameForType(sortType.integerValue), time.doubleValue / NUM_TRIALS];
            

        }];
        
        
    }
    
    
    return report;
}

@end


