package body TECS.State is

   procedure Init (State : in out Storage; Next : State_Type) is
   begin
      State.Current  := Next;
      State.Switched := False;
      State_Queue.Clear (State.Set_Queue);
   end Init;

   procedure Set (State : in out Storage; Next : State_Type) is
   begin
      State_Queue.Append (State.Set_Queue, Next);
   end Set;

   function Contains (State : Storage; Current : State_Type) return Boolean is
   begin
      return State.Current = Current;
   end Contains;

   function Current (State : Storage) return State_Type is
   begin
      return State.Current;
   end Current;

   --  Вошли ли в стейт
   function Entered_In (State : Storage; S : State_Type) return Boolean is
   begin
      if State.Switched then
         return State.Current = S;
      else
         return False;
      end if;
   end Entered_In;

   --  Вышли ли из стейта
   function Leaved_Out (State : Storage; S : State_Type) return Boolean is
   begin
      if State.Switched then
         return State.Previous = S;
      else
         return False;
      end if;
   end Leaved_Out;

   --  Был ли переход из стейта в стейт
   function Transitioned
     (State : Storage; From : State_Type; To : State_Type) return Boolean
   is
   begin
      if State.Switched then
         return State.Current = To and then State.Previous = From;
      else
         return False;
      end if;
   end Transitioned;

   procedure Flush (State : in out Storage) is
      Last_Switched : State_Type;
   begin
      if not State_Queue.Is_Empty (State.Set_Queue) then
         --  Если были запросы на смену состояния
         --  То забираем данные из последнего запроса
         for R of State.Set_Queue loop
            Last_Switched := R;
         end loop;
         if State.Current /= Last_Switched then
            State.Switched := True;
            State.Previous := State.Current;
            State.Current  := Last_Switched;
         end if;
         State_Queue.Clear (State.Set_Queue);
      else
         if State.Switched then
            --  Этот флаг установлен, если в предыдущем кадре состояние изменилось
            --  Его нужно сбросить, если в этом кадре оно не изменилось
            State.Switched := False;
         end if;
      end if;
   end Flush;

end TECS.State;
