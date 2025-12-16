Return-Path: <linux-pci+bounces-43131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DBDCC3953
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 15:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 831D2304CBB4
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 14:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8E4341666;
	Tue, 16 Dec 2025 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epAiFpGq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E11C8611
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895042; cv=none; b=qX3NJShENsmIHIlm7csWJR4LN+0qiqtMPDVOM0Y25n6s56dLf2BDoawP/7yhq3jubRmnnttGowiJZr/YwrD2iKe7BDzHRHbVlyRG7xfinKc+2dQdNbR+tr3DLSNnPUD2gqa0OCsmcHYIaO2UmELOYXwpKGa6O56YU2xQvkIshLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895042; c=relaxed/simple;
	bh=vw4Q+BWWUooWqVQ42Vmf78AoNx2To6UcAVDO0425Xs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkAjeKo7AjNRoSXvh7/mL4fdHEdEoQN2RFKmLw+NQiI4bXlVcl1fQk3YIF3I7LRKi1sevg+66XEa8nMZ+zwysjnhPkc3Ax5ZcjrFwbJTxSTBy3qQbsYH2F0hoILJXCArmZBethvHgR1baovGMtTzcfPPIB4ykei3ZlkMb+Oo2Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epAiFpGq; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88888c41a13so54974856d6.3
        for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 06:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765895035; x=1766499835; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ht7rx20l+XBdIgpQxvCKf0fSB+KwpvwCkxf7eXWvPjY=;
        b=epAiFpGqOu8lK3Di+siiV9Lv1/EgtYAr8hSRJS/KRbOj7447eh/kiAV5y7AGtw+jV0
         wQ9qPLUDP/cYYg595Kc7Pt8AIp4xnp715uE5jRiYODFgDTRjHtO8eXlIv6abdrMEqQRl
         lgkeDEBAF+n16NueyoBv7wUWJbywEWP5u8kZ1Hbaxx755kIxOL4i306QyLg/eZpjIOoj
         AZXDgWmIJskz/6ayy4B3bd8EexhH8bsAG68U95Pvj+F/PJ3OKy9GjUmQXvErAL89iNYi
         i0UruNngC5oECGo7BDJ2cMFOxu/ZFbljjcO3Unx9nT+aq1neCQzYpYh9NpIAKfSvWYKq
         Jelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765895035; x=1766499835;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ht7rx20l+XBdIgpQxvCKf0fSB+KwpvwCkxf7eXWvPjY=;
        b=xF5rpDL6Uxh78NVPUIffYzzBc9zRj7h6P6dcvbPMTs6qHMNr1VIOPrqkZO0bU2x2NK
         3XjzIHfj7paa8AJdOnBi6EKkB5Ugti3ya/WfmMOTnyiHuAXAcnpAfB6Q8dY5ayQO7Ikp
         maehIAUnH9fZY9bXAUCpJV6uND8w7CrTbv6Ljgt7av+t7TwlmoAuuSQKXbS2QT+GgV4W
         GV/kSMsyTa4ZpNfriNhm354tiiZZw/C1i6S2/6xdG0mJJoOAMH+li00C/d32ch/56Tuz
         9uDdFv9t2Hy3ZWkxksyGuEBPZxrHGi+m8mGwp357QOunFZP/g1nVwVlAm7uf3+zlLRsi
         v0WQ==
X-Gm-Message-State: AOJu0YzfbP9b/1cUIARAlFJmKc89KEqxQQCcunQ9033ql7xYIcMeXo7u
	XLRDsenK7WYd3iQ8kIeJnpf/hR1+bhrD7ZxDLlyAYKKcxuMcdL8rrAjBics2ag==
X-Gm-Gg: AY/fxX4Msmw3hZSN5JlnpZBq5nLIigahJFXk7RuwEq2jfYMEp+SnyvcnsPQIh7+xQRm
	no/abI6EZRWHTwvKe3GMvqKHWI3y1SKGx8T15ravP2FsrynHgHvm79yVL6qkzaoLMiucsu3QFVX
	IXCziHGT2ZG7MmODaIFxEiva3/Jteh2hZ3apkkhYrkkna/ViE09dSS+VJKqp4g6B30NUnSowGqO
	vLIBC6ZPf0grDiGv0yUzgX0HK4+vFuuEEfI7pbCiu710TrYdkWdl0ECTXcpb+NXe9RF6Xaog6jS
	SOhT8B83SqfucmUsKT8Vo07ArEYef1eLFUjqyM0ehA6LvZVq7gVbMD6MYoKBsbF11LR/w5P4yTm
	dLn3M2A1uwmkq5OIW9DO6emJzd9S+lUq37sxd3ZZjBKg8i16kwQ9srjAchfbx3U6AFcmUX9mgc4
	q4govYW4TADI3uyScObMfnxDTms7DmzRaSmYZG3OFYpX+keMMTCwVLm9ytpfl50f0=
