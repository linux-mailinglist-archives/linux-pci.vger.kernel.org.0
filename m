Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D0E63263D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiKUOip (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiKUOhv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:37:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1589773BB8;
        Mon, 21 Nov 2022 06:37:50 -0800 (PST)
Message-ID: <20221121091326.604272160@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=zyjjCorGuKC2reAb1ZhFkEbw6ekC0gDsCqvqwlCqPS8=;
        b=PjB9FR5YTbezkAxg4l4oOPZXzQSkQQcuWhs2mqPpF4tyGheB7Ldej/Uoy8TjsHFm3HwDu6
        BOv1pYhG9HIYfn1z0CAvyLVcow0lyFB/5MxvmhtvgfIWaxRHLXR1HYE7mzVkk/7SmjO2HS
        9QMDuinQerjtHndmle2+kvJDGH8OGcry8NPTMq6gBSJXCOVRgzRnqcE6bNhDYx9spbcKHW
        qEknGGPZPna1svXFJQ59k8GPjiicurptkvUdcZ7SBCnbr9i5nZ3ByM4uuqmTbcFLQULpfN
        SUfFHDBe7410tuWbWKThuRQMB+znwZ9mdK87DzSPfBxrj1ZtLEXuTQmZuOdGqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=zyjjCorGuKC2reAb1ZhFkEbw6ekC0gDsCqvqwlCqPS8=;
        b=akBvOMHFkSJ7X9at4DMMI/tB55KtYRhUhJOgiND7DHwm+2enzKdXynGJ4sagfkIFK7sgsx
        wh7h9XKejDNfeMAg==
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
Subject: [patch V2 02/33] genirq/msi: Provide struct msi_parent_ops
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:37:48 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MSI parent domains must have some control over the MSI domains which are
built on top. On domain creation they need to fill in e.g. architecture
specific chip callbacks or msi domain ops to make the outermost domain
parent agnostic which is obviously required for architecture independence
etc.

The structure contains:

    1) A bitfield which exposes the supported functional features. This
       allows to check for features and is also used in the initialization
       callback to mask out unsupported features when the actual domain
       implementation requests a broader range, e.g. on x86 PCI multi-MSI
       is only supported by remapping domains but not by the underlying
       vector domain. The PCI/MSI code can then always request multi-MSI
       support, but the resulting feature set after creation might not
       have it set.

    2) An optional string prefix which is put in front of domain and chip
       names during creation of the MSI domain. That allows to keep the
       naming schemes e.g. on x86 where PCI-MSI domains have a IR- prefix
       when interrupt remapping is enabled.

    3) An initialization callback to sanity check the domain info of
       the to be created MSI domain, to restrict features and to
       apply changes in MSI ops and interrupt chip callbacks to
       accomodate to the particular MSI parent implementation and/or
       the underlying hierarchy.

Add a conveniance function to delegate the initialization from the
MSI parent domain to an underlying domain in the hierarchy.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Renamed arguments and updated comments (Jason)
---
 include/linux/irqdomain.h |    5 +++++
 include/linux/msi.h       |   21 +++++++++++++++++++++
 kernel/irq/msi.c          |   41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -46,6 +46,7 @@ struct irq_desc;
 struct cpumask;
 struct seq_file;
 struct irq_affinity_desc;
+struct msi_parent_ops;
 
 #define IRQ_DOMAIN_IRQ_SPEC_PARAMS 16
 
@@ -134,6 +135,7 @@ struct irq_domain_chip_generic;
  * @pm_dev:	Pointer to a device that can be utilized for power management
  *		purposes related to the irq domain.
  * @parent:	Pointer to parent irq_domain to support hierarchy irq_domains
+ * @msi_parent_ops: Pointer to MSI parent domain methods for per device domain init
  *
  * Revmap data, used internally by the irq domain code:
  * @revmap_size:	Size of the linear map table @revmap[]
@@ -157,6 +159,9 @@ struct irq_domain {
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_domain		*parent;
 #endif
+#ifdef CONFIG_GENERIC_MSI_IRQ
+	const struct msi_parent_ops	*msi_parent_ops;
+#endif
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
 	irq_hw_number_t			hwirq_max;
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -492,6 +492,27 @@ enum {
 
 };
 
+/**
+ * struct msi_parent_ops - MSI parent domain callbacks and configuration info
+ *
+ * @supported_flags:	Required: The supported MSI flags of the parent domain
+ * @prefix:		Optional: Prefix for the domain and chip name
+ * @init_dev_msi_info:	Required: Callback for MSI parent domains to setup parent
+ *			domain specific domain flags, domain ops and interrupt chip
+ *			callbacks when a per device domain is created.
+ */
+struct msi_parent_ops {
+	u32		supported_flags;
+	const char	*prefix;
+	bool		(*init_dev_msi_info)(struct device *dev, struct irq_domain *domain,
+					     struct irq_domain *msi_parent_domain,
+					     struct msi_domain_info *msi_child_info);
+};
+
+bool msi_parent_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				  struct irq_domain *msi_parent_domain,
+				  struct msi_domain_info *msi_child_info);
+
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
 			    bool force);
 
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -826,6 +826,47 @@ struct irq_domain *msi_create_irq_domain
 	return domain;
 }
 
+/**
+ * msi_parent_init_dev_msi_info - Delegate initialization of device MSI info down
+ *				  in the domain hierarchy
+ * @dev:		The device for which the domain should be created
+ * @domain:		The domain in the hierarchy this op is being called on
+ * @msi_parent_domain:	The IRQ_DOMAIN_FLAG_MSI_PARENT domain for the child to
+ *			be created
+ * @msi_child_info:	The MSI domain info of the IRQ_DOMAIN_FLAG_MSI_DEVICE
+ *			domain to be created
+ *
+ * Return: true on success, false otherwise
+ *
+ * This is the most complex problem of per device MSI domains and the
+ * underlying interrupt domain hierarchy:
+ *
+ * The device domain to be initialized requests the broadest feature set
+ * possible and the underlying domain hierarchy puts restrictions on it.
+ *
+ * That's trivial for a simple parent->child relationship, but it gets
+ * interesting with an intermediate domain: root->parent->child.  The
+ * intermediate 'parent' can expand the capabilities which the 'root'
+ * domain is providing. So that creates a classic hen and egg problem:
+ * Which entity is doing the restrictions/expansions?
+ *
+ * One solution is to let the root domain handle the initialization that's
+ * why there is the @domain and the @msi_parent_domain pointer.
+ */
+bool msi_parent_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				  struct irq_domain *msi_parent_domain,
+				  struct msi_domain_info *msi_child_info)
+{
+	struct irq_domain *parent = domain->parent;
+
+	if (WARN_ON_ONCE(!parent || !parent->msi_parent_ops ||
+			 !parent->msi_parent_ops->init_dev_msi_info))
+		return false;
+
+	return parent->msi_parent_ops->init_dev_msi_info(dev, parent, msi_parent_domain,
+							 msi_child_info);
+}
+
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec, msi_alloc_info_t *arg)
 {

