Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5088F1996F2
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 15:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgCaNBm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 09:01:42 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:52891 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730732AbgCaNBm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 09:01:42 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 4AEC43000469C;
        Tue, 31 Mar 2020 15:01:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1AC1A15BC99; Tue, 31 Mar 2020 15:01:39 +0200 (CEST)
Date:   Tue, 31 Mar 2020 15:01:39 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Haeuptle, Michael" <michael.haeuptle@hpe.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "michaelhaeuptle@gmail.com" <michaelhaeuptle@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: Deadlock during PCIe hot remove
Message-ID: <20200331130139.46oxbade6rcbaicb@wunner.de>
References: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
 <20200329154352.5lxbtlf3464sm4ce@wunner.de>
 <CS1PR8401MB0728EBC6CD83C2F8554D02A395CB0@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CS1PR8401MB0728EBC6CD83C2F8554D02A395CB0@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 30, 2020 at 04:15:01PM +0000, Haeuptle, Michael wrote:
> There are 2 places where vfio tries to take the device lock. Once in
> pcie_try_reset_function and then later in pci_reset_bus.
> 
> As mentioned, this is the happy path with one device removal. When
> multiple devices are removed then execution piles up on the global
> remove_rescan lock and vfio most of the time gets the device lock
> first resulting in a dead lock.

So I'm not really familiar with vfio but my limited understanding is
that you've got NVMe drives attached to a hotplug slot of a host and
you're passing them through to VMs.  And when you hot-remove them
from the host, pciehp unbinds them from their driver and brings down
the slot, while simultaneously vfio tries to reset the hot-removed
device in order to put it in a consistent state before handing it
back to the host.

Resetting a hot-removed device is kind of pointless of course,
but it may be difficult to make vfio aware of the device's absence
because it's not predictable when pciehp will be finished with
bringing down the slot.  vfio would have to wait as long to know
that the device is gone and the reset can be skipped.

As for the deadlock, the reset_lock in pciehp's controller struct
seeks to prevent a reset while the slot is brought up or down.
The problem is that pciehp takes the reset lock first, then the
device lock, whereas the reset functions in drivers/pci/pci.c
essentially do it the other way round, provoking the AB/BA
deadlock.

The obvious solution is to push the reset_lock out of pciehp and
into the pci_slot struct such that it can be taken by the PCI core
before taking the device lock.  Below is a patch which does exactly
that, could you test if this fixes the issue for you?  It is
compile-tested only.  It is meant to be applied to Bjorn's pci/next
branch.  Since you're using v4.18 plus a bunch of backported patches,
I'm not sure if it will apply cleanly to your tree.

Unfortunately it is not sufficient to add the locking to
pci_slot_lock() et al because of pci_dev_reset_slot_function()
which is called from __pci_reset_function_locked(), which in turn
is called by vfio and xen, all of which require additional locking.

There's an invocation of __pci_reset_function_locked() in
drivers/xen/xen-pciback/pci_stub.c:pcistub_device_release() which
cannot be augmented with the required reset_lock locking because it
is apparently called on unbind, with the device lock already held.
I don't know how to fix this as I'm not familiar with xen.

And there's another mess:  When the PCI core invokes a hotplug_slot's
->reset_slot() hook, it currently doesn't take any precautions to
prevent the hotplug_slot's driver from unbinding.  We dereference
pci_dev->slot but that will become NULL when the hotplug driver
unbinds.  This can easily happen if the hotplug_slot's driver is
unbound via sysfs or if multiple cascaded hotplug slots are removed
at the same time (as is the case with Thunderbolt).  We've never done
this correctly.

Thanks,

Lukas

-- >8 --
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index ae44f46d1bf3..978b8fadfab7 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -20,7 +20,6 @@
 #include <linux/pci_hotplug.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
-#include <linux/rwsem.h>
 #include <linux/workqueue.h>
 
 #include "../pcie/portdrv.h"
@@ -69,9 +68,6 @@ extern int pciehp_poll_time;
  * @button_work: work item to turn the slot on or off after 5 seconds
  *	in response to an Attention Button press
  * @hotplug_slot: structure registered with the PCI hotplug core
- * @reset_lock: prevents access to the Data Link Layer Link Active bit in the
- *	Link Status register and to the Presence Detect State bit in the Slot
- *	Status register during a slot reset which may cause them to flap
  * @ist_running: flag to keep user request waiting while IRQ thread is running
  * @request_result: result of last user request submitted to the IRQ thread
  * @requester: wait queue to wake up on completion of user request,
