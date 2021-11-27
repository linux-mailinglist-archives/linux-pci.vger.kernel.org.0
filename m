Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3352945FB33
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351973AbhK0BhD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:37:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40724 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345991AbhK0BfC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:35:02 -0500
Message-ID: <20211127000918.664542907@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rrdNHJUyUgKyNz6Pbn0ws4hWiMPwwbNMnZ1F31AYBD0=;
        b=MarT9tzc3uD/IHylu0qgFMXJqCIRF9E81IK9oU/QSiHl//TLD0MlLLyVDHc3E7fdnFbWu4
        jNajrFTveOc0UcHgHrFVYFiOkVWUcp3VDcqqQXPjZNVJR5XW50P58xX/SZg2KrTAsXpTtY
        Tx+yiPXnYoApeFdOBCHvl1LeKN2JqGWS+8oSh99qUDZtlKU0CvhJVcdO1Ig3H9Vvi7C6vm
        Kbuso6YgToHZ6EpxYMF78Igydg+8TrnH0g8uLD1WNk02H7AaNPPJZHQyTMgOO2HrkZQhcQ
        qo2f721FKRrB+prTdNZtaax2ROXufT5XV4IAi0xugE7NPJhFzBmGup8OcxopZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rrdNHJUyUgKyNz6Pbn0ws4hWiMPwwbNMnZ1F31AYBD0=;
        b=z83mpLTnkklHBxL+vHIMKuuahXOWE70VTpa6amHX4Jp0eBu+uIRunBrhjFfksl44tytuvK
        ibg2EKm4G97OPyCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Cooper <amc96@cam.ac.uk>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [patch 03/10] genirq/msi: Make MSI descriptor alloc/free ready for
 range allocations
References: <20211126233124.618283684@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:24:34 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the MSI descriptor related functions to ranges and fixup the call
sites.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/base/platform-msi.c |    3 ++-
 include/linux/msi.h         |    7 ++++---
 kernel/irq/msi.c            |   38 +++++++++++++++++++-------------------
 3 files changed, 25 insertions(+), 23 deletions(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -320,11 +320,12 @@ struct irq_domain *
 void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int virq,
 				     unsigned int nr_irqs)
 {
+	struct msi_range range = { .first = virq, .last = virq + nr_irqs - 1, };
 	struct platform_msi_priv_data *data = domain->host_data;
 
 	msi_lock_descs(data->dev);
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
-	msi_free_msi_descs_range(data->dev, MSI_DESC_ALL, virq, nr_irqs);
+	msi_free_msi_descs_range(data->dev, MSI_DESC_ALL, &range);
 	msi_unlock_descs(data->dev);
 }
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -321,8 +321,7 @@ static inline void pci_write_msi_msg(uns
 #endif /* CONFIG_PCI_MSI */
 
 int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc);
