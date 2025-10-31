Return-Path: <linux-pci+bounces-39953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B990FC269A4
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 19:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 789844E6240
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 18:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7461F2DBF47;
	Fri, 31 Oct 2025 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="YwzIvY19"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F47405F7;
	Fri, 31 Oct 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935762; cv=none; b=ihjw6fRR+axNFJl8kN1doi3ID0A+NFj7m7eTJS9945fZT/DP5JqSMLkvPcxxFy/xUYvunu2GpXfonQ+PmhIBYHigwxWGR8p4xDVtlQi4vT0ZN8j0BbuxAQHE++lmYaLBP2055DGVaz1ZiDwDzQEpic1T9sJz/aN98ojJtixI0DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935762; c=relaxed/simple;
	bh=WpXRbsO5ptrWbZmM8tdoFFagksicAzIe/isUoa9D0KU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bzntyeUP0j4Vy6psK8np1P57/fTxg47rg+Uz5gsJUkeM29iRcM5FMRWJNQejwSwR9aaQQFrbEjJNNrPaQlPkXbuPiXwMNIwirD7x8jFRg6MOBxBZlhP58VWsw3EPYl19TEza9P8EvlmCPP9F9Jz1+i8n+PRg3eylIgRcNOwu5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=YwzIvY19; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761935756; x=1762540556; i=spasswolf@web.de;
	bh=B+cMeACw7JR34OP88G+BUtDySSPd8Ru/nS6+8Wvqoeg=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YwzIvY19rF1A0J5cQ9+BxkxSv3ceBZO9y4dGqgH2I8oyI1qNn6AiLJoBdVH3zULb
	 EGr8jb4kWaGjC0bEW8cOn2NIQpYEooDDbk86I3T38V8hz//wk0GVeq6lnM0eqL7Ty
	 SGM1l5WkRZe8PZmRerfBOhx/+yLRwvJubg/mKKqqDffRydhmuyX3TM4YSFf+vY1bW
	 b5SSxFinixNY4OeaImi8+qJm2/wAw/oiLv9IG0+HhSFtfuQ/j93a1PdkpglIWI8o8
	 WGlCgDGr/dk7UTCZ19eXFtG29PFQhBijK/b50hZDWKAuKsyLqSgDrKPK0Wfd+Cshu
	 p0d7qGrFvjP65/6B6A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N62yY-1wLMcF1tbk-00vPCX; Fri, 31
 Oct 2025 19:35:55 +0100
Message-ID: <635b6cb19b5969bed7432dfd1cd651124e63aebb.camel@web.de>
Subject: Re: [REGRESSION 00/04] Crash during resume of pcie bridge
From: Bert Karwatzki <spasswolf@web.de>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Mario
 Limonciello <superm1@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
	 <rafael.j.wysocki@intel.com>
Date: Fri, 31 Oct 2025 19:35:54 +0100
In-Reply-To: <26bf82303f661cdd34e4e8c16997e33eb21d1ee4.camel@web.de>
References: <20251006120944.7880-1-spasswolf@web.de>
						 <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
						 <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de>
						 <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
						 <25f36fa7-d1d6-4b81-a42f-64c445d6f065@amd.com>
			 <1853e2af7f70cf726df278137b6d2d89d9d9dc82.camel@web.de>
		 <f18bafacbd8316c9623658e2935f8fc3b276af64.camel@web.de>
	 <26bf82303f661cdd34e4e8c16997e33eb21d1ee4.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nzBBc1kteSy04/pjj6Xl1WjnelV34wXWsj7+S1usyehqU5hDRKb
 AX1Y0udL6rwscGkHEMh97PLqiW/wlBFTl80XUm+PNxhPt/F/fkNSSQdePIZPCaKige2u83t
 kDXtMpJ0C2Dux/zHay2uJh+MC16wVXSSH7g7rfTTpq+DlcMYv6aMi69nKE9azC8eQVSa/e1
 ZumPzjxlBGR4GA4O1apHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4cOGDmhblRw=;PxWKf/3eC77OetUmDrd5lMFCwdU
 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

Am Freitag, dem 31.10.2025 um 14:47 +0100 schrieb Bert Karwatzki:
> Upon closer inspection I noticed that the PCIe bandwitdth has been reduc=
ed:
>=20
> >=20
> > [76621.870884] [    T140] pcieport 0000:01:00.0: Unable to change powe=
r state from D3cold to D0, device inaccessible
> > [76621.870977] [    T140] pcieport 0000:02:00.0: Unable to change powe=
r state from D3cold to D0, device inaccessible
> > [76621.876006] [    T140] pci_bus 0000:03: busn_res: [bus 03] is relea=
sed
> > [76621.878237] [    T140] pci_bus 0000:02: busn_res: [bus 02-03] is re=
leased
> > [76621.879867] [    T140] pcieport 0000:00:01.1: pciehp: Slot(0): Card=
 present
> > [76621.879873] [    T140] pcieport 0000:00:01.1: pciehp: Slot(0): Link=
 Up
> > [76622.006565] [    T140] pci 0000:01:00.0: [1002:1478] type 01 class =
0x060400 PCIe Switch Upstream Port
> > [76622.006606] [    T140] pci 0000:01:00.0: BAR 0 [mem 0xfcc00000-0xfc=
c03fff]
> > [76622.006616] [    T140] pci 0000:01:00.0: PCI bridge to [bus 02-03]
> > [76622.006630] [    T140] pci 0000:01:00.0:   bridge window [mem 0xfca=
00000-0xfcbfffff]
> > [76622.006644] [    T140] pci 0000:01:00.0:   bridge window [mem 0xfc0=
0000000-0xfe0fffffff 64bit pref]
> > [76622.006772] [    T140] pci 0000:01:00.0: PME# supported from D0 D3h=
ot D3cold
>=20
> The PCIe band with seems to be have been reduce to PCIe 1.0 (2.5GT/s):
>=20
> > [76622.006874] [    T140] pci 0000:01:00.0: 16.000 Gb/s available PCIe=
 bandwidth, limited by 2.5 GT/s PCIe x8 link at 0000:00:01.1 (capable of 1=
26.024 Gb/s with
> > 16.0 GT/s PCIe x8 link)
> >=20
> > Bert Karwatzki
>=20
> This is the same message from system startup (here it's PCIe 3.0 (8.0GT/=
s), which is the PCIe version
> of the CPU (AMD Ryzen 7 5800H with Radeon Graphics)):=09
> [    0.289221] [      T1] pci 0000:01:00.0: 63.008 Gb/s available PCIe b=
andwidth, limited by 8.0 GT/s PCIe x8 link at 0000:00:01.1 (capable of 126=
.024 Gb/s with
> 16.0 GT/s PCIe x8 link)
>=20
> Bert Karwatzki

