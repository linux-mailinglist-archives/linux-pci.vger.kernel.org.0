Return-Path: <linux-pci+bounces-39934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A8C2548D
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 14:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A1E18950E9
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDC02236EB;
	Fri, 31 Oct 2025 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="uhs5o8ue"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1330221D96;
	Fri, 31 Oct 2025 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917934; cv=none; b=SiyvfYuG1K8OGljG0wdVFSEwPK+YZQyZMMM6BbWd/MA7FW6u0cGpfpZv9uRot/2+KFT7XhGBWNyEruR3rWCsYXfrayFONIjUwjOJZjYpOxUBVdcEG6eNApSmiuMbrpE+5vyDisKHHZ0HR2iR9bpslUrUHsctA/mVRQMu87L83ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917934; c=relaxed/simple;
	bh=R/+HG0zSBDY/C1p8ivCwR+EcyHjCB2x4shhvkltW2Yw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Slrhixmur1EIG2tKGiTnDIW8ecZMrZTwBLp9yePijO0moFklbKnZPboB2krgb7kfByfZbXJiRedOXjGE8o8yIOx8zzuPEVsfqjdrSeqTJy/pHiTf185pupmlq0P/RqH2d9tpweKGGBuFebaqbt06xmoz9cfJQz3ybu7BpcOAO08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=uhs5o8ue; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761917906; x=1762522706; i=spasswolf@web.de;
	bh=yEe00GzuhJtpNup8HltnhHTUxomqKKrdkJX8F+/Pzcw=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uhs5o8ue99ep4wKs9JFQLebJ26YFlY3NcNF7fE1+42A3g2XNtRVogFeECbrC43bV
	 tEVctl+LAT0kRWRqSg8vBExQhdy+Mjc6hMiowTDzHUEPFAEEW+xkiUV2Jh44wr0x7
	 0rIvPFOiFliA5tjlv9qaFYU0EKBdw85lgL7SJ/RxSDN7UO5xb2YzL/3UyziMQOE3u
	 bCsM+gipgn8XLO00CyS9zKtJ650FPnvVxVG2w7sQkj//Ux3hNuU2ee4wmh39an5x9
	 ydfwoxi6LVOaN3HYesOMXtP+lhVz3oa0HRSAZNC5cyMWnHxnQI7kkg62oTWP1s4O9
	 PDXDEn8qCdDzNv2g/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mm9Va-1vweTi0ria-00aLyk; Fri, 31
 Oct 2025 14:38:26 +0100
Message-ID: <f18bafacbd8316c9623658e2935f8fc3b276af64.camel@web.de>
Subject: Re: [REGRESSION 00/04] Crash during resume of pcie bridge
From: Bert Karwatzki <spasswolf@web.de>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Mario
 Limonciello <superm1@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
	 <rafael.j.wysocki@intel.com>, spasswolf@web.de
Date: Fri, 31 Oct 2025 14:38:24 +0100
In-Reply-To: <1853e2af7f70cf726df278137b6d2d89d9d9dc82.camel@web.de>
References: <20251006120944.7880-1-spasswolf@web.de>
				 <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
				 <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de>
				 <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
				 <25f36fa7-d1d6-4b81-a42f-64c445d6f065@amd.com>
	 <1853e2af7f70cf726df278137b6d2d89d9d9dc82.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AnozMPPruOy4pwJwQEAK7+n/DauyxwieSf4bmb6sHFw3clSHjKq
 V1xk+hlcXPmNzbNnBlLT044m223+P4w+ehmZae8YXqGmeNjN25tLD4AG6OJHHClcDo6unMu
 2ZHjFJP6zT7+gPVePDQI4oSp6ddExbHSFSfU9oDuk8zzCDfCsC06mSeYPMy35tDGR+dlJX9
 Dsv/VU3vj3vDfGSQcieUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l5PpPRpFiY0=;Iqv23AL8HOnt8XM1rA0CHXEVow1
 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
 nrGz8/zQBCIMIaJpI=

I'm currently trying to bisect this issue (again ...), and during a test r=
un
with kernel version commit 74adf9e35384 (in linux-next) I temporarily lost=
 the
discrete GPU. This loss did not result in a crash and did not result in a =
permanent
loss of the discrete GPU (i.e. using the discrete GPU (e.g. DRI_PRIME=3D1 =
glxgears)=C2=A0
works again). I'm not sure if this is related to the crashes.

Error messsage:
[76466.462660] [ T179286] pci_bus 0000:03: Allocating resources
[76466.463156] [ T179892] [drm] PCIE GART of 512M enabled (table at 0x0000=
0081FEB00000).
[76466.463193] [ T179892] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[76466.639416] [ T179892] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 fr=
om 0x81fd000000 for PSP TMR
[76466.721071] [ T179892] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras t=
a ucode is not available
[76466.732309] [ T179892] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: secu=
redisplay ta ucode is not available
[76466.732319] [ T179892] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[76466.732326] [ T179892] amdgpu 0000:03:00.0: amdgpu: smu driver if versi=
on =3D 0x0000000f, smu fw if version =3D 0x00000013, smu fw program =3D 0,=
 version =3D
0x003b3100 (59.49.0)
[76466.732333] [ T179892] amdgpu 0000:03:00.0: amdgpu: SMU driver if versi=
on not matched
[76466.806897] [ T179892] amdgpu 0000:03:00.0: amdgpu: SMU is resumed succ=
essfully!
[76466.808829] [ T179892] [drm] kiq ring mec 2 pipe 1 q 0
[76466.815229] [ T179892] [drm] DMUB hardware initialized: version=3D0x020=
20020
[76466.834132] [ T179892] amdgpu 0000:03:00.0: [drm] Cannot find any crtc =
or sizes
[76466.834153] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses=
 VM inv eng 0 on hub 0
[76466.834158] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses=
 VM inv eng 1 on hub 0
