Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3520E6381B0
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiKXXac (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiKXX35 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:29:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8EA59856;
        Thu, 24 Nov 2022 15:27:58 -0800 (PST)
Message-ID: <20221124232326.961711347@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5RTULcrzALXI6kqcCTFqzHeG98y1iAErZ2LN9kOhvOw=;
        b=z4DbH4XIv1kmxippL2hPCp96iWQYpvohT0sVRs5PG25Df35z6ugkXIfB7ahEPFJDmqmTG8
        d+ztRHLzC6WuX9awOb1syNuT1Gwlk5hXRUPg9I8cxvNlYjP7+ARyMHQgLdf0Fj6a9LpvSh
        ungaxTUr3kpRsxm9k0OrPtpQErNPJ0W9CitB7HN8OksxBa+eJhm9F9CzTix/QI7/2enWmG
        9biQXQElJUVHE9wwSCjT1Q9F+qMpaqdlPo/D+ykmdBRAeRs8v3kTjWcW/8NSyQtp3UjwRl
        jLS6X0EssAFpy97oIDN6b1cLAzXnJm9XOEoI4Jxxt414qNeKpZT7ySuguLS4pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5RTULcrzALXI6kqcCTFqzHeG98y1iAErZ2LN9kOhvOw=;
        b=lu6X+IMJmfOSIvBVNI1TXB/n/jyz7pQkN3zGH7jqRBV8dTnepVR3Op1rS8fkLO0RNNiDI5
        HpAX+FhR+yvzvXCA==
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
        Allen Hubbe <allenbh@gmail.com>
Subject: [patch V3 29/33] PCI/MSI: Provide pci_ims_alloc/free_irq()
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:26:31 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Single vector allocation which allocates the next free index in the IMS
space. The free function releases.

All allocated vectors are released also via pci_free_vectors() which is
also releasing MSI/MSI-X vectors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
V3: s/cookie/icookie/ (Kevin)
---
 drivers/pci/msi/api.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h   |    3 +++
 2 files changed, 53 insertions(+)

--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -361,6 +361,56 @@ const struct cpumask *pci_irq_get_affini
 EXPORT_SYMBOL(pci_irq_get_affinity);
 
 /**
+ * pci_ims_alloc_irq - Allocate an interrupt on a PCI/IMS interrupt domain
+ * @dev:	The PCI device to operate on
+ * @icookie:	Pointer to an IMS implementation specific cookie for this
+ *		IMS instance (PASID, queue ID, pointer...).
+ *		The cookie content is copied into the MSI descriptor for the
+ *		interrupt chip callbacks or domain specific setup functions.
+ * @affdesc:	Optional pointer to an interrupt affinity descriptor
+ *
+ * There is no index for IMS allocations as IMS is an implementation
+ * specific storage and does not have any direct associations between
+ * index, which might be a pure software construct, and device
+ * functionality. This association is established by the driver either via
+ * the index - if there is a hardware table - or in case of purely software
+ * managed IMS implementation the association happens via the
+ * irq_write_msi_msg() callback of the implementation specific interrupt
+ * chip, which utilizes the provided @icookie to store the MSI message in
+ * the appropriate place.
+ *
+ * Return: A struct msi_map
+ *
+ *	On success msi_map::index contains the allocated index (>= 0) and
+ *	msi_map::virq the allocated Linux interrupt number (> 0).
+ *
+ *	On fail msi_map::index contains the error code and msi_map::virq
+ *	is set to 0.
+ */
+struct msi_map pci_ims_alloc_irq(struct pci_dev *dev, union msi_instance_cookie *icookie,
+				 const struct irq_affinity_desc *affdesc)
+{
+	return msi_domain_alloc_irq_at(&dev->dev, MSI_SECONDARY_DOMAIN, MSI_ANY_INDEX,
+				       affdesc, icookie);
+}
+EXPORT_SYMBOL_GPL(pci_ims_alloc_irq);
+
+/**
+ * pci_ims_free_irq - Allocate an interrupt on a PCI/IMS interrupt domain
+ *		      which was allocated via pci_ims_alloc_irq()
+ * @dev:	The PCI device to operate on
+ * @map:	A struct msi_map describing the interrupt to free as
+ *		returned from pci_ims_alloc_irq()
+ */
+void pci_ims_free_irq(struct pci_dev *dev, struct msi_map map)
+{
+	if (WARN_ON_ONCE(map.index < 0 || !map.virq))
+		return;
+	msi_domain_free_irqs_range(&dev->dev, MSI_SECONDARY_DOMAIN, map.index, map.index);
+}
+EXPORT_SYMBOL_GPL(pci_ims_free_irq);
+
+/**
  * pci_free_irq_vectors() - Free previously allocated IRQs for a device
  * @dev: the PCI device to operate on
  *
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2491,6 +2491,9 @@ struct msi_domain_template;
 
 bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
 			   unsigned int hwsize, void *data);
+struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev, union msi_instance_cookie *icookie,
+				 const struct irq_affinity_desc *affdesc);
+void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
 
 #include <linux/dma-mapping.h>
 

