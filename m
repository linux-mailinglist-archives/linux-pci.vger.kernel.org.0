Return-Path: <linux-pci+bounces-30734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BF2AE9B9C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93B8C7B949C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031D325B680;
	Thu, 26 Jun 2025 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDsVvSZl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB63225B678;
	Thu, 26 Jun 2025 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933724; cv=none; b=dD2d5UeylG3AhKn2rsyHslGRNHWhpX/yrPUK5QYz+WAEw77GqA+YWWU6l90p8XotwUgseU+dkRjeDE7j9Q8DpBbPbkfbSj4Czp71c1qw5J6SJO/CoMcq3VSdzcD/gxQjKms38SzFj3Ie4zaGoub7M1/vbfcNojisTS8aYp4sRWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933724; c=relaxed/simple;
	bh=pWG1G2mBTD+N9l/FGUOM8XrO+5AgWTZQPiXtRYYjjvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mdbt4XsRRfgjd2Q7DAsjpq4/wOQ12SKcFJOx4VY4j1c3ZDEiTn+PEJCT4IQDISPUAFuN278Mzsn3gk7EtQCjYvUUfYkiOhBoj0l2qIW+M5b3jM7zKDKTWL3u8sk2xYTL/J2a6P8bCUgqnFgXROF91ewKmTM7JfPhewqptAUr9k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDsVvSZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78F8C4CEEE;
	Thu, 26 Jun 2025 10:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933724;
	bh=pWG1G2mBTD+N9l/FGUOM8XrO+5AgWTZQPiXtRYYjjvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YDsVvSZlgg78GVAhC+REHedyDVzMQly+m4N3CooaOplbs6stvLgG6bpThma18YmqU
	 9xLZscLQ3Aa4K0r9BEexCgX6HtRofXGULKwiPyV4QAiUMj5CL/lZL361N5oDo+Jg9r
	 ZXyJXWlS78Z1OUVC7A2ad/dIDQ0hfrtBPTL7tHKog5R2NX71XuXW0kpZ0+xAs5zHXJ
	 oZzDVcyc81nprI6rR6wDncWy4usiE4vAYib6nDKcyOkx9B1Xycy/YRVO22tXKe/SMT
	 QUkzrvBtHdLlJqfCCytQKhpYBsINnpvxiEY6OJle8gReI6l54JvkYlgqmI+wPdpemx
	 PPY73CSPa+zDA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 26 Jun 2025 12:26:17 +0200
Subject: [PATCH v6 26/31] irqchip/gic-v3: Rename GICv3 ITS MSI parent
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-gicv5-host-v6-26-48e046af4642@kernel.org>
References: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
In-Reply-To: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Sascha Bischoff <sascha.bischoff@arm.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Timothy Hayes <timothy.hayes@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15-dev-6f78e

The GICv5 ITS will reuse some GICv3 ITS MSI parent functions therefore
it makes sense to keep the code functionality in a compilation unit
shared by the two drivers.

Rename the GICv3 ITS MSI parent file and update the related
Kconfig/Makefile entries to pave the way for code sharing.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Kconfig                                       |  4 ++++
 drivers/irqchip/Makefile                                      |  3 ++-
 drivers/irqchip/irq-gic-common.h                              |  2 --
 .../{irq-gic-v3-its-msi-parent.c => irq-gic-its-msi-parent.c} |  2 +-
 drivers/irqchip/irq-gic-its-msi-parent.h                      | 11 +++++++++++
 drivers/irqchip/irq-gic-v3-its.c                              |  1 +
 6 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 3e4fb08b7a4d..f9eae1a645c9 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -41,10 +41,14 @@ config ARM_GIC_V3
 	select HAVE_ARM_SMCCC_DISCOVERY
 	select IRQ_MSI_IOMMU
 
+config ARM_GIC_ITS_PARENT
+	bool
+
 config ARM_GIC_V3_ITS
 	bool
 	select GENERIC_MSI_IRQ
 	select IRQ_MSI_LIB
+	select ARM_GIC_ITS_PARENT
 	default ARM_GIC_V3
 	select IRQ_MSI_IOMMU
 
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 7a0e6cee09e1..3ce6ea9a371b 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -33,7 +33,8 @@ obj-$(CONFIG_ARCH_REALVIEW)		+= irq-gic-realview.o
 obj-$(CONFIG_IRQ_MSI_LIB)		+= irq-msi-lib.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
-obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v4.o irq-gic-v3-its-msi-parent.o
+obj-$(CONFIG_ARM_GIC_ITS_PARENT)	+= irq-gic-its-msi-parent.o
+obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v4.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
 obj-$(CONFIG_ARM_GIC_V5)		+= irq-gic-v5.o irq-gic-v5-irs.o
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 020ecdf16901..710cab61d919 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -29,8 +29,6 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data);
 
-extern const struct msi_parent_ops gic_v3_its_msi_parent_ops;
-
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING    (1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED     (1 << 1)
 #define RDIST_FLAGS_FORCE_NON_SHAREABLE        (1 << 2)
diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
similarity index 99%
rename from drivers/irqchip/irq-gic-v3-its-msi-parent.c
rename to drivers/irqchip/irq-gic-its-msi-parent.c
index a5e110ffdd88..8beecfed2b84 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -7,7 +7,7 @@
 #include <linux/acpi_iort.h>
 #include <linux/pci.h>
 
-#include "irq-gic-common.h"
+#include "irq-gic-its-msi-parent.h"
 #include <linux/irqchip/irq-msi-lib.h>
 
 #define ITS_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
diff --git a/drivers/irqchip/irq-gic-its-msi-parent.h b/drivers/irqchip/irq-gic-its-msi-parent.h
new file mode 100644
index 000000000000..75e223e673ce
--- /dev/null
+++ b/drivers/irqchip/irq-gic-its-msi-parent.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 ARM Limited, All Rights Reserved.
+ */
+
+#ifndef _IRQ_GIC_ITS_MSI_PARENT_H
+#define _IRQ_GIC_ITS_MSI_PARENT_H
+
+extern const struct msi_parent_ops gic_v3_its_msi_parent_ops;
+
+#endif /* _IRQ_GIC_ITS_MSI_PARENT_H */
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d54fa0638dc4..467cb78435a9 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -41,6 +41,7 @@
 #include <asm/exception.h>
 
 #include "irq-gic-common.h"
+#include "irq-gic-its-msi-parent.h"
 #include <linux/irqchip/irq-msi-lib.h>
 
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)

-- 
2.48.0