[76466.834163] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 use=
s VM inv eng 4 on hub 0
[76466.834167] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 use=
s VM inv eng 5 on hub 0
[76466.834172] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 use=
s VM inv eng 6 on hub 0
[76466.834176] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 use=
s VM inv eng 7 on hub 0
[76466.834180] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 use=
s VM inv eng 8 on hub 0
[76466.834184] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 use=
s VM inv eng 9 on hub 0
[76466.834188] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 use=
s VM inv eng 10 on hub 0
[76466.834193] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 use=
s VM inv eng 11 on hub 0
[76466.834197] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 us=
es VM inv eng 12 on hub 0
[76466.834201] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM =
inv eng 13 on hub 0
[76466.834205] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM =
inv eng 14 on hub 0
[76466.834209] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses=
 VM inv eng 0 on hub 8
[76466.834214] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 us=
es VM inv eng 1 on hub 8
[76466.834218] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 us=
es VM inv eng 4 on hub 8
[76466.834222] [ T179892] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses =
VM inv eng 5 on hub 8
[76466.838133] [ T179892] amdgpu 0000:03:00.0: [drm] Cannot find any crtc =
or sizes
[76619.622697] [ T179316] pci_bus 0000:03: Allocating resources
[76619.622938] [ T179987] [drm] PCIE GART of 512M enabled (table at 0x0000=
0081FEB00000).
[76619.622971] [ T179987] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[76619.798737] [ T179987] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 fr=
om 0x81fd000000 for PSP TMR
[76619.882296] [ T179987] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras t=
a ucode is not available
[76619.893732] [ T179987] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: secu=
redisplay ta ucode is not available
[76619.893751] [ T179987] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[76619.893760] [ T179987] amdgpu 0000:03:00.0: amdgpu: smu driver if versi=
on =3D 0x0000000f, smu fw if version =3D 0x00000013, smu fw program =3D 0,=
 version =3D
0x003b3100 (59.49.0)
[76619.893769] [ T179987] amdgpu 0000:03:00.0: amdgpu: SMU driver if versi=
on not matched
[76620.141719] [ T179987] amdgpu 0000:03:00.0: amdgpu: SMU: response:0xFFF=
FFFFF for index:6 param:0x00000000 message:EnableAllSmuFeatures?
[76620.141736] [ T179987] amdgpu 0000:03:00.0: amdgpu: Failed to enable re=
quested dpm features!
[76620.141742] [ T179987] amdgpu 0000:03:00.0: amdgpu: Failed to setup smc=
 hw!
[76620.141747] [ T179987] amdgpu 0000:03:00.0: amdgpu: resume of IP block =
<smu> failed -121
[76620.141754] [ T179987] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_re=
sume failed (-121).
[76621.007575] [    T140] pcieport 0000:00:01.1: pciehp: Slot(0): Link Dow=
n
[76621.007592] [    T140] pcieport 0000:00:01.1: pciehp: Slot(0): Card not=
 present
[76621.007651] [ T175001] pcieport 0000:02:00.0: Unable to change power st=
ate from D0 to D3hot, device inaccessible
[76621.007736] [ T177848] pcieport 0000:01:00.0: Unable to change power st=
ate from D0 to D3hot, device inaccessible
[76621.085815] [    T140] amdgpu 0000:03:00.0: amdgpu: amdgpu: finishing d=
evice.
[76621.140891] [    T140] ------------[ cut here ]------------
[76621.140904] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/=
amdgpu/amdgpu_object.c:510 amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[76621.141042] [    T140] Modules linked in: ec_sys netconsole sd_mod scsi=
_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_e=
vent
snd_rawmidi snd_seq snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fa=
t snd_hda_codec_generic btusb btrtl btintel snd_hda_codec_hdmi btbcm btmtk
snd_hda_intel uvcvideo snd_intel_dspcfg videobuf2_vmalloc videobuf2_memops=
 snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn uvc bluetooth snd_hda_codec
videobuf2_v4l2 snd_soc_core snd_hwdep snd_hda_core videodev snd_pcm_oss sn=
d_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_acp=
_config
snd_soc_acpi msi_wmi ecdh_generic ecc sparse_keymap snd_timer wmi_bmof mc =
snd ccp soundcore k10temp snd_pci_acp3x battery ac button hid_sensor_prox
hid_sensor_magn_3d hid_sensor_gyro_3d hid_sensor_accel_3d hid_sensor_als h=
id_sensor_trigger industrialio_triggered_buffer kfifo_buf industrialio amd=
_pmc
hid_sensor_iio_common joydev evdev mt7921e mt7921_common mt792x_lib mt76_c=
onnac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse
[76621.141122] [    T140]  nvme_fabrics efi_pstore configfs efivarfs autof=
s4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_hel=
per ttm
drm_panel_backlight_quirks drm_exec drm_suballoc_helper cec xhci_pci amdxc=
p xhci_hcd drm_buddy hid_multitouch hid_sensor_hub gpu_sched mfd_core hid_=
generic
i2c_hid_acpi drm_display_helper psmouse usbcore amd_sfh i2c_hid nvme hid d=
rm_kms_helper serio_raw nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc=
16
i2c_designware_platform i2c_designware_core
[76621.141177] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Not t=
ainted 6.14.0-mystery-00198-g74adf9e35384 #36
[76621.141183] [    T140] Hardware name: Micro-Star International Co., Ltd=
. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[76621.141187] [    T140] RIP: 0010:amdgpu_bo_free_kernel+0xe4/0x100 [amdg=
pu]
[76621.141312] [    T140] Code: f6 ff ff 4d 85 e4 74 08 49 c7 04 24 00 00 =
00 00 48 85 ed 74 08 48 c7 45 00 00 00 00 00 5b 5d 41 5c 41 5d 41 5e e9 a7=
 99 65 c7
<0f> 0b e9 4b ff ff ff 3d 00 fe ff ff 0f 85 e5 9d 5d 00 eb bd 0f 1f
[76621.141317] [    T140] RSP: 0018:ffffb97f00743bd0 EFLAGS: 00010202
[76621.141323] [    T140] RAX: 0000000000000000 RBX: ffff9f050a4bb890 RCX:=
 0000000080000000
[76621.141332] [    T140] RDX: ffff9f050a4bb8e0 RSI: ffff9f050a4bb8e8 RDI:=
 ffff9f050a4bb890
[76621.141336] [    T140] RBP: ffff9f050a4bb8e0 R08: 0000000000000000 R09:=
 0000000000000014
[76621.141340] [    T140] R10: 0000000000000001 R11: 0000000000000000 R12:=
 ffff9f050a4bb8e8
