//
//  appleblink.c
//  AppleLogoBlink_C
//
//  Created by Harun Urhan on 14.03.2014.
//  Copyright (c) 2014 Harun Urhan. All rights reserved.
//
// to compile gcc -o appleblink appleblink.c -framework IOKit -framework ApplicationServices
// to run ./appleblink 4

#include <stdio.h>
#include <IOKit/graphics/IOGraphicsLib.h>
#include <ApplicationServices/ApplicationServices.h>

int main(int argc, char **argv)
{
    CGDirectDisplayID targetDisplayId = CGMainDisplayID();
    io_service_t service = CGDisplayIOServicePort(targetDisplayId);
    CFStringRef key = CFSTR(kIODisplayBrightnessKey);
    int blinktime = strtof(argv[1], NULL);
    int count = 0;
    while(count <= blinktime)
    {
        IODisplaySetIntegerParameter(service, kNilOptions, key, 0);
        sleep(1);
        IODisplaySetIntegerParameter(service, kNilOptions, key, 1000);
        sleep(1);
        count++;
    }
    printf("appleblink ended \n");
    return 0;
}
