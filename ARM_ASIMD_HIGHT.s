.data
vector: .Byte 0,2,4,6,8,10,12,14,1,3,5,7,9,11,13,15
vector2: .Byte 0,8,1,9,2,10,3,11,4,12,5,13,6,14,7,15
vector3: .Byte 8,7,9,0,10,1,11,2,12,3,13,4,14,5,15,6
delta: 
 .Byte 0x2c, 0x37, 0x7d, 0x76, 0x59, 0x6f, 0x7a, 0x6c, 0x33, 0x5e, 0x75, 0x58, 0x66, 0x3c, 0x6a, 0x31
 .Byte 0x4c, 0x79, 0x55, 0x62, 0x18, 0x73, 0x2a, 0x45, 0x30, 0x67, 0x54, 0x0a, 0x60, 0x4e, 0x28, 0x14
 .Byte 0x41, 0x1c, 0x50, 0x29, 0x03, 0x39, 0x21, 0x52, 0x06, 0x72, 0x42, 0x25, 0x0d, 0x65, 0x05, 0x4B
 .Byte 0x1B, 0x4a, 0x0b, 0x17, 0x36, 0x15, 0x16, 0x2f, 0x6d, 0x2b, 0x2d, 0x5f, 0x5a, 0x56, 0x5b, 0x3e 
 .Byte 0x61,0x26,0x48,0x5a, 0x43,0x4d,0x11,0x35, 0x07,0x1a,0x22,0x6b, 0x0f,0x34,0x44,0x57
 .Byte 0x1f,0x69,0x08,0x2e, 0x3f,0x53,0x10,0x5d, 0x7f,0x27,0x20,0x3a, 0x7e,0x4f,0x40,0x74
 .Byte 0x7c,0x1e,0x01,0x68, 0x78,0x3d,0x02,0x51, 0x71,0x7b,0x04,0x23, 0x63,0x77,0x09,0x46
 .Byte 0x47,0x6e,0x12,0x0c, 0x0e,0x5c,0x24,0x19, 0x1d,0x38,0x49,0x32, 0x3b,0x70,0x13,0x64

 
.text
    .global HIGHT_encrypt
    .global F_Function_M4
    .global F_Function_ARMv8
    .global HIGHT_RoundKey_Setting
    .global HIGHT_Final
    .global HIGHT_Final2
    .global HIGHT_encrypt_8_Data_Task
    .global HIGHT_encrypt_8_Data_Task_loop
    .global HIGHT_encrypt_8_Data_Task_loop_LDR
    .global F_Function_M4_8PT
    .global HIGHT_revise
    .global HIGHT_original

HIGHT_revise:

   LD4 {v0.16b-v3.16b},[x1] // 8PT
   MOV w3,#0 // Round count
   LD4 {v0.16b-v3.16b},[x1] // 8PT

   //v4, v5 Initial, v27~v30 Roundkey
   //Initial
   LD2 {v4.16b-v5.16b},[x2],#32
   EOR v1.16b,v1.16b,v4.16b
   ADD v3.16b,v3.16b,v5.16b
   EOR v1.16b,v1.16b,v4.16b
   ADD v3.16b,v3.16b,v5.16b
   //Round Function
     //1 round
    //key load

loop13:

   LD4 {v27.16b-v30.16b},[x2],#64

    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v2.16b,v23.16b,v2.16b
 
    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b

     shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v2.16b,v23.16b,v2.16b
 
    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b


     //2round
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear

    //3 round
    //key load
   LD4 {v27.16b-v30.16b},[x2],#64

    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear
    //3 round
    //key load
   LD4 {v27.16b-v30.16b},[x2],#64

    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear
 
   //4round
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b
    //4round
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b
    add w3,w3,#1
    CMP w3,#7
    BNE loop13
   
   //1 round
    //key load
   LD4 {v27.16b-v30.16b},[x2],#64
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b

    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round

    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
    //clear
      LD4 {v27.16b-v30.16b},[x2],#64

    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
    //clear
    //3 round
    //key load
   
    //F Function
    MOV v4.16b,v2.16b
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v2.16b,v23.16b,v1.16b

    MOV v1.16b,v0.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v0.16b,v23.16b,v3.16b

    MOV v3.16b,v4.16b
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
    //Initial
    LD2 {v10.16b-v11.16b},[x2]

    add v3.16b,v11.16b,v3.16b
    eor v1.16b,v10.16b,v1.16b
    add v3.16b,v11.16b,v3.16b
    eor v1.16b,v10.16b,v1.16b

   
    ST4 {v0.16b-v3.16b},[x0]
       
    ST4 {v0.16b-v3.16b},[x0]

    ret
HIGHT_original:
   
    LD4 {v0.16b-v3.16b},[x1]
    LD4 {v0.16b-v3.16b},[x1]
    MOV w3,#0

    //Initial
    //v0 -> 0 ,4 index v1-> 1, 5 index, v2->2,6 index, v3->3,7 index , v8, v9, v10, v11 round key
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4

    trn1 v10.16b,v8.16b,v9.16b
    trn2 v11.16b,v8.16b,v9.16b

    EOR v1.16b,v1.16b,v10.16b
    ADD v3.16b,v3.16b,v11.16b
   EOR v1.16b,v1.16b,v10.16b
    ADD v3.16b,v3.16b,v11.16b
loop12:
    //1 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
    //clear


    //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
    //clear

    //4round
             
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
    add w3,w3,#1
    CMP w3,#7
    BNE loop12
   
   //1 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
    //clear
   
       //2 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear

shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
           //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear
   shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
    //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    MOV v4.16b,v2.16b
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v1.16b

    MOV v1.16b,v0.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v3.16b

    MOV v3.16b,v4.16b
shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
    //Initial
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn2 v10.16b,v8.16b,v9.16b
    trn1 v11.16b,v8.16b,v9.16b

    add v3.16b,v10.16b,v3.16b
    eor v1.16b,v11.16b,v1.16b

    add v3.16b,v10.16b,v3.16b
    eor v1.16b,v11.16b,v1.16b

    st4 {v0.16b-v3.16b},[x0]
        st4 {v0.16b-v3.16b},[x0]
    ret
HIGHT_Final2:
    LD4 {v0.16b-v3.16b},[x1] // 8PT
   MOV w3,#0 // Round count

   //v4, v5 Initial, v27~v30 Roundkey
   //Initial
   LD2 {v4.16b-v5.16b},[x2],#32
   EOR v1.16b,v1.16b,v4.16b
   ADD v3.16b,v3.16b,v5.16b
   EOR v1.16b,v1.16b,v4.16b
   ADD v3.16b,v3.16b,v5.16b
   //Round Function
     //1 round
    //key load

loop5:

   LD4 {v27.16b-v30.16b},[x2],#64

    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v2.16b,v23.16b,v2.16b
 
    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b

     //2round
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear

    //3 round
    //key load
   LD4 {v27.16b-v30.16b},[x2],#64

    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear
 
   //4round
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b
     //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v2.16b,v23.16b,v2.16b
 
    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b

     //2round
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear

    //3 round
    //key loa

    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear
 
   //4round
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b
    add w3,w3,#1
    CMP w3,#7
    BNE loop5
   
   //1 round
    //key load
   LD4 {v27.16b-v30.16b},[x2],#64
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round

    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear
      

    //v20, v21,v22 : temp, v23 : state 
      LD4 {v27.16b-v30.16b},[x2],#64
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear
    //3 round
    //key load
   
    //F Function
    MOV v4.16b,v2.16b
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v2.16b,v23.16b,v1.16b

    MOV v1.16b,v0.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v0.16b,v23.16b,v3.16b

    MOV v3.16b,v4.16b

    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round

    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear
      

    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear
    //3 round
    //key load
   
    //F Function
    MOV v4.16b,v2.16b
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v2.16b,v23.16b,v1.16b

    MOV v1.16b,v0.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v0.16b,v23.16b,v3.16b

    MOV v3.16b,v4.16b
    //Initial
    LD2 {v10.16b-v11.16b},[x2]

    add v3.16b,v11.16b,v3.16b
    eor v1.16b,v10.16b,v1.16b
 add v3.16b,v11.16b,v3.16b
    eor v1.16b,v10.16b,v1.16b

   
   ST4 {v0.16b-v3.16b},[x0]

   ret
   
HIGHT_Final:

   LD4 {v0.16b-v3.16b},[x1] // 8PT
   MOV w3,#0 // Round count

   //v4, v5 Initial, v27~v30 Roundkey
   //Initial
   LD2 {v4.16b-v5.16b},[x2],#32
   EOR v1.16b,v1.16b,v4.16b
   ADD v3.16b,v3.16b,v5.16b
   //Round Function
     //1 round
    //key load

