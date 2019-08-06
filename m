Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E00A782C85
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 09:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbfHFHYb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 03:24:31 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:58399 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731735AbfHFHYb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2019 03:24:31 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id A9E27101C06FB;
        Tue,  6 Aug 2019 09:24:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6ED1FCCB7; Tue,  6 Aug 2019 09:24:28 +0200 (CEST)
Date:   Tue, 6 Aug 2019 09:24:28 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, yaohongbo@huawei.com,
        guohanjun@huawei.com, huawei.libin@huawei.com
Subject: Re: [RFC PATCH] pciehp: use completion to wait irq_thread
 'pciehp_ist'
Message-ID: <20190806072428.2v7k775tvvgkbloh@wunner.de>
References: <1562226638-54134-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562226638-54134-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 04, 2019 at 03:50:38PM +0800, Xiongfeng Wang wrote:
> When I use the following command to power on a slot which has been
> powered off already.
> echo 1 > /sys/bus/pci/slots/22/power
> It prints the following error:
> -bash: echo: write error: No such device
> But the slot is actually powered on and the devices is probed.
> 
> In function 'pciehp_sysfs_enable_slot()', we use 'wait_event()' to wait
> until 'ctrl->pending_events' is cleared in 'pciehp_ist()'. But in some
> situation, when 'pciehp_ist()' is woken up on a nearby CPU after
> 'pciehp_request' is called, 'ctrl->pending_events' is cleared before we
> go into sleep state. 'wait_event()' will check the condition before
> going into sleep. So we return immediately and '-ENODEV' is return.
> 
> This patch use struct completion to wait until irq_thread 'pciehp_ist'
> is completed.

Thank you, good catch.

Unfortunately your patch still allows the following race AFAICS:

* pciehp_ist() is running (e.g. due to a hotplug operation)
* a request to disable or enable the slot is submitted via sysfs,
  the completion is reinitialized
* pciehp_ist() finishes, signals completion
* the sysfs request returns to user space prematurely
* pciehp_ist() is run, handles the sysfs request, signals completion again

I'd suggest something like the below instead, could you give it a whirl
and see if it reliably fixes the issue for you?

-- >8 --

Subject: [PATCH] PCI: pciehp: Avoid returning prematurely from sysfs requests

A sysfs request to enable or disable a PCIe hotplug slot should not
return before it has been carried out.  That is sought to be achieved
by waiting until the controller's "pending_events" have been cleared.

However the IRQ thread pciehp_ist() clears the "pending_events" before
it acts on them.  If pciehp_sysfs_enable_slot() / _disable_slot() happen
to check the "pending_events" after they have been cleared but while
pciehp_ist() is still running, the functions may return prematurely
with an incorrect return value.

Fix by introducing an "ist_running" flag which must be false before a
sysfs request is allowed to return.

Fixes: 32a8cef274fe ("PCI: pciehp: Enable/disable exclusively from IRQ thread")
Link: https://lore.kernel.org/linux-pci/1562226638-54134-1-git-send-email-wangxiongfeng2@huawei.com
Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.19+
---
 drivers/pci/hotplug/pciehp.h      | 2 ++
 drivers/pci/hotplug/pciehp_ctrl.c | 6 ++++--
 drivers/pci/hotplug/pciehp_hpc.c  | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 8c51a04b8083..e316bde45c7b 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -72,6 +72,7 @@ extern int pciehp_poll_time;
  * @reset_lock: prevents access to the Data Link Layer Link Active bit in the
  *	Link Status register and to the Presence Detect State bit in the Slot
  *	Status register during a slot reset which may cause them to flap
+ * @ist_running: flag to keep user request waiting while IRQ thread is running
  * @request_result: result of last user request submitted to the IRQ thread
  * @requester: wait queue to wake up on completion of user request,
  *	used for synchronous slot enable/disable request via sysfs
@@ -101,6 +102,7 @@ struct controller {
 
 	struct hotplug_slot hotplug_slot;	/* hotplug core interface */
 	struct rw_semaphore reset_lock;
+	unsigned int ist_running;
 	int request_result;
 	wait_queue_head_t requester;
 };
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 631ced0ab28a..1ce9ce335291 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -368,7 +368,8 @@ int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot)
 		ctrl->request_result = -ENODEV;
 		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
 		wait_event(ctrl->requester,
-			   !atomic_read(&ctrl->pending_events));
+			   !atomic_read(&ctrl->pending_events) &&
+			   !ctrl->ist_running);
 		return ctrl->request_result;
 	case POWERON_STATE:
 		ctrl_info(ctrl, "Slot(%s): Already in powering on state\n",
@@ -401,7 +402,8 @@ int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot)
 		mutex_unlock(&ctrl->state_lock);
 		pciehp_request(ctrl, DISABLE_SLOT);
 		wait_event(ctrl->requester,
-			   !atomic_read(&ctrl->pending_events));
+			   !atomic_read(&ctrl->pending_events) &&
+			   !ctrl->ist_running);
 		return ctrl->request_result;
 	case POWEROFF_STATE:
 		ctrl_info(ctrl, "Slot(%s): Already in powering off state\n",
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bd990e3371e3..9e2d7688e8cc 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -608,6 +608,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	irqreturn_t ret;
 	u32 events;
 
+	ctrl->ist_running = true;
 	pci_config_pm_runtime_get(pdev);
 
 	/* rerun pciehp_isr() if the port was inaccessible on interrupt */
@@ -654,6 +655,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	up_read(&ctrl->reset_lock);
 
 	pci_config_pm_runtime_put(pdev);
+	ctrl->ist_running = false;
 	wake_up(&ctrl->requester);
 	return IRQ_HANDLED;
 }
-- 
2.20.1

