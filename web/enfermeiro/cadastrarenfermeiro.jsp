<%-- 
    Document   : cadastrarenfermeiro
    Created on : Mar 4, 2021, 12:56:40 PM
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
        <form method="post" action="EnfermeiroServlet">
            <div class="modal-body">
                <div class="form-group row">
                    <label for="nome" class="col-2 col-form-label">Nome</label>
                    <div class="col-10">
                        <input class="form-control" type="text" name="nome" required value="${(param.redirect != null && param["redirect"] eq 'edita') ? enfermeiro.nome : ''}" id="nome"/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="coren" class="col-2 col-form-label">Coren</label>
                    <div class="col-10">
                        <input class="form-control" type="text" name="coren" required value="${(param.redirect != null && param["redirect"] eq 'edita') ? enfermeiro.coren : ''}" id="coren"/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="nome" class="col-2 col-form-label">Ano Formacao</label>
                    <div class="col-10">
                        <input class="form-control" type="number" name="anoFormacao"  min="1" minlength="4" value="${(param.redirect != null && param["redirect"] eq 'edita') ? enfermeiro.anoFormacao : ''}" id="nome"/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="contato" class="col-2 col-form-label">Contato</label>
                    <div class="col-10">
                        <input class="form-control" type="text" name="contato" required value="${(param.redirect != null && param["redirect"] eq 'edita') ? enfermeiro.contato : ''}" id="contato"/>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                <button type="submit" value="cadastrar" class="btn btn-primary">${(param.redirect != null && param["redirect"] eq 'edita') ? 'Editar' : 'Cadastrar'} Enfermeiro</button>
            </div>
            <input type="hidden" name="${(param.redirect != null && param["redirect"] eq 'edita') ? 'editar' : ''}" value="edita"/>
            <input type="hidden" name="${(param.redirect != null && param["redirect"] eq 'edita') ? 'codigo' : ''}" value="${(param.redirect != null && param["redirect"] eq 'edita') ? enfermeiro.id : ''}"/>
        </form>


    </body>
</html>
