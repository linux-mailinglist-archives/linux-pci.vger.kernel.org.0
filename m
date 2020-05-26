Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3A61E30C4
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 22:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390353AbgEZU4e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 16:56:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:2824 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389782AbgEZU4d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 16:56:33 -0400
IronPort-SDR: hkgfqUg4AvMUVm08IF5y+FqZoF3CW7sQnEdzzZPxRMHTCrujp10ORw4O1YJCPpvpEEL9j/anQQ
 jtsT7f7lAD/A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 13:56:29 -0700
IronPort-SDR: BDKyzgeJ355ADG9UzbIYTa43TbKoNTKBpImmW0ueZ9TCNmPd89mAvhv8caxWwsbpuX8z+fE+2F
 ECCb97BD89jQ==
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; 
   d="scan'208";a="468488183"
Received: from sgrossar-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.251.151.136])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 13:56:29 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     mj@ucw.cz, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [PATCH] CXL: Capability vendor ID changed
Date:   Tue, 26 May 2020 13:56:28 -0700
Message-Id: <20200526205628.342438-1-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the cap-dvsec-cxl test to match the new vendor ID.

Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
---
 tests/cap-dvsec-cxl | 203 +++++++++++++++++++++++---------------------
 1 file changed, 108 insertions(+), 95 deletions(-)

diff --git a/tests/cap-dvsec-cxl b/tests/cap-dvsec-cxl
index 1c51812..c499d0e 100644
--- a/tests/cap-dvsec-cxl
+++ b/tests/cap-dvsec-cxl
@@ -1,90 +1,103 @@
 6b:00.0 Unassigned class [ff00]: Intel Corporation Device 0d93
