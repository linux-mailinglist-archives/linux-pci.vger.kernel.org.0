Return-Path: <linux-pci+bounces-27655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9935BAB5B36
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 19:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71D73AD7EC
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 17:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1C72BEC26;
	Tue, 13 May 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ql/wY9r/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4AA2BE7C5;
	Tue, 13 May 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157310; cv=none; b=OGCuGL0u0O4xyQxpZobf5dIrvcU8aAaEy0pj+FcDJRvsj3MkJLb590UEVyzZjJx0cj0V09jjPDVm+O+6wCLQMK0cj6Bko0D9EHjUaZ049p6YxJ3cxpAV7pu4ptm7wB5v1CVnXjzcIrHJNRoNVo4r/ok5KZzKPxj7N0m8gqWlTRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157310; c=relaxed/simple;
	bh=1rkj+y1q1p0hGIIM2flqfhEStwJJYCpE+rTvcEhYKkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NbHIV4VczztZUKtxmmWqnqu1kFwOzyY5r81m1PyhzryRzbDsGX0vaaK948cvCYNzp8Ejru6w1B5wEy5g6u+o2EJlR7UkiFQV6IanLL96/v/qiHpdNAPdcm5VqPpzebKKeXtZwFirhaI97Om7WU/nS92XfF6z3WBzHm9Yi1B0uCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ql/wY9r/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C93C4CEEF;
	Tue, 13 May 2025 17:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747157310;
	bh=1rkj+y1q1p0hGIIM2flqfhEStwJJYCpE+rTvcEhYKkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ql/wY9r/tVu6+JSfqR/UAO3OpVkZ5lrATJBcMgQuUEGPnNnzzUjHbjk5tVuHW0x5f
	 dWTR/MeBVGJ1TDQQW2CwByd4rPGKCXStyZ81vK5wlb7O1Jr6L4XAUODhWlwI6GhQhd
	 UvZHGu/xnYWBsKTV3va1/6aVAZ101aE0ZCS/zg3qXajIubBfsmSVIyB7zmFyPDS1j3
	 kJYtzMmvsyx2WnSEBWEAsaGzlBq58/66I0YAdeL6OB4ceJdTwFHr3ePdQOzStuqMgG
	 A0JgLJ7bHYoKPUTSLKNtqJNPFwkPJCn3OobFEwsRPoSY2RphocXgVd1H+HBrEnXl84
	 qpZefku+qKP2g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uEtQa-00EbRz-2X;
	Tue, 13 May 2025 18:28:28 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toan Le <toan@os.amperecomputing.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 1/9] irqchip: Make irq-msi-lib.h globally available
Date: Tue, 13 May 2025 18:28:11 +0100
Message-Id: <20250513172819.2216709-2-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250513172819.2216709-1-maz@kernel.org>
References: <20250513172819.2216709-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, tglx@linutronix.de, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com, toan@os.amperecomputing.com, alyssa@rosenzweig.io, thierry.reding@gmail.com, jonathanh@nvidia.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Move irq-msi-lib.h into include/linux/irqchip, making it available
to compilation units outside of drivers/irqchip.

This requires some churn in drivers to fetch it from the new location,
generated using this script:

	git grep -l -w \"irq-msi-lib.h\" | \
	xargs sed -i -e 's:"irq-msi-lib.h":\<linux/irqchip/irq-msi-lib.h\>:'

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-bcm2712-mip.c                | 2 +-
 drivers/irqchip/irq-gic-v2m.c                    | 2 +-
 drivers/irqchip/irq-gic-v3-its-msi-parent.c      | 2 +-
 drivers/irqchip/irq-gic-v3-its.c                 | 2 +-
 drivers/irqchip/irq-gic-v3-mbi.c                 | 2 +-
 drivers/irqchip/irq-imx-mu-msi.c                 | 2 +-
 drivers/irqchip/irq-loongarch-avec.c             | 2 +-
 drivers/irqchip/irq-loongson-pch-msi.c           | 2 +-
 drivers/irqchip/irq-msi-lib.c                    | 2 +-
 drivers/irqchip/irq-mvebu-gicp.c                 | 2 +-
 drivers/irqchip/irq-mvebu-icu.c                  | 2 +-
 drivers/irqchip/irq-mvebu-odmi.c                 | 2 +-
 drivers/irqchip/irq-mvebu-sei.c                  | 2 +-
 drivers/irqchip/irq-riscv-imsic-platform.c       | 2 +-
 drivers/irqchip/irq-sg2042-msi.c                 | 2 +-
 {drivers => include/linux}/irqchip/irq-msi-lib.h | 6 +++---
 16 files changed, 18 insertions(+), 18 deletions(-)
 rename {drivers => include/linux}/irqchip/irq-msi-lib.h (84%)