[76621.141344] [    T140] R13: ffff9f0512d7f400 R14: ffff9f050a48ef80 R15:=
 ffffb97f00743d6e
[76621.141348] [    T140] FS:  0000000000000000(0000) GS:ffff9f07ba780000(=
0000) knlGS:0000000000000000
[76621.141353] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[76621.141357] [    T140] CR2: 00007fe612af0900 CR3: 0000000120cbc000 CR4:=
 0000000000750ef0
[76621.141361] [    T140] PKRU: 55555554
[76621.141365] [    T140] Call Trace:
[76621.141370] [    T140]  <TASK>
[76621.141381] [    T140]  ? __warn.cold+0x90/0x9e
[76621.141388] [    T140]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[76621.141507] [    T140]  ? report_bug+0xfa/0x140
[76621.141513] [    T140]  ? handle_bug+0x53/0x90
[76621.141518] [    T140]  ? exc_invalid_op+0x17/0x70
[76621.141523] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
[76621.141528] [    T140]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[76621.141637] [    T140]  psp_v11_0_ring_destroy+0x2e/0x50 [amdgpu]
[76621.141760] [    T140]  psp_hw_fini+0x126/0x380 [amdgpu]
[76621.141876] [    T140]  amdgpu_ip_block_hw_fini+0x2b/0x59 [amdgpu]
[76621.142041] [    T140]  amdgpu_device_fini_hw+0x1fe/0x2ad [amdgpu]
[76621.142195] [    T140]  amdgpu_pci_remove+0x40/0x70 [amdgpu]
[76621.142299] [    T140]  pci_device_remove+0x3d/0xb0
[76621.142305] [    T140]  device_release_driver_internal+0x197/0x200
[76621.142311] [    T140]  pci_stop_bus_device+0x68/0x80
[76621.142317] [    T140]  pci_stop_bus_device+0x38/0x80
[76621.142322] [    T140]  pci_stop_bus_device+0x27/0x80
[76621.142327] [    T140]  pci_stop_and_remove_bus_device+0xd/0x20
[76621.142332] [    T140]  pciehp_unconfigure_device+0x93/0x180
[76621.142337] [    T140]  pciehp_disable_slot+0x62/0x100
[76621.142343] [    T140]  pciehp_handle_presence_or_link_change+0x72/0x35=
0
[76621.142348] [    T140]  pciehp_ist+0x13b/0x180
[76621.142353] [    T140]  irq_thread_fn+0x1e/0x60
[76621.142359] [    T140]  irq_thread+0x114/0x1e0
[76621.142364] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
[76621.142369] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
[76621.142374] [    T140]  ? irq_affinity_notify+0xd0/0xd0
[76621.142379] [    T140]  kthread+0xea/0x1e0
[76621.142385] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
[76621.142390] [    T140]  ret_from_fork+0x2f/0x50
[76621.142395] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
[76621.142400] [    T140]  ret_from_fork_asm+0x11/0x20
[76621.142408] [    T140]  </TASK>
[76621.142412] [    T140] ---[ end trace 0000000000000000 ]---
[76621.143507] [    T140] ------------[ cut here ]------------
[76621.143511] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/=
amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
[76621.143608] [    T140] Modules linked in: ec_sys netconsole sd_mod scsi=
_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_e=
vent
snd_rawmidi snd_seq snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fa=
t snd_hda_codec_generic btusb btrtl btintel snd_hda_codec_hdmi btbcm btmtk
snd_hda_intel uvcvideo snd_intel_dspcfg videobuf2_vmalloc videobuf2_memops=
 snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn uvc bluetooth snd_hda_codec
videobuf2_v4l2 snd_soc_core snd_hwdep snd_hda_core videodev snd_pcm_oss sn=
d_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_acp=
_config
snd_soc_acpi msi_wmi ecdh_generic ecc sparse_keymap snd_timer wmi_bmof mc =
snd ccp soundcore k10temp snd_pci_acp3x battery ac button hid_sensor_prox
hid_sensor_magn_3d hid_sensor_gyro_3d hid_sensor_accel_3d hid_sensor_als h=
id_sensor_trigger industrialio_triggered_buffer kfifo_buf industrialio amd=
_pmc
hid_sensor_iio_common joydev evdev mt7921e mt7921_common mt792x_lib mt76_c=
onnac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse
[76621.143688] [    T140]  nvme_fabrics efi_pstore configfs efivarfs autof=
s4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_hel=
per ttm
drm_panel_backlight_quirks drm_exec drm_suballoc_helper cec xhci_pci amdxc=
p xhci_hcd drm_buddy hid_multitouch hid_sensor_hub gpu_sched mfd_core hid_=
generic
i2c_hid_acpi drm_display_helper psmouse usbcore amd_sfh i2c_hid nvme hid d=
rm_kms_helper serio_raw nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc=
16
i2c_designware_platform i2c_designware_core
[76621.143739] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Taint=
ed: G        W          6.14.0-mystery-00198-g74adf9e35384 #36
[76621.143744] [    T140] Tainted: [W]=3DWARN
[76621.143748] [    T140] Hardware name: Micro-Star International Co., Ltd=
. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[76621.143752] [    T140] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
[76621.143855] [    T140] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 =
d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 7f d0 5c c7 e9 9f=
 fd ff ff
<0f> 0b b8 ea ff ff ff e9 6e d0 5c c7 b8 ea ff ff ff e9 64 d0 5c c7
[76621.143859] [    T140] RSP: 0018:ffffb97f00743c30 EFLAGS: 00010246
[76621.143864] [    T140] RAX: ffff9f0500bf3b60 RBX: ffff9f050a480000 RCX:=
 0000000000000000
[76621.143868] [    T140] RDX: 0000000000000000 RSI: ffff9f050a480c78 RDI:=
 ffff9f050a480000
[76621.143872] [    T140] RBP: 0000000000000001 R08: 0000000000000001 R09:=
 0000000000000000
[76621.143876] [    T140] R10: 000000000020001f R11: 0000000000000000 R12:=
 ffff9f050a4c6e48
[76621.143880] [    T140] R13: ffffffffc0cac1a8 R14: ffffffffc0cac1a8 R15:=
 ffffb97f00743d6e
