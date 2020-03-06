Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E031A17C803
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 22:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCFVr4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 16:47:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgCFVr4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 16:47:56 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 576CF20674;
        Fri,  6 Mar 2020 21:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583531275;
        bh=di4o/XwNKabmqbfoz57lh67Izeky9Hbs6uCzon43+iw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=e9nfcihwM1RmJCSX5ncglfDwLNzE0hfdRJCS8hhGdbcK+sna4MIPHiiWhVV5o+1gh
         cRgXdQQ44L11GpmV47bbMTkt5KQw6XItktIq0VjhJgy+TIYVlll6Fga6nnPZh/FT6c
         sJk0PdWc2LbnSVwFK/ZAKR2Cn/qIxOKW6o3V84mI=
Date:   Fri, 6 Mar 2020 15:47:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on
 Linux
Message-ID: <20200306214753.GA235309@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzXK1r0Er039iERnc2KJ4jn7ySNUOG9H=Ha8TD8XroVqiZjgg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thomas, Jason, Nicholas, Ben]

On Fri, Mar 06, 2020 at 02:32:59PM +0000, Luís Mendes wrote:
> Hi,
> 
> I'm trying to use Google/Coral TPU Edge modules for a project, on
> arm64 and armhf, but BAR0 doesn't get assigned during the enumeration
> of PCIe devices and consequently pci_enable_device(...) fails on BAR0
> resource with value -22 (EINVAL) (resource has null parent) when
> loading gasket/apex driver.
> 
> I'm also trying to adapt gasket/apex to run on armhf, but anyhow that
> is not the root cause for this issue.
> 
> Relevant Log extracts follow in attachment.

Hi Luís,

Thanks for the report, and sorry for the problem you're tripping over.
I cc'd a few folks who might be interested.

> [    6.983880] mvebu-pcie soc:pcie: /soc/pcie/pcie@1,0: reset gpio is active low
> [    6.993528] hub 4-1:1.0: 4 ports detected
> [    6.993749] mvebu-pcie soc:pcie: /soc/pcie/pcie@2,0: reset gpio is active low
> [    7.106741]  sdb: sdb1
> [    7.109826] sd 2:0:0:0: [sdb] Attached SCSI removable disk
> [    7.242916] mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
> [    7.248854] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    7.254370] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xefffffff]
> [    7.261267] pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
> [    7.267621] pci 0000:00:01.0: [11ab:6828] type 01 class 0x060400
> [    7.273662] pci 0000:00:01.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
> [    7.293971] PCI: bus0: Fast back to back transfers disabled
> [    7.299558] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    7.315694] pci 0000:01:00.0: [1ac1:089a] type 00 class 0x0000ff
> [    7.321749] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit pref]
> [    7.322814] usb 4-1.1: new high-speed USB device number 3 using xhci-hcd
> [    7.329004] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x000fffff 64bit pref]
> [    7.343111] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:01.0 (capable of 4.000 Gb/s with 5 GT/s x1 link)
> [    7.383442] PCI: bus1: Fast back to back transfers disabled
> [    7.389031] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> [    7.495604] pci 0000:00:02.0: ASPM: current common clock configuration is broken, reconfiguring
> [    7.552513] pci 0000:00:01.0: BAR 8: assigned [mem 0xe8000000-0xe81fffff]
> [    7.565611] pci 0000:00:01.0: BAR 6: assigned [mem 0xe8200000-0xe82007ff pref]
> [    7.580096] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    7.585079] pci 0000:00:01.0:   bridge window [mem 0xe8000000-0xe81fffff]
> [    7.653228] pcieport 0000:00:01.0: enabling device (0140 -> 0142)
> 
> 
> [   11.188025] gasket: module is from the staging directory, the quality is unknown, you have been warned.
> [   11.217048] apex: module is from the staging directory, the quality is unknown, you have been warned.
> [   11.217926] apex 0000:01:00.0: can't enable device: BAR 0 [mem 0x00000000-0x00003fff 64bit pref] not claimed
> [   11.227825] apex 0000:01:00.0: error enabling PCI device

It looks like we did assign space for the bridge window leading to
01:00.0, but failed to assign space to the 01:00.0 BAR itself.

I don't know offhand why that would be.  Can you put the entire dmesg
log somewhere we can see?  That will tell us what kernel you're using
and possibly other useful things.

Does the same problem happen with other devices, or does it only
happen with the gasket/apex combination?  There shouldn't be anything
device-specific in the PCI core resource assignment code.

> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6828 (rev 04) (prog-if 00 [Normal decode])
> 	Device tree node: /sys/firmware/devicetree/base/soc/pcie/pcie@1,0
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff [empty]
> 	Memory behind bridge: e8000000-e81fffff [size=2M]
> 	Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> 	[virtual] Expansion ROM at e8200000 [disabled] [size=2K]
> 	BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort+ >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 512 bytes
> 		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> 		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <256ns, L1 unlimited
> 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 5GT/s (ok), Width x1 (ok)
> 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> 			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
> 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> 			Changed: MRL- PresDet- LinkState-
> 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
> 		RootCap: CRSVisible-
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd-
> 			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
> 			 AtomicOpsCtl: ReqEn- EgressBlck-
> 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 
> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6828 (rev 04) (prog-if 00 [Normal decode])
> 	Device tree node: /sys/firmware/devicetree/base/soc/pcie/pcie@2,0
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
> 	I/O behind bridge: 00010000-00010fff [size=4K]
> 	Memory behind bridge: d0000000-e7ffffff [size=384M]
> 	Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> 	[virtual] Expansion ROM at e8300000 [disabled] [size=2K]
> 	BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort+ >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 512 bytes
> 		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> 		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <256ns, L1 unlimited
> 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s (downgraded), Width x1 (ok)
> 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> 			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
> 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> 			Changed: MRL- PresDet- LinkState-
> 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
> 		RootCap: CRSVisible-
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd-
> 			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
> 			 AtomicOpsCtl: ReqEn- EgressBlck-
> 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 
> 01:00.0 Non-VGA unclassified device: Device 1ac1:089a (prog-if ff)
> 	Subsystem: Device 1ac1:089a
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin A routed to IRQ 48
> 	Region 0: [virtual] Memory at <unassigned> (64-bit, prefetchable) [size=16K]
> 	Region 2: [virtual] Memory at <unassigned> (64-bit, prefetchable) [size=1M]
> 	Capabilities: [80] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
> 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
> 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 512 bytes
> 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> 		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
> 			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 5GT/s (ok), Width x1 (ok)
> 			TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
> 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not Supported
> 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
> 			 AtomicOpsCtl: ReqEn-
> 		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [d0] MSI-X: Enable- Count=128 Masked-
> 		Vector table: BAR=2 offset=00046800
> 		PBA: BAR=2 offset=00046068
> 	Capabilities: [e0] MSI: Enable- Count=1/32 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000
> 	Capabilities: [f8] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [100 v1] Vendor Specific Information: ID=1556 Rev=1 Len=008 <?>
> 	Capabilities: [108 v1] Latency Tolerance Reporting
> 		Max snoop latency: 0ns
> 		Max no snoop latency: 0ns
> 	Capabilities: [110 v1] L1 PM Substates
> 		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
> 			  PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
> 		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
> 			   T_CommonMode=0us LTR1.2_Threshold=0ns
> 		L1SubCtl2: T_PwrOn=10us
> 	Capabilities: [200 v2] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
> 		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
> 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> 		HeaderLog: 00000000 00000000 00000000 00000000
> 	Kernel modules: apex
> 
> 
> 