diff --git a/drivers/irqchip/irq-bcm2712-mip.c b/drivers/irqchip/irq-bcm2712-mip.c
index 49a19db2d1e1b..f04a42b16cca0 100644
--- a/drivers/irqchip/irq-bcm2712-mip.c
+++ b/drivers/irqchip/irq-bcm2712-mip.c
@@ -11,7 +11,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 #define MIP_INT_RAISE		0x00
 #define MIP_INT_CLEAR		0x10
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index c698948618666..62676994d0695 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -26,7 +26,7 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/irqchip/arm-gic-common.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 /*
 * MSI_TYPER:
diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index 68f9ba4085ce5..51cc961bc3181 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -8,7 +8,7 @@
 #include <linux/pci.h>
 
 #include "irq-gic-common.h"
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 #define ITS_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
 				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fd6e7c170d37e..9e6380f597488 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -41,7 +41,7 @@
 #include <asm/exception.h>
 
 #include "irq-gic-common.h"
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index 34e9ca77a8c36..e562b57923229 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -18,7 +18,7 @@
 
 #include <linux/irqchip/arm-gic-v3.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 struct mbi_range {
 	u32			spi_start;
diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
index 69aacdfc8bef0..137da1927d144 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -24,7 +24,7 @@
 #include <linux/pm_domain.h>
 #include <linux/spinlock.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 #define IMX_MU_CHANS            4
 
diff --git a/drivers/irqchip/irq-loongarch-avec.c b/drivers/irqchip/irq-loongarch-avec.c
index 80e55955a29fa..bf52dc8345f5f 100644
--- a/drivers/irqchip/irq-loongarch-avec.c
+++ b/drivers/irqchip/irq-loongarch-avec.c
@@ -18,7 +18,7 @@
 #include <asm/loongarch.h>
 #include <asm/setup.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 #include "irq-loongson.h"
 
 #define VECTORS_PER_REG		64
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 9c62108b3ad58..fb690c7cbcaa6 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -15,7 +15,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 #include "irq-loongson.h"
 
 static int nr_pics;
diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 51464c6257f37..2a61c06c4da07 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -4,7 +4,7 @@
 
 #include <linux/export.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 /**
  * msi_lib_init_dev_msi_info - Domain info setup for MSI domains
diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index d67f93f6d7505..0b2a857b49018 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -17,7 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 4eebed39880a5..db5dbc6e88b05 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -20,7 +20,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 #include <dt-bindings/interrupt-controller/mvebu-icu.h>
 
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index 28f7e81df94f0..306a7754e44f8 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -18,7 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/slab.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index ebd4a9014e8da..a962ef4977169 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -14,7 +14,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 /* Cause register */
 #define GICP_SECR(idx)		(0x0  + ((idx) * 0x4))
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index b8ae67c25b37a..1b9fbfce95816 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -20,7 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/smp.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 #include "irq-riscv-imsic-state.h"
 
 static bool imsic_cpu_page_phys(unsigned int cpu, unsigned int guest_index,
diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index ee682e87eb8be..d641f3a5eee9e 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -17,7 +17,7 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 #define SG2042_MAX_MSI_VECTOR	32
 
diff --git a/drivers/irqchip/irq-msi-lib.h b/include/linux/irqchip/irq-msi-lib.h
similarity index 84%
rename from drivers/irqchip/irq-msi-lib.h
rename to include/linux/irqchip/irq-msi-lib.h
index 681ceabb7bc74..dd8d1d1385449 100644
--- a/drivers/irqchip/irq-msi-lib.h
+++ b/include/linux/irqchip/irq-msi-lib.h
@@ -2,8 +2,8 @@
 // Copyright (C) 2022 Linutronix GmbH
 // Copyright (C) 2022 Intel
 
-#ifndef _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H
-#define _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H
+#ifndef _IRQCHIP_IRQ_MSI_LIB_H
+#define _IRQCHIP_IRQ_MSI_LIB_H
 
 #include <linux/bits.h>
 #include <linux/irqdomain.h>
@@ -24,4 +24,4 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 			       struct irq_domain *real_parent,
 			       struct msi_domain_info *info);
 
-#endif /* _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H */
+#endif /* _IRQCHIP_IRQ_MSI_LIB_H */
-- 
2.39.2


