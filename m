Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3704B2B87EF
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 23:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgKRWt2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 17:49:28 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:39944 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgKRWt2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 17:49:28 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C53A8C00BE;
        Wed, 18 Nov 2020 22:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605739767; bh=hDnwe0PEALMr+1oFQqQQ/liIHzIi8ypTFCgoQ8vuxhc=;
        h=From:To:Cc:Subject:Date:From;
        b=W8aWYbLxGk8oFtve7rjFeib0vLZZekxIOBWAWb9FglWxKCEYCRuNQ43NzwaQJ6UuA
         opLPnHu1kKNTZpVb9TRX5OFRsZfaRnfw0FWv0HSalkpbkqPWmWE8C18SryYCPy2BY1
         ViwO4rpwKW8i8WNL+vfcjBUCPvhKmDEUaE2LLFrtC0yN4NKqUTujoDlwgD7y+0NQCs
         2y51aNcI9feD7PodK5Et9l2gVgztblPnAN+Iat5Vr1IG/OKAXeQPFenJKiOUczOrJ5
         pMdckX5iBzPld8pO1TLivA1+JJOFDvKKR1DUTQgl1lZzx6I5vW3jkm4wWhyZEUpAnX
         6gRugYH4ZLo6w==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id EAE30A005C;
        Wed, 18 Nov 2020 22:49:23 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Decode PCIe 64 GT/s link speed
Date:   Wed, 18 Nov 2020 23:49:20 +0100
Message-Id: <aaaab33fe18975e123a84aebce2adb85f44e2bbe.1605739760.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe r6.0, sec 7.5.3.18, defines a new 64.0 GT/s bit in the Supported
Link Speeds Vector of Link Capabilities 2.

This does not affect the speed of the link, which should be negotiated
automatically by the hardware; it only adds decoding when showing the
speed to the user.

This patch adds the decoding of this new speed, previously, reading the
speed of a link operating at this speed showed "Unknown speed" instead
of "64.0 GT/s".

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/pci.h             | 6 ++++--
 drivers/pci/probe.c           | 3 ++-
 include/linux/pci.h           | 1 +
 include/uapi/linux/pci_regs.h | 4 ++++
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f86cae9..81bf905 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -294,7 +294,8 @@ void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe link information from Link Capabilities 2 */
 #define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
-	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
+	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_64_0GB ? PCIE_SPEED_64_0GT : \
+	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
 	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_16_0GB ? PCIE_SPEED_16_0GT : \
 	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_8_0GB ? PCIE_SPEED_8_0GT : \
 	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_5_0GB ? PCIE_SPEED_5_0GT : \
@@ -303,7 +304,8 @@ void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
-	((speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
+	((speed) == PCIE_SPEED_64_0GT ? 64000*128/130 : \
+	 (speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
 	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
 	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
 	 (speed) == PCIE_SPEED_5_0GT  ?  5000*8/10 : \
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4289030..fe2e00f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -677,7 +677,7 @@ const unsigned char pcie_link_speed[] = {
 	PCIE_SPEED_8_0GT,		/* 3 */
 	PCIE_SPEED_16_0GT,		/* 4 */
 	PCIE_SPEED_32_0GT,		/* 5 */
-	PCI_SPEED_UNKNOWN,		/* 6 */
+	PCIE_SPEED_64_0GT,		/* 6 */
 	PCI_SPEED_UNKNOWN,		/* 7 */
 	PCI_SPEED_UNKNOWN,		/* 8 */
 	PCI_SPEED_UNKNOWN,		/* 9 */
@@ -719,6 +719,7 @@ const char *pci_speed_string(enum pci_bus_speed speed)
 	    "8.0 GT/s PCIe",		/* 0x16 */
 	    "16.0 GT/s PCIe",		/* 0x17 */
 	    "32.0 GT/s PCIe",		/* 0x18 */
+	    "64.0 GT/s PCIe",		/* 0x19 */
 	};
 
 	if (speed < ARRAY_SIZE(speed_strings))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 22207a7..e007bc3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -281,6 +281,7 @@ enum pci_bus_speed {
 	PCIE_SPEED_8_0GT		= 0x16,
 	PCIE_SPEED_16_0GT		= 0x17,
 	PCIE_SPEED_32_0GT		= 0x18,
+	PCIE_SPEED_64_0GT		= 0x19,
 	PCI_SPEED_UNKNOWN		= 0xff,
 };
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a95d55f..fe9d5db 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -531,6 +531,7 @@
 #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
 #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
 #define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
+#define  PCI_EXP_LNKCAP_SLS_64_0GB 0x00000006 /* LNKCAP2 SLS Vector bit 5 */
 #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
 #define  PCI_EXP_LNKCAP_ASPM_L0S 0x00000400 /* ASPM L0s Support */
@@ -562,6 +563,7 @@
 #define  PCI_EXP_LNKSTA_CLS_8_0GB 0x0003 /* Current Link Speed 8.0GT/s */
 #define  PCI_EXP_LNKSTA_CLS_16_0GB 0x0004 /* Current Link Speed 16.0GT/s */
 #define  PCI_EXP_LNKSTA_CLS_32_0GB 0x0005 /* Current Link Speed 32.0GT/s */
+#define  PCI_EXP_LNKSTA_CLS_64_0GB 0x0006 /* Current Link Speed 64.0GT/s */
 #define  PCI_EXP_LNKSTA_NLW	0x03f0	/* Negotiated Link Width */
 #define  PCI_EXP_LNKSTA_NLW_X1	0x0010	/* Current Link Width x1 */
 #define  PCI_EXP_LNKSTA_NLW_X2	0x0020	/* Current Link Width x2 */
@@ -670,6 +672,7 @@
 #define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_32_0GB	0x00000020 /* Supported Speed 32GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_64_0GB	0x00000040 /* Supported Speed 64GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
 #define  PCI_EXP_LNKCTL2_TLS		0x000f
@@ -678,6 +681,7 @@
 #define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_64_0GT	0x0006 /* Supported Speed 64GT/s */
 #define  PCI_EXP_LNKCTL2_ENTER_COMP	0x0010 /* Enter Compliance */
 #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
 #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
-- 
2.7.4

