//
//  ListStudentTableViewController.swift
//  ManageStudent
//
//  Created by Nha T.Tran on 3/10/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit

class  Birthday{
    var date: String?
    var month: String?
    var year: String?
}

class ClassOfStudent{
    var name: String?
    var id: Int?
}

class Student{
    var firstName: String?
    var lastName: String?
    var gender: String?
    var birthday: Birthday?
    var inClass: ClassOfStudent?
    var otherInfor: String?
}


class ListStudentTableViewController: UITableViewController {
    
    var mang: [String]!
    static var studentList = [Student]()
    var selectedStudent: Student?
    var indexOfSelectedStudent: Int?
    var recievedStudent: Student = Student()
    var recievedAddOrEdit: Int? //1: add, 2:edit
    var tblStudentList: UITableView = UITableView()
    
    
    @IBAction func btnDelete(_ sender: Any) {
        if (indexOfSelectedStudent != nil){
            ListStudentTableViewController.studentList.remove(at: indexOfSelectedStudent!)
            self.tblStudentList.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (recievedAddOrEdit == 1){ //add
                       ListStudentTableViewController.studentList.append(recievedStudent)
        }
        if (recievedAddOrEdit == 2) //edit
        {
            ListStudentTableViewController.studentList[indexOfSelectedStudent!] = recievedStudent
        }
        
        sortFollowName()
        tblStudentList.reloadData()
    }
    
    
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    func sortFollowName(){
        if (ListStudentTableViewController.studentList.count > 0){
            var i:Int = 0
            
            while (i < ListStudentTableViewController.studentList.count - 1){
                var j:Int = i + 1
                while (j < ListStudentTableViewController.studentList.count){
                    if (ListStudentTableViewController.studentList[i].firstName! > ListStudentTableViewController.studentList[j].firstName!){
                        var temp:Student = ListStudentTableViewController.studentList[i]
                        ListStudentTableViewController.studentList[i] = ListStudentTableViewController.studentList[j]
                        ListStudentTableViewController.studentList[j] = temp
                    }
                    j += 1
                }
                i += 1
            }
        }
     
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedStudent = ListStudentTableViewController.studentList[indexPath.row]
        indexOfSelectedStudent = indexPath.row
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editSegue" && selectedStudent?.firstName != nil){
            let editController = segue.destination as! AddStudentViewController
            editController.selectedStudent = selectedStudent
            editController.addOrEdit = 2 //edit
            editController.indexOfSelectedStudent = indexOfSelectedStudent
        }
        else if (segue.identifier == "addStudentSegue"){
            let addController = segue.destination as! AddStudentViewController
            addController.addOrEdit = 1 //save
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        tblStudentList = tableView
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ListStudentTableViewController.studentList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
            cell.layer.borderWidth = 1.0
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.shadowOpacity = 2.0
        
        if (ListStudentTableViewController.studentList[indexPath.row].gender == "male")
        {
            var imageview:UIImageView!
            imageview = UIImageView(frame:CGRect(x:4,y:8,width:56,height:56))
            imageview.image = UIImage(named:"male.png")
            cell.addSubview(imageview)
        }
        
        if (ListStudentTableViewController.studentList[indexPath.row].gender == "female")
        {
            var imageview:UIImageView!
            imageview = UIImageView(frame:CGRect(x:4,y:8,width:56,height:56))
            imageview.image = UIImage(named:"female.png")
            cell.addSubview(imageview)
        }
        
        var temp:String = " "
        var studentName: UILabel
        studentName = UILabel(frame:CGRect(x:68,y:4,width:200, height:30))
        studentName.text = ListStudentTableViewController.studentList[indexPath.row].firstName! + temp+ListStudentTableViewController.studentList[indexPath.row].lastName!
        cell.addSubview(studentName)
        
        var temp2:String = "Birthday: "
        var temp3:String = "/"
        var studentbirthday: UILabel
        studentbirthday = UILabel(frame:CGRect(x:68,y:25,width:500, height:30))
        
        temp2 += (ListStudentTableViewController.studentList[indexPath.row].birthday?.date)!
        temp2 += temp3 + (ListStudentTableViewController.studentList[indexPath.row].birthday?.month)!
        temp2 += temp3 +  (ListStudentTableViewController.studentList[indexPath.row].birthday?.year)!
        
        studentbirthday.text = temp2
        cell.addSubview(studentbirthday)
        
        
        var className: UILabel
        className = UILabel(frame:CGRect(x:68,y:45,width:200, height:30))
        className.text = ListStudentTableViewController.studentList[indexPath.row].inClass?.name
        cell.addSubview(className)
        
        cell.contentView.backgroundColor = UIColor.clear
        let whiteRoundedView: UIView = UIView(frame:CGRect(x:10, y:8, width: 600, height:72))
        
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
       /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {p
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
