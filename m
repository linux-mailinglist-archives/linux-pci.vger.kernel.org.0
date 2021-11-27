Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F3745FA89
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345149AbhK0Bc0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:32:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40144 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350492AbhK0BaY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:30:24 -0500
Message-ID: <20211126232734.708730446@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Crjr7H36J9Lf+jrInVyv901m9c+NySD9gCdemdb2Zhs=;
        b=KpCQ3oWSGiOBYVKeR83G6UqoazJMqBAcDo8sBjvgjm+Psx3uer7pVsOIBzeQCIYPIBu/Q6
        xJGx1CIZP080ZrpciiaLvxE9J7Op5q2B9tusCp87jlpyXuxey/zB/zq52f4Y/XnNyqBl12
        Ez12zPCWjWqdzc/acCGt2rbjq5lfYk5WGHOFUJuBke1GNoxzoF6/mRkgvZWBVucuD76j01
        8p2blTmgAhd9+cD1Ue2Bi0Ji/jzDs6yle/MRSiOzv6x6xRZ5XzRxz8CKX+11oXCEzfW5Hw
        4zUoIVTVIIQwOzDDIzM0TGFmHKqFcMFEZWoK3jb+v6L+CqQ8R5fsbYs+yNmaGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Crjr7H36J9Lf+jrInVyv901m9c+NySD9gCdemdb2Zhs=;
        b=Jts3Efi06bmkH0eFVHwuy2EXLZDxq+/nYtWITOwYFzp//eDHMJ6M0vPebEn7zIQgEkn+jK
        w/cwmuzMUxfIiVDQ==
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
Date:   Sat, 27 Nov 2021 02:22:38 +0100 (CET)
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

