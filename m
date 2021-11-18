Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDFB455DB3
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhKROQN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:16:13 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:56331 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232816AbhKROQN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Nov 2021 09:16:13 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 8D835440EEF;
        Thu, 18 Nov 2021 16:13:08 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1637244788;
        bh=MXoQLkWXa7ftWdOIPycTA65YKc/ITRPkclu5MNbQjgs=;
        h=From:To:Cc:Subject:Date:From;
        b=Ts7sd0aizHJvHm4RThUZbV+d53gIeJ2/Fi3Irr7La7dqN2kRJVgCvedPd/9d0aka2
         u2MV7P0/Xs/wuumjb8rjtgBOnNyWszhg6ad1QDiC4rWagzhH8ls0f03gLMrqJiSdKG
         VqnKPP7U9JeYP2E+3IU7Saf1HxOvOSQX2SHHY7Iw8QWqwVw0BD1jEo5sxMCcR2tDhr
         PEnfvL7vSTRFWl0esiOJg2i/h9v8yKO1mXDr44Xjj6zUb8fhjwjLgxl3PEf+EaNGn9
         T96vUTIeiaCWCjOsqyoMlriUjXdt4GYG1XL8DYHH6j/tq5+Qhu0ogogCrFbS4Tvaps
         jupyeuWD9ZSTA==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH] PCI: Change PCIe capability registers offset to hex
Date:   Thu, 18 Nov 2021 16:13:00 +0200
Message-Id: <aa067278adacbb59a675366052714081f4980f26.1637244780.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hex notation matches the spec documents, and is less error prone.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Link: https://lore.kernel.org/r/20210825160516.GA3576414@bjorn-Precision-5520/
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 include/uapi/linux/pci_regs.h | 44 +++++++++++++++++------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ff6ccbc6efe9..81a972368f2a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -470,7 +470,7 @@
 
 /* PCI Express capability registers */
 
-#define PCI_EXP_FLAGS		2	/* Capabilities register */
+#define PCI_EXP_FLAGS		0x02	/* Capabilities register */
 #define  PCI_EXP_FLAGS_VERS	0x000f	/* Capability version */
 #define  PCI_EXP_FLAGS_TYPE	0x00f0	/* Device/Port type */
 #define   PCI_EXP_TYPE_ENDPOINT	   0x0	/* Express Endpoint */
@@ -484,7 +484,7 @@
 #define   PCI_EXP_TYPE_RC_EC	   0xa	/* Root Complex Event Collector */
 #define  PCI_EXP_FLAGS_SLOT	0x0100	/* Slot implemented */
 #define  PCI_EXP_FLAGS_IRQ	0x3e00	/* Interrupt message number */
-#define PCI_EXP_DEVCAP		4	/* Device capabilities */
+#define PCI_EXP_DEVCAP		0x04	/* Device capabilities */
 #define  PCI_EXP_DEVCAP_PAYLOAD	0x00000007 /* Max_Payload_Size */
 #define  PCI_EXP_DEVCAP_PHANTOM	0x00000018 /* Phantom functions */
 #define  PCI_EXP_DEVCAP_EXT_TAG	0x00000020 /* Extended tags */
@@ -497,7 +497,7 @@
 #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
 #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
 #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
-#define PCI_EXP_DEVCTL		8	/* Device Control */
+#define PCI_EXP_DEVCTL		0x08	/* Device Control */
 #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
 #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */
 #define  PCI_EXP_DEVCTL_FERE	0x0004	/* Fatal Error Reporting Enable */
@@ -522,7 +522,7 @@
 #define  PCI_EXP_DEVCTL_READRQ_2048B 0x4000 /* 2048 Bytes */
 #define  PCI_EXP_DEVCTL_READRQ_4096B 0x5000 /* 4096 Bytes */
 #define  PCI_EXP_DEVCTL_BCR_FLR 0x8000  /* Bridge Configuration Retry / FLR */
-#define PCI_EXP_DEVSTA		10	/* Device Status */
+#define PCI_EXP_DEVSTA		0x0a	/* Device Status */
 #define  PCI_EXP_DEVSTA_CED	0x0001	/* Correctable Error Detected */
 #define  PCI_EXP_DEVSTA_NFED	0x0002	/* Non-Fatal Error Detected */
 #define  PCI_EXP_DEVSTA_FED	0x0004	/* Fatal Error Detected */
@@ -530,7 +530,7 @@
 #define  PCI_EXP_DEVSTA_AUXPD	0x0010	/* AUX Power Detected */
 #define  PCI_EXP_DEVSTA_TRPND	0x0020	/* Transactions Pending */
 #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V1	12	/* v1 endpoints without link end here */
-#define PCI_EXP_LNKCAP		12	/* Link Capabilities */
+#define PCI_EXP_LNKCAP		0x0c	/* Link Capabilities */
 #define  PCI_EXP_LNKCAP_SLS	0x0000000f /* Supported Link Speeds */
 #define  PCI_EXP_LNKCAP_SLS_2_5GB 0x00000001 /* LNKCAP2 SLS Vector bit 0 */
 #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
