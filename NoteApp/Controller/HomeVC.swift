//
//  HomeVC.swift
//  NoteApp
//
//  Created by Ahmed Nasr on 10/7/20.
//  Copyright © 2020 Ahmed Nasr. All rights reserved.
//
import UIKit
import Firebase
import Toast_Swift
class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messegelable: UILabel!
    
    var noteArray = [NoteDetails]()
    var noteId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        observeData()
    }
    @IBAction func AddOnClick(_ sender: Any) {
        let toAddPage = storyboard?.instantiateViewController(identifier: "addNotePage") as! AddNoteVC
        toAddPage.title = "New Note"
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(toAddPage, animated: true)
    }
}
extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let index = noteArray[indexPath.row]
        cell.textLabel?.text = index.titleNote
        cell.detailTextLabel?.text = index.noteBody
        return cell
    }
}
extension HomeVC: UITableViewDelegate{

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = noteArray[indexPath.row]
            index.ref?.removeValue()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        noteId = noteArray[indexPath.row].key
        let toEditPage = storyboard?.instantiateViewController(identifier: "editPage") as! EditVC
        toEditPage.noteID = noteId
        toEditPage.title = "Note"
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(toEditPage, animated: true)
    }
}
extension HomeVC{
    func observeData(){
        let ref = Database.database().reference()
        ref.child("Note").observe(.value) { (snapshot) in
            var subArray = [NoteDetails]()
            for data in snapshot.children {
                if let snap = data as? DataSnapshot {
                    if let note = NoteDetails.init(snapshotNames: snap){
                        subArray.append(note)
                    }
                    self.noteArray = subArray
                    self.messegelable.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
            }
        }
    }
}
