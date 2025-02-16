//
//  NoteManagerImpl.m
//  NotesStarface
//
//  Created by Johanna Reiting on 14.02.25.
//

#import "NoteManagerImpl.h"
#import "NoteEntity+CoreDataClass.h"
@import CoreData;

@implementation NoteManagerImpl

@synthesize context = _context;

- (instancetype)initWithContext:(NSManagedObjectContext *)context {
    self = [super init];
    if (self) {
        _context = context;
    }
    
    return self;
}

- (NSArray<NoteEntity *> *)fetchAllNotes {
    NSFetchRequest *fetchRequest = [NoteEntity fetchRequest];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO]];
    
    NSError *error;
    NSArray<NoteEntity *> *notes = [self.context executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        // TODO: error handling. Maybe show an alert?
        return @[];
    }
    
    return notes;
}

- (void)createNoteWithTitle:(NSString *)title content:(NSString *)content {
    NoteEntity *newNote = [[NoteEntity alloc] initWithContext:self.context];
    newNote.noteID = [NSUUID UUID];
    newNote.title = title;
    newNote.content = content;
    newNote.timestamp = [NSDate date];
    
    NSError *error;
    BOOL result = [self.context save:&error];
    if (!result)
    {
        // TODO: error handling. Maybe show an alert?
    }
}

- (void)deleteNote:(NoteEntity *)note {
    [self.context deleteObject:note];
    
    NSError *error;
    BOOL result = [self.context save:&error];
    if (!result)
    {
        // TODO: error handling. Maybe show an alert?
    }
}

- (void)editNote:(NoteEntity *)note withTitle:(NSString *)title andContent:(NSString *)content {
    
    note.title = title;
    note.content = content;
    note.timestamp = [NSDate date];  // Always update the timestamp when saving
    
    NSError *error;
    BOOL result = [self.context save:&error];
    if (!result)
    {
        // TODO: error handling. Maybe show an alert?
    }
}

@end
