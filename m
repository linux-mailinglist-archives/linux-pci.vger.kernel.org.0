Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4025BCF0A
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 16:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiISOhX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 10:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiISOhS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 10:37:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C5F32D99;
        Mon, 19 Sep 2022 07:37:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhhHMWCGRojwWVBvEzpqVCWAaE/qb71tPFb1NfVayzvfNUO+Hf9FeEdSzJTQEYr//xTE6Zo+DPSV1PwKWCDdnl40v7faiS5bTbb01CHzspi5sdQFO9YXbh6O5HxuCYmPKo8uB3PEVS1Q+glRIMA3khQwot6NK4A1rl+CIFo+xH5fiBETP1AORwo7dQ6HnMhH7bWwaEkkITn61EnlfovpSzRCnsLfFASSzHh4PobfNYEkpq+QKnxapTnIVVmNDMzKNlzEcPfh0UQ5bKulAi4vz9vPdiNwVmFKbd//XNdt+4wPl5EGZdKc9O7o0NVn+XtW2JfoPF14dcJFucPCU3L+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcPj5wXLd6TopjUqnyhqEg0mG7Ry1tjniNVUrQSStZc=;
 b=RSdOUEzpEahBEXWzBlZQcWSEnHGFDwry9gVFLgyjBfKyjO0i4xJTn0CNgDFpbzpAy/A359YjybkESeJrNgxN0xKyeUK6WSNxExTvQpxelf2FOX+npSUH41kNIBGwkIYEUftDAg27nozntD0/DqM5Dt36il6vSb1M+6FJQxoTXi+AttSLfYgYdl7lPcjRAHjGdKdJ2B6arwgKOSdbSbIWmSj387Q7YMdQUWLMo+agHqet+4aqFQPzHJZA09Eku3cDqVOczNaQTcQX1iyRe/O5WE4/jBwq9KuMXLf1Hi/pPXCV6MnkpXO4U8WdOYw+uNBJMfhJYsT16AZUPF/m1jTfHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcPj5wXLd6TopjUqnyhqEg0mG7Ry1tjniNVUrQSStZc=;
 b=nH3XNBITGKZs2X0QqaM/fqzwCYnRm1yGc9oRCy1nevMTNfYLVSsD3Rlj6Wzwq17hDuS7CXL9OmaTDy8DjOEDk1TVgrz3aD5zmoCRRZqMAtT7wWjnhr3+wJioOIQVVRaxRaUQtLLolvrIa2ZIrSpJxtyQTqJtvdEVJsFHD07gyIxxy45PgKf1lZ4Pv2En5gR6KIKl8YhkIiGt33mCg7ij9vp62YB4UX7mH8IuGaDM3QLVIU4Ad0k5E6FbgXGRQhMds95DFDbDv7ZIOs8d+9er1jKRueswkwd4kJZ6uLlawyGgPy41zcPOHJxo2ZsmyZWJUmo0V30IENW9hqC/ehwbsQ==
