//
//  DBManager.m
//  SqliteExample
//
//  Created by Manju Sj on 5/19/16.
//  Copyright (c) 2016 Manju Sj. All rights reserved.
//

#import "DBManager.h"

static DBManager *sharedInstance=nil;
static sqlite3 *database=nil;
static sqlite3_stmt *statement=nil;
@implementation DBManager

+(DBManager *)getSharedInstance
{
    if (!sharedInstance) {
        sharedInstance =[[super allocWithZone:NULL]init];
        [sharedInstance createDb];
    }

    return sharedInstance;
}
-(BOOL)createDb{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    databasePath=[[NSString alloc ]initWithString:[[dirPaths objectAtIndex:0]stringByAppendingPathComponent:@"mydatabase.sqlite"]];
    BOOL isSuccess=YES;
    NSFileManager *fileMgr=[NSFileManager defaultManager];
    
    if ([fileMgr fileExistsAtPath:docsDir]==NO) {
        
        const char *dbPath=[databasePath UTF8String];
        
        if (sqlite3_open(dbPath, &database)==SQLITE_OK) {
            
            char *errMsg;
            const char *sql_stmt="create table if not exists studentDetail (regno integer primary key,name text,department text,year text)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL,&errMsg)!=SQLITE_OK) {
                
                isSuccess=NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            return isSuccess;
            
            
        }else{
            isSuccess=NO;
            NSLog(@"Failed to open/close database");
        }
        
        
    }
    return isSuccess;


}

- (BOOL) saveData:(NSString*)registerNumber name:(NSString*)name
       department:(NSString*)department year:(NSString*)year;
{
     BOOL isSuccess=NO;
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into studentsDetail (regno,name, department, year) values (\"%ld\",\"%@\", \"%@\", \"%@\")",[registerNumber integerValue],name, department, year];
        const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
                                if (sqlite3_step(statement) == SQLITE_DONE)
                                {
                                    isSuccess=YES;
                                }
                                else {
                                    isSuccess=NO;
                                }
                                sqlite3_reset(statement);
                                }
    
   return  isSuccess;
}
                                
- (NSArray*) findByRegisterNumber:(NSString*)registerNumber
        {
            const char *dbpath = [databasePath UTF8String];
            if (sqlite3_open(dbpath, &database) == SQLITE_OK)
            {
    NSString *querySQL = [NSString stringWithFormat:@"select name, department, year from studentsDetail where regno=\"%@\"",registerNumber];
                const char *query_stmt = [querySQL UTF8String];
                NSMutableArray *resultArray = [[NSMutableArray alloc]init];
                if (sqlite3_prepare_v2(database,
                                       query_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    if (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        NSString *name = [[NSString alloc] initWithUTF8String:
                                          (const char *) sqlite3_column_text(statement, 0)];
                        [resultArray addObject:name];
                        NSString *department = [[NSString alloc] initWithUTF8String:
                                                (const char *) sqlite3_column_text(statement, 1)];
                        [resultArray addObject:department];
                        NSString *year = [[NSString alloc]initWithUTF8String:
                                          (const char *) sqlite3_column_text(statement, 2)];
                        [resultArray addObject:year];
                        return resultArray;
                    }
                    else{
                        NSLog(@"Not found");
                        return nil;
                    }
                    sqlite3_reset(statement);
                }
            }
            return nil;
        }
@end
