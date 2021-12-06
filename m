Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFBB46AD6A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 23:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359457AbhLFWzC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 17:55:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47846 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358962AbhLFWyl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 17:54:41 -0500
Message-ID: <20211206210747.873833567@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638831071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UXWSPGXq5vnQLUJp9/NNC9VtOj7oZ//oTBntFTDlckE=;
        b=PgswJKO7WjEq/yzSlO8H3r2ZY7wjGa6pUk3EvaNcKuMrsgVGzpecG5DceC1CGnwjJDfFrd
        NEIcwffhXM1Dh8hkAJqoaBetLrFmrWaiobLhBPB3Si54snueZHcItXS4lJu61yhklX8gL9
        vDjkPpzxc7w5tGUe71tIur9OcFBylBX/nVwXuDYVc4/D/njZPwu1dfzRZIDTvKazX1ctqQ
        qfboBuUucOEcJo4C9YNpUXDsL6irdm9ZTWhNvyVPa3FV7PH/JPmsWkGxQxeoLk+YcMZswH
        LUhmEcQ2lFEnBNmvg7mPfElXx9sYkYIvbB/0MVj3vFz9c+772JnNAXwn11Yomw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638831071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UXWSPGXq5vnQLUJp9/NNC9VtOj7oZ//oTBntFTDlckE=;
        b=t+DO982LnLzdozDveVemoQFAxPU8VVJP7+1gBgv3k94/pKvOyQo4khceqch0cyJeFbU1xs
        cy6hN4KbQT/tk+DA==
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
Subject: [patch V2 05/31] genirq/msi: Provide msi_alloc_msi_desc() and a
 simple allocator
References: <20211206210600.123171746@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:51:10 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide msi_alloc_msi_desc() which takes a template MSI descriptor for
initializing a newly allocated descriptor. This allows to simplify various
usage sites of alloc_msi_entry() and moves the storage handling into the
core code.

For simple cases where only a linear vector space is required provide
msi_add_simple_msi_descs() which just allocates a linear range of MSI
descriptors and fills msi_desc::msi_index accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    2 +
 kernel/irq/msi.c    |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -264,6 +264,8 @@ static inline void pci_write_msi_msg(uns
 }
 #endif /* CONFIG_PCI_MSI */
 
+int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc);
+
 struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
 				 const struct irq_affinity_desc *affinity);
 void free_msi_entry(struct msi_desc *entry);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -61,6 +61,65 @@ void free_msi_entry(struct msi_desc *ent
 }
 
 /**
+ * msi_add_msi_desc - Allocate and initialize a MSI descriptor
+ * @dev:	Pointer to the device for which the descriptor is allocated
+ * @init_desc:	Pointer to an MSI descriptor to initialize the new descriptor
+ *
+ * Return: 0 on success or an appropriate failure code.
+ */
+int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc)
+{
+	struct msi_desc *desc;
+
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	desc = alloc_msi_entry(dev, init_desc->nvec_used, init_desc->affinity);
+	if (!desc)
+		return -ENOMEM;
+
+	/* Copy the MSI index and type specific data to the new descriptor. */
+	desc->msi_index = init_desc->msi_index;
+	desc->pci = init_desc->pci;
+
+	list_add_tail(&desc->list, &dev->msi.data->list);
+	return 0;
+}
+
+/**
+ * msi_add_simple_msi_descs - Allocate and initialize MSI descriptors
+ * @dev:	Pointer to the device for which the descriptors are allocated
+ * @index:	Index for the first MSI descriptor
+ * @ndesc:	Number of descriptors to allocate
+ *
+ * Return: 0 on success or an appropriate failure code.
+ */
+static int msi_add_simple_msi_descs(struct device *dev, unsigned int index, unsigned int ndesc)
+{
+	struct msi_desc *desc, *tmp;
+	LIST_HEAD(list);
+	unsigned int i;
+
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	for (i = 0; i < ndesc; i++) {
+		desc = alloc_msi_entry(dev, 1, NULL);
+		if (!desc)
+			goto fail;
+		desc->msi_index = index + i;
+		list_add_tail(&desc->list, &list);
+	}
+	list_splice_tail(&list, &dev->msi.data->list);
+	return 0;
+
+fail:
+	list_for_each_entry_safe(desc, tmp, &list, list) {
+		list_del(&desc->list);
+		free_msi_entry(desc);
+	}
+	return -ENOMEM;
+}
+
+/**
  * msi_device_set_properties - Set device specific MSI properties
  * @dev:	Pointer to the device which is queried
  * @prop:	Properties to set

