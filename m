Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A25AD5F427
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2019 09:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfGDHxA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jul 2019 03:53:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727180AbfGDHxA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jul 2019 03:53:00 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EF7DE4A3A00B8D6F92BC;
        Thu,  4 Jul 2019 15:52:57 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Thu, 4 Jul 2019 15:52:49 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bhelgaas@google.com>, <lukas@wunner.de>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yaohongbo@huawei.com>, <guohanjun@huawei.com>,
        <huawei.libin@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH] pciehp: use completion to wait irq_thread 'pciehp_ist'
Date:   Thu, 4 Jul 2019 15:50:38 +0800
Message-ID: <1562226638-54134-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When I use the following command to power on a slot which has been
powered off already.
echo 1 > /sys/bus/pci/slots/22/power
It prints the following error:
-bash: echo: write error: No such device
But the slot is actually powered on and the devices is probed.

In function 'pciehp_sysfs_enable_slot()', we use 'wait_event()' to wait
until 'ctrl->pending_events' is cleared in 'pciehp_ist()'. But in some
situation, when 'pciehp_ist()' is woken up on a nearby CPU after
'pciehp_request' is called, 'ctrl->pending_events' is cleared before we
go into sleep state. 'wait_event()' will check the condition before
going into sleep. So we return immediately and '-ENODEV' is return.

This patch use struct completion to wait until irq_thread 'pciehp_ist'
is completed.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/pci/hotplug/pciehp.h      | 2 +-
 drivers/pci/hotplug/pciehp_ctrl.c | 8 ++++----
 drivers/pci/hotplug/pciehp_hpc.c  | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 8c51a04..f8c3826 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -102,7 +102,7 @@ struct controller {
 	struct hotplug_slot hotplug_slot;	/* hotplug core interface */
 	struct rw_semaphore reset_lock;
 	int request_result;
-	wait_queue_head_t requester;
+	struct completion requester;
 };
 
 /**
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 631ced0..2237793 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -366,9 +366,9 @@ int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot)
 		 * card before the thread wakes up, so initialize to -ENODEV.
 		 */
 		ctrl->request_result = -ENODEV;
+		reinit_completion(&ctrl->requester);
 		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
-		wait_event(ctrl->requester,
-			   !atomic_read(&ctrl->pending_events));
+		wait_for_completion(&ctrl->requester);
 		return ctrl->request_result;
 	case POWERON_STATE:
 		ctrl_info(ctrl, "Slot(%s): Already in powering on state\n",
@@ -399,9 +399,9 @@ int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot)
 	case BLINKINGOFF_STATE:
 	case ON_STATE:
 		mutex_unlock(&ctrl->state_lock);
+		reinit_completion(&ctrl->requester);
 		pciehp_request(ctrl, DISABLE_SLOT);
-		wait_event(ctrl->requester,
-			   !atomic_read(&ctrl->pending_events));
+		wait_for_completion(&ctrl->requester);
 		return ctrl->request_result;
 	case POWEROFF_STATE:
 		ctrl_info(ctrl, "Slot(%s): Already in powering off state\n",
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bd990e3..0a74b48 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -654,7 +654,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	up_read(&ctrl->reset_lock);
 
 	pci_config_pm_runtime_put(pdev);
-	wake_up(&ctrl->requester);
+	complete(&ctrl->requester);
 	return IRQ_HANDLED;
 }
 
@@ -862,7 +862,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 	mutex_init(&ctrl->ctrl_lock);
 	mutex_init(&ctrl->state_lock);
 	init_rwsem(&ctrl->reset_lock);
-	init_waitqueue_head(&ctrl->requester);
+	init_completion(&ctrl->requester);
 	init_waitqueue_head(&ctrl->queue);
 	INIT_DELAYED_WORK(&ctrl->button_work, pciehp_queue_pushbutton_work);
 	dbg_ctrl(ctrl);
-- 
1.7.12.4

