import PlaygroundSupport
import UIKit

public class Controller: NSObject, CalculatorViewDelegate, CalculatorViewDataSource {
    var displayText = "0"
    var r_value_str : String = ""
    var symbol : String = ""
    var operator_given = false
    var equalCalled = false
    var l_val : Double = 0
    var r_val : Double = 0
    
    
    public func calculatorView(_ calculatorView: CalculatorView, didPress key: CalculatorKey) {
        switch key {
        case .clear:
            displayText = "0"
            symbol = ""
            //l_value_str = ""
            r_value_str = ""
            operator_given = false
            equalCalled = false
        case .add, .subtract, .divide, .multiply :
            equalCalled = false
            r_value_str = ""
            if(symbol == ""){
                l_val = Double(displayText)!
            }
            if operator_given == false {
                symbol = key.rawValue
            }
            else{
                r_value_str = displayText
                r_val = Double(displayText)!
                calculate()
                operator_given = false
                r_value_str = ""
                symbol = key.rawValue
            }
        case .percent :
            equalCalled = false
            if displayText != "0" {
                var value = Double(displayText)!
                value /= 100
                displayText = String(value)
                correct_displayText()
            }
            
        case .toggleSign :
            equalCalled = false
            if displayText != "0" {
                if displayText.first == "-"{
                    displayText.removeFirst()
                } else {
                    displayText = "-" + displayText
                }
                
            }
            
        case .equal :
            
            if operator_given == true{
                r_value_str = displayText
                r_val = Double(displayText)!
                calculate()
                operator_given = false
                equalCalled = true
            }
            else if equalCalled{
                calculate()
            }
            
            
        default:
            equalCalled = false
            if symbol != "" && operator_given == false{
                operator_given = true
                displayText = "0"
            }
            if displayText == "0" && key.rawValue != "."{
                //operator_given = false
                displayText = key.rawValue
            } else if Double(displayText + key.rawValue) != nil{
                displayText += key.rawValue
            }
        }
    }
    
    public func displayText(_ calculatorView: CalculatorView) -> String {
        
        return displayText
    }
    
    public func correct_displayText() {
        let index = displayText.index(before: displayText.endIndex)
        let beforeindex = displayText.index(before: index)
        
        if(displayText[index] == "0" && displayText[beforeindex] == "."){
            displayText.removeLast()
            displayText.removeLast()
        }
    }
    
    public func calculate(){
        switch symbol {
        case "+":
            l_val += r_val
        case "-":
            l_val -= r_val
        case "×":
            l_val *= r_val
        case "÷":
            l_val /= r_val
        default:
            break
        }
        displayText = String(l_val)
        correct_displayText()
        
    }
}

// Internal Setup
let controller = Controller(), page = PlaygroundPage.current
setupCalculatorView(for: page, with: controller)

// To see the calculator view:
// 1. Run the Playground (⌘Cmd + ⇧Shift + ↩Return)
// 2. View Assistant Editors (⌘Cmd + ⌥Opt + ↩Return)
// 3. Select Live View in the Assistant Editor tabs
