import GLFW

const OpenGLver="1.0"
using OpenGL

immutable WorldState
    x_rot::GLfloat
    x_speed::GLfloat
    y_rot::GLfloat
    y_speed::GLfloat

    WorldState(xr, xs, yr, ys) = new(xr, xs, yr, ys)
    WorldState() = new(0.0, 0.0, 0.0, 0.0)
end


function tick(state::WorldState)
    x_speed = state.x_speed
    x_speed += GLFW.GetKey(GLFW.KEY_UP) ? 0.04 : 0.0
    x_speed -= GLFW.GetKey(GLFW.KEY_DOWN) ? 0.04 : 0.0
    y_speed = state.y_speed
    y_speed += GLFW.GetKey(GLFW.KEY_RIGHT) ? 0.04 : 0.0
    y_speed -= GLFW.GetKey(GLFW.KEY_LEFT) ? 0.04 : 0.0
    x_rot = state.x_rot + x_speed
    y_rot = state.y_rot + y_speed
    return WorldState(x_rot, x_speed,
                      y_rot, y_speed)
end

function initGL(w, h)
    aspect_ratio = w / h

    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    gluPerspective(45.0, aspect_ratio, 0.1, 100.0)

    glMatrixMode(GL_MODELVIEW)

    # smooth shading
    glShadeModel(GL_SMOOTH)
    #glEnable(GL_LIGHTING)
    #glEnable(GL_COLOR_MATERIAL)
    #  Really Nice Perspective Calculations
    glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)

    # set up blending function
end

function draw_cube()
    glPushMatrix()
    # 4 sides
    for rot in [0, 90, 180, 270]
        glPushMatrix()
            glRotate(rot, 0.0, 1.0, 0.0)
            glTranslate(0.0, 0.0, 1.0)
            draw_square()
        glPopMatrix()
    end
    #top, bottom
    for rot in [90, 270]
        glPushMatrix()
            glRotate(rot, 1.0, 0.0, 0.0)
            glTranslate(0.0, 0.0, 1.0)
            draw_square()
        glPopMatrix()
    end
    glPopMatrix()
end

function draw_square()
    glBegin(GL_QUADS);
        #glNormal(0.0, 0.0, 1.0)
        glVertex(-1.0, -1.0,  0.0);
        glVertex( 1.0, -1.0,  0.0);
        glVertex( 1.0,  1.0,  0.0);
        glVertex(-1.0,  1.0,  0.0);
    glEnd();
end

function draw(state)
    glEnable(GL_BLEND)
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    # white background
    glClearColor(1.0, 1.0, 1.0, 1.0)
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    # disable depth testing so blending works
    glEnable(GL_DEPTH_TEST)
    glLoadIdentity()

    # set up ambient light
    # glLightfv(GL_LIGHT1, GL_AMBIENT, [0.1, 0.1, 0.1, 1.0])
    # set up diffuse light
    # glLightfv(GL_LIGHT1, GL_DIFFUSE, [1.0, 1.0, 1.0, 1.0])
    # set the  light as directional
    # glLightfv(GL_LIGHT1, GL_POSITION, [-1.0, 1.0, 1.0, 0.0])
    # glEnable(GL_LIGHT1)
    #glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, [1.0, 0.0, 0.0, 1.0]);
    #glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, [0.3, 0.3, 0.3, 1.0]);
    #glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, [0.0, 0.0, 0.0, 1.0]);
    # reset the current Modelview matrix

    glTranslate(0.0, 0.0, -6.0)
    glRotate(state.x_rot, 1.0, 0.0, 0.0)
    glRotate(state.y_rot, 0.0, 1.0, 0.0)

    glPushMatrix()
    glTranslate(-1.5, 0.0, 0.0)
    glColor(0.0, 1.0, 0.0, 1.0)
    draw_cube()
    glPopMatrix()
    glTranslate(1.5, 0.0, 0.0)
    glColor(1.0, 0.0, 0.0, 0.5)
    draw_cube()
end

function main()
    width = 800
    height = 600
    GLFW.Init()
    # this time we'll set up anti-aliasing to smooth the edges
    GLFW.OpenWindowHint(GLFW.FSAA_SAMPLES, 4)
    GLFW.OpenWindow(width, height, 0, 0, 0, 8, 24, 8, GLFW.WINDOW)
    GLFW.SetWindowTitle("Tutorial 4")
    GLFW.Enable(GLFW.STICKY_KEYS);
    initGL(width, height)

    state = WorldState()


    #glColor(0.8, 0.0, 0.2, 0.2)

    while GLFW.GetWindowParam(GLFW.OPENED) && !GLFW.GetKey(GLFW.KEY_ESC)
        draw(state)
        GLFW.SwapBuffers()
        state = tick(state)
    end
    GLFW.CloseWindow()
    GLFW.Terminate()
end

main()
