Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CDC5FE18A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiJMSm1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiJMSmL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:42:11 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06F450F81;
        Thu, 13 Oct 2022 11:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZ7rKNQ/jexpqOt3jvK1VMEULAiE2OK1RT3GekxIexGn8R0RdBJv5rI26n/dYQQl6ZsQYwjlWc1nF4f5E5iqd+pgr0s39dzdfYLTvNrgT28DXC6KS6/ZClQH8W1AnObv0FmO2GYqHw+5+aH8qm8mqETR7jNZsLFHzsN8Va09mG/cqShTs2ql8HCdypaElVviCt/rIR3u4o3XDEsaJDFvLVR2fIVPfEdrTtGB8NF9HLVLNcoVVwsRS+yHRCgTf/pKAthvqSi/zX9a4cAFctW0xDGjI7LGxz9mCRfkAZrTxI1WAOaJ61Nd6+Y/j4JYA4sTgLo2pUULbhx9upGn7bNJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqT1A7WR0nbhBF22z/tKSNbOEqvEgC/iyokFqYFxUsY=;
 b=Z1omfP5lk1lwbIlXjDAdMysQqh7ValKa18aiTrGfFmr0hZ2nwDkUX2eRSxMfR1o95N7B87Nor7krXtFp+OMa8StKeikQtcy32zzYlrfySa7x9sQtdtgGp7c3beDK3n4Y/V4Xxf5Skdhd1n+H8ENOXkHSWqF2I15BM9aIvhSomREmPeUmnAOiZZ+6Y7gu1x0NLRP39Egb/38pmc1irnVrTl/BtG3dDFJaUHLs//xjPr1W4YDvq64UqgJQhxr2rs8K0bXTtJUtsBO8xeG7K+neaUKC+LrFIAP7aliitfo42hOvt1l145AlflHfbRGiXTXwc0/MNYgeKYswFCTIwBWBRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqT1A7WR0nbhBF22z/tKSNbOEqvEgC/iyokFqYFxUsY=;
 b=pXB7ZyyfozbNh07Jiwy1qtyIK7A+VoqYxzc5mS/Pu2vQVfacEayrVKedvxy/15FBZ8O6arSla/K9C8Bj4zQRXD9NWSm7LKDf50r2GjK00nQlR15tH+ARZ8owxlM21TXpjdlR5KQEGKNq/8TL6zRjz7IxEzTWGY+7V3Kf8c/KGRJXil3X22pY2iglsQtpsFxDTXLhozW6WUAY3Dqa7/knGJnU7lEq6dwovMRTojuZQegrj41twUY7wsk+5dGfnwdmAtdG5nvIHwWH7vZWOBpuORBfNwta31t/Lqb3o0rxTXF8R3wgbCgCorhsxnnjHCwBm/W9dLDXfYeRs55jYl4gSQ==
Received: from DS7PR03CA0164.namprd03.prod.outlook.com (2603:10b6:5:3b2::19)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 18:39:20 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::be) by DS7PR03CA0164.outlook.office365.com
 (2603:10b6:5:3b2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22 via Frontend
 Transport; Thu, 13 Oct 2022 18:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:39:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:39:10 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 13 Oct 2022 11:39:10 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:39:06 -0700
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
Subject: [PATCH V3 01/21] PCI: tegra194: Use devm_gpiod_get_optional() to parse "nvidia,refclk-select"
Date:   Fri, 14 Oct 2022 00:08:34 +0530
Message-ID: <20221013183854.21087-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013183854.21087-1-vidyas@nvidia.com>
References: <20221013183854.21087-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 5caef5e4-3b86-4085-f550-08daad4a3ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npRGwRiT5hfrvR1LhwRtNU2SaBko/QxuV/Lw6q9WiTxQ5jC81LsnIWPAuwy1jj8q1To3EnTT3V40940wnphKVPDdxaT/v5JivcUsZgSfu+frfocSw9V5tFQKQE/6eOaz8g8lhCrzcD/0KlJoQkdk66yQEverN9Yf7v7f4I6QI2vFKNNC38/fZ0/KaGN+SCOsPABdYMVPcCwBFRZaWrIFi7OQ99XHUPppbooUDtcTCh3TNtKGwKPCqj7SHCE+df/p+dolwEBNk5fbMnIRsVFv3nUnbfoll3p+bHfv5h+O/fGhmXFQrBRtuTkDHMZPfrKwQdZ2Gtxf7mvV9S6PTdZ8YxMkR54c4j3DXJN0iZbvNugPDeo5ypJMFtljt0SwrGIqKSDfyFRf6FZ1mzhIYYqJvcCTR+s4ckXWTgU7WFBZsFE7OWQKjFdhFGs0gG19ceYrdx3hygFmWP06QRrz6XIR6cl9AwBMBXIgsUr5lyl+xKBeJFVSgaAAxcRMyb2PJLWXgHgM9Qvm1Hj3bsoKzkzQZCD7BfCv6JxT79n8VH9h7uAKbr/9xj9bICfF55/ODDCq01rPzCWD2kcw1+vFBJfXfpPzcPoQKfnQkRQAOKqQL2EIr5q5R9LA33htNdQw8TzUVjkhkunUBmNLkM/obNN3E6ro3yGfgEzDjYUnLhS3Z1CCOUYTjRsVqE73vWgRTzexmo0wXBTqcM6HgoM8mBMd7CJ8hZ0+T7QEOgg8MQKVwdmGz1lOaA3K95AFSD/ojLW+gC8Kjp8IzAEQIkwokJSTErJIO/Ch8ZsVIezQU428f78=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(26005)(7696005)(36860700001)(82740400003)(4326008)(316002)(8676002)(70206006)(921005)(70586007)(7636003)(86362001)(40460700003)(36756003)(40480700001)(356005)(82310400005)(83380400001)(186003)(6666004)(47076005)(2616005)(478600001)(54906003)(2906002)(41300700001)(336012)(5660300002)(7416002)(1076003)(4744005)(8936002)(110136005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:39:20.2974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5caef5e4-3b86-4085-f550-08daad4a3ded
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The GPIO DT property "nvidia,refclk-select" to select the PCIe reference
clock is optional. Use devm_gpiod_get_optional() to get it.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 9e64b948f999..d7ab33931de4 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1233,9 +1233,9 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 		return err;
 	}
 
-	pcie->pex_refclk_sel_gpiod = devm_gpiod_get(pcie->dev,
-						    "nvidia,refclk-select",
-						    GPIOD_OUT_HIGH);
+	pcie->pex_refclk_sel_gpiod = devm_gpiod_get_optional(pcie->dev,
+							     "nvidia,refclk-select",
+							     GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
 		int err = PTR_ERR(pcie->pex_refclk_sel_gpiod);
 		const char *level = KERN_ERR;
-- 
2.17.1

