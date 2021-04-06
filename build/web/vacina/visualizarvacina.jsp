<%-- 
    Document   : visualizarvacina
    Created on : Mar 4, 2021, 11:46:31 AM
    Author     : Arcantus
--%>


<%@page import="br.recife.edu.ifpe.model.classes.Vacina"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Vacina vacina = (Vacina) request.getAttribute("vacina");
            if (vacina != null) {
        %>
        <div class="modal-body">

            <table class="table">
                <tr>
                    <th>Codigo</th>
                    <td>${vacina.id}</td>
                </tr>
                <tr>
                    <th>Nome</th>
                    <td>${vacina.nome}</td>
                </tr>
                <tr>
                    <th>Fabricante</th>
                    <td>${vacina.fabricante}</td>
                </tr>
                <tr>
                    <th>Tempo entre Aplicacoes</th>
                    <td>${vacina.tempoEntreAplicacoes}</td>
                </tr>
                <tr>
                    <th>Quantidade</th>
                    <td>${vacina.quantidadeAplicacoes}</td>
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
