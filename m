Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CC12CD7B7
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 14:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436768AbgLCNgJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 08:36:09 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1686 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436676AbgLCNgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 08:36:07 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc8e99e0001>; Thu, 03 Dec 2020 05:35:26 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 13:35:23 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 3 Dec 2020 13:35:20 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 3/5] PCI: tegra: Continue unconfig sequence even if parts fail
Date:   Thu, 3 Dec 2020 19:04:49 +0530
Message-ID: <20201203133451.17716-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203133451.17716-1-vidyas@nvidia.com>
References: <20201203133451.17716-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607002526; bh=uES3XIrwD3FA2DwwQr0e/GhmJLQIg4AE4uT2d2D9XMM=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=r7/XY33EYrG/A8us8UnJlSVVrPw9Oq/qF0Q2w0TLAswlVrk+H2me9KT5e6d18s37z
         EE/pD60l+aFwTtyC8QZlx138xOUD41KiWHt0tHH/jd3bmUkId3CG3zsRY3wRrrqrxt
         eG3w2ZsZvs5F94FkrjwVPhOIs6q3oKuZSAWTLYmEgb7/8x14XOmHw6D9C1+rUyKmoH
         Q6N2wiF0sH01aFgS2ZfyYQ5x5To+t5h2PVoczIAEbtxDBT9CEL5zauun6TAviUsMwh
         PiAid3xF+v4mV9r+eYX0JzGchuQsXGl097+YgP/ijXLkEMwhw3x5SJ25Ew//s4ekeP
         Ch0pYEsUBfHUg==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the driver checks for error value of different APIs during the
uninitialization sequence. It just returns from there if there is any error
observed for one of those calls. Comparatively it is better to continue the
uninitialization sequence irrespective of whether some of them are
returning error. That way, it is more closer to complete uninitialization.

Tested-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V5:
* Added Tested-by and Acked-by from Thierry Reding

V4:
* None

V3:
* Modified subject as per Bjorn's suggestion
* Removed tegra_pcie_init_controller()'s error checking part and pushed
  a separate patch for it

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 39 +++++++++-------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 59163b735c96..471c6d725c70 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1415,43 +1415,32 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 	return ret;
 }
 
-static int __deinit_controller(struct tegra_pcie_dw *pcie)
+static void tegra_pcie_unconfig_controller(struct tegra_pcie_dw *pcie)
 {
 	int ret;
 
 	ret = reset_control_assert(pcie->core_rst);
-	if (ret) {
-		dev_err(pcie->dev, "Failed to assert \"core\" reset: %d\n",
-			ret);
-		return ret;
-	}
+	if (ret)
+		dev_err(pcie->dev, "Failed to assert \"core\" reset: %d\n", ret);
 
 	tegra_pcie_disable_phy(pcie);
 
 	ret = reset_control_assert(pcie->core_apb_rst);
-	if (ret) {
+	if (ret)
 		dev_err(pcie->dev, "Failed to assert APB reset: %d\n", ret);
-		return ret;
-	}
 
 	clk_disable_unprepare(pcie->core_clk);
 
 	ret = regulator_disable(pcie->pex_ctl_supply);
-	if (ret) {
+	if (ret)
 		dev_err(pcie->dev, "Failed to disable regulator: %d\n", ret);
-		return ret;
-	}
 
 	tegra_pcie_disable_slot_regulators(pcie);
 
 	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, false);
-	if (ret) {
+	if (ret)
 		dev_err(pcie->dev, "Failed to disable controller %d: %d\n",
 			pcie->cid, ret);
-		return ret;
-	}
-
-	return ret;
 }
 
 static int tegra_pcie_init_controller(struct tegra_pcie_dw *pcie)
@@ -1475,7 +1464,8 @@ static int tegra_pcie_init_controller(struct tegra_pcie_dw *pcie)
 	return 0;
 
 fail_host_init:
-	return __deinit_controller(pcie);
+	tegra_pcie_unconfig_controller(pcie);
+	return ret;
 }
 
 static int tegra_pcie_try_link_l2(struct tegra_pcie_dw *pcie)
@@ -1544,13 +1534,12 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 	appl_writel(pcie, data, APPL_PINMUX);
 }
 
-static int tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
+static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
 {
 	tegra_pcie_downstream_dev_to_D0(pcie);
 	dw_pcie_host_deinit(&pcie->pci.pp);
 	tegra_pcie_dw_pme_turnoff(pcie);
-
-	return __deinit_controller(pcie);
+	tegra_pcie_unconfig_controller(pcie);
 }
 
 static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
@@ -2197,8 +2186,9 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 					       PORT_LOGIC_MSI_CTRL_INT_0_EN);
 	tegra_pcie_downstream_dev_to_D0(pcie);
 	tegra_pcie_dw_pme_turnoff(pcie);
+	tegra_pcie_unconfig_controller(pcie);
 
-	return __deinit_controller(pcie);
+	return 0;
 }
 
 static int tegra_pcie_dw_resume_noirq(struct device *dev)
@@ -2226,7 +2216,8 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 	return 0;
 
 fail_host_init:
-	return __deinit_controller(pcie);
+	tegra_pcie_unconfig_controller(pcie);
+	return ret;
 }
 
 static int tegra_pcie_dw_resume_early(struct device *dev)
@@ -2264,7 +2255,7 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 		disable_irq(pcie->pci.pp.msi_irq);
 
 	tegra_pcie_dw_pme_turnoff(pcie);
-	__deinit_controller(pcie);
+	tegra_pcie_unconfig_controller(pcie);
 }
 
 static const struct tegra_pcie_dw_of_data tegra_pcie_dw_rc_of_data = {
-- 
2.17.1

