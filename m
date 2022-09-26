Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED515EA73A
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 15:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiIZN3C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 09:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbiIZN2k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 09:28:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F0A1DB545;
        Mon, 26 Sep 2022 04:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrQo8jJX5+uSxqNRgFXSQPqvXo4Bu4YkTDelOSvwRDiOdgTPTLp1KCK50+0jabAZ2mS/5Vmm9sCxS2cv2abJT0ty3aaqhJJ4DbBJxd4RFOsp05RgNpzU9PG36xsqtBAE2PMCoH8ANAb7vlLuBOz+p9WyTO7yWDYTuevZI69NIAN60t6jUNzyoZCEmSQ6iVvs20G7iPJ5k3ZEHN3yzYlZWX0Umo1kb+t7ZwLE/KvY0BsCQOcuvQpC37cYv0z6UMtEwrQnPxhY/yIlo0r3E7PY0jYdX4+iALLODGi3cpVkDyFms7J6XgoWpumuKHNRHAbZAExrQnZItSG0NV9hUKNAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKmaV6+jF1xw8mvpP63nGfHuSHfDEvqHRRTHfVhsRmY=;
 b=WVdwzv3OylD6H5OysJNepphnBWjzhmvu/GnnNGTXRNUzt4mk4KJM2sfrqXGWS0UB5ciIt0jvjdMgLwHYNYUpK+P5cJ9PbnVcmIrGXw4QlGsZjBseLlsoHcA5aQLYctuBh3QSOypDTUDnDBXbfGpjFGx2QYqQ9xR7Zn5gGEglx92cdJPTjZsETpExkTCXW0ASr7W8ZdS38q4nEjo7Dwsnlai+9UWQRNPyGkLrvu9tFCipBC0wbKjUg+328JVwDZ7nchLTKv1YX1ZEwNhA7kcMy7TJgyZwU/7DDN6Gx2hElnCA9TTfxznYGEW4IG8J/qhQryHl7LhA/jl27XRh7UanfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKmaV6+jF1xw8mvpP63nGfHuSHfDEvqHRRTHfVhsRmY=;
 b=pL/3r0CJwt2P1IImaC3t6Vq5g9a/rP45mcMAMWYyA1qXTd8ddiO54u6bwoSfCe1EzAfLdIPVziN/GYP2E7ZBLnSZ2aXe70/5cNW8HFlK3E+cmlfrLtOVnGLrvDqH7YaFJBWRY3JKObhSA78IjZiKrxwviIAjAyyBVx5YXG8WVW2+E1DYDqZuG3x0ZfBOThNZPTFJZNqGHdIdf+oYnDY6vgCy5iyqFHGq/UCRHZ2Rc4etqFRwEu8cR8x+rOwYpN3ntSkq+5DwnOAfgPRiJRGwDb+7xie85mJ3sqdTCMJ1Tk/8+a4F8w73iFJ68UjVIFoYKOlQTgU/mchMUv/lIdR33g==
Received: from DM6PR06CA0060.namprd06.prod.outlook.com (2603:10b6:5:54::37) by
 CH2PR12MB4969.namprd12.prod.outlook.com (2603:10b6:610:68::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.24; Mon, 26 Sep 2022 11:51:56 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::ba) by DM6PR06CA0060.outlook.office365.com
 (2603:10b6:5:54::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 11:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 11:51:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 04:51:45 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 04:51:45 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 04:51:40 -0700
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
Subject: [PATCH V2 9/9] PCI: tegra194: Calibrate P2U for endpoint mode
Date:   Mon, 26 Sep 2022 17:20:38 +0530
Message-ID: <20220926115038.24727-10-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926115038.24727-1-vidyas@nvidia.com>
References: <20220926115038.24727-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|CH2PR12MB4969:EE_
X-MS-Office365-Filtering-Correlation-Id: d03c46b7-4764-4a8a-dba3-08da9fb582d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5Lvs5y0SAvyYGf57NeNY6CsvqWA3zHAjyDFQeOcz0be6P8SdaKun70Kd5Ge/1JKMdkdr5AZ9eoo/tOvC7HU1G54XtwQw5eQCm0MIQnkP7fOy4KQIlOOq+FJF9EQ3fMVh/gj8a5x8JIYdSVvBURQUGEObTQcBxVBzcNbM0onURX3amGs0cWCC/lFELd7hm+rdZB7is6WmUwKdmJ4Hu4v/vfh8proa1bZQCXxdNvzPyyAvKvdOAXzM2i9LgUdCRLt9nFwbW7yUrIxMAnTKbrxPJLjtb6r9evpIAeg55j68KV6AH8GSdn0o1sHINX1jQLBTu/Pa/oeE+/n9jlyLAduDhtM4DPi1AOZ4EF+gkZM08wUOxzfgjBzuGpQfjfUQSkh3FEiP6kUmT8HwnR0STaHjaSJIC8mpWbiQicMT9M60/hhn2STzZtyLmkY4zXY/Wu6MzpJH2G+xuvLek8ZhaHyqdVU7dd+ZVIV9RG8z1vI+uyqHDXm9kK9GluKE7lNBk77dosQfC5nTiWxkLoYiZ99/RLSRVHjsWkzHlUNTGZrY9DPo9TJz7Kr7Eqlplg1ugOP6epAD983fhOY/pY7zfgAt1hXg29Owf03K60EciUWsszLu0IRIUO6QwcVsV7+tIMm7e3mhNpG9dy/YjFRz3QYaWco2hv8wiQA04eSrXWdRTprnoYKQSanbY1TpO03nJPUEFTDk47Qy/7qCoiRsyLY1ubCx1vK4Wtb6amxtNi+Y/+O39V6bu3fXo4tZm1/HGttLVU+274QMZkiBVSzqEqQOLQIp8AgF65WkRuAGv5dEjw=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36756003)(8936002)(47076005)(86362001)(336012)(426003)(41300700001)(1076003)(2616005)(83380400001)(110136005)(7636003)(4326008)(8676002)(40460700003)(356005)(316002)(5660300002)(921005)(82310400005)(2906002)(70206006)(70586007)(36860700001)(7696005)(40480700001)(26005)(186003)(54906003)(82740400003)(4744005)(7416002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 11:51:55.7865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d03c46b7-4764-4a8a-dba3-08da9fb582d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4969
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Calibrate P2U for endpoint to request UPHY PLL rate change to Gen1 during
initialization.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 3e4868ab8416..cfe32a98b2f3 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1078,6 +1078,9 @@ static int tegra_pcie_enable_phy(struct tegra_pcie_dw *pcie)
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

