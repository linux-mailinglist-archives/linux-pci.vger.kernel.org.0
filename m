Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4A12DBE25
	for <lists+linux-pci@lfdr.de>; Wed, 16 Dec 2020 11:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgLPKCB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Dec 2020 05:02:01 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56626 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725822AbgLPKCA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Dec 2020 05:02:00 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 93416400C5;
        Wed, 16 Dec 2020 10:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1608112860; bh=ywR5snH3mIylH/jDbNsTACO0lKeGNx/hqKkcli977+U=;
        h=From:To:Cc:Subject:Date:From;
        b=TPqfsh0VxK6mnAp9ibCXMKZTo/jNybBAHARVSQJbzIHsZnG4H4JLPbQm9W8a1OMYm
         ZIgOryZhTT32Nr+T/YPmu/Cx52PA1jHe3a+t8waeCy/75YxVHW5giPwVHrl8MaEZQN
         vF3x6f3NFT/spmTUr7cBcHTZ42l328/jy3IbTD0Rg8+QtIcQBJjlNtMmaPe6112CgN
         XeKvtq3+0y+gBcNeuwjX/BIACa947MfRZT84Y+PHQDg6ENbUt4PwPnsTpmE1pBMPZ1
         Ubmk+o4WxhMi7vrdCjkoTAcNd6zkWkvdi621G347z4ZqF8NbyLyXagxfhZph/C4YwL
         K1nPMFXJg50HQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3ED64A005D;
        Wed, 16 Dec 2020 10:00:57 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Rui Matos <Rui.Matos@synopsys.com>
Subject: [PATCH] lspci: Add Synopsys DesignWare VSECs support for HDMA
Date:   Wed, 16 Dec 2020 11:00:52 +0100
Message-Id: <7591ef75643f9628b938df462bdfe87f1a53e5d0.1608112852.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for Synopsys DesignWare Vendor-Specific Extended Capability
interpretion related to Direct Memory Access

Signed-off-by: Rui Matos <rui.matos@synopsys.com>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Makefile                |   3 +-
 lib/header.h            |   2 +
 ls-ecaps-snps.c         | 117 +++++++++
 ls-ecaps.c              |   9 +
 lspci.h                 |   3 +
 tests/cap-snps-Endpoint | 618 ++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 751 insertions(+), 1 deletion(-)
 create mode 100644 ls-ecaps-snps.c
 create mode 100644 tests/cap-snps-Endpoint

diff --git a/Makefile b/Makefile
index ff51be1..2f3bc78 100644
--- a/Makefile
+++ b/Makefile
@@ -69,7 +69,7 @@ force:
 lib/config.h lib/config.mk:
 	cd lib && ./configure
 
-lspci: lspci.o ls-vpd.o ls-caps.o ls-caps-vendor.o ls-ecaps.o ls-kernel.o ls-tree.o ls-map.o common.o lib/$(PCILIB)
+lspci: lspci.o ls-vpd.o ls-caps.o ls-caps-vendor.o ls-ecaps.o ls-ecaps-snps.o ls-kernel.o ls-tree.o ls-map.o common.o lib/$(PCILIB)
 setpci: setpci.o common.o lib/$(PCILIB)
 
 LSPCIINC=lspci.h pciutils.h $(PCIINC)
@@ -77,6 +77,7 @@ lspci.o: lspci.c $(LSPCIINC)
 ls-vpd.o: ls-vpd.c $(LSPCIINC)
 ls-caps.o: ls-caps.c $(LSPCIINC)
 ls-ecaps.o: ls-ecaps.c $(LSPCIINC)
+ls-ecaps-snps.o: ls-ecaps-snps.c $(LSPCIINC)
 ls-kernel.o: ls-kernel.c $(LSPCIINC)
 ls-tree.o: ls-tree.c $(LSPCIINC)
 ls-map.o: ls-map.c $(LSPCIINC)
