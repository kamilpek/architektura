// Zamana liczb zmiennoprzecinkowych na kod IEEE 754
// Autor: Kamil Pek 231050. Data: 10.03.2016.

#include <stdio.h>
#include <stdlib.h>

void kodowanie_32(float f, char argument[])                                  // zamiana na kod IEEE 754
{
  FILE *wynik = NULL;
  wynik = fopen(argument, "a");
  fprintf(wynik, "%f\t", f);
  int i;
  unsigned a =*(unsigned*)&f;
  unsigned b = 1<<31 ;
  for (i=0;i<32;i++)
  	{
    fputc((a & b? '1' : '0' ), wynik);
  	a <<= 1;
  	}
  fprintf(wynik, "\n");
}

int main(int argc, char *argv[]){
  FILE *plik = NULL;
  plik = fopen(argv[1], "r");                              // otwarcie pliku tekstowego w trybie czytania

  if (plik == NULL){                                       // sprawdzanie istnienia pliku
    printf("Otwarcie pliku sie nie powiodlo!\n");
    return 1;
  }
  else {
    int j;
    float liczby = 0;
    while(1) {                                             // wieczny while
      fscanf(plik, "%f", &liczby);                         // wczytywanie liczb z pliku do tablicy "cyfry"
      if(feof(plik) != 0) break;                           // konczenie petli jak skonczy sie zawartosc pliku
      if(!liczby) {                                        // obsluga niedozwolonych znakow
        printf("W pliku znajduja sie nie dozwolone znaki, prosze popraw to.\n Koncze dzialanie programu.\n");
        break;
      }
      int argument = atoi(argv[2]);
      if(argument == 32) kodowanie_32(liczby, argv[3]);
      else if (argument == 64) printf ("Pracujemy nad tym\n");
      else printf("Prosze podac prawidlowe parametry");
      }
      liczby = 0;
    }
    fclose(plik);                                          // zamykanie pliku
  return 0;
}