@@ -549,7 +549,7 @@
 #define  PCI_EXP_LNKCAP_DLLLARC	0x00100000 /* Data Link Layer Link Active Reporting Capable */
 #define  PCI_EXP_LNKCAP_LBNC	0x00200000 /* Link Bandwidth Notification Capability */
 #define  PCI_EXP_LNKCAP_PN	0xff000000 /* Port Number */
-#define PCI_EXP_LNKCTL		16	/* Link Control */
+#define PCI_EXP_LNKCTL		0x10	/* Link Control */
 #define  PCI_EXP_LNKCTL_ASPMC	0x0003	/* ASPM Control */
 #define  PCI_EXP_LNKCTL_ASPM_L0S 0x0001	/* L0s Enable */
 #define  PCI_EXP_LNKCTL_ASPM_L1  0x0002	/* L1 Enable */
@@ -562,7 +562,7 @@
 #define  PCI_EXP_LNKCTL_HAWD	0x0200	/* Hardware Autonomous Width Disable */
 #define  PCI_EXP_LNKCTL_LBMIE	0x0400	/* Link Bandwidth Management Interrupt Enable */
 #define  PCI_EXP_LNKCTL_LABIE	0x0800	/* Link Autonomous Bandwidth Interrupt Enable */
-#define PCI_EXP_LNKSTA		18	/* Link Status */
+#define PCI_EXP_LNKSTA		0x12	/* Link Status */
 #define  PCI_EXP_LNKSTA_CLS	0x000f	/* Current Link Speed */
 #define  PCI_EXP_LNKSTA_CLS_2_5GB 0x0001 /* Current Link Speed 2.5GT/s */
 #define  PCI_EXP_LNKSTA_CLS_5_0GB 0x0002 /* Current Link Speed 5.0GT/s */
@@ -582,7 +582,7 @@
 #define  PCI_EXP_LNKSTA_LBMS	0x4000	/* Link Bandwidth Management Status */
 #define  PCI_EXP_LNKSTA_LABS	0x8000	/* Link Autonomous Bandwidth Status */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V1	20	/* v1 endpoints with link end here */
-#define PCI_EXP_SLTCAP		20	/* Slot Capabilities */
+#define PCI_EXP_SLTCAP		0x14	/* Slot Capabilities */
 #define  PCI_EXP_SLTCAP_ABP	0x00000001 /* Attention Button Present */
 #define  PCI_EXP_SLTCAP_PCP	0x00000002 /* Power Controller Present */
 #define  PCI_EXP_SLTCAP_MRLSP	0x00000004 /* MRL Sensor Present */
@@ -595,7 +595,7 @@
 #define  PCI_EXP_SLTCAP_EIP	0x00020000 /* Electromechanical Interlock Present */
 #define  PCI_EXP_SLTCAP_NCCS	0x00040000 /* No Command Completed Support */
 #define  PCI_EXP_SLTCAP_PSN	0xfff80000 /* Physical Slot Number */
-#define PCI_EXP_SLTCTL		24	/* Slot Control */
+#define PCI_EXP_SLTCTL		0x18	/* Slot Control */
 #define  PCI_EXP_SLTCTL_ABPE	0x0001	/* Attention Button Pressed Enable */
 #define  PCI_EXP_SLTCTL_PFDE	0x0002	/* Power Fault Detected Enable */
 #define  PCI_EXP_SLTCTL_MRLSCE	0x0004	/* MRL Sensor Changed Enable */
@@ -617,7 +617,7 @@
 #define  PCI_EXP_SLTCTL_EIC	0x0800	/* Electromechanical Interlock Control */
 #define  PCI_EXP_SLTCTL_DLLSCE	0x1000	/* Data Link Layer State Changed Enable */
 #define  PCI_EXP_SLTCTL_IBPD_DISABLE	0x4000 /* In-band PD disable */
-#define PCI_EXP_SLTSTA		26	/* Slot Status */
+#define PCI_EXP_SLTSTA		0x1a	/* Slot Status */
 #define  PCI_EXP_SLTSTA_ABP	0x0001	/* Attention Button Pressed */
 #define  PCI_EXP_SLTSTA_PFD	0x0002	/* Power Fault Detected */
 #define  PCI_EXP_SLTSTA_MRLSC	0x0004	/* MRL Sensor Changed */
@@ -627,15 +627,15 @@
 #define  PCI_EXP_SLTSTA_PDS	0x0040	/* Presence Detect State */
 #define  PCI_EXP_SLTSTA_EIS	0x0080	/* Electromechanical Interlock Status */
 #define  PCI_EXP_SLTSTA_DLLSC	0x0100	/* Data Link Layer State Changed */
