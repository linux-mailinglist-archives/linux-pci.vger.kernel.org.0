Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AF845FAD9
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349246AbhK0BfE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:35:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349603AbhK0BdB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:33:01 -0500
Message-ID: <20211126232734.349989857@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=pqZGjMh/WFXDkVYYwyzdxBCQBDh9R/X8Ua/hDtqXIzc=;
        b=L7Mofy0kW3ACp+ppcJ6em8oVqvFVBYeezBVf29Bp83UOrcfW1PgAjQox0sOZ6Ns+maJ+nK
        WCwuJNqP4GELmsNO+aZ7Y7224ORj0WXexkZYlMcHHDUan/GxH5ieFXruQYWkdjc4+YJG8v
        St/ClkUNzhOtoYUy0UAQG77IUFdKf13Blgnj62GSP/+5gg2PZvYIbWygZz8CAk5rIRdu0t
        7ATeCpdNJqr+g4qRir/Kxs8qwh3x9hbdmz0WzjB4qnD0dqFNrLnYmtiEQzWZ0bhGuNYMHx
        7oJcKMw65sLPef21bSLBVt1eMS/GkjhIdxwaW04k8DXDFcaxKRJSJo9Y0L7o2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=pqZGjMh/WFXDkVYYwyzdxBCQBDh9R/X8Ua/hDtqXIzc=;
        b=/VwXJEkpbUtogElV7KK9Gba/kGJ9aJP7J02Q0s4Th+QzO9HPzx0b/SF4hEB5GeszxrlGKD
        ernH5zI4reMRWSCw==
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
Subject: [patch 01/32] genirq/msi: Move descriptor list to struct msi_device_data
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:23:30 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It's only required when MSI is in use.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/base/core.c    |    3 ---
 include/linux/device.h |    4 ----
 include/linux/msi.h    |    4 +++-
 kernel/irq/msi.c       |    5 ++++-
 4 files changed, 7 insertions(+), 9 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2874,9 +2874,6 @@ void device_initialize(struct device *de
 	INIT_LIST_HEAD(&dev->devres_head);
 	device_pm_init(dev);
 	set_dev_node(dev, NUMA_NO_NODE);
-#ifdef CONFIG_GENERIC_MSI_IRQ
-	INIT_LIST_HEAD(&dev->msi_list);
-#endif
 	INIT_LIST_HEAD(&dev->links.consumers);
 	INIT_LIST_HEAD(&dev->links.suppliers);
 	INIT_LIST_HEAD(&dev->links.defer_sync);
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -422,7 +422,6 @@ struct dev_msi_info {
  * @em_pd:	device's energy model performance domain
  * @pins:	For device pin management.
  *		See Documentation/driver-api/pin-control.rst for details.
- * @msi_list:	Hosts MSI descriptors
  * @numa_node:	NUMA node this device is close to.
  * @dma_ops:    DMA mapping operations for this device.
  * @dma_mask:	Dma mask (if dma'ble device).
@@ -518,9 +517,6 @@ struct device {
 	struct dev_pin_info	*pins;
 #endif
 	struct dev_msi_info	msi;
-#ifdef CONFIG_GENERIC_MSI_IRQ
-	struct list_head	msi_list;
-#endif
 #ifdef CONFIG_DMA_OPS
 	const struct dma_map_ops *dma_ops;
 #endif
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -145,12 +145,14 @@ struct msi_desc {
  * @properties:		MSI properties which are interesting to drivers
  * @attrs:		Pointer to the sysfs attribute group
  * @platform_data:	Platform-MSI specific data
+ * @list:		List of MSI descriptors associated to the device
  */
 struct msi_device_data {
 	raw_spinlock_t			lock;
 	unsigned long			properties;
 	const struct attribute_group    **attrs;
 	struct platform_msi_priv_data	*platform_data;
+	struct list_head		list;
 };
 
 int msi_setup_device_data(struct device *dev);
@@ -187,7 +189,7 @@ static inline unsigned int msi_get_virq(
 
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
-#define dev_to_msi_list(dev)		(&(dev)->msi_list)
+#define dev_to_msi_list(dev)		(&(dev)->msi.data->list)
 #define first_msi_entry(dev)		\
 	list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
 #define for_each_msi_entry(desc, dev)	\
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -87,7 +87,9 @@ EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 
 static void msi_device_data_release(struct device *dev, void *res)
 {
-	WARN_ON_ONCE(!list_empty(&dev->msi_list));
+	struct msi_device_data *md = res;
+
+	WARN_ON_ONCE(!list_empty(&md->list));
 	dev->msi.data = NULL;
 }
 
@@ -113,6 +115,7 @@ int msi_setup_device_data(struct device
 		return -ENOMEM;
 
 	raw_spin_lock_init(&md->lock);
+	INIT_LIST_HEAD(&md->list);
 	dev->msi.data = md;
 	devres_add(dev, md);
 	return 0;

