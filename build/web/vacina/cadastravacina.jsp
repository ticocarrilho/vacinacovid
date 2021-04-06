<%-- 
    Document   : cadastravacina
    Created on : Mar 3, 2021, 12:41:21 PM
    Author     : Arcantus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form method="post" action="VacinaServlet">
            <div class="modal-body">
                <div class="form-group row">
                    <label for="nome" class="col-2 col-form-label">Nome</label>
                    <div class="col-10">
                        <input class="form-control" type="text" name="nome" required value="${(param.redirect != null && param["redirect"] eq 'edita') ? vacina.nome : ''}" id="nome"/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="fabricante" class="col-2 col-form-label">Fabricante</label>
                    <div class="col-10">
                        <input class="form-control" type="text" name="fabricante"required value="${(param.redirect != null && param["redirect"] eq 'edita') ? vacina.fabricante : ''}" id="fabricante"/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="tempoEntreAplicacoes" class="col-2 col-form-label">Tempo entre Aplicacoes</label>
                    <div class="col-10">
                        <input class="form-control" type="text" name="tempo" required value="${(param.redirect != null && param["redirect"] eq 'edita') ? vacina.tempoEntreAplicacoes : ''}" id="tempoEntreAplicacoes"/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="quantidadeAplicacoes" class="col-3 col-form-label">Quantidade</label>
                    <div class="col-9">
                        <input class="form-control" type="number" name="quantidade" min="1" required value="${(param.redirect != null && param["redirect"] eq 'edita') ? vacina.quantidadeAplicacoes : ''}" id="quantidadeAplicacoes"/>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                <button type="submit" value="cadastrar" class="btn btn-primary">${(param.redirect != null && param["redirect"] eq 'edita') ? 'Editar' : 'Cadastrar'} Vacina</button>
            </div>
            <input type="hidden" name="${(param.redirect != null && param["redirect"] eq 'edita') ? 'editar' : ''}" value="edita"/>
            <input type="hidden" name="${(param.redirect != null && param["redirect"] eq 'edita') ? 'codigo' : ''}" value="${(param.redirect != null && param["redirect"] eq 'edita') ? vacina.id : ''}"/>
        </form>


    </body>
</html>
