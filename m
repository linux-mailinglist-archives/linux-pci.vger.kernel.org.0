Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4161DDA5E
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 00:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgEUWkv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 18:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730329AbgEUWkv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 18:40:51 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 456CC20756;
        Thu, 21 May 2020 22:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590100846;
        bh=LCulSmVvEGpedCU5A/oowhvk6TKbx0Rgu/OGGvqwp2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VmO8whyZYns9482ZhPiLCd1hWspWkll+iRfks+Hdd0qs4JAcfo1IHlIebdOAfBs4T
         8lOikyKQGB1SPvowYs35K/neiMVMW0Uf4KxlhxnGMfiCJ1AJLDxnngTkpHCOoW7mST
         3+5aZtPXBs5PFhtAXVVIe79evHMl+iu6LVCj/ikc=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] lspci: Decode PCIe Link Capabilities 2, expand Link Status 2
Date:   Thu, 21 May 2020 17:40:29 -0500
Message-Id: <20200521224030.1193617-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521224030.1193617-1-helgaas@kernel.org>
References: <20200521224030.1193617-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Decode Link Capabilities 2, which includes the Supported Link Speeds
Vector, and decode more fields of Link Status 2.

The test case (data from https://bugzilla.kernel.org/show_bug.cgi?id=206837
comment #21) includes a Thunderbolt Downstream Port that advertises
2.5-8GT/s support in Link Capabilities 2.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 lib/header.h          |   10 +
 ls-caps.c             |   93 ++-
 tests/cap-exp-lnkcap2 | 1317 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1418 insertions(+), 2 deletions(-)
 create mode 100644 tests/cap-exp-lnkcap2

diff --git a/lib/header.h b/lib/header.h
index bfdcc80..93a6e4f 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -901,6 +901,11 @@
 #define  PCI_EXP_DEV2_OBFF(x)		(((x) >> 13) & 3) /* OBFF enabled */
 #define PCI_EXP_DEVSTA2			0x2a	/* Device Status */
 #define PCI_EXP_LNKCAP2			0x2c	/* Link Capabilities */
+#define  PCI_EXP_LNKCAP2_SPEED(x)	(((x) >> 1) & 0x7f)
+#define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink Supported */
+#define  PCI_EXP_LNKCAP2_RETIMER	0x00800000 /* Retimer Supported */
+#define  PCI_EXP_LNKCAP2_2RETIMERS	0x01000000 /* 2 Retimers Supported */
+#define  PCI_EXP_LNKCAP2_DRS		0x80000000 /* Device Readiness Status */
 #define PCI_EXP_LNKCTL2			0x30	/* Link Control */
 #define  PCI_EXP_LNKCTL2_SPEED(x)	((x) & 0xf) /* Target Link Speed */
 #define  PCI_EXP_LNKCTL2_CMPLNC		0x0010	/* Enter Compliance */
@@ -917,6 +922,11 @@
 #define  PCI_EXP_LINKSTA2_EQU_PHASE2	0x08	/* Equalization Phase 2 Successful */
 #define  PCI_EXP_LINKSTA2_EQU_PHASE3	0x10	/* Equalization Phase 3 Successful */
 #define  PCI_EXP_LINKSTA2_EQU_REQ	0x20	/* Link Equalization Request */
+#define  PCI_EXP_LINKSTA2_RETIMER	0x0040	/* Retimer Detected */
+#define  PCI_EXP_LINKSTA2_2RETIMERS	0x0080	/* 2 Retimers Detected */
+#define  PCI_EXP_LINKSTA2_CROSSLINK(x)	(((x) >> 8) & 0x3) /* Crosslink Res */
+#define  PCI_EXP_LINKSTA2_COMPONENT(x)	(((x) >> 12) & 0x7) /* Presence */
+#define  PCI_EXP_LINKSTA2_DRS_RCVD	0x8000	/* DRS Msg Received */
 #define PCI_EXP_SLTCAP2			0x34	/* Slot Capabilities */
 #define PCI_EXP_SLTCTL2			0x38	/* Slot Control */
 #define PCI_EXP_SLTSTA2			0x3a	/* Slot Status */
diff --git a/ls-caps.c b/ls-caps.c
index a6705eb..c8a8bd6 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -649,6 +649,13 @@ cap_msi(struct device *d, int where, int cap)
     }
 }
 
