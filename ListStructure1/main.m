//
//  main.m
//  ListStructure1
//
//  Created by CSX on 2017/4/6.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct student STU;

struct student{
    char name[20];
    unichar age;
    float avg;
    STU *next;
};

void test (STU *head){
    printf("size of :%ld\n",sizeof(*head));
}


void add_note(STU *head, STU *new){
    STU *data = malloc(sizeof(STU));
    memcpy(data, new, sizeof(STU));
    data->next = NULL;
    while (head->next != NULL) {
        head = head->next;
    }
    head->next = data;
}

void dispaly_list(STU *head){
    while (head->next != NULL) {
        printf("\n\n\n");
        printf("name : %s\n",head->name);
        printf("age : %d\n",head->age);
        printf("avg : %f\n",head->avg);
        
        head = head->next;
    }
}




int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        STU *head = malloc(sizeof(STU));
        if (!head) {
            printf("malloc");
            return -1;
        }
        memset(head, 0, sizeof(*head));
        head->next = NULL;
        
        for (int i = 0; i<10; i++) {
            STU *stu1 = malloc(sizeof(STU));
            strcpy(stu1->name, "Jack");
            stu1->name[strlen(stu1->name)] = '\0';
            stu1->age = arc4random()%100+17;
            stu1->avg = arc4random()%100+50;
            add_note(head, stu1);
        }
        
        dispaly_list(head);
        
        
 
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
