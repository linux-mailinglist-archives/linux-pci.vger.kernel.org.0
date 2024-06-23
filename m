Return-Path: <linux-pci+bounces-9136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DAD913C11
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C920CB210D0
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0F11822EA;
	Sun, 23 Jun 2024 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fWGnebn6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VI6OsYSz"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4E6181D18;
	Sun, 23 Jun 2024 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155918; cv=none; b=A2Q5wnJJK0PxUtLjmV1EflIQr/lcbXQ/8eTe7X5kQxQYdCUTUvdfJVXko39r9sDr5hVxRoBugXQazALdlTxk+CVDswQRmM4c4rqq8vtZ4V88qcyTE2x+676gCZKbObxmT+Z0p74PHVQyygH5DT/yg8MpzubrwFJo79w/I6put4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155918; c=relaxed/simple;
	bh=9Q+nXN18QBrbiL/IEIzVg8KsCQFQDRO9BkMAkExnKf4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=mtg7VT4augr5DuEDvw9QP9QQsRnB08QQ4xHR1H1WpGts1Y8hUCeeNvgMbNLVqQ+mhFOi/PZ5xj0gupntSRRuTfebACBIKbUGJS27skPwTz07PRctIHUufvDjJ/WMhvhjxTNMhqsA6wUo164HEDb2Ikkhptalp7bFmkKVoNVz6WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fWGnebn6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VI6OsYSz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142234.840975799@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=SqGRn5Sy0tg5tHJ1W1Lp/xdsweqGEk5oPxDfF69Xgfc=;
	b=fWGnebn6fqorjysimxEkBhiQJD1xxMcnGKpX/OE/q0QNSPEG/4zedPQsqEFaSNnuzg2qXf
	dP/0Qlh3rK9ocsIQ8ag/dduyIPHUeMotvgBcSCSnLvoNc/77h4xpzXPvL6QEXciCujQAxL
	+s5TICUdJzWEe2faaTlr9lh1xM8jRiGGSwbJqgVC/mRjy226grUI2v41YPuGblLGSDpG83
	vF5O3x6oC+f13rO9EfztzkMDSova/ldGLhQ/DtCwle4I46eFbqyzVOo6wSXyiVvf34C8Ou
	CQATdgm7aKnkiz0WuHtni6DV0X/I6ZYrFh3OmxUXM08S+n4ZxcoFfDoJgBdUOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=SqGRn5Sy0tg5tHJ1W1Lp/xdsweqGEk5oPxDfF69Xgfc=;
	b=VI6OsYSznzzc4OPFy3At95S4oz5VOl1fbs2fxZEvtyKxprbVLV2wkAuB+GjfOGyLwWFFD0
	S5LiW2Oabel6MfAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 maz@kernel.org,
 tglx@linutronix.de,
 anna-maria@linutronix.de,
 shawnguo@kernel.org,
 s.hauer@pengutronix.de,
 festevam@gmail.com,
 bhelgaas@google.com,
 rdunlap@infradead.org,
 vidyas@nvidia.com,
 ilpo.jarvinen@linux.intel.com,
 apatel@ventanamicro.com,
 kevin.tian@intel.com,
 nipun.gupta@amd.com,
 den@valinux.co.jp,
 andrew@lunn.ch,
 gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 alex.williamson@redhat.com,
 will@kernel.org,
 lorenzo.pieralisi@arm.com,
 jgg@mellanox.com,
 ammarfaizi2@gnuweeb.org,
 robin.murphy@arm.com,
 lpieralisi@kernel.org,
 nm@ti.com,
 kristo@kernel.org,
 vkoul@kernel.org,
 okaya@kernel.org,
 agross@kernel.org,
 andersson@kernel.org,
 mark.rutland@arm.com,
 shameerali.kolothum.thodi@huawei.com,
 yuzenghui@huawei.com,
 shivamurthy.shastri@linutronix.de
Subject: [patch V4 02/21] irqchip: Provide irq-msi-lib
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 17:18:34 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

