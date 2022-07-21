Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A46657CD7E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiGUOXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiGUOXP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:23:15 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC7C823A4;
        Thu, 21 Jul 2022 07:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdKjy7pDARJiqD8/h5odzXZsMQb8haJCaUuGi3cdBk8USd+HFsyOt7gqv4trcdLsWpQusSlM8B9PH9FnU8ukRCjYqd9RBlAjA76+wrGc1RGvrMwxYw0/7f/arLhceh4bzymPNPc9vaYJZwl8kIu5UPcvy9N0wl+LLQLP/OvkgfjAFmH8qKnqZtq9bSox56WpGjcyP4f7HcpYct8YVU1Eh5T1uhmbQyT/T+nMwdawRDUjjUNWXfpxJNURByIaWe6UzGnMHoRvgoQKiVs6LoguVZiU1mWAB4qjhm1s0R7CNINEtDnu0v9DkPAXR2eysUKNi1Z+2UR8sZ9auZhpIpQAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuUro1IyLLI1/Kw9jGDtA6iYezMmX4LhuiHUrDy8Sow=;
 b=QzIJgHVJ4iVLj2X/N8VU+ypDfv7tqWX+9JQMglYajcB96dwt0JlpHdLPFPLRHr6DIHs/ibOkamg/lUeh+Xxl8t9fEJO5u1i8/2iArTPy7VL05S8410phxuob1d/DeH33LJBJml0kvydGy88gN/ZXINWrCLt9Rc9OY2iTp8KdNvUhlhy3PfwpopmlpRUQNSYPwRPmYKN/mGl+Dh6zTtXsjGgtENDq23/WM9U7qOwLG1i0TKwqTVA1Dhtr13fNmLtnMl0MU5vbLMmfLzdCOof6kTnAKfS1N8GB3mO7dw4wC7j3VFhisV/t/NsocUXw0IJtQ7dFvJMIE4TKey7WHBjt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuUro1IyLLI1/Kw9jGDtA6iYezMmX4LhuiHUrDy8Sow=;
 b=tzUQkLJyyOR96s6StUyr5grtVa2ZYH+uAJ+2IUUrBbSNVwvbf6e0WUsD4uTSlSH8gi7OsVEbCESQL3wp2AF1Iltd8V/FDOeQ+oZF7IJlQXSrEYwdrFizc1MD9mtNURLUDxOQG9BH42BR+dm+AZsmRAOWap2cxvBQ2Ax96OXt+DVTl8qN+JQTEDNzUJHeVtmOL+aFZlI14XTP42jy4PRqx8VANqc+r6/DyqGyhUPr3vO/nqOsa4RIlDKl3p5zUkGIkZaE5v0cmg4BOseKMSPBVdJud5sQBE2HxNFIX6q9LUgNqlZ1RqRv7ADH3vrE15TAi2OwfrKhPs8jpWDbJZl8Vw==
Received: from BN9PR03CA0103.namprd03.prod.outlook.com (2603:10b6:408:fd::18)
 by CH2PR12MB3733.namprd12.prod.outlook.com (2603:10b6:610:15::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Thu, 21 Jul
 2022 14:22:57 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::81) by BN9PR03CA0103.outlook.office365.com
 (2603:10b6:408:fd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Thu, 21 Jul 2022 14:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 14:22:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 21 Jul 2022 14:22:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 21 Jul 2022 07:22:56 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 21 Jul 2022 07:22:51 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V6 16/16] PCI: tegra: Add Tegra234 PCIe support
