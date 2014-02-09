import GLFW

const OpenGLver="1.0"
using OpenGL

function main()
    width = 800
    height = 600
    GLFW.Init()
    GLFW.OpenWindow(width, height, 0, 0, 0, 0, 0, 0, GLFW.WINDOW)
    GLFW.SetWindowTitle("Tutorial 1")
    GLFW.Enable(GLFW.STICKY_KEYS);

    while GLFW.GetWindowParam(GLFW.OPENED) && !GLFW.GetKey(GLFW.KEY_ESC)
        # nothing to draw here
        GLFW.SwapBuffers()
    end
    GLFW.CloseWindow()
    GLFW.Terminate()
end

main()
