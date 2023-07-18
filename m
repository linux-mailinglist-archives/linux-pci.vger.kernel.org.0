Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D984E757203
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 04:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjGRCwq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 22:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGRCwp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 22:52:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB57100;
        Mon, 17 Jul 2023 19:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ1nGNChL9rW6+s+QobA7VtdmcYihqtnIiwOoV9QnTDjGOoROasIKNAh69ogtmYF70HhBHxIUBWSt6D+sQuDQAckOl12x2uykDF95+GLv3Au9DrGpAWlDyM4hRuj0H2zq0g+nmLv3uKIMzTUT0ezNf8ckS1iBV23hKUW5L1hqhSkle8LsJC4MSvPL/mNbOfc/TUt6wtTpc6fEN08TxFYnvJ5EJLuL+WcB4qWasJbmTI4iQQ3bC6Tk6Ldj/jtXv1jDmML/3KiEUR2HyzcVgOHKYKtDTqnMpPvWgfUP5iy/QZeCbk+QFHHiIuM4ErkaiuW3N3MKy3tC6fC2sbWGMHbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P723caHDol4blPPBY4pGCuAxWiX6ebABAOFoIPIHrbA=;
 b=KQejInKtTbQv7ZTaSyNBZpqaXppQZz69CBNcnDs1VjkBgsldZt1lWJK3yyGPqWDpLkX1aXEZvs/kurc0VgFcfsZ5TUnvhJIFNpLfvB00RVmss8nk4lwoidJF1Yvsea7R5Uy+KJnNKsmSyWWTCQP1IZIoe+2pAMhzlysxPE5/5gdleKzUdSpA6Zo6FYC5AB3fq3wvirgw0nHfcjkDJmQc+YQlD6SnPjUN3NFRoofEbAnjHxAcEo9Vs9HSBk7oglVCRS5Dwjruw95LwVGaQnZFzGeVgUalK3JMWL9vYyzWdadfdoehnW0nO0EWsEXgWF4+mvYeY5LL9drWGITIcVxgWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P723caHDol4blPPBY4pGCuAxWiX6ebABAOFoIPIHrbA=;
 b=smGa2TVJ1izKO6up3E2qhirGKx4jTgQKK2yOz2d/k3BLXzbK7pu5+ZElQMpw4lqPzBroR4402XhsCMz/QBm3Pcx4c1YKIycYeFuqyfNWHQXto9wpWAJb8X0gpuveYeVe7xdOLHiPWnpP4IgXIaDujxLFQ5sUONdAXmSf7xx0xmEHBkFWA13KJXlcF8ptwL01/S94lXyS1aYI5r8i8/+XpnICRUWjtVTyNGsvG4FSANXAEwkQ/6FRN/DWDiBChzn8y9kyvyCu8qJxc6Qmxi76ESkrLvKSWR3TvD5eNIfn/oy9NJ+Ta1EtD7c2tshZp3XHlfn+9Lrwq1gHNlmNpwKKLg==
Received: from DS7PR03CA0349.namprd03.prod.outlook.com (2603:10b6:8:55::24) by
 SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Tue, 18 Jul
 2023 02:52:40 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::df) by DS7PR03CA0349.outlook.office365.com
 (2603:10b6:8:55::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 02:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 02:52:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 17 Jul 2023
 19:52:27 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 17 Jul
 2023 19:52:27 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 17 Jul 2023 19:52:23 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Sergey.Semin@baikalelectronics.ru>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4] Revert "PCI: tegra194: Enable support for 256 Byte payload"
