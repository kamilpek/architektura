#include <stdio.h>

#define liczba_bitow 32

void toBinary(long);

int main(){
  FILE *plik = NULL;
  plik = fopen("plik.txt", "r");                         // otwarcie pliku tekstowego w trybie czytania

  if (plik == NULL){                                     // sprawdzanie istnienia pliku
    printf("Otwarcie pliku się nie powiodło!\n");
    return 1;
  }
  else {
    int j;
    int cyfry;

    for (j = 0; j < 12; j++) {                        // wczytywanie liczb z pliku do tablicy
      fscanf(plik, "%i", &cyfry);
      printf("%d\t ", cyfry);
      toBinary(cyfry);
    }
    fclose(plik);
  }
}

void toBinary(long liczba_dziesietna)                    // zamiana na binarne
{
  int i;

  for(i = 0; i < liczba_bitow; i++)
  {
    printf("%ld", (liczba_dziesietna >> (liczba_bitow - (i + 1))) & 0x1);
  }
  printf("\n");
}