[76621.143884] [    T140] FS:  0000000000000000(0000) GS:ffff9f07ba780000(=
0000) knlGS:0000000000000000
[76621.143888] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[76621.143892] [    T140] CR2: 00007fe612af0900 CR3: 0000000120cbc000 CR4:=
 0000000000750ef0
[76621.143896] [    T140] PKRU: 55555554
[76621.143899] [    T140] Call Trace:
[76621.143903] [    T140]  <TASK>
[76621.143907] [    T140]  ? __warn.cold+0x90/0x9e
[76621.143913] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
[76621.144016] [    T140]  ? report_bug+0xfa/0x140
[76621.144022] [    T140]  ? handle_bug+0x53/0x90
[76621.144026] [    T140]  ? exc_invalid_op+0x17/0x70
[76621.144031] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
[76621.144037] [    T140]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
[76621.144140] [    T140]  gmc_v10_0_hw_fini+0x52/0xb0 [amdgpu]
[76621.144243] [    T140]  amdgpu_ip_block_hw_fini+0x2b/0x59 [amdgpu]
[76621.144387] [    T140]  amdgpu_device_fini_hw+0x1fe/0x2ad [amdgpu]
[76621.144533] [    T140]  amdgpu_pci_remove+0x40/0x70 [amdgpu]
[76621.144629] [    T140]  pci_device_remove+0x3d/0xb0
[76621.144635] [    T140]  device_release_driver_internal+0x197/0x200
[76621.144640] [    T140]  pci_stop_bus_device+0x68/0x80
[76621.144646] [    T140]  pci_stop_bus_device+0x38/0x80
[76621.144650] [    T140]  pci_stop_bus_device+0x27/0x80
[76621.144655] [    T140]  pci_stop_and_remove_bus_device+0xd/0x20
[76621.144660] [    T140]  pciehp_unconfigure_device+0x93/0x180
[76621.144666] [    T140]  pciehp_disable_slot+0x62/0x100
[76621.144671] [    T140]  pciehp_handle_presence_or_link_change+0x72/0x35=
0
[76621.144676] [    T140]  pciehp_ist+0x13b/0x180
[76621.144681] [    T140]  irq_thread_fn+0x1e/0x60
[76621.144687] [    T140]  irq_thread+0x114/0x1e0
[76621.144692] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
[76621.144697] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
[76621.144702] [    T140]  ? irq_affinity_notify+0xd0/0xd0
[76621.144707] [    T140]  kthread+0xea/0x1e0
[76621.144712] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
[76621.144717] [    T140]  ret_from_fork+0x2f/0x50
[76621.144723] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
[76621.144728] [    T140]  ret_from_fork_asm+0x11/0x20
[76621.144735] [    T140]  </TASK>
[76621.144738] [    T140] ---[ end trace 0000000000000000 ]---
[76621.144792] [    T140] ------------[ cut here ]------------
[76621.144796] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/=
amdgpu/amdgpu_object.c:510 amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[76621.144894] [    T140] Modules linked in: ec_sys netconsole sd_mod scsi=
_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_e=
vent
snd_rawmidi snd_seq snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fa=
t snd_hda_codec_generic btusb btrtl btintel snd_hda_codec_hdmi btbcm btmtk
snd_hda_intel uvcvideo snd_intel_dspcfg videobuf2_vmalloc videobuf2_memops=
 snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn uvc bluetooth snd_hda_codec
videobuf2_v4l2 snd_soc_core snd_hwdep snd_hda_core videodev snd_pcm_oss sn=
d_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_acp=
_config
snd_soc_acpi msi_wmi ecdh_generic ecc sparse_keymap snd_timer wmi_bmof mc =
snd ccp soundcore k10temp snd_pci_acp3x battery ac button hid_sensor_prox
hid_sensor_magn_3d hid_sensor_gyro_3d hid_sensor_accel_3d hid_sensor_als h=
id_sensor_trigger industrialio_triggered_buffer kfifo_buf industrialio amd=
_pmc
hid_sensor_iio_common joydev evdev mt7921e mt7921_common mt792x_lib mt76_c=
onnac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse
[76621.144972] [    T140]  nvme_fabrics efi_pstore configfs efivarfs autof=
s4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_hel=
per ttm
drm_panel_backlight_quirks drm_exec drm_suballoc_helper cec xhci_pci amdxc=
p xhci_hcd drm_buddy hid_multitouch hid_sensor_hub gpu_sched mfd_core hid_=
generic
i2c_hid_acpi drm_display_helper psmouse usbcore amd_sfh i2c_hid nvme hid d=
rm_kms_helper serio_raw nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc=
16
i2c_designware_platform i2c_designware_core
[76621.145021] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Taint=
ed: G        W          6.14.0-mystery-00198-g74adf9e35384 #36
[76621.145026] [    T140] Tainted: [W]=3DWARN
[76621.145030] [    T140] Hardware name: Micro-Star International Co., Ltd=
. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[76621.145034] [    T140] RIP: 0010:amdgpu_bo_free_kernel+0xe4/0x100 [amdg=
pu]
[76621.145115] [    T140] Code: f6 ff ff 4d 85 e4 74 08 49 c7 04 24 00 00 =
00 00 48 85 ed 74 08 48 c7 45 00 00 00 00 00 5b 5d 41 5c 41 5d 41 5e e9 a7=
 99 65 c7
<0f> 0b e9 4b ff ff ff 3d 00 fe ff ff 0f 85 e5 9d 5d 00 eb bd 0f 1f
[76621.145119] [    T140] RSP: 0018:ffffb97f00743c00 EFLAGS: 00010202
[76621.145124] [    T140] RAX: ffff9f07ba7a5d80 RBX: ffff9f050a494b60 RCX:=
 000000000000016f
[76621.145127] [    T140] RDX: ffff9f050a494b68 RSI: ffff9f050a494b70 RDI:=
 ffff9f050a494b60
[76621.145131] [    T140] RBP: ffff9f050a494b68 R08: 00000000000056ee R09:=
 0000000000000009
[76621.145135] [    T140] R10: 0000000000000056 R11: 0000000000000012 R12:=
 ffff9f050a494b70
[76621.145139] [    T140] R13: ffff9f0500c18000 R14: ffff9f050a48ef80 R15:=
 ffffb97f00743d6e
