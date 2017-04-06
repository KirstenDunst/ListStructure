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
    memcpy(data, new, sizeof(STU));   //memcpy(void *dest, const void *src, size_t n);用来将src地址处的内容拷贝n个字节的数据至目标地址dest指向的内存中去。函数返回指向dest的指针。    memcpy用来做内存拷贝，你可以拿它拷贝任何数据类型的对象，可以指定拷贝的数据长度；
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


#pragma mark-----------------------------双向链表(非循环的双向链表操作)-------------开始---------
/*
 *双向链表相比较单向链表，主要有下面几个特点：
 *（1）在数据结构中具有双向指针
 *（2）插入数据的时候需要考虑前后的方向的操作
 *（3）同样，删除数据的是有也需要考虑前后方向的操作
 */


typedef struct _Double_Link_Node DoubleList;
struct _Double_Link_Node{
    int data;
    struct _Double_Link_Node *prev;
    struct _Double_Link_Node *next;
};
//创建双向链表节点
DoubleList *create_double_link_node(int value){
    DoubleList *pDLinkNode = NULL;
    pDLinkNode = malloc(sizeof(DoubleList));
    assert(pDLinkNode != NULL);//断言，不满足会报错原因，不继续执行
    memset(pDLinkNode, 0, sizeof(DoubleList));      //memset(void *s,int c,size_t n) 作用：将已开辟内存空间 s 的首 n 个字节的值设为值 c（给空间初始化）；
    pDLinkNode->data = value;
    return pDLinkNode;
}

//删除双向链表
void delete_all_double_link_node(DoubleList *pDlinkNode){
    DoubleList *pNode;
    if (pDlinkNode == NULL) {
        return;
    }
    
    pNode = pDlinkNode;
    pDlinkNode = pNode->next;
    delete_all_double_link_node(pDlinkNode);
}
//在双向链表中查找数据
DoubleList *find_data_in_double_link(const DoubleList *pDLinkNode, int data){
    DoubleList *pNode = NULL;
    if (pDLinkNode == NULL) {
        return NULL;
    }
    
    pNode = (DoubleList *)pDLinkNode;
    while (pNode != NULL) {
        if (data == pNode->data) {
            return pNode;
        }
         pNode = pNode->next;
    }
    return NULL;
}

//双向链表中插入数据
BOOL insert_data_into_double_link(DoubleList *pNLinkNode, int data){
    DoubleList *pNode;
    DoubleList *pIndex;
    
    if (pNLinkNode == NULL) {
        pNode = create_double_link_node(data);
        assert(pNode != NULL);
        pNLinkNode = pNode;
        pNLinkNode->prev = pNLinkNode->next = NULL;
        return TRUE;
    }
    
    if (find_data_in_double_link(pNLinkNode, data) != NULL) {
        return FALSE;
    }
    
    pNode = create_double_link_node(data);
    assert(pNode != NULL);
    pIndex = pNLinkNode;
    while (pIndex->next != NULL) {
        pIndex = pIndex->next;
    }
    
    pNode->prev = pIndex;
    pNode->next = pIndex->next;
    pIndex->next = pNode;
    
    return TRUE;
}
//双向链表中删除数据
BOOL delect_data_from_double_link(DoubleList *pDLinkNode, int data){
    DoubleList *pNode;
    if (pDLinkNode == NULL) {
        return FALSE;
    }
    
    pNode = find_data_in_double_link(pDLinkNode, data);
    if (pNode == NULL) {
        return FALSE;
    }
    
    if (pNode == pDLinkNode) {
        if (pDLinkNode->next == NULL) {
            pDLinkNode = NULL;
        }else{
            pDLinkNode = pNode->next;
            pDLinkNode->prev = NULL;
        }
    }else{
        if (pNode->next) {
            pNode->next->prev = pNode->prev;
            pNode->prev->next = pNode->next;
        }
    }
    
    free(pNode);
    
    return TRUE;
}

//统计双向链表中数据的个数
int count_number_in_double_link(const DoubleList *pDLinkNode){
    int count = 0;
    DoubleList *pNode = (DoubleList *)pDLinkNode;
    
    while (pNode != NULL) {
        count++;
        pNode = pNode->next;
    }
    return count;
}

//打印双向链表中数据
void print_double_link_node(const DoubleList *pDLinkNode){
    DoubleList *pNode = (DoubleList *)pDLinkNode;
    while (pNode != NULL) {
        printf("%D\n",pNode->data);
        pNode = pNode->next;
    }
    
}
#pragma mark-----------------------------------双向链表(非循环的双向链表操作)--------------结束------------









int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        STU *head = malloc(sizeof(STU));
        if (!head) {
            printf("malloc");
            return -1;
        }
        memset(head, 0, sizeof(*head));   //memset(void *s,int c,size_t n) 作用：将已开辟内存空间 s 的首 n 个字节的值设为值 c（给空间初始化）；
        head->next = NULL;
        
        for (int i = 0; i<10; i++) {
            STU *stu1 = malloc(sizeof(STU));
            strcpy(stu1->name, "Jack");               //strcpy只能拷贝字符串，它遇到'\0'就结束拷贝；例：char a[100],b[50];strcpy(a,b);如用strcpy(b,a)，要注意a中的字符串长度（第一个‘\0’之前）是否超过50位，如超过，则会造成b的内存溢出。会造成缓冲区溢出，轻者程序崩溃，重者系统会出现问题！！
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
