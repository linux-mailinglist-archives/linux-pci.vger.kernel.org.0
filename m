Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F3E13BC00
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 10:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgAOJIX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 04:08:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9615 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729287AbgAOJIX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 04:08:23 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5E76482BB5391F8C9357;
        Wed, 15 Jan 2020 17:08:19 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 17:08:10 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>
Subject: [PATCH 6/6] PCI: Reduce redundancy in current_link_speed_show()
Date:   Wed, 15 Jan 2020 17:04:23 +0800
Message-ID: <1579079063-5668-7-git-send-email-yangyicong@hisilicon.com>
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

Remove switch-case statements in current_link_speed_show(). Use
pcie_link_speed[] array to get link speed and PCI_SPEED2STR macro
to get link speed string.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pci-sysfs.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f4eafbc..eaece10 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -175,33 +175,15 @@ static ssize_t current_link_speed_show(struct device *dev,
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	u16 linkstat;
 	int err;
-	const char *speed;
+	enum pci_bus_speed speed;
 
 	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
 	if (err)
 		return -EINVAL;
 
-	switch (linkstat & PCI_EXP_LNKSTA_CLS) {
-	case PCI_EXP_LNKSTA_CLS_32_0GB:
-		speed = "32 GT/s";
-		break;
-	case PCI_EXP_LNKSTA_CLS_16_0GB:
-		speed = "16 GT/s";
-		break;
-	case PCI_EXP_LNKSTA_CLS_8_0GB:
-		speed = "8 GT/s";
-		break;
-	case PCI_EXP_LNKSTA_CLS_5_0GB:
-		speed = "5 GT/s";
-		break;
-	case PCI_EXP_LNKSTA_CLS_2_5GB:
-		speed = "2.5 GT/s";
-		break;
-	default:
-		speed = "Unknown speed";
-	}
+	speed = pcie_link_speed[linkstat & PCI_EXP_LNKSTA_CLS];
 
-	return sprintf(buf, "%s\n", speed);
+	return sprintf(buf, "%s\n", PCI_SPEED2STR(speed));
 }
 static DEVICE_ATTR_RO(current_link_speed);
 
-- 
2.8.1

