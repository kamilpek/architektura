// Zamiana liczb zmiennoprzecinkowych na ich kod IEEE 754.
// Autor: Kamil Pek 231050. Data: 10.03.2016.

#include <stdio.h>
#include <stdlib.h>                                       // dodanie tej biblioteki umowzliwia skorzystanie z funkcji 'atoi'

void kodowanie_32(float f, char argument[])               // zamiana na kod IEEE 754
{
  FILE *wynik = NULL;
  wynik = fopen(argument, "a");                           // otwarcie pliku tekstowego w trybie zapisu
  fprintf(wynik, "%f\t", f);                              // dodanie na poczatku linii liczby dziesietnej
  int i;
  unsigned a =*(unsigned*)&f;                             // przypisanie wartosci warunku AND z floatem z rzutowanie na int bez znaku
  unsigned b = 1 << 31;                                   // przesuniecie bitowe w lewo o 31
  for (i=0;i<32;i++)                                      // petla wypisujaca do pliku
  	{
    fputc((a & b? '1' : '0' ), wynik);                    // 'potrojny if', jesli and = 0 to wypiszy 1 inaczej wypisz 0
  	a <<= 1;                                              // przesuniecie bitowe w lewo o jeden
  	}
  fprintf(wynik, "\n");                                   // dodanie na koniec linii, znaku konca linii
}

int main(int argc, char *argv[]){                         // przyjecie argumentow wiersza polecen
  FILE *plik = NULL;
  plik = fopen(argv[1], "r");                              // otwarcie pliku tekstowego w trybie czytania

  if (plik == NULL){                                       // sprawdzanie istnienia pliku
    printf("Otwarcie pliku sie nie powiodlo!\n");
    return 1;
  }
  else {
    float liczby = 0;                                      // zerowanie zmiennej
    while(1) {                                             // wieczny while
      fscanf(plik, "%f", &liczby);                         // wczytywanie liczb z pliku do tablicy "cyfry"
      if(feof(plik) != 0) break;                           // konczenie petli jak skonczy sie zawartosc pliku
      if(!liczby) {                                        // obsluga niedozwolonych znakow
        printf("W pliku znajduja sie nie dozwolone znaki, prosze popraw to.\n Koncze dzialanie programu.\n");
        break;                                             // przerwanie petli wiecznego while
      }
      int argument = atoi(argv[2]);                        // zmiana typu jednego z argumentów wiersza poleceń na typ int
      if(argument == 32) kodowanie_32(liczby, argv[3]);    // wywolanie funkcji kodujacej ieee754 pojedynczje precyzji
      else if (argument == 64) printf ("Pracujemy nad tym\n"); // tu ma byc wywolanie funkcji kodujacej iee754 podwojnej precyzji
      else printf("Prosze podac prawidlowe parametry");
      }
      liczby = 0;                                          // ponowne zerowanie zmiennej
    }
    fclose(plik);                                          // zamykanie pliku
  return 0;
}
