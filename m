Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155FC1CE1FA
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 19:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgEKRq0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 13:46:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:4542 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgEKRq0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 13:46:26 -0400
IronPort-SDR: IFL6jQ9cnBdWQX3P/P7KSzykvlNOX583IEUpTRkjfE0fpUeX/5zp4Ch/BiOWVVevJshx1RyxBn
 mmP3/oWfgsNA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 10:46:24 -0700
IronPort-SDR: Z7Zzbwip7lBY5gMWMi/I7MQjP9mLe33wEHvRDBk4Qnf7L4JN/dyPi+/G12FRC/7RdaP9ypzRbO
 OdgGg9ABuOng==
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="279854845"
Received: from unknown (HELO arch-ashland-svkelley.intel.com) ([10.254.2.203])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 10:46:23 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     mj@ucw.cz, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, f.fangjian@huawei.com,
        huangdaode@hisilicon.com,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [PATCH v7 2/2] pciutils: Decode Compute eXpress Link DVSEC
Date:   Mon, 11 May 2020 10:46:18 -0700
Message-Id: <20200511174618.10589-3-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511174618.10589-1-sean.v.kelley@linux.intel.com>
References: <20200511174618.10589-1-sean.v.kelley@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Compute eXpress Link[1] is a new CPU interconnect created with
workload accelerators in mind. The interconnect relies on PCIe
electrical and physical interconnect for communication via a Flex Bus
port which allows designs to choose between providing PCIe or CXL.

This patch introduces basic support for lspci decode of CXL and
builds upon the existing Designated Vendor-Specific support in
lspci through identification of a supporting CXL device using DVSEC
Vendor ID and DVSEC ID.

[1] https://www.computeexpresslink.org/

Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
---
 lib/header.h        |  21 +++
 ls-ecaps.c          |  56 +++++++-
 tests/cap-dvsec-cxl | 340 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 416 insertions(+), 1 deletion(-)
 create mode 100644 tests/cap-dvsec-cxl

diff --git a/lib/header.h b/lib/header.h
index daeddeb..bc86fce 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1045,6 +1045,27 @@
 /* PCIe Designated Vendor-Specific Capability */
 #define PCI_DVSEC_HEADER1	4	/* Designated Vendor-Specific Header 1 */
 #define PCI_DVSEC_HEADER2	8	/* Designated Vendor-Specific Header 2 */
+#define PCI_DVSEC_INTEL_CXL	0	/* Designated Vendor-Specific ID for Intel CXL */
+#define PCI_DVSEC_VENDOR_ID_CXL	0x1e98	/* Designated Vendor-Specific Vendor ID for CXL */
+
+/* PCIe CXL Designated Vendor-Specific Capabilities, Control, Status */
+#define PCI_CXL_CAP		0x0a	/* CXL Capability Register */
+#define  PCI_CXL_CAP_CACHE	0x0001	/* CXL.cache Protocol Support */
+#define  PCI_CXL_CAP_IO		0x0002	/* CXL.io Protocol Support */
+#define  PCI_CXL_CAP_MEM	0x0004	/* CXL.mem Protocol Support */
+#define  PCI_CXL_CAP_MEM_HWINIT	0x0008	/* CXL.mem Initalizes with HW/FW Support */
+#define  PCI_CXL_CAP_HDM_CNT(x)	(((x) & (3 << 4)) >> 4)	/* CXL Number of HDM ranges */
+#define  PCI_CXL_CAP_VIRAL	0x4000	/* CXL Viral Handling Support */
+#define PCI_CXL_CTRL		0x0c	/* CXL Control Register */
+#define  PCI_CXL_CTRL_CACHE	0x0001	/* CXL.cache Protocol Enable */
+#define  PCI_CXL_CTRL_IO	0x0002	/* CXL.io Protocol Enable */
+#define  PCI_CXL_CTRL_MEM	0x0004	/* CXL.mem Protocol Enable */
+#define  PCI_CXL_CTRL_CACHE_SF_COV(x)	(((x) & (0x1f << 3)) >> 3) /* Snoop Filter Coverage */
+#define  PCI_CXL_CTRL_CACHE_SF_GRAN(x)	(((x) & (0x7 << 8)) >> 8) /* Snoop Filter Granularity */
+#define  PCI_CXL_CTRL_CACHE_CLN	0x0800	/* CXL.cache Performance Hint on Clean Evictions */
+#define  PCI_CXL_CTRL_VIRAL	0x4000	/* CXL Viral Handling Enable */
+#define PCI_CXL_STATUS		0x0e	/* CXL Status Register */
+#define  PCI_CXL_STATUS_VIRAL	0x4000	/* CXL Viral Handling Status */
 
 /* Access Control Services */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
