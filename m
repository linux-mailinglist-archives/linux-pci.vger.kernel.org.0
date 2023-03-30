Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B083E6D06F8
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 15:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjC3NgN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 09:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjC3NgM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 09:36:12 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F417BBB3;
        Thu, 30 Mar 2023 06:35:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZGkbSk3dS7p8zTTIE0YTAQ2X9cQA+EBe7BlaznLhcS8izKlI+knr3fFUKvOn4PKQ47JuUbpNJNLcuT+/0S+iypQmgeOGGIx+EL/R7UEAn9P1VcE6FBkDmvZrPuyfW6rn6N7Sant/zfkSuHOmrPsfxxP0kIOQZsLC8J17o8HwZZ+eb8/3pK/RjeF/ArhRRhAks0kL2672MAEWnm4yjBaZx913ZaCkKUv7cMl3S8J0Myy1TZVLfPzN9K/xKX8zbaH+XAX/ErM5iu6areenoEI5xXa5gtXB1K+yl8xlI46cXZAh5k5eUN56HkKaGAiLz4BomsMfTLLSolYWGMS6Lm64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW73Whtn9BukhIEn3tjHCL3FW7AAbitk16PcweJxRkY=;
 b=CIM0kgEq73C6EyjEryNn0aHnq3ku5lvh8/CYTAMS/75enHAndfaFDv9E/u7AJ957s9xm0UFI51to9scVvezjy8xBYislK+g9pkiqFn0itejR6hbJcA3M7AwxgHq7ruzagoweQVU5vccafY/e0TRhRDum7jIeAhW51ZRjJnTNxCtkYMjc7c74AjmWp2O9FTeRYlEBCbPgHr/4Lz66mvR2EDDN7xEU2UoCQrpzAqUdDbfi3xFkcSQGsf4Wvh99cYN3tnlDZYXif5gPAj5FPvqWzGEKBu7KOepL5rCLNSBj7O3t48axT/Mw6m04n/QU98TL0EfsC5u233sQqXNO6Suk/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW73Whtn9BukhIEn3tjHCL3FW7AAbitk16PcweJxRkY=;
 b=piPZtRWQQPzVDaM8W7hOQxgV9XQ1okZuXMVLxV4GqixvbhaSlrR+3yeQtKJglYoKVaXsbUX49qHMckcn9694QRlugl2LTAZl7bYQ1QqlKYHKObDQwie0F/gziFAffDw3+sIK879FsA8EjJxwa41KR3l0QrYHNVoZ6R0J1Xy9qu4uNCe0LVx62NbgKvtIFFCSSL5p8K3jjyEf+jGYD1MPhusbg8Nnv3SdCL/iq/X9XATJr43BTFBWTSe2LGh1iDQC6k23hz7OhQNQ1gmb9gLL0C+8YNvXqSPmxm09FNZ4MAMZNdmz6yNs3Mz51JCbLYG1UFGMJRWMyILhbYYQFRj0rQ==
Received: from DS7PR03CA0336.namprd03.prod.outlook.com (2603:10b6:8:55::20) by
 CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22; Thu, 30 Mar 2023 13:35:35 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::65) by DS7PR03CA0336.outlook.office365.com
 (2603:10b6:8:55::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 13:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Thu, 30 Mar 2023 13:35:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 06:35:32 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 30 Mar 2023 06:35:32 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 30 Mar 2023 06:35:26 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>, <helgaas@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kw@linux.com>, <bhelgaas@google.com>, <vidyas@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v5 7/8] PCI: tegra194: add interconnect support in Tegra234
