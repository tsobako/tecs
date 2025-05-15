package body Tecs is

   procedure Next_EntityId (Storage : in out EntityStorage; Id : out EntityId)
   is
   begin
      Id := Storage.CurrentEntityId;
      Entities.Insert (Storage.Storage, Id);
      Storage.CurrentEntityId := Storage.CurrentEntityId + 1;
   end Next_EntityId;

   function IsEntityAlive
     (Storage : EntityStorage; Id : EntityId) return Boolean
   is
   begin
      return
        Entities.Contains (Storage.Storage, Id)
        and then not Entities.Contains (Storage.Deleted, Id);
   end IsEntityAlive;

   procedure DeleteEntity (Storage : in out EntityStorage; Id : EntityId) is
   begin
      Entities.Delete (Storage.Storage, Id);
      Entities.Insert (Storage.Deleted, Id);
   end DeleteEntity;

   function GetDeletedEntities
     (Storage : EntityStorage) return EntityVectorPackage.Vector
   is
      Result : EntityVectorPackage.Vector := EntityVectorPackage.Empty_Vector;
   begin
      for Id of Storage.Deleted loop
         EntityVectorPackage.Append (Result, Id);
      end loop;
      return Result;
   end GetDeletedEntities;

   procedure Maintain (Storage : in out EntityStorage) is
   begin
      Entities.Clear (Storage.Deleted);
   end Maintain;

   function EntityIdHash (Element : EntityId) return Ada.Containers.Hash_Type
   is
   begin
      return Ada.Containers.Hash_Type (Element);
   end EntityIdHash;

   function EntityIdEquivalent_Elements (Left, Right : EntityId) return Boolean
   is
   begin
      return Left = Right;
   end EntityIdEquivalent_Elements;

end Tecs;
