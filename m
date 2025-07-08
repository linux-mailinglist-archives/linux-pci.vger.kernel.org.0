Return-Path: <linux-pci+bounces-31710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EFBAFD56A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C93756550B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1285B2E7169;
	Tue,  8 Jul 2025 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2Ez36Kw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6DC2E6D2A;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996052; cv=none; b=WpEhsHpNGtA2dX0WazrEQoFCUlx3pQpG0oTRzhim/qUGS+mPEG05ODYAPrm2eEmAuilO3/gIYlMziuPnJgaaRWBkISPIC0te1+e74/vSFHF15GFq7EvqGj462aoskqJF+a2scfZW8FfOzsabJna5D5rg+YxHNXpeJJ+yqCKhtCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996052; c=relaxed/simple;
	bh=qWYeb6MF8JBZHzsUTq1buPEorDJbsZ0f2u6J/KVs+2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TFD+2jD+rI5BS2pZCkQfHJP4wKMM6DbzJCw5pCN4kFcoHcq5+YiuEi+Y+mdl+cLWSnD9S5+ZvbHXd9dBPt+YEjM6Z1U7wh53AG3JmPLyCrAjSV9XZwuIlIASYjyH9nHhfxyuqBkZR4SQVISKQ5Fyqx6UGKz3gaiGA9MbrG3RDVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2Ez36Kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966E5C4CEF7;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751996051;
	bh=qWYeb6MF8JBZHzsUTq1buPEorDJbsZ0f2u6J/KVs+2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2Ez36Kw3qv2a/OFVg6YYk3aw0iaY6ZcOd5VUiZpj55VmM5KtXu7+61Ov0zu7y3e7
	 mHRvAIlq+fZIpnvTMK5WCPl+wY2qW+4+7Awr3vKCZ+bkqhy7dDeq7/oa6In2EHP7ks
	 JS9FmrPjpQw5T7Fy2yR6DpK8NvZJCJd+u7c6GJg24+njISAH8cwZx00PPE431/Utc8
	 wIJP1jElqsBs9zEnJY5ib+xoBTT2VHWB/Rg2v6MdrJmGgP0KM6BHagzCq4PSyepKlB
	 0fNxng2IsrW75KQipYinkBBUCYYmS25crZSSPnuhIdnrjo47XV38+RjnwsRl8OeKFF
	 1jrx/hu7ZI/vA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uZCCn-00Dqhw-Oz;
	Tue, 08 Jul 2025 18:34:09 +0100
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
Subject: [PATCH v2 06/13] PCI: xgene-msi: Drop superfluous fields from xgene_msi structure
Date: Tue,  8 Jul 2025 18:33:57 +0100
Message-Id: <20250708173404.1278635-7-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250708173404.1278635-1-maz@kernel.org>
References: <20250708173404.1278635-1-maz@kernel.org>
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

The xgene_msi structure remembers both the of_node of the device
and the number of CPUs. All of which are perfectly useless.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-xgene-msi.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index 5b69286689177..50a817920cfd9 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -31,14 +31,12 @@ struct xgene_msi_group {
 };
 
 struct xgene_msi {
-	struct device_node	*node;
 	struct irq_domain	*inner_domain;
 	u64			msi_addr;
 	void __iomem		*msi_regs;
 	unsigned long		*bitmap;
 	struct mutex		bitmap_lock;
 	struct xgene_msi_group	*msi_groups;
-	int			num_cpus;
 };
 
 /* Global data */
@@ -147,7 +145,7 @@ static void xgene_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
  */
 static int hwirq_to_cpu(unsigned long hwirq)
 {
-	return (hwirq % xgene_msi_ctrl.num_cpus);
+	return (hwirq % num_possible_cpus());
 }
 
 static unsigned long hwirq_to_canonical_hwirq(unsigned long hwirq)
@@ -186,9 +184,9 @@ static int xgene_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	mutex_lock(&msi->bitmap_lock);
 
 	msi_irq = bitmap_find_next_zero_area(msi->bitmap, NR_MSI_VEC, 0,
-					     msi->num_cpus, 0);
+					     num_possible_cpus(), 0);
 	if (msi_irq < NR_MSI_VEC)
-		bitmap_set(msi->bitmap, msi_irq, msi->num_cpus);
+		bitmap_set(msi->bitmap, msi_irq, num_possible_cpus());
 	else
 		msi_irq = -ENOSPC;
 
@@ -214,7 +212,7 @@ static void xgene_irq_domain_free(struct irq_domain *domain,
 	mutex_lock(&msi->bitmap_lock);
 
 	hwirq = hwirq_to_canonical_hwirq(d->hwirq);
-	bitmap_clear(msi->bitmap, hwirq, msi->num_cpus);
+	bitmap_clear(msi->bitmap, hwirq, num_possible_cpus());
 
 	mutex_unlock(&msi->bitmap_lock);
 
@@ -235,10 +233,11 @@ static const struct msi_parent_ops xgene_msi_parent_ops = {
 	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
-static int xgene_allocate_domains(struct xgene_msi *msi)
+static int xgene_allocate_domains(struct device_node *node,
+				  struct xgene_msi *msi)
 {
 	struct irq_domain_info info = {
-		.fwnode		= of_fwnode_handle(msi->node),
+		.fwnode		= of_fwnode_handle(node),
 		.ops		= &xgene_msi_domain_ops,
 		.size		= NR_MSI_VEC,
 		.host_data	= msi,
@@ -358,7 +357,7 @@ static int xgene_msi_hwirq_alloc(unsigned int cpu)
 	int i;
 	int err;
 
-	for (i = cpu; i < NR_HW_IRQS; i += msi->num_cpus) {
+	for (i = cpu; i < NR_HW_IRQS; i += num_possible_cpus()) {
 		msi_group = &msi->msi_groups[i];
 
 		/*
@@ -386,7 +385,7 @@ static int xgene_msi_hwirq_free(unsigned int cpu)
 	struct xgene_msi_group *msi_group;
 	int i;
 
-	for (i = cpu; i < NR_HW_IRQS; i += msi->num_cpus) {
+	for (i = cpu; i < NR_HW_IRQS; i += num_possible_cpus()) {
 		msi_group = &msi->msi_groups[i];
 		irq_set_chained_handler_and_data(msi_group->gic_irq, NULL,
 						 NULL);
@@ -417,8 +416,6 @@ static int xgene_msi_probe(struct platform_device *pdev)
 		goto error;
 	}
 	xgene_msi->msi_addr = res->start;
-	xgene_msi->node = pdev->dev.of_node;
-	xgene_msi->num_cpus = num_possible_cpus();
 
 	rc = xgene_msi_init_allocator(xgene_msi);
 	if (rc) {
@@ -426,7 +423,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	rc = xgene_allocate_domains(xgene_msi);
+	rc = xgene_allocate_domains(dev_of_node(&pdev->dev), xgene_msi);
 	if (rc) {
 		dev_err(&pdev->dev, "Failed to allocate MSI domain\n");
 		goto error;
-- 
2.39.2


