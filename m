Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2EE638167
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiKXXZE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKXXYj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:24:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA11898CB;
        Thu, 24 Nov 2022 15:24:28 -0800 (PST)
Message-ID: <20221124230314.044613697@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=x2FLCuF8Xx8AySp9OHgOheEghQq8ehPfwhiGfgwepSM=;
        b=fSdVbg+u/TWqJfbPCEQESo8FLiGMdEKgTWQub3f7agTq3Eg+So028TFvzEddwh7jLwS9cE
        /q15t8aieHFexWg2CqZolhQAXhrs+juCOajxl4rmjue6Ehtvw3qGSmcmta9av8HgCG0w7+
        HANaj/SFfLBG9//yUJLmtWNcgocyJnnmRce6QMcmNljPwnJ66gd7At6Nkqp+1qrxB6l1XI
        AR2UrY8ypKxwjj0wKEHVy43qgN0ecBsZBHrz0J/4gVCW1Et/Si2xAFdvNS3tKFlpzZmLTm
        ZdDpL6ObTmsGALslVk3rhyGJwwf0vWGYgEzxY94uVJMr1Do9SnQmhNRo5+zyvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=x2FLCuF8Xx8AySp9OHgOheEghQq8ehPfwhiGfgwepSM=;
        b=hJ/ILqaggPKEbceqhzx7lHfxS10XTJZTdjXuLEcMMEAShh3J70ripCmsMbLriR4qyZfKvo
        kXej1vPYj58UKPCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [patch V3 11/22] genirq/msi: Make msi_get_virq() device domain aware
References: <20221124225331.464480443@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:24:25 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ahmed S. Darwish <darwi@linutronix.de>

In preparation of the upcoming per device multi MSI domain support, change
the interface to support lookups based on domain id and zero based index
within the domain.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fix the locking leak and the operator precedence issue (kernel robot)
V3: Adopt to the domain/xarray storage change
---
 include/linux/msi_api.h |   14 +++++++++++++-
 kernel/irq/msi.c        |   19 +++++++++++++------
 2 files changed, 26 insertions(+), 7 deletions(-)

--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -18,6 +18,18 @@ enum msi_domain_ids {
 	MSI_MAX_DEVICE_IRQDOMAINS,
 };
 
-unsigned int msi_get_virq(struct device *dev, unsigned int index);
+unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigned int index);
+
+/**
+ * msi_get_virq - Lookup the Linux interrupt number for a MSI index on the default interrupt domain
+ * @dev:	Device for which the lookup happens
+ * @index:	The MSI index to lookup
+ *
+ * Return: The Linux interrupt number on success (> 0), 0 if not found
+ */
+static inline unsigned int msi_get_virq(struct device *dev, unsigned int index)
+{
+	return msi_domain_get_virq(dev, MSI_DEFAULT_DOMAIN, index);
+}
 
 #endif
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -338,26 +338,32 @@ struct msi_desc *msi_next_desc(struct de
 EXPORT_SYMBOL_GPL(msi_next_desc);
 
 /**
- * msi_get_virq - Return Linux interrupt number of a MSI interrupt
+ * msi_domain_get_virq - Lookup the Linux interrupt number for a MSI index on a interrupt domain
  * @dev:	Device to operate on
+ * @domid:	Domain ID of the interrupt domain associated to the device
  * @index:	MSI interrupt index to look for (0-based)
  *
  * Return: The Linux interrupt number on success (> 0), 0 if not found
  */
-unsigned int msi_get_virq(struct device *dev, unsigned int index)
+unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigned int index)
 {
 	struct msi_desc *desc;
 	unsigned int ret = 0;
+	bool pcimsi = false;
 	struct xarray *xa;
-	bool pcimsi;
 
 	if (!dev->msi.data)
 		return 0;
 
-	pcimsi = dev_is_pci(dev) ? to_pci_dev(dev)->msi_enabled : false;
+	if (WARN_ON_ONCE(index > MSI_MAX_INDEX || domid >= MSI_MAX_DEVICE_IRQDOMAINS))
+		return 0;
+
+	/* This check is only valid for the PCI default MSI domain */
+	if (dev_is_pci(dev) && domid == MSI_DEFAULT_DOMAIN)
+		pcimsi = to_pci_dev(dev)->msi_enabled;
 
 	msi_lock_descs(dev);
-	xa = &dev->msi.data->__domains[MSI_DEFAULT_DOMAIN].store;
+	xa = &dev->msi.data->__domains[domid].store;
 	desc = xa_load(xa, pcimsi ? 0 : index);
 	if (desc && desc->irq) {
 		/*
@@ -372,10 +378,11 @@ unsigned int msi_get_virq(struct device
 			ret = desc->irq;
 		}
 	}
+
 	msi_unlock_descs(dev);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(msi_get_virq);
+EXPORT_SYMBOL_GPL(msi_domain_get_virq);
 
 #ifdef CONFIG_SYSFS
 static struct attribute *msi_dev_attrs[] = {