@@ -102,7 +98,6 @@ struct controller {
 	struct delayed_work button_work;
 
 	struct hotplug_slot hotplug_slot;	/* hotplug core interface */
-	struct rw_semaphore reset_lock;
 	unsigned int ist_running;
 	int request_result;
 	wait_queue_head_t requester;
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 312cc45c44c7..7d2e372a3ac0 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -165,7 +165,7 @@ static void pciehp_check_presence(struct controller *ctrl)
 {
 	int occupied;
 
-	down_read(&ctrl->reset_lock);
+	down_read(&ctrl->hotplug_slot.pci_slot->reset_lock);
 	mutex_lock(&ctrl->state_lock);
 
 	occupied = pciehp_card_present_or_link_active(ctrl);
@@ -176,7 +176,7 @@ static void pciehp_check_presence(struct controller *ctrl)
 		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
 
 	mutex_unlock(&ctrl->state_lock);
-	up_read(&ctrl->reset_lock);
+	up_read(&ctrl->hotplug_slot.pci_slot->reset_lock);
 }
 
 static int pciehp_probe(struct pcie_device *dev)
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 53433b37e181..a1c9072c3e80 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -706,13 +706,17 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	/*
 	 * Disable requests have higher priority than Presence Detect Changed
 	 * or Data Link Layer State Changed events.
+	 *
+	 * A slot reset may cause flaps of the Presence Detect State bit in the
+	 * Slot Status register and the Data Link Layer Link Active bit in the
+	 * Link Status register.  Prevent by holding the reset lock.
 	 */
-	down_read(&ctrl->reset_lock);
+	down_read(&ctrl->hotplug_slot.pci_slot->reset_lock);
 	if (events & DISABLE_SLOT)
 		pciehp_handle_disable_request(ctrl);
 	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
 		pciehp_handle_presence_or_link_change(ctrl, events);
-	up_read(&ctrl->reset_lock);
+	up_read(&ctrl->hotplug_slot.pci_slot->reset_lock);
 
 	ret = IRQ_HANDLED;
 out:
@@ -841,8 +845,6 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
 	if (probe)
 		return 0;
 
-	down_write(&ctrl->reset_lock);
-
 	if (!ATTN_BUTTN(ctrl)) {
 		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
 		stat_mask |= PCI_EXP_SLTSTA_PDC;
@@ -861,7 +863,6 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
 
-	up_write(&ctrl->reset_lock);
 	return rc;
 }
 
@@ -925,7 +926,6 @@ struct controller *pcie_init(struct pcie_device *dev)
 	ctrl->slot_cap = slot_cap;
 	mutex_init(&ctrl->ctrl_lock);
 	mutex_init(&ctrl->state_lock);
-	init_rwsem(&ctrl->reset_lock);
 	init_waitqueue_head(&ctrl->requester);
 	init_waitqueue_head(&ctrl->queue);
 	INIT_DELAYED_WORK(&ctrl->button_work, pciehp_queue_pushbutton_work);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4aa46c7b0148..321980293c5e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5063,6 +5063,8 @@ int pci_reset_function(struct pci_dev *dev)
 	if (!dev->reset_fn)
 		return -ENOTTY;
 
+	if (dev->slot)
+		down_write(&dev->slot->reset_lock);
 	pci_dev_lock(dev);
 	pci_dev_save_and_disable(dev);
 
@@ -5070,6 +5072,8 @@ int pci_reset_function(struct pci_dev *dev)
 
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
+	if (dev->slot)
+		up_write(&dev->slot->reset_lock);
 
 	return rc;
 }
@@ -5122,6 +5126,10 @@ int pci_try_reset_function(struct pci_dev *dev)
 	if (!dev->reset_fn)
 		return -ENOTTY;
 
+	if (dev->slot)
+		if (!down_write_trylock(&dev->slot->reset_lock))
+			return -EAGAIN;
+
 	if (!pci_dev_trylock(dev))
 		return -EAGAIN;
 
@@ -5129,6 +5137,8 @@ int pci_try_reset_function(struct pci_dev *dev)
 	rc = __pci_reset_function_locked(dev);
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
+	if (dev->slot)
+		up_write(&dev->slot->reset_lock);
 
 	return rc;
 }
@@ -5227,6 +5237,7 @@ static void pci_slot_lock(struct pci_slot *slot)
 {
 	struct pci_dev *dev;
 
+	down_write(&slot->reset_lock);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
@@ -5248,6 +5259,7 @@ static void pci_slot_unlock(struct pci_slot *slot)
 			pci_bus_unlock(dev->subordinate);
 		pci_dev_unlock(dev);
 	}
+	up_write(&slot->reset_lock);
 }
 
 /* Return 1 on successful lock, 0 on contention */
@@ -5255,6 +5267,9 @@ static int pci_slot_trylock(struct pci_slot *slot)
 {
 	struct pci_dev *dev;
 
+	if (!down_write_trylock(&slot->reset_lock))
+		return 0;
+
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
@@ -5278,6 +5293,7 @@ static int pci_slot_trylock(struct pci_slot *slot)
 			pci_bus_unlock(dev->subordinate);
 		pci_dev_unlock(dev);
 	}
+	up_write(&slot->reset_lock);
 	return 0;
 }
 
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index cc386ef2fa12..e8e7d0975889 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -279,6 +279,8 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	INIT_LIST_HEAD(&slot->list);
 	list_add(&slot->list, &parent->slots);
 
