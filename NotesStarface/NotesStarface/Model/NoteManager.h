//
//  NoteManager.h
//  NotesStarface
//
//  Created by Johanna Reiting on 15.02.25.
//

#import <Foundation/Foundation.h>
#import "NoteEntity+CoreDataClass.h"

@protocol NoteManager <NSObject>

- (NSArray<NoteEntity *> *)fetchAllNotes;
- (void)createNoteWithTitle:(NSString *)title content:(NSString *)content;
- (void)deleteNote:(NoteEntity *)note;
- (void)updateNote:(NoteEntity *)note;

@end
