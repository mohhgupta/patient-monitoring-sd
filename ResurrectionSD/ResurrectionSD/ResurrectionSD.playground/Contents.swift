import UIKit

var str = "Hello, playground"
var array = [String(1), "2.0", "true"]
var stringarray = array.joined(separator:"-")

let decoded = stringarray.components(separatedBy: "-")

let timeInterval = NSDate().timeIntervalSince1970

Bool(decoded[2])

var arr = [[String]]()
arr.append(["4","3","2"])
arr.append(["6","7","8"])
arr[0]
arr[1][1]