[76621.145143] [    T140] FS:  0000000000000000(0000) GS:ffff9f07ba780000(=
0000) knlGS:0000000000000000
[76621.145147] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[76621.145151] [    T140] CR2: 00007fe612af0900 CR3: 0000000120cbc000 CR4:=
 0000000000750ef0
[76621.145155] [    T140] PKRU: 55555554
[76621.145159] [    T140] Call Trace:
[76621.145163] [    T140]  <TASK>
[76621.145167] [    T140]  ? __warn.cold+0x90/0x9e
[76621.145172] [    T140]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[76621.145253] [    T140]  ? report_bug+0xfa/0x140
[76621.145258] [    T140]  ? handle_bug+0x53/0x90
[76621.145263] [    T140]  ? exc_invalid_op+0x17/0x70
[76621.145267] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
[76621.145273] [    T140]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[76621.145354] [    T140]  amdgpu_ih_ring_fini+0x4f/0x80 [amdgpu]
[76621.145446] [    T140]  amdgpu_irq_fini_hw+0x2f/0x80 [amdgpu]
[76621.145540] [    T140]  amdgpu_device_fini_hw+0x231/0x2ad [amdgpu]
[76621.145665] [    T140]  amdgpu_pci_remove+0x40/0x70 [amdgpu]
[76621.145745] [    T140]  pci_device_remove+0x3d/0xb0
[76621.145751] [    T140]  device_release_driver_internal+0x197/0x200
[76621.145756] [    T140]  pci_stop_bus_device+0x68/0x80
[76621.145761] [    T140]  pci_stop_bus_device+0x38/0x80
[76621.145766] [    T140]  pci_stop_bus_device+0x27/0x80
[76621.145771] [    T140]  pci_stop_and_remove_bus_device+0xd/0x20
[76621.145776] [    T140]  pciehp_unconfigure_device+0x93/0x180
[76621.145781] [    T140]  pciehp_disable_slot+0x62/0x100
[76621.145786] [    T140]  pciehp_handle_presence_or_link_change+0x72/0x35=
0
[76621.145791] [    T140]  pciehp_ist+0x13b/0x180
[76621.145796] [    T140]  irq_thread_fn+0x1e/0x60
[76621.145802] [    T140]  irq_thread+0x114/0x1e0
[76621.145806] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
[76621.145812] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
[76621.145817] [    T140]  ? irq_affinity_notify+0xd0/0xd0
[76621.145822] [    T140]  kthread+0xea/0x1e0
[76621.145827] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
[76621.145833] [    T140]  ret_from_fork+0x2f/0x50
[76621.145838] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
[76621.145843] [    T140]  ret_from_fork_asm+0x11/0x20
[76621.145850] [    T140]  </TASK>
[76621.145854] [    T140] ---[ end trace 0000000000000000 ]---
[76621.146685] [    T140] ------------[ cut here ]------------
[76621.146691] [    T140] WARNING: CPU: 6 PID: 140 at drivers/gpu/drm/amd/=
amdgpu/amdgpu_object.c:510 amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[76621.146775] [    T140] Modules linked in: ec_sys netconsole sd_mod scsi=
_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_e=
vent
snd_rawmidi snd_seq snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fa=
t snd_hda_codec_generic btusb btrtl btintel snd_hda_codec_hdmi btbcm btmtk
snd_hda_intel uvcvideo snd_intel_dspcfg videobuf2_vmalloc videobuf2_memops=
 snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn uvc bluetooth snd_hda_codec
videobuf2_v4l2 snd_soc_core snd_hwdep snd_hda_core videodev snd_pcm_oss sn=
d_mixer_oss snd_pcm snd_rn_pci_acp3x edac_mce_amd videobuf2_common snd_acp=
_config
snd_soc_acpi msi_wmi ecdh_generic ecc sparse_keymap snd_timer wmi_bmof mc =
snd ccp soundcore k10temp snd_pci_acp3x battery ac button hid_sensor_prox
hid_sensor_magn_3d hid_sensor_gyro_3d hid_sensor_accel_3d hid_sensor_als h=
id_sensor_trigger industrialio_triggered_buffer kfifo_buf industrialio amd=
_pmc
hid_sensor_iio_common joydev evdev mt7921e mt7921_common mt792x_lib mt76_c=
onnac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse
[76621.146853] [    T140]  nvme_fabrics efi_pstore configfs efivarfs autof=
s4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_hel=
per ttm
drm_panel_backlight_quirks drm_exec drm_suballoc_helper cec xhci_pci amdxc=
p xhci_hcd drm_buddy hid_multitouch hid_sensor_hub gpu_sched mfd_core hid_=
generic
i2c_hid_acpi drm_display_helper psmouse usbcore amd_sfh i2c_hid nvme hid d=
rm_kms_helper serio_raw nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc=
16
i2c_designware_platform i2c_designware_core
[76621.146904] [    T140] CPU: 6 UID: 0 PID: 140 Comm: irq/43-pciehp Taint=
ed: G        W          6.14.0-mystery-00198-g74adf9e35384 #36
[76621.146909] [    T140] Tainted: [W]=3DWARN
[76621.146913] [    T140] Hardware name: Micro-Star International Co., Ltd=
. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[76621.146917] [    T140] RIP: 0010:amdgpu_bo_free_kernel+0xe4/0x100 [amdg=
pu]
[76621.146998] [    T140] Code: f6 ff ff 4d 85 e4 74 08 49 c7 04 24 00 00 =
00 00 48 85 ed 74 08 48 c7 45 00 00 00 00 00 5b 5d 41 5c 41 5d 41 5e e9 a7=
 99 65 c7
<0f> 0b e9 4b ff ff ff 3d 00 fe ff ff 0f 85 e5 9d 5d 00 eb bd 0f 1f
[76621.147003] [    T140] RSP: 0018:ffffb97f00743c48 EFLAGS: 00010202
[76621.147007] [    T140] RAX: 0000000000000000 RBX: ffff9f050a480a20 RCX:=
 0000000000000000
[76621.147011] [    T140] RDX: ffff9f050a480a28 RSI: 0000000000000000 RDI:=
 ffff9f050a480a20
[76621.147015] [    T140] RBP: ffff9f050a480a28 R08: ffff9f05723cf5d8 R09:=
 0000000000000000
