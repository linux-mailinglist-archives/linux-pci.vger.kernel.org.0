Return-Path: <linux-pci+bounces-43130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34580CC3832
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 15:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 746993085473
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 14:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A483121E0AD;
	Tue, 16 Dec 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsxRCFcf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F21D63D8
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894458; cv=none; b=Jybf7UyBMR2FX4engI89WFwDypzqoF4XoqJCrelAYBx4eDyXuJO27B2vRXlbgODzMvmyDfyvIUhCGa6sRVzLU3PALLsac9wldGwrPRBags2u59/MaGh8qG0kwa3fbL0yOhQktwoBcgOK7Rbu3M52cL7w3d2x2HJ03LARox70XE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894458; c=relaxed/simple;
	bh=qZcoy6RHq5yYYWWcBEsb7bPSvEsJuruvZJ9l+36vNvk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YNZlBmQO//XWlK2FsJpAkK99fSkSe/FZ6apd0YoCLKEQe6jX4lxX9isMHSIqBeGb/cOzQ4krY/0KyZfpGuTJQBHd0mHcKU3OFqG4bpPVRjeXVWNzbiHFlDGbUbgoRJ5nqiUXZii5j5XLO0B6Lx71QKPo9ABv5DW14SM6rmVhLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsxRCFcf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765894457; x=1797430457;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qZcoy6RHq5yYYWWcBEsb7bPSvEsJuruvZJ9l+36vNvk=;
  b=jsxRCFcfOkZPDQrLq/2I00SRFp6u3CX1rZsJpFpTGcRfpWrd7/2BRBJm
   XDAUHnjWLJE/fZ5RXAC+gp3e+Vjl4lR1hcW6D0xBNeHz97z6UFT2FYhJc
   vViGLLe0KWu2PL5pHbVlqrWQqKDsY7ZLnsL2Cw5TcoEDzD/RIkE7pxgV3
   SGn6Fh/xzgcT+4n2r8+d/SgURm8ybCCOoJlIarurbEgCD0IpS/hoLXDsS
   /e7TwpIa8XcdyzVvyVRdohVAR9+gMdzfWmUFYaQBU/RJoXIhIm1SaK6mh
   ZkOixrH+8RKMqLzx7B76/OijyLFH1pg97ecxMh4EEe1Rq3H0PMeHnV+OO
   g==;
X-CSE-ConnectionGUID: +nOf1taoTZWsXiTQ8Q3quA==
X-CSE-MsgGUID: tnPgNLFSQumzhd6lLdn/fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="67850478"
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; 
   d="scan'208";a="67850478"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 06:14:16 -0800
X-CSE-ConnectionGUID: ViXWK/WET5GdQeUQT7USeA==
X-CSE-MsgGUID: EGX+zKe4TMCioGLEUqWKCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; 
   d="scan'208";a="197919761"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.4])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 06:14:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Dec 2025 16:14:10 +0200 (EET)
To: Adam Stylinski <kungfujesus06@gmail.com>
cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: Kernel regression in 6.13
In-Reply-To: <aUFlNgmLA5sI0FaJ@eggsbenedict>
Message-ID: <3c61a43d-2a2f-0cd7-eafc-e34fb36f2274@linux.intel.com>
References: <aUCt1tHhm_-XIVvi@eggsbenedict> <09dc94cd-6247-231a-7bcc-27aaeb3b5176@linux.intel.com> <aUFlNgmLA5sI0FaJ@eggsbenedict>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2127776925-1765894450=:1169"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2127776925-1765894450=:1169
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 16 Dec 2025, Adam Stylinski wrote:

> On Tue, Dec 16, 2025 at 11:49:45AM +0200, Ilpo J=E4rvinen wrote:
> > On Mon, 15 Dec 2025, Adam Stylinski wrote:
> >=20
> > > Hello,
> > >=20
> > > I seem to be encountering a regression that prevents my system from=
=20
> > > booting.  The regression occurred between 6.12 and 6.13.  I've bisect=
ed=20
> > > it to this commit:
> > > 665745f274870c921020f610e2c99a3b1613519b
> > >=20
> > > Some info about this system: it's ancient. It's a Q9650 that I used a=
s a=20
> > > mythbackend/frontend for over a decade. This booting failure on newer=
=20
> > > kernels finally forced my hand to buy new a "new" PCI Express based=
=20
> > > tuner and upgrade the system into the modern age. It boots via MBR on=
 a=20
