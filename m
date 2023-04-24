Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B116ECCEC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 15:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjDXNQz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 09:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjDXNQy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 09:16:54 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7192B4C03;
        Mon, 24 Apr 2023 06:16:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtzNCzdn8/yGAFU8QYSlMwuhfkEkhR9wbIkciv1zkwgKi2BbH8R5ha/5wwdBAeuNbhss3+FFiaKzSsAvLWD8I8CxbPeuh1PUqPtsh1RuGeVdMx2h1qkRJW86yjsnEUGlILk+YezlikRNlQPWhHu/4rZjdhGsSS8a0mewfgpK/j9mb9/JC/8XdX+Wwunxm+8npDj4uLgAm8MK43OUcJWbF2olKiWtYEUf0tTNpelhnJjhD7lUVlw4VnLzZ7ELHag7XL6/duC5UJh+X0Vs2Tf3txJZdYmQWLy2HDJJNHpVwwdQHAZ1wUZ2DAxPYFxougmcB535YT3c5H0xlQgafprD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcNlQ00p2UcnKSWFgTiH/eHyZE9V1VZ17K217ssLo20=;
 b=dR59oytzZ1/cxKiacQZ62954q/AB8MVvsTsF7fGxD+ddDfGE25tgjzoMjLSs+foZu0efpaRi17e8tnQXIs5RVXv1EXfctCq9c2yf/k28koAq/tyeA0PVypg2PGtNrwVlK/PBQnf2+gDRzLBvB+5F6RuCB6hX9Z2t0g6zMv/6KyZrVxxgann+PQssC3kH66DcSa5ruqvug+OLx8guDAoB4eqi4IFDcx8CJUPfrSlnaZD9x3TOoFVrMrqNeSnNxsWKSSfyWiuQZPzDHCU1zMLE9CycCOQRJDtJgsfQPrbL2vevW/ZquC8lHeaOD6tBrE3CQ/vT7+NcvBN8DH04sxAWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcNlQ00p2UcnKSWFgTiH/eHyZE9V1VZ17K217ssLo20=;
 b=eOpsgZ/7aczmEwR2yXRloDl6LQ36UEvede05r3I3kEwvl+FhGKk02/icJqtxlOYwjKs8SbVIFFUheeZWZdXwhgDvrt9PTwah8vrvEPSDZM9bQLnk/QQ3XBXhea6AUW7z6r9/7RBRcQulONX1xAC/yYj4DTyXjFURcNVBWUdL1o8pTlgbYoIT9xldW4GqACy3Yt1kqaWlrZvcEdTfK1fjE8WAdA8TXoTDnA3dz7rTu9KGGM2BpXfbzgt8KxvpS+Ona+U+Hdu/8fKVeeBzEks3NuYl24u+VzltJq4oP3G0NX57U0rnEbf9ufketwPFowXUl+nlEdTfZBqwIDx1hR5wqQ==
Received: from MN2PR11CA0027.namprd11.prod.outlook.com (2603:10b6:208:23b::32)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 13:15:55 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::92) by MN2PR11CA0027.outlook.office365.com
 (2603:10b6:208:23b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 13:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.15 via Frontend Transport; Mon, 24 Apr 2023 13:15:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 06:15:37 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 24 Apr
 2023 06:15:37 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Apr 2023 06:15:31 -0700
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
Subject: [Patch v7 7/8] PCI: tegra194: Add interconnect support in Tegra234
Date:   Mon, 24 Apr 2023 18:43:36 +0530
Message-ID: <20230424131337.20151-8-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230424131337.20151-1-sumitg@nvidia.com>
References: <20230424131337.20151-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8d3727-088d-457b-f175-08db44c608fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KznIouh46XWrrVNzOUS1tkM6mCJ3FRx59Z2AOCgvIHxxs6v458oJWQd+UevtvGC1p8wgJB3YD4whIOMZRH54LKVE+rK4odCj3h0Hx9CQ5B6Z4QmCV+OMyFOyPkg2sk8HFCsmraRFxLI+kTpF9L9Lqc07GJzw+4h5eLQtKA1nFFU7ycD8s+uGMDhdRIJXGhM50DLQ3AUpBQK159oIBEzi+eqNH0XUeBik4lusviJn7eIF5XvhjSqFtcu0cfJ5WGBGrSh3h1nbC+G79tq5l1vJ0oFe2vJEF0RaZDCGvp7qlFM5fSmTa9pBAVkYvSgdd0ntl+YIeFNPSpsGyZxra9FlTZzLr9ORiTexnnDKBuFuLAgJ3b7gQxaSC5yvKPB20faW6v7o9ZYYNU8MrGlOr09f6L6uGsRdzIrq6PInQHMSKcNgKlYuPe1WoUp2j7hpzbwe58rp/f1eKgJ+5WsvZMAdncjNq2qo+6cvg+z7DLNQhuDZ54/94TUWVHf1o2ROEMQouAeDzRRR9WCVrzDrsRbPF0iyNR27uuxD0jd5BAx/KGGpVSGMDlSGsor/3rGGfIH2Ekbwe3rZZU0p6bFz7BiyfeLcXHHb51sUc3YJASb8mW8bzBFpeOjGCF4RBK7vcQBgOZET9uVlK3Y9Tt9Vs/jFLOOGK0AI+6IKXgkx4poMzm+mCmaqXoRURwsSdYUzUh7jcGIvMRVvmcF4awQq2jmW/A==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(36756003)(8676002)(8936002)(110136005)(54906003)(40460700003)(478600001)(4326008)(70206006)(70586007)(7416002)(40480700001)(7636003)(356005)(316002)(41300700001)(82740400003)(2906002)(5660300002)(2616005)(86362001)(186003)(36860700001)(336012)(426003)(26005)(1076003)(107886003)(7696005)(47076005)(83380400001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 13:15:54.5902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8d3727-088d-457b-f175-08db44c608fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to request DRAM bandwidth (BW) with Memory Interconnect
in Tegra234 SoC. The DRAM BW required for different modes depends on
the link speed (Gen-1/2/3/4) and width/lanes (x1/x2/x4/x8).
Currently, the DRAM frequency is always set to the maximum available
but that results in the highest power consumption.
The Memory Interconnect is a software feature which uses Interconnect
framework (ICC). It adds the capability for Memory Controller (MC)
clients to request bandwidth and therefore scale DRAM frequency
dynamically depending on the required link speed so that the DRAM
energy consumption can be optimized.

Suggested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
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

