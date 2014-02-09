import GLFW

const OpenGLver="1.0"
using OpenGL

immutable WorldState
    r_tri::GLfloat
    r_quad::GLfloat

    WorldState() = new(0, 0)
    WorldState(r_tri, r_quad) = new(r_tri, r_quad)
end

function tick(state::WorldState)
    return WorldState(state.r_tri + 0.6,
                      state.r_quad - 0.45)
end

function initGL(w, h)
    aspect_ratio = w / h

    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    gluPerspective(45.0, aspect_ratio, 0.1, 100.0)

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

function draw(state)
    # clear the screen and depth buffer
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    # reset the current Modelview matrix
    glLoadIdentity()

    glTranslate(-1.5, 0.0, -6.0)
    glRotate(state.r_tri, 0.0, 1.0, 0.0)

    glBegin(GL_TRIANGLES)
        glColor(1.0, 0.0, 0.0)
        glVertex(0.0, 1.0, 0.0)
        glColor(0.0, 1.0, 0.0)
        glVertex(1.0, -1.0, 0.0)
        glColor(0.0, 0.0, 1.0)
        glVertex(-1.0, -1.0, 0.0)
    glEnd()

    # now we reset the Modelview matrix to clear out the rotation from the
    # triangle
    glLoadIdentity()
    glTranslate(1.5, 0.0, -6.0)
    glRotate(state.r_quad, 1.0, 0.0, 0.0)

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
    # this time we'll set up anti-aliasing to smooth the edges
    GLFW.OpenWindowHint(GLFW.FSAA_SAMPLES, 4)
    GLFW.OpenWindow(width, height, 0, 0, 0, 0, 0, 0, GLFW.WINDOW)
    GLFW.SetWindowTitle("Tutorial 4")
    GLFW.Enable(GLFW.STICKY_KEYS);
    initGL(width, height)

    state = WorldState()

    while GLFW.GetWindowParam(GLFW.OPENED) && !GLFW.GetKey(GLFW.KEY_ESC)
        draw(state)
        GLFW.SwapBuffers()
        state = tick(state)
    end
    GLFW.CloseWindow()
    GLFW.Terminate()
end

main()