[76621.147019] [    T140] R10: 00007fe80b74e000 R11: 000000000000014d R12:=
 0000000000000000
[76621.147023] [    T140] R13: ffff9f0500c1d400 R14: ffff9f050a48ef80 R15:=
 ffffb97f00743d6e
[76621.147027] [    T140] FS:  0000000000000000(0000) GS:ffff9f07ba780000(=
0000) knlGS:0000000000000000
[76621.147031] [    T140] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[76621.147035] [    T140] CR2: 00007fe612af0900 CR3: 0000000120cbc000 CR4:=
 0000000000750ef0
[76621.147039] [    T140] PKRU: 55555554
[76621.147042] [    T140] Call Trace:
[76621.147046] [    T140]  <TASK>
[76621.147050] [    T140]  ? __warn.cold+0x90/0x9e
[76621.147056] [    T140]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[76621.147138] [    T140]  ? report_bug+0xfa/0x140
[76621.147143] [    T140]  ? handle_bug+0x53/0x90
[76621.147147] [    T140]  ? exc_invalid_op+0x17/0x70
[76621.147152] [    T140]  ? asm_exc_invalid_op+0x1a/0x20
[76621.147158] [    T140]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[76621.147239] [    T140]  amdgpu_device_unmap_mmio+0x25/0x90 [amdgpu]
[76621.147319] [    T140]  amdgpu_pci_remove+0x40/0x70 [amdgpu]
[76621.147398] [    T140]  pci_device_remove+0x3d/0xb0
[76621.147403] [    T140]  device_release_driver_internal+0x197/0x200
[76621.147409] [    T140]  pci_stop_bus_device+0x68/0x80
[76621.147414] [    T140]  pci_stop_bus_device+0x38/0x80
[76621.147419] [    T140]  pci_stop_bus_device+0x27/0x80
[76621.147424] [    T140]  pci_stop_and_remove_bus_device+0xd/0x20
[76621.147429] [    T140]  pciehp_unconfigure_device+0x93/0x180
[76621.147434] [    T140]  pciehp_disable_slot+0x62/0x100
[76621.147439] [    T140]  pciehp_handle_presence_or_link_change+0x72/0x35=
0
[76621.147444] [    T140]  pciehp_ist+0x13b/0x180
[76621.147449] [    T140]  irq_thread_fn+0x1e/0x60
[76621.147455] [    T140]  irq_thread+0x114/0x1e0
[76621.147460] [    T140]  ? irq_finalize_oneshot.part.0+0xc0/0xc0
[76621.147465] [    T140]  ? irq_set_affinity_notifier+0x120/0x120
[76621.147471] [    T140]  ? irq_affinity_notify+0xd0/0xd0
[76621.147483] [    T140]  kthread+0xea/0x1e0
[76621.147489] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
[76621.147494] [    T140]  ret_from_fork+0x2f/0x50
[76621.147500] [    T140]  ? kthreads_online_cpu+0xf0/0xf0
[76621.147505] [    T140]  ret_from_fork_asm+0x11/0x20
[76621.147512] [    T140]  </TASK>
[76621.147515] [    T140] ---[ end trace 0000000000000000 ]---
[76621.870884] [    T140] pcieport 0000:01:00.0: Unable to change power st=
ate from D3cold to D0, device inaccessible
[76621.870977] [    T140] pcieport 0000:02:00.0: Unable to change power st=
ate from D3cold to D0, device inaccessible
[76621.876006] [    T140] pci_bus 0000:03: busn_res: [bus 03] is released
[76621.878237] [    T140] pci_bus 0000:02: busn_res: [bus 02-03] is releas=
ed
[76621.879867] [    T140] pcieport 0000:00:01.1: pciehp: Slot(0): Card pre=
sent
[76621.879873] [    T140] pcieport 0000:00:01.1: pciehp: Slot(0): Link Up
[76622.006565] [    T140] pci 0000:01:00.0: [1002:1478] type 01 class 0x06=
0400 PCIe Switch Upstream Port
[76622.006606] [    T140] pci 0000:01:00.0: BAR 0 [mem 0xfcc00000-0xfcc03f=
ff]
[76622.006616] [    T140] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[76622.006630] [    T140] pci 0000:01:00.0:   bridge window [mem 0xfca0000=
0-0xfcbfffff]
[76622.006644] [    T140] pci 0000:01:00.0:   bridge window [mem 0xfc00000=
000-0xfe0fffffff 64bit pref]
[76622.006772] [    T140] pci 0000:01:00.0: PME# supported from D0 D3hot D=
3cold
[76622.006874] [    T140] pci 0000:01:00.0: 16.000 Gb/s available PCIe ban=
dwidth, limited by 2.5 GT/s PCIe x8 link at 0000:00:01.1 (capable of 126.0=
24 Gb/s with
16.0 GT/s PCIe x8 link)
[76622.007064] [    T140] pci 0000:01:00.0: Adding to iommu group 12
[76622.007193] [    T140] pci 0000:02:00.0: [1002:1479] type 01 class 0x06=
0400 PCIe Switch Downstream Port
[76622.007227] [    T140] pci 0000:02:00.0: PCI bridge to [bus 03]
[76622.007241] [    T140] pci 0000:02:00.0:   bridge window [mem 0xfca0000=
0-0xfcbfffff]
[76622.007256] [    T140] pci 0000:02:00.0:   bridge window [mem 0xfc00000=
000-0xfe0fffffff 64bit pref]
[76622.007366] [    T140] pci 0000:02:00.0: PME# supported from D0 D3hot D=
3cold
[76622.008231] [    T140] pci 0000:02:00.0: Adding to iommu group 13
[76622.008285] [    T140] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[76622.008428] [    T140] pci 0000:03:00.0: [1002:73ff] type 00 class 0x03=
8000 PCIe Legacy Endpoint
[76622.008493] [    T140] pci 0000:03:00.0: BAR 0 [mem 0xfc00000000-0xfdff=
ffffff 64bit pref]
[76622.008500] [    T140] pci 0000:03:00.0: BAR 2 [mem 0xfe00000000-0xfe0f=
ffffff 64bit pref]
[76622.008507] [    T140] pci 0000:03:00.0: BAR 5 [mem 0xfca00000-0xfcafff=
ff]
[76622.008512] [    T140] pci 0000:03:00.0: ROM [mem 0xfcb00000-0xfcb1ffff=
 pref]
