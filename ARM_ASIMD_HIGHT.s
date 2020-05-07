.data
vector: .Byte 0,2,4,6,8,10,12,14,1,3,5,7,9,11,13,15
vector2: .Byte 0,8,1,9,2,10,3,11,4,12,5,13,6,14,7,15
vector3: .Byte 8,7,9,0,10,1,11,2,12,3,13,4,14,5,15,6

.text
    .global HIGHT_encrypt
    .global F_Function_M4
    .global F_Function_ARMv8
    .global add_xor
add_xor:
    add v23.16b,v23.16b,v1.16b
    eor v16.16b,v23.16b,v16.16b
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
    ret

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