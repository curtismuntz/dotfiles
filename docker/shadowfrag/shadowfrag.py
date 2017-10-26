#!/usr/bin/env python3

import os
import glob
from moviepy.editor import VideoFileClip, concatenate_videoclips
import argparse

def getSortedClipsFromDir(directory):
    clips = list(filter(os.path.isfile, glob.glob(directory + "*.mp4")))
    clips.sort(key=lambda x: os.path.getmtime(x))
    return clips

def create_video(input_dir, output_dir):
    clips = getSortedClipsFromDir(input_dir)
    all_clips_in_dir = [None] * len(clips)
    for (i, clip) in enumerate(clips):
        print(clip)
        all_clips_in_dir[i] = VideoFileClip(clip)

    out_path = output_dir+"out.mp4"
    final_clip = concatenate_videoclips(all_clips_in_dir)
    final_clip.write_videofile(out_path,
      codec='libx264',
      audio_codec='aac',
      temp_audiofile='/tmp/temp-audio.m4a',
      remove_temp=True
    )

def sanitize_path(path_name):
    # Makes sure that the path has
    return os.path.join(os.path.expanduser(path_name),'')

def main():
    arg_parser = argparse.ArgumentParser(
            description="Combines all videos in a directory into a single video")
    arg_parser.add_argument("--input_dir", "-i", default=".", required=True,
                            help="The directory containing all your sweet frags")
    arg_parser.add_argument("--output_dir", "-o", default=".",
                            help="The output directory to export fragtage to")

    args = arg_parser.parse_args()
    input_dir = sanitize_path(args.input_dir)
    output_dir = sanitize_path(args.output_dir)

    create_video(input_dir, output_dir)

if __name__ == "__main__":
    main()