-	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
-	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Interrupt: pin A routed to IRQ 255
-	NUMA node: 0
-	Region 0: Memory at b3100000 (32-bit, non-prefetchable) [disabled] [size=1M]
-	Region 2: I/O ports at a400 [disabled] [size=1K]
-	Region 4: Memory at b1000000 (32-bit, prefetchable) [disabled] [size=16M]
-	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
-		DevCap: MaxPayload 256 bytes, PhantFunc 0
-			ExtTag+ RBE+ FLReset+
-		DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
-			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop- FLReset-
-			MaxPayload 128 bytes, MaxReadReq 512 bytes
-		DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
-		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, NROPrPrP-, LTR+
-			 10BitTagComp-, 10BitTagReq-, OBFF Via WAKE#, ExtFmt+, EETLPPrefix+, MaxEETLPPrefixes 1
-			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
-			 FRS-
-			 AtomicOpsCap: 32bit+ 64bit+ 128bitCAS+
-		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
-			 AtomicOpsCtl: ReqEn-
-	Capabilities: [80] MSI: Enable- Count=1/4 Maskable+ 64bit+
-		Address: 0000000000000000  Data: 0000
-		Masking: 00000000  Pending: 00000000
-	Capabilities: [a0] Power Management version 3
-		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
-		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
-	Capabilities: [100 v1] Advanced Error Reporting
-		UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
-		UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
-		UESvrt: DLP+ SDES- TLP+ FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
-		CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
-		CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
-		AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn+ ECRCChkCap+ ECRCChkEn+
-			MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
-		HeaderLog: 00000000 00000000 00000000 00000000
-	Capabilities: [200 v1] Multi-Function Virtual Channel <?>
-	Capabilities: [300 v1] Virtual Channel
-		Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
-		Arb:    Fixed- WRR32- WRR64- WRR128-
-		Ctrl:   ArbSelect=Fixed
-		Status: InProgress-
-		VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
-			Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
-			Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
-			Status: NegoPending- InProgress-
-	Capabilities: [550 v1] Multicast
-		McastCap: MaxGroups 64, WindowSz 1 (2 bytes)            McastCtl: NumGroups 1, Enable-
-		McastBAR: IndexPos 0, BaseAddr 0000000000000000
-		McastReceiveVec:      0000000000000000
-		McastBlockAllVec:     0000000000000000
-		McastBlockUntransVec: 0000000000000000
-	Capabilities: [588 v1] Latency Tolerance Reporting
-		Max snoop latency: 0ns
-		Max no snoop latency: 0ns
-	Capabilities: [5b0 v1] Transaction Processing Hints
-		Extended requester support
-		Steering table in TPH capability structure
-	Capabilities: [6e0 v1] Address Translation Service (ATS)
-		ATSCap: Invalidate Queue Depth: 00
-		ATSCtl: Enable-, Smallest Translation Unit: 00
-	Capabilities: [700 v1] Resizable BAR <?>
-	Capabilities: [714 v1] Secondary PCI Express
-		LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
-		LaneErrStat: 0
-	Capabilities: [b20 v1] Page Request Interface (PRI)
-		PRICtl: Enable- Reset-
-		PRISta: RF- UPRGI- Stopped+
-		Page Request Capacity: 00000000, Page Request Allocation: 00000000
-	Capabilities: [b40 v1] Process Address Space ID (PASID)
-		PASIDCap: Exec+ Priv+, Max PASID Width: 14
-		PASIDCtl: Enable- Exec- Priv-
-	Capabilities: [b50 v1] Precision Time Measurement
-		PTMCap: Requester:- Responder:- Root:-
-		PTMClockGranularity: Unimplemented
-		PTMControl: Enabled:- RootSelected:-
-		PTMEffectiveGranularity: Unknown
-	Capabilities: [d00 v1] Vendor Specific Information: ID=0040 Rev=1 Len=04c <?>
-	Capabilities: [e00 v1] CXL Designated Vendor-Specific:
-		CXLCap: Cache+ IO+ Mem+ Mem HW Init+ HDMCount 1 Viral-
-		CXLCtl: Cache+ IO+ Mem- Cache SF Cov 0 Cache SF Gran 0 Cache Clean- Viral-
-		CXLSta: Viral-
-	Capabilities: [e38 v1] Device Serial Number 12-34-56-78-90-00-00-00
-00: 86 80 93 0d 40 01 10 00 00 00 00 ff 00 00 80 00
-10: 00 00 10 b3 00 00 00 00 01 a4 00 00 00 00 00 00
-20: 08 00 00 b1 00 00 00 00 00 00 00 00 00 00 00 00
+        Physical Slot: 3
+        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
+        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+        Interrupt: pin A routed to IRQ 255
+        NUMA node: 0
+        Region 0: Memory at a6f00000 (32-bit, non-prefetchable) [disabled] [size=1M]
+        Region 2: I/O ports at a400 [disabled] [size=1K]
+        Region 4: Memory at a0000000 (32-bit, prefetchable) [disabled] [size=16M]
+        Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
+                DevCap: MaxPayload 256 bytes, PhantFunc 0
+                        ExtTag+ RBE+ FLReset+
+                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
+                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop- FLReset-
+                        MaxPayload 128 bytes, MaxReadReq 512 bytes
+                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
+                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
+                         10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
+                         EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
+                         FRS-
+                         AtomicOpsCap: 32bit+ 64bit+ 128bitCAS+
+                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
+                         AtomicOpsCtl: ReqEn-
+        Capabilities: [80] MSI: Enable- Count=1/4 Maskable+ 64bit+
+                Address: 0000000000000000  Data: 0000
+                Masking: 00000000  Pending: 00000000
+        Capabilities: [a0] Power Management version 3
+                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
+                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
+        Capabilities: [100 v1] Advanced Error Reporting
+                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
+                UESvrt: DLP+ SDES- TLP+ FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
+                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
+                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
+                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn+ ECRCChkCap+ ECRCChkEn+
+                        MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
+                HeaderLog: 00000000 00000000 00000000 00000000
+        Capabilities: [200 v1] Multi-Function Virtual Channel <?>
+        Capabilities: [300 v1] Virtual Channel
+                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
+                Arb:    Fixed- WRR32- WRR64- WRR128-
+                Ctrl:   ArbSelect=Fixed
+                Status: InProgress-
+                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
+                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
+                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
+                        Status: NegoPending- InProgress-
+        Capabilities: [550 v1] Multicast
+                McastCap: MaxGroups 64, WindowSz 1 (2 bytes)            McastCtl: NumGroups 1, Enable-
+                McastBAR: IndexPos 0, BaseAddr 0000000000000000
+                McastReceiveVec:      0000000000000000
+                McastBlockAllVec:     0000000000000000
+                McastBlockUntransVec: 0000000000000000
+        Capabilities: [588 v1] Latency Tolerance Reporting
+                Max snoop latency: 0ns
+                Max no snoop latency: 0ns
+        Capabilities: [5b0 v1] Transaction Processing Hints
+                Extended requester support
+                Steering table in TPH capability structure
+        Capabilities: [6e0 v1] Address Translation Service (ATS)
+                ATSCap: Invalidate Queue Depth: 00
+                ATSCtl: Enable-, Smallest Translation Unit: 00
+        Capabilities: [700 v1] Physical Resizable BAR
+                BAR 4: current size: 16MB, supported: 16MB 32MB
+        Capabilities: [714 v1] Secondary PCI Express
+                LnkCtl3: LnkEquIntrruptEn- PerformEqu-
+                LaneErrStat: 0
+        Capabilities: [b20 v1] Page Request Interface (PRI)
+                PRICtl: Enable- Reset-
+                PRISta: RF- UPRGI- Stopped+
+                Page Request Capacity: 00000000, Page Request Allocation: 00000000
+        Capabilities: [b40 v1] Process Address Space ID (PASID)
+                PASIDCap: Exec+ Priv+, Max PASID Width: 14
+                PASIDCtl: Enable- Exec- Priv-
+        Capabilities: [b50 v1] Precision Time Measurement
+                PTMCap: Requester:- Responder:- Root:-
+                PTMClockGranularity: Unimplemented
+                PTMControl: Enabled:- RootSelected:-
+                PTMEffectiveGranularity: Unknown
+        Capabilities: [b80 v1] Single Root I/O Virtualization (SR-IOV)
+                IOVCap: Migration-, Interrupt Message Number: 000
+                IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy-
+                IOVSta: Migration-
+                Initial VFs: 6, Total VFs: 6, Number of VFs: 0, Function Dependency Link: 00
+                VF offset: 16, stride: 2, Device ID: 0d52
+                Supported Page Size: 0000003f, System Page Size: 00000001
+                Region 0: Memory at a6900000 (32-bit, non-prefetchable)
+                Region 2: Memory at a7028000 (32-bit, non-prefetchable)
+                Region 4: Memory at 94000000 (32-bit, non-prefetchable)
+                VF Migration: offset: 00000000, BIR: 0
+        Capabilities: [d00 v1] Vendor Specific Information: ID=0040 Rev=1 Len=04c <?>
+        Capabilities: [e00 v1] Designated Vendor-Specific: Vendor=1e98 ID=0000 Rev=0 Len=56: CXL
+                CXLCap: Cache- IO+ Mem+ Mem HW Init+ HDMCount 1 Viral-
+                CXLCtl: Cache- IO+ Mem- Cache SF Cov 0 Cache SF Gran 0 Cache Clean- Viral-
+                CXLSta: Viral-
+        Capabilities: [e38 v1] Device Serial Number 30-91-11-78-10-00-00-00
+00: 86 80 93 0d 40 01 10 00 00 00 00 ff 08 40 80 00
+10: 00 00 f0 a6 00 00 00 00 01 a4 00 00 00 00 00 00
+20: 08 00 00 a0 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
 40: 10 80 92 00 e1 8f 00 10 1f 21 00 00 00 00 00 00
 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -263,13 +276,13 @@ b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 b20: 13 00 01 b4 00 00 00 01 00 00 00 00 00 00 00 00
 b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 b40: 1b 00 01 b5 06 14 00 00 00 00 00 00 00 00 00 00
