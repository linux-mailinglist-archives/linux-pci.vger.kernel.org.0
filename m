Return-Path: <linux-pci+bounces-31012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0732AEC96C
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 19:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11EDF3BE549
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 17:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6184328750C;
	Sat, 28 Jun 2025 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LO9h/GJi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3511E287270;
	Sat, 28 Jun 2025 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131829; cv=none; b=c/lVoPkmCj51ajU9w+ANqm1L8Jh2Gvf+dsAX6xBNIgTsoL32lAhwe2Vm35wN1XTgDd2ab7ML0cm3SPpUjM2G1y0/W3pO3+IGytQmmgCKnFympXw7cGQfzASjdXlNEtCkw2qK0iM+GbW0AekXVagBd8+7Wa0jIk9N5v0mZ4F3/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131829; c=relaxed/simple;
	bh=JZyJGXIu/4I+riiflFUcQzbvQss2UZj5eTHZTtcmb0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hxBC47+MVft4h7vqDX648VdprI4y+6rMzHpSELbO9s18CUEMMno34D3Q7oDdbKUFAull2RYZs3yIsFOEaO4xilWh8rwQfwNztgpV0YRblLk0/u+VVWceRXQ+OMOokrl2787QYUFzzX2pgJHlLcFmFzn4G0nilbY+Lr1cZiANLLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LO9h/GJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1060AC4CEEA;
	Sat, 28 Jun 2025 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751131829;
	bh=JZyJGXIu/4I+riiflFUcQzbvQss2UZj5eTHZTtcmb0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LO9h/GJi2Ir33taGZccJ/ya3WyPfw3E0QPo2kAy/N58uMiARZCXYxj+35Jsu0zvOV
	 8ReuFVXfP3eQxrBmNvIxe0PwjwCx/OFjjNN1Gc0/n7pyXP+Cd5COgAJzJFDd7fWOGl
	 vA/FVG/OytThgFLMC9LqWitbUTkbWRYCbm4tv7pci7FlCrX+3grl8vhygo6nhCdvo/
	 eOE0Tz5JHJCrvCLFGY5U11ZEqEi2YBNclLmINOZY4n6JQT111b4c66JMTQmZC14pTb
	 qENINSVmIEI9zJI+ptMIMzrqJNx8L/VSXu0sE8+X4uHMUH+8jxdFwxpAyps7FtycTK
	 7exj2AVFw0vJw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uVZNj-00AqZC-8P;
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
Subject: [PATCH 07/12] PCI: xgene-msi: Use device-managed memory allocations
Date: Sat, 28 Jun 2025 18:30:00 +0100
Message-Id: <20250628173005.445013-8-maz@kernel.org>
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

Since the MSI driver is probed as a platform device, there is no
reason to not use device-managed allocations. That's including
the top-level bookkeeping structure, which is better dynamically
alocated than being static.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-xgene-msi.c | 37 +++++++++++++-------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index 3ca9a13cf38d3..b3ac0125b3b40 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -40,7 +40,7 @@ struct xgene_msi {
 };
 
 /* Global data */
-static struct xgene_msi xgene_msi_ctrl;
+static struct xgene_msi *xgene_msi_ctrl;
 
 /*
  * X-Gene v1 has 16 groups of MSI termination registers MSInIRx, where
@@ -253,18 +253,18 @@ static void xgene_free_domains(struct xgene_msi *msi)
 		irq_domain_remove(msi->inner_domain);
 }
 
-static int xgene_msi_init_allocator(struct xgene_msi *xgene_msi)
+static int xgene_msi_init_allocator(struct device *dev)
 {
-	xgene_msi->bitmap = bitmap_zalloc(NR_MSI_VEC, GFP_KERNEL);
-	if (!xgene_msi->bitmap)
+	xgene_msi_ctrl->bitmap = devm_bitmap_zalloc(dev, NR_MSI_VEC, GFP_KERNEL);
+	if (!xgene_msi_ctrl->bitmap)
 		return -ENOMEM;
 
-	mutex_init(&xgene_msi->bitmap_lock);
+	mutex_init(&xgene_msi_ctrl->bitmap_lock);
 
-	xgene_msi->msi_groups = kcalloc(NR_HW_IRQS,
-					sizeof(struct xgene_msi_group),
-					GFP_KERNEL);
-	if (!xgene_msi->msi_groups)
+	xgene_msi_ctrl->msi_groups = devm_kcalloc(dev, NR_HW_IRQS,
+						  sizeof(struct xgene_msi_group),
+						  GFP_KERNEL);
+	if (!xgene_msi_ctrl->msi_groups)
 		return -ENOMEM;
 
 	return 0;
@@ -273,15 +273,14 @@ static int xgene_msi_init_allocator(struct xgene_msi *xgene_msi)
 static void xgene_msi_isr(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct xgene_msi *xgene_msi = xgene_msi_ctrl;
 	struct xgene_msi_group *msi_groups;
-	struct xgene_msi *xgene_msi;
 	int msir_index, msir_val, hw_irq, ret;
 	u32 intr_index, grp_select, msi_grp;
 
 	chained_irq_enter(chip, desc);
 
 	msi_groups = irq_desc_get_handler_data(desc);
-	xgene_msi = msi_groups->msi;
 	msi_grp = msi_groups->msi_grp;
 
 	/*
@@ -344,15 +343,12 @@ static void xgene_msi_remove(struct platform_device *pdev)
 
 	kfree(msi->msi_groups);
 
-	bitmap_free(msi->bitmap);
-	msi->bitmap = NULL;
-
 	xgene_free_domains(msi);
 }
 
 static int xgene_msi_hwirq_alloc(unsigned int cpu)
 {
-	struct xgene_msi *msi = &xgene_msi_ctrl;
+	struct xgene_msi *msi = xgene_msi_ctrl;
 	struct xgene_msi_group *msi_group;
 	int i;
 	int err;
@@ -381,7 +377,7 @@ static int xgene_msi_hwirq_alloc(unsigned int cpu)
 
 static int xgene_msi_hwirq_free(unsigned int cpu)
 {
-	struct xgene_msi *msi = &xgene_msi_ctrl;
+	struct xgene_msi *msi = xgene_msi_ctrl;
 	struct xgene_msi_group *msi_group;
 	int i;
 
@@ -408,7 +404,12 @@ static int xgene_msi_probe(struct platform_device *pdev)
 	int virt_msir;
 	u32 msi_val, msi_idx;
 
-	xgene_msi = &xgene_msi_ctrl;
+	xgene_msi_ctrl = devm_kzalloc(&pdev->dev, sizeof(*xgene_msi_ctrl),
+				      GFP_KERNEL);
+	if (!xgene_msi_ctrl)
+		return -ENOMEM;
+
+	xgene_msi = xgene_msi_ctrl;
 
 	platform_set_drvdata(pdev, xgene_msi);
 
@@ -419,7 +420,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
 	}
 	xgene_msi->msi_addr = res->start;
 
-	rc = xgene_msi_init_allocator(xgene_msi);
+	rc = xgene_msi_init_allocator(&pdev->dev);
 	if (rc) {
 		dev_err(&pdev->dev, "Error allocating MSI bitmap\n");
 		goto error;
-- 
2.39.2


