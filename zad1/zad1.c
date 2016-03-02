#include <stdio.h>

#define LEAD_BIT 8

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
    int bufor_liczb[12];
    int cyfry[12];
    int cyferki;
    long int binarki;
    long int binarne[12];
    for (j = 0; j < 12; j++) cyfry[j] = 0;            // czyszczenie tablicy
    for (j = 0; j < 12; j++) binarne[j] = 0;            // czyszczenie tablicy

    long liczba_plik_binarna = 0;

    for (j = 0; j < 12; j++) {                        // wczytywanie liczb z pliku do tablicy
      fscanf(plik, "%i", &cyferki);
      printf("%d\t ", cyferki);
      toBinary(cyferki);
    }

    fclose(plik);
  }
}

void toBinary(long decimal_number)                    // zamiana na binarne
{
  int i;

  for(i = 0; i < LEAD_BIT; i++)
  {
    printf("%ld", (decimal_number >> (LEAD_BIT - (i + 1))) & 0x1);
  }
  printf("\n");
}
