import Foundation

extension Recipe{
    
    static let REC_TABLE = "Recipes"
    static let REC_ID = "RES_ID"
    static let REC_TEXT = "Text"
    static let REC_TITLE = "Title"
    static let REC_AUTOR = "Autor"
    static let REC_IMAGE_URL = "IMAGE_URL"
    //static let RES_LAST_UPDATE = "RES_LAST_UPDATE"
    
    static func createTable(database:OpaquePointer?)->Bool{
        var error: UnsafeMutablePointer<Int8>? = nil
        
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS " + REC_TABLE + " ( " + REC_ID + " TEXT PRIMARY KEY, "
            + REC_TEXT + " TEXT, "
            + REC_TITLE + " TEXT, "
            + REC_AUTOR + " TEXT, "
            + REC_IMAGE_URL + " TEXT , UNIQUE(" + REC_ID + "))", nil, nil, &error);
        if(res != 0){
            print("error creating table: ", error);
            return false
        }
        print("SQLite Was Seccesful")
        return true
    }
    
    func addRecipeToLocalDB(database:OpaquePointer?){
        var sqlite3_stmt: OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO " + Recipe.REC_TABLE
            + "(" + Recipe.REC_ID + ","
            + Recipe.REC_TEXT + "," + Recipe.REC_TITLE + "," +
            Recipe.REC_AUTOR + "," + Recipe.REC_IMAGE_URL + /*+ ","
            + Student.ST_LAST_UPDATE +*/ ") VALUES (?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            
            let id = self.recpieID.cString(using: .utf8)
            let text = self.recipeText.cString(using: .utf8)
            let title = self.title.cString(using: .utf8)
            let autor = self.autor.cString(using: .utf8)
            var imageUrl = "".cString(using: .utf8)
            if self.imageUrl != nil {
                imageUrl = self.imageUrl!.cString(using: .utf8)
            }

            sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil)
            sqlite3_bind_text(sqlite3_stmt, 2, text,-1,nil)
            sqlite3_bind_text(sqlite3_stmt, 3, title,-1,nil)
            sqlite3_bind_text(sqlite3_stmt, 4, autor,-1,nil)
            sqlite3_bind_text(sqlite3_stmt, 5, imageUrl,-1,nil)
            
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("A new Recipe row added succefully")
            }
        }
    }
    
    func getRecipeFromLocalDB(byId:String,database:OpaquePointer?) -> Recipe?{
        return nil

    }
}
