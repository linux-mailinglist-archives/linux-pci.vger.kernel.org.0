Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E60B50E9C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 16:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfFXOgk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 10:36:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727520AbfFXOgj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 10:36:39 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3B08A24D32A7364DE355;
        Mon, 24 Jun 2019 22:36:37 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Jun 2019 22:36:27 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 1/6] lib: logic_pio: Fix RCU usage
Date:   Mon, 24 Jun 2019 22:35:03 +0800
Message-ID: <1561386908-31884-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1561386908-31884-1-git-send-email-john.garry@huawei.com>
References: <1561386908-31884-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The traversing of io_range_list with list_for_each_entry_rcu()
is not properly protected by rcu_read_lock() and rcu_read_unlock(),
so add them.

These functions mark the critical section scope where the list is
protected for the reader, it cannot be  "reclaimed". Any updater - in
this case, the logical PIO registration functions - cannot update the
list until the reader exits this critical section.

In addition, the list traversing used in logic_pio_register_range()
does not need to use the rcu variant.

This is because we are already using io_range_mutex to guarantee mutual
exclusion from mutating the list.

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

