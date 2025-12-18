Return-Path: <linux-pci+bounces-43306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9214CCC1F6
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 14:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83816300BED8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153CA3451BF;
	Thu, 18 Dec 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XIbQ5ZsQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE1F332EAA
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066080; cv=none; b=IV6SgahvFIIJOAHxgeeqM7BAV3a1zbHhwDpd/WUfvln/1aP6Lu4zRtWyzCQI0oNxR9k0sNtRjnaeX+evsY4aD9qeLV/OPWv5he44JG0Ur52wKUiM8/SOwwUPRYURTqgDU4K4JuhV9p6yxYmgsSokUukQnV+09RGzGRoCJ4Y6zrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066080; c=relaxed/simple;
	bh=Dgh2zwe6hGntmCd3HwqGuHvNWUpLbcTpeoZ6zxpF4Sw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Lzy0E5krPvTJc7pxDn5THOAJ1AjvyshHQjtjMm6wiwplFp5uDdrnkAghzu7YZ9PC36Fl0l+QSnFHp5wZ322hR5C5ydzaLIu8gErLQ63kQwE4A6aX/zjQxgsH/4eicbsaWvNoL/A1ew9GTxduJbEog2HElwg2xX4N2clOLaW1Nd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XIbQ5ZsQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766066078; x=1797602078;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Dgh2zwe6hGntmCd3HwqGuHvNWUpLbcTpeoZ6zxpF4Sw=;
  b=XIbQ5ZsQijnVxed7C1/dpvOKzbvdf/erHW9TWMIcXzh5WcuUjc14tdY6
   2nITsQOr3Zfi2sf3kSJW27Upq/yY4BOkjwgKaASK913+B2R61gxgCcsFJ
   kLkAef1ORSjkHC75LQAHJtnX8LowDaN5N5noqj2SUPzRU9jteVTbyIUgM
   GU8M0u1HA/4G4GKBfWViz+yUt7QeEmNHnj9Q0TfbzPC34vhIBDa3WulBK
   0H8lDW+IAy9gFzWT4LSJOsVfssf9shj6eAq8bNxedvU6COZPkarS8deC2
   hAeHVVeYrgXzRQQm1lvA5TDneU86vzATJlhdO6CJk2v9yMlTK6I/lORYK
   Q==;