-#define PCI_EXP_RTCTL		28	/* Root Control */
+#define PCI_EXP_RTCTL		0x1c	/* Root Control */
 #define  PCI_EXP_RTCTL_SECEE	0x0001	/* System Error on Correctable Error */
 #define  PCI_EXP_RTCTL_SENFEE	0x0002	/* System Error on Non-Fatal Error */
 #define  PCI_EXP_RTCTL_SEFEE	0x0004	/* System Error on Fatal Error */
 #define  PCI_EXP_RTCTL_PMEIE	0x0008	/* PME Interrupt Enable */
 #define  PCI_EXP_RTCTL_CRSSVE	0x0010	/* CRS Software Visibility Enable */
-#define PCI_EXP_RTCAP		30	/* Root Capabilities */
+#define PCI_EXP_RTCAP		0x1e	/* Root Capabilities */
 #define  PCI_EXP_RTCAP_CRSVIS	0x0001	/* CRS Software Visibility capability */
-#define PCI_EXP_RTSTA		32	/* Root Status */
+#define PCI_EXP_RTSTA		0x20	/* Root Status */
 #define  PCI_EXP_RTSTA_PME	0x00010000 /* PME status */
 #define  PCI_EXP_RTSTA_PENDING	0x00020000 /* PME pending */
 /*
@@ -646,7 +646,7 @@
  * Use pcie_capability_read_word() and similar interfaces to use them
  * safely.
  */
-#define PCI_EXP_DEVCAP2		36	/* Device Capabilities 2 */
+#define PCI_EXP_DEVCAP2		0x24	/* Device Capabilities 2 */
 #define  PCI_EXP_DEVCAP2_COMP_TMOUT_DIS	0x00000010 /* Completion Timeout Disable supported */
 #define  PCI_EXP_DEVCAP2_ARI		0x00000020 /* Alternative Routing-ID */
 #define  PCI_EXP_DEVCAP2_ATOMIC_ROUTE	0x00000040 /* Atomic Op routing */
@@ -658,7 +658,7 @@
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
 #define  PCI_EXP_DEVCAP2_EE_PREFIX	0x00200000 /* End-End TLP Prefix */
-#define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
+#define PCI_EXP_DEVCTL2		0x28	/* Device Control 2 */
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
 #define  PCI_EXP_DEVCTL2_ARI		0x0020	/* Alternative Routing-ID */
@@ -670,9 +670,9 @@
 #define  PCI_EXP_DEVCTL2_OBFF_MSGA_EN	0x2000	/* Enable OBFF Message type A */
 #define  PCI_EXP_DEVCTL2_OBFF_MSGB_EN	0x4000	/* Enable OBFF Message type B */
 #define  PCI_EXP_DEVCTL2_OBFF_WAKE_EN	0x6000	/* OBFF using WAKE# signaling */
-#define PCI_EXP_DEVSTA2		42	/* Device Status 2 */
+#define PCI_EXP_DEVSTA2		0x2a	/* Device Status 2 */
 #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V2	44	/* v2 endpoints without link end here */
-#define PCI_EXP_LNKCAP2		44	/* Link Capabilities 2 */
+#define PCI_EXP_LNKCAP2		0x2c	/* Link Capabilities 2 */
 #define  PCI_EXP_LNKCAP2_SLS_2_5GB	0x00000002 /* Supported Speed 2.5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
@@ -680,7 +680,7 @@
 #define  PCI_EXP_LNKCAP2_SLS_32_0GB	0x00000020 /* Supported Speed 32GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_64_0GB	0x00000040 /* Supported Speed 64GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
-#define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
+#define PCI_EXP_LNKCTL2		0x30	/* Link Control 2 */
 #define  PCI_EXP_LNKCTL2_TLS		0x000f
 #define  PCI_EXP_LNKCTL2_TLS_2_5GT	0x0001 /* Supported Speed 2.5GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_5_0GT	0x0002 /* Supported Speed 5GT/s */
@@ -691,12 +691,12 @@
 #define  PCI_EXP_LNKCTL2_ENTER_COMP	0x0010 /* Enter Compliance */
 #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
 #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
-#define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
+#define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
-#define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
+#define PCI_EXP_SLTCAP2		0x34	/* Slot Capabilities 2 */
 #define  PCI_EXP_SLTCAP2_IBPD	0x00000001 /* In-band PD Disable Supported */
-#define PCI_EXP_SLTCTL2		56	/* Slot Control 2 */
-#define PCI_EXP_SLTSTA2		58	/* Slot Status 2 */
+#define PCI_EXP_SLTCTL2		0x38	/* Slot Control 2 */
+#define PCI_EXP_SLTSTA2		0x3a	/* Slot Status 2 */
 
 /* Extended Capabilities (PCI-X 2.0 and Express) */
 #define PCI_EXT_CAP_ID(header)		(header & 0x0000ffff)
-- 
2.33.0

