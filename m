Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A06A221DE5
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 20:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfEQSzt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 14:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfEQSzs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 May 2019 14:55:48 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C8620848;
        Fri, 17 May 2019 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558119347;
        bh=deEKOf6AJ76PRSC4UpVH+4TLM70ODdzWsv0fqu2nNcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WoCcjU9EPDSSxnXApzaer4eHVwztWZio/M63p3GJgB837AdrutJHNdQp1gwUTLUHI
         actYI7GDpKukKVdeD0jm8tBSyFLSl7PZsqxuhzxUYhwGWrkwwdaYeGdQjVYkRQgWoo
         2+Bs/vBWHfQ3zGZhdU0wPjztXyTuDyK6KRLbDT5s=
Date:   Fri, 17 May 2019 13:55:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V6 02/15] PCI/PME: Export pcie_pme_disable_msi() &
 pcie_pme_no_msi() APIs
Message-ID: <20190517185545.GB49425@google.com>
References: <20190513050626.14991-1-vidyas@nvidia.com>
 <20190513050626.14991-3-vidyas@nvidia.com>
 <20190513072539.GA27708@infradead.org>
 <3a8cea93-2aeb-e5e2-4d56-f0c6449073c3@nvidia.com>
 <20190516133426.GC101793@google.com>
 <bd08ccaa-c6ee-f966-91e4-bcd5d99d5cf2@nvidia.com>
 <20190517132453.GA30700@google.com>
 <ba611a45-9589-8dce-58e1-d99dd463265d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba611a45-9589-8dce-58e1-d99dd463265d@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 17, 2019 at 11:23:36PM +0530, Vidya Sagar wrote:
> On 5/17/2019 6:54 PM, Bjorn Helgaas wrote:
> > Do you have "lspci -vvxxx" output for the root ports handy?
> > 
> > If there's some clue in the standard config space that would tell us
> > that MSI works for some events but not others, we could make the PCI
> > core pay attention it.  That would be the best solution because it
> > wouldn't require Tegra-specific code.
> 
> Here is the output of 'lspci vvxxx' for one of Tegra194's root ports.

Thanks!

This port advertises both MSI and MSI-X, and neither one is enabled.
This particular port doesn't have a slot, so hotplug isn't applicable
to it.

But if I understand correctly, if MSI or MSI-X were enabled and the
port had a slot, the port would generate MSI/MSI-X hotplug interrupts.
But PME and AER events would still cause INTx interrupts (even with
MSI or MSI-X enabled).

Do I have that right?  I just want to make sure that the reason for
PME being INTx is a permanent hardware choice and that it's not
related to MSI and MSI-X currently being disabled.

> 0005:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad0 (rev a1) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 50
> 	Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
> 	I/O behind bridge: None
> 	Memory behind bridge: 40000000-400fffff [size=1M]
> 	Prefetchable memory behind bridge: None
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [40] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
> 		Address: 0000000000000000  Data: 0000
> 		Masking: 00000000  Pending: 00000000
> 	Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
> 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 512 bytes
> 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
> 		LnkCap:	Port #0, Speed 16GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <1us, L1 <64us
> 			ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt-
> 		LnkSta:	Speed 5GT/s (downgraded), Width x1 (downgraded)
> 			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+
> 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
> 		RootCap: CRSVisible+
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd-
> 			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
> 			 AtomicOpsCtl: ReqEn- EgressBlck-
> 		LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [b0] MSI-X: Enable- Count=8 Masked-
> 		Vector table: BAR=2 offset=00000000
> 		PBA: BAR=2 offset=00010000
> 	Capabilities: [100 v2] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
> 		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
> 			MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
> 		HeaderLog: 00000000 00000000 00000000 00000000
> 		RootCmd: CERptEn+ NFERptEn+ FERptEn+
> 		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
> 			 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
> 		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
> 	Capabilities: [148 v1] Secondary PCI Express <?>
> 	Capabilities: [168 v1] Physical Layer 16.0 GT/s <?>
> 	Capabilities: [190 v1] Lane Margining at the Receiver <?>
> 	Capabilities: [1c0 v1] L1 PM Substates
> 		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
> 			  PortCommonModeRestoreTime=60us PortTPowerOnTime=40us
> 		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
> 			   T_CommonMode=10us LTR1.2_Threshold=0ns
> 		L1SubCtl2: T_PwrOn=10us
> 	Capabilities: [1d0 v1] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
> 	Capabilities: [2d0 v1] Vendor Specific Information: ID=0001 Rev=1 Len=038 <?>
> 	Capabilities: [308 v1] Data Link Feature <?>
> 	Capabilities: [314 v1] Precision Time Measurement
> 		PTMCap: Requester:+ Responder:+ Root:+
> 		PTMClockGranularity: 16ns
> 		PTMControl: Enabled:- RootSelected:-
> 		PTMEffectiveGranularity: Unknown
> 	Capabilities: [320 v1] Vendor Specific Information: ID=0004 Rev=1 Len=054 <?>
> 	Kernel driver in use: pcieport
> 00: de 10 d0 1a 07 01 10 00 a1 00 04 06 00 00 01 00
> 10: 00 00 00 00 00 00 00 00 00 01 ff 00 f0 00 00 00
> 20: 00 40 00 40 f1 ff 01 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 32 01 02 00
> 40: 01 50 c3 c9 08 00 00 00 00 00 00 00 00 00 00 00
> 50: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 10 b0 42 00 01 80 00 00 1f 28 10 00 84 4c 7b 00
> 80: 40 04 12 f0 00 00 00 00 c0 03 40 00 18 00 01 00
> 90: 00 00 00 00 1f 0c 01 00 00 04 00 00 1e 00 80 01
> a0: 04 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 11 00 07 00 02 00 00 00 02 00 01 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
