<%-- 
    Document   : cadastragrupo
    Created on : Mar 4, 2021, 12:10:51 PM
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
        <form method="post" action="GrupoServlet">
            <div class="modal-body">
                <div class="form-group row">
                    <label for="denominacao" class="col-3 col-form-label">Denominacao</label>
                    <div class="col-9">
                      <input class="form-control" type="text" name="denominacao" required value="${(param.redirect != null && param["redirect"] eq 'edita') ? grupo.denominacao : ''}" id="denominacao"/>
                    </div>
                  </div>
                  <div class="form-group row">
                    <label for="idademinima" class="col-2 col-form-label">Idade Minima</label>
                    <div class="col-10">
                      <input class="form-control" type="number" name="idademinima" min="0" required value="${(param.redirect != null && param["redirect"] eq 'edita') ? grupo.idadeMinima : ''}" id="idademinima"/>
                    </div>
                  </div>
                  <div class="form-group row">
                    <label for="idademaxima" class="col-2 col-form-label">Idade Maxima</label>
                    <div class="col-10">
                      <input class="form-control" type="number" name="idademaxima" min="1" required value="${(param.redirect != null && param["redirect"] eq 'edita') ? grupo.idadeMaxima : ''}" id="idademaxima"/>
                    </div>
                  </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                <button type="submit" value="cadastrar" class="btn btn-primary">${(param.redirect != null && param["redirect"] eq 'edita') ? 'Editar' : 'Cadastrar'} Grupo</button>
            </div>
            <input type="hidden" name="${(param.redirect != null && param["redirect"] eq 'edita') ? 'editar' : ''}" value="edita"/>
            <input type="hidden" name="${(param.redirect != null && param["redirect"] eq 'edita') ? 'codigo' : ''}" value="${(param.redirect != null && param["redirect"] eq 'edita') ? grupo.id : ''}"/>
        </form>


    </body>
</html>