Date:   Tue, 18 Jul 2023 08:22:21 +0530
Message-ID: <20230718025221.4001329-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619102604.3735001-1-vidyas@nvidia.com>
References: <20230619102604.3735001-1-vidyas@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6fa4ac-40ac-44ba-d17b-08db873a0d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fhtol6cov1EfwWk00rG/ae1dvyibAOmP4k27gZ9wF0xGLtn8UAUiMx1xM028/1Tu+A4VxBxrMbhX75yBVEy2YrZdRH8iQKo8LMb8BK2m8HVEgEJIF5+3t4IWl6CBCz8RQIvFrp/U+fDw2d+Wq47F2fKkEl+eZm6v5m4wPa27Pn2PpHhtQFN6zlWvp5wGCqMicWNmwLmzk8b3wCE9F6w7fWMxl/C1s1GochRV4k8UL/xzpe0m42Oq5JPrX7AtqO8ZPec7p2QHflXeCP5BBBsUD/LLn8OlM4RtZiLD4tGi+qGivP4BB7/SB0k+Qq9gyuHiCfOREfbDp1Ek1NdGBjMNQ1h3kLPTn4791/8HmLUEgpZB8HO5Nsv1zlNAmdP8+0wHn1h5aBjRfnxGnimqdnRJ/sRrNxvQS7JQZOL0SxlD8u+2bPum598RZZ5ZWZPZBMnSYGqdRzqx6kQosL3vXLECYSBrLjnoHEatBekYI5UNMb0YpEolnNNqY+E5NkSenYuXo8iCkGQmp74ViAocis/+YdRm4u/EwbRcTUmPb30PKdGbRdgZKSaOeDiOeaVSKdOGj335/VxAJ+HZ+lSS4NNzk0kbNPWj769j45nC93Z1xKUUUYQiI2y40sx3U0jeamG1OMcO9KoEqrup0qEDQ6k0AJnH0qYscrsB0kQBzzDeCXdiHF2viUkOXXzvjWsHfPvtoXjPYWqGt6qineLGLvtHIJSAYKv/CG31XibHSK9ZF6DmA2EDXTunNq/6BT1x9E7X
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(47076005)(70586007)(2906002)(36860700001)(7416002)(7696005)(83380400001)(336012)(2616005)(186003)(1076003)(426003)(36756003)(5660300002)(26005)(356005)(110136005)(40460700003)(86362001)(82740400003)(7636003)(40480700001)(8676002)(478600001)(8936002)(54906003)(316002)(4326008)(41300700001)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 02:52:40.1961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6fa4ac-40ac-44ba-d17b-08db873a0d44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
payload"), we set MPS=256 for tegra194 Root Ports.

By default (CONFIG_PCIE_BUS_DEFAULT set and no "pci=pcie_bus_*"
parameter), Linux configures the MPS of every device to match the
upstream bridge, which is impossible if the Root Port has MPS=256
and a device only supports MPS=128.

This scenario results in uncorrectable Malformed TLP errors if the
Root Port sends TLPs with payloads larger than 128 bytes.  These
errors can be avoided by using the "pci=pcie_bus_safe" parameter,
but it doesn't seem to be a good idea to always have this parameter
even for basic functionality to work.

Revert commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
payload") so the Root Ports default to MPS=128, which all devices
support.

If peer-to-peer DMA is not required, one can use "pci=pcie_bus_perf"
to get the benefit of larger MPS settings.

[ rewrote commit message based on Bjorn's suggestion ]

Fixes: 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte payload")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V4:
* Rewrote commit message based on Bjorn's suggestion

V3:
* Fixed a build issue

V2:
* Addressed review comments from Bjorn

 drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4fdadc7b045f..a772faff14b5 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -900,11 +900,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 							      PCI_CAP_ID_EXP);
 
-	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
-	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
-	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
-	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
-
 	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
 	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
 	dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
@@ -1756,7 +1751,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	struct device *dev = pcie->dev;
 	u32 val;
 	int ret;
-	u16 val_16;
 
 	if (pcie->ep_state == EP_STATE_ENABLED)
 		return;
@@ -1887,20 +1881,16 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 						      PCI_CAP_ID_EXP);
 
-	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
-	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
-	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
-	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
-
 	/* Clear Slot Clock Configuration bit if SRNS configuration */
 	if (pcie->enable_srns) {
+		u16 val_16;
+
 		val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
 					   PCI_EXP_LNKSTA);
 		val_16 &= ~PCI_EXP_LNKSTA_SLC;
 		dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
 				   val_16);
 	}
-
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
 
 	val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
-- 
2.25.1

