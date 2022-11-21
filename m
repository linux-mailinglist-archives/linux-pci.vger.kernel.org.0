Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC830632641
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiKUOiu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiKUOhy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:37:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2707A77217;
        Mon, 21 Nov 2022 06:37:54 -0800 (PST)
Message-ID: <20221121091326.769133826@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MZ8jPM+DGKOpETlDvAHwxuzbjfVqWBMalr44KdANGx8=;
        b=jVyiurSFqZAUGWno02f2IPodi3QwmpcrP1Vp2Ks0TgbJO20F/dWxDsa5dkEbr6Pg7p97Zy
        rPp/3DeHMD3AmuIy1U6tnu38EVMxnDmSZ5WOK1XOEDm5yDz8fIPDe/LG0uIWDMtpu8iBS4
        vqdD0gGHsMTBRzfa1ctvixmDkcjkyFrvKI/cphmfB0/vKb9d53rQDJavu1Sin8HXPtqfTl
        7Fwh7u9cjesrfJL67x+o31/16McsURPTx7cl1gWZUfgzl8L4mUWxY8aO6fCEOb99PrmRqm
        jNat6FOPDzEVcjez0lrzaaeC2yqPDyEPR3Rh21W979eeXF67X5U6AgaAagyjJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MZ8jPM+DGKOpETlDvAHwxuzbjfVqWBMalr44KdANGx8=;
        b=CReccuOnPb82wr5d0rcYob2PGyVgUsEM1kQ3zSl0zyf8wPkw1ry+mxpKf5xLJwlBnkTmpS
        2Dcw+yPVAXZHm0Bw==
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
Subject: [patch V2 05/33] genirq/msi: Split msi_create_irq_domain()
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:37:52 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Split the functionality of msi_create_irq_domain() so it can
be reused for creating per device irq domains.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/msi.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -796,17 +796,10 @@ static void msi_domain_update_chip_ops(s
 		chip->irq_set_affinity = msi_domain_set_affinity;
 }
 
-/**
- * msi_create_irq_domain - Create an MSI interrupt domain
- * @fwnode:	Optional fwnode of the interrupt controller
- * @info:	MSI domain info
- * @parent:	Parent irq domain
- *
- * Return: pointer to the created &struct irq_domain or %NULL on failure
- */
-struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
-					 struct msi_domain_info *info,
-					 struct irq_domain *parent)
+static struct irq_domain *__msi_create_irq_domain(struct fwnode_handle *fwnode,
+						  struct msi_domain_info *info,
+						  unsigned int flags,
+						  struct irq_domain *parent)
 {
 	struct irq_domain *domain;
 
@@ -814,7 +807,7 @@ struct irq_domain *msi_create_irq_domain
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		msi_domain_update_chip_ops(info);
 
-	domain = irq_domain_create_hierarchy(parent, IRQ_DOMAIN_FLAG_MSI, 0,
+	domain = irq_domain_create_hierarchy(parent, flags | IRQ_DOMAIN_FLAG_MSI, 0,
 					     fwnode, &msi_domain_ops, info);
 
 	if (domain) {
@@ -827,6 +820,21 @@ struct irq_domain *msi_create_irq_domain
 }
 
 /**
+ * msi_create_irq_domain - Create an MSI interrupt domain
+ * @fwnode:	Optional fwnode of the interrupt controller
+ * @info:	MSI domain info
+ * @parent:	Parent irq domain
+ *
+ * Return: pointer to the created &struct irq_domain or %NULL on failure
+ */
+struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
+					 struct msi_domain_info *info,
+					 struct irq_domain *parent)
+{
+	return __msi_create_irq_domain(fwnode, info, 0, parent);
+}
+
+/**
  * msi_parent_init_dev_msi_info - Delegate initialization of device MSI info down
  *				  in the domain hierarchy
  * @dev:		The device for which the domain should be created

