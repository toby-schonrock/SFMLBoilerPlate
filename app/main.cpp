#include <chrono>
#include <iostream>

#include "GUI.hpp"
#include "SFML/Graphics.hpp"
#include "SFML/Window.hpp"
#include "Vector2.hpp"
#include "imgui-SFML.h"
#include "imgui.h"
#include "implot.h"

template <typename T>
sf::Vector2f visualize(const Vector2<T>& v) {
    return sf::Vector2f(static_cast<float>(v.x), static_cast<float>(v.y));
}

template <typename T>
Vector2<T> unvisualize(const sf::Vector2f& v) {
    return Vector2<T>(v.x, v.y);
}

template <typename T>
Vector2<T> unvisualize(const sf::Vector2i& v) {
    return Vector2<T>(v.x, v.y);
}

int main() {
    sf::VideoMode desktop = sf::VideoMode::getDesktopMode();

    sf::ContextSettings settings;
    settings.antialiasingLevel = 8;

    sf::RenderWindow window(sf::VideoMode::getDesktopMode(), "Window", sf::Style::Fullscreen,
                            settings); //, sf::Style::Default);

    GUI gui(desktop, window);

    ImGui::SFML::Init(window);
    ImPlot::CreateContext();
    ImGuiIO& imguIO = ImGui::GetIO();
    imguIO.ConfigFlags &= ~ImGuiConfigFlags_NoMouseCursorChange; // disable cursor overide

    // example circle
    sf::CircleShape circle(0.5);
    circle.setOrigin(circle.getRadius(), circle.getRadius());
    circle.setPosition(gui.view.getCenter());

    sf::Clock
        deltaClock; // for imgui - read https://eliasdaler.github.io/using-imgui-with-sfml-pt1/
    while (window.isOpen()) {
        sf::Vector2i mousePixPos = sf::Mouse::getPosition(
            window); // mouse position is only accurate to end of simulation frames (it does change)

        // poll events for sfml and imgui
        sf::Event event; // NOLINT
        while (window.pollEvent(event)) {
            ImGui::SFML::ProcessEvent(event);
            if (event.type == sf::Event::Closed) {
                window.close();
            } else if (!(imguIO.WantCaptureMouse && event.type == sf::Event::MouseButtonPressed)) {
                gui.event(event, mousePixPos);
            }
        }

        ImGui::SFML::Update(window, deltaClock.restart()); // required for imgui-sfml

        if ((unvisualize<float>(window.mapPixelToCoords(mousePixPos) - circle.getPosition()))
                .mag() < circle.getRadius()) { // if hovering
            circle.setFillColor(sf::Color::Green);
            ImGui::SetTooltip("Welcome to SFML");
        } else {
            circle.setFillColor(sf::Color::White);
        }

        // draw
        window.clear();

        window.draw(circle);
        gui.frame(mousePixPos);

        ImGui::SFML::Render(window);
        window.display();
    }

    ImPlot::DestroyContext();
    ImGui::SFML::Shutdown();

    return 0;
}