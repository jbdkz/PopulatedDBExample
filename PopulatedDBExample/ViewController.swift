//
//  ViewController.swift
//  PopulatedDBExample
//
//  Created by John Diczhazy on 9/29/17.
//  Copyright © 2017 JohnDiczhazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
  
    //Class Variables
    var macData: [Dictionary<String, AnyObject>] = []
    let cellTableIdentifier = "CellTableIdentifier"

    @IBOutlet var tableView:UITableView!
    
    override func viewDidLoad() {
        
        // Call copyDB() function
        ViewController.copyDB()
        
        // Read all records into macData Array of Dictionaries
        macData = ViewController.readAllRecords() as [Dictionary<String, AnyObject>]
    
        // Setup to use CellDetails Class
        tableView.register(CellDetails.self,
                           forCellReuseIdentifier: cellTableIdentifier)
        
        // Setup to use new Cell
        let xib = UINib(nibName: "CellDetails", bundle: nil)
        tableView.register(xib,
                           forCellReuseIdentifier: cellTableIdentifier)
        tableView.rowHeight = 160
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Return row count method to Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return macData.count
    }
    
    // Called when Table View needs to draw a row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellTableIdentifier, for: indexPath)
            as! CellDetails
        
        // Determine Row Requested
        let rowData = macData[indexPath.row]
        
        // Populate cell with data from chosen row
        cell.row = rowData["Row"]! as! String
        cell.model = rowData["Model"]! as! String
        cell.orderNo = rowData["OrderNo"]! as! String
        cell.proc = rowData["Processor"]! as! String
        cell.memory = rowData["Memory"]! as! String

        return cell
    }
    
    // Read all records from sqlite database, add them to an array of dictionaries
    class func readAllRecords() -> Array<Dictionary<String, AnyObject>> {
        
        var database:OpaquePointer? = nil
        let result = sqlite3_open(dataFilePath(), &database)
        var fieldRow: String = ""
        var fieldModel: String = ""
        var fieldOrderNo: String = ""
        var fieldProc: String = ""
        var fieldMemory: String = ""
        var myArray: [Dictionary<String, AnyObject>] = []
        
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("Failed to open database")
        }
        
        let query = "SELECT * FROM Laptop ORDER BY Row"
        var statement:OpaquePointer? = nil
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            
            while sqlite3_step(statement) == SQLITE_ROW {
                let row = sqlite3_column_text(statement, 0)
                let rowData = sqlite3_column_text(statement, 1)
                let rowData1 = sqlite3_column_text(statement, 2)
                let rowData2 = sqlite3_column_text(statement, 3)
                let rowData3 = sqlite3_column_text(statement, 4)
                
               
                fieldRow = String(cString:(row!))
                fieldModel = String(cString:(rowData!))
                fieldOrderNo = String(cString:(rowData1!))
                fieldProc = String(cString:(rowData2!))
                fieldMemory = String(cString:(rowData3!))
               
                let MacInfo = ["Row": fieldRow, "Model": fieldModel, "OrderNo": fieldOrderNo, "Processor": fieldProc, "Memory": fieldMemory]
                
                myArray.append(MacInfo as [String : AnyObject])
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(database)
        return myArray
    }
    
    
    // Copy DB from Bundle Path to Application Document Directory
    class func copyDB(){
    let bundlePath = Bundle.main.path(forResource: "Mac", ofType: ".sqlite")
    let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let fileManager = FileManager.default
    let fullDestPath = URL(fileURLWithPath: destPath).appendingPathComponent("Mac.sqlite")
    if fileManager.fileExists(atPath: fullDestPath.path){
    print("Database file exists in Application Document Directory!")
    }else{
       do
          {
           try fileManager.copyItem(atPath: bundlePath!, toPath: fullDestPath.path)
           print("Database file does not exist in Application Document Directory, copying now.")
           }catch{
         print("\n",error)
        }
      }
    }
    
    // Function returns sqlite file location
    class func dataFilePath() -> String {
        let urls = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask)
        return urls.first!.appendingPathComponent("Mac.sqlite").path
    }
}
