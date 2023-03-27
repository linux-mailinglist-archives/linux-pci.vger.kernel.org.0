Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130056CAA62
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 18:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjC0QSo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 12:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjC0QSV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 12:18:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF465B92;
        Mon, 27 Mar 2023 09:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtfLfdd3EXlG7N86sXVr9c6eeDOoxQ25kNEM+usj1tRy+yQpSx5afhUdBR05KL8qyvohqptsdbGcUqWtxZpZv2GVPYZNKI/AvpZhRqMVM/T1IJdElNGYlHH3geuebkS+cqC4PKpBNA1WsZ2S913c1SRJczFMPLBXoZrQp8yP5iCKC0cFBnxjZCVDIEEvh08FoJSfNlIv91VDYPcZtUJNnuzOJxmp8EkBTX0Zk7A0ehyt5RjqlRtIkWrBeQkq3ilLtIB3HeL4cOKuZX7e9hCjJkxC32/tNPud28fs+2ZJvqD961tIRYqmYU3cMn2HI6kqSaRO/oP1Hc2UplyeLh4svg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zl/Zq3udnXoPPmPhp/uzEpbABsNB15gy+KqjcHFYdzA=;
 b=fKg40JnsXwEB3oWZ0+4ZU0wLu4CcP0KU4wK0buDzlou9GReDVt0nEdmtJrv4dQDxYeJ5WmbMn0lBQuuwCFGnxJosKW+Yzl955Bp6xkKduNxhnpMOBmwH2smmCy2gTisl2wrMfj8uxe0NvlH8enurvAtBQds61m3E9qUH/XYWTFCHt3ftxlvxZk26OYzMikpmQORZgCr5kFewZBpjvxx5on6PaUI4hJSMN5mjHJyO4PdEVDoRkkhu9nd7lm/rMGEDJaiPm3y1jYZVucbm54I1IHpc6liieFSFwgUhqDfHgByVThPfPyagvnYxbaKWhj/V+AsOP+5TV6Ee8jaFu1uY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zl/Zq3udnXoPPmPhp/uzEpbABsNB15gy+KqjcHFYdzA=;
 b=ZAm6vD3Ba1MkAaShsA23ItfI9YmkKEeJmLO82awVH4Cy6WiSSWiDFpz5RR426hw3luLLJbZVpwg0FNsFjo5Em+X2y0j2EaaKzKqDHVXqzy7RroM/0Y7BMbttcvMfuYxZ3ZAoWiranbhxEfau4ZUF9y+TktRQjUtiFHBTsG6I6o+Acx7EZ0+T6dD73y0DQKQDaxzMT8+e8d64tNTZmj+knkdfCcaHvo+Go9cjIrV4nRBOJChqokQwx9YyBXVdt+aUNM5YvFMzllIiWy3nPycUhj4q8nuCRfzFx/bnK2U8mCDxL7MR39wvPkC2EGF1O1GXtWt1EkGtaPl/v7PL4/C7fg==
Received: from DM6PR01CA0006.prod.exchangelabs.com (2603:10b6:5:296::11) by
 DM4PR12MB6110.namprd12.prod.outlook.com (2603:10b6:8:ad::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.41; Mon, 27 Mar 2023 16:17:27 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::ec) by DM6PR01CA0006.outlook.office365.com
 (2603:10b6:5:296::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 16:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.32 via Frontend Transport; Mon, 27 Mar 2023 16:17:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 09:17:18 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Mar 2023 09:17:18 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Mar 2023 09:17:13 -0700
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
Subject: [Patch v4 10/10] PCI: tegra194: add interconnect support in Tegra234
Date:   Mon, 27 Mar 2023 21:44:26 +0530
Message-ID: <20230327161426.32639-11-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230327161426.32639-1-sumitg@nvidia.com>
References: <20230327161426.32639-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|DM4PR12MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: b22c18ba-3fcf-4736-c8e2-08db2edec1f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHFWV5B8RQh9XV3iMEU+2+I+DpgzwO3rNxu+ngscb1A6aMfBXlnh+8H0gwaB+N4W+DLJecB5b8se0Q/hf+I+4mLQ1ykA7Wj2Fp4jFDE5qngiBJzogD5DL4dJNdC/DMzko//jsMN1F382qbZ06LWCPcSzHF52l7GVdIOmAsgNnIDYV+BtQlvLbNwUCpHzx531huk74n68/z3R/W21CLvNR0ikuE9SsIWHMmeEMMosu/ZkDo4Us95RmreTogpu2tluSH0pDj3fs2FGqEOAAa1OMB2lxpqjXJwwphpS9fhm5Q02DZqzNmUABfBkDQM8DZ30FXS/A8aN4g+Vugv6RzMM7e1nBkKGUuCdPHCN5PgBYTfWeDRgfIbnUu9MNtN84yE68Y6dvC0zMoWZmz/qffma27LO90D8CyugAKEGmekHP6i1y7BUHn+xw2r6UYoRNkaYd/hhcI5REIn5t3qSAmLDcTMt0Y23Y09Oto2N1Ui13b/jbhjW3aL21Jd+TgiXY6rE29izZAfZWnU6eTv/7ZLXE8KDJHOIOsx9EQDI6EawLuNFoV+xxl5aN/ag2yHiUVLKb5zcpCLoYj1a2gvpqAFxdJXTumwgDkJ0RFfV5SS0n2VVCqd+1/uCyz+THAhFHokiq2kg+e3VSVEwd9JJJb9baT5XGdkN4FeBXvOMyyGdgEUxeMdvltkiid3NNYZt8zdxBVegnAkkdaLdP1+mA+yRO+zqh8qSrFDEsZCzTH59HyPjcR2eYDUsT8m+ASEDYvcc6q+TfMOLC2N2lLVAJgVqzsLQT3x5kPVcm7xGS4B+FQI=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(40480700001)(82310400005)(36756003)(2906002)(356005)(40460700003)(26005)(6666004)(83380400001)(107886003)(336012)(1076003)(426003)(2616005)(7696005)(47076005)(478600001)(4326008)(70586007)(316002)(34020700004)(36860700001)(110136005)(8676002)(70206006)(82740400003)(186003)(7636003)(54906003)(5660300002)(41300700001)(7416002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 16:17:27.3051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b22c18ba-3fcf-4736-c8e2-08db2edec1f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
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