loop3:

   LD4 {v27.16b-v30.16b},[x2],#64

    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v2.16b,v23.16b,v2.16b
 
    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b

     //2round
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear

    //3 round
    //key load
   LD4 {v27.16b-v30.16b},[x2],#64

    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear
 
   //4round
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b
    add w3,w3,#1
    CMP w3,#7
    BNE loop3
   
   //1 round
    //key load
   LD4 {v27.16b-v30.16b},[x2],#64
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round

    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear
      LD4 {v27.16b-v30.16b},[x2],#64

    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v27.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v28.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear
    //3 round
    //key load
   
    //F Function
    MOV v4.16b,v2.16b
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v29.16b
    add v2.16b,v23.16b,v1.16b

    MOV v1.16b,v0.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v30.16b
    eor v0.16b,v23.16b,v3.16b

    MOV v3.16b,v4.16b
    //Initial
    LD2 {v10.16b-v11.16b},[x2]

    add v3.16b,v11.16b,v3.16b
    eor v1.16b,v10.16b,v1.16b

   
    ST4 {v0.16b-v3.16b},[x0]

    ret
   
HIGHT_RoundKey_Setting:
   //v0 Master Key, v5~v12 delta register v13~v15 temp, v16~v23
   LD1 {v0.16b},[x0]
   DUP v1.8h,v0.h[0]
   DUP v2.8h,v0.h[1]
   MOV w0,#0 // Round count
   LDR x5,=delta
   LD4 {v5.16b-v8.16b},[x5],#64
   LD4 {v9.16b-v12.16b},[x5]
   MOV v20.16b,v0.16b

   trn1 v3.16b,v1.16b,v2.16b
   trn2 v4.16b,v1.16b,v2.16b

   ST2 {v3.16b-v4.16b},[x1],#32
//RoundKey setting
   add v13.16b,v0.16b,v5.16b

   DUP v3.16b,v13.b[15]
   DUP v4.16b,v13.b[13]
   trn1 v16.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[14]
   DUP v4.16b,v13.b[12]
    trn1 v17.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[11]
   DUP v4.16b,v13.b[9]
    trn1 v18.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[10]
   DUP v4.16b,v13.b[8]
    trn1 v19.16b,v4.16b,v3.16b

   ST4 {v16.16b-v19.16b},[x1],#64
//okay
   DUP v3.16b,v13.b[7]
   DUP v4.16b,v13.b[5]
   trn1 v16.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[6]
   DUP v4.16b,v13.b[4]
    trn1 v17.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[3]
   DUP v4.16b,v13.b[1]
   trn1 v18.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[2]
   DUP v4.16b,v13.b[0]
   trn1 v19.16b,v4.16b,v3.16b
  ST4 {v16.16b-v19.16b},[x1],#64
//Key Rotation
   MOV v13.b[8],v0.b[8]
   MOV v13.b[0],v0.b[0]
   USHR v0.2d,v0.2d,#8
   MOV v0.b[7],v13.b[0]
   MOV v0.b[15],v13.b[8]

   add v13.16b,v0.16b,v6.16b
   DUP v3.16b,v13.b[15]
   DUP v4.16b,v13.b[13]
   trn1 v16.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[14]
   DUP v4.16b,v13.b[12]
    trn1 v17.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[11]
   DUP v4.16b,v13.b[9]
    trn1 v18.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[10]
   DUP v4.16b,v13.b[8]
    trn1 v19.16b,v4.16b,v3.16b

   ST4 {v16.16b-v19.16b},[x1],#64

   DUP v3.16b,v13.b[7]
   DUP v4.16b,v13.b[5]
   trn1 v16.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[6]
   DUP v4.16b,v13.b[4]
    trn1 v17.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[3]
   DUP v4.16b,v13.b[1]
   trn1 v18.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[2]
   DUP v4.16b,v13.b[0]
   trn1 v19.16b,v4.16b,v3.16b
   
   ST4 {v16.16b-v19.16b},[x1],#64

   MOV v13.b[8],v0.b[8]
   MOV v13.b[0],v0.b[0]
   USHR v0.2d,v0.2d,#8
   MOV v0.b[7],v13.b[0]
   MOV v0.b[15],v13.b[8]

    add v13.16b,v0.16b,v7.16b
   DUP v3.16b,v13.b[15]
   DUP v4.16b,v13.b[13]
   trn1 v16.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[14]
   DUP v4.16b,v13.b[12]
    trn1 v17.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[11]
   DUP v4.16b,v13.b[9]
    trn1 v18.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[10]
   DUP v4.16b,v13.b[8]
    trn1 v19.16b,v4.16b,v3.16b

   ST4 {v16.16b-v19.16b},[x1],#64

   DUP v3.16b,v13.b[7]
   DUP v4.16b,v13.b[5]
   trn1 v16.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[6]
   DUP v4.16b,v13.b[4]
    trn1 v17.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[3]
   DUP v4.16b,v13.b[1]
   trn1 v18.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[2]
   DUP v4.16b,v13.b[0]
   trn1 v19.16b,v4.16b,v3.16b

   ST4 {v16.16b-v19.16b},[x1],#64
  

   MOV v13.b[8],v0.b[8]
   MOV v13.b[0],v0.b[0]
   USHR v0.2d,v0.2d,#8
   MOV v0.b[7],v13.b[0]
   MOV v0.b[15],v13.b[8]

   add v13.16b,v0.16b,v8.16b
   DUP v3.16b,v13.b[15]
   DUP v4.16b,v13.b[13]
   trn1 v16.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[14]
   DUP v4.16b,v13.b[12]
    trn1 v17.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[11]
   DUP v4.16b,v13.b[9]
    trn1 v18.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[10]
   DUP v4.16b,v13.b[8]
    trn1 v19.16b,v4.16b,v3.16b

   ST4 {v16.16b-v19.16b},[x1],#64

   DUP v3.16b,v13.b[7]
   DUP v4.16b,v13.b[5]
   trn1 v16.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[6]
   DUP v4.16b,v13.b[4]
    trn1 v17.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[3]
   DUP v4.16b,v13.b[1]
   trn1 v18.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[2]
   DUP v4.16b,v13.b[0]
   trn1 v19.16b,v4.16b,v3.16b
   
   ST4 {v16.16b-v19.16b},[x1],#64
    
   MOV v13.b[8],v0.b[8]
   MOV v13.b[0],v0.b[0]
   USHR v0.2d,v0.2d,#8
   MOV v0.b[7],v13.b[0]
   MOV v0.b[15],v13.b[8]

   add v13.16b,v0.16b,v9.16b
   DUP v3.16b,v13.b[15]
   DUP v4.16b,v13.b[13]
   trn1 v16.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[14]
   DUP v4.16b,v13.b[12]
    trn1 v17.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[11]
   DUP v4.16b,v13.b[9]
    trn1 v18.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[10]
   DUP v4.16b,v13.b[8]
    trn1 v19.16b,v4.16b,v3.16b

   ST4 {v16.16b-v19.16b},[x1],#64

   DUP v3.16b,v13.b[7]
   DUP v4.16b,v13.b[5]
   trn1 v16.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[6]
   DUP v4.16b,v13.b[4]
    trn1 v17.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[3]
   DUP v4.16b,v13.b[1]
   trn1 v18.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[2]
   DUP v4.16b,v13.b[0]
   trn1 v19.16b,v4.16b,v3.16b

   ST4 {v16.16b-v19.16b},[x1],#64
  


    MOV v13.b[8],v0.b[8]
   MOV v13.b[0],v0.b[0]
   USHR v0.2d,v0.2d,#8
   MOV v0.b[7],v13.b[0]
   MOV v0.b[15],v13.b[8]

   
   add v13.16b,v0.16b,v10.16b
   DUP v3.16b,v13.b[15]
   DUP v4.16b,v13.b[13]
   trn1 v16.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[14]
   DUP v4.16b,v13.b[12]
    trn1 v17.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[11]
   DUP v4.16b,v13.b[9]
    trn1 v18.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[10]
   DUP v4.16b,v13.b[8]
    trn1 v19.16b,v4.16b,v3.16b

   ST4 {v16.16b-v19.16b},[x1],#64

   DUP v3.16b,v13.b[7]
   DUP v4.16b,v13.b[5]
   trn1 v16.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[6]
   DUP v4.16b,v13.b[4]
    trn1 v17.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[3]
   DUP v4.16b,v13.b[1]
   trn1 v18.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[2]
   DUP v4.16b,v13.b[0]
   trn1 v19.16b,v4.16b,v3.16b
   
   ST4 {v16.16b-v19.16b},[x1],#64

    MOV v13.b[8],v0.b[8]
   MOV v13.b[0],v0.b[0]
   USHR v0.2d,v0.2d,#8
   MOV v0.b[7],v13.b[0]
   MOV v0.b[15],v13.b[8]

   
   add v13.16b,v0.16b,v11.16b
   DUP v3.16b,v13.b[15]
   DUP v4.16b,v13.b[13]
   trn1 v16.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[14]
   DUP v4.16b,v13.b[12]
    trn1 v17.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[11]
   DUP v4.16b,v13.b[9]
    trn1 v18.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[10]
   DUP v4.16b,v13.b[8]
    trn1 v19.16b,v4.16b,v3.16b

   ST4 {v16.16b-v19.16b},[x1],#64

   DUP v3.16b,v13.b[7]
   DUP v4.16b,v13.b[5]
   trn1 v16.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[6]
   DUP v4.16b,v13.b[4]
    trn1 v17.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[3]
   DUP v4.16b,v13.b[1]
   trn1 v18.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[2]
   DUP v4.16b,v13.b[0]
   trn1 v19.16b,v4.16b,v3.16b
   
   ST4 {v16.16b-v19.16b},[x1],#64

   
   MOV v13.b[8],v0.b[8]
   MOV v13.b[0],v0.b[0]
   USHR v0.2d,v0.2d,#8
   MOV v0.b[7],v13.b[0]
   MOV v0.b[15],v13.b[8]

   
   add v13.16b,v0.16b,v12.16b
   DUP v3.16b,v13.b[15]
   DUP v4.16b,v13.b[13]
   trn1 v16.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[14]
   DUP v4.16b,v13.b[12]
    trn1 v17.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[11]
   DUP v4.16b,v13.b[9]
    trn1 v18.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[10]
   DUP v4.16b,v13.b[8]
    trn1 v19.16b,v4.16b,v3.16b

   ST4 {v16.16b-v19.16b},[x1],#64

   DUP v3.16b,v13.b[7]
   DUP v4.16b,v13.b[5]
   trn1 v16.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[6]
   DUP v4.16b,v13.b[4]
    trn1 v17.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[3]
   DUP v4.16b,v13.b[1]
   trn1 v18.16b,v4.16b,v3.16b
   DUP v3.16b,v13.b[2]
   DUP v4.16b,v13.b[0]
   trn1 v19.16b,v4.16b,v3.16b
   
   ST4 {v16.16b-v19.16b},[x1],#64

   
   DUP v21.8h,v20.h[6]
   DUP v22.8h,v20.h[7]
   trn1 v16.16b,v21.16b,v22.16b
   trn2 v17.16b,v21.16b,v22.16b


   ST2 {v16.16b-v17.16b},[x1]
   ret



   
   //v1 delta
