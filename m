Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF41A638187
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiKXX1v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiKXX1X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:27:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5112A976DF;
        Thu, 24 Nov 2022 15:26:16 -0800 (PST)
Message-ID: <20221124232325.559086358@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NNfDCQRDz9DltLDIG/7m5g8s58pcCqqYMsewa1N3sZE=;
        b=afGnU5wXi26xEDzhSpDaPnEag0oZF2TFyPqjsgHSNRixpkbaGf7N5ZxDRRpJ3K+kr4VdO+
        U6Oz2WCjDUPpJ3xXt2d12nuPkGrdmzJ8nNCcM1F5WvMtIl2Pb6lThpuIDMWhzxCZaO8Ji6
        3ZZ87Y7YioBTLHbyM8dFmw4DZdVq8pPmSUX8DNxgO7ocoJrPHEyItI8fsx0TymMXyiJ3PM
        kiE5TnW49uMz6ZeAAhSM8kz6iL+uKOMfA9VfjaEHQGJzTiVC2279X+1EkWWlfauRQObaL5
        vNaKIjAHvjf5EeIPB1kVnTYUXBygL1qjFXBVBWYtc+YZx+l3VIfBXWyB0uRTOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NNfDCQRDz9DltLDIG/7m5g8s58pcCqqYMsewa1N3sZE=;
        b=Ojr368Qg/5Wa/X97FxSO9JlwdMYyVi5CrQmizkHWeZAoQ2OCJ5O/Sj4JHpk+mfgQcVfZax
        Zo/+IoxXwkpwzLDw==
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
Subject: [patch V3 05/33] genirq/msi: Split msi_create_irq_domain()
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:25:52 +0100 (CET)
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
@@ -759,17 +759,10 @@ static void msi_domain_update_chip_ops(s
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
 
@@ -788,7 +781,7 @@ struct irq_domain *msi_create_irq_domain
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		msi_domain_update_chip_ops(info);
 
-	domain = irq_domain_create_hierarchy(parent, IRQ_DOMAIN_FLAG_MSI, 0,
+	domain = irq_domain_create_hierarchy(parent, flags | IRQ_DOMAIN_FLAG_MSI, 0,
 					     fwnode, &msi_domain_ops, info);
 
 	if (domain) {
@@ -801,6 +794,21 @@ struct irq_domain *msi_create_irq_domain
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

