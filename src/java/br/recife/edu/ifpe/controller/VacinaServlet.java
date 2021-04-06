/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.recife.edu.ifpe.controller;

import br.recife.edu.ifpe.model.classes.Vacina;
import br.recife.edu.ifpe.model.repositorios.RepositorioVacina;
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
@WebServlet(name = "VacinaServlet", urlPatterns = {"/VacinaServlet"})
public class VacinaServlet extends HttpServlet {

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doDelete(request, response); //To change body of generated methods, choose Tools | Templates.
        int id = Integer.parseInt(request.getParameter("id"));
        Vacina f = RepositorioVacina.getCurrentInstance().read(id);
        RepositorioVacina.getCurrentInstance().delete(f);

        HttpSession session = request.getSession();

        session.setAttribute("msg", "A vacina " + f.getNome() + " foi deletada com sucesso.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String codStr = request.getParameter("codigo");

        if (codStr != null) {
            int codigo = Integer.parseInt(codStr);
            Vacina f = RepositorioVacina.getCurrentInstance().read(codigo);
            request.setAttribute("vacina", f);
        }
        getServletContext().getRequestDispatcher("/vacina/vacinas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String nome = request.getParameter("nome");
            String fabricante = request.getParameter("fabricante");
            String tempoEntreAplicacoes = request.getParameter("tempo");
            int quantidadeAplicacoes = Integer.parseInt(request.getParameter("quantidade"));
            String editar = request.getParameter("editar");

            Vacina f = new Vacina();
            f.setNome(nome);
            f.setFabricante(fabricante);
            f.setTempoEntreAplicacoes(tempoEntreAplicacoes);
            f.setQuantidadeAplicacoes(quantidadeAplicacoes);
            HttpSession session = request.getSession();
            
            if (editar == null) {
                RepositorioVacina.getCurrentInstance().insert(f);
                session.setAttribute("msg", "Vacina " + f.getNome() + " cadastrada com sucesso.");
            } else {
                int codigo = Integer.parseInt(request.getParameter("codigo"));
                f.setId(codigo);
                RepositorioVacina.getCurrentInstance().update(f);
                session.setAttribute("msg", "Vacina " + f.getNome() + " editada com sucesso.");
            }
            response.sendRedirect("VacinaServlet");

        } catch (Exception e) {
            e.printStackTrace();
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