5 hours later the following happend:
This time the discrete GPU is no longer present on the PCI bus.

[94794.664620] [ T246165] pcieport 0000:01:00.0: Unable to change power st=
ate from D3cold to D0, device inaccessible
[94794.927090] [ T249440] [drm] PCIE GART of 512M enabled (table at 0x0000=
0081FEB00000).
[94794.927137] [ T249440] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[94795.103071] [ T249440] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 fr=
om 0x81fd000000 for PSP TMR
[94795.184954] [ T249440] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras t=
a ucode is not available
[94795.196436] [ T249440] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: secu=
redisplay ta ucode is not available
[94795.196443] [ T249440] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[94795.196450] [ T249440] amdgpu 0000:03:00.0: amdgpu: smu driver if versi=
on =3D 0x0000000f, smu fw if version =3D 0x00000013, smu fw program =3D 0,=
 version =3D
0x003b3100 (59.49.0)
[94795.196456] [ T249440] amdgpu 0000:03:00.0: amdgpu: SMU driver if versi=
on not matched
[94795.270584] [ T249440] amdgpu 0000:03:00.0: amdgpu: SMU is resumed succ=
essfully!
[94795.272500] [ T249440] [drm] kiq ring mec 2 pipe 1 q 0
[94795.279250] [ T249440] [drm] DMUB hardware initialized: version=3D0x020=
20020
[94795.298642] [ T249440] amdgpu 0000:03:00.0: [drm] Cannot find any crtc =
or sizes
[94795.298659] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses=
 VM inv eng 0 on hub 0
[94795.298664] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses=
 VM inv eng 1 on hub 0
[94795.298668] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 use=
s VM inv eng 4 on hub 0
[94795.298672] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 use=
s VM inv eng 5 on hub 0
[94795.298676] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 use=
s VM inv eng 6 on hub 0
[94795.298680] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 use=
s VM inv eng 7 on hub 0
[94795.298683] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 use=
s VM inv eng 8 on hub 0
[94795.298687] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 use=
s VM inv eng 9 on hub 0
[94795.298691] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 use=
s VM inv eng 10 on hub 0
[94795.298695] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 use=
s VM inv eng 11 on hub 0
[94795.298699] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 us=
es VM inv eng 12 on hub 0
[94795.298703] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM =
inv eng 13 on hub 0
[94795.298707] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM =
inv eng 14 on hub 0
[94795.298711] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses=
 VM inv eng 0 on hub 8
[94795.298715] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 us=
es VM inv eng 1 on hub 8
[94795.298719] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 us=
es VM inv eng 4 on hub 8
[94795.298722] [ T249440] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses =
VM inv eng 5 on hub 8
[94795.303424] [ T249440] amdgpu 0000:03:00.0: [drm] Cannot find any crtc =
or sizes
[94858.150608] [ T255287] pcieport 0000:02:00.0: Unable to change power st=
ate from D3cold to D0, device inaccessible
[94858.278571] [ T255287] amdgpu 0000:03:00.0: Unable to change power stat=
e from D3cold to D0, device inaccessible
[94869.026346] [ T255287] [drm:gmc_v10_0_flush_gpu_tlb [amdgpu]] *ERROR* T=
imeout waiting for sem acquire in VM flush!
[94869.188171] [ T255287] amdgpu 0000:03:00.0: amdgpu: Timeout waiting for=
 VM flush hub: 8!
[94869.347241] [ T255287] amdgpu 0000:03:00.0: amdgpu: Timeout waiting for=
 VM flush hub: 0!
[94869.347265] [ T255287] [drm] PCIE GART of 512M enabled (table at 0x0000=
0081FEB00000).
[94869.347283] [ T255287] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[94869.387560] [ T255287] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 fr=
om 0x81fd000000 for PSP TMR
[94869.387688] [ T255287] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras t=
a ucode is not available
[94869.387832] [ T255287] ------------[ cut here ]------------
[94869.387838] [ T255287] WARNING: CPU: 7 PID: 255287 at drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c:510 amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[94869.388000] [ T255287] Modules linked in: ec_sys netconsole sd_mod scsi=
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
[94869.388093] [ T255287]  nvme_fabrics efi_pstore configfs efivarfs autof=
s4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_hel=
per ttm
drm_panel_backlight_quirks drm_exec drm_suballoc_helper cec xhci_pci amdxc=
p xhci_hcd drm_buddy hid_multitouch hid_sensor_hub gpu_sched mfd_core hid_=
generic
i2c_hid_acpi drm_display_helper psmouse usbcore amd_sfh i2c_hid nvme hid d=
rm_kms_helper serio_raw nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc=
16
i2c_designware_platform i2c_designware_core
[94869.388156] [ T255287] CPU: 7 UID: 1000 PID: 255287 Comm: evolution Tai=
nted: G        W          6.14.0-mystery-00198-g74adf9e35384 #36
[94869.388163] [ T255287] Tainted: [W]=3DWARN
[94869.388167] [ T255287] Hardware name: Micro-Star International Co., Ltd=
. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[94869.388172] [ T255287] RIP: 0010:amdgpu_bo_free_kernel+0xe4/0x100 [amdg=
pu]
[94869.388328] [ T255287] Code: f6 ff ff 4d 85 e4 74 08 49 c7 04 24 00 00 =
00 00 48 85 ed 74 08 48 c7 45 00 00 00 00 00 5b 5d 41 5c 41 5d 41 5e e9 a7=
 99 65 c7
<0f> 0b e9 4b ff ff ff 3d 00 fe ff ff 0f 85 e5 9d 5d 00 eb bd 0f 1f
[94869.388334] [ T255287] RSP: 0018:ffffb97f1035f940 EFLAGS: 00010202
[94869.388340] [ T255287] RAX: ffff9f05b0b69f80 RBX: ffff9f056be3c6e8 RCX:=
 00000081fec03000
