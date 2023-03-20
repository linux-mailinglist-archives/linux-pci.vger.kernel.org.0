Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915856C1FFA
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 19:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjCTSg2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 14:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjCTSgE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 14:36:04 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86F237F38;
        Mon, 20 Mar 2023 11:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmiMnZ1/j8sdZnP921Gslt+cGB4GQ8OgE7CgeW1jsCDA8SxkJ+H3DL6OGQs2Gi4dCGnhbQy5yvDeuAh9QSkRtqhaQQC+TeAKzFmL+Lm0cOHJXOAKtW9zoU9NiR3m0NG0VCspz4lLZdPPcGculkNnJQbmWAkxulFI9aoxiYzUe6lGCnssjAAL/NC04+Vd4MZavTEr5Sq6yHI7zNhyeUqeJjNwqgF773e4P3tFJ9jwJ4eB9Cw5HE9RnF8I3U3A2DgWmm6Id8Wzs/vOWJrnozliyqKKG80V3QEfx19K6JkT4zAQ4PSY8O+cY/HE48ANmG3OgEz3u03QLkougNsFxWkYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zl/Zq3udnXoPPmPhp/uzEpbABsNB15gy+KqjcHFYdzA=;
 b=WHfnWkNKP2P1xHHx+LBsR9cVMo20I05SQwoFO2cosF/8W5hBD8/qAk2JODoyM3TLwRbB2A3DYDpCoo32RIaJNAihkUCWW79jRk67SFoJaB+yCbRrANDT8erku+ijlXC4Bl/qcQWSzHHssz5AVagILGBJGbs6icjiPTf3RM6+u3OhqaExNSglTrvJP2M3WOvWbv4VPaByNdT25BrHFQShp9mJZK6Tu5Hal28QGyzZatXjBDqsNTfEpyLxDxeYTpqdsFVPRajjjtDUlhFuHV+7K3BfyAe+A8iOckaRy/yUjNqqVOYkDWGxb3jO9tyO/ELdS6JDW3b2Lv/uGDTRIKe37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zl/Zq3udnXoPPmPhp/uzEpbABsNB15gy+KqjcHFYdzA=;
 b=hSE1ku6SK16qx42p6Y12lkhLqqwxMnvBsDY+eo39Y9/GrPikgPcFGdl5cC4oF3h3LBkwM6vYdTqz4F7Cm54Xm6SHs2tBRyKZB2EVWpfrHopRhxsGvxz+r35i05eGjv76nakyoxmxmpruX4bPdQpU/qjf8SRTmZlF7+bQfFPwDV96qLz34zgOZ0LFuAukgpz91ZEOHR5hdSygEcry4jwJvScKOxOT0e2Vx/e9CIPLh5yDQK9dXgdyjK1YuBaGzck5Z7WSqVyKig90dOvo2xpf+G4yzm2G47ExGIZEHBa4iuP4YMRYNdKZJ1ZgEbbdRmHHK3KVrWhmsC/YknfYCgAn0Q==
Received: from MW4PR03CA0112.namprd03.prod.outlook.com (2603:10b6:303:b7::27)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.33; Mon, 20 Mar 2023 18:26:55 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::24) by MW4PR03CA0112.outlook.office365.com
 (2603:10b6:303:b7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 18:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 18:26:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 11:26:44 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 20 Mar 2023 11:26:43 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 20 Mar 2023 11:26:38 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kw@linux.com>, <bhelgaas@google.com>, <vidyas@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v3 09/11] PCI: tegra194: add interconnect support in Tegra234