> > > P45 based chipset (A P5Q Plus board, to be precise).  Given the age, =
I=20
> > > chalked the issue up to possibly some failing hardware or memory=20
> > > corruption that happened at compile time. I recently pulled the syste=
m=20
> > > back out again to do some performance testing in zlib-ng only to find=
=20
> > > out it hangs on the latest Ubuntu server ISO. I figured at this point=
 it=20
> > > wasn't something specific to my kernel config / compilation and it's=
=20
> > > likely a regression. It's also old enough that I may be in the positi=
on=20
> > > of the only one having this problem, so I took it upon myself to bise=
ct=20
> > > what was going on. Let me know if there's anything you'd like me to t=
est=20
> > > or try.
> >=20
> > Hi,
> >=20
> > Thanks for the report.
> >=20
> > In pcie_bwnotif_enable() there's pcie_capability_set_word() that enable=
s
> > bandwidth notifications:
> >=20
> > =09        pcie_capability_set_word(port, PCI_EXP_LNKCTL,
> >                                  PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_=
LABIE);
> >=20
> > So as the first step change those PCI_EXP_LNKCTL_LBMIE |=20
> > PCI_EXP_LNKCTL_LABIE into 0 to see if not enabling the bandwitdh=20
> > notification allows the system to come up.
> >=20
> > I suggest not trying this directly at the top of 665745f27487=20
> > ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")=20
> > but on a kernel that is expected to have fixes since 665745f27487=20
> > including those made to the other PCIe service drivers that share=20
> > interrupt handler with bwctrl (so basically some stable version).
> >=20
> > If that works try to enable those bits one at a time.
> >=20
> > Please also send lspci -vvv.
> >=20
> > --=20
> >  i.
> >=20
>=20
> I'll try changing those values atop of the 6.18 tagged commit and let you=
 know how it goes.  Thanks for looking into this.
> The privileged lspci -vv output is below:
>=20
> 00:00.0 Host bridge: Intel Corporation 4 Series Chipset DRAM Controller (=
rev 03)
> =09Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
> =09Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
> =09Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort+ >SERR- <PERR- INTx-
> =09Latency: 0
> =09Capabilities: [e0] Vendor Specific Information: Intel <unknown>
>=20
> 00:01.0 PCI bridge: Intel Corporation 4 Series Chipset PCI Express Root P=
ort (rev 03) (prog-if 00 [Normal decode])
> =09Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
> =09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx+
> =09Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR- INTx-
> =09Latency: 0, Cache Line Size: 32 bytes
> =09Interrupt: pin A routed to IRQ 24
> =09Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
> =09I/O behind bridge: c000-cfff [size=3D4K] [16-bit]
> =09Memory behind bridge: fd000000-fe9fffff [size=3D26M] [32-bit]
> =09Prefetchable memory behind bridge: c0000000-dfffffff [size=3D512M] [32=
-bit]
> =09Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- <SERR- <PERR-
> =09BridgeCtl: Parity- SERR+ NoISA- VGA+ VGA16+ MAbort- >Reset- FastB2B-
> =09=09PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> =09Capabilities: [88] Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherb=
oard
> =09Capabilities: [80] Power Management version 3
> =09=09Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+=
,D3cold+)
> =09=09Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> =09Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> =09=09Address: fee02000  Data: 0020
> =09Capabilities: [a0] Express (v2) Root Port (Slot+), IntMsgNum 0
> =09=09DevCap:=09MaxPayload 128 bytes, PhantFunc 0
> =09=09=09ExtTag- RBE+ TEE-IO-
> =09=09DevCtl:=09CorrErr- NonFatalErr- FatalErr- UnsupReq-
> =09=09=09RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> =09=09=09MaxPayload 128 bytes, MaxReadReq 128 bytes
> =09=09DevSta:=09CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPe=
nd-
> =09=09LnkCap:=09Port #2, Speed 5GT/s, Width x16, ASPM L0s, Exit Latency L=
0s <256ns
> =09=09=09ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
> =09=09LnkCtl:=09ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
> =09=09=09ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
> =09=09LnkSta:=09Speed 2.5GT/s, Width x16
> =09=09=09TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt+

At least this Root Port has both BWMgmt and ABWMgmt asserted (not a=20
problem in itself, necessarily).

If you get the system working by changing that set_word call, it's worth=20
to check if these got reasserted (bwctrl tries to clear them right after=20
the set word call but it could be they get reasserted).

--=20
 i.

--8323328-2127776925-1765894450=:1169--

