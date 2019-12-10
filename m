Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC9C611802D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 07:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLJGHP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 01:07:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:49460 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfLJGHO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 01:07:14 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 35A159D4EFD3133DFE18;
        Tue, 10 Dec 2019 14:07:11 +0800 (CST)
Received: from HGHY4Z004218071.china.huawei.com (10.133.224.57) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 10 Dec 2019 14:07:00 +0800
From:   Xiang Zheng <zhengxiang9@huawei.com>
To:     <bhelgaas@google.com>, <willy@infradead.org>
CC:     <zhengxiang9@huawei.com>, <wangxiongfeng2@huawei.com>,
        <wanghaibin.wang@huawei.com>, <guoheyi@huawei.com>,
        <yebiaoxiang@huawei.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <tglx@linutronix.de>, <guohanjun@huawei.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH v3] PCI: Lock the pci_cfg_wait queue for the consistency of data
Date:   Tue, 10 Dec 2019 11:15:27 +0800
Message-ID: <20191210031527.40136-1-zhengxiang9@huawei.com>
X-Mailer: git-send-email 2.15.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

7ea7e98fd8d0 ("PCI: Block on access to temporarily unavailable pci
device") suggests that the "pci_lock" is sufficient, and all the
callers of pci_wait_cfg() are wrapped with the "pci_lock".

However, since the commit cdcb33f98244 ("PCI: Avoid possible deadlock on
pci_lock and p->pi_lock") merged, the accesses to the pci_cfg_wait queue
are not safe anymore. This would cause kernel panic in a very low chance
(See more detailed information from the below link). A "pci_lock" is
insufficient and we need to hold an additional queue lock while read/write
the wait queue.

So let's use the add_wait_queue()/remove_wait_queue() instead of
__add_wait_queue()/__remove_wait_queue(). Also move the wait queue
functionality around the "schedule()" function to avoid reintroducing
the deadlock addressed by "cdcb33f98244".

Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
Cc: Heyi Guo <guoheyi@huawei.com>
Cc: Biaoxiang Ye <yebiaoxiang@huawei.com>
Link: https://lore.kernel.org/linux-pci/79827f2f-9b43-4411-1376-b9063b67aee3@huawei.com/
---

v3:
  Improve the commit subject and message.

v2:
  Move the wait queue functionality around the "schedule()".

---
 drivers/pci/access.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 2fccb5762c76..09342a74e5ea 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -207,14 +207,14 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
 {
 	DECLARE_WAITQUEUE(wait, current);
 
-	__add_wait_queue(&pci_cfg_wait, &wait);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		raw_spin_unlock_irq(&pci_lock);
+		add_wait_queue(&pci_cfg_wait, &wait);
 		schedule();
+		remove_wait_queue(&pci_cfg_wait, &wait);
 		raw_spin_lock_irq(&pci_lock);
 	} while (dev->block_cfg_access);
-	__remove_wait_queue(&pci_cfg_wait, &wait);
 }
 
 /* Returns 0 on success, negative values indicate error. */
-- 
2.19.1


