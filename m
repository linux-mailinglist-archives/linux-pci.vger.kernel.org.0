Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D493D2A5FF3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 09:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgKDIwi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 03:52:38 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6022 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbgKDIwh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 03:52:37 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa26bd40000>; Wed, 04 Nov 2020 00:52:36 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 08:52:36 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Nov 2020 08:52:32 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3 4/5] PCI: tegra: Continue unconfig sequence even if parts fail
Date:   Wed, 4 Nov 2020 14:20:17 +0530
Message-ID: <20201104085018.13021-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104085018.13021-1-vidyas@nvidia.com>
References: <20201104085018.13021-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604479956; bh=NTU9fqj88EFlCQxwql10C8vOX1XMlMilgH1XPS4W2nA=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=TgqudBjDRvToLkVVuuS9hsuTrRZqka4zOE5gdItbk6bSrwALi5PWL1+YBDdG9SBdk
         1IuOaNJ1+QjsHhWsxQreEXV8QdrfZk8YQW5+DAg/JNYh1LQmruI6lx2CTe1LSNTfHo
         +0WADPijaPEbtnnX8W6NIxicNH4ortTdSaSAf3pPfPUUPpADTCDqe6dccThDN6A9iU
         aheTpGztR5p4w3wxtvytlWb4B4V3ILoIOGTgPtxOCUTWn7VYLE6URaWS6VyajhfqCN
         2nlkXS9xJNXXb1OsfhEwcObh25ndwKgQTl+vpmHO6blQKxxHFJaW5UMehf70p9cpIN
         l7XHiLpyGszUQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the driver checks for error value of different APIs during the
uninitialization sequence. It just returns from there if there is any error
observed for one of those calls. Comparatively it is better to continue the
uninitialization sequence irrespective of whether some of them are
returning error. That way, it is more closer to complete uninitialization.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* Modified subject as per Bjorn's suggestion
* Removed tegra_pcie_init_controller()'s error checking part and pushed
  a separate patch for it

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 39 +++++++++-------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 253d91033bc3..9be10c8953df 100644
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
@@ -2238,8 +2227,9 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 					       PORT_LOGIC_MSI_CTRL_INT_0_EN);
 	tegra_pcie_downstream_dev_to_D0(pcie);
 	tegra_pcie_dw_pme_turnoff(pcie);
+	tegra_pcie_unconfig_controller(pcie);
 
-	return __deinit_controller(pcie);
+	return 0;
 }
 
 static int tegra_pcie_dw_resume_noirq(struct device *dev)
@@ -2267,7 +2257,8 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 	return 0;
 
 fail_host_init:
-	return __deinit_controller(pcie);
+	tegra_pcie_unconfig_controller(pcie);
+	return ret;
 }
 
 static int tegra_pcie_dw_resume_early(struct device *dev)
@@ -2305,7 +2296,7 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 		disable_irq(pcie->pci.pp.msi_irq);
 
 	tegra_pcie_dw_pme_turnoff(pcie);
-	__deinit_controller(pcie);
+	tegra_pcie_unconfig_controller(pcie);
 }
 
 static const struct tegra_pcie_dw_of_data tegra_pcie_dw_rc_of_data = {
-- 
2.17.1

