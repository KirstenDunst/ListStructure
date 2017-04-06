//
//  main.m
//  ListStructure
//
//  Created by CSX on 2017/4/6.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//



/*----------------------------------------新建->macOS  ->Command Line Tool  ---------------------------------*/


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
    while (head!= NULL) {
        printf("\n\n\n");
        printf("name : %s\n",head->name);
        printf("age : %d\n",head->age);
        printf("avg : %f\n",head->avg);
        head = head->next;
    }
}

//age的链表的冒泡排序核心算法
//STU *bubble(STU *pNode){
//    
//    if (pNode == NULL) {
//        printf("%s函数执行，链表为空，冒泡排序失败\n",__FUNCTION__);
//        return NULL;
//    }else{
//        
//        STU *pMove;
//        pMove = pNode;
//        //需要进行(n-1)次遍历,控制次数
//        int size = SizeList(pNode);
//        for (int i = 0; i < size-1; i++) {
//            while (pMove->next != NULL) {
//                if (pMove->age > pMove->next->age) {
//                    //只要交换这两个节点的element元素值就可以了
//                    int temp;
//                    temp = pMove->age;
//                    pMove->age = pMove->next->age;
//                    pMove->next->age = temp;
//                }
//                pMove = pMove->next;
//            }
//            //每次遍历结束，pMove重新移动到链表头部
//            pMove = pNode;
//        }
//    }
//    printf("%s函数执行，链表冒泡排序完成\n",__FUNCTION__);
// return pNode;
//}
//// 5.返回单链表的长度
//int SizeList(STU *pHead)
//{
//    int size = 0;
//    
//    while(pHead != NULL)
//    {
//        size++;         //遍历链表size大小比链表的实际长度小1
//        pHead = pHead->next;
//    }
//    printf("sizeList函数执行，链表长度 %d \n",size);
//    return size;    //链表的实际长度
//}


STU *bubble(STU *head){
    STU* tail = NULL;
    
    while(tail != head->next)
    {
        STU* pre = head;
        STU* cur = pre->next;
        while(cur != tail && cur->next != tail)
        {
            if( cur->age > cur->next->age )
            {
                //交换当前节点和后一个节点
                pre->next = cur->next;
                cur->next = cur->next->next;
                pre->next->next = cur;  
            }  
            pre = pre->next;  
            cur = pre->next;  
        }  
        
        tail = cur;  
    }
    return head;
}


#pragma mark-----------------------------双向链表






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
        
        
        NSLog(@"Hello, World!\n");
        
        
        STU *buble = bubble(head);
        dispaly_list(buble);
        
        NSLog(@"结束");
    }
    return 0;
}
