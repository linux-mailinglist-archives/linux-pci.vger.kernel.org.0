Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02A27A02ED
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 15:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfH1NPu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 09:15:50 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2041 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfH1NPt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 09:15:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d667e840000>; Wed, 28 Aug 2019 06:15:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 28 Aug 2019 06:15:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 28 Aug 2019 06:15:47 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 13:15:47 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 13:15:47 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 28 Aug 2019 13:15:47 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d667e7e0000>; Wed, 28 Aug 2019 06:15:46 -0700
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
Subject: [PATCH V2 4/6] PCI: tegra: Add support to enable slot regulators
Date:   Wed, 28 Aug 2019 18:45:03 +0530
Message-ID: <20190828131505.28475-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828131505.28475-1-vidyas@nvidia.com>
References: <20190828131505.28475-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566998148; bh=d5gn4lsVkZC/j3+ttZyQdtxWKvd3aTBDeJAebrNCxtc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=G2VVp0FEcc25WRQ5u5zNmk2+BHU0DkzWxCIv8sabY1WEQ6tmN8U0QVUl4PUCG9/F7
         2e8Urw7hC22UqOAyL2zNaUVRedwaO+JkXclPXqA/uGZP5JFsJF1izyR+9sVwqF4aM3
         /09GfVwA0jP9D4KF9cei3gcv7rpw6lfPvNA/yrRwdZ5LbRT0oOvovbJnm19nOzV35A
         iaviN6N3kFG542p/HhAXlX+68FFQF/QkrVJo0Cxhl9E8tQYP+oYxH6KPlsjcj18iIa
         qgEKIYVDbmNy3gj8N5aYxRvVcrY9lmmeF6hqU2xzydXVpSd3KhqRzSz4eYKfK6EuRt
         pU0CjyNduCkYg==
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
V2:
* Addressed review comments from Thierry Reding and Andrew Murray
* Handled failure case of devm_regulator_get_optional() for -ENODEV cleanly

 drivers/pci/controller/dwc/pcie-tegra194.c | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 057ba4f9fbcd..6a66101ec83d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -278,6 +278,8 @@ struct tegra_pcie_dw {
 	u32 aspm_l0s_enter_lat;
 
 	struct regulator *pex_ctl_supply;
+	struct regulator *slot_ctl_3v3;
+	struct regulator *slot_ctl_12v;
 
 	unsigned int phy_count;
 	struct phy **phys;
@@ -1047,6 +1049,72 @@ static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
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
+				"Failed to enable 3V3 slot supply: %d\n", ret);
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
+	msleep(100);
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
@@ -1060,6 +1128,10 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 		return ret;
 	}
 
+	ret = tegra_pcie_enable_slot_regulators(pcie);
+	if (ret < 0)
+		goto fail_slot_reg_en;
+
 	ret = regulator_enable(pcie->pex_ctl_supply);
 	if (ret < 0) {
 		dev_err(pcie->dev, "Failed to enable regulator: %d\n", ret);
@@ -1142,6 +1214,8 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 fail_core_clk:
 	regulator_disable(pcie->pex_ctl_supply);
 fail_reg_en:
+	tegra_pcie_disable_slot_regulators(pcie);
+fail_slot_reg_en:
 	tegra_pcie_bpmp_set_ctrl_state(pcie, false);
 
 	return ret;
@@ -1174,6 +1248,8 @@ static int __deinit_controller(struct tegra_pcie_dw *pcie)
 		return ret;
 	}
 
+	tegra_pcie_disable_slot_regulators(pcie);
+
 	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, false);
 	if (ret) {
 		dev_err(pcie->dev, "Failed to disable controller %d: %d\n",
@@ -1373,6 +1449,10 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = tegra_pcie_get_slot_regulators(pcie);
+	if (ret < 0)
+		return ret;
+
 	pcie->pex_ctl_supply = devm_regulator_get(dev, "vddio-pex-ctl");
 	if (IS_ERR(pcie->pex_ctl_supply)) {
 		dev_err(dev, "Failed to get regulator: %ld\n",
-- 
2.17.1

