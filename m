Return-Path: <linux-pci+bounces-36510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D52B8A401
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 17:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14DE17DA8A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 15:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135BC31814F;
	Fri, 19 Sep 2025 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ydu2gNT/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2B318136;
	Fri, 19 Sep 2025 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295429; cv=none; b=hNdLI9U9n5Hl/azb9D3ZT/Tlfi1ZqfefV6yWqff9/pLH22nro/Tx2vL4uAJ0oV4aEfELINT+LG2ktQ5famuLZxtV1MZWT5uIYril61FfEt/0/r+MyRpaIdZ7lStor4AiWfhVWRfSUAxN7cJz6aNP93P/h9vhcu6kUhzRu8Y0XDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295429; c=relaxed/simple;
	bh=XFYGqWQuFX4br1ELZqbi3iLoE9Zl/ffZCDX5rRarUF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WO217w7oYSt4DSCvhVFiUxgMMTiRLo8nSKQP02UAbMyb3KZ7JcHzYtSLdL8++d/tLCAspawnJ6/d7pfF/sRks3v8ZJfy6Tz6dz5sZpjHcBLKmYrPOODzghtBqLSyxMCbOomAY1UfdLg+NyFmbWMMwviy3bXKItiCLaTeeE4wt74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ydu2gNT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06C4C4CEF0;
	Fri, 19 Sep 2025 15:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758295429;
	bh=XFYGqWQuFX4br1ELZqbi3iLoE9Zl/ffZCDX5rRarUF4=;
	h=From:To:Cc:Subject:Date:From;
	b=Ydu2gNT/q8+2uZqIsYMctWbHaxOa0Z/R1rNVao5UOVqK+jCT2U8zVMhk5tN9YMpCg
	 ZmSY0YY/hAPreybEZjg1+ezyIUWfLUTLyrVp7xS069EOGJ0xY7xN2tOXM84Qv9/Q3d
	 Ltu8HzdwwYxFwrrcvcsz1cQi+fxap07t0LAzWfqVkbV809AmnW6X8aTP6ZN+yZKPMp
	 u+Y5Ki7ZK1ddq0lvuoGKx4sStZJGSrfdGpPAgdsQXWhFQMSKkhicdbehvNqI1Qs9zI
	 l5VQvw8WmrKS6vReuvONvUZspBBhYFJLuoEpLKsJxLRJhUYUtCl4iZAZiRD6TdFjTH
	 Cbh9/vU8dPpvQ==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Vidya Sagar <vidyas@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH] PCI: tegra194: Fix broken tegra_pcie_ep_raise_msi_irq()
Date: Fri, 19 Sep 2025 17:23:30 +0200
Message-ID: <20250919152329.239160-2-cassel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1816; i=cassel@kernel.org; h=from:subject; bh=XFYGqWQuFX4br1ELZqbi3iLoE9Zl/ffZCDX5rRarUF4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLOlhYKntZ/cGQr5+uO/T+ZO8/1BFQdDamb3Hq4NVw0m yVt669DHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiI6Q2G/w6d9ztLbD/xOBcx /Hro/5b9eE7/4dOhkRNW/Rdhu2vC08DI8KT/MYvzn53l7qsjys7FNy/+6rKEVX/TRw2dB9Yi03f XcQMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The pci_epc_raise_irq() supplies a MSI or MSI-X interrupt number in range
(1-N), see kdoc for pci_epc_raise_irq().

Thus, for MSI pci_epc_raise_irq() will supply interrupt number 1-32.

Convert the interrupt number to an MSI vector.

With this, the PCI endpoint kselftest test case MSI_TEST passes.

Also, set msi_capable to true, as the driver obviously supports MSI.
This helps pci_endpoint_test to use the optimal IRQ type when using
PCITEST_IRQ_TYPE_AUTO.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Note to PCI maintainers: this patch is made on top of
27fce9e8c6f0 ("PCI: endpoint: Drop superfluous pci_epc_features initialization")
which is currently queued on branch pci/endpoint.

 drivers/pci/controller/dwc/pcie-tegra194.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0e413857649fd..fe418b9bfbb4b 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1955,10 +1955,10 @@ static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
 
 static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
-	if (unlikely(irq > 31))
+	if (unlikely(irq > 32))
 		return -EINVAL;
 
-	appl_writel(pcie, BIT(irq), APPL_MSI_CTRL_1);
+	appl_writel(pcie, BIT(irq - 1), APPL_MSI_CTRL_1);
 
 	return 0;
 }
@@ -1998,6 +1998,7 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 static const struct pci_epc_features tegra_pcie_epc_features = {
 	.linkup_notifier = true,
+	.msi_capable = true,
 	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M,
 			.only_64bit = true, },
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
-- 
2.51.0


