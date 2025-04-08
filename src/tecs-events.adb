package body TECS.Events is

   procedure Add (S : in out Storage; E : Event_Type) is
   begin
      Events_Storage.Append (S.Buffer, E);
   end Add;

   function Get_All (S : Storage) return Events_Vector is
      Result : Events_Vector;
   begin
      for E of S.Current loop
         Events_Storage.Append (Result, E);
      end loop;
      return Result;
   end Get_All;

   procedure Flush (S : in out Storage) is
   begin
      Events_Storage.Clear (S.Current);
      for E of S.Buffer loop
         Events_Storage.Append (S.Current, E);
      end loop;
      Events_Storage.Clear (S.Buffer);
   end Flush;

   function Contains (S : Storage; E : Event_Type) return Boolean is
   begin
      for Ev of S.Current loop
         if Ev = E then
            return True;
         end if;
      end loop;
      return False;
   end Contains;

end TECS.Events;
