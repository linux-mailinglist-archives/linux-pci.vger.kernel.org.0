Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBB31FEEF
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfEPFx1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:53:27 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14979 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPFx1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:53:27 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfad10000>; Wed, 15 May 2019 22:53:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:53:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 15 May 2019 22:53:25 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:53:24 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:53:24 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:53:21 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 03/28] PCI: tegra: Rearrange Tegra PCIe driver functions
Date:   Thu, 16 May 2019 11:22:42 +0530
Message-ID: <20190516055307.25737-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986001; bh=/lYqSZLpKWmpT99J8+K29zwvQueNTZ/YqNW3XYGRITk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=BDm3UzZ/LehfnWFS+xxZsAalomcMPBCTSOzOQpByQQ5rWQZkPdfgFM/p3DDUpBfnC
         tyZWqtcKYiB7KtlftC5+cLJ2+q50AF75uGA33SL1VW1V4Fb3I5Otb0qw88goN43LKp
         aIguJaa885Op+YE9EvaKqjP7QPocrw/WNfb7r7L/U0t5XO2QAUQ14CvWgABQd2kouS
         KUSq2LSB/1hWJuz3wL175XtjwXQj5O9AQ+jivI1q/6BpDRdkFSJyq0Emg49o9qOuNz
         Op9uByOoKL3ScjJ6OWfPVvWPvI6NmqtNFhEs87n3qCeuNSCEMf+fx8N+mkic9JQhqb
         GxnpHGsbURGJw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra PCIe has register spec for,
 - AXI to FPCI(AFI) bridge
 - Multiple PCIe root ports
 - PCIe PHY
 - PCIe pad control

Rearrange Tegra PCIe driver functions such that each function programs
required module only.
 - tegra_pcie_enable_controller(): Program AFI module and enable PCIe
controller.
 - tegra_pcie_phy_power_on(): Bring up PCIe PHY.
 - tegra_pcie_apply_pad_settings(): Program PCIe REFCLK pad settings.
 - tegra_pcie_enable_ports(): Program each root port and bring up PCIe
link.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V4: No change

V3: No change

V2: This is new patch in V2

 drivers/pci/controller/pci-tegra.c | 70 +++++++++++++-----------------
 1 file changed, 30 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 8235d937951b..bb3c0af9c830 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -852,7 +852,6 @@ static int tegra_pcie_port_phy_power_off(struct tegra_pcie_port *port)
 static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
-	const struct tegra_pcie_soc *soc = pcie->soc;
 	struct tegra_pcie_port *port;
 	int err;
 
@@ -878,12 +877,6 @@ static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
 		}
 	}
 
-	/* Configure the reference clock driver */
-	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
-
-	if (soc->num_ports > 2)
-		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
-
 	return 0;
 }
 
@@ -918,13 +911,11 @@ static int tegra_pcie_phy_power_off(struct tegra_pcie *pcie)
 	return 0;
 }
 
-static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
+static void tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	struct tegra_pcie_port *port;
 	unsigned long value;
-	int err;
 
 	/* enable PLL power down */
 	if (pcie->phy) {
@@ -958,14 +949,6 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 		afi_writel(pcie, value, AFI_FUSE);
 	}
 
-	if (soc->program_uphy) {
-		err = tegra_pcie_phy_power_on(pcie);
-		if (err < 0) {
-			dev_err(dev, "failed to power on PHY(s): %d\n", err);
-			return err;
-		}
-	}
-
 	/* take the PCIe interface module out of reset */
 	reset_control_deassert(pcie->pcie_xrst);
 
@@ -989,22 +972,6 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 
 	/* disable all exceptions */
 	afi_writel(pcie, 0, AFI_FPCI_ERROR_MASKS);
-
-	return 0;
-}
-
-static void tegra_pcie_disable_controller(struct tegra_pcie *pcie)
-{
-	int err;
-
-	reset_control_assert(pcie->pcie_xrst);
-
-	if (pcie->soc->program_uphy) {
-		err = tegra_pcie_phy_power_off(pcie);
-		if (err < 0)
-			dev_err(pcie->dev, "failed to power off PHY(s): %d\n",
-				err);
-	}
 }
 
 static void tegra_pcie_power_off(struct tegra_pcie *pcie)
@@ -1106,6 +1073,17 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 	return err;
 }
 
+static void tegra_pcie_apply_pad_settings(struct tegra_pcie *pcie)
+{
+	const struct tegra_pcie_soc *soc = pcie->soc;
+
+	/* Configure the reference clock driver */
+	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
+
+	if (soc->num_ports > 2)
+		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
+}
+
 static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -2482,16 +2460,23 @@ static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
 {
 	struct tegra_pcie *pcie = dev_get_drvdata(dev);
 	struct tegra_pcie_port *port;
+	int err;
 
 	list_for_each_entry(port, &pcie->ports, list)
 		tegra_pcie_pme_turnoff(port);
 
 	tegra_pcie_disable_ports(pcie);
 
+	if (pcie->soc->program_uphy) {
+		err = tegra_pcie_phy_power_off(pcie);
+		if (err < 0)
+			dev_err(dev, "failed to power off PHY(s): %d\n", err);
+	}
+
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_disable_msi(pcie);
 
-	tegra_pcie_disable_controller(pcie);
+	reset_control_assert(pcie->pcie_xrst);
 	tegra_pcie_power_off(pcie);
 
 	return 0;
@@ -2507,16 +2492,21 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 		dev_err(dev, "tegra pcie power on fail: %d\n", err);
 		return err;
 	}
-	err = tegra_pcie_enable_controller(pcie);
-	if (err) {
-		dev_err(dev, "tegra pcie controller enable fail: %d\n", err);
-		goto poweroff;
-	}
+	tegra_pcie_enable_controller(pcie);
 	tegra_pcie_setup_translations(pcie);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_enable_msi(pcie);
 
+	if (pcie->soc->program_uphy) {
+		err = tegra_pcie_phy_power_on(pcie);
+		if (err < 0) {
+			dev_err(dev, "failed to power on PHY(s): %d\n", err);
+			goto poweroff;
+		}
+	}
+
+	tegra_pcie_apply_pad_settings(pcie);
 	tegra_pcie_enable_ports(pcie);
 
 	return 0;
-- 
2.17.1

