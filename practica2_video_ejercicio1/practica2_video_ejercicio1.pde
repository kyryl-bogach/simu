
import processing.video.*;

Configuracion conf; // Objeto con la configuración en tiempo real del proyecto

// Variables globales
ArrayList<Boton> botones; // Botones en la vista principal

Movie mov; // Variable global del vídeo
PImage imagenAnterior; // Variable de control de la imágen anterior

final String PATH = "sample_video.mp4";
final int SALTO = 4; // segundos de salto

void setup() {
	size(1280, 720);

	conf = new Configuracion();

	mov = new Movie(this, PATH);
	mov.loop(); // Comenzamos en bucle
	mov.volume(1);

	// Imagen anterior vacía
	imagenAnterior = createImage(mov.width, mov.height, RGB);

	// Configuramos la botonera de control del vídeo
	botones = new ArrayList<Boton>();
	botones.add(new BotonFiltro(200, 630, 80, 80));
	botones.add(new BotonRewind(400, 630, 80, 80));
	botones.add(new BotonStop(500, 630, 80, 80));
	botones.add(new BotonPlay(600, 630, 80, 80));
	botones.add(new BotonPause(700, 630, 80, 80));
	botones.add(new BotonForward(800, 630, 80, 80));
}

void movieEvent(Movie m) {
	m.read();
}

void draw() {
	// Dibujamos la imagen anterior
	image(imagenAnterior, 0, 0, width, height);

	// Si está el efecto activado, lo aplicamos
	if (conf.mostrarEfecto) {
		blend(mov, 0, 0, mov.width, mov.height, 0, 0, mov.width, mov.height, SUBTRACT);
	}

	// Actualizamos la imagen anterior
	imagenAnterior = mov.get(0, 0, mov.width, mov.height);

	// Control de los botones
	for (Boton b : botones) {
		b.update();
		b.show();
	}

	// Variable de control del clickado el ratón en un tick
	// (para los botones)
	conf.mouseClicked = false;
}

// Manejamos eventos al clickar con el ratón
// (para los botones)
void mouseClicked() {
	conf.mouseClicked = true;
}