[76622.008644] [    T140] pci 0000:03:00.0: PME# supported from D1 D2 D3ho=
t D3cold
[76622.008753] [    T140] pci 0000:03:00.0: 16.000 Gb/s available PCIe ban=
dwidth, limited by 2.5 GT/s PCIe x8 link at 0000:00:01.1 (capable of 252.0=
48 Gb/s with
16.0 GT/s PCIe x16 link)
[76622.009273] [    T140] pci 0000:03:00.0: Adding to iommu group 14
[76622.009323] [    T140] pci 0000:03:00.1: [1002:ab28] type 00 class 0x04=
0300 PCIe Legacy Endpoint
[76622.009368] [    T140] pci 0000:03:00.1: BAR 0 [mem 0x00000000-0x00003f=
ff]
[76622.009386] [    T140] pci 0000:03:00.1: Max Payload Size set to 256 (w=
as 128, max 256)
[76622.009467] [    T140] pci 0000:03:00.1: PME# supported from D1 D2 D3ho=
t D3cold
[76622.010655] [    T140] pci 0000:03:00.1: Adding to iommu group 15
[76622.010691] [    T140] pci 0000:02:00.0: ASPM: current common clock con=
figuration is inconsistent, reconfiguring
[76622.010737] [    T140] pci 0000:02:00.0: PCI bridge to [bus 03]
[76622.010771] [    T140] pcieport 0000:00:01.1: Assigned bridge window [m=
em 0xfc00000000-0xfe0fffffff 64bit pref] to [bus 01-03] cannot fit 0x30000=
0000
required for 0000:02:00.0 bridging to [bus 03]
[76622.010777] [    T140] pci 0000:02:00.0: bridge window [mem 0xfc0000000=
0-0xfe0fffffff 64bit pref] to [bus 03] requires relaxed alignment rules
[76622.010783] [    T140] pcieport 0000:00:01.1: Assigned bridge window [m=
em 0xfc00000000-0xfe0fffffff 64bit pref] to [bus 01-03] cannot fit 0x40000=
0000
required for 0000:01:00.0 bridging to [bus 02-03]
[76622.010788] [    T140] pci 0000:01:00.0: bridge window [mem 0xfc0000000=
0-0xfe0fffffff 64bit pref] to [bus 02-03] requires relaxed alignment rules
[76622.010797] [    T140] pci 0000:01:00.0: bridge window [mem 0xfc0000000=
0-0xfe0fffffff 64bit pref]: assigned
[76622.010802] [    T140] pci 0000:01:00.0: bridge window [mem 0xfca00000-=
0xfcbfffff]: assigned
[76622.010806] [    T140] pci 0000:01:00.0: BAR 0 [mem 0xfcc00000-0xfcc03f=
ff]: assigned
[76622.010813] [    T140] pci 0000:02:00.0: bridge window [mem 0xfc0000000=
0-0xfe0fffffff 64bit pref]: assigned
[76622.010818] [    T140] pci 0000:02:00.0: bridge window [mem 0xfca00000-=
0xfcbfffff]: assigned
[76622.010824] [    T140] pci 0000:03:00.0: BAR 0 [mem 0xfc00000000-0xfdff=
ffffff 64bit pref]: assigned
[76622.010836] [    T140] pci 0000:03:00.0: BAR 2 [mem 0xfe00000000-0xfe0f=
ffffff 64bit pref]: assigned
[76622.010849] [    T140] pci 0000:03:00.0: BAR 5 [mem 0xfca00000-0xfcafff=
ff]: assigned
[76622.010855] [    T140] pci 0000:03:00.0: ROM [mem 0xfcb00000-0xfcb1ffff=
 pref]: assigned
