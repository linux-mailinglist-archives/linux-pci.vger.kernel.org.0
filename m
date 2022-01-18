Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E41492C3F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 18:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346665AbiARRZV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jan 2022 12:25:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4428 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243633AbiARRZT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jan 2022 12:25:19 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JdbDg06yDz67Vhh;
        Wed, 19 Jan 2022 01:22:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 18 Jan 2022 18:25:16 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 18 Jan 2022 17:25:16 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: [PATCH 1/1] pciutils: Add decode support for Data Object Exchange Extended Capability
Date:   Tue, 18 Jan 2022 17:25:15 +0000
Message-ID: <20220118172515.18839-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI Data Object Exchange [1] provides a mailbox interface used as the
transport for various protocols defined by PCI-SIG and others. Make the
limited information in config space available. Note the Read/Write
Mailbox registers themselves are not currently parsed as the usefulness
of accessing one dword of a protocol is probably limited.

In future, operating systems may provide means to safely query the
supported protocols, but those have not yet been defined.

Example output:

Capabilities: [190 v1] Data Object Exchange
                DOECap: IntSup:+
                        Interrupt Message Number: 001
                DOECtl: IntEn:-
                DOESta: Busy:- IntSta:- Error:- ObjectReady:-
		
[1] Data Object Exchange (DOE) ECN, approved 12 March 2020

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

 lib/header.h  |  15 +++
 ls-ecaps.c    |  38 +++++++
 tests/cap-doe | 302 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 355 insertions(+)

diff --git a/lib/header.h b/lib/header.h
index d4b40aa..85414bc 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -252,6 +252,7 @@
 #define PCI_EXT_CAP_ID_LMR	0x27	/* Lane Margining at Receiver */
 #define PCI_EXT_CAP_ID_HIER_ID	0x28	/* Hierarchy ID */
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
+#define PCI_EXT_CAP_ID_DOE	0x2e	/* Data Object Exchange */
 
 /*** Definitions of capabilities ***/
 
@@ -1253,6 +1254,20 @@
 #define  PCI_L1PM_SUBSTAT_CTL1_ASPM_L11	0x8	/* ASPM L1.1 Enable */
 #define PCI_L1PM_SUBSTAT_CTL2	0xC	/* L1 PM Substate Control 2 */
 
+/* Data Object Exchange Extended Capability */
+#define PCI_DOE_CAP		0x4	/* DOE Capabilities Register */
+#define  PCI_DOE_CAP_INT_SUPP		0x1	/* Interrupt Support */
+#define  PCI_DOE_CAP_INT_MSG(x) (((x) >> 1) & 0x7ff) /* DOE Interrupt Message Number */
+#define PCI_DOE_CTL		0x8	/* DOE Control Register */
+#define  PCI_DOE_CTL_ABORT		0x1	/* DOE Abort */
+#define  PCI_DOE_CTL_INT		0x2	/* DOE Interrupt Enable */
+#define  PCI_DOE_CTL_GO			0x80000000 /* DOE Go */
+#define PCI_DOE_STS		0xC	/* DOE Status Register */
+#define  PCI_DOE_STS_BUSY		0x1	/* DOE Busy */
+#define  PCI_DOE_STS_INT		0x2	/* DOE Interrupt Status */
+#define  PCI_DOE_STS_ERROR		0x3	/* DOE Error */
+#define  PCI_DOE_STS_OBJECT_READY	0x80000000 /* Data Object Ready */
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 99c55ff..dd328c3 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -992,6 +992,41 @@ cap_rebar(struct device *d, int where, int virtual)
     }
 }
 
