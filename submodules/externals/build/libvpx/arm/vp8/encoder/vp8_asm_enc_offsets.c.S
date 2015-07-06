	.arch armv5te
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"vp8_asm_enc_offsets.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
.LFB90:
	.file 1 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c"
	.loc 1 20 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 23 0
#APP
@ 23 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_block_coeff EQU #4
@ 0 "" 2
	.loc 1 24 0
@ 24 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_block_zbin EQU #20
@ 0 "" 2
	.loc 1 25 0
@ 25 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_block_round EQU #28
@ 0 "" 2
	.loc 1 26 0
@ 26 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_block_quant EQU #8
@ 0 "" 2
	.loc 1 27 0
@ 27 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_block_quant_fast EQU #12
@ 0 "" 2
	.loc 1 28 0
@ 28 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_block_zbin_extra EQU #32
@ 0 "" 2
	.loc 1 29 0
@ 29 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_block_zrun_zbin_boost EQU #24
@ 0 "" 2
	.loc 1 30 0
@ 30 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_block_quant_shift EQU #16
@ 0 "" 2
	.loc 1 32 0
@ 32 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_blockd_qcoeff EQU #0
@ 0 "" 2
	.loc 1 33 0
@ 33 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_blockd_dequant EQU #12
@ 0 "" 2
	.loc 1 34 0
@ 34 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_blockd_dqcoeff EQU #4
@ 0 "" 2
	.loc 1 35 0
@ 35 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_blockd_eob EQU #20
@ 0 "" 2
	.loc 1 38 0
@ 38 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_block_base_src EQU #36
@ 0 "" 2
	.loc 1 39 0
@ 39 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_block_src EQU #40
@ 0 "" 2
	.loc 1 40 0
@ 40 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_block_src_diff EQU #0
@ 0 "" 2
	.loc 1 41 0
@ 41 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_block_src_stride EQU #44
@ 0 "" 2
	.loc 1 43 0
@ 43 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_blockd_predictor EQU #8
@ 0 "" 2
	.loc 1 46 0
@ 46 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_writer_lowvalue EQU #0
@ 0 "" 2
	.loc 1 47 0
@ 47 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_writer_range EQU #4
@ 0 "" 2
	.loc 1 48 0
@ 48 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_writer_count EQU #8
@ 0 "" 2
	.loc 1 49 0
@ 49 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_writer_pos EQU #12
@ 0 "" 2
	.loc 1 50 0
@ 50 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_writer_buffer EQU #16
@ 0 "" 2
	.loc 1 51 0
@ 51 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_writer_buffer_end EQU #20
@ 0 "" 2
	.loc 1 52 0
@ 52 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_writer_error EQU #24
@ 0 "" 2
	.loc 1 54 0
@ 54 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
tokenextra_token EQU #6
@ 0 "" 2
	.loc 1 55 0
@ 55 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
tokenextra_extra EQU #4
@ 0 "" 2
	.loc 1 56 0
@ 56 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
tokenextra_context_tree EQU #0
@ 0 "" 2
	.loc 1 57 0
@ 57 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
tokenextra_skip_eob_node EQU #7
@ 0 "" 2
	.loc 1 58 0
@ 58 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
TOKENEXTRA_SZ EQU #8
@ 0 "" 2
	.loc 1 60 0
@ 60 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_extra_bit_struct_sz EQU #16
@ 0 "" 2
	.loc 1 62 0
@ 62 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_token_value EQU #0
@ 0 "" 2
	.loc 1 63 0
@ 63 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_token_len EQU #4
@ 0 "" 2
	.loc 1 65 0
@ 65 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_extra_bit_struct_tree EQU #0
@ 0 "" 2
	.loc 1 66 0
@ 66 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_extra_bit_struct_prob EQU #4
@ 0 "" 2
	.loc 1 67 0
@ 67 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_extra_bit_struct_len EQU #8
@ 0 "" 2
	.loc 1 68 0
@ 68 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_extra_bit_struct_base_val EQU #12
@ 0 "" 2
	.loc 1 70 0
@ 70 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_comp_tplist EQU #139872
@ 0 "" 2
	.loc 1 71 0
@ 71 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_comp_common EQU #105664
@ 0 "" 2
	.loc 1 72 0
