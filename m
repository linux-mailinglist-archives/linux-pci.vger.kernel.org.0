Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6561D4AAA19
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 17:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380436AbiBEQXl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Feb 2022 11:23:41 -0500
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:60353
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380428AbiBEQXk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Feb 2022 11:23:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgmjzSpJk6UVjzAl2H0w5mx56ZMuVasDTabYRJEV53kCP9UskY+dEDMDMtlHpB9owePO36eferEMOkfTZ3sQi5b0RovfAa0C5uNJ90p0WTiQKIlITAg+QX3rM9OWXdSo3SVjB/Q/myR+Dmtmf6wsK3NJyEEkO2inUjpyZWoadDcG8FiMAKLVEhWtV2Z3dcOcRqWVe3srNjDpCfekSxkzRoYN0hGUk46cqQupn6lKacfidtTOdAzY2ohA/SFVbFyf1dnzc6bTClXdoXMOSe67vzE2UP5XzKcMYpVuaJULQeGiIHqaTPKyXI9ha9KjUjMHnzj4+kXsoV9PBISsE2fgxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkB32VW4MlTkbvYqkWx60WYiDdMovUN4ls1q+rciym0=;
 b=RHEoBRLVCJRfL8aHZZqtr57Eo6ZzarUqlRiYFGujEhPc9T9WwJP7SREhj0mBwmmHjyKDIlcfW5zq7jfRQt5ijmAQN3lfVL3p9msMnsjuuyfVWNPoLxZM2czW92l2BcFwOZ+Xh+dMUdWF87dPIrfh7RKvMjT5InyVQdh2pFJoNvEy9bhA/FXPvtNabbTFMlGdmOwuqFTKuLudOwPl9xxFkTCyZWjbbsWVRXxfwMYdfHyFifNF9iZsXKbaTSzijOPigAVf6uRT4NfqgCM+sM3uw0X120dv2l9VtKxhmhtNArzxM4wBzD6b7oaD39F9PKpvDXiyAcb6HqkJr4Ub0a8UZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkB32VW4MlTkbvYqkWx60WYiDdMovUN4ls1q+rciym0=;
 b=NlKUFKAdhlW/Y+ptqGYpdNLcHiZuPifM/pca3oMxcwhag61QuIs30xXbm4/086ygVeMfvxBEoqziD1/PTPhDFm1LGOkm8vFxjIrC92G2EQyz8oHXj5dkg2a04SE5U2k8PF0+3jI5495wqlNCBBCIxbdUSI7CCKfBkjIhdI7ZiJUdlh+GbOWDZhL3caV+yYRDcWskC/fzpNzmGMerH9mxFTRVa0MjJWnsFsrmffqvTuDErCMydAarZQNWTjGuGPY3ksKyR72o0FuldwjLS/id7N+B7K83A/aVSvKPjm5/yP4EfXKC5ecp6jI/JCQxz28Y3djGYPWTKlLT1nhUVbi72Q==
Received: from BN1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:408:e2::8)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 16:23:37 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::f5) by BN1PR13CA0003.outlook.office365.com
 (2603:10b6:408:e2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.9 via Frontend
 Transport; Sat, 5 Feb 2022 16:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 16:23:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 5 Feb
 2022 16:23:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sat, 5 Feb 2022
 08:23:35 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sat, 5 Feb 2022 08:23:30 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski@canonical.com>, <p.zabel@pengutronix.de>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 10/10] PCI: tegra: Add Tegra234 PCIe support
Date:   Sat, 5 Feb 2022 21:51:44 +0530
Message-ID: <20220205162144.30240-11-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220205162144.30240-1-vidyas@nvidia.com>
References: <20220205162144.30240-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a352c52-d1d0-48b6-99ae-08d9e8c3dcad
X-MS-TrafficTypeDiagnostic: DM6PR12MB4284:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB42840DEEB8C7DC146E3F9CB6B82A9@DM6PR12MB4284.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMn+7yh6VkW+GMD6qYfnSUvH5PTiWOsck8XsUyIZ/1avfeOccdGXxI7hrN+oRkEob0PHnudGCftNdlIF8D0x0+yxqG0+kOguC5uarmB+qf2s4jgQNBQP3ONI6tb4RrLv0YdYISf+xXxWEImgDs2l7+KmEApWk/Qw9sEQ7vZYWXpbsGvZEGumte2Mh0Sz7/VGdXanddc9XUPfwthGJdBhmHnAtXF9D9bUxrkN9ZZJjUY8LCShfHyrLwSxXbRbL2Kjvn8C5tE9j2j0qioRV+yeSxF/vuF34QNOrHJhvHmAN33adJ49eyZa3mc1CCLxZ1F7CxDWx06nv6cvBUalQp85RIY4nWfFDfUUL6h6g3XVWKDE6hS/ep2S+omVDkVlC+k5elT8AmH0lIVKWxkOmjHJXAmW9BMb8LSr+XLG3hnaDLG4Mxlr9OM5ZW0Ccs2LBa5f/N4imYAGsNwWo55z62vMpr+7nnQUDPC/Fjh8I9CV+TjJ0Qp7TQoqKVKoJRL87Cy2d9iQCVIvit40NWo1HEG0aAcsQkLiqxPfhoajxiZS1yxnlPc0z98v80o+JmkwIGttAL8fuEHS9Hkq+hpw9WvDOkQcxBUnodw5aWWDMetvGyTl7facoiAY2qOYe7bKWEAFyOMqRN7Rj+GVvcCMjLkc9PeCxfg3wtHIFtVniTk5BuPNUA+7ZGZzmry+Ef26Dgs/II4YOYpEU3Vxs1DROTMvCQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(7416002)(5660300002)(82310400004)(2906002)(86362001)(356005)(2616005)(26005)(186003)(426003)(1076003)(336012)(81166007)(47076005)(30864003)(508600001)(7696005)(110136005)(6666004)(316002)(40460700003)(36860700001)(8676002)(6636002)(70586007)(8936002)(36756003)(4326008)(70206006)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 16:23:36.6548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a352c52-d1d0-48b6-99ae-08d9e8c3dcad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for Synopsys DesignWare core IP based PCIe host controllers
present in the Tegra234 SoC.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 409 ++++++++++++++++-----
 1 file changed, 315 insertions(+), 94 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b1b5f836a806..512ab0767f11 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * PCIe host controller driver for Tegra194 SoC
