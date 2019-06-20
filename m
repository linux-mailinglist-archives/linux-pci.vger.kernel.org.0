Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E7C4CBFB
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 12:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfFTKdf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 06:33:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbfFTKdf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 06:33:35 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EC3BFE25D40905185C3B;
        Thu, 20 Jun 2019 18:33:32 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Thu, 20 Jun 2019 18:33:25 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>, <arm@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <joe@perches.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 1/5] lib: logic_pio: Fix RCU usage
Date:   Thu, 20 Jun 2019 18:31:52 +0800
Message-ID: <1561026716-140537-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
References: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The traversing of io_range_list with list_for_each_entry_rcu()
is not properly protected by rcu_read_lock(), so add it.

In addition, the list traversing used in logic_pio_register_range()
does not need to use the rcu variant.

Fixes: 031e3601869c ("lib: Add generic PIO mapping method")
Signed-off-by: John Garry <john.garry@huawei.com>
---
 lib/logic_pio.c | 49 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index feea48fd1a0d..761296376fbc 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -46,7 +46,7 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 	end = new_range->hw_start + new_range->size;
 
 	mutex_lock(&io_range_mutex);
-	list_for_each_entry_rcu(range, &io_range_list, list) {
+	list_for_each_entry(range, &io_range_list, list) {
 		if (range->fwnode == new_range->fwnode) {
 			/* range already there */
 			goto end_register;
@@ -108,26 +108,38 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
  */
 struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode)
 {
-	struct logic_pio_hwaddr *range;
+	struct logic_pio_hwaddr *range, *found_range = NULL;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(range, &io_range_list, list) {
-		if (range->fwnode == fwnode)
-			return range;
+		if (range->fwnode == fwnode) {
+			found_range = range;
+			break;
+		}
 	}
-	return NULL;
+	rcu_read_unlock();
+
+	return found_range;
 }
 
 /* Return a registered range given an input PIO token */
 static struct logic_pio_hwaddr *find_io_range(unsigned long pio)
 {
-	struct logic_pio_hwaddr *range;
+	struct logic_pio_hwaddr *range, *found_range = NULL;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(range, &io_range_list, list) {
-		if (in_range(pio, range->io_start, range->size))
-			return range;
+		if (in_range(pio, range->io_start, range->size)) {
+			found_range = range;
+			break;
+		}
 	}
-	pr_err("PIO entry token %lx invalid\n", pio);
-	return NULL;
+	rcu_read_unlock();
+
+	if (!found_range)
+		pr_err("PIO entry token 0x%lx invalid\n", pio);
+
+	return found_range;
 }
 
 /**
@@ -180,14 +192,23 @@ unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
 {
 	struct logic_pio_hwaddr *range;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(range, &io_range_list, list) {
 		if (range->flags != LOGIC_PIO_CPU_MMIO)
 			continue;
-		if (in_range(addr, range->hw_start, range->size))
-			return addr - range->hw_start + range->io_start;
+		if (in_range(addr, range->hw_start, range->size)) {
+			unsigned long cpuaddr;
+
+			cpuaddr = addr - range->hw_start + range->io_start;
+
+			rcu_read_unlock();
+			return cpuaddr;
+		}
 	}
-	pr_err("addr %llx not registered in io_range_list\n",
-	       (unsigned long long) addr);
+	rcu_read_unlock();
+
+	pr_err("addr %pa not registered in io_range_list\n", &addr);
+
 	return ~0UL;
 }
 
-- 
2.17.1

