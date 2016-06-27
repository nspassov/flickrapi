//
//  NSManagedObjectContext+Extensions.h
//  OneBudget
//
//  Created by Nikolay Spassov on 23.04.16.
//  Copyright © 2016 г. Nikolay Spassov. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Extensions)

+ (NSFetchRequest *)fetchRequest;
+ (NSFetchRequest *)fetchRequestWithSortDescriptors:(NSArray *)sortDescriptors;

@end


@interface NSManagedObjectContext (Extensions)

+ (NSManagedObjectContext *)mainContext;

- (NSManagedObjectContext *)createChildContext;
- (BOOL)save;
- (NSArray *)executeFetchRequest:(NSFetchRequest *)request;
- (NSEntityDescription *)entityDescriptionForClass:(Class)className;
- (id)insertedObjectForEntityClass:(Class)className;

@end


@interface NSFetchRequest (Extensions)

- (NSFetchedResultsController *)fetchedResultsControllerWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
- (NSFetchedResultsController *)fetchedResultsControllerWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate sectionNameKeyPath:(NSString *)sectionNameKeyPath;

@end


@interface NSFetchedResultsController (Extensions)

- (BOOL)performFetch;
- (id<NSFetchedResultsSectionInfo>)sectionAtIndex:(NSUInteger)sectionIndex;

@end
