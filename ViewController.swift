//
//  ViewController.swift
//  Swift Speed Test
//
//  Created by Gene Leybzon on 6/16/14.
//  Copyright (c) 2014 Stream11. All rights reserved.
//

import UIKit

let MAX_COUNT = 10000

let NUM_TRIALS = 10

typealias SortFunctionClosure = (arr: Int[]) -> ()

enum SortFunctionName : String {
    case Swift = "Swift"
    case Quick = "Quick"
    case Heap = "Heap"
    case Insertion = "Insertion"
    case Selection = "Selection"
}


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func OnStartClick(sender : UIButton) {
        println("tapped button ß")
        
        let now = NSDate()
        let formatter = NSDateFormatter()
        formatter.timeStyle = .LongStyle
        logView.text = "Test started at " + formatter.stringFromDate(now)
        
        //sortObjC();
        sortSwift();
        
        
    }
    
    func sortObjC() {
        var sortInObjC: SortObjC = SortObjC()
        var msg = sortInObjC.sortAll()
        
        logView.text = logView.text + msg + "\n"
        println("::: REPORT :::" + msg + ":::")
        
    }
    
/*
    class BackgroundSwiftSort: NSOperation {
        override func main() ->() {
            var sortInObjC: SortObjC = SortObjC()
            var msg = sortInObjC.sortAll()
            
            logView.text = logView.text + msg + "\n"
        }
    }
  */

let sortAlgorithms : Dictionary<SortAlgorithmName, SortAlgorithmClosure> = [SortAlgorithmName.Swift : swiftSort,
                                                                            SortAlgorithmName.Quick : quickSort,
                                                                            SortAlgorithmName.Heap : heapSort,
                                                                            SortAlgorithmName.Insertion : insertionSort,
                                                                            SortAlgorithmName.Selection : selectionSort]

    let sortFunctions : Dictionary<SortFunctionName, SortFunctionClosure> = [SortFunctionName.Swift : swiftSort,
        SortFunctionName.Quick : quickSort,
        SortFunctionName.Heap : heapSort,
        SortFunctionName.Insertion : insertionSort,
        SortFunctionName.Selection : selectionSort]
    
    @IBOutlet var logView : UITextView
    
    func sortSwift() {
        
        var averageSortTimes : Dictionary<SortAlgorithmName, Double> = [SortAlgorithmName.Swift : 0.0,
            SortAlgorithmName.Quick : 0.0,
            SortAlgorithmName.Heap : 0.0,
            SortAlgorithmName.Insertion : 0.0,
            SortAlgorithmName.Selection : 0.0]
        
for t in 1...NUM_TRIALS {
    println("::: TRIAL \(t) :::")
    var unsortedArray : Int[] = randomIntegerArray(MAX_COUNT)
    
    for (name, closure) in sortAlgorithms {
        let totalTime = averageSortTimes[name]!
        
        var sortTime = sortArray(anArray: unsortedArray,
                                 sortName: name,
                                 sortClosure: closure)
        
        averageSortTimes[name] = totalTime + sortTime
    }
}
        
        println("\nFinal Swift Results:\n--------------")
        
        logView.text = logView.text + "Swift results:\n";
        
        for (name, time) in averageSortTimes {
            var msg = "\(name.toRaw()) sort average time = \(time / Double(NUM_TRIALS)) sec";
            
            println(msg);
            logView.text = logView.text + msg + "\n";
        }
        
        println()
        
    }

}



