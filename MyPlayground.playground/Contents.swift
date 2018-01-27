//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//柯里化
func addTo(_ adder: Int) -> (Int) -> Int{
    return{
        num in
        return num + adder;
    }
}

let addTwo = addTo(2);
let result = addTwo(6);

//print(result);

func greaterThan(_ compare: Int) -> (Int) -> Bool {
    return {
        num in
        return num > compare;
    }
}

let greaterThan10 = greaterThan(10);
greaterThan10(13);

greaterThan10(8);

//闭包

var names = ["Swift","Arial","Soga","Donary"];
//func backwards(firstString: String, secondString: String) -> Bool {
//    return firstString > secondString;
//}
var reversed: Array<Any>?
reversed = names.sorted { (firstString, secondString) -> Bool in
    return firstString > secondString;
}
//reversed = names.sorted{(firstString,secondString) in return firstString > secondString};
//reversed = names.sorted{(firstString,secondString) in firstString > secondString};
//reversed = names.sorted{$0>$1};



//var reversed = names.sorted();

print(reversed ?? ["11"]);

//var arr = [11,22,33,44,55];
//
//
//func hasClosureMatch(arr: [Int],value: Int,cb:(_ num: Int,_ value: Int)->Bool ) ->Bool{
//    for item in arr {
//        if (cb(item, value)) {
//            return true;
//        }
//    }
//    return false;
//}


