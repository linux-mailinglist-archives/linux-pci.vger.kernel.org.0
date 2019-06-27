Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74636584B8
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 16:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfF0OpG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 10:45:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:19117 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbfF0OpF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jun 2019 10:45:05 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3C5E76D3B65719CB1A8F;
        Thu, 27 Jun 2019 22:45:00 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Jun 2019 22:44:52 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-pci@vger.kernel.org>,
        =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>
CC:     <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <jcm@redhat.com>, <nariman.poushin@linaro.org>,
        <linuxarm@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 0/2] lspci: support for CCIX DVSEC
Date:   Thu, 27 Jun 2019 22:43:53 +0800
Message-ID: <20190627144355.27913-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for near complete interpretation of CCIX DVSEC.
Most of the CCIX base 1.0 specification is covered, but a few minor
elements are not currently printed (some of the timeouts and credit
types). That can be rectified in a future version or follow up patch
and isn't necessary for this discussion.

CCIX (www.ccixconsortium.org) is a coherent interconnect specification.
It is flexible in allowed interconnect topologies, but is overlayed
on top of a traditional PCIe tree.  Note that CCIX physical devices
may turn up in a number of different locations in the PCIe tree.

The topology configuration and physical layer controls and description
are presented using PCIe DVSEC structures defined in the CCIX 1.0
base specification.  These use the unique ID granted by the PCISIG.
Note that, whilst it looks like a Vendor ID for this usecase it is
not one and can only be used to identify DVSEC and related CCIX protocol
messages.

So why an RFC?
* Are the lspci maintainers happy to have the tool include support for
  PCI configuration structures that are defined in other standards?
* Is the general approach and code structure appropriate?
* It's a lot of description so chances are some of it isn't in a format
  consistent with the rest of lspci!

The patch set includes and example that was manually created to exercise
much of the parser.  We also have qemu patches to emulate more complex
topologies if anyone wants to experiment.

https://patchwork.kernel.org/cover/11015357/

Example output from lspci -t -F ccix-specex1 -s 03:00.0

