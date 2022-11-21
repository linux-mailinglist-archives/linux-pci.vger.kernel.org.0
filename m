Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A56E6326BB
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiKUOsY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiKUOqo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:46:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3559DD2883;
        Mon, 21 Nov 2022 06:41:04 -0800 (PST)
Message-ID: <20221121140048.913023922@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=idBO2Jn3x7lJLQyPZWlY/n45k+pAZ7w1xLsTIR+PA4Q=;
        b=vYJ3zwSV7ba7WJwns1j0+2RwIgwpv41OLCYeXbqcxPsKW7xxH3hu5JG8a5gekFdSnHDMwk
        vCEnkFzoW3KSLiz2b5rqXGHcwZbsJuj4WwPpOAOXpDpInmL/LTLAXsV3BFPyPAFDtGzZ6+
        V+Z8xHB8vYIdUkG57DCiCeVOf+qFaZK3bKwva4LDpEV73Lvt8cocbRC0PjCtYRYDVdTS8T
        Rzb3AD2JkOBlqMS8IpMvRlkoI2SQ37mjUPFs5A54cLryF0XFkzumCTRPIHaT18DXI1UaYE
        nG3WJuzYkhsp9Zwzk9Yka/kC3JZmXzaJxwnZvfbTCdGiYYhK81qp0YTwiJoGbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=idBO2Jn3x7lJLQyPZWlY/n45k+pAZ7w1xLsTIR+PA4Q=;
        b=fPTd3YlKMUbpX7p/xnzUnj3Y1k0ggMFVNh1oc6avPGlyM1NCHu7cEj3F77oxLPltSAxWwj
        HJodJOv7sk1eX8BQ==
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
Subject: [patch V2 10/40] irqchip: Provide irq-gic-lib
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:41 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All irqdomains which provide MSI parent domain functionality for per device
MSI domains need to provide a select() callback for the irqdomain and a
function to initialize the child domain.

Most of these functions would just be copy&pasta with minimal
modifications, so provide a library function which implements the required
functionality and is customizable via parent_domain::msi_parent_ops

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Export functions for modular irqchip drivers...
---
 drivers/irqchip/Kconfig           |    3 +
 drivers/irqchip/Makefile          |    1 
 drivers/irqchip/irq-gic-msi-lib.c |  112 ++++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-msi-lib.h |   19 ++++++
 4 files changed, 135 insertions(+)

--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -30,6 +30,9 @@ config ARM_GIC_V2M
 config GIC_NON_BANKED
 	bool
 
+config ARM_GIC_MSI_LIB
+	bool
+
 config ARM_GIC_V3
 	bool
 	select IRQ_DOMAIN_HIERARCHY
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-sh
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_PM)		+= irq-gic-pm.o
 obj-$(CONFIG_ARCH_REALVIEW)		+= irq-gic-realview.o
+obj-$(CONFIG_ARM_GIC_MSI_LIB)		+= irq-gic-msi-lib.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o
--- /dev/null
+++ b/drivers/irqchip/irq-gic-msi-lib.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#include <linux/export.h>
+
+#include "irq-gic-msi-lib.h"
+
+/**
+ * gic_msi_lib_init_dev_msi_info - Domain info setup for MSI domains
+ * @dev:		The device for which the domain is created for
+ * @domain:		The domain providing this callback
+ * @real_parent:	The real parent domain of the to initialize domain
+ *			which might be a domain built on top of @domain
+ *			or @domain itself
+ * @info:		The domain info for the to initialize domain
+ *
+ * This function is to be used for all types of MSI domains above the root
+ * parent domain and any intermediates. The topmost parent domain specific
+ * functionality is determined via @real_parent.
+ *
+ * All intermediate domains between the root and the device domain must
+ * have either msi_parent_ops.init_dev_msi_info = msi_parent_init_dev_msi_info
+ * or invoke it down the line.
+ */
+bool gic_msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				   struct irq_domain *real_parent,
+				   struct msi_domain_info *info)
+{
+	const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
+
+	/*
+	 * MSI parent domain specific settings. For now there is only the
+	 * root parent domain, e.g. NEXUS, acting as a MSI parent, but it is
+	 * possible to stack MSI parents. See x86 vector -> irq remapping
+	 */
+	if (domain->bus_token == pops->bus_select_token) {
+		if (WARN_ON_ONCE(domain != real_parent))
+			return false;
+	} else {
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/* Parent ops available? */
+	if (WARN_ON_ONCE(!pops))
+		return false;
+
+	/* Is the target domain bus token supported ? */
+	switch(info->bus_token) {
+	default:
+		/*
+		 * This should never be reached. See
+		 * gic_msi_lib_irq_domain_select()
+		 */
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/*
+	 * Mask out the domain specific MSI feature flags which are not
+	 * supported by the real parent.
+	 */
+	info->flags			&= pops->supported_flags;
+	/* Enforce the required flags */
+	info->flags			|= pops->required_flags;
+
+	/* Chip updates for all child bus types */
+	if (!info->chip->irq_eoi)
+		info->chip->irq_eoi	= irq_chip_eoi_parent;
+
+	/*
+	 * The device MSI domain can never have a set affinity callback it
+	 * always has to rely on the parent domain to handle affinity
+	 * settings. The device MSI domain just has to write the resulting
+	 * MSI message into the hardware which is the whole purpose of the
+	 * device MSI domain aside of mask/unmask which is provided e.g. by
+	 * PCI/MSI device domains.
+	 */
+	info->chip->irq_set_affinity	= msi_domain_set_affinity;
+	return true;
+}
+EXPORT_SYMBOL_GPL(gic_msi_lib_init_dev_msi_info);
+
+/**
+ * gic_msi_lib_irq_domain_select - Shared select function for NEXUS domains
+ * @d:		Pointer to the irq domain on which select is invoked
+ * @fwspec:	Firmware spec describing what is searched
+ * @bus_token:	The bus token for which a matching irq domain is looked up
+ *
+ * Returns:	%0 if @d is not what is being looked for
+ *
+ *		%1 if @d is either the domain which is directly searched for or
+ *		   if @d is providing the parent MSI domain for the functionality
+ *			 requested with @bus_token.
+ */
+int gic_msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+				  enum irq_domain_bus_token bus_token)
+{
+	const struct msi_parent_ops *ops = d->msi_parent_ops;
+	u32 busmask = BIT(bus_token);
+
+	if (fwspec->fwnode != d->fwnode || fwspec->param_count != 0)
+		return 0;
+
+	/* Handle pure domain searches */
+	if (bus_token == ops->bus_select_token)
+		return 1;
+
+	return ops && !!(ops->bus_select_mask & busmask);
+}
+EXPORT_SYMBOL_GPL(gic_msi_lib_irq_domain_select);
--- /dev/null
+++ b/drivers/irqchip/irq-gic-msi-lib.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#ifndef _DRIVERS_IRQCHIP_IRQ_GIC_MSI_LIB_H
+#define _DRIVERS_IRQCHIP_IRQ_GIC_MSI_LIB_H
+
+#include <linux/bits.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+
+int gic_msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+				  enum irq_domain_bus_token bus_token);
+
+bool gic_msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				   struct irq_domain *real_parent,
+				   struct msi_domain_info *info);
+
+#endif /* _DRIVERS_IRQCHIP_IRQ_GIC_MSI_LIB_H */

