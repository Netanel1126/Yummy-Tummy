import Foundation

class SqLiteModel{
    var database:OpaquePointer? = nil
    let dbName = "YT_database.db"
    
    init() {
        initDb()
    }
    
    func initDb(){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let path = dir.appendingPathComponent(dbName)
            if sqlite3_open(path.absoluteString, &database) != SQLITE_OK{
                print("Faild To Open DB File: \(path.absoluteString)")
                return
            }
        }
    }
}
