Return-Path: <linux-pci+bounces-38029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB30BD8B67
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 12:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29DEC4E4EBD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 10:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF002F0C48;
	Tue, 14 Oct 2025 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="tVK7s2Ic";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="LIerhxD4"
X-Original-To: linux-pci@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E152EC0B2;
	Tue, 14 Oct 2025 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437113; cv=fail; b=DI428N52SXG9zaXE5voRfBZZQURR4gkFTsvCvw4021ymirWPlPdHQnyeS6PmmpMZPqOsYGetipcSq/zkwzdtv6D9pDrbkIEHUpMbMJYfpld3ta/fWw4RTI6t4/QVaM3/oBin5BVoXtIOQL6ncgolwM8QleTkz2uomYDJ0ijIn6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437113; c=relaxed/simple;
	bh=mnk2Tp4BqBjzOf+Sk6D0bwEHtz+eplJR5KzvV6YMaCY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YXi6yFTUiTPd3a1qprGEhHI1V6D6ZPp6dGnjQ4icoN1tDQsIh8+frvwivnvIab6lv1hSIMMi/UERJ+9VLG1kMNz6iE0wuxtXBo06bjalMynBosuvkQi8kqyIf+pz9XHNQBo4sgxB0n7QDqBMl6LJvX1Jqu7s8zYNJ45dnNPQMjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=tVK7s2Ic; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=LIerhxD4; arc=fail smtp.client-ip=72.84.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sapience.com
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.sapience.com (srv8.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id BC0BC480A02;
	Tue, 14 Oct 2025 06:18:29 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1760437109;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=fP2AapzH0P5GM+gmZrivACasOzhAfhhFaaQEi0zlJ5s=;
 b=tVK7s2IcaXaRDIWeAu35hn0roBePdKh65fnWQz1zOp2UdusAkSYAdbtwtG+v6yicHiJVu
 EoqJvMFhj64Dw9ZDg==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1760437109;
	cv=none; b=BtN3+NiPlJacmV56GGpzf12DJ+m/cwBFjsgSQqYCF58E+ivEG9l8BKnQ752WFT93Vn5bwD2n0I/qzBJU8Qy8UtO8bEqTsHxXBenVJXkjAj7BEWYGl0MqnAUOewuRx0tDjlKFq5XxRnmzp2f9HCUCdWAl0uyhNrKyQka9Sy3UUvV5E4mml0Cj9gT04D00ICRSttt6Hn7/2fMczbxC2C70Adpnc5iJT5Hko1JZKd1IPTzyxZNrRj9YFU2/4t2cDvGT4h1YGx5UwVBaBZeJXr5G6jKNWF4KFiowvpfnzUieDZk1skA2PDtJ2oUeI+RWawfpd0MOP8MyqndBVOnLbFpAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1760437109; c=relaxed/simple;
	bh=mnk2Tp4BqBjzOf+Sk6D0bwEHtz+eplJR5KzvV6YMaCY=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=UqanI4lIHEbfZRaCAtCv7qvzXH2ERepnNl5Kdv2bSfHfzy/5NtsdofsF8hsgIbo9qsI1MHuQ5fKpO8i2l2e2vbx8h8tH2ZMYmgKL23WD2j6YxEzk6pwVAwuRhpP++cFyltSUQlx+myuR3pQtlLYQf4OKjm2NUWAyRa/7rO3pR8/PSP27h0GiDopQftZs4EYm+j/RoEcTcpjZM+HUaPBGFLmBJ23gFZ2tEuuLMsMFUkjC6DZXLeiIABRyBlAuOFMNchdjX38MYIdMDJFPwK87J12P/tBKrhMSxVEJ6Yip6+dbrwxEGTtOzJFoJm8RnzGO4Z8uh1MNd+8tKSDaelBoSQ==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1760437109;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=fP2AapzH0P5GM+gmZrivACasOzhAfhhFaaQEi0zlJ5s=;
 b=LIerhxD4YIoXWA3FJUBcDvr2DQWmp5D+JzPNJmjtPXQP1UnZ7Cic4x9wiofZ7IY826l9/
 7ZUwthBjm5HvjrGaHF2VG+cxesh6Qrd8F7aHQ4WgCLOPIQbHuW/7zPR1XNS0kzlDOwjsidJ
 mz11v2wXbzDE7GweHYarHflE6FlAIgKh7QqCFcRg8lMlyuvw65sTOa7ngrp8FKmYRMgV/Hv
 Y62mCA27aFLJ+eQBh49VbhrD4N0yiRPaVt3aaF7aH0mBb23nJlPF6d5pmCMTtOuOlTH24Xk
 XygZj26tYYx4dZbYyUCbMijx/DSroPLiSpUmfbDKKPHY1JLPn1D0F/7mW84Q==
Received: by srv8.prv.sapience.com (Postfix) id 91E5428001B;
	Tue, 14 Oct 2025 06:18:29 -0400 (EDT)
Message-ID: <b30331816621cc1f6a154233482f01798cf57cea.camel@sapience.com>
Subject: Re: mainline boot fail nvme/block? [BISECTED]
From: Genes Lists <lists@sapience.com>
To: Inochi Amaoto <inochiama@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Date: Tue, 14 Oct 2025 06:18:28 -0400
In-Reply-To: <xfzcvv6ezleds24wvha2apkz5kirhcmoydm3on2hnfrxcwuc3g@koj6plovnvbd>
References: <4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com>
	 <cf4e88c6-0319-4084-8311-a7ca28a78c81@kernel.dk>
	 <3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com>
	 <trdjd7zhpldyeurmpvx4zpgjoz7hmf3ugayybz4gagu2iue56c@zswmzvauqnxk>
	 <622d6d7401b5cfd4bd5f359c7d7dc5b3bf8785d5.camel@sapience.com>
	 <xfzcvv6ezleds24wvha2apkz5kirhcmoydm3on2hnfrxcwuc3g@koj6plovnvbd>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-WzP+G+VsL1ZgoEfePPDq"
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-WzP+G+VsL1ZgoEfePPDq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-10-14 at 08:54 +0800, Inochi Amaoto wrote:
> On Mon, Oct 13, 2025 at 07:45:05AM -0400, Genes Lists wrote:
> >=20
...

> > Thank you Inochi
> >=20
> > I tried this patch over 6.18-rc1.
> >=20
> > =C2=A0It get's further than without the patch but around the time I get
> > prompted for passphrase for the luks partition
> > (root is not encrypted) it crashes.=C2=A0
> >=20
> > I have uploaded 2 images I took of the screen when this happens and
> > uploaded them to here:
> >=20
> > =C2=A0 =C2=A0=C2=A0https://0x0.st/KSNz.jpg
> > =C2=A0 =C2=A0=C2=A0https://0x0.st/KSNi.jpg
> >=20
>=20
> This picture is only a WARNING from perf_get_x86_pmu_capability,
> and no other information. So I am not sure whether it is caused
> by this change. But from the original report I have, it solves
> the problem at that time.
>=20
> By the way, can you test the following change?
> https://lore.kernel.org/all/2hyxqqdootjw5yepbimacuuapfsf26c5mmu5w2jsd
> mamxvsjdq@gnibocldkuz5/
>=20
> If it is OK, I will send a patch for it.
>=20
> Regards,
> Inochi


With this patch it boots with the same/similar warning as before, which
I will include below since it's text instead of image.

Tested-by: Gene C <gene@sapience.com>

Thank you

gene

Warning from 6.18-rc1 with above patch:


[  +0.003929] ------------[ cut here ]------------
[  +0.000004] WARNING: CPU: 7 PID: 584 at arch/x86/events/core.c:3089
perf_get_x86_pmu_capability+0x11/0xb0
[  +0.000010] Modules linked in: snd_hda_codec sr_mod(+) iwlmvm(+)
kvm_intel(+) dm_crypt cdrom encrypted_keys snd_>
[  +0.000060]  industrialio mei_me processor_thermal_wt_req i2c_smbus
spi_intel_pci intel_ipu6 soundcore processor>
[  +0.000058]  ghash_clmulni_intel aesni_intel video intel_ish_ipc
drm_display_helper intel_lpss_pci thunderbolt i>
[  +0.000025] CPU: 7 UID: 0 PID: 584 Comm: (udev-worker) Not tainted
6.18.0-rc1-test-1-00002-ge9cc50c96bb9 #2 PREE>
[  +0.000005] Hardware name: Dell Inc. XPS 9320/0CR6NC, BIOS 2.23.0
07/03/2025
[  +0.000002] RIP: 0010:perf_get_x86_pmu_capability+0x11/0xb0
[  +0.000004] Code: eb 9c e8 22 38 f8 00 66 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 4>
[  +0.000002] RSP: 0018:ffffd1e041edba58 EFLAGS: 00010202
[  +0.000003] RAX: 0000000000000000 RBX: ffffffffc206f000 RCX:
00000000c0000080
[  +0.000003] RDX: ffffffffc1e396e0 RSI: ffffffffc1e39408 RDI:
ffffffffc1e396e0
[  +0.000001] RBP: 0000000000000001 R08: 0000000000000000 R09:
ffffffffb0e763fb
[  +0.000002] R10: ffff8d0fdad72460 R11: ffff8d0fc0042600 R12:
0000000000000000
[  +0.000001] R13: ffffffffc17e4ca0 R14: 000071be141fd2f2 R15:
0000000000000000
[  +0.000002] FS:  000071be140c6880(0000) GS:ffff8d177bf79000(0000)
knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000002] CR2: 00007d5cd598b808 CR3: 0000000109583004 CR4:
0000000000f70ef0
[  +0.000002] PKRU: 55555554
[  +0.000001] Call Trace:
[  +0.000003]  <TASK>
[  +0.000002]  kvm_init_pmu_capability+0x27/0x130 [kvm
83ffe9a0591f43a0ce126662332dfe4cf2561fa4]
[  +0.000119]  kvm_x86_vendor_init+0x1de/0x19d0 [kvm
83ffe9a0591f43a0ce126662332dfe4cf2561fa4]
[  +0.000085]  ? __pfx_vt_init+0x10/0x10 [kvm_intel
5fa84b05f575edf3826c8f8519ca550622307061]
[  +0.000023]  vmx_init+0xf6/0x170 [kvm_intel
5fa84b05f575edf3826c8f8519ca550622307061]
[  +0.000015]  vt_init+0xf/0x360 [kvm_intel
5fa84b05f575edf3826c8f8519ca550622307061]
[  +0.000012]  do_one_initcall+0x5b/0x300
[  +0.000009]  do_init_module+0x62/0x250
[  +0.000005]  ? init_module_from_file+0x8a/0xe0
[  +0.000004]  init_module_from_file+0x8a/0xe0
[  +0.000006]  idempotent_init_module+0x114/0x310
[  +0.000005]  __x64_sys_finit_module+0x6d/0xd0
[  +0.000004]  ? syscall_trace_enter+0x8d/0x1d0
[  +0.000003]  do_syscall_64+0x81/0x7f0
[  +0.000005]  ? __wait_for_common+0x162/0x190
[  +0.000005]  ? __pfx_schedule_timeout+0x10/0x10
[  +0.000004]  ? __rseq_handle_notify_resume+0xa6/0x490
[  +0.000005]  ? idempotent_init_module+0x1df/0x310
[  +0.000005]  ? switch_fpu_return+0x4e/0xd0
[  +0.000003]  ? do_syscall_64+0x226/0x7f0
[  +0.000003]  ? do_syscall_64+0x226/0x7f0
[  +0.000003]  ? do_user_addr_fault+0x21a/0x690
[  +0.000006]  ? exc_page_fault+0x7e/0x1a0
[  +0.000013] Bluetooth: hci0: Firmware SHA1: 0x937bca4a
[  +0.003913] Bluetooth: hci0: Fseq status: Success (0x00)
[  +0.000011] Bluetooth: hci0: Fseq executed: 00.00.02.41
[  +0.000004] Bluetooth: hci0: Fseq BT Top: 00.00.02.41
[  +8.297442] Key type trusted registered
[  +0.014388] Key type encrypted registered
[  +0.017993] sr 0:0:0:0: Power-on or device reset occurred
[  +0.005943] sr 0:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram
cd/rw xa/form2 cdda tray
[  +0.000005] cdrom: Uniform CD-ROM driver Revision: 3.20
[  +0.003929] ------------[ cut here ]------------
[  +0.000004] WARNING: CPU: 7 PID: 584 at arch/x86/events/core.c:3089
perf_get_x86_pmu_capability+0x11/0xb0
[  +0.000010] Modules linked in: snd_hda_codec sr_mod(+) iwlmvm(+)
kvm_intel(+) dm_crypt cdrom encrypted_keys snd_>
[  +0.000060]  industrialio mei_me processor_thermal_wt_req i2c_smbus
spi_intel_pci intel_ipu6 soundcore processor>
[  +0.000058]  ghash_clmulni_intel aesni_intel video intel_ish_ipc
drm_display_helper intel_lpss_pci thunderbolt i>
[  +0.000025] CPU: 7 UID: 0 PID: 584 Comm: (udev-worker) Not tainted
6.18.0-rc1-test-1-00002-ge9cc50c96bb9 #2 PREE>
[  +0.000005] Hardware name: Dell Inc. XPS 9320/0CR6NC, BIOS 2.23.0
07/03/2025
[  +0.000002] RIP: 0010:perf_get_x86_pmu_capability+0x11/0xb0
[  +0.000004] Code: eb 9c e8 22 38 f8 00 66 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 4>
[  +0.000002] RSP: 0018:ffffd1e041edba58 EFLAGS: 00010202
[  +0.000003] RAX: 0000000000000000 RBX: ffffffffc206f000 RCX:
00000000c0000080
[  +0.000003] RDX: ffffffffc1e396e0 RSI: ffffffffc1e39408 RDI:
ffffffffc1e396e0
[  +0.000001] RBP: 0000000000000001 R08: 0000000000000000 R09:
ffffffffb0e763fb
[  +0.000002] R10: ffff8d0fdad72460 R11: ffff8d0fc0042600 R12:
0000000000000000
[  +0.000001] R13: ffffffffc17e4ca0 R14: 000071be141fd2f2 R15:
0000000000000000
[  +0.000002] FS:  000071be140c6880(0000) GS:ffff8d177bf79000(0000)
knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000002] CR2: 00007d5cd598b808 CR3: 0000000109583004 CR4:
0000000000f70ef0
[  +0.000002] PKRU: 55555554
[  +0.000001] Call Trace:
[  +0.000003]  <TASK>
[  +0.000002]  kvm_init_pmu_capability+0x27/0x130 [kvm
83ffe9a0591f43a0ce126662332dfe4cf2561fa4]
[  +0.000119]  kvm_x86_vendor_init+0x1de/0x19d0 [kvm
83ffe9a0591f43a0ce126662332dfe4cf2561fa4]
[  +0.000085]  ? __pfx_vt_init+0x10/0x10 [kvm_intel
5fa84b05f575edf3826c8f8519ca550622307061]
[  +0.000023]  vmx_init+0xf6/0x170 [kvm_intel
5fa84b05f575edf3826c8f8519ca550622307061]
[  +0.000015]  vt_init+0xf/0x360 [kvm_intel
5fa84b05f575edf3826c8f8519ca550622307061]
[  +0.000012]  do_one_initcall+0x5b/0x300
[  +0.000009]  do_init_module+0x62/0x250
[  +0.000005]  ? init_module_from_file+0x8a/0xe0
[  +0.000004]  init_module_from_file+0x8a/0xe0
[  +0.000006]  idempotent_init_module+0x114/0x310
[  +0.000005]  __x64_sys_finit_module+0x6d/0xd0
[  +0.000004]  ? syscall_trace_enter+0x8d/0x1d0
[  +0.000003]  do_syscall_64+0x81/0x7f0
[  +0.000005]  ? __wait_for_common+0x162/0x190
[  +0.000005]  ? __pfx_schedule_timeout+0x10/0x10
[  +0.000004]  ? __rseq_handle_notify_resume+0xa6/0x490
[  +0.000005]  ? idempotent_init_module+0x1df/0x310
[  +0.000005]  ? switch_fpu_return+0x4e/0xd0
[  +0.000003]  ? do_syscall_64+0x226/0x7f0
[  +0.000003]  ? do_syscall_64+0x226/0x7f0
[  +0.000003]  ? do_user_addr_fault+0x21a/0x690
[  +0.000006]  ? exc_page_fault+0x7e/0x1a0
[  +0.000004]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000003] RIP: 0033:0x71be1391876d
[  +0.000045] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c>
[  +0.000002] RSP: 002b:00007ffdfcc7da58 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[  +0.000004] RAX: ffffffffffffffda RBX: 000064e3aeb57f80 RCX:
000071be1391876d
[  +0.000001] RDX: 0000000000000004 RSI: 000071be141fd2f2 RDI:
0000000000000032
[  +0.000002] RBP: 00007ffdfcc7daf0 R08: 0000000000000000 R09:
000064e3aeb528f0
[  +0.000001] R10: 0000000000000000 R11: 0000000000000246 R12:
000071be141fd2f2
[  +0.000001] R13: 0000000000020000 R14: 000064e3aeb507f0 R15:
000064e3aeb57f80
[  +0.000003]  </TASK>
[  +0.000001] ---[ end trace 0000000000000000 ]---



--=20
Gene

--=-WzP+G+VsL1ZgoEfePPDq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCaO4jdAAKCRA5BdB0L6Ze
244RAQDk1/zoqO5wjghvcV/PzFr1pEfVFIEW5Kjc7eP+weAG3gD/ZhNV4oGBjWc0
BxKw9gsEg3neYfcTDB9Bag9mtmFtJAQ=
=xG1/
-----END PGP SIGNATURE-----

--=-WzP+G+VsL1ZgoEfePPDq--

