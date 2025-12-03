Return-Path: <linux-pci+bounces-42585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BACCA15E8
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 20:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 555D03092062
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07012641CA;
	Wed,  3 Dec 2025 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="mzN+79lK"
X-Original-To: linux-pci@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FFB26E714;
	Wed,  3 Dec 2025 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764788731; cv=none; b=fEGxTggwriLjTTdm3fXvszknPAKVPlr/Ycdm30DUhgWzVQ7fEOyanEoB2Nf4csSq5sXiwbVwGG8ziqrSH3CNSEkwwSIidHAtYN/FAns2PAHaFLGJXPaoy+9+fY+vkjcgGbIsgwvpls4+Bqe7wcTeUxtdHIEwZkUWOsDd7bUPVDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764788731; c=relaxed/simple;
	bh=30euAENYe1h/8DeOy446fbXbQy1BI6rQzD+7+HiNR54=;
	h=Date:Message-Id:To:Cc:Subject:From:Mime-Version:Content-Type; b=elP8lQmWV3XE31UwEpv6pf/GwSJsgiwrHpHcuFWvXt0wk/Qd0c7aGuEH3xSjC1P8YFrMiM6kQg/M+XEmbG6Zg/vwCrfP05mHb6wP1lE4B6ExLTQMcPzFL6fKlOLoqriiJQJ3vXLuCtsCYnMnAPTTdQa9LH07xDxEKu+W0rwXVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=mzN+79lK; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:Cc:To
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=MxzTarBwv/+LuSwL7w4S2W212MtfC33eNtTpqIkqTV8=; b=m
	zN+79lKtBlbOYW4e9C285i4KVw2Xv6uB4YRc+qGrNzzVWTc8sIz9V8nwqaHGqrz505wv5mMeEKVyN
	L7K54IEiCy8Spjh69EF/o4dkDdjB2qd/1XROMnGdBr4JAZV9DgX4WkSyRkgL3Wkc61HpLVlcQ9DjO
	sHe303XVlf0MFLPLLO6E0vnaBbiceBzK8IR6o4LXtPT9g3j72mCwy2cdufA3tlANeATBQyR5HOkln
	KRN4E3Kb4KPdpbT/8XjQ+Ir3q1I/BZa1sVDrPrSFXMbvc/JcdsL3sGhYAxsuXwugir/EwEIl6G5/F
	oNiqJIZ1FaEO9ZV1Hsv14ZFDXZVH0U4zw==;
Date: Wed, 03 Dec 2025 20:05:26 +0100 (CET)
Message-Id: <20251203.200526.1986895588669292863.rene@exactco.de>
To: linux-pci@vger.kernel.org
Cc: rafael@kernel.org, mika.westerberg@linux.intel.com, lukas@wunner.de,
 briannorris@chromium.org, helgaas@kernel.org,
 linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de,
 riccardo.mottola@libero.it, mani@kernel.org, mario.limonciello@amd.com
Subject: [PATCH V2] PCI: Fix PCI bridges not to go to D3Hot on SPARC64
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
non-x86") was bisected to break some SPARC64 systems, see two oopses
below. Fix by not allowing D3Hot on sparc64 while this is being
further analyzed.

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
Cc: stable@kernel.org
Signed-off-by: René Rebe <rene@exactco.de>
---
Tested on Sun Blade 1000 and PowerPC64 G5 w/ T2/Linux.
---
 drivers/pci/pci.c | 4 ++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..7619d2cfa66d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3033,9 +3033,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 
 		/*
 		 * Out of caution, we only allow PCIe ports from 2015 or newer
-		 * into D3 on x86.
+		 * into D3 or x86. Avoid SPARC64 for now, too.
 		 */
-		if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >= 2015)
+		if ((IS_ENABLED(CONFIG_X86) && dmi_get_bios_year() >= 2015) ||
+		    !IS_ENABLED(CONFIG_SPARC64))
 			return true;
 		break;
 	}
-- 
2.52.0

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