+ * PCIe host controller driver for the following SoCs
+ * Tegra194
+ * Tegra234
  *
- * Copyright (C) 2019 NVIDIA Corporation.
+ * Copyright (C) 2019-2022 NVIDIA Corporation.
  *
  * Author: Vidya Sagar <vidyas@nvidia.com>
  */
@@ -35,6 +37,9 @@
 #include <soc/tegra/bpmp-abi.h>
 #include "../../pci.h"
 
+#define TEGRA194_DWC_IP_VER			0x490A
+#define TEGRA234_DWC_IP_VER			0x562A
+
 #define APPL_PINMUX				0x0
 #define APPL_PINMUX_PEX_RST			BIT(0)
 #define APPL_PINMUX_CLKREQ_OVERRIDE_EN		BIT(2)
@@ -49,6 +54,7 @@
 #define APPL_CTRL_HW_HOT_RST_MODE_MASK		GENMASK(1, 0)
 #define APPL_CTRL_HW_HOT_RST_MODE_SHIFT		22
 #define APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST	0x1
+#define APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN	0x2
 
 #define APPL_INTR_EN_L0_0			0x8
 #define APPL_INTR_EN_L0_0_LINK_STATE_INT_EN	BIT(0)
@@ -245,6 +251,18 @@ static const unsigned int pcie_gen_freq[] = {
 	GEN4_CORE_CLK_FREQ
 };
 
