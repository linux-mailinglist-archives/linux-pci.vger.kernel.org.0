Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0452B625BDB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbiKKN5n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiKKN4y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:56:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FAC7F56F;
        Fri, 11 Nov 2022 05:55:11 -0800 (PST)
Message-ID: <20221111122015.574339988@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Msjel7aC5+Im+aQvsAthw2RuYInXdUWBTW//73XVYm0=;
        b=KgXVLrX3pE/nIoqiS99qR5s9yOIMz/R1VaPvfyv2loIU5hDglv67gRX6pyou1DtK60H8cv
        9GpmCDddO9kcF85adqjHiYF1bQ5d87zXTRgP0UgAlqGixa7Beb5iGb+pdp3Q4PG+f1toDz
        X83uOxv0BEfIdDiW+VJKmP5sHOk9JHA4UYsiIbRMhD1dFrLSv8FyNxH9l8a1jx+W7F1ES2
        mgqX8q8gvQYFh0AjANuSBzI/kXzbuI16QPGuQiCAWc2j/5+ePYMfVnyMFOtmr8uagWYcXr
        mb6yiiUo1myYYM3ShslmbhVM3mpnldYVdu78xh8u5sdNukY35Vk1Ij8AFOxhaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Msjel7aC5+Im+aQvsAthw2RuYInXdUWBTW//73XVYm0=;
        b=+iwkwvNEn54tR9xz7jcZGiqa+56HiFP8TiLT8JYtzPWGMO6Z8uVywQslTWiMPsVIVC4Jkm
        pdv9Nt05hulH8fCQ==
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 34/39] PCI/MSI: Reject multi-MSI early
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:55:09 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When hierarchical MSI interrupt domains are enabled then there is no point
to do tons of work and detect the missing support for multi-MSI late in the
allocation path.

Just query the domain feature flags right away. The query function is going
to be used for other purposes later and has a mode argument which influences
the result:

  ALLOW_LEGACY returns true when:
     - there is no irq domain attached (legacy support)
     - there is a irq domain attached which has the feature flag set

  DENY_LEGACY returns only true when:
     - there is a irq domain attached which has the feature flag set

This allows to use the function universally without ifdeffery in the
calling code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/irqdomain.c |   22 ++++++++++++++++++++++
 drivers/pci/msi/msi.c       |    4 ++++
 drivers/pci/msi/msi.h       |    9 +++++++++
 3 files changed, 35 insertions(+)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -187,6 +187,28 @@ struct irq_domain *pci_msi_create_irq_do
 }
 EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
 
+/**
+ * pci_msi_domain_supports - Check for support of a particular feature flag
+ * @pdev:		The PCI device to operate on
+ * @feature_mask:	The feature mask to check for (full match)
+ * @mode:		If ALLOW_LEGACY this grants the feature when there is no irq domain
+ *			associated to the device. If DENY_LEGACY the lack of an irq domain
+ *			makes the feature unsupported
+ */
+bool pci_msi_domain_supports(struct pci_dev *pdev, unsigned int feature_mask,
+			     enum support_mode mode)
+{
+	struct msi_domain_info *info;
+	struct irq_domain *domain;
+
+	domain = dev_get_msi_domain(&pdev->dev);
+
+	if (!domain || !irq_domain_is_hierarchy(domain))
+		return mode == ALLOW_LEGACY;
+	info = domain->host_data;
+	return (info->flags & feature_mask) == feature_mask;
+}
+
 /*
  * Users of the generic MSI infrastructure expect a device to have a single ID,
  * so with DMA aliases we have to pick the least-worst compromise. Devices with
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -347,6 +347,10 @@ static int msi_capability_init(struct pc
 	struct msi_desc *entry;
 	int ret;
 
+	/* Reject multi-MSI early on irq domain enabled architectures */
+	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW_LEGACY))
+		return 1;
+
 	/*
 	 * Disable MSI during setup in the hardware, but mark it enabled
 	 * so that setup code can evaluate it.
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -97,6 +97,15 @@ int __pci_enable_msix_range(struct pci_d
 void __pci_restore_msi_state(struct pci_dev *dev);
 void __pci_restore_msix_state(struct pci_dev *dev);
 
+/* irq_domain related functionality */
+
+enum support_mode {
+	ALLOW_LEGACY,
+	DENY_LEGACY,
+};
+
+bool pci_msi_domain_supports(struct pci_dev *dev, unsigned int feature_mask, enum support_mode mode);
+
 /* Legacy (!IRQDOMAIN) fallbacks */
 
 #ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS

