Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C3145FB0A
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352451AbhK0BgD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:36:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40502 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348060AbhK0BeC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:34:02 -0500
Message-ID: <20211126232734.708730446@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Crjr7H36J9Lf+jrInVyv901m9c+NySD9gCdemdb2Zhs=;
        b=vjZxQ5LVbqwX2zljpy/zDoVl6j/uPJ0qLO3S0vPyiSWwu/C/4vPRRhG1lp+t88V+kBnmPO
        WNC7G3ePUmy/z/Kqld6zrhXC9J0HiJYQ+aLx1VwAt5uhv5pv68ShcHYc29rgoccHf1PjaV
        O2xyR6KNRc5bP6mj034vLv46VJz3h+5VTIMExEbSQIoXHdXmcBU5kSaBfPxWowFaS0VubQ
        fwqJHQtKenKJLJEEP0b7roMeWcxr+55CfbUJehwjUkbLnQDKF5VqeSGXPaoaaPrpwvcWaN
        PSJRS+ag/e2fYPZPb30v3/2lfmpcgZ1Uam8IiJAEE10sqfPb1i97i3t2i0/2Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Crjr7H36J9Lf+jrInVyv901m9c+NySD9gCdemdb2Zhs=;
        b=LTpyN0RevBj98IqGQL0ndMB2GRxM/1x74g3jxSHAu2Gps+RjgtvWuSuX33ow9cTEe8X/7F
        eXfoljRsrX0yz8CA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch 07/32] genirq/msi: Count the allocated MSI descriptors
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:23:39 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    3 +++
 kernel/irq/msi.c    |   18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -156,6 +156,7 @@ enum msi_desc_filter {
  * msi_device_data - MSI per device data
  * @lock:		Spinlock to protect register access
  * @properties:		MSI properties which are interesting to drivers
+ * @num_descs:		The number of allocated MSI descriptors for the device
  * @attrs:		Pointer to the sysfs attribute group
  * @platform_data:	Platform-MSI specific data
  * @list:		List of MSI descriptors associated to the device
@@ -166,6 +167,7 @@ enum msi_desc_filter {
 struct msi_device_data {
 	raw_spinlock_t			lock;
 	unsigned long			properties;
+	unsigned int			num_descs;
 	const struct attribute_group    **attrs;
 	struct platform_msi_priv_data	*platform_data;
 	struct list_head		list;
@@ -208,6 +210,7 @@ static inline unsigned int msi_get_virq(
 
 void msi_lock_descs(struct device *dev);
 void msi_unlock_descs(struct device *dev);
+unsigned int msi_device_num_descs(struct device *dev);
 
 struct msi_desc *__msi_first_desc(struct device *dev, enum msi_desc_filter filter, unsigned int base_index);
 struct msi_desc *msi_next_desc(struct device *dev);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -82,6 +82,7 @@ int msi_add_msi_desc(struct device *dev,
 	desc->pci = init_desc->pci;
 
 	list_add_tail(&desc->list, &dev->msi.data->list);
+	dev->msi.data->num_descs++;
 	return 0;
 }
 
@@ -109,6 +110,7 @@ int msi_add_simple_msi_descs(struct devi
 		list_add_tail(&desc->list, &list);
 	}
 	list_splice_tail(&list, &dev->msi.data->list);
+	dev->msi.data->num_descs += ndesc;
 	return 0;
 
 fail:
@@ -142,6 +144,7 @@ void msi_free_msi_descs_range(struct dev
 			continue;
 		list_del(&desc->list);
 		free_msi_entry(desc);
+		dev->msi.data->num_descs--;
 	}
 }
 
@@ -157,6 +160,21 @@ bool msi_device_has_property(struct devi
 	return !!(dev->msi.data->properties & prop);
 }
 
+/**
+ * msi_device_num_descs - Query the number of allocated MSI descriptors of a device
+ * @dev:	The device to read from
+ *
+ * Note: This is a lockless snapshot of msi_device_data::num_descs
+ *
+ * Returns the number of MSI descriptors which are allocated for @dev
+ */
+unsigned int msi_device_num_descs(struct device *dev)
+{
+	if (dev->msi.data)
+		return dev->msi.data->num_descs;
+	return 0;
+}
+
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	*msg = entry->msg;