Received: from CY5PR15CA0207.namprd15.prod.outlook.com (2603:10b6:930:82::26)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 14:37:10 +0000
Received: from CY4PEPF0000B8EA.namprd05.prod.outlook.com
 (2603:10b6:930:82:cafe::f6) by CY5PR15CA0207.outlook.office365.com
 (2603:10b6:930:82::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 14:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000B8EA.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.11 via Frontend Transport; Mon, 19 Sep 2022 14:37:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 07:36:53 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:36:52 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 07:36:47 -0700
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
Subject: [PATCH V1 2/9] PCI: tegra194: Drive CLKREQ signal low explicitly
Date:   Mon, 19 Sep 2022 20:06:20 +0530
Message-ID: <20220919143627.13803-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919143627.13803-1-vidyas@nvidia.com>
References: <20220919143627.13803-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EA:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c4e4b6-c0cd-4497-bcb9-08da9a4c6f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qD17PPJURFZQw9pRJOaVBqz3hQIMUnRF4mAnO6Aa0i7ugFOscF4TU16mNnaqJfHLR+ZfZo9g9JKyPIM+viES6H6AE6kIXwu59QCtSFb/H09CKlVBbqOHn1NQiSrpDwm3I2GMflYNloAGvz7z9+O/6AzGihCX05iaLISwM+KFdOP0lOsQRu1ahxSAS1sFQixGM1fAQ4ljbkPNL38oSVfO/A5KIE+bsyvypGiTay1aHIvcLVmK6vx2RrSrVxZSKp51YBtYYCBlQyl6go8v1ng7lgqo1MDu7VKgRTe+FFMTCg0ZAtexC8GEPw0b6pumAaB1KsWBfj9wXZ6Ko8lcv6m1dPhGxf38ZZro2affhA0J+WF91TJy3bMAFIZ94zx8jomUyLbgq1vepUQ7Ig+b7Tf/qzc7ab+o+Z0+Pzx60f8jUtTQrepcEvtw1DVKhO87JMU8WpLDOIWvmv0x+0PgOG83sDRrjMVLnpt62P6AoEESvulMhBcUaXFBG/e5EZXJY1enTRz9n8jiIIfbZ65iAU3xWBh1Nul//y2ETxjznRe/AM9h6citMvssqhG6EwST6lzibuPnhCJ1Eca2V4SwPdRC800t/YGomH5w69yADvV5vqO6BFAmhU9o5sWMT8h4M5SLclOJPW/vM9tyNAevlDMemqVw7j+zM6B6hZ4EbG8Zq9MKuQi07RZqZ5Omt5qfpTvOHpwRqmK/Jx9N4nN9COTsXaLsp2OIjFzPOTcJ1x7wkdLI2zIl9tUQT9J90hx6Hh2cKXjTS+w4uEOC+YwrByzSGpxutqPfEcAAVw8KALara6Q=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(7696005)(26005)(2616005)(356005)(478600001)(7416002)(2906002)(5660300002)(36860700001)(82310400005)(82740400003)(36756003)(86362001)(40460700003)(336012)(1076003)(186003)(426003)(47076005)(40480700001)(6666004)(41300700001)(4326008)(7636003)(921005)(316002)(8676002)(110136005)(54906003)(70586007)(70206006)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 14:37:10.5856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c4e4b6-c0cd-4497-bcb9-08da9a4c6f9a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the default setting is that CLKREQ signal of a Root Port
is internally overridden to '0' to enable REFCLK flowing out to the slot.
It is observed that one of the PCIe switches (case in point Broadcom PCIe
Gen4 switch) is propagating the CLKREQ signal of the root port to the
downstream side of the switch and expecting the endpoints to pull it low
so that it (PCIe switch) can give out the REFCLK although the Switch as
such doesn't support CLK-PM or ASPM-L1SS. So, as a work-around, this patch
drives the CLKREQ of the Root Port itself low to avoid link up issues
between PCIe switch downstream port and endpoints. This is not a wrong
thing to do after all the CLKREQ is anyway being overridden to '0'
internally and now it is just that the same is being propagated outside
also.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 2631685e3315..d053e52b1778 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -46,6 +46,7 @@
 #define APPL_PINMUX_CLKREQ_OVERRIDE		BIT(3)
 #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN	BIT(4)
 #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE	BIT(5)
+#define APPL_PINMUX_CLKREQ_DEFAULT_VALUE	BIT(13)
 
 #define APPL_CTRL				0x4
 #define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
@@ -1453,6 +1454,7 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 		val = appl_readl(pcie, APPL_PINMUX);
 		val |= APPL_PINMUX_CLKREQ_OVERRIDE_EN;
 		val &= ~APPL_PINMUX_CLKREQ_OVERRIDE;
+		val &= ~APPL_PINMUX_CLKREQ_DEFAULT_VALUE;
 		appl_writel(pcie, val, APPL_PINMUX);
 	}
 
-- 
2.17.1

