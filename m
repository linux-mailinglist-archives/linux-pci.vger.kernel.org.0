Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598B2625C1E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbiKKOAy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbiKKOA2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:00:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C5756EFE;
        Fri, 11 Nov 2022 05:56:43 -0800 (PST)
Message-ID: <20221111132706.163937407@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2CoaFGPWc/Ouzc0vn/G/Q6h+d/JDyugVvhuanxsmmo8=;
        b=xUJTOaErxrOOcSWTbVuF75ylihHCzcZQNdIKx39UJGXuQnABkc2EtERk2eKPKfnwr6XIGV
        XoK+QDRyH5IrNhXvylE18HMvSb4GI1myk7noBEYTmnyGizh58RazzhdXTYwpC72Ek6ru03
        hjKKccJN0CpoAmWPDMg8DubLPA1pGpSmty4l2/AhrenLU0QJ4R8ifqmwG7aGymNM+ix7Xl
        +HVwLYMgAoHSxbTn4axGfyQxgRAWJfJpa9IFUZmXfIrACmaOi52JMR4jlby2/JQSHCQN/x
        qZzpDmJsxmWk1J92wQPNoFXM1Q3Hd24zUHCZZUOziSqWSwthlwDqJ2FT7HD0rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2CoaFGPWc/Ouzc0vn/G/Q6h+d/JDyugVvhuanxsmmo8=;
        b=+39+WuL03G/T25dbyzxcOa8C+uQ116zjlffPxkXWdNMxciHdcocHOT1lKjAnWEQ9uC2KMP
        B0Jo6+g1ESWMDGCA==
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
Subject: [patch 02/20] genirq/irqdomain: Rename irq_domain::dev to irq_domain::pm_dev
References: <20221111131813.914374272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:56:40 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

irq_domain::dev is a misnomer as it's usually the rule that a device
pointer points to something which is directly related to the instance.

irq_domain::dev can point to some other device for power management to
ensure that this underlying device is not powered down when an interrupt is
allocated.

The upcoming per device MSI domains really require a pointer to the device
which instantiated the irq domain and not to some random other device which
is required for power management down the chain.

Rename irq_domain::dev to irq_domain::pm_dev and fixup the few sites which
use that pointer.

Conversion was done with the help of coccinelle.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-gic.c |    4 +-
 include/linux/irqdomain.h |   76 +++++++++++++++++++++++-----------------------
 kernel/irq/chip.c         |    8 ++--
 3 files changed, 44 insertions(+), 44 deletions(-)

