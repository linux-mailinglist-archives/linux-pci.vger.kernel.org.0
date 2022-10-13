Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263B45FE1AC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiJMSn2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJMSnC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:43:02 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2047.outbound.protection.outlook.com [40.107.96.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A2C1929D;
        Thu, 13 Oct 2022 11:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuwA2ZcBtySavjbswlEemEQ/vI2MzyR3anQwG0HrtFG99Fb5PzknLlzda851Ao7gHHfkSqUVam7rvoVrW0fpZfVJij4HdB7HlXwy7SI2ANpmrX27bFFlmNHJp1eu8NlRTknTn3r2WwD/ZowBRB9xEOg1HLSS5kxhAegdRZssAzQJ9Nibeqxr+BsdK0TOVsbKhXPY6hLVPnEDiwlIkgsPBORHehziJWKNzmsw52qKv1Z6zzrux3WhBgYwNa6BOdI9GnSi5m7SrJGrM6rsTLdSxtoygWgqVIvGtlhHtGzuyKPtlieh//Vi8MqefpPAsYu2uoaWPeuXjX0caMGO9Dh2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEfQavBN7MZ0wUAhnJBthx7U6nJZTglMIirSa0jSIYU=;
 b=Om828uqvMlvEk9CXah4l6f0KafDZKlAkZC9OhyyHHYoq7lKfX3BjCJAqql0Wi0TNE9644ivy6ZKW3NsQdFr34IOl4KUDDbLrqEKb+z341l6QLviUVbb45QwK4LmpJdl6YCxmq3XZH4VQoAnJyfBl3P6xXx2B8G9Y2712TMTvRaPVTkiw91nfXopfvk9OCsLKh1lPMSKvOAGXkpZsnQcXjkwNQAbPpQdDXB/HI/oPaMr5COf3z9doGWMFV2Hm4haZNlpI2kT98SNnyHFZ5IiyV0XnJBB9pBenA5MCtg1Hwg5IL+l7Ann4B/weFe0CK16Z7bm0CP+WTLt1f3HuBghesA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEfQavBN7MZ0wUAhnJBthx7U6nJZTglMIirSa0jSIYU=;
 b=dhmsjTfgfBtb7Nn1rY/FdITmFDG3LRdw6q1eroTtd6pi7JC+sLX/0Qev7oGHxCd+CqDReVjBJfvdYhGGLZc+pu7/uVEzg9w6luEc6GFLO0fBRcIS5v7q9jnHjcAicRvrc62AkG9dFaVWA+1nDb2AR8K22txD5M3RcYrB14WTImyBx2TWzqOQGP39FDUE3ghQY18JcOOHvN0MbNnCz3i1efJQc9O8bah+ZFIMLTb2+nzakSd6DrPFk/thD6aAOduyTmA33aBVaXudkkM4MysZ9/T/W6uLIiTp4GGbqIR4OZLjTRAykbw6qyOyoHJ279NRM1Qnr8aXzSHHEBCvMm4tjQ==
Received: from BN9PR03CA0489.namprd03.prod.outlook.com (2603:10b6:408:130::14)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 18:40:13 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::ad) by BN9PR03CA0489.outlook.office365.com
 (2603:10b6:408:130::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 18:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:40:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:40:02 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 13 Oct 2022 11:40:02 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:39:58 -0700
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
Subject: [PATCH V3 09/21] PCI: tegra194: Calibrate P2U for endpoint mode
Date:   Fri, 14 Oct 2022 00:08:42 +0530
Message-ID: <20221013183854.21087-10-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013183854.21087-1-vidyas@nvidia.com>
References: <20221013183854.21087-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: d168f173-7866-4d8c-54f2-08daad4a5d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xEc3vT0NIjhPigPclO+fS+nPvr2E9Z/ck4J723D0VvfBIB67yKZpYf2Nf/VFK0rW73vtuATbCkx8YLGDH329nA9yOfw4loOEqxJD1+UuSrlSL/SPo2PNYj356DYnjfrJpJnXnewH73WBPvaJsg1jnyKY5kg5NdsFulvgSLfp0w/2XK/gvv8dpi2lAQbmyf9o4iHUrHflZFtAGYXap4Tz5IrHBcf7uqaz1ZXvB9f6FwU0c5rF395sEBQpjLYUCMlhU8ZmqpekjXVH9yoBm25bEdNwAPkHccdw3pyHE6dndX4yZHFsqHsKzS5b3fTqgdLtR1F0L1v+FFtsqGp5m4LmyZMoEkMrcEF+doipLP5f6Ft0FQ7SOWZPr6LA7bhxugi4dIVBk4wyiCe//bb5edbXjnD9Cz/Rk7UaeuAL+JtFng7XktsTHmX9qgCvBJ8JRAdvOGN5FM+oByPgyV64RqSmrxigsaKToF4k01xq73xAqyzgWEHwMyKYFaTG/wk2DnDZ9fuDz1W2wqTEshl+Jtz9AQ2J24iwcGplm5yCzJlKE++NgDanXzZ4F86h28azLkwcdqYweYwZQRsHXwykdBFfE93xLeP3f9soS13wJgdAPp1OIWbr1KOQKfwSVFPv7Ao3oAd3l3e8Rdsvh2idYDY3RpC7os4/oIc2PXXbuoV0SHvCqmDCgKSLP992ufH2wK4Dt2DcSV9THYfb3u+8CEHH3wgD1fwXz/bCvWC5Nkl+ABdfBhUPyKIc7bgsExTf/CbZg7xrO4Z1x7VLvHH6IcAQjjOfT72qGK45igYOlXsbRss=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(36756003)(921005)(86362001)(356005)(7636003)(186003)(2906002)(47076005)(83380400001)(5660300002)(336012)(40480700001)(4744005)(7696005)(36860700001)(70206006)(2616005)(6666004)(1076003)(7416002)(4326008)(70586007)(426003)(54906003)(40460700003)(8676002)(41300700001)(26005)(110136005)(82310400005)(316002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:40:13.2232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d168f173-7866-4d8c-54f2-08daad4a5d83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Calibrate P2U for endpoint controller to request UPHY PLL rate change to
Gen1 during initialization. This helps to reset stale PLL state from the
previous bad link state.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* Reworded the commit message

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index dff38f73d9a7..910dc6c2154e 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1130,6 +1130,9 @@ static int tegra_pcie_enable_phy(struct tegra_pcie_dw *pcie)
 		ret = phy_power_on(pcie->phys[i]);
 		if (ret < 0)
 			goto phy_exit;
+
+		if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+			phy_calibrate(pcie->phys[i]);
 	}
 
 	return 0;
-- 
2.17.1

