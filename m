Return-Path: <linux-pci+bounces-40431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 926F7C380C1
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 22:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B3894F8EDA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 21:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF21B2D9EDB;
	Wed,  5 Nov 2025 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiznFV24"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5634D2C3272;
	Wed,  5 Nov 2025 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378290; cv=none; b=uh8GA9I0NbHQBaENM7n6uWQaP1rLAIu7fTMS1GT/klz1YtZ9QpuK/x32x7Og1/bwJpxFdYUYp3PXR1YC3oFLoLDL10yQq+KwZBccLQXrs3wLrn+sIjv1u2+xNuWM+HxyehLoTNMI4wxHQ6wUtFhXUqwsDrioQQoADDGxF3Qmcf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378290; c=relaxed/simple;
	bh=p42itfJxghARSJNT+Xe14abj9vuheZEymnrKYNJFU18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNSuCW87BpkMDxzEyKXH2nsKQMcONLl/9g2lh4jBbr6zwvQ9AbtfjDyIJZURqhXk2bvCO5mNok8tRDnfOQ5ztAl/HhGhYKT0Gw2ChFySg7uFwEyss7jhKIYubaGgmrzXzTv0WA1rjsxVANadlIgMuI7+Rv32FOArrV2rh9Bb4Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiznFV24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA19CC116C6;
	Wed,  5 Nov 2025 21:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762378289;
	bh=p42itfJxghARSJNT+Xe14abj9vuheZEymnrKYNJFU18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MiznFV24zbIQBWf+WokGOg3j8AhQiJf9mmMpmATnZcfudV3xIaszIGZNcEtUXfbSx
	 aeLpTJ9dSnyd8Fdw2YHj2d20RFKoOHvmzaVZB0X56NZbD/8KTKl7hKJcP39lU9rF8I
	 cxS0hHbncLzQcv/yay5qfSNZIm3P06iy17KzqBdwdQcuBfY1Dj7hscZ7e8y6LoiraX
	 TNCCYGJeT6HNhW74SFtnUO4qc6zKCpNjbKPOBVtaciKwduK5NoArtkaAu47BU5Ipwo
	 lGEm1zHL2d2a5YA1cILnkREDN9KNeKnBrDuUrRQ9iyGzpXRLBq97ILZfac6gfobVmZ
	 irq1fwb/CbE8g==
Message-ID: <3772b8f5-6d1a-403e-ad27-99a711e78902@kernel.org>
Date: Wed, 5 Nov 2025 15:31:27 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION 00/04] Crash during resume of pcie bridge
To: Bert Karwatzki <spasswolf@web.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, regressions@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20251006120944.7880-1-spasswolf@web.de>
 <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
 <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de>
 <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
 <25f36fa7-d1d6-4b81-a42f-64c445d6f065@amd.com>
 <1853e2af7f70cf726df278137b6d2d89d9d9dc82.camel@web.de>
 <f18bafacbd8316c9623658e2935f8fc3b276af64.camel@web.de>
 <26bf82303f661cdd34e4e8c16997e33eb21d1ee4.camel@web.de>
 <635b6cb19b5969bed7432dfd1cd651124e63aebb.camel@web.de>
 <18e472a0489ee5337465d5dc26685cebaf7c4f8d.camel@web.de>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <18e472a0489ee5337465d5dc26685cebaf7c4f8d.camel@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/5/2025 5:44 AM, Bert Karwatzki wrote:
> I finally got a result from kdump regarding this bug. As I told I'm currently
> trying to bisect this (again ...) between v6.14 and v6.15. My test setup during
> overnight tests is to put on a long youtube video and then simulate some
> interactivity by running this script:
> 
> #!/bin/bash
> for i in {0..10000}
> do
>   echo $i
>   evolution &
>   sleep 3
>   killall evolution
>   sleep 27
> done
> 
> 
> I'm not done with the bisection, yet, but this night I got a result from kdump
> showing a NULL pointer dereference after a loss of the discrete GPU:
> (This may be a different bug though, as this did not result in a reboot
> but hang instead)

I think this is a different problem with how we handle cleanup from a 
GPU that disappeared.

FWIW we do have a lot of fixups past 6.14 in this area.  I also have 
done some failed suspend unwind code very recently that's going to 6.19 
that might help this.  I'm not sure if it's in drm-next yet, if it's not 
it will be soon!