Date:   Mon, 20 Mar 2023 23:54:39 +0530
Message-ID: <20230320182441.11904-10-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230320182441.11904-1-sumitg@nvidia.com>
References: <20230320182441.11904-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: ae155388-fa7c-457b-8371-08db2970aedf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMnkquGLqRaEEgbELFAsbTF8R0NuQrvFQrEB9fBQiGZsNpiCQZTspmRH1+PWFFXlASfgM5yimOjvLTMn+EZ93BayQr0S6gnngVDh7Gm2wfuuToXwbBNyi6RGM7a+KpwQ8DrCYVMz/OaPN/+A8IkrBq8C9MxkFCJt2IVeIpU/veZpFItmXf30tJKGqsFKBjbH/RqH9oz/DNutSLmPw4ep8k7hxnPbfOC9j3sGFEjlvmSsJkA6RQBR2hxKHOVK8YfZNYBvinLyqOHoz3vHn0cI36fMjBckAxq8vxTTFn17dAHMZve/mcDc1qpMiokIjUh+hFywWoHHvlYg9os+rWUg1lKb0q7xpQnD/XlgN9jM9jVsjF1Q+xyajdTBJnxtZ61PA/52ueCK24OiQELhwXLVMjNaRKM2ptXk/u1USuXwFQ9XNrMwp7eBqeT//qMqpi7UwOg+qWo2jZzRmdu9WSgjpt/AaMIKBUWdwJqEeOSI3dC7OBgCcv7SkpJ0l8A3nz8LrqzS+XIeUFGhM2FkVA3ZyeDGlwXj91/pQZ+uheh3DHntFdS3YExj5eQZQaoaR8yEC62gjuMjEbcHFDdKk71TYTzgxuwBsMg7/fuW+cBhF2DCC6jpgK/eJZ++pf5fQvcMnCM7pCc1LzyLiuWyMUKKwup1IAwk1HoE+SkhASGNREKwbZ352OPu7V5Lnvd+8czxaQuGABCOORPx0WnU3J74VpAaObBNpcG5xM1JV6sCtQoYQm1GsoOr4M3b7rJ3Clf/
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199018)(36840700001)(46966006)(40470700004)(8936002)(5660300002)(7416002)(41300700001)(83380400001)(40460700003)(36860700001)(1076003)(40480700001)(82740400003)(86362001)(36756003)(82310400005)(356005)(7636003)(2906002)(110136005)(54906003)(7696005)(316002)(2616005)(107886003)(478600001)(26005)(426003)(186003)(70206006)(70586007)(8676002)(336012)(4326008)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:26:54.9079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae155388-fa7c-457b-8371-08db2970aedf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to request DRAM bandwidth with Memory Interconnect
in Tegra234 SoC. The DRAM BW required for different modes depends
on speed (Gen-1/2/3/4) and width/lanes (x1/x2/x4/x8).

Suggested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 40 +++++++++++++++++-----
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 09825b4a075e..d2513c9d3feb 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -15,6 +15,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
+#include <linux/interconnect.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -287,6 +288,7 @@ struct tegra_pcie_dw {
 	unsigned int pex_rst_irq;
 	int ep_state;
 	long link_status;
+	struct icc_path *icc_path;
 };
 
 static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
@@ -309,6 +311,24 @@ struct tegra_pcie_soc {
 	enum dw_pcie_device_mode mode;
 };
 
+static void tegra_pcie_icc_set(struct tegra_pcie_dw *pcie)
+{
+	struct dw_pcie *pci = &pcie->pci;
+	u32 val, speed, width;
+
+	val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
+
+	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
+	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
+
+	val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) / BITS_PER_BYTE);
+
+	if (icc_set_bw(pcie->icc_path, MBps_to_icc(val), 0))
+		dev_err(pcie->dev, "can't set bw[%u]\n", val);
+
+	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+}
+
 static void apply_bad_link_workaround(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -452,14 +472,12 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 	struct tegra_pcie_dw *pcie = arg;
 	struct dw_pcie_ep *ep = &pcie->pci.ep;
 	struct dw_pcie *pci = &pcie->pci;
-	u32 val, speed;
+	u32 val;
 
 	if (test_and_clear_bit(0, &pcie->link_status))
 		dw_pcie_ep_linkup(ep);
 
-	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
-		PCI_EXP_LNKSTA_CLS;
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+	tegra_pcie_icc_set(pcie);
 
 	if (pcie->of_data->has_ltr_req_fix)
 		return IRQ_HANDLED;
@@ -945,9 +963,9 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 
 static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 {
-	u32 val, offset, speed, tmp;
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	struct dw_pcie_rp *pp = &pci->pp;
+	u32 val, offset, tmp;
 	bool retry = true;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
@@ -1018,9 +1036,7 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 		goto retry_link;
 	}
 
-	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
-		PCI_EXP_LNKSTA_CLS;
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+	tegra_pcie_icc_set(pcie);
 
 	tegra_pcie_enable_interrupts(pp);
 
@@ -2224,6 +2240,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	pcie->icc_path = devm_of_icc_get(&pdev->dev, "write");
+	ret = PTR_ERR_OR_ZERO(pcie->icc_path);
+	if (ret) {
+		tegra_bpmp_put(pcie->bpmp);
+		dev_err_probe(&pdev->dev, ret, "failed to get write interconnect\n");
+		return ret;
+	}
+
 	switch (pcie->of_data->mode) {
 	case DW_PCIE_RC_TYPE:
 		ret = devm_request_irq(dev, pp->irq, tegra_pcie_rp_irq_handler,
-- 
2.17.1

