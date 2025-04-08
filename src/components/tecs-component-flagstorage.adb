package body TECS.Component.FlagStorage is

   procedure Add (Components : in out Storage; Id : TECS.EntityId) is
   begin
      Component_Storage.Insert (Components.To_Add, Id);
   end Add;

   function Contains (Components : Storage; Id : TECS.EntityId) return Boolean
   is
   begin
      return Component_Storage.Contains (Components.Data, Id);
   end Contains;

   function Get_All
     (Components : Storage) return TECS.EntityVectorPackage.Vector
   is
      Result : TECS.EntityVectorPackage.Vector;
   begin
      for Id of Components.Data loop
         TECS.EntityVectorPackage.Append (Result, Id);
      end loop;
      return Result;
   end Get_All;

   function Get_Cursor (Components : Storage) return Entity_Cursor is
   begin
      return (Data => Component_Storage.First (Components.Data));
   end Get_Cursor;

   function Has_Element (Cursor : Entity_Cursor) return Boolean is
   begin
      return Component_Storage.Has_Element (Cursor.Data);
   end Has_Element;

   procedure Next (Cursor : in out Entity_Cursor) is
   begin
      Component_Storage.Next (Cursor.Data);
   end Next;

   function Get_Entity (Cursor : Entity_Cursor) return TECS.EntityId is
   begin
      return Component_Storage.Element (Cursor.Data);
   end Get_Entity;

   procedure Remove (Components : in out Storage; Id : TECS.EntityId) is
   begin
      Component_Storage.Insert (Components.To_Remove, Id);
   end Remove;

   function Added (Components : Storage; Id : TECS.EntityId) return Boolean is
   begin
      return Component_Storage.Contains (Components.Current_Added, Id);
   end Added;

   function Removed (Components : Storage; Id : TECS.EntityId) return Boolean is
   begin
      return Component_Storage.Contains (Components.Current_Removed, Id);
   end Removed;

   procedure Flush (Components : in out Storage) is
   begin
      Component_Storage.Clear (Components.Current_Added);
      Component_Storage.Clear (Components.Current_Removed);
      for Id_Added of Components.To_Add loop
         Component_Storage.Insert (Components.Data, Id_Added);
         Component_Storage.Insert (Components.Current_Added, Id_Added);
      end loop;
      Component_Storage.Clear (Components.To_Add);

      for Id_Removed of Components.To_Remove loop
         Component_Storage.Delete (Components.Data, Id_Removed);
         Component_Storage.Insert (Components.Current_Removed, Id_Removed);
      end loop;
      Component_Storage.Clear (Components.To_Remove);

   end Flush;

end TECS.Component.FlagStorage;
