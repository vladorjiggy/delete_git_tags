#!/bin/bash


# Überprüfe, ob sich das Skript in einem Git-Repository befindet
if [ ! -d ".git" ]; then
  echo "Fehler: Dieses Skript muss in einem Git-Repository ausgeführt werden."
  exit 1
fi

prefix="test-"

# Finde Tags mit dem angegebenen Präfix
tagsToDelete=$(git tag -l "$prefix*")

# Überprüfe, ob Tags gefunden wurden
if [ -z "$tagsToDelete" ]; then
  echo "Keine passenden Tags gefunden."
  exit 1
fi

# Zeige die zu löschenden Tags an
echo "Folgende Tags werden gelöscht:"
for tag in $tagsToDelete; do
    echo $tag
done

# Frage nach Bestätigung
read -p "Möchten Sie diese Tags wirklich löschen? (y/n): " confirm

if [ "$confirm" == "y" ]; then
    # Iteriere über die gefundenen Tags und lösche sie
    for tag in $tagsToDelete; do
        git tag -d $tag
        git push origin :refs/tags/$tag
        echo "Tag $tag wurde gelöscht."
    done
    echo "Alle ausgewählten Tags wurden gelöscht."
else
    echo "Löschvorgang abgebrochen. Keine Tags wurden gelöscht."
fi