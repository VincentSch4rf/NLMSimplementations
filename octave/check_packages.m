function check_packages
  p = pkg("describe", "image");
  empty = {struct('name',{},'description',{},'provides',{})};
  if isequaln(p, empty) == 1
    a = questdlg("Das Paket 'image' ist nicht vorhanden und muss installiert werden.\nDie Installation dauert eine (lange) Weile.\nEbenfalls wird eine funktionierende Internetverbindung benoetigt.",
                  "Fortfahren", "Abbrechen");
    if a == "Fortfahren"
      printf("Installation gestartet.\n");
      pkg install -forge -verbose image
    else
      print("Das Skript wird nun beendet.");
      exit(1);
    end
  else
      printf("OK: Alle benoetigten Pakete installiert\n");
      pkg("load", "image");
  end
end