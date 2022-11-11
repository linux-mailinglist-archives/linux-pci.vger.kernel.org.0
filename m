Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15467625BE3
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiKKN6K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiKKN5B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:57:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA586EB6F;
        Fri, 11 Nov 2022 05:55:17 -0800 (PST)
Message-ID: <20221111122015.807616900@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=643AGhyNZmR2aie2PCCrOjp31nEV6JyyeqqH5V3vLDo=;
        b=Sw1lJkOUvkZ0DIAcRPl+ie495eVa6MbYCglERsRGFe8w0Y5OR00lTVkULAo3m3suKSbjrP
        0ow0a6Nw5jI91aq9J3EGWRZoVNumWiEKlIlIXZxwTYrItsHWIo3QClO8S/4rXyABHAgyRd
        VLCJNs9QTCInxzPdTphoMGKQBBAQzQYXZZzvOmqqZ5Wydl5zhwLSMUpWma3gufRqtR7R7c
        Q7e/lmelPnuCPGVViHH7TrfQy0Chs28OJpRiQP92j/k5T4lQXPSjBLR5hGCMjSgcBdnQev
        9JltwNMmtLP7XxpQGxTpy8LoCtAOCTdKp0RybLPEIGZ6vG3MULDpIUQfdcegHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=643AGhyNZmR2aie2PCCrOjp31nEV6JyyeqqH5V3vLDo=;
        b=CEwbqwdLhlbEE3zKR1PyZBZm1Iv1k/zk7+gvTQLDniqqGqeEfGsMiJ+J0PDZl7Nx3yuYOM
        y3Rvy6Y7JuG7mMBQ==
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
Subject: [patch 38/39] genirq/msi: Remove msi_domain_ops::msi_check()
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:55:15 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    4 ----
 kernel/irq/msi.c    |   17 +----------------
 2 files changed, 1 insertion(+), 20 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -288,7 +288,6 @@ struct msi_domain_info;
  * @get_hwirq:		Retrieve the resulting hw irq number
  * @msi_init:		Domain specific init function for MSI interrupts
  * @msi_free:		Domain specific function to free a MSI interrupts
- * @msi_check:		Callback for verification of the domain/info/dev data
  * @msi_prepare:	Prepare the allocation of the interrupts in the domain
  * @set_desc:		Set the msi descriptor for an interrupt
  * @domain_alloc_irqs:	Optional function to override the default allocation
@@ -326,9 +325,6 @@ struct msi_domain_ops {
 	void		(*msi_free)(struct irq_domain *domain,
 				    struct msi_domain_info *info,
 				    unsigned int virq);
-	int		(*msi_check)(struct irq_domain *domain,
-				     struct msi_domain_info *info,
-				     struct device *dev);
 	int		(*msi_prepare)(struct irq_domain *domain,
 				       struct device *dev, int nvec,
 				       msi_alloc_info_t *arg);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -617,17 +617,9 @@ static int msi_domain_ops_init(struct ir
 	return 0;
 }
 
-static int msi_domain_ops_check(struct irq_domain *domain,
-				struct msi_domain_info *info,
-				struct device *dev)
-{
-	return 0;
-}
-
 static struct msi_domain_ops msi_domain_ops_default = {
 	.get_hwirq		= msi_domain_ops_get_hwirq,
 	.msi_init		= msi_domain_ops_init,
-	.msi_check		= msi_domain_ops_check,
 	.msi_prepare		= msi_domain_ops_prepare,
 	.set_desc		= msi_domain_ops_set_desc,
 	.domain_alloc_irqs	= __msi_domain_alloc_irqs,
@@ -655,8 +647,6 @@ static void msi_domain_update_dom_ops(st
 		ops->get_hwirq = msi_domain_ops_default.get_hwirq;
 	if (ops->msi_init == NULL)
 		ops->msi_init = msi_domain_ops_default.msi_init;
-	if (ops->msi_check == NULL)
-		ops->msi_check = msi_domain_ops_default.msi_check;
 	if (ops->msi_prepare == NULL)
 		ops->msi_prepare = msi_domain_ops_default.msi_prepare;
 	if (ops->set_desc == NULL)
@@ -707,13 +697,8 @@ int msi_domain_prepare_irqs(struct irq_d
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
-	int ret;
-
-	ret = ops->msi_check(domain, info, dev);
-	if (ret == 0)
-		ret = ops->msi_prepare(domain, dev, nvec, arg);
 
-	return ret;
+	return ops->msi_prepare(domain, dev, nvec, arg);
 }
 
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,