X-Google-Smtp-Source: AGHT+IHP54/xQWft9yIovc7i919bgy4izmJrkRVjUjDlr+5JuVAXaKR5cm4mzHKPNZtlI9AoMFuElw==
X-Received: by 2002:a05:6214:4344:b0:88a:38c0:538f with SMTP id 6a1803df08f44-88a38c054a2mr88897646d6.61.1765895034151;
        Tue, 16 Dec 2025 06:23:54 -0800 (PST)
Received: from eggsbenedict (ip-74-215-254-164.dynamic.fuse.net. [74.215.254.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88993b41f86sm75750246d6.3.2025.12.16.06.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:23:53 -0800 (PST)
Date: Tue, 16 Dec 2025 09:23:52 -0500
From: Adam Stylinski <kungfujesus06@gmail.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: Kernel regression in 6.13
Message-ID: <aUFreCbbgfb-5Wh1@eggsbenedict>
References: <aUCt1tHhm_-XIVvi@eggsbenedict>
 <09dc94cd-6247-231a-7bcc-27aaeb3b5176@linux.intel.com>
 <aUFlNgmLA5sI0FaJ@eggsbenedict>
 <3c61a43d-2a2f-0cd7-eafc-e34fb36f2274@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c61a43d-2a2f-0cd7-eafc-e34fb36f2274@linux.intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Tue, Dec 16, 2025 at 04:14:10PM +0200, Ilpo Järvinen wrote:
> On Tue, 16 Dec 2025, Adam Stylinski wrote:
> 
> > On Tue, Dec 16, 2025 at 11:49:45AM +0200, Ilpo Järvinen wrote:
> > > On Mon, 15 Dec 2025, Adam Stylinski wrote:
> > > 
> > > > Hello,
> > > > 
> > > > I seem to be encountering a regression that prevents my system from 
> > > > booting.  The regression occurred between 6.12 and 6.13.  I've bisected 
> > > > it to this commit:
> > > > 665745f274870c921020f610e2c99a3b1613519b
> > > > 
> > > > Some info about this system: it's ancient. It's a Q9650 that I used as a 
> > > > mythbackend/frontend for over a decade. This booting failure on newer 
> > > > kernels finally forced my hand to buy new a "new" PCI Express based 
> > > > tuner and upgrade the system into the modern age. It boots via MBR on a 
> > > > P45 based chipset (A P5Q Plus board, to be precise).  Given the age, I 
> > > > chalked the issue up to possibly some failing hardware or memory 
> > > > corruption that happened at compile time. I recently pulled the system 
> > > > back out again to do some performance testing in zlib-ng only to find 
> > > > out it hangs on the latest Ubuntu server ISO. I figured at this point it 
> > > > wasn't something specific to my kernel config / compilation and it's 
> > > > likely a regression. It's also old enough that I may be in the position 
> > > > of the only one having this problem, so I took it upon myself to bisect 
> > > > what was going on. Let me know if there's anything you'd like me to test 
> > > > or try.
> > > 
> > > Hi,
> > > 
> > > Thanks for the report.
> > > 
> > > In pcie_bwnotif_enable() there's pcie_capability_set_word() that enables
> > > bandwidth notifications:
> > > 
> > > 	        pcie_capability_set_word(port, PCI_EXP_LNKCTL,
> > >                                  PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
> > > 
> > > So as the first step change those PCI_EXP_LNKCTL_LBMIE | 
> > > PCI_EXP_LNKCTL_LABIE into 0 to see if not enabling the bandwitdh 
> > > notification allows the system to come up.
> > > 
> > > I suggest not trying this directly at the top of 665745f27487 
> > > ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller") 
> > > but on a kernel that is expected to have fixes since 665745f27487 
> > > including those made to the other PCIe service drivers that share 
> > > interrupt handler with bwctrl (so basically some stable version).
> > > 
> > > If that works try to enable those bits one at a time.
> > > 
> > > Please also send lspci -vvv.
> > > 
> > > -- 
> > >  i.
> > > 
> > 
> > I'll try changing those values atop of the 6.18 tagged commit and let you know how it goes.  Thanks for looking into this.
> > The privileged lspci -vv output is below:
> > 
> > 00:00.0 Host bridge: Intel Corporation 4 Series Chipset DRAM Controller (rev 03)
> > 	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
> > 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> > 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
> > 	Latency: 0
> > 	Capabilities: [e0] Vendor Specific Information: Intel <unknown>
> > 
> > 00:01.0 PCI bridge: Intel Corporation 4 Series Chipset PCI Express Root Port (rev 03) (prog-if 00 [Normal decode])
> > 	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 0, Cache Line Size: 32 bytes
> > 	Interrupt: pin A routed to IRQ 24
> > 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> > 	I/O behind bridge: c000-cfff [size=4K] [16-bit]
> > 	Memory behind bridge: fd000000-fe9fffff [size=26M] [32-bit]
> > 	Prefetchable memory behind bridge: c0000000-dfffffff [size=512M] [32-bit]
> > 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> > 	BridgeCtl: Parity- SERR+ NoISA- VGA+ VGA16+ MAbort- >Reset- FastB2B-
> > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > 	Capabilities: [88] Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
> > 	Capabilities: [80] Power Management version 3
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > 	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > 		Address: fee02000  Data: 0020
> > 	Capabilities: [a0] Express (v2) Root Port (Slot+), IntMsgNum 0
> > 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> > 			ExtTag- RBE+ TEE-IO-
> > 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
> > 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> > 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> > 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> > 		LnkCap:	Port #2, Speed 5GT/s, Width x16, ASPM L0s, Exit Latency L0s <256ns
> > 			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
> > 		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
> > 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
> > 		LnkSta:	Speed 2.5GT/s, Width x16
> > 			TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt+
> 
> At least this Root Port has both BWMgmt and ABWMgmt asserted (not a 
> problem in itself, necessarily).
> 
> If you get the system working by changing that set_word call, it's worth 
> to check if these got reasserted (bwctrl tries to clear them right after 
> the set word call but it could be they get reasserted).
> 
> -- 
>  i.

Yes, I was able to boot after forcing those flags to zero.  Here's lspci -vvv after booting into 6.18:

00:00.0 Host bridge: Intel Corporation 4 Series Chipset DRAM Controller (rev 03)
	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Intel <unknown>
lspci: Unable to load libkmod resources: error -2

00:01.0 PCI bridge: Intel Corporation 4 Series Chipset PCI Express Root Port (rev 03) (prog-if 00 [Normal decode])
	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 24
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: c000-cfff [size=4K] [16-bit]
	Memory behind bridge: fd000000-fe9fffff [size=26M] [32-bit]
	Prefetchable memory behind bridge: c0000000-dfffffff [size=512M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [88] Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee02000  Data: 0020
	Capabilities: [a0] Express (v2) Root Port (Slot+), IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 5GT/s, Width x16, ASPM L0s, Exit Latency L0s <256ns
			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
		LnkSta:	Speed 2.5GT/s, Width x16
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 75W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [140 v1] Root Complex Link
		Desc:	PortNumber=02 ComponentID=01 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=01 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed19000
	Kernel driver in use: pcieport

00:1a.0 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #4 (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at b800 [size=32]
	Capabilities: [50] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: uhci_hcd

00:1a.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #5 (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at b880 [size=32]
	Capabilities: [50] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: uhci_hcd

00:1a.2 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #6 (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at bc00 [size=32]
	Capabilities: [50] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: uhci_hcd

00:1a.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #2 (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at fcfffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: ehci-pci

00:1c.0 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Root Port 1 (prog-if 00 [Normal decode])
	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 17
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 1000-1fff [size=4K] [16-bit]
	Memory behind bridge: f0000000-f01fffff [size=2M] [32-bit]
	Prefetchable memory behind bridge: fbf00000-fbffffff [size=1M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <256ns, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
		LnkSta:	Speed 2.5GT/s, Width x0
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 10W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed+ WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [180 v1] Root Complex Link
		Desc:	PortNumber=01 ComponentID=00 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=00 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Root Port 5 (prog-if 00 [Normal decode])
	Subsystem: ASUSTeK Computer Inc. Device 82d4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 17
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: e000-efff [size=4K] [16-bit]
	Memory behind bridge: feb00000-febfffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: f0200000-f03fffff [size=2M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #5, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <256ns, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 10W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 82d4
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed+ WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [180 v1] Root Complex Link
		Desc:	PortNumber=05 ComponentID=00 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=00 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: pcieport

00:1c.5 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Root Port 6 (prog-if 00 [Normal decode])
	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 16
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: d000-dfff [size=4K] [16-bit]
	Memory behind bridge: fea00000-feafffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: fbe00000-fbefffff [size=1M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #6, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <256ns, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 10W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed+ WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [180 v1] Root Complex Link
		Desc:	PortNumber=06 ComponentID=00 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=00 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #1 (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 4: I/O ports at b080 [size=32]
	Capabilities: [50] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: uhci_hcd

00:1d.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #2 (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at b400 [size=32]
	Capabilities: [50] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: uhci_hcd

00:1d.2 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #3 (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at b480 [size=32]
	Capabilities: [50] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: uhci_hcd

00:1d.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #1 (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at fcfff800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: ehci-pci

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90) (prog-if 01 [Subtractive decode])
	Subsystem: ASUSTeK Computer Inc. Device 82d4
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
	I/O behind bridge: f000-0fff [disabled] [16-bit]
	Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Subsystem: ASUSTeK Computer Inc. Device 82d4

00:1f.0 ISA bridge: Intel Corporation 82801JIB (ICH10) LPC Interface Controller
	Subsystem: ASUSTeK Computer Inc. Device 82d4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Intel Feature Detection

00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10 Family) SATA AHCI Controller (prog-if 01 [AHCI 1.0])
	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 25
	Region 0: I/O ports at ac00 [size=8]
	Region 1: I/O ports at a880 [size=4]
	Region 2: I/O ports at a800 [size=8]
	Region 3: I/O ports at a480 [size=4]
	Region 4: I/O ports at a400 [size=32]
	Region 5: Memory at fcffe800 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/16 Maskable- 64bit-
		Address: fee03000  Data: 0020
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Capabilities: [b0] Vendor Specific Information: Intel <unknown>
	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 82801JI (ICH10 Family) SMBus Controller
	Subsystem: ASUSTeK Computer Inc. P5Q Deluxe Motherboard
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 15
	Region 0: Memory at fcfff400 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at 0400 [size=32]

01:00.0 VGA compatible controller: NVIDIA Corporation TU116 [GeForce GTX 1650 SUPER] (rev a1) (prog-if 00 [VGA controller])
	Subsystem: Hewlett-Packard Company Device 87a5
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at dc000000 (64-bit, prefetchable) [size=32M]
	Region 5: I/O ports at cc00 [size=128]
	Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express (v2) Legacy Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <512ns, L1 <4us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
		LnkSta:	Speed 2.5GT/s (downgraded), Width x16
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range AB, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [250 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [258 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=255us PortTPowerOnTime=10us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=0us LTR1.2_Threshold=0ns
		L1SubCtl2: T_PwrOn=10us
	Capabilities: [128 v1] Power Budgeting <?>
	Capabilities: [420 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
	Capabilities: [900 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [bb0 v1] Physical Resizable BAR
		BAR 0: current size: 16MB, supported: 16MB
		BAR 1: current size: 256MB, supported: 64MB 128MB 256MB
		BAR 3: current size: 32MB, supported: 32MB

01:00.1 Audio device: NVIDIA Corporation TU116 High Definition Audio Controller (rev a1)
	Subsystem: Hewlett-Packard Company Device 87a5
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at fe9f8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 75W TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <512ns, L1 <4us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
		LnkSta:	Speed 2.5GT/s (downgraded), Width x16
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range AB, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Kernel driver in use: snd_hda_intel

01:00.2 USB controller: NVIDIA Corporation TU116 USB 3.1 Host Controller (rev a1) (prog-if 30 [XHCI])
	Subsystem: Hewlett-Packard Company Device 87a5
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at dffc0000 (64-bit, prefetchable) [size=256K]
	Region 3: Memory at dffb0000 (64-bit, prefetchable) [size=64K]
	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 75W TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <512ns, L1 <4us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
		LnkSta:	Speed 2.5GT/s (downgraded), Width x16
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range AB, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
	Capabilities: [b4] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000

01:00.3 Serial bus controller: NVIDIA Corporation TU116 USB Type-C UCSI Controller (rev a1)
	Subsystem: Hewlett-Packard Company Device 87a5
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin D routed to IRQ 5
	Region 0: Memory at fe9ff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 75W TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <512ns, L1 <4us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
		LnkSta:	Speed 2.5GT/s (downgraded), Width x16
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range AB, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
	Capabilities: [b4] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000

02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 02)
	Subsystem: ASUSTeK Computer Inc. M3A78 Series Motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at d800 [size=256]
	Region 2: Memory at feaff000 (64-bit, non-prefetchable) [size=4K]
	Region 4: Memory at fbef0000 (64-bit, prefetchable) [size=64K]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v1) Endpoint, IntMsgNum 1
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10W TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [b0] MSI-X: Enable+ Count=2 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00000800
	Capabilities: [d0] Vital Product Data
		Unknown small resource type 05, will not decode more.
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr+ BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 03-00-00-00-68-4c-e0-00
	Kernel driver in use: r8169

03:00.0 IDE interface: JMicron Technology Corp. JMB368 IDE controller (prog-if 85 [PCI native mode-only controller, supports bus mastering])
	Subsystem: ASUSTeK Computer Inc. Device 824f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at ec00 [size=8]
	Region 1: I/O ports at e880 [size=4]
	Region 2: I/O ports at e800 [size=8]
	Region 3: I/O ports at e480 [size=4]
	Region 4: I/O ports at e400 [size=16]
	Expansion ROM at febf0000 [disabled] [size=64K]
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Express (v1) Legacy Endpoint, IntMsgNum 1
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset- TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s unlimited
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: pata_jmicron