diff --git a/lib/header.h b/lib/header.h
index bfdcc80..bd41727 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1354,6 +1354,8 @@
 
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_VENDOR_ID_COMPAQ		0x0e11
+#define PCI_VENDOR_ID_SYNOPSYS		0x16c3
+#define PCI_DEVICE_ID_SYNOPSYS_EDDA	0xedda
 
 /* I/O resource flags, compatible with <include/linux/ioport.h> */
 
diff --git a/ls-ecaps-snps.c b/ls-ecaps-snps.c
new file mode 100644
index 0000000..f08b235
--- /dev/null
+++ b/ls-ecaps-snps.c
@@ -0,0 +1,117 @@
+/*
+ * Can be freely distributed and used under the terms of the GNU GPL-2.
+ *
+ * Copyright (c) 2019 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare Vendor Specific Capabilities
+ *
+ * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+ * Author: Rui Matos <rui.matos@synopsys.com>
+ */
+
+#include <stdio.h>
+#include <string.h>
+
+#include "lspci.h"
+
+#define SNPS_VSEC_ID_DMA		0x6
+
+static void show_snps_VSEC_DMA(struct device *d, int where, int rev, int len)
+{
+	static const char *pw[16] = {
+		"?", "?", "?", "?", "?", "?", "?", "?",
+		"128 ", "256 ", "512 ", "1K", "2K", "4K", "?", "?"
+	};
+	static const char *mbl[8] = {
+		"8", "16", "32", "64", "128", "256", "?", "?"
+	};
+	static const char *mbw[8] = {
+		"32", "64", "128", "256", "512", "?", "?", "?"
+	};
+	static const char *sp[8] = {
+		"256", "512 ", "1K", "2K", "4K", "8K", "16K", "32K"
+	};
+	static const char *b[2] = {
+		"-", "+"
+	};
+	u32 raw;
+	u64 val;
+
+	printf("Synopsys Direct Memory Access (rev %d)\n", rev);
+
+	if (verbose < 2)
+		return;
+
+	switch (rev) {
+	case 0x0:
+		if (len != 0x18 || !config_fetch(d, where, len))
+			goto err;
+
+		raw = get_conf_long(d, where + 0x8);
+		printf("\t\tDevice: ");
+		printf("PW: %sbytes, ", pw[BITS(raw, 26, 4)]);
+		printf("MBL: %sbits, ", mbl[BITS(raw, 23, 3)]);
+		printf("MBW: %sbits, ", mbw[BITS(raw, 20, 3)]);
+		printf("AXI%s, ", b[BITS(raw, 19, 1)]);
+		printf("CS: %sbytes, ", sp[BITS(raw, 16, 3)]);
+		printf("PFN: %u, ", BITS(raw, 11, 5));
+		printf("BARN: %u\n", BITS(raw, 10, 3));
+		printf("\t\t\tMF: ");
+		switch (BITS(raw, 0, 3)) {
+		case 0x0:
+			printf("EDMA legacy (0x0)\n");
+			break;
+		case 0x1:
+			printf("EDMA unroll (0x1)\n");
+			break;
+		case 0x5:
+			printf("HDMA compatibility (0x5)\n");
+			break;
+		case 0x7:
+			printf("HDMA native (0x7)\n");
+			break;
+		default:
+			printf("Unknown (0x%x)\n", BITS(raw, 0, 3));
+			break;
+		}
+
+		raw = get_conf_long(d, where + 0xc);
+		printf("\t\tChannels: ");
+		printf("Read: %u, ", BITS(raw, 16, 10));
+		printf("Write: %u\n", BITS(raw, 0, 10));
+
+		val = get_conf_long(d, where + 0x10);
+		val <<= 32;
+		val |= get_conf_long(d, where + 0x14);
+		printf("\t\tUnroll Address: 0x%.16lx (64-bit)\n", val);
+		break;
+	default:
+		goto err;
+	}
+	return;
+err:
+	printf("\t\t<unreadable>\n");
+}
+
+int show_snps_caps(struct device *d, int where)
+{
+	u32 header, id, rev, len;
+
+	if (!config_fetch(d, where, 4))
+		return 0;
+
+	header = get_conf_long(d, where + 4);
+	if (!header)
+		return 0;
+
+	id = BITS(header, 0, 16);
+	rev = BITS(header, 16, 4);
+	len = BITS(header, 20, 12);
+
+	if (id != SNPS_VSEC_ID_DMA)
+		return 0;
+
+	show_snps_VSEC_DMA(d, where, rev, len);
+
+	return 1;
+}
+
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 4417cd9..b383801 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -646,6 +646,15 @@ cap_evendor(struct device *d, int where)
       return;
     }
 
