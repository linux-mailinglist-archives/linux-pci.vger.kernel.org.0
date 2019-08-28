Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE8AA086F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 19:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfH1R31 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 13:29:27 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2820 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1R30 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 13:29:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d66b9f60000>; Wed, 28 Aug 2019 10:29:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 28 Aug 2019 10:29:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 28 Aug 2019 10:29:24 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 17:29:24 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 17:29:24 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 28 Aug 2019 17:29:23 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d66b9ef0000>; Wed, 28 Aug 2019 10:29:23 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3 4/6] PCI: tegra: Add support to enable slot regulators
Date:   Wed, 28 Aug 2019 22:58:48 +0530
Message-ID: <20190828172850.19871-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828172850.19871-1-vidyas@nvidia.com>
References: <20190828172850.19871-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567013366; bh=WIISi0TM28m6XZNh/d7HrZznz6izsY7QLcb0ruI4yOg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=PM/tDLJzcXZP8uVrEVv3DXViOE4GahlBpPbzAOEjE+1dMQ+WGBCY1yB9flCARHM7Q
         MVjTnu2QRcx+LdJOn7RtNzAwyELFMNZadCqdu95ZOuleAFlvy6t0DjE0oqLug+pe1U
         3P0eg0ytdWPQZ3dH6Y73rHPx3bUweETnqGUlExIsVo5jTS9QRA61hX8fi9853tYyMg
         TsDXx+kLzePReAZDRFbWr7sbvRhZnmGEanEjJAsg957T5yE//2jWTEhTVKtI8ToreW
         Cpz20CFqK129ELjXlO38j5ULKmweLtJKY8CrXLVB36iFzWIPFLQcLEi4eEXt0W2a/A
         RdiAE635U+Frw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to get regulator information of 3.3V and 12V supplies of a PCIe
slot from the respective controller's device-tree node and enable those
supplies. This is required in platforms like p2972-0000 where the supplies
to x16 slot owned by C5 controller need to be enabled before attempting to
enumerate the devices.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* Added a dev_err() print for failure case of tegra_pcie_get_slot_regulators() API
* Modified to make 100ms sleep valid only if at least one of the regulator handles exist

V2:
* Addressed review comments from Thierry Reding and Andrew Murray
* Handled failure case of devm_regulator_get_optional() for -ENODEV cleanly

 drivers/pci/controller/dwc/pcie-tegra194.c | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 77fa6f70bc96..18453cc5e7e4 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -278,6 +278,8 @@ struct tegra_pcie_dw {
 	u32 aspm_l0s_enter_lat;
 
 	struct regulator *pex_ctl_supply;
+	struct regulator *slot_ctl_3v3;
+	struct regulator *slot_ctl_12v;
 
 	unsigned int phy_count;
 	struct phy **phys;
@@ -1047,6 +1049,73 @@ static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
 	}
 }
 
+static int tegra_pcie_get_slot_regulators(struct tegra_pcie_dw *pcie)
+{
+	pcie->slot_ctl_3v3 = devm_regulator_get_optional(pcie->dev, "vpcie3v3");
+	if (IS_ERR(pcie->slot_ctl_3v3)) {
+		if (PTR_ERR(pcie->slot_ctl_3v3) != -ENODEV)
+			return PTR_ERR(pcie->slot_ctl_3v3);
+
+		pcie->slot_ctl_3v3 = NULL;
+	}
+
+	pcie->slot_ctl_12v = devm_regulator_get_optional(pcie->dev, "vpcie12v");
+	if (IS_ERR(pcie->slot_ctl_12v)) {
+		if (PTR_ERR(pcie->slot_ctl_12v) != -ENODEV)
+			return PTR_ERR(pcie->slot_ctl_12v);
+
+		pcie->slot_ctl_12v = NULL;
+	}
+
+	return 0;
+}
+
+static int tegra_pcie_enable_slot_regulators(struct tegra_pcie_dw *pcie)
+{
+	int ret;
+
+	if (pcie->slot_ctl_3v3) {
+		ret = regulator_enable(pcie->slot_ctl_3v3);
+		if (ret < 0) {
+			dev_err(pcie->dev,
+				"Failed to enable 3.3V slot supply: %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (pcie->slot_ctl_12v) {
+		ret = regulator_enable(pcie->slot_ctl_12v);
+		if (ret < 0) {
+			dev_err(pcie->dev,
+				"Failed to enable 12V slot supply: %d\n", ret);
+			goto fail_12v_enable;
+		}
+	}
+
+	/*
+	 * According to PCI Express Card Electromechanical Specification
+	 * Revision 1.1, Table-2.4, T_PVPERL (Power stable to PERST# inactive)
+	 * should be a minimum of 100ms.
+	 */
+	if (pcie->slot_ctl_3v3 || pcie->slot_ctl_12v)
+		msleep(100);
+
+	return 0;
+
+fail_12v_enable:
+	if (pcie->slot_ctl_3v3)
+		regulator_disable(pcie->slot_ctl_3v3);
+	return ret;
+}
+
+static void tegra_pcie_disable_slot_regulators(struct tegra_pcie_dw *pcie)
+{
+	if (pcie->slot_ctl_12v)
+		regulator_disable(pcie->slot_ctl_12v);
+	if (pcie->slot_ctl_3v3)
+		regulator_disable(pcie->slot_ctl_3v3);
+}
+
 static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 					bool en_hw_hot_rst)
 {
@@ -1060,6 +1129,10 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 		return ret;
 	}
 
+	ret = tegra_pcie_enable_slot_regulators(pcie);
+	if (ret < 0)
+		goto fail_slot_reg_en;
+
 	ret = regulator_enable(pcie->pex_ctl_supply);
 	if (ret < 0) {
 		dev_err(pcie->dev, "Failed to enable regulator: %d\n", ret);
@@ -1142,6 +1215,8 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 fail_core_clk:
 	regulator_disable(pcie->pex_ctl_supply);
 fail_reg_en:
+	tegra_pcie_disable_slot_regulators(pcie);
+fail_slot_reg_en:
 	tegra_pcie_bpmp_set_ctrl_state(pcie, false);
 
 	return ret;
@@ -1174,6 +1249,8 @@ static int __deinit_controller(struct tegra_pcie_dw *pcie)
 		return ret;
 	}
 
+	tegra_pcie_disable_slot_regulators(pcie);
+
 	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, false);
 	if (ret) {
 		dev_err(pcie->dev, "Failed to disable controller %d: %d\n",
@@ -1373,6 +1450,12 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = tegra_pcie_get_slot_regulators(pcie);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get slot regulators: %d\n", ret);
+		return ret;
+	}
+
 	pcie->pex_ctl_supply = devm_regulator_get(dev, "vddio-pex-ctl");
 	if (IS_ERR(pcie->pex_ctl_supply)) {
 		dev_err(dev, "Failed to get regulator: %ld\n",
-- 
2.17.1