F_Function_M4_8PT:
   AND w11,w2, #0x00FF00FF
    LSL x10,x11,#1
    EOR x10,x10,x11,LSR #7
    EOR x10,x10,x11,LSL #2
    EOR x10,x10,x11,LSR #6
    EOR x10,x10,x11,LSL #7
    EOR x10,x10,x11,LSR #1
    AND w6,w10,#0x00ff00ff

    AND w11,w2, #0x00FF00FF
    LSL x10,x11,#1
    EOR x10,x10,x11,LSR #7
    EOR x10,x10,x11,LSL #2
    EOR x10,x10,x11,LSR #6
    EOR x10,x10,x11,LSL #7
    EOR x10,x10,x11,LSR #1
    AND w6,w10,#0x00ff00ff
    ORR x10,x10,x10
   
   AND w11,w2, #0x00FF00FF
    LSL x10,x11,#1
    EOR x10,x10,x11,LSR #7
    EOR x10,x10,x11,LSL #2
    EOR x10,x10,x11,LSR #6
    EOR x10,x10,x11,LSL #7
    EOR x10,x10,x11,LSR #1
    AND w6,w10,#0x00ff00ff

    AND w11,w2, #0x00FF00FF
    LSL x10,x11,#1
    EOR x10,x10,x11,LSR #7
    EOR x10,x10,x11,LSL #2
    EOR x10,x10,x11,LSR #6
    EOR x10,x10,x11,LSL #7
    EOR x10,x10,x11,LSR #1
    AND w6,w10,#0x00ff00ff
    ORR x10,x10,x10
   AND w11,w2, #0x00FF00FF
    LSL x10,x11,#1
    EOR x10,x10,x11,LSR #7
    EOR x10,x10,x11,LSL #2
    EOR x10,x10,x11,LSR #6
    EOR x10,x10,x11,LSL #7
    EOR x10,x10,x11,LSR #1
    AND w6,w10,#0x00ff00ff

    AND w11,w2, #0x00FF00FF
    LSL x10,x11,#1
    EOR x10,x10,x11,LSR #7
    EOR x10,x10,x11,LSL #2
    EOR x10,x10,x11,LSR #6
    EOR x10,x10,x11,LSL #7
    EOR x10,x10,x11,LSR #1
    AND w6,w10,#0x00ff00ff
    ORR x10,x10,x10
   AND w11,w2, #0x00FF00FF
    LSL x10,x11,#1
    EOR x10,x10,x11,LSR #7
    EOR x10,x10,x11,LSL #2
    EOR x10,x10,x11,LSR #6
    EOR x10,x10,x11,LSL #7
    EOR x10,x10,x11,LSR #1
    AND w6,w10,#0x00ff00ff

    AND w11,w2, #0x00FF00FF
    LSL x10,x11,#1
    EOR x10,x10,x11,LSR #7
    EOR x10,x10,x11,LSL #2
    EOR x10,x10,x11,LSR #6
    EOR x10,x10,x11,LSL #7
    EOR x10,x10,x11,LSR #1
    AND w6,w10,#0x00ff00ff
    ORR x10,x10,x10
   ret
test:
  LDR x1,=vector
  LD1 {v1.16b},[x1]
  LD1 {v0.16b},[x0]
  tbl v0.16b,{v0.16b},v1.16b

  ST1 {v0.16b},[x0]
  ret
  
HIGHT_encrypt_8_Data_Task_loop_LDR:
    LD4 {v0.16b-v3.16b},[x1]
    LD4 {v0.16b-v3.16b},[x1]
    MOV w3,#0
loop2:
    //1 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear


    //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear

    //4round
             
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b

     shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b
    add w3,w3,#1
    CMP w3,#7
    BNE loop2

  
   //1 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear


    //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear

    //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    MOV v4.16b,v2.16b
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v1.16b

    MOV v1.16b,v0.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v3.16b

    MOV v3.16b,v4.16b

   //1 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear


           //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear

    //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    MOV v4.16b,v2.16b
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v1.16b

    MOV v1.16b,v0.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v3.16b

    MOV v3.16b,v4.16b

    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn2 v10.16b,v8.16b,v9.16b
    trn1 v11.16b,v8.16b,v9.16b

    add v3.16b,v10.16b,v3.16b
    eor v1.16b,v11.16b,v1.16b

    st4 {v0.16b-v3.16b},[x0]
        add v3.16b,v10.16b,v3.16b
    eor v1.16b,v11.16b,v1.16b

    st4 {v0.16b-v3.16b},[x0]

    ret


HIGHT_encrypt_8_Data_Task_loop:  // loop use + 8 Data+Task parall + ST4 process (MOV X)
  
    LD4 {v0.16b-v3.16b},[x1]
    MOV w3,#0

    //Initial
    //v0 -> 0 ,4 index v1-> 1, 5 index, v2->2,6 index, v3->3,7 index , v8, v9, v10, v11 round key
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4

    trn1 v10.16b,v8.16b,v9.16b
    trn2 v11.16b,v8.16b,v9.16b

    EOR v1.16b,v1.16b,v10.16b
    ADD v3.16b,v3.16b,v11.16b
loop:
    //1 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear


    //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear

    //4round
             
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b
    add w3,w3,#1
    CMP w3,#7
    BNE loop
   
   //1 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear


           //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear

    //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    MOV v4.16b,v2.16b
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v1.16b

    MOV v1.16b,v0.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v3.16b

    MOV v3.16b,v4.16b
    //Initial
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn2 v10.16b,v8.16b,v9.16b
    trn1 v11.16b,v8.16b,v9.16b

    add v3.16b,v10.16b,v3.16b
    eor v1.16b,v11.16b,v1.16b

    st4 {v0.16b-v3.16b},[x0]

    
    ret
 

HIGHT_encrypt_8_Data_Task:
  
    LD4 {v0.16b-v3.16b},[x1]


    //Initial
    //v0 -> 0 ,4 index v1-> 1, 5 index, v2->2,6 index, v3->3,7 index , v8, v9, v10, v11 round key
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4

    trn1 v10.16b,v8.16b,v9.16b
    trn2 v11.16b,v8.16b,v9.16b

    EOR v1.16b,v1.16b,v10.16b
    ADD v3.16b,v3.16b,v11.16b
    //1 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear


           //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear

    //4round
             
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b

   
   //1 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear


           //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear

    //4round
             
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b

