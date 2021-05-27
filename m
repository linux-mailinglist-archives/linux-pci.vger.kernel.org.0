Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281FB3928E0
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 09:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhE0Hsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 03:48:36 -0400
Received: from mail-dm6nam08on2044.outbound.protection.outlook.com ([40.107.102.44]:17632
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235156AbhE0Hsd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 03:48:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjnSEi68fnv9zjfudSIPdtA3ZXOc1Ic591h2u5Oy3j0oFW3Ly++QNJKa+eDi+LHtIFrT98jLpBeSAS61Wlig8w9toPiddVjtu+hiCeCxy3y567gVAGsgvr2wT9Vtti7xPWVP0e2tIneVRvKBwUE9kOSCPjDqwY+mP+Ten9XYqmpX+hE9gZ+G4LjjU0/i3EBFOlLCx9WN4Ip0sJm9JPIPWNrFWyOeemSJvHNAnPGffN/O+TDIl8rlSz6CoiC4D2NVd9cFJEXkxtXKS7RlQnRCDrKECvJ1x+6DutXBQBK2PhCOvoi7fn6Y4LU0jqKvlT7OUV8qOF0vnY09S2xK52LdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1GK2JWWrQSWRsqdJXF260JrFBq7qIyGNr5crXTQ3Kg=;
 b=XwT7huzkDAGiBPKunsHWScgMOCek4F1+nX4EcK+k9fj3wyEhrRMzL01mxwI8dhlTQiyeYwXN4ORb1TkBBHUIlL9qctLfOE68rsN7s1+C92j7NsnDqRgceb8Xjw1M2AvG1bopOjnwmA8DPu0FcqfWO8vaUrSih57h85YKjvETjKj9L04chr6M/kbtnLCLhe945OivhurR6wS8Hm+rrOKiida8QP9/kWYwmfBb3TT+4Tc5y1g1Oij2coUSeAwAGZlQJQS663LbAvT9RvU11xzmqnwUIyyWjEdx7Fc3TQwJ6wqFtG/Y7dfQFOJKHtSmXfF4fQiM9Lshq9o2cqXRuX04og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1GK2JWWrQSWRsqdJXF260JrFBq7qIyGNr5crXTQ3Kg=;
 b=hoRuG37Fh2IkhY6kEj7zl5gvY9njrMvY7fCkubHzx3o9zje5d4ql3Ayf79Q1cLFmLKLSrZcqYvmJA1m+US3Bzi4DUYjAIktc9quhLi96a9aSwHHLkxhLSraZ051cQKeqrVCBvVOi1Qn3qC/NkjI4s46PZeFgKFGE42IUlAorq7e/qiRxN8bb83RyRbPbw/Vwq8XsZosvo8wav/1wIvpuOKScE1+K0hqrQ1p4jC0BH4NHXRrvKBH6kAqud5uitx5rRDLVOhWL8WnlI/alKeR7B/cBb12DKGLBS8c+ZWnkXoUwt5VgrWEvI+pYh1+IEq/7csqBp7oJ7fj7DUarjYuGag==
Received: from BN9PR03CA0126.namprd03.prod.outlook.com (2603:10b6:408:fe::11)
 by BN6PR12MB1747.namprd12.prod.outlook.com (2603:10b6:404:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 07:46:59 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::d1) by BN9PR03CA0126.outlook.office365.com
 (2603:10b6:408:fe::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 07:46:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 07:46:58 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 07:46:58 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.145.6) by
 mail.nvidia.com (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 27 May 2021 00:46:54 -0700
From:   Om Prakash Singh <omp@nvidia.com>
To:     <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V1 5/5] PCI: tegra: Cleanup unused code
Date:   Thu, 27 May 2021 13:16:14 +0530
Message-ID: <20210527074614.49149-8-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527074614.49149-1-omp@nvidia.com>
References: <20210527074614.49149-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ca89220-311a-4730-a0fe-08d920e39ba5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1747:
X-Microsoft-Antispam-PRVS: <BN6PR12MB17471969D755A0B31E6A0A70DA239@BN6PR12MB1747.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LW6ToLUyjrUIoBA974JiIQhcPP/6SE9qw1j5gXIyFlxgv7S9nEc3jAZB00Ly3N8Wfv65zRuw2rWnCko8gSEDiXaEfpOkU6F8rcWa4f85bSn37uCyPULoeoFwq6vEPiVKrY27axC7HWCJ/UsLNQ3eRbYbIPl6FME+jvjpfo7Um1FR6ru2krL9JtsGNnKugsbYQQ03jAU1F3WDn1GVYFPB2j/aGg2wVtmw5XwjhQgqJ8FWGDyGZtgEZxgX0EAZETzaPJWdczncAMFLBxVmb4O8NQDtzCOJyf2AZ/bDNAGE38Y6hXnJyPg9VJWcFS9ac2j55+mx8TtJ4nGijCGUSChQOi2O9XBF6A0fDxMROBBJaeuaL4b/kTaKQ4TArQjdVZX2YLJQZsu9A4jggIi8duJYGS+4tFPRlHwvg2aJDVZ85QWwuEI5eolbs1/ixzp2jrLXsltcUzogo2A16OtupAggXnXtC0KtEGhSUuJ/vjcR8Y2cXJpR7Dz6ePANnY6qPGS+WMRfxUfTaea/Qe4j4Bcs4HW4g70RbwoUe1wn/wXSS+u3ufYej19N25+fUh368q4d6ikraZPzeD36bw6Trp/CUJ7b5U87bSD0o05cDE0mZ9JHa9oNf77GyBzvR2dbl+eXv38iiFwz7n1GRHN+R9E6DgBeg7yVrAhVY+OV8P6p57U=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(36840700001)(1076003)(36860700001)(107886003)(478600001)(47076005)(26005)(186003)(316002)(54906003)(2906002)(336012)(83380400001)(6636002)(36906005)(110136005)(426003)(82310400003)(8676002)(356005)(36756003)(8936002)(2616005)(4326008)(7636003)(82740400003)(7696005)(86362001)(5660300002)(70206006)(4744005)(70586007)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 07:46:58.8864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca89220-311a-4730-a0fe-08d920e39ba5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1747
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unused code from function tegra_pcie_config_ep.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 93c89f2084a7..096aa5306fda 100644
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

