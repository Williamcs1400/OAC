#include <stdio.h>

int main(){
    int i, cont = 0, var = 0x10040000;

    for(i = 0; i < 4096; i++){
        printf("%x ", var);
        var += 4;
        cont++;
        if(cont == 64){
            printf("\n");
            cont = 0;
        }
    }
    return 0;
}