+struct tegra_pcie_of_data {
+	u32 version;
+	enum dw_pcie_device_mode mode;
+	bool msix_doorbell_access_fixup;
+	bool sbr_reset_fixup;
+	bool l1ss_exit_fixup;
+	bool ltr_req_fixup;
+	u32 cdm_chk_int_en;
+	u32 gen4_preset_vec;
+	u8 n_fts[2];
+};
+
 struct tegra194_pcie {
 	struct device *dev;
 	struct resource *appl_res;
@@ -257,12 +275,14 @@ struct tegra194_pcie {
 	struct dw_pcie pci;
 	struct tegra_bpmp *bpmp;
 
-	enum dw_pcie_device_mode mode;
+	struct tegra_pcie_of_data *of_data;
 
 	bool supports_clkreq;
 	bool enable_cdm_check;
+	bool enable_srns;
 	bool link_state;
 	bool update_fc_fixup;
+	bool enable_ext_refclk;
 	u8 init_link_width;
 	u32 msi_ctrl_int;
 	u32 num_lanes;
@@ -286,13 +306,10 @@ struct tegra194_pcie {
 	struct gpio_desc *pex_rst_gpiod;
 	struct gpio_desc *pex_refclk_sel_gpiod;
 	unsigned int pex_rst_irq;
+	bool pex_rst_irq_enabled;
 	int ep_state;
 };
 
-struct tegra194_pcie_of_data {
-	enum dw_pcie_device_mode mode;
-};
-
 static inline struct tegra194_pcie *to_tegra_pcie(struct dw_pcie *pci)
 {
 	return container_of(pci, struct tegra194_pcie, pci);
@@ -352,15 +369,15 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
 	struct tegra194_pcie *pcie = arg;
 	struct dw_pcie *pci = &pcie->pci;
 	struct pcie_port *pp = &pci->pp;
-	u32 val, tmp;
+	u32 val, status_l0, status_l1;
 	u16 val_w;
 
-	val = appl_readl(pcie, APPL_INTR_STATUS_L0);
-	if (val & APPL_INTR_STATUS_L0_LINK_STATE_INT) {
-		val = appl_readl(pcie, APPL_INTR_STATUS_L1_0_0);
-		if (val & APPL_INTR_STATUS_L1_0_0_LINK_REQ_RST_NOT_CHGED) {
-			appl_writel(pcie, val, APPL_INTR_STATUS_L1_0_0);
-
+	status_l0 = appl_readl(pcie, APPL_INTR_STATUS_L0);
+	if (status_l0 & APPL_INTR_STATUS_L0_LINK_STATE_INT) {
+		status_l1 = appl_readl(pcie, APPL_INTR_STATUS_L1_0_0);
+		appl_writel(pcie, status_l1, APPL_INTR_STATUS_L1_0_0);
+		if (pcie->of_data->sbr_reset_fixup &&
+		    status_l1 & APPL_INTR_STATUS_L1_0_0_LINK_REQ_RST_NOT_CHGED) {
 			/* SBR & Surprise Link Down WAR */
 			val = appl_readl(pcie, APPL_CAR_RESET_OVRD);
 			val &= ~APPL_CAR_RESET_OVRD_CYA_OVERRIDE_CORE_RST_N;
@@ -376,15 +393,21 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
 		}
 	}
 
-	if (val & APPL_INTR_STATUS_L0_INT_INT) {
-		val = appl_readl(pcie, APPL_INTR_STATUS_L1_8_0);
-		if (val & APPL_INTR_STATUS_L1_8_0_AUTO_BW_INT_STS) {
+	if (status_l0 & APPL_INTR_STATUS_L0_INT_INT) {
+		status_l1 = appl_readl(pcie, APPL_INTR_STATUS_L1_8_0);
+		if (status_l1 & APPL_INTR_STATUS_L1_8_0_AUTO_BW_INT_STS) {
 			appl_writel(pcie,
 				    APPL_INTR_STATUS_L1_8_0_AUTO_BW_INT_STS,
 				    APPL_INTR_STATUS_L1_8_0);
 			apply_bad_link_workaround(pp);
 		}
-		if (val & APPL_INTR_STATUS_L1_8_0_BW_MGT_INT_STS) {
+		if (status_l1 & APPL_INTR_STATUS_L1_8_0_BW_MGT_INT_STS) {
+			val_w = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
+						  PCI_EXP_LNKSTA);
+			val_w |= PCI_EXP_LNKSTA_LBMS;
+			dw_pcie_writew_dbi(pci, pcie->pcie_cap_base +
+					   PCI_EXP_LNKSTA, val_w);
+
 			appl_writel(pcie,
 				    APPL_INTR_STATUS_L1_8_0_BW_MGT_INT_STS,
 				    APPL_INTR_STATUS_L1_8_0);
@@ -396,25 +419,24 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
 		}
 	}
 
-	val = appl_readl(pcie, APPL_INTR_STATUS_L0);
-	if (val & APPL_INTR_STATUS_L0_CDM_REG_CHK_INT) {
-		val = appl_readl(pcie, APPL_INTR_STATUS_L1_18);
-		tmp = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
-		if (val & APPL_INTR_STATUS_L1_18_CDM_REG_CHK_CMPLT) {
+	if (status_l0 & APPL_INTR_STATUS_L0_CDM_REG_CHK_INT) {
+		status_l1 = appl_readl(pcie, APPL_INTR_STATUS_L1_18);
+		val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
+		if (status_l1 & APPL_INTR_STATUS_L1_18_CDM_REG_CHK_CMPLT) {
 			dev_info(pci->dev, "CDM check complete\n");
-			tmp |= PCIE_PL_CHK_REG_CHK_REG_COMPLETE;
+			val |= PCIE_PL_CHK_REG_CHK_REG_COMPLETE;
 		}
-		if (val & APPL_INTR_STATUS_L1_18_CDM_REG_CHK_CMP_ERR) {
+		if (status_l1 & APPL_INTR_STATUS_L1_18_CDM_REG_CHK_CMP_ERR) {
 			dev_err(pci->dev, "CDM comparison mismatch\n");
-			tmp |= PCIE_PL_CHK_REG_CHK_REG_COMPARISON_ERROR;
+			val |= PCIE_PL_CHK_REG_CHK_REG_COMPARISON_ERROR;
 		}
-		if (val & APPL_INTR_STATUS_L1_18_CDM_REG_CHK_LOGIC_ERR) {
+		if (status_l1 & APPL_INTR_STATUS_L1_18_CDM_REG_CHK_LOGIC_ERR) {
 			dev_err(pci->dev, "CDM Logic error\n");
-			tmp |= PCIE_PL_CHK_REG_CHK_REG_LOGIC_ERROR;
+			val |= PCIE_PL_CHK_REG_CHK_REG_LOGIC_ERROR;
 		}
-		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, tmp);
-		tmp = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_ERR_ADDR);
-		dev_err(pci->dev, "CDM Error Address Offset = 0x%08X\n", tmp);
+		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
+		val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_ERR_ADDR);
+		dev_err(pci->dev, "CDM Error Address Offset = 0x%08X\n", val);
 	}
 
 	return IRQ_HANDLED;
@@ -456,6 +478,9 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 		PCI_EXP_LNKSTA_CLS;
 	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
 
+	if (!pcie->of_data->ltr_req_fixup)
+		return IRQ_HANDLED;
+
 	/* If EP doesn't advertise L1SS, just return */
 	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
 	if (!(val & (PCI_L1SS_CAP_ASPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_2)))
@@ -540,13 +565,18 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 static int tegra194_pcie_rd_own_conf(struct pci_bus *bus, u32 devfn, int where,
 				     int size, u32 *val)
 {
+	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
+
 	/*
 	 * This is an endpoint mode specific register happen to appear even
 	 * when controller is operating in root port mode and system hangs
 	 * when it is accessed with link being in ASPM-L1 state.
 	 * So skip accessing it altogether
 	 */
-	if (!PCI_SLOT(devfn) && where == PORT_LOGIC_MSIX_DOORBELL) {
+	if (pcie->of_data->msix_doorbell_access_fixup &&
+	    !PCI_SLOT(devfn) && where == PORT_LOGIC_MSIX_DOORBELL) {
 		*val = 0x00000000;
 		return PCIBIOS_SUCCESSFUL;
 	}
@@ -557,13 +587,18 @@ static int tegra194_pcie_rd_own_conf(struct pci_bus *bus, u32 devfn, int where,
 static int tegra194_pcie_wr_own_conf(struct pci_bus *bus, u32 devfn, int where,
 				     int size, u32 val)
 {
+	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
+
 	/*
 	 * This is an endpoint mode specific register happen to appear even
 	 * when controller is operating in root port mode and system hangs
 	 * when it is accessed with link being in ASPM-L1 state.
 	 * So skip accessing it altogether
 	 */
-	if (!PCI_SLOT(devfn) && where == PORT_LOGIC_MSIX_DOORBELL)
+	if (pcie->of_data->msix_doorbell_access_fixup &&
+	    !PCI_SLOT(devfn) && where == PORT_LOGIC_MSIX_DOORBELL)
 		return PCIBIOS_SUCCESSFUL;
 
 	return pci_generic_config_write(bus, devfn, where, size, val);
@@ -711,13 +746,15 @@ static void tegra_pcie_enable_system_interrupts(struct pcie_port *pp)
 	val |= APPL_INTR_EN_L0_0_LINK_STATE_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L0_0);
 
-	val = appl_readl(pcie, APPL_INTR_EN_L1_0_0);
-	val |= APPL_INTR_EN_L1_0_0_LINK_REQ_RST_NOT_INT_EN;
-	appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
+	if (pcie->of_data->sbr_reset_fixup) {
+		val = appl_readl(pcie, APPL_INTR_EN_L1_0_0);
+		val |= APPL_INTR_EN_L1_0_0_LINK_REQ_RST_NOT_INT_EN;
+		appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
+	}
 
 	if (pcie->enable_cdm_check) {
 		val = appl_readl(pcie, APPL_INTR_EN_L0_0);
-		val |= APPL_INTR_EN_L0_0_CDM_REG_CHK_INT_EN;
+		val |= pcie->of_data->cdm_chk_int_en;
 		appl_writel(pcie, val, APPL_INTR_EN_L0_0);
 
 		val = appl_readl(pcie, APPL_INTR_EN_L1_18);
@@ -844,7 +881,8 @@ static void config_gen3_gen4_eq_presets(struct tegra194_pcie *pcie)
 
 	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
 	val &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK;
-	val |= (0x360 << GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT);
+	val |= (pcie->of_data->gen4_preset_vec <<
+		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT);
 	val &= ~GEN3_EQ_CONTROL_OFF_FB_MODE_MASK;
 	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
 
@@ -858,6 +896,7 @@ static int tegra194_pcie_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct tegra194_pcie *pcie = to_tegra_pcie(pci);
 	u32 val;
+	u16 val_16;
 
 	pp->bridge->ops = &tegra_pci_ops;
 
@@ -865,6 +904,11 @@ static int tegra194_pcie_host_init(struct pcie_port *pp)
 		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 							      PCI_CAP_ID_EXP);
 
+	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
+	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
+	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
+	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
+
 	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
 	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
 	dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
@@ -889,6 +933,15 @@ static int tegra194_pcie_host_init(struct pcie_port *pp)
 	val |= (pcie->num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT);
 	dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP, val);
 
+	/* Clear Slot Clock Configuration bit if SRNS configuration */
+	if (pcie->enable_srns) {
+		val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
+					   PCI_EXP_LNKSTA);
+		val_16 &= ~PCI_EXP_LNKSTA_SLC;
+		dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
+				   val_16);
+	}
+
 	config_gen3_gen4_eq_presets(pcie);
 
 	init_host_aspm(pcie);
@@ -899,9 +952,11 @@ static int tegra194_pcie_host_init(struct pcie_port *pp)
 		disable_aspm_l12(pcie);
 	}
 
-	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+	if (pcie->of_data->l1ss_exit_fixup) {
+		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+	}
 
 	if (pcie->update_fc_fixup) {
 		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
@@ -921,8 +976,11 @@ static int tegra194_pcie_start_link(struct dw_pcie *pci)
 	struct pcie_port *pp = &pci->pp;
 	bool retry = true;
 
-	if (pcie->mode == DW_PCIE_EP_TYPE) {
-		enable_irq(pcie->pex_rst_irq);
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
+		if (!pcie->pex_rst_irq_enabled) {
+			enable_irq(pcie->pex_rst_irq);
+			pcie->pex_rst_irq_enabled = true;
+		}
 		return 0;
 	}
 
@@ -1113,13 +1171,26 @@ static int tegra194_pcie_parse_dt(struct tegra194_pcie *pcie)
 	if (of_property_read_bool(np, "nvidia,update-fc-fixup"))
 		pcie->update_fc_fixup = true;
 
+	pcie->enable_ext_refclk =
+		of_property_read_bool(pcie->dev->of_node,
+				      "nvidia,enable-ext-refclk");
+	/* RP using an external REFCLK is supported only in Tegra234 */
+	if (pcie->of_data->version == TEGRA194_DWC_IP_VER) {
+		if (pcie->of_data->mode == DW_PCIE_RC_TYPE)
+			pcie->enable_ext_refclk = false;
+		else
+			pcie->enable_ext_refclk = true;
+	}
+
 	pcie->supports_clkreq =
 		of_property_read_bool(pcie->dev->of_node, "supports-clkreq");
 
 	pcie->enable_cdm_check =
 		of_property_read_bool(np, "snps,enable-cdm-check");
 
-	if (pcie->mode == DW_PCIE_RC_TYPE)
+	pcie->enable_srns = of_property_read_bool(np, "nvidia,enable-srns");
+
+	if (pcie->of_data->mode == DW_PCIE_RC_TYPE)
 		return 0;
 
 	/* Endpoint mode specific DT entries */
@@ -1163,8 +1234,11 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra194_pcie *pcie,
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
 
-	/* Controller-5 doesn't need to have its state set by BPMP-FW */
-	if (pcie->cid == 5)
+	/*
+	 * Controller-5 doesn't need to have its state set by BPMP-FW in
+	 * Tegra194
+	 */
+	if (pcie->cid == 5 && pcie->of_data->version == 0x490A)
 		return 0;
 
 	memset(&req, 0, sizeof(req));
@@ -1330,6 +1404,14 @@ static int tegra_pcie_config_controller(struct tegra194_pcie *pcie,
 		return ret;
 	}
 
+	if (pcie->enable_ext_refclk) {
+		ret = tegra_pcie_bpmp_set_pll_state(pcie, true);
+		if (ret) {
+			dev_err(pcie->dev, "Failed to init UPHY: %d\n", ret);
+			goto fail_pll_init;
+		}
+	}
+
 	ret = tegra_pcie_enable_slot_regulators(pcie);
 	if (ret < 0)
 		goto fail_slot_reg_en;
@@ -1353,11 +1435,13 @@ static int tegra_pcie_config_controller(struct tegra194_pcie *pcie,
 		goto fail_core_apb_rst;
 	}
 
-	if (en_hw_hot_rst) {
+	if (en_hw_hot_rst || !pcie->of_data->sbr_reset_fixup) {
 		/* Enable HW_HOT_RST mode */
 		val = appl_readl(pcie, APPL_CTRL);
 		val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
 			 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+		val |= (APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN <<
+			APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
 		val |= APPL_CTRL_HW_HOT_RST_EN;
 		appl_writel(pcie, val, APPL_CTRL);
 	}
@@ -1384,6 +1468,19 @@ static int tegra_pcie_config_controller(struct tegra194_pcie *pcie,
 	val |= (APPL_CFG_MISC_ARCACHE_VAL << APPL_CFG_MISC_ARCACHE_SHIFT);
 	appl_writel(pcie, val, APPL_CFG_MISC);
 
+	if (pcie->enable_srns || pcie->enable_ext_refclk) {
+		/*
+		 * When Tegra PCIe RP is using external clock, it cannot
+		 * supply same clock back to EP, which makes it separate clock.
+		 * Gate PCIe RP REFCLK out pads when RP & EP are using separate
+		 * clock or RP is using external REFCLK.
+		 */
+		val = appl_readl(pcie, APPL_PINMUX);
+		val |= APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN;
+		val &= ~APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE;
+		appl_writel(pcie, val, APPL_PINMUX);
+	}
+
 	if (!pcie->supports_clkreq) {
 		val = appl_readl(pcie, APPL_PINMUX);
 		val |= APPL_PINMUX_CLKREQ_OVERRIDE_EN;
@@ -1409,6 +1506,9 @@ static int tegra_pcie_config_controller(struct tegra194_pcie *pcie,
 fail_reg_en:
 	tegra_pcie_disable_slot_regulators(pcie);
 fail_slot_reg_en:
+	if (pcie->enable_ext_refclk)
+		tegra_pcie_bpmp_set_pll_state(pcie, false);
+fail_pll_init:
 	tegra_pcie_bpmp_set_ctrl_state(pcie, false);
 
 	return ret;
@@ -1436,6 +1536,12 @@ static void tegra_pcie_unconfig_controller(struct tegra194_pcie *pcie)
 
 	tegra_pcie_disable_slot_regulators(pcie);
 
+	if (pcie->enable_ext_refclk) {
+		ret = tegra_pcie_bpmp_set_pll_state(pcie, false);
+		if (ret)
+			dev_err(pcie->dev, "Failed to deinit UPHY: %d\n", ret);
+	}
+
 	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, false);
 	if (ret)
 		dev_err(pcie->dev, "Failed to disable controller %d: %d\n",
@@ -1636,6 +1742,13 @@ static void pex_ep_event_pex_rst_assert(struct tegra194_pcie *pcie)
 
 	pm_runtime_put_sync(pcie->dev);
 
+	if (pcie->enable_ext_refclk) {
+		ret = tegra_pcie_bpmp_set_pll_state(pcie, false);
+		if (ret)
+			dev_err(pcie->dev, "Failed to turn off UPHY: %d\n",
+				ret);
+	}
+
 	ret = tegra_pcie_bpmp_set_pll_state(pcie, false);
 	if (ret)
 		dev_err(pcie->dev, "Failed to turn off UPHY: %d\n", ret);
@@ -1651,6 +1764,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra194_pcie *pcie)
 	struct device *dev = pcie->dev;
 	u32 val;
 	int ret;
+	u16 val_16;
 
 	if (pcie->ep_state == EP_STATE_ENABLED)
 		return;
@@ -1662,10 +1776,20 @@ static void pex_ep_event_pex_rst_deassert(struct tegra194_pcie *pcie)
 		return;
 	}
 
-	ret = tegra_pcie_bpmp_set_pll_state(pcie, true);
+	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, true);
 	if (ret) {
-		dev_err(dev, "Failed to init UPHY for PCIe EP: %d\n", ret);
-		goto fail_pll_init;
+		dev_err(pcie->dev, "Failed to enable controller %u: %d\n",
+			pcie->cid, ret);
+		goto fail_set_ctrl_state;
+	}
+
+	if (pcie->enable_ext_refclk) {
+		ret = tegra_pcie_bpmp_set_pll_state(pcie, true);
+		if (ret) {
+			dev_err(dev, "Failed to init UPHY for PCIe EP: %d\n",
+				ret);
+			goto fail_pll_init;
+		}
 	}
 
 	ret = clk_prepare_enable(pcie->core_clk);
@@ -1762,12 +1886,29 @@ static void pex_ep_event_pex_rst_deassert(struct tegra194_pcie *pcie)
 		disable_aspm_l12(pcie);
 	}
 
-	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+	if (pcie->of_data->l1ss_exit_fixup) {
+		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+	}
 
 	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 						      PCI_CAP_ID_EXP);
+
+	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
+	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
+	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
+	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
+
+	/* Clear Slot Clock Configuration bit if SRNS configuration */
+	if (pcie->enable_srns) {
+		val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
+					   PCI_EXP_LNKSTA);
+		val_16 &= ~PCI_EXP_LNKSTA_SLC;
+		dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
+				   val_16);
+	}
+
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
 
 	val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
@@ -1784,6 +1925,13 @@ static void pex_ep_event_pex_rst_deassert(struct tegra194_pcie *pcie)
 
 	dw_pcie_ep_init_notify(ep);
 
+	/* Send LTR upstream */
+	if (!pcie->of_data->ltr_req_fixup) {
+		val = appl_readl(pcie, APPL_LTR_MSG_2);
+		val |= APPL_LTR_MSG_2_LTR_MSG_REQ_STATE;
+		appl_writel(pcie, val, APPL_LTR_MSG_2);
+	}
+
 	/* Enable LTSSM */
 	val = appl_readl(pcie, APPL_CTRL);
 	val |= APPL_CTRL_LTSSM_EN;
@@ -1804,6 +1952,8 @@ static void pex_ep_event_pex_rst_deassert(struct tegra194_pcie *pcie)
 fail_core_clk_enable:
 	tegra_pcie_bpmp_set_pll_state(pcie, false);
 fail_pll_init:
+	tegra_pcie_bpmp_set_ctrl_state(pcie, false);
+fail_set_ctrl_state:
 	pm_runtime_put_sync(dev);
 }
 
@@ -1933,6 +2083,7 @@ static int tegra_pcie_config_ep(struct tegra194_pcie *pcie,
 
 	irq_set_status_flags(pcie->pex_rst_irq, IRQ_NOAUTOEN);
 
+	pcie->pex_rst_irq_enabled = false;
 	pcie->ep_state = EP_STATE_DISABLED;
 
 	ret = devm_request_threaded_irq(dev, pcie->pex_rst_irq, NULL,
@@ -1979,14 +2130,13 @@ static int tegra194_pcie_probe(struct platform_device *pdev)
 	pci = &pcie->pci;
 	pci->dev = &pdev->dev;
 	pci->ops = &tegra_dw_pcie_ops;
-	pci->n_fts[0] = N_FTS_VAL;
-	pci->n_fts[1] = FTS_VAL;
-	pci->version = 0x490A;
-
+	pcie->dev = &pdev->dev;
+	pcie->of_data = (struct tegra_pcie_of_data *)data;
+	pci->n_fts[0] = pcie->of_data->n_fts[0];
+	pci->n_fts[1] = pcie->of_data->n_fts[1];
+	pci->version = pcie->of_data->version;
 	pp = &pci->pp;
 	pp->num_vectors = MAX_MSI_IRQS;
-	pcie->dev = &pdev->dev;
-	pcie->mode = (enum dw_pcie_device_mode)data->mode;
 
 	ret = tegra194_pcie_parse_dt(pcie);
 	if (ret < 0) {
@@ -2103,7 +2253,7 @@ static int tegra194_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
-	switch (pcie->mode) {
+	switch (pcie->of_data->mode) {
 	case DW_PCIE_RC_TYPE:
 		ret = devm_request_irq(dev, pp->irq, tegra_pcie_rp_irq_handler,
 				       IRQF_SHARED, "tegra-pcie-intr", pcie);
@@ -2138,7 +2288,8 @@ static int tegra194_pcie_probe(struct platform_device *pdev)
 		break;
 
 	default:
-		dev_err(dev, "Invalid PCIe device type %d\n", pcie->mode);
+		dev_err(dev, "Invalid PCIe device type %d\n",
+			pcie->of_data->mode);
 	}
 
 fail:
@@ -2150,12 +2301,19 @@ static int tegra194_pcie_remove(struct platform_device *pdev)
 {
 	struct tegra194_pcie *pcie = platform_get_drvdata(pdev);
 
-	if (!pcie->link_state)
-		return 0;
+	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
+		if (!pcie->link_state)
+			return 0;
+
+		debugfs_remove_recursive(pcie->debugfs);
+		tegra_pcie_deinit_controller(pcie);
+		pm_runtime_put_sync(pcie->dev);
+	} else {
+		if (pcie->pex_rst_irq_enabled)
+			disable_irq(pcie->pex_rst_irq);
+		pex_ep_event_pex_rst_assert(pcie);
+	}
 
-	debugfs_remove_recursive(pcie->debugfs);
-	tegra_pcie_deinit_controller(pcie);
-	pm_runtime_put_sync(pcie->dev);
 	pm_runtime_disable(pcie->dev);
 	tegra_bpmp_put(pcie->bpmp);
 	if (pcie->pex_refclk_sel_gpiod)
@@ -2169,15 +2327,22 @@ static int tegra194_pcie_suspend_late(struct device *dev)
 	struct tegra194_pcie *pcie = dev_get_drvdata(dev);
 	u32 val;
 
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
+		dev_err(dev, "Failed to Suspend as Tegra PCIe is in EP mode\n");
+		return -EPERM;
+	}
+
 	if (!pcie->link_state)
 		return 0;
 
 	/* Enable HW_HOT_RST mode */
-	val = appl_readl(pcie, APPL_CTRL);
-	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
-		 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
-	val |= APPL_CTRL_HW_HOT_RST_EN;
-	appl_writel(pcie, val, APPL_CTRL);
+	if (pcie->of_data->sbr_reset_fixup) {
+		val = appl_readl(pcie, APPL_CTRL);
+		val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
+			 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+		val |= APPL_CTRL_HW_HOT_RST_EN;
+		appl_writel(pcie, val, APPL_CTRL);
+	}
 
 	return 0;
 }
@@ -2239,22 +2404,19 @@ static int tegra194_pcie_resume_early(struct device *dev)
 	struct tegra194_pcie *pcie = dev_get_drvdata(dev);
 	u32 val;
 
-	if (pcie->mode == DW_PCIE_EP_TYPE) {
-		dev_err(dev, "Suspend is not supported in EP mode");
-		return -ENOTSUPP;
-	}
-
 	if (!pcie->link_state)
 		return 0;
 
 	/* Disable HW_HOT_RST mode */
-	val = appl_readl(pcie, APPL_CTRL);
-	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
-		 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
-	val |= APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST <<
-	       APPL_CTRL_HW_HOT_RST_MODE_SHIFT;
-	val &= ~APPL_CTRL_HW_HOT_RST_EN;
-	appl_writel(pcie, val, APPL_CTRL);
+	if (pcie->of_data->sbr_reset_fixup) {
+		val = appl_readl(pcie, APPL_CTRL);
+		val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
+			 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+		val |= APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST <<
+		       APPL_CTRL_HW_HOT_RST_MODE_SHIFT;
+		val &= ~APPL_CTRL_HW_HOT_RST_EN;
+		appl_writel(pcie, val, APPL_CTRL);
+	}
 
 	return 0;
 }
@@ -2263,26 +2425,77 @@ static void tegra194_pcie_shutdown(struct platform_device *pdev)
 {
 	struct tegra194_pcie *pcie = platform_get_drvdata(pdev);
 
-	if (!pcie->link_state)
-		return;
+	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
+		if (!pcie->link_state)
+			return;
 
-	debugfs_remove_recursive(pcie->debugfs);
-	tegra_pcie_downstream_dev_to_D0(pcie);
+		debugfs_remove_recursive(pcie->debugfs);
+		tegra_pcie_downstream_dev_to_D0(pcie);
 
-	disable_irq(pcie->pci.pp.irq);
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		disable_irq(pcie->pci.pp.msi_irq);
+		disable_irq(pcie->pci.pp.irq);
+		if (IS_ENABLED(CONFIG_PCI_MSI))
+			disable_irq(pcie->pci.pp.msi_irq);
 
-	tegra194_pcie_pme_turnoff(pcie);
-	tegra_pcie_unconfig_controller(pcie);
+		tegra194_pcie_pme_turnoff(pcie);
+		tegra_pcie_unconfig_controller(pcie);
+		pm_runtime_put_sync(pcie->dev);
+	} else {
+		if (pcie->pex_rst_irq_enabled)
+			disable_irq(pcie->pex_rst_irq);
+		pex_ep_event_pex_rst_assert(pcie);
+	}
 }
 
-static const struct tegra194_pcie_of_data tegra194_pcie_rc_of_data = {
+static const struct tegra_pcie_of_data tegra194_pcie_rc_of_data = {
+	.version = TEGRA194_DWC_IP_VER,
+	.mode = DW_PCIE_RC_TYPE,
+	.msix_doorbell_access_fixup = true,
+	.sbr_reset_fixup = true,
+	.l1ss_exit_fixup = true,
+	.ltr_req_fixup = false,
+	.cdm_chk_int_en = BIT(19),
+	/* Gen4 - 5, 6, 8 and 9 presets enabled */
+	.gen4_preset_vec = 0x360,
+	.n_fts = { 52, 52 },
+};
+
+static const struct tegra_pcie_of_data tegra194_pcie_ep_of_data = {
+	.version = TEGRA194_DWC_IP_VER,
+	.mode = DW_PCIE_EP_TYPE,
+	.msix_doorbell_access_fixup = false,
+	.sbr_reset_fixup = false,
+	.l1ss_exit_fixup = true,
+	.ltr_req_fixup = true,
+	.cdm_chk_int_en = BIT(19),
+	/* Gen4 - 5, 6, 8 and 9 presets enabled */
+	.gen4_preset_vec = 0x360,
+	.n_fts = { 52, 52 },
+};
+
+static const struct tegra_pcie_of_data tegra234_pcie_rc_of_data = {
+	.version = TEGRA234_DWC_IP_VER,
 	.mode = DW_PCIE_RC_TYPE,
+	.msix_doorbell_access_fixup = false,
+	.sbr_reset_fixup = false,
+	.l1ss_exit_fixup = false,
+	.ltr_req_fixup = false,
+	.cdm_chk_int_en = BIT(18),
+	/* Gen4 - 6, 8 and 9 presets enabled */
+	.gen4_preset_vec = 0x340,
+	.n_fts = { 52, 80 },
 };
 
-static const struct tegra194_pcie_of_data tegra194_pcie_ep_of_data = {
+static const struct tegra_pcie_of_data tegra234_pcie_ep_of_data = {
+	.version = TEGRA234_DWC_IP_VER,
 	.mode = DW_PCIE_EP_TYPE,
+	.msix_doorbell_access_fixup = false,
+	.sbr_reset_fixup = false,
+	.l1ss_exit_fixup = false,
+	.ltr_req_fixup = false,
+	.cdm_chk_int_en = BIT(18),
+	/* Gen4 - 6, 8 and 9 presets enabled */
+	.gen4_preset_vec = 0x340,
+	.n_fts = { 52, 80 },
 };
 
 static const struct of_device_id tegra194_pcie_of_match[] = {
@@ -2294,6 +2507,14 @@ static const struct of_device_id tegra194_pcie_of_match[] = {
 		.compatible = "nvidia,tegra194-pcie-ep",
 		.data = &tegra194_pcie_ep_of_data,
 	},
+	{
+		.compatible = "nvidia,tegra234-pcie",
+		.data = &tegra234_pcie_rc_of_data,
+	},
+	{
+		.compatible = "nvidia,tegra234-pcie-ep",
+		.data = &tegra234_pcie_ep_of_data,
+	},
 	{},
 };
 
-- 
2.17.1

