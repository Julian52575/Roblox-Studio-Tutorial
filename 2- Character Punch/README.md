# 2- Player punching attack

## What we will learn

- Script and LocalScript 
- Client / Server interaction using RemoteEvent and Ownership
- Hitbox collision
- Character animation
- Scheduling code execution

## What you need to know

> [!TIP]
> If you want to get to work, [go there](#Working) and come back when you need help  
> I'll link to these entry when they become relevant 🤓  

### Characters 

<img width="282" height="302" alt="Model" src="https://github.com/Julian52575/Roblox-Studio-Tutorial/blob/2-2--character-punching/2-%20Character%20Punch/images/CharacterModel.png" />  

Factually speaking, A "Character" is a [`Model`](https://create.roblox.com/docs/reference/engine/classes/Model) that hosts a [`Humanoid`](https://create.roblox.com/docs/reference/engine/classes/Humanoid).  
It it also composed of many `MeshPart` for displaying the limbs and `HumanoidRootPart`, a [`Part`](https://create.roblox.com/docs/reference/engine/classes/Part) for use in scripts.  

---
### Clients and Server

A client is the software running locally for the player usage. _IE: Roblox and Roblox Studio._  
A server is a software running online, that arbitrate the game by communicating updates to connected clients and (idealy) prevent cheating.  

#### How is it handled in Roblox Studio ?

Roblox offers to host game on their servers for free ! Most of the work is automatically done by their systems.  
Any update on objects inside the [`Workspace`](https://create.roblox.com/docs/reference/engine/classes/Workspace) will automatically be replicated on all clients by the server.  

> [!IMPORTANT]
> Communications between Server and Clients can be delayed by many factors.  
> Keep in mind the possible time difference between client queries and server action.

#### Ownership

To smoothen operation and avoid lags, different parts are owned by either the server or the client.  
The server will tell all clients about updates on objects it owns, and ask the owner about objects it doesn't own.  
By default, A Player's [`Character`](#Characters) is owned by their client. This allow updates based on the player's input.  

> [!TIP]
> Set the [`Ownership`](https://create.roblox.com/docs/reference/engine/classes/BasePart#SetNetworkOwner) of the player to the server in your scripts to reduce lags.

> [!TIP]
> Read the wikipedia pages if you want to know more: [server](https://en.wikipedia.org/wiki/Game_server), [client](https://en.wikipedia.org/wiki/Game_client)


---
### RemoteEvent

<img alt="RemoteEvent" src="https://github.com/Julian52575/Roblox-Studio-Tutorial/blob/2-2--character-punching/2-%20Character%20Punch/images/RemoteEvent.png">  

A [`RemoteEvent`](https://create.roblox.com/docs/reference/engine/classes/RemoteEvent) allows communication between Clients and Server.  
One party will fire it, and the other will listen and react to the fire.  

> [!TIP]
> A [`RemoteFunction`](https://create.roblox.com/docs/reference/engine/classes/RemoteFunction) allows the other party to reply to the event.
> We only need one-way communication from client to server for now.

---
### Roblox Lua Programming

> [!TIP]
> If you are already familiar with lua programming for Roblox Studio, you can skip this part.  
> If not, you can check this [`official guide`](https://create.roblox.com/docs/scripting) to understand the following code better.  

---
### Workspace VS Players

[`Workspace`](https://create.roblox.com/docs/reference/engine/classes/Workspace) hosts game objects, such as the body parts and the Humanoid while [`Players`](https://create.roblox.com/docs/reference/engine/classes/Players) hosts the players' scripts and UIs.  
<img alt="WorkspaceVSPlayers" src="https://github.com/Julian52575/Roblox-Studio-Tutorial/blob/2-2--character-punching/2-%20Character%20Punch/images/Player.png">

---
### ReplicatedStorage, ServerScriptService, StarterPlayerScripts and Scripts/LocalScripts

[`ReplicatedStorage`](https://create.roblox.com/docs/reference/engine/classes/ReplicatedStorage) is shared between clients and server.  

[`StartedPlayerScripts`](https://create.roblox.com/docs/reference/engine/classes/StarterPlayerScripts) is a folder of your game that allow you to write [`LocalScript`](https://create.roblox.com/docs/reference/engine/classes/LocalScript) that will be applied to every Player that joins.  
It will be copied into the `PlayerScripts` folder of each Player's folder inside the `Players` folder _(look at the screenshot right over)_.  

[`ServerScriptService`](https://create.roblox.com/docs/reference/engine/classes/ServerScriptService) is a folder that can only be accessed by the Server.  

> [!IMPORTANT]
> `LocalScripts` can only be used inside `StartedPlayerScripts` and `StarterGui`.  
> `Scripts` can only be used inside `ServerScriptService`.

---
## Working

For this task, we will create:
  - 1 `LocalScript` inside .  
  - 1 `Scripts` inside 
  - 1 `RemoteEvent` for interacting between these two

WIP...












