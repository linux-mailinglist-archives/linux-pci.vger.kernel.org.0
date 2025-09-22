Return-Path: <linux-pci+bounces-36676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95FEB91987
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 16:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EDA190193A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F331C19AD8B;
	Mon, 22 Sep 2025 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giZt3pqm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DAB1957FC;
	Mon, 22 Sep 2025 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550148; cv=none; b=ceNIPnB7uVvqk+8iYRIbemP43LkUQDO9rg2B5thmY3CVmsvfPwhp4maxU2xgQXRCPQf9KnzbLILGTRqC+NfrFVUb6wCOv22q5mcV1yY7STgdv2dgsPjDJWnyOnAWbZKDJOMiCoPwEqgERpL+clSNXXcPzfX22LYRFxVnk68CCSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550148; c=relaxed/simple;
	bh=XPokvl0rX7B5xeL1hJsNi035/3mVkbm8hvJVhqmk+EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlxEH1BlyJcQ7kFgHpjRNczZJoaKorkpfyNr8JnODT2P6TtzKqRPe8XVXVL4E51BmxaNMoFyUKEY8Yj1vROjn3tgZqJx1mx6QR27E2zUjwzqMBrCmFNCgqcUmlLf8jRtPdfq6Ur8HJED7nr0NNUjkZx7SjkZub3+I+Bheyi3GpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giZt3pqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFE5C4CEF0;
	Mon, 22 Sep 2025 14:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758550148;
	bh=XPokvl0rX7B5xeL1hJsNi035/3mVkbm8hvJVhqmk+EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=giZt3pqm+etsmnNGUP8PaSlj/3RBqSE4q5nF1GGCl3yUwPnuxGaprI3q9x7s4bGWa
	 2GvtBPvKglj1zR5zo5855mOJis5A/5Bn8+8xEx3qmkgTa1Gb6ne3sWpydkCOE7q882
	 isu5XG9fSV/3KAJd9cR/rQLgqscZs7IjpW3tML9fp824snkF9YsLjzfdqhUESbVCk3
	 K8jvRxwzxCkQivLDyUqD99E4ZHRX6zOAlnAC9F/NiEj/ymtRaB3ZZ3r6zQIutnhKD+
	 bvN5MbRDMgNGqPD9N4GJuGVvzLZnglppl+uPWSIx8e4hK5Dy2sLMdVab7sxqB94MZl
	 xilct3M74aNuw==
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
Subject: [PATCH v2 1/3] PCI: tegra194: Fix broken tegra_pcie_ep_raise_msi_irq()
Date: Mon, 22 Sep 2025 16:08:24 +0200
Message-ID: <20250922140822.519796-6-cassel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922140822.519796-5-cassel@kernel.org>
References: <20250922140822.519796-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738; i=cassel@kernel.org; h=from:subject; bh=XPokvl0rX7B5xeL1hJsNi035/3mVkbm8hvJVhqmk+EU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIuRsTZJj+9cuG1AJeYpevTM9/vaIveXHBX84OPbnmix 44Tc4sUO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjARExlGhh2cO7w7DT2vP4lq f55xIqN1gf+JdKXkS6k3r1otaYhW3sjIsOnV9OOJk8+I7WD5pCLeyidweznj29pXdr3eD03jwq7 84wYA
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

Cc: stable@vger.kernel.org
Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 7c295ec6f0f16..63d310e5335f4 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1969,10 +1969,10 @@ static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
 
 static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
-	if (unlikely(irq > 31))
+	if (unlikely(irq > 32))
 		return -EINVAL;
 
-	appl_writel(pcie, BIT(irq), APPL_MSI_CTRL_1);
+	appl_writel(pcie, BIT(irq - 1), APPL_MSI_CTRL_1);
 
 	return 0;
 }
@@ -2012,6 +2012,7 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 static const struct pci_epc_features tegra_pcie_epc_features = {
 	.linkup_notifier = true,
+	.msi_capable = true,
 	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M,
 			.only_64bit = true, },
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
-- 
2.51.0


