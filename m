Return-Path: <linux-pci+bounces-29423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C254DAD5283
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 12:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E84B7AD08D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 10:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A49284B4A;
	Wed, 11 Jun 2025 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idAe2R7l"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F845284B3A;
	Wed, 11 Jun 2025 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638673; cv=none; b=GebfK/q7oo0+Rfsn/APwAwvmqhzKY3TI/E1n0pF9/+UE19QgkKenZvlsNOfzrmlnuGyBEPtpAozXmc62SN6XncYwXiaH5LMe0DVdUTjlEorfxjq84W4wNG6MEclgHim1AlFrXiEz0mcv3xaReNTkvdPICgdR26Dy2QegXedwc7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638673; c=relaxed/simple;
	bh=hA0wj8cW1lU72wYErpe+Q30mvQrkFsCwfJGZ5PR4buI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwFagip64KDSzJbvYG/GP7PN6pcdGRgq83yYSrdV6irF6e4Ol1BFXyP3ndwsQmj4Ghfdf0MiXq4PF0HUl0vrSWJMfYY5qxC82aqVMJwoLID0r+I6rCFvY14amUDp/fChNIIFKvA0X9eNtUA70xLumCS/rBMv/N5IVNigfoZ20pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idAe2R7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E086EC4CEEE;
	Wed, 11 Jun 2025 10:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749638673;
	bh=hA0wj8cW1lU72wYErpe+Q30mvQrkFsCwfJGZ5PR4buI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idAe2R7l8Vm5D3aOhjTSclyhlRJOEbI1FzRE4akb9XeIBXKgTwAUZk2m6fn0VA6wb
	 VfCAAEvDTmHhsAtx2CJXOvukuplPLKmBpnHcFcNO/XD2DZfCzh+wFeGqo68Cnnvn4a
	 OHjk4/fAAennKcum1dL866WrFwbA1m+qD9LzU1FsVy3bObP6jV53WMJK8Luyb0Da/t
	 5p03N875nDZwGOLHpb8xoSW7g6mj5Uvb8Hnlh96WGc3T8ascQD11melYsvfXUThXKv
	 377GGjGU5wougSAWGUjubD9uYMVyelZDj40DEIRFX1YY2gywi4AhtkvuKQKFYydktn
	 heqOjK4Gw4xpA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH] pci/controller: Use dev_fwnode()
Date: Wed, 11 Jun 2025 12:43:44 +0200
Message-ID: <20250611104348.192092-16-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611104348.192092-1-jirislaby@kernel.org>
References: <20250611104348.192092-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_domain_create_simple() takes fwnode as the first argument. It can be
extracted from the struct device using dev_fwnode() helper instead of
using of_node with of_fwnode_handle().

So use the dev_fwnode() helper.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 5 ++---
 drivers/pci/controller/pcie-mediatek-gen3.c          | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index a600f46ee3c3..cd44ddb698ea 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -464,9 +464,8 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
 	struct mobiveil_root_port *rp = &pcie->rp;
 
 	/* setup INTx */
-	rp->intx_domain = irq_domain_create_linear(of_fwnode_handle(dev->of_node), PCI_NUM_INTX,
-						   &intx_domain_ops, pcie);
-
+	rp->intx_domain = irq_domain_create_linear(dev_fwnode(dev), PCI_NUM_INTX, &intx_domain_ops,
+						   pcie);
 	if (!rp->intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENOMEM;
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index b55f5973414c..5464b4ae5c20 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -756,8 +756,7 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
 	/* Setup MSI */
 	mutex_init(&pcie->lock);
 
-	pcie->msi_bottom_domain = irq_domain_create_linear(of_fwnode_handle(node),
-							   PCIE_MSI_IRQS_NUM,
+	pcie->msi_bottom_domain = irq_domain_create_linear(dev_fwnode(dev), PCIE_MSI_IRQS_NUM,
 							   &mtk_msi_bottom_domain_ops, pcie);
 	if (!pcie->msi_bottom_domain) {
 		dev_err(dev, "failed to create MSI bottom domain\n");
-- 
2.49.0