[94869.388345] [ T255287] RDX: ffff9f056be3c6f8 RSI: ffff9f056be3c6f0 RDI:=
 ffff9f056be3c6e8
[94869.388349] [ T255287] RBP: ffff9f056be3c6f8 R08: ffff9f056be3c728 R09:=
 ffffb97f11391000
[94869.388353] [ T255287] R10: ffff9f07e02fffa8 R11: 0000000000000003 R12:=
 ffff9f056be3c6f0
[94869.388358] [ T255287] R13: ffff9f05b0b67400 R14: ffff9f056be0ef80 R15:=
 ffff9f05059a10c8
[94869.388362] [ T255287] FS:  00007f2cae63acc0(0000) GS:ffff9f07ba7c0000(=
0000) knlGS:0000000000000000
[94869.388367] [ T255287] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[94869.388372] [ T255287] CR2: 00007f6d36cc2b9c CR3: 000000018c0d4000 CR4:=
 0000000000750ef0
[94869.388376] [ T255287] PKRU: 55555554
[94869.388381] [ T255287] Call Trace:
[94869.388387] [ T255287]  <TASK>
[94869.388392] [ T255287]  ? __warn.cold+0x90/0x9e
[94869.388400] [ T255287]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[94869.388556] [ T255287]  ? report_bug+0xfa/0x140
[94869.388564] [ T255287]  ? handle_bug+0x53/0x90
[94869.388570] [ T255287]  ? exc_invalid_op+0x17/0x70
[94869.388576] [ T255287]  ? asm_exc_invalid_op+0x1a/0x20
[94869.388584] [ T255287]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[94869.388771] [ T255287]  psp_rap_initialize+0x19f/0x1d0 [amdgpu]
[94869.388962] [ T255287]  psp_resume+0x19a/0x201 [amdgpu]
[94869.389186] [ T255287]  amdgpu_ip_block_resume+0x22/0x40 [amdgpu]
[94869.389339] [ T255287]  ? srso_alias_return_thunk+0x5/0xfbef5
[94869.389347] [ T255287]  amdgpu_device_fw_loading+0x109/0x140 [amdgpu]
[94869.389510] [ T255287]  ? srso_alias_return_thunk+0x5/0xfbef5
[94869.389517] [ T255287]  ? amdgpu_device_ip_resume_phase1+0x50/0x90 [amd=
gpu]
[94869.389651] [ T255287]  amdgpu_device_resume+0x65/0x2b0 [amdgpu]
[94869.389793] [ T255287]  amdgpu_pmops_runtime_resume+0x56/0x100 [amdgpu]
[94869.389927] [ T255287]  ? pci_pm_restore_noirq+0xc0/0xc0
[94869.389934] [ T255287]  ? pci_pm_restore_noirq+0xc0/0xc0
[94869.389940] [ T255287]  __rpm_callback+0x3f/0x160
[94869.389947] [ T255287]  rpm_callback+0x50/0x60
[94869.389953] [ T255287]  ? pci_pm_restore_noirq+0xc0/0xc0
[94869.389959] [ T255287]  rpm_resume+0x50a/0x770
[94869.389968] [ T255287]  ? srso_alias_return_thunk+0x5/0xfbef5
[94869.389974] [ T255287]  ? lock_timer_base+0x68/0x90
[94869.389982] [ T255287]  __pm_runtime_resume+0x46/0x80
[94869.389989] [ T255287]  amdgpu_driver_open_kms+0x4b/0x250 [amdgpu]
[94869.390124] [ T255287]  drm_file_alloc+0x1cb/0x270
[94869.390133] [ T255287]  drm_open_helper+0x80/0x130
[94869.390140] [ T255287]  ? srso_alias_return_thunk+0x5/0xfbef5
[94869.390146] [ T255287]  drm_open+0x6e/0x100
[94869.390153] [ T255287]  drm_stub_open+0x99/0xd0
[94869.390160] [ T255287]  chrdev_open+0xae/0x210
[94869.390168] [ T255287]  ? __unregister_chrdev+0x40/0x40
[94869.390174] [ T255287]  do_dentry_open+0x16b/0x580
[94869.390181] [ T255287]  vfs_open+0x29/0xe0
[94869.390188] [ T255287]  path_openat+0x832/0x12b0
[94869.390195] [ T255287]  ? vsnprintf+0x4cb/0x5c0
[94869.390203] [ T255287]  do_filp_open+0xc2/0x170
[94869.390211] [ T255287]  ? srso_alias_return_thunk+0x5/0xfbef5
[94869.390217] [ T255287]  ? current_time+0x2a/0x110
[94869.390224] [ T255287]  ? srso_alias_return_thunk+0x5/0xfbef5
[94869.390230] [ T255287]  ? __check_object_size+0x1f0/0x220
[94869.390236] [ T255287]  ? srso_alias_return_thunk+0x5/0xfbef5
[94869.390242] [ T255287]  do_sys_openat2+0x6c/0xd0
[94869.390250] [ T255287]  __x64_sys_openat+0x50/0xa0
[94869.390256] [ T255287]  do_syscall_64+0x5f/0x170
[94869.390263] [ T255287]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
[94869.390270] [ T255287] RIP: 0033:0x7f2cb9dea9ee
[94869.390276] [ T255287] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 =
89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24=
 08 0f 05
<c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[94869.390282] [ T255287] RSP: 002b:00007ffcba63cc48 EFLAGS: 00000246 ORIG=
_RAX: 0000000000000101
[94869.390289] [ T255287] RAX: ffffffffffffffda RBX: 00007f2cae63acc0 RCX:=
 00007f2cb9dea9ee
[94869.390295] [ T255287] RDX: 0000000000080002 RSI: 00005569c704b818 RDI:=
 ffffffffffffff9c
[94869.390300] [ T255287] RBP: 0000000000000001 R08: 0000000000000000 R09:=
 0000000000000000
[94869.390306] [ T255287] R10: 0000000000000000 R11: 0000000000000246 R12:=
 00005569c64c0d90
[94869.390311] [ T255287] R13: 00007f2ca4010600 R14: 00007f2ca4044410 R15:=
 0000000000000000
