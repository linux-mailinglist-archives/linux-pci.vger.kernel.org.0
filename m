Return-Path: <linux-pci+bounces-31017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA22AEC974
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 19:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAF8189C274
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 17:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D045A288502;
	Sat, 28 Jun 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnKHCbCw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A333D2882D3;
	Sat, 28 Jun 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131830; cv=none; b=nkAaolRmq65/QrQL6Xqdb1U1EAgRua73ux49zdcCEA0tKyWWtiIC9lzDpalW6/8aZ5nAimfPr51ZsQf/mVEEe1TdgGcIdaZs7Kj7fQKvcYobzKlaalMKMkZyj5a1dfCqeX1x7g67tBzoLR9cG03eMBcDQmyG3uJ3kphnf6knf1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131830; c=relaxed/simple;
	bh=jcOz3x1eGlNJpjfPJye0zmL0BeEqCXJWFfQN+XE02XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JxqJUbQ4Gky4seKkqwVEYa08YnSh5q34itKYGaiDplmdSrT+4Yqhy8pRmDpt0wyhScOB74owvFG+pGON34gXhDd2H8bFibbECFQ2mhUtFSOzl0UxZGk0TEsONt9g4+aB0lFwTX6IQxaOJ+P1Con8C+Fbn3Pe1RN6Z1+TK1dNX9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnKHCbCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84042C4CEEF;
	Sat, 28 Jun 2025 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751131830;
	bh=jcOz3x1eGlNJpjfPJye0zmL0BeEqCXJWFfQN+XE02XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mnKHCbCwtx3uTyrPjXJq80QwKbtrL4UBVIwHDOlOzCEalNs2fcMN/zjKeGHyukzkH
	 6GK/UycXynXKtjBy9cGYk/woCl3twg+6q0kGXyY+2eQ9K2tDKmBdG5ZE3oNZhDmdJ4
	 cYWKYL5QJwryutN3CoKVFWBMxGWFBD2tW3oFr0P8MCcoNIJbeZ8k2FTXnQgUtvmEKK
	 OTd6QOKcNQ0X5vyH4lDEHTNN4iCexOemRzuFjEe34x/Uy9/Jx1Wpgk+Pi74FG9uT9d
	 7H6HImnXD7Ub+c7XjwRQIlr/NHXl5LCPaLs0BpeZWdvAqyz3gwyJJRr8zJJVJmcedU
	 O9asPCiBVxPiA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uVZNk-00AqZC-Lh;
	Sat, 28 Jun 2025 18:30:28 +0100
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
Subject: [PATCH 12/12] PCI: xgene-msi: Restructure handler setup/teardown
Date: Sat, 28 Jun 2025 18:30:05 +0100
Message-Id: <20250628173005.445013-13-maz@kernel.org>
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

Another utterly pointless aspect of the xgene-msi driver is that
it is built around CPU hotplug. Which is quite amusing since this
is one of the few arm64 platforms that, by construction, cannot
do CPU hotplug in a supported way (no EL3, no PSCI, no luck).

Drop the CPU hotplug nonsense and just setup the IRQs and handlers
in a less overdesigned way, grouping things more logically in the
process.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-xgene-msi.c | 109 +++++++++----------------
 1 file changed, 37 insertions(+), 72 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index a22a6df7808c7..9f05c2a12da94 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -216,12 +216,6 @@ static int xgene_allocate_domains(struct device_node *node,
 	return msi->inner_domain ? 0 : -ENOMEM;
 }
 
