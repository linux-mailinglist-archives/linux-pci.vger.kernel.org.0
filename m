Return-Path: <linux-pci+bounces-10968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB15C93F826
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 16:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09AFFB23C5E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 14:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3331192B6B;
	Mon, 29 Jul 2024 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Tik8Gk5T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF03183094
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263068; cv=none; b=W4pIT0K/Qk4+Tmj4lefChWZXZ+EsN5yS4GOof5/ehxGaR7jq+HSXGpMi95RMSYSadaeJf1WrGf/PL0PBFR42CqRKvNr/dKa/b9DqCe3k9GYNi2eWfO0sGXkLCqUGzI7gdXFT9ANPSVZeNZIhr2cPmWtCKqA/8SAjhjHt74wC93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263068; c=relaxed/simple;
	bh=+UbqGuHJb3QdYvkfHtcWyGnRGIWHv4ptKTm8t7QdFQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwUBQH2ICWRxxmVQzuPo/FZJ/pyqDdx9cTl+hoGFvSMPMi5ZcKw7iUhWoqySANFzQn47tXZvAS6QMn9nNxvju39DChhmpouVAIaNIQtKlk8eOTXrq88qDfZfgZ5rrEeXY9SQg+mh3Gzb19UG014yzi8nrH83jWwE8nIVjOpXZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Tik8Gk5T; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc491f9b55so22361365ad.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 07:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722263065; x=1722867865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtHN5RSatiirKkuRPrN7Xezrvz6FAse7wNTwc5cY9vQ=;
        b=Tik8Gk5Tp4XjyCilNJmfwAkvPInVAWJnaW182dqrPSOA0Pp1CPw6Plr9ss6JDoRXDT
         9pgFLqM3e3NhNksPQM+V+HEc4f2JMU40XcCSennk99JNb6cbRBFtQdVvjKF0455u/oMC
         zWbr1SP/k8mFVbpL4Y/vPj5qw74YRic3LGq46NHL57OuK/pFcZw6zg+GmFOWZlwfuEuy
         +PQX4qXu5kBl0npaa0qf4eBoVxyIkoxAUDsZn+UN9M+N09/uqyrcXaMwFJ9f1yyF3Kdp
         a4mp7m9NizuFHhMdmkGPq22NUzTZhJFW/RY2xhIbZ1zcNegFprhFDvHMoS8a2f1R0h4U
         JzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263065; x=1722867865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtHN5RSatiirKkuRPrN7Xezrvz6FAse7wNTwc5cY9vQ=;
        b=EY1REk8p0rFvDhCsWZ6271gF2nvLe0NgfICu7tX18NTV+TfE7VuzdF/naH++5tf8iZ
         ywccuW3hPFAeN3LT9ALTzLX8+3Rmlvfy46E8kiV1grFtUPniqg6AmJs3ekJ98BbOUNQ1
         jmbWU76g2ev73wv/CUjF0mogt3229kI60puY0X3Wqia8JHlX7xQ2hmm67EFABeWBUQ9B
         /4ttL4vDJ9IKudXxrnBcFldvg6NsTm985adDgtVu6FJUodhRO1uypT5lTZBfZgEsMwhH
         fwG/sdF267N3VBkix6uKuLW2ao0uFSFNlKAm1mjWKY1H+4iW9bbWv9Mb0FVboh/ZUeJ7
         IdmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSZwtkzQ4vr3MoLXH+/b7LFzSQmWMTV+7g8eMry6WvlaR6dwNWjx4/RA21QixPpq8JwzxLjl+i3UqaMl8oVRw65pwFbcnISv2W
X-Gm-Message-State: AOJu0YyhjVzHhy36u05bY3dS/op4MLVP5g9TANGRtA8CN6VTd/+y+9dL
	X4TiUiFVleHC5z+YDk/SgH0GKFJpUL2TJZoQGOCnsnbxQTATJsEWO3qeMNYjq+I=
