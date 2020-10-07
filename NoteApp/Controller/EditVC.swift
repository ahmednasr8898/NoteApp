//
//  EditVC.swift
//  NoteApp
//
//  Created by Ahmed Nasr on 10/7/20.
//  Copyright © 2020 Ahmed Nasr. All rights reserved.
//

import UIKit
import Firebase

class EditVC: UIViewController {

    @IBOutlet weak var titleNote: UILabel!
    @IBOutlet weak var body: UITextView!
    
    
    var noteID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observsingleData()
        
    }
}


extension EditVC{
    
    func observsingleData(){
        
        let ref = Database.database().reference()
        
        guard let noteid = noteID else { return }
        
        ref.child("Note").child(noteid).observeSingleEvent(of: .value) { (snapshot) in
            
            if let value = snapshot.value as? [String: Any] {
            
            let titleNote = value["titleNote"] as? String
            let noteBody = value["noteBody"] as? String
            
                self.titleNote.text = titleNote
                self.body.text = noteBody
            }
        }
    }
}