diff --git a/ls-ecaps.c b/ls-ecaps.c
index b82d37e..f985c31 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -634,6 +634,57 @@ cap_rclink(struct device *d, int where)
     }
 }
 
+static void
+cap_cxl(struct device *d, int where)
+{
+  u16 l;
+
+  printf("CXL Designated Vendor-Specific:\n");
+  if (verbose < 2)
+    return;
+
+  if (!config_fetch(d, where + PCI_CXL_CAP, 12))
+    return;
+
+  l = get_conf_word(d, where + PCI_CXL_CAP);
+  printf("\t\tCXLCap:\tCache%c IO%c Mem%c Mem HW Init%c HDMCount %d Viral%c\n",
+    FLAG(l, PCI_CXL_CAP_CACHE), FLAG(l, PCI_CXL_CAP_IO), FLAG(l, PCI_CXL_CAP_MEM),
+    FLAG(l, PCI_CXL_CAP_MEM_HWINIT), PCI_CXL_CAP_HDM_CNT(l), FLAG(l, PCI_CXL_CAP_VIRAL));
+
+  l = get_conf_word(d, where + PCI_CXL_CTRL);
+  printf("\t\tCXLCtl:\tCache%c IO%c Mem%c Cache SF Cov %d Cache SF Gran %d Cache Clean%c Viral%c\n",
+    FLAG(l, PCI_CXL_CTRL_CACHE), FLAG(l, PCI_CXL_CTRL_IO), FLAG(l, PCI_CXL_CTRL_MEM),
+    PCI_CXL_CTRL_CACHE_SF_COV(l), PCI_CXL_CTRL_CACHE_SF_GRAN(l), FLAG(l, PCI_CXL_CTRL_CACHE_CLN),
+    FLAG(l, PCI_CXL_CTRL_VIRAL));
+
+  l = get_conf_word(d, where + PCI_CXL_STATUS);
+  printf("\t\tCXLSta:\tViral%c\n", FLAG(l, PCI_CXL_STATUS_VIRAL));
+}
+
+static int
+is_cxl_cap(struct device *d, int where)
+{
+  u32 hdr;
+  u16 w;
+
+  if (!config_fetch(d, where + PCI_DVSEC_HEADER1, 8))
+    return 0;
+
+  /* Check for supported Vendor */
+  hdr = get_conf_long(d, where + PCI_DVSEC_HEADER1);
+  w = BITS(hdr, 0, 16);
+  if (w != PCI_DVSEC_VENDOR_ID_CXL)
+    return 0;
+
+  /* Check for Designated Vendor-Specific ID */
+  hdr = get_conf_long(d, where + PCI_DVSEC_HEADER2);
+  w = BITS(hdr, 0, 16);
+  if (w == PCI_DVSEC_INTEL_CXL)
+    return 1;
+
+  return 0;
+}
+
 static void
 cap_dvsec(struct device *d, int where)
 {
@@ -947,7 +998,10 @@ show_ext_caps(struct device *d, int type)
 	    printf("Readiness Time Reporting <?>\n");
 	    break;
 	  case PCI_EXT_CAP_ID_DVSEC:
-	    cap_dvsec(d, where);
+	    if (is_cxl_cap(d, where))
+	      cap_cxl(d, where);
+	    else
+	      cap_dvsec(d, where);
 	    break;
 	  case PCI_EXT_CAP_ID_VF_REBAR:
 	    printf("VF Resizable BAR <?>\n");
diff --git a/tests/cap-dvsec-cxl b/tests/cap-dvsec-cxl
new file mode 100644
index 0000000..e5d2745
--- /dev/null
+++ b/tests/cap-dvsec-cxl
@@ -0,0 +1,340 @@
+6b:00.0 Unassigned class [ff00]: Intel Corporation Device 0d93
+        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
+        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+        Interrupt: pin A routed to IRQ 255
+        NUMA node: 0
+        Region 0: Memory at b3100000 (32-bit, non-prefetchable) [disabled] [size=1M]
+        Region 2: I/O ports at a400 [disabled] [size=1K]
+        Region 4: Memory at b1000000 (32-bit, prefetchable) [disabled] [size=16M]
+        Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
+                DevCap: MaxPayload 256 bytes, PhantFunc 0
+                        ExtTag+ RBE+ FLReset+
+                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
+                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop- FLReset-
+                        MaxPayload 128 bytes, MaxReadReq 512 bytes
+                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
+                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, NROPrPrP-, LTR+
+                         10BitTagComp-, 10BitTagReq-, OBFF Via WAKE#, ExtFmt+, EETLPPrefix+, MaxEETLPPrefixes 1
+                         EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
+                         FRS-
+                         AtomicOpsCap: 32bit+ 64bit+ 128bitCAS+
+                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
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
+        Capabilities: [700 v1] Resizable BAR <?>
+        Capabilities: [714 v1] Secondary PCI Express
+                LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
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
+        Capabilities: [d00 v1] Vendor Specific Information: ID=0040 Rev=1 Len=04c <?>
+        Capabilities: [e00 v1] CXL Designated Vendor-Specific:
+                CXLCap: Cache+ IO+ Mem+ Mem HW Init+ HDMCount 1 Viral-
+                CXLCtl: Cache+ IO+ Mem- Cache SF Cov 0 Cache SF Gran 0 Cache Clean- Viral-
+                CXLSta: Viral-
+        Capabilities: [e38 v1] Device Serial Number 12-34-56-78-90-00-00-00
+00: 86 80 93 0d 40 01 10 00 00 00 00 ff 00 00 80 00
+10: 00 00 10 b3 00 00 00 00 01 a4 00 00 00 00 00 00
+20: 08 00 00 b1 00 00 00 00 00 00 00 00 00 00 00 00
+30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
+40: 10 80 92 00 e1 8f 00 10 1f 21 00 00 00 00 00 00
+50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+60: 00 00 00 00 9f 0b 78 00 00 00 00 00 00 00 00 00
+70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+80: 05 a0 84 03 00 00 00 00 00 00 00 00 00 00 00 00
+90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a0: 01 00 13 f8 08 00 00 00 00 00 00 00 00 00 00 00
+b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+100: 01 00 01 20 00 00 00 00 00 00 10 00 10 30 46 00
+110: 00 00 00 00 00 20 00 00 e0 03 00 00 00 00 00 00
+120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+200: 08 00 01 30 00 00 00 00 01 00 00 00 00 00 00 00
+210: 01 00 00 00 ff 00 00 80 00 00 00 00 00 00 00 00
+220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+2f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+300: 09 00 01 55 00 00 00 00 00 00 00 00 00 00 00 00
+310: 00 00 00 00 ff 00 00 80 00 00 00 00 00 00 00 00
+320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+3f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+550: 12 00 81 58 3f 01 00 00 00 00 00 00 00 00 00 00
+560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+580: 00 00 00 00 00 00 00 00 18 00 01 5b 00 00 00 00
+590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5b0: 17 00 01 6e 00 03 0f 00 00 00 00 00 00 00 00 00
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
+6e0: 0f 00 01 70 80 00 00 00 00 00 00 00 00 00 00 00
+6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+700: 15 00 41 71 00 03 00 00 24 04 00 00 00 00 00 00
+710: 00 00 00 00 19 00 01 b2 00 00 00 00 00 00 00 00
+720: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f
+730: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f
+740: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+750: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
+800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+810: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+890: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
+b20: 13 00 01 b4 00 00 00 01 00 00 00 00 00 00 00 00
+b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b40: 1b 00 01 b5 06 14 00 00 00 00 00 00 00 00 00 00
+b50: 1f 00 01 d0 00 00 00 00 00 00 00 00 00 00 00 00
+b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b80: 10 00 01 d0 06 00 00 00 00 00 00 00 06 00 06 00
+b90: 06 00 00 00 02 00 02 00 00 00 52 0d 3f 00 00 00
+ba0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
+d00: 0b 00 01 e0 40 00 c1 04 00 00 80 01 00 00 00 00
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
+e00: 23 00 81 e3 86 80 80 03 00 00 1f 00 03 00 00 00
+e10: 00 00 00 00 00 00 00 00 00 00 00 00 03 01 00 08
+e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e30: 00 00 00 00 00 00 00 00 03 00 01 00 00 00 00 90
+e40: 78 56 34 12 00 00 00 00 00 00 00 00 00 00 00 00
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
2.26.2

