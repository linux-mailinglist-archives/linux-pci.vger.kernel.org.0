Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5365FE1BF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiJMSoG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiJMSnn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:43:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6BE186D76;
        Thu, 13 Oct 2022 11:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7hsZGoCFhZHxOkGh9UgTbVte0KdDd1fLuQOP5YbdWhrzZ9uGZxWlmILBfCMmNWe7eaK7BHkFx1w1dTOfHsVqlxBHXS9btMovU1TdX8abu+IfBK6mHbt80XLms/5s/XBUkO9DNDCniG3mTVxmyXUj5B6CAFCopGPZEnyYp0az8VxmG7R54b3gS2fe8M6zXsxqzFBDiTEjQayRQZlBspCAqsBb6AR75jryRLRHDB9qmyim8A+ilFnA2eL5oKI/V4FBnHQTOlOGizk2yyTG/i5poQyw66zTj6KAOcTcqUmbQ/mAkwUZJzOUvH/BDc82YGBrYKcIEUC9jwpd+ZxNouqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH5YgaTVUz7eF4RuTjJb3wToT5WFijNGSYa0v+Q8n9k=;
 b=nvk3uAaS863txYtWBnBn5WEV+QagYKCxDprTnFmFUt+7ooOHw7zlyjUN+y7M+zRZLxG7tI+nVfwQQdKyLNBQ7quB0mx31RhEk+qgq8HrvOpNkJ/ETKoEMzlGBICQlHNVHbjUUMhMSzt60zlg9o44UvCktcPEutl49CtiPK+3oTwCY8901tRZAztqu6euwai6Opjz6CRlAPQ2TKPuB4yx081jr0BufBAFR0qQAKwehEpdCZZyNXThRR6QmiDW26UJ7G/GgqeDeHzRv/qEE5T9VUbOnnDDEVepOCxzkPok/JQe96g5mlk7rIsztZQ/2M2LA34o/ZZBlwqcCsmb3KWWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH5YgaTVUz7eF4RuTjJb3wToT5WFijNGSYa0v+Q8n9k=;
 b=APXpY6AasBmOL/DLHFKhmRR1WNlgekBxuUgG9IIWNuE9yFU1u4YIy8Rb7Dv1eNtmQNfeExLIJ9TCiSd1geRu6vcktu1SJANBhy3z0jkNa/Tppf78xU+CzdacQvWX/mqe3e8djDjGQHb9b5XyGFiBSf9LXTLtXPz4ZbjGqw4Ulx3BqeO/JWi2UfQ79wdoTqerWh5/Q4/DIVDAzwqei3mzCwQNoBk4r5At1pw5BG9yCU69VJY/Wp0TSjpmpWmYi7XkkWqlrHG5rBr4KlKUD7UI3uccYcLX4hnm7PUp1CPp3FFXRd4e1zuKcH9bgv2/pveWsxblwxmkWULnOgaEYnmqrQ==
