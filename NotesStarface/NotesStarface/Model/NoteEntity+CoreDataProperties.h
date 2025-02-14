//
//  NoteEntity+CoreDataProperties.h
//  NotesStarface
//
//  Created by Johanna Reiting on 14.02.25.
//
//

#import "NoteEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NoteEntity (CoreDataProperties)

+ (NSFetchRequest<NoteEntity *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSUUID *noteID;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSDate *timestamp;

@end

NS_ASSUME_NONNULL_END
