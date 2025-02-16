//
//  NoteManager.h
//  NotesStarface
//
//  Created by Johanna Reiting on 15.02.25.
//

#import <Foundation/Foundation.h>
#import "NoteEntity+CoreDataClass.h"

@protocol NoteManager <NSObject>

@property(nonatomic, readonly, strong) NSManagedObjectContext *context;

- (NSArray<NoteEntity *> *)fetchAllNotes;
- (void)createNoteWithTitle:(NSString *)title content:(NSString *)content;
- (void)deleteNote:(NoteEntity *)note;
- (void)editNote:(NoteEntity *)note withTitle:(NSString *)title andContent:(NSString *)content;

@end