Received: from BN7PR06CA0055.namprd06.prod.outlook.com (2603:10b6:408:34::32)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 18:41:02 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::9f) by BN7PR06CA0055.outlook.office365.com
 (2603:10b6:408:34::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 18:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:41:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:40:55 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 13 Oct 2022 11:40:55 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:40:50 -0700
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
Subject: [PATCH V3 17/21] PCI: tegra194: Reduce AXI slave timeout value
Date:   Fri, 14 Oct 2022 00:08:50 +0530
Message-ID: <20221013183854.21087-18-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013183854.21087-1-vidyas@nvidia.com>
References: <20221013183854.21087-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: e6fd0f5b-70bc-41f4-0daf-08daad4a7adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AqkhDQWU91IyuBqSOIhiZWgwYxSxJ6W3X/j+wgcOP9uSXbyRqzoO7jqDyEFHy0kIVKGC83cgUex4XrbHyVQJrUKP3e8Los5RcWEOiC5KrW9AF4iFida17SgESkZ60msx8ZxCgKRACDj4npm8pvg4HuhSb0llGnukWvQFMwCqo/dOxv6WHmwATmsu6I0wRgSkbu2nlvlHZkUGuEX7bjX/0i50iwuemayd41oNFuZcThFotJ8UmRbnh+NoJPYow9eEMwAiDTxGGtVwhrMyFmPUJfO4gw+KsMXJFgFMopk7a3kTroGf9JTb4CqAvkpX9FB15Fod/WAea3H10K0RSzkz7mSzMhxx5XdfzuGcyP/nETQiZ1LOf+3fREdEID6XEM4LyEs/4daNv/IHA89iyxpf7t0+zRBF0lapvACLNCwdMwjyQs/V5N9HGnOvMa82aBAAaDLsWot2jI+C5MMf51F+iUSsJly+wloWioJxpvhYEeyNBRPc09c87awrNlOPp3QR7QSayEctbn7UM3GH1R0twiF9rmALfD284cuzJX4GlcJosmSG5lLLqRRHH4SnZWsc4uHhvyFXlpTc+gEosvlU3bDMMiX2AHEKPAXq9Pc2aH38CuJR/njne01siggBX/Uu0spQcQgBM0I8gVfi98iREb76DCv9YE+ivOSIaULrL4d2w5/tEVDHHihui9B2lN7l0nso/LIeuLafELuUZsT/8v7mRBwUUadtDJ2p8W0Zwz9E4M3D2nsW+UmLgfrAIlCY3oPQSJE7CvDRQ1k3FrCMykK2g+SsVmbUlOqZ/+u2QWU=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(54906003)(356005)(7416002)(921005)(70206006)(70586007)(82740400003)(7636003)(2906002)(5660300002)(40460700003)(8936002)(41300700001)(36860700001)(8676002)(26005)(4326008)(110136005)(2616005)(1076003)(336012)(478600001)(7696005)(316002)(186003)(83380400001)(47076005)(82310400005)(426003)(36756003)(40480700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:41:02.4938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fd0f5b-70bc-41f4-0daf-08daad4a7adf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reduce the AXI slave timeout value to 7ms to be in line with the CBB
logic's timeout value and to avoid CBB reporting errors because of no
response from the PCIe IPs AXI slave logic for configuration space accesses
through ECAM when the PCIe link is down. Also, set the Completion Timeout
value to Range-A: 1ms~10ms to be inline with the AXI timeout value.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 23ca97401339..7890e0c0c0d2 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -198,6 +198,12 @@
 #define AMBA_ERROR_RESPONSE_CRS_OKAY_FFFFFFFF	1
 #define AMBA_ERROR_RESPONSE_CRS_OKAY_FFFF0001	2
 
+#define PORT_LOGIC_AMBA_LINK_TIMEOUT		0x8D4
+#define AMBA_LINK_TIMEOUT_PERIOD_MASK		GENMASK(7, 0)
+#define AMBA_LINK_TIMEOUT_PERIOD_VAL		0x7
+
+#define PCI_EXP_DEVCTL2_CPL_TO_VAL		0x2 /* Range-A: 1ms to 10ms */
+
 #define MSIX_ADDR_MATCH_LOW_OFF			0x940
 #define MSIX_ADDR_MATCH_LOW_OFF_EN		BIT(0)
 #define MSIX_ADDR_MATCH_LOW_OFF_MASK		GENMASK(31, 2)
@@ -922,6 +928,18 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 		AMBA_ERROR_RESPONSE_CRS_SHIFT);
 	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
 
+	/* Reduce the AXI slave Timeout value to 7ms */
+	val  = dw_pcie_readl_dbi(pci, PORT_LOGIC_AMBA_LINK_TIMEOUT);
+	val &= ~AMBA_LINK_TIMEOUT_PERIOD_MASK;
+	val |= AMBA_LINK_TIMEOUT_PERIOD_VAL;
+	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_LINK_TIMEOUT, val);
+
+	/* Set the Completion Timeout value in 1ms~10ms range */
+	val_16  = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL2);
+	val_16 &= ~PCI_EXP_DEVCTL2_COMP_TIMEOUT;
+	val_16 |= PCI_EXP_DEVCTL2_CPL_TO_VAL;
+	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL2, val_16);
+
 	/* Configure Max lane width from DT */
 	val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP);
 	val &= ~PCI_EXP_LNKCAP_MLW;
@@ -1988,6 +2006,12 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
 	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
 
+	/* Set the Completion Timeout value in 1ms~10ms range */
+	val_16  = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL2);
+	val_16 &= ~PCI_EXP_DEVCTL2_COMP_TIMEOUT;
+	val_16 |= PCI_EXP_DEVCTL2_CPL_TO_VAL;
+	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL2, val_16);
+
 	/* Clear Slot Clock Configuration bit if SRNS configuration */
 	if (pcie->enable_srns) {
 		val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
-- 
2.17.1

