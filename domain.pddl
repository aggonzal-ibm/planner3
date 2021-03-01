(define (domain ambulancia)
     (:requirements :strips :equality :typing :conditional-effects)

     (:types
          ambulancia locacion paciente
     )

     (:predicates
          (ambulancia ?a - ambulancia)
          (ambulancia_locacion ?a - ambulancia ?locacion - locacion)
          (dentro_ambulancia ?p - paciente ?a - ambulancia)
          (paciente_locacion ?p - paciente ?locacion1 - locacion)
          (fuera_ambulancia ?p - paciente)
          (camino ?locacion - locacion ?locacion2 - locacion)

     )
     (:action EntregarPaciente
          :parameters ( ?a - ambulancia ?locacion - locacion ?p - paciente)
          :precondition (and
               (ambulancia ?a)
               (ambulancia_locacion ?a ?locacion)
               (dentro_ambulancia ?p ?a)
               (paciente_locacion ?p ?locacion)
          )
          :effect (and
               (not (dentro_ambulancia ?p ?a))
               (fuera_ambulancia ?p)
          )
     )
     (:action TreparPaciente
          :parameters ( ?a - ambulancia ?locacion - locacion ?p - paciente)
          :precondition (and
               (ambulancia ?a)
               (ambulancia_locacion ?a ?locacion)
               (fuera_ambulancia ?p)
               (paciente_locacion ?p ?locacion)

          )
          :effect (and
               (not (fuera_ambulancia ?p))
               (dentro_ambulancia ?p ?a)
          )
     )

     (:action MoverAmbulanciaVacia
          :parameters ( ?a - ambulancia ?locaciona - locacion ?locacionb - locacion)
          :precondition (and
               (ambulancia ?a)
               (ambulancia_locacion ?a ?locaciona)
               (camino ?locaciona ?locacionb)

          )
          :effect (and
               (not (ambulancia_locacion ?a ?locaciona))
               (ambulancia_locacion ?a ?locacionb)
               (camino ?locaciona ?locacionb)

          )
     )

     (:action MoverAmbulanciaConPaciente
          :parameters ( ?a - ambulancia ?locaciona - locacion ?locacionb - locacion ?p - paciente)
          :precondition (and
               (ambulancia ?a)
               (ambulancia_locacion ?a ?locaciona)
               (dentro_ambulancia ?p ?a)
               (paciente_locacion ?p ?locaciona)
               (camino ?locaciona ?locacionb)

          )
          :effect (and
               (not (ambulancia_locacion ?a ?locaciona))
               (not (paciente_locacion ?p ?locaciona))
               (ambulancia_locacion ?a ?locacionb)
               (camino ?locaciona ?locacionb)
               (paciente_locacion ?p ?locacionb)
          )
     )

)