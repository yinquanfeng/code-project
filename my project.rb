# Set the tempo
use_bpm 120

# Define the scale and choose a synth for the melody
melody_notes = scale(:c4, :minor_pentatonic, num_octaves: 2)
use_synth :prophet

# Function to play the melody
define :play_melody do
  8.times do
    play melody_notes.choose, release: 0.1, cutoff: rrand(70, 130)
    sleep 0.25
  end
end

# Chord progression
chords = [chord(:d4, :minor7), chord(:ab3, :major7), chord(:f3, :minor7), chord(:g3, :dom7)]
chord_inversion = 0 # Change this for different inversions

# Function to play chords
define :play_chords do
  chords.each do |chord|
    play chord.choose, release: 4, cutoff: rrand(70, 130), invert_chord: chord_inversion
    sleep 1
  end
end

# Function to play the bass
define :play_bass do
  use_synth :tb303
  play :c2, release: 4, cutoff: rrand(60, 110)
  sleep 4
end

# Define the drums
define :play_drums do
  sample :bd_tek, rate: 0.8
  sleep 0.5
  sample :sn_dolf
  sleep 0.5
  sample :bd_tek, rate: 0.8
  sleep 0.25
  sample :drum_cymbal_closed, sustain: 0.1, release: 0.1
  sleep 0.25
end

# Define a breakdown drum pattern
define :play_breakdown_drums do
  sample :bd_boom, amp: 0.5
  sleep 1
  sample :sn_zome
  sleep 1
  sample :bd_boom, amp: 0.5
  sleep 1
end

# Live loops
live_loop :melody do
  play_melody
end

live_loop :chords do
  play_chords
end

live_loop :bass_line do
  play_bass
end

live_loop :drums do
  play_drums
end

# After 4 iterations, switch to the breakdown drums
live_loop :breakdown_drums do
  4.times do
    sleep 32
  end
  play_breakdown_drums
end