//8 round finish

   //1 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear


           //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear

    //4round
             
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b
//12 Round Finish
   //1 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear


           //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear

    //4round
             
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b
//16round finish
   //1 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear


           //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear

    //4round
             
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b
//20Round Finish
   //1 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear


           //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear

    //4round
             
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b
       //1 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear


           //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear

    //4round
             
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v1.16b,v23.16b,v1.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v3.16b,v23.16b,v3.16b
    rev16 v3.16b,v3.16b
//28round finish
   //1 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v3.16b, #3
    USHR v22.16b,v3.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #4
    USHR v22.16b,v3.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #6
    USHR v22.16b,v3.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v2.16b

    shl v21.16b,v1.16b, #1
    USHR v22.16b,v1.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #2
    USHR v22.16b,v1.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #7
    USHR v22.16b,v1.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v0.16b
    rev16 v0.16b,v0.16b
   
    //clear
   
       //2 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v0.16b, #3
    USHR v22.16b,v0.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #4
    USHR v22.16b,v0.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #6
    USHR v22.16b,v0.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v3.16b,v23.16b,v3.16b

    shl v21.16b,v2.16b, #1
    USHR v22.16b,v2.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #2
    USHR v22.16b,v2.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #7
    USHR v22.16b,v2.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v1.16b,v23.16b,v1.16b
    rev16 v1.16b,v1.16b
    //clear


           //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v1.16b, #3
    USHR v22.16b,v1.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v1.16b, #4
    USHR v22.16b,v1.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v1.16b, #6
    USHR v22.16b,v1.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v0.16b,v23.16b,v0.16b

    shl v21.16b,v3.16b, #1
    USHR v22.16b,v3.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v3.16b, #2
    USHR v22.16b,v3.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v3.16b, #7
    USHR v22.16b,v3.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v2.16b,v23.16b,v2.16b
    rev16 v2.16b,v2.16b
    //clear

    //3 round
    //key load
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn1 v10.16b,v9.16b,v8.16b
    trn2 v11.16b,v9.16b,v8.16b
    //F Function
    MOV v4.16b,v2.16b
    //v20, v21,v22 : temp, v23 : state 
    shl v21.16b,v2.16b, #3
    USHR v22.16b,v2.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v2.16b, #4
    USHR v22.16b,v2.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v2.16b, #6
    USHR v22.16b,v2.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    eor v23.16b,v23.16b,v10.16b
    add v2.16b,v23.16b,v1.16b

    MOV v1.16b,v0.16b

    shl v21.16b,v0.16b, #1
    USHR v22.16b,v0.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v0.16b, #2
    USHR v22.16b,v0.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v0.16b, #7
    USHR v22.16b,v0.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v11.16b
    eor v0.16b,v23.16b,v3.16b

    MOV v3.16b,v4.16b
    //Initial
    LDR w4,[x2],#4
    DUP v8.8h,w4
    LSR w4,w4,#16
    DUP v9.8h,w4
    
    trn2 v10.16b,v8.16b,v9.16b
    trn1 v11.16b,v8.16b,v9.16b

    add v3.16b,v10.16b,v3.16b
    eor v1.16b,v11.16b,v1.16b

    st4 {v0.16b-v3.16b},[x0]

    
    ret