All irqdomains which provide MSI parent domain functionality for per device
MSI domains need to provide a select() callback for the irqdomain and a
function to initialize the child domain.

Most of these functions would just be copy&paste with minimal
modifications, so provide a library function which implements the required
functionality and is customizable via parent_domain::msi_parent_ops. The
check for the supported bus tokens in msi_lib_init_dev_msi_info() is
expanded step by step within the next patches.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
v3: renamed file and functions as the library is independent of gic -
Frank Li
---
 drivers/irqchip/Kconfig       |   3 +
 drivers/irqchip/Makefile      |   1 +
 drivers/irqchip/irq-msi-lib.c | 112 ++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-msi-lib.h |  19 ++++++
 4 files changed, 135 insertions(+)
 create mode 100644 drivers/irqchip/irq-msi-lib.c
 create mode 100644 drivers/irqchip/irq-msi-lib.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 14464716bacb..2bf8d940504c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -74,6 +74,9 @@ config ARM_VIC_NR
 	  The maximum number of VICs available in the system, for
 	  power management.
 
+config IRQ_MSI_LIB
+	bool
+
 config ARMADA_370_XP_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d9dc3d99aaa8..72c7f6289411 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_PM)		+= irq-gic-pm.o
 obj-$(CONFIG_ARCH_REALVIEW)		+= irq-gic-realview.o
+obj-$(CONFIG_IRQ_MSI_LIB)		+= irq-msi-lib.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o
diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
new file mode 100644
index 000000000000..acbccf8f7f5b
--- /dev/null
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#include <linux/export.h>
+
+#include "irq-msi-lib.h"
+
+/**
+ * msi_lib_init_dev_msi_info - Domain info setup for MSI domains
+ * @dev:		The device for which the domain is created for
+ * @domain:		The domain providing this callback
+ * @real_parent:	The real parent domain of the domain to be initialized
+ *			which might be a domain built on top of @domain or
+ *			@domain itself
+ * @info:		The domain info for the domain to be initialize
+ *
+ * This function is to be used for all types of MSI domains above the root
+ * parent domain and any intermediates. The topmost parent domain specific
+ * functionality is determined via @real_parent.
+ *
+ * All intermediate domains between the root and the device domain must
+ * have either msi_parent_ops.init_dev_msi_info = msi_parent_init_dev_msi_info
+ * or invoke it down the line.
+ */
+bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+			       struct irq_domain *real_parent,
+			       struct msi_domain_info *info)
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
+	/* Is the target domain bus token supported? */
+	switch(info->bus_token) {
+	default:
+		/*
+		 * This should never be reached. See
+		 * msi_lib_irq_domain_select()
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
+	 * The device MSI domain can never have a set affinity callback. It
+	 * always has to rely on the parent domain to handle affinity
+	 * settings. The device MSI domain just has to write the resulting
+	 * MSI message into the hardware which is the whole purpose of the
+	 * device MSI domain aside of mask/unmask which is provided e.g. by
+	 * PCI/MSI device domains.
+	 */
+	info->chip->irq_set_affinity	= msi_domain_set_affinity;
+	return true;
+}
+EXPORT_SYMBOL_GPL(msi_lib_init_dev_msi_info);
+
+/**
+ * msi_lib_irq_domain_select - Shared select function for NEXUS domains
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
+int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+			      enum irq_domain_bus_token bus_token)
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
+EXPORT_SYMBOL_GPL(msi_lib_irq_domain_select);
diff --git a/drivers/irqchip/irq-msi-lib.h b/drivers/irqchip/irq-msi-lib.h
new file mode 100644
index 000000000000..f0706cc28264
--- /dev/null
+++ b/drivers/irqchip/irq-msi-lib.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#ifndef _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H
+#define _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H
+
+#include <linux/bits.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+
+int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+			      enum irq_domain_bus_token bus_token);
+
+bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+			       struct irq_domain *real_parent,
+			       struct msi_domain_info *info);
+
+#endif /* _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H */
-- 
2.34.1



