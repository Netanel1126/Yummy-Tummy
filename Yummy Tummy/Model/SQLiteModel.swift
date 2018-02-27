import Foundation

class SqLiteModel{
    var database:OpaquePointer? = nil
    let dbName = "YT_database.db"
    
    init?() {
        initDb()
        
        if Recipe.createTable(database: database) == false{
            return nil
        }
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
    
    func getAllRecipeFromLocalDB() -> [Recipe]{
        var Recipes = [Recipe]()
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(self.database,"SELECT * from " + Recipe.REC_TABLE + ";" ,-1,&sqlite3_stmt,nil) == SQLITE_OK){
            
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let recId =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,0))
                let recText =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,1))
                let recTitle =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,2))
                let recAutor =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,3))
                var imageUrl =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,4))
                
                print("read from filter st: \(recId!) \(recText) \(recTitle) \(recAutor)")
                if (imageUrl != nil && imageUrl == ""){
                    imageUrl = nil
                }
                
                let rec = Recipe(recpieID: recId!, recipeText: recText!, autor: recAutor!, imageUrl: imageUrl, title: recTitle!)
                
                Recipes.append(rec)
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return Recipes
    }
    
}
