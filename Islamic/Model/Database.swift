import Foundation
import SQLite3


final class Database {
    func fetch(name : String, n : Int) -> [String] {
        let db = openDatabase()
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, "select * from \(name)", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        
        var names : [String] = []
        
        while sqlite3_step(statement) == SQLITE_ROW {
            if let cString = sqlite3_column_text(statement, Int32(n)) {
                let name = String(cString: cString)
                names.append(name)
            }
        }
        
        statement = nil
        
        return names
    }

    private func openDatabase() -> OpaquePointer? {
        let base = Bundle.main.path(forResource: "Muslim", ofType: "db")
        var db: OpaquePointer? = nil
        if sqlite3_open(base, &db) == SQLITE_OK {
            return db
        } else {
            return nil
        }
    }
}
