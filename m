Return-Path: <linux-pci+bounces-42506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAC6C9C3E5
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 17:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5E3D4E175F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 16:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8227F28980A;
	Tue,  2 Dec 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="Qyh2Wkqr"
X-Original-To: linux-pci@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D021F03C5;
	Tue,  2 Dec 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693611; cv=none; b=HWWZrIq9v05pGMY25IdYoTaGw9nc8jEZqowMgo4jKqBAguVMUUq6J+qpjHP5FYSZ0z+OtC8HFJ9vyfPEtIKKUUhinRB4jQPQf9FUT2wwbdS5YhtVlIg60JyjXTsH3AZpL603wQJ0fzrltpgtsH0VBeLBBnM395K6Llne9sEFmKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693611; c=relaxed/simple;
	bh=7ImWrWsUTPqaaE4oIWOP/Gsu7JuANTworIz1AIVVfLM=;
	h=Date:Message-Id:Cc:To:Subject:From:Mime-Version:Content-Type; b=bEdR0uyVmaklTP5VgZsE1ZVOk87zxAgOPQ6mNKa8E5e4EYL2aPYWGTljV+//vG7QxBFVPzhgXlX5vrg3vw4eG7VuFn6w0sTLkiI+cdfhT5xwKnbKh0ZLZCgP/vaYTU1E6fUoBF089akNBeF8m/XSDbDbH6b5LdUvvIrhxb8Scns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=Qyh2Wkqr; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:To:Cc
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=U5O24SN1EST6YrllSJW7bCyK4rasEc8rrfttpt9ll5g=; b=Q
	yh2Wkqr6XxNQeOweAUMoREjBnScsr2zmxCRtqufHPqgRs5a7g1Rh4LDzTlEcbxtOnaWAkseE4lWzR
	fTiwYR970+QG4Nzwvbu42fA+GXcO3knUuMn6np7qB2BFZzyP6eUxVsbMj1Uo991PKwiBsrSwtr2Qr
	7v9rOZ8gW2lDBE3ZLnwfKJSNqL5YfLcaSe/sBH/tzbS3RWIM9RleqQxsz2kb42nhmGRb2zOC67RRX
	rub53MQ9L/7hZeJmJCpmYxIEgHyavecqUs/KnYz1ojFw9mlt0PM0bmfFnJkmhhQq6kojlSB92OdCS
	n/a1i6mHgqg7gXFMp5Tom2GHO+4fYM3tw==;
Date: Tue, 02 Dec 2025 17:40:07 +0100 (CET)
Message-Id: <20251202.174007.745614442598214100.rene@exactco.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Riccardo Mottola
 <riccardo.mottola@libero.it>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC
 systems
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Commit a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all
non-x86") was bisected to break various non-x86 RISC Unix systems,
e.g. sparc64, see two example oopses below. Fix by only allowing D3Hot
on modern ARM64, PPC64 and RISCV ISAs besides new enough x86.

Sun Blade 1000:
ERROR(0): Cheetah error trap taken afsr[0010080005000000] afar[000007f900800000] TL1(0)
ERROR(0): TPC[100a05a4] TNPC[100a05a8] O7[42acc8] TSTATE[4411001603]
ERROR(0):
TPC<MakeIocReady+0xc/0x278 [mptbase]>
ERROR(0): M_SYND(0),  E_SYND(0), Privileged
ERROR(0): Highest priority error (0000080000000000) "Bus error response from system bus"
ERROR(0): D-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000]
ERROR(0): D-cache data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
ERROR(0): I-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000] u[0000000000000000] l[0000000000000000]
ERROR(0): I-cache INSN0[0000000000000000] INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000]
ERROR(0): I-cache INSN4[0000000000000000] INSN5[0000000000000000] INSN6[0000000000000000] INSN7[0000000000000000]
ERROR(0): E-cache idx[b08040] tag[000000001e008fa0]
ERROR(0): E-cache data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] data3[ffffffffffffffff]
Kernel panic - not syncing: Irrecoverable deferred error trap.
CPU: 0 UID: 0 PID: 46 Comm: (udev-worker) Not tainted 6.14.0-rc1-00001-ga5fb3ff63287 #18
Call Trace:
[<00000000004294b0>] panic+0xf0/0x370
[<0000000000435bc4>] cheetah_deferred_handler+0x2c8/0x2d8
[<0000000000405e88>] c_deferred+0x18/0x24
[<00000000100a05a4>] MakeIocReady+0xc/0x278 [mptbase]
[<00000000100a089c>] mpt_do_ioc_recovery+0x8c/0x1054 [mptbase]
[<000000001009f2d4>] mpt_attach+0x920/0xa68 [mptbase]
[<000000001012424c>] mptsas_probe+0x8/0x3e8 [mptsas]
[<0000000000788308>] local_pci_probe+0x24/0x70
[<0000000000788dac>] pci_device_probe+0x1c0/0x1d0
[<000000000082633c>] really_probe+0x13c/0x29c
[<0000000000826590>] __driver_probe_device+0xf4/0x104
[<0000000000826614>] driver_probe_device+0x24/0xa0
[<000000000082683c>] __driver_attach+0xe8/0x104
[<0000000000824da0>] bus_for_each_dev+0x58/0x84
[<0000000000825508>] bus_add_driver+0xdc/0x1f8
[<0000000000827110>] driver_register+0x70/0x120