--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -401,8 +401,8 @@ static void gic_irq_print_chip(struct ir
 {
 	struct gic_chip_data *gic = irq_data_get_irq_chip_data(d);
 
-	if (gic->domain->dev)
-		seq_printf(p, gic->domain->dev->of_node->name);
+	if (gic->domain->pm_dev)
+		seq_printf(p, gic->domain->pm_dev->of_node->name);
 	else
 		seq_printf(p, "GIC-%d", (int)(gic - &gic_data[0]));
 }
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -117,53 +117,53 @@ struct irq_domain_chip_generic;
 
 /**
  * struct irq_domain - Hardware interrupt number translation object
- * @link: Element in global irq_domain list.
- * @name: Name of interrupt domain
- * @ops: pointer to irq_domain methods
- * @host_data: private data pointer for use by owner.  Not touched by irq_domain
- *             core code.
- * @flags: host per irq_domain flags
- * @mapcount: The number of mapped interrupts
+ * @link:	Element in global irq_domain list.
+ * @name:	Name of interrupt domain
+ * @ops:	Pointer to irq_domain methods
+ * @host_data:	Private data pointer for use by owner.  Not touched by irq_domain
+ *		core code.
+ * @flags:	Per irq_domain flags
+ * @mapcount:	The number of mapped interrupts
  *
- * Optional elements
- * @fwnode: Pointer to firmware node associated with the irq_domain. Pretty easy
- *          to swap it for the of_node via the irq_domain_get_of_node accessor
- * @gc: Pointer to a list of generic chips. There is a helper function for
- *      setting up one or more generic chips for interrupt controllers
- *      drivers using the generic chip library which uses this pointer.
- * @dev: Pointer to a device that the domain represent, and that will be
- *       used for power management purposes.
- * @parent: Pointer to parent irq_domain to support hierarchy irq_domains
+ * Optional elements:
+ * @fwnode:	Pointer to firmware node associated with the irq_domain. Pretty easy
+ *		to swap it for the of_node via the irq_domain_get_of_node accessor
+ * @gc:		Pointer to a list of generic chips. There is a helper function for
+ *		setting up one or more generic chips for interrupt controllers
+ *		drivers using the generic chip library which uses this pointer.
+ * @pm_dev:	Pointer to a device that can be utilized for power management
+ *		purposes related to the irq domain.
+ * @parent:	Pointer to parent irq_domain to support hierarchy irq_domains
  *
- * Revmap data, used internally by irq_domain
- * @revmap_size: Size of the linear map table @revmap[]
- * @revmap_tree: Radix map tree for hwirqs that don't fit in the linear map
- * @revmap_mutex: Lock for the revmap
- * @revmap: Linear table of irq_data pointers
+ * Revmap data, used internally by the irq domain code:
+ * @revmap_size:	Size of the linear map table @revmap[]
+ * @revmap_tree:	Radix map tree for hwirqs that don't fit in the linear map
+ * @revmap_mutex:	Lock for the revmap
+ * @revmap:		Linear table of irq_data pointers
  */
 struct irq_domain {
-	struct list_head link;
-	const char *name;
-	const struct irq_domain_ops *ops;
-	void *host_data;
-	unsigned int flags;
-	unsigned int mapcount;
+	struct list_head		link;
+	const char			*name;
+	const struct irq_domain_ops	*ops;
+	void				*host_data;
+	unsigned int			flags;
+	unsigned int			mapcount;
 
 	/* Optional data */
-	struct fwnode_handle *fwnode;
-	enum irq_domain_bus_token bus_token;
-	struct irq_domain_chip_generic *gc;
-	struct device *dev;
+	struct fwnode_handle		*fwnode;
+	enum irq_domain_bus_token	bus_token;
+	struct irq_domain_chip_generic	*gc;
+	struct device			*pm_dev;
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-	struct irq_domain *parent;
+	struct irq_domain		*parent;
 #endif
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
-	irq_hw_number_t hwirq_max;
-	unsigned int revmap_size;
-	struct radix_tree_root revmap_tree;
-	struct mutex revmap_mutex;
-	struct irq_data __rcu *revmap[];
+	irq_hw_number_t			hwirq_max;
+	unsigned int			revmap_size;
+	struct radix_tree_root		revmap_tree;
+	struct mutex			revmap_mutex;
+	struct irq_data __rcu		*revmap[];
 };
 
 /* Irq domain flags */
@@ -206,7 +206,7 @@ static inline void irq_domain_set_pm_dev
 					    struct device *dev)
 {
 	if (d)
-		d->dev = dev;
+		d->pm_dev = dev;
 }
 
 #ifdef CONFIG_IRQ_DOMAIN
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1561,10 +1561,10 @@ int irq_chip_compose_msi_msg(struct irq_
 	return 0;
 }
 
-static struct device *irq_get_parent_device(struct irq_data *data)
+static struct device *irq_get_pm_device(struct irq_data *data)
 {
 	if (data->domain)
-		return data->domain->dev;
+		return data->domain->pm_dev;
 
 	return NULL;
 }
@@ -1578,7 +1578,7 @@ static struct device *irq_get_parent_dev
  */
 int irq_chip_pm_get(struct irq_data *data)
 {
-	struct device *dev = irq_get_parent_device(data);
+	struct device *dev = irq_get_pm_device(data);
 	int retval = 0;
 
 	if (IS_ENABLED(CONFIG_PM) && dev)
@@ -1597,7 +1597,7 @@ int irq_chip_pm_get(struct irq_data *dat
  */
 int irq_chip_pm_put(struct irq_data *data)
 {
-	struct device *dev = irq_get_parent_device(data);
+	struct device *dev = irq_get_pm_device(data);
 	int retval = 0;
 
 	if (IS_ENABLED(CONFIG_PM) && dev)