X-Google-Smtp-Source: AGHT+IFQUf/+EhYfgsVrzK2L/oleohsnmuLKT1iKr9sPO9lBK/mJauG7ujc+tgm88sfndaMqzPY+Eg==
X-Received: by 2002:a17:902:eccf:b0:1fb:34ef:4467 with SMTP id d9443c01a7336-1ff048e2267mr57478325ad.43.1722263065556;
        Mon, 29 Jul 2024 07:24:25 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:24:25 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v7 16/17] irqchip/riscv-aplic: Add ACPI support
Date: Mon, 29 Jul 2024 19:52:38 +0530
Message-ID: <20240729142241.733357-17-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729142241.733357-1-sunilvl@ventanamicro.com>
References: <20240729142241.733357-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ACPI support in APLIC drivers. Use the mapping created early during
boot to get the details about the APLIC.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-aplic-direct.c | 22 +++++---
 drivers/irqchip/irq-riscv-aplic-main.c   | 69 ++++++++++++++++--------
 drivers/irqchip/irq-riscv-aplic-main.h   |  1 +
 drivers/irqchip/irq-riscv-aplic-msi.c    |  9 +++-
 4 files changed, 69 insertions(+), 32 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index 4a3ffe856d6c..34540a0ca4da 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2022 Ventana Micro Systems Inc.
  */
 
+#include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/cpu.h>
@@ -189,17 +190,22 @@ static int aplic_direct_starting_cpu(unsigned int cpu)
 }
 
 static int aplic_direct_parse_parent_hwirq(struct device *dev, u32 index,
-					   u32 *parent_hwirq, unsigned long *parent_hartid)
+					   u32 *parent_hwirq, unsigned long *parent_hartid,
+					   struct aplic_priv *priv)
 {
 	struct of_phandle_args parent;
+	unsigned long hartid;
 	int rc;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(dev->fwnode))
-		return -EINVAL;
+	if (!is_of_node(dev->fwnode)) {
+		hartid = acpi_get_ext_intc_parent_hartid(priv->id, index);
+		if (hartid == INVALID_HARTID)
+			return -ENODEV;
+
+		*parent_hartid = hartid;
+		*parent_hwirq = RV_IRQ_EXT;
+		return 0;
+	}
 
 	rc = of_irq_parse_one(to_of_node(dev->fwnode), index, &parent);
 	if (rc)
