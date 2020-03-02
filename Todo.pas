program Todo;

{$mode objfpc}

uses
  JS, Classes, SysUtils, Web;

type
  task = record
    name: String;
    completed: Boolean;
  end;

var
  newTaskName: String;
  tasks: array[0 .. 100] of task;
  numberOfTasks: Integer;
  listElement, inputElement, submitButton: TJSElement;

procedure SortByCompleted();
var result: array[0 .. 100] of task;
    cur, i: Integer;
begin
  cur := 0;
  for i := 0 to numberOfTasks do
  begin
    if tasks[i].completed then
    begin
      result[cur] := tasks[i];
      Inc(cur);
    end;
  end;
  for i := 0 to numberOfTasks do
  begin
    if not tasks[i].completed then
    begin
      result[cur] := tasks[i];
      Inc(cur);
    end;
  end;
  for i := 0 to numberOfTasks do tasks[i] := result[i];
end;

procedure Blit();
var taskElement: TJSElement;
    i: Integer;
function ToggleTask(Event: TEventListenerEvent): Boolean;
var index: Integer;
begin
    index := integer(Event.target.Properties['id']);
    tasks[index].completed := not tasks[index].completed;
    Blit();
    ToggleTask := true;
end;
begin
  SortByCompleted();
  listElement.innerHTML := '';
  for i := 0 to numberOfTasks - 1 do
  begin
    taskElement := document.createElement('a');
    taskElement.textContent := tasks[i].name;
    taskElement.classList.add('list-group-item');
    taskElement.classList.add('list-group-item-action');
    taskElement.setAttribute('id', IntToStr(i));
    taskElement.addEventListener('click', @ToggleTask);
    if tasks[i].completed then
       taskElement.classList.add('disabled');
    listElement.insertBefore(taskElement, listElement.firstChild);
  end;
end;

function AddTask(Event: TEventListenerEvent): Boolean;
begin
  tasks[numberOfTasks].name := newTaskName;
  tasks[numberOfTasks].completed := false;
  Inc(numberOfTasks);
  Blit();
  AddTask := true;
end;

function OnTextChange(Event: TEventListenerEvent): Boolean;
begin
  newTaskName := string(Event.target.Properties['value']);
  inputElement.setAttribute('value', newTaskName);
end;

begin
  WriteLn('Hello world');
  listElement := document.querySelector('#list');
  inputElement := document.querySelector('#newTaskInput');
  inputElement.addEventListener('input', @OnTextChange);
  submitButton := document.querySelector('#submitButton');
  submitButton.addEventListener('click', @AddTask);
  Blit();
end.
