//
//  NoteManagerImpl.h
//  NotesStarface
//
//  Created by Johanna Reiting on 14.02.25.
//

#import <Foundation/Foundation.h>
#import "NoteManager.h"

@class NoteEntity;
@class NSManagedObjectContext;

// Handles all interactions with Core Data
@interface NoteManagerImpl : NSObject <NoteManager>

@property(nonatomic, readonly, strong) NSManagedObjectContext *context;

- (instancetype)initWithContext:(NSManagedObjectContext *)context;

- (NSArray<NoteEntity *> *)fetchAllNotes;
- (void)createNoteWithTitle:(NSString *)title content:(NSString *)content;
- (void)deleteNote:(NoteEntity *)note;

@end
