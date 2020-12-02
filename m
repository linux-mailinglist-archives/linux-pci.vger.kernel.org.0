Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69C02CB2D7
	for <lists+linux-pci@lfdr.de>; Wed,  2 Dec 2020 03:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgLBCem (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 21:34:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9088 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgLBCem (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2020 21:34:42 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cm31D1hfWzLy1v;
        Wed,  2 Dec 2020 10:33:20 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.20) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Wed, 2 Dec 2020 10:33:43 +0800
From:   Jubin Zhong <zhongjubin@huawei.com>
To:     <bhelgaas@google.com>
CC:     <liuwenliang@huawei.com>, <wangfangpeng1@huawei.com>,
        <nixiaoming@huawei.com>, <gregkh@linuxfoundation.org>,
        <wu000273@umn.edu>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] PCI: Fix Oops caused by uninitialized slot->list in pci_slot_release()
Date:   Wed, 2 Dec 2020 10:33:42 +0800
Message-ID: <1606876422-117457-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.20]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Once kobject_init_and_add() failed, pci_slot_release() is called to
delete slot->list from parent->slots. But slot->list is intialized
afterwards, so we ran into the following crash:

  Unable to handle kernel NULL pointer dereference at virtual address
00000000
  ...
  CPU: 10 PID: 1 Comm: swapper/0 Not tainted 4.4.240 #197
  task: ffffeb398a45ef10 task.stack: ffffeb398a470000
  PC is at __list_del_entry_valid+0x5c/0xb0
  LR is at pci_slot_release+0x84/0xe4
  ...
  __list_del_entry_valid+0x5c/0xb0
  pci_slot_release+0x84/0xe4
  kobject_put+0x184/0x1c4
  pci_create_slot+0x17c/0x1b4
  __pci_hp_initialize+0x68/0xa4
  pciehp_probe+0x1a4/0x2fc
  pcie_port_probe_service+0x58/0x84
  driver_probe_device+0x320/0x470
  __driver_attach+0x54/0xb8
  bus_for_each_dev+0xc8/0xf0
  driver_attach+0x30/0x3c
  bus_add_driver+0x1b0/0x24c
  driver_register+0x9c/0xe0
  pcie_port_service_register+0x64/0x7c
  pcied_init+0x44/0xa4
  do_one_initcall+0x1d0/0x1f0
  kernel_init_freeable+0x24c/0x254
  kernel_init+0x18/0xe8
  ret_from_fork+0x10/0x20

Fixes: 8a94644b440e ("PCI: Fix pci_create_slot() reference count leak")
Signed-off-by: Jubin Zhong <zhongjubin@huawei.com>
Cc: stable@vger.kernel.org #v4.4.235

----
v2:
  Since both slot memory and slot->list would be handled by
pci_slot_release(), we need to make sure slot->list is properly
initialized beforehand.

v1: https://lore.kernel.org/lkml/1606288971-47927-1-git-send-email-zhongjubin@huawei.com/
  Two things need to be cleaned up on pci_create_slot's error path:
  1. free slot memory
  2. remove slot->list from its parent->slots
  This patch mistakenly took slot memory as unfreed (which is not), and
would introduce double free problem.
---
 drivers/pci/slot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 3861505..ed2077e 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -272,6 +272,9 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 		goto err;
 	}
 
+	INIT_LIST_HEAD(&slot->list);
+	list_add(&slot->list, &parent->slots);
+
 	err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, NULL,
 				   "%s", slot_name);
 	if (err) {
@@ -279,9 +282,6 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 		goto err;
 	}
 
-	INIT_LIST_HEAD(&slot->list);
-	list_add(&slot->list, &parent->slots);
-
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
 		if (PCI_SLOT(dev->devfn) == slot_nr)
-- 
1.8.5.6

