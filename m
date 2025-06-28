Return-Path: <linux-pci+bounces-31013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF195AEC970
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 19:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B34170EB7
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 17:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323BE2877F0;
	Sat, 28 Jun 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMziUJ9p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2602877DB;
	Sat, 28 Jun 2025 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131830; cv=none; b=N7gPL3cc25lJ8ocCoOqFAQkjIL0fSjwNDLeTLzNWPS8QoCp9hk5pKxiz6uVVkkXqhHSPeyEFQWMFRKnji3OIKNo6e3rwyQNuwKNX9xnQGT3KPySyct7JwDD3HPHhZOLOsa3E1pZ7OGIFN6FrtyEJj1D7SzVXikNrGCVsGM84L+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131830; c=relaxed/simple;
	bh=DHDYX8cxljeI3rHGGcqR3uEzr7HycmJ924nJhLeqQ78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZDk4Mce+9jQTGs9/ZscjGA9o+rmK7G9nQ+b1pDRY+pZQ+U2RGZ5QNEnR8PFO6zlv23FJPuRUy5bpyicFtlIbj951z8fv/F/CbXgrT2IZm/1Us1vwi1OFmJ8+my7P9djMtyNySx/8IshUUXp3B1/b69d1GnUAVE6OAh5IyPmlk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMziUJ9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C09CC4CEEA;
	Sat, 28 Jun 2025 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751131829;
	bh=DHDYX8cxljeI3rHGGcqR3uEzr7HycmJ924nJhLeqQ78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rMziUJ9pucVOVHytvHBKwI1DHX9Hn6L2H2Kvhrn1AcG77Ur4XuHhLaN7LwT0i4EfK
	 xscWXWjSYh6/xEjPo1WONO2OJWS3+h8V1sF9wgRctg1HbFSydTF5hZyqtbexCY7DgW
	 j6WB/Rjp6QtJgl8kPR0k4ZT9za3gdZkdUum7bXdfBs0PgOlPz3GE3RIZENl/Jx//Cc
	 LmLLDZxyP4bLnaHhrt2e/GUbRs/0WaCjYT7+wEPMzohjasfxvUCeOIv9zxFyYX94sF
	 AeX4Nd4thFOsMZCXlnUg+j/h+PSIBWF5FLi8DgoSd1Rn8usPm/L2JNprE/bFN1bPHY
	 rHfD8yo3fFIPQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uVZNj-00AqZC-GE;
	Sat, 28 Jun 2025 18:30:27 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Toan Le <toan@os.amperecomputing.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 08/12] PCI: xgene-msi: Get rid of intermediate tracking structure
Date: Sat, 28 Jun 2025 18:30:01 +0100
Message-Id: <20250628173005.445013-9-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250628173005.445013-1-maz@kernel.org>
References: <20250628173005.445013-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, toan@os.amperecomputing.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

The xgene-msi driver uses an odd construct in the form of an
intermediate tracking structure, evidently designed to deal with
multiple instances of the MSI widget. However, the existing HW
only has one set, and it is obvious that there won't be new HW
coming down that particular line.

Simplify the driver by using a bit of pointer arithmetic instead,
directly tracking the interrupt and avoiding extra memory allocation.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-xgene-msi.c | 58 ++++++++------------------
 1 file changed, 17 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index b3ac0125b3b40..4be79b9ff80df 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -24,19 +24,13 @@
 #define NR_HW_IRQS		16
 #define NR_MSI_VEC		(IDX_PER_GROUP * IRQS_PER_IDX * NR_HW_IRQS)
 
-struct xgene_msi_group {
-	struct xgene_msi	*msi;
-	int			gic_irq;
-	u32			msi_grp;
-};
-
 struct xgene_msi {
 	struct irq_domain	*inner_domain;
 	u64			msi_addr;
 	void __iomem		*msi_regs;
 	unsigned long		*bitmap;
 	struct mutex		bitmap_lock;
-	struct xgene_msi_group	*msi_groups;
+	unsigned int		gic_irq[NR_HW_IRQS];
 };
 
 /* Global data */
@@ -261,27 +255,20 @@ static int xgene_msi_init_allocator(struct device *dev)
 
 	mutex_init(&xgene_msi_ctrl->bitmap_lock);
 
