Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D273B17C0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 12:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFWKIO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 06:08:14 -0400
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:34145
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231129AbhFWKIM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 06:08:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0sq96/57FDDwj4OgSOC0dhWZNvreQkxJ9gJSqYpWyEFXPtfWgKw6kEPLJ98nTRMIwKedm5FjSwh3Mzb3i2FMVAXtapNAjqawdIUeKcZ9ZT2FiA90ukg9xBBKlPhKeVmEOhqZOTfUw4pzyP7ngmLsxuj6Sg46IQzqIr6bcLRj+LqTxz0GvTzdIq6hDWNVLPZFaPnlyMqoTNQWb8DTddNp5zJYCmO4hqchmXgL56gwaB1ZUHlRQlQNH1Ql9OWcyLsNf3NkvWFAtqYdxMCLf5/el/pVwfmXQiva64xHraajdw90Ch3anAIh/cW0BPYPU8HP8HHr2GM/XiisYA3ypGTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFHE7Eor8pM0fRBaXGPsQTnMfHfhzETtteJmE9zbaV0=;
 b=Zmtq/TiUFYk13Dqv9xXqv74ESaiRsOOdB5YQruMCsxWCzAeFL8pfD1RX4sWTFR8yE9S+aMrD4H9lmxhQqwPcdQIMmAgs5nH6Uev1KYHcUR3QFnHwlmrHExBwbchl4yEoc75eP8zC5rq3jizNll0A3WOQs3O9zOTkbM6Gs3HXQHBKRdFb2kaOE0z2JmBHfEDRLorS4jJ2F2Lwi7TVLDkz33Pimt9ManGClkudwpOpkQYZZir/7IFc5LTxdEhS6JHPBwuJ259QwZ1TZvpxLnfdP4CyxzFu9GRZBoXLco6zExWc1uLqIDfbcmunNvsyaLcECtJty9pCD7BZ3YbNvUg+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFHE7Eor8pM0fRBaXGPsQTnMfHfhzETtteJmE9zbaV0=;
 b=VYqeoR63gVWUPoHA2ky/8VPTdI2S5B6jwZcRTCxPrHRgACBNgvB+ssXS/pP7jtqxoGBYwR7cpAjQKbvugwA4TNEQmewLdzIbc4CsETXfxrSUIX1P3p0LiXYBQxtMrRr5zd1BkId4roAgHa+T3vb4puO+J8YvBPK9g64cMa7atwOR2lEhQYTmaL/gavYB22I+ieO6314TR2EYd484QOhZ+qHfzMxSTg0AzO1UMijHpEUbFOPcg/PqYZc8ElmpcRopgIOK7vo5ItK4xOXqo8mjiyFqvp3Nhdzrb26WPYxYf4fuHj0Cg4/uRNOl+oTV0SO0DvG/8nA+yY2kV2fp8qsJ6Q==
Received: from MW4PR03CA0114.namprd03.prod.outlook.com (2603:10b6:303:b7::29)
 by CY4PR1201MB0072.namprd12.prod.outlook.com (2603:10b6:910:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 10:05:53 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::93) by MW4PR03CA0114.outlook.office365.com
 (2603:10b6:303:b7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Wed, 23 Jun 2021 10:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 10:05:53 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Jun
 2021 10:05:52 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.187.5) by
 mail.nvidia.com (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Wed, 23 Jun 2021 10:05:48 +0000
From:   Om Prakash Singh <omp@nvidia.com>
To:     <kw@linux.com>, <helgaas@kernel.org>, <vidyas@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V3 5/5] PCI: tegra194: Cleanup unused code
Date:   Wed, 23 Jun 2021 15:35:25 +0530
Message-ID: <20210623100525.19944-6-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210623100525.19944-1-omp@nvidia.com>
References: <20210623100525.19944-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e9921bd-1bd2-4133-dc11-08d9362e7c45
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0072:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0072CFFE7734D10954A08A09DA089@CY4PR1201MB0072.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lcDDyuWSUvqLy7xM6pObU8OfuiA3sWnlMt2yZfks0lHEYju2ggUbABxk0TPdrWs6+ENhBHHpCjTYMLyrDGyv9d/797l4sqdIe1k4B1RjMLz9vPcg29pV1VjkaL0JTuKkBLJ0FQPmTM+VqkmrmRjygGOcc27LOoig84nyPBfyEiV/eHT8k5bOkKMZgsyWpu0mKAiE8PLWtD+XpPlyDR2kPySpZXAZ4BsikDGCh0ipvPUE1pkJYFGrt964yVdnGpBqo3X3AcWIyPkq2wHLpVqfGKJtur8AQw61qbagFS7mBXyqJs1RteK+xr/VQmd3M0i1PxqEA+7U2UMPJhuOyue6KhJK+RtHKShy6aNPBS6EZ1DjlKP3DTK1fpAz0NjAadde0jgmAk81pKiNWzC+aK634rJNmx4NUqqTSDb6EWLsFFA3F44BRouLrIkcRIS5/iN4oKiiG+ddsomkJshwG/X7p1Bhsk2mNPuYa259kjt/SRjoyY/rKnIjoE/aJs0pxVAhpGcOCE0DHI4L6EhmJJviyYh/crYGEyFLst793WN4dCNO6Tvgxi+5cKJ6QlNK0mPdpt/oNqKGg3zxUIdJIyDKs8zgMbMra/lguBdencldpHcyYK5W7VCvfVmbcgjEcmtObc7GmVlnMSEfYLWO8GM7mu8x/lkFoymEaSEqflPuJtBw6cWdcpR4eQDXNiIYnWbIfY5a2v/bqUUAa8lmA2u5Ig==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(426003)(7696005)(186003)(2616005)(86362001)(7636003)(82740400003)(54906003)(356005)(316002)(70206006)(26005)(110136005)(47076005)(6636002)(36860700001)(336012)(70586007)(6666004)(1076003)(2906002)(36756003)(8676002)(4744005)(8936002)(82310400003)(107886003)(478600001)(5660300002)(83380400001)(4326008)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 10:05:53.0015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9921bd-1bd2-4133-dc11-08d9362e7c45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0072
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unused code from function tegra_pcie_config_ep.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Vidya Sagar <vidyas@nvidia.com>
---
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

