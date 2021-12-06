Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE5046ADB3
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 23:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377375AbhLFW4V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 17:56:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48330 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359516AbhLFWzH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 17:55:07 -0500
Message-ID: <20211206210748.737904583@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638831096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CzqGTYDUie5SurN5/gfV37QSqlTZtJhIqYh57XXY9vc=;
        b=1RPNxtfr5VOlwanCXHzzCGA5Okk7iWaKRIecmxZqcQ6GJ0N+TtqkJB4YBgKir4DpaFIby2
        TRL5d8Yy6CPk4zvOP3IAjf8rBmhgoTlm/L1kch6yeBRZBqQv1tnis78DJISBVkWqedG7kW
        +UF+HoUE+QXVYx2FHqbtaf8jvVW1CIcSK0Lt9gdkhNLog4N5iX/+i0lCCEkRdUsCAH5BS+
        M8Ui7QxFmKA/zA6UsxNXXH9SHexJzn01o7N0bxnreZcIW5uaSDvXRX6Db6sRqabEbx7TII
        t2IyHWZfEGz8M5lT0y6GzRbyCNuKzYCId/ZxJxgQ9wg+WoVlQuVF7cJLPCN54g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638831096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CzqGTYDUie5SurN5/gfV37QSqlTZtJhIqYh57XXY9vc=;
        b=Jct3bSAMJvPsNwVF2TBaEtc50EznqpM+HcoTb5h9bKmrJfg+EG2SWo9/6tVTtRKQrwReAU
        pte3E9Jf8LXGmsBA==
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
Subject: [patch V2 21/31] soc: ti: ti_sci_inta_msi: Rework MSI descriptor allocation
References: <20211206210600.123171746@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:51:36 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Protect the allocation properly and use the core allocation and free
mechanism.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/soc/ti/ti_sci_inta_msi.c |   71 +++++++++++++--------------------------
 1 file changed, 25 insertions(+), 46 deletions(-)

--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -51,6 +51,7 @@ struct irq_domain *ti_sci_inta_msi_creat
 	struct irq_domain *domain;
 
 	ti_sci_inta_msi_update_chip_ops(info);
+	info->flags |= MSI_FLAG_FREE_MSI_DESCS;
 
 	domain = msi_create_irq_domain(fwnode, info, parent);
 	if (domain)
@@ -60,50 +61,31 @@ struct irq_domain *ti_sci_inta_msi_creat
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_create_irq_domain);
 
-static void ti_sci_inta_msi_free_descs(struct device *dev)
-{
-	struct msi_desc *desc, *tmp;
-
-	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
-		list_del(&desc->list);
-		free_msi_entry(desc);
-	}
-}
-
 static int ti_sci_inta_msi_alloc_descs(struct device *dev,
 				       struct ti_sci_resource *res)
 {
-	struct msi_desc *msi_desc;
+	struct msi_desc msi_desc;
 	int set, i, count = 0;
 
+	memset(&msi_desc, 0, sizeof(msi_desc));
+
 	for (set = 0; set < res->sets; set++) {
-		for (i = 0; i < res->desc[set].num; i++) {
-			msi_desc = alloc_msi_entry(dev, 1, NULL);
-			if (!msi_desc) {
-				ti_sci_inta_msi_free_descs(dev);
-				return -ENOMEM;
-			}
-
-			msi_desc->msi_index = res->desc[set].start + i;
-			INIT_LIST_HEAD(&msi_desc->list);
-			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
-			count++;
+		for (i = 0; i < res->desc[set].num; i++, count++) {
+			msi_desc.msi_index = res->desc[set].start + i;
+			if (msi_add_msi_desc(dev, &msi_desc))
+				goto fail;
 		}
-		for (i = 0; i < res->desc[set].num_sec; i++) {
-			msi_desc = alloc_msi_entry(dev, 1, NULL);
-			if (!msi_desc) {
-				ti_sci_inta_msi_free_descs(dev);
-				return -ENOMEM;
-			}
-
-			msi_desc->msi_index = res->desc[set].start_sec + i;
-			INIT_LIST_HEAD(&msi_desc->list);
-			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
-			count++;
+
+		for (i = 0; i < res->desc[set].num_sec; i++, count++) {
+			msi_desc.msi_index = res->desc[set].start_sec + i;
+			if (msi_add_msi_desc(dev, &msi_desc))
+				goto fail;
 		}
 	}
-
 	return count;
+fail:
+	msi_free_msi_descs(dev);
+	return -ENOMEM;
 }
 
 int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
@@ -124,20 +106,18 @@ int ti_sci_inta_msi_domain_alloc_irqs(st
 	if (ret)
 		return ret;
 
+	msi_lock_descs(dev);
 	nvec = ti_sci_inta_msi_alloc_descs(dev, res);
-	if (nvec <= 0)
-		return nvec;
-
-	ret = msi_domain_alloc_irqs(msi_domain, dev, nvec);
-	if (ret) {
-		dev_err(dev, "Failed to allocate IRQs %d\n", ret);
-		goto cleanup;
+	if (nvec <= 0) {
+		ret = nvec;
+		goto unlock;
 	}
 
-	return 0;
-
-cleanup:
-	ti_sci_inta_msi_free_descs(&pdev->dev);
+	ret = msi_domain_alloc_irqs_descs_locked(msi_domain, dev, nvec);
+	if (ret)
+		dev_err(dev, "Failed to allocate IRQs %d\n", ret);
+unlock:
+	msi_unlock_descs(dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);
@@ -145,6 +125,5 @@ EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain
 void ti_sci_inta_msi_domain_free_irqs(struct device *dev)
 {
 	msi_domain_free_irqs(dev->msi.domain, dev);
-	ti_sci_inta_msi_free_descs(dev);
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_free_irqs);

