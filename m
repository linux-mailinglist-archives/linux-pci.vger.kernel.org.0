Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38340625C2F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiKKOBs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiKKOA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:00:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B59121271;
        Fri, 11 Nov 2022 05:56:53 -0800 (PST)
Message-ID: <20221111132706.556889434@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TkOvIxWq7blX++8C4usdFqhmn0pf5LlrWLBigdC6jNU=;
        b=QwvsjN+SeJTunL4JDRi3zuYoEkPYRBE3sGQtDBitAJztwrnQqvJFDprVJ3r+G23bUHKTXz
        WVnLTw5f30eDVfgihTfJPYh/Z0QsjvMKw0FT4fEiroiX9FQQRB/8S59doOI0R+CVgPo2Ij
        HcLqirBVszrOQRk/9x7L5bfx3ZMse96fIUFurtJqHM7ZxxOKTJm6Vtjt6BgEVeszKHG4VH
        Zi9+KnBbJNUfAlznj2A0WtgtSI3seDWQFduF5C3BGlCDTdk+RzJklqNTZo67B5WY4Z60+k
        695kbAKVQ2MzHgWCxy8XHJHwnSSyLy8JdX6CUPZFaY6qQVf6NhgpZrLnLuOzfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TkOvIxWq7blX++8C4usdFqhmn0pf5LlrWLBigdC6jNU=;
        b=8rRBWR4SmnZKR1bVKLF8pwofRIJbqCo+qdlwtD/+742M8HKIZZrdG3K1eaeFfog27xHxWo
        L9y1Jro0COuGinAw==
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
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 09/20] genirq/msi: Make msi_get_virq() device domain aware
References: <20221111131813.914374272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:56:51 +0100 (CET)
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
 include/linux/msi_api.h |   14 +++++++++++++-
 kernel/irq/msi.c        |   24 ++++++++++++++++++------
 2 files changed, 31 insertions(+), 7 deletions(-)

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
@@ -351,25 +351,37 @@ struct msi_desc *msi_next_desc(struct de
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
+	if (WARN_ON_ONCE(index >= MSI_MAX_INDEX))
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
+		return 0;
+
+	desc = xa_load(&dev->msi.data->__store, base + pcimsi ? 0 : index);
 	if (desc && desc->irq) {
 		/*
 		 * PCI-MSI has only one descriptor for multiple interrupts.
@@ -386,7 +398,7 @@ unsigned int msi_get_virq(struct device
 	msi_unlock_descs(dev);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(msi_get_virq);
+EXPORT_SYMBOL_GPL(msi_domain_get_virq);
 
 #ifdef CONFIG_SYSFS
 static struct attribute *msi_dev_attrs[] = {

