Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE15469CF0A
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 15:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjBTOKK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 09:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBTOKI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 09:10:08 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648321E9EF;
        Mon, 20 Feb 2023 06:09:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvTGhxEKEXv6vwfIBdc5C7FQIeN2TXqpXrmzn8lbb7goyFQ5zIgyRPIgHG5P3Bb839lFu6lf+Drz2qdU1Ry+2YzyxY144qC3FwgWu7Bgfp9kxLXN1LvqxeAVIzA8uB+5TBcw9TSlg5Ycpl+Mp+IQ/jsKTuW/Ymp0Ni2xYh0RvYEgJDctXX1YKdgaTw9l6WHmDJGU/c54lM4+WFrBJpwYvD+Z0UGSVRvONEZTt3NVLDV0vnf9yrM69oMPhsZuPVo25bHLcaXJOYLU+t3KfW9O4mwKAXNnncGg/u1NdYy5a6p9Q6f5lKwfGdYLgNQQoDAUIShHHVBPLOqqFFXBPo6XmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zl/Zq3udnXoPPmPhp/uzEpbABsNB15gy+KqjcHFYdzA=;
 b=EWm9U1o79tyWz/YgutfkwXCnYZ0x6ZNQ5cD66UcRBaYQG4bRpciwwo9xKYEocUu21PUuISrOK99ykVXJi8CYCrVvwUiVjoIy6nTsPUZcfh+yIDKAY2OXou6+UKvcVsgTMbiUo+ZJRHrsAJmmeUnjz9b6AhzXSuj7yncphqB4JYulPCI9/YcGbzK/hja3MgSjzI+OQ65VkK4CiY0Sd/Ea6VzHVGgfdSqLewy9Kc+eMn8wmNlCNX9VsXwSgvZDshuTKv4OhjMJEPGlyE8PfKUH7GEDxN0tKYABIHh0p39XS6hq+Qb0AdECEbva7okp8r28dCxNbeXQSqCZo5tb54ABNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zl/Zq3udnXoPPmPhp/uzEpbABsNB15gy+KqjcHFYdzA=;
 b=TxGnZjBmyrsY1wtwmOyTGNoWYYolKTDzWzQZD/JwFRDDIxmRZC/6+fAq0u4Wd1dSENdLhGE89SOKZvZ3KdE6gK843WqLunNa1k8nrdTYE+fRjF+KobTN2zuCYiXjyNSfcffNE1YqzVbTvurJMzkZKZyb/BfM5OU4R1PCb70CcNKvxftspfJRRDOemxxcw1st6AvFzQEHZvhoMxU4yjVKQgx2rXGeNAjT/xhvS1fC+W6GEE0+RWMC6Iw3zEK3n2RLRfJw9Tj3fjNkoxfRnv8evMZ3TLrP4Frg1m0KZSWRj2U4rdJUtVOQr4ufP5emLDQtNyXF07MA38ONn50yPHjNaQ==
Received: from MN2PR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:23a::8)
 by CH0PR12MB5252.namprd12.prod.outlook.com (2603:10b6:610:d3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 14:08:58 +0000
Received: from BL02EPF0000C404.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::48) by MN2PR03CA0003.outlook.office365.com
 (2603:10b6:208:23a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Mon, 20 Feb 2023 14:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C404.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.14 via Frontend Transport; Mon, 20 Feb 2023 14:08:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:08:44 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 20 Feb
 2023 06:08:43 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 20 Feb 2023 06:08:38 -0800
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
Subject: [Patch v2 9/9] PCI: tegra194: add interconnect support in Tegra234
Date:   Mon, 20 Feb 2023 19:35:59 +0530
Message-ID: <20230220140559.28289-10-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230220140559.28289-1-sumitg@nvidia.com>
References: <20230220140559.28289-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C404:EE_|CH0PR12MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa3a2a0-6350-4c8f-557c-08db134c0268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxAmTWWS0zyN63XqIqEJM5rtubWOPO/c2Yr6ONvnoNkfcBTOYHy2CeIw0HgK+MB2wAN3kFr8YcmXA86Hj1NklYBAxSnz+N2w/UsKXZ57LaDcxjs+Wdwy0Duse159fxOC2SSysBU79dJf8zwcgYagblQXLdo+2+6aKjOrtxj8xAm8JLQPEfNKkOdAKqXhz4N/0u1Lj5S+vciSetXYyFPnzBvE2qAfgg5sGxKiv+5+zZl0hW64qcJVT6kAz/0NIjzaal34bIODO4Uwfa5+xilzzOECGGwWKjgwM8GZzxXrvltvoYr7Cg/Z6h0uimH6uRru9BozK8Y8Bcs5trl1x05bGmSJZfUmWxVDnlB8H4cKEHtXsH60HScdUrpH0rnJiTQBWczSCWMclH8gfXdzbNEm0hki59e1xISzp42VnXNk+8R0KZlyvU082lrzgV9JL/2gOaYzLz3CqxC4GOgrsqSeuZtb/FkbfmwrF1OnK329FXC6/5ghkW/hpv6BOCleB/LwW+IY450gIad0Z+mpx25FAD5AMkXw+9C7o1JDixdDyCsj/pHvrYkfaikBYna/dkSEXN7ofZa0L7+AHWwPHgNuypBLkxuBp1xA5DhMBoRDMcvuKDrnC8kd4UdXgt1b5G6LKnwV0c/UusOHDziWgN1dEzhm0VK3C/BSaX7URmr2PzY8n0r4dzXPFyxqf/xt1M6eQjnfDX6hhYovlamjQ7iz8Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(7696005)(8936002)(83380400001)(5660300002)(7416002)(47076005)(41300700001)(426003)(86362001)(6666004)(186003)(26005)(54906003)(1076003)(107886003)(70206006)(2906002)(4326008)(8676002)(70586007)(336012)(316002)(2616005)(478600001)(110136005)(356005)(36860700001)(36756003)(82310400005)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 14:08:57.9860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa3a2a0-6350-4c8f-557c-08db134c0268
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C404.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5252
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