X-CSE-ConnectionGUID: /FHiTH9CRTiHdmwOJ2gJkw==
X-CSE-MsgGUID: D5ievWWqTxOSgmhyNR0GIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="68057765"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="68057765"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 05:54:37 -0800
X-CSE-ConnectionGUID: VNDLAWCBQhCstlwjZ4L5yg==
X-CSE-MsgGUID: 3oVu1CIHTCujD65wZ+N1DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="198193195"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 05:54:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Dec 2025 15:54:32 +0200 (EET)
To: Adam Stylinski <kungfujesus06@gmail.com>
cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: Kernel regression in 6.13
In-Reply-To: <aUFreCbbgfb-5Wh1@eggsbenedict>
Message-ID: <fcf1a483-8ef8-7450-2e9e-f82be527a49d@linux.intel.com>
References: <aUCt1tHhm_-XIVvi@eggsbenedict> <09dc94cd-6247-231a-7bcc-27aaeb3b5176@linux.intel.com> <aUFlNgmLA5sI0FaJ@eggsbenedict> <3c61a43d-2a2f-0cd7-eafc-e34fb36f2274@linux.intel.com> <aUFreCbbgfb-5Wh1@eggsbenedict>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2101671776-1766066072=:959"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2101671776-1766066072=:959
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 16 Dec 2025, Adam Stylinski wrote:
> On Tue, Dec 16, 2025 at 04:14:10PM +0200, Ilpo J=E4rvinen wrote:
> > On Tue, 16 Dec 2025, Adam Stylinski wrote:
> >=20
> > > On Tue, Dec 16, 2025 at 11:49:45AM +0200, Ilpo J=E4rvinen wrote:
> > > > On Mon, 15 Dec 2025, Adam Stylinski wrote:
> > > >=20
> > > > > Hello,
> > > > >=20
> > > > > I seem to be encountering a regression that prevents my system fr=
om=20
> > > > > booting.  The regression occurred between 6.12 and 6.13.  I've bi=
sected=20
> > > > > it to this commit:
> > > > > 665745f274870c921020f610e2c99a3b1613519b
> > > > >=20
> > > > > Some info about this system: it's ancient. It's a Q9650 that I us=
ed as a=20
> > > > > mythbackend/frontend for over a decade. This booting failure on n=
ewer=20
> > > > > kernels finally forced my hand to buy new a "new" PCI Express bas=
ed=20
> > > > > tuner and upgrade the system into the modern age. It boots via MB=
R on a=20
> > > > > P45 based chipset (A P5Q Plus board, to be precise).  Given the a=
ge, I=20
> > > > > chalked the issue up to possibly some failing hardware or memory=
=20
> > > > > corruption that happened at compile time. I recently pulled the s=
ystem=20
> > > > > back out again to do some performance testing in zlib-ng only to =
find=20
> > > > > out it hangs on the latest Ubuntu server ISO. I figured at this p=
oint it=20
> > > > > wasn't something specific to my kernel config / compilation and i=
t's=20
> > > > > likely a regression. It's also old enough that I may be in the po=
sition=20
> > > > > of the only one having this problem, so I took it upon myself to =
bisect=20
> > > > > what was going on. Let me know if there's anything you'd like me =
to test=20
> > > > > or try.
> > > >=20
> > > > Hi,
> > > >=20
> > > > Thanks for the report.
> > > >=20
> > > > In pcie_bwnotif_enable() there's pcie_capability_set_word() that en=
ables
> > > > bandwidth notifications:
> > > >=20
> > > > =09        pcie_capability_set_word(port, PCI_EXP_LNKCTL,
> > > >                                  PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNK=
CTL_LABIE);
> > > >=20
> > > > So as the first step change those PCI_EXP_LNKCTL_LBMIE |=20
> > > > PCI_EXP_LNKCTL_LABIE into 0 to see if not enabling the bandwitdh=20
> > > > notification allows the system to come up.
> > > >=20
> > > > I suggest not trying this directly at the top of 665745f27487=20
> > > > ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller"=
)=20
> > > > but on a kernel that is expected to have fixes since 665745f27487=
=20
> > > > including those made to the other PCIe service drivers that share=
=20
> > > > interrupt handler with bwctrl (so basically some stable version).
> > > >=20
> > > > If that works try to enable those bits one at a time.
> > > >=20
> > > > Please also send lspci -vvv.
> > > >=20
> > > > --=20
> > > >  i.
> > > >=20
> > >=20
> > > I'll try changing those values atop of the 6.18 tagged commit and let=
 you know how it goes.  Thanks for looking into this.
> > > The privileged lspci -vv output is below:
> > >=20
> > > 00:00.0 Host bridge: Intel Corporation 4 Series Chipset DRAM Controll=
er (rev 03)
> > > =09Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
> > > =09Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
- Stepping- SERR- FastB2B- DisINTx-
> > > =09Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <=
TAbort- <MAbort+ >SERR- <PERR- INTx-
> > > =09Latency: 0
> > > =09Capabilities: [e0] Vendor Specific Information: Intel <unknown>
> > >=20
> > > 00:01.0 PCI bridge: Intel Corporation 4 Series Chipset PCI Express Ro=
ot Port (rev 03) (prog-if 00 [Normal decode])
> > > =09Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
> > > =09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
- Stepping- SERR+ FastB2B- DisINTx+
> > > =09Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <=
TAbort- <MAbort- >SERR- <PERR- INTx-
> > > =09Latency: 0, Cache Line Size: 32 bytes
> > > =09Interrupt: pin A routed to IRQ 24
> > > =09Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=
=3D0
> > > =09I/O behind bridge: c000-cfff [size=3D4K] [16-bit]
> > > =09Memory behind bridge: fd000000-fe9fffff [size=3D26M] [32-bit]
> > > =09Prefetchable memory behind bridge: c0000000-dfffffff [size=3D512M]=
 [32-bit]
