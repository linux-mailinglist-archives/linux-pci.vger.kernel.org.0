Return-Path: <linux-pci+bounces-97-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 300787F3DDF
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604851C20E1D
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B83A156F9;
	Wed, 22 Nov 2023 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAfG71Tu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50FC12B96
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6070CC433D9;
	Wed, 22 Nov 2023 06:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700633069;
	bh=tTezMQnyXLUyxAhUN0kIUOQvd0IFmjZZyhxDAvlKtNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAfG71Tu07fE066WB4tiW/O9+TFRwGnmtfFq/R3DCisw/EdJsdGOPlC2uW9UBJp1U
	 bjc7z3Vne91EEJ+qs8GHIOnThMFvM7ZmOvbKOg9+UF1HNcL1PQ+NMh7uND73f08yyw
	 YnfxvPrYtPf8qlcfFhlmcn6fXDrv4XFVsfPMs1E+AZHo+QLylsQEukBrdDGKlL1U6l
	 3iMQzVd/eROGS7Fb+yNfeawrYZn80y5CZOP3WJI64Qy7136mLKHcViSO0S19+rb4Wf
	 IiaVzZbImxfNaFH5VLYs3tmjOCqU5Nu5wfg8LmdZcLfNMw/V0Ru7r6CFCrY27ujLVB
	 ba1k4HbL38vbg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 12/16] PCI: tegra194: Use INTX instead of legacy
Date: Wed, 22 Nov 2023 15:04:02 +0900
Message-ID: <20231122060406.14695-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122060406.14695-1-dlemoal@kernel.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the Designware tegra194 controller driver, change all names using
"legacy" to use "intx", to match the term used in the PCI
specifications.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index a1f37d2d7798..e02dcbcb5970 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -773,13 +773,13 @@ static void tegra_pcie_enable_system_interrupts(struct dw_pcie_rp *pp)
 			   val_w);
 }
 
-static void tegra_pcie_enable_legacy_interrupts(struct dw_pcie_rp *pp)
+static void tegra_pcie_enable_intx_interrupts(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val;
 
-	/* Enable legacy interrupt generation */
+	/* Enable INTX interrupt generation */
 	val = appl_readl(pcie, APPL_INTR_EN_L0_0);
 	val |= APPL_INTR_EN_L0_0_SYS_INTR_EN;
 	val |= APPL_INTR_EN_L0_0_INT_INT_EN;
@@ -830,7 +830,7 @@ static void tegra_pcie_enable_interrupts(struct dw_pcie_rp *pp)
 	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_17);
 
 	tegra_pcie_enable_system_interrupts(pp);
-	tegra_pcie_enable_legacy_interrupts(pp);
+	tegra_pcie_enable_intx_interrupts(pp);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_enable_msi_interrupts(pp);
 }
@@ -1947,7 +1947,7 @@ static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int tegra_pcie_ep_raise_legacy_irq(struct tegra_pcie_dw *pcie, u16 irq)
+static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
 	/* Tegra194 supports only INTA */
 	if (irq > 1)
@@ -1986,7 +1986,7 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	switch (type) {
 	case PCI_IRQ_INTX:
-		return tegra_pcie_ep_raise_legacy_irq(pcie, interrupt_num);
+		return tegra_pcie_ep_raise_intx_irq(pcie, interrupt_num);
 
 	case PCI_IRQ_MSI:
 		return tegra_pcie_ep_raise_msi_irq(pcie, interrupt_num);
-- 
2.42.0


