function mark_kross2(r::Robot) 
    for side in (Nord,West,Sud,Ost)
        count=1
        while count!=0
            count=workaround_wall(r,side)
            putmarker!(r)
        end
        while ismarker(r)==true
            workaround_wall(r,inverse(side))
        end
        side=inverse(next(side))
    end
putmarker!(r)
end
            
function workaround_wall(r::Robot, side::HorizonSide) 
    num_steps=0
    while isborder(r,side) && !isborder(r,next(side)) 
        num_steps+=1
    end
    count=0 
    if isborder(r,side)==false
        move!(r,side)
        count+=1 
    end
    if num_steps !=0
        while isborder(r,inverse(next(side))) 
            move!(r,side)
            count+=1
        end
        for t in 1:num_steps
        move!(r,inverse(next(side))) 
        end
    end
    return count
end

function next(side::HorizonSide)
    return HorizonSide(mod(Int(side)+3,4))
end
    
function inverse(side::HorizonSide) 
    return HorizonSide(mod(Int(side) +2, 4))
end 

mark_kross2(r)