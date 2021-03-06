#!/bin/bash

function muestraayuda_genera_lienzo_satinado() {
  echo -e "\e[1mNOMBRE\e[0m"
  echo -e "\t genera_lienzo_satinado - Genera un lienzo con formas aleatorias con transparencia."
  echo ""
  echo -e "\e[1mSINOPSIS\e[0m"
  echo -e "\t genera_lienzo_satinado.sh "
  echo -e "\t genera_lienzo_satinado.sh -an 1920 -al 1080 nombredelfichero.png"

  echo ""
  echo -e "\e[1mDESCRIPCIÓN\e[0m"
  echo -e "\t \e[1mgenera_lienzo_satinado\e[0m Genera un lienzo con formas formas curvadas y tranparencia."
  echo -e "\t Se le puede indicar la altura con «-al» o «altura» y el número de píxeles que se desea para la altura del lienzo."
  echo -e "\t Para indicarle la anchura, acepta los parámetros «-an» o «anchura»."
  echo -e "\t En caso de que no se le indique anchura o altura, se usará 1920 y 1080 como respectivos valores por defecto."
  echo -e "\t Escribiendo un nombre de fichero, se utilizará éste como nombre del fichero a generar."
  echo ""
  echo -e "\e[1mPARÁMETROS\e[0m"
  echo -e "\t [ \e[1m-an\e[0m | \e[1manchura\e[0m ] Genera un lienzo de la anchura indicada. Si no se le indica anchura, el valor por defecto es 1920"
  echo -e "\t [ \e[1m-al\e[0m | \e[1maltura\e[0m ] Genera un lienzo de la altura indicada. Si no se le indica altura, el valor por defecto es 1080"
  echo -e "\t \e[1mnombredelfichero.png\e[0m Indica el nombre del fichero que se generará con el lienzo. Si no se le indica un nombre de fichero, el valor por defecto es «lienzo_laberinto.png»."

}

function genera_lienzo_satinado() {

while [[ $# -gt 0 ]]
do
    case $1 in
        -h|ayuda)
            muestraayuda_genera_lienzo_satinado
            exit 0
            ;;
        -al|altura)
            let altura=$2
            shift
            shift
            ;;
        -an|anchura)
            let anchura=$2
            shift
            shift
            ;;
        *)

            # Si tiene un punto «puede» que sea el nombre de un fichero.

            if [[ "$1" == *"."* ]]
            then
              ficherosalida=$1
            fi
            shift
            ;;
    esac
done


if [[ ! $anchura ]]
then
  let anchura=1920
fi
if [[ ! $altura ]]
then
  let altura=1080
fi
if [[ ! $ficherosalida ]]
then
  numeroficheros=$(ls lienzo_satinado* | wc -l)
  if [[ $numeroficheros = "0" ]]
  then
    ficherosalida="lienzo_satinado.png"
  else
    let numeral=$numeroficheros+1
    ficherosalida="lienzo_satinado_"$numeral".png"
  fi
fi

# Asignar valores aleatorios.

. genera_valores.sh

valores=$(genera_valores 17 0 100)

echo $valores
# valores="20,1,0,0,0,0,255,255,255,255,255,0,0,0,-50,0,0"

instruccion="gmic "$anchura","$altura",1,3 fx_satin "$valores" -output "$ficherosalida
eval $instruccion
echo $valores

# Comprueba que se ha generado con éxito.
if [[ -f $ficherosalida ]]
then
  # Devuelve el nombre del fichero generado por si se quiere almacenar en una variable
  echo $ficherosalida
else
  exit -1
fi
}


genera_lienzo_satinado $*
