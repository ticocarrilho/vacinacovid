/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.recife.edu.ifpe.controller;

import br.recife.edu.ifpe.model.classes.ProfissionalEnfermagem;
import br.recife.edu.ifpe.model.repositorios.RepositorioProfissionalEnfermagem;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Arcantus
 */
@WebServlet(name = "EnfermeiroServlet", urlPatterns = {"/EnfermeiroServlet"})
public class EnfermeiroServlet extends HttpServlet {

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doDelete(request, response); //To change body of generated methods, choose Tools | Templates.
        int id = Integer.parseInt(request.getParameter("id"));
        ProfissionalEnfermagem f = RepositorioProfissionalEnfermagem.getCurrentInstance().read(id);
        RepositorioProfissionalEnfermagem.getCurrentInstance().delete(f);

        HttpSession session = request.getSession();

        session.setAttribute("msg", "O enfermeiro " + f.getNome() + " foi deletado com sucesso.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String codStr = request.getParameter("codigo");
        if (codStr != null) {
            int codigo = Integer.parseInt(codStr);
            ProfissionalEnfermagem f = RepositorioProfissionalEnfermagem.getCurrentInstance().read(codigo);

            request.setAttribute("enfermeiro", f);
        }
        getServletContext().getRequestDispatcher("/enfermeiro/enfermeiro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String nome = request.getParameter("nome");
            String coren = request.getParameter("coren");
            int anoFormacao = Integer.parseInt(request.getParameter("anoFormacao"));
            String contato = request.getParameter("contato");
            String editar = request.getParameter("editar");

            ProfissionalEnfermagem f = new ProfissionalEnfermagem();
            f.setNome(nome);
            f.setCoren(coren);
            f.setAnoFormacao(anoFormacao);
            f.setContato(contato);
            HttpSession session = request.getSession();
            if (editar == null) {
                RepositorioProfissionalEnfermagem.getCurrentInstance().insert(f);
                session.setAttribute("msg", "Enfermeiro " + f.getNome() + " cadastrado com sucesso.");
            } else {
                int codigo = Integer.parseInt(request.getParameter("codigo"));
                f.setId(codigo);
                RepositorioProfissionalEnfermagem.getCurrentInstance().update(f);
                session.setAttribute("msg", "Grupo " + f.getNome()+ " editado com sucesso.");
            }
            response.sendRedirect("EnfermeiroServlet");

        } catch (Exception e) {
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
