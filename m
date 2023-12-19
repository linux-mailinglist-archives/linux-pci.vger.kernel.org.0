Return-Path: <linux-pci+bounces-1184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA076818EAA
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 18:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813BF2851CC
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152783D0C4;
	Tue, 19 Dec 2023 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="D/sP50/o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5014B3FB33
	for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3c93fadc4so14379365ad.3
        for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 09:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703008002; x=1703612802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZH2VVLJxNHvriakOOoWr5FlZ4jVyb+u72AVTrlwbgg=;
        b=D/sP50/osE/XVQ5JJt63JoC5BH/nxC1BnGu5xk8ZNOPvKhDqYYiwVl+nWraaHMB9LH
         dOIGyANx/jcxYPodABNGNgy3riAbaPDryhVl7y2bxMZOBXd38IF09Yi3WSP263fOC11k
         uPt3CCTaZ3BwoCZ2wVZvBgo8+cN2R6J1VdH9gOmLYUDjER69a7zVPqpF1tBYCsn8ffKe
         VKGY7WjdXDgvV85metBMhXKv4J2NT7vKzaVsYmqg7O3tGqdE/kvzT+DCivMsr9lhYblC
         BypFB2Ta3X+Bn5n7e35kukhNGOZAGSnD8sKHzVBYtmBX5UBtb3bVgQ7XqUa0OvV9P2wG
         Pmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703008002; x=1703612802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZH2VVLJxNHvriakOOoWr5FlZ4jVyb+u72AVTrlwbgg=;
        b=MgVMqBTG+PAIjnBc70YMeij4NoVRt11aKMWq4exkb2D5Pi6MSxf3chwy3Bn9vg3FyD
         is6B89oR4gGYz13ghs7Rj8u8hVLTDlCpVwEBeUqXIgUeahgq/YpyBnG10cq+0RfyrTXe
         YSDf/6H9Bm0GPl6Ihv/3uaJcXrC/KYc4U3LG2o1k4+b7LyN+vL5rYe+m9teIzNuFHIaz
         0QCU2AUwdBLYoYQhSh54bDnaa5sRywM4IzeJu2p2l6BAYJG8UAV+uouJQVvXKnIFfAp8
         4e9bjyuhrmmTU5XyKxSiGEOxsU+GKUt/W+shjhEDWi0Bx/Yghs1YD7bd+RDgWZ2Fccpk
         V/9A==
X-Gm-Message-State: AOJu0Yw6YCoZ3iTXs1fMUwap/4s/G2TnBW3VzCb0Oo8eKFylNfTuYuTT
	csnWZPYaHRl9ap7i7DJ4YUIQ4w==
X-Google-Smtp-Source: AGHT+IE6uf+usXMxRKVOaon8WyaEOOvOylj5AlLYp7ZK7Lf0piVNkksf6YQ/7YkGTuiL7VIoKgEHhA==
X-Received: by 2002:a17:903:11cd:b0:1d3:2e0e:c889 with SMTP id q13-20020a17090311cd00b001d32e0ec889mr8798850plh.62.1703008002608;
        Tue, 19 Dec 2023 09:46:42 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:46:42 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v3 12/17] irqchip: irq-sifive-plic: Add ACPI support
Date: Tue, 19 Dec 2023 23:15:21 +0530
Message-Id: <20231219174526.2235150-13-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ACPI support in PLIC driver. In ACPI, IO devices use Global System
Interrupts (GSI) which is a flat space split across multiple PLICs.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 arch/riscv/include/asm/irq.h      |  6 +++
 drivers/irqchip/irq-sifive-plic.c | 76 +++++++++++++++++++++++--------
 2 files changed, 64 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index df59192a157d..7b14f3ebe242 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -28,6 +28,12 @@ struct fwnode_handle *aplic_get_gsi_domain_id(u32 gsi);
 static inline struct fwnode_handle *aplic_get_gsi_domain_id(u32 gsi) { return NULL; }
 #endif
 
