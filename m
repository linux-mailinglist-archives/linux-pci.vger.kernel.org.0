Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0F645FADC
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349172AbhK0BfG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:35:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40390 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350649AbhK0BdB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:33:01 -0500
Message-ID: <20211126232734.411769132@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dWlRgqR+0drt9PwtC3seDhr2BnCncrRnkVfFxsvT5DI=;
        b=ErFEn9JAHZmB9N7TIfTOBXfqadUYsXpmipIzHwuhs1qUCDliJVI5OWR05sQtXVu27rTXEf
        vwIl2QkSVsw/Qxi30tHLjeruo5PHb+yIuNXpoSkn3LI93hCPDrQe/mKvZ8NzUb2c9j4uyT
        nSxZhq2G+Ov+hRATjuF6hb24yDDEQPMc8V+RYteTmsghpRtQWtq9wMKV+GaIyfpE9JXaRP
        3giq5a+TVDahUjBTCNfv1xPWC9LqaZx+ZmPi1P32GMDSm7PQTA9p8o54Kjer59HeYMhUm8
        WwOXhTP7Y1Pzd4w71w4kZqXr+QkUduldyjhasIlFU5v9Pr/nazqsGXFwi3fPiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dWlRgqR+0drt9PwtC3seDhr2BnCncrRnkVfFxsvT5DI=;
        b=UXoJTaH8HHXYi93GRMVRUhgn+NP1loOvwQRR91dam6iZ7yWtaJkuebAQ3xt3KIuZVa1QKh
        MzVvnRXez6BFs2BA==
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
Subject: [patch 02/32] genirq/msi: Add mutex for MSI list protection
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:23:31 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For upcoming runtime extensions of MSI-X interrupts it's required to
protect the MSI descriptor list. Add a mutex to struct msi_device_data and
provide lock/unlock functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    6 ++++++
 kernel/irq/msi.c    |   25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -3,6 +3,7 @@
 #define LINUX_MSI_H
 
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/bits.h>
 #include <asm/msi.h>
@@ -146,6 +147,7 @@ struct msi_desc {
  * @attrs:		Pointer to the sysfs attribute group
  * @platform_data:	Platform-MSI specific data
  * @list:		List of MSI descriptors associated to the device
+ * @mutex:		Mutex protecting the MSI list
  */
 struct msi_device_data {
 	raw_spinlock_t			lock;
@@ -153,6 +155,7 @@ struct msi_device_data {
 	const struct attribute_group    **attrs;
 	struct platform_msi_priv_data	*platform_data;
 	struct list_head		list;
+	struct mutex			mutex;
 };
 
 int msi_setup_device_data(struct device *dev);
@@ -187,6 +190,9 @@ static inline unsigned int msi_get_virq(
 	return ret < 0 ? 0 : ret;
 }
 
+void msi_lock_descs(struct device *dev);
+void msi_unlock_descs(struct device *dev);
+
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
 #define dev_to_msi_list(dev)		(&(dev)->msi.data->list)
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -116,12 +116,37 @@ int msi_setup_device_data(struct device
 
 	raw_spin_lock_init(&md->lock);
 	INIT_LIST_HEAD(&md->list);
+	mutex_init(&md->mutex);
 	dev->msi.data = md;
 	devres_add(dev, md);
 	return 0;
 }
 
 /**
+ * msi_lock_descs - Lock the MSI descriptor storage of a device
+ * @dev:	Device to operate on
+ */
+void msi_lock_descs(struct device *dev)
+{
+	if (WARN_ON_ONCE(!dev->msi.data))
+		return;
+	mutex_lock(&dev->msi.data->mutex);
+}
+EXPORT_SYMBOL_GPL(msi_lock_descs);
+
+/**
+ * msi_unlock_descs - Unlock the MSI descriptor storage of a device
+ * @dev:	Device to operate on
+ */
+void msi_unlock_descs(struct device *dev)
+{
+	if (WARN_ON_ONCE(!dev->msi.data))
+		return;
+	mutex_unlock(&dev->msi.data->mutex);
+}
+EXPORT_SYMBOL_GPL(msi_unlock_descs);
+
+/**
  * __msi_get_virq - Return Linux interrupt number of a MSI interrupt
  * @dev:	Device to operate on
  * @index:	MSI interrupt index to look for (0-based)

