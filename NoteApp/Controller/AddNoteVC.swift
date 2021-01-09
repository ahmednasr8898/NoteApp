//
//  AddNoteVC.swift
//  NoteApp
//
//  Created by Ahmed Nasr on 10/7/20.
//  Copyright © 2020 Ahmed Nasr. All rights reserved.
//
import UIKit
import Firebase
import Toast_Swift
class AddNoteVC: UIViewController {

    @IBOutlet weak var titleNoteTxt: UITextField!
    @IBOutlet weak var noteTxt: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleNoteTxt.becomeFirstResponder()
    }
    @IBAction func saveNoteOnClick(_ sender: Any) {
        guard let titleNote = titleNoteTxt.text , !titleNote.isEmpty , let noteBody = noteTxt.text , !noteBody.isEmpty else{
            // show Alert
            return
        }
        saveData(titleNote: titleNote, noteBody: noteBody)
    }
}
extension AddNoteVC{
      func saveData(titleNote: String , noteBody: String){
          let ref = Database.database().reference()
          let noteDetails = NoteDetails.init(titleNote: titleNote, noteBody: noteBody)
          let note = ref.child("Note").childByAutoId()
        note.setValue(noteDetails.toAnyObject()) { (error: Error?, ref :DatabaseReference) in
            if error == nil {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
