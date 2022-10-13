Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA265FE1DF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiJMSpy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiJMSp3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:45:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7263C34DC;
        Thu, 13 Oct 2022 11:42:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXo/hf00aGwwT/Xa2J55uu8vmH5Nq6h1LowPjjdIhg7bXC9MCMN0aaVpMXAFtNz79FoQ1TrhKTQYbW0oFbJ/q5LZeCRmhUwJkhsx5c6V4EUI9rAnkVKNlSWbsGB26z3nE14xCEdZqLIiSAS8IP0Btsdjk8YuhmX7HWzVqafdIgzy8XOQ0hmGYcbjrHd5l4XUJGb7YHX6tCvJpdzoLVOCiS+xTeOllnxoRpMd8jQC48PkKlnVWJfLEoPuaa6mKdWAVrQSl9fPEXFY/Q1KHb2rJSXSf2DEXcWgNxZFJYursLaulnvt5bEtdrTJ7IbNf/JhyRQsJe2iGzMZNS1guVOl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPsdh/LeAVLGI//ZKIOszKcbprG+fe9y5UUxgVPd5tM=;
 b=mX3zoyULhJQ1QFRaJynwn8cVZ1AVI8t+4zqMxR8hfU4RayrIsKFtg7Ghvw7V5Q1q5xYHT4nUHJp02Tj2HHDa2qVo+RsAFWH7mDsIvvghSas5H9aKi1P5K5DBjvgvwIP188g/X+EtHlCC3NGB4XztnbCkVMiRfFbpQWIF9FZTeMvwPEZ9JSHC22ECn8mUtN18754AkIVwFAJepXFh0gOYUSREkiggVKq961SoAPgnvbagO4jE/O2E3O59wTfKNV8VbKCrZX4b5sg/q9fO0mwvCnX3j/PjiyNPeuP0+CXif6FBkLcYDPq5o6X8Crpt+udOURhsiz0vga39wxFQVNgHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPsdh/LeAVLGI//ZKIOszKcbprG+fe9y5UUxgVPd5tM=;
 b=g0xuRTQ9RLoHjvaOwNF1THH5rm7SpONu5qfteCLqMbHOtRwUU+KQD72tlPm9rn9Sy2ElloDXlofXMBYiQyYdybNfBx+FOEgGjJwjqB5snFngCXAxGkVXKQFLqTm2jJYI2HtP4hOKbv5vItLHylo9tkQvHgEtzgBpn3Uyuyutwawn6tlQtfB88pYpIRaukaSi7OwIishyeimiaTi+XGB4ozpv5hBOVjdqffp1wPoegmdI9pxfrHXQGhZblxMDVh0tJuaFKvA/v94uLbnsT4NiA9moOLyKNB6wsHzCvhEL+s3TGgGHdvfTPmmGfUrIXn8pZraLAF7wLsFLYKwWXOtTpg==
Received: from MW4PR04CA0122.namprd04.prod.outlook.com (2603:10b6:303:84::7)
 by SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 18:41:30 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::4) by MW4PR04CA0122.outlook.office365.com
 (2603:10b6:303:84::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 18:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:41:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:41:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 13 Oct 2022 11:41:22 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:41:18 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <vkoul@kernel.org>,
        <mani@kernel.org>, <Sergey.Semin@baikalelectronics.ru>,
        <ffclaire1224@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 21/21] PCI: tegra194: Add core monitor clock support
