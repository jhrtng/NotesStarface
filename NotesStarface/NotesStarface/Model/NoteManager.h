//
//  NoteManager.h
//  NotesStarface
//
//  Created by Johanna Reiting on 14.02.25.
//

#import <Foundation/Foundation.h>

// Handles all interactions with Core Data
@interface NoteManager : NSObject

+ (void)createNoteWithTitle:(NSString *)title content:(NSString *)content;

@end
