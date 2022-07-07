Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E209569D20
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 10:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbiGGIPD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 04:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbiGGIOO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 04:14:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AED33E02;
        Thu,  7 Jul 2022 01:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5eZgcW5Y2sZJzZNNbBFpVXbAloA1Oj2jgOQ64kwD6ivbg+biEnf3ovajRge8eOY+UkWJfkCMjGrJ8xliAQ4Bn2qQljCZ5sTWVCZ09AJaLgE6cfY913vLqQcQe1MbwAouReA2XreUUqnry5A4HYrg9uN+E0jAuoj0W6y34A2sNOM6J8Bdx6kcMfhuxxDZZOmwxEspXmMm1qdY7yyezvFUKPD1pvn2ndLXrn26uS3VK7Londue5WFKYCrpGZK/DCdGr3nz++YPboNCGaLp7cGVJ3ZcXDvG8k1rxeafK5s0kkgQWIc63Xr3aiVwY+6mi8TU7b720PIFqaUxCxfyzp2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWU0KfDWC5f6t9QC0imSThkm5pE7QY29Uv2fHsND3gQ=;
 b=Q8ek+GCPNCT7x33RzODUb1lLkYjPqHVbgGGuzZhV6Ec8aqykMHFDGkx4+chrCTE+SxBRX36UXceH+gkM5CK5hlqDqyshdpGgYSzh7jtH7hr2tc6m/h/Ul4jbK4wdCdlqu6gNOAoRFnusmQJoUrB35hWI/F4iE6Fo1Stt7ys3a2MvtYDTzfor4Ro9PLVizv2xVfP+xnQZsn9yb+v/X6lI461HNBQLtLNKeWfHzsW0e57Exra8GTwOOAS4CUvllFTHrxt9HnUNFvDgZik1tiKyHaONuQCY/fhH8SGLyq/ByunQ6JfgODCclRmtCIwxlHtpRR5Oiywwmme+/6fzX/G94g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWU0KfDWC5f6t9QC0imSThkm5pE7QY29Uv2fHsND3gQ=;
 b=eULhWQfhAex/tmK0VDYrL+W3QfOboYPIoxtOQq4OXzS7NsxSV4DSP5J6nmwXfqIdzTZVuz7pfaP6VIHt7B9irzlrFqfqh6XGWth0dn7JFSiMNSLKtOxVkieLEh/Ozyqr0zmyWvTmLvJqGrUNIMso7PfoUvCLgB2YRxmwtRSVt8j0InyBftbvE+W7t6SvPHWNxSeqoE15fhJO3POdBGMm6iG9RItBfNb0It1STEz4X05HcDJjYJEhZsMsSBF9Sw+K1U6ljpOk+R3jRuuVK5Oi44GiA/otMQeOtu2KzELVAHnjIbVjCc9EML7fsw8LV9vqgZcsyAzBZXqMaPGfnoTzRw==
Received: from MWHPR13CA0035.namprd13.prod.outlook.com (2603:10b6:300:95::21)
 by DM6PR12MB3401.namprd12.prod.outlook.com (2603:10b6:5:39::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Thu, 7 Jul
 2022 08:14:09 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::b8) by MWHPR13CA0035.outlook.office365.com
 (2603:10b6:300:95::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.9 via Frontend
 Transport; Thu, 7 Jul 2022 08:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 08:14:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 7 Jul
 2022 08:14:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 7 Jul 2022
 01:14:07 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 7 Jul 2022 01:14:03 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4 9/9] PCI: tegra: Add Tegra234 PCIe support