+#ifdef CONFIG_SIFIVE_PLIC
+struct fwnode_handle *plic_get_gsi_domain_id(u32 gsi);
+#else
+static inline struct fwnode_handle *plic_get_gsi_domain_id(u32 gsi) { return NULL; }
+#endif
+
 int __init acpi_get_intc_index_hartid(u32 index, unsigned long *hartid);
 int acpi_get_ext_intc_parent_hartid(u8 id, u32 idx, unsigned long *hartid);
 void acpi_get_plic_nr_contexts(u8 id, int *nr_contexts);
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index c8f8a8cdcce1..d4c355ffa628 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 SiFive
  * Copyright (C) 2018 Christoph Hellwig
  */
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -70,6 +71,8 @@ struct plic_priv {
 	unsigned long plic_quirks;
 	unsigned int nr_irqs;
 	unsigned long *prio_save;
+	u32 gsi_base;
+	int id;
 };
 
 struct plic_handler {
@@ -316,6 +319,10 @@ static int plic_irq_domain_translate(struct irq_domain *d,
 {
 	struct plic_priv *priv = d->host_data;
 
+	/* For DT, gsi_base is always zero. */
+	if (fwspec->param[0] >= priv->gsi_base)
+		fwspec->param[0] = fwspec->param[0] - priv->gsi_base;
+
 	if (test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
 		return irq_domain_translate_twocell(d, fwspec, hwirq, type);
 
@@ -417,17 +424,31 @@ static const struct of_device_id plic_match[] = {
 };
 
 static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
-					   u32 *nr_irqs, u32 *nr_contexts)
+					   u32 *nr_irqs, u32 *nr_contexts,
+					   u32 *gsi_base, u32 *id)
 {
 	struct device *dev = &pdev->dev;
+	struct acpi_madt_plic *plic;
 	int rc;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(dev->fwnode))
-		return -EINVAL;
+	if (!is_of_node(dev->fwnode)) {
+		plic = *(struct acpi_madt_plic **)dev_get_platdata(dev);
+		if (!plic) {
+			dev_err(dev, "PLIC platform data is NULL!\n");
+			return -EINVAL;
+		}
+
+		*nr_irqs = plic->num_irqs;
+		acpi_get_plic_nr_contexts(plic->id, nr_contexts);
+		if (WARN_ON(!*nr_contexts)) {
+			dev_err(dev, "no PLIC context available\n");
+			return -EINVAL;
+		}
+
+		*gsi_base = plic->gsi_base;
+		*id = plic->id;
+		return 0;
+	}
 
 	rc = of_property_read_u32(to_of_node(dev->fwnode),
 				  "riscv,ndev", nr_irqs);
@@ -442,23 +463,28 @@ static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	*gsi_base = 0;
+	*id = 0;
+
 	return 0;
 }
 
 static int plic_parse_context_parent_hwirq(struct platform_device *pdev,
-					   u32 context, u32 *parent_hwirq,
+					   u32 context, u32 id, u32 *parent_hwirq,
 					   unsigned long *parent_hartid)
 {
 	struct device *dev = &pdev->dev;
 	struct of_phandle_args parent;
 	int rc;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(dev->fwnode))
-		return -EINVAL;
+	if (!is_of_node(dev->fwnode)) {
+		rc = acpi_get_ext_intc_parent_hartid(id, context, parent_hartid);
+		if (rc)
+			return rc;
+
+		*parent_hwirq = RV_IRQ_EXT;
+		return 0;
+	}
 
 	rc = of_irq_parse_one(to_of_node(dev->fwnode), context, &parent);
 	if (rc)
@@ -483,7 +509,9 @@ static int plic_probe(struct platform_device *pdev)
 	struct plic_priv *priv;
 	irq_hw_number_t hwirq;
 	struct resource *res;
+	int id, context_id;
 	bool cpuhp_setup;
+	u32 gsi_base;
 
 	if (is_of_node(dev->fwnode)) {
 		const struct of_device_id *id;
@@ -510,19 +538,21 @@ static int plic_probe(struct platform_device *pdev)
 		return -EIO;
 	}
 
-	rc = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts);
+	rc = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts, &gsi_base, &id);
 	if (rc) {
 		dev_err(dev, "failed to parse irqs and contexts\n");
 		return rc;
 	}
 	priv->nr_irqs = nr_irqs;
+	priv->gsi_base = gsi_base;
+	priv->id = id;
 
 	priv->prio_save = devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
 	if (!priv->prio_save)
 		return -ENOMEM;
 
 	for (i = 0; i < nr_contexts; i++) {
-		rc = plic_parse_context_parent_hwirq(pdev, i,
+		rc = plic_parse_context_parent_hwirq(pdev, i, priv->id,
 						     &parent_hwirq, &hartid);
 		if (rc) {
 			dev_warn(dev, "hwirq for context%d not found\n", i);
@@ -574,13 +604,23 @@ static int plic_probe(struct platform_device *pdev)
 			goto done;
 		}
 
+		if (is_of_node(dev->fwnode)) {
+			context_id = i;
+		} else {
+			rc = acpi_get_plic_context(priv->id, i, &context_id);
+			if (rc) {
+				dev_warn(dev, "invalid context id for context%d\n", i);
+				continue;
+			}
+		}
+
 		cpumask_set_cpu(cpu, &priv->lmask);
 		handler->present = true;
 		handler->hart_base = priv->regs + CONTEXT_BASE +
-			i * CONTEXT_SIZE;
+			context_id * CONTEXT_SIZE;
 		raw_spin_lock_init(&handler->enable_lock);
 		handler->enable_base = priv->regs + CONTEXT_ENABLE_BASE +
-			i * CONTEXT_ENABLE_SIZE;
+			context_id * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 
 		handler->enable_save =  devm_kcalloc(dev,
-- 
2.39.2


