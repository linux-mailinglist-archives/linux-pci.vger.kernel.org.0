Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143FE625C77
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiKKOHv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbiKKOGX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:06:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B49D8A8E6;
        Fri, 11 Nov 2022 05:59:41 -0800 (PST)
Message-ID: <20221111135205.543363889@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Oak79lo/7cHcPMXn18Hj8VarinH9SEGY40y7VRfsAjo=;
        b=pBqdNgbAzXxUKGKDj7jLQp+M8aHV+AWaaXqgcvSxV4Fof+m+6qNtNARkiEOYaQs3PtUzWR
        1hmh5rRhqmQgYwvRWYkWH6Q6J8SkydOIXNsk07GmGyKdl/B7AxwDSDE0X9U1NGwwxwDwv6
        YgZ7+WLSHMdAa2sFWlAaUAzVt99uBErWvOG9yx6iA8ykogkwtVmWeyucCeep5E6DUE049k
        CHNIVaUJg4njEDJi+1nHAm3kAQXQeKQuAD/brmbWZYa7HDxUJ5JykEHrQbL9e5OKvOZWsR
        DH13DwLpownYGkEqSwnQqgwp9QQlsYL2f442XAmdjEghnbHVI9BaMvXQvevHkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Oak79lo/7cHcPMXn18Hj8VarinH9SEGY40y7VRfsAjo=;
        b=mLJW7vo/nLUrPNcPAXXjSyIpq9qHGaPEIyrq6QBonl09L4LHa9MTGtdYktNIsqmLIUIrAL
        D7El80NCOTi87CAw==
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
Subject: [patch 05/33] genirq/msi: Split msi_create_irq_domain()
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:19 +0100 (CET)
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
@@ -795,17 +795,10 @@ static void msi_domain_update_chip_ops(s
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
 
@@ -813,7 +806,7 @@ struct irq_domain *msi_create_irq_domain
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		msi_domain_update_chip_ops(info);
 
-	domain = irq_domain_create_hierarchy(parent, IRQ_DOMAIN_FLAG_MSI, 0,
+	domain = irq_domain_create_hierarchy(parent, flags | IRQ_DOMAIN_FLAG_MSI, 0,
 					     fwnode, &msi_domain_ops, info);
 
 	if (domain) {
@@ -826,6 +819,21 @@ struct irq_domain *msi_create_irq_domain
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
  * msi_parent_init_dev_msi_info - Delegate initialization of device MSI info to parent domain
  * @dev:		The device for which the domain should be created
  * @domain:		The domain which delegates

