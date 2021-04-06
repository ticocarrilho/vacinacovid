<%-- 
    Document   : visualizagrupo
    Created on : Mar 4, 2021, 12:11:02 PM
    Author     : Arcantus
--%>

<%@page import="br.recife.edu.ifpe.model.classes.Grupo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Grupo grupo = (Grupo) request.getAttribute("grupo");
            if (grupo != null) {
        %>
        <div class="modal-body">

            <table class="table">
                <tr>
                    <th>Codigo</th>
                    <td>${grupo.id}</td>
                </tr>
                <tr>
                    <th>Denominacao</th>
                    <td>${grupo.denominacao}</td>
                </tr>
                <tr>
                    <th>Idade Minima</th>
                    <td>${grupo.idadeMinima}</td>
                </tr>
                <tr>
                    <th>Idade Maxima</th>
                    <td>${grupo.idadeMaxima}</td>
                </tr>
            </table>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
        </div>
        <%
            }
        %>
    </body>
</html>
