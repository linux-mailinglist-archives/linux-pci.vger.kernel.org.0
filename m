Return-Path: <linux-pci+bounces-33311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B41B186DC
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 19:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BABD3B52E1
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 17:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD831DE8B2;
	Fri,  1 Aug 2025 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J4cBhHlk"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCB81A08DB
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754070218; cv=none; b=GBL2kKBpJ/s0xJILONh/A1jdQ4PwmG3ko28xxeKaTFgN/nDd8of4fjPGaIZdjdLwlWy6nq4t9bncms2z8UxsK6/aMkxFeq4fDl7UYj2aNqmK7erE4UO6ZvBVL2AdTKhu8rz+udLEVH+jBywSKmpJ61t76uND0zehEi0RVqkN4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754070218; c=relaxed/simple;
	bh=Nsz+8eLWi+ttEmdt1o+WzKgTHtlqGqfw4qFgaJThX5M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=gV+n9CtJQG1fkKMrp97Tr46+GF2whULn4eTg54fEUAeMre1UghEw+a/45tKUr8VhcLdQR3sZ5N2wAmeQDlupViNI2j9/rAqgRxi/odX0ZbsVRm27oJ5hvm4EDd5GCmEohxk2/LrDuzY9mvRVjna9q5gfFyDmKYuXrPMSLTMeK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J4cBhHlk; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <53f6d267-62af-4dad-8fa7-a2a497b22636@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754070202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CeWhdWQUjjY6qtmHWK9NWvqGGMpBxisoCeR/n+R6EY8=;
	b=J4cBhHlkUCErWxEVkMQqOgbDi09LfhUv5VpBBaW8Umpyw/gu8cOX25rq1jlpyV6ZqIbt9b
	BVL8ge/2NGwtCduHs+FR8ZiB7zL7SVilXSgyGsSHrImPZMVbYEmSGwabJ1DE1+f21EkSiw
	AXjHTwgciEhzf0QATa58jRP/xeGU4Bw=
Date: Fri, 1 Aug 2025 13:43:19 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
Subject: [BUG] pci: nwl: Unhandled AER correctable error
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-pci@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

AER correctable errors are pretty rare. I only saw one once before and
came up with commit 78457cae24cb ("PCI: xilinx-nwl: Rate-limit misc
interrupt messages") in response. I saw another today and,
unfortunately, clearing the correctable AER bit in MSGF_MISC_STATUS is
not sufficient to handle the IRQ. It gets immediately re-raised,
preventing the system from making any other progress. I suspect that it
needs to be cleared in PCI_ERR_ROOT_STATUS. But since the AER IRQ never
gets delivered to aer_irq, those registers never get tickled.

The underlying problem is that pcieport thinks that the IRQ is going to
be one of the MSIs or a legacy interrupt, but it's actually a native
interrupt:

           CPU0       CPU1       CPU2       CPU3       
 42:          0          0          0          0     GICv2 150 Level     nwl_pcie:misc
 45:          0          0          0          0  nwl_pcie:legacy   0 Level     PCIe PME, aerdrv
 46:         25          0          0          0  nwl_pcie:msi 524288 Edge      nvme0q0
 47:          0          0          0          0  nwl_pcie:msi 524289 Edge      nvme0q1
 48:          0          0          0          0  nwl_pcie:msi 524290 Edge      nvme0q2
 49:         46          0          0          0  nwl_pcie:msi 524291 Edge      nvme0q3
 50:          0          0          0          0  nwl_pcie:msi 524292 Edge      nvme0q4

In the above example, AER errors will trigger interrupt 42, not 45.
Actually, there are a bunch of different interrupts in MSGF_MISC_STATUS,
so maybe nwl_pcie_misc_handler should be an interrupt controller
instead? But even then pcie_port_enable_irq_vec() won't figure out the
correct IRQ. Any ideas on how to fix this?

Additionally, any tips on actually triggering AER/PME stuff in a
consistent way? Are there any off-the-shelf cards for sending weird PCIe
stuff over a link for testing? Right now all I have 

--Sean

# lspci -vv
00:00.0 PCI bridge: Xilinx Corporation Device d011 (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 45
	Bus: primary=00, secondary=01, subordinate=0c, sec-latency=0
	I/O behind bridge: 00000000-00000fff [size=4K]
	Memory behind bridge: e0000000-e00fffff [size=1M]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend+
		LnkCap:	Port #0, Speed 5GT/s, Width x2, ASPM not supported
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s (ok), Width x2 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt+
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [10c v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [128 v1] Vendor Specific Information: ID=1234 Rev=1 Len=018 <?>
	Capabilities: [140 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn+ NFERptEn+ FERptEn+
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Kernel driver in use: pcieport

