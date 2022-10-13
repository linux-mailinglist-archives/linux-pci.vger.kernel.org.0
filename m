Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B625FE199
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 20:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiJMSmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 14:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiJMSmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 14:42:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612AF26CC;
        Thu, 13 Oct 2022 11:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjeSDBU8fyT/j3/3ycAgblyLzYUF08XKX9IXXqQaFQ6cVXfGdRSxuZee0uc/GDkXoFkDddEBBIzrxErG0zDfIll/PdwOw8KBnDzxaV9fGnTkyu+gpd7+9bqDRiu6tpm2EOBjli2J2OfBxEWdG5dujTWC12b91rvhEQcRg3u7ErAgUIukGFy7OIhmxdwzNhJkecafq44NJwRpM/C5YrToZJjMNfUT4XsI7nsCbFnmxXuaYUhN/3qXHJ/c8Axwzd9gq1Fliir+ruID8UyihAE/Vight67fKS6XYMcRlnnlH63nBfX7swhvD0rpweeZpjuJfgdXu9VIoc1GRFS1aDsRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsqlbVud5olieId7V11LFR3ftBXKyulSOt8ZhpHQmFY=;
 b=LEFrbV8fXPI5S6sJxY8caMT/Ua97uCqs9CdhtB2FZ5DlVCXw7wDGIrlt0GuRx5RgRwQ6XctUFTJQCYo4da9cYqXZ3USMnnrQV0/CM2S+OPGmf6GR6ua7p4yinLiDHOLipXlWo7R8o6hWhAzMl9+wPKrv6fYukxE3jgBUYe6OmgrjwHcLNcicK6opVKjtZBM+S2dSv3aYawn4kN4kOPydK1aveEUnPmYgjy1H+uXEBb0cQ6hbpqxccoCpu6yew0q+djv7LdlzOI/B2ndCBcD7Hfitx3Kg2shP2C0marxZnJm/a0rVyfs78lvj+bs+YP+yXc3a2nAdsnXu/St1na9hJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsqlbVud5olieId7V11LFR3ftBXKyulSOt8ZhpHQmFY=;
 b=SCQBEg5X+3LCmgsveBkuAWOEOQvx+Q/SoJkza89e91TPTjYLPObSg3pryd8odugg6gKjUTB3LM7ZJukPvuWsO44XaI5mBoVGT8pGcPN3RNQ3CoeIn2/1Oi6y+1P0lc1Lm7K6LarZzuzxdDEOj9m7yxgNRmWwNwhPb/0bBxTN5baKMgFRQCFoXURqrgJJ0lC+anwTaT32rKb3rXnwcBXz9VJ8vqv9XliZp8cUAXZ/b9asszI++2SxavyVCUA9NAF4Eh6ZKPsYUa9kM/3u269vd+NmfXq/10yYuvFGQKVl5Ui3NFTPuALlSPEZvbpGPFo7SSVaRo6YrPF5py6H/svHpg==
Received: from DM6PR02CA0168.namprd02.prod.outlook.com (2603:10b6:5:332::35)
 by CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 18:39:43 +0000
Received: from DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::ea) by DM6PR02CA0168.outlook.office365.com
 (2603:10b6:5:332::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 18:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT072.mail.protection.outlook.com (10.13.173.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:39:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 13 Oct
 2022 11:39:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 13 Oct 2022 11:39:35 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 13 Oct 2022 11:39:31 -0700
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
Subject: [PATCH V3 05/21] PCI: tegra194: Apply pinctrl settings for both PCIe RP and EP
Date:   Fri, 14 Oct 2022 00:08:38 +0530
Message-ID: <20221013183854.21087-6-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013183854.21087-1-vidyas@nvidia.com>
References: <20221013183854.21087-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT072:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc82c90-7468-4685-9097-08daad4a4ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAaIYqXgsXfnp4zge9NqFPRPIykDdXDxa+15TaY/gbqnPnH4iOH3w7IvzG5GjdWgwjeuLxQ8S+qJ5UMuwDyLLNSzqS7O4g4iLDOSatsEG+d5cndogPkjaDkxPAP7xRMddKUBchT/JG7192LfBg/Sfj7gcYf4v3eh0qPycYtiG+A2OG138SLrFBcNoqgIzygq0P73faWW65aVjWxl12gBVQcAoa8gVrBbvx6FTXkOe3G8r7vlQZHZVPJndWSfnWbJ9wv1uKycvvSC0bBZyEFkSDifsxzNrCkCUacow76feWYyw7ArOiGEbWIB4h9brhgZBBwNaHqAwJHyuYs/+bp1xMjC7z51qZCalJWAbQzAz3FVkE84MezKLQ3fIB7EKBI1D7lOAWvKdEgM/fDrOKukjOA3K8995pAOqagK0IOsFq5GB6zUKfIh8gnFp5BnWC+KoFFtXf2WkjAaPug/PfL28YdW6t0wGQDHzjympx1sFp7YTEqS3Dz7KRxxjOGBAGaIYfnBqlv6Mrsh2ZJ6Rr710ntPOkwfPQ2nrCg94FvyVCZHooSbcNxNZXNcU1kEp9pH0ATIsv5cu9u2PtXKldFbp6sgP0tsb+7x8B7EHgWUbK3MJ17WQYqlImYAzqdDKA+9d8epOueTxA8RP3LwS41gvYPv86q9a9uN3Uhdk1kuwVy8kCETq4DJoWKHYssmbd0joa4i49JJHdzd2oUtJECOjQeOgZ8EMfrchpGoiPVQ1b5dIVJCQdj7qqDCvyo68fYuaFvGtGsCSogqtqmmTC30AZXj1r0wznMPx0UJTFN2e9Q=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(7636003)(26005)(7696005)(36860700001)(110136005)(54906003)(8676002)(316002)(36756003)(356005)(82740400003)(40460700003)(40480700001)(86362001)(478600001)(2616005)(921005)(83380400001)(5660300002)(1076003)(426003)(7416002)(47076005)(336012)(70586007)(8936002)(2906002)(4326008)(70206006)(186003)(41300700001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:39:43.3267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc82c90-7468-4685-9097-08daad4a4ba5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PERST# and CLKREQ# pinctrl settings should be applied for both root port
and endpoint mode. Move pinctrl_pm_select_default_state() function call
from root port specific configuration function to probe().

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index ae7e0d8f693b..69e11a74a0d7 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1716,12 +1716,6 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 		goto fail_pm_get_sync;
 	}
 
-	ret = pinctrl_pm_select_default_state(dev);
-	if (ret < 0) {
-		dev_err(dev, "Failed to configure sideband pins: %d\n", ret);
-		goto fail_pm_get_sync;
-	}
-
 	ret = tegra_pcie_init_controller(pcie);
 	if (ret < 0) {
 		dev_err(dev, "Failed to initialize controller: %d\n", ret);
@@ -2191,6 +2185,19 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	pp = &pci->pp;
 	pp->num_vectors = MAX_MSI_IRQS;
 
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret < 0) {
+		const char *level = KERN_ERR;
+
+		if (ret == -EPROBE_DEFER)
+			level = KERN_DEBUG;
+
+		dev_printk(level, dev,
+			   "Failed to configure sideband pins: %d\n",
+			   ret);
+		return ret;
+	}
+
 	ret = tegra_pcie_dw_parse_dt(pcie);
 	if (ret < 0) {
 		const char *level = KERN_ERR;
-- 
2.17.1