> > > =09Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <=
TAbort- <MAbort- <SERR- <PERR-
> > > =09BridgeCtl: Parity- SERR+ NoISA- VGA+ VGA16+ MAbort- >Reset- FastB2=
B-
> > > =09=09PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > > =09Capabilities: [88] Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Mot=
herboard
> > > =09Capabilities: [80] Power Management version 3
> > > =09=09Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3=
hot+,D3cold+)
> > > =09=09Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> > > =09Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> > > =09=09Address: fee02000  Data: 0020
> > > =09Capabilities: [a0] Express (v2) Root Port (Slot+), IntMsgNum 0
> > > =09=09DevCap:=09MaxPayload 128 bytes, PhantFunc 0
> > > =09=09=09ExtTag- RBE+ TEE-IO-
> > > =09=09DevCtl:=09CorrErr- NonFatalErr- FatalErr- UnsupReq-
> > > =09=09=09RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> > > =09=09=09MaxPayload 128 bytes, MaxReadReq 128 bytes
> > > =09=09DevSta:=09CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- Tra=
nsPend-
> > > =09=09LnkCap:=09Port #2, Speed 5GT/s, Width x16, ASPM L0s, Exit Laten=
cy L0s <256ns
> > > =09=09=09ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
> > > =09=09LnkCtl:=09ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
> > > =09=09=09ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
> > > =09=09LnkSta:=09Speed 2.5GT/s, Width x16
> > > =09=09=09TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt+
> >=20
> > At least this Root Port has both BWMgmt and ABWMgmt asserted (not a=20
> > problem in itself, necessarily).
> >=20
> > If you get the system working by changing that set_word call, it's wort=
h=20
> > to check if these got reasserted (bwctrl tries to clear them right afte=
r=20
> > the set word call but it could be they get reasserted).
> >=20
> > --=20
> >  i.
>=20
> Yes, I was able to boot after forcing those flags to zero.  Here's lspci =
-vvv after booting into 6.18:
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
> lspci: Unable to load libkmod resources: error -2
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
> =09=09=09TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> =09=09SltCap:=09AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise=
-
> =09=09=09Slot #0, PowerLimit 75W; Interlock- NoCompl-
> =09=09SltCtl:=09Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- Li=
nkChg-
> =09=09=09Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> =09=09SltSta:=09Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlo=
ck-
> =09=09=09Changed: MRL- PresDet+ LinkState-
> =09=09RootCap: CRSVisible-
> =09=09RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisi=
ble-
> =09=09RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> =09=09DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- L=
TR-
> =09=09=09 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPre=
fix-
> =09=09=09 EmergencyPowerReduction Not Supported, EmergencyPowerReductionI=
nit-
> =09=09=09 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
> =09=09=09 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
> =09=09DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
> =09=09=09 AtomicOpsCtl: ReqEn- EgressBlck-
> =09=09=09 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
> =09=09=09 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
> =09=09LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> =09=09=09 Transmit Margin: Normal Operating Range, EnterModifiedComplianc=
e- ComplianceSOS-
> =09=09=09 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
> =09=09LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- Equ=
alizationPhase1-
> =09=09=09 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest=
-
> =09=09=09 Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
> =09Capabilities: [100 v1] Virtual Channel
> =09=09Caps:=09LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
> =09=09Arb:=09Fixed- WRR32- WRR64- WRR128-
> =09=09Ctrl:=09ArbSelect=3DFixed
> =09=09Status:=09InProgress-
> =09=09VC0:=09Caps:=09PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
> =09=09=09Arb:=09Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
> =09=09=09Ctrl:=09Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
> =09=09=09Status:=09NegoPending- InProgress-
> =09Capabilities: [140 v1] Root Complex Link
> =09=09Desc:=09PortNumber=3D02 ComponentID=3D01 EltType=3DConfig
> =09=09Link0:=09Desc:=09TargetPort=3D00 TargetComponent=3D01 AssocRCRB- Li=
nkType=3DMemMapped LinkValid+
> =09=09=09Addr:=0900000000fed19000
> =09Kernel driver in use: pcieport