Once you're done with your bisect I'd be really interested if you can 
still reproduce the splats and NULL pointer on the recovery path using 
amd-staging-drm-next.
> 
> faddr2line gives this regarding the NULL pointer:
> $ scripts/faddr2line drivers/gpu/drm/ttm/ttm_resource.o ttm_resource_move_to_lru_tail+0xc1/0xe0
> ttm_resource_move_to_lru_tail+0xc1/0xe0:
> list_add_tail at /mnt/data/linux-forest/mystery_shutdown/./include/linux/list.h:183
> (inlined by) list_move_tail at /mnt/data/linux-forest/mystery_shutdown/./include/linux/list.h:311
> (inlined by) ttm_resource_move_to_lru_tail at /mnt/data/linux-forest/mystery_shutdown/drivers/gpu/drm/ttm/ttm_resource.c:291
> 
> So I probably should use CONFIG_DEBUG_LIST from now on.
> 
> 
> [13600.900669] [    T140] pcieport 0000:00:01.1: pciehp: Slot(0): Link Down
> [13600.900678] [    T140] pcieport 0000:00:01.1: pciehp: Slot(0): Card not present
> [13600.971642] [  T53331] amdgpu 0000:03:00.0: amdgpu: SMU: response:0xFFFFFFFF for index:7 param:0x00000000 message:DisableAllSmuFeatures?
> [13600.971649] [  T53331] amdgpu 0000:03:00.0: amdgpu: Failed to disable smu features.
> [13600.971653] [  T53331] amdgpu 0000:03:00.0: amdgpu: SMU is in hanged state, failed to send smu message!
> [13600.971656] [  T53331] amdgpu 0000:03:00.0: amdgpu: [PrepareMp1] Failed!
> [13600.971658] [  T53331] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* SMC failed to set mp1 state 2, -121
> [13600.971779] [  T53331] amdgpu 0000:03:00.0: Unable to change power state from D0 to D3hot, device inaccessible
> [13600.971809] [    T140] amdgpu 0000:03:00.0: Unable to change power state from D3cold to D0, device inaccessible
> [13611.504805] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
> [13611.504924] [    T140] amdgpu 0000:03:00.0: amdgpu: smu driver if version = 0x0000000f, smu fw if version = 0x00000013, smu fw program = 0, version =
> 0x003b3100 (59.49.0)
> [13611.504930] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
> [13611.504933] [    T140] amdgpu 0000:03:00.0: amdgpu: dpm has been enabled
> [13611.504936] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
> [13611.664765] [    T140] amdgpu 0000:03:00.0: amdgpu: rlc autoload: gc ucode autoload timeout
> [13611.664771] [    T140] amdgpu 0000:03:00.0: amdgpu: resume of IP block <gfx_v10_0> failed -110
> [13611.664775] [    T140] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).
> [13611.665372] [  T32730] pcieport 0000:02:00.0: Unable to change power state from D0 to D3hot, device inaccessible
> [13611.666216] [  T32730] pcieport 0000:01:00.0: Unable to change power state from D0 to D3hot, device inaccessible
> [13611.763659] [    T140] amdgpu 0000:03:00.0: amdgpu: amdgpu: finishing device.
> [13611.763798] [    T140] ------------[ cut here ]------------
> [13611.763801] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13611.763924] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13611.763993] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13611.764031] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Not tainted 6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13611.764034] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13611.764036] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13611.764129] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13611.764132] [    T140] RSP: 0018:ffff9ac3c0743bf0 EFLAGS: 00010246
> [13611.764135] [    T140] RAX: ffff8c3200c40280 RBX: ffff8c3200dba000 RCX: 0000000000000000
> [13611.764137] [    T140] RDX: 0000000000000000 RSI: ffff8c3200dba008 RDI: ffff8c320a600000
> [13611.764139] [    T140] RBP: ffff8c3200dba000 R08: 0000000000000001 R09: 0000000000000000
> [13611.764141] [    T140] R10: 000000000040003f R11: 0000000000000000 R12: ffff8c320a600000
> [13611.764142] [    T140] R13: ffffffffc0be01a8 R14: ffffffffc0be01a8 R15: ffff9ac3c0743d6e
> [13611.764144] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13611.764146] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13611.764148] [    T140] CR2: 000055fcf3dd7e44 CR3: 0000000271a64000 CR4: 0000000000750ef0
> [13611.764150] [    T140] PKRU: 55555554
> [13611.764152] [    T140] Call Trace:
> [13611.764155] [    T140]  <TASK>
> [13611.764157] [    T140]  ? __warn.cold+0x90/0x9e
> [13611.764162] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13611.764248] [    T140]  ? report_bug+0xfa/0x140
> [13611.764253] [    T140]  ? handle_bug+0x53/0x90
> [13611.764256] [    T140]  ? exc_invalid_op+0x17/0x70
> [13611.764259] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13611.764263] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13611.764346] [    T140]  smu_smc_hw_cleanup+0x5e/0x3e0 [amdgpu]
> [13611.764460] [    T140]  smu_hw_fini+0xfb/0x1a0 [amdgpu]
> [13611.764573] [    T140]  amdgpu_ip_block_hw_fini+0x2b/0x59 [amdgpu]
> [13611.764699] [    T140]  amdgpu_device_fini_hw+0x1fe/0x2ad [amdgpu]
> [13611.764815] [    T140]  amdgpu_pci_remove+0x40/0x70 [amdgpu]
> [13611.764893] [    T140]  pci_device_remove+0x3d/0xb0
> [13611.764897] [    T140]  device_release_driver_internal+0x197/0x200
> [13611.764900] [    T140]  pci_stop_bus_device+0x68/0x80
> [13611.764904] [    T140]  pci_stop_bus_device+0x38/0x80
> [13611.764907] [    T140]  pci_stop_bus_device+0x27/0x80
> [13611.764909] [    T140]  pci_stop_and_remove_bus_device+0xd/0x20
> [13611.764912] [    T140]  pciehp_unconfigure_device+0x93/0x160
> [13611.764916] [    T140]  pciehp_disable_slot+0x62/0x100
> [13611.764919] [    T140]  pciehp_handle_presence_or_link_change+0x72/0x350
> [13611.764922] [    T140]  pciehp_ist+0x13b/0x180
> [13611.764925] [    T140]  irq_thread_fn+0x1e/0x60
> [13611.764929] [    T140]  irq_thread+0x114/0x1e0
> [13611.764932] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13611.764935] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13611.764938] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13611.764941] [    T140]  kthread+0xea/0x1e0
> [13611.764945] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13611.764948] [    T140]  ret_from_fork+0x2f/0x50
> [13611.764951] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13611.764954] [    T140]  ret_from_fork_asm+0x11/0x20
> [13611.764959] [    T140]  </TASK>
> [13611.764960] [    T140] ---[ end trace 0000000000000000 ]---
> [13611.764963] [    T140] amdgpu 0000:03:00.0: amdgpu: Fail to disable thermal alert!
> [13611.785004] [    T140] ------------[ cut here ]------------
> [13611.785008] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:510 amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
> [13611.785128] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13611.785216] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13611.785262] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13611.785266] [    T140] Tainted: [W]=WARN
> [13611.785268] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13611.785271] [    T140] RIP: 0010:amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
> [13611.785377] [    T140] Code: f6 ff ff 4d 85 e4 74 08 49 c7 04 24 00 00 00 00 48 85 ed 74 08 48 c7 45 00 00 00 00 00 5b 5d 41 5c 41 5d 41 5e e9 e7 49 b2 c5
> <0f> 0b e9 4b ff ff ff 3d 00 fe ff ff 0f 85 85 97 5d 00 eb bd 0f 1f
> [13611.785380] [    T140] RSP: 0018:ffff9ac3c0743bd0 EFLAGS: 00010202
> [13611.785384] [    T140] RAX: 0000000000000000 RBX: ffff8c320a63b830 RCX: 0000000080000000
> [13611.785386] [    T140] RDX: ffff8c320a63b880 RSI: ffff8c320a63b888 RDI: ffff8c320a63b830
> [13611.785389] [    T140] RBP: ffff8c320a63b880 R08: 0000000000000000 R09: 00000000ffffffea
> [13611.785391] [    T140] R10: ffff8c34e02fffa8 R11: 0000000000000003 R12: ffff8c320a63b888
> [13611.785393] [    T140] R13: ffff8c3205b49800 R14: ffff8c320a60ef80 R15: ffff9ac3c0743d6e
> [13611.785395] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13611.785398] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13611.785400] [    T140] CR2: 000055fcf3dd7e44 CR3: 0000000271a64000 CR4: 0000000000750ef0
> [13611.785403] [    T140] PKRU: 55555554
> [13611.785405] [    T140] Call Trace:
> [13611.785408] [    T140]  <TASK>
> [13611.785410] [    T140]  ? __warn.cold+0x90/0x9e
> [13611.785415] [    T140]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
> [13611.785530] [    T140]  ? report_bug+0xfa/0x140
> [13611.785535] [    T140]  ? handle_bug+0x53/0x90
> [13611.785540] [    T140]  ? exc_invalid_op+0x17/0x70
> [13611.785543] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13611.785548] [    T140]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
> [13611.785651] [    T140]  psp_v11_0_ring_destroy+0x2e/0x50 [amdgpu]
> [13611.785771] [    T140]  psp_hw_fini+0x126/0x380 [amdgpu]
> [13611.785856] [    T140]  amdgpu_ip_block_hw_fini+0x2b/0x59 [amdgpu]
> [13611.785974] [    T140]  amdgpu_device_fini_hw+0x1fe/0x2ad [amdgpu]
> [13611.786084] [    T140]  amdgpu_pci_remove+0x40/0x70 [amdgpu]
> [13611.786160] [    T140]  pci_device_remove+0x3d/0xb0
> [13611.786164] [    T140]  device_release_driver_internal+0x197/0x200
> [13611.786167] [    T140]  pci_stop_bus_device+0x68/0x80
> [13611.786170] [    T140]  pci_stop_bus_device+0x38/0x80
> [13611.786173] [    T140]  pci_stop_bus_device+0x27/0x80
> [13611.786175] [    T140]  pci_stop_and_remove_bus_device+0xd/0x20
> [13611.786178] [    T140]  pciehp_unconfigure_device+0x93/0x160
> [13611.786181] [    T140]  pciehp_disable_slot+0x62/0x100
> [13611.786184] [    T140]  pciehp_handle_presence_or_link_change+0x72/0x350
> [13611.786201] [    T140]  pciehp_ist+0x13b/0x180
> [13611.786204] [    T140]  irq_thread_fn+0x1e/0x60
> [13611.786208] [    T140]  irq_thread+0x114/0x1e0
> [13611.786211] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13611.786213] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13611.786216] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13611.786219] [    T140]  kthread+0xea/0x1e0
> [13611.786223] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13611.786226] [    T140]  ret_from_fork+0x2f/0x50
> [13611.786229] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13611.786232] [    T140]  ret_from_fork_asm+0x11/0x20
> [13611.786236] [    T140]  </TASK>
> [13611.786238] [    T140] ---[ end trace 0000000000000000 ]---
> [13611.787301] [    T140] ------------[ cut here ]------------
> [13611.787303] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:510 amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
> [13611.787382] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13611.787447] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13611.787494] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13611.787497] [    T140] Tainted: [W]=WARN
> [13611.787499] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13611.787501] [    T140] RIP: 0010:amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
> [13611.787578] [    T140] Code: f6 ff ff 4d 85 e4 74 08 49 c7 04 24 00 00 00 00 48 85 ed 74 08 48 c7 45 00 00 00 00 00 5b 5d 41 5c 41 5d 41 5e e9 e7 49 b2 c5
> <0f> 0b e9 4b ff ff ff 3d 00 fe ff ff 0f 85 85 97 5d 00 eb bd 0f 1f
> [13611.787580] [    T140] RSP: 0018:ffff9ac3c0743c00 EFLAGS: 00010202
> [13611.787583] [    T140] RAX: ffff8c34ba7a5d80 RBX: ffff8c320a614b60 RCX: 000000000000016f
> [13611.787585] [    T140] RDX: ffff8c320a614b68 RSI: ffff8c320a614b70 RDI: ffff8c320a614b60
> [13611.787586] [    T140] RBP: ffff8c320a614b68 R08: 00000000000056ee R09: 0000000000000009
> [13611.787588] [    T140] R10: 00000000000000b2 R11: 000000000000000a R12: ffff8c320a614b70
> [13611.787590] [    T140] R13: ffff8c320a6cb400 R14: ffff8c320a60ef80 R15: ffff9ac3c0743d6e
> [13611.787592] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13611.787594] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13611.787596] [    T140] CR2: 000055fcf3dd7e44 CR3: 0000000271a64000 CR4: 0000000000750ef0
> [13611.787597] [    T140] PKRU: 55555554
> [13611.787599] [    T140] Call Trace:
> [13611.787601] [    T140]  <TASK>
> [13611.787603] [    T140]  ? __warn.cold+0x90/0x9e
> [13611.787606] [    T140]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
> [13611.787691] [    T140]  ? report_bug+0xfa/0x140
> [13611.787695] [    T140]  ? handle_bug+0x53/0x90
> [13611.787699] [    T140]  ? exc_invalid_op+0x17/0x70
> [13611.787702] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13611.787707] [    T140]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
> [13611.787801] [    T140]  amdgpu_ih_ring_fini+0x4f/0x80 [amdgpu]
> [13611.787909] [    T140]  amdgpu_irq_fini_hw+0x2f/0x80 [amdgpu]
> [13611.788011] [    T140]  amdgpu_device_fini_hw+0x231/0x2ad [amdgpu]
> [13611.788156] [    T140]  amdgpu_pci_remove+0x40/0x70 [amdgpu]
> [13611.788249] [    T140]  pci_device_remove+0x3d/0xb0
> [13611.788253] [    T140]  device_release_driver_internal+0x197/0x200
> [13611.788257] [    T140]  pci_stop_bus_device+0x68/0x80
> [13611.788261] [    T140]  pci_stop_bus_device+0x38/0x80
> [13611.788264] [    T140]  pci_stop_bus_device+0x27/0x80
> [13611.788267] [    T140]  pci_stop_and_remove_bus_device+0xd/0x20
> [13611.788270] [    T140]  pciehp_unconfigure_device+0x93/0x160
> [13611.788274] [    T140]  pciehp_disable_slot+0x62/0x100
> [13611.788277] [    T140]  pciehp_handle_presence_or_link_change+0x72/0x350
> [13611.788281] [    T140]  pciehp_ist+0x13b/0x180
> [13611.788284] [    T140]  irq_thread_fn+0x1e/0x60
> [13611.788288] [    T140]  irq_thread+0x114/0x1e0
> [13611.788291] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13611.788295] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13611.788298] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13611.788302] [    T140]  kthread+0xea/0x1e0
> [13611.788306] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13611.788309] [    T140]  ret_from_fork+0x2f/0x50
> [13611.788313] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13611.788317] [    T140]  ret_from_fork_asm+0x11/0x20
> [13611.788322] [    T140]  </TASK>
> [13611.788324] [    T140] ---[ end trace 0000000000000000 ]---
> [13611.789149] [    T140] ------------[ cut here ]------------
> [13611.789151] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:510 amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
> [13611.789230] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13611.789294] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13611.789328] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13611.789331] [    T140] Tainted: [W]=WARN
> [13611.789333] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13611.789334] [    T140] RIP: 0010:amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
> [13611.789411] [    T140] Code: f6 ff ff 4d 85 e4 74 08 49 c7 04 24 00 00 00 00 48 85 ed 74 08 48 c7 45 00 00 00 00 00 5b 5d 41 5c 41 5d 41 5e e9 e7 49 b2 c5
> <0f> 0b e9 4b ff ff ff 3d 00 fe ff ff 0f 85 85 97 5d 00 eb bd 0f 1f
> [13611.789413] [    T140] RSP: 0018:ffff9ac3c0743c48 EFLAGS: 00010202
> [13611.789416] [    T140] RAX: 0000000000000000 RBX: ffff8c320a600a20 RCX: 0000000000000000
> [13611.789418] [    T140] RDX: ffff8c320a600a28 RSI: 0000000000000000 RDI: ffff8c320a600a20
> [13611.789420] [    T140] RBP: ffff8c320a600a28 R08: ffff8c3221bd1c18 R09: 00007f363c49e000
> [13611.789421] [    T140] R10: 0000000000000020 R11: 000000000000009d R12: 0000000000000000
> [13611.789423] [    T140] R13: ffff8c320a6cb000 R14: ffff8c320a60ef80 R15: ffff9ac3c0743d6e
> [13611.789425] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13611.789427] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13611.789429] [    T140] CR2: 000055fcf3dd7e44 CR3: 0000000271a64000 CR4: 0000000000750ef0
> [13611.789430] [    T140] PKRU: 55555554
> [13611.789432] [    T140] Call Trace:
> [13611.789434] [    T140]  <TASK>
> [13611.789436] [    T140]  ? __warn.cold+0x90/0x9e
> [13611.789439] [    T140]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
> [13611.789524] [    T140]  ? report_bug+0xfa/0x140
> [13611.789528] [    T140]  ? handle_bug+0x53/0x90
> [13611.789531] [    T140]  ? exc_invalid_op+0x17/0x70
> [13611.789533] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13611.789537] [    T140]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
> [13611.789614] [    T140]  amdgpu_device_unmap_mmio+0x25/0x90 [amdgpu]
> [13611.789689] [    T140]  amdgpu_pci_remove+0x40/0x70 [amdgpu]
> [13611.789765] [    T140]  pci_device_remove+0x3d/0xb0
> [13611.789768] [    T140]  device_release_driver_internal+0x197/0x200
> [13611.789771] [    T140]  pci_stop_bus_device+0x68/0x80
> [13611.789774] [    T140]  pci_stop_bus_device+0x38/0x80
> [13611.789776] [    T140]  pci_stop_bus_device+0x27/0x80
> [13611.789779] [    T140]  pci_stop_and_remove_bus_device+0xd/0x20
> [13611.789782] [    T140]  pciehp_unconfigure_device+0x93/0x160
> [13611.789785] [    T140]  pciehp_disable_slot+0x62/0x100
> [13611.789787] [    T140]  pciehp_handle_presence_or_link_change+0x72/0x350
> [13611.789790] [    T140]  pciehp_ist+0x13b/0x180
> [13611.789793] [    T140]  irq_thread_fn+0x1e/0x60
> [13611.789796] [    T140]  irq_thread+0x114/0x1e0
> [13611.789799] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13611.789801] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13611.789805] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13611.789807] [    T140]  kthread+0xea/0x1e0
> [13611.789810] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13611.789814] [    T140]  ret_from_fork+0x2f/0x50
> [13611.789817] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13611.789820] [    T140]  ret_from_fork_asm+0x11/0x20
> [13611.789824] [    T140]  </TASK>
> [13611.789826] [    T140] ---[ end trace 0000000000000000 ]---
> [13612.510583] [    T140] pcieport 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
> [13612.510746] [    T140] pcieport 0000:02:00.0: Unable to change power state from D3cold to D0, device inaccessible
> [13612.515993] [    T140] pci_bus 0000:03: busn_res: [bus 03] is released
> [13612.517813] [    T140] pci_bus 0000:02: busn_res: [bus 02-03] is released
> [13612.517957] [    T140] pcieport 0000:00:01.1: pciehp: Slot(0): Card present
> [13612.517960] [    T140] pcieport 0000:00:01.1: pciehp: Slot(0): Link Up
> [13612.646970] [    T140] pci 0000:01:00.0: [1002:1478] type 01 class 0x060400 PCIe Switch Upstream Port
> [13612.647337] [    T140] pci 0000:01:00.0: BAR 0 [mem 0xfcc00000-0xfcc03fff]
> [13612.647459] [    T140] pci 0000:01:00.0: PCI bridge to [bus 02-03]
> [13612.648148] [    T140] pci 0000:01:00.0:   bridge window [mem 0xfca00000-0xfcbfffff]
> [13612.649293] [    T140] pci 0000:01:00.0:   bridge window [mem 0xfc00000000-0xfe0fffffff 64bit pref]
> [13612.651803] [    T140] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> [13612.655075] [    T140] pci 0000:01:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x8 link at 0000:00:01.1 (capable of 126.024 Gb/s with
> 16.0 GT/s PCIe x8 link)
> [13612.655993] [    T140] pci 0000:01:00.0: Adding to iommu group 12
> [13612.657710] [    T140] pci 0000:02:00.0: [1002:1479] type 01 class 0x060400 PCIe Switch Downstream Port
> [13612.658068] [    T140] pci 0000:02:00.0: PCI bridge to [bus 03]
> [13612.658078] [    T140] pci 0000:02:00.0:   bridge window [mem 0xfca00000-0xfcbfffff]
> [13612.658315] [    T140] pci 0000:02:00.0:   bridge window [mem 0xfc00000000-0xfe0fffffff 64bit pref]
> [13612.661595] [    T140] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
> [13612.667373] [    T140] pci 0000:02:00.0: Adding to iommu group 13
> [13612.667877] [    T140] pci 0000:01:00.0: PCI bridge to [bus 02-03]
> [13612.668858] [    T140] pci 0000:03:00.0: [1002:73ff] type 00 class 0x038000 PCIe Legacy Endpoint
> [13612.669236] [    T140] pci 0000:03:00.0: BAR 0 [mem 0xfc00000000-0xfdffffffff 64bit pref]
> [13612.669241] [    T140] pci 0000:03:00.0: BAR 2 [mem 0xfe00000000-0xfe0fffffff 64bit pref]
> [13612.669480] [    T140] pci 0000:03:00.0: BAR 5 [mem 0xfca00000-0xfcafffff]
> [13612.669484] [    T140] pci 0000:03:00.0: ROM [mem 0xfcb00000-0xfcb1ffff pref]
> [13612.672312] [    T140] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
> [13612.673659] [    T140] pci 0000:03:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x8 link at 0000:00:01.1 (capable of 252.048 Gb/s with
> 16.0 GT/s PCIe x16 link)
> [13612.675633] [    T140] pci 0000:03:00.0: Adding to iommu group 14
> [13612.676122] [    T140] pci 0000:03:00.1: [1002:ab28] type 00 class 0x040300 PCIe Legacy Endpoint
> [13612.677265] [    T140] pci 0000:03:00.1: BAR 0 [mem 0xfcb20000-0xfcb23fff]
> [13612.678612] [    T140] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
> [13612.679722] [    T140] pci 0000:03:00.1: Adding to iommu group 15
> [13612.680123] [    T140] pci 0000:02:00.0: PCI bridge to [bus 03]
> [13612.680834] [    T140] pcieport 0000:00:01.1: Assigned bridge window [mem 0xfc00000000-0xfe0fffffff 64bit pref] to [bus 01-03] cannot fit 0x300000000
> required for 0000:02:00.0 bridging to [bus 03]
> [13612.680838] [    T140] pci 0000:02:00.0: bridge window [mem 0xfc00000000-0xfe0fffffff 64bit pref] to [bus 03] requires relaxed alignment rules
> [13612.680842] [    T140] pcieport 0000:00:01.1: Assigned bridge window [mem 0xfc00000000-0xfe0fffffff 64bit pref] to [bus 01-03] cannot fit 0x400000000
> required for 0000:01:00.0 bridging to [bus 02-03]
> [13612.680845] [    T140] pci 0000:01:00.0: bridge window [mem 0xfc00000000-0xfe0fffffff 64bit pref] to [bus 02-03] requires relaxed alignment rules
> [13612.680851] [    T140] pci 0000:01:00.0: bridge window [mem 0xfc00000000-0xfe0fffffff 64bit pref]: assigned
> [13612.680853] [    T140] pci 0000:01:00.0: bridge window [mem 0xfca00000-0xfcbfffff]: assigned
> [13612.680856] [    T140] pci 0000:01:00.0: BAR 0 [mem 0xfcc00000-0xfcc03fff]: assigned
> [13612.680861] [    T140] pci 0000:02:00.0: bridge window [mem 0xfc00000000-0xfe0fffffff 64bit pref]: assigned
> [13612.680864] [    T140] pci 0000:02:00.0: bridge window [mem 0xfca00000-0xfcbfffff]: assigned
> [13612.680867] [    T140] pci 0000:03:00.0: BAR 0 [mem 0xfc00000000-0xfdffffffff 64bit pref]: assigned
> [13612.680877] [    T140] pci 0000:03:00.0: BAR 2 [mem 0xfe00000000-0xfe0fffffff 64bit pref]: assigned
> [13612.680888] [    T140] pci 0000:03:00.0: BAR 5 [mem 0xfca00000-0xfcafffff]: assigned
> [13612.681010] [    T140] pci 0000:03:00.0: ROM [mem 0xfcb00000-0xfcb1ffff pref]: assigned
> [13612.681012] [    T140] pci 0000:03:00.1: BAR 0 [mem 0xfcb20000-0xfcb23fff]: assigned
> [13612.681233] [    T140] pci 0000:02:00.0: PCI bridge to [bus 03]
> [13612.681589] [    T140] pci 0000:02:00.0:   bridge window [mem 0xfca00000-0xfcbfffff]
> [13612.681707] [    T140] pci 0000:02:00.0:   bridge window [mem 0xfc00000000-0xfe0fffffff 64bit pref]
> [13612.681714] [    T140] pci 0000:01:00.0: PCI bridge to [bus 02-03]
> [13612.681833] [    T140] pci 0000:01:00.0:   bridge window [mem 0xfca00000-0xfcbfffff]
> [13612.681960] [    T140] pci 0000:01:00.0:   bridge window [mem 0xfc00000000-0xfe0fffffff 64bit pref]
> [13612.681967] [    T140] pcieport 0000:00:01.1: PCI bridge to [bus 01-03]
> [13612.681970] [    T140] pcieport 0000:00:01.1:   bridge window [io  0x1000-0x1fff]
> [13612.681974] [    T140] pcieport 0000:00:01.1:   bridge window [mem 0xfca00000-0xfccfffff]
> [13612.681977] [    T140] pcieport 0000:00:01.1:   bridge window [mem 0xfc00000000-0xfe0fffffff 64bit pref]
> [13612.684765] [    T140] [drm] initializing kernel modesetting (DIMGREY_CAVEFISH 0x1002:0x73FF 0x1462:0x1313 0xC3).
> [13612.685143] [    T140] [drm] register mmio base: 0xFCA00000
> [13612.685145] [    T140] [drm] register mmio size: 1048576
> [13614.899803] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block number 0 <nv_common>
> [13614.899811] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block number 1 <gmc_v10_0>
> [13614.899815] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block number 2 <navi10_ih>
> [13614.899818] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block number 3 <psp>
> [13614.899821] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block number 4 <smu>
> [13614.899824] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block number 5 <dm>
> [13614.899827] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block number 6 <gfx_v10_0>
> [13614.899831] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block number 7 <sdma_v5_2>
> [13614.899834] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block number 8 <vcn_v3_0>
> [13614.899837] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block number 9 <jpeg_v3_0>
> [13614.899982] [    T140] amdgpu 0000:03:00.0: amdgpu: ACPI VFCT table present but broken (too short #2),skipping
> [13615.118633] [    T140] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from ROM BAR
> [13615.118640] [    T140] amdgpu: ATOM BIOS: SWBRT77181.001
> [13615.126013] [    T140] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) feature disabled as experimental (default)
> [13615.126355] [    T140] amdgpu 0000:03:00.0: amdgpu: MODE1 reset
> [13615.126359] [    T140] amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset
> [13615.128943] [    T140] amdgpu 0000:03:00.0: amdgpu: GPU smu mode1 reset
> [13615.633347] [    T140] [drm] GPU posting now...
> [13615.633384] [    T140] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
> [13615.633393] [    T140] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M 0x0000008000000000 - 0x00000081FEFFFFFF (8176M used)
> [13615.633397] [    T140] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x0000000000000000 - 0x000000001FFFFFFF
> [13615.633408] [    T140] [drm] Detected VRAM RAM=8176M, BAR=8192M
> [13615.633410] [    T140] [drm] RAM width 128bits GDDR6
> [13615.633554] [    T140] [drm] amdgpu: 8176M of VRAM memory ready
> [13615.633557] [    T140] [drm] amdgpu: 6895M of GTT memory ready.
> [13615.633574] [    T140] [drm] GART: num cpu pages 131072, num gpu pages 131072
> [13615.635159] [    T140] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB00000).
> [13630.506743] [    T140] amdgpu 0000:03:00.0: amdgpu: STB initialized to 2048 entries
> [13630.506836] [    T140] [drm] Loading DMUB firmware via PSP: version=0x02020020
> [13630.510341] [    T140] [drm] use_doorbell being set to: [true]
> [13630.511712] [    T140] [drm] use_doorbell being set to: [true]
> [13630.511733] [    T140] [drm] Found VCN firmware Version ENC: 1.33 DEC: 4 VEP: 0 Revision: 6
> [13630.685530] [    T140] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0x81fd000000 for PSP TMR
> [13631.015392] [    T140] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not available
> [13631.046278] [    T140] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
> [13631.046644] [    T140] amdgpu 0000:03:00.0: amdgpu: smu driver if version = 0x0000000f, smu fw if version = 0x00000013, smu fw program = 0, version =
> 0x003b3100 (59.49.0)
> [13631.046649] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
> [13631.046909] [    T140] amdgpu 0000:03:00.0: amdgpu: use vbios provided pptable
> [13631.153391] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU: response:0xFFFFFFFF for index:12 param:0x00000000 message:GetEnabledSmuFeaturesLow?
> [13631.153396] [    T140] amdgpu 0000:03:00.0: amdgpu: Failed to retrieve enabled ppfeatures!
> [13631.153399] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is in hanged state, failed to send smu message!
> [13631.153401] [    T140] amdgpu 0000:03:00.0: amdgpu: Failed to retrieve enabled ppfeatures!
> [13631.153404] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is in hanged state, failed to send smu message!
> [13631.153406] [    T140] amdgpu 0000:03:00.0: amdgpu: Failed to retrieve enabled ppfeatures!
> [13631.153408] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is in hanged state, failed to send smu message!
> [13631.153411] [    T140] amdgpu 0000:03:00.0: amdgpu: Failed to retrieve enabled ppfeatures!
> [13631.153413] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is in hanged state, failed to send smu message!
> [13631.153415] [    T140] amdgpu 0000:03:00.0: amdgpu: Failed to retrieve enabled ppfeatures!
> [13631.153417] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is in hanged state, failed to send smu message!
> [13631.153419] [    T140] amdgpu 0000:03:00.0: amdgpu: Failed to retrieve enabled ppfeatures!
> [13631.153421] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is in hanged state, failed to send smu message!
> [13631.153423] [    T140] amdgpu 0000:03:00.0: amdgpu: Failed to retrieve enabled ppfeatures!
> [13631.153425] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is in hanged state, failed to send smu message!
> [13631.153427] [    T140] amdgpu 0000:03:00.0: amdgpu: Failed to retrieve enabled ppfeatures!
> [13631.153429] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is in hanged state, failed to send smu message!
> [13631.153431] [    T140] amdgpu 0000:03:00.0: amdgpu: Failed to retrieve enabled ppfeatures!
> [13631.153433] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is in hanged state, failed to send smu message!
> [13631.153435] [    T140] amdgpu 0000:03:00.0: amdgpu: Failed to retrieve enabled ppfeatures!
> [13631.153437] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is in hanged state, failed to send smu message!
> [13631.153438] [    T140] amdgpu 0000:03:00.0: amdgpu: Failed to retrieve enabled ppfeatures!
> [13631.153440] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is in hanged state, failed to send smu message!
> [13631.153442] [    T140] amdgpu 0000:03:00.0: amdgpu: Failed to retrieve enabled ppfeatures!
> [13631.153444] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is in hanged state, failed to send smu message!
> [13631.153446] [    T140] amdgpu 0000:03:00.0: amdgpu: Failed to retrieve enabled ppfeatures!
> [13631.153448] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is in hanged state, failed to send smu message!
> [13631.153451] [    T140] amdgpu 0000:03:00.0: amdgpu: Failed to retrieve enabled ppfeatures!
> [13631.153453] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is in hanged state, failed to send smu message!
> [13631.153455] [    T140] amdgpu 0000:03:00.0: amdgpu: Attempt to override pcie params failed!
> [13631.153457] [    T140] amdgpu 0000:03:00.0: amdgpu: Failed to setup smc hw!
> [13631.153459] [    T140] [drm:amdgpu_device_init.cold [amdgpu]] *ERROR* hw_init of IP block <smu> failed -121
> [13631.153638] [    T140] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_init failed
> [13631.153641] [    T140] amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
> [13631.161507] [    T140] amdgpu 0000:03:00.0: amdgpu: amdgpu: finishing device.
> [13631.161633] [    T140] ------------[ cut here ]------------
> [13631.161635] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.161751] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.161831] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.161876] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.161881] [    T140] Tainted: [W]=WARN
> [13631.161882] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.161885] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.161990] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.161992] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.161996] [    T140] RAX: ffff8c336755a3c0 RBX: ffff8c32a5898890 RCX: 0000000000000000
> [13631.161998] [    T140] RDX: 0000000000000000 RSI: ffff8c32a58a54d0 RDI: ffff8c32a5880000
> [13631.162000] [    T140] RBP: ffff8c32a5890250 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.162001] [    T140] R10: 0000000000000082 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.162003] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.162005] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.162007] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.162009] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.162011] [    T140] PKRU: 55555554
> [13631.162013] [    T140] Call Trace:
> [13631.162016] [    T140]  <TASK>
> [13631.162019] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.162025] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.162140] [    T140]  ? report_bug+0xfa/0x140
> [13631.162146] [    T140]  ? handle_bug+0x53/0x90
> [13631.162149] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.162152] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.162157] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.162260] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.162263] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.162392] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.162536] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.162657] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.162749] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.162753] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.162756] [    T140]  pci_device_probe+0xc0/0x180
> [13631.162760] [    T140]  really_probe+0xd9/0x340
> [13631.162764] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.162769] [    T140]  __driver_probe_device+0x73/0x110
> [13631.162773] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.162776] [    T140]  __device_attach_driver+0x84/0x110
> [13631.162780] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.162783] [    T140]  __device_attach+0xab/0x1b0
> [13631.162787] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.162790] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.162792] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.162795] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.162797] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.162800] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.162803] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.162806] [    T140]  pciehp_ist+0x13b/0x180
> [13631.162809] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.162813] [    T140]  irq_thread+0x114/0x1e0
> [13631.162815] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.162818] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.162822] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.162824] [    T140]  kthread+0xea/0x1e0
> [13631.162828] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.162831] [    T140]  ret_from_fork+0x2f/0x50
> [13631.162835] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.162838] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.162843] [    T140]  </TASK>
> [13631.162844] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.162857] [    T140] ------------[ cut here ]------------
> [13631.162858] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.162948] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.163013] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.163048] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.163051] [    T140] Tainted: [W]=WARN
> [13631.163053] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.163054] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.163139] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.163141] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.163143] [    T140] RAX: ffff8c336755a3c4 RBX: ffff8c32a5898ba8 RCX: 0000000000000000
> [13631.163145] [    T140] RDX: 0000000000000001 RSI: ffff8c32a58a54d0 RDI: ffff8c32a5880000
> [13631.163147] [    T140] RBP: ffff8c32a5890258 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.163149] [    T140] R10: 0000000000000282 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.163150] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.163152] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.163154] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.163156] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.163158] [    T140] PKRU: 55555554
> [13631.163159] [    T140] Call Trace:
> [13631.163162] [    T140]  <TASK>
> [13631.163163] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.163167] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.163250] [    T140]  ? report_bug+0xfa/0x140
> [13631.163254] [    T140]  ? handle_bug+0x53/0x90
> [13631.163257] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.163259] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.163263] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.163345] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.163348] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.163427] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.163557] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.163669] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.163746] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.163750] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.163753] [    T140]  pci_device_probe+0xc0/0x180
> [13631.163756] [    T140]  really_probe+0xd9/0x340
> [13631.163759] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.163763] [    T140]  __driver_probe_device+0x73/0x110
> [13631.163766] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.163770] [    T140]  __device_attach_driver+0x84/0x110
> [13631.163773] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.163777] [    T140]  __device_attach+0xab/0x1b0
> [13631.163781] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.163785] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.163787] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.163790] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.163792] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.163795] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.163798] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.163800] [    T140]  pciehp_ist+0x13b/0x180
> [13631.163803] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.163807] [    T140]  irq_thread+0x114/0x1e0
> [13631.163810] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.163813] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.163816] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.163818] [    T140]  kthread+0xea/0x1e0
> [13631.163822] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.163825] [    T140]  ret_from_fork+0x2f/0x50
> [13631.163828] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.163831] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.163835] [    T140]  </TASK>
> [13631.163837] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.163847] [    T140] ------------[ cut here ]------------
> [13631.163849] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.163937] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.164001] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.164034] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.164037] [    T140] Tainted: [W]=WARN
> [13631.164039] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.164040] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.164124] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.164126] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.164129] [    T140] RAX: ffff8c336755a3c8 RBX: ffff8c32a5898ec8 RCX: 0000000000000000
> [13631.164131] [    T140] RDX: 0000000000000002 RSI: ffff8c32a58a54d0 RDI: ffff8c32a5880000
> [13631.164133] [    T140] RBP: ffff8c32a5890260 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.164135] [    T140] R10: 0000000000000282 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.164137] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.164139] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.164141] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.164143] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.164144] [    T140] PKRU: 55555554
> [13631.164146] [    T140] Call Trace:
> [13631.164148] [    T140]  <TASK>
> [13631.164149] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.164152] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.164235] [    T140]  ? report_bug+0xfa/0x140
> [13631.164239] [    T140]  ? handle_bug+0x53/0x90
> [13631.164242] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.164244] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.164248] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.164330] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.164333] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.164411] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.164538] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.164650] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.164758] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.164762] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.164765] [    T140]  pci_device_probe+0xc0/0x180
> [13631.164768] [    T140]  really_probe+0xd9/0x340
> [13631.164771] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.164774] [    T140]  __driver_probe_device+0x73/0x110
> [13631.164778] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.164781] [    T140]  __device_attach_driver+0x84/0x110
> [13631.164784] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.164788] [    T140]  __device_attach+0xab/0x1b0
> [13631.164791] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.164794] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.164797] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.164799] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.164801] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.164809] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.164811] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.164814] [    T140]  pciehp_ist+0x13b/0x180
> [13631.164817] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.164821] [    T140]  irq_thread+0x114/0x1e0
> [13631.164823] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.164826] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.164829] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.164832] [    T140]  kthread+0xea/0x1e0
> [13631.164836] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.164839] [    T140]  ret_from_fork+0x2f/0x50
> [13631.164843] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.164846] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.164851] [    T140]  </TASK>
> [13631.164852] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.164861] [    T140] ------------[ cut here ]------------
> [13631.164863] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.164951] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.165014] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.165048] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.165050] [    T140] Tainted: [W]=WARN
> [13631.165052] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.165054] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.165151] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.165153] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.165155] [    T140] RAX: ffff8c336755a3cc RBX: ffff8c32a58991e0 RCX: 0000000000000000
> [13631.165157] [    T140] RDX: 0000000000000003 RSI: ffff8c32a58a54d0 RDI: ffff8c32a5880000
> [13631.165158] [    T140] RBP: ffff8c32a5890268 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.165160] [    T140] R10: 0000000000000282 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.165162] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.165164] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.165166] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.165167] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.165169] [    T140] PKRU: 55555554
> [13631.165171] [    T140] Call Trace:
> [13631.165172] [    T140]  <TASK>
> [13631.165174] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.165177] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.165259] [    T140]  ? report_bug+0xfa/0x140
> [13631.165263] [    T140]  ? handle_bug+0x53/0x90
> [13631.165267] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.165269] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.165272] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.165355] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.165358] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.165436] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.165560] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.165671] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.165748] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.165752] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.165755] [    T140]  pci_device_probe+0xc0/0x180
> [13631.165758] [    T140]  really_probe+0xd9/0x340
> [13631.165761] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.165764] [    T140]  __driver_probe_device+0x73/0x110
> [13631.165768] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.165771] [    T140]  __device_attach_driver+0x84/0x110
> [13631.165774] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.165778] [    T140]  __device_attach+0xab/0x1b0
> [13631.165781] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.165784] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.165786] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.165789] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.165791] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.165794] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.165796] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.165799] [    T140]  pciehp_ist+0x13b/0x180
> [13631.165802] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.165805] [    T140]  irq_thread+0x114/0x1e0
> [13631.165808] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.165810] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.165814] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.165816] [    T140]  kthread+0xea/0x1e0
> [13631.165819] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.165823] [    T140]  ret_from_fork+0x2f/0x50
> [13631.165826] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.165829] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.165833] [    T140]  </TASK>
> [13631.165835] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.165843] [    T140] ------------[ cut here ]------------
> [13631.165845] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.165933] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.165996] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.166030] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.166032] [    T140] Tainted: [W]=WARN
> [13631.166034] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.166035] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.166127] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.166129] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.166132] [    T140] RAX: ffff8c336755a3d0 RBX: ffff8c32a58994f8 RCX: 0000000000000000
> [13631.166133] [    T140] RDX: 0000000000000004 RSI: ffff8c32a58a54d0 RDI: ffff8c32a5880000
> [13631.166135] [    T140] RBP: ffff8c32a5890270 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.166137] [    T140] R10: 0000000000000282 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.166139] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.166140] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.166142] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.166144] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.166146] [    T140] PKRU: 55555554
> [13631.166147] [    T140] Call Trace:
> [13631.166149] [    T140]  <TASK>
> [13631.166151] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.166154] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.166236] [    T140]  ? report_bug+0xfa/0x140
> [13631.166240] [    T140]  ? handle_bug+0x53/0x90
> [13631.166243] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.166245] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.166249] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.166331] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.166334] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.166413] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.166543] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.166654] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.166731] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.166735] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.166738] [    T140]  pci_device_probe+0xc0/0x180
> [13631.166741] [    T140]  really_probe+0xd9/0x340
> [13631.166744] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.166747] [    T140]  __driver_probe_device+0x73/0x110
> [13631.166750] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.166754] [    T140]  __device_attach_driver+0x84/0x110
> [13631.166757] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.166760] [    T140]  __device_attach+0xab/0x1b0
> [13631.166764] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.166767] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.166769] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.166772] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.166774] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.166776] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.166779] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.166782] [    T140]  pciehp_ist+0x13b/0x180
> [13631.166784] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.166788] [    T140]  irq_thread+0x114/0x1e0
> [13631.166790] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.166793] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.166796] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.166799] [    T140]  kthread+0xea/0x1e0
> [13631.166802] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.166805] [    T140]  ret_from_fork+0x2f/0x50
> [13631.166808] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.166811] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.166815] [    T140]  </TASK>
> [13631.166817] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.166825] [    T140] ------------[ cut here ]------------
> [13631.166826] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.166915] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.166978] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.167010] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.167013] [    T140] Tainted: [W]=WARN
> [13631.167014] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.167016] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.167100] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.167102] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.167104] [    T140] RAX: ffff8c336755a3d4 RBX: ffff8c32a5899810 RCX: 0000000000000000
> [13631.167106] [    T140] RDX: 0000000000000005 RSI: ffff8c32a58a54d0 RDI: ffff8c32a5880000
> [13631.167108] [    T140] RBP: ffff8c32a5890278 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.167109] [    T140] R10: 0000000000000282 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.167111] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.167113] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.167115] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.167116] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.167118] [    T140] PKRU: 55555554
> [13631.167120] [    T140] Call Trace:
> [13631.167121] [    T140]  <TASK>
> [13631.167123] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.167126] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.167209] [    T140]  ? report_bug+0xfa/0x140
> [13631.167212] [    T140]  ? handle_bug+0x53/0x90
> [13631.167215] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.167217] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.167221] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.167309] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.167312] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.167390] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.167515] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.167627] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.167704] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.167708] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.167711] [    T140]  pci_device_probe+0xc0/0x180
> [13631.167714] [    T140]  really_probe+0xd9/0x340
> [13631.167717] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.167720] [    T140]  __driver_probe_device+0x73/0x110
> [13631.167723] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.167726] [    T140]  __device_attach_driver+0x84/0x110
> [13631.167730] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.167733] [    T140]  __device_attach+0xab/0x1b0
> [13631.167737] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.167739] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.167742] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.167744] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.167747] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.167749] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.167752] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.167754] [    T140]  pciehp_ist+0x13b/0x180
> [13631.167757] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.167760] [    T140]  irq_thread+0x114/0x1e0
> [13631.167763] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.167766] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.167769] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.167772] [    T140]  kthread+0xea/0x1e0
> [13631.167775] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.167778] [    T140]  ret_from_fork+0x2f/0x50
> [13631.167781] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.167784] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.167788] [    T140]  </TASK>
> [13631.167789] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.167798] [    T140] ------------[ cut here ]------------
> [13631.167799] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.167887] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.167955] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.167988] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.167991] [    T140] Tainted: [W]=WARN
> [13631.167992] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.167994] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.168077] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.168079] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.168082] [    T140] RAX: ffff8c336755a3c8 RBX: ffff8c32a5899b28 RCX: 0000000000000000
> [13631.168083] [    T140] RDX: 0000000000000002 RSI: ffff8c32a58a54d0 RDI: ffff8c32a5880000
> [13631.168085] [    T140] RBP: ffff8c32a5890280 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.168087] [    T140] R10: 0000000000000282 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.168089] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.168090] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.168092] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.168094] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.168096] [    T140] PKRU: 55555554
> [13631.168097] [    T140] Call Trace:
> [13631.168099] [    T140]  <TASK>
> [13631.168101] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.168104] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.168187] [    T140]  ? report_bug+0xfa/0x140
> [13631.168190] [    T140]  ? handle_bug+0x53/0x90
> [13631.168193] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.168195] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.168199] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.168281] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.168284] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.168362] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.168491] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.168601] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.168678] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.168682] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.168685] [    T140]  pci_device_probe+0xc0/0x180
> [13631.168688] [    T140]  really_probe+0xd9/0x340
> [13631.168691] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.168694] [    T140]  __driver_probe_device+0x73/0x110
> [13631.168698] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.168701] [    T140]  __device_attach_driver+0x84/0x110
> [13631.168704] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.168708] [    T140]  __device_attach+0xab/0x1b0
> [13631.168711] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.168714] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.168716] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.168719] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.168721] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.168724] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.168726] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.168729] [    T140]  pciehp_ist+0x13b/0x180
> [13631.168732] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.168735] [    T140]  irq_thread+0x114/0x1e0
> [13631.168738] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.168741] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.168744] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.168747] [    T140]  kthread+0xea/0x1e0
> [13631.168755] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.168758] [    T140]  ret_from_fork+0x2f/0x50
> [13631.168762] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.168765] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.168769] [    T140]  </TASK>
> [13631.168771] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.168783] [    T140] ------------[ cut here ]------------
> [13631.168784] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.168878] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.168941] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.168974] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.168977] [    T140] Tainted: [W]=WARN
> [13631.168978] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.168980] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.169064] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.169066] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.169069] [    T140] RAX: ffff8c336755a3cc RBX: ffff8c32a5899e40 RCX: 0000000000000000
> [13631.169071] [    T140] RDX: 0000000000000003 RSI: ffff8c32a58a54d0 RDI: ffff8c32a5880000
> [13631.169072] [    T140] RBP: ffff8c32a5890288 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.169074] [    T140] R10: 0000000000000282 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.169076] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.169078] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.169080] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.169081] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.169083] [    T140] PKRU: 55555554
> [13631.169085] [    T140] Call Trace:
> [13631.169086] [    T140]  <TASK>
> [13631.169094] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.169097] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.169180] [    T140]  ? report_bug+0xfa/0x140
> [13631.169183] [    T140]  ? handle_bug+0x53/0x90
> [13631.169186] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.169188] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.169192] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.169275] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.169278] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.169357] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.169490] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.169601] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.169678] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.169682] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.169685] [    T140]  pci_device_probe+0xc0/0x180
> [13631.169688] [    T140]  really_probe+0xd9/0x340
> [13631.169691] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.169694] [    T140]  __driver_probe_device+0x73/0x110
> [13631.169697] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.169701] [    T140]  __device_attach_driver+0x84/0x110
> [13631.169704] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.169707] [    T140]  __device_attach+0xab/0x1b0
> [13631.169711] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.169713] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.169716] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.169718] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.169721] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.169723] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.169726] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.169729] [    T140]  pciehp_ist+0x13b/0x180
> [13631.169731] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.169734] [    T140]  irq_thread+0x114/0x1e0
> [13631.169737] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.169740] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.169743] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.169746] [    T140]  kthread+0xea/0x1e0
> [13631.169749] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.169752] [    T140]  ret_from_fork+0x2f/0x50
> [13631.169755] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.169758] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.169762] [    T140]  </TASK>
> [13631.169764] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.169773] [    T140] ------------[ cut here ]------------
> [13631.169774] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.169863] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.169925] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.169958] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.169961] [    T140] Tainted: [W]=WARN
> [13631.169962] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.169964] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.170048] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.170050] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.170053] [    T140] RAX: ffff8c336755a3d0 RBX: ffff8c32a589a158 RCX: 0000000000000000
> [13631.170054] [    T140] RDX: 0000000000000004 RSI: ffff8c32a58a54d0 RDI: ffff8c32a5880000
> [13631.170056] [    T140] RBP: ffff8c32a5890290 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.170058] [    T140] R10: 0000000000000282 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.170059] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.170061] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.170063] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.170065] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.170067] [    T140] PKRU: 55555554
> [13631.170068] [    T140] Call Trace:
> [13631.170070] [    T140]  <TASK>
> [13631.170072] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.170074] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.170159] [    T140]  ? report_bug+0xfa/0x140
> [13631.170162] [    T140]  ? handle_bug+0x53/0x90
> [13631.170165] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.170167] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.170171] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.170259] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.170262] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.170345] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.170464] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.170582] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.170664] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.170668] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.170671] [    T140]  pci_device_probe+0xc0/0x180
> [13631.170674] [    T140]  really_probe+0xd9/0x340
> [13631.170677] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.170680] [    T140]  __driver_probe_device+0x73/0x110
> [13631.170683] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.170686] [    T140]  __device_attach_driver+0x84/0x110
> [13631.170690] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.170693] [    T140]  __device_attach+0xab/0x1b0
> [13631.170697] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.170699] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.170702] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.170704] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.170707] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.170709] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.170712] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.170714] [    T140]  pciehp_ist+0x13b/0x180
> [13631.170717] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.170720] [    T140]  irq_thread+0x114/0x1e0
> [13631.170723] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.170726] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.170729] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.170731] [    T140]  kthread+0xea/0x1e0
> [13631.170735] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.170738] [    T140]  ret_from_fork+0x2f/0x50
> [13631.170740] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.170743] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.170748] [    T140]  </TASK>
> [13631.170749] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.170757] [    T140] ------------[ cut here ]------------
> [13631.170758] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.170852] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.170914] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.170946] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.170949] [    T140] Tainted: [W]=WARN
> [13631.170950] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.170952] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.171041] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.171043] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.171045] [    T140] RAX: ffff8c336755a3d4 RBX: ffff8c32a589a470 RCX: 0000000000000000
> [13631.171047] [    T140] RDX: 0000000000000005 RSI: ffff8c32a58a54d0 RDI: ffff8c32a5880000
> [13631.171049] [    T140] RBP: ffff8c32a5890298 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.171051] [    T140] R10: 0000000000000282 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.171052] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.171054] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.171056] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.171058] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.171059] [    T140] PKRU: 55555554
> [13631.171061] [    T140] Call Trace:
> [13631.171063] [    T140]  <TASK>
> [13631.171064] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.171068] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.171155] [    T140]  ? report_bug+0xfa/0x140
> [13631.171159] [    T140]  ? handle_bug+0x53/0x90
> [13631.171162] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.171164] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.171168] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.171255] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.171258] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.171338] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.171454] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.171574] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.171674] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.171677] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.171680] [    T140]  pci_device_probe+0xc0/0x180
> [13631.171683] [    T140]  really_probe+0xd9/0x340
> [13631.171686] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.171690] [    T140]  __driver_probe_device+0x73/0x110
> [13631.171693] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.171696] [    T140]  __device_attach_driver+0x84/0x110
> [13631.171699] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.171703] [    T140]  __device_attach+0xab/0x1b0
> [13631.171706] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.171709] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.171711] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.171714] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.171716] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.171718] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.171721] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.171724] [    T140]  pciehp_ist+0x13b/0x180
> [13631.171726] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.171729] [    T140]  irq_thread+0x114/0x1e0
> [13631.171732] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.171735] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.171738] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.171741] [    T140]  kthread+0xea/0x1e0
> [13631.171744] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.171747] [    T140]  ret_from_fork+0x2f/0x50
> [13631.171750] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.171753] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.171757] [    T140]  </TASK>
> [13631.171758] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.171767] [    T140] ------------[ cut here ]------------
> [13631.171768] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.171856] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.171918] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.171951] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.171953] [    T140] Tainted: [W]=WARN
> [13631.171955] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.171956] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.172039] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.172041] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.172044] [    T140] RAX: ffff8c3203e26ba8 RBX: ffff8c32a5896d20 RCX: 0000000000000000
> [13631.172045] [    T140] RDX: 0000000000000000 RSI: ffff8c32a5897038 RDI: ffff8c32a5880000
> [13631.172047] [    T140] RBP: ffff8c32a58902a0 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.172049] [    T140] R10: 0000000000000282 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.172051] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.172052] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.172054] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.172056] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.172058] [    T140] PKRU: 55555554
> [13631.172059] [    T140] Call Trace:
> [13631.172061] [    T140]  <TASK>
> [13631.172063] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.172066] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.172148] [    T140]  ? report_bug+0xfa/0x140
> [13631.172151] [    T140]  ? handle_bug+0x53/0x90
> [13631.172154] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.172156] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.172160] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.172242] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.172245] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.172323] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.172440] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.172558] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.172635] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.172638] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.172641] [    T140]  pci_device_probe+0xc0/0x180
> [13631.172644] [    T140]  really_probe+0xd9/0x340
> [13631.172647] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.172650] [    T140]  __driver_probe_device+0x73/0x110
> [13631.172654] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.172657] [    T140]  __device_attach_driver+0x84/0x110
> [13631.172660] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.172664] [    T140]  __device_attach+0xab/0x1b0
> [13631.172667] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.172670] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.172672] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.172675] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.172677] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.172679] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.172682] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.172685] [    T140]  pciehp_ist+0x13b/0x180
> [13631.172688] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.172691] [    T140]  irq_thread+0x114/0x1e0
> [13631.172693] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.172696] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.172699] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.172702] [    T140]  kthread+0xea/0x1e0
> [13631.172705] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.172708] [    T140]  ret_from_fork+0x2f/0x50
> [13631.172711] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.172714] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.172718] [    T140]  </TASK>
> [13631.172720] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.172728] [    T140] ------------[ cut here ]------------
> [13631.172730] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.172818] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.172880] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.172913] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.172915] [    T140] Tainted: [W]=WARN
> [13631.172917] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.172919] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.173002] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.173004] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.173006] [    T140] RAX: ffff8c320135da78 RBX: ffff8c32a58a6460 RCX: 0000000000000000
> [13631.173008] [    T140] RDX: 0000000000000000 RSI: ffff8c32a58aca50 RDI: ffff8c32a5880000
> [13631.173010] [    T140] RBP: ffff8c32a58902a8 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.173011] [    T140] R10: 0000000000000282 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.173013] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.173015] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.173017] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.173019] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.173020] [    T140] PKRU: 55555554
> [13631.173022] [    T140] Call Trace:
> [13631.173024] [    T140]  <TASK>
> [13631.173025] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.173028] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.173111] [    T140]  ? report_bug+0xfa/0x140
> [13631.173114] [    T140]  ? handle_bug+0x53/0x90
> [13631.173117] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.173119] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.173123] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.173205] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.173208] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.173286] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.173404] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.173524] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.173600] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.173604] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.173607] [    T140]  pci_device_probe+0xc0/0x180
> [13631.173610] [    T140]  really_probe+0xd9/0x340
> [13631.173613] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.173616] [    T140]  __driver_probe_device+0x73/0x110
> [13631.173619] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.173623] [    T140]  __device_attach_driver+0x84/0x110
> [13631.173626] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.173629] [    T140]  __device_attach+0xab/0x1b0
> [13631.173633] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.173635] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.173638] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.173640] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.173643] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.173645] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.173648] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.173650] [    T140]  pciehp_ist+0x13b/0x180
> [13631.173653] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.173656] [    T140]  irq_thread+0x114/0x1e0
> [13631.173659] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.173662] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.173665] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.173668] [    T140]  kthread+0xea/0x1e0
> [13631.173671] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.173674] [    T140]  ret_from_fork+0x2f/0x50
> [13631.173677] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.173680] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.173684] [    T140]  </TASK>
> [13631.173685] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.173693] [    T140] ------------[ cut here ]------------
> [13631.173695] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.173782] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.173844] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.173877] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.173879] [    T140] Tainted: [W]=WARN
> [13631.173881] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.173882] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.173965] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.173967] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.173970] [    T140] RAX: ffff8c320135da7c RBX: ffff8c32a58a6ac0 RCX: 0000000000000000
> [13631.173971] [    T140] RDX: 0000000000000001 RSI: ffff8c32a58aca50 RDI: ffff8c32a5880000
> [13631.173973] [    T140] RBP: ffff8c32a58902b0 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.173975] [    T140] R10: 0000000000000282 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.173976] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.173978] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.173980] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.173982] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.173984] [    T140] PKRU: 55555554
> [13631.173985] [    T140] Call Trace:
> [13631.173987] [    T140]  <TASK>
> [13631.173989] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.173992] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.174074] [    T140]  ? report_bug+0xfa/0x140
> [13631.174077] [    T140]  ? handle_bug+0x53/0x90
> [13631.174080] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.174082] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.174086] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.174168] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.174171] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.174249] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.174366] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.174485] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.174562] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.174566] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.174569] [    T140]  pci_device_probe+0xc0/0x180
> [13631.174572] [    T140]  really_probe+0xd9/0x340
> [13631.174575] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.174578] [    T140]  __driver_probe_device+0x73/0x110
> [13631.174582] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.174585] [    T140]  __device_attach_driver+0x84/0x110
> [13631.174588] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.174592] [    T140]  __device_attach+0xab/0x1b0
> [13631.174595] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.174598] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.174600] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.174603] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.174605] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.174608] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.174610] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.174613] [    T140]  pciehp_ist+0x13b/0x180
> [13631.174616] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.174619] [    T140]  irq_thread+0x114/0x1e0
> [13631.174622] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.174624] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.174628] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.174630] [    T140]  kthread+0xea/0x1e0
> [13631.174633] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.174637] [    T140]  ret_from_fork+0x2f/0x50
> [13631.174639] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.174642] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.174647] [    T140]  </TASK>
> [13631.174648] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.174656] [    T140] ------------[ cut here ]------------
> [13631.174658] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.174746] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.174809] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.174842] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.174844] [    T140] Tainted: [W]=WARN
> [13631.174846] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.174847] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.174932] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.174934] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.174936] [    T140] RAX: ffff8c320beb3600 RBX: ffff8c32a58aee20 RCX: 0000000000000000
> [13631.174938] [    T140] RDX: 0000000000000000 RSI: ffff8c32a58afa88 RDI: ffff8c32a5880000
> [13631.174939] [    T140] RBP: ffff8c32a58902b8 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.174941] [    T140] R10: 0000000000000282 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.174943] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.174945] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.174947] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.174948] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.174950] [    T140] PKRU: 55555554
> [13631.174952] [    T140] Call Trace:
> [13631.174953] [    T140]  <TASK>
> [13631.174955] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.174958] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.175041] [    T140]  ? report_bug+0xfa/0x140
> [13631.175045] [    T140]  ? handle_bug+0x53/0x90
> [13631.175048] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.175050] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.175054] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.175136] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.175139] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.175218] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.175335] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.175446] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.175529] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.175533] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.175536] [    T140]  pci_device_probe+0xc0/0x180
> [13631.175539] [    T140]  really_probe+0xd9/0x340
> [13631.175542] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.175545] [    T140]  __driver_probe_device+0x73/0x110
> [13631.175548] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.175552] [    T140]  __device_attach_driver+0x84/0x110
> [13631.175555] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.175558] [    T140]  __device_attach+0xab/0x1b0
> [13631.175562] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.175564] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.175567] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.175569] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.175572] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.175574] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.175577] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.175580] [    T140]  pciehp_ist+0x13b/0x180
> [13631.175582] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.175585] [    T140]  irq_thread+0x114/0x1e0
> [13631.175588] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.175591] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.175594] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.175597] [    T140]  kthread+0xea/0x1e0
> [13631.175600] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.175603] [    T140]  ret_from_fork+0x2f/0x50
> [13631.175606] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.175609] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.175613] [    T140]  </TASK>
> [13631.175615] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.175622] [    T140] ------------[ cut here ]------------
> [13631.175624] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.175712] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.175774] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.175807] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.175809] [    T140] Tainted: [W]=WARN
> [13631.175811] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.175812] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.175896] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.175898] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.175900] [    T140] RAX: ffff8c320beb3600 RBX: ffff8c32a58af138 RCX: 0000000000000000
> [13631.175902] [    T140] RDX: 0000000000000000 RSI: ffff8c32a58afa88 RDI: ffff8c32a5880000
> [13631.175904] [    T140] RBP: ffff8c32a58902c0 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.175906] [    T140] R10: 0000000000000282 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.175907] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.175909] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.175911] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.175913] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.175915] [    T140] PKRU: 55555554
> [13631.175916] [    T140] Call Trace:
> [13631.175918] [    T140]  <TASK>
> [13631.175920] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.175922] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.176005] [    T140]  ? report_bug+0xfa/0x140
> [13631.176009] [    T140]  ? handle_bug+0x53/0x90
> [13631.176012] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.176014] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.176018] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.176113] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.176116] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.176195] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.176312] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.176424] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.176509] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.176513] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.176516] [    T140]  pci_device_probe+0xc0/0x180
> [13631.176519] [    T140]  really_probe+0xd9/0x340
> [13631.176522] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.176525] [    T140]  __driver_probe_device+0x73/0x110
> [13631.176528] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.176532] [    T140]  __device_attach_driver+0x84/0x110
> [13631.176535] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.176538] [    T140]  __device_attach+0xab/0x1b0
> [13631.176542] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.176544] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.176547] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.176549] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.176552] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.176554] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.176557] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.176559] [    T140]  pciehp_ist+0x13b/0x180
> [13631.176562] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.176565] [    T140]  irq_thread+0x114/0x1e0
> [13631.176568] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.176571] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.176574] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.176577] [    T140]  kthread+0xea/0x1e0
> [13631.176580] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.176583] [    T140]  ret_from_fork+0x2f/0x50
> [13631.176586] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.176588] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.176593] [    T140]  </TASK>
> [13631.176594] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.176602] [    T140] ------------[ cut here ]------------
> [13631.176603] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.176691] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.176754] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.176786] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.176789] [    T140] Tainted: [W]=WARN
> [13631.176790] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.176792] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.176875] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.176877] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.176880] [    T140] RAX: ffff8c320beb3600 RBX: ffff8c32a58af450 RCX: 0000000000000000
> [13631.176881] [    T140] RDX: 0000000000000000 RSI: ffff8c32a58afa88 RDI: ffff8c32a5880000
> [13631.176883] [    T140] RBP: ffff8c32a58902c8 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.176885] [    T140] R10: 0000000000000282 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.176886] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.176888] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.176890] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.176892] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.176894] [    T140] PKRU: 55555554
> [13631.176895] [    T140] Call Trace:
> [13631.176897] [    T140]  <TASK>
> [13631.176899] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.176902] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.176984] [    T140]  ? report_bug+0xfa/0x140
> [13631.176988] [    T140]  ? handle_bug+0x53/0x90
> [13631.176991] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.176993] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.176996] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.177078] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.177081] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.177160] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.177278] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.177388] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.177465] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.177479] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.177482] [    T140]  pci_device_probe+0xc0/0x180
> [13631.177485] [    T140]  really_probe+0xd9/0x340
> [13631.177488] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.177492] [    T140]  __driver_probe_device+0x73/0x110
> [13631.177495] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.177498] [    T140]  __device_attach_driver+0x84/0x110
> [13631.177502] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.177505] [    T140]  __device_attach+0xab/0x1b0
> [13631.177508] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.177511] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.177514] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.177516] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.177518] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.177521] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.177523] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.177526] [    T140]  pciehp_ist+0x13b/0x180
> [13631.177529] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.177532] [    T140]  irq_thread+0x114/0x1e0
> [13631.177534] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.177537] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.177541] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.177543] [    T140]  kthread+0xea/0x1e0
> [13631.177546] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.177549] [    T140]  ret_from_fork+0x2f/0x50
> [13631.177552] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.177555] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.177560] [    T140]  </TASK>
> [13631.177561] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.177569] [    T140] ------------[ cut here ]------------
> [13631.177571] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.177659] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.177722] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.177754] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.177757] [    T140] Tainted: [W]=WARN
> [13631.177758] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.177760] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.177844] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.177846] [    T140] RSP: 0018:ffff9ac3c0743b08 EFLAGS: 00010246
> [13631.177848] [    T140] RAX: ffff8c320135dd00 RBX: ffff8c32a58b23d0 RCX: 0000000000000000
> [13631.177850] [    T140] RDX: 0000000000000000 RSI: ffff8c32a58b42c0 RDI: ffff8c32a5880000
> [13631.177852] [    T140] RBP: ffff8c32a58902d0 R08: 0000000000000002 R09: ffff8c34ba798f40
> [13631.177853] [    T140] R10: 0000000000000282 R11: 0000000000000003 R12: ffff8c32a5890630
> [13631.177855] [    T140] R13: ffff8c32a5880010 R14: ffff8c32a5880000 R15: ffff9ac3c0743b14
> [13631.177857] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.177859] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.177861] [    T140] CR2: 00007fd810faa000 CR3: 000000010c6ee000 CR4: 0000000000750ef0
> [13631.177862] [    T140] PKRU: 55555554
> [13631.177864] [    T140] Call Trace:
> [13631.177866] [    T140]  <TASK>
> [13631.177867] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.177870] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.177953] [    T140]  ? report_bug+0xfa/0x140
> [13631.177956] [    T140]  ? handle_bug+0x53/0x90
> [13631.177959] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.177961] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.177965] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.178047] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13631.178050] [    T140]  amdgpu_fence_driver_hw_fini+0xf2/0x120 [amdgpu]
> [13631.178128] [    T140]  amdgpu_device_fini_hw+0xad/0x2ad [amdgpu]
> [13631.178245] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.178356] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.178432] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.178436] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.178439] [    T140]  pci_device_probe+0xc0/0x180
> [13631.178442] [    T140]  really_probe+0xd9/0x340
> [13631.178445] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.178448] [    T140]  __driver_probe_device+0x73/0x110
> [13631.178451] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.178455] [    T140]  __device_attach_driver+0x84/0x110
> [13631.178458] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.178461] [    T140]  __device_attach+0xab/0x1b0
> [13631.178465] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.178479] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.178481] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.178484] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.178486] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.178489] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.178491] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.178494] [    T140]  pciehp_ist+0x13b/0x180
> [13631.178497] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.178500] [    T140]  irq_thread+0x114/0x1e0
> [13631.178503] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.178506] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.178509] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.178511] [    T140]  kthread+0xea/0x1e0
> [13631.178515] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.178518] [    T140]  ret_from_fork+0x2f/0x50
> [13631.178521] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.178523] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.178528] [    T140]  </TASK>
> [13631.178529] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.342117] [    T140] ------------[ cut here ]------------
> [13631.342123] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.342257] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13631.342342] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13631.342389] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13631.342394] [    T140] Tainted: [W]=WARN
> [13631.342396] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13631.342399] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.342528] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 bf 80 a9 c5 e9 9f fd ff ff
> <0f> 0b b8 ea ff ff ff e9 ae 80 a9 c5 b8 ea ff ff ff e9 a4 80 a9 c5
> [13631.342532] [    T140] RSP: 0018:ffff9ac3c0743b30 EFLAGS: 00010246
> [13631.342536] [    T140] RAX: ffff8c3203e262a0 RBX: ffff8c32a5880000 RCX: 0000000000000000
> [13631.342538] [    T140] RDX: 0000000000000000 RSI: ffff8c32a5880c78 RDI: ffff8c32a5880000
> [13631.342541] [    T140] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> [13631.342543] [    T140] R10: ffff8c34ba79de60 R11: 0000000000000000 R12: ffff8c32a58c6de8
> [13631.342546] [    T140] R13: 0000000000000021 R14: ffff8c32a5880000 R15: ffff8c32a5880010
> [13631.342548] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13631.342551] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13631.342553] [    T140] CR2: 00007fd810faa000 CR3: 000000010f62a000 CR4: 0000000000750ef0
> [13631.342555] [    T140] PKRU: 55555554
> [13631.342557] [    T140] Call Trace:
> [13631.342559] [    T140]  <TASK>
> [13631.342562] [    T140]  ? __warn.cold+0x90/0x9e
> [13631.342566] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.342652] [    T140]  ? report_bug+0xfa/0x140
> [13631.342656] [    T140]  ? handle_bug+0x53/0x90
> [13631.342660] [    T140]  ? exc_invalid_op+0x17/0x70
> [13631.342662] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13631.342666] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
> [13631.342746] [    T140]  gmc_v10_0_hw_fini+0x52/0xb0 [amdgpu]
> [13631.342838] [    T140]  amdgpu_ip_block_hw_fini+0x2b/0x59 [amdgpu]
> [13631.342961] [    T140]  amdgpu_device_fini_hw+0x1fe/0x2ad [amdgpu]
> [13631.343073] [    T140]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [13631.343180] [    T140]  amdgpu_pci_probe+0x167/0x3e0 [amdgpu]
> [13631.343255] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.343259] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13631.343262] [    T140]  pci_device_probe+0xc0/0x180
> [13631.343266] [    T140]  really_probe+0xd9/0x340
> [13631.343269] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13631.343272] [    T140]  __driver_probe_device+0x73/0x110
> [13631.343275] [    T140]  driver_probe_device+0x1a/0xa0
> [13631.343279] [    T140]  __device_attach_driver+0x84/0x110
> [13631.343282] [    T140]  bus_for_each_drv+0x82/0xe0
> [13631.343285] [    T140]  __device_attach+0xab/0x1b0
> [13631.343289] [    T140]  pci_bus_add_device+0x53/0x80
> [13631.343292] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13631.343294] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.343297] [    T140]  pci_bus_add_devices+0x56/0x70
> [13631.343299] [    T140]  pciehp_configure_device+0xaa/0x160
> [13631.343302] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13631.343304] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13631.343307] [    T140]  pciehp_ist+0x13b/0x180
> [13631.343310] [    T140]  irq_thread_fn+0x1e/0x60
> [13631.343314] [    T140]  irq_thread+0x114/0x1e0
> [13631.343316] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13631.343319] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13631.343323] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13631.343325] [    T140]  kthread+0xea/0x1e0
> [13631.343329] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.343332] [    T140]  ret_from_fork+0x2f/0x50
> [13631.343336] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13631.343338] [    T140]  ret_from_fork_asm+0x11/0x20
> [13631.343343] [    T140]  </TASK>
> [13631.343345] [    T140] ---[ end trace 0000000000000000 ]---
> [13631.351179] [    T140] amdgpu 0000:03:00.0: probe with driver amdgpu failed with error -121
> [13632.005054] [    T140] ------------[ cut here ]------------
> [13632.005063] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/drm_buddy.c:337 drm_buddy_fini+0xa8/0xb0 [drm_buddy]
> [13632.005073] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13632.005147] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13632.005189] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13632.005194] [    T140] Tainted: [W]=WARN
> [13632.005196] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13632.005199] [    T140] RIP: 0010:drm_buddy_fini+0xa8/0xb0 [drm_buddy]
> [13632.005202] [    T140] Code: 44 3b 6d 10 72 a3 4c 8b 65 20 4c 39 65 28 75 1e 48 8b 7d 08 e8 79 1d f1 c5 48 8b 7d 00 5b 5d 41 5c 41 5d 41 5e e9 68 1d f1 c5
> <0f> 0b eb b3 0f 0b eb de f3 0f 1e fa 48 8b 0e 89 c8 25 00 0c 00 00
> [13632.005205] [    T140] RSP: 0018:ffff9ac3c0743a90 EFLAGS: 00010206
> [13632.005208] [    T140] RAX: 0000000000000c00 RBX: 000000000000000c RCX: 00000001feacbfff
> [13632.005210] [    T140] RDX: ffff8c3203757ea0 RSI: ffff8c3221b8f750 RDI: ffff8c3205edda00
> [13632.005212] [    T140] RBP: ffff8c32a588fa50 R08: 0000000000000001 R09: 0000000000000000
> [13632.005214] [    T140] R10: ffff8c3205edda00 R11: 00000001feaca000 R12: 0000000001000000
> [13632.005216] [    T140] R13: 0000000000000008 R14: 00000000ffffffff R15: ffff8c32a588fa50
> [13632.005218] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13632.005220] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13632.005222] [    T140] CR2: 00007fd810faa000 CR3: 000000010f62a000 CR4: 0000000000750ef0
> [13632.005224] [    T140] PKRU: 55555554
> [13632.005226] [    T140] Call Trace:
> [13632.005229] [    T140]  <TASK>
> [13632.005232] [    T140]  ? __warn.cold+0x90/0x9e
> [13632.005238] [    T140]  ? drm_buddy_fini+0xa8/0xb0 [drm_buddy]
> [13632.005242] [    T140]  ? report_bug+0xfa/0x140
> [13632.005247] [    T140]  ? handle_bug+0x53/0x90
> [13632.005252] [    T140]  ? exc_invalid_op+0x17/0x70
> [13632.005255] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13632.005260] [    T140]  ? drm_buddy_fini+0xa8/0xb0 [drm_buddy]
> [13632.005264] [    T140]  amdgpu_vram_mgr_fini+0x17a/0x1b0 [amdgpu]
> [13632.005422] [    T140]  amdgpu_ttm_fini+0x14b/0x210 [amdgpu]
> [13632.005540] [    T140]  amdgpu_bo_fini+0x1f/0x90 [amdgpu]
> [13632.005649] [    T140]  gmc_v10_0_sw_fini+0x29/0x40 [amdgpu]
> [13632.005772] [    T140]  amdgpu_device_fini_sw+0xc8/0x3c0 [amdgpu]
> [13632.005879] [    T140]  amdgpu_driver_release_kms+0x11/0x30 [amdgpu]
> [13632.005990] [    T140]  drm_dev_put.part.0+0x37/0x60
> [13632.005993] [    T140]  devres_release_all+0xa6/0xf0
> [13632.005998] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13632.006001] [    T140]  device_unbind_cleanup+0x9/0x70
> [13632.006004] [    T140]  really_probe+0x21c/0x340
> [13632.006008] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13632.006012] [    T140]  __driver_probe_device+0x73/0x110
> [13632.006016] [    T140]  driver_probe_device+0x1a/0xa0
> [13632.006019] [    T140]  __device_attach_driver+0x84/0x110
> [13632.006022] [    T140]  bus_for_each_drv+0x82/0xe0
> [13632.006026] [    T140]  __device_attach+0xab/0x1b0
> [13632.006030] [    T140]  pci_bus_add_device+0x53/0x80
> [13632.006033] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13632.006036] [    T140]  pci_bus_add_devices+0x56/0x70
> [13632.006038] [    T140]  pci_bus_add_devices+0x56/0x70
> [13632.006041] [    T140]  pciehp_configure_device+0xaa/0x160
> [13632.006044] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13632.006047] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13632.006050] [    T140]  pciehp_ist+0x13b/0x180
> [13632.006053] [    T140]  irq_thread_fn+0x1e/0x60
> [13632.006056] [    T140]  irq_thread+0x114/0x1e0
> [13632.006059] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13632.006062] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13632.006065] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13632.006068] [    T140]  kthread+0xea/0x1e0
> [13632.006072] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13632.006075] [    T140]  ret_from_fork+0x2f/0x50
> [13632.006079] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13632.006082] [    T140]  ret_from_fork_asm+0x11/0x20
> [13632.006087] [    T140]  </TASK>
> [13632.006088] [    T140] ---[ end trace 0000000000000000 ]---
> [13632.006100] [    T140] ------------[ cut here ]------------
> [13632.006102] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/drm_buddy.c:344 drm_buddy_fini+0xac/0xb0 [drm_buddy]
> [13632.006105] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13632.006169] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13632.006203] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13632.006206] [    T140] Tainted: [W]=WARN
> [13632.006208] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13632.006210] [    T140] RIP: 0010:drm_buddy_fini+0xac/0xb0 [drm_buddy]
> [13632.006212] [    T140] Code: 72 a3 4c 8b 65 20 4c 39 65 28 75 1e 48 8b 7d 08 e8 79 1d f1 c5 48 8b 7d 00 5b 5d 41 5c 41 5d 41 5e e9 68 1d f1 c5 0f 0b eb b3
> <0f> 0b eb de f3 0f 1e fa 48 8b 0e 89 c8 25 00 0c 00 00 3d 00 04 00
> [13632.006214] [    T140] RSP: 0018:ffff9ac3c0743a90 EFLAGS: 00010287
> [13632.006217] [    T140] RAX: 0000000001000000 RBX: 000000000000000c RCX: 000000000000000c
> [13632.006219] [    T140] RDX: 0000000000001000 RSI: ffff8c3221b8f750 RDI: 0000000000380022
> [13632.006221] [    T140] RBP: ffff8c32a588fa50 R08: 0000000000000001 R09: 0000000000000000
> [13632.006222] [    T140] R10: 0000000000380022 R11: 0000000000000000 R12: 00000001ff000000
> [13632.006224] [    T140] R13: 0000000000000009 R14: 00000000ffffffff R15: ffff8c32a588fa50
> [13632.006226] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13632.006228] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13632.006230] [    T140] CR2: 00007fd810faa000 CR3: 000000010f62a000 CR4: 0000000000750ef0
> [13632.006232] [    T140] PKRU: 55555554
> [13632.006233] [    T140] Call Trace:
> [13632.006235] [    T140]  <TASK>
> [13632.006237] [    T140]  ? __warn.cold+0x90/0x9e
> [13632.006240] [    T140]  ? drm_buddy_fini+0xac/0xb0 [drm_buddy]
> [13632.006242] [    T140]  ? report_bug+0xfa/0x140
> [13632.006246] [    T140]  ? handle_bug+0x53/0x90
> [13632.006249] [    T140]  ? exc_invalid_op+0x17/0x70
> [13632.006252] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13632.006255] [    T140]  ? drm_buddy_fini+0xac/0xb0 [drm_buddy]
> [13632.006258] [    T140]  amdgpu_vram_mgr_fini+0x17a/0x1b0 [amdgpu]
> [13632.006385] [    T140]  amdgpu_ttm_fini+0x14b/0x210 [amdgpu]
> [13632.006511] [    T140]  amdgpu_bo_fini+0x1f/0x90 [amdgpu]
> [13632.006632] [    T140]  gmc_v10_0_sw_fini+0x29/0x40 [amdgpu]
> [13632.006763] [    T140]  amdgpu_device_fini_sw+0xc8/0x3c0 [amdgpu]
> [13632.006883] [    T140]  amdgpu_driver_release_kms+0x11/0x30 [amdgpu]
> [13632.006964] [    T140]  drm_dev_put.part.0+0x37/0x60
> [13632.006966] [    T140]  devres_release_all+0xa6/0xf0
> [13632.006970] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13632.006973] [    T140]  device_unbind_cleanup+0x9/0x70
> [13632.006976] [    T140]  really_probe+0x21c/0x340
> [13632.006979] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13632.006983] [    T140]  __driver_probe_device+0x73/0x110
> [13632.006986] [    T140]  driver_probe_device+0x1a/0xa0
> [13632.006989] [    T140]  __device_attach_driver+0x84/0x110
> [13632.006993] [    T140]  bus_for_each_drv+0x82/0xe0
> [13632.006996] [    T140]  __device_attach+0xab/0x1b0
> [13632.007000] [    T140]  pci_bus_add_device+0x53/0x80
> [13632.007003] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13632.007005] [    T140]  pci_bus_add_devices+0x56/0x70
> [13632.007008] [    T140]  pci_bus_add_devices+0x56/0x70
> [13632.007010] [    T140]  pciehp_configure_device+0xaa/0x160
> [13632.007013] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13632.007015] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13632.007018] [    T140]  pciehp_ist+0x13b/0x180
> [13632.007021] [    T140]  irq_thread_fn+0x1e/0x60
> [13632.007024] [    T140]  irq_thread+0x114/0x1e0
> [13632.007027] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13632.007030] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13632.007033] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13632.007036] [    T140]  kthread+0xea/0x1e0
> [13632.007039] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13632.007042] [    T140]  ret_from_fork+0x2f/0x50
> [13632.007045] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13632.007048] [    T140]  ret_from_fork_asm+0x11/0x20
> [13632.007053] [    T140]  </TASK>
> [13632.007054] [    T140] ---[ end trace 0000000000000000 ]---
> [13632.007059] [    T140] ------------[ cut here ]------------
> [13632.007061] [    T140] Memory manager not clean during takedown.
> [13632.007066] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/drm_mm.c:964 drm_mm_takedown+0x22/0x30
> [13632.007069] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13632.007133] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13632.007167] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13632.007170] [    T140] Tainted: [W]=WARN
> [13632.007171] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13632.007173] [    T140] RIP: 0010:drm_mm_takedown+0x22/0x30
> [13632.007175] [    T140] Code: 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 8b 47 38 48 83 c7 38 48 39 f8 75 05 e9 55 74 8e ff 48 c7 c7 f0 ad e7 86 e8 be c1 a7 ff
> <0f> 0b e9 42 74 8e ff 0f 1f 80 00 00 00 00 f3 0f 1e fa 41 57 49 89
> [13632.007177] [    T140] RSP: 0018:ffff9ac3c0743ac8 EFLAGS: 00010282
> [13632.007180] [    T140] RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000000027
> [13632.007181] [    T140] RDX: ffff8c34ba797808 RSI: 0000000000000001 RDI: ffff8c34ba797800
> [13632.007183] [    T140] RBP: ffff8c3205edfe00 R08: 0000000000000000 R09: ffff9ac3c0743950
> [13632.007185] [    T140] R10: ffff8c34e02fffa8 R11: 0000000000000003 R12: ffff8c32a588ef80
> [13632.007187] [    T140] R13: ffff8c3205edff70 R14: 0000000000000000 R15: ffff8c3276051358
> [13632.007188] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13632.007190] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13632.007192] [    T140] CR2: 00007fd810faa000 CR3: 000000010f62a000 CR4: 0000000000750ef0
> [13632.007194] [    T140] PKRU: 55555554
> [13632.007195] [    T140] Call Trace:
> [13632.007197] [    T140]  <TASK>
> [13632.007199] [    T140]  ? __warn.cold+0x90/0x9e
> [13632.007202] [    T140]  ? drm_mm_takedown+0x22/0x30
> [13632.007204] [    T140]  ? report_bug+0xfa/0x140
> [13632.007207] [    T140]  ? srso_alias_return_thunk+0x5/0xfbef5
> [13632.007211] [    T140]  ? handle_bug+0x53/0x90
> [13632.007214] [    T140]  ? exc_invalid_op+0x17/0x70
> [13632.007216] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
> [13632.007220] [    T140]  ? drm_mm_takedown+0x22/0x30
> [13632.007222] [    T140]  ? drm_mm_takedown+0x22/0x30
> [13632.007224] [    T140]  ttm_range_man_fini_nocheck+0x86/0x100 [ttm]
> [13632.007230] [    T140]  amdgpu_ttm_fini+0x18f/0x210 [amdgpu]
> [13632.007310] [    T140]  amdgpu_bo_fini+0x1f/0x90 [amdgpu]
> [13632.007390] [    T140]  gmc_v10_0_sw_fini+0x29/0x40 [amdgpu]
> [13632.007484] [    T140]  amdgpu_device_fini_sw+0xc8/0x3c0 [amdgpu]
> [13632.007563] [    T140]  amdgpu_driver_release_kms+0x11/0x30 [amdgpu]
> [13632.007641] [    T140]  drm_dev_put.part.0+0x37/0x60
> [13632.007644] [    T140]  devres_release_all+0xa6/0xf0
> [13632.007648] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13632.007651] [    T140]  device_unbind_cleanup+0x9/0x70
> [13632.007654] [    T140]  really_probe+0x21c/0x340
> [13632.007657] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13632.007660] [    T140]  __driver_probe_device+0x73/0x110
> [13632.007663] [    T140]  driver_probe_device+0x1a/0xa0
> [13632.007666] [    T140]  __device_attach_driver+0x84/0x110
> [13632.007670] [    T140]  bus_for_each_drv+0x82/0xe0
> [13632.007673] [    T140]  __device_attach+0xab/0x1b0
> [13632.007677] [    T140]  pci_bus_add_device+0x53/0x80
> [13632.007680] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13632.007682] [    T140]  pci_bus_add_devices+0x56/0x70
> [13632.007685] [    T140]  pci_bus_add_devices+0x56/0x70
> [13632.007687] [    T140]  pciehp_configure_device+0xaa/0x160
> [13632.007690] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13632.007692] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13632.007695] [    T140]  pciehp_ist+0x13b/0x180
> [13632.007698] [    T140]  irq_thread_fn+0x1e/0x60
> [13632.007701] [    T140]  irq_thread+0x114/0x1e0
> [13632.007704] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13632.007707] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13632.007710] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13632.007713] [    T140]  kthread+0xea/0x1e0
> [13632.007716] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13632.007719] [    T140]  ret_from_fork+0x2f/0x50
> [13632.007722] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13632.007725] [    T140]  ret_from_fork_asm+0x11/0x20
> [13632.007729] [    T140]  </TASK>
> [13632.007731] [    T140] ---[ end trace 0000000000000000 ]---
> [13632.007752] [    T140] [drm] amdgpu: ttm finalized
> [13632.007775] [    T140] BUG: kernel NULL pointer dereference, address: 0000000000000058
> [13632.007777] [    T140] #PF: supervisor read access in kernel mode
> [13632.007779] [    T140] #PF: error_code(0x0000) - not-present page
> [13632.007781] [    T140] PGD 175454067 P4D 175454067 PUD 0
> [13632.007786] [    T140] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [13632.007788] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Kdump: loaded Tainted: G        W          6.14.0-rc1-mystery-00004-g822c11592522 #43
> [13632.007791] [    T140] Tainted: [W]=WARN
> [13632.007793] [    T140] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [13632.007795] [    T140] RIP: 0010:ttm_resource_move_to_lru_tail+0xc1/0xe0 [ttm]
> [13632.007799] [    T140] Code: 46 40 48 8b 94 ca 98 00 00 00 48 8b 4e 48 48 89 4f 08 48 89 39 48 89 c1 48 83 c0 03 48 c1 e1 04 48 c1 e0 04 48 01 d1 48 01 c2
> <48> 8b 79 38 4c 89 41 38 48 89 56 40 48 89 7e 48 4c 89 07 e9 42 0d
> [13632.007801] [    T140] RSP: 0018:ffff9ac3c0743af0 EFLAGS: 00010206
> [13632.007803] [    T140] RAX: 0000000000000050 RBX: ffff8c3276008848 RCX: 0000000000000020
> [13632.007805] [    T140] RDX: 0000000000000050 RSI: ffff8c332918e100 RDI: ffff8c332918e140
> [13632.007807] [    T140] RBP: ffff8c32a588ef80 R08: ffff8c332918e140 R09: 0000000000000000
> [13632.007809] [    T140] R10: 0000000000400032 R11: 0000000000000000 R12: 0000000000000000
> [13632.007811] [    T140] R13: ffff8c3276008800 R14: ffff8c32a588ef80 R15: ffff8c3276051358
> [13632.007812] [    T140] FS:  0000000000000000(0000) GS:ffff8c34ba780000(0000) knlGS:0000000000000000
> [13632.007814] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13632.007816] [    T140] CR2: 0000000000000058 CR3: 000000010f62a000 CR4: 0000000000750ef0
> [13632.007818] [    T140] PKRU: 55555554
> [13632.007820] [    T140] Call Trace:
> [13632.007821] [    T140]  <TASK>
> [13632.007823] [    T140]  ? __die+0x51/0x92
> [13632.007826] [    T140]  ? page_fault_oops+0x99/0x220
> [13632.007831] [    T140]  ? exc_page_fault+0x32e/0x600
> [13632.007834] [    T140]  ? asm_exc_page_fault+0x26/0x30
> [13632.007837] [    T140]  ? ttm_resource_move_to_lru_tail+0xc1/0xe0 [ttm]
> [13632.007841] [    T140]  ttm_bo_unpin+0x58/0x80 [ttm]
> [13632.007845] [    T140]  amdgpu_bo_unpin+0x19/0x90 [amdgpu]
> [13632.007926] [    T140]  amdgpu_bo_free_kernel+0x77/0x100 [amdgpu]
> [13632.008006] [    T140]  amdgpu_device_fini_sw+0x339/0x3c0 [amdgpu]
> [13632.008085] [    T140]  amdgpu_driver_release_kms+0x11/0x30 [amdgpu]
> [13632.008163] [    T140]  drm_dev_put.part.0+0x37/0x60
> [13632.008166] [    T140]  devres_release_all+0xa6/0xf0
> [13632.008169] [    T140]  ? driver_probe_device+0xa0/0xa0
> [13632.008173] [    T140]  device_unbind_cleanup+0x9/0x70
> [13632.008176] [    T140]  really_probe+0x21c/0x340
> [13632.008179] [    T140]  ? pm_runtime_barrier+0x4f/0x90
> [13632.008182] [    T140]  __driver_probe_device+0x73/0x110
> [13632.008185] [    T140]  driver_probe_device+0x1a/0xa0
> [13632.008188] [    T140]  __device_attach_driver+0x84/0x110
> [13632.008192] [    T140]  bus_for_each_drv+0x82/0xe0
> [13632.008195] [    T140]  __device_attach+0xab/0x1b0
> [13632.008199] [    T140]  pci_bus_add_device+0x53/0x80
> [13632.008201] [    T140]  pci_bus_add_devices+0x2b/0x70
> [13632.008204] [    T140]  pci_bus_add_devices+0x56/0x70
> [13632.008206] [    T140]  pci_bus_add_devices+0x56/0x70
> [13632.008209] [    T140]  pciehp_configure_device+0xaa/0x160
> [13632.008211] [    T140]  ? pcie_capability_read_word+0x7a/0x90
> [13632.008214] [    T140]  pciehp_handle_presence_or_link_change+0x1b2/0x350
> [13632.008217] [    T140]  pciehp_ist+0x13b/0x180
> [13632.008220] [    T140]  irq_thread_fn+0x1e/0x60
> [13632.008223] [    T140]  irq_thread+0x114/0x1e0
> [13632.008225] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
> [13632.008228] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
> [13632.008232] [    T140]  ? irq_affinity_notify+0xd0/0xd0
> [13632.008235] [    T140]  kthread+0xea/0x1e0
> [13632.008238] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13632.008241] [    T140]  ret_from_fork+0x2f/0x50
> [13632.008244] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
> [13632.008247] [    T140]  ret_from_fork_asm+0x11/0x20
> [13632.008251] [    T140]  </TASK>
> [13632.008253] [    T140] Modules linked in: sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
> snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi btusb btrtl snd_hda_intel btintel snd_intel_dspcfg btbcm
> uvcvideo snd_hda_codec btmtk videobuf2_vmalloc snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn videobuf2_memops snd_hwdep uvc bluetooth snd_soc_core snd_hda_core
> videobuf2_v4l2 snd_pcm_oss videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_timer snd_acp_config msi_wmi snd_soc_acpi
> ecdh_generic ecc mc wmi_bmof sparse_keymap snd k10temp snd_pci_acp3x soundcore ccp ac battery button hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_gyro_3d
> hid_sensor_prox hid_sensor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf amd_pmc industrialio hid_sensor_iio_common joydev evdev mt7921e
> mt7921_common mt792x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore
> [13632.008316] [    T140]  configfs efivarfs autofs4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks
> drm_exec drm_suballoc_helper cec xhci_pci amdxcp drm_buddy xhci_hcd gpu_sched hid_sensor_hub mfd_core hid_multitouch hid_generic drm_display_helper usbcore
> psmouse i2c_hid_acpi amd_sfh nvme i2c_hid hid serio_raw drm_kms_helper nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_platform
> i2c_designware_core
> [13632.008349] [    T140] CR2: 0000000000000058
> 
> 
> Bert Karwatzki


