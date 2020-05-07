#include<stdio.h>
#include<time.h>
#include<string.h>
#include<stdint.h>
#include<sys/time.h>
#include<unistd.h>
void add_xor(unsigned char* PT);
void HIGHT_encrypt(unsigned char* PT, unsigned char* CT, unsigned char* K);
void F_Function_M4(unsigned char* state);
void F_Function_ARMv8(unsigned char* state);
void getElapsedTime(struct timeval Tstart, struct timeval Tend) {
	Tend.tv_usec = Tend.tv_usec - Tstart.tv_usec;
	Tend.tv_sec = Tend.tv_sec - Tstart.tv_sec;
	Tend.tv_usec += (Tend.tv_sec * 1000000);

	printf("Elapsed Time : %lf sec\n", Tend.tv_usec / 1000000.0);
}
int main() {
	unsigned char state[128] = { 0,0,0,0,0,0,0,0,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x01,0x23,0x45,0x67,0x89,0xab,0xcd,0xef,0xb4,0x1e,0x6b,0xe2,0xeb,0xa8,0x4a,0x14,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0xa1,0xa2,0xa3,0xa4,0xa5,0xa6,0xa7,0xa8,0xb1,0xb2,0xb3,0xb4,0xb5,0xb6,0xb7,0xb8,0xc1,0xc2,0xc3,0xc4,0xc5,0xc6,0xc7,0xc8 };

	unsigned char state3[128] = { 0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77 };
	unsigned char state2[128] = { 0x00, };
	unsigned char state4[128] = { 0x00, };
	unsigned char KEY[136] = { 0xff,0xee,0xdd,0xcc,0x5a,0x7e,0x58,0x4e,0x51,0x5b,0x69,0xb8,0xe8,0xc9,0xc2,0x07,0x32,0x10,0x47,0x2b,0xcd,0x2b,0x26,0x6c,0x98,0xb6,0x8e,0x82,0x4d,0xef,0x0c,0x23,0xf7,0x2a,0x4c,0x25,0xc1,0xa4,0x16,0x1c,0x27,0x75,0x65,0xa5,0x16,0x53,0xb2,0xee,0x14,0x30,0x46,0x5a,0x93,0xc5,0xa6,0x17,0x5c,0x47,0x85,0x6d,0xf1,0xf8,0x44,0xea,0xca,0x02,0x27,0x42,0x7f,0x72,0x74,0xbe,0x63,0x82,0x9a,0xaf,0x4a,0x5c,0x2d,0x1e,0x97,0xa0,0xed,0x1c,0xa3,0x7c,0xb1,0xd4,0xee,0x7b,0x4e,0x40,0x0a,0xf3,0x30,0x57,0x33,0xa2,0xe6,0xd0,0x35,0x7c,0x68,0x67,0x6f,0x7b,0x02,0x12,0xea,0xdb,0xdc,0xe5,0x32,0x21,0x99,0xe1,0x75,0x54,0x4c,0x50,0x9b,0x89,0xc8,0x68,0x0d,0xe4,0x18,0xfa,0x34,0x59,0x34,0xe2,0x33,0x22,0x11,0x00 };
	int cnt_i = 0;
	unsigned char pdwRoundKey[136] = { 0, };																									// Round keys for encryption or decryption
	unsigned char pbUserKey[16] = { 0x88, 0xE3, 0x4F, 0x8F, 0x08, 0x17, 0x79, 0xF1, 0xE9, 0xF3, 0x94, 0x37, 0x0A, 0xD4, 0x05, 0x89 }; 		// User secret key
	unsigned char pbData[8] = { 0xD7, 0x6D, 0x0D,0x18, 0x32, 0x7E, 0xC5, 0x62 };
	clock_t start = 0, end = 0;
	double result;
	double total = 0;

	unsigned long long ts = 0;
	unsigned long long te = 0;
	unsigned long time1 = 0;
	struct timeval Tstart, Tend;

	while (cnt_i < 100) {
		start = clock();
		F_Function_M4(state);

		end = clock();

		cnt_i++;
		result = (double)(end - start);
		total += result;
	}
	printf("SIMD HIGHT F0 Function= ");
	printf("%lf\n", total / 100 / CLOCKS_PER_SEC);
	cnt_i = 0;
	total = 0;


	while (cnt_i < 100) {
		start = clock();
		F_Function_ARMv8(state);
		end = clock();
		cnt_i++;
		result = (double)(end - start);
		total += result;
	}
	printf("ASIMD HIGHT F0 Function= ");
	printf("%lf\n", total / 100 / CLOCKS_PER_SEC);
	cnt_i = 0;






	/*

	 while(cnt_i<100000){
		start=clock();
		HIGHT_Encrypt_2( pdwRoundKey, pbData );
		end=clock();
		cnt_i++;
		result=(double)(end-start);
		total+=result;
		}
		printf("C1 HIGHT= ");
		printf("%f\n",total/100000);

		total=0;
		cnt_i=0;
		while(cnt_i<100000){
		start=clock();
		HIGHT_Encrypt( pdwRoundKey, pbData );
		HIGHT_Encrypt( pdwRoundKey, pbData );
		HIGHT_Encrypt( pdwRoundKey, pbData );
		HIGHT_Encrypt( pdwRoundKey, pbData );
		HIGHT_Encrypt( pdwRoundKey, pbData );
		HIGHT_Encrypt( pdwRoundKey, pbData );
		HIGHT_Encrypt( pdwRoundKey, pbData );
		HIGHT_Encrypt( pdwRoundKey, pbData );
		HIGHT_Encrypt( pdwRoundKey, pbData );
		HIGHT_Encrypt( pdwRoundKey, pbData );
		HIGHT_Encrypt( pdwRoundKey, pbData );
		HIGHT_Encrypt( pdwRoundKey, pbData );
		HIGHT_Encrypt( pdwRoundKey, pbData );
		HIGHT_Encrypt( pdwRoundKey, pbData );
		HIGHT_Encrypt( pdwRoundKey, pbData );
		HIGHT_Encrypt( pdwRoundKey, pbData );

		end=clock();
	cnt_i++;
		result=(double)(end-start);
		total+=result;
		}
		printf("C2 HIGHT= ");
		printf("%f\n",total/100000);
		cnt_i=0;
		total=0;

		while(cnt_i<100000){
		start=clock();
		HIGHT_encrypt(state2,state4,KEY);
		end=clock();
	cnt_i++;
		result=(double)(end-start);
		total+=result;
		}
		printf("ASIMD HIGHT= ");
		printf("%f\n",total/100000);
		printf("========HIGHT PT======\n");
		printf("ASIMD HIGHT PT1 : ");
		for(cnt_i=0;cnt_i<8;cnt_i++){
			printf("%X ",state3[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT PT2 : ");
		for(cnt_i=8;cnt_i<16;cnt_i++){
			printf("%X ",state3[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT PT3 : ");
		for(cnt_i=16;cnt_i<24;cnt_i++){
			printf("%X ",state3[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT PT4 : ");
		for(cnt_i=24;cnt_i<32;cnt_i++){
			printf("%X ",state3[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT PT5 : ");
		for(cnt_i=32;cnt_i<40;cnt_i++){
			printf("%X ",state3[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT PT6 : ");
		for(cnt_i=40;cnt_i<48;cnt_i++){
			printf("%X ",state3[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT PT7 : ");
		for(cnt_i=48;cnt_i<56;cnt_i++){
			printf("%X ",state3[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT PT8 : ");
		for(cnt_i=56;cnt_i<64;cnt_i++){
			printf("%X ",state3[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT PT9 : ");
		for(cnt_i=64;cnt_i<72;cnt_i++){
			printf("%X ",state3[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT PT10 : ");
		for(cnt_i=72;cnt_i<80;cnt_i++){
			printf("%X ",state3[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT PT11 : ");
		for(cnt_i=80;cnt_i<88;cnt_i++){
			printf("%X ",state3[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT PT12 : ");
		for(cnt_i=88;cnt_i<96;cnt_i++){
			printf("%X ",state3[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT PT13 : ");
		for(cnt_i=96;cnt_i<104;cnt_i++){
			printf("%X ",state3[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT PT14 : ");
		for(cnt_i=104;cnt_i<112;cnt_i++){
			printf("%X ",state3[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT PT15 : ");
		for(cnt_i=112;cnt_i<120;cnt_i++){
			printf("%X ",state3[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT PT16 : ");
		for(cnt_i=120;cnt_i<128;cnt_i++){
			printf("%X ",state3[cnt_i]);
		}printf("\n");

		HIGHT_encrypt(state4,state3,KEY);
		printf("========HIGHT CT======\n");
		printf("ASIMD HIGHT CT1 : ");
		for(cnt_i=0;cnt_i<8;cnt_i++){
			printf("%X ",state4[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT CT2 : ");
		for(cnt_i=8;cnt_i<16;cnt_i++){
			printf("%X ",state4[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT CT3 : ");
		for(cnt_i=16;cnt_i<24;cnt_i++){
			printf("%X ",state4[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT CT4 : ");
		for(cnt_i=24;cnt_i<32;cnt_i++){
			printf("%X ",state4[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT CT5 : ");
		for(cnt_i=32;cnt_i<40;cnt_i++){
			printf("%X ",state4[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT CT6 : ");
		for(cnt_i=40;cnt_i<48;cnt_i++){
			printf("%X ",state4[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT CT7 : ");
		for(cnt_i=48;cnt_i<56;cnt_i++){
			printf("%X ",state4[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT CT8 : ");
		for(cnt_i=56;cnt_i<64;cnt_i++){
			printf("%X ",state4[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT CT9 : ");
		for(cnt_i=64;cnt_i<72;cnt_i++){
			printf("%X ",state4[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT CT10 : ");
		for(cnt_i=72;cnt_i<80;cnt_i++){
			printf("%X ",state4[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT CT11 : ");
		for(cnt_i=80;cnt_i<88;cnt_i++){
			printf("%X ",state4[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT CT12 : ");
		for(cnt_i=88;cnt_i<96;cnt_i++){
			printf("%X ",state4[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT CT13 : ");
		for(cnt_i=96;cnt_i<104;cnt_i++){
			printf("%X ",state4[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT CT14 : ");
		for(cnt_i=104;cnt_i<112;cnt_i++){
			printf("%X ",state4[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT CT15 : ");
		for(cnt_i=112;cnt_i<120;cnt_i++){
			printf("%X ",state4[cnt_i]);
		}printf("\n");
		printf("ASIMD HIGHT CT16 : ");
		for(cnt_i=120;cnt_i<128;cnt_i++){
			printf("%X ",state4[cnt_i]);
		}printf("\n");
		*/
	return 0;
}