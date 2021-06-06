Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1741239CE0C
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 10:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhFFIYX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 04:24:23 -0400
Received: from mail-bn1nam07on2077.outbound.protection.outlook.com ([40.107.212.77]:42209
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230246AbhFFIYW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Jun 2021 04:24:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7mwe/tBFkKRTh0/KeZwlZHSoSZwwHoCUK35maG/eT2zU6Lr+moptMup3A8dpWeofWKRNYOpX2BltSZwYOH/6WasJlmbyvTRJLOWxFxJJ9H1CNj4dQubZ5bylNpkMRdDknJYSnfAoB8NmKLNt8hM93jO05ZZC0Z2lhCRYbE8DZbvbIFSuZQalUOH6wXbMGo18vf74NKThr5elCHaAQCK9q195Ty++iLVRlZk271fTp+2qCWL5GUqFfdCcSCmEpp/jusqxB9hBOX4Gn22qg+uRZps/os562P5IvF0o9eAf6erdXMiQ6eqiRM/28iXUimzb3m8Kc3h+1kX+Rl4B/Fk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AnTcmfDtEN/TjF1oFRqXu3GyUM4PYqKx55o48rxdQ8=;
 b=jjLU9Bsv7k8qIWp3raGSspC7Trx+sHly0dID51jjuUkqYlPLghkPOKe0DwRJvlRDSBlC+0tKRgmEkgfQj6r4IIb7QS2RQulcKo1qOc932Lm9ebDLE9Xfun2R5B/7O1L5kyx5leP0/HqvSVneAnI1swcd2g8cK3qbzxsAczh/BElwr+I6rBd1Cnzd7KLKyX1Eiuftt2qrwDx1WN5+09+WDu4dMAuwIO0zmrDqQS8Hy5SXjOo9f3Y++2W1zDH2sIQ+hNsNgiNeHjH6GIRXWCJOQobXXKAL8PQ11jzsEWCzj0ZlPGtW3GbKMC1ATmmLavnmpD4vs4nMvkujiVI0TgtXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AnTcmfDtEN/TjF1oFRqXu3GyUM4PYqKx55o48rxdQ8=;
 b=YKLTzdWIk5SA2NNHx1e8SaBJN7wS6tHbv4vW5JAi0hY6XB9d+HsqijSM8hCFZ4xzpBM1HR0A61OrxrsKzZyCs8UAhAXtBQez6+21IH6pALJVyxzAIRl4G6CYkOvQYmg5Hw5H7Swgmby2nMwpQPKVCIJ56SafUEXi66Io+ILdSryPf8kL35TDay/np3aMHB9mOuXB+cHaoE5QGp2vzjEnw4K2wqdYXhSJPtmDSNbw4Y2lmvIZP/n40ycJQClUEwO8AE0Dj9yQikzb5tp0dN4GapWHQ+adsNzrqHBBmn1dCNoJVFprtOoiGHx79L145E6sUz8jj9MkweIVUIR4yGHbeg==
Received: from DM6PR08CA0056.namprd08.prod.outlook.com (2603:10b6:5:1e0::30)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Sun, 6 Jun
 2021 08:22:31 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::1f) by DM6PR08CA0056.outlook.office365.com
 (2603:10b6:5:1e0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Sun, 6 Jun 2021 08:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 08:22:30 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 6 Jun
 2021 08:22:30 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 6 Jun
 2021 08:22:29 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.187.5) by
 mail.nvidia.com (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Sun, 6 Jun 2021 08:22:26 +0000
From:   Om Prakash Singh <omp@nvidia.com>
To:     <kw@linux.com>, <helgaas@kernel.org>, <vidyas@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V2 3/5] PCI: tegra: Disable interrupts before entering L2
Date:   Sun, 6 Jun 2021 13:52:02 +0530
Message-ID: <20210606082204.14222-4-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210606082204.14222-1-omp@nvidia.com>
References: <20210606082204.14222-1-omp@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfe846f1-e990-4bea-89ca-08d928c43a74
X-MS-TrafficTypeDiagnostic: MN2PR12MB4439:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4439717433A1FABFAE735938DA399@MN2PR12MB4439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMcaMzWJ0Z5xv1JIMMhDP0+x04XRjSsEpXWFPGPh+6luNspHhFP68riKtqu0V+GtWSTWS5bHR0OCESpkHofPaBBw2HWSRMmyLEKBZhGlgqbuZ4gGbf1Ipr8tBcxOTfIhvwNJ2nBt+AubuDTw/lLEvQnrqbPCjbosNB46BW5v+x5vAe1LwUWYGDHiSogT7c0pYTuRhOwEph5AZ012x3KIU7K5wVtqmy/+nFUpdTQK3oCmlKXUmXjJnSyxf4QzauoZ7PGxihqohWlD02OXn3la6KTlHM0vXW35xz8JdAw8sUb2bvjZmAnazQ0LDpXQspzte7lRyLAD+Evg/lw86u+yaErPd1cZLLOBygSXz5uCp/GCHcJJGtKP4OBND6cpd/IPXvhX+lFIWReBT09NV+w6+zJng5jSFXoU9dq8YuGWujmzH8I6MjBlklCeqZhm71MzFND8/hVEwOyIOXUjYACmF6+wqSFTz+JPnYFJFwfmefhs6Wadz68B7m1QFiTcOWqS4NC7x4tUnSzpSr/169tZZlyNTNMcmZFPKzruLamt8W2fLF9+Y/v3hpfBsJhsoPjwv74JvTf1I8NpRu+YmbeNCdvV2bZDLWh3T0MDW2auMbcnUTr2S0U5ziPv565eFFa0CTqmKyOiUM1fj8wAADkYbk6iAdPhGZrbyuZlermQQvA=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36840700001)(46966006)(7636003)(26005)(82740400003)(107886003)(110136005)(4326008)(356005)(2906002)(186003)(6636002)(36756003)(8676002)(2616005)(83380400001)(47076005)(66574015)(86362001)(70206006)(6666004)(5660300002)(70586007)(36860700001)(54906003)(1076003)(478600001)(426003)(8936002)(336012)(82310400003)(316002)(36906005)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 08:22:30.7913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe846f1-e990-4bea-89ca-08d928c43a74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In suspend_noirq() call if link doesn't goto L2, PERST# is asserted
to bring link to detect state. However, this is causing surprise
link down AER error. Since Kernel is executing noirq suspend calls,
AER interrupt is not processed. PME and AER are shared interrupts
and PCIe subsystem driver enables wake capability of PME irq during
suspend. So this AER will cause suspend failure due to pending
AER interrupt.

After PCIe link is in L2, interrupts are not expected since PCIe
controller will be in reset state. Disable PCIe interrupts before
going to L2 state to avoid pending AER interrupt.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
---

Changes in V2:
	- Rephrase the commit message as per comment from Krzysztof Wilczyński

 drivers/pci/controller/dwc/pcie-tegra194.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 66e00b276cd3..64ec0da31b5b 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1593,6 +1593,16 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 		return;
 	}
 
+	/*
+	 * PCIe controller exits from L2 only if reset is applied, so
+	 * controller doesn't handle interrupts. But in cases where
+	 * L2 entry fails, PERST# is asserted which can trigger surprise
+	 * link down AER. However this function call happens in
+	 * suspend_noirq(), so AER interrupt will not be processed.
+	 * Disable all interrupts to avoid such a scenario.
+	 */
+	appl_writel(pcie, 0x0, APPL_INTR_EN_L0_0);
+
 	if (tegra_pcie_try_link_l2(pcie)) {
 		dev_info(pcie->dev, "Link didn't transition to L2 state\n");
 		/*
-- 
2.17.1

