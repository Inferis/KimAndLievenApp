// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Kid.m instead.

#import "_Kid.h"

@implementation KidID
@end

@implementation _Kid

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Kid" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Kid";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Kid" inManagedObjectContext:moc_];
}

- (KidID*)objectID {
	return (KidID*)[super objectID];
}




@dynamic birthdate;






@dynamic name;






@dynamic length;






@dynamic birthhour;






@dynamic parent;






@dynamic weight;






@dynamic sex;










@end