+	init_rwsem(&slot->reset_lock);
+
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
 		if (PCI_SLOT(dev->devfn) == slot_nr)
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 379a02c36e37..2a9cb7634e0e 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -447,13 +447,20 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 	 * We can not use the "try" reset interface here, which will
 	 * overwrite the previously restored configuration information.
 	 */
-	if (vdev->reset_works && pci_cfg_access_trylock(pdev)) {
-		if (device_trylock(&pdev->dev)) {
-			if (!__pci_reset_function_locked(pdev))
-				vdev->needs_reset = false;
-			device_unlock(&pdev->dev);
+	if (vdev->reset_works) {
+		if (!pdev->slot ||
+		    down_write_trylock(&pdev->slot->reset_lock)) {
+			if (pci_cfg_access_trylock(pdev)) {
+				if (device_trylock(&pdev->dev)) {
+					if (!__pci_reset_function_locked(pdev))
+						vdev->needs_reset = false;
+					device_unlock(&pdev->dev);
+				}
+				pci_cfg_access_unlock(pdev);
+			}
+			if (pdev->slot)
+				up_write(&pdev->slot->reset_lock);
 		}
-		pci_cfg_access_unlock(pdev);
 	}
 
 	pci_restore_state(pdev);
diff --git a/drivers/xen/xen-pciback/passthrough.c b/drivers/xen/xen-pciback/passthrough.c
index 66e9b814cc86..98a9ec8accce 100644
--- a/drivers/xen/xen-pciback/passthrough.c
+++ b/drivers/xen/xen-pciback/passthrough.c
@@ -89,11 +89,17 @@ static void __xen_pcibk_release_pci_dev(struct xen_pcibk_device *pdev,
 	mutex_unlock(&dev_data->lock);
 
 	if (found_dev) {
-		if (lock)
+		if (lock) {
+			if (found_dev->slot)
+				down_write(&found_dev->slot->reset_lock);
 			device_lock(&found_dev->dev);
+		}
 		pcistub_put_pci_dev(found_dev);
-		if (lock)
+		if (lock) {
 			device_unlock(&found_dev->dev);
+			if (found_dev->slot)
+				up_write(&found_dev->slot->reset_lock);
+		}
 	}
 }
 
@@ -164,9 +170,13 @@ static void __xen_pcibk_release_devices(struct xen_pcibk_device *pdev)
 	list_for_each_entry_safe(dev_entry, t, &dev_data->dev_list, list) {
 		struct pci_dev *dev = dev_entry->dev;
 		list_del(&dev_entry->list);
+		if (dev->slot)
+			down_write(&dev->slot->reset_lock);
 		device_lock(&dev->dev);
 		pcistub_put_pci_dev(dev);
 		device_unlock(&dev->dev);
+		if (dev->slot)
+			up_write(&dev->slot->reset_lock);
 		kfree(dev_entry);
 	}
 
diff --git a/drivers/xen/xen-pciback/vpci.c b/drivers/xen/xen-pciback/vpci.c
index f6ba18191c0f..e11ed4764371 100644
--- a/drivers/xen/xen-pciback/vpci.c
+++ b/drivers/xen/xen-pciback/vpci.c
@@ -171,11 +171,17 @@ static void __xen_pcibk_release_pci_dev(struct xen_pcibk_device *pdev,
 	mutex_unlock(&vpci_dev->lock);
 
 	if (found_dev) {
-		if (lock)
+		if (lock) {
+			if (found_dev->slot)
+				down_write(&found_dev->slot->reset_lock);
 			device_lock(&found_dev->dev);
+		}
 		pcistub_put_pci_dev(found_dev);
-		if (lock)
+		if (lock) {
 			device_unlock(&found_dev->dev);
+			if (found_dev->slot)
+				up_write(&found_dev->slot->reset_lock);
+		}
 	}
 }
 
@@ -216,9 +222,13 @@ static void __xen_pcibk_release_devices(struct xen_pcibk_device *pdev)
 					 list) {
 			struct pci_dev *dev = e->dev;
 			list_del(&e->list);
+			if (dev->slot)
+				down_write(&dev->slot->reset_lock);
 			device_lock(&dev->dev);
 			pcistub_put_pci_dev(dev);
 			device_unlock(&dev->dev);
+			if (dev->slot)
+				up_write(&dev->slot->reset_lock);
 			kfree(e);
 		}
 	}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 71c92b88bbc6..e8d31e6d495a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -38,6 +38,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/resource_ext.h>
+#include <linux/rwsem.h>
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
@@ -63,6 +64,7 @@ struct pci_slot {
 	struct pci_bus		*bus;		/* Bus this slot is on */
 	struct list_head	list;		/* Node in list of slots */
 	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
+	struct rw_semaphore	reset_lock;	/* Held during slot reset */
 	unsigned char		number;		/* PCI_SLOT(pci_dev->devfn) */
 	struct kobject		kobj;
 };