-b50: 1f 00 01 d0 00 00 00 00 00 00 00 00 00 00 00 00
+b50: 1f 00 01 b8 00 00 00 00 00 00 00 00 00 00 00 00
 b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-b80: 10 00 01 d0 06 00 00 00 00 00 00 00 06 00 06 00
-b90: 06 00 00 00 02 00 02 00 00 00 52 0d 3f 00 00 00
-ba0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b80: 10 00 01 d0 02 00 00 00 00 00 00 00 06 00 06 00
+b90: 00 00 00 00 10 00 02 00 00 00 52 0d 3f 00 00 00
+ba0: 01 00 00 00 00 00 90 a6 00 00 00 00 00 80 02 a7
+bb0: 00 00 00 00 00 00 00 94 00 00 00 00 00 00 00 00
 bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -306,11 +319,11 @@ dc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 dd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 de0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 df0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-e00: 23 00 81 e3 86 80 80 03 00 00 1f 00 03 00 00 00
-e10: 00 00 00 00 00 00 00 00 00 00 00 00 03 01 00 08
+e00: 23 00 81 e3 98 1e 80 03 00 00 1e 00 02 00 00 00
+e10: 00 00 00 00 00 00 00 00 00 00 00 00 03 01 00 10
 e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-e30: 00 00 00 00 00 00 00 00 03 00 01 00 00 00 00 90
-e40: 78 56 34 12 00 00 00 00 00 00 00 00 00 00 00 00
+e30: 00 00 00 00 00 00 00 00 03 00 01 00 00 00 00 10
+e40: 78 11 91 30 00 00 00 00 00 00 00 00 00 00 00 00
 e50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 e60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 e70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-- 
2.26.2

