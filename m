Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B15515428D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2020 12:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgBFLD3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Feb 2020 06:03:29 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48938 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727060AbgBFLD3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Feb 2020 06:03:29 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B694985F37D3CA603435;
        Thu,  6 Feb 2020 19:03:22 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 6 Feb 2020 19:03:15 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH v2 3/6] PCI: Refactor and rename PCIE_SPEED2STR macro
Date:   Thu, 6 Feb 2020 18:59:17 +0800
Message-ID: <1580986760-10182-4-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1580986760-10182-1-git-send-email-yangyicong@hisilicon.com>
References: <1580986760-10182-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use pci_bus_speed_strings[] array to refactor PCIE_SPEED2STR
macro. Rename it with PCI_SPEED2STR as it can also used to
decode non-PCIe speeds with pci_bus_speed_strings[].

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pci-sysfs.c |  2 +-
 drivers/pci/pci.c       |  6 +++---
 drivers/pci/pci.h       | 10 +++-------
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 13f766d..f4eafbc 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -156,7 +156,7 @@ static ssize_t max_link_speed_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%s\n", PCIE_SPEED2STR(pcie_get_speed_cap(pdev)));
+	return sprintf(buf, "%s\n", PCI_SPEED2STR(pcie_get_speed_cap(pdev)));
 }
 static DEVICE_ATTR_RO(max_link_speed);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3c30e72..7285fe0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5871,14 +5871,14 @@ void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
 	if (bw_avail >= bw_cap && verbose)
 		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)\n",
 			 bw_cap / 1000, bw_cap % 1000,
-			 PCIE_SPEED2STR(speed_cap), width_cap);
+			 PCI_SPEED2STR(speed_cap), width_cap);
 	else if (bw_avail < bw_cap)
 		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
 			 bw_avail / 1000, bw_avail % 1000,
-			 PCIE_SPEED2STR(speed), width,
+			 PCI_SPEED2STR(speed), width,
 			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
 			 bw_cap / 1000, bw_cap % 1000,
-			 PCIE_SPEED2STR(speed_cap), width_cap);
+			 PCI_SPEED2STR(speed_cap), width_cap);
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d2e92b0f..ba6b2cb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -295,13 +295,9 @@ struct pci_bus *pci_bus_get(struct pci_bus *bus);
 void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe link information */
-#define PCIE_SPEED2STR(speed) \
-	((speed) == PCIE_SPEED_32_0GT ? "32 GT/s" : \
-	 (speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
-	 (speed) == PCIE_SPEED_8_0GT ? "8 GT/s" : \
-	 (speed) == PCIE_SPEED_5_0GT ? "5 GT/s" : \
-	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
-	 "Unknown speed")
+#define PCI_SPEED2STR(speed) \
+	((speed) < pci_bus_speed_strings_size ? \
+	 pci_bus_speed_strings[speed] : "Unknown speed")
 
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
-- 
2.8.1

