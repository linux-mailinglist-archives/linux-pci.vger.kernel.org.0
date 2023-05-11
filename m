Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5016FF893
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 19:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbjEKRey (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 13:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238971AbjEKRex (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 13:34:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ABB44B1;
        Thu, 11 May 2023 10:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLxGXMNqCskJOzlad63ncieRutN0D9fbm6/dQxCtPO8/NQ8RWuI0kbXv1t9vmRUXMgmrh022xTwjlzDP6PLJSWleXKcZOkfp3K2u/kXbpMVjOGXHpVk1EWW174ewEJ3mOzXDEORjIK4o9sKTOciMwHQx8/km/mZmVDg4OYOQtxkclDaQZF/1PmCPyVCg/SLSeh+4pL46bKS8rxaRY7XXIkINLH6NzlQzFH8FRdazZXRfb4CFOjNPNRCoiGfSiHUbpOjWFgruLI/z9CUhVpN//2BDU1EDYSR+WJIt7vRW5ScwsOj0/O/fAyxonKHxh17RvWfhyHMTNbMubgVU+bPOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcNlQ00p2UcnKSWFgTiH/eHyZE9V1VZ17K217ssLo20=;
 b=CN+OLhz0Jdivn2D9QBEI/A1o3X1CS3rLqmrE+yzg0Bo+CFi26XZX9NpQKY1rvhusINRfUVEnz3iNVC6B2Cz2+5wS9HJDQl9PA34IQZ8iNCmY46+imASf4JiF6HCvYQGCO2rZ/iQYcZSxsMfyWYuA6H5+fRG0Xt10ONcONdCzmgfncMQcu6tEZk/yLncaz2SAPOrJr8yBTDf/fvMx+NljYGLuxl6dA4o3r58xZKj0oVP0lzYbvBTlIWYafIANduukx/kAWgY2T2mIgE77k1Nfu5CWirhfn0Aoc20hK+aozBDc5mdwKcNUQWzJtbdBG/IbkiTNFNSyPipL7jbNSUdOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcNlQ00p2UcnKSWFgTiH/eHyZE9V1VZ17K217ssLo20=;
 b=CA/1jqTqz+dC8Zk2w2D/2Oc+llv9ZNfd6/YWqLO5SKGpvjW0u0cFZoPkPT3ESuO11c0hwAIE2bf/BjxZEpijC+ul4WeIMzJkk5ve3skLdqoFVkURX7oGzdSdekdP9wZt13a3+x1RyH37e+uImavrFBuWh2EC/D2VWLone75VviRte7urv9yhd1mWP+0wKxk8Nxg/6xq3uotWRt7bqXix6kQmWUFegwb2J5md/5/jeqO79ThhF7S0Jn+Q29k7+eAKk2R03PPGpCmUB+PpWR36MZbupJmyUrmU5XBsBEGJ4SGw3doALf4CDTgCRE9M6zZ/FvOmKiyWWXou8Tff9NzXFg==
Received: from BN9PR03CA0115.namprd03.prod.outlook.com (2603:10b6:408:fd::30)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Thu, 11 May
 2023 17:33:49 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::71) by BN9PR03CA0115.outlook.office365.com
 (2603:10b6:408:fd::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21 via Frontend
 Transport; Thu, 11 May 2023 17:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21 via Frontend Transport; Thu, 11 May 2023 17:33:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 10:33:39 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 11 May 2023 10:33:38 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 10:33:33 -0700
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
Subject: [Patch v8 7/8] PCI: tegra194: Add interconnect support in Tegra234
Date:   Thu, 11 May 2023 23:02:10 +0530
Message-ID: <20230511173211.9127-8-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511173211.9127-1-sumitg@nvidia.com>
References: <20230511173211.9127-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT040:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2b8a29-41e8-4228-78f3-08db5245e185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXG+XgqCspomA9Iqe9N/F4qrtYkBnZGm3JBV1YIA8OEfwfrW/i+E+GjFjKd7Sn0vjIs/OTePUDZaWQ9rROSKRCdvnJdehElGG4qXHbISTNGzCURRwX68T/dK+mNjYn4HKHcEtQiGvve+SkoGK5pnb4kRKbAVPxoIc3RDZWg1Wm+2hzzaJPfrbogwMkL1GkaPrRdfAUITELKh17t5yGN4v5IJoUWltlHPhmGeuxoMrHpQ07+P6xaEd3mzWX3iiZ7o77lD0eLscDVtVZMi6bJ6jv8BX8aTUbt2jkliHuUjdaVyxZJVYr97mS4IXi3dObNVfOSni9mDRDFoKw1uIz0sJOvAs4Y9gdUv4c9CD6A006m9jChZzfPFOd2YxxMGsneKkXQHI7g9IrjOgUPhAkqfQlHai/PywpeaxAZ3o07C+EImc/lP9LVYHouViEeL4bFms/FD9jDtOBSJekuNAgq6CIjzOT0ZfGZFH8D0qejadQrXDg0ir2eqqj4VqbPRDfRJhtrxFabyleDNbesxaj/O/XXIqsOTWy12dz8eX/SkdG6Pdjv9XfH1qQNtWSEpslYfKh+l69e+69ipQ/OkgBqXtGY3+bpI1T8huNdbYyl1hyJQGRJwFQ+AHgM8AIdQSzISwJT/zdiKtlK/EDzfjq5it97Ag2jIfc1Y30gWVBOcsw/qgRQBpCc3qY1sbUY3sXtjtZeGyRV6Si2B4vgrer2lB3CTLDA/C8oBkL9Ma4a77fTjxlwMk0e3gIn4HDBO71zE
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(70586007)(70206006)(4326008)(478600001)(7696005)(316002)(110136005)(54906003)(86362001)(36756003)(336012)(83380400001)(47076005)(26005)(1076003)(107886003)(2616005)(36860700001)(426003)(186003)(8936002)(5660300002)(8676002)(7416002)(2906002)(6666004)(82310400005)(40480700001)(82740400003)(356005)(7636003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 17:33:49.1024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2b8a29-41e8-4228-78f3-08db5245e185
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