-void msi_free_msi_descs_range(struct device *dev, enum msi_desc_filter filter,
-			      unsigned int base_index, unsigned int ndesc);
+void msi_free_msi_descs_range(struct device *dev, enum msi_desc_filter filter, struct msi_range *range);
 
 /**
  * msi_free_msi_descs - Free MSI descriptors of a device
@@ -330,7 +329,9 @@ void msi_free_msi_descs_range(struct dev
  */
 static inline void msi_free_msi_descs(struct device *dev)
 {
-	msi_free_msi_descs_range(dev, MSI_DESC_ALL, 0, UINT_MAX);
+	struct msi_range range = { .first = 0, .last = UINT_MAX, };
+
+	msi_free_msi_descs_range(dev, MSI_DESC_ALL, &range);
 }
 
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -101,19 +101,19 @@ int msi_add_msi_desc(struct device *dev,
  *
  * Return: 0 on success or an appropriate failure code.
  */
-static int msi_add_simple_msi_descs(struct device *dev, unsigned int index, unsigned int ndesc)
+static int msi_add_simple_msi_descs(struct device *dev, struct msi_range *range)
 {
 	struct msi_desc *desc;
-	unsigned long i;
+	unsigned long idx;
 	int ret;
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
-	for (i = 0; i < ndesc; i++) {
+	for (idx = range->first; idx <= range->last; idx++) {
 		desc = msi_alloc_desc(dev, 1, NULL);
 		if (!desc)
 			goto fail_mem;
-		ret = msi_insert_desc(dev->msi.data, desc, index + i);
+		ret = msi_insert_desc(dev->msi.data, desc, idx);
 		if (ret)
 			goto fail;
 	}
@@ -122,7 +122,7 @@ static int msi_add_simple_msi_descs(stru
 fail_mem:
 	ret = -ENOMEM;
 fail:
-	msi_free_msi_descs_range(dev, MSI_DESC_NOTASSOCIATED, index, ndesc);
+	msi_free_msi_descs_range(dev, MSI_DESC_NOTASSOCIATED, range);
 	return ret;
 }
 
@@ -148,14 +148,14 @@ static bool msi_desc_match(struct msi_de
  * @ndesc:	Number of descriptors to free
  */
 void msi_free_msi_descs_range(struct device *dev, enum msi_desc_filter filter,
-			      unsigned int base_index, unsigned int ndesc)
+			      struct msi_range *range)
 {
 	struct msi_desc *desc;
 	unsigned long idx;
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
-	xa_for_each_range(&dev->msi.data->store, idx, desc, base_index, base_index + ndesc - 1) {
+	xa_for_each_range(&dev->msi.data->store, idx, desc, range->first, range->last) {
 		if (msi_desc_match(desc, filter)) {
 			xa_erase(&dev->msi.data->store, idx);
 			msi_free_desc(desc);
@@ -746,17 +746,18 @@ int msi_domain_prepare_irqs(struct irq_d
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 			     int virq_base, int nvec, msi_alloc_info_t *arg)
 {
+	struct msi_range range = { .first = virq_base, .last = virq_base + nvec - 1 };
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
 	struct msi_desc *desc;
 	int ret, virq;
 
 	msi_lock_descs(dev);
-	ret = msi_add_simple_msi_descs(dev, virq_base, nvec);
+	ret = msi_add_simple_msi_descs(dev, &range);
 	if (ret)
 		goto unlock;
 
-	for (virq = virq_base; virq < virq_base + nvec; virq++) {
+	for (virq = range.first; virq <= range.last; virq++) {
 		desc = xa_load(&dev->msi.data->store, virq);
 		desc->irq = virq;
 
@@ -773,7 +774,7 @@ int msi_domain_populate_irqs(struct irq_
 fail:
 	for (--virq; virq >= virq_base; virq--)
 		irq_domain_free_irqs_common(domain, virq, 1);
-	msi_free_msi_descs_range(dev, MSI_DESC_ALL, virq_base, nvec);
+	msi_free_msi_descs_range(dev, MSI_DESC_ALL, &range);
 unlock:
 	msi_unlock_descs(dev);
 	return ret;
@@ -932,14 +933,13 @@ int __msi_domain_alloc_irqs(struct irq_d
 	return 0;
 }
 
-static int msi_domain_add_simple_msi_descs(struct msi_domain_info *info,
-					   struct device *dev,
-					   unsigned int num_descs)
+static int msi_domain_add_simple_msi_descs(struct msi_domain_info *info, struct device *dev,
+					   struct msi_range *range)
 {
 	if (!(info->flags & MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS))
 		return 0;
 
-	return msi_add_simple_msi_descs(dev, 0, num_descs);
+	return msi_add_simple_msi_descs(dev, range);
 }
 
 /**
@@ -964,7 +964,7 @@ int msi_domain_alloc_irqs_descs_locked(s
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
-	ret = msi_domain_add_simple_msi_descs(info, dev, range->ndesc);
+	ret = msi_domain_add_simple_msi_descs(info, dev, range);
 	if (ret)
 		return ret;
 
@@ -1017,11 +1017,11 @@ void __msi_domain_free_irqs(struct irq_d
 	}
 }
 
-static void msi_domain_free_msi_descs(struct msi_domain_info *info,
-				      struct device *dev)
+static void msi_domain_free_msi_descs(struct msi_domain_info *info, struct device *dev,
+				      struct msi_range *range)
 {
 	if (info->flags & MSI_FLAG_FREE_MSI_DESCS)
-		msi_free_msi_descs(dev);
+		msi_free_msi_descs_range(dev, MSI_DESC_ALL, range);
 }
 
 /**
@@ -1043,7 +1043,7 @@ void msi_domain_free_irqs_descs_locked(s
 	lockdep_assert_held(&dev->msi.data->mutex);
 
 	ops->domain_free_irqs(domain, dev, range);
-	msi_domain_free_msi_descs(info, dev);
+	msi_domain_free_msi_descs(info, dev, range);
 }
 
 /**

