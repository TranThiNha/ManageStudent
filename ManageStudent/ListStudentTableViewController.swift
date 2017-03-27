//
//  ListStudentTableViewController.swift
//  ManageStudent
//
//  Created by Nha T.Tran on 3/10/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit
import CoreData

class  Birthday{
    var date: String?
    var month: String?
    var year: String?
}

class ClassOfStudent{
    var name: String?
    var id: Int64?
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
    var studentList2 = [Student_]()

    var selectedStudent: Student?
    var indexOfSelectedStudent: Int?
    var recievedStudent: Student = Student()
    var recievedAddOrEdit: Int? //1: add, 2:edit
    var tblStudentList: UITableView = UITableView()
    static var justLoad:Int = 0;
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        
            if (ListStudentTableViewController.justLoad == 0){
            
            do{
                
                let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Student_")
                let request = NSBatchDeleteRequest(fetchRequest: fetch)
                
                
                studentList2 = try context.fetch(Student_.fetchRequest())
                
              
                
                /*for x in studentList2{
                    context.delete(x)
                }
                
              (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                 studentList2 = try context.fetch(Student_.fetchRequest())*/
                
                var dem: Int = 0

                for element in studentList2{
                
                    var tempStudent: Student = Student()
                    var tempClass : ClassOfStudent = ClassOfStudent()
                    var tempBirthday: Birthday = Birthday()
                    
                    tempStudent.firstName  = element.firstName
                    tempStudent.lastName  = element.lastName
                    tempStudent.gender  = element.gender
                    tempStudent.otherInfor  = element.otherInfor
                    
                    tempClass.name = element.inClass?.name
                    tempClass.id = element.inClass?.id
                    
                    tempStudent.inClass = tempClass
                    
                    tempBirthday.date = element.bithday?.date
                    tempBirthday.month = element.bithday?.month
                    tempBirthday.year = element.bithday?.year
                    
                    tempStudent.birthday = tempBirthday

                    
                    ListStudentTableViewController.studentList.append(tempStudent)
                    dem += 1
                    
                }
                //var tem = ListStudentTableViewController.studentList[2]
                
                tblStudentList.reloadData()
                
            }catch{
                
            }
                ListStudentTableViewController.justLoad = 1
            }
            
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if (recievedAddOrEdit == 1){ //add
            ListStudentTableViewController.studentList.append(recievedStudent)
            do{
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Student_")
            let request = NSBatchDeleteRequest(fetchRequest: fetch)
            
            
            studentList2 = try context.fetch(Student_.fetchRequest())
            
            }catch{
                
            }
            
            let student = Student_(context: context)
            let inClass = ClassOfStudent_(context: context)
            let birthday = Birthday_(context: context)
            
            student.firstName = recievedStudent.firstName
            student.lastName = recievedStudent.lastName
            student.gender = recievedStudent.gender
            student.otherInfor = recievedStudent.otherInfor
            
            inClass.name = recievedStudent.inClass?.name
            inClass.id = (recievedStudent.inClass?.id)!
            
            birthday.date = recievedStudent.birthday?.date
            birthday.month = recievedStudent.birthday?.month
            birthday.year = recievedStudent.birthday?.year

            student.inClass = inClass
            student.bithday = birthday
        
            
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            
            

            //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

            
        }
        