[94869.390318] [ T255287]  </TASK>
[94869.390323] [ T255287] ---[ end trace 0000000000000000 ]---
[94869.390335] [ T255287] amdgpu 0000:03:00.0: amdgpu: RAP TA initialize f=
ail (0) status -1.
[94869.390341] [ T255287] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: secu=
redisplay ta ucode is not available
[94869.390349] [ T255287] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[94869.390361] [ T255287] amdgpu 0000:03:00.0: amdgpu: smu driver if versi=
on =3D 0x0000000f, smu fw if version =3D 0x00000013, smu fw program =3D 0,=
 version =3D
0x003b3100 (59.49.0)
[94869.390369] [ T255287] amdgpu 0000:03:00.0: amdgpu: SMU driver if versi=
on not matched
[94869.390375] [ T255287] amdgpu 0000:03:00.0: amdgpu: dpm has been enable=
d
[94869.390381] [ T255287] amdgpu 0000:03:00.0: amdgpu: SMU is resumed succ=
essfully!
[94869.550359] [ T255287] amdgpu 0000:03:00.0: amdgpu: rlc autoload: gc uc=
ode autoload timeout
[94869.550372] [ T255287] amdgpu 0000:03:00.0: amdgpu: resume of IP block =
<gfx_v10_0> failed -110
[94869.550378] [ T255287] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_re=
sume failed (-110).
[94877.422621] [ T255166] pcieport 0000:02:00.0: Unable to change power st=
ate from D3cold to D0, device inaccessible
[94877.492483] [ T249695] amdgpu 0000:03:00.0: amdgpu: amdgpu: finishing d=
evice.
[94877.492701] [ T249695] ------------[ cut here ]------------
[94877.492706] [ T249695] WARNING: CPU: 13 PID: 249695 at drivers/gpu/drm/=
amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
[94877.492833] [ T249695] Modules linked in: ec_sys netconsole sd_mod scsi=
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
[94877.492924] [ T249695]  nvme_fabrics efi_pstore configfs efivarfs autof=
s4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_hel=
per ttm
drm_panel_backlight_quirks drm_exec drm_suballoc_helper cec xhci_pci amdxc=
p xhci_hcd drm_buddy hid_multitouch hid_sensor_hub gpu_sched mfd_core hid_=
generic
i2c_hid_acpi drm_display_helper psmouse usbcore amd_sfh i2c_hid nvme hid d=
rm_kms_helper serio_raw nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc=
16
i2c_designware_platform i2c_designware_core
[94877.492993] [ T249695] CPU: 13 UID: 0 PID: 249695 Comm: kworker/u64:4 T=
ainted: G        W          6.14.0-mystery-00198-g74adf9e35384 #36
[94877.493002] [ T249695] Tainted: [W]=3DWARN
[94877.493009] [ T249695] Hardware name: Micro-Star International Co., Ltd=
. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[94877.493016] [ T249695] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[94877.493026] [ T249695] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
[94877.493121] [ T249695] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 =
d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 7f d0 5c c7 e9 9f=
 fd ff ff
<0f> 0b b8 ea ff ff ff e9 6e d0 5c c7 b8 ea ff ff ff e9 64 d0 5c c7
[94877.493132] [ T249695] RSP: 0018:ffffb97f105f7bd0 EFLAGS: 00010246
[94877.493142] [ T249695] RAX: ffff9f0638b5e490 RBX: ffff9f05059a0000 RCX:=
 0000000000000000
[94877.493150] [ T249695] RDX: 0000000000000000 RSI: ffff9f05059a0008 RDI:=
 ffff9f056be00000
[94877.493159] [ T249695] RBP: ffff9f05059a0000 R08: 0000000000000001 R09:=
 0000000000000000
[94877.493170] [ T249695] R10: 000000000040003f R11: 0000000000000000 R12:=
 ffff9f056be00000
[94877.493175] [ T249695] R13: ffffffffc0cac1a8 R14: ffffffffc0cac1a8 R15:=
 ffff9f0501370500
[94877.493186] [ T249695] FS:  0000000000000000(0000) GS:ffff9f07ba940000(=
0000) knlGS:0000000000000000
[94877.493190] [ T249695] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[94877.493197] [ T249695] CR2: 00007fe7f6aa2000 CR3: 00000001055a0000 CR4:=
 0000000000750ef0
