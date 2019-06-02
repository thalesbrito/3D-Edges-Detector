function [edgePoints, edgeWeight] = consensusAnalysis(edgePointsByNormal, internalBoundaryPoints, externalBoundaryPoints, coincidentLabels)

structureObj = ["wall", "window", "floor", "column", "ceiling", "beam", "board"];% se tiver mais de um elementos desse vetor aumenta prob
furnitureObj = ["bookcase", "chair", "sofa", "table"]; %ainda nao sei o q fazer com isso
nonIdObj = ["<UNK>", "clutter"]; %marcar como non-edge




%aumentar prob se estiver em obj estrutural
%intersecao entre chao e  furniture. nao eh borda estrutural
%diminuir probab de estiver em obj nao identificado
%fazer analise consensual

end