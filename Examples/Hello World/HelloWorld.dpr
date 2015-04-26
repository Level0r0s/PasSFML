program HelloWorld;

{$R *.res}

uses
  SysUtils,
  SfmlAudio in '..\..\Source\SfmlAudio.pas',
  SfmlGraphics in '..\..\Source\SfmlGraphics.pas',
  SfmlNetwork in '..\..\Source\SfmlNetwork.pas',
  SfmlSystem in '..\..\Source\SfmlSystem.pas',
  SfmlWindow in '..\..\Source\SfmlWindow.pas';

var
  Mode: TSfmlVideoMode;
  Window: PSfmlRenderWindow;
  Texture: PSfmlTexture;
  Sprite: PSfmlSprite;
  Font: PSfmlFont;
  Text: PSfmlText;
  Music: PSfmlMusic;
  Event: TSfmlEvent;
  TextPos: TSfmlVector2f;
begin
  Mode.Width := 800;
  Mode.Height := 600;
  Mode.BitsPerPixel := 32;
  if SfmlVideoModeIsValid(Mode) = sfFalse then
    raise Exception.Create('Invalid video mode');

  Window := SfmlRenderWindowCreate(Mode, 'SFML Window', [sfResize, sfClose], nil);
  if not Assigned(Window) then
    raise Exception.Create('Window error');

  // Load a sprite to display
  Texture := SfmlTextureCreateFromFile('../Resources/OncaPintada.jpg', nil);
  if not Assigned(Texture) then
    raise Exception.Create('Texture error');
  Sprite := SfmlSpriteCreate;
  SfmlSpriteSetTexture(Sprite, texture, sfTrue);

  // Create a graphical text to display
  Font := SfmlFontCreateFromFile('../Resources/AdmirationPains.ttf');
  if not Assigned(Font) then
    raise Exception.Create('Font error');
  Text := SfmlTextCreate;
  SfmlTextSetString(Text, 'Hello World');
  SfmlTextSetFont(Text, Font);
  SfmlTextSetCharacterSize(Text, 50);
  SfmlTextSetColor(Text, SfmlBlack);
  TextPos.X := 300;
  TextPos.Y := 20;
  SfmlTextSetPosition(Text, TextPos);

  // Load a music to play
  Music := SfmlMusicCreateFromFile('../Resources/OncaPintada.ogg');
  if not Assigned(Music) then
    raise Exception.Create('Music error');

  // Play the music
  SfmlMusicPlay(Music);

  // Start the game loop
  while SfmlRenderWindowIsOpen(Window) = sfTrue do
  begin
    // Process events
    while SfmlRenderWindowPollEvent(Window, @Event) = sfTrue do
    begin
      // Close window : exit
      if Event.EventType = sfEvtClosed then
        SfmlRenderWindowClose(Window);
    end;

    // Clear the screen
    SfmlRenderWindowClear(Window, SfmlWhite);

    // Draw the sprite
    SfmlRenderWindowDrawSprite(Window, Sprite, nil);

    // Draw the text
    SfmlRenderWindowDrawText(Window, Text, nil);

    // Update the window
    SfmlRenderWindowDisplay(Window);
  end;

  // Cleanup resources
  SfmlMusicStop(Music);
  SfmlMusicDestroy(Music);
  SfmlTextDestroy(Text);
  SfmlFontDestroy(Font);
  SfmlSpriteDestroy(Sprite);
  SfmlTextureDestroy(Texture);
  SfmlRenderWindowDestroy(Window);
end.