@ 72 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_comp_bc EQU #110880
@ 0 "" 2
	.loc 1 73 0
@ 73 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_writer_sz EQU #36
@ 0 "" 2
	.loc 1 75 0
@ 75 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
tokenlist_start EQU #0
@ 0 "" 2
	.loc 1 76 0
@ 76 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
tokenlist_stop EQU #4
@ 0 "" 2
	.loc 1 77 0
@ 77 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
TOKENLIST_SZ EQU #8
@ 0 "" 2
	.loc 1 79 0
@ 79 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c" 1
	
vp8_common_mb_rows EQU #2424
@ 0 "" 2
	.loc 1 81 0
	mov	r0, #0
	bx	lr
	.cfi_endproc
.LFE90:
	.size	main, .-main
	.text
.Letext0:
	.file 2 "/home/william/linphone/linphone-android/submodules/externals/libvpx/vp8/encoder/boolhuff.h"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0xd2
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF14
	.byte	0x1
	.4byte	.LASF15
	.4byte	.LASF16
	.4byte	.Ldebug_ranges0+0
	.4byte	0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF0
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.4byte	.LASF1
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF2
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.4byte	.LASF3
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.4byte	.LASF4
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.4byte	.LASF5
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.4byte	.LASF6
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF7
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.4byte	.LASF8
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF9
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF10
	.uleb128 0x3
	.byte	0x8
	.byte	0x4
	.4byte	.LASF11
	.uleb128 0x4
	.4byte	0x3a
	.4byte	0x90
	.uleb128 0x5
	.4byte	0x5d
	.byte	0xff
	.byte	0
	.uleb128 0x6
	.4byte	.LASF17
	.byte	0x1
	.byte	0x14
	.4byte	0x25
	.4byte	.LFB90
	.4byte	.LFE90-.LFB90
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x4
	.4byte	0x2c
	.4byte	0xb5
	.uleb128 0x5
	.4byte	0x5d
	.byte	0xff
	.byte	0
	.uleb128 0x7
	.4byte	.LASF12
	.byte	0x2
	.byte	0x2c
	.4byte	0xc0
	.uleb128 0x8
	.4byte	0xa5
	.uleb128 0x7
	.4byte	.LASF13
	.byte	0x2
	.byte	0x2f
	.4byte	0xd0
	.uleb128 0x8
	.4byte	0x80
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.LFB90
	.4byte	.LFE90-.LFB90
	.4byte	0
	.4byte	0
	.section	.debug_ranges,"",%progbits
.Ldebug_ranges0:
	.4byte	.LFB90
	.4byte	.LFE90
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF5:
	.ascii	"long long int\000"
.LASF0:
	.ascii	"unsigned int\000"
.LASF16:
	.ascii	"/home/william/linphone/linphone-android/submodules/"
	.ascii	"externals/build/libvpx/arm\000"
.LASF17:
	.ascii	"main\000"
.LASF10:
	.ascii	"long unsigned int\000"
.LASF12:
	.ascii	"vp8_prob_cost\000"
.LASF14:
	.ascii	"GNU C 4.8 -mbionic -mtune=cortex-a8 -march=armv5te "
	.ascii	"-mfloat-abi=soft -mfpu=vfp -mtls-dialect=gnu -g -O3"
	.ascii	" -fPIC\000"
.LASF9:
	.ascii	"char\000"
.LASF6:
	.ascii	"long long unsigned int\000"
.LASF2:
	.ascii	"unsigned char\000"
.LASF13:
	.ascii	"vp8_norm\000"
.LASF15:
	.ascii	"/home/william/linphone/linphone-android/submodules/"
	.ascii	"externals/libvpx/vp8/encoder/vp8_asm_enc_offsets.c\000"
.LASF8:
	.ascii	"long int\000"
.LASF11:
	.ascii	"double\000"
.LASF4:
	.ascii	"short unsigned int\000"
.LASF1:
	.ascii	"signed char\000"
.LASF3:
	.ascii	"short int\000"
.LASF7:
	.ascii	"sizetype\000"
	.ident	"GCC: (GNU) 4.8"
	.section	.note.GNU-stack,"",%progbits
