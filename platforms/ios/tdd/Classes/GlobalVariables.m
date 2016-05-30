//
//  GlobalVariables.m
//  Mjsen
//
//  Created by NLE1 on 10. 8. 26..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GlobalVariables.h"

static GlobalVariables *singleTonClass = nil;

@implementation GlobalVariables


@synthesize G_DeviceId;		//사용자 id
@synthesize G_MemberId;		//사용자명
@synthesize G_Host;


+(GlobalVariables*)singleTonClass {
	
	if (singleTonClass == nil) {
		
		singleTonClass = [[super allocWithZone:NULL] init];
	}
	
	return singleTonClass;
}



@end