[76622.010860] [    T140] pci 0000:03:00.1: BAR 0 [mem 0xfcb20000-0xfcb23f=
ff]: assigned
[76622.010867] [    T140] pci 0000:02:00.0: PCI bridge to [bus 03]
[76622.010874] [    T140] pci 0000:02:00.0:   bridge window [mem 0xfca0000=
0-0xfcbfffff]
[76622.010881] [    T140] pci 0000:02:00.0:   bridge window [mem 0xfc00000=
000-0xfe0fffffff 64bit pref]
[76622.010890] [    T140] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[76622.010897] [    T140] pci 0000:01:00.0:   bridge window [mem 0xfca0000=
0-0xfcbfffff]
[76622.010904] [    T140] pci 0000:01:00.0:   bridge window [mem 0xfc00000=
000-0xfe0fffffff 64bit pref]
[76622.010913] [    T140] pcieport 0000:00:01.1: PCI bridge to [bus 01-03]
[76622.010917] [    T140] pcieport 0000:00:01.1:   bridge window [io  0x10=
00-0x1fff]
[76622.010924] [    T140] pcieport 0000:00:01.1:   bridge window [mem 0xfc=
a00000-0xfccfffff]
[76622.010929] [    T140] pcieport 0000:00:01.1:   bridge window [mem 0xfc=
00000000-0xfe0fffffff 64bit pref]
[76622.011839] [    T140] [drm] initializing kernel modesetting (DIMGREY_C=
AVEFISH 0x1002:0x73FF 0x1462:0x1313 0xC3).
[76622.012233] [    T140] [drm] register mmio base: 0xFCA00000
[76622.012240] [    T140] [drm] register mmio size: 1048576
[76624.031458] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 0 <nv_common>
[76624.031471] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 1 <gmc_v10_0>
[76624.031482] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 2 <navi10_ih>
[76624.031487] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 3 <psp>
[76624.031491] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 4 <smu>
[76624.031495] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 5 <dm>
[76624.031499] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 6 <gfx_v10_0>
[76624.031503] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 7 <sdma_v5_2>
[76624.031508] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 8 <vcn_v3_0>
[76624.031512] [    T140] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 9 <jpeg_v3_0>
[76624.031533] [    T140] amdgpu 0000:03:00.0: amdgpu: ACPI VFCT table pre=
sent but broken (too short #2),skipping
[76624.040650] [    T140] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from =
ROM BAR
[76624.040661] [    T140] amdgpu: ATOM BIOS: SWBRT77181.001
[76624.047812] [    T140] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone=
 (TMZ) feature disabled as experimental (default)
[76624.047826] [    T140] amdgpu 0000:03:00.0: amdgpu: MODE1 reset
[76624.047832] [    T140] amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset
[76624.047925] [    T140] amdgpu 0000:03:00.0: amdgpu: GPU smu mode1 reset
[76624.550931] [    T140] [drm] GPU posting now...
[76624.551021] [    T140] [drm] vm size is 262144 GB, 4 levels, block size=
 is 9-bit, fragment size is 9-bit
[76624.551041] [    T140] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M 0x00000=
08000000000 - 0x00000081FEFFFFFF (8176M used)
[76624.551051] [    T140] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x000000=
0000000000 - 0x000000001FFFFFFF
[76624.551083] [    T140] [drm] Detected VRAM RAM=3D8176M, BAR=3D8192M
[76624.551090] [    T140] [drm] RAM width 128bits GDDR6
[76624.551292] [    T140] [drm] amdgpu: 8176M of VRAM memory ready
[76624.551306] [    T140] [drm] amdgpu: 6895M of GTT memory ready.
[76624.551341] [    T140] [drm] GART: num cpu pages 131072, num gpu pages =
131072
[76624.551558] [    T140] [drm] PCIE GART of 512M enabled (table at 0x0000=
0081FEB00000).
[76627.137571] [    T140] amdgpu 0000:03:00.0: amdgpu: STB initialized to =
2048 entries
[76627.137664] [    T140] [drm] Loading DMUB firmware via PSP: version=3D0=
x02020020
[76627.138008] [    T140] [drm] use_doorbell being set to: [true]
[76627.138031] [    T140] [drm] use_doorbell being set to: [true]
[76627.138048] [    T140] [drm] Found VCN firmware Version ENC: 1.33 DEC: =
4 VEP: 0 Revision: 6
[76627.301177] [    T140] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 fr=
om 0x81fd000000 for PSP TMR
[76627.382840] [    T140] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras t=
a ucode is not available
[76627.394206] [    T140] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: secu=
redisplay ta ucode is not available
[76627.394236] [    T140] amdgpu 0000:03:00.0: amdgpu: smu driver if versi=
on =3D 0x0000000f, smu fw if version =3D 0x00000013, smu fw program =3D 0,=
 version =3D
0x003b3100 (59.49.0)
[76627.394244] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU driver if versi=
on not matched
[76627.394283] [    T140] amdgpu 0000:03:00.0: amdgpu: use vbios provided =
pptable
[76627.470860] [    T140] amdgpu 0000:03:00.0: amdgpu: SMU is initialized =
successfully!
[76627.471678] [    T140] [drm] Display Core v3.2.316 initialized on DCN 3=
.0.2
[76627.471686] [    T140] [drm] DP-HDMI FRL PCON supported
[76627.473002] [    T140] [drm] DMUB hardware initialized: version=3D0x020=
20020
[76627.505987] [    T140] [drm] kiq ring mec 2 pipe 1 q 0
[76627.514661] [    T140] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[76627.514688] [    T140] kfd kfd: amdgpu: Total number of KFD nodes to be=
 created: 1
[76627.514812] [    T140] amdgpu: Virtual CRAT table created for GPU
[76627.515356] [    T140] amdgpu: Topology: Add dGPU node [0x73ff:0x1002]
[76627.515361] [    T140] kfd kfd: amdgpu: added device 1002:73ff
[76627.515385] [    T140] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 2, =
CU per SH 8, active_cu_number 28
[76627.515394] [    T140] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses=
 VM inv eng 0 on hub 0
[76627.515400] [    T140] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses=
 VM inv eng 1 on hub 0
[76627.515406] [    T140] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 use=
s VM inv eng 4 on hub 0
[76627.515411] [    T140] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 use=
s VM inv eng 5 on hub 0
[76627.515415] [    T140] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 use=
s VM inv eng 6 on hub 0
[76627.515419] [    T140] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 use=
s VM inv eng 7 on hub 0
[76627.515423] [    T140] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 use=
s VM inv eng 8 on hub 0
[76627.515428] [    T140] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 use=
s VM inv eng 9 on hub 0
[76627.515431] [    T140] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 use=
s VM inv eng 10 on hub 0
[76627.515436] [    T140] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 use=
s VM inv eng 11 on hub 0
[76627.515440] [    T140] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 us=
es VM inv eng 12 on hub 0
[76627.515444] [    T140] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM =
inv eng 13 on hub 0
[76627.515448] [    T140] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM =
inv eng 14 on hub 0
[76627.515452] [    T140] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses=
 VM inv eng 0 on hub 8
[76627.515456] [    T140] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 us=
es VM inv eng 1 on hub 8
[76627.515460] [    T140] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 us=
es VM inv eng 4 on hub 8
[76627.515464] [    T140] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses =
VM inv eng 5 on hub 8
[76627.517023] [    T140] amdgpu 0000:03:00.0: amdgpu: Using BOCO for runt=
ime pm
[76627.525799] [    T140] [drm] Initialized amdgpu 3.61.0 for 0000:03:00.0=
 on minor 2
[76627.529014] [    T140] amdgpu 0000:03:00.0: [drm] Cannot find any crtc =
or sizes
[76627.529208] [    T140] pci 0000:03:00.1: D0 power state depends on 0000=
:03:00.0
[76627.529246] [    T140] snd_hda_intel 0000:03:00.1: enabling device (000=
0 -> 0002)
[76627.529333] [    T140] snd_hda_intel 0000:03:00.1: Handle vga_switchero=
o audio client
[76627.529342] [    T140] snd_hda_intel 0000:03:00.1: Force to non-snoop m=
ode
[76627.535481] [ T178264] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (=
ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[76627.536870] [ T178264] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as /devices/=
pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1=
/input32
[76627.537043] [ T178264] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as /devices/=
pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1=
/input33
[76627.537142] [ T178264] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as /devices/=
pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1=
/input34
[76627.537213] [ T178264] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as /devices/=
pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1=
/input35
[76627.537293] [ T178264] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as /devices=
/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card=
1/input36


Bert Karwatzki