03:00.0 Class 0700: Device 19ec:0003 (prog-if 01)
	Subsystem: Device 19ec:0007
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at e0000000 (64-bit, non-prefetchable)
	Region 2: Memory at e4000000 (64-bit, non-prefetchable)
	Region 4: [virtual] Memory at 80000000000 (64-bit, prefetchable)
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI: Enable- Count=1/4 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] MSI-X: Enable- Count=32 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=2 offset=00008fe0
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM not supported
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x8 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, NROPrPrP-, LTR-
			 10BitTagComp-, 10BitTagReq-, OBFF Not Supported, ExtFmt-, EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-, TPHComp-, ExtTPHComp-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [1c0 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
		LaneErrStat: 0
	Capabilities: [1f0 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		Port Arbitration Table [500] <?>
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=7f
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=1 ArbSelect=Fixed TC/VC=80
			Status:	NegoPending- InProgress-
	Capabilities: [380 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable-, Smallest Translation Unit: 00
	Capabilities: [600 v0] Designated Vendor-Specific <>
		Vendor:1e2c Version:0
		<CCIX Transport 600>
			TranCap:	ESM+ SR/LR RecalOnrC- CalTime: 500us QuickEqTime: 200ms/208ms
			ESMRateCap:	2.5 GT/s 5 GT/s 8 GT/s 16 GT/s 20 GT/s 25 GT/s 
			ESMStatus:	25 GT/s Cal+
			ESMCtl:		ESM0: 16 GT/s ESM1: 25 GT/s ESM+ ESMCompliance- LR
					ExtEqPhase2TimeOut: 400 ms / 408 ms  ExtEqPhase3TimeOut: 600 ms / 608 ms 
					QuickEqTimeout: Unknown
			ESMEqCtl 20GT/s:	Lane #00: Trans Presets US: 0x1 DS: 0x2
						Lane #01: Trans Presets US: 0x2 DS: 0x3
						Lane #02: Trans Presets US: 0x1 DS: 0x2
						Lane #03: Trans Presets US: 0x2 DS: 0x3
						Lane #04: Trans Presets US: 0x2 DS: 0x3
						Lane #05: Trans Presets US: 0x1 DS: 0x2
						Lane #06: Trans Presets US: 0x2 DS: 0x3
						Lane #07: Trans Presets US: 0x1 DS: 0x2
						Lane #08: Trans Presets US: 0x1 DS: 0x2
						Lane #09: Trans Presets US: 0x2 DS: 0x3
						Lane #10: Trans Presets US: 0x1 DS: 0x2
						Lane #11: Trans Presets US: 0x2 DS: 0x3
						Lane #12: Trans Presets US: 0x2 DS: 0x3
						Lane #13: Trans Presets US: 0x1 DS: 0x2
						Lane #14: Trans Presets US: 0x2 DS: 0x3
						Lane #15: Trans Presets US: 0x1 DS: 0x2

			ESMEqCtl 25GT/s:	Lane #00: Trans Presets US: 0x4 DS: 0x5
						Lane #01: Trans Presets US: 0x5 DS: 0x6
						Lane #02: Trans Presets US: 0x4 DS: 0x5
						Lane #03: Trans Presets US: 0x5 DS: 0x6
						Lane #04: Trans Presets US: 0x5 DS: 0x6
						Lane #05: Trans Presets US: 0x4 DS: 0x5
						Lane #06: Trans Presets US: 0x5 DS: 0x6
						Lane #07: Trans Presets US: 0x4 DS: 0x5
						Lane #08: Trans Presets US: 0x4 DS: 0x5
						Lane #09: Trans Presets US: 0x5 DS: 0x6
						Lane #10: Trans Presets US: 0x4 DS: 0x5
						Lane #11: Trans Presets US: 0x5 DS: 0x6
						Lane #12: Trans Presets US: 0x5 DS: 0x6
						Lane #13: Trans Presets US: 0x4 DS: 0x5
						Lane #14: Trans Presets US: 0x5 DS: 0x6
						Lane #15: Trans Presets US: 0x4 DS: 0x5
				TLCap: OptTLP+ VCResCapInd: 1
				TLCtl: OptTLP+ LengthCheck+
	Capabilities: [644 v0] Designated Vendor-Specific <>
		Vendor:1e2c Version:0
		<CCIX Protocol 644 7bc>
			CCIX Cap [680 v0] Common
				CommonCap:	DevID: 3 StructVer: 0 DevMultiPort- PrimaryPort
				CommonCap2:	Rdy+ PartialCache- PortAgg- 128B- MultiHop- SamAlign- SWPort- 
						AddrWidth: 48 bit, DataRdyTime: 16 * 32^7
				PER [d00]:	LogVersion: 1, ME+ SevUE- SevNoComm- SevDegraded- SevDeferred+
					Component:	Link
					Address:	[0x0000000100000000], MaskLen: 3
					MemErr:	FRU:		3
						MemType:	NonVolatile
						Operation:	Scrub
						ErrorType:	SingleSymbolChipKillECC
						Chan:		2
						Module:		3
						Bank:		4
						Device:		5
						Row:		6
						Column:		7
						Rank:		8
						BitPos:		1
						ChipID:		9
						MemPoolType:	Unspecified
						VenSpecLen:	0
			CCIX Cap [6a0 v0] Port
				PortCap:	Port #0 Rdy+ OptTLP+ P2PForward- Links: 1 PSAMNum: 0 
				PortCap2:	Agg Mask 0x0
				PortCap3:	FW Mask 0x0
			CCIX Cap [6b4 v0] Link
				LinkCap:	Rdy+ SharedCredits- MsgPack- NoCompAck- MaxPktSize: 128B 
				LinkSendCap:	MaxMemReq: 16, MaxSnpReq: 16, MaxDatReq: 32
				LinkRcvCap:	MaxMemReq: 16, MaxSnpReq: 16, MaxDatReq: 32
				MiscCap:	MaxMiscReqSend: 16, MaxMiscReqRcv 16
			CCIX Cap [6d0 v0] Request Agent
				RACapStat:	DiscRdyStat+ CacheFlushStat-
			CCIX Ctl [800] Common
				CommCtl1:	DeviceEnable+ PrimaryPortEnable+ Mesh- PortAgg-
						IDMTableValid+ RSAMTableValid+ HSAMTableValid- SWPort-
						ErrorAgent: 0, DevID: 2
				CommCtl2:	PartialCache- 128B- AddrWidth: 48 bit
				DevErrCtl:	Enable+
			CCIX Ctl [820] Port
				PortCntrl:	Enable+ OptTLP+ LinksEnabled: 33, PSAMNum: 0
				ErrCtlSta1:	Current: Error pending, LogDisable- PERMsgDisable-
				ErrCtlSta2:	SevLogMask: 0x00, SevPERMsgMask: 0x00
				TypeMaskR/L:	Mem-/- Cache-/- ATC-/- Port-/- Agent-/-
				SourceTransportID: 02:00.0
				PER [da0]:	LogVersion: 1, ME+ SevUE- SevNoComm- SevDegraded- SevDeferred+
					Component:	Port
					Address:	[0x0000000002000000], MaskLen: 0
					PortErr:
						Operation:	Command
						PortErrType:	Generic
						CCIX Message:	Unspecified
			CCIX Ctl [840] Link
				Link#00 [844]
				LinkCtl:	Enable+ CreditSnd+ MsgPack- NoCmpAck- MaxPktSize: 128B 
						RA-to-HA
				MaxCredit:	Mem: 0016, Snoop: 0016, Data 0016, Misc 0000
				MinCredit:	Mem: 0008, Snoop: 0008, Data 0008, Misc 0000
				DestBDF:	01:00.0
				ErrCtlSta1:	Current: Error pending, LogDisable- PERMsgDisable-
				ErrCtlSta2:	SevLogMask: 0x01, SevPERMsgMask: 0x00
				TypeMaskR/L:	Mem-/- Cache-/- ATC-/- Port-/- Agent-/-
				PER [d80]:	LogVersion: 1, ME+ SevUE- SevNoComm- SevDegraded- SevDeferred+
					Component:	Link
					Address:	[0x0000000002000000], MaskLen: 3
					LinkErr:
						OperationType:	Read
						ErrorType:	CreditOverflow
						LinkID:		3
						LinkCreditType:	4
						CCIX Message:	Unspecified
			CCIX Ctl [960] Request Agent
				RACtl:	ID: 01, Enable+ SnpRespEnable- CacheFlush- CacheEnable-
				ErrCtlSta1:	Current: Error pending, LogDisable- PERMsgDisable-
				ErrCtlSta2:	SevLogMask: 0x00, SevPERMsgMask: 0x00
				TypeMaskR/L:	Mem-/- Cache-/- ATC-/- Port-/- Agent-/-
				PER [d40]:	LogVersion: 1, ME+ SevUE- SevNoComm- SevDegraded- SevDeferred+
					Component:	RA
					Address:	[0x0000000100000000], MaskLen: 3
					CacheErr:
						CacheType:	Data
						OperationType:	Prefetch
						CacheError:	Data
						Level:		4
						Set:		5
						Way:		6
						InstanceID:	1
			CCIX IDM Table [c00]
				#00: Port#00 Link#00
				#02: Local
			CCIX RSAM Table [b00]
				#00: Enable+ Port#00 NumAgg: 01	[0x0000000000000000:0x0002000000000000]
				#01: Enable- Local		[0x0000000000000000:0x0000000000000000]
				#02: Enable- Local		[0x0000000000000000:0x0000000000000000]
				#03: Enable- Local		[0x0000000000000000:0x0000000000000000]
				#04: Enable- Local		[0x0000000000000000:0x0000000000000000]

The following grants the 'pciutils' project trademark usage of
CCIX tradmark where relevant.

This patch is being distributed by the CCIX Consortium, Inc. (CCIX) to
you and other parties that are paticipating (the "participants") in the
pciutils with the understanding that the participants will use CCIX's
name and trademark only when this patch is used in association with the
pciutils project.

CCIX is also distributing this patch to these participants with the
understanding that if any portion of the CCIX specification will be
used or referenced in the pciutils project, the participants will not modify
the cited portion of the CCIX specification and will give CCIX propery
copyright attribution by including the following copyright notice with
the cited part of the CCIX specification:
"© 2019 CCIX CONSORTIUM, INC. ALL RIGHTS RESERVED."

Jonathan Cameron (2):
  CCIX DVSEC initial support
  DVSEC Add an example from the ccix spec.

 Makefile           |    2 +-
 lib/header.h       |    2 +
 ls-ccix.c          | 1364 ++++++++++++++++++++++++++++++++++++++++++++
 ls-ecaps.c         |   28 +-
 lspci.h            |    4 +
 tests/ccix-specex1 |  661 +++++++++++++++++++++
 6 files changed, 2059 insertions(+), 2 deletions(-)
 create mode 100644 ls-ccix.c
 create mode 100644 tests/ccix-specex1

-- 
2.20.1

