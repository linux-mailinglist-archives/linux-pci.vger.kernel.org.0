Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E29248A63
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfFQRkR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:40:17 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11866 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbfFQRkR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 13:40:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d07d0800000>; Mon, 17 Jun 2019 10:40:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 10:40:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Jun 2019 10:40:16 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:40:15 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:40:15 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Jun 2019 17:40:12 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 05/27] PCI: tegra: Fix PCIe host power up sequence
Date:   Mon, 17 Jun 2019 23:09:30 +0530
Message-ID: <20190617173952.29363-6-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617173952.29363-1-mmaddireddy@nvidia.com>
References: <20190617173952.29363-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560793216; bh=J99oOn2yhWDUdF+usw5wr2Vix4nQuTb2w5jMlI/57jI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=fJ06Kzxv03VGS7EEbT7ReNN4BlMr+hQPrxenPxk+GkxCLscEGmBAnDY1GwYQSw7G3
         +46uVOet1d/W8cx84VSIeuDt75WVhUqGN7PXM999AYbMstUzr2VIlpKZ+i8K0pn0wD
         fpKpDpga/tmAwFz2s7Y8No3vGIaOhe3lydXauZqEETWuRDycOOXuO0a3QgduLVrt2i
         zYvJjeYqGnlPaZI+8xKBmY6CBNj70NESTxNX9r0iIlGUmWsH6ZOIyhrWFpEFkCzNOC
         WjzgckXqCp/DI0/kUjyvmyqjinafmB2vOQ+IIeVUcDcTAammf78FvJ/aM08k+3FKzi
         MRN0xwCnSnBOA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe host power up sequence involves programming AFI(AXI to FPCI bridge)
registers first and then PCIe registers. Otherwise AFI register settings
may not latch to PCIe IP.

PCIe root port starts LTSSM as soon as PCIe xrst is deasserted.
So deassert PCIe xrst after programming PCIe registers.

Modify PCIe power up sequence as follows,
 - Power ungate PCIe partition
 - Enable AFI clock
 - Deassert AFI reset
 - Program AFI registers
 - Enable PCIe clock
 - Deassert PCIe reset
 - Program PCIe PHY
 - Program PCIe pad control registers
 - Program PCIe root port registers
 - Deassert PCIe xrst to start LTSSM

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V5: No change

V4: No change

V3: No change

V2: Error cleanup changes are moved to new patch and only sequence
correction is done in this patch.

 drivers/pci/controller/pci-tegra.c | 52 +++++++++++++++++-------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 0453bfb2726e..5e9fcef5f8eb 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -949,9 +949,6 @@ static void tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 		afi_writel(pcie, value, AFI_FUSE);
 	}
 
-	/* take the PCIe interface module out of reset */
-	reset_control_deassert(pcie->pcie_xrst);
-
 	/* finally enable PCIe */
 	value = afi_readl(pcie, AFI_CONFIGURATION);
 	value |= AFI_CONFIGURATION_EN_FPCI;
@@ -981,13 +978,11 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 	int err;
 
 	reset_control_assert(pcie->afi_rst);
-	reset_control_assert(pcie->pex_rst);
 
 	clk_disable_unprepare(pcie->pll_e);
 	if (soc->has_cml_clk)
 		clk_disable_unprepare(pcie->cml_clk);
 	clk_disable_unprepare(pcie->afi_clk);
-	clk_disable_unprepare(pcie->pex_clk);
 
 	if (!dev->pm_domain)
 		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
@@ -1015,25 +1010,19 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 	if (err < 0)
 		dev_err(dev, "failed to enable regulators: %d\n", err);
 
-	if (dev->pm_domain) {
-		err = clk_prepare_enable(pcie->pex_clk);
+	if (!dev->pm_domain) {
+		err = tegra_powergate_power_on(TEGRA_POWERGATE_PCIE);
 		if (err) {
-			dev_err(dev, "failed to enable PEX clock: %d\n", err);
+			dev_err(dev, "failed to power ungate: %d\n", err);
 			goto regulator_disable;
 		}
-		reset_control_deassert(pcie->pex_rst);
-	} else {
-		err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_PCIE,
-							pcie->pex_clk,
-							pcie->pex_rst);
+		err = tegra_powergate_remove_clamping(TEGRA_POWERGATE_PCIE);
 		if (err) {
-			dev_err(dev, "powerup sequence failed: %d\n", err);
-			goto regulator_disable;
+			dev_err(dev, "failed to remove clamp: %d\n", err);
+			goto powergate;
 		}
 	}
 
-	reset_control_deassert(pcie->afi_rst);
-
 	err = clk_prepare_enable(pcie->afi_clk);
 	if (err < 0) {
 		dev_err(dev, "failed to enable AFI clock: %d\n", err);
@@ -1054,6 +1043,8 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 		goto disable_cml_clk;
 	}
 
+	reset_control_deassert(pcie->afi_rst);
+
 	return 0;
 
 disable_cml_clk:
@@ -1062,9 +1053,6 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 disable_afi_clk:
 	clk_disable_unprepare(pcie->afi_clk);
 powergate:
-	reset_control_assert(pcie->afi_rst);
-	reset_control_assert(pcie->pex_rst);
-	clk_disable_unprepare(pcie->pex_clk);
 	if (!dev->pm_domain)
 		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
 regulator_disable:
@@ -2111,7 +2099,12 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
 			 port->index, port->lanes);
 
 		tegra_pcie_port_enable(port);
+	}
 
+	/* Start LTSSM from Tegra side */
+	reset_control_deassert(pcie->pcie_xrst);
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
 		if (tegra_pcie_port_check_link(port))
 			continue;
 
@@ -2126,6 +2119,8 @@ static void tegra_pcie_disable_ports(struct tegra_pcie *pcie)
 {
 	struct tegra_pcie_port *port, *tmp;
 
+	reset_control_assert(pcie->pcie_xrst);
+
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
 		tegra_pcie_port_disable(port);
 }
@@ -2488,10 +2483,12 @@ static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
 			dev_err(dev, "failed to power off PHY(s): %d\n", err);
 	}
 
+	reset_control_assert(pcie->pex_rst);
+	clk_disable_unprepare(pcie->pex_clk);
+
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_disable_msi(pcie);
 
-	reset_control_assert(pcie->pcie_xrst);
 	tegra_pcie_power_off(pcie);
 
 	return 0;
@@ -2513,11 +2510,19 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_enable_msi(pcie);
 
+	err = clk_prepare_enable(pcie->pex_clk);
+	if (err) {
+		dev_err(dev, "failed to enable PEX clock: %d\n", err);
+		goto poweroff;
+	}
+
+	reset_control_deassert(pcie->pex_rst);
+
 	if (pcie->soc->program_uphy) {
 		err = tegra_pcie_phy_power_on(pcie);
 		if (err < 0) {
 			dev_err(dev, "failed to power on PHY(s): %d\n", err);
-			goto poweroff;
+			goto disable_pex_clk;
 		}
 	}
 
@@ -2526,6 +2531,9 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 
 	return 0;
 
+disable_pex_clk:
+	reset_control_assert(pcie->pex_rst);
+	clk_disable_unprepare(pcie->pex_clk);
 poweroff:
 	tegra_pcie_power_off(pcie);
 
-- 
2.17.1

