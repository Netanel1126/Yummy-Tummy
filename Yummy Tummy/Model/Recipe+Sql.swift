import Foundation

extension Recipe{
    
    static let RES_TABLE = "Recipes"
    static let RES_ID = "RES_ID"
    static let RES_TEXT = "Text"
    static let RES_TITLE = "Title"
    static let RES_AUTOR = "Autor"
    static let RES_IMAGE_URL = "IMAGE_URL"
    //static let RES_LAST_UPDATE = "RES_LAST_UPDATE"
    
    static func createTable(database:OpaquePointer?)->Bool{
        var error: UnsafeMutablePointer<Int8>? = nil
        
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS " + RES_TABLE + " ( " + RES_ID + " TEXT PRIMARY KEY, "
            + RES_TEXT + " TEXT, "
            + RES_TITLE + " TEXT, "
            + RES_AUTOR + "TEXT, "
            + RES_IMAGE_URL + " TEXT) , UNIQUE(" + RES_ID + ")", nil, nil, &error);
        if(res != 0){
            print("error creating table: ", error);
            return false
        }
        
        return true
    }
    
}
