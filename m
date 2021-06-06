Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC0839CE12
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 10:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFFIYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 04:24:30 -0400
Received: from mail-mw2nam12on2088.outbound.protection.outlook.com ([40.107.244.88]:58287
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230258AbhFFIY3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Jun 2021 04:24:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgGReczPtyvgjhFBJE2d3XHGoz1FBKyULorCMj+M5J5X4YUDPjj8VrPZb6Ha3a/95IQKF5ftrsy1tPQS6IjhfZfGQwYCtCfRJQH7OJT9x87sDhIGWugdz6Dcnz5l2NZWBrKaqZ+QkiPP9RB31FRLid4meA3KtigfsVW7ZfFx9G9rnCmpO0fCFbZ+GNMlyQ33ORLFOQSzBzfmo666euqUOgqLQDegpIVVdPai0hyODA0r7UVNUQ8v3cTqjs9kPbt+Hz/EYrSb7xHreEcvvJBUCXl9MxU3dq5HJTJj3mWJlCZJZskHajKpOCw3gQT7CRk6sPwJV0UP59D6olYlUtqLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG8VmMbc+i3+ywRgNnTrGbHx27HxSK7tNzOpd7aasF4=;
 b=BYIafJDe3Wu8TdmS4pN4lx8zbHqmLE5JFT3ZkWCj/SH3cFDBriUjEVPaQI3dKMVO7UNOwcSSAoBQ84yEphllzxns69GLVF+tn2yl5EK3+1tc585UuhCejRSgE1smzgsObbWYXiUP/ugdYVeT9yQtiEfJhxfQrc1SSjAJp1xLIgtLqG4yDLKqB4uzQ0IOJCc2Ns+EC3luKwqgelS9EUO7yFlQg+tQKo+ja+kttf1sjvAITnZ/JgDeJqN8wgmf5msvkpnxz3qpw95dF3CGw1YgeGsrz9841bfBkFQYrG39u1kckL4HKEf9BGe8zrxgtUkJhLJ4jEsS4OJZtTo7dwKKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG8VmMbc+i3+ywRgNnTrGbHx27HxSK7tNzOpd7aasF4=;
 b=p9BlpfphdtI57BAKwb9yt27hhnGd7d0TIKFt+SIidIZprbOJ8yiDh6naS/qmiEWPAKHN2yW//CAGI7Rx5o+cyC61aMsM/t9kbjxsgSXJN1gp97RvztpDnSZtrSmRJuGQDwIQu7Vrb/EtLAovjynmaJQHhovE+fzH57X1+la15Vn09U9Dcz+wPxK9sQkyFigImFA6vJGfcA5JLU8L0oZViyA16fWgiw0J9bVdBgSmauDlYNoQ67t8Gip/yzeOqU3iZPxNW4lEh2d1jQ8ZmFm77ak9dhac9J6lxhxbOtLvt7hBY1ML3OtgQutjG+oVJsJ0HBhfoWHULBqOQO/I9M5oRg==
Received: from MW4PR04CA0001.namprd04.prod.outlook.com (2603:10b6:303:69::6)
 by BN6PR12MB1329.namprd12.prod.outlook.com (2603:10b6:404:19::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Sun, 6 Jun
 2021 08:22:39 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:69:cafe::3b) by MW4PR04CA0001.outlook.office365.com
 (2603:10b6:303:69::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend
 Transport; Sun, 6 Jun 2021 08:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 08:22:38 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 6 Jun
 2021 08:22:37 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.187.5) by
 mail.nvidia.com (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Sun, 6 Jun 2021 08:22:34 +0000
From:   Om Prakash Singh <omp@nvidia.com>
To:     <kw@linux.com>, <helgaas@kernel.org>, <vidyas@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V2 5/5] PCI: tegra: Cleanup unused code
Date:   Sun, 6 Jun 2021 13:52:04 +0530
Message-ID: <20210606082204.14222-6-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210606082204.14222-1-omp@nvidia.com>
References: <20210606082204.14222-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11619f53-b962-41b4-17f7-08d928c43ef7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1329:
X-Microsoft-Antispam-PRVS: <BN6PR12MB13298800F7C9C89918B3953FDA399@BN6PR12MB1329.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /I913n5bmvPsL8628QYPRt0KIzNTfU/cRSBOYzxRHuvs4/tHzUSGTbf3xz/O6MlPdTxaovtlKe2sMkZ3a2NgaWHRtpqjlozRUz+rnSl36Vomwx2JIAoiQpJefDC54c+NBdlWETSJzQFvV/y5dGJARcQColmE5FSAG5aMzKfsRHHSh7UCt2tXqEPrtPil1HMXeNk7Qti1nAT2E/xIeNH6vMFJjo3zEY+2a1XBzfA1s/L7kK+8Glu8AM1RIgm1obZs9Cl+Ce6JeiDA6AvuyUlTK/hTT3YJUtaI12VKNoiBYYW0sj1WaiWAyOwqhexiT2IvYryPlgcWZjwu1R+xM68aj0t4j1oM1Q/L3btW0dRYNNwMlPErYMOLXs9LN55AKE87HtAI+1punt/KTIm+1gHQ5+yjJg/MIJmiYIYmKOROmAQht5MFneJApTNx6H78XMIx+8bgk243FqrCogsKKemQiGd0xHbvZQtaxqGMOCPxjKPDdSpSokroV3/4prdN49DdjhxQFyxacdzvFKaUcuSFajB2mjaG0kTF01n19XjTmbODFfGCk9n/vFeS6Qv1qjqyWAn106dM05Q0kX5wGFRgnvrz/z3/9LRVLCkKRm73MLtHKJIhLGzhGwJYAZ4IiQE8bqUIvN1ZPkI4MkFjrzzZ6gcyjlZ68ll4biv2zndxbwQ=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(36840700001)(2616005)(107886003)(426003)(82310400003)(83380400001)(336012)(6666004)(86362001)(7636003)(356005)(54906003)(5660300002)(110136005)(316002)(4744005)(4326008)(82740400003)(8676002)(7696005)(70586007)(36860700001)(36906005)(36756003)(26005)(1076003)(6636002)(186003)(47076005)(2906002)(70206006)(478600001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 08:22:38.3574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11619f53-b962-41b4-17f7-08d928c43ef7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1329
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unused code from function tegra_pcie_config_ep.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
---

Changes in V2:
	- No change

 drivers/pci/controller/dwc/pcie-tegra194.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index ae4c0a29818d..e9d573c850dd 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2045,13 +2045,6 @@ static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
 		return ret;
 	}
 
-	name = devm_kasprintf(dev, GFP_KERNEL, "tegra_pcie_%u_ep_work",
-			      pcie->cid);
-	if (!name) {
-		dev_err(dev, "Failed to create PCIe EP work thread string\n");
-		return -ENOMEM;
-	}
-
 	pm_runtime_enable(dev);
 
 	ret = dw_pcie_ep_init(ep);
-- 
2.17.1

