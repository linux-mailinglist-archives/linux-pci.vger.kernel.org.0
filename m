Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B3D13BC01
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 10:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgAOJIY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 04:08:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729276AbgAOJIX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 04:08:23 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 54652AEECA2AAEDA986C;
        Wed, 15 Jan 2020 17:08:19 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 17:08:09 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>
Subject: [PATCH 2/6] PCI: Make pci_bus_speed_strings[] public
Date:   Wed, 15 Jan 2020 17:04:19 +0800
Message-ID: <1579079063-5668-3-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1579079063-5668-1-git-send-email-yangyicong@hisilicon.com>
References: <1579079063-5668-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_bus_speed_strings[] in slot.c defines universal speed information.
Make it public and move to probe.c so that we can use it. Remove "PCIe"
suffix of PCIe bus speed strings to reduce redundancy.

Use PCI_SPEED_UNKNOWN to judge the unknown speed condition in
bus_speed_read() in slot.c, as we cannot get array size from an external
array.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---

The reason why I don't add a boundary check is illustrated in Patch_4

 drivers/pci/pci.h   |  1 +
 drivers/pci/probe.c | 29 +++++++++++++++++++++++++++++
 drivers/pci/slot.c  | 35 +++--------------------------------
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a88c316..5fb1d76 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -9,6 +9,7 @@
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */

 extern const unsigned char pcie_link_speed[];
+extern const char *pci_bus_speed_strings[];
 extern bool pci_early_dump;

 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb43..3c70b87 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -678,6 +678,35 @@ const unsigned char pcie_link_speed[] = {
 	PCI_SPEED_UNKNOWN		/* F */
 };

+/* these strings match up with the values in pci_bus_speed */
+const char *pci_bus_speed_strings[] = {
+	"33 MHz PCI",		/* 0x00 */
+	"66 MHz PCI",		/* 0x01 */
+	"66 MHz PCI-X",		/* 0x02 */
+	"100 MHz PCI-X",	/* 0x03 */
+	"133 MHz PCI-X",	/* 0x04 */
+	NULL,			/* 0x05 */
+	NULL,			/* 0x06 */
+	NULL,			/* 0x07 */
+	NULL,			/* 0x08 */
+	"66 MHz PCI-X 266",	/* 0x09 */
+	"100 MHz PCI-X 266",	/* 0x0a */
+	"133 MHz PCI-X 266",	/* 0x0b */
+	"Unknown AGP",		/* 0x0c */
+	"1x AGP",		/* 0x0d */
+	"2x AGP",		/* 0x0e */
+	"4x AGP",		/* 0x0f */
+	"8x AGP",		/* 0x10 */
+	"66 MHz PCI-X 533",	/* 0x11 */
+	"100 MHz PCI-X 533",	/* 0x12 */
+	"133 MHz PCI-X 533",	/* 0x13 */
+	"2.5 GT/s",	/* 0x14 */
+	"5.0 GT/s",	/* 0x15 */
+	"8.0 GT/s",	/* 0x16 */
+	"16.0 GT/s",	/* 0x17 */
+	"32.0 GT/s",	/* 0x18 */
+};
+
 void pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
 {
 	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index ae4aa0e..140dafb 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -49,43 +49,14 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 				slot->number);
 }

-/* these strings match up with the values in pci_bus_speed */
-static const char *pci_bus_speed_strings[] = {
-	"33 MHz PCI",		/* 0x00 */
-	"66 MHz PCI",		/* 0x01 */
-	"66 MHz PCI-X",		/* 0x02 */
-	"100 MHz PCI-X",	/* 0x03 */
-	"133 MHz PCI-X",	/* 0x04 */
-	NULL,			/* 0x05 */
-	NULL,			/* 0x06 */
-	NULL,			/* 0x07 */
-	NULL,			/* 0x08 */
-	"66 MHz PCI-X 266",	/* 0x09 */
-	"100 MHz PCI-X 266",	/* 0x0a */
-	"133 MHz PCI-X 266",	/* 0x0b */
-	"Unknown AGP",		/* 0x0c */
-	"1x AGP",		/* 0x0d */
-	"2x AGP",		/* 0x0e */
-	"4x AGP",		/* 0x0f */
-	"8x AGP",		/* 0x10 */
-	"66 MHz PCI-X 533",	/* 0x11 */
-	"100 MHz PCI-X 533",	/* 0x12 */
-	"133 MHz PCI-X 533",	/* 0x13 */
-	"2.5 GT/s PCIe",	/* 0x14 */
-	"5.0 GT/s PCIe",	/* 0x15 */
-	"8.0 GT/s PCIe",	/* 0x16 */
-	"16.0 GT/s PCIe",	/* 0x17 */
-	"32.0 GT/s PCIe",	/* 0x18 */
-};
-
 static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
 {
 	const char *speed_string;

-	if (speed < ARRAY_SIZE(pci_bus_speed_strings))
-		speed_string = pci_bus_speed_strings[speed];
-	else
+	if (speed == PCI_SPEED_UNKNOWN)
 		speed_string = "Unknown";
+	else
+		speed_string = pci_bus_speed_strings[speed];

 	return sprintf(buf, "%s\n", speed_string);
 }
--
2.8.1

