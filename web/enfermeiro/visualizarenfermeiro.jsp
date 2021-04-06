<%-- 
    Document   : visualizarenfermeiro
    Created on : Mar 4, 2021, 12:56:30 PM
    Author     : Arcantus
--%>


<%@page import="br.recife.edu.ifpe.model.classes.ProfissionalEnfermagem"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            ProfissionalEnfermagem enfermeiro = (ProfissionalEnfermagem) request.getAttribute("enfermeiro");
            if (enfermeiro != null) {
        %>
        <div class="modal-body">

            <table class="table">
                <tr>
                    <th>Codigo</th>
                    <td>${enfermeiro.id}</td>
                </tr>
                <tr>
                    <th>Nome</th>
                    <td>${enfermeiro.nome}</td>
                </tr>
                <tr>
                    <th>Coren</th>
                    <td>${enfermeiro.coren}</td>
                </tr>
                <tr>
                    <th>Ano Formacao</th>
                    <td>${enfermeiro.anoFormacao}</td>
                </tr>
                <tr>
                    <th>Contato</th>
                    <td>${enfermeiro.contato}</td>
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