Niagara T1:
mptsas 0000:07:00.0: Unable to change power state from D3cold to D0, device inaccessible
NON-RESUMABLE ERROR: Reporting on cpu 31
NON-RESUMABLE ERROR: TPC [0x0000000010184034] <MakeIocReady+0x10/0x298 [mptbase]>
NON-RESUMABLE ERROR: RAW [1f10000000000007:0000000e3179235c:0000000202000004:000000ea00300000
NON-RESUMABLE ERROR: 00000000001f0000:0000000000000000:0000000000000000:0000000000000000]
NON-RESUMABLE ERROR: handle [0x1f10000000000007] stick [0x0000000e3179235c]
NON-RESUMABLE ERROR: type [precise nonresumable]
NON-RESUMABLE ERROR: attrs [0x02000004] < PIO sp-faulted priv >
NON-RESUMABLE ERROR: raddr [0x000000ea00300000]
Kernel panic - not syncing: Non-resumable error.
CPU: 31 UID: 0 PID: 367 Comm: (udev-worker) Not tainted 6.16.12+3-sparc64-smp #1 NONE  Debian 6.16.12-2+sparc64.1
Call Trace:
[<00000000004373c4>] dump_stack+0x8/0x18
[<0000000000429540>] panic+0xf4/0x398
[<000000000043afcc>] sun4v_nonresum_error+0x16c/0x240
[<0000000000406eb8>] sun4v_nonres_mondo+0xc8/0xd8
[<0000000010184034>] MakeIocReady+0x10/0x298 [mptbase]
[<00000000101844b4>] mpt_do_ioc_recovery+0x9c/0x1110 [mptbase]
[<00000000101836f8>] mpt_attach+0xb58/0xd20 [mptbase]
[<0000000010287f30>] mptsas_probe+0x10/0x440 [mptsas]
[<0000000000b3fab0>] local_pci_probe+0x30/0x80
[<0000000000b405d4>] pci_device_probe+0xb4/0x240
[<0000000000bfd348>] really_probe+0xc8/0x400
[<0000000000bfd70c>] __driver_probe_device+0x8c/0x160
[<0000000000bfd8c8>] driver_probe_device+0x28/0x100
[<0000000000bfdb7c>] __driver_attach+0xbc/0x1e0
[<0000000000bfacfc>] bus_for_each_dev+0x5c/0xc0
[<0000000000bfcafc>] driver_attach+0x1c/0x40
Press Stop-A (L1-A) from sun keyboard or send break
twice on console to return to the boot prom

Fixes: a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86")
Signed-off-by: René Rebe <rene@exactco.de>
---
Tested on Sun Blade 1000, and shipping in all T2/Linux builds since 2025-08-01
---
 drivers/pci/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..7619d2cfa66d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3033,9 +3033,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 
 		/*
 		 * Out of caution, we only allow PCIe ports from 2015 or newer
-		 * into D3 on x86.
+		 * into D3 or other modern ISAs only.
 		 */
-		if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >= 2015)
+		if (IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_PPC64) || IS_ENABLED(CONFIG_RISCV) || dmi_get_bios_year() >= 2015)
 			return true;
 		break;
 	}
-- 
2.52.0

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