Hi.

Here's a quirk patch to disable bwctrl on this Root Port, assuming I=20
guessed the PCI device ID for it right, please check it matches to 00:01.0=
=20
(I should have asked lspci with -n to see the raw number but you can=20
easily correct it yourself too before compiling the kernel).

From=201e13651f8789fb9df060269a7b7c396211d910f8 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.intel=
=2Ecom>
Date: Thu, 18 Dec 2025 15:45:25 +0200
Subject: [PATCH 1/1] PCI/bwctrl: Disable BW controller on Intel P45 using a=
 quirk
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The commit 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as
PCIe BW controller") was found to lead to a boot hang on a Intel P45
system. Testing without setting Link Bandwidth Management Interrupt
Enable (LBMIE) and Link Autonomous Bandwidth Interrupt Enable (LABIE)
(PCIe r7.0, sec. 7.5.3.7) in bwctrl allowed system to come up.

Add no_bw_notif into the struct pci_dev and quirk Intel P45 Root Port
with it.

Reported-by: Adam Stylinski <kungfujesus06@gmail.com>
Link: https://lore.kernel.org/linux-pci/aUCt1tHhm_-XIVvi@eggsbenedict/
Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/bwctrl.c |  3 +++
 drivers/pci/quirks.c      | 10 ++++++++++
 include/linux/pci.h       |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 36f939f23d34..4ae92c9f912a 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -250,6 +250,9 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 =09struct pci_dev *port =3D srv->port;
 =09int ret;
=20
+=09if (port->no_bw_notif)
+=09=09return -ENODEV;
+
 =09/* Can happen if we run out of bus numbers during enumeration. */
 =09if (!port->subordinate)
 =09=09return -ENODEV;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b9c252aa6fe0..6ef42a2c4831 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1359,6 +1359,16 @@ static void quirk_transparent_bridge(struct pci_dev =
*dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,=09PCI_DEVICE_ID_INTEL_82380F=
B,=09quirk_transparent_bridge);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA,=090x605,=09quirk_transpare=
nt_bridge);
=20
+/*
+ * Enabling Link Bandwidth Management Interrupts (BW notifications) can ca=
use
+ * boot hangs on P45.
+ */
+static void quirk_p45_bw_notifications(struct pci_dev *dev)
+{
+=09dev->no_bw_notif =3D 1;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e21, quirk_p45_bw_notific=
ations);
+
 /*
  * Common misconfiguration of the MediaGX/Geode PCI master that will reduc=
e
  * PCI bandwidth from 70MB/s to 25MB/s.  See the GXM/GXLV/GX1 datasheets
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..3a556cd749e3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -406,6 +406,7 @@ struct pci_dev {
 =09=09=09=09=09=09      user sysfs */
 =09unsigned int=09clear_retrain_link:1;=09/* Need to clear Retrain Link
 =09=09=09=09=09=09   bit manually */
+=09unsigned int=09no_bw_notif:1;=09/* BW notifications may cause issues */
 =09unsigned int=09d3hot_delay;=09/* D3hot->D0 transition time in ms */
 =09unsigned int=09d3cold_delay;=09/* D3cold->D0 transition time in ms */
=20

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
--=20
2.39.5

--8323328-2101671776-1766066072=:959--

