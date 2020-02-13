Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E24715BDE2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 12:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgBMLkr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 06:40:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729820AbgBMLkr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Feb 2020 06:40:47 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8E8DFA3B452107E70216;
        Thu, 13 Feb 2020 19:40:42 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Feb 2020 19:40:32 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH v3 3/9] PCI: Remove PCIe suffix in pci_bus_speed_strings[]
Date:   Thu, 13 Feb 2020 19:36:27 +0800
Message-ID: <1581593793-23589-4-git-send-email-yangyicong@hisilicon.com>
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

Remove "PCIe" suffix of PCIe speed strings in
pci_bus_speed_strings[] array. For example, if we use the
array to decode link speed in __pcie_print_link_status,
it'll lead to redundancy like:
- nvme 0000:01:00.0: 16.000 Gb/s available PCIe bandwidth,
  limited by 5 GT/s x4 link at 0000:00:01.1 (capable of
  31.504 Gb/s with 8 GT/s x4 link)
+ nvme 0000:01:00.0: 16.000 Gb/s available PCIe bandwidth,
  limited by 5 GT/s PCIe x4 link at 0000:00:01.1 (capable
  of 31.504 Gb/s with 8 GT/s PCIe x4 link)

The patch introduces changes in sysfs when display
bus speed of certain slot from cur_bus_speed/max_bus_speed
in /sys/bus/pci/slots/*. It may looks like:
-/sys/bus/pci/slots/0/cur_bus_speed: 8 GT/s PCIe
+/sys/bus/pci/slots/0/cur_bus_speed: 8 GT/s
The following patch will compensate and display slot
bus speed with "PCIe" suffix as before.

[1] https://lore.kernel.org/linux-pci/20200114224909.GA19633@google.com
[2] https://lore.kernel.org/linux-pci/20200205183531.GA229621@google.com
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/probe.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4e997e7..6ce47d8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -700,11 +700,11 @@ const char *pci_bus_speed_strings[] = {
 	"66 MHz PCI-X 533",	/* 0x11 */
 	"100 MHz PCI-X 533",	/* 0x12 */
 	"133 MHz PCI-X 533",	/* 0x13 */
-	"2.5 GT/s PCIe",	/* 0x14 */
-	"5.0 GT/s PCIe",	/* 0x15 */
-	"8.0 GT/s PCIe",	/* 0x16 */
-	"16.0 GT/s PCIe",	/* 0x17 */
-	"32.0 GT/s PCIe",	/* 0x18 */
+	"2.5 GT/s",	/* 0x14 */
+	"5.0 GT/s",	/* 0x15 */
+	"8.0 GT/s",	/* 0x16 */
+	"16.0 GT/s",	/* 0x17 */
+	"32.0 GT/s",	/* 0x18 */
 };
 const int pci_bus_speed_strings_size = ARRAY_SIZE(pci_bus_speed_strings);
 
-- 
2.8.1

