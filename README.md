# Table Director

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) 

<p align="left">
	<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/Swift_5.1-compatible-4BC51D.svg?style=flat" alt="Swift 5.1 compatible" /></a>
	<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
</p>

Table Direcotr is a lightware generic library allows you manage the `UITableView` and `UICollectionView` in a declare manier.

You don't need implement `UI*DataSource` or `UI*Delegate`, just describe Table Director and free codding.

# How to:

First, define the Table Director:
  
    import UIKit
    import TableDirector
  
    class MyViewController: UIViewController {
        @IBOutlet weak var tableView: UITableView!
      
        var tableDirector: TableViewDirector!
        
        override func viewDidLoad() {
            super.viewDidLoad()

            tableDirector = TableViewDirector(withTableView: tableView)
            tableView.delegate = tableDirector
        }
    }
Second, defina a cell

```
class MytCell: UITableViewCell, ConfigurableCell {
        @IBOutlet weak var someDataLabel: UILabel!

        func configure(data: SomeType) {
            self.someDataLabel.text = data.someData
        }
}
```

Third, let's define a builders here

```
extension MyCell {
  
    typealias Builder = TableRowBuilder<Self, DataType>
    typealias Action = TableRowAction<Self, DataType>
    typealias ActionOptions = TableRowActionOptions<Self, DataType>
}
```

What is it?

***Builder*** is a type to which helps you define the actions for each cell.

***Action*** is a type to define the action for each cell

***ActionOptions*** - this type will provides you for each action

## For example:

```
    let clickAction = [MytCell.Action(.click, handler: didSelectCell)]
    
    let builders = itemsToCell.map { item in 
        MytCell.Builder(item: item, actions: [clickAction])
    }
    
    let sections = TableSection(rows: builders, title: "MyItems section")
    
    tableDirector.replace(sections)
    tableDirector.reload()
 ```

## Callback

```
 func didSelectCell(_ option: MyCell.ActionOptions) {
        router.doAction(with: option.item, moduleOutput: self)
 }
```

**Here is MyCell.ActionOptions contains properties:** 

* item - is a cell data
* cell - is the cell instance
* indexPath - type of Index path for this cell
* userInfo - any user infor provided to this cell

# How to build universal framework
1. Clone the project
2. Build for any simulator
3. Build for jeneric device
4. Archive
5. See to openend Finder windows with framework

Instruction:[Build a Universal Framework in iOS using Swift](https://medium.com/swiftindia/build-a-custom-universal-framework-on-ios-swift-549c084de7c8)
