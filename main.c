#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#define NUM_PARTICLES 100
#define GRAVITATIONAL_CONSTANT 1.0
#define SOFTENING_LENGTH 0.05

// Struct containing properties of the particles
struct Particle
{
    double position[3];
    double velocity[3];
    double mass;
};


// Generate stationary particles at random positions
struct Particle stationary_particle_at_random_position()
{
    struct Particle particle;

    particle.position[0] = (double) rand() / RAND_MAX - 0.5;
    particle.position[1] = (double) rand() / RAND_MAX - 0.5;
    particle.position[2] = (double) rand() / RAND_MAX - 0.5;
    particle.velocity[0] = 0.0;
    particle.velocity[1] = 0.0;
    particle.velocity[2] = 0.0;
    particle.mass = 1.0;

    return particle;
}


// Calculate forces
void compute_force(struct Particle* particles, double* forces)
{
    for (int i = 0; i < NUM_PARTICLES; ++i)
    {
        forces[3 * i + 0] = 0.0;
        forces[3 * i + 1] = 0.0;
        forces[3 * i + 2] = 0.0;

        for (int j = 0; j < NUM_PARTICLES; ++j)
        {
            // We are computing the force on particle i due to particle j.
            // (dx, dy, dz) is the vector pointing from particle i to particle
            // j: this is the direction of the force.
            double G = GRAVITATIONAL_CONSTANT;
            double rs = SOFTENING_LENGTH;

            double dx = particles[j].position[0] - particles[i].position[0];
            double dy = particles[j].position[1] - particles[i].position[1];
            double dz = particles[j].position[2] - particles[i].position[2];

            double r2 = dx * dx + dy * dy + dz * dz;
            double invr3 = pow(r2 + rs * rs, -1.5);

            double mj = particles[j].mass;

            double fx = dx * G * mj * invr3;
            double fy = dy * G * mj * invr3;
            double fz = dz * G * mj * invr3;

            forces[3 * i + 0] += fx;
            forces[3 * i + 1] += fy;
            forces[3 * i + 2] += fz;
        }
    }
}


// Write particle data to file for analysis
void output_particles(struct Particle* particles, int output_number)
{
    char filename[1024];
    snprintf(filename, 1024, "particles.%d.dat", output_number);
    FILE* outfile = fopen(filename, "w");

    for (int i = 0; i < NUM_PARTICLES; ++i)
    {
        fprintf(outfile, "%+.8f %+.8f %+.8f\n",
            particles[i].position[0],
            particles[i].position[1],
            particles[i].position[2]);
    }
    fclose(outfile);
}


// Main fuction
int main()
{
    struct Particle particles[NUM_PARTICLES];
    double forces[NUM_PARTICLES * 3];
    double t = 0.0;
    double dt = 1e-4;
    int iteration = 0;

    for (int i = 0; i < NUM_PARTICLES; ++i)
    {
        particles[i] = stationary_particle_at_random_position();
    }

    while (t < 1.0)
    {
        compute_force(particles, forces);

        for (int i = 0; i < NUM_PARTICLES; ++i)
        {
            struct Particle* p = &particles[i];
            double *force = &forces[3 * i];

            // Now the positions of the particles will be calculated based
            // on the Leapfrog method ("kick-drift-kick")

            // Kick
            p->velocity[0] += force[0] * (dt/2) / p->mass;
            p->velocity[1] += force[1] * (dt/2) / p->mass;
            p->velocity[2] += force[2] * (dt/2) / p->mass;

            // Drift
            p->position[0] += p->velocity[0] * dt;
            p->position[1] += p->velocity[1] * dt;
            p->position[2] += p->velocity[2] * dt;

            compute_force(particles, forces);

            // Kick
            p->velocity[0] += force[0] * (dt/2) / p->mass;
            p->velocity[1] += force[1] * (dt/2) / p->mass;
            p->velocity[2] += force[2] * (dt/2) / p->mass;


        }
        t += dt;
        iteration += 1;

        printf("[%d] t=%f\n", iteration, t);

        if (iteration % 20 == 0)
        {
            output_particles(particles, iteration / 20);
        }
    }
    return 0;
}