#include <iostream>
#include <stdlib.h>

using namespace std;

void change_scheme(string colorscheme){
  system("rm ~/.config/alacritty/alacritty.yml");
  string cmd = "cp ~/.config/alacritty/colorschemes/" + colorscheme + "/alacritty.yml ~/.config/alacritty/alacritty.yml"; 
  const char *command = cmd.c_str();
  system(command);
  cout << "se ha cambiado el esquema de color correctamente a " << colorscheme << endl;
}

int main(){
  int eleccion;

  cout << "A cual colorscheme quieres cambiar?\n\t[1] > dracula\n\t[2] > nord\n\t"
  << "[3] > gruvbox\n\t" << ">>> "; cin >> eleccion;

  switch (eleccion){
    case 1:
      change_scheme("dracula");
      break;

    case 2:
      change_scheme("nord");
      break;
    case 3:
      change_scheme("gruvbox");
      break;
  }

  return 0;
}