Date:   Thu, 30 Mar 2023 19:03:53 +0530
Message-ID: <20230330133354.714-8-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230330133354.714-1-sumitg@nvidia.com>
References: <20230330133354.714-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|CY8PR12MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac0207e-55c5-4cdf-3f83-08db3123a439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLiCjla0qIYGU3AzovijVn+7hP3n+ZgcSBPzJ5XVa0ctcUaxn1sXUGEQGL0Bg40O08f/QPq08MOmZ9znRCjqIH/H7ZC3/q2AUfpj5CtRCY1PvaXMSJGV3D2wF5x0RpdogvZG9QHbhGoq5sKYgWyU6KxpHLbOu+dgHd5oc4oXMC6mViI1whOMSOv+VKbHpi7T2kU/37hDEwBPDoRuBqBHUR7rfBQvATpJjkvEV263VJ3PXHZoxtoBeDWnm7QP5QEn/Xz5g6TVmRT9I4rlEUyzuCPkOy5TKWloDvtAf4Nz/XfLg0XXMtdQJkXgaqxVwP05/VH9ba6UmmLqvp0SPFmVVtzD/xys1JtBWDPN9yjiE5kEtuz+zYSDJvAWezPHkgE+1KXY1j7ZHvtyL6Nawz9ZU2IUxuJNlV9wN8d/1pHYME84zYTqEeFo0pLAu7exkprLbay/qGKKy12Xgl6rjedxL/NF8qyTjWQlx1I0fhwKk3BOLhxT51dPsd9FexTKAw61QQ3ztoWLTTyAud3sWc579QjYfX2giVGGtrbc/xClgO+RYV3rKY2udwKwBfIEyFv0FQ7Fw5ODcpYmTLruwZboYds6KfWcjcvDInHTAcxDjr0ZeeVFUh0/7QtPP/HDaLw9eGTvJHxIpSwVPx8HSM19L8c+Pmlq4j7eya2UvdGYdyhmRnjDZHdEOZq/XD67U2nK+tT+F/exfe7SfOCs/s3CFr2BzcBEuS/nifV3K/p+5tWtmIgEIUAvsGJv4hMIhI0RUu7E+ngTiQvC+zZbxDGE0vDCCKlMeKS1RhEmHyTC6Ec=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(7636003)(41300700001)(40460700003)(40480700001)(356005)(2906002)(5660300002)(7416002)(8936002)(86362001)(82310400005)(36756003)(7696005)(336012)(426003)(36860700001)(47076005)(54906003)(34020700004)(83380400001)(2616005)(6666004)(26005)(1076003)(107886003)(186003)(8676002)(4326008)(70206006)(316002)(82740400003)(70586007)(110136005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:35:35.0482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac0207e-55c5-4cdf-3f83-08db3123a439
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/pci/controller/dwc/pcie-tegra194.c | 44 ++++++++++++++++++----
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 09825b4a075e..89d829a946ee 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
+#include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -223,6 +224,7 @@
 #define EP_STATE_ENABLED	1
 
 static const unsigned int pcie_gen_freq[] = {
+	GEN1_CORE_CLK_FREQ,   /* PCI_EXP_LNKSTA_CLS == 0; undefined */
 	GEN1_CORE_CLK_FREQ,
 	GEN2_CORE_CLK_FREQ,
 	GEN3_CORE_CLK_FREQ,
@@ -287,6 +289,7 @@ struct tegra_pcie_dw {
 	unsigned int pex_rst_irq;
 	int ep_state;
 	long link_status;
+	struct icc_path *icc_path;
 };
 
 static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
@@ -309,6 +312,27 @@ struct tegra_pcie_soc {
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
+	if (speed >= ARRAY_SIZE(pcie_gen_freq))
+		speed = 0;
+
+	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
+}
+
 static void apply_bad_link_workaround(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -452,14 +476,12 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
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
@@ -945,9 +967,9 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 
 static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 {
-	u32 val, offset, speed, tmp;
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	struct dw_pcie_rp *pp = &pci->pp;
+	u32 val, offset, tmp;
 	bool retry = true;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
@@ -1018,9 +1040,7 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 		goto retry_link;
 	}
 
-	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
-		PCI_EXP_LNKSTA_CLS;
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+	tegra_pcie_icc_set(pcie);
 
 	tegra_pcie_enable_interrupts(pp);
 
@@ -2224,6 +2244,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 
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

