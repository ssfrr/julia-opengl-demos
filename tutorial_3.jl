import GLFW

const OpenGLver="1.0"
using OpenGL

function initGL(w, h)
    aspect_ratio = h / w

    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    gluPerspective(45.0, (1 / aspect_ratio), 0.1, 100.0)
    glMatrixMode(GL_MODELVIEW)

    # smooth shading
    glShadeModel(GL_SMOOTH)
    # black background
    glClearColor(0.0, 0.0, 0.0, 0.0)
    # setup depth buffer
    glClearDepth(1.0)
    # enable depth testing and set type
    glEnable(GL_DEPTH_TEST)
    glDepthFunc(GL_LEQUAL)
    #  Really Nice Perspective Calculations
    glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)
end

function draw()
    # clear the screen and depth buffer
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    # reset the current Modelview matrix
    glLoadIdentity()

    # set the color to white

    glTranslate(-1.5, 0.0, -6.0)

    glBegin(GL_TRIANGLES)
        glColor(1.0, 0.0, 0.0)
        glVertex(0.0, 1.0, 0.0)
        glColor(0.0, 1.0, 0.0)
        glVertex(1.0, -1.0, 0.0)
        glColor(0.0, 0.0, 1.0)
        glVertex(-1.0, -1.0, 0.0)
    glEnd()

    glTranslate(3.0, 0.0, 0.0)

    glBegin(GL_QUADS)
        glVertex(-1.0, 1.0, 0.0)
        glVertex(1.0, 1.0, 0.0)
        glVertex(1.0, -1.0, 0.0)
        glVertex(-1.0, -1.0, 0.0)
    glEnd()

    glLoadIdentity()
end

function main()
    width = 800
    height = 600
    GLFW.Init()
    #GLFW.OpenWindowHint(GLFW.FSAA_SAMPLES, 4) # 4x antialiasing
    GLFW.OpenWindow(width, height, 0, 0, 0, 0, 0, 0, GLFW.WINDOW)
    GLFW.SetWindowTitle("Tutorial 3")
    GLFW.Enable(GLFW.STICKY_KEYS);
    initGL(width, height)

    while GLFW.GetWindowParam(GLFW.OPENED) && !GLFW.GetKey(GLFW.KEY_ESC)
        draw()
        GLFW.SwapBuffers()
    end
    GLFW.CloseWindow()
    GLFW.Terminate()
end

main()