        if (recievedAddOrEdit == 2) //edit
        {
            ListStudentTableViewController.studentList[indexOfSelectedStudent!] = recievedStudent
            
            do{
                let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Student_")
                let request = NSBatchDeleteRequest(fetchRequest: fetch)
                
                
                studentList2 = try context.fetch(Student_.fetchRequest())
                var count: Int = 0
                
                for element in studentList2{
                    if (count == indexOfSelectedStudent)
                    {
                        let inClass = ClassOfStudent_(context: context)
                        let birthday = Birthday_(context: context)
                        
                        
                        element.firstName = recievedStudent.firstName
                        element.lastName = recievedStudent.lastName
                        element.gender = recievedStudent.gender
                        element.otherInfor = recievedStudent.otherInfor
                        
                        inClass.name = recievedStudent.inClass?.name
                        inClass.id = (recievedStudent.inClass?.id)!
                        
                        birthday.date = recievedStudent.birthday?.date
                        birthday.month = recievedStudent.birthday?.month
                        birthday.year = recievedStudent.birthday?.year
                        
                        element.inClass = inClass
                        element.bithday = birthday
                        

                    }
                    count += 1
                }
                var dem  = studentList2.count
                
            }catch{
                
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()

            
        }
        
        var dem  = studentList2.count
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedStudent = ListStudentTableViewController.studentList[indexPath.row]
        indexOfSelectedStudent = indexPath.row
        
        
        var message: String = ""
        message += "Name: "
        message += (selectedStudent?.firstName!)!+" "
        message += (selectedStudent?.lastName)!+"\nBirthday: "
        message += (selectedStudent?.birthday?.date)! + "/"
        message += (selectedStudent?.birthday?.month)! + "/"
        message += (selectedStudent?.birthday?.year)! + "\nClass: "
        message += (selectedStudent?.inClass?.name)! + "\nOther Infor:"
        message += (selectedStudent?.otherInfor)!
        
        
        
        let alertView = UIAlertController(title:"Detail Information",message:message ,preferredStyle: .alert)
        let alertAction = UIAlertAction(title:  "OK", style: .destructive){
        (action) in print("ok")
        }
        alertView.addAction(alertAction)
        present(alertView, animated: true, completion: nil)
    
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
        let color = UIColor(red:210, green:180, blue:222, alpha: 1.0)
            cell.layer.borderWidth = 0.5
        cell.layer.shadowOffset = CGSize(width: 2, height:2)
        cell.layer.shadowColor = color.cgColor
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
        studentName = UILabel(frame:CGRect(x:68,y:4,width:300, height:30))
        studentName.text = ListStudentTableViewController.studentList[indexPath.row].firstName! + temp+ListStudentTableViewController.studentList[indexPath.row].lastName!
        cell.addSubview(studentName)
        
        var temp2:String = "Birthday: "
        var temp3:String = "/"
        var studentbirthday: UILabel
        studentbirthday = UILabel(frame:CGRect(x:68,y:25,width:300, height:30))
        
        temp2 += (ListStudentTableViewController.studentList[indexPath.row].birthday?.date)!
        temp2 += temp3 + (ListStudentTableViewController.studentList[indexPath.row].birthday?.month)!
        temp2 += temp3 +  (ListStudentTableViewController.studentList[indexPath.row].birthday?.year)!
        
        studentbirthday.text = temp2
        cell.addSubview(studentbirthday)
        
        
        var className: UILabel
        className = UILabel(frame:CGRect(x:68,y:45,width:300, height:30))
        className.text = ListStudentTableViewController.studentList[indexPath.row].inClass?.name
        cell.addSubview(className)
        
        /*cell.contentView.backgroundColor = UIColor.clear
        let whiteRoundedView: UIView = UIView(frame:CGRect(x:10, y:8, width: 600, height:72))
        
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)*/
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
        
     }
    
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
        ListStudentTableViewController.studentList.remove(at: indexPath.row)
        do{
        studentList2 = try context.fetch(Student_.fetchRequest())
            var count: Int = 0
            for element in studentList2{
                if count == indexPath.row{
                    context.delete(element)
                }
                
                count += 1

            }
        }
        catch{
            
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
     tableView.deleteRows(at: [indexPath], with: .fade)

     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
    
    
    
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let student = ListStudentTableViewController.studentList[fromIndexPath.row]
        ListStudentTableViewController.studentList.remove(at: fromIndexPath.row)
        ListStudentTableViewController.studentList.insert(student, at: to.row)
        
        
        do{
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Student_")
            let result = try? context.fetch(fetch)
            
            let resulData = result as! [Student_]
            
            var count: Int = 0
            
            for element in resulData{
                let inClass = ClassOfStudent_(context: context)
                let birthday = Birthday_(context: context)
                
                
                element.firstName = ListStudentTableViewController.studentList[count].firstName
                element.lastName = ListStudentTableViewController.studentList[count].lastName
                element.gender = ListStudentTableViewController.studentList[count].gender
                element.otherInfor = ListStudentTableViewController.studentList[count].otherInfor
                
                inClass.name = ListStudentTableViewController.studentList[count].inClass?.name
                inClass.id = (ListStudentTableViewController.studentList[count].inClass?.id)!
                
                birthday.date = ListStudentTableViewController.studentList[count].birthday?.date
                birthday.month = ListStudentTableViewController.studentList[count].birthday?.month
                birthday.year = ListStudentTableViewController.studentList[count].birthday?.year
                
                element.inClass = inClass
                element.bithday = birthday
                
                count += 1
            }
          
            
            
            
        }catch{
            
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
     }



    // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
