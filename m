Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CDB632618
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiKUOhS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiKUOgm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:36:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2E1C7210;
        Mon, 21 Nov 2022 06:36:32 -0800 (PST)
Message-ID: <20221121083326.056299459@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XKtpijacgcV8/nCTByztO8f4qnhUrmimBQl8oQuyrjc=;
        b=fmTlkmLmeCpYnQ2H384C1kftB37lQDAfjPUvbAxzkY6TKz4z1CMnXEhYFYOBbKR90REmp9
        /Fbn+ghuUprcA0TS1MngifG+Hcf8OksUXJ3Q8E59tSyKCUe10iXuJQKzWZ02s4lJ/Dknmv
        83HZoU36SrSzuabJ3Kifdcmq8iw1OckNtYx3tAV1COuknF81ZPFdqCaQF7AsNJKTCqG+YW
        pNI/LfXMbN7LQJxZUx6vB5tsJritM8Ymon9DE4g8uuXnR0lWgKN1ex/MZe0Z29i1d3gWo/
        l5aJeQHmbAXvwAsp2jY2wHw9Wc43dpuzYW+pjbr8xMNUQldRA1WZ4i+jBdF5Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XKtpijacgcV8/nCTByztO8f4qnhUrmimBQl8oQuyrjc=;
        b=SUifxZ3Y0/AmPPpqvb6faM2hoCT6jLvDLeTgZ+9bYVKXEnuEhV/NLYlTe15YSGbT4T66N+
        RIi40TUBSFPM9uDQ==
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
Subject: [patch V2 10/21] genirq/msi: Make msi_get_virq() device domain aware
References: <20221121083210.309161925@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:36:30 +0100 (CET)
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
---
 include/linux/msi_api.h |   14 +++++++++++++-
 kernel/irq/msi.c        |   27 +++++++++++++++++++++------
 2 files changed, 34 insertions(+), 7 deletions(-)

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
@@ -351,25 +351,38 @@ struct msi_desc *msi_next_desc(struct de
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
-	bool pcimsi;
+	bool pcimsi = false;
+	int base;
 
 	if (!dev->msi.data)
 		return 0;
 
-	pcimsi = dev_is_pci(dev) ? to_pci_dev(dev)->msi_enabled : false;
+	if (WARN_ON_ONCE(index > MSI_MAX_INDEX))
+		return 0;
+
+	/* This check is only valid for the PCI default MSI domain */
+	if (dev_is_pci(dev) && domid == MSI_DEFAULT_DOMAIN)
+		pcimsi = to_pci_dev(dev)->msi_enabled;
 
 	msi_lock_descs(dev);
-	desc = xa_load(&dev->msi.data->__store, pcimsi ? 0 : index);
+
+	base = msi_get_domain_base_index(dev, domid);
+	if (base < 0)
+		goto unlock;
+
+	base += pcimsi ? 0 : index;
+	desc = xa_load(&dev->msi.data->__store, base);
 	if (desc && desc->irq) {
 		/*
 		 * PCI-MSI has only one descriptor for multiple interrupts.
@@ -383,10 +396,12 @@ unsigned int msi_get_virq(struct device
 			ret = desc->irq;
 		}
 	}
+
+unlock:
 	msi_unlock_descs(dev);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(msi_get_virq);
+EXPORT_SYMBOL_GPL(msi_domain_get_virq);
 
 #ifdef CONFIG_SYSFS
 static struct attribute *msi_dev_attrs[] = {

