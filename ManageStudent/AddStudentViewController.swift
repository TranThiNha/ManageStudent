//
//  AddStudentViewController.swift
//  ManageStudent
//
//  Created by Nha T.Tran on 3/10/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit

class AddStudentViewController: UIViewController, UIPickerViewDelegate , UIPickerViewDataSource{

    @IBOutlet weak var pickerViewGender: UIPickerView!

    @IBOutlet weak var pickerViewDate: UIPickerView!
    
    @IBOutlet weak var pickerViewMonth: UIPickerView!
    
    @IBOutlet weak var pickerViewYear: UIPickerView!
    
    @IBOutlet weak var pickerViewClass: UIPickerView!
    
    @IBAction func Cancel(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
        
        //self.dismiss(animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName:
        UITextField!
    
    
    @IBOutlet weak var otherInfor: UITextField!
    
    
    @IBAction func Save(_ sender: Any) {
        
        
        if (firstName.text == ""){
            let alertView = UIAlertController(title:"Detail Information",message:"first Name is not empty!" ,preferredStyle: .alert)
            let alertAction = UIAlertAction(title:  "OK", style: .destructive){
                (action) in print("ok")
            }
            alertView.addAction(alertAction)
            present(alertView, animated: true, completion: nil)
        }
        if (lastName.text == ""){
            let alertView = UIAlertController(title:"Detail Information",message:"last Name is not empty!" ,preferredStyle: .alert)
            let alertAction = UIAlertAction(title:  "OK", style: .destructive){
                (action) in print("ok")
            }
            alertView.addAction(alertAction)
            present(alertView, animated: true, completion: nil)
        }
        
        
    }
    
    
    
    var genderList:[String]!
    var classNameList:[String]!
    var dateList:[String]!
    var monthList:[String]!
    var yearList:[String]!
    var selectedGender: String?
    var selectedClass: String?
    var selectedDate: String?
    var selectedMonth: String?
    var selectedYear: String?
    var selectedID:Int64?
    var addOrEdit: Int? //1: add 2:edit
    var indexGender: Int?
    var indexClass: Int?
    var indexDate: Int?
    var indexMonth: Int?
    var indexYear: Int?
    
    //for edit
    var selectedStudent: Student?
    var sendAddOrEdit: Int? //1:add,2:edit
    var indexOfSelectedStudent: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        genderList = ["male","female"]
        classNameList = ["14ctt1","14ctt2","14ctt3","14ctt4","14cntn"]
        dateList = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
        monthList = ["1","2","3","4","5","6","7","8","9","10","11","12"]
        yearList = ["1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005"]
        
        pickerViewClass.delegate = self
        pickerViewClass.dataSource = self
        
        pickerViewGender.delegate = self
        pickerViewGender.dataSource = self
        
        pickerViewDate.delegate = self
        pickerViewDate.dataSource = self
        
        pickerViewMonth.delegate = self
        pickerViewMonth.dataSource = self
        
        pickerViewYear.delegate = self
        pickerViewYear.dataSource = self
        
        selectedGender = genderList[0]
        selectedClass = classNameList[0]
        selectedID = 0
        selectedDate = (dateList[0])
        selectedMonth = (monthList[0])
        selectedYear = (yearList[0])
        
        
        print((monthList[0]))
        
        if (addOrEdit == 2){
            lastName.text = selectedStudent?.lastName
            firstName.text = selectedStudent?.firstName
            otherInfor.text = selectedStudent?.otherInfor
            
            var l0:Int =  genderList.count - 1
            while(l0>=0){
                if (genderList[l0] == selectedStudent?.gender){
                    pickerViewGender.selectRow(l0, inComponent: 0, animated: true)
                    indexGender = l0
                    selectedGender = selectedStudent?.gender
                    break
                }
                l0 -= 1
            }
            
            var l:Int =  classNameList.count - 1
            while(l>=0){
                if (classNameList[l] == selectedStudent?.inClass?.name){
                    pickerViewClass.selectRow(l, inComponent: 0, animated: true)
                    indexClass = l
                    selectedClass = selectedStudent?.inClass?.name
                    selectedID = selectedStudent?.inClass?.id
                
                    break
                }
                l -= 1
            }
            
            var l2: Int = dateList.count - 1
            while (l2 >= 0){
                if (dateList[l2] == selectedStudent?.birthday?.date)
                {
                    pickerViewDate.selectRow(l2, inComponent: 0, animated: true)
                    indexDate = l2
                    selectedDate = selectedStudent?.birthday?.date
                    break
                }
                l2 -= 1
            }
            
            var l3: Int = monthList.count - 1
            while (l3 >= 0){
                if ((dateList[l3]) == selectedStudent?.birthday?.month)
                {
                    pickerViewMonth.selectRow(l3, inComponent: 0, animated: true);
                    indexMonth = l3
                    selectedMonth = selectedStudent?.birthday?.month
                    break
                }
                l3 -= 1
        
            }
            
            var l4: Int = yearList.count - 1
            while (l4 >= 0){
                if ((yearList[l4]) == selectedStudent?.birthday?.year)
                {
                    pickerViewYear.selectRow (l4, inComponent: 0, animated: true)
                    indexYear = l4
                    selectedYear = selectedStudent?.birthday?.year
                    break
                }
                l4 -= 1
            }
            
        }
        
        
               // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "saveSegue" && firstName.text != "" && lastName.text != ""){
            
            
            let saveController = segue.destination as! ListStudentTableViewController
            
            var student: Student = Student()
            
            student.firstName = firstName.text
            student.lastName = lastName.text
            student.otherInfor = otherInfor.text
            student.gender = selectedGender
            var birthday: Birthday = Birthday()
            birthday.date = selectedDate
            birthday.month = selectedMonth
            birthday.year = selectedYear
            student.birthday = birthday
            
            var inClass: ClassOfStudent = ClassOfStudent()
            inClass.name = selectedClass
            inClass.id = selectedID
            
            student.inClass = inClass
            saveController.recievedStudent = student
           
            if (addOrEdit == 1){//add
                saveController.recievedAddOrEdit = 1
                
            }
            else if (addOrEdit == 2){ //edit
                saveController.recievedAddOrEdit = 2
                saveController.indexOfSelectedStudent = indexOfSelectedStudent
            }
            
        }
            
    }
    
    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView.tag==1){
           
            selectedGender = genderList[row]
	
        }
        else if (pickerView.tag==2){
            
            selectedClass = classNameList[row]
            selectedID = Int64(row)
        }
        else if (pickerView.tag == 3){
            selectedDate = (dateList[row])
        }
        else if (pickerView.tag == 4){
            selectedMonth = (monthList[row])
        }
        else if (pickerView.tag == 5){
            selectedYear = (yearList[row])
        }
    }
        
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if (pickerView.tag == 1){
            return genderList.count
        }
        else if (pickerView.tag == 2){
            return classNameList.count
        }
        else if (pickerView.tag == 3){
            return dateList.count
        }
        else if (pickerView.tag == 4){
            return monthList.count
        }
        else if (pickerView.tag == 5){
            return yearList.count
        }
        else{
            return 0
        }
    }
    
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if (pickerView.tag == 1)
            {
               
                return genderList[row]
                
            }
            else if (pickerView.tag == 2)
            {
                return classNameList[row]
            }
            else if (pickerView.tag == 3)
            {
                return String(dateList[row])
            }
            else if (pickerView.tag == 4)
            {
                return String(monthList[row])
            }
                
            else if (pickerView.tag == 5)
            {
                return String(yearList[row])
            }
                
            else
            {
                return ""
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
