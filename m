Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A95B625B98
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiKKNyz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiKKNyv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:54:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC8C6F366;
        Fri, 11 Nov 2022 05:54:27 -0800 (PST)
Message-ID: <20221111122014.004725919@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GAKiePxBwA26UOzSRlo0ofGhAo2Fb7Jw45XwvXqJzKU=;
        b=Yu6U84ia9FLugctorieny+7ozdDKY9K4yqqmT77rPtFmjIsYVb+xbI+H5owKByCTwabGFi
        XSUP3+twnj3K2LOXu5MGeCAk5Fqc95LTtwvoNYzKrFPOlHQMT38RZvffj79o/PUIffICyR
        Jw4JMo25Fr0VI6ucEf2SRxIGXBk5fNUjPRXoubLhcl+2CXsZWT11nLZF51xi1yvuNx3JzV
        vLMM+vvz4a8LfnKYX3C/JE+uy3X/nEjWc4GtcwLcypC9JiCo0kd0nnPqlNus4OEuGchKBA
        /pQVvyBdbBupRB6uqKjHCKGo5tVWIdNOeHLUIvsxZS9dpIQyB+6Of8k52fhTUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GAKiePxBwA26UOzSRlo0ofGhAo2Fb7Jw45XwvXqJzKU=;
        b=oM7mFTR/BDMFIdSFauwnokPDjh6lKKffIIiPbVtB8cy6c9N5UGO9yua+3dqGd7aiCGwFmW
        BpQKABGh9Jg8x2DA==
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
Subject: [patch 07/39] genirq/msi: Make __msi_domain_alloc_irqs() static
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:25 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Nothing outside of the core code requires this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    7 ++-----
 kernel/irq/msi.c    |    6 ++++--
 2 files changed, 6 insertions(+), 7 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -334,9 +334,8 @@ struct msi_domain_info;
  * MSI_FLAG_USE_DEF_DOM_OPS is not set to avoid breaking existing users and
  * because these callbacks are obviously mandatory.
  *
- * This is NOT meant to be abused, but it can be useful to build wrappers
- * for specialized MSI irq domains which need extra work before and after
- * calling __msi_domain_alloc_irqs()/__msi_domain_free_irqs().
+ * __msi_domain_free_irqs() is exposed for PPC pseries to handle extra
+ * work after all interrupts and descriptors have been freed.
  */
 struct msi_domain_ops {
 	irq_hw_number_t	(*get_hwirq)(struct msi_domain_info *info,
@@ -425,8 +424,6 @@ int msi_domain_set_affinity(struct irq_d
 struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
-int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			    int nvec);
 int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
 				       int nvec);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -462,6 +462,8 @@ static inline void msi_sysfs_remove_desc
 #endif /* !CONFIG_SYSFS */
 
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec);
+
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
 {
@@ -852,8 +854,8 @@ static int msi_init_virq(struct irq_doma
 	return 0;
 }
 
-int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			    int nvec)
+static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
+				   int nvec)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;