[94877.493201] [ T249695] PKRU: 55555554
[94877.493208] [ T249695] Call Trace:
[94877.493213] [ T249695]  <TASK>
[94877.493221] [ T249695]  ? __warn.cold+0x90/0x9e
[94877.493229] [ T249695]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
[94877.493324] [ T249695]  ? report_bug+0xfa/0x140
[94877.493334] [ T249695]  ? handle_bug+0x53/0x90
[94877.493343] [ T249695]  ? exc_invalid_op+0x17/0x70
[94877.493352] [ T249695]  ? asm_exc_invalid_op+0x1a/0x20
[94877.493363] [ T249695]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
[94877.493460] [ T249695]  smu_smc_hw_cleanup+0x5e/0x3e0 [amdgpu]
[94877.493596] [ T249695]  smu_hw_fini+0xfb/0x1a0 [amdgpu]
[94877.493709] [ T249695]  amdgpu_ip_block_hw_fini+0x2b/0x59 [amdgpu]
[94877.493842] [ T249695]  amdgpu_device_fini_hw+0x1fe/0x2ad [amdgpu]
[94877.493965] [ T249695]  amdgpu_pci_remove+0x40/0x70 [amdgpu]
[94877.494048] [ T249695]  pci_device_remove+0x3d/0xb0
[94877.494056] [ T249695]  device_release_driver_internal+0x197/0x200
[94877.494065] [ T249695]  pci_stop_bus_device+0x68/0x80
[94877.494073] [ T249695]  pci_stop_bus_device+0x38/0x80
[94877.494081] [ T249695]  pci_stop_and_remove_bus_device+0xd/0x20
[94877.494089] [ T249695]  trim_stale_devices+0x147/0x1a0
[94877.494097] [ T249695]  trim_stale_devices+0xa1/0x1a0
[94877.494105] [ T249695]  acpiphp_check_bridge.part.0+0x126/0x170
[94877.494113] [ T249695]  acpiphp_hotplug_notify+0xc1/0x260
[94877.494121] [ T249695]  ? acpiphp_post_dock_fixup+0xe0/0xe0
[94877.494128] [ T249695]  acpi_device_hotplug+0xc1/0x450
[94877.494136] [ T249695]  acpi_hotplug_work_fn+0x19/0x30
[94877.494144] [ T249695]  process_one_work+0x161/0x270
[94877.494152] [ T249695]  worker_thread+0x30a/0x440
[94877.494161] [ T249695]  ? rescuer_thread+0x500/0x500
[94877.494168] [ T249695]  kthread+0xea/0x1e0
[94877.494176] [ T249695]  ? kthreads_online_cpu+0xf0/0xf0
[94877.494184] [ T249695]  ret_from_fork+0x2f/0x50
[94877.494192] [ T249695]  ? kthreads_online_cpu+0xf0/0xf0
[94877.494200] [ T249695]  ret_from_fork_asm+0x11/0x20
[94877.494209] [ T249695]  </TASK>
[94877.494216] [ T249695] ---[ end trace 0000000000000000 ]---
[94877.494239] [ T249695] amdgpu 0000:03:00.0: amdgpu: Fail to disable the=
rmal alert!
[94877.514281] [ T249695] ------------[ cut here ]------------
[94877.514294] [ T249695] WARNING: CPU: 10 PID: 249695 at drivers/gpu/drm/=
amd/amdgpu/amdgpu_object.c:510 amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[94877.514409] [ T249695] Modules linked in: ec_sys netconsole sd_mod scsi=
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
[94877.514518] [ T249695]  nvme_fabrics efi_pstore configfs efivarfs autof=
s4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_hel=
per ttm
drm_panel_backlight_quirks drm_exec drm_suballoc_helper cec xhci_pci amdxc=
p xhci_hcd drm_buddy hid_multitouch hid_sensor_hub gpu_sched mfd_core hid_=
generic
i2c_hid_acpi drm_display_helper psmouse usbcore amd_sfh i2c_hid nvme hid d=
rm_kms_helper serio_raw nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc=
16
i2c_designware_platform i2c_designware_core
[94877.514584] [ T249695] CPU: 10 UID: 0 PID: 249695 Comm: kworker/u64:4 T=
ainted: G        W          6.14.0-mystery-00198-g74adf9e35384 #36
[94877.514592] [ T249695] Tainted: [W]=3DWARN
[94877.514597] [ T249695] Hardware name: Micro-Star International Co., Ltd=
. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[94877.514602] [ T249695] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[94877.514609] [ T249695] RIP: 0010:amdgpu_bo_free_kernel+0xe4/0x100 [amdg=
pu]
[94877.514718] [ T249695] Code: f6 ff ff 4d 85 e4 74 08 49 c7 04 24 00 00 =
00 00 48 85 ed 74 08 48 c7 45 00 00 00 00 00 5b 5d 41 5c 41 5d 41 5e e9 a7=
 99 65 c7
<0f> 0b e9 4b ff ff ff 3d 00 fe ff ff 0f 85 e5 9d 5d 00 eb bd 0f 1f
[94877.514724] [ T249695] RSP: 0018:ffffb97f105f7bb0 EFLAGS: 00010202
[94877.514730] [ T249695] RAX: 0000000000000000 RBX: ffff9f056be3b890 RCX:=
 0000000080000000
[94877.514736] [ T249695] RDX: ffff9f056be3b8e0 RSI: ffff9f056be3b8e8 RDI:=
 ffff9f056be3b890
[94877.514741] [ T249695] RBP: ffff9f056be3b8e0 R08: 0000000000000000 R09:=
 00000000ffffffea
[94877.514745] [ T249695] R10: ffff9f07e02fffa8 R11: 0000000000000003 R12:=
 ffff9f056be3b8e8
[94877.514750] [ T249695] R13: ffff9f05b0b61000 R14: ffff9f056be0ef80 R15:=
 ffff9f0501370500
[94877.514756] [ T249695] FS:  0000000000000000(0000) GS:ffff9f07ba880000(=
0000) knlGS:0000000000000000
[94877.514761] [ T249695] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[94877.514766] [ T249695] CR2: 000055e0b0eb1fe8 CR3: 0000000386c18000 CR4:=
 0000000000750ef0
