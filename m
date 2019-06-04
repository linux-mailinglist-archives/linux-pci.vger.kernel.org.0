Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CE334D2B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 18:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfFDQYt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 12:24:49 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:60080 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727385AbfFDQYt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 12:24:49 -0400
Received: from mailhost.synopsys.com (unknown [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 42C65C00D6;
        Tue,  4 Jun 2019 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559665499; bh=Z5knSwzfDyOQC0KtFQddwe2paagbYdxhRAUwXuNmts0=;
        h=From:To:Cc:Subject:Date:From;
        b=Vqwh3DMGF1XYObsbOe0Wro+2QkJIMTgrEYdeWcp8507uTxa9tJD3XDutMesW8Brgp
         bj+hH+pFLmyYb7cDcqIND9n3OQ/PTSxGXzYIiXrKeSmmhJwSWb2DNb/4w/6uEEdocs
         b6/QDfHiIMh2ZnvxznZ1TeDJ32nvxKcgU/rcJQWjq42zeDVt856vuVO/Kwjrzqm0EU
         e1ELgAo6bP+DjxMQiV8Py6ANmpYJzSm1hIwYSOww/HtDWXdxs9oyVkF1MGWKkSbP6q
         tDkcmDY4Y8lXIK518K5LXmflncjmKQE9ZBeKXCKc3IaUP8i+GsN7ncKmWB9LHxitwm
         bs4NrIiAlbVbA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 03E2BA022E;
        Tue,  4 Jun 2019 16:24:45 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id DAA163D05A;
        Tue,  4 Jun 2019 18:24:45 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     bhelgaas@google.com, mj@ucw.cz, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v2] PCI: Add PCIe 5.0 data rate (32 GT/s) support
Date:   Tue,  4 Jun 2019 18:24:43 +0200
Message-Id: <92365e3caf0fc559f9ab14bcd053bfc92d4f661c.1559664969.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe 5.0 allows an effective 32.0 GT/s speed per lane.

Currently if you read a PCIe 5.0 EP link data rate through sysfs, the
resulting output will be "Unknown speed" instead of "32.0 GT/s" as we
would be expect.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Changes:
v1 -> v2
 - Rebase patch

 drivers/pci/pci-sysfs.c       | 3 +++
 drivers/pci/pci.c             | 4 +++-
 drivers/pci/probe.c           | 2 +-
 drivers/pci/slot.c            | 1 +
 include/linux/pci.h           | 1 +
 include/uapi/linux/pci_regs.h | 4 ++++
 6 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6d27475..d52d304 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -182,6 +182,9 @@ static ssize_t current_link_speed_show(struct device *dev,
 		return -EINVAL;
 
 	switch (linkstat & PCI_EXP_LNKSTA_CLS) {
+	case PCI_EXP_LNKSTA_CLS_32_0GB:
+		speed = "32 GT/s";
+		break;
 	case PCI_EXP_LNKSTA_CLS_16_0GB:
 		speed = "16 GT/s";
 		break;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8abc843..4729a7c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5621,7 +5621,9 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
 	 */
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
 	if (lnkcap2) { /* PCIe r3.0-compliant */
-		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_16_0GB)
+		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_32_0GB)
+			return PCIE_SPEED_32_0GT;
+		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_16_0GB)
 			return PCIE_SPEED_16_0GT;
 		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
 			return PCIE_SPEED_8_0GT;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0e8e2c1..c5f27c8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -668,7 +668,7 @@ const unsigned char pcie_link_speed[] = {
 	PCIE_SPEED_5_0GT,		/* 2 */
 	PCIE_SPEED_8_0GT,		/* 3 */
 	PCIE_SPEED_16_0GT,		/* 4 */
-	PCI_SPEED_UNKNOWN,		/* 5 */
+	PCIE_SPEED_32_0GT,		/* 5 */
 	PCI_SPEED_UNKNOWN,		/* 6 */
 	PCI_SPEED_UNKNOWN,		/* 7 */
 	PCI_SPEED_UNKNOWN,		/* 8 */
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index f4d92b1..ae4aa0e 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -75,6 +75,7 @@ static const char *pci_bus_speed_strings[] = {
 	"5.0 GT/s PCIe",	/* 0x15 */
 	"8.0 GT/s PCIe",	/* 0x16 */
 	"16.0 GT/s PCIe",	/* 0x17 */
+	"32.0 GT/s PCIe",	/* 0x18 */
 };
 
 static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4a5a84d..2173e6b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -258,6 +258,7 @@ enum pci_bus_speed {
 	PCIE_SPEED_5_0GT		= 0x15,
 	PCIE_SPEED_8_0GT		= 0x16,
 	PCIE_SPEED_16_0GT		= 0x17,
+	PCIE_SPEED_32_0GT		= 0x18,
 	PCI_SPEED_UNKNOWN		= 0xff,
 };
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 2716476..f28e562 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -528,6 +528,7 @@
 #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
 #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
 #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
+#define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
 #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
 #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
@@ -556,6 +557,7 @@
 #define  PCI_EXP_LNKSTA_CLS_5_0GB 0x0002 /* Current Link Speed 5.0GT/s */
 #define  PCI_EXP_LNKSTA_CLS_8_0GB 0x0003 /* Current Link Speed 8.0GT/s */
 #define  PCI_EXP_LNKSTA_CLS_16_0GB 0x0004 /* Current Link Speed 16.0GT/s */
+#define  PCI_EXP_LNKSTA_CLS_32_0GB 0x0005 /* Current Link Speed 32.0GT/s */
 #define  PCI_EXP_LNKSTA_NLW	0x03f0	/* Negotiated Link Width */
 #define  PCI_EXP_LNKSTA_NLW_X1	0x0010	/* Current Link Width x1 */
 #define  PCI_EXP_LNKSTA_NLW_X2	0x0020	/* Current Link Width x2 */
@@ -661,6 +663,7 @@
 #define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_32_0GB	0x00000020 /* Supported Speed 32GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
 #define  PCI_EXP_LNKCTL2_TLS		0x000f
@@ -668,6 +671,7 @@
 #define  PCI_EXP_LNKCTL2_TLS_5_0GT	0x0002 /* Supported Speed 5GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
-- 
2.7.4

