Return-Path: <linux-pci+bounces-31861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9FEB00829
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 18:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9584A165B8C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB9B2EF283;
	Thu, 10 Jul 2025 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="d5WTHjUw"
X-Original-To: linux-pci@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC602EF649
	for <linux-pci@vger.kernel.org>; Thu, 10 Jul 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163455; cv=none; b=MKzuYhUqb0tR6k6DQ2osG6j5T6FXkc+4gULxcTluNu82v0MbfbkRfyr+PqYnBexTIseJb38Id0w66e273BG5CQ6Zpqr9q/MQOwXsC9qZL/BQ4vtfhtuDy+6/d+IywgjXL3B80Z+rHeQr9c5nPLHgTQjnrWQrectgAcPZg0GD3rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163455; c=relaxed/simple;
	bh=0RVXGR7LZ9mYoy19mD+52UhTa8ezKpw9ORToenI1jNM=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=plAqFUJoWioI7fSxHAPErLXD0AY8jSHmB4rMdMsX6Ci4gFwvLgJKLBjoc81vgdzu2BmHGVuGc5TjKNBAmDIf7ULitGlstIlfW1LW//oCOhRG/ocb+2PA2ie7M07OlG2dkKS4ODjndwXJ3bz9P/PxxJSisW2w4xLmAqj1bOVZoyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=d5WTHjUw; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=hk/6/zYk48+A2ilj6mxYup+h+PTbUxsREww5LDt0tmU=; b=d5WTHjUwe2tr/EZrboljmWs/tK
	FXQ1vWHgxIMzrVcmEev4IZ65mUIpVa636mCNpfFyQg3BKO/uBiP/kk5AjM0gpE7k/mDXo6H0/EnAI
	hB6SC1S6h+lMnUsUDu9CMgxjiuoAoMjaRwSrxZXOzSaKMyQ5f5LCgjyCEmmkz0nndJfl7x3lTvuc8
	+XTkDrTltheB2/AxWcxNL3LkKqVCVUmC0DzBbnN1v2PYZ4B2Ipu9DYo3PebFL7RHQl6cIWS9V5blT
	2UdUMLqf7iBYLu0Oob8nPXt1kX+wI1sSGxOeQKqJeXKcCmbswd69nCnNiE/9a0UesIs1oux1QPkMZ
	rNrQGDJQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <benh@debian.org>)
	id 1uZtPo-00FSbf-Cy; Thu, 10 Jul 2025 15:42:28 +0000
Message-ID: <00571ac825960730bbc1c2fe28d6d2dca251d322.camel@debian.org>
Subject: Failure to resume ASMedia ASM4242 on AMD systems
From: Ben Hutchings <benh@debian.org>
To: linux-pci <linux-pci@vger.kernel.org>
Cc: 1102175@bugs.debian.org, Alison Chaiken <alison@she-devel.com>, Brandon
 Falk <b@bfa.lk>
Date: Thu, 10 Jul 2025 17:42:23 +0200
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-++4+ciE3/D2PlbGb8JVA"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Debian-User: benh


--=-++4+ciE3/D2PlbGb8JVA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Debian received a bug report <https://bugs.debian.org/1102175> about
soft lockups where a Thunderbolt bridge fails to come back from runtime
suspend.  Here's an example:

2025-04-11T20:12:16.449990-07:00 schallkreis kernel: pcieport 0000:0f:00.0:=
 Unable to change power state from D3cold to D0, device inaccessible
2025-04-11T20:12:38.513032-07:00 schallkreis kernel: watchdog: BUG: soft lo=
ckup - CPU#1 stuck for 22s! [apcupsd:3119]
2025-04-11T20:12:38.513045-07:00 schallkreis kernel: Modules linked in: qrt=
r nfsd auth_rpcgss nfs_acl lockd grace binfmt_misc sunrpc nls_ascii nls_cp4=
37 vfat fat amd_atl intel_rapl_msr intel_rapl_co
mmon mt7925e mt7925_common mt792x_lib mt76_connac_lib edac_mce_amd mt76 snd=
_hda_codec_realtek kvm_amd snd_hda_codec_generic mac80211 snd_hda_scodec_co=
mponent snd_hda_codec_hdmi kvm snd_hda_intel snd
_intel_dspcfg libarc4 snd_intel_sdw_acpi snd_hda_codec cfg80211 crct10dif_p=
clmul ghash_clmulni_intel snd_hda_core sha512_ssse3 sha256_ssse3 sha1_ssse3=
 snd_hwdep aesni_intel snd_pcm gf128mul crypto_s
