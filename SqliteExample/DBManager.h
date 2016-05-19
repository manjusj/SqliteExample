//
//  DBManager.h
//  SqliteExample
//
//  Created by Manju Sj on 5/19/16.
//  Copyright (c) 2016 Manju Sj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DBManager : NSObject
{

    NSString *databasePath;
    

}
+(DBManager *)getSharedInstance;
-(BOOL)createDb;
-(BOOL)saveData:(NSString*)registerNumber name:(NSString *)name
      department:(NSString*)department year:(NSString *)year;
-(NSArray *)findRegisterNumber:(NSString *)registerNumber;

@end