Date:   Fri, 14 Oct 2022 00:08:54 +0530
Message-ID: <20221013183854.21087-22-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013183854.21087-1-vidyas@nvidia.com>
References: <20221013183854.21087-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|SA1PR12MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3fdb91-1640-4f59-1c4a-08daad4a8b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7H12q9TTDpRb4e38+BfnstadUJsOlIFVL4lxFJfxR6X81Vg3WgW5shUErmGjEca8x5QEn5BIWcI0CDVKRy1RWiFDqQNqOsCc9058BnjWx8E6FWT6Xk1SOnfYs2fbE1bme7TDthMQqrfZvWXJBtJghJw+yOHCne4KHXDmeDotNo4QunFCAgvmJbtjGT3UH9858K4JmkvOCTRowTuDmJrzMOT/p/wap2CRJFhdcr9R+q/0IwgPnA8OqwK3drkRMOO8bKA0O7+uRkX+SVjxpjVcfvCftVlqwlkyW3h4Aez67KTsx18CrOTiJmbGM/wOBPmOy6TVWOK2GHExdi4FvCf9+ltc2cdeagfU3CF9B074cpDvXumIkANHdvTHwmIbDz6hdt8v4zqPRgTeSvrqBj1wmtDN82fIINT5OsMpTZ6s6/fcGfoWkzjIAmpMR/s3tgT7c9+PA++GXhwgaNA9S2UySOVSdWwuFTQnOb+u1kdJkBAsuSbgbjX7XJlF4EZSTHVc+Zc3NjCNhaaGeHLU3G3r0ghD+GLrQZS3X62fCxBOJzEKJCQERip4RhbVfXnN5iRxR4dpzKxzMil6KpOXXSoumRndfrUTJU9/VhvxsKx4p3XBf7TBq0YkUSj9p+B5761potcWf3N+ZGRPhXsrCfP7pzWwNYPHcEPoUba0Rafjazmex2KJfOETAQnY+l5Q7+XkYUPPoEYhEkUstzKEaXypme7E4dBa0IQLA0ezM6Ve2M8suyVKZ0S5sdgXon8XWJPicn9U+6e9S3+0UzAHxVtbOqS9FKS5GndqztmlQz11i8=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(40480700001)(70586007)(110136005)(7696005)(41300700001)(7636003)(921005)(8676002)(26005)(70206006)(4326008)(478600001)(82740400003)(2616005)(47076005)(86362001)(356005)(40460700003)(7416002)(83380400001)(186003)(8936002)(1076003)(82310400005)(2906002)(426003)(336012)(36860700001)(6666004)(316002)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:41:29.8247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3fdb91-1640-4f59-1c4a-08daad4a8b1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra supports PCIe core clock monitoring for any rate changes that may be
happening because of the link speed changes. This is useful in tracking
any changes in the core clock that are not initiated by the software. This
patch adds support to parse the monitor clock info from device-tree and
enable it if present.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index c88c36d85ee5..28512dc60172 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -265,6 +265,7 @@ struct tegra_pcie_dw {
 	struct resource *atu_dma_res;
 	void __iomem *appl_base;
 	struct clk *core_clk;
+	struct clk *core_clk_m;
 	struct reset_control *core_apb_rst;
 	struct reset_control *core_rst;
 	struct dw_pcie pci;
@@ -978,6 +979,8 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 	}
 
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
+	if (clk_prepare_enable(pcie->core_clk_m))
+		dev_err(pci->dev, "Failed to enable core monitor clock\n");
 
 	return 0;
 }
@@ -1050,6 +1053,12 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 		val &= ~PCI_DLF_EXCHANGE_ENABLE;
 		dw_pcie_writel_dbi(pci, offset + PCI_DLF_CAP, val);
 
+		/*
+		 * core_clk_m is enabled as part of host_init callback in
+		 * dw_pcie_host_init(). Disable the clock since below
+		 * tegra_pcie_dw_host_init() will enable it again.
+		 */
+		clk_disable_unprepare(pcie->core_clk_m);
 		tegra_pcie_dw_host_init(pp);
 		dw_pcie_setup_rc(pp);
 
@@ -1059,7 +1068,8 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
 		PCI_EXP_LNKSTA_CLS;
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+	if (!pcie->core_clk_m)
+		clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
 
 	tegra_pcie_enable_interrupts(pp);
 
@@ -1687,6 +1697,7 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 
 static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
 {
+	clk_disable_unprepare(pcie->core_clk_m);
 	dw_pcie_host_deinit(&pcie->pci.pp);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
@@ -2266,6 +2277,13 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->core_clk);
 	}
 
+	pcie->core_clk_m = devm_clk_get_optional(dev, "core_m");
+	if (IS_ERR(pcie->core_clk_m)) {
+		dev_err(dev, "Failed to get monitor clock: %ld\n",
+			PTR_ERR(pcie->core_clk_m));
+		return PTR_ERR(pcie->core_clk_m);
+	}
+
 	pcie->appl_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						      "appl");
 	if (!pcie->appl_res) {
@@ -2449,6 +2467,7 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 	if (!pcie->link_state && !pcie->slot_pluggable)
 		return 0;
 
+	clk_disable_unprepare(pcie->core_clk_m);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 
-- 
2.17.1