-	xgene_msi_ctrl->msi_groups = devm_kcalloc(dev, NR_HW_IRQS,
-						  sizeof(struct xgene_msi_group),
-						  GFP_KERNEL);
-	if (!xgene_msi_ctrl->msi_groups)
-		return -ENOMEM;
-
 	return 0;
 }
 
 static void xgene_msi_isr(struct irq_desc *desc)
 {
+	unsigned int *irqp = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct xgene_msi *xgene_msi = xgene_msi_ctrl;
-	struct xgene_msi_group *msi_groups;
 	int msir_index, msir_val, hw_irq, ret;
 	u32 intr_index, grp_select, msi_grp;
 
 	chained_irq_enter(chip, desc);
 
-	msi_groups = irq_desc_get_handler_data(desc);
-	msi_grp = msi_groups->msi_grp;
+	msi_grp = irqp - xgene_msi->gic_irq;
 
 	/*
 	 * MSIINTn (n is 0..F) indicates if there is a pending MSI interrupt
@@ -341,35 +328,31 @@ static void xgene_msi_remove(struct platform_device *pdev)
 		cpuhp_remove_state(pci_xgene_online);
 	cpuhp_remove_state(CPUHP_PCI_XGENE_DEAD);
 
-	kfree(msi->msi_groups);
-
 	xgene_free_domains(msi);
 }
 
 static int xgene_msi_hwirq_alloc(unsigned int cpu)
 {
-	struct xgene_msi *msi = xgene_msi_ctrl;
-	struct xgene_msi_group *msi_group;
 	int i;
 	int err;
 
 	for (i = cpu; i < NR_HW_IRQS; i += num_possible_cpus()) {
-		msi_group = &msi->msi_groups[i];
+		unsigned int irq = xgene_msi_ctrl->gic_irq[i];
 
 		/*
 		 * Statically allocate MSI GIC IRQs to each CPU core.
 		 * With 8-core X-Gene v1, 2 MSI GIC IRQs are allocated
 		 * to each core.
 		 */
-		irq_set_status_flags(msi_group->gic_irq, IRQ_NO_BALANCING);
-		err = irq_set_affinity(msi_group->gic_irq, cpumask_of(cpu));
+		irq_set_status_flags(irq, IRQ_NO_BALANCING);
+		err = irq_set_affinity(irq, cpumask_of(cpu));
 		if (err) {
 			pr_err("failed to set affinity for GIC IRQ");
 			return err;
 		}
 
-		irq_set_chained_handler_and_data(msi_group->gic_irq,
-			xgene_msi_isr, msi_group);
+		irq_set_chained_handler_and_data(irq, xgene_msi_isr,
+						 &xgene_msi_ctrl->gic_irq[i]);
 	}
 
 	return 0;
@@ -378,15 +361,12 @@ static int xgene_msi_hwirq_alloc(unsigned int cpu)
 static int xgene_msi_hwirq_free(unsigned int cpu)
 {
 	struct xgene_msi *msi = xgene_msi_ctrl;
-	struct xgene_msi_group *msi_group;
 	int i;
 
 	for (i = cpu; i < NR_HW_IRQS; i += num_possible_cpus()) {
-		msi_group = &msi->msi_groups[i];
-		if (!msi_group->gic_irq)
+		if (!msi->gic_irq[i])
 			continue;
-		irq_set_chained_handler_and_data(msi_group->gic_irq, NULL,
-						 NULL);
+		irq_set_chained_handler_and_data(msi->gic_irq[i], NULL, NULL);
 	}
 	return 0;
 }
@@ -399,10 +379,9 @@ static const struct of_device_id xgene_msi_match_table[] = {
 static int xgene_msi_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-	int rc, irq_index;
 	struct xgene_msi *xgene_msi;
-	int virt_msir;
 	u32 msi_val, msi_idx;
+	int rc;
 
 	xgene_msi_ctrl = devm_kzalloc(&pdev->dev, sizeof(*xgene_msi_ctrl),
 				      GFP_KERNEL);
@@ -432,15 +411,12 @@ static int xgene_msi_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	for (irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
-		virt_msir = platform_get_irq(pdev, irq_index);
-		if (virt_msir < 0) {
-			rc = virt_msir;
+	for (int irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
+		rc = platform_get_irq(pdev, irq_index);
+		if (rc < 0)
 			goto error;
-		}
-		xgene_msi->msi_groups[irq_index].gic_irq = virt_msir;
-		xgene_msi->msi_groups[irq_index].msi_grp = irq_index;
-		xgene_msi->msi_groups[irq_index].msi = xgene_msi;
+
+		xgene_msi->gic_irq[irq_index] = rc;
 	}
 
 	/*
@@ -448,7 +424,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
 	 * interrupt handlers, read all of them to clear spurious
 	 * interrupts that may occur before the driver is probed.
 	 */
-	for (irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
+	for (int irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
 		for (msi_idx = 0; msi_idx < IDX_PER_GROUP; msi_idx++)
 			xgene_msi_ir_read(xgene_msi, irq_index, msi_idx);
 
-- 
2.39.2


