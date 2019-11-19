Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40A8A10108D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 02:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfKSBQc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 20:16:32 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:34018 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726775AbfKSBQc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 20:16:32 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 019D6627C3C33EB3DB28;
        Tue, 19 Nov 2019 09:16:29 +0800 (CST)
Received: from HGHY4Z004218071.china.huawei.com (10.133.224.57) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 19 Nov 2019 09:16:20 +0800
From:   Xiang Zheng <zhengxiang9@huawei.com>
To:     <bhelgaas@google.com>, <willy@infradead.org>
CC:     <zhengxiang9@huawei.com>, <wangxiongfeng2@huawei.com>,
        <wanghaibin.wang@huawei.com>, <guoheyi@huawei.com>,
        <yebiaoxiang@huawei.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <tglx@linutronix.de>, <guohanjun@huawei.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH v2] pci: lock the pci_cfg_wait queue for the consistency of data
Date:   Tue, 19 Nov 2019 09:15:45 +0800
Message-ID: <20191119011545.15408-1-zhengxiang9@huawei.com>
X-Mailer: git-send-email 2.15.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit "7ea7e98fd8d0" suggests that the "pci_lock" is sufficient,
and all the callers of pci_wait_cfg() are wrapped with the "pci_lock".

However, since the commit "cdcb33f98244" merged, the accesses to
the pci_cfg_wait queue are not safe anymore. A "pci_lock" is
insufficient and we need to hold an additional queue lock while
read/write the wait queue.

So let's use the add_wait_queue()/remove_wait_queue() instead of
__add_wait_queue()/__remove_wait_queue(). Also move the wait queue
functionality around the "schedule()" function to avoid reintroducing
the deadlock addressed by "cdcb33f98244".

Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
Cc: Heyi Guo <guoheyi@huawei.com>
Cc: Biaoxiang Ye <yebiaoxiang@huawei.com>
---

v2:
 - Move the wait queue functionality around the "schedule()" function to
   avoid reintroducing the deadlock addressed by "cdcb33f98244"

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


