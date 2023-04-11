Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BAE6DD8BA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 13:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDKLDU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 07:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjDKLDT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 07:03:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3173AAA;
        Tue, 11 Apr 2023 04:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSqStCKtjFd/F/3QD/yjlGaxjdqFSLnqeahB6saI0ChRi4+tONZDUS0ArfqKjAiUxHDJTkniKfNf0/Rax+hsfoA/k8HJnq1itjvlsENw3xRsvBy69vSeBuqNeQogjIXxeXVtIHVnQNL08mjhO3UUle6sXP2b8P/OAwDTmnzbsJDkem8cR5mZEYAF3b8p/ZD3YfY67C9+px4vT0cS/BzbqnAbXZxdfIwTNAEntsHnPlFQ233ShrbGGWCPoPHP0hkHigtgvNdUdyDCuzm6OIx0hidpIwEaIK61bJn5nzxfY3uDy/ozBeUE19Afz3YMos6hex8GGt0xgyxxMkSjGp+sew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qe7ko4hKk3wIiZjpXWtiYE1sJaLpuPQX/tl1088MPcA=;
 b=FVWxpOw/fd2JeR5vTt3rGvp+3wqxVbIP07M45g5ItV5XLKsKsRlT21MjJt2y8elBgIFYpDJvov59yBDlV3+vVUc7EHhMKB5lswvUVuZZyjX5OHQvBxam57TtBekkZXtKy+aj2bNJjZFjioKd40KbsbKMSbK3D75G0q1lxLRdW66w2nSfHzZKMrMOA6VXlpsVhCdoPb0ujOsD+GKi5crcZPrZCySniQ+pKywPriCdtQo3r2UaO48SDF3lNM+dgvfaQ9nBE5SKZcYwSvgM9vFa+edRd3E6fGgfEYOko40KLx9mjXdhA3YNvSxjAHhVUIqE3GitFWYw7e9WGGJzlaSNwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qe7ko4hKk3wIiZjpXWtiYE1sJaLpuPQX/tl1088MPcA=;
 b=LXcS8bqKI7YvWEmCLu2sqEw/JwSUHIig3Zs7YH5OmH6CygV3G8lCY44g0OD6PBrLzYdYaPYfazg40UacSJe9fILA58Ws1dAKysFyJXIBhSmSOYgboiRVByjKGOhcgtP1ox9zSBuv4pazeovG1K6fGeYlTMe161yXGp3u80RdSJ6Q1KNNn4NQ/mEQM9x/nP6KGU+tRZuW6x7j5U6Dosbjot4ndyBjcHhhGz1MF55gvoxAcvtBae1yJTQ/wfRB8DYhQGDJj4CalyBBsAyvxn68rnQhfhtS+VpJiMRV6oZJmyae98Cb/8ddFNkoR6mjrDWr3hSPnSPlutI5YY+LJPGa9Q==
