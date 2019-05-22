Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F628266CA
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 17:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfEVPUy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 May 2019 11:20:54 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:41518 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729583AbfEVPUx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2019 11:20:53 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 864D2C0C7E;
        Wed, 22 May 2019 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558538439; bh=/bcjuD49lKsTnjkVz6nDkv6k+rS/ZaUmdgH6ewZe0EU=;
        h=From:To:Cc:Subject:Date:From;
        b=SitiWieSF8x0XJGTAHueZ1y6LlUaIjEtYzkrtTpvfMatODvQVqXR5XXAYLhzyXWfL
         b+bMcGIysoafJ8l4CkE+2z+YhQqqXeNj5XkukqVIVZwBV6yf5QfB4Sks6Rfm4FfnU1
         9hQcB42Tsk7YVy9I8KiWeETzdpJDE0pqIJaOdaBugryxRr2E+VDo8E8288OUddf+eY
         tBswCfZoqmaItD9jYlyKagkJX9H3BuHyKEZo+3prUIgupw7nrh8cGDHIilMWuafbhm
         2gmmjBa4A73oT+H7G4vffDM2d2FimyUicvBsGF0piiCWnj7vzhLh7sNw6E6+gR+tAS
         7Ums1EfTrKySw==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id A72D2A0097;
        Wed, 22 May 2019 15:20:52 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id D1C103F242;
        Wed, 22 May 2019 17:20:51 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH] PCI: Add PCIe 5.0 data rate (32 GT/s) support
Date:   Wed, 22 May 2019 17:20:45 +0200
Message-Id: <27294cb86bfab72fb8400291052fba9f833bed95.1558537614.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe 5.0 allows an effective 32.0 GT/s speed per lane.

Currently if you read a PCIe 5.0 EP link data rate through sysfs, the
resulting output will be "Unknown speed" instead of "32.0 GT/s" as we
would be expect.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/pci-sysfs.c       | 3 +++
 drivers/pci/pci.c             | 4 +++-
 drivers/pci/probe.c           | 2 +-
 drivers/pci/slot.c            | 1 +
 include/linux/pci.h           | 1 +
 include/uapi/linux/pci_regs.h | 4 ++++
 6 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 25794c2..3e1356b 100644
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
index 7c1b362..b1981fd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5635,7 +5635,9 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
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
index 2ec0df0..f1d9d05 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -662,7 +662,7 @@ const unsigned char pcie_link_speed[] = {
 	PCIE_SPEED_5_0GT,		/* 2 */
 	PCIE_SPEED_8_0GT,		/* 3 */
 	PCIE_SPEED_16_0GT,		/* 4 */
-	PCI_SPEED_UNKNOWN,		/* 5 */
+	PCIE_SPEED_32_0GT,		/* 5 */
 	PCI_SPEED_UNKNOWN,		/* 6 */
 	PCI_SPEED_UNKNOWN,		/* 7 */
 	PCI_SPEED_UNKNOWN,		/* 8 */
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index c46d5e1..8c48d815 100644
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
index 7744821..5fe65f6 100644
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
index 5c98133..437eded 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -524,6 +524,7 @@
 #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
 #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
 #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
+#define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
 #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
 #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
@@ -552,6 +553,7 @@
 #define  PCI_EXP_LNKSTA_CLS_5_0GB 0x0002 /* Current Link Speed 5.0GT/s */
 #define  PCI_EXP_LNKSTA_CLS_8_0GB 0x0003 /* Current Link Speed 8.0GT/s */
 #define  PCI_EXP_LNKSTA_CLS_16_0GB 0x0004 /* Current Link Speed 16.0GT/s */
+#define  PCI_EXP_LNKSTA_CLS_32_0GB 0x0005 /* Current Link Speed 32.0GT/s */
 #define  PCI_EXP_LNKSTA_NLW	0x03f0	/* Negotiated Link Width */
 #define  PCI_EXP_LNKSTA_NLW_X1	0x0010	/* Current Link Width x1 */
 #define  PCI_EXP_LNKSTA_NLW_X2	0x0020	/* Current Link Width x2 */
@@ -657,6 +659,7 @@
 #define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_32_0GB	0x00000020 /* Supported Speed 32GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
 #define PCI_EXP_LNKCTL2_TLS		0x000f
@@ -664,6 +667,7 @@
 #define PCI_EXP_LNKCTL2_TLS_5_0GT	0x0002 /* Supported Speed 5GT/s */
 #define PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
 #define PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
+#define PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
-- 
2.7.4