HIGHT_encrypt:
//v0~v7 : PT, v8~v11 - RoundKey State, v12~v19 = state Register(v12 0-th, v13 1-th)
    LD4 {v0.16b-v3.16b},[x1],#64
    LD4 {v4.16b-v7.16b},[x1]
    LDR x3,=vector
    LD1 {v8.16b},[x3]
    //parael setting (0)
    trn1 v12.16b,v0.16b,v4.16b
    tbl v12.16b,{v12.16b},v8.16b

    trn1 v13.16b,v1.16b,v5.16b
    tbl v13.16b,{v13.16b},v8.16b

    trn1 v14.16b,v2.16b,v6.16b
    tbl v14.16b,{v14.16b},v8.16b

    trn1 v15.16b,v3.16b,v7.16b

    tbl v15.16b,{v15.16b},v8.16b

    trn2 v16.16b,v4.16b,v0.16b
    tbl v16.16b,{v16.16b},v8.16b

    trn2 v17.16b,v5.16b,v1.16b
    tbl v17.16b,{v17.16b},v8.16b

    trn2 v18.16b,v6.16b,v2.16b
    tbl v18.16b,{v18.16b},v8.16b

    trn2 v19.16b,v7.16b,v3.16b
    tbl v19.16b,{v19.16b},v8.16b

    //Initial
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    add v19.16b,v19.16b,v3.16b // v0 
    eor v17.16b,v17.16b,v2.16b
    add v15.16b,v15.16b,v1.16b
    eor v13.16b,v13.16b,v0.16b

    //Encrypt i-th
    //RoundKey
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4
   // v12~v19 = state Register(v12 7-th, v13 6-th) , v20, v21,v22 : temp, v23 : state 
    //F Function
    shl v21.16b,v19.16b, #3
    USHR v22.16b,v19.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #4
    USHR v22.16b,v19.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #6
    USHR v22.16b,v19.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v18.16b,v23.16b,v18.16b
    // clear 
    shl v21.16b,v17.16b, #1
    USHR v22.16b,v17.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v17.16b, #2
    USHR v22.16b,v17.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v17.16b, #7
    USHR v22.16b,v17.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v16.16b,v23.16b,v16.16b
    //clear
    shl v21.16b,v15.16b, #3
    USHR v22.16b,v15.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v15.16b, #4
    USHR v22.16b,v15.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v15.16b, #6
    USHR v22.16b,v15.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v14.16b,v23.16b,v14.16b
    ///clear
    shl v21.16b,v13.16b, #1
    USHR v22.16b,v13.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v13.16b, #2
    USHR v22.16b,v13.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v13.16b, #7
    USHR v22.16b,v13.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v3.16b
    eor v12.16b,v23.16b,v12.16b
    //2 round Keysetting
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///2round
    //F Function
    shl v21.16b,v12.16b, #3
    USHR v22.16b,v12.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v12.16b, #4
    USHR v22.16b,v12.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v12.16b, #6
    USHR v22.16b,v12.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v19.16b,v23.16b,v19.16b
    // clear 
    shl v21.16b,v18.16b, #1
    USHR v22.16b,v18.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v18.16b, #2
    USHR v22.16b,v18.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v18.16b, #7
    USHR v22.16b,v18.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v17.16b,v23.16b,v17.16b
    //clear
    shl v21.16b,v16.16b, #3
    USHR v22.16b,v16.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v16.16b, #4
    USHR v22.16b,v16.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v16.16b, #6
    USHR v22.16b,v16.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v15.16b,v23.16b,v15.16b
    //clear
    shl v21.16b,v14.16b, #1
    USHR v22.16b,v14.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v14.16b, #2
    USHR v22.16b,v14.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v14.16b, #7
    USHR v22.16b,v14.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v13.16b,v23.16b,v13.16b
    //clear

    //3 round Keysetting
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///3round
    //F Function
    shl v21.16b,v13.16b, #3
    USHR v22.16b,v13.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v13.16b, #4
    USHR v22.16b,v13.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v13.16b, #6
    USHR v22.16b,v13.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v12.16b,v23.16b,v12.16b
    // clear 
    shl v21.16b,v19.16b, #1
    USHR v22.16b,v19.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #2
    USHR v22.16b,v19.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #7
    USHR v22.16b,v19.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v18.16b,v23.16b,v18.16b
    //clear
    shl v21.16b,v17.16b, #3
    USHR v22.16b,v17.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v17.16b, #4
    USHR v22.16b,v17.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v17.16b, #6
    USHR v22.16b,v17.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v16.16b,v23.16b,v16.16b
    //clear
    shl v21.16b,v15.16b, #1
    USHR v22.16b,v15.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v15.16b, #2
    USHR v22.16b,v15.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v15.16b, #7
    USHR v22.16b,v15.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v14.16b,v23.16b,v14.16b
    //clear
    
    //4 round Keysetting
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///4round
    //F Function
    shl v21.16b,v14.16b, #3
    USHR v22.16b,v14.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v14.16b, #4
    USHR v22.16b,v14.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v14.16b, #6
    USHR v22.16b,v14.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v13.16b,v23.16b,v13.16b
    // clear 
    shl v21.16b,v12.16b, #1
    USHR v22.16b,v12.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v12.16b, #2
    USHR v22.16b,v12.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v12.16b, #7
    USHR v22.16b,v12.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v19.16b,v23.16b,v19.16b
    //clear
    shl v21.16b,v18.16b, #3
    USHR v22.16b,v18.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v18.16b, #4
    USHR v22.16b,v18.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v18.16b, #6
    USHR v22.16b,v18.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v17.16b,v23.16b,v17.16b
    //clear
    shl v21.16b,v16.16b, #1
    USHR v22.16b,v16.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v16.16b, #2
    USHR v22.16b,v16.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v16.16b, #7
    USHR v22.16b,v16.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v15.16b,v23.16b,v15.16b
    //clear
    //5round Key setting 
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///5round
    //F Function
    shl v21.16b,v15.16b, #3
    USHR v22.16b,v15.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v15.16b, #4
    USHR v22.16b,v15.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v15.16b, #6
    USHR v22.16b,v15.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v14.16b,v23.16b,v14.16b
    // clear 
    shl v21.16b,v13.16b, #1
    USHR v22.16b,v13.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v13.16b, #2
    USHR v22.16b,v13.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v13.16b, #7
    USHR v22.16b,v13.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v12.16b,v23.16b,v12.16b
    //clear
    shl v21.16b,v19.16b, #3
    USHR v22.16b,v19.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #4
    USHR v22.16b,v19.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #6
    USHR v22.16b,v19.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v18.16b,v23.16b,v18.16b
    //clear
    shl v21.16b,v17.16b, #1
    USHR v22.16b,v17.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v17.16b, #2
    USHR v22.16b,v17.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v17.16b, #7
    USHR v22.16b,v17.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v16.16b,v23.16b,v16.16b
    
    
    //6round Key setting 
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///6round
    //F Function
    shl v21.16b,v16.16b, #3
    USHR v22.16b,v16.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v16.16b, #4
    USHR v22.16b,v16.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v16.16b, #6
    USHR v22.16b,v16.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v15.16b,v23.16b,v15.16b
    // clear 
    shl v21.16b,v14.16b, #1
    USHR v22.16b,v14.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v14.16b, #2
    USHR v22.16b,v14.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v14.16b, #7
    USHR v22.16b,v14.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v13.16b,v23.16b,v13.16b
    //clear
    shl v21.16b,v12.16b, #3
    USHR v22.16b,v12.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v12.16b, #4
    USHR v22.16b,v12.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v12.16b, #6
    USHR v22.16b,v12.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v19.16b,v23.16b,v19.16b
    //clear
    shl v21.16b,v18.16b, #1
    USHR v22.16b,v18.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v18.16b, #2
    USHR v22.16b,v18.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v18.16b, #7
    USHR v22.16b,v18.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v17.16b,v23.16b,v17.16b
    
    
    
    

        //7round Key setting 
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///7round
    //F Function
    shl v21.16b,v17.16b, #3
    USHR v22.16b,v17.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v17.16b, #4
    USHR v22.16b,v17.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v17.16b, #6
    USHR v22.16b,v17.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v16.16b,v23.16b,v16.16b
    // clear 
    shl v21.16b,v15.16b, #1
    USHR v22.16b,v15.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v15.16b, #2
    USHR v22.16b,v15.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v15.16b, #7
    USHR v22.16b,v15.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v14.16b,v23.16b,v14.16b
    //clear
    shl v21.16b,v13.16b, #3
    USHR v22.16b,v13.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v13.16b, #4
    USHR v22.16b,v13.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v13.16b, #6
    USHR v22.16b,v13.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v12.16b,v23.16b,v12.16b
    //clear
    shl v21.16b,v19.16b, #1
    USHR v22.16b,v19.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #2
    USHR v22.16b,v19.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #7
    USHR v22.16b,v19.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v18.16b,v23.16b,v18.16b
    
    
   
    //8round Key setting 
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///8round
    //F Function
    shl v21.16b,v18.16b, #3
    USHR v22.16b,v18.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v18.16b, #4
    USHR v22.16b,v18.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v18.16b, #6
    USHR v22.16b,v18.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v17.16b,v23.16b,v17.16b
    // clear 
    shl v21.16b,v16.16b, #1
    USHR v22.16b,v16.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v16.16b, #2
    USHR v22.16b,v16.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v16.16b, #7
    USHR v22.16b,v16.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v15.16b,v23.16b,v15.16b
    //clear
    shl v21.16b,v14.16b, #3
    USHR v22.16b,v14.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v14.16b, #4
    USHR v22.16b,v14.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v14.16b, #6
    USHR v22.16b,v14.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v13.16b,v23.16b,v13.16b
    //clear
    shl v21.16b,v12.16b, #1
    USHR v22.16b,v12.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v12.16b, #2
    USHR v22.16b,v12.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v12.16b, #7
    USHR v22.16b,v12.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v19.16b,v23.16b,v19.16b
      
    
     //9round Key setting 
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///9round
    //F Function
    shl v21.16b,v19.16b, #3
    USHR v22.16b,v19.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #4
    USHR v22.16b,v19.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #6
    USHR v22.16b,v19.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v18.16b,v23.16b,v18.16b
    // clear 
    shl v21.16b,v17.16b, #1
    USHR v22.16b,v17.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v17.16b, #2
    USHR v22.16b,v17.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v17.16b, #7
    USHR v22.16b,v17.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v16.16b,v23.16b,v16.16b
    //clear
    shl v21.16b,v15.16b, #3
    USHR v22.16b,v15.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v15.16b, #4
    USHR v22.16b,v15.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v15.16b, #6
    USHR v22.16b,v15.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v14.16b,v23.16b,v14.16b
    //clear
    shl v21.16b,v13.16b, #1
    USHR v22.16b,v13.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v13.16b, #2
    USHR v22.16b,v13.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v13.16b, #7
    USHR v22.16b,v13.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v12.16b,v23.16b,v12.16b
      
    //10 round
        LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///10round
    //F Function
    shl v21.16b,v12.16b, #3
    USHR v22.16b,v12.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v12.16b, #4
    USHR v22.16b,v12.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v12.16b, #6
    USHR v22.16b,v12.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v19.16b,v23.16b,v19.16b
    // clear 
    shl v21.16b,v18.16b, #1
    USHR v22.16b,v18.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v18.16b, #2
    USHR v22.16b,v18.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v18.16b, #7
    USHR v22.16b,v18.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v17.16b,v23.16b,v17.16b
    //clear
    shl v21.16b,v16.16b, #3
    USHR v22.16b,v16.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v16.16b, #4
    USHR v22.16b,v16.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v16.16b, #6
    USHR v22.16b,v16.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v15.16b,v23.16b,v15.16b
    //clear
    shl v21.16b,v14.16b, #1
    USHR v22.16b,v14.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v14.16b, #2
    USHR v22.16b,v14.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v14.16b, #7
    USHR v22.16b,v14.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v13.16b,v23.16b,v13.16b 


    //11-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///11-round
    //F Function
    shl v21.16b,v13.16b, #3
    USHR v22.16b,v13.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v13.16b, #4
    USHR v22.16b,v13.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v13.16b, #6
    USHR v22.16b,v13.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v12.16b,v23.16b,v12.16b
    // clear 
    shl v21.16b,v19.16b, #1
    USHR v22.16b,v19.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #2
    USHR v22.16b,v19.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #7
    USHR v22.16b,v19.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v18.16b,v23.16b,v18.16b
    //clear
    shl v21.16b,v17.16b, #3
    USHR v22.16b,v17.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v17.16b, #4
    USHR v22.16b,v17.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v17.16b, #6
    USHR v22.16b,v17.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v16.16b,v23.16b,v16.16b
    //clear
    shl v21.16b,v15.16b, #1
    USHR v22.16b,v15.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v15.16b, #2
    USHR v22.16b,v15.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v15.16b, #7
    USHR v22.16b,v15.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v14.16b,v23.16b,v14.16b 

       //12-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///12-round
    //F Function
    shl v21.16b,v14.16b, #3
    USHR v22.16b,v14.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v14.16b, #4
    USHR v22.16b,v14.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v14.16b, #6
    USHR v22.16b,v14.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v13.16b,v23.16b,v13.16b
    // clear 
    shl v21.16b,v12.16b, #1
    USHR v22.16b,v12.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v12.16b, #2
    USHR v22.16b,v12.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v12.16b, #7
    USHR v22.16b,v12.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v19.16b,v23.16b,v19.16b
    //clear
    shl v21.16b,v18.16b, #3
    USHR v22.16b,v18.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v18.16b, #4
    USHR v22.16b,v18.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v18.16b, #6
    USHR v22.16b,v18.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v17.16b,v23.16b,v17.16b
    //clear
    shl v21.16b,v16.16b, #1
    USHR v22.16b,v16.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v16.16b, #2
    USHR v22.16b,v16.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v16.16b, #7
    USHR v22.16b,v16.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v15.16b,v23.16b,v15.16b 

    //OKAY

           //13-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///13-round
    //F Function
    shl v21.16b,v15.16b, #3
    USHR v22.16b,v15.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v15.16b, #4
    USHR v22.16b,v15.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v15.16b, #6
    USHR v22.16b,v15.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v14.16b,v23.16b,v14.16b
    // clear 
    shl v21.16b,v13.16b, #1
    USHR v22.16b,v13.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v13.16b, #2
    USHR v22.16b,v13.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v13.16b, #7
    USHR v22.16b,v13.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v12.16b,v23.16b,v12.16b
    //clear
    shl v21.16b,v19.16b, #3
    USHR v22.16b,v19.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #4
    USHR v22.16b,v19.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #6
    USHR v22.16b,v19.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v18.16b,v23.16b,v18.16b
    //clear
    shl v21.16b,v17.16b, #1
    USHR v22.16b,v17.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v17.16b, #2
    USHR v22.16b,v17.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v17.16b, #7
    USHR v22.16b,v17.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v16.16b,v23.16b,v16.16b 
    //14-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///14-round
    //F Function
    shl v21.16b,v16.16b, #3
    USHR v22.16b,v16.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v16.16b, #4
    USHR v22.16b,v16.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v16.16b, #6
    USHR v22.16b,v16.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v15.16b,v23.16b,v15.16b
    // clear 
    shl v21.16b,v14.16b, #1
    USHR v22.16b,v14.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v14.16b, #2
    USHR v22.16b,v14.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v14.16b, #7
    USHR v22.16b,v14.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v13.16b,v23.16b,v13.16b
    //clear
    shl v21.16b,v12.16b, #3
    USHR v22.16b,v12.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v12.16b, #4
    USHR v22.16b,v12.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v12.16b, #6
    USHR v22.16b,v12.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v19.16b,v23.16b,v19.16b
    //clear
    shl v21.16b,v18.16b, #1
    USHR v22.16b,v18.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v18.16b, #2
    USHR v22.16b,v18.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v18.16b, #7
    USHR v22.16b,v18.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v17.16b,v23.16b,v17.16b 

       //15-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///15-round
    //F Function
    shl v21.16b,v17.16b, #3
    USHR v22.16b,v17.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v17.16b, #4
    USHR v22.16b,v17.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v17.16b, #6
    USHR v22.16b,v17.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v16.16b,v23.16b,v16.16b
    // clear 
    shl v21.16b,v15.16b, #1
    USHR v22.16b,v15.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v15.16b, #2
    USHR v22.16b,v15.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v15.16b, #7
    USHR v22.16b,v15.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v14.16b,v23.16b,v14.16b
    //clear
    shl v21.16b,v13.16b, #3
    USHR v22.16b,v13.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v13.16b, #4
    USHR v22.16b,v13.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v13.16b, #6
    USHR v22.16b,v13.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v12.16b,v23.16b,v12.16b
    //clear
    shl v21.16b,v19.16b, #1
    USHR v22.16b,v19.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #2
    USHR v22.16b,v19.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #7
    USHR v22.16b,v19.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v18.16b,v23.16b,v18.16b 

          //16-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///16-round
    //F Function
    shl v21.16b,v18.16b, #3
    USHR v22.16b,v18.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v18.16b, #4
    USHR v22.16b,v18.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v18.16b, #6
    USHR v22.16b,v18.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v17.16b,v23.16b,v17.16b
    // clear 
    shl v21.16b,v16.16b, #1
    USHR v22.16b,v16.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v16.16b, #2
    USHR v22.16b,v16.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v16.16b, #7
    USHR v22.16b,v16.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v15.16b,v23.16b,v15.16b
    //clear
    shl v21.16b,v14.16b, #3
    USHR v22.16b,v14.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v14.16b, #4
    USHR v22.16b,v14.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v14.16b, #6
    USHR v22.16b,v14.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v13.16b,v23.16b,v13.16b
    //clear
    shl v21.16b,v12.16b, #1
    USHR v22.16b,v12.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v12.16b, #2
    USHR v22.16b,v12.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v12.16b, #7
    USHR v22.16b,v12.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v19.16b,v23.16b,v19.16b 

              //17-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///17-round
    //F Function
    shl v21.16b,v19.16b, #3
    USHR v22.16b,v19.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #4
    USHR v22.16b,v19.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #6
    USHR v22.16b,v19.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v18.16b,v23.16b,v18.16b
    // clear 
    shl v21.16b,v17.16b, #1
    USHR v22.16b,v17.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v17.16b, #2
    USHR v22.16b,v17.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v17.16b, #7
    USHR v22.16b,v17.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v16.16b,v23.16b,v16.16b
    //clear
    shl v21.16b,v15.16b, #3
    USHR v22.16b,v15.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v15.16b, #4
    USHR v22.16b,v15.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v15.16b, #6
    USHR v22.16b,v15.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v14.16b,v23.16b,v14.16b
    //clear
    shl v21.16b,v13.16b, #1
    USHR v22.16b,v13.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v13.16b, #2
    USHR v22.16b,v13.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v13.16b, #7
    USHR v22.16b,v13.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v12.16b,v23.16b,v12.16b


                  //18-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///18-round
    //F Function
    shl v21.16b,v12.16b, #3
    USHR v22.16b,v12.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v12.16b, #4
    USHR v22.16b,v12.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v12.16b, #6
    USHR v22.16b,v12.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v19.16b,v23.16b,v19.16b
    // clear 
    shl v21.16b,v18.16b, #1
    USHR v22.16b,v18.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v18.16b, #2
    USHR v22.16b,v18.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v18.16b, #7
    USHR v22.16b,v18.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v17.16b,v23.16b,v17.16b
    //clear
    shl v21.16b,v16.16b, #3
    USHR v22.16b,v16.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v16.16b, #4
    USHR v22.16b,v16.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v16.16b, #6
    USHR v22.16b,v16.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v15.16b,v23.16b,v15.16b
    //clear
    shl v21.16b,v14.16b, #1
    USHR v22.16b,v14.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v14.16b, #2
    USHR v22.16b,v14.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v14.16b, #7
    USHR v22.16b,v14.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v13.16b,v23.16b,v13.16b
    

                  //19-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///19-round
    //F Function
    shl v21.16b,v13.16b, #3
    USHR v22.16b,v13.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v13.16b, #4
    USHR v22.16b,v13.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v13.16b, #6
    USHR v22.16b,v13.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v12.16b,v23.16b,v12.16b
    // clear 
    shl v21.16b,v19.16b, #1
    USHR v22.16b,v19.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #2
    USHR v22.16b,v19.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #7
    USHR v22.16b,v19.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v18.16b,v23.16b,v18.16b
    //clear
    shl v21.16b,v17.16b, #3
    USHR v22.16b,v17.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v17.16b, #4
    USHR v22.16b,v17.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v17.16b, #6
    USHR v22.16b,v17.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v16.16b,v23.16b,v16.16b
    //clear
    shl v21.16b,v15.16b, #1
    USHR v22.16b,v15.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v15.16b, #2
    USHR v22.16b,v15.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v15.16b, #7
    USHR v22.16b,v15.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v14.16b,v23.16b,v14.16b

                     //20-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///20-round
    //F Function
    shl v21.16b,v14.16b, #3
    USHR v22.16b,v14.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v14.16b, #4
    USHR v22.16b,v14.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v14.16b, #6
    USHR v22.16b,v14.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v13.16b,v23.16b,v13.16b
    // clear 
    shl v21.16b,v12.16b, #1
    USHR v22.16b,v12.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v12.16b, #2
    USHR v22.16b,v12.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v12.16b, #7
    USHR v22.16b,v12.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v19.16b,v23.16b,v19.16b
    //clear
    shl v21.16b,v18.16b, #3
    USHR v22.16b,v18.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v18.16b, #4
    USHR v22.16b,v18.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v18.16b, #6
    USHR v22.16b,v18.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v17.16b,v23.16b,v17.16b
    //clear
    shl v21.16b,v16.16b, #1
    USHR v22.16b,v16.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v16.16b, #2
    USHR v22.16b,v16.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v16.16b, #7
    USHR v22.16b,v16.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v15.16b,v23.16b,v15.16b


                         //21-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///21-round
    //F Function
    shl v21.16b,v15.16b, #3
    USHR v22.16b,v15.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v15.16b, #4
    USHR v22.16b,v15.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v15.16b, #6
    USHR v22.16b,v15.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v14.16b,v23.16b,v14.16b
    // clear 
    shl v21.16b,v13.16b, #1
    USHR v22.16b,v13.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v13.16b, #2
    USHR v22.16b,v13.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v13.16b, #7
    USHR v22.16b,v13.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v12.16b,v23.16b,v12.16b
    //clear
    shl v21.16b,v19.16b, #3
    USHR v22.16b,v19.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #4
    USHR v22.16b,v19.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #6
    USHR v22.16b,v19.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v18.16b,v23.16b,v18.16b
    //clear
    shl v21.16b,v17.16b, #1
    USHR v22.16b,v17.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v17.16b, #2
    USHR v22.16b,v17.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v17.16b, #7
    USHR v22.16b,v17.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v16.16b,v23.16b,v16.16b

                           //22-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///22-round
    //F Function
    shl v21.16b,v16.16b, #3
    USHR v22.16b,v16.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v16.16b, #4
    USHR v22.16b,v16.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v16.16b, #6
    USHR v22.16b,v16.16b, #2   
    eor v24.16b,v21.16b,v22.16b    
    eor v23.16b,v24.16b,v23.16b 
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v15.16b,v23.16b,v15.16b
    // clear 
    shl v21.16b,v14.16b, #1
    USHR v22.16b,v14.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v14.16b, #2
    USHR v22.16b,v14.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v14.16b, #7
    USHR v22.16b,v14.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v13.16b,v23.16b,v13.16b
    //clear
    shl v21.16b,v12.16b, #3
    USHR v22.16b,v12.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v12.16b, #4
    USHR v22.16b,v12.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v12.16b, #6
    USHR v22.16b,v12.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v19.16b,v23.16b,v19.16b
    //clear
    shl v21.16b,v18.16b, #1
    USHR v22.16b,v18.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v18.16b, #2
    USHR v22.16b,v18.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v18.16b, #7
    USHR v22.16b,v18.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v17.16b,v23.16b,v17.16b

    //OKAY
                               //23-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///23-round
    //F Function
    shl v21.16b,v17.16b, #3
    USHR v22.16b,v17.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v17.16b, #4
    USHR v22.16b,v17.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v17.16b, #6
    USHR v22.16b,v17.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v16.16b,v23.16b,v16.16b
    // clear 
    shl v21.16b,v15.16b, #1
    USHR v22.16b,v15.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v15.16b, #2
    USHR v22.16b,v15.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v15.16b, #7
    USHR v22.16b,v15.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v14.16b,v23.16b,v14.16b
    //clear
    shl v21.16b,v13.16b, #3
    USHR v22.16b,v13.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v13.16b, #4
    USHR v22.16b,v13.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v13.16b, #6
    USHR v22.16b,v13.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v12.16b,v23.16b,v12.16b
    //clear
    shl v21.16b,v19.16b, #1
    USHR v22.16b,v19.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #2
    USHR v22.16b,v19.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #7
    USHR v22.16b,v19.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v18.16b,v23.16b,v18.16b
                                   //24-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///24-round
    //F Function
    shl v21.16b,v18.16b, #3
    USHR v22.16b,v18.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v18.16b, #4
    USHR v22.16b,v18.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v18.16b, #6
    USHR v22.16b,v18.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v17.16b,v23.16b,v17.16b
    // clear 
    shl v21.16b,v16.16b, #1
    USHR v22.16b,v16.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v16.16b, #2
    USHR v22.16b,v16.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v16.16b, #7
    USHR v22.16b,v16.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v15.16b,v23.16b,v15.16b
    //clear
    shl v21.16b,v14.16b, #3
    USHR v22.16b,v14.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v14.16b, #4
    USHR v22.16b,v14.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v14.16b, #6
    USHR v22.16b,v14.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v13.16b,v23.16b,v13.16b
    //clear
    shl v21.16b,v12.16b, #1
    USHR v22.16b,v12.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v12.16b, #2
    USHR v22.16b,v12.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v12.16b, #7
    USHR v22.16b,v12.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v19.16b,v23.16b,v19.16b

                                       //25-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///25-round
    //F Function
    shl v21.16b,v19.16b, #3
    USHR v22.16b,v19.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #4
    USHR v22.16b,v19.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #6
    USHR v22.16b,v19.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v18.16b,v23.16b,v18.16b
    // clear 
    shl v21.16b,v17.16b, #1
    USHR v22.16b,v17.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v17.16b, #2
    USHR v22.16b,v17.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v17.16b, #7
    USHR v22.16b,v17.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v16.16b,v23.16b,v16.16b
    //clear
    shl v21.16b,v15.16b, #3
    USHR v22.16b,v15.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v15.16b, #4
    USHR v22.16b,v15.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v15.16b, #6
    USHR v22.16b,v15.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v14.16b,v23.16b,v14.16b
    //clear
    shl v21.16b,v13.16b, #1
    USHR v22.16b,v13.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v13.16b, #2
    USHR v22.16b,v13.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v13.16b, #7
    USHR v22.16b,v13.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v12.16b,v23.16b,v12.16b
    //OKAY

    //26-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///26-round
    //F Function
    shl v21.16b,v12.16b, #3
    USHR v22.16b,v12.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v12.16b, #4
    USHR v22.16b,v12.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v12.16b, #6
    USHR v22.16b,v12.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v19.16b,v23.16b,v19.16b
    // clear 
    shl v21.16b,v18.16b, #1
    USHR v22.16b,v18.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v18.16b, #2
    USHR v22.16b,v18.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v18.16b, #7
    USHR v22.16b,v18.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v17.16b,v23.16b,v17.16b
    //clear
    shl v21.16b,v16.16b, #3
    USHR v22.16b,v16.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v16.16b, #4
    USHR v22.16b,v16.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v16.16b, #6
    USHR v22.16b,v16.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v15.16b,v23.16b,v15.16b
    //clear
    shl v21.16b,v14.16b, #1
    USHR v22.16b,v14.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v14.16b, #2
    USHR v22.16b,v14.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v14.16b, #7
    USHR v22.16b,v14.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v13.16b,v23.16b,v13.16b

        //27-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///27-round
    //F Function
    shl v21.16b,v13.16b, #3
    USHR v22.16b,v13.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v13.16b, #4
    USHR v22.16b,v13.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v13.16b, #6
    USHR v22.16b,v13.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v12.16b,v23.16b,v12.16b
    // clear 
    shl v21.16b,v19.16b, #1
    USHR v22.16b,v19.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #2
    USHR v22.16b,v19.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #7
    USHR v22.16b,v19.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v18.16b,v23.16b,v18.16b
    //clear
    shl v21.16b,v17.16b, #3
    USHR v22.16b,v17.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v17.16b, #4
    USHR v22.16b,v17.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v17.16b, #6
    USHR v22.16b,v17.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v16.16b,v23.16b,v16.16b
    //clear
    shl v21.16b,v15.16b, #1
    USHR v22.16b,v15.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v15.16b, #2
    USHR v22.16b,v15.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v15.16b, #7
    USHR v22.16b,v15.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v14.16b,v23.16b,v14.16b
    //OKAY
            //28-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///28-round
    //F Function
    shl v21.16b,v14.16b, #3
    USHR v22.16b,v14.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v14.16b, #4
    USHR v22.16b,v14.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v14.16b, #6
    USHR v22.16b,v14.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v13.16b,v23.16b,v13.16b
    // clear 
    shl v21.16b,v12.16b, #1
    USHR v22.16b,v12.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v12.16b, #2
    USHR v22.16b,v12.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v12.16b, #7
    USHR v22.16b,v12.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v19.16b,v23.16b,v19.16b
    //clear
    shl v21.16b,v18.16b, #3
    USHR v22.16b,v18.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v18.16b, #4
    USHR v22.16b,v18.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v18.16b, #6
    USHR v22.16b,v18.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v17.16b,v23.16b,v17.16b
    //clear
    shl v21.16b,v16.16b, #1
    USHR v22.16b,v16.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v16.16b, #2
    USHR v22.16b,v16.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v16.16b, #7
    USHR v22.16b,v16.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v15.16b,v23.16b,v15.16b
           //29-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///29-round
    //F Function
    shl v21.16b,v15.16b, #3
    USHR v22.16b,v15.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v15.16b, #4
    USHR v22.16b,v15.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v15.16b, #6
    USHR v22.16b,v15.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v14.16b,v23.16b,v14.16b
    // clear 
    shl v21.16b,v13.16b, #1
    USHR v22.16b,v13.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v13.16b, #2
    USHR v22.16b,v13.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v13.16b, #7
    USHR v22.16b,v13.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v12.16b,v23.16b,v12.16b
    //clear
    shl v21.16b,v19.16b, #3
    USHR v22.16b,v19.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #4
    USHR v22.16b,v19.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #6
    USHR v22.16b,v19.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v18.16b,v23.16b,v18.16b
    //clear
    shl v21.16b,v17.16b, #1
    USHR v22.16b,v17.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v17.16b, #2
    USHR v22.16b,v17.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v17.16b, #7
    USHR v22.16b,v17.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v16.16b,v23.16b,v16.16b

              //30-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///30-round
    //F Function
    shl v21.16b,v16.16b, #3
    USHR v22.16b,v16.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v16.16b, #4
    USHR v22.16b,v16.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v16.16b, #6
    USHR v22.16b,v16.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v15.16b,v23.16b,v15.16b
    // clear 
    shl v21.16b,v14.16b, #1
    USHR v22.16b,v14.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v14.16b, #2
    USHR v22.16b,v14.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v14.16b, #7
    USHR v22.16b,v14.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v13.16b,v23.16b,v13.16b
    //clear
    shl v21.16b,v12.16b, #3
    USHR v22.16b,v12.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v12.16b, #4
    USHR v22.16b,v12.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v12.16b, #6
    USHR v22.16b,v12.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v19.16b,v23.16b,v19.16b
    //clear
    shl v21.16b,v18.16b, #1
    USHR v22.16b,v18.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v18.16b, #2
    USHR v22.16b,v18.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v18.16b, #7
    USHR v22.16b,v18.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v17.16b,v23.16b,v17.16b
    
                  //31-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///31-round
    //F Function
    shl v21.16b,v17.16b, #3
    USHR v22.16b,v17.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v17.16b, #4
    USHR v22.16b,v17.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v17.16b, #6
    USHR v22.16b,v17.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v16.16b,v23.16b,v16.16b
    // clear 
    shl v21.16b,v15.16b, #1
    USHR v22.16b,v15.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v15.16b, #2
    USHR v22.16b,v15.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v15.16b, #7
    USHR v22.16b,v15.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v14.16b,v23.16b,v14.16b
    //clear
    shl v21.16b,v13.16b, #3
    USHR v22.16b,v13.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v13.16b, #4
    USHR v22.16b,v13.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v13.16b, #6
    USHR v22.16b,v13.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v12.16b,v23.16b,v12.16b
    //clear
    shl v21.16b,v19.16b, #1
    USHR v22.16b,v19.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #2
    USHR v22.16b,v19.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #7
    USHR v22.16b,v19.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v18.16b,v23.16b,v18.16b

    //32-Round
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    ///32-round
    //F Function
    shl v21.16b,v18.16b, #3
    USHR v22.16b,v18.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v18.16b, #4
    USHR v22.16b,v18.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v18.16b, #6
    USHR v22.16b,v18.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v0.16b
    add v17.16b,v23.16b,v17.16b
    // clear 
    shl v21.16b,v16.16b, #1
    USHR v22.16b,v16.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v16.16b, #2
    USHR v22.16b,v16.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v16.16b, #7
    USHR v22.16b,v16.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey Addtion
    add v23.16b,v23.16b,v1.16b
    eor v15.16b,v23.16b,v15.16b
    //clear
    shl v21.16b,v14.16b, #3
    USHR v22.16b,v14.16b, #5   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v14.16b, #4
    USHR v22.16b,v14.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v14.16b, #6
    USHR v22.16b,v14.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    eor v23.16b,v23.16b,v2.16b
    add v13.16b,v23.16b,v13.16b
    //clear
    shl v21.16b,v12.16b, #1
    USHR v22.16b,v12.16b, #7   
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v12.16b, #2
    USHR v22.16b,v12.16b, #6   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v12.16b, #7
    USHR v22.16b,v12.16b, #1   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b
    //RoundKey
    
    add v23.16b,v23.16b,v3.16b
    eor v19.16b,v23.16b,v19.16b
    //initial
    LDR w4,[x2],#4
    DUP v0.16b,w4
    LSR w4,w4,#8
    DUP v1.16b,w4
    LSR w4,w4,#8
    DUP v2.16b,w4
    LSR w4,w4,#8
    DUP v3.16b,w4

    add v18.16b,v18.16b,v3.16b // v0 
    eor v16.16b,v16.16b,v2.16b
    add v14.16b,v14.16b,v1.16b
    eor v12.16b,v12.16b,v0.16b
    //finish
    //transposed 
    //trn1 v0.16b,v19.16b,v12.16b
    LDR x3,=vector2
    LD1 {v8.16b},[x3]
    
    TBL v20.16b,{v19.16b},v8.16b
    TBL v21.16b,{v15.16b},v8.16b
    Trn1 v0.16b,v20.16b,v21.16b

    TBL v20.16b,{v12.16b},v8.16b
    TBL v21.16b,{v16.16b},v8.16b
    Trn1 v1.16b,v20.16b,v21.16b

    TBL v20.16b,{v13.16b},v8.16b
    TBL v21.16b,{v17.16b},v8.16b
    Trn1 v2.16b,v20.16b,v21.16b

    TBL v20.16b,{v14.16b},v8.16b
    TBL v21.16b,{v18.16b},v8.16b
    Trn1 v3.16b,v20.16b,v21.16b

    LDR x3,=vector3
    LD1 {v8.16b},[x3]

    TBL v20.16b,{v19.16b},v8.16b
    TBL v21.16b,{v15.16b},v8.16b
    Trn1 v4.16b,v20.16b,v21.16b

    TBL v20.16b,{v12.16b},v8.16b
    TBL v21.16b,{v16.16b},v8.16b
    Trn1 v5.16b,v20.16b,v21.16b

    TBL v20.16b,{v13.16b},v8.16b
    TBL v21.16b,{v17.16b},v8.16b
    Trn1 v6.16b,v20.16b,v21.16b

    TBL v20.16b,{v14.16b},v8.16b
    TBL v21.16b,{v18.16b},v8.16b
    Trn1 v7.16b,v20.16b,v21.16b
   
    st4 {v0.16b-v3.16b},[x0],#64
    st4 {v4.16b-v7.16b},[x0]

    ret



