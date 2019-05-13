Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B871BCB0
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 20:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbfEMSI1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 14:08:27 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3118 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732266AbfEMSI0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 14:08:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd9b2710001>; Mon, 13 May 2019 11:07:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 11:08:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 11:08:24 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:08:24 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:08:21 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 18:08:17 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 05/29] PCI: tegra: Fix PCIe host power up sequence
Date:   Mon, 13 May 2019 23:37:20 +0530
Message-ID: <20190513180744.16493-6-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513180744.16493-1-mmaddireddy@nvidia.com>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557770865; bh=etT8bWR/8xMB8tWmcBbl7+inKaLhqn+9L1uU2dhkoQs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=WPkvn3RvWYTVYP3pTUTdqXu73Yg/YI1DIl6VMOOBqS1kt69YFyE7RL2bYCyJTWY5g
         OS6I4NpedTP6nX0/R4hjYTwSS7TLCnlCuifPkh7LcghZHr6EUhnpXXsejAkFghManW
         4wusUyhovua11Uz9wCBteCS3M77TBeSv0rp+h1Up+VEoIU/GsukuFUwTMsNp3NGkhm
         Lh3kmhe9MeX/VqPJkmWjYUiOzN1boaRMYqhu92YsEQSgRv7m1U9J7J3vURONfkeqOP
         tAlPrttbpPo7pyo0b3YcFFXQzV9x3D0vD9Q3JuWYliTyKqJweLI+IDVq9keBs/sWUU
         Asz8lrr91R4tg==
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
V3: No change

V2: Error cleanup changes are moved to new patch and only sequence
correction is done in this patch.

 drivers/pci/controller/pci-tegra.c | 52 +++++++++++++++++-------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index d0e517f084a1..015add4e345b 100644
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
@@ -2487,10 +2482,12 @@ static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
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
@@ -2512,11 +2509,19 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
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
 
@@ -2525,6 +2530,9 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 
 	return 0;
 
+disable_pex_clk:
+	reset_control_assert(pcie->pex_rst);
+	clk_disable_unprepare(pcie->pex_clk);
 poweroff:
 	tegra_pcie_power_off(pcie);
 
-- 
2.17.1

