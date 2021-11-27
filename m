Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774DB45FBDB
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 03:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350136AbhK0CSR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 21:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350170AbhK0CQO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 21:16:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690A3C08EB4B;
        Fri, 26 Nov 2021 17:31:23 -0800 (PST)
Message-ID: <20211126232735.730257825@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=pofZ6QZSw9wxKST9VxfsCsQBNhHIUiM1COkp0ds7QyE=;
        b=jVjP6wT12tETggq984P/QPiqnGjCVTLWI4cUytxj8NSLT21NwS0BTF2aXLWkD3XRCyjq5j
        rGBWJ1/13g3oISqAt+AUI43z1nBYVKg/ivaUOwP+vKzKfsP2IL4AikAnPfkKuD1+3X3+ru
        jusIEHnPSeaDwTTbjLlYJveY9avL2eG0aa+vEFW2F3pBOwKQP9+9eKJJAmHKraMMFOH9Oz
        T+vM9ZmrdFFOep1TVAw9G0xBhJeHrsrXi+hT14S3lJGbH4E9YVe20s6YiCgLPbpmN7Gm9I
        cjSIzUQig0/6ztU8awhnR8eVyu7Ml/r1Q5BvWGfhfX38LEYZnUVqMl76fDzEJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=pofZ6QZSw9wxKST9VxfsCsQBNhHIUiM1COkp0ds7QyE=;
        b=r370dFtZeqITQ60D6DxEqwfPGstv2ax1jPDSb+Kz6anns9ic97blv5q894U24NtkYLUfKg
        UCJIZkkeNhTwKYDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch 24/32] bus: fsl-mc-msi: Simplify MSI descriptor handling
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:24:06 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Let the MSI irq domain code handle descriptor allocation and free.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/bus/fsl-mc/fsl-mc-msi.c |   61 ++--------------------------------------
 1 file changed, 4 insertions(+), 57 deletions(-)

--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -170,6 +170,7 @@ struct irq_domain *fsl_mc_msi_create_irq
 		fsl_mc_msi_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		fsl_mc_msi_update_chip_ops(info);
+	info->flags |= MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
 
 	domain = msi_create_irq_domain(fwnode, info, parent);
 	if (domain)
@@ -210,45 +211,7 @@ struct irq_domain *fsl_mc_find_msi_domai
 	return msi_domain;
 }
 
-static void fsl_mc_msi_free_descs(struct device *dev)
-{
-	struct msi_desc *desc, *tmp;
-
-	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
-		list_del(&desc->list);
-		free_msi_entry(desc);
-	}
-}
-
-static int fsl_mc_msi_alloc_descs(struct device *dev, unsigned int irq_count)
-
-{
-	unsigned int i;
-	int error;
-	struct msi_desc *msi_desc;
-
-	for (i = 0; i < irq_count; i++) {
-		msi_desc = alloc_msi_entry(dev, 1, NULL);
-		if (!msi_desc) {
-			dev_err(dev, "Failed to allocate msi entry\n");
-			error = -ENOMEM;
-			goto cleanup_msi_descs;
-		}
-
-		msi_desc->msi_index = i;
-		INIT_LIST_HEAD(&msi_desc->list);
-		list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
-	}
-
-	return 0;
-
-cleanup_msi_descs:
-	fsl_mc_msi_free_descs(dev);
-	return error;
-}
-
-int fsl_mc_msi_domain_alloc_irqs(struct device *dev,
-				 unsigned int irq_count)
+int fsl_mc_msi_domain_alloc_irqs(struct device *dev,  unsigned int irq_count)
 {
 	struct irq_domain *msi_domain;
 	int error;
@@ -261,28 +224,17 @@ int fsl_mc_msi_domain_alloc_irqs(struct
 	if (error)
 		return error;
 
-	if (!list_empty(dev_to_msi_list(dev)))
+	if (msi_device_num_descs(dev))
 		return -EINVAL;
 
-	error = fsl_mc_msi_alloc_descs(dev, irq_count);
-	if (error < 0)
-		return error;
-
 	/*
 	 * NOTE: Calling this function will trigger the invocation of the
 	 * its_fsl_mc_msi_prepare() callback
 	 */
 	error = msi_domain_alloc_irqs(msi_domain, dev, irq_count);
 
-	if (error) {
+	if (error)
 		dev_err(dev, "Failed to allocate IRQs\n");
-		goto cleanup_msi_descs;
-	}
-
-	return 0;
-
-cleanup_msi_descs:
-	fsl_mc_msi_free_descs(dev);
 	return error;
 }
 
@@ -295,9 +247,4 @@ void fsl_mc_msi_domain_free_irqs(struct
 		return;
 
 	msi_domain_free_irqs(msi_domain, dev);
-
-	if (list_empty(dev_to_msi_list(dev)))
-		return;
-
-	fsl_mc_msi_free_descs(dev);
 }

