#!/bin/bash

# Definir directorios
TRANSLATORX="...T/translatorx_vLocal.pl"
INPUT_DIR="...Single_Copy_Orthologue_Sequences"
OUTPUT_DIR="...1_RESULTADO"

# Crear directorio de salida si no existe
mkdir -p "$OUTPUT_DIR"

# Iterar sobre todos los archivos .fa en el directorio de entrada
for file in "$INPUT_DIR"/*.fa; do
    filename=$(basename "$file" .fa)  # Extraer el nombre del archivo sin extensión
    
    echo "Procesando: $filename"

    # Ejecutar TranslatorX
    perl "$TRANSLATORX" -i "$file" -o "$OUTPUT_DIR/$filename" -p C -t F -w 1 -c 1 

    echo "✅ Completado: $filename"
done

echo "🎉 Todos los ortólogos han sido procesados con TranslatorX."