[94877.514771] [ T249695] PKRU: 55555554
[94877.514776] [ T249695] Call Trace:
[94877.514782] [ T249695]  <TASK>
[94877.514787] [ T249695]  ? __warn.cold+0x90/0x9e
[94877.514794] [ T249695]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[94877.514901] [ T249695]  ? report_bug+0xfa/0x140
[94877.514908] [ T249695]  ? handle_bug+0x53/0x90
[94877.514914] [ T249695]  ? exc_invalid_op+0x17/0x70
[94877.514920] [ T249695]  ? asm_exc_invalid_op+0x1a/0x20
[94877.514928] [ T249695]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[94877.515031] [ T249695]  psp_v11_0_ring_destroy+0x2e/0x50 [amdgpu]
[94877.515123] [ T249695]  psp_hw_fini+0x126/0x380 [amdgpu]
[94877.515208] [ T249695]  amdgpu_ip_block_hw_fini+0x2b/0x59 [amdgpu]
[94877.515337] [ T249695]  amdgpu_device_fini_hw+0x1fe/0x2ad [amdgpu]
[94877.515451] [ T249695]  amdgpu_pci_remove+0x40/0x70 [amdgpu]
[94877.515533] [ T249695]  pci_device_remove+0x3d/0xb0
[94877.515538] [ T249695]  device_release_driver_internal+0x197/0x200
[94877.515544] [ T249695]  pci_stop_bus_device+0x68/0x80
[94877.515549] [ T249695]  pci_stop_bus_device+0x38/0x80
[94877.515554] [ T249695]  pci_stop_and_remove_bus_device+0xd/0x20
[94877.515559] [ T249695]  trim_stale_devices+0x147/0x1a0
[94877.515564] [ T249695]  trim_stale_devices+0xa1/0x1a0
[94877.515570] [ T249695]  acpiphp_check_bridge.part.0+0x126/0x170
[94877.515575] [ T249695]  acpiphp_hotplug_notify+0xc1/0x260
[94877.515580] [ T249695]  ? acpiphp_post_dock_fixup+0xe0/0xe0
[94877.515585] [ T249695]  acpi_device_hotplug+0xc1/0x450
[94877.515590] [ T249695]  acpi_hotplug_work_fn+0x19/0x30
[94877.515595] [ T249695]  process_one_work+0x161/0x270
[94877.515599] [ T249695]  worker_thread+0x30a/0x440
[94877.515604] [ T249695]  ? rescuer_thread+0x500/0x500
[94877.515609] [ T249695]  kthread+0xea/0x1e0
[94877.515614] [ T249695]  ? kthreads_online_cpu+0xf0/0xf0
[94877.515619] [ T249695]  ret_from_fork+0x2f/0x50
[94877.515624] [ T249695]  ? kthreads_online_cpu+0xf0/0xf0
[94877.515629] [ T249695]  ret_from_fork_asm+0x11/0x20
[94877.515636] [ T249695]  </TASK>
[94877.515639] [ T249695] ---[ end trace 0000000000000000 ]---
[94877.516672] [ T249695] ------------[ cut here ]------------
[94877.516676] [ T249695] WARNING: CPU: 10 PID: 249695 at drivers/gpu/drm/=
amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x41/0x70 [amdgpu]
[94877.516767] [ T249695] Modules linked in: ec_sys netconsole sd_mod scsi=
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
[94877.516839] [ T249695]  nvme_fabrics efi_pstore configfs efivarfs autof=
s4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_hel=
per ttm
drm_panel_backlight_quirks drm_exec drm_suballoc_helper cec xhci_pci amdxc=
p xhci_hcd drm_buddy hid_multitouch hid_sensor_hub gpu_sched mfd_core hid_=
generic
i2c_hid_acpi drm_display_helper psmouse usbcore amd_sfh i2c_hid nvme hid d=
rm_kms_helper serio_raw nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc=
16
i2c_designware_platform i2c_designware_core
[94877.516884] [ T249695] CPU: 10 UID: 0 PID: 249695 Comm: kworker/u64:4 T=
ainted: G        W          6.14.0-mystery-00198-g74adf9e35384 #36
[94877.516889] [ T249695] Tainted: [W]=3DWARN
[94877.516893] [ T249695] Hardware name: Micro-Star International Co., Ltd=
. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[94877.516896] [ T249695] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[94877.516901] [ T249695] RIP: 0010:amdgpu_irq_put+0x41/0x70 [amdgpu]
[94877.516987] [ T249695] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 =
d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 e9 7f d0 5c c7 e9 9f=
 fd ff ff
<0f> 0b b8 ea ff ff ff e9 6e d0 5c c7 b8 ea ff ff ff e9 64 d0 5c c7
[94877.516991] [ T249695] RSP: 0018:ffffb97f105f7c10 EFLAGS: 00010246
[94877.516996] [ T249695] RAX: ffff9f0638b5efa8 RBX: ffff9f056be00000 RCX:=
 0000000000000000
[94877.516999] [ T249695] RDX: 0000000000000000 RSI: ffff9f056be00c78 RDI:=
 ffff9f056be00000
[94877.517003] [ T249695] RBP: 0000000000000001 R08: 0000000000000001 R09:=
 0000000000000000
[94877.517007] [ T249695] R10: 000000000020001f R11: 0000000000000000 R12:=
 ffff9f056be46e48
[94877.517010] [ T249695] R13: ffffffffc0cac1a8 R14: ffffffffc0cac1a8 R15:=
 ffff9f0501370500
[94877.517014] [ T249695] FS:  0000000000000000(0000) GS:ffff9f07ba880000(=
0000) knlGS:0000000000000000
[94877.517018] [ T249695] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[94877.517021] [ T249695] CR2: 000055e0b0eb1fe8 CR3: 0000000386c18000 CR4:=
 0000000000750ef0
[94877.517025] [ T249695] PKRU: 55555554
[94877.517029] [ T249695] Call Trace:
[94877.517032] [ T249695]  <TASK>
[94877.517037] [ T249695]  ? __warn.cold+0x90/0x9e
[94877.517043] [ T249695]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
[94877.517147] [ T249695]  ? report_bug+0xfa/0x140
[94877.517153] [ T249695]  ? handle_bug+0x53/0x90
[94877.517159] [ T249695]  ? exc_invalid_op+0x17/0x70
[94877.517164] [ T249695]  ? asm_exc_invalid_op+0x1a/0x20
[94877.517171] [ T249695]  ? amdgpu_irq_put+0x41/0x70 [amdgpu]
[94877.517284] [ T249695]  gmc_v10_0_hw_fini+0x52/0xb0 [amdgpu]
[94877.517389] [ T249695]  amdgpu_ip_block_hw_fini+0x2b/0x59 [amdgpu]
[94877.517550] [ T249695]  amdgpu_device_fini_hw+0x1fe/0x2ad [amdgpu]
[94877.517695] [ T249695]  amdgpu_pci_remove+0x40/0x70 [amdgpu]
[94877.517792] [ T249695]  pci_device_remove+0x3d/0xb0
[94877.517799] [ T249695]  device_release_driver_internal+0x197/0x200
[94877.517804] [ T249695]  pci_stop_bus_device+0x68/0x80
[94877.517811] [ T249695]  pci_stop_bus_device+0x38/0x80
[94877.517816] [ T249695]  pci_stop_and_remove_bus_device+0xd/0x20
[94877.517822] [ T249695]  trim_stale_devices+0x147/0x1a0
[94877.517828] [ T249695]  trim_stale_devices+0xa1/0x1a0
[94877.517834] [ T249695]  acpiphp_check_bridge.part.0+0x126/0x170
[94877.517840] [ T249695]  acpiphp_hotplug_notify+0xc1/0x260
[94877.517846] [ T249695]  ? acpiphp_post_dock_fixup+0xe0/0xe0
[94877.517852] [ T249695]  acpi_device_hotplug+0xc1/0x450
[94877.517859] [ T249695]  acpi_hotplug_work_fn+0x19/0x30
[94877.517864] [ T249695]  process_one_work+0x161/0x270
[94877.517870] [ T249695]  worker_thread+0x30a/0x440
[94877.517876] [ T249695]  ? rescuer_thread+0x500/0x500
[94877.517881] [ T249695]  kthread+0xea/0x1e0
[94877.517887] [ T249695]  ? kthreads_online_cpu+0xf0/0xf0
[94877.517894] [ T249695]  ret_from_fork+0x2f/0x50
[94877.517900] [ T249695]  ? kthreads_online_cpu+0xf0/0xf0
[94877.517906] [ T249695]  ret_from_fork_asm+0x11/0x20
[94877.517913] [ T249695]  </TASK>
[94877.517918] [ T249695] ---[ end trace 0000000000000000 ]---
[94877.517978] [ T249695] ------------[ cut here ]------------
[94877.517983] [ T249695] WARNING: CPU: 10 PID: 249695 at drivers/gpu/drm/=
amd/amdgpu/amdgpu_object.c:510 amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[94877.518067] [ T249695] Modules linked in: ec_sys netconsole sd_mod scsi=
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
[94877.518139] [ T249695]  nvme_fabrics efi_pstore configfs efivarfs autof=
s4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_hel=
per ttm
drm_panel_backlight_quirks drm_exec drm_suballoc_helper cec xhci_pci amdxc=
p xhci_hcd drm_buddy hid_multitouch hid_sensor_hub gpu_sched mfd_core hid_=
generic
i2c_hid_acpi drm_display_helper psmouse usbcore amd_sfh i2c_hid nvme hid d=
rm_kms_helper serio_raw nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc=
16
i2c_designware_platform i2c_designware_core
[94877.518184] [ T249695] CPU: 10 UID: 0 PID: 249695 Comm: kworker/u64:4 T=
ainted: G        W          6.14.0-mystery-00198-g74adf9e35384 #36
[94877.518188] [ T249695] Tainted: [W]=3DWARN
[94877.518192] [ T249695] Hardware name: Micro-Star International Co., Ltd=
. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[94877.518196] [ T249695] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[94877.518201] [ T249695] RIP: 0010:amdgpu_bo_free_kernel+0xe4/0x100 [amdg=
pu]
[94877.518279] [ T249695] Code: f6 ff ff 4d 85 e4 74 08 49 c7 04 24 00 00 =
00 00 48 85 ed 74 08 48 c7 45 00 00 00 00 00 5b 5d 41 5c 41 5d 41 5e e9 a7=
 99 65 c7
