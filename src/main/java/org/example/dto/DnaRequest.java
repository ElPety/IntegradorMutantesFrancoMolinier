package org.example.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.validator.ValidDna; // Crearemos esta anotación luego

@AllArgsConstructor
@NoArgsConstructor
@Data
public class DnaRequest {
    @NotNull(message = "El ADN no puede ser nulo")
    @NotEmpty(message = "El ADN no puede estar vacío")
    @ValidDna // Validación personalizada para verificar NxN y caracteres válidos
    private String[] dna;
}