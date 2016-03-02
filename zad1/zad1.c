#include <stdio.h>
#define liczba_bitow 32                                  // definicja liczby bitow dla funkcji toBinary

void toBinary(long);                                     // deklaracja funkcji toBinary

int main(){
  FILE *plik = NULL;
  plik = fopen("plik.txt", "r");                         // otwarcie pliku tekstowego w trybie czytania

  if (plik == NULL){                                     // sprawdzanie istnienia pliku
    printf("Otwarcie pliku się nie powiodło!\n");
    return 1;
  }
  else {
    int j;
    int cyfry = 0;
    for (j = 0; j < 12; j++) {
      fscanf(plik, "%i", &cyfry);                         // wczytywanie liczb z pliku do tablicy "cyfry"
      if(!cyfry) {                                        // obsluga niedozwolonych znakow
        printf("W pliku znajduja sie nie dozwolone znaki, prosze popraw to.\n");
        printf("Koncze dzialanie programu.\n\n");
        break;
      }
      printf("%d\t ", cyfry);
      toBinary(cyfry);
      cyfry = 0;
    }
    fclose(plik);                                         // zamykanie pliku
  }
  return 0;
}

void toBinary(long liczba_dziesietna)                     // zamiana na kod U2(32-bitowy)
{
  int i;
  for(i = 0; i < liczba_bitow; i++) printf("%ld", (liczba_dziesietna >> (liczba_bitow - (i + 1))) & 0x1);
  printf("\n");
}
