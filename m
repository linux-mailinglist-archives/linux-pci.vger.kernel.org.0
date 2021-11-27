Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD3645FC10
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 03:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242414AbhK0C2F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 21:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242794AbhK0C0E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 21:26:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C47BC0619E8;
        Fri, 26 Nov 2021 17:32:50 -0800 (PST)
Message-ID: <20211127000918.948090130@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0A61IAyhwI6GY5iuZYdA+ROlAbbN0w/XOIQw6hDb9NM=;
        b=a3iGOUSTx4AN3Q+pI7OaLd8XxRJez4TVI0yS8OwSrBLHpMdd43pK6NS2i9A78zct8mMk9N
        KkCBGxJmthiU+adM0JABQFd1JpzvyWEDZYkDTb6KmwkCcIlJvYwRrVtecKgwiWt149QTKy
        kXNw9ozrprUifZWGRJ3ozGMEgFx7xSIRi4PKYhplfZ2luJnSotKEvPT5jrmonGKUd48KP4
        l+CgfvLLEiDNlvnHaEw1Cta1aegPtCzTvkIfKuY21nSEgRwMKfcO4iuilA54iG4h/Lw0VE
        OOcQ/VEF5J9CngnBfWKhbVR9UJEUOHQQedT9R8W+9iFsK//l3/Je1Nou98oMNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0A61IAyhwI6GY5iuZYdA+ROlAbbN0w/XOIQw6hDb9NM=;
        b=bg4/hHFjPj1TJiW6AfVYBKxndqevN1BSCZqejV8miPfCEJVhBd+nd4HllZp/pRBVSGwDQb
        VCXYClThCFvP92AQ==
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
Subject: [patch 08/10] PCI/MSI: Provide pci_msi_domain_supports_expand()
References: <20211126233124.618283684@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:25:09 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Not all irq domain implementations can support runtime MSI-X vector
expansion as they assume zero based allocations or have other
restrictions.

The legacy PCI allocation functions are not suited for runtime vector
expansion either.

Add a function which allows to query whether runtime MSI-X vector expansion
is supported or not.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/irqdomain.c |   29 +++++++++++++++++++++++------
 include/linux/msi.h         |    2 ++
 2 files changed, 25 insertions(+), 6 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -8,12 +8,18 @@
 
 #include "msi.h"
 
+static struct irq_domain *pci_get_msi_domain(struct pci_dev *dev)
+{
+	struct irq_domain *domain = dev_get_msi_domain(&dev->dev);
+
+	return domain && irq_domain_is_hierarchy(domain) ? domain : NULL;
+}
+
 int pci_msi_setup_msi_irqs(struct pci_dev *dev, struct msi_range *range, int type)
 {
-	struct irq_domain *domain;
+	struct irq_domain *domain = pci_get_msi_domain(dev);
 
-	domain = dev_get_msi_domain(&dev->dev);
-	if (domain && irq_domain_is_hierarchy(domain))
+	if (domain)
 		return msi_domain_alloc_irqs_descs_locked(domain, &dev->dev, range);
 
 	return pci_msi_legacy_setup_msi_irqs(dev, range->ndesc, type);
@@ -21,15 +27,26 @@ int pci_msi_setup_msi_irqs(struct pci_de
 
 void pci_msi_teardown_msi_irqs(struct pci_dev *dev, struct msi_range *range)
 {
-	struct irq_domain *domain;
+	struct irq_domain *domain = pci_get_msi_domain(dev);
 
-	domain = dev_get_msi_domain(&dev->dev);
-	if (domain && irq_domain_is_hierarchy(domain))
+	if (domain)
 		msi_domain_free_irqs_descs_locked(domain, &dev->dev, range);
 	else
 		pci_msi_legacy_teardown_msi_irqs(dev);
 }
 
+bool pci_msi_domain_supports_expand(struct pci_dev *dev)
+{
+	struct irq_domain *domain = pci_get_msi_domain(dev);
+	struct msi_domain_info *info;
+
+	if (!domain)
+		return false;
+
+	info = domain->host_data;
+	return info->flags & MSI_FLAG_CAN_EXPAND;
+}
+
 /**
  * pci_msi_domain_write_msg - Helper to write MSI message to PCI config space
  * @irq_data:	Pointer to interrupt data of the MSI interrupt
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -552,11 +552,13 @@ struct irq_domain *pci_msi_create_irq_do
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
 bool pci_dev_has_special_msi_domain(struct pci_dev *pdev);
+bool pci_msi_domain_supports_expand(struct pci_dev *dev);
 #else
 static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
 	return NULL;
 }
+static inline bool pci_msi_domain_supports_expand(struct pci_dev *dev) { return false; }
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
 
 #endif /* LINUX_MSI_H */

