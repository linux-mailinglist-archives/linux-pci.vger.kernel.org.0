Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3C5625C56
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbiKKOFE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiKKOEo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:04:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2363987B2B;
        Fri, 11 Nov 2022 05:58:53 -0800 (PST)
Message-ID: <20221111135205.368911521@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=e8FMSieAN/nuamC9qf7yvRciPl3gkYlctlSfz55sfqw=;
        b=whPHvmGsSTEAxU0UpyWL+s2V98t8wQyMTkxmtcd3cFXgOGnWMjhx4YnxJWu8M+OFve1iEm
        2kWzHThXQzkJZEDdJ+9EQpyEOLJryPs0CK/4lYS55RTgMuSWVTXxLvjJge6071up38G8z3
        wPW65B7I/v5uiVDEb2yXTphln4iR2r2RDa/5hLeytVR/f0z4j+K8DcyxNbMFEHJLNAYeTI
        O0CSuItSz2dT03GPUIn7DqDRlrQBxvhMcn197ojQcoj8x6FRTqeaqahntGPSGiIax1pn4Z
        9ORsvROp++bdSHkjnorAcyg606IZ5KyGkduPbjClPaizcHMI2fWXXKgArNyV0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=e8FMSieAN/nuamC9qf7yvRciPl3gkYlctlSfz55sfqw=;
        b=Easie5wEeQFjls8M+15mkYyIDobQYmQxU9KI3o95c+umHJwBwacQjMprgv1YGq2vfl5Pn8
        uzq5ge9MfxJaxgAA==
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
Subject: [patch 02/33] genirq/msi: Provide struct msi_parent_ops
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:14 +0100 (CET)
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
 include/linux/irqdomain.h |    5 +++++
 include/linux/msi.h       |   20 ++++++++++++++++++++
 kernel/irq/msi.c          |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

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
@@ -488,6 +488,26 @@ enum {
 
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
+					     struct irq_domain *real_parent,
+					     struct msi_domain_info *info);
+};
+
+bool msi_parent_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info);
+
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
 			    bool force);
 
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -825,6 +825,42 @@ struct irq_domain *msi_create_irq_domain
 	return domain;
 }
 
+/**
+ * msi_parent_init_dev_msi_info - Delegate initialization of device MSI info to parent domain
+ * @dev:		The device for which the domain should be created
+ * @domain:		The domain which delegates
+ * @real_parent:	The real parent domain of the to be initialized MSI domain
+ * @info:		The MSI domain info to initialize
+ *
+ * Return: true on success, false otherwise
+ *
+ * This is the most complex problem of per device MSI domains and the
+ * underlying interrupt domain hierarchy:
+ *
+ * The device domain to be initialized requests the broadest feature set
+ * possible and the underlying domain hierarchy puts restrictions on it.
+ *
+ * That's working perfectly fine for a strict parent->device model, but it
+ * falls apart with a root_parent->real_parent->device chain because the
+ * intermediate 'real parent' can expand the capabilities which the
+ * 'root_parent' domain is providing. So that creates a classic hen and egg
+ * problem: Which entity is doing the restrictions/expansions?
+ *
+ * One solution is to let the root parent domain handle the initialization
+ * that's why there is the @domain and the @real_parent pointer.
+ */
+bool msi_parent_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	struct irq_domain *parent = domain->parent;
+
+	if (WARN_ON_ONCE(!parent || !parent->msi_parent_ops ||
+			 !parent->msi_parent_ops->init_dev_msi_info))
+		return false;
+
+	return parent->msi_parent_ops->init_dev_msi_info(dev, parent, real_parent, info);
+}
+
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec, msi_alloc_info_t *arg)
 {

