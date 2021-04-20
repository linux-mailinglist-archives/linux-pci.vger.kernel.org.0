Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C59436597B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 15:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhDTNGH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 09:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhDTNGF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 09:06:05 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68D7C613B4;
        Tue, 20 Apr 2021 13:05:31 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lYq4H-008Ugk-7V; Tue, 20 Apr 2021 14:05:29 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     kernel-team@android.com, Jon Hunter <jonathanh@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] PCI: tegra: Restore MSI enable state on resume
Date:   Tue, 20 Apr 2021 14:05:26 +0100
Message-Id: <20210420130526.531138-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, kernel-team@android.com, jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com, thierry.reding@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When going into suspend, the Tegra MSI controller loses its
state. Restore the MSI allocation on resume so that PCI devices
are usable again.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 973a28677e39 ("PCI: tegra: Convert to MSI domains")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pci/controller/pci-tegra.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index eaba7b2fab4a..507b23d43ad1 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1802,13 +1802,19 @@ static void tegra_pcie_enable_msi(struct tegra_pcie *pcie)
 {
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	struct tegra_msi *msi = &pcie->msi;
-	u32 reg;
+	u32 reg, msi_state[INT_PCI_MSI_NR / 32];
+	int i;
 
 	afi_writel(pcie, msi->phys >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_ST);
 	afi_writel(pcie, msi->phys, AFI_MSI_AXI_BAR_ST);
 	/* this register is in 4K increments */
 	afi_writel(pcie, 1, AFI_MSI_BAR_SZ);
 
+	/* Restore the MSI allocation state */
+	bitmap_to_arr32(msi_state, msi->used, INT_PCI_MSI_NR);
+	for (i = 0; i < ARRAY_SIZE(msi_state); i++)
+		afi_writel(pcie, msi_state[i], AFI_MSI_EN_VEC(i));
+
 	/* and unmask the MSI interrupt */
 	reg = afi_readl(pcie, AFI_INTR_MASK);
 	reg |= AFI_INTR_MASK_MSI_MASK;
-- 
2.30.2