+static int exp_downstream_port(int type)
+{
+  return type == PCI_EXP_TYPE_ROOT_PORT ||
+	 type == PCI_EXP_TYPE_DOWNSTREAM ||
+	 type == PCI_EXP_TYPE_PCIE_BRIDGE;	/* PCI/PCI-X to PCIe Bridge */
+}
+
 static float power_limit(int value, int scale)
 {
   static const float scales[4] = { 1.0, 0.1, 0.01, 0.001 };
@@ -1151,6 +1158,29 @@ static void cap_express_dev2(struct device *d, int where, int type)
     }
 }
 
+static const char *cap_express_link2_speed_cap(int vector)
+{
+  /*
+   * Per PCIe r5.0, sec 8.2.1, a device must support 2.5GT/s and is not
+   * permitted to skip support for any data rates between 2.5GT/s and the
+   * highest supported rate.
+   */
+  if (vector & 0x60)
+    return "RsvdP";
+  if (vector & 0x10)
+    return "2.5-32GT/s";
+  if (vector & 0x08)
+    return "2.5-16GT/s";
+  if (vector & 0x04)
+    return "2.5-8GT/s";
+  if (vector & 0x02)
+    return "2.5-5GT/s";
+  if (vector & 0x01)
+    return "2.5GT/s";
+
+  return "Unknown";
+}
+
 static const char *cap_express_link2_speed(int type)
 {
   switch (type)
@@ -1202,12 +1232,59 @@ static const char *cap_express_link2_transmargin(int type)
     }
 }
 
