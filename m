Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA481625B9F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiKKNzW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiKKNy4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:54:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D19165863;
        Fri, 11 Nov 2022 05:54:32 -0800 (PST)
Message-ID: <20221111122014.179595843@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=oY+wTD07UJdZe/4apbDgNNcex5cwO56TFt4SFwForIc=;
        b=XKH6NEiB67Xn3bODoK1UFNxfG2Caz8t/SVVKnrvUY4TysvhYRo1CTn8qB9QRn9RXgGnOUn
        ZlbsPVdXWbPeRr+WmykWCafK8bLI9q2+VQe4v5gBp0//TxvsSvxCpPxquAuRMxNEgtM/2N
        FxObd8tB3rxUW6wBz7mLBiKynGG5OmxeXo5buw0kruHyiYCT7q3lsatjITlV+OIRMqapgo
        /ZgLE9xBM91qCV2tv5mSnn5R76PdySctgB00+MO+fIVUWs9O5o7hYp6u+FWK6+yL40MA1E
        eIxjf8p9VQYpJPcp119zLp2e+qHu7Ls8pywkEyFDGq1LVZW6sAQAPyCaxlhp7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=oY+wTD07UJdZe/4apbDgNNcex5cwO56TFt4SFwForIc=;
        b=DEHoveL7w/ktG5ghiwXKDZHBT8EPqXrrOFE5Ik9fSJifrawkey+Jqom1hnjX29gXiW58gk
        NcPL/Y06TjJtq6Cg==
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
Subject: [patch 10/39] genirq/msi: Make __msi_domain_free_irqs() static
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:30 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the last user is gone, confine it to the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    4 ----
 kernel/irq/msi.c    |    3 ++-
 2 files changed, 2 insertions(+), 5 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -335,9 +335,6 @@ struct msi_domain_info;
  * are set to the default implementation if NULL and even when
  * MSI_FLAG_USE_DEF_DOM_OPS is not set to avoid breaking existing users and
  * because these callbacks are obviously mandatory.
- *
- * __msi_domain_free_irqs() is exposed for PPC pseries to handle extra
- * work after all interrupts and descriptors have been freed.
  */
 struct msi_domain_ops {
 	irq_hw_number_t	(*get_hwirq)(struct msi_domain_info *info,
@@ -432,7 +429,6 @@ int msi_domain_alloc_irqs_descs_locked(s
 				       int nvec);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec);
-void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -463,6 +463,7 @@ static inline void msi_sysfs_remove_desc
 
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec);
+static void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
@@ -978,7 +979,7 @@ int msi_domain_alloc_irqs(struct irq_dom
 	return ret;
 }
 
-void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+static void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct irq_data *irqd;

