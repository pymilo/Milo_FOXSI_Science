FUNCTION foxsi3_first_indice_in_consec, select

; this function takes a selection of indices and returns a list of indices that are the first indices of a serie of consecutive indices

nind = n_elements(select)
IF nind LT 2 THEN BEGIN
  print, 'the list contains less than 2 elements'
  res = 0
ENDIF ELSE BEGIN

  firstind = list()
  firstind.add, select[0]

  FOR k=1, nind-1 DO BEGIN
    diffe = select[k]-select[k-1]
    IF diffe GT 1 THEN firstind.add, select[k]
  ENDFOR
  
  res = firstind
ENDELSE

RETURN, res

END