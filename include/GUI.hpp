#pragma once

#include <iostream>
#include <optional>

#include "SFML/Graphics.hpp"
#include "SFML/Window.hpp"
#include "imgui.h"

class GUI {
  private:
    static constexpr float          zoomFact = 1.05F;
    sf::RenderWindow&               window;
    std::optional<sf::Vector2i>     mousePosLast;
    const sf::Vector2<unsigned int> screen;
    const float                     vsScale; // window scaling
  public:
    sf::View view;

    GUI(const sf::VideoMode& desktop, sf::RenderWindow& window_)
        : window(window_), screen(desktop.width, desktop.height),
          vsScale(static_cast<float>(screen.x) / 20.0F) {
        std::cout << "Scale: " << vsScale << "\n";
        reset();
    }

    void reset() {
        view = window.getDefaultView();
        view.zoom(1 / vsScale);
        view.setCenter(view.getSize() / 2.0F);
        window.setView(view);
    }

    void event(const sf::Event& event, const sf::Vector2i& mousePixPos) {
        if (event.type == sf::Event::MouseWheelMoved) {
            float        zoom = (event.mouseWheel.delta == 1) ? 1 / zoomFact : zoomFact;
            sf::Vector2f diff = window.mapPixelToCoords(mousePixPos) - view.getCenter();
            view.zoom(zoom);
            view.move(diff * (1 - zoom));
            window.setView(view);
        } else if (event.type == sf::Event::MouseButtonReleased) {
            if (event.mouseButton.button == sf::Mouse::Middle) {
                mousePosLast.reset();
            }
        }
    }

    void frame(const sf::Vector2i& mousePixPos) {
        interface();
        if (sf::Mouse::isButtonPressed(sf::Mouse::Middle)) {
            ImGui::SetMouseCursor(ImGuiMouseCursor_ResizeAll);
            if (!mousePosLast)
                mousePosLast = mousePixPos;
            else {
                sf::Vector2i diff = *mousePosLast - mousePixPos;
                sf::Vector2f mouseMove =
                    sf::Vector2f(diff) * view.getSize().x / static_cast<float>(screen.x);
                view.move(mouseMove);
                window.setView(view);
                mousePosLast = mousePixPos;
            }
        }
    }

    void interface() {
        ImGui::Begin("GUI", NULL,
                     ImGuiWindowFlags_NoMove | ImGuiWindowFlags_NoBackground |
                         ImGuiWindowFlags_NoResize);
        ImGui::SetWindowSize({-1.0F, -1.0F});
        ImGui::SetWindowPos({0.0F, 0.0F});
        ImGui::Text("View: (%F, %F)", view.getSize().x, view.getSize().y);
        ImGui::Text("Pos: (%F, %F)", view.getCenter().x, view.getCenter().y);
        if (ImGui::Button("reset view")) reset();
        ImGui::End();
    }
};