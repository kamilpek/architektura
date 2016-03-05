// Zamana liczb zmiennoprzecinkowych na kod IEEE 754
// Autor: Kamil Pek 231050. Data: 04.03.2016.

#include <stdio.h>
#define liczba_bitow 32                                    // definicja liczby bitow dla funkcji toBinary

void kodowanie(int liczba_dziesietna)                      // zamiana na kod U2(32-bitowy)
{
  FILE *wynik = NULL;
  wynik = fopen("wynik.txt", "a");
  int i;
  for(i = 0; i < liczba_bitow; i++) {
    fprintf(wynik, "%d", (liczba_dziesietna >> (liczba_bitow - (i + 1))) & 1);
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
      kodowanie(liczby);
      liczby = 0;
    }
    fclose(plik);                                          // zamykanie pliku
  }
  return 0;
}