<0f> 0b e9 4b ff ff ff 3d 00 fe ff ff 0f 85 e5 9d 5d 00 eb bd 0f 1f
[94877.518284] [ T249695] RSP: 0018:ffffb97f105f7be0 EFLAGS: 00010202
[94877.518288] [ T249695] RAX: ffff9f07ba8a5d80 RBX: ffff9f056be14b60 RCX:=
 000000000000016f
[94877.518292] [ T249695] RDX: ffff9f056be14b68 RSI: ffff9f056be14b70 RDI:=
 ffff9f056be14b60
[94877.518295] [ T249695] RBP: ffff9f056be14b68 R08: 00000000000056ee R09:=
 0000000000000009
[94877.518299] [ T249695] R10: 0000000000000008 R11: 0000000000000139 R12:=
 ffff9f056be14b70
[94877.518303] [ T249695] R13: ffff9f0519e18800 R14: ffff9f056be0ef80 R15:=
 ffff9f0501370500
[94877.518306] [ T249695] FS:  0000000000000000(0000) GS:ffff9f07ba880000(=
0000) knlGS:0000000000000000
[94877.518310] [ T249695] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[94877.518314] [ T249695] CR2: 000055e0b0eb1fe8 CR3: 0000000386c18000 CR4:=
 0000000000750ef0
[94877.518318] [ T249695] PKRU: 55555554
[94877.518321] [ T249695] Call Trace:
[94877.518325] [ T249695]  <TASK>
[94877.518329] [ T249695]  ? __warn.cold+0x90/0x9e
[94877.518333] [ T249695]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[94877.518412] [ T249695]  ? report_bug+0xfa/0x140
[94877.518417] [ T249695]  ? handle_bug+0x53/0x90
[94877.518421] [ T249695]  ? exc_invalid_op+0x17/0x70
[94877.518425] [ T249695]  ? asm_exc_invalid_op+0x1a/0x20
[94877.518431] [ T249695]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[94877.518518] [ T249695]  amdgpu_ih_ring_fini+0x4f/0x80 [amdgpu]
[94877.518608] [ T249695]  amdgpu_irq_fini_hw+0x2f/0x80 [amdgpu]
[94877.518693] [ T249695]  amdgpu_device_fini_hw+0x231/0x2ad [amdgpu]
[94877.518821] [ T249695]  amdgpu_pci_remove+0x40/0x70 [amdgpu]
[94877.518898] [ T249695]  pci_device_remove+0x3d/0xb0
[94877.518903] [ T249695]  device_release_driver_internal+0x197/0x200
[94877.518908] [ T249695]  pci_stop_bus_device+0x68/0x80
[94877.518913] [ T249695]  pci_stop_bus_device+0x38/0x80
[94877.518918] [ T249695]  pci_stop_and_remove_bus_device+0xd/0x20
[94877.518922] [ T249695]  trim_stale_devices+0x147/0x1a0
[94877.518928] [ T249695]  trim_stale_devices+0xa1/0x1a0
[94877.518932] [ T249695]  acpiphp_check_bridge.part.0+0x126/0x170
[94877.518937] [ T249695]  acpiphp_hotplug_notify+0xc1/0x260
[94877.518942] [ T249695]  ? acpiphp_post_dock_fixup+0xe0/0xe0
[94877.518947] [ T249695]  acpi_device_hotplug+0xc1/0x450
[94877.518952] [ T249695]  acpi_hotplug_work_fn+0x19/0x30
[94877.518956] [ T249695]  process_one_work+0x161/0x270
[94877.518960] [ T249695]  worker_thread+0x30a/0x440
[94877.518965] [ T249695]  ? rescuer_thread+0x500/0x500
[94877.518969] [ T249695]  kthread+0xea/0x1e0
[94877.518974] [ T249695]  ? kthreads_online_cpu+0xf0/0xf0
[94877.518979] [ T249695]  ret_from_fork+0x2f/0x50
[94877.518984] [ T249695]  ? kthreads_online_cpu+0xf0/0xf0
[94877.518989] [ T249695]  ret_from_fork_asm+0x11/0x20
[94877.518996] [ T249695]  </TASK>
[94877.518999] [ T249695] ---[ end trace 0000000000000000 ]---
[94877.519192] [ T249695] ------------[ cut here ]------------
[94877.519201] [ T249695] WARNING: CPU: 10 PID: 249695 at drivers/gpu/drm/=
amd/amdgpu/amdgpu_object.c:510 amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[94877.519280] [ T249695] Modules linked in: ec_sys netconsole sd_mod scsi=
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
[94877.519352] [ T249695]  nvme_fabrics efi_pstore configfs efivarfs autof=
s4 ext4 mbcache jbd2 usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_hel=
per ttm
drm_panel_backlight_quirks drm_exec drm_suballoc_helper cec xhci_pci amdxc=
p xhci_hcd drm_buddy hid_multitouch hid_sensor_hub gpu_sched mfd_core hid_=
generic
i2c_hid_acpi drm_display_helper psmouse usbcore amd_sfh i2c_hid nvme hid d=
rm_kms_helper serio_raw nvme_core r8169 i2c_piix4 i2c_smbus usb_common crc=
16
i2c_designware_platform i2c_designware_core
[94877.519397] [ T249695] CPU: 10 UID: 0 PID: 249695 Comm: kworker/u64:4 T=
ainted: G        W          6.14.0-mystery-00198-g74adf9e35384 #36
[94877.519402] [ T249695] Tainted: [W]=3DWARN
[94877.519405] [ T249695] Hardware name: Micro-Star International Co., Ltd=
. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[94877.519409] [ T249695] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[94877.519414] [ T249695] RIP: 0010:amdgpu_bo_free_kernel+0xe4/0x100 [amdg=
pu]
[94877.519500] [ T249695] Code: f6 ff ff 4d 85 e4 74 08 49 c7 04 24 00 00 =
00 00 48 85 ed 74 08 48 c7 45 00 00 00 00 00 5b 5d 41 5c 41 5d 41 5e e9 a7=
 99 65 c7
