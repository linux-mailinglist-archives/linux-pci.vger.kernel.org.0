Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D81E1744A5
	for <lists+linux-pci@lfdr.de>; Sat, 29 Feb 2020 04:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgB2DH1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 22:07:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgB2DH1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Feb 2020 22:07:27 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8792F246B4;
        Sat, 29 Feb 2020 03:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582945646;
        bh=0/zH0ZWc+6baWuppY8V6ex0SkBlyjsOp4dveaZkMadE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qa3D/0YaZmZWsQ0Gz4VQ47huTeVkFtw4t06BgsuD/F+EuRnxdnjivqXUPMJiiq0mm
         An4cX7ac7cqVn23u1shMOXuP0SegdRoX6DJ0l6B2z+ycEgPOPCCxMwbzvcuxBlv3eq
         Yh9ILseQeBCwmBALxXZtW09njqLc6nBQ82TGTtDo=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Jay Fang <f.fangjian@huawei.com>, huangdaode@huawei.com,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 2/4] PCI: Add pci_speed_string()
Date:   Fri, 28 Feb 2020 21:07:04 -0600
Message-Id: <20200229030706.17835-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200229030706.17835-1-helgaas@kernel.org>
References: <20200229030706.17835-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Add pci_speed_string() to return a text description of the supplied bus or
link speed.  The slot code previously used the private
pci_bus_speed_strings[] array for this purpose, but adding this interface
will enable us to consolidate similar code elsewhere.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h   |  1 +
 drivers/pci/probe.c | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/slot.c  | 38 +-------------------------------------
 include/linux/pci.h |  2 +-
 4 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f65912e0f30d..809753b10fad 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -310,6 +310,7 @@ void pci_bus_put(struct pci_bus *bus);
 	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
 	 0)
 
+const char *pci_speed_string(enum pci_bus_speed speed);
 enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb4312ddd..3a1aba39ad67 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -640,6 +640,7 @@ void pci_free_host_bridge(struct pci_host_bridge *bridge)
 }
 EXPORT_SYMBOL(pci_free_host_bridge);
 
+/* Indexed by PCI_X_SSTATUS_FREQ (secondary bus mode and frequency) */
 static const unsigned char pcix_bus_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* 0 */
 	PCI_SPEED_66MHz_PCIX,		/* 1 */
@@ -659,6 +660,7 @@ static const unsigned char pcix_bus_speed[] = {
 	PCI_SPEED_133MHz_PCIX_533	/* F */
 };
 
+/* Indexed by PCI_EXP_LNKCAP_SLS, PCI_EXP_LNKSTA_CLS */
 const unsigned char pcie_link_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* 0 */
 	PCIE_SPEED_2_5GT,		/* 1 */
@@ -678,6 +680,42 @@ const unsigned char pcie_link_speed[] = {
 	PCI_SPEED_UNKNOWN		/* F */
 };
 
+const char *pci_speed_string(enum pci_bus_speed speed)
+{
+	/* Indexed by the pci_bus_speed enum */
+	static const char *speed_strings[] = {
+	    "33 MHz PCI",		/* 0x00 */
+	    "66 MHz PCI",		/* 0x01 */
+	    "66 MHz PCI-X",		/* 0x02 */
+	    "100 MHz PCI-X",		/* 0x03 */
+	    "133 MHz PCI-X",		/* 0x04 */
+	    NULL,			/* 0x05 */
+	    NULL,			/* 0x06 */
+	    NULL,			/* 0x07 */
+	    NULL,			/* 0x08 */
+	    "66 MHz PCI-X 266",		/* 0x09 */
+	    "100 MHz PCI-X 266",	/* 0x0a */
+	    "133 MHz PCI-X 266",	/* 0x0b */
+	    "Unknown AGP",		/* 0x0c */
+	    "1x AGP",			/* 0x0d */
+	    "2x AGP",			/* 0x0e */
+	    "4x AGP",			/* 0x0f */
+	    "8x AGP",			/* 0x10 */
+	    "66 MHz PCI-X 533",		/* 0x11 */
+	    "100 MHz PCI-X 533",	/* 0x12 */
+	    "133 MHz PCI-X 533",	/* 0x13 */
+	    "2.5 GT/s PCIe",		/* 0x14 */
+	    "5.0 GT/s PCIe",		/* 0x15 */
+	    "8.0 GT/s PCIe",		/* 0x16 */
+	    "16.0 GT/s PCIe",		/* 0x17 */
+	    "32.0 GT/s PCIe",		/* 0x18 */
+	};
+
+	if (speed < ARRAY_SIZE(speed_strings))
+		return speed_strings[speed];
+	return "Unknown";
+}
+
 void pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
 {
 	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index ae4aa0e1f2f4..cc386ef2fa12 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -49,45 +49,9 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
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
-	const char *speed_string;
-
-	if (speed < ARRAY_SIZE(pci_bus_speed_strings))
-		speed_string = pci_bus_speed_strings[speed];
-	else
-		speed_string = "Unknown";
-
-	return sprintf(buf, "%s\n", speed_string);
+	return sprintf(buf, "%s\n", pci_speed_string(speed));
 }
 
 static ssize_t max_speed_read_file(struct pci_slot *slot, char *buf)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3840a541a9de..76f4806a154c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -236,7 +236,7 @@ enum pcie_link_width {
 	PCIE_LNK_WIDTH_UNKNOWN	= 0xff,
 };
 
-/* Based on the PCI Hotplug Spec, but some values are made up by us */
+/* See matching string table in pci_speed_string() */
 enum pci_bus_speed {
 	PCI_SPEED_33MHz			= 0x00,
 	PCI_SPEED_66MHz			= 0x01,
-- 
2.25.0.265.gbab2e86ba0-goog