-static void xgene_free_domains(struct xgene_msi *msi)
-{
-	if (msi->inner_domain)
-		irq_domain_remove(msi->inner_domain);
-}
-
 static int xgene_msi_init_allocator(struct device *dev)
 {
 	xgene_msi_ctrl->bitmap = devm_bitmap_zalloc(dev, NR_MSI_VEC, GFP_KERNEL);
@@ -271,26 +265,48 @@ static void xgene_msi_isr(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static enum cpuhp_state pci_xgene_online;
-
 static void xgene_msi_remove(struct platform_device *pdev)
 {
-	struct xgene_msi *msi = platform_get_drvdata(pdev);
-
-	if (pci_xgene_online)
-		cpuhp_remove_state(pci_xgene_online);
-	cpuhp_remove_state(CPUHP_PCI_XGENE_DEAD);
+	for (int i = 0; i < NR_HW_IRQS; i++) {
+		unsigned int irq = xgene_msi_ctrl->gic_irq[i];
+		if (!irq)
+			continue;
+		irq_set_chained_handler_and_data(irq, NULL, NULL);
+	}
 
-	xgene_free_domains(msi);
+	if (xgene_msi_ctrl->inner_domain)
+		irq_domain_remove(xgene_msi_ctrl->inner_domain);
 }
 
-static int xgene_msi_hwirq_alloc(unsigned int cpu)
+static int xgene_msi_handler_setup(struct platform_device *pdev)
 {
+	struct xgene_msi *xgene_msi = xgene_msi_ctrl;
 	int i;
-	int err;
 
-	for (i = cpu; i < NR_HW_IRQS; i += num_possible_cpus()) {
-		unsigned int irq = xgene_msi_ctrl->gic_irq[i];
+	for (i = 0; i < NR_HW_IRQS; i++) {
+		u32 msi_val;
+		int irq, err;
+
+		/*
+		 * MSInIRx registers are read-to-clear; before registering
+		 * interrupt handlers, read all of them to clear spurious
+		 * interrupts that may occur before the driver is probed.
+		 */
+		for (int msi_idx = 0; msi_idx < IDX_PER_GROUP; msi_idx++)
+			xgene_msi_ir_read(xgene_msi, i, msi_idx);
+
+		/* Read MSIINTn to confirm */
+		msi_val = xgene_msi_int_read(xgene_msi, i);
+		if (msi_val) {
+			dev_err(&pdev->dev, "Failed to clear spurious IRQ\n");
+			return EINVAL;
+		}
+
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			return irq;
+
+		xgene_msi->gic_irq[i] = irq;
 
 		/*
 		 * Statically allocate MSI GIC IRQs to each CPU core.
@@ -298,7 +314,7 @@ static int xgene_msi_hwirq_alloc(unsigned int cpu)
 		 * to each core.
 		 */
 		irq_set_status_flags(irq, IRQ_NO_BALANCING);
-		err = irq_set_affinity(irq, cpumask_of(cpu));
+		err = irq_set_affinity(irq, cpumask_of(i % num_possible_cpus()));
 		if (err) {
 			pr_err("failed to set affinity for GIC IRQ");
 			return err;
@@ -311,19 +327,6 @@ static int xgene_msi_hwirq_alloc(unsigned int cpu)
 	return 0;
 }
 
-static int xgene_msi_hwirq_free(unsigned int cpu)
-{
-	struct xgene_msi *msi = xgene_msi_ctrl;
-	int i;
-
-	for (i = cpu; i < NR_HW_IRQS; i += num_possible_cpus()) {
-		if (!msi->gic_irq[i])
-			continue;
-		irq_set_chained_handler_and_data(msi->gic_irq[i], NULL, NULL);
-	}
-	return 0;
-}
-
 static const struct of_device_id xgene_msi_match_table[] = {
 	{.compatible = "apm,xgene1-msi"},
 	{},
@@ -333,7 +336,6 @@ static int xgene_msi_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct xgene_msi *xgene_msi;
-	u32 msi_val, msi_idx;
 	int rc;
 
 	xgene_msi_ctrl = devm_kzalloc(&pdev->dev, sizeof(*xgene_msi_ctrl),
@@ -343,8 +345,6 @@ static int xgene_msi_probe(struct platform_device *pdev)
 
 	xgene_msi = xgene_msi_ctrl;
 
-	platform_set_drvdata(pdev, xgene_msi);
-
 	xgene_msi->msi_regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(xgene_msi->msi_regs)) {
 		rc = PTR_ERR(xgene_msi->msi_regs);
@@ -364,48 +364,13 @@ static int xgene_msi_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	for (int irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
-		rc = platform_get_irq(pdev, irq_index);
-		if (rc < 0)
-			goto error;
-
-		xgene_msi->gic_irq[irq_index] = rc;
-	}
-
-	/*
-	 * MSInIRx registers are read-to-clear; before registering
-	 * interrupt handlers, read all of them to clear spurious
-	 * interrupts that may occur before the driver is probed.
-	 */
-	for (int irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
-		for (msi_idx = 0; msi_idx < IDX_PER_GROUP; msi_idx++)
-			xgene_msi_ir_read(xgene_msi, irq_index, msi_idx);
-
-		/* Read MSIINTn to confirm */
-		msi_val = xgene_msi_int_read(xgene_msi, irq_index);
-		if (msi_val) {
-			dev_err(&pdev->dev, "Failed to clear spurious IRQ\n");
-			rc = -EINVAL;
-			goto error;
-		}
-	}
-
-	rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "pci/xgene:online",
-			       xgene_msi_hwirq_alloc, NULL);
-	if (rc < 0)
-		goto err_cpuhp;
-	pci_xgene_online = rc;
-	rc = cpuhp_setup_state(CPUHP_PCI_XGENE_DEAD, "pci/xgene:dead", NULL,
-			       xgene_msi_hwirq_free);
+	rc = xgene_msi_handler_setup(pdev);
 	if (rc)
-		goto err_cpuhp;
+		goto error;
 
 	dev_info(&pdev->dev, "APM X-Gene PCIe MSI driver loaded\n");
 
 	return 0;
-
-err_cpuhp:
-	dev_err(&pdev->dev, "failed to add CPU MSI notifier\n");
 error:
 	xgene_msi_remove(pdev);
 	return rc;
-- 
2.39.2


