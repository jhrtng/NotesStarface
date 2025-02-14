//
//  NoteEntity+CoreDataProperties.m
//  NotesStarface
//
//  Created by Johanna Reiting on 14.02.25.
//
//

#import "NoteEntity+CoreDataProperties.h"

@implementation NoteEntity (CoreDataProperties)

+ (NSFetchRequest<NoteEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"NoteEntity"];
}

@dynamic noteID;
@dynamic title;
@dynamic content;
@dynamic timestamp;

@end