Received: from BN9PR03CA0466.namprd03.prod.outlook.com (2603:10b6:408:139::21)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Tue, 11 Apr
 2023 11:02:13 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::20) by BN9PR03CA0466.outlook.office365.com
 (2603:10b6:408:139::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28 via Frontend
 Transport; Tue, 11 Apr 2023 11:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.28 via Frontend Transport; Tue, 11 Apr 2023 11:02:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Apr 2023
 04:02:01 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Apr
 2023 04:02:00 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 11 Apr 2023 04:01:54 -0700
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
Subject: [Patch v6 8/9] PCI: tegra194: Add interconnect support in Tegra234
Date:   Tue, 11 Apr 2023 16:30:01 +0530
Message-ID: <20230411110002.19824-9-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230411110002.19824-1-sumitg@nvidia.com>
References: <20230411110002.19824-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b813f1-49b1-43f3-8c44-08db3a7c3459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmoax3ypVuJf8c40uIjBOmNI/7ftLnLw5Bue/bvxxFINHhLIxAK4lFnOas+g3awJKtQ3n7N/T5j4FBp+sB4jX2t1HMVufnWRmyyqai5DFdVIbfxTkxU1M/37G64URpSOiWMiyn9FS0kzcrDnBHhPZL2+jdy64Y4QHAh75FqgFeK0KfLwEb/yI2c3Ezl8hoRsFlBZWccV/hnlAyEz3+Nrg9izvEbqU2vjxz46mHcV/NW6BtYzPEysWZksp1pVjDOcI9tIrmZ8OZZnBH4ox3rYPuDjlWQpQLcaX5smk5o2SIhJD3gBSPKxRjsWWtPLOnlSm8Kfs+3+STvrgecnSlTkfLth3s7KA2tRvyiuNVfMv5xXLe3rSFIPnFIBwpbJmt0zt58Qi7YRp52RIxeE11MafO6wdevAuB+ryUTxfuPwqtxC9uDMw0pZUVXNFDsU9aeXwsRnXmyPMNWJliAqDHdJBiKFoHoc3eOWPoRt5cIZ3cnTUtSmJncsW1wmYHn/paZTZtlV+eLb7eRCkkPA9OiJ4J/gpF09x+4s3otIOnrUa4Q6FJZNhHO1JqcwLaHVPfVvsKeoJyXCb/JFdrav4aowBoQcPDv5+bzIrFBxjC5Io43JQQUmqNCVWzRBeeU7y8IFxOJCUMzdpawrVXyo6hCkEIzSdbAmJ/vIq2dLU0i6A3H6GTpmFvdMkT4w6gSupprRH5urIdmyqo1KDxYg0ppby4URq+i5C0ZligAVxRrXyqpkCTKtUVdXOHnRBeSpvIxh
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(110136005)(54906003)(7636003)(82740400003)(356005)(426003)(2616005)(336012)(82310400005)(47076005)(316002)(83380400001)(86362001)(4326008)(186003)(7416002)(8676002)(26005)(478600001)(70206006)(70586007)(2906002)(1076003)(107886003)(6666004)(36756003)(5660300002)(40460700003)(40480700001)(8936002)(41300700001)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 11:02:12.9665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b813f1-49b1-43f3-8c44-08db3a7c3459
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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
Currently, no latency is observed in data transfer with PCI as the
DRAM Freq is always set to max. But that results in high power
consumption. Now for Tegra234, we are enabling the dynamic scaling
of the DRAM Freq based on requests from Clients instead of running
at the max Freq always. This change does that for PCI MC client.

Suggested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 51 +++++++++++++++-------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index e6eec85480ca..4fdadc7b045f 100644
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
@@ -288,6 +289,7 @@ struct tegra_pcie_dw {
 	unsigned int pex_rst_irq;
 	int ep_state;
 	long link_status;
+	struct icc_path *icc_path;
 };
 
 static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
@@ -310,6 +312,27 @@ struct tegra_pcie_soc {
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
@@ -453,18 +476,12 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 	struct tegra_pcie_dw *pcie = arg;
 	struct dw_pcie_ep *ep = &pcie->pci.ep;
 	struct dw_pcie *pci = &pcie->pci;
-	u32 val, speed;
+	u32 val;
 
 	if (test_and_clear_bit(0, &pcie->link_status))
 		dw_pcie_ep_linkup(ep);
 
-	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
-		PCI_EXP_LNKSTA_CLS;
-
-	if (speed >= ARRAY_SIZE(pcie_gen_freq))
-		speed = 0;
-
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
+	tegra_pcie_icc_set(pcie);
 
 	if (pcie->of_data->has_ltr_req_fix)
 		return IRQ_HANDLED;
@@ -950,9 +967,9 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 
 static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 {
-	u32 val, offset, speed, tmp;
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	struct dw_pcie_rp *pp = &pci->pp;
+	u32 val, offset, tmp;
 	bool retry = true;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
@@ -1023,13 +1040,7 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 		goto retry_link;
 	}
 
-	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
-		PCI_EXP_LNKSTA_CLS;
-
-	if (speed >= ARRAY_SIZE(pcie_gen_freq))
-		speed = 0;
-
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
+	tegra_pcie_icc_set(pcie);
 
 	tegra_pcie_enable_interrupts(pp);
 
@@ -2233,6 +2244,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 
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

