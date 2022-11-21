Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3E663263B
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiKUOin (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiKUOht (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:37:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B28606AA;
        Mon, 21 Nov 2022 06:37:48 -0800 (PST)
Message-ID: <20221121091326.548660039@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uxE2Dly/6+Q4uRawtSsl3v/O5OKI6xZbIMyJaFXzjoA=;
        b=H5FvQ0HMPFqq2/TfkTiq4NY0eoXPxKBhOuyfnrZ2HeGSZ60Qh7dSRPHAThmvdsx/6Q72SJ
        CSGlFqv6qbJ2+Lw2WcmT2DyINQyZYBK9GeEfhf+ViSrCsqdjuImi73OnSfhvzDc2tgLc3E
        Onx6X0N2Rg12QQVeiuqxVcooKsEYs2eHcWhsAP8BL3HubK18FCaiGJhlFQSqGcE5dAPOXl
        eJElaRgIenWRQxHz+oygtqmU47spwjbfaIToEXY/IMLD/sBHTcN/DA0P4w+i8sOZDy30Tx
        ULp9KiuvTQTCrUZGZIQcEV4LVACx2HmaA0B/HTlwQLQzvvvJ9SOqxUgU7kX9dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uxE2Dly/6+Q4uRawtSsl3v/O5OKI6xZbIMyJaFXzjoA=;
        b=p5I9kVDhYyGggj+rhwXTgsauKm6EWZCcnpND+ruO2nO4/QYYg9OfnUuAH/n4/HKST0eUEv
        xiJLh8sqbD95fZAg==
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
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [patch V2 01/33] genirq/msi: Rearrange MSI domain flags
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:37:47 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These flags got added as necessary and have no obvious structure. For
feature support checks and masking it's convenient to have two blocks of
flags:

   1) Flags to control the internal behaviour like allocating/freeing
      MSI descriptors. Those flags do not need any support from the
      underlying MSI parent domain. They are mostly under the control
      of the outermost domain which implements the actual MSI support.

   2) Flags to expose features, e.g. PCI multi-MSI or requirements
      which can depend on a underlying domain.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/msi.h |   49 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -24,6 +24,8 @@
 #include <linux/xarray.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
+#include <linux/bits.h>
+
 #include <asm/msi.h>
 
 /* Dummy shadow structures if an architecture does not define them */
@@ -432,7 +434,16 @@ struct msi_domain_info {
 	void				*data;
 };
 
-/* Flags for msi_domain_info */
+/*
+ * Flags for msi_domain_info
+ *
+ * Bit 0-15:	Generic MSI functionality which is not subject to restriction
+ *		by parent domains
+ *
+ * Bit 16-31:	Functionality which depends on the underlying parent domain and
+ *		can be masked out by msi_parent_ops::init_dev_msi_info() when
+ *		a device MSI domain is initialized.
+ */
 enum {
 	/*
 	 * Init non implemented ops callbacks with default MSI domain
@@ -444,33 +455,41 @@ enum {
 	 * callbacks.
 	 */
 	MSI_FLAG_USE_DEF_CHIP_OPS	= (1 << 1),
-	/* Support multiple PCI MSI interrupts */
-	MSI_FLAG_MULTI_PCI_MSI		= (1 << 2),
-	/* Support PCI MSIX interrupts */
-	MSI_FLAG_PCI_MSIX		= (1 << 3),
 	/* Needs early activate, required for PCI */
-	MSI_FLAG_ACTIVATE_EARLY		= (1 << 4),
+	MSI_FLAG_ACTIVATE_EARLY		= (1 << 2),
 	/*
 	 * Must reactivate when irq is started even when
 	 * MSI_FLAG_ACTIVATE_EARLY has been set.
 	 */
-	MSI_FLAG_MUST_REACTIVATE	= (1 << 5),
-	/* Is level-triggered capable, using two messages */
-	MSI_FLAG_LEVEL_CAPABLE		= (1 << 6),
+	MSI_FLAG_MUST_REACTIVATE	= (1 << 3),
 	/* Populate sysfs on alloc() and destroy it on free() */
-	MSI_FLAG_DEV_SYSFS		= (1 << 7),
-	/* MSI-X entries must be contiguous */
-	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 8),
+	MSI_FLAG_DEV_SYSFS		= (1 << 4),
 	/* Allocate simple MSI descriptors */
-	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	= (1 << 9),
+	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	= (1 << 5),
 	/* Free MSI descriptors */
-	MSI_FLAG_FREE_MSI_DESCS		= (1 << 10),
+	MSI_FLAG_FREE_MSI_DESCS		= (1 << 6),
 	/*
 	 * Quirk to handle MSI implementations which do not provide
 	 * masking. Currently known to affect x86, but has to be partially
 	 * handled in the core MSI code.
 	 */
-	MSI_FLAG_NOMASK_QUIRK		= (1 << 11),
+	MSI_FLAG_NOMASK_QUIRK		= (1 << 7),
+
+	/* Mask for the generic functionality */
+	MSI_GENERIC_FLAGS_MASK		= GENMASK(15, 0),
+
+	/* Mask for the domain specific functionality */
+	MSI_DOMAIN_FLAGS_MASK		= GENMASK(31, 16),
+
+	/* Support multiple PCI MSI interrupts */
+	MSI_FLAG_MULTI_PCI_MSI		= (1 << 16),
+	/* Support PCI MSIX interrupts */
+	MSI_FLAG_PCI_MSIX		= (1 << 17),
+	/* Is level-triggered capable, using two messages */
+	MSI_FLAG_LEVEL_CAPABLE		= (1 << 18),
+	/* MSI-X entries must be contiguous */
+	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 19),
+
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,

