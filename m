Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB286326DF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiKUOvH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiKUOud (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:50:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6A49E963;
        Mon, 21 Nov 2022 06:42:43 -0800 (PST)
Message-ID: <20221121140050.005249847@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1qf1CpiGQuxTaBaQJziws0lBHcg/Bs5K2Mj5ASL27jM=;
        b=H2+nRsG8r586jKjGAlvKt02BDjMI4po3O2a4W8Od2X4bXuZeT3lW2rJMe4phHNkAI99TLm
        Ka0mmJns6BM2nQzY4k/oZdqezW6fbHT07Gq9Yqosps2wnx6f/GsDWIFRfzXQ+EVzGwH2XC
        3ZiuYMZfQcPU0gzvHqnVKJELBhO4Dos+B3LYDCQCnJXhJmVCGeLeFogvREJUykOt7BzENw
        IeJCETfKmzXN+TiU/ptwiBFZCbBacy0bubqfW9Lt7AafjiqqA+HN8F8s7bUtHJM7u5NZlK
        QJ4G8NZkIT0HnjXlu39mW1YzF3KNzBzWd5nqR5xM+p4rnSYxyPLZGlYVq6Ex/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1qf1CpiGQuxTaBaQJziws0lBHcg/Bs5K2Mj5ASL27jM=;
        b=4fQWxlxTHf6bVWds80rgtZQcBfZVZmudrfS4kGvp2hUUm7KhRFgD5PA2u0Cj9RqTYoasWR
        TpHZF16CQUFoO8Ag==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 27/40] irqchip/mbigen: Remove
 platform_msi_create_device_domain() fallback
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:40:02 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that ITS provides the MSI parent domain, remove the unused fallback
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-mbigen.c |   74 ++-----------------------------------------
 1 file changed, 4 insertions(+), 70 deletions(-)

--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -180,64 +180,6 @@ static int mbigen_domain_translate(struc
 	return -EINVAL;
 }
 
-/* The following section will go away once ITS provides a MSI parent */
-
-static struct irq_chip mbigen_irq_chip = {
-	.name =			"mbigen-v2",
-	.irq_mask =		irq_chip_mask_parent,
-	.irq_unmask =		irq_chip_unmask_parent,
-	.irq_eoi =		mbigen_eoi_irq,
-	.irq_set_type =		mbigen_set_type,
-	.irq_set_affinity =	irq_chip_set_affinity_parent,
-};
-
-static int mbigen_irq_domain_alloc(struct irq_domain *domain,
-					unsigned int virq,
-					unsigned int nr_irqs,
-					void *args)
-{
-	struct irq_fwspec *fwspec = args;
-	irq_hw_number_t hwirq;
-	unsigned int type;
-	struct mbigen_device *mgn_chip;
-	int i, err;
-
-	err = mbigen_domain_translate(domain, fwspec, &hwirq, &type);
-	if (err)
-		return err;
-
-	err = platform_msi_device_domain_alloc(domain, virq, nr_irqs);
-	if (err)
-		return err;
-
-	mgn_chip = platform_msi_get_host_data(domain);
-
-	for (i = 0; i < nr_irqs; i++)
-		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
-				      &mbigen_irq_chip, mgn_chip->base);
-
-	return 0;
-}
-
-static void mbigen_irq_domain_free(struct irq_domain *domain, unsigned int virq,
-				   unsigned int nr_irqs)
-{
-	platform_msi_device_domain_free(domain, virq, nr_irqs);
-}
-
-static const struct irq_domain_ops mbigen_domain_ops = {
-	.translate	= mbigen_domain_translate,
-	.alloc		= mbigen_irq_domain_alloc,
-	.free		= mbigen_irq_domain_free,
-};
-
-static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
-{
-	mbigen_write_msi_msg(irq_get_irq_data(desc->irq), msg);
-}
-
-/* End of to be removed section */
-
 static void mbigen_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 {
 	arg->desc = desc;
@@ -268,20 +210,12 @@ static const struct msi_domain_template
 static bool mbigen_create_device_domain(struct device *dev, unsigned int size,
 					struct mbigen_device *mgn_chip)
 {
-	struct irq_domain *domain = dev->msi.domain;
-
-	if (WARN_ON_ONCE(!domain))
+	if (WARN_ON_ONCE(!dev->msi.domain))
 		return false;
 
-	if (irq_domain_is_msi_parent(domain)) {
-		return msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
-						    &mbigen_msi_template, size,
-						    NULL, mgn_chip->base);
-	}
-
-	/* Remove once ITS provides MSI parent */
-	return !!platform_msi_create_device_domain(dev, size, mbigen_write_msg,
-						   &mbigen_domain_ops, mgn_chip);
+	return msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
+					    &mbigen_msi_template, size,
+					    NULL, mgn_chip->base);
 }
 
 static int mbigen_of_create_domain(struct platform_device *pdev,

