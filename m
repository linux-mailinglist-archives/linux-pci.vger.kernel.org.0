Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C589C15BDDF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 12:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgBMLkq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 06:40:46 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729855AbgBMLkq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Feb 2020 06:40:46 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 837953DDD2D538B1A45C;
        Thu, 13 Feb 2020 19:40:42 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Feb 2020 19:40:31 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH v3 2/9] PCI: Make pci_bus_speed_strings[] public
Date:   Thu, 13 Feb 2020 19:36:26 +0800
Message-ID: <1581593793-23589-3-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1581593793-23589-1-git-send-email-yangyicong@hisilicon.com>
References: <1581593793-23589-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_bus_speed_strings[] in slot.c defines universal speed information.
Currently it is only used to decode bus speed in slot.c, while elsewhere
use judgement statements repeatly to decode speed information. For
example, in PCIE_SPEED2STR and current_link_speed_show() in sysfs.

Make it public and move to probe.c so that we can reuse it for decoding
speed information even if CONFIG_SYSFS is not set. Add
pci_bus_speed_strings_size for boundary check purpose, to avoid acquiring
size of an external array by ARRAY_SIZE macro.

Link:https://lore.kernel.org/linux-pci/20200205183531.GA229621@google.com/
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pci.h   |  2 ++
 drivers/pci/probe.c | 30 ++++++++++++++++++++++++++++++
 drivers/pci/slot.c  | 31 +------------------------------
 3 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f65912e..d2e92b0f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -12,6 +12,8 @@
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
 
 extern const unsigned char pcie_link_speed[];
+extern const char *pci_bus_speed_strings[];
+extern const int pci_bus_speed_strings_size;
 extern bool pci_early_dump;
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb43..4e997e7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -678,6 +678,36 @@ const unsigned char pcie_link_speed[] = {
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
+	"2.5 GT/s PCIe",	/* 0x14 */
+	"5.0 GT/s PCIe",	/* 0x15 */
+	"8.0 GT/s PCIe",	/* 0x16 */
+	"16.0 GT/s PCIe",	/* 0x17 */
+	"32.0 GT/s PCIe",	/* 0x18 */
+};
+const int pci_bus_speed_strings_size = ARRAY_SIZE(pci_bus_speed_strings);
+
 void pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
 {
 	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index ae4aa0e..fb7c172 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -49,40 +49,11 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
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
+	if (speed < pci_bus_speed_strings_size)
 		speed_string = pci_bus_speed_strings[speed];
 	else
 		speed_string = "Unknown";
-- 
2.8.1