+static const char *cap_express_link2_crosslink_res(int crosslink)
+{
+  switch (crosslink)
+    {
+      case 0:
+        return "unsupported";
+      case 1:
+        return "Upstream Port";
+      case 2:
+        return "Downstream Port";
+      default:
+        return "incomplete";
+    }
+}
+
+static const char *cap_express_link2_component(int presence)
+{
+  switch (presence)
+    {
+      case 0:
+        return "Link Down - Not Determined";
+      case 1:
+        return "Link Down - Not Present";
+      case 2:
+        return "Link Down - Present";
+      case 4:
+        return "Link Up - Present";
+      case 5:
+        return "Link Up - Present and DRS Received";
+      default:
+        return "Reserved";
+    }
+}
+
 static void cap_express_link2(struct device *d, int where, int type)
 {
+  u32 l = 0;
   u16 w;
 
   if (!((type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_LEG_END) &&
 	(d->dev->dev != 0 || d->dev->func != 0))) {
+    /* Link Capabilities 2 was reserved before PCIe r3.0 */
+    l = get_conf_long(d, where + PCI_EXP_LNKCAP2);
+    if (l) {
+      printf("\t\tLnkCap2: Supported Link Speeds: %s, Crosslink%c "
+	"Retimer%c 2Retimers%c DRS%c\n",
+	  cap_express_link2_speed_cap(PCI_EXP_LNKCAP2_SPEED(l)),
+	  FLAG(l, PCI_EXP_LNKCAP2_CROSSLINK),
+	  FLAG(l, PCI_EXP_LNKCAP2_RETIMER),
+	  FLAG(l, PCI_EXP_LNKCAP2_2RETIMERS),
+	  FLAG(l, PCI_EXP_LNKCAP2_DRS));
+    }
+
     w = get_conf_word(d, where + PCI_EXP_LNKCTL2);
     printf("\t\tLnkCtl2: Target Link Speed: %s, EnterCompliance%c SpeedDis%c",
 	cap_express_link2_speed(PCI_EXP_LNKCTL2_SPEED(w)),
@@ -1227,13 +1304,25 @@ static void cap_express_link2(struct device *d, int where, int type)
 
   w = get_conf_word(d, where + PCI_EXP_LNKSTA2);
   printf("\t\tLnkSta2: Current De-emphasis Level: %s, EqualizationComplete%c, EqualizationPhase1%c\n"
-	"\t\t\t EqualizationPhase2%c, EqualizationPhase3%c, LinkEqualizationRequest%c\n",
+	"\t\t\t EqualizationPhase2%c, EqualizationPhase3%c, LinkEqualizationRequest%c\n"
+	"\t\t\t Retimer%c 2Retimers%c CrosslinkRes: %s",
 	cap_express_link2_deemphasis(PCI_EXP_LINKSTA2_DEEMPHASIS(w)),
 	FLAG(w, PCI_EXP_LINKSTA2_EQU_COMP),
 	FLAG(w, PCI_EXP_LINKSTA2_EQU_PHASE1),
 	FLAG(w, PCI_EXP_LINKSTA2_EQU_PHASE2),
 	FLAG(w, PCI_EXP_LINKSTA2_EQU_PHASE3),
-	FLAG(w, PCI_EXP_LINKSTA2_EQU_REQ));
+	FLAG(w, PCI_EXP_LINKSTA2_EQU_REQ),
+	FLAG(w, PCI_EXP_LINKSTA2_RETIMER),
+	FLAG(w, PCI_EXP_LINKSTA2_2RETIMERS),
+	cap_express_link2_crosslink_res(PCI_EXP_LINKSTA2_CROSSLINK(w)));
+
+  if (exp_downstream_port(type) && (l & PCI_EXP_LNKCAP2_DRS)) {
+    printf(", DRS%c\n"
+	"\t\t\t DownstreamComp: %s\n",
+	FLAG(w, PCI_EXP_LINKSTA2_DRS_RCVD),
+	cap_express_link2_component(PCI_EXP_LINKSTA2_COMPONENT(w)));
+  } else
+    printf("\n");
 }
 
 static void cap_express_slot2(struct device *d UNUSED, int where UNUSED)
diff --git a/tests/cap-exp-lnkcap2 b/tests/cap-exp-lnkcap2
new file mode 100644
index 0000000..d7b159c
--- /dev/null
+++ b/tests/cap-exp-lnkcap2
@@ -0,0 +1,1317 @@
+00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 (rev f1) (prog-if 00 [Normal decode])
+	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
+	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+	Latency: 0
+	Interrupt: pin A routed to IRQ 255
+	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
+	I/O behind bridge: 0000d000-0000dfff [size=4K]
+	Memory behind bridge: e8000000-e8ffffff [size=16M]
+	Prefetchable memory behind bridge: 0000000070000000-0000000081ffffff [size=288M]
+	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
+	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
+		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
+	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
+		DevCap:	MaxPayload 256 bytes, PhantFunc 0
+			ExtTag- RBE+
+		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
+			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
+			MaxPayload 256 bytes, MaxReadReq 128 bytes
+		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
+		LnkCap:	Port #1, Speed 8GT/s, Width x4, ASPM not supported
+			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
+		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
+			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
+		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
+			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
+		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
+			Slot #0, PowerLimit 25.000W; Interlock- NoCompl+
+		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
+			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
+		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
+			Changed: MRL- PresDet+ LinkState+
+		RootCap: CRSVisible-
+		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
+		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
+		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, NROPrPrP-, LTR+
+			 10BitTagComp-, 10BitTagReq-, OBFF Not Supported, ExtFmt-, EETLPPrefix-
+			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
+			 FRS-, LN System CLS Not Supported, TPHComp-, ExtTPHComp-, ARIFwd+
+			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
+		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
+			 AtomicOpsCtl: ReqEn- EgressBlck-
+		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- DRS-
+		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
+			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
+			 Compliance De-emphasis: -6dB
+		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+, EqualizationPhase1+
+			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
+	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
+		Address: fee00238  Data: 0000
+	Capabilities: [90] Subsystem: Lenovo Device 225a
+	Capabilities: [a0] Power Management version 3
+		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
+		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
+	Capabilities: [100 v1] Advanced Error Reporting
+		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
+		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
+		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
+		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
+			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
+		HeaderLog: 00000000 00000000 00000000 00000000
+		RootCmd: CERptEn- NFERptEn- FERptEn-
+		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
+			 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
+		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
+	Capabilities: [140 v1] Access Control Services
+		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
+		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
+	Capabilities: [200 v1] L1 PM Substates
+		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
+			  PortCommonModeRestoreTime=40us PortTPowerOnTime=44us
+		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
+			   T_CommonMode=255us LTR1.2_Threshold=163840ns
+		L1SubCtl2: T_PwrOn=44us
+	Capabilities: [220 v1] Secondary PCI Express
+		LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
+		LaneErrStat: 0
+00: 86 80 10 9d 07 04 10 00 f1 00 04 06 00 00 81 00
+10: 00 00 00 00 00 00 00 00 00 02 02 00 d0 d0 00 20
+20: 00 e8 f0 e8 01 70 f1 81 00 00 00 00 00 00 00 00
+30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 02 00
+40: 10 80 42 01 01 80 00 00 20 00 10 00 43 40 72 01
+50: 40 00 43 70 00 fd 04 00 00 00 48 01 08 00 00 00
+60: 00 00 00 00 37 08 00 00 00 04 00 00 0e 00 00 00
+70: 03 00 1f 00 00 00 00 00 00 00 00 00 00 00 00 00
+80: 05 90 01 00 38 02 e0 fe 00 00 00 00 00 00 00 00
+90: 0d a0 00 00 aa 17 5a 22 00 00 00 00 00 00 00 00
+a0: 01 00 03 c8 00 00 00 00 00 00 00 00 00 00 00 00
+b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d0: 11 10 00 07 42 18 00 00 08 00 9e 09 00 00 00 00
+e0: 00 f7 f3 00 00 00 00 00 06 80 12 00 00 00 00 00
+f0: 50 01 00 00 00 03 00 40 b3 0f 41 08 04 c0 00 01
+100: 01 00 01 14 00 00 00 00 00 00 01 00 11 00 06 00
+110: 00 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00
+120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+140: 0d 00 01 20 0f 00 00 00 00 00 00 00 00 00 00 00
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
+200: 1e 00 01 22 1f 28 b0 00 0f ff a0 40 b0 00 00 00
+210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+220: 19 00 01 00 00 00 00 00 00 00 00 00 77 75 77 75
+230: 77 75 77 75 00 00 00 00 00 00 00 00 00 00 00 00
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
+300: a7 5f b7 00 97 0c c0 1b 00 00 00 00 00 00 00 00
+310: 00 00 00 00 38 3f 70 7e 00 00 14 14 d9 23 6a 05
+320: db 60 d9 69 a0 60 6f 08 89 f0 38 33 88 60 88 00
+330: 16 00 00 2a bc b5 bc 4a 72 01 00 30 00 00 00 00
+340: 01 00 01 00 41 01 51 00 40 01 30 00 16 00 88 00
+350: 1e 00 c8 00 01 00 30 00 00 00 00 00 00 00 00 00
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
+410: 00 00 00 00 00 00 00 00 30 09 00 00 00 00 00 00
+420: 47 81 ac e2 f0 59 00 00 28 00 00 00 55 55 15 14
+430: 54 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+450: 80 11 80 01 86 40 08 88 82 20 28 02 00 00 00 00
+460: 00 00 00 00 1a 17 0f 00 00 0e 00 40 00 00 00 00
+470: 00 00 00 00 00 00 00 00 2c 3d 00 28 02 40 04 00
+480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+500: 18 80 6c 00 85 06 18 1c 00 01 02 00 dd 00 70 04
+510: c0 35 18 18 04 b1 15 00 16 a0 00 00 0a 20 14 3c
+520: 18 80 6c 00 85 06 18 1c 00 01 02 00 dd 00 70 04
+530: c0 35 18 18 04 b1 15 00 16 a0 00 00 0a 20 14 3c
+540: 18 80 6c 00 85 06 18 1c 00 01 02 00 dd 00 70 04
+550: c0 35 18 18 04 b1 15 00 16 a0 00 00 0a 20 14 3c
+560: 18 80 6c 00 85 06 18 1c 00 01 02 00 dd 00 70 04
+570: c0 35 18 18 04 b1 15 00 16 a0 00 00 0a 20 14 3c
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
+800: 00 00 00 00 03 00 00 00 01 00 00 00 00 00 00 00
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
+900: 06 b0 c4 0c 96 0f 64 07 00 00 00 00 00 00 00 00
+910: 00 00 00 00 00 00 00 00 00 00 06 40 00 00 00 00
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
+02:00.0 3D controller: NVIDIA Corporation GP108M [GeForce MX150] (rev a1)
+	Subsystem: Lenovo Device 225b
+	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+	Latency: 0
+	Interrupt: pin A routed to IRQ 255
+	Region 0: Memory at e8000000 (32-bit, non-prefetchable)
+	Region 1: Memory at 70000000 (64-bit, prefetchable)
+	Region 3: Memory at 80000000 (64-bit, prefetchable)
+	Region 5: I/O ports at d000 [disabled]
+	Expansion ROM at fff80000 [disabled]
+	Capabilities: [60] Power Management version 3
+		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
+		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
+	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
+		Address: 0000000000000000  Data: 0000
+	Capabilities: [78] Express (v2) Endpoint, MSI 00
+		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
+			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 25.000W
+		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
+			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
+			MaxPayload 256 bytes, MaxReadReq 512 bytes
+		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
+		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <1us, L1 <4us
+			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
+		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
+			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
+		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
+			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
+		DevCap2: Completion Timeout: Range AB, TimeoutDis+, NROPrPrP-, LTR+
+			 10BitTagComp-, 10BitTagReq-, OBFF Via message, ExtFmt-, EETLPPrefix-
+			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
+			 FRS-, TPHComp-, ExtTPHComp-
+		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
+			 AtomicOpsCtl: ReqEn-
+		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- DRS-
+		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
+			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
+			 Compliance De-emphasis: -6dB
+		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
+			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
+	Capabilities: [100 v1] Virtual Channel
+		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
+		Arb:	Fixed- WRR32- WRR64- WRR128-
+		Ctrl:	ArbSelect=Fixed
+		Status:	InProgress-
+		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
+			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
+			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
+			Status:	NegoPending- InProgress-
+	Capabilities: [250 v1] Latency Tolerance Reporting
+		Max snoop latency: 3145728ns
+		Max no snoop latency: 3145728ns
+	Capabilities: [258 v1] L1 PM Substates
+		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
+			  PortCommonModeRestoreTime=255us PortTPowerOnTime=10us
+		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
+			   T_CommonMode=0us LTR1.2_Threshold=0ns
+		L1SubCtl2: T_PwrOn=10us
+	Capabilities: [128 v1] Power Budgeting <?>
+	Capabilities: [420 v2] Advanced Error Reporting
+		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
+		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
+		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
+		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
+			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
+		HeaderLog: 00000000 00000000 00000000 00000000
+	Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
+	Capabilities: [900 v1] Secondary PCI Express
+		LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
+		LaneErrStat: 0
+00: de 10 10 1d 06 00 10 00 a1 00 02 03 00 00 00 00
+10: 00 00 00 e8 0c 00 00 70 00 00 00 00 0c 00 00 80
+20: 00 00 00 00 01 d0 00 00 00 00 00 00 aa 17 5b 22
+30: 00 00 f8 ff 60 00 00 00 00 00 00 00 ff 01 00 00
+40: aa 17 5b 22 00 00 00 00 00 00 00 00 00 00 00 00
+50: 00 00 00 00 01 00 00 00 ce d6 23 00 00 00 00 00
+60: 01 68 03 00 08 00 00 00 05 78 80 00 00 00 00 00
+70: 00 00 00 00 00 00 00 00 10 00 02 00 e1 8d e8 07
+80: 30 29 09 00 43 4c 45 00 40 01 43 10 00 00 00 00
+90: 00 00 00 00 00 00 00 00 00 00 00 00 13 08 04 00
+a0: 00 04 00 00 0e 00 00 00 03 00 1e 00 00 00 00 00
+b0: 00 00 00 00 09 00 14 01 00 00 00 00 00 00 00 00
+c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+100: 02 00 01 25 00 00 00 00 00 00 00 00 00 00 00 00
+110: 00 00 00 00 ff 00 00 80 00 00 00 00 00 00 00 00
+120: 00 00 00 00 00 00 00 00 04 00 01 42 00 00 00 00
+130: 21 81 07 00 00 00 00 00 00 00 00 00 00 00 00 00
+140: 00 00 00 00 10 00 00 00 00 00 00 00 1b 00 00 0b
+150: 95 01 00 e0 20 71 50 06 00 00 00 00 21 81 07 00
+160: 21 81 05 00 02 80 03 00 02 80 01 00 06 80 1f 00
+170: 06 80 1d 00 00 00 00 00 00 00 00 00 00 00 00 00
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
+250: 18 00 81 25 03 10 03 10 1e 00 81 12 1f ff 28 00
+260: 00 00 00 00 28 00 00 00 00 00 00 00 00 00 00 00
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
+410: 00 00 00 00 00 00 00 00 00 00 00 00 00 05 34 00
+420: 01 00 02 60 00 00 00 00 00 00 00 00 30 20 46 00
+430: 00 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00
+440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+470: 00 00 00 00 00 00 00 00 00 00 00 00 f4 d1 07 00
+480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03
+4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+4c0: 03 03 18 00 00 00 00 00 00 00 00 00 30 30 40 01
+4d0: 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00
+4e0: 00 00 00 00 ff ff ff 00 00 00 00 00 fe ff 03 00
+4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+500: 00 00 00 00 00 00 00 00 00 30 00 00 00 00 00 00
+510: 00 00 00 00 00 30 00 00 00 00 00 00 0f 00 00 00
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
+600: 0b 00 01 90 01 00 41 02 02 00 41 01 01 18 00 00
+610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+650: 00 00 00 00 00 00 00 00 37 0f 00 00 00 00 00 00
+660: 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+700: fe 0f 02 00 00 00 00 00 8d e0 00 00 48 00 10 00
+710: 00 00 00 02 0a 48 00 00 a2 80 14 00 00 00 00 00
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
+800: 00 06 00 00 00 06 00 00 f0 f0 2c 00 00 00 00 00
+810: cc 2c 00 00 00 00 00 00 00 00 00 00 01 00 00 00
+820: 21 04 00 00 01 01 00 00 01 00 01 00 01 b0 07 00
+830: 21 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
+840: 00 00 00 00 44 08 00 00 00 00 00 40 00 00 e0 00
+850: 00 00 00 00 03 00 00 00 ff 3f 00 00 00 00 00 00
+860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+890: 00 00 00 00 00 00 00 00 ff ff 00 00 00 00 00 00
+8a0: 00 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff
+8b0: 00 00 00 00 1b 00 00 7d 1b 00 c0 8e 00 00 00 00
+8c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+8d0: 00 00 00 00 00 00 00 00 00 00 00 00 68 55 01 00
+8e0: 00 00 00 00 5a 00 00 00 10 10 10 00 02 20 20 00
+8f0: 88 38 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+900: 19 00 01 00 00 00 00 00 00 00 00 00 00 75 00 75
+910: 00 75 00 75 00 00 00 00 00 00 00 00 00 00 00 00
+920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+940: 00 00 00 00 00 00 00 00 ff 00 00 00 00 00 00 00
+950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f4 01
+9d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+9f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a00: 01 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a10: fa 04 fa 04 fa 04 fa 04 0f 00 00 00 00 00 00 00
+a20: 00 06 00 00 00 00 00 00 00 00 00 80 00 00 00 00
+a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a60: 00 00 00 00 00 00 00 00 1f ff 28 00 21 00 00 00
+a70: 21 00 00 00 25 01 00 00 00 00 00 00 00 00 00 00
+a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+aa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ab0: 00 00 00 00 ff 00 00 00 00 00 00 00 00 00 00 00
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
+08:00.0 PCI bridge: Intel Corporation JHL6240 Thunderbolt 3 Bridge (Low Power) [Alpine Ridge LP 2016] (rev 01) (prog-if 00 [Normal decode])
+	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
+	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+	Latency: 0, Cache Line Size: 128 bytes
+	Interrupt: pin A routed to IRQ 255
+	Bus: primary=08, secondary=09, subordinate=09, sec-latency=0
+	I/O behind bridge: [disabled]
+	Memory behind bridge: e6000000-e60fffff [size=1M]
+	Prefetchable memory behind bridge: [disabled]
+	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
+	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
+		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
+	Capabilities: [80] Power Management version 3
+		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
+		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
+	Capabilities: [88] MSI: Enable+ Count=1/1 Maskable- 64bit+
+		Address: 00000000fee002b8  Data: 0000
+	Capabilities: [ac] Subsystem: Device 2222:1111
+	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
+		DevCap:	MaxPayload 128 bytes, PhantFunc 0
+			ExtTag+ RBE+
+		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
+			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
+			MaxPayload 128 bytes, MaxReadReq 512 bytes
+		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
+		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <2us, L1 <4us
+			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
+		LnkCtl:	ASPM Disabled; Disabled- CommClk+
+			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
+		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
+			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
+		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
+			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
+		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
+			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
+		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
+			Changed: MRL- PresDet+ LinkState-
+		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, NROPrPrP-, LTR+
+			 10BitTagComp-, 10BitTagReq-, OBFF Not Supported, ExtFmt-, EETLPPrefix-
+			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
+			 FRS-, ARIFwd-
+			 AtomicOpsCap: Routing-
+		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
+			 AtomicOpsCtl: EgressBlck-
+		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- DRS-
+		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
+			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
+			 Compliance De-emphasis: -6dB
+		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
+			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
+	Capabilities: [100 v1] Device Serial Number 21-df-cc-fa-34-c9-a0-00
+	Capabilities: [200 v1] Advanced Error Reporting
+		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
+		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
+		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
+		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
+			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
+		HeaderLog: 00000000 00000000 00000000 00000000
+	Capabilities: [300 v1] Virtual Channel
+		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
+		Arb:	Fixed- WRR32- WRR64- WRR128-
+		Ctrl:	ArbSelect=Fixed
+		Status:	InProgress-
+		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
+			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
+			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
+			Status:	NegoPending- InProgress-
+	Capabilities: [400 v1] Power Budgeting <?>
+	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=0e0 <?>
+	Capabilities: [700 v1] Secondary PCI Express
+		LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
+		LaneErrStat: 0
+00: 86 80 c0 15 06 04 10 00 01 00 04 06 20 00 01 00
+10: 00 00 00 00 00 00 00 00 08 09 09 00 f1 01 00 00
+20: 00 e6 00 e6 f1 ff 01 00 00 00 00 00 00 00 00 00
+30: 00 00 00 00 80 00 00 00 00 00 00 00 ff 01 02 00
+40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+80: 01 88 c3 ff 08 00 00 00 05 ac 81 00 b8 02 e0 fe
+90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a0: 00 00 00 00 00 00 00 00 00 00 00 00 0d c0 00 00
+b0: 22 22 11 11 00 00 00 00 00 00 00 00 00 00 00 00
+c0: 10 00 62 01 20 80 00 00 10 29 10 00 41 5c 61 00
+d0: 40 00 41 10 00 00 04 00 00 00 48 00 00 00 00 00
+e0: 00 00 00 00 00 08 00 00 00 04 00 00 0e 00 00 00
+f0: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
+100: 03 00 01 20 00 a0 c9 34 fa cc df 21 00 00 00 00
+110: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
+200: 01 00 01 30 00 00 00 00 00 00 00 00 10 20 46 00
+210: 00 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00
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
+300: 02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00
+310: 01 00 00 00 ff 00 00 80 00 00 00 00 00 00 00 00
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
+400: 04 00 01 50 00 00 00 00 00 82 07 00 00 00 00 00
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
+500: 0b 00 01 70 34 12 01 0e 50 09 b0 0c b9 06 78 0c
+510: 00 38 00 00 00 00 00 00 00 00 00 00 32 02 10 00
+520: ef d3 00 40 00 00 00 00 f0 f0 30 c1 00 00 30 00
+530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+550: 09 08 00 00 08 01 00 00 00 00 00 00 00 00 00 00
+560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+590: 08 00 a8 01 00 00 00 00 00 00 00 00 00 00 00 00
+5a0: 00 00 00 00 00 00 00 00 00 00 00 00 38 24 01 00
+5b0: 08 40 00 84 00 00 05 01 34 03 00 f0 06 20 01 00
+5c0: 00 00 08 40 06 00 00 01 90 00 08 1b 00 08 80 08
+5d0: 80 7f 08 00 00 00 00 00 00 1e 40 00 0f 00 00 00
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
+700: 19 00 01 00 00 00 00 00 00 00 00 00 07 07 07 07
+710: 07 07 07 07 00 00 00 00 00 00 00 00 00 00 00 00
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
+09:00.0 System peripheral: Intel Corporation JHL6240 Thunderbolt 3 NHI (Low Power) [Alpine Ridge LP 2016] (rev 01)
+	Subsystem: Device 2222:1111
+	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
+	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+	Latency: 0, Cache Line Size: 128 bytes
+	Interrupt: pin A routed to IRQ 255
+	Region 0: Memory at e6000000 (32-bit, non-prefetchable)
+	Region 1: Memory at e6040000 (32-bit, non-prefetchable)
+	Capabilities: [80] Power Management version 3
+		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
+		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
+	Capabilities: [88] MSI: Enable- Count=1/1 Maskable- 64bit+
+		Address: 0000000000000000  Data: 0000
+	Capabilities: [c0] Express (v2) Endpoint, MSI 00
+		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <8us
+			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
+		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
+			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
+			MaxPayload 128 bytes, MaxReadReq 512 bytes
+		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
+		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <2us, L1 <4us
+			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
+		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
+			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
+		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
+			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
+		DevCap2: Completion Timeout: Range B, TimeoutDis+, NROPrPrP-, LTR+
+			 10BitTagComp-, 10BitTagReq-, OBFF Not Supported, ExtFmt-, EETLPPrefix-
+			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
+			 FRS-, TPHComp-, ExtTPHComp-
+		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
+			 AtomicOpsCtl: ReqEn-
+		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
+			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
+			 Compliance De-emphasis: -6dB
+		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
+			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
+	Capabilities: [a0] MSI-X: Enable+ Count=16 Masked-
+		Vector table: BAR=1 offset=00000000
+		PBA: BAR=1 offset=00000fa0
+	Capabilities: [100 v1] Device Serial Number 21-df-cc-fa-34-c9-a0-00
+	Capabilities: [200 v1] Advanced Error Reporting
+		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
+		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
+		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
+		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
+			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
+		HeaderLog: 00000000 00000000 00000000 00000000
+	Capabilities: [300 v1] Virtual Channel
+		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
+		Arb:	Fixed- WRR32- WRR64- WRR128-
+		Ctrl:	ArbSelect=Fixed
+		Status:	InProgress-
+		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
+			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
+			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
+			Status:	NegoPending- InProgress-
+	Capabilities: [400 v1] Power Budgeting <?>
+	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=088 <?>
+	Capabilities: [600 v1] Latency Tolerance Reporting
+		Max snoop latency: 3145728ns
+		Max no snoop latency: 3145728ns
+00: 86 80 bf 15 06 04 10 00 01 00 80 08 20 00 00 00
+10: 00 00 00 e6 00 00 04 e6 00 00 00 00 00 00 00 00
+20: 00 00 00 00 00 00 00 00 00 00 00 00 22 22 11 11
+30: 00 00 00 00 80 00 00 00 00 00 00 00 ff 01 00 00
+40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+80: 01 88 c3 ff 08 00 00 00 05 c0 80 00 00 00 00 00
+90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a0: 11 00 0f 80 01 00 00 00 a1 0f 00 00 00 00 00 00
+b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c0: 10 a0 02 00 a0 87 00 00 10 29 10 00 41 5c 05 00
+d0: 40 01 41 10 00 00 00 00 00 00 00 00 00 00 00 00
+e0: 00 00 00 00 12 08 00 00 00 04 00 00 00 00 00 00
+f0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
+100: 03 00 01 20 00 a0 c9 34 fa cc df 21 00 00 00 00
+110: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
+200: 01 00 01 30 00 00 00 00 00 00 00 00 30 20 06 00
+210: 00 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00
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
+300: 02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00
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
+400: 04 00 01 50 00 00 00 00 00 82 07 00 00 00 00 00
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
+500: 0b 00 01 60 34 12 81 08 50 09 b0 0c b9 06 18 08
+510: 00 38 00 01 00 00 00 00 00 00 00 00 23 02 10 00
+520: ff d3 00 40 11 00 95 00 30 02 00 c0 00 00 00 00
+530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+560: 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00
+570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+600: 18 00 01 00 03 10 03 10 00 00 00 00 00 00 00 00
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
2.25.1

