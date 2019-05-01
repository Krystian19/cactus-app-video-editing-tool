import ffmpeg
import moviepy.editor as mp

OUTPUT_FILE='output2.mp4'
overlay_file = ffmpeg.input('logo.png')

"""
Download video file
"""
stream = ffmpeg.input('https://dl.v.vrv.co//evs//d5055c18f0b1527048f3384edf9eef90//assets//d1d073c012e531ad06ffede657189492_,3654217.mp4,3654219.mp4,3654215.mp4,3654211.mp4,3654213.mp4,.urlset//master.m3u8?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cCo6Ly9kbC52LnZydi5jby9ldnMvZDUwNTVjMThmMGIxNTI3MDQ4ZjMzODRlZGY5ZWVmOTAvYXNzZXRzL2QxZDA3M2MwMTJlNTMxYWQwNmZmZWRlNjU3MTg5NDkyXywzNjU0MjE3Lm1wNCwzNjU0MjE5Lm1wNCwzNjU0MjE1Lm1wNCwzNjU0MjExLm1wNCwzNjU0MjEzLm1wNCwudXJsc2V0L21hc3Rlci5tM3U4IiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNTU2NjcxODQ0fX19XX0_&Signature=PZJwwVxAvatNuDnTBCoxw8To5e4RWWOizlr0tucqyV07KtQpziMjidSVqlrWAk94A5x1UkIw8cYHT~PxxOS6iu~S97puI6v1ui8kCR~~rsJyA3sYyPxnP08PukCv4qF0PRW9kwl9B7Gi7yyoIGAeVpJn6wMTyuWSXT20j0p3EsPiA5T~PIL1vx3T7M8X~l-YWZUBrfES3S5m2Fqh38qCDbhIg-Dyrr70GZpbZWuqMdml709WLt-adLF3N-BsEk9PrUzYzPajJw1lqjv89tT7kdQZvzgwOnnCtM1ZJVx4o9xKQHNpj1Mb~yT8EcJS~8D8cv9GYUHJuUu~qrAg-u0WHA__&Key-Pair-Id=DLVR')
stream = ffmpeg.output(OUTPUT_FILE)
ffmpeg.overlay(overlay_file.eof_action=)
ffmpeg.run(stream)

# """
# Include logo inside the video file
# """
# video = mp.VideoFileClip(OUTPUT_FILE)
# logo = (mp.ImageClip("logo.png")
#           .set_duration(video.duration)
#           .resize(height=70) # if you need to resize...
#           .margin(right=24, bottom=24, opacity=0) # (optional) logo-border padding
#           .set_pos(("right","bottom")))

# final = mp.CompositeVideoClip([video, logo])
# # # final.subclip(1000,1010).write_videofile("test.mp4")
# # final.write_videofile(OUTPUT_FILE, codec='libx264', audio_codec='aac')
# final.write_videofile(OUTPUT_FILE, codec='libx264', audio_codec='aac')