@@ -237,7 +243,7 @@ int aplic_direct_setup(struct device *dev, void __iomem *regs)
 	/* Setup per-CPU IDC and target CPU mask */
 	current_cpu = get_cpu();
 	for (i = 0; i < priv->nr_idcs; i++) {
-		rc = aplic_direct_parse_parent_hwirq(dev, i, &hwirq, &hartid);
+		rc = aplic_direct_parse_parent_hwirq(dev, i, &hwirq, &hartid, priv);
 		if (rc) {
 			dev_warn(dev, "parent irq for IDC%d not found\n", i);
 			continue;
diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index 28dd175b5764..8357c5f9921a 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -4,8 +4,10 @@
  * Copyright (C) 2022 Ventana Micro Systems Inc.
  */
 
+#include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/irqchip/riscv-aplic.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -125,39 +127,50 @@ static void aplic_init_hw_irqs(struct aplic_priv *priv)
 	writel(0, priv->regs + APLIC_DOMAINCFG);
 }
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id aplic_acpi_match[] = {
+	{ "RSCV0002", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, aplic_acpi_match);
+
+#endif
+
 int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iomem *regs)
 {
 	struct device_node *np = to_of_node(dev->fwnode);
 	struct of_phandle_args parent;
 	int rc;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!np)
-		return -EINVAL;
-
 	/* Save device pointer and register base */
 	priv->dev = dev;
 	priv->regs = regs;
 
-	/* Find out number of interrupt sources */
-	rc = of_property_read_u32(np, "riscv,num-sources", &priv->nr_irqs);
-	if (rc) {
-		dev_err(dev, "failed to get number of interrupt sources\n");
-		return rc;
-	}
+	if (np) {
+		/* Find out number of interrupt sources */
+		rc = of_property_read_u32(np, "riscv,num-sources", &priv->nr_irqs);
+		if (rc) {
+			dev_err(dev, "failed to get number of interrupt sources\n");
+			return rc;
+		}
 
-	/*
-	 * Find out number of IDCs based on parent interrupts
-	 *
-	 * If "msi-parent" property is present then we ignore the
-	 * APLIC IDCs which forces the APLIC driver to use MSI mode.
-	 */
-	if (!of_property_present(np, "msi-parent")) {
-		while (!of_irq_parse_one(np, priv->nr_idcs, &parent))
-			priv->nr_idcs++;
+		/*
+		 * Find out number of IDCs based on parent interrupts
+		 *
+		 * If "msi-parent" property is present then we ignore the
+		 * APLIC IDCs which forces the APLIC driver to use MSI mode.
+		 */
+		if (!of_property_present(np, "msi-parent")) {
+			while (!of_irq_parse_one(np, priv->nr_idcs, &parent))
+				priv->nr_idcs++;
+		}
+	} else {
+		rc = riscv_acpi_get_gsi_info(dev->fwnode, &priv->gsi_base, &priv->id,
+					     &priv->nr_irqs, &priv->nr_idcs);
+		if (rc) {
+			dev_err(dev, "failed to find GSI mapping\n");
+			return rc;
+		}
 	}
 
 	/* Setup initial state APLIC interrupts */
@@ -184,7 +197,11 @@ static int aplic_probe(struct platform_device *pdev)
 	 * If msi-parent property is present then setup APLIC MSI
 	 * mode otherwise setup APLIC direct mode.
 	 */
-	msi_mode = of_property_present(to_of_node(dev->fwnode), "msi-parent");
+	if (is_of_node(dev->fwnode))
+		msi_mode = of_property_present(to_of_node(dev->fwnode), "msi-parent");
+	else
+		msi_mode = imsic_acpi_get_fwnode(NULL) ? 1 : 0;
+
 	if (msi_mode)
 		rc = aplic_msi_setup(dev, regs);
 	else
@@ -192,6 +209,11 @@ static int aplic_probe(struct platform_device *pdev)
 	if (rc)
 		dev_err(dev, "failed to setup APLIC in %s mode\n", msi_mode ? "MSI" : "direct");
 
+#ifdef CONFIG_ACPI
+	if (!acpi_disabled)
+		acpi_dev_clear_dependencies(ACPI_COMPANION(dev));
+#endif
+
 	return rc;
 }
 
@@ -204,6 +226,7 @@ static struct platform_driver aplic_driver = {
 	.driver = {
 		.name		= "riscv-aplic",
 		.of_match_table	= aplic_match,
+		.acpi_match_table = ACPI_PTR(aplic_acpi_match),
 	},
 	.probe = aplic_probe,
 };
diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/irq-riscv-aplic-main.h
index 4393927d8c80..9fbf45c7b4f7 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.h
+++ b/drivers/irqchip/irq-riscv-aplic-main.h
@@ -28,6 +28,7 @@ struct aplic_priv {
 	u32			gsi_base;
 	u32			nr_irqs;
 	u32			nr_idcs;
+	u32			id;
 	void __iomem		*regs;
 	struct aplic_msicfg	msicfg;
 };
diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index 028444af48bd..f5020241e0ed 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -157,6 +157,7 @@ static const struct msi_domain_template aplic_msi_template = {
 int aplic_msi_setup(struct device *dev, void __iomem *regs)
 {
 	const struct imsic_global_config *imsic_global;
+	struct irq_domain *msi_domain;
 	struct aplic_priv *priv;
 	struct aplic_msicfg *mc;
 	phys_addr_t pa;
@@ -239,8 +240,14 @@ int aplic_msi_setup(struct device *dev, void __iomem *regs)
 		 * IMSIC and the IMSIC MSI domains are created later through
 		 * the platform driver probing so we set it explicitly here.
 		 */
-		if (is_of_node(dev->fwnode))
+		if (is_of_node(dev->fwnode)) {
 			of_msi_configure(dev, to_of_node(dev->fwnode));
+		} else {
+			msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
+							      DOMAIN_BUS_PLATFORM_MSI);
+			if (msi_domain)
+				dev_set_msi_domain(dev, msi_domain);
+		}
 	}
 
 	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, &aplic_msi_template,
-- 
2.43.0