<0f> 0b e9 4b ff ff ff 3d 00 fe ff ff 0f 85 e5 9d 5d 00 eb bd 0f 1f
[94877.519505] [ T249695] RSP: 0018:ffffb97f105f7c28 EFLAGS: 00010202
[94877.519509] [ T249695] RAX: 0000000000000000 RBX: ffff9f056be00a20 RCX:=
 0000000000000001
[94877.519513] [ T249695] RDX: ffff9f056be00a28 RSI: 0000000000000000 RDI:=
 ffff9f056be00a20
[94877.519517] [ T249695] RBP: ffff9f056be00a28 R08: 0000000000000020 R09:=
 ffffffff891e8340
[94877.519520] [ T249695] R10: 0000000000000020 R11: 000000000000016d R12:=
 0000000000000000
[94877.519524] [ T249695] R13: ffff9f0519e1b800 R14: ffff9f056be0ef80 R15:=
 ffff9f0501370500
[94877.519528] [ T249695] FS:  0000000000000000(0000) GS:ffff9f07ba880000(=
0000) knlGS:0000000000000000
[94877.519532] [ T249695] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[94877.519535] [ T249695] CR2: 000055e0b0eb1fe8 CR3: 0000000386c18000 CR4:=
 0000000000750ef0
[94877.519539] [ T249695] PKRU: 55555554
[94877.519543] [ T249695] Call Trace:
[94877.519546] [ T249695]  <TASK>
[94877.519550] [ T249695]  ? __warn.cold+0x90/0x9e
[94877.519555] [ T249695]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[94877.519633] [ T249695]  ? report_bug+0xfa/0x140
[94877.519638] [ T249695]  ? handle_bug+0x53/0x90
[94877.519642] [ T249695]  ? exc_invalid_op+0x17/0x70
[94877.519647] [ T249695]  ? asm_exc_invalid_op+0x1a/0x20
[94877.519652] [ T249695]  ? amdgpu_bo_free_kernel+0xe4/0x100 [amdgpu]
[94877.519731] [ T249695]  amdgpu_device_unmap_mmio+0x25/0x90 [amdgpu]
[94877.519808] [ T249695]  amdgpu_pci_remove+0x40/0x70 [amdgpu]
[94877.519885] [ T249695]  pci_device_remove+0x3d/0xb0
[94877.519889] [ T249695]  device_release_driver_internal+0x197/0x200
[94877.519894] [ T249695]  pci_stop_bus_device+0x68/0x80
[94877.519899] [ T249695]  pci_stop_bus_device+0x38/0x80
[94877.519904] [ T249695]  pci_stop_and_remove_bus_device+0xd/0x20
[94877.519908] [ T249695]  trim_stale_devices+0x147/0x1a0
[94877.519913] [ T249695]  trim_stale_devices+0xa1/0x1a0
[94877.519918] [ T249695]  acpiphp_check_bridge.part.0+0x126/0x170
[94877.519923] [ T249695]  acpiphp_hotplug_notify+0xc1/0x260
[94877.519928] [ T249695]  ? acpiphp_post_dock_fixup+0xe0/0xe0
[94877.519933] [ T249695]  acpi_device_hotplug+0xc1/0x450
[94877.519938] [ T249695]  acpi_hotplug_work_fn+0x19/0x30
[94877.519942] [ T249695]  process_one_work+0x161/0x270
[94877.519947] [ T249695]  worker_thread+0x30a/0x440
[94877.519951] [ T249695]  ? rescuer_thread+0x500/0x500
[94877.519956] [ T249695]  kthread+0xea/0x1e0
[94877.519961] [ T249695]  ? kthreads_online_cpu+0xf0/0xf0
[94877.519965] [ T249695]  ret_from_fork+0x2f/0x50
[94877.519970] [ T249695]  ? kthreads_online_cpu+0xf0/0xf0
[94877.519975] [ T249695]  ret_from_fork_asm+0x11/0x20
[94877.519981] [ T249695]  </TASK>
[94877.519985] [ T249695] ---[ end trace 0000000000000000 ]---
[94878.445496] [ T255166] pcieport 0000:02:00.0: Data Link Layer Link Acti=
ve not set in 1000 msec
[94878.446706] [ T249695] pci_bus 0000:03: busn_res: [bus 03] is released

Bert Karwatzki