imd cryptd spd5118 wmi_bmof snd_timer rapl ccp pcspkr snd k10temp rfkill so=
undcore joydev evdev parport_pc ppdev lp parport configfs efi_pstore nfnetl=
ink efivarfs ip_tables x_tables autofs4 ext4 mbc
ache jbd2 crc32c_generic hid_generic usbhid hid amdgpu amdxcp drm_exec gpu_=
sched drm_buddy i2c_algo_bit drm_suballoc_helper drm_display_helper cec rc_=
core drm_ttm_helper ttm xhci_pci xhci_hcd drm_km
s_helper ahci libahci libata drm thunderbolt r8169 usbcore nvme sp5100_tco =
watchdog
2025-04-11T20:12:38.513046-07:00 schallkreis kernel:  scsi_mod realtek mdio=
_devres nvme_core libphy crc32_pclmul crc32c_intel i2c_piix4 i2c_smbus usb_=
common video scsi_common nvme_auth crc16 wmi gpi
o_amdpt gpio_generic button
2025-04-11T20:12:38.513047-07:00 schallkreis kernel: CPU: 1 UID: 0 PID: 311=
9 Comm: apcupsd Not tainted 6.12.21-amd64 #1  Debian 6.12.21-1
2025-04-11T20:12:38.513048-07:00 schallkreis kernel: Hardware name: System7=
6 Thelio Mira/Thelio Mira, BIOS 3.11.SP01 12/05/2024
2025-04-11T20:12:38.513049-07:00 schallkreis kernel: RIP: 0010:pci_mmcfg_re=
ad+0xa4/0xe0
2025-04-11T20:12:38.513049-07:00 schallkreis kernel: Code: fe 01 75 0b 4c 0=
1 e0 8a 00 0f b6 c0 89 45 00 e8 a2 6a 51 ff 31 c0 5b 5d 41 5c 41 5d 41 5e 4=
1 5f c3 cc cc cc cc 4c 01 e0 8b 00 <89> 45 00 eb e0 4c 01 e0 66 8b 00 0f b7=
 c0 89 45 00 eb d2 e8 74 6a
2025-04-11T20:12:38.513050-07:00 schallkreis kernel: RSP: 0018:ffffaf7345f9=
3688 EFLAGS: 00000286
2025-04-11T20:12:38.513050-07:00 schallkreis kernel: RAX: 00000000ffffffff =
RBX: 0000000000f00000 RCX: 0000000000000ffc
2025-04-11T20:12:38.513064-07:00 schallkreis kernel: RDX: 00000000000000ff =
RSI: 000000000000000f RDI: 0000000000000000
2025-04-11T20:12:38.513065-07:00 schallkreis kernel: RBP: ffffaf7345f936c4 =
R08: 0000000000000004 R09: ffffaf7345f936c4
2025-04-11T20:12:38.513065-07:00 schallkreis kernel: R10: 000000000000000f =
R11: ffffffffab061970 R12: 0000000000000ffc
2025-04-11T20:12:38.513066-07:00 schallkreis kernel: R13: 0000000000000000 =
R14: 0000000000000004 R15: 0000000000000000
2025-04-11T20:12:38.513066-07:00 schallkreis kernel: FS:  00007fa0debc10c0(=
0000) GS:ffff9ca81f280000(0000) knlGS:0000000000000000
2025-04-11T20:12:38.513066-07:00 schallkreis kernel: CS:  0010 DS: 0000 ES:=
 0000 CR0: 0000000080050033
