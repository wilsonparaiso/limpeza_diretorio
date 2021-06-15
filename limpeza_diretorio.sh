#!/bin/bash
#Autor: Wilson Paraiso
#Data: 14/06/2021
#Versão: 1.0
###Realizando Limpeza dos arquivos de logs.
rm -f /tmp/arquivos_removidos.log
rm -f /tmp/conteudodiretorio.log
###Informe o diretório no qual deseja executar a limpeza.
varDiretorio="..."
###Criando a lista de arquivos que contém no diretório informado.
ls $varDiretorio > /tmp/conteudodiretorio.log
###Estrutura de repetição para leitura de linha por linha da lista gerada no passo anterior.
while IFS= read -r varARQUIVO || [[ -n "$varARQUIVO" ]]; do
        ###Verificando se o arquivo tem mais de 30 dias. Se tiver valor será igual a 1, caso não tenha, valor igual a 0.
        varTestaArquivo=$(find $varDiretorio/$varARQUIVO -mtime +30 -exec ls -l {} \; | wc -l)
        ###Verificando de a variável varTestaArquivo tem valor igual a 1.
        if [ $varTestaArquivo == 1 ]
        then
            ###Gerando log de execução com a lista de arquivos removidos.
            ls -l $varDiretorio/$varARQUIVO >>/tmp/arquivos_removidos.log
            ###Removendo o arquivo que passou na verificação.
            rm -f $varDiretorio/$varARQUIVO
        fi
done < /tmp/conteudodiretorio.log  ###Leitura da lista de arquivos gerada.