Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF846AD45
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 23:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358778AbhLFWyp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 17:54:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47756 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358779AbhLFWyg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 17:54:36 -0500
Message-ID: <20211206210747.708877269@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638831066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bFF1yyGEjmfqWVKF8xO+FdVcOtASH/zVcW6F8m2ztk8=;
        b=h7zs3HhLa0MyUgqB67Ek7aGJd9bFAh+2EBYlLG+sGad3LvLUgcZ6PykeQ5T6eUoxRbF44n
        mkWuFUC/qTyXYPpvhvI+X8dyd8cfKbfMKzDXVLn/46F4zzW6CBXmi+BBfhyf+HjNEeFk2z
        0tlwWIn2KUw0sNQi54kfP7klOY0mavnu974JJFHMh0ScVWu+AaTNKMbWbvZhO3xPn83QKX
        3SfTxO7JJ6v7rvOkZQQmmn2jDyVJPowuI+fb7Z3GIff8R9ihaIBagf102XcP2fDgLFwsoX
        JfWhfpj+4WpCl7P1WgfvAQ8IDuZF8EJFDa7kJxO3HWBybIkTR+XAvrGbpm9saQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638831066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bFF1yyGEjmfqWVKF8xO+FdVcOtASH/zVcW6F8m2ztk8=;
        b=lffMhZ/bYwE9mvQry1DVLTFG/WrrN+Pe6NDIt4eykcaGDRpNfFjLIhhaQck/87AbjfD7/F
        3/Pb9k654s4J9XDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch V2 02/31] genirq/msi: Add mutex for MSI list protection
References: <20211206210600.123171746@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:51:05 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For upcoming runtime extensions of MSI-X interrupts it's required to
protect the MSI descriptor list. Add a mutex to struct msi_device_data and
provide lock/unlock functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    5 +++++
 kernel/irq/msi.c    |   25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -3,6 +3,7 @@
 #define LINUX_MSI_H
 
 #include <linux/cpumask.h>
+#include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/bits.h>
 #include <asm/msi.h>
@@ -146,12 +147,14 @@ struct msi_desc {
  * @attrs:		Pointer to the sysfs attribute group
  * @platform_data:	Platform-MSI specific data
  * @list:		List of MSI descriptors associated to the device
+ * @mutex:		Mutex protecting the MSI list
  */
 struct msi_device_data {
 	unsigned long			properties;
 	const struct attribute_group    **attrs;
 	struct platform_msi_priv_data	*platform_data;
 	struct list_head		list;
+	struct mutex			mutex;
 };
 
 int msi_setup_device_data(struct device *dev);
@@ -173,6 +176,8 @@ static inline void msi_device_set_proper
 #endif
 
 unsigned int msi_get_virq(struct device *dev, unsigned int index);
+void msi_lock_descs(struct device *dev);
+void msi_unlock_descs(struct device *dev);
 
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -127,12 +127,37 @@ int msi_setup_device_data(struct device
 		return -ENOMEM;
 
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
  * msi_get_virq - Return Linux interrupt number of a MSI interrupt
  * @dev:	Device to operate on
  * @index:	MSI interrupt index to look for (0-based)

