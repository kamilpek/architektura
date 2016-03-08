// Zamana liczb zmiennoprzecinkowych na kod IEEE 754
// Autor: Kamil Pek 231050. Data: 08.03.2016.

#include <stdio.h>

void kodowanie_32(float f)                                  // zamiana na kod IEEE 754
{
  FILE *wynik = NULL;
  wynik = fopen("wynik.txt", "a");
  fprintf(wynik, "%f\t", f);
  unsigned cher;
  int i;
  unsigned mask = 1<<31 ;

  cher =*(unsigned*)&f;
  for (i=0;i<32;i++)
  	{
    fputc((mask & cher? '1' : '0' ), wynik);
  	cher <<=1;
  	}
  fprintf(wynik, "\n");
}

int main(){
  FILE *plik = NULL;
  plik = fopen("plik.txt", "r");                           // otwarcie pliku tekstowego w trybie czytania

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
        printf("W pliku znajduja sie nie dozwolone znaki, prosze popraw to.\n");
        printf("Koncze dzialanie programu.\n\n");
        break;
      }
      kodowanie_32(liczby);
      liczby = 0;
    }
    fclose(plik);                                          // zamykanie pliku
  }
  return 0;
}
