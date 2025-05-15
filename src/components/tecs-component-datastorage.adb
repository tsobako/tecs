package body Tecs.Component.DataStorage is

   procedure Add
     (Components : in out Storage; Id : Tecs.EntityId; A : Element_Type)
   is
   begin
      Component_Storage.Include (Components.Data, Id, A);
      EntityId_Set.Insert (Components.Current_Added, Id);
   end Add;

   procedure Update
     (Components : in out Storage; Id : Tecs.EntityId; A : Element_Type)
   is
   begin
      Component_Storage.Include (Components.Data, Id, A);
      EntityId_Set.Include (Components.Current_Updated, Id);
   end Update;

   function Get (Components : Storage; Id : Tecs.EntityId) return Element_Type
   is
   begin
      return Component_Storage.Element (Components.Data, Id);
   end Get;

   function Contains (Components : Storage; Id : Tecs.EntityId) return Boolean
   is
   begin
      return Component_Storage.Contains (Components.Data, Id);
   end Contains;

   function Get_All
     (Components : Storage) return Tecs.EntityVectorPackage.Vector
   is
      Result : Tecs.EntityVectorPackage.Vector;
   begin
      for C in Components.Data.Iterate loop
         Tecs.EntityVectorPackage.Append (Result, Component_Storage.Key (C));
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

   function Get_Entity (Cursor : Entity_Cursor) return Tecs.EntityId is
   begin
      return Component_Storage.Key (Cursor.Data);
   end Get_Entity;

   function Get_Component_Data (Cursor : Entity_Cursor) return Element_Type is
   begin
      return Component_Storage.Element (Cursor.Data);
   end Get_Component_Data;

   procedure Remove (Components : in out Storage; Id : Tecs.EntityId) is
   begin
      Component_Storage.Delete (Components.Data, Id);
      EntityId_Set.Insert (Components.Current_Removed, Id);
   end Remove;

   function Added
     (Components : in out Storage; Id : Tecs.EntityId) return Boolean
   is
   begin
      return EntityId_Set.Contains (Components.Before_Added, Id);
   end Added;
   function Updated
     (Components : in out Storage; Id : Tecs.EntityId) return Boolean
   is
   begin
      return EntityId_Set.Contains (Components.Before_Updated, Id);
   end Updated;
   function Removed
     (Components : in out Storage; Id : Tecs.EntityId) return Boolean
   is
   begin
      return EntityId_Set.Contains (Components.Before_Removed, Id);
   end Removed;

   procedure Flush (Components : in out Storage) is
   begin

      EntityId_Set.Clear (Components.Before_Added);
      EntityId_Set.Clear (Components.Before_Updated);
      EntityId_Set.Clear (Components.Before_Removed);

      for E of Components.Current_Added loop
         EntityId_Set.Include (Components.Before_Added, E);
      end loop;

      for E of Components.Current_Updated loop
         EntityId_Set.Include (Components.Before_Updated, E);
      end loop;

      for E of Components.Current_Removed loop
         EntityId_Set.Include (Components.Before_Removed, E);
      end loop;

      EntityId_Set.Clear (Components.Current_Added);
      EntityId_Set.Clear (Components.Current_Updated);
      EntityId_Set.Clear (Components.Current_Removed);

   end Flush;

end Tecs.Component.DataStorage;
