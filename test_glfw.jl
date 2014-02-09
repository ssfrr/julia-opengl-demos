import GLFW

const OpenGLver="3.3"
using OpenGL

# An array of 3 vectors which represents 3 vertices
const vertex_buffer_data = Float32[
   -1, -1, 0,
    1, -1, 0,
    0,  1, 0,
]

function main()
    GLFW.Init()
    GLFW.OpenWindow(0, 0, 0, 0, 0, 0, 0, 0, GLFW.WINDOW)
    GLFW.SetWindowTitle("Bouncy, Bouncy")

    # wrap in a pointer so we can get the value back
    VertexArrayID = GLuint[0]
    glGenVertexArrays(1, VertexArrayID)
    glBindVertexArray(VertexArrayID[1])


    # This will identify our vertex buffer
    vertexbuffer = GLuint[0]

    # Generate 1 buffer, put the resulting identifier in vertexbuffer
    glGenBuffers(1, vertexbuffer)

    # bind vertexbuffer to the 1st element so we don't need to keep
    # dereferencing it from here on out
    vertexbuffer = vertexbuffer[1]

    # The following commands will talk about our 'vertexbuffer' buffer
    glBindBuffer(ARRAY_BUFFER, vertexbuffer)

    # Give our vertices to OpenGL.
    glBufferData(ARRAY_BUFFER, length(vertex_buffer_data),
                 vertex_buffer_data, STATIC_DRAW)

    while GLFW.GetWindowParam(GLFW.OPENED) && !GLFW.GetKey(GLFW.KEY_ESC)
        # 1st attribute buffer : vertices
        glEnableVertexAttribArray(0)
        glBindBuffer(ARRAY_BUFFER, vertexbuffer)
        glVertexAttribPointer(
           0,        # attribute 0. No particular reason for 0, but must match
                     # the layout in the shader.
           3,        # size
           FLOAT,    # type
           FALSE,    # normalized?
           0,        # stride
           0         # array buffer offset
        )

        # Starting from vertex 0; 3 vertices total -> 1 triangle
        glDrawArrays(TRIANGLES, 0, 3)
        glDisableVertexAttribArray(0);
        info("loop")
    end
    GLFW.CloseWindow()
    GLFW.Terminate()
end

main()