2025-04-11T20:12:38.513066-07:00 schallkreis kernel: CR2: 00002bac04cb4000 =
CR3: 00000001188ce000 CR4: 0000000000f50ef0
2025-04-11T20:12:38.513067-07:00 schallkreis kernel: PKRU: 55555554
2025-04-11T20:12:38.513067-07:00 schallkreis kernel: Call Trace:
2025-04-11T20:12:38.513068-07:00 schallkreis kernel:  <IRQ>
2025-04-11T20:12:38.513068-07:00 schallkreis kernel:  ? watchdog_timer_fn.c=
old+0x3d/0xa1
2025-04-11T20:12:38.513069-07:00 schallkreis kernel:  ? __pfx_watchdog_time=
r_fn+0x10/0x10
2025-04-11T20:12:38.513069-07:00 schallkreis kernel:  ? __hrtimer_run_queue=
s+0x12f/0x2a0
2025-04-11T20:12:38.513069-07:00 schallkreis kernel:  ? hrtimer_interrupt+0=
xfa/0x210
2025-04-11T20:12:38.513069-07:00 schallkreis kernel:  ? __sysvec_apic_timer=
_interrupt+0x52/0x100
2025-04-11T20:12:38.513070-07:00 schallkreis kernel:  ? sysvec_apic_timer_i=
nterrupt+0x6c/0x90
2025-04-11T20:12:38.513070-07:00 schallkreis kernel:  </IRQ>
2025-04-11T20:12:38.513070-07:00 schallkreis kernel:  <TASK>
2025-04-11T20:12:38.513070-07:00 schallkreis kernel:  ? asm_sysvec_apic_tim=
er_interrupt+0x1a/0x20
2025-04-11T20:12:38.513072-07:00 schallkreis kernel:  ? __pfx_pci_mmcfg_rea=
d+0x10/0x10
2025-04-11T20:12:38.513072-07:00 schallkreis kernel:  ? pci_mmcfg_read+0xa4=
/0xe0
2025-04-11T20:12:38.513072-07:00 schallkreis kernel:  ? pci_mmcfg_read+0x4f=
/0xe0
2025-04-11T20:12:38.513073-07:00 schallkreis kernel:  pci_bus_read_config_d=
word+0x4a/0x80
2025-04-11T20:12:38.513073-07:00 schallkreis kernel:  pci_find_next_ext_cap=
ability+0x89/0xf0
2025-04-11T20:12:38.513073-07:00 schallkreis kernel:  pci_restore_ltr_state=
+0x28/0x50
2025-04-11T20:12:38.513079-07:00 schallkreis kernel:  pci_restore_state.par=
t.0+0x29/0x370
2025-04-11T20:12:38.513080-07:00 schallkreis kernel:  pci_pm_runtime_resume=
+0x45/0xf0
2025-04-11T20:12:38.513080-07:00 schallkreis kernel:  ? __pfx_pci_pm_runtim=
e_resume+0x10/0x10
2025-04-11T20:12:38.513080-07:00 schallkreis kernel:  __rpm_callback+0x41/0=
x170
2025-04-11T20:12:38.513080-07:00 schallkreis kernel:  ? __pfx_pci_pm_runtim=
e_resume+0x10/0x10
2025-04-11T20:12:38.513081-07:00 schallkreis kernel:  rpm_callback+0x55/0x6=
0
2025-04-11T20:12:38.513082-07:00 schallkreis kernel:  ? __pfx_pci_pm_runtim=
e_resume+0x10/0x10
2025-04-11T20:12:38.513082-07:00 schallkreis kernel:  rpm_resume+0x4d3/0x70=
0
2025-04-11T20:12:38.513083-07:00 schallkreis kernel:  ? xhci_get_resuming_p=
orts+0x12/0x50 [xhci_hcd]
2025-04-11T20:12:38.513083-07:00 schallkreis kernel:  ? hub_resume+0xa5/0x1=
00 [usbcore]
2025-04-11T20:12:38.513083-07:00 schallkreis kernel:  rpm_resume+0x2d3/0x70=
0
2025-04-11T20:12:38.513083-07:00 schallkreis kernel:  rpm_resume+0x2d3/0x70=
0
2025-04-11T20:12:38.513084-07:00 schallkreis kernel:  rpm_resume+0x2d3/0x70=
0
2025-04-11T20:12:38.513084-07:00 schallkreis kernel:  ? klist_put+0x1f/0xb0
2025-04-11T20:12:38.513084-07:00 schallkreis kernel:  __pm_runtime_resume+0=
x4b/0x80
2025-04-11T20:12:38.513085-07:00 schallkreis kernel:  usb_autoresume_device=
+0x1e/0x50 [usbcore]
2025-04-11T20:12:38.513085-07:00 schallkreis kernel:  usbdev_open+0x103/0x2=
60 [usbcore]
2025-04-11T20:12:38.513086-07:00 schallkreis kernel:  ? bpf_prog_e8932b6bae=
2b9745_restrict_filesystems+0xb7/0x132
2025-04-11T20:12:38.513087-07:00 schallkreis kernel:  chrdev_open+0xb2/0x23=
0
2025-04-11T20:12:38.513087-07:00 schallkreis kernel:  ? __pfx_chrdev_open+0=
x10/0x10
2025-04-11T20:12:38.513087-07:00 schallkreis kernel:  do_dentry_open+0x14c/=
0x440
2025-04-11T20:12:38.513087-07:00 schallkreis kernel:  vfs_open+0x2e/0xe0
2025-04-11T20:12:38.513088-07:00 schallkreis kernel:  path_openat+0x82e/0x1=
2d0
2025-04-11T20:12:38.513089-07:00 schallkreis kernel:  ? usbdev_read+0x1d5/0=
x2c0 [usbcore]
2025-04-11T20:12:38.513089-07:00 schallkreis kernel:  do_filp_open+0xc4/0x1=
70
2025-04-11T20:12:38.513089-07:00 schallkreis kernel:  do_sys_openat2+0xae/0=
xe0
2025-04-11T20:12:38.513090-07:00 schallkreis kernel:  __x64_sys_openat+0x55=
/0xa0
2025-04-11T20:12:38.513090-07:00 schallkreis kernel:  do_syscall_64+0x82/0x=
190
2025-04-11T20:12:38.513090-07:00 schallkreis kernel:  ? __memcg_slab_free_h=
ook+0xf7/0x140
2025-04-11T20:12:38.513091-07:00 schallkreis kernel:  ? __x64_sys_close+0x3=
c/0x80
2025-04-11T20:12:38.513092-07:00 schallkreis kernel:  ? kmem_cache_free+0x3=
ee/0x440
2025-04-11T20:12:38.513092-07:00 schallkreis kernel:  ? syscall_exit_to_use=
r_mode+0x4d/0x210
2025-04-11T20:12:38.513093-07:00 schallkreis kernel:  ? do_syscall_64+0x8e/=
0x190
2025-04-11T20:12:38.513093-07:00 schallkreis kernel:  ? syscall_exit_to_use=
r_mode+0x4d/0x210
2025-04-11T20:12:38.513093-07:00 schallkreis kernel:  ? do_syscall_64+0x8e/=
0x190
2025-04-11T20:12:38.513094-07:00 schallkreis kernel:  ? do_sys_openat2+0x9c=
/0xe0
2025-04-11T20:12:38.513095-07:00 schallkreis kernel:  ? syscall_exit_to_use=
r_mode+0x4d/0x210
2025-04-11T20:12:38.513095-07:00 schallkreis kernel:  ? do_syscall_64+0x8e/=
0x190
2025-04-11T20:12:38.513095-07:00 schallkreis kernel:  ? do_syscall_64+0x8e/=
0x190
2025-04-11T20:12:38.513096-07:00 schallkreis kernel:  ? do_syscall_64+0x8e/=
0x190
2025-04-11T20:12:38.513096-07:00 schallkreis kernel:  ? do_syscall_64+0x8e/=
0x190
2025-04-11T20:12:38.513096-07:00 schallkreis kernel:  entry_SYSCALL_64_afte=
r_hwframe+0x76/0x7e
2025-04-11T20:12:38.513097-07:00 schallkreis kernel: RIP: 0033:0x7fa0dec5c9=
ee
2025-04-11T20:12:38.513098-07:00 schallkreis kernel: Code: 08 0f 85 f5 4b f=
f ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4=
c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f=
 80 00 00 00 00 48 83 ec 08