+static void
+cap_doe(struct device *d, int where)
+{
+  u32 l;
+
+  printf("Data Object Exchange\n");
+
+  if (verbose < 2)
+    return;
+
+  if (!config_fetch(d, where + PCI_DOE_CAP, 0x14))
+    {
+      printf("\t\t<unreadable>\n");
+      return;
+    }
+
+  l = get_conf_long(d, where + PCI_DOE_CAP);
+  printf("\t\tDOECap: IntSup:%c\n",
+	 FLAG(l, PCI_DOE_CAP_INT_SUPP));
+  if (l & PCI_DOE_CAP_INT_SUPP)
+    printf("\t\t\tInterrupt Message Number: %03x\n",
+	   PCI_DOE_CAP_INT_MSG(l));
+
+  l = get_conf_long(d, where + PCI_DOE_CTL);
+  printf("\t\tDOECtl: IntEn:%c\n",
+	 FLAG(l, PCI_DOE_CTL_INT));
+
+  l = get_conf_long(d, where + PCI_DOE_STS);
+  printf("\t\tDOESta: Busy:%c IntSta:%c Error:%c ObjectReady:%c\n",
+	 FLAG(l, PCI_DOE_STS_BUSY),
+	 FLAG(l, PCI_DOE_STS_INT),
+	 FLAG(l, PCI_DOE_STS_ERROR),
+	 FLAG(l, PCI_DOE_STS_OBJECT_READY));
+}
+
 void
 show_ext_caps(struct device *d, int type)
 {
@@ -1139,6 +1174,9 @@ show_ext_caps(struct device *d, int type)
 	  case PCI_EXT_CAP_ID_NPEM:
 	    printf("Native PCIe Enclosure Management <?>\n");
 	    break;
+	  case PCI_EXT_CAP_ID_DOE:
+	    cap_doe(d, where);
+	    break;
 	  default:
 	    printf("Extended Capability ID %#02x\n", id);
 	    break;
diff --git a/tests/cap-doe b/tests/cap-doe
new file mode 100644
index 0000000..4edc3e7
--- /dev/null
+++ b/tests/cap-doe
@@ -0,0 +1,302 @@
+df:00.0 Memory controller [0502]: Intel Corporation Device 0d93 (rev 01) (prog-if 10)
+	Subsystem: Red Hat, Inc. Device 1100
+	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+	Interrupt: pin ? routed to IRQ 255
+	Region 0: Memory at 10800000 (64-bit, non-prefetchable) [disabled]
+	Region 2: Memory at 10810000 (64-bit, non-prefetchable) [disabled]
+	Region 4: Memory at 10811000 (32-bit, non-prefetchable) [disabled]
+	Capabilities: [40] MSI-X: Enable- Count=2 Masked-
+		Vector table: BAR=4 offset=00000000
+		PBA: BAR=4 offset=00000800
+	Capabilities: [80] Express (v2) Endpoint, MSI 00
+		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
+			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0W
+		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
+			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
+			MaxPayload 128 bytes, MaxReadReq 128 bytes
+		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
+		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <64ns
+			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
+		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
+			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
+		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
+			TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
+		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
+			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 4
+			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
+			 FRS- TPHComp- ExtTPHComp-
+		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled,
+			 AtomicOpsCtl: ReqEn-
+		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
+			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
+			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
+		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
+			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
+			 Retimer- 2Retimers- CrosslinkRes: unsupported
+	Capabilities: [100 v1] Data Object Exchange
+		DOECap: IntSup:+
+			Interrupt Message Number: 001
+		DOECtl: IntEn:+
+		DOESta: Busy:- IntSta:- Error:- ObjectReady:+
+	Capabilities: [130 v1] Data Object Exchange
+		DOECap: IntSup:-
+		DOECtl: IntEn:-
+		DOESta: Busy:- IntSta:- Error:- ObjectReady:-
+00: 86 80 93 0d 00 00 10 00 01 10 02 05 00 00 00 00
+10: 04 00 80 10 00 00 00 00 04 00 81 10 00 00 00 00
+20: 00 10 81 10 00 00 00 00 00 00 00 00 f4 1a 00 11
+30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 00 00 00
+40: 11 80 01 00 04 00 00 00 04 08 00 00 00 00 00 00
+50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+80: 10 00 02 00 00 80 00 00 00 00 00 00 11 04 00 00
+90: 00 00 11 00 00 00 00 00 00 00 00 00 00 00 00 00
+a0: 00 00 00 00 00 00 30 00 00 00 00 00 00 00 00 00
+b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+100: 2e 00 01 13 03 00 00 00 02 00 00 00 00 00 00 80
+110: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+130: 2e 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
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
+200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
+300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
+550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
+700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+710: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+720: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+730: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
+b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
+
-- 
2.19.1

