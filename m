Return-Path: <linux-pci+bounces-36677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E351FB91981
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 16:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAE4425230
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 14:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0064219F111;
	Mon, 22 Sep 2025 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSEMSSml"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362310F1;
	Mon, 22 Sep 2025 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550152; cv=none; b=agXIl6zwMblsCIamrDyUhFj1kDckkub8FgrcfELdV/GscS5y3UcrgoStKFkDAs2TAllw1u1YHebOeg9AH82X+K1hUhWkfkdltsfeGleTySOJDTqwfwuKnTIptqq1jFx98Ic7BswFaw/PZvcdsblDtahyKQilYM2dfuBPoU/DSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550152; c=relaxed/simple;
	bh=4M9LLrRqO8uLW1VI4POLcnk+eKzxPkR/nl5/vtK8sOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWbEB9NcCDDni0VPc7RTq6+ZxmuaAOMn8e6fxOAVjHiw9KiwBheGbmKnmIhn+GGoZV7PZ7j8OGLm4FyVI/2FbmCWRjLioNis7uew9NicyPF21ANvyysCXN3H+bY1jG+FEankVtT/8aSjg3Aw6MQ44oT0NKCrER46V1C3jB17XG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSEMSSml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2DBC4CEF0;
	Mon, 22 Sep 2025 14:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758550152;
	bh=4M9LLrRqO8uLW1VI4POLcnk+eKzxPkR/nl5/vtK8sOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSEMSSml3H0XqR740SQMhUyWdok8LD672ySmcHi2NVNycGTCwm2Fy3/ZZuEfLlbMB
	 Dzi07jWzqmnMYuCst2Z6pHejcBSBEZwUbTon6sGf4sSX8m6j2yykzhyn3htf9dTjih
	 HKqn36CZcwL2ohPfAmsZU4nufwVnLO6HaQK6Kk5YVnfgKbp/YFu6w85igHLsQFGBNb
	 3TAfU+MjS2zdCzx+h82ML5ll3T3tRR6+LWnPni/FNFJ2SZ5fg8ASUW0dKGbWwo1s5j
	 pCxh2CEdRVveL7BvIqx5m7n5rIvFPn1rvrvjj77Bs6E9hOFBOcdkwVyH1kN0CzZIt4
	 oYHpwANbRG1OA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 2/3] PCI: tegra194: Reset BARs when running in PCIe endpoint mode
Date: Mon, 22 Sep 2025 16:08:25 +0200
Message-ID: <20250922140822.519796-7-cassel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922140822.519796-5-cassel@kernel.org>
References: <20250922140822.519796-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2484; i=cassel@kernel.org; h=from:subject; bh=4M9LLrRqO8uLW1VI4POLcnk+eKzxPkR/nl5/vtK8sOQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIuRsS985WN9cj34LyXt/lNjdcipxZj78A//6ZH2bTG6 q9fJfm/o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABOZEMbIsDHaeLKZXE3zusS3 Kvt/ihU4zeN6wfYsw4U5eIJ+C9tHC4b/LssZ7sdwhUvZ2v60eP3GoP92zxvf17U+1Z8WprWFll7 lBgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Tegra already defines all BARs expect for BAR0 as BAR_RESERVED.
This is sufficient for pci-epf-test to not allocate backing memory and to
not call set_bar() for those BARs. However, marking a BAR as BAR_RESERVED
does not mean that the BAR get disabled.

The host side driver, pci_endpoint_test, simply does an ioremap for all
enabled BARs, and will run tests against all enabled BARs. (I.e. it will
run tests also against the BARs marked as BAR_RESERVED.)

After running the BARs tests (which will write to all enabled BARs), the
inbound address translation is broken.
This is because the tegra controller exposes the ATU Port Logic Structure
in BAR4. So when BAR4 is written, the inbound address translation settings
get overwritten.

To avoid this, implement the dw_pcie_ep_ops .init() callback and start off
by disabling all BARs (pci-epf-test will later enable/configure BARs that
are not defined as BAR_RESERVED).

This matches the behavior of other PCIe endpoint drivers:
dra7xx, imx6, layerscape-ep, artpec6, dw-rockchip, qcom-ep, rcar-gen4, and
uniphier-ep.

With this, the PCI endpoint kselftest test case CONSECUTIVE_BAR_TEST
(which was specifically made to detect address translation issues) passes.

Cc: stable@vger.kernel.org
Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 63d310e5335f4..7eb48cc13648e 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1955,6 +1955,15 @@ static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void tegra_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
+};
+
 static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
 	/* Tegra194 supports only INTA */
@@ -2030,6 +2039,7 @@ tegra_pcie_ep_get_features(struct dw_pcie_ep *ep)
 }
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
+	.init = tegra_pcie_ep_init,
 	.raise_irq = tegra_pcie_ep_raise_irq,
 	.get_features = tegra_pcie_ep_get_features,
 };
-- 
2.51.0


