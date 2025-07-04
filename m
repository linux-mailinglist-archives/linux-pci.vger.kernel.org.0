Return-Path: <linux-pci+bounces-31523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0A0AF8F82
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 12:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382233AEB65
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 10:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A08D2BEC23;
	Fri,  4 Jul 2025 10:09:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from 12.mo534.mail-out.ovh.net (12.mo534.mail-out.ovh.net [46.105.38.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D282BEC20
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.38.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751623777; cv=none; b=F3NmzPudctvAZQRRMqzF1xiXowrtbrGBe4RoR3WbeZmXdaAgEqeuvwvjAWOT2afp66S6z7yXzU8hC4v5+lK9BPyuAwkHAXEVgGkFaJEdJ2Onnbcmiaw/2j6dwb0n0ifR5h+qtDDb/qOhD33WTKtYS2IGhmi/9k0Wk9nosxfV9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751623777; c=relaxed/simple;
	bh=HPKYWTiVYesJXR39s7M1azWUtubAecQ9gg6i9VpyD7g=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=K3NcEUAXDRMLEsXRS0escdFMteSgep0GZ/utawrY69yoLltAi6crYBh0hQItXHiotPpYsHX2WTR7nToNHiFa0lsdmc6SbTzihtt09sVWgObjSVrg4XUC0YfRhpdukAsinzkM/0P8uSICpCmzeudQ4DdAlR3uJyNW9ryHac+oQGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; arc=none smtp.client-ip=46.105.38.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4bYT0W07Ssz6JRW
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 09:31:22 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 09:31:22 +0000 (UTC)
Received: from mta2.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.113.158])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4bYT0V3GQSz5wF5
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 09:31:22 +0000 (UTC)
Received: from mailstore2.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.2.8.2])
	by mta2.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTP id 42B7FBA4275
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 09:31:22 +0000 (UTC)
Date: Fri, 4 Jul 2025 09:31:22 +0000 (UTC)
From: Marcos Del Sol <marcos@orca.pet>
To: linux-pci <linux-pci@vger.kernel.org>
Message-ID: <472002156.44518617.1751621482142.JavaMail.zimbra@orca.pet>
Subject: Broken PCI MSI on Vortex86DX3 and Vortex86EX2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Thread-Index: GGvBptz8aTb9UnYXoW7UmpCXcAbfvw==
Thread-Topic: Broken PCI MSI on Vortex86DX3 and Vortex86EX2
X-Ovh-Tracer-Id: 11486993799683790438
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvvdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffkufggtgfgihhtsehtjegttddttdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpeduudfglefftefhkedvfeekledtieeghfdtleehkeelheevueffveehtdevjeelieenucfkphepuddvjedrtddrtddruddpjeelrdduudeirdegjedrudelheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehfeegmgdpmhhouggvpehsmhhtphhouhht

Hello everyone.

I recently acquired a Vortex86DX3-based mini PC from ICOP, a eBox-3352DX3-GL
which has a Realtek RTL8168E-VL Gigabit Ethernet card connected via PCI-E.

I have discovered that, while it works okay under Windows 7 (the latest
supported version for this machine), it will not under Linux. After some
research I found out the reason is that it attempts to use MSI for
interrupts, but they do not work properly. Thus interrupts will not fire and
packets cannot be received, even though they can be sent via the interface.
On Windows, it uses regular PCI interrupts.

I have contacted DM&P (the company behind the Vortex processors) and they
confirmed that it is a known issue on all machines using the PCI/PCI-X to
PCI-E Bridge [17f3:1031] bridge, such as this one and others using the
Vortex86EX2.

This is the output of lspci -nnvv (without pci=nomsi):

