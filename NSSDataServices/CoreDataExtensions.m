//
//  NSManagedObjectContext+Extensions.m
//  OneBudget
//
//  Created by Nikolay Spassov on 23.04.16.
//  Copyright © 2016 г. Nikolay Spassov. All rights reserved.
//

#import "CoreDataExtensions.h"

#import "NSSCoreDataWrapper.h"

@implementation NSManagedObject (Extensions)

+ (NSFetchRequest *)fetchRequest
{
    return [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(self)];
}

+ (NSFetchRequest *)fetchRequestWithSortDescriptors:(NSArray *)sortDescriptors
{
    NSFetchRequest* fr = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(self)];
    [fr setSortDescriptors:sortDescriptors];
    return fr;
}

@end


@implementation NSManagedObjectContext (Extensions)

+ (NSManagedObjectContext *)mainContext
{
    return [[NSSCoreDataWrapper sharedInstance] mainContext];
}

- (NSManagedObjectContext *)createChildContext
{
    NSManagedObjectContext* moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [moc setParentContext:self];
    return moc;
}

- (BOOL)save
{
    NSError* e;
    if(![self save:&e]) {
#ifdef DEBUG
        NSLog(@"%@", e);
#endif
    }
    return !e;
}

- (NSArray *)executeFetchRequest:(NSFetchRequest *)request
{
    NSError* e;
    NSArray* a = [self executeFetchRequest:request error:&e];
    if(!a) {
#ifdef DEBUG
        NSLog(@"%@", e);
#endif
    }
    return a;
}

- (NSEntityDescription *)entityDescriptionForClass:(Class)className
{
    return [NSEntityDescription entityForName:NSStringFromClass(className) inManagedObjectContext:self];
}

- (id)insertedObjectForEntityClass:(Class)className
{
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(className) inManagedObjectContext:self];
}

@end


@implementation NSFetchRequest (Extensions)

- (NSFetchedResultsController *)fetchedResultsControllerWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate
{
    NSFetchedResultsController* frc = [[NSFetchedResultsController alloc] initWithFetchRequest:self managedObjectContext:[NSManagedObjectContext mainContext] sectionNameKeyPath:nil cacheName:nil];
    [frc setDelegate:delegate];
    return frc;
}

- (NSFetchedResultsController *)fetchedResultsControllerWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate sectionNameKeyPath:(NSString *)sectionNameKeyPath
{
    NSFetchedResultsController* frc = [[NSFetchedResultsController alloc] initWithFetchRequest:self managedObjectContext:[NSManagedObjectContext mainContext] sectionNameKeyPath:sectionNameKeyPath cacheName:nil];
    [frc setDelegate:delegate];
    return frc;
}

@end


@implementation NSFetchedResultsController (Extensions)

- (BOOL)performFetch
{
    NSError* e;
    if(![self performFetch:&e]) {
#ifdef DEBUG
        NSLog(@"%@", e);
#endif
    }
    return !e;
}

- (id<NSFetchedResultsSectionInfo>)sectionAtIndex:(NSUInteger)sectionIndex
{
    if(!self.sections.count)
        return nil;
    else
        return (id<NSFetchedResultsSectionInfo>)[self.sections objectAtIndex:sectionIndex];
}

@end
