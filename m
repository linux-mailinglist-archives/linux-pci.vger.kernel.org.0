Return-Path: <linux-pci+bounces-8804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C24299089C3
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8EB51C22729
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A610319599E;
	Fri, 14 Jun 2024 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QaviekyS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9y42dO69"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCCF1957E1;
	Fri, 14 Jun 2024 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360719; cv=none; b=HLp8397rFICWwo5d7GMyZWmXudAm17h+j+5rxMf1EdQfpjBVt6OW1A8dJ6VW9+lcS/TutkcqJCFezvNCptSjQnYw0Zog8/HszA7qz/aM10zG4aHuPiODFsqgSSLmC6lk2rO74HpNV4wU0yrWfqnXEY/BPXi7lufzdmESSRTgX9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360719; c=relaxed/simple;
	bh=IGK5cZ15OTCw/sUY5VzPU37ZVXtygKB/ZLWNj8VVq5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G+Wrqo2Tj8dd/LeTzAuizlOBGG16EyG5zvhLm1nOCFI32XF+z2t4E6/fq7IbiYftphh/37BAa3jRtHfZLT5wPHdoHH/RhptxajBJi+3eFNySYE6D/TbYjIRRRrOoLhgejTvw1d/hxwaFlPLHpzCgnUu4K17MfjolQbbrpqpvKLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QaviekyS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9y42dO69; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwrCoCuS5rY3NDG+j3W1+xM6HrWl1ksEU1r/wsP+5cg=;
	b=QaviekySgRU3yygKmHZy6xCNXbmKAmTWWuBqMD+aksL5ntVpUqzBnUMO0nzuGDoRZ5cLlU
	I026nVIrI7Mr8hIC0S3OY160FXoknvxaK4nTnOH7DC3WUe7lSvRnNgyiet59tfDRBvfyT1
	dJtPmi7MpyM7Qq2UCz1jlb43NCrj5hkyZ1P3Nax1rQgce3ppUJCJGjE5YsXcGo/sTstN7A
	5ca6zpyqHu6IJbRcBx9MGQjacVvDJUWeVrDlAEi/9RG0N41KOg23+F5XLg0OTozZYlXfTk
	BvuxR6zLoLdpP68ZYnpwn6Vpp6gingPdIOVb8dwwi2VFxtoGT1+xMwK/bQ5ung==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwrCoCuS5rY3NDG+j3W1+xM6HrWl1ksEU1r/wsP+5cg=;
	b=9y42dO69yFOPufrVl8YIULcyUbNlAfanFOapEKqFfw3P5WTyEtbstAo8AqF0wgSSG1FDrg
	tTmt2jh+BJSquSAQ==
To: linux-kernel@vger.kernel.org
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
Subject: [PATCH v3 05/24] irqchip/gic-v3-its: Provide MSI parent infrastructure
Date: Fri, 14 Jun 2024 12:23:44 +0200
Message-Id: <20240614102403.13610-6-shivamurthy.shastri@linutronix.de>
In-Reply-To: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

To support per device MSI domains the ITS must provide MSI parent domain
functionality.

Provide the basic skeleton for this:

   - msi_parent_ops
   - child domain init callback
   - the MSI parent flag set in irqdomain::flags

This does not make ITS a functional parent domain as there is no bit set in
the bus_select_mask yet, but it provides the base to implement PCI and
platform MSI support gradually on top.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
v3: enabled MSI_FLAG_PCI_MSI_MASK_PARENT in msi_parent_ops::supported_flags
---
 drivers/irqchip/Kconfig                     |  1 +
 drivers/irqchip/Makefile                    |  2 +-
 drivers/irqchip/irq-gic-common.h            |  3 ++
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 31 +++++++++++++++++++++
 drivers/irqchip/irq-gic-v3-its.c            |  5 ++++
 5 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 drivers/irqchip/irq-gic-v3-its-msi-parent.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 2bf8d940504c..b51863fa9b38 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -41,6 +41,7 @@ config ARM_GIC_V3
 config ARM_GIC_V3_ITS
 	bool
 	select GENERIC_MSI_IRQ
+	select IRQ_MSI_LIB
 	default ARM_GIC_V3
 
 config ARM_GIC_V3_ITS_PCI
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 72c7f6289411..6e4f7715206d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -32,7 +32,7 @@ obj-$(CONFIG_ARCH_REALVIEW)		+= irq-gic-realview.o
 obj-$(CONFIG_IRQ_MSI_LIB)		+= irq-msi-lib.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
-obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o
+obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o irq-gic-v3-its-msi-parent.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_PCI)	+= irq-gic-v3-its-pci-msi.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index f407cce9ecaa..eb4a220dd6ad 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -8,6 +8,7 @@
 
 #include <linux/of.h>
 #include <linux/irqdomain.h>
+#include <linux/msi.h>
 #include <linux/irqchip/arm-gic-common.h>
 
 struct gic_quirk {
@@ -29,6 +30,8 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data);
 
+extern const struct msi_parent_ops gic_v3_its_msi_parent_ops;
+
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING    (1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED     (1 << 1)
 #define RDIST_FLAGS_FORCE_NON_SHAREABLE        (1 << 2)
diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
new file mode 100644
index 000000000000..cdc0844229b5
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#include "irq-gic-common.h"
+#include "irq-msi-lib.h"
+
+#define ITS_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define ITS_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				 MSI_FLAG_PCI_MSIX      |	\
+				 MSI_FLAG_MULTI_PCI_MSI |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	return true;
+}
+
+const struct msi_parent_ops gic_v3_its_msi_parent_ops = {
+	.supported_flags	= ITS_MSI_FLAGS_SUPPORTED,
+	.required_flags		= ITS_MSI_FLAGS_REQUIRED,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.prefix			= "ITS-",
+	.init_dev_msi_info	= its_init_dev_msi_info,
+};
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3c755d5dad6e..d770d6aedb29 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -38,6 +38,7 @@
 #include <asm/exception.h>
 
 #include "irq-gic-common.h"
+#include "irq-msi-lib.h"
 
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
@@ -3688,6 +3689,7 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops its_domain_ops = {
+	.select			= msi_lib_irq_domain_select,
 	.alloc			= its_irq_domain_alloc,
 	.free			= its_irq_domain_free,
 	.activate		= its_irq_domain_activate,
@@ -4993,6 +4995,9 @@ static int its_init_domain(struct its_node *its)
 
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
 
+	inner_domain->msi_parent_ops = &gic_v3_its_msi_parent_ops;
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+
 	return 0;
 }
 
-- 
2.34.1