Date:   Thu, 21 Jul 2022 19:50:52 +0530
Message-ID: <20220721142052.25971-17-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721142052.25971-1-vidyas@nvidia.com>
References: <20220721142052.25971-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17fd52ea-a1fc-4ff0-eb5d-08da6b24824e
X-MS-TrafficTypeDiagnostic: CH2PR12MB3733:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVIKS9tJqcCPdMPzODjsODKnpubvH19hZoXs3/YugqDY5HaucZVNMBcTQgPz21GAFyrp6SMJJs9AwUa8vDvDHMZ7L5RG1Ev9pIR7aAG5VlAEte7Edf5Q8BT683xo4XEKfqNH+pgod1RHdLUkjH826fZP4aOw09vrCEKcWgTZJIBNPA8vXfhoO9UzVI6J8sFHx5kKRViC0/PRqxEIYucLRCBuQRW+HUCeUK+JFV+eErdeExxjvXtjbEZphz1c8fnTQSyog+gCzq3jzvzuztdGbvmPe2yfC6IXl5ZIT/M5p/EeC0PHbShx8uFqv8KwXguMAPu7tLoFc0VnjYRP0i9ChiUPvn7S73igykDAIZ1iZcF1vtbQshqEeo/gfWUhIuPx9Xp74ANHR0cFltjCuCKIHsQygAmT6NLrMcREOuHlACVWmazkzcCoRj5T64sa1js9MOBJHvLCZL7FOHj8lWSqJCK4sqneZOxDn7TreJW8+UOMxHrZ6JOmTBtyUXV/uICcqedy4g7Rm0h81zfKSPbL5yinP5hBdue+SLk8dvA3V0zEhUSx9VOqHLsWEq1qE6FZ6oA7oMUhEEz4VQomoMNtyZJzEWfBqun/39Ea0FcKcV9+C8p3Wk7qExyjLh57sQXUEyOpPxo6DQqPFf+1VeOWhDYtjfKaRGOK6A0/S5NzAOFO6Lq1SsJPcVExEHZzFVbvTnkVVjHWcfW+yM45laOYyQbLFuNbg+qTsmnz2+n0sKe6UsLz11dN08dTpGTLw7YUkcaDEgBft+CdAO7fXGigaRq8lsTvro0YhtM+QBtcckFpzFcYtMMNa71T0eHLOsfdkrq4qErpyUiJXGkBw3MvViOw0fnuSpppsHSBtmM5Kkg=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966006)(40470700004)(36840700001)(26005)(70586007)(8676002)(7416002)(478600001)(4326008)(336012)(40460700003)(83380400001)(5660300002)(82740400003)(356005)(41300700001)(8936002)(40480700001)(7696005)(81166007)(36860700001)(30864003)(2906002)(186003)(316002)(86362001)(70206006)(82310400005)(36756003)(54906003)(2616005)(426003)(110136005)(47076005)(1076003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:22:57.2895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fd52ea-a1fc-4ff0-eb5d-08da6b24824e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3733
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for Synopsys DesignWare core IP based PCIe host controllers
present in the Tegra234 SoC.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V6:
* Addressed review comment from Bjorn
* Moved out all non-Tegra234 code to separate patches

V5:
* None

V4:
* None

V3:
* Addressed review comment from Raul Tambre

V2:
* Rebased on top of the previous patch

 drivers/pci/controller/dwc/pcie-tegra194.c | 284 ++++++++++++++++-----
 1 file changed, 225 insertions(+), 59 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index fc373b6efd00..624c3fd9297f 100644
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
@@ -230,6 +236,18 @@ static const unsigned int pcie_gen_freq[] = {
 	GEN4_CORE_CLK_FREQ
 };
 
+struct tegra_pcie_dw_of_data {
+	u32 version;
+	enum dw_pcie_device_mode mode;
+	bool has_msix_doorbell_access_fix;
+	bool has_sbr_reset_fix;
+	bool has_l1ss_exit_fix;
+	bool has_ltr_req_fix;
+	u32 cdm_chk_int_en_bit;
+	u32 gen4_preset_vec;
+	u8 n_fts[2];
+};
+
 struct tegra_pcie_dw {
 	struct device *dev;
 	struct resource *appl_res;
@@ -242,12 +260,14 @@ struct tegra_pcie_dw {
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
@@ -275,10 +295,6 @@ struct tegra_pcie_dw {
 	int ep_state;
 };
 
-struct tegra_pcie_dw_of_data {
-	enum dw_pcie_device_mode mode;
-};
-
 static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
 {
 	return container_of(pci, struct tegra_pcie_dw, pci);
@@ -345,7 +361,8 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
 	if (status_l0 & APPL_INTR_STATUS_L0_LINK_STATE_INT) {
 		status_l1 = appl_readl(pcie, APPL_INTR_STATUS_L1_0_0);
 		appl_writel(pcie, status_l1, APPL_INTR_STATUS_L1_0_0);
-		if (status_l1 & APPL_INTR_STATUS_L1_0_0_LINK_REQ_RST_NOT_CHGED) {
+		if (!pcie->of_data->has_sbr_reset_fix &&
+		    status_l1 & APPL_INTR_STATUS_L1_0_0_LINK_REQ_RST_NOT_CHGED) {
 			/* SBR & Surprise Link Down WAR */
 			val = appl_readl(pcie, APPL_CAR_RESET_OVRD);
 			val &= ~APPL_CAR_RESET_OVRD_CYA_OVERRIDE_CORE_RST_N;
@@ -446,6 +463,9 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 		PCI_EXP_LNKSTA_CLS;
 	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
 
+	if (pcie->of_data->has_ltr_req_fix)
+		return IRQ_HANDLED;
+
 	/* If EP doesn't advertise L1SS, just return */
 	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
 	if (!(val & (PCI_L1SS_CAP_ASPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_2)))
@@ -530,13 +550,18 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
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
+	if (!pcie->of_data->has_msix_doorbell_access_fix &&
+	    !PCI_SLOT(devfn) && where == PORT_LOGIC_MSIX_DOORBELL) {
 		*val = 0x00000000;
 		return PCIBIOS_SUCCESSFUL;
 	}
@@ -547,13 +572,18 @@ static int tegra_pcie_dw_rd_own_conf(struct pci_bus *bus, u32 devfn, int where,
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
+	if (!pcie->of_data->has_msix_doorbell_access_fix &&
+	    !PCI_SLOT(devfn) && where == PORT_LOGIC_MSIX_DOORBELL)
 		return PCIBIOS_SUCCESSFUL;
 
 	return pci_generic_config_write(bus, devfn, where, size, val);
@@ -692,13 +722,15 @@ static void tegra_pcie_enable_system_interrupts(struct pcie_port *pp)
 	val |= APPL_INTR_EN_L0_0_LINK_STATE_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L0_0);
 
-	val = appl_readl(pcie, APPL_INTR_EN_L1_0_0);
-	val |= APPL_INTR_EN_L1_0_0_LINK_REQ_RST_NOT_INT_EN;
-	appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
+	if (!pcie->of_data->has_sbr_reset_fix) {
+		val = appl_readl(pcie, APPL_INTR_EN_L1_0_0);
+		val |= APPL_INTR_EN_L1_0_0_LINK_REQ_RST_NOT_INT_EN;
+		appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
+	}
 
 	if (pcie->enable_cdm_check) {
 		val = appl_readl(pcie, APPL_INTR_EN_L0_0);
-		val |= APPL_INTR_EN_L0_0_CDM_REG_CHK_INT_EN;
+		val |= pcie->of_data->cdm_chk_int_en_bit;
 		appl_writel(pcie, val, APPL_INTR_EN_L0_0);
 
 		val = appl_readl(pcie, APPL_INTR_EN_L1_18);
@@ -825,7 +857,8 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 
 	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
 	val &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK;
-	val |= (0x360 << GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT);
+	val |= (pcie->of_data->gen4_preset_vec <<
+		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT);
 	val &= ~GEN3_EQ_CONTROL_OFF_FB_MODE_MASK;
 	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
 
@@ -876,6 +909,15 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
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
@@ -886,9 +928,11 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 		disable_aspm_l12(pcie);
 	}
 
-	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+	if (!pcie->of_data->has_l1ss_exit_fix) {
+		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+	}
 
 	if (pcie->update_fc_fixup) {
 		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
@@ -908,7 +952,7 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 	struct pcie_port *pp = &pci->pp;
 	bool retry = true;
 
-	if (pcie->mode == DW_PCIE_EP_TYPE) {
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
 		enable_irq(pcie->pex_rst_irq);
 		return 0;
 	}
@@ -1100,13 +1144,27 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 	if (of_property_read_bool(np, "nvidia,update-fc-fixup"))
 		pcie->update_fc_fixup = true;
 
+	/* RP using an external REFCLK is supported only in Tegra234 */
+	if (pcie->of_data->version == TEGRA194_DWC_IP_VER) {
+		if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+			pcie->enable_ext_refclk = true;
+	} else {
+		pcie->enable_ext_refclk =
+			of_property_read_bool(pcie->dev->of_node,
+					      "nvidia,enable-ext-refclk");
+	}
+
 	pcie->supports_clkreq =
 		of_property_read_bool(pcie->dev->of_node, "supports-clkreq");
 
 	pcie->enable_cdm_check =
 		of_property_read_bool(np, "snps,enable-cdm-check");
 
-	if (pcie->mode == DW_PCIE_RC_TYPE)
+	if (pcie->of_data->version == TEGRA234_DWC_IP_VER)
+		pcie->enable_srns =
+			of_property_read_bool(np, "nvidia,enable-srns");
+
+	if (pcie->of_data->mode == DW_PCIE_RC_TYPE)
 		return 0;
 
 	/* Endpoint mode specific DT entries */
@@ -1150,8 +1208,11 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
 
-	/* Controller-5 doesn't need to have its state set by BPMP-FW */
-	if (pcie->cid == 5)
+	/*
+	 * Controller-5 doesn't need to have its state set by BPMP-FW in
+	 * Tegra194
+	 */
+	if (pcie->of_data->version == TEGRA194_DWC_IP_VER && pcie->cid == 5)
 		return 0;
 
 	memset(&req, 0, sizeof(req));
@@ -1317,6 +1378,14 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
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
@@ -1340,11 +1409,13 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 		goto fail_core_apb_rst;
 	}
 
-	if (en_hw_hot_rst) {
+	if (en_hw_hot_rst || pcie->of_data->has_sbr_reset_fix) {
 		/* Enable HW_HOT_RST mode */
 		val = appl_readl(pcie, APPL_CTRL);
 		val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
 			 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+		val |= (APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN <<
+			APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
 		val |= APPL_CTRL_HW_HOT_RST_EN;
 		appl_writel(pcie, val, APPL_CTRL);
 	}
@@ -1371,6 +1442,19 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 	val |= (APPL_CFG_MISC_ARCACHE_VAL << APPL_CFG_MISC_ARCACHE_SHIFT);
 	appl_writel(pcie, val, APPL_CFG_MISC);
 
+	if (pcie->enable_srns || pcie->enable_ext_refclk) {
+		/*
+		 * When Tegra PCIe RP is using external clock, it cannot supply
+		 * same clock to its downstream hierarchy. Hence, gate PCIe RP
+		 * REFCLK out pads when RP & EP are using separate clocks or RP
+		 * is using an external REFCLK.
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
@@ -1396,6 +1480,9 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 fail_reg_en:
 	tegra_pcie_disable_slot_regulators(pcie);
 fail_slot_reg_en:
+	if (pcie->enable_ext_refclk)
+		tegra_pcie_bpmp_set_pll_state(pcie, false);
+fail_pll_init:
 	tegra_pcie_bpmp_set_ctrl_state(pcie, false);
 
 	return ret;
@@ -1423,6 +1510,12 @@ static void tegra_pcie_unconfig_controller(struct tegra_pcie_dw *pcie)
 
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
@@ -1623,6 +1716,13 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 
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
@@ -1657,10 +1757,13 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		goto fail_set_ctrl_state;
 	}
 
-	ret = tegra_pcie_bpmp_set_pll_state(pcie, true);
-	if (ret) {
-		dev_err(dev, "Failed to init UPHY for PCIe EP: %d\n", ret);
-		goto fail_pll_init;
+	if (pcie->enable_ext_refclk) {
+		ret = tegra_pcie_bpmp_set_pll_state(pcie, true);
+		if (ret) {
+			dev_err(dev, "Failed to init UPHY for PCIe EP: %d\n",
+				ret);
+			goto fail_pll_init;
+		}
 	}
 
 	ret = clk_prepare_enable(pcie->core_clk);
@@ -1757,9 +1860,11 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		disable_aspm_l12(pcie);
 	}
 
-	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+	if (!pcie->of_data->has_l1ss_exit_fix) {
+		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+	}
 
 	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 						      PCI_CAP_ID_EXP);
@@ -1769,6 +1874,15 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
 	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
 
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
@@ -1785,6 +1899,13 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	dw_pcie_ep_init_notify(ep);
 
+	/* Program the private control to allow sending LTR upstream */
+	if (pcie->of_data->has_ltr_req_fix) {
+		val = appl_readl(pcie, APPL_LTR_MSG_2);
+		val |= APPL_LTR_MSG_2_LTR_MSG_REQ_STATE;
+		appl_writel(pcie, val, APPL_LTR_MSG_2);
+	}
+
 	/* Enable LTSSM */
 	val = appl_readl(pcie, APPL_CTRL);
 	val |= APPL_CTRL_LTSSM_EN;
@@ -1983,14 +2104,13 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
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
@@ -2107,7 +2227,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
-	switch (pcie->mode) {
+	switch (pcie->of_data->mode) {
 	case DW_PCIE_RC_TYPE:
 		ret = devm_request_irq(dev, pp->irq, tegra_pcie_rp_irq_handler,
 				       IRQF_SHARED, "tegra-pcie-intr", pcie);
@@ -2142,7 +2262,8 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		break;
 
 	default:
-		dev_err(dev, "Invalid PCIe device type %d\n", pcie->mode);
+		dev_err(dev, "Invalid PCIe device type %d\n",
+			pcie->of_data->mode);
 	}
 
 fail:
@@ -2154,7 +2275,7 @@ static int tegra_pcie_dw_remove(struct platform_device *pdev)
 {
 	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
 
-	if (pcie->mode == DW_PCIE_RC_TYPE) {
+	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
 		if (!pcie->link_state)
 			return 0;
 
@@ -2179,7 +2300,7 @@ static int tegra_pcie_dw_suspend_late(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	u32 val;
 
-	if (pcie->mode == DW_PCIE_EP_TYPE) {
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
 		dev_err(dev, "Failed to Suspend as Tegra PCIe is in EP mode\n");
 		return -EPERM;
 	}
@@ -2188,11 +2309,13 @@ static int tegra_pcie_dw_suspend_late(struct device *dev)
 		return 0;
 
 	/* Enable HW_HOT_RST mode */
-	val = appl_readl(pcie, APPL_CTRL);
-	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
-		 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
-	val |= APPL_CTRL_HW_HOT_RST_EN;
-	appl_writel(pcie, val, APPL_CTRL);
+	if (!pcie->of_data->has_sbr_reset_fix) {
+		val = appl_readl(pcie, APPL_CTRL);
+		val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
+			 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+		val |= APPL_CTRL_HW_HOT_RST_EN;
+		appl_writel(pcie, val, APPL_CTRL);
+	}
 
 	return 0;
 }
@@ -2247,7 +2370,7 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	u32 val;
 
-	if (pcie->mode == DW_PCIE_EP_TYPE) {
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
 		dev_err(dev, "Suspend is not supported in EP mode");
 		return -ENOTSUPP;
 	}
@@ -2256,13 +2379,15 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 		return 0;
 
 	/* Disable HW_HOT_RST mode */
-	val = appl_readl(pcie, APPL_CTRL);
-	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
-		 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
-	val |= APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST <<
-	       APPL_CTRL_HW_HOT_RST_MODE_SHIFT;
-	val &= ~APPL_CTRL_HW_HOT_RST_EN;
-	appl_writel(pcie, val, APPL_CTRL);
+	if (!pcie->of_data->has_sbr_reset_fix) {
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
@@ -2271,7 +2396,7 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 {
 	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
 
-	if (pcie->mode == DW_PCIE_RC_TYPE) {
+	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
 		if (!pcie->link_state)
 			return;
 
@@ -2291,24 +2416,65 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 	}
 }
 
-static const struct tegra_pcie_dw_of_data tegra_pcie_dw_rc_of_data = {
+static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_rc_of_data = {
+	.version = TEGRA194_DWC_IP_VER,
 	.mode = DW_PCIE_RC_TYPE,
+	.cdm_chk_int_en_bit = BIT(19),
+	/* Gen4 - 5, 6, 8 and 9 presets enabled */
+	.gen4_preset_vec = 0x360,
+	.n_fts = { 52, 52 },
 };
 
-static const struct tegra_pcie_dw_of_data tegra_pcie_dw_ep_of_data = {
+static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_ep_of_data = {
+	.version = TEGRA194_DWC_IP_VER,
 	.mode = DW_PCIE_EP_TYPE,
+	.cdm_chk_int_en_bit = BIT(19),
+	/* Gen4 - 5, 6, 8 and 9 presets enabled */
+	.gen4_preset_vec = 0x360,
+	.n_fts = { 52, 52 },
+};
+
+static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_rc_of_data = {
+	.version = TEGRA234_DWC_IP_VER,
+	.mode = DW_PCIE_RC_TYPE,
+	.has_msix_doorbell_access_fix = true,
+	.has_sbr_reset_fix = true,
+	.has_l1ss_exit_fix = true,
+	.cdm_chk_int_en_bit = BIT(18),
+	/* Gen4 - 6, 8 and 9 presets enabled */
+	.gen4_preset_vec = 0x340,
+	.n_fts = { 52, 80 },
+};
+
+static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
+	.version = TEGRA234_DWC_IP_VER,
+	.mode = DW_PCIE_EP_TYPE,
+	.has_l1ss_exit_fix = true,
+	.has_ltr_req_fix = true,
+	.cdm_chk_int_en_bit = BIT(18),
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
-	{},
+	{}
 };
 
 static const struct dev_pm_ops tegra_pcie_dw_pm_ops = {
-- 
2.17.1