+  switch (get_conf_word(d, PCI_VENDOR_ID))
+    {
+      case PCI_VENDOR_ID_SYNOPSYS:
+	  if (get_conf_word(d, PCI_DEVICE_ID) == PCI_DEVICE_ID_SYNOPSYS_EDDA)
+	    if (show_snps_caps(d, where))
+              return;
+        break;
+    }
+
   hdr = get_conf_long(d, where + PCI_EVNDR_HEADER);
   printf("ID=%04x Rev=%d Len=%03x <?>\n",
     BITS(hdr, 0, 16),
diff --git a/lspci.h b/lspci.h
index fefee52..a1bbce8 100644
--- a/lspci.h
+++ b/lspci.h
@@ -75,6 +75,9 @@ void show_caps(struct device *d, int where);
 
 void show_ext_caps(struct device *d, int type);
 
+/* ls-ecaps-snps.c */
+int show_snps_caps(struct device *d, int where);
+
 /* ls-caps-vendor.c */
 
 void show_vendor_caps(struct device *d, int where, int cap);
diff --git a/tests/cap-snps-Endpoint b/tests/cap-snps-Endpoint
new file mode 100644
index 0000000..ea87e7c
--- /dev/null
+++ b/tests/cap-snps-Endpoint
@@ -0,0 +1,618 @@
+01:00.0 Class 0580: Device 16c3:edda (rev 53)
+        Subsystem: Device 16c3:0124
+        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+        Interrupt: pin A routed to IRQ 11
+        Region 0: Memory at a4010000 (64-bit, non-prefetchable) [disabled]
+        Region 2: Memory at a0000000 (64-bit, non-prefetchable) [disabled]
+        Expansion ROM at a4000000 [disabled]
+        Capabilities: [40] Power Management version 3
+                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
+                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
+        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
+                Address: 0000000000000000  Data: 0000
+                Masking: 00000000  Pending: 00000000
+        Capabilities: [70] Express (v2) Endpoint, MSI 00
+                DevCap: MaxPayload 1024 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
+                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
+                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
+                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
+                        MaxPayload 1024 bytes, MaxReadReq 512 bytes
+                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
+                LnkCap: Port #0, Speed 16GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <4us, L1 <64us
+                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
+                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
+                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
+                LnkSta: Speed 16GT/s (ok), Width x8 (ok)
+                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
+                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, NROPrPrP-, LTR+
+                         10BitTagComp+, 10BitTagReq-, OBFF Not Supported, ExtFmt+, EETLPPrefix+, MaxEETLPPrefixes 1
+                         EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
+                         FRS-, TPHComp+, ExtTPHComp-
+                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
+                         AtomicOpsCtl: ReqEn-
+                LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
+                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
+                         Compliance De-emphasis: -6dB
+                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
+                         EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
+        Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
+                Vector table: BAR=0 offset=00000000
+                PBA: BAR=0 offset=00000010
+        Capabilities: [100 v2] Advanced Error Reporting
+                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
+                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
+                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
+                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
+                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
+                HeaderLog: 00000000 00000000 00000000 00000000
+        Capabilities: [148 v1] Virtual Channel
+                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
+                Arb:    Fixed- WRR32- WRR64- WRR128-
+                Ctrl:   ArbSelect=Fixed
+                Status: InProgress-
+                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
+                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
+                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
+                        Status: NegoPending- InProgress-
+        Capabilities: [164 v1] Device Serial Number 00-00-00-00-00-00-00-00
+        Capabilities: [174 v1] Alternative Routing-ID Interpretation (ARI)
+                ARICap: MFVC- ACS+, Next Function: 1
+                ARICtl: MFVC- ACS-, Function Group: 0
+        Capabilities: [184 v1] Secondary PCI Express
+                LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
+                LaneErrStat: 0
+        Capabilities: [1a4 v1] Physical Layer 16.0 GT/s <?>
+        Capabilities: [1cc v1] Lane Margining at the Receiver <?>
+        Capabilities: [1f4 v1] Single Root I/O Virtualization (SR-IOV)
+                IOVCap: Migration-, Interrupt Message Number: 000
+                IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy-
+                IOVSta: Migration-
+                Initial VFs: 15, Total VFs: 15, Number of VFs: 0, Function Dependency Link: 00
+                VF offset: 256, stride: 256, Device ID: 1172
+                Supported Page Size: 00000553, System Page Size: 00000001
+                VF Migration: offset: 00000000, BIR: 0
+        Capabilities: [234 v1] Transaction Processing Hints
+                No steering table available
+        Capabilities: [294 v1] Vendor Specific Information: Synopsys Direct Memory Access (rev 0)
+                Device Information
+                        Page Width: 4 Kbytes
+                        Master Burst Length: 32 bits
+                        Master Bus Width: 512 bits
+                        AXI Interface: Enabled
+                        Channel Separation: 256 bytes
+                        Physical Function Number: 0
+                        Base Address Register Number: 0
+                        MAP Format: HDMA compatibility (0x5)
+                Channels
+                        Read: 2
+                        Write: 2
+                Unroll Address: 0x0000100000000000 (64-bit)
+        Capabilities: [2c0 v1] Address Translation Service (ATS)
+                ATSCap: Invalidate Queue Depth: 00
+                ATSCtl: Enable-, Smallest Translation Unit: 00
+        Capabilities: [2d0 v1] Access Control Services
+                ACSCap: SrcValid- TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl+ DirectTrans+
+                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
+        Capabilities: [2dc v1] Page Request Interface (PRI)
+                PRICtl: Enable- Reset-
+                PRISta: RF- UPRGI- Stopped+
+                Page Request Capacity: 00000001, Page Request Allocation: 00000000
+        Capabilities: [2ec v1] Latency Tolerance Reporting
+                Max snoop latency: 0ns
+                Max no snoop latency: 0ns
+        Capabilities: [2f4 v1] Process Address Space ID (PASID)
+                PASIDCap: Exec+ Priv+, Max PASID Width: 00
+                PASIDCtl: Enable- Exec- Priv-
+        Capabilities: [2fc v1] Vendor Specific Information: Synopsys Reliability, Availability, and Serviceability - Debug, Error Injection, and Statistics (rev 4)
+                Event Counter Control
+                        Status: 0
+                        Lane Select: 0
+                        Data Select: Ebuf Overflow
+                Event Counter Data
+                        Data: 0
+                Time Based Analysis Control
+                        Timer Start: Stop
+                        Duration Select: 1 ms
+                        Report Select: Duration of 1 cycle
+                Time Based Analysis Data
+                        Value: 4294967296000
+                Error Injection Control
+                        Injection0 (CRC Error): Disabled
+                        Injection1 (Sequence Number Error): Disabled
+                        Injection2 (DLLP Error): Disabled
+                        Injection3 (Symbol DataK Mask Error or Sync Header Error): Disabled
+                        Injection4 (FC Credit Update Error): Disabled
+                        Injection5 (TLP Duplicate/Nullify Error): Disabled
+                        Injection6 (Specific TLP Error): Disabled
+                Error Injection Control 0
+                        Error count: 0
+                        Error type: New TLP's LCRC error
+                Error Injection Control 1
+                        Error count: 0
+                        Error type: ACK/NAK DLLP's SEQ# Error
+                        Bad sequence number: 0
+                Error Injection Control 2
+                        Error count: 0
+                        DLLP Type: ACK/NAK DLLP's transmission block
+                Error Injection Control 3
+                        Error count: 0
+                        Error Type: Invert sync header for 128b/130b encoding or reserved for 8b/10b encoding
+                Error Injection Control 4
+                        Error count: 0
+                        Update-FC type: Posted TLP Header Credit value control
+                        VC Number: 0
+                        Bad update-FC credit: 0
+                Error Injection Control 5
+                        Error count: 0
+                        Specified TLP: Generates Nullified TLP (Original TLP will be stored in retry buffer)
+                Error Injection Control 6
+                        Compare Point H[0]: 0x0
+                        Compare Point H[1]: 0x0
+                        Compare Point H[2]: 0x0
+                        Compare Point H[3]: 0x0
+                        Compare Value H[0]: 0x0
+                        Compare Value H[1]: 0x0
+                        Compare Value H[2]: 0x0
+                        Compare Value H[3]: 0x0
+                        Change Point H[0]: 0x0
+                        Change Point H[1]: 0x0
+                        Change Point H[2]: 0x0
+                        Change Point H[3]: 0x0
+                        Change Value H[0]: 0x0
+                        Change Value H[1]: 0x0
+                        Change Value H[2]: 0x0
+                        Change Value H[3]: 0x0
+                Error Injection Control 6 (Packet Error)
+                        Error count: 0
+                        Inverted Error Injection Control: Change Value H[0/1/2/3] is used to replace bits specified by Change Point H[0/1/2/3]
+                        Packet type: TLP Header
+                Silicon Debug Control l
+                        Force Detect Lane: 0
+                        Force Detect Lane Enable: Disabled
+                        Number of Tx EIOS: 1 - (2.5GT/s, 8.0GT/s or higher) or 2 - (5.0GT/s)
+                        Low Power Entry Interval Time: 40ns
+                Silicon Debug Control 2
+                        Hold and Release LTSSM: Clear
+                        Force LinkDown: Clear
+                        Direct Recovery Idle to Configuration: Clear
+                        Direct Polling Compliance to Detect: Clear
+                        Direct Loopback Slave To Exit: Clear
+                        Framing Error Recovery Disable: 0
+                Silicon Debug Layer 1 Lane Status
+                        Lane Select: 0
+                        PIPE RxPolarity: 0
+                        PIPE Detect Lane: Detected
+                        PIPE RxValid: Detected
+                        PIPE RxElecIdle: 0
+                        PIPE TxElecIdle: 0
+                        Deskew Pointer: 2
+                Silicon Debug Layer 1 LTSSM Status
+                        First Framing Error Pointer: Reserved
+                        Framing Error: Not Detected
+                        PIPE PowerDown: 0
+                        Lane Reversal Operation: 0
+                        LTSSM Variable: 200 - Reserved
+                Silicon Debug Power Managment Status
+                        Internal PM State
+                                (Master): L0
+                                (Slave): S_IDLE
+                        PME Re-send flag: 0
+                        L1Sub State: S_L1_U : Idle state
+                        Latched N_FTS: 190
+                Silicon Debug Layer 2 Lane Status
+                        Tx Tlp Sequence Number: 2064
+                        Tx Ack Sequence Number: 2063
+                        DLCMSM: DL_ACTIVE
+                        FC_INIT2: 0
+                Silicon Debug Layer 3 Lane FC Status
+                        Credit Select(VC): VC0
+                        Credit Select(Credit Type): Rx
+                        Credit Select(TLP Type): Posted
+                        Credit Select(HeaderData): Data Credit
+                        Credit Data0: 121
+                        Credit Data1: 0
+                Silicon Debug Layer 3 Lane Status
+                        First Malformed TLP Error Pointer:  Reserved
+                        Malformed TLP Status: 0
+                Silicon Debug Equalizer Control 1
+                        EQ Status Lane Select: Lane0
+                        EQ Status Rate Select: 8.0GT/s Speed
+                        Extends EQ Phase2/3 Timeout: [EQ Master]24ms or [EQ Slave] 32ms
+                        Eval Interval Time: 500 ns
+                        FOM Targe Enable: Disabled
+                        FOM Target 0x0
+                Silicon Debug Equalizer Control 2
+                        Force Local Transmitter Pre-cursor: 0
+                        Force Local Transmitter Cursor: 0
+                        Force Local Transmitter Post-Cursor: 0
+                        Force Local Receiver Preset Hint: 0
+                        Force Local Transmitter Preset: 0
+                        Force Local Transmitter Coefficient Enable: Disabled
+                        Force Local Receiver Preset Hint Enable: Disabled
+                        Force Local Transmitter Preset Enable: Disabled
+                Silicon Debug Equalizer Control 3
+                        Force Remote Transmitter Pre-cursor: 0
+                        Force Remote Transmitter Cursor: 0
+                        Force Remote Transmitter Post-Cursor: 0
+                        Force Remote Transmitter Coefficient Enable: Disabled
+                Silicon Debug Equalizer Status 1
+                        EQ Sequence: 0
+                        EQ Convergence Info: Equalization finished successfully
+                        EQ Rule A Violation: 0
+                        EQ Rule B Violation: 0
+                        EQ Rule C Violation: 0
+                        EQ Reject Event: 0
+                Silicon Debug Equalizer Status 2
+                        EQ Local Pre-Cursor: 0
+                        EQ Local Cursor: 42
+                        EQ Local Post-Cursor: 6
+                        EQ Local Receiver Preset Hint: 0
+                        EQ Local Figure of Merit: 0
+                Silicon Debug Equalizer Status 3
+                        EQ Remote Pre-Cursor: 5
+                        EQ Remote Cursor: 43
+                        EQ Remote Post-Cursor: 0
+                        EQ Remote LF: 18
+                        EQ Remote FS: 48
+        Capabilities: [3fc v1] Vendor Specific Information: Synopsys Reliability, Availability, and Serviceability - Data Protection (rev 1)
+                Error Correction
+                        Global Transmission: Disabled
+                                AXI Bridge Outbound Completion: Disabled
+                                AXI Bridge Outbound Request: Disabled
+                                DMA Write: Disabled
+                                Layer 2: Disabled
+                                Layer 3: Disabled
+                                Adm: Disabled
+                                CXS: Disabled
+                                DTIM: Disabled
+                        Global Reception: Disabled
+                                AXI Bridge Inbound Completion: Disabled
+                                AXI Bridge Inbound Request: Disabled
+                                DMA Read: Disabled
+                                Layer 2: Disabled
+                                Layer 3: Disabled
+                                Adm: Disabled
+                                CXS: Disabled
+                Correctable Counter Control
+                        Selection: 0
+                        Region: ADM Reception
+                        Status: Enabled
+                Correctable Counter Report
+                        Selection: 0
+                        Region: ADM Reception
+                        Status: Disabled
+                Uncorrectable Counter Control
+                        Selection: 0
+                        Region: ADM Reception
+                        Status: Enabled
+                Uncorrectable Counter Report
+                        Selection: 0
+                        Region: ADM Reception
+                        Status: Disabled
+                Error Injection Control
+                        Location: 0
+                        Count: ADM Reception
+                        Type: none
+                        Status: Disabled
+                Correctable Error Location
+                        Last Location: 0
+                        Last Region: ?
+                        First Location: 0
+                        First Region: ?
+                Uncorrectable Error Location
+                        Last Location: 0
+                        Last Region: ?
+                        First Location: 0
+                        First Region: ?
+                Error Mode
+                        Automatically Link Down: Disabled
+                        Status: Enabled
+                RAM Correctable Error
+                        Index: 0
+                        Address: 0x00000000
+                RAM Uncorrectable Error
+                        Index: 0
+                        Address: 0x00000000
+        Capabilities: [434 v1] Data Link Feature <?>
+        Capabilities: [440 v1] Precision Time Measurement
+                PTMCap: Requester:+ Responder:+ Root:+
+                PTMClockGranularity: Unimplemented
+                PTMControl: Enabled:- RootSelected:-
+                PTMEffectiveGranularity: Unknown
+        Capabilities: [44c v1] Vendor Specific Information: Synopsys Precision Time Management - Requester (rev 1)
+                Control
+                        Propagation Delay Byte Reversal: Disabled
+                        Long Timer: 10 ms
+                        Fast Timers: Disabled
+                        Start Update: Clear
+                        Automatically Update: Disabled
+                Status
+                        Manual Update: not allowed
+                        Context Valid: valid
+                Local Clock Address: 0x00011b6c00000000 (64-bit)
+                T1 Timestamp Address: 0x0000000000000000 (64-bit)
+                T1 Previous Timestamp Address: 0x0000000000000000 (64-bit)
+                T4 Timestamp Address: 0x0000000000000000 (64-bit)
+                T4 Previous Timestamp Address 0x0000000000000000 (64-bit)
+                Master Time Address: 0x0000000000000000 (64-bit)
+                Propagation Delay: 0 us
+                Master Time T1: 0 us
+                Transmission Latency: 17 us
+                Reception Latency: 43 us
+                Clock Correction: 0 us
+                Nominal Clock Period
+                        Integral Part: 1 (ns)
+                        Fractional Part: 0 (ns)
+                Scaled Clock Period
+                        Status: Disabled
+                        Integral Part: 0 (ns)
+                        Fractional Part: 0 (ns)
+                Latency Viewport Register
+                        Mode: Write/read for PCIe rates
+                        Viewport Selected: 0
+                USB4 CIO Control
+                        Mode: Clear
+                        TMU Request Timer: 0
+                USB4 TMU Timestamp Value: 0 (tmu_t)
+        Kernel modules: pci_endpoint_test
+
+01:00.0 Memory controller: Synopsys, Inc. EPMockUp (rev 53)
+00: c3 16 da ed 00 00 10 00 53 00 80 05 10 00 00 00
+10: 04 00 01 a4 00 00 00 00 04 00 00 a0 00 00 00 00
+20: 00 00 00 00 00 00 00 00 00 00 00 00 c3 16 24 01
+30: 00 00 00 a4 40 00 00 00 00 00 00 00 0b 01 00 00
+40: 01 50 c3 c9 08 00 00 00 00 00 00 00 00 00 00 00
+50: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
+60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+70: 10 b0 02 00 e3 8f 00 10 70 29 10 00 84 6c 43 00
+80: 00 00 84 10 00 00 00 00 00 00 00 00 00 00 00 00
+90: 00 00 00 00 9f 1b 71 00 00 00 00 00 1e 00 80 01
+a0: 04 00 1e 01 00 00 00 00 00 00 00 00 00 00 00 00
+b0: 11 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00
+c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+100: 01 00 82 14 00 00 00 00 00 00 40 00 30 20 46 00
+110: 00 00 00 00 00 e0 00 00 a0 00 00 00 00 00 00 00
+120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+140: 00 00 00 00 00 00 00 00 02 00 41 16 00 00 00 00
+150: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 80
+160: 00 00 00 00 03 00 41 17 00 00 00 00 00 00 00 00
+170: 00 00 00 00 0e 00 41 18 02 01 00 00 00 00 00 00
+180: 00 00 00 00 19 00 41 1a 00 00 00 00 00 00 00 00
+190: 00 27 00 02 00 57 00 71 00 40 00 52 00 08 00 50
+1a0: 00 00 00 00 26 00 c1 1c 00 00 00 00 00 00 00 00
+1b0: 0f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1c0: 00 00 00 00 f0 f0 f0 f0 f0 f0 f0 f0 27 00 41 1f
+1d0: 00 00 00 00 38 9c 38 9c 38 9c 38 9c 38 9c 38 9c
+1e0: 38 9c 38 9c 38 9c 38 9c 38 9c 38 9c 38 9c 38 9c
+1f0: 38 9c 38 9c 10 00 41 23 02 00 00 00 00 00 00 00
+200: 0f 00 0f 00 00 00 00 00 00 01 00 01 00 00 72 11
+210: 53 05 00 00 01 00 00 00 00 00 00 00 00 00 00 00
+220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+230: 00 00 00 00 17 00 41 29 01 00 00 00 00 00 00 00
+240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+290: 00 00 00 00 0b 00 01 2c 06 00 80 01 05 00 48 35
+2a0: 02 00 02 00 00 10 00 00 00 00 00 00 00 00 00 00
+2b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2c0: 0f 00 01 2d 60 00 00 00 00 00 00 00 00 00 00 00
+2d0: 0d 00 c1 2d 6c 08 00 00 00 00 00 00 13 00 c1 2e
+2e0: 00 00 00 01 01 00 00 00 00 00 00 00 18 00 41 2f
+2f0: 00 00 00 00 1b 00 c1 2f 06 00 00 00 0b 00 c1 3f
+300: 02 00 04 10 00 00 00 00 00 00 00 00 00 01 00 00
+310: e8 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 02
+3b0: 00 00 c8 00 01 00 be 00 10 f8 80 03 00 79 00 00
+3c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3d0: 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00
+3e0: 80 6a 00 00 c5 0a 48 30 00 00 00 00 00 00 00 00
+3f0: 00 00 00 00 00 00 00 00 00 00 00 00 0b 00 41 43
+400: 01 00 81 03 00 00 00 00 10 00 00 00 00 00 00 00
+410: 10 00 00 00 00 00 00 00 00 00 00 00 e0 00 e0 00
+420: e0 00 e0 00 01 00 00 00 00 00 00 00 00 00 00 00
+430: 00 00 00 00 25 00 01 44 01 00 00 80 01 00 00 80
+440: 1f 00 c1 44 0f 00 00 00 00 00 00 00 0b 00 c1 54
+450: 03 00 41 07 00 09 00 00 02 00 00 00 6c 1b 01 00
+460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+490: 00 00 00 00 00 00 00 00 11 00 00 00 2b 00 00 00
+4a0: 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00
+4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+540: 00 00 00 00 00 00 00 00 00 00 00 00 0b 00 01 00
+550: 04 00 c1 07 00 00 00 00 00 00 00 00 08 29 01 00
+560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+580: 00 00 00 00 11 00 00 00 2b 00 00 00 00 00 01 00
+590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+700: 4b 00 b6 35 ff ff ff ff 08 00 80 00 00 be be 1b
+710: 20 01 0f 00 00 00 00 38 07 40 02 00 80 02 08 20
+720: 00 00 00 00 00 00 00 00 91 89 02 03 10 00 00 08
+730: f8 02 88 01 c4 00 88 01 ff ff ff 0f 01 00 00 00
+740: 0f 00 00 00 00 00 00 00 f8 22 26 46 c4 20 26 06
+750: 00 00 20 06 00 00 00 00 00 00 00 00 00 00 00 00
+760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+7f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+800: 00 00 00 00 00 00 00 00 00 00 00 00 be 08 05 00
+810: 00 00 00 00 00 00 00 00 00 00 00 00 ff 1f 00 00
+820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+880: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
+890: 01 28 40 01 00 00 00 00 00 00 00 00 00 00 00 00
+8a0: 00 00 00 00 00 00 00 00 31 1a 00 04 00 00 00 00
+8b0: 00 00 00 00 00 00 00 00 ff 00 00 00 49 3f 27 00
+8c0: 80 00 00 00 7f e0 01 00 00 00 00 00 00 00 00 00
+8d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8f0: 00 00 00 00 00 00 00 00 2a 30 30 30 2a 2a 61 67
+900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+910: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+940: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+aa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ab0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b40: 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b80: 3f 32 3f 0a 3f 3f 0f 0b 00 00 00 00 00 00 00 00
+b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ca0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+cb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+cc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+cd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ce0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+cf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+da0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+db0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+dc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+dd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+de0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+df0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ea0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+eb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ec0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ed0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ee0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ef0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+fa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-- 
2.7.4

