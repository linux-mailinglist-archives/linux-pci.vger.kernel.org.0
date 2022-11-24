Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2964463817B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKXX0S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiKXXZn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:25:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEC4ACEB9;
        Thu, 24 Nov 2022 15:25:00 -0800 (PST)
Message-ID: <20221124230314.575538524@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Dc0ZFlk2JAPmF0v24u3+k7yycgC6/ipKg9qXDEwD/vU=;
        b=tlGaFyfmoSWtxrbIaA3s+d+wnKpP7mQ4yRhQcybarPjr5OegK+K7smE0Hbatt2ieqeY3RW
        WCxjo9c/yL9TSxl/2KDHh8lQE5duMTcbuLAjctZ+Ef33m30ozqEbP9GnSVCETtE/OTa0Mj
        MNWrE4wOgK0DWppsLvxXGYA8K4WJGrAYZeqD45fuNZhnq7SO4pV+VN1zIWwCOhMt8AZrWc
        NxoUTqqLZ4yBohmcQg+pwVghGmHf4Guf+d9N/GwFsKNcVMDHE/sKSoNTJWfV+/efwRgXBq
        7Cj6bG4uf1NfGByjJ1NKrIK/w3wHd9c5p2uh1lx6IR2Zc6xkfVnUtLLn7tzKaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Dc0ZFlk2JAPmF0v24u3+k7yycgC6/ipKg9qXDEwD/vU=;
        b=GOSmbtRqp/P2x6kEtLkClRK2HxyuTC3wPsoNowCef52M508oqahOf/VIDdBSB2+7qQ4bMn
        MwTiaHHGrsimdDDw==
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
Subject: [patch V3 20/22] bus: fsl-mc-msi: Switch to domain id aware interfaces
References: <20221124225331.464480443@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:24:40 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Switch to the new domain id aware interfaces to phase out the previous
ones.

Get rid of the MSI descriptor and domain checks as the core code detects
these issues anyway.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/bus/fsl-mc/fsl-mc-msi.c |   25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -213,21 +213,8 @@ struct irq_domain *fsl_mc_find_msi_domai
 
 int fsl_mc_msi_domain_alloc_irqs(struct device *dev,  unsigned int irq_count)
 {
-	struct irq_domain *msi_domain;
-	int error;
+	int error = msi_setup_device_data(dev);
 
-	msi_domain = dev_get_msi_domain(dev);
-	if (!msi_domain)
-		return -EINVAL;
-
-	error = msi_setup_device_data(dev);
-	if (error)
-		return error;
-
-	msi_lock_descs(dev);
-	if (msi_first_desc(dev, MSI_DESC_ALL))
-		error = -EINVAL;
-	msi_unlock_descs(dev);
 	if (error)
 		return error;
 
@@ -235,7 +222,7 @@ int fsl_mc_msi_domain_alloc_irqs(struct
 	 * NOTE: Calling this function will trigger the invocation of the
 	 * its_fsl_mc_msi_prepare() callback
 	 */
-	error = msi_domain_alloc_irqs(msi_domain, dev, irq_count);
+	error = msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, irq_count - 1);
 
 	if (error)
 		dev_err(dev, "Failed to allocate IRQs\n");
@@ -244,11 +231,5 @@ int fsl_mc_msi_domain_alloc_irqs(struct
 
 void fsl_mc_msi_domain_free_irqs(struct device *dev)
 {
-	struct irq_domain *msi_domain;
-
-	msi_domain = dev_get_msi_domain(dev);
-	if (!msi_domain)
-		return;
-
-	msi_domain_free_irqs(msi_domain, dev);
+	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
 }

