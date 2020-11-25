Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB872C3A07
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 08:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgKYHXF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 02:23:05 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7986 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgKYHXF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 02:23:05 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CgsmQ5zgYzhh3f;
        Wed, 25 Nov 2020 15:22:46 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.20) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 25 Nov 2020 15:22:52 +0800
From:   Jubin Zhong <zhongjubin@huawei.com>
To:     <bhelgaas@google.com>
CC:     <wangfangpeng1@huawei.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: Fix pci_create_slot() memory leak
Date:   Wed, 25 Nov 2020 15:22:51 +0800
Message-ID: <1606288971-47927-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.20]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After commit 8a94644b440e ("PCI: Fix pci_create_slot() reference count
leak"), kobject_put() is called instead of kfree() if
kobject_init_and_add() fails. However, we still need to free the slot
memory before overwriting it as ERR_PTR(err).

This partially reverts the commit 8a94644b440e.

Fixes: 8a94644b440e ("PCI: Fix pci_create_slot() reference count leak")
Signed-off-by: Jubin Zhong <zhongjubin@huawei.com>
---
 drivers/pci/slot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 3861505..a4be62e 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -268,7 +268,6 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	slot_name = make_slot_name(name);
 	if (!slot_name) {
 		err = -ENOMEM;
-		kfree(slot);
 		goto err;
 	}
 
@@ -296,6 +295,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	mutex_unlock(&pci_slot_mutex);
 	return slot;
 err:
+	kfree(slot);
 	slot = ERR_PTR(err);
 	goto out;
 }
-- 
1.8.5.6