Date:   Thu, 7 Jul 2022 13:43:01 +0530
Message-ID: <20220707081301.29961-10-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220707081301.29961-1-vidyas@nvidia.com>
References: <20220707081301.29961-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7729bfb-75b5-4691-7ab5-08da5ff0aaea
X-MS-TrafficTypeDiagnostic: DM6PR12MB3401:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4i5UPil1skHSL0ff6NxWeIHHb+3zxwjBwZp1eYL9tg2cxyBkBqEZvsMRmObQOCiUEVdFfzOcqKSTzGbfaJtGBSt0WEMfsTy4509oYJjyv34q0YW6amg7eiZsIp5oBGcaCX44KdgEcMmnYe/twHaBEBd7qoEdm9Z/YUVRpiZY/RO1alxhI5NP5Bvoproo5HleQWwfMtI3TDzPOlKivuRV9ka4HPn3o7QCG2MmwphzeXb07AdbMhs/12AhgI/CKtUjx8KKkyiMTTAcUnuI449YqSHM4uH/IJdOv/UqfcwDzzvVNM06WiuNVyulSHHpDP9gJaO5jlEbBu5U3krtxMKszBB0iCcxCf873soATCfUTYbqwNNI3YeGDKUtNubQvERXdPtLq0v231Epe0L6gpuuhfBSX7UkGCgqItlWe63ySyQIs5C7tDLc3rGzc3AUOO6pzQZvriEXadDlWfGscukg4cdIEVRXcEa0I/i4XC1Fsf1MKE2ygelE+WWO5dCr3nM1BV8GfZb9SAL861/S1PjiGsYh6mppnlRm4CeqJSRRoOruBVhvDz/AJKYngl6pPW1BO0a2fB0jI101Z4wmDx++cyC5VtL8UuXk1dQcTa/ZnZO8PEEfv0gVTasGD6i9d1ViImKyI+eTZ2qsc7GnPul2CV2ghEes/RDIj3hKY/h1ZZSi2Sp4etaUZszvw7fHimhCJieJ1O7Ogw8iXEgUraD71dYTETkG0tlmmjLZzvRX5FSUGmBr6krehL7YK9Lt7mC+apD3Z/Xxw6NkGpKggo0Q2XK19KglKaGVT9CNaaiFRjQjLTfGOOpY0e2UhlQKSm62trrXypQAcZ0HJIe+kWuFHwFFR07nYUPzhiu/hnref135iwKHY7CvMLHcJH8f3wfQ
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(396003)(36840700001)(46966006)(40470700004)(40460700003)(81166007)(4326008)(82310400005)(7416002)(186003)(110136005)(41300700001)(426003)(7696005)(336012)(54906003)(26005)(47076005)(316002)(36756003)(83380400001)(2906002)(8676002)(30864003)(1076003)(8936002)(5660300002)(40480700001)(86362001)(70586007)(2616005)(36860700001)(82740400003)(70206006)(478600001)(356005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 08:14:08.9067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7729bfb-75b5-4691-7ab5-08da5ff0aaea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3401
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for Synopsys DesignWare core IP based PCIe host controllers
present in the Tegra234 SoC.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V4:
* None

V3:
* Addressed review comment from Raul Tambre

V2:
* Rebased on top of the previous patch

 drivers/pci/controller/dwc/pcie-tegra194.c | 412 ++++++++++++++++-----
 1 file changed, 319 insertions(+), 93 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index bd16245fc2c4..f5dbfdfe3887 100644
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
@@ -243,6 +249,18 @@ static const unsigned int pcie_gen_freq[] = {
 	GEN4_CORE_CLK_FREQ
 };
 
+struct tegra_pcie_dw_of_data {
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
 struct tegra_pcie_dw {
 	struct device *dev;
 	struct resource *appl_res;
@@ -255,12 +273,14 @@ struct tegra_pcie_dw {
 	struct dw_pcie pci;
 	struct tegra_bpmp *bpmp;
 
-	enum dw_pcie_device_mode mode;
+	struct tegra_pcie_dw_of_data *of_data;
 
 	bool supports_clkreq;
 	bool enable_cdm_check;
+	bool enable_srns;
 	bool link_state;
 	bool update_fc_fixup;
+	bool enable_ext_refclk;
 	u8 init_link_width;
 	u32 msi_ctrl_int;
 	u32 num_lanes;
@@ -284,13 +304,10 @@ struct tegra_pcie_dw {
 	struct gpio_desc *pex_rst_gpiod;
 	struct gpio_desc *pex_refclk_sel_gpiod;
 	unsigned int pex_rst_irq;
+	bool pex_rst_irq_enabled;
 	int ep_state;
 };
 
-struct tegra_pcie_dw_of_data {
-	enum dw_pcie_device_mode mode;
-};
-
 static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
 {
 	return container_of(pci, struct tegra_pcie_dw, pci);
@@ -350,15 +367,15 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
 	struct tegra_pcie_dw *pcie = arg;
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
@@ -374,15 +391,21 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
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
@@ -394,25 +417,24 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
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
@@ -454,6 +476,9 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 		PCI_EXP_LNKSTA_CLS;
 	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
 
+	if (!pcie->of_data->ltr_req_fixup)
+		return IRQ_HANDLED;
+
 	/* If EP doesn't advertise L1SS, just return */
 	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
 	if (!(val & (PCI_L1SS_CAP_ASPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_2)))
@@ -538,13 +563,18 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 static int tegra_pcie_dw_rd_own_conf(struct pci_bus *bus, u32 devfn, int where,
 				     int size, u32 *val)
 {
+	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
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
@@ -555,13 +585,18 @@ static int tegra_pcie_dw_rd_own_conf(struct pci_bus *bus, u32 devfn, int where,
 static int tegra_pcie_dw_wr_own_conf(struct pci_bus *bus, u32 devfn, int where,
 				     int size, u32 val)
 {
+	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
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
@@ -709,13 +744,15 @@ static void tegra_pcie_enable_system_interrupts(struct pcie_port *pp)
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
@@ -842,7 +879,8 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 
 	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
 	val &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK;
-	val |= (0x360 << GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT);
+	val |= (pcie->of_data->gen4_preset_vec <<
+		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT);
 	val &= ~GEN3_EQ_CONTROL_OFF_FB_MODE_MASK;
 	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
 
@@ -856,6 +894,7 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val;
+	u16 val_16;
 
 	pp->bridge->ops = &tegra_pci_ops;
 
@@ -863,6 +902,11 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
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
@@ -887,6 +931,15 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
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
@@ -897,9 +950,11 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
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
@@ -919,8 +974,11 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
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
 
@@ -978,7 +1036,7 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 		offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_DLF);
 		val = dw_pcie_readl_dbi(pci, offset + PCI_DLF_CAP);
 		val &= ~PCI_DLF_EXCHANGE_ENABLE;
-		dw_pcie_writel_dbi(pci, offset, val);
+		dw_pcie_writel_dbi(pci, offset + PCI_DLF_CAP, val);
 
 		tegra_pcie_dw_host_init(pp);
 		dw_pcie_setup_rc(pp);
@@ -1111,13 +1169,26 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
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
@@ -1161,8 +1232,11 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
 
-	/* Controller-5 doesn't need to have its state set by BPMP-FW */
-	if (pcie->cid == 5)
+	/*
+	 * Controller-5 doesn't need to have its state set by BPMP-FW in
+	 * Tegra194
+	 */
+	if (pcie->cid == 5 && pcie->of_data->version == TEGRA194_DWC_IP_VER)
 		return 0;
 
 	memset(&req, 0, sizeof(req));
@@ -1328,6 +1402,14 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
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
@@ -1351,11 +1433,13 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
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
@@ -1382,6 +1466,19 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 	val |= (APPL_CFG_MISC_ARCACHE_VAL << APPL_CFG_MISC_ARCACHE_SHIFT);
 	appl_writel(pcie, val, APPL_CFG_MISC);
 
+	if (pcie->enable_srns || pcie->enable_ext_refclk) {
+		/*
+		 * When Tegra PCIe RP is using external clock, it cannot
+		 * supply same clock to its downstream hierarchy.
+		 * Hence, gate PCIe RP REFCLK out pads when RP & EP are
+		 * using separate clocks or RP is using an external REFCLK.
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
@@ -1407,6 +1504,9 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 fail_reg_en:
 	tegra_pcie_disable_slot_regulators(pcie);
 fail_slot_reg_en:
+	if (pcie->enable_ext_refclk)
+		tegra_pcie_bpmp_set_pll_state(pcie, false);
+fail_pll_init:
 	tegra_pcie_bpmp_set_ctrl_state(pcie, false);
 
 	return ret;
@@ -1434,6 +1534,12 @@ static void tegra_pcie_unconfig_controller(struct tegra_pcie_dw *pcie)
 
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
@@ -1634,6 +1740,13 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 
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
@@ -1649,6 +1762,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	struct device *dev = pcie->dev;
 	u32 val;
 	int ret;
+	u16 val_16;
 
 	if (pcie->ep_state == EP_STATE_ENABLED)
 		return;
@@ -1660,10 +1774,20 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
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
@@ -1760,12 +1884,29 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
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
@@ -1782,6 +1923,13 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
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
@@ -1802,6 +1950,8 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 fail_core_clk_enable:
 	tegra_pcie_bpmp_set_pll_state(pcie, false);
 fail_pll_init:
+	tegra_pcie_bpmp_set_ctrl_state(pcie, false);
+fail_set_ctrl_state:
 	pm_runtime_put_sync(dev);
 }
 
@@ -1931,6 +2081,7 @@ static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
 
 	irq_set_status_flags(pcie->pex_rst_irq, IRQ_NOAUTOEN);
 
+	pcie->pex_rst_irq_enabled = false;
 	pcie->ep_state = EP_STATE_DISABLED;
 
 	ret = devm_request_threaded_irq(dev, pcie->pex_rst_irq, NULL,
@@ -1978,14 +2129,13 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	pci = &pcie->pci;
 	pci->dev = &pdev->dev;
 	pci->ops = &tegra_dw_pcie_ops;
-	pci->n_fts[0] = N_FTS_VAL;
-	pci->n_fts[1] = FTS_VAL;
-	pci->version = 0x490A;
-
+	pcie->dev = &pdev->dev;
+	pcie->of_data = (struct tegra_pcie_dw_of_data *)data;
+	pci->n_fts[0] = pcie->of_data->n_fts[0];
+	pci->n_fts[1] = pcie->of_data->n_fts[1];
+	pci->version = pcie->of_data->version;
 	pp = &pci->pp;
 	pp->num_vectors = MAX_MSI_IRQS;
-	pcie->dev = &pdev->dev;
-	pcie->mode = (enum dw_pcie_device_mode)data->mode;
 
 	ret = tegra_pcie_dw_parse_dt(pcie);
 	if (ret < 0) {
@@ -2102,7 +2252,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
-	switch (pcie->mode) {
+	switch (pcie->of_data->mode) {
 	case DW_PCIE_RC_TYPE:
 		ret = devm_request_irq(dev, pp->irq, tegra_pcie_rp_irq_handler,
 				       IRQF_SHARED, "tegra-pcie-intr", pcie);
@@ -2137,7 +2287,8 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		break;
 
 	default:
-		dev_err(dev, "Invalid PCIe device type %d\n", pcie->mode);
+		dev_err(dev, "Invalid PCIe device type %d\n",
+			pcie->of_data->mode);
 	}
 
 fail:
@@ -2149,12 +2300,19 @@ static int tegra_pcie_dw_remove(struct platform_device *pdev)
 {
 	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
 
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
@@ -2168,15 +2326,22 @@ static int tegra_pcie_dw_suspend_late(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
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
@@ -2231,7 +2396,7 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	u32 val;
 
-	if (pcie->mode == DW_PCIE_EP_TYPE) {
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
 		dev_err(dev, "Suspend is not supported in EP mode");
 		return -ENOTSUPP;
 	}
@@ -2240,13 +2405,15 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
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
@@ -2255,36 +2422,95 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 {
 	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
 
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
 
-	tegra_pcie_dw_pme_turnoff(pcie);
-	tegra_pcie_unconfig_controller(pcie);
+		tegra_pcie_dw_pme_turnoff(pcie);
+		tegra_pcie_unconfig_controller(pcie);
+		pm_runtime_put_sync(pcie->dev);
+	} else {
+		if (pcie->pex_rst_irq_enabled)
+			disable_irq(pcie->pex_rst_irq);
+		pex_ep_event_pex_rst_assert(pcie);
+	}
 }
 
-static const struct tegra_pcie_dw_of_data tegra_pcie_dw_rc_of_data = {
+static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_rc_of_data = {
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
+static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_ep_of_data = {
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
+static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_rc_of_data = {
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
 
-static const struct tegra_pcie_dw_of_data tegra_pcie_dw_ep_of_data = {
+static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
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
 
 static const struct of_device_id tegra_pcie_dw_of_match[] = {
 	{
 		.compatible = "nvidia,tegra194-pcie",
-		.data = &tegra_pcie_dw_rc_of_data,
+		.data = &tegra194_pcie_dw_rc_of_data,
 	},
 	{
 		.compatible = "nvidia,tegra194-pcie-ep",
-		.data = &tegra_pcie_dw_ep_of_data,
+		.data = &tegra194_pcie_dw_ep_of_data,
+	},
+	{
+		.compatible = "nvidia,tegra234-pcie",
+		.data = &tegra234_pcie_dw_rc_of_data,
+	},
+	{
+		.compatible = "nvidia,tegra234-pcie-ep",
+		.data = &tegra234_pcie_dw_ep_of_data,
 	},
 	{},
 };
-- 
2.17.1