00:00.0 Host bridge [0600]: RDC Semiconductor, Inc. R6023 Host Bridge [17f3:6023] (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 0

00:01.0 PCI bridge [0604]: RDC Semiconductor, Inc. PCI/PCI-X to PCI-E Bridge [17f3:1031] (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 16
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: d000-dfff [size=4K] [16-bit]
        Memory behind bridge: 7c000000-7c1fffff [size=2M] [32-bit]
        Prefetchable memory behind bridge: f6900000-f69fffff [size=1M] [32-bit]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- VGA16- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) PCI/PCI-X to PCI-Express Bridge (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE-
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <2us, L1 <32us
                        ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1
                        TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #0, PowerLimit 10W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                        Changed: MRL- PresDet+ LinkState+
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

00:02.0 PCI bridge [0604]: RDC Semiconductor, Inc. PCI/PCI-X to PCI-E Bridge [17f3:1031] (rev 01) (prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 11
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 1000-1fff [size=4K] [16-bit]
        Memory behind bridge: 7c200000-7c3fffff [size=2M] [32-bit]
        Prefetchable memory behind bridge: 7c400000-7c5fffff [size=2M] [32-bit]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- VGA16- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) PCI/PCI-X to PCI-Express Bridge (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE-
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
                LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <2us, L1 <32us
                        ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #0, PowerLimit 10W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge [0601]: RDC Semiconductor, Inc. R6035 ISA Bridge [17f3:6035] (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=?? >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0

00:07.1 ISA bridge [0601]: RDC Semiconductor, Inc. R6035 ISA Bridge [17f3:6035] (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=?? >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0

00:0a.0 USB controller [0c03]: RDC Semiconductor, Inc. R6060 USB 1.1 Controller [17f3:6060] (rev 14) (prog-if 10 [OHCI])        Subsystem: RDC Semiconductor, Inc. R6060 USB 1.1 Controller [17f3:6060]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at febdf000 (32-bit, non-prefetchable) [size=4K]
        Kernel driver in use: ohci-pci
        Kernel modules: ohci_pci

00:0a.1 USB controller [0c03]: RDC Semiconductor, Inc. R6061 USB 2.0 Controller [17f3:6061] (rev 08) (prog-if 20 [EHCI])        Subsystem: RDC Semiconductor, Inc. R6061 USB 2.0 Controller [17f3:6061]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 32 bytes
        Interrupt: pin B routed to IRQ 21
        Region 0: Memory at febdec00 (32-bit, non-prefetchable) [size=256]
        Kernel driver in use: ehci-pci
        Kernel modules: ehci_pci

00:0c.0 IDE interface [0101]: RDC Semiconductor, Inc. R1012 IDE Controller [17f3:1012] (rev 02) (prog-if 8f [PCI native mode controller, supports both channels switched to ISA compatibility mode, supports bus mastering])
        Subsystem: RDC Semiconductor, Inc. R1012 IDE Controller [17f3:1012]
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at e880 [size=8]
        Region 1: I/O ports at e800 [size=4]
        Region 2: I/O ports at e480 [size=8]
        Region 3: I/O ports at e400 [size=4]
        Region 4: I/O ports at e080 [size=16]
        Kernel driver in use: pata_rdc
        Kernel modules: pata_rdc, ata_generic

00:0d.0 VGA compatible controller [0300]: RDC Semiconductor, Inc. RDC M2015 VGA-compatible graphics adapter [17f3:2015] (prog-if 00 [VGA controller])
        Subsystem: RDC Semiconductor, Inc. RDC M2015 VGA-compatible graphics adapter [17f3:2015]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
        Region 1: Memory at febe0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at ec00 [size=128]
        Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Audio device [0403]: RDC Semiconductor, Inc. R3010 HD Audio Controller [17f3:3010] (rev 01)
        Subsystem: RDC Semiconductor, Inc. R3010 HD Audio Controller [17f3:3010]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at febd8000 (32-bit, non-prefetchable) [size=16K]
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel

01:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 07)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller [10ec:0123]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at d800 [size=256]
        Region 2: Memory at f69ff000 (64-bit, prefetchable) [size=4K]
        Region 4: Memory at f69f8000 (64-bit, prefetchable) [size=16K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v2) Endpoint, MSI 01
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 4096 bytes
                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
                         10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
                         EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled,
                         AtomicOpsCtl: ReqEn-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [b0] MSI-X: Enable+ Count=4 Masked-
                Vector table: BAR=4 offset=00000000
                PBA: BAR=4 offset=00000800
        Capabilities: [d0] Vital Product Data
                Unknown small resource type 05, will not decode more.
        Kernel driver in use: r8169
        Kernel modules: r8169

This is /proc/interrupts without pci=nomsi:
           CPU0       CPU1
  0:         35          0   IO-APIC   2-edge      timer
  1:          0          4   IO-APIC   1-edge      i8042
  8:          0          0   IO-APIC   8-edge      rtc0
  9:          0          0   IO-APIC   9-fasteoi   acpi
 12:          6          0   IO-APIC  12-edge      i8042
 18:        667          0   IO-APIC  18-fasteoi   ohci_hcd:usb2, snd_hda_intel:card0
 21:          0        330   IO-APIC  21-fasteoi   ehci_hcd:usb1
 23:          0       2248   IO-APIC  23-fasteoi   pata_rdc
 24:          0          0   PCI-MSI 524288-edge      enp1s0
NMI:          0          0   Non-maskable interrupts
LOC:      16110      15274   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:          0          0   Performance monitoring interrupts
IWI:          0          0   IRQ work interrupts
RTR:          0          0   APIC ICR read retries
RES:        119         58   Rescheduling interrupts
CAL:       3032       2562   Function call interrupts
TLB:          0          2   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
DFR:          0          0   Deferred Error APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:          0          0   Machine check polls
ERR:          1
MIS:          0
PIN:          0          0   Posted-interrupt notification event
NPI:          0          0   Nested posted-interrupt event
PIW:          0          0   Posted-interrupt wakeup event

This is /proc/interrupts with pci=nomsi:
           CPU0       CPU1
  0:         34          0   IO-APIC   2-edge      timer
  1:          0          4   IO-APIC   1-edge      i8042
  8:          0          0   IO-APIC   8-edge      rtc0
  9:          0          0   IO-APIC   9-fasteoi   acpi
 12:          6          0   IO-APIC  12-edge      i8042
 16:        996          0   IO-APIC  16-fasteoi   enp1s0
 18:          0        667   IO-APIC  18-fasteoi   ohci_hcd:usb2, snd_hda_intel:card0
 21:         28          0   IO-APIC  21-fasteoi   ehci_hcd:usb1
 23:          0       2572   IO-APIC  23-fasteoi   pata_rdc
NMI:          0          0   Non-maskable interrupts
LOC:      62636      61759   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:          0          0   Performance monitoring interrupts
IWI:          0          0   IRQ work interrupts
RTR:          0          0   APIC ICR read retries
RES:        119         60   Rescheduling interrupts
CAL:       3572       2267   Function call interrupts
TLB:          1          2   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
DFR:          0          0   Deferred Error APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:          0          0   Machine check polls
ERR:          1
MIS:          0
PIN:          0          0   Posted-interrupt notification event
NPI:          0          0   Nested posted-interrupt event
PIW:          0          0   Posted-interrupt wakeup event

Note how there are no fired interrupts when PCI MSI is enabled for enp1s0,
despite being on a home network with plenty of broadcast and multicast
traffic.

If you need any more information, please let me know.

Thanks,
Marcos

