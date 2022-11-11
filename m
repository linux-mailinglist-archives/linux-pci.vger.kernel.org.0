Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11903625C53
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiKKOFB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbiKKOEl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:04:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3783889F93;
        Fri, 11 Nov 2022 05:58:52 -0800 (PST)
Message-ID: <20221111135205.309731052@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=x3hIqu1krW0wya/Cp5B9blgpcq3/YMthZGe6CW4aay0=;
        b=Cl5Cge90NeD11tWuUxPPNdqZbeOuu4BQbbJMd3s9+G4WD0B9jm0X3WAOhAy2+ZIQ5xgVeY
        nPgODgSeTnlOzkTqejTq7e1tsTPXmPTG07cumpYKhU+huUjnB0PgzxC+HKe9O4D4kWOFDH
        GhQ0dJ890Y7W+YCJL9W8srS/HxDfxc2jEFyKjBp9PM8QeGxpdXM7Uwr93MATI+dlCynZ9K
        NPEn5kuFfG9Ka8zpB2HV86db979qP7UD18U+LQpUbq+rMjeoyToZjYkybfI2Rfo27lxpA6
        E8LdRZHmeYCL1FIrZKAKpmHrfX7CygBkvkO9B1lGvGrHLvhYpy4+9twcRYbBIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=x3hIqu1krW0wya/Cp5B9blgpcq3/YMthZGe6CW4aay0=;
        b=vJI5ABKsNoBbr9nzBicoj0rOjr0qz69urGN0yNn0bnfvWmNvrsRfmT6zwZYg8ATxc4NGuw
        2IqzREvpGLwcaRBA==
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
Subject: [patch 01/33] genirq/msi: Rearrange MSI domain flags
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:12 +0100 (CET)
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
@@ -428,7 +430,16 @@ struct msi_domain_info {
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
@@ -440,33 +451,41 @@ enum {
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

