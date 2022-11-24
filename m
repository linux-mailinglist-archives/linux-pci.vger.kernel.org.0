Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AEA63817D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiKXX0W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiKXXZu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:25:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9709F88B51;
        Thu, 24 Nov 2022 15:25:03 -0800 (PST)
Message-ID: <20221124230314.694291814@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bf5av9l//y7oowGJ6eQBesu1F3liOY0q9r9aUAN4lbw=;
        b=ivOz0V2yzDCsYPo27vDjm7HsbVozSSQqtTuUh57wNLOf/AfuG8KS31VYVmVGaKYt5N/Tc+
        w8ZuJY8TnJmeMK9OaIsbbBnPhjuUnYJP9aJq0obT+e73emUNgsOuK5Qd/R8YQ+Y2eaYceD
        nBXiMj0Ja4TcLlRG1k7Eh6+OqxrkPFQO6GYQ8MJ7hytsvUeTpkLcvNLboBS+ISuypYQgQR
        ts9bjc9NlMTXOhHS0WrWOnuyr1BQlXjcNONrPwJ2/4jjuggW6ibDo/t4jxAmZqegvxJQUH
        t5x2cB7lV+46WBB/ooyxa9bS4d88nK+rQsVwXVLWnCC7trN+FiJNCrQiFcbPiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bf5av9l//y7oowGJ6eQBesu1F3liOY0q9r9aUAN4lbw=;
        b=vXnHI/Px0MdF3reiMkVo3OU4HNGCfg0iyJFd9CS7uvalynqX2sPQg1Ljo5iW08y/xGgGgq
        pyDh0AV1RQ4gDAAw==
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
Subject: [patch V3 22/22] genirq/msi: Remove unused alloc/free interfaces
References: <20221124225331.464480443@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:24:43 +0100 (CET)
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
@@ -487,13 +487,6 @@ int msi_domain_set_affinity(struct irq_d
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
@@ -1143,51 +1143,6 @@ int msi_domain_alloc_irqs_all_locked(str
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
@@ -1312,34 +1267,6 @@ void msi_domain_free_irqs_all(struct dev
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

