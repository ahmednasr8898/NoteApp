
import Foundation
import Firebase

struct NoteDetails {
  
  let ref: DatabaseReference?
  let key: String
  let titleNote: String
  let noteBody: String
 
  init(titleNote: String, noteBody: String, key: String = "") {
    self.ref = nil
    self.key = key
    self.titleNote = titleNote
    self.noteBody = noteBody
    
  }
  
  init?(snapshotNames: DataSnapshot) {
    guard
      let value = snapshotNames.value as? [String: AnyObject],
      let titleNote = value["titleNote"] as? String,
      let noteBody = value["noteBody"] as? String else {
      return nil
    }
    
    self.ref = snapshotNames.ref
    self.key = snapshotNames.key
    self.titleNote = titleNote
    self.noteBody = noteBody
  }
  
  func toAnyObject() -> Any {
    return [
      "titleNote": titleNote,
      "noteBody": noteBody
    ]
  }
}
