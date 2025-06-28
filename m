Return-Path: <linux-pci+bounces-31011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EC3AEC96D
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 19:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186ED189C630
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3D728727F;
	Sat, 28 Jun 2025 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFCsT+rL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4FE2868A9;
	Sat, 28 Jun 2025 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131829; cv=none; b=hdUjKgQ+yLFa2ouUhmXGVLYYlUx4adqAHU+klmSSYmuKXVJKz/ZxtAa+5/ZGLEBkD9cCAUxsy2PsOmsYgbeiQhZoZi74l/dY56IirIGk5e7Xy6s6sInNgFpILxX6DCiTJGSDprIhaI3G5W9o4ouYk2FSM/6bdWlGqwO+WXk2e+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131829; c=relaxed/simple;
	bh=4Gg5A1LyFjdZmUgJo3m479Qqj8iK0uKlUkKwvsIYG08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aq9ijG553T8Z1fZJ7yvTxrYZbtqO8KWoiuJwKLPJWtJIWuPNSrUXc/PZUWH/acq4iQsoZWQZHXyE/m08iIjvj362TJXhnDkK71LEg/yqs6HSsd8yVUmXuctk0M2YmkvsIRMGvsrASR2CFo7KiOs+2yqxPKW5n+i4TIAbO0KqRGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFCsT+rL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD76C4CEED;
	Sat, 28 Jun 2025 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751131828;
	bh=4Gg5A1LyFjdZmUgJo3m479Qqj8iK0uKlUkKwvsIYG08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFCsT+rLkcqq4jOmXDTLFYZVnXozPG6tq3LqY/qFbK7zn00/y0gSMDg5/P+gT5c8x
	 FII2gsx2fui7qRAYLNnDw2owytPhv5s8uRX0cZp4uCDAhWvcv86La3J3RBZOCZZiSN
	 3Dm5ItjnrQSwyuUzJ6ZXMwB86kDWyjyf+jyacsdZQhTc4RSWXneEU5Q0faowlDPEtH
	 zpMOhBFllKZ99SbP/f6E4iENVsIkiuCRfLNZU+davFELsKyXGsUh5feWZ48CZOpKvn
	 Y5IIjylzWJoYfy6GopTBucTluQEY2lOBFgnTrH+aB0C0k6rpPtiUcn+8V45M/YOcxj
	 n1vvwYNup/wqQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uVZNj-00AqZC-09;
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
Subject: [PATCH 06/12] PCI: xgene-msi: Drop superfluous fields from xgene_msi structure
Date: Sat, 28 Jun 2025 18:29:59 +0100
Message-Id: <20250628173005.445013-7-maz@kernel.org>
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

The xgene_msi structure remembers both the of_node of the device
and the number of CPUs. All of which are perfectly useless.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-xgene-msi.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index 25cb4119bab07..3ca9a13cf38d3 100644
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
@@ -386,11 +385,10 @@ static int xgene_msi_hwirq_free(unsigned int cpu)
 	struct xgene_msi_group *msi_group;
 	int i;
 
-	for (i = cpu; i < NR_HW_IRQS; i += msi->num_cpus) {
+	for (i = cpu; i < NR_HW_IRQS; i += num_possible_cpus()) {
 		msi_group = &msi->msi_groups[i];
 		if (!msi_group->gic_irq)
 			continue;
-
 		irq_set_chained_handler_and_data(msi_group->gic_irq, NULL,
 						 NULL);
 	}
@@ -420,8 +418,6 @@ static int xgene_msi_probe(struct platform_device *pdev)
 		goto error;
 	}
 	xgene_msi->msi_addr = res->start;
-	xgene_msi->node = pdev->dev.of_node;
-	xgene_msi->num_cpus = num_possible_cpus();
 
 	rc = xgene_msi_init_allocator(xgene_msi);
 	if (rc) {
@@ -429,7 +425,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	rc = xgene_allocate_domains(xgene_msi);
+	rc = xgene_allocate_domains(dev_of_node(&pdev->dev), xgene_msi);
 	if (rc) {
 		dev_err(&pdev->dev, "Failed to allocate MSI domain\n");
 		goto error;
-- 
2.39.2


