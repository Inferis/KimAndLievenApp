// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Kid.h instead.

#import <CoreData/CoreData.h>











@interface KidID : NSManagedObjectID {}
@end

@interface _Kid : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (KidID*)objectID;



@property (nonatomic, retain) NSString *birthdate;

//- (BOOL)validateBirthdate:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *length;

//- (BOOL)validateLength:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *birthhour;

//- (BOOL)validateBirthhour:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *parent;

//- (BOOL)validateParent:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *weight;

//- (BOOL)validateWeight:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *sex;

//- (BOOL)validateSex:(id*)value_ error:(NSError**)error_;





@end

@interface _Kid (CoreDataGeneratedAccessors)

@end

@interface _Kid (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveBirthdate;
- (void)setPrimitiveBirthdate:(NSString*)value;


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;


- (NSString*)primitiveLength;
- (void)setPrimitiveLength:(NSString*)value;


- (NSString*)primitiveBirthhour;
- (void)setPrimitiveBirthhour:(NSString*)value;


- (NSString*)primitiveParent;
- (void)setPrimitiveParent:(NSString*)value;


- (NSString*)primitiveWeight;
- (void)setPrimitiveWeight:(NSString*)value;


- (NSString*)primitiveSex;
- (void)setPrimitiveSex:(NSString*)value;



@end
