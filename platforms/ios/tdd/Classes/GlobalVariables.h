//
//  GlobalVariables.h
//  Mjsen
//
//  Created by NLE1 on 10. 8. 26..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GlobalVariables : NSObject {
	

	NSString *G_DeviceId;
	NSString *G_MemberId;		//사용자 id

}


@property(nonatomic, retain) NSString *G_DeviceId;		//사용자 id
@property(nonatomic, retain) NSString *G_MemberId;		//사용자명
@property(nonatomic, retain) NSString *G_Host;

+(GlobalVariables *)singleTonClass;

@end
