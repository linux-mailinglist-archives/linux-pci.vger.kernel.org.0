Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093F429E455
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 08:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgJ2Hhl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 03:37:41 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11928 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbgJ2Hh2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 03:37:28 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9a50d70000>; Wed, 28 Oct 2020 22:19:19 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 05:19:08 +0000
Received: from vidyas-desktop.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 29 Oct 2020 05:19:04 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 4/4] PCI: tegra: Handle error conditions properly
Date:   Thu, 29 Oct 2020 10:48:39 +0530
Message-ID: <20201029051839.11245-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029051839.11245-1-vidyas@nvidia.com>
References: <20201029051839.11245-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603948759; bh=NEbt0hTlr9FUk+W+954xruMCeKF+pBJtNq7Cw6/Tdcs=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=OUkurXLEsSJsPBkN0O9M+pCVWtpG74QWrnKaq7tJXi5MyZut1qyVm6oQF+cNlZnvv
         n6xMkeSl2SNFUaF+FjMkEUthtR1Ab9wt4oaJJhdHXWfF2h7Fp4/71Tg4mrDBsz+2U2
         5ghu79vNgPFkWZbiG3LueW8AEzXVNOQqoCcjVxD3KzfW1TS0CEXqZlMXv4lACFvw5O
         rL3yep6avF8FkHV3va6uUJzK44FikyUm6j3wKMhREq1JCM6cGk9CC5pnMy/vS2MAF8
         M3WH/bHgfsEcIQauwD3YUI1+k7TDgTWwIxioeQgsr3WpT0wtKpMs+vX5m04Q3dFzaG
         Zfg48w3LJYX0Q==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the driver checks for error value of different APIs during the
uninitialization sequence. It just returns from there if there is any error
observed for one of those calls. Comparatively it is better to continue the
uninitialization sequence irrespective of whether some of them are
returning error. That way, it is more closer to complete uninitialization.
It also adds checking return value for error for a cleaner exit path.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 45 ++++++++++------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 253d91033bc3..8c08998b9ce1 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1422,43 +1422,32 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
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
@@ -1482,7 +1471,8 @@ static int tegra_pcie_init_controller(struct tegra_pcie_dw *pcie)
 	return 0;
 
 fail_host_init:
-	return __deinit_controller(pcie);
+	tegra_pcie_unconfig_controller(pcie);
+	return ret;
 }
 
 static int tegra_pcie_try_link_l2(struct tegra_pcie_dw *pcie)
@@ -1551,13 +1541,12 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
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
@@ -1590,7 +1579,11 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 		goto fail_pm_get_sync;
 	}
 
-	tegra_pcie_init_controller(pcie);
+	ret = tegra_pcie_init_controller(pcie);
+	if (ret < 0) {
+		dev_err(dev, "Failed to initialize controller: %d\n", ret);
+		goto fail_pm_get_sync;
+	}
 
 	pcie->link_state = tegra_pcie_dw_link_up(&pcie->pci);
 	if (!pcie->link_state) {
@@ -2238,8 +2231,9 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 					       PORT_LOGIC_MSI_CTRL_INT_0_EN);
 	tegra_pcie_downstream_dev_to_D0(pcie);
 	tegra_pcie_dw_pme_turnoff(pcie);
+	tegra_pcie_unconfig_controller(pcie);
 
-	return __deinit_controller(pcie);
+	return 0;
 }
 
 static int tegra_pcie_dw_resume_noirq(struct device *dev)
@@ -2267,7 +2261,8 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 	return 0;
 
 fail_host_init:
-	return __deinit_controller(pcie);
+	tegra_pcie_unconfig_controller(pcie);
+	return ret;
 }
 
 static int tegra_pcie_dw_resume_early(struct device *dev)
@@ -2305,7 +2300,7 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 		disable_irq(pcie->pci.pp.msi_irq);
 
 	tegra_pcie_dw_pme_turnoff(pcie);
-	__deinit_controller(pcie);
+	tegra_pcie_unconfig_controller(pcie);
 }
 
 static const struct tegra_pcie_dw_of_data tegra_pcie_dw_rc_of_data = {
-- 
2.17.1

