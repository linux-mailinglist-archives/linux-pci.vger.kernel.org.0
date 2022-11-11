Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A595D625C45
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiKKODF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbiKKOCd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:02:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BA290946;
        Fri, 11 Nov 2022 05:57:47 -0800 (PST)
Message-ID: <20221111132707.173697815@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=g3DkOoVQZpocmCUdq743KlTbhHv6STUDcTyWXV9U3+I=;
        b=aIItsgd6QfmXuUPWKRxsYxONfAJgL9uVoASBkaYxs2wjJHlixMwKFfJRCF8K9A+D31pisa
        MF9Nl4iDgg8GRSE21VmWAaH8qgz9FkpcW2zB3Bya+OYBIGfYZax/LyfTJlEynEw7qDfHDN
        KBSbl3lvOhkfLyUuRV4G4faz7s3KFuSwzimL4nZemSjmtjcidz+q3wVSimYsM6w3V98U5W
        piHemsJjopiBIWhnQTWvLEpToT2m6CJdj5CXJ7Z7mBLQVs0zbOmtPWrr9NmTHT6ISHYDhP
        eWn8a5ymvIZBfo344tbW8Z6t/DwAeoAfPKuSYsKLwepmsY2zVF8Wa+HmR1iYdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=g3DkOoVQZpocmCUdq743KlTbhHv6STUDcTyWXV9U3+I=;
        b=UmDlpU1zhkMhauM+traZAmMlpDfASpvgDh3+0I9OXUats9OlNn1+S2URzDSoBb4d1OVT5+
        79iU5xGCNr+0a2CQ==
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
Subject: [patch 20/20] genirq/msi: Remove unused alloc/free interfaces
References: <20221111131813.914374272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:57:09 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that all users are converted remove the old interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    7 ----
 kernel/irq/msi.c    |   73 ----------------------------------------------------
 2 files changed, 80 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -475,13 +475,6 @@ int msi_domain_set_affinity(struct irq_d
 struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
-int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
-				       int nvec);
-int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			  int nvec);
-
-void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev);
-void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 
 int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domid,
 				       unsigned int first, unsigned int last);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1176,51 +1176,6 @@ int msi_domain_alloc_irqs_all_locked(str
 	return msi_domain_alloc_locked(dev, &ctrl);
 }
 
-/**
- * msi_domain_alloc_irqs_descs_locked - Allocate interrupts from a MSI interrupt domain
- * @domain:	The domain to allocate from
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are allocated
- * @nvec:	The number of interrupts to allocate
- *
- * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
- * pair. Use this for MSI irqdomains which implement their own vector
- * allocation/free.
- *
- * Return: %0 on success or an error code.
- */
-int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
-				       int nvec)
-{
-	struct msi_ctrl ctrl = {
-		.domid	= MSI_DEFAULT_DOMAIN,
-		.first	= 0,
-		.last	= MSI_MAX_INDEX,
-		.nirqs	= nvec,
-	};
-
-	return msi_domain_alloc_locked(dev, &ctrl);
-}
-
-/**
- * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
- * @domain:	The domain to allocate from
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are allocated
- * @nvec:	The number of interrupts to allocate
- *
- * Return: %0 on success or an error code.
- */
-int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec)
-{
-	int ret;
-
-	msi_lock_descs(dev);
-	ret = msi_domain_alloc_irqs_descs_locked(domain, dev, nvec);
-	msi_unlock_descs(dev);
-	return ret;
-}
-
 static void __msi_domain_free_irqs(struct device *dev, struct irq_domain *domain,
 				   struct msi_ctrl *ctrl)
 {
@@ -1347,34 +1302,6 @@ void msi_domain_free_irqs_all(struct dev
 	msi_unlock_descs(dev);
 }
 
-/**
- * msi_domain_free_irqs_descs_locked - Free interrupts from a MSI interrupt @domain associated to @dev
- * @domain:	The domain to managing the interrupts
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are free
- *
- * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
- * pair. Use this for MSI irqdomains which implement their own vector
- * allocation.
- */
-void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev)
-{
-	msi_domain_free_irqs_range_locked(dev, MSI_DEFAULT_DOMAIN, 0, MSI_MAX_INDEX);
-}
-
-/**
- * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated to @dev
- * @domain:	The domain to managing the interrupts
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are free
- */
-void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
-{
-	msi_lock_descs(dev);
-	msi_domain_free_irqs_descs_locked(domain, dev);
-	msi_unlock_descs(dev);
-}
-
 /**
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
  * @domain:	The interrupt domain to retrieve data from