2025-04-11T20:12:38.513099-07:00 schallkreis kernel: RSP: 002b:00007ffe05ee=
1b78 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
2025-04-11T20:12:38.513099-07:00 schallkreis kernel: RAX: ffffffffffffffda =
RBX: 00007fa0debc10c0 RCX: 00007fa0dec5c9ee
2025-04-11T20:12:38.513099-07:00 schallkreis kernel: RDX: 0000000000080002 =
RSI: 000055a553c51310 RDI: ffffffffffffff9c
2025-04-11T20:12:38.513099-07:00 schallkreis kernel: RBP: 0000000000000007 =
R08: 0000000000000000 R09: 0000000000000000
2025-04-11T20:12:38.513100-07:00 schallkreis kernel: R10: 0000000000000000 =
R11: 0000000000000246 R12: 00007ffe05ee1cb0
2025-04-11T20:12:38.513101-07:00 schallkreis kernel: R13: 00007ffe05ee1c60 =
R14: 000055a54bf862cb R15: 0000000000000004
2025-04-11T20:12:38.513101-07:00 schallkreis kernel:  </TASK>

(full log is at <https://she-devel.com/Thelio-Mira-syslog.tar.xz>).

We later received a report of similar behaviour on a different system
running Gentoo:

Apr 30 03:08:17 tibia kernel: pcieport 0000:19:00.0: Unable to change power=
 state from D3cold to D0, device inaccessible
[...]
Apr 30 03:08:40 tibia kernel: watchdog: BUG: soft lockup - CPU#9 stuck for =
22s! [device poll:533454]
Apr 30 03:08:40 tibia kernel: CPU#9 Utilization every 4s during lockup:
Apr 30 03:08:42 tibia kernel:         #1:   2% system,          0% softirq,=
          0% hardirq,          0% idle
Apr 30 03:08:43 tibia kernel:         #2:   2% system,          0% softirq,=
          0% hardirq,          0% idle
Apr 30 03:08:43 tibia kernel:         #3:   2% system,          0% softirq,=
          0% hardirq,          0% idle
Apr 30 03:08:44 tibia kernel:         #4:   2% system,          0% softirq,=
          0% hardirq,          0% idle
Apr 30 03:08:44 tibia kernel:         #5:   2% system,          0% softirq,=
          0% hardirq,          0% idle
Apr 30 03:08:44 tibia kernel: Modules linked in: veth nf_conntrack_netlink =
xt_nat iptable_raw xt_set ip_set rfcomm snd_seq_dummy snd_seq_midi snd_hrti=
mer snd_seq_midi_event snd_seq xt_CHECKSUM xt_MASQUERADE ip6table_mangle ip=
6table_nat iptable_mangle iptable_nat nf_nat bridge stp llc overlay bnep vf=
at fat irdma i40e ib_uverbs ib_core amd_atl intel_rapl_msr intel_rapl_commo=
n mt7925e mt7925_common mt792x_lib mt76_connac_lib amdgpu edac_mce_amd snd_=
hda_codec_hdmi mt76 kvm_amd snd_hda_intel spd5118 snd_intel_dspcfg snd_usb_=
audio mac80211 snd_intel_sdw_acpi kvm amdxcp snd_usbmidi_lib snd_hda_codec =
btusb gpu_sched snd_ump i2c_algo_bit btrtl drm_suballoc_helper snd_rawmidi =
drm_ttm_helper snd_hda_core snd_seq_device btintel ttm mc snd_hwdep btbcm b=
tmtk drm_exec libarc4 i2c_piix4 ice drm_display_helper snd_pcm thunderbolt =
rapl pcspkr wmi_bmof k10temp i2c_smbus cec bluetooth snd_timer drm_buddy r8=
169 cfg80211 snd gnss soundcore libie realtek rfkill joydev gpio_amdpt gpio=
_generic acpi_pad ip6t_REJECT nf_reject_ipv6 xt_hl ip6t_rt ipt_REJECT
Apr 30 03:08:44 tibia kernel:  nf_reject_ipv4 xt_limit xt_addrtype xt_connt=
rack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables =
iptable_filter ip_tables fuse loop nfnetlink crct10dif_pclmul crc32_pclmul =
crc32c_intel nvme polyval_clmulni polyval_generic ghash_clmulni_intel sha51=
2_ssse3 sha256_ssse3 sha1_ssse3 sp5100_tco nvme_core nvme_auth video wmi lm=
92
Apr 30 03:08:44 tibia kernel: CPU: 9 UID: 1000 PID: 533454 Comm: device pol=
l Not tainted 6.12.21-gentoo-dist #1
Apr 30 03:08:44 tibia kernel: Hardware name: ASRock X870E Taichi Lite/X870E=
 Taichi Lite, BIOS 3.20 02/21/2025
Apr 30 03:08:44 tibia kernel: RIP: 0010:pci_mmcfg_read+0xa4/0xe0
Apr 30 03:08:44 tibia kernel: Code: fe 01 75 0b 4c 01 e0 8a 00 0f b6 c0 89 =
45 00 e8 f2 ee f9 fe 31 c0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 4c =
01 e0 8b 00 <89> 45 00 eb e0 4c 01 e0 66 8b 00 0f b7 c0 89 45 00 eb d2 e8 c=
4 ee
Apr 30 03:08:44 tibia kernel: RSP: 0018:ffffb933e32eb620 EFLAGS: 00000286
Apr 30 03:08:44 tibia kernel: RAX: 00000000ffffffff RBX: 0000000001900000 R=
CX: 0000000000000ffc
Apr 30 03:08:44 tibia kernel: RDX: 00000000000000ff RSI: 0000000000000019 R=
DI: 0000000000000000
Apr 30 03:08:44 tibia kernel: RBP: ffffb933e32eb65c R08: 0000000000000004 R=
09: ffffb933e32eb65c
Apr 30 03:08:44 tibia kernel: R10: 0000000000000019 R11: ffffffff9e231d60 R=
12: 0000000000000ffc
Apr 30 03:08:44 tibia kernel: R13: 0000000000000000 R14: 0000000000000004 R=
15: 0000000000000000
Apr 30 03:08:44 tibia kernel: FS:  00007fcda051e6c0(0000) GS:ffff8b60bdc800=
00(0000) knlGS:0000000000000000
Apr 30 03:08:44 tibia kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
Apr 30 03:08:44 tibia kernel: CR2: 00007faa4f42c000 CR3: 00000003cb1b6000 C=
R4: 0000000000f50ef0
Apr 30 03:08:44 tibia kernel: PKRU: 55555554
Apr 30 03:08:44 tibia kernel: Call Trace:
Apr 30 03:08:44 tibia kernel:  <IRQ>
Apr 30 03:08:44 tibia kernel:  ? watchdog_timer_fn.cold+0x233/0x311
Apr 30 03:08:44 tibia kernel:  ? __pfx_watchdog_timer_fn+0x10/0x10
Apr 30 03:08:44 tibia kernel:  ? __hrtimer_run_queues+0x113/0x280
Apr 30 03:08:44 tibia kernel:  ? hrtimer_interrupt+0xfa/0x210
Apr 30 03:08:44 tibia kernel:  ? __sysvec_apic_timer_interrupt+0x52/0x100
Apr 30 03:08:44 tibia kernel:  ? sysvec_apic_timer_interrupt+0x6c/0x90
Apr 30 03:08:44 tibia kernel:  </IRQ>
Apr 30 03:08:44 tibia kernel:  <TASK>
Apr 30 03:08:44 tibia kernel:  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
Apr 30 03:08:44 tibia kernel:  ? __pfx_pci_mmcfg_read+0x10/0x10
Apr 30 03:08:44 tibia kernel:  ? pci_mmcfg_read+0xa4/0xe0
Apr 30 03:08:44 tibia kernel:  pci_bus_read_config_dword+0x4a/0x80
Apr 30 03:08:44 tibia kernel:  pci_find_next_ext_capability+0x89/0xf0
Apr 30 03:08:44 tibia kernel:  ? _raw_spin_unlock_irqrestore+0x1d/0x40
Apr 30 03:08:44 tibia kernel:  pci_restore_ltr_state+0x28/0x50
Apr 30 03:08:44 tibia kernel:  pci_restore_state.part.0+0x29/0x370
Apr 30 03:08:44 tibia kernel:  ? pci_bus_read_config_word+0x4a/0x90
Apr 30 03:08:44 tibia kernel:  pci_pm_runtime_resume+0x45/0xf0
Apr 30 03:08:44 tibia kernel:  ? __pfx_pci_pm_runtime_resume+0x10/0x10
Apr 30 03:08:44 tibia kernel:  __rpm_callback+0x41/0x170
Apr 30 03:08:44 tibia kernel:  ? __pfx_pci_pm_runtime_resume+0x10/0x10
Apr 30 03:08:44 tibia kernel:  rpm_callback+0x55/0x60
Apr 30 03:08:44 tibia kernel:  ? __pfx_pci_pm_runtime_resume+0x10/0x10
Apr 30 03:08:44 tibia kernel:  rpm_resume+0x4d3/0x700
Apr 30 03:08:44 tibia kernel:  ? check_preempt_wakeup_fair+0x1f3/0x280
Apr 30 03:08:44 tibia kernel:  rpm_resume+0x2d3/0x700
Apr 30 03:08:44 tibia kernel:  rpm_resume+0x2d3/0x700
Apr 30 03:08:44 tibia kernel:  ? kick_pool+0x60/0x160
Apr 30 03:08:44 tibia kernel:  rpm_resume+0x2d3/0x700
Apr 30 03:08:44 tibia kernel:  ? klist_put+0x1f/0xb0
Apr 30 03:08:44 tibia kernel:  __pm_runtime_resume+0x4b/0x80
Apr 30 03:08:44 tibia kernel:  usb_autoresume_device+0x1e/0x50
Apr 30 03:08:44 tibia kernel:  usbdev_open+0x133/0x2b0
Apr 30 03:08:44 tibia kernel:  ? __cgroup_bpf_check_dev_permission+0x10c/0x=
190
Apr 30 03:08:44 tibia kernel:  chrdev_open+0xb2/0x230
Apr 30 03:08:44 tibia kernel:  ? __pfx_chrdev_open+0x10/0x10
Apr 30 03:08:44 tibia kernel:  do_dentry_open+0x14c/0x4a0
Apr 30 03:08:44 tibia kernel:  vfs_open+0x2e/0xe0
Apr 30 03:08:44 tibia kernel:  path_openat+0x82e/0x12d0
Apr 30 03:08:44 tibia kernel:  do_filp_open+0xc4/0x170
Apr 30 03:08:44 tibia kernel:  do_sys_openat2+0xae/0xe0
Apr 30 03:08:44 tibia kernel:  __x64_sys_openat+0x55/0xa0
Apr 30 03:08:44 tibia kernel:  do_syscall_64+0x82/0x190
Apr 30 03:08:44 tibia kernel:  ? inode_update_timestamps+0x15c/0x190
Apr 30 03:08:44 tibia kernel:  ? generic_update_time+0x4e/0x60
Apr 30 03:08:44 tibia kernel:  ? touch_atime+0xb5/0x120
Apr 30 03:08:44 tibia kernel:  ? iterate_dir+0x182/0x200
Apr 30 03:08:44 tibia kernel:  ? __x64_sys_getdents64+0x108/0x130
Apr 30 03:08:44 tibia kernel:  ? __pfx_filldir64+0x10/0x10
Apr 30 03:08:44 tibia kernel:  ? syscall_exit_to_user_mode+0x10/0x200
Apr 30 03:08:44 tibia kernel:  ? do_syscall_64+0x8e/0x190
Apr 30 03:08:44 tibia kernel:  ? syscall_exit_to_user_mode+0x10/0x200
Apr 30 03:08:44 tibia kernel:  ? do_syscall_64+0x8e/0x190
Apr 30 03:08:44 tibia kernel:  ? __x64_sys_getdents64+0x108/0x130
Apr 30 03:08:44 tibia kernel:  ? __pfx_filldir64+0x10/0x10
Apr 30 03:08:44 tibia kernel:  ? syscall_exit_to_user_mode+0x10/0x200
Apr 30 03:08:44 tibia kernel:  ? do_syscall_64+0x8e/0x190
Apr 30 03:08:44 tibia kernel:  ? do_syscall_64+0x8e/0x190
Apr 30 03:08:44 tibia kernel:  ? do_syscall_64+0x8e/0x190
Apr 30 03:08:44 tibia kernel:  ? syscall_exit_to_user_mode+0x10/0x200
Apr 30 03:08:44 tibia kernel:  ? do_syscall_64+0x8e/0x190
Apr 30 03:08:44 tibia kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Apr 30 03:08:44 tibia kernel: RIP: 0033:0x7fcda111edb0
Apr 30 03:08:44 tibia kernel: Code: 48 89 44 24 20 75 92 44 89 54 24 0c e8 =
b9 89 f9 ff 44 8b 54 24 0c 89 da 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 =
00 00 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 89 44 24 0c e8 0c 8a f9 ff 8=
b 44
Apr 30 03:08:44 tibia kernel: RSP: 002b:00007fcda051c930 EFLAGS: 00000293 O=
RIG_RAX: 0000000000000101
Apr 30 03:08:44 tibia kernel: RAX: ffffffffffffffda RBX: 0000000000080000 R=
CX: 00007fcda111edb0
Apr 30 03:08:44 tibia kernel: RDX: 0000000000080000 RSI: 00007fcd98011520 R=
DI: 00000000ffffff9c
Apr 30 03:08:44 tibia kernel: RBP: 00007fcd98011520 R08: 0000000000000000 R=
09: 0000000000000000
Apr 30 03:08:44 tibia kernel: R10: 0000000000000000 R11: 0000000000000293 R=
12: 00007fcda051c9d0
Apr 30 03:08:44 tibia kernel: R13: 00005645b88bb1c0 R14: 00007fcd980124b0 R=
15: 0000000000000014
Apr 30 03:08:44 tibia kernel:  </TASK>

(full log is at
<https://gist.github.com/gamozolabs/97e0dc50009022d3fe0c0895cc4f6e60>).

These reports were against 6.12.x but I didn't see any later changes
that are obviously related to an issue like this.

On both systems the device stuck in D3cold is the upstream port of an
ASMedia ASM4242 (PCI ID 1b21:2421) and the root complex is an AMD
Raphael/Granite Ridge.  So my guess is that there is some problem
specific to the interaction between these 2, but perhaps not.

The full kernel logs also show I/O timeouts on several other devices at
around the same time, which I assume are connected somehow.

Ben.

--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS
teams

--=-++4+ciE3/D2PlbGb8JVA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmhv318ACgkQ57/I7JWG
EQmN4Q/+MTnhJdbZQ3XTvBKFr4esdYAbv+fmOYkTPt5duHbCaIJZ2cA6XE99XYAD
n+j+Q3yQGQWGNmQSxtRtc4xPhOMhJdx/CpGt1ResUPVBgV/YGfHLQA+Lc5gzVV6n
45tjP9eCYOQiHge35angY+96YNeebpDeNTSdwex0pA/EE4hK38HWPMNBUF4SFJLs
A6aopaZTa+spa/SUOa0w8omAORf2znxXJeVKGM1r+VI5M4hGcQ6AJ8xGnN6sq58z
5KS2lY2dru5H/6+rhu3ppFvg4FcqshD1Ki5p9k/da5TV12VYQprslfHNa1VW0A9j
rOpsKp497ctb33DEm8b//RFn3odeREOGCL4iin+d43lJ5i4bqNnz7MVwRsZPZMhh
CojaB4vBhI/Zc/eJnHoPr+Tknr5kmWtgOaTqUrAsOKugWLukaCfJBXBSjrdywvX2
HPyPymY4Nt0ueSJfjtuCbJJ2FWujfXCVezdvRNIeS1tXeri6xQAS6JJ4a4eeb6vm
tj9Zk5aS/QXFnPMr6RcmMdkQPUba4/I+lzIBcfcOKo0LFgNQR1Gd21m9shDau7KK
OjmQ4XUmQRhLJ7Ehqn4dMSGLmwXOi+w1/9Yqi1FCfwsMTbrPHt0blry7vVpvtTZg
hqGq7/DPDmay/x7mgpHseHjaBpo4Jo+YKU+BANs4X0towVrCSwU=
=nBen
-----END PGP SIGNATURE-----

--=-++4+ciE3/D2PlbGb8JVA--