F_Function_M4:
    AND w11,w2, #0x00FF00FF
    LSL x10,x11,#1
    EOR x10,x10,x11,LSR #7
    EOR x10,x10,x11,LSL #2
    EOR x10,x10,x11,LSR #6
    EOR x10,x10,x11,LSL #7
    EOR x10,x10,x11,LSR #1
    AND w6,w10,#0x00ff00ff

    AND w11,w2, #0x00FF00FF
    LSL x10,x11,#1
    EOR x10,x10,x11,LSR #7
    EOR x10,x10,x11,LSL #2
    EOR x10,x10,x11,LSR #6
    EOR x10,x10,x11,LSL #7
    EOR x10,x10,x11,LSR #1
    AND w6,w10,#0x00ff00ff
    ORR x10,x10,x10

    AND w11,w2, #0x00FF00FF
    LSL x10,x11,#1
    EOR x10,x10,x11,LSR #7
    EOR x10,x10,x11,LSL #2
    EOR x10,x10,x11,LSR #6
    EOR x10,x10,x11,LSL #7
    EOR x10,x10,x11,LSR #1
    AND w6,w10,#0x00ff00ff

    AND w11,w2, #0x00FF00FF
    LSL x10,x11,#1
    EOR x10,x10,x11,LSR #7
    EOR x10,x10,x11,LSL #2
    EOR x10,x10,x11,LSR #6
    EOR x10,x10,x11,LSL #7
    EOR x10,x10,x11,LSR #1
    AND w6,w10,#0x00ff00ff
    ORR x10,x10,x10

    AND w11,w2, #0x00FF00FF
    LSL x10,x11,#1
    EOR x10,x10,x11,LSR #7
    EOR x10,x10,x11,LSL #2
    EOR x10,x10,x11,LSR #6
    EOR x10,x10,x11,LSL #7
    EOR x10,x10,x11,LSR #1
    AND w6,w10,#0x00ff00ff

    AND w11,w2, #0x00FF00FF
    LSL x10,x11,#1
    EOR x10,x10,x11,LSR #7
    EOR x10,x10,x11,LSL #2
    EOR x10,x10,x11,LSR #6
    EOR x10,x10,x11,LSL #7
    EOR x10,x10,x11,LSR #1
    AND w6,w10,#0x00ff00ff
    ORR x10,x10,x10

    AND w11,w2, #0x00FF00FF
    LSL x10,x11,#1
    EOR x10,x10,x11,LSR #7
    EOR x10,x10,x11,LSL #2
    EOR x10,x10,x11,LSR #6
    EOR x10,x10,x11,LSL #7
    EOR x10,x10,x11,LSR #1
    AND w6,w10,#0x00ff00ff

    AND w11,w2, #0x00FF00FF
    LSL x10,x11,#1
    EOR x10,x10,x11,LSR #7
    EOR x10,x10,x11,LSL #2
    EOR x10,x10,x11,LSR #6
    EOR x10,x10,x11,LSL #7
    EOR x10,x10,x11,LSR #1
    AND w6,w10,#0x00ff00ff
    ORR x10,x10,x10
   
    ret
//16
F_Function_ARMv8:
    shl v21.16b,v19.16b, #3
    USHR v22.16b,v19.16b, #5  
    eor v23.16b,v21.16b,v22.16b

    shl v21.16b,v19.16b, #4
    USHR v22.16b,v19.16b, #4   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b

    shl v21.16b,v19.16b, #6
    USHR v22.16b,v19.16b, #2   
    eor v24.16b,v21.16b,v22.16b

    eor v23.16b,v24.16b,v23.16b


    ret

