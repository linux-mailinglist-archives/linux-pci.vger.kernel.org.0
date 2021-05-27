Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F133928D3
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 09:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbhE0HsR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 03:48:17 -0400
Received: from mail-co1nam11on2072.outbound.protection.outlook.com ([40.107.220.72]:11648
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234594AbhE0HsR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 03:48:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiFcxX6Z9pk1gXIrUhULNPWY/IXKC9Y3C9cScFn2fmmpxeQW+/0vGsMR9QYuBUqzb07sUNKQpuYxvKMSk8Atiq8Q3TsoySOxjOyue6ciYI1VP9B3sOrBrCKr4FLIHtV1UiMvdbZH1Fe+IS0BpKncwpF5Wc0kCZMp9p/FkC2k7ogIyXk+5dJElQ2Ss8FwyHnDXZguejqevWnAS9ePSnRtJJuxvvvWHpGBF2wiep9JSM7xcSwL/CH4cKX18/PWghbFkpomTAqMMKsUMI37LP/nqqCoXN09gaBDVUbtbqG2DqTinJ8fs/cODR6SaQcyJ1T06TBXBMB1t5GYonpm1on/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwYiYHzRO9TuQvjUemHCBpGmrulkM/eHDZKMQXYIimU=;
 b=ay4PfPyv439kZYFZdbuduyH/GTfcIbtY47QDGZXBUbcb/uJpBvYlMOAcRLqPxhu1bfLRKCI8x2AzzQGWzqd7zlx/ltPcSRiKhv2ogERRzR1JabHZXNqdnNnrd/iUQ5BO/3aF92Wu4W1pttfrCiJUTRJJaYoNIB5I9QZ5XI3F7jSKzsgWJYJ5OyQYfaOOXQz/bR8yrzqrcXzqskI4cI28pb2/fcdmf2X58E6nmcOPhB1hAJw+pbW/QXUZuAGKDkwo1h+P5zSRnAvG9CMrdD87jR6OLV1nbTEfomRx6PZGdNPuq7ImsYCxuzdjzpl67OZ22KbqSRm+FWQWp9GYHa5U+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwYiYHzRO9TuQvjUemHCBpGmrulkM/eHDZKMQXYIimU=;
 b=CVEfdX6fwSHG3EB3V8zOP/7dulISyBrPU3vQ8S8iRqVQz+JU8z/ORYHtnOdCM1f3JxhWM9L7yd1r762SuKK3ztagb5BykB6KyVkB/YZkRNH21r8G50iBfuzUBAQGjlo4pEP0VxMinzjKi8CFPKtTzKO0/71ar4jZdAd+mnmfppmCQ3Db+aYIKirTC+4Z6zobDcTzfNM5WV0I52SPBC8B1ebhzzqg3BEVOxOfy4L6qTehInRUGvshq5iToajqoVdRRO9Ktfc/ye75QRzchAwZI2QsrnfDLWtAtG/IqRp1/2B20SskdAxP8uKu3rDoAWulYlR1FWmltEMGY66zyeEVFg==
Received: from BN9PR03CA0685.namprd03.prod.outlook.com (2603:10b6:408:10e::30)
 by BY5PR12MB3892.namprd12.prod.outlook.com (2603:10b6:a03:1a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 07:46:43 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::83) by BN9PR03CA0685.outlook.office365.com
 (2603:10b6:408:10e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 07:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 07:46:43 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 00:46:42 -0700
Received: from buildserver-hdc-comms.nvidia.com (172.20.145.6) by
 mail.nvidia.com (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 27 May 2021 00:46:39 -0700
From:   Om Prakash Singh <omp@nvidia.com>
To:     <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V1 1/5] PCI: tegra: Fix handling BME_CHGED event
Date:   Thu, 27 May 2021 13:16:10 +0530
Message-ID: <20210527074614.49149-4-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527074614.49149-1-omp@nvidia.com>
References: <20210527074614.49149-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e04e43d-4d52-443b-24b5-08d920e3925e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3892:
X-Microsoft-Antispam-PRVS: <BY5PR12MB38921939FC37C767B0DA7031DA239@BY5PR12MB3892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfDywpGYjwRx5af38m22stqVKxSpe0MGfcoXFX2J8zR+1yEfH2Y5zIpFRUlObywbN1zNqxrnv6zzvOYqdQ3UDMPCHd/FW/ovCvcz5d69tt4dTtDQjf0wYPlOGPiXUAXLrwxQUrNlH9scTQw8YXZmvEbkNUIM6hY4oT8R8G6qL/ksFF+AHCqbZF7tOwRid+z4XJPxXo5JDe5DGDZmaHLdDTL6CCCWoRhs6ZmtiMXhmAHpm4Z9MNuI3d4Cb73TU550ey56pu/8EKMbOLm9th8T8s8zYZzDWoG7ygrGdsag23gAYdwm5UmnReLsx/Z5emmI4UtRs2B/+ozHcCefEVv+tOcveWzygSuFpm+eZv2VcUzyxdtd4ZXfN+i7dlwczBQ12YacIYyTU3ZsHaB4bBzSm6hDkf3COiJm2+4QdxME61AqtNc5SsLnOuJQV1igQ+IYt82WRx/TUD0Ditl2fH2tkWHRAyN/NSSckxLq4xMbpNaMwpBKk03QKo/f/uadvSrY56kY9mVFcKPcjmsPvA6jV4ZgaFuX6upiCh1iv8FLwPIeh4qEH8gqubE/3IP+zoq2ut2Z3X8Tm26cDGzyc9pr/H7mp5k32qHlMA9RNf05+sQdzMsk06IAPNflGZs+NOTJhRbkeTtSSk44wo07eg2SmmzfqcrQ0iS6bGWtbIDGIH4=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(316002)(8676002)(36860700001)(8936002)(6666004)(426003)(336012)(83380400001)(36756003)(70206006)(6636002)(86362001)(70586007)(54906003)(4326008)(2906002)(478600001)(26005)(82310400003)(107886003)(82740400003)(47076005)(1076003)(7696005)(5660300002)(110136005)(7636003)(356005)(186003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 07:46:43.3195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e04e43d-4d52-443b-24b5-08d920e3925e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3892
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In tegra_pcie_ep_hard_irq(), APPL_INTR_STATUS_L0 is stored in val and again
APPL_INTR_STATUS_L1_0_0 is also stored in val. So when execution reaches
"if (val & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT)", val is not correct.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index bafd2c6ab3c2..c51d666c9d87 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -615,10 +615,10 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 	struct tegra_pcie_dw *pcie = arg;
 	struct dw_pcie_ep *ep = &pcie->pci.ep;
 	int spurious = 1;
-	u32 val, tmp;
+	u32 val_l0, val, tmp;
 
-	val = appl_readl(pcie, APPL_INTR_STATUS_L0);
-	if (val & APPL_INTR_STATUS_L0_LINK_STATE_INT) {
+	val_l0 = appl_readl(pcie, APPL_INTR_STATUS_L0);
+	if (val_l0 & APPL_INTR_STATUS_L0_LINK_STATE_INT) {
 		val = appl_readl(pcie, APPL_INTR_STATUS_L1_0_0);
 		appl_writel(pcie, val, APPL_INTR_STATUS_L1_0_0);
 
@@ -636,7 +636,7 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 		spurious = 0;
 	}
 
-	if (val & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT) {
+	if (val_l0 & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT) {
 		val = appl_readl(pcie, APPL_INTR_STATUS_L1_15);
 		appl_writel(pcie, val, APPL_INTR_STATUS_L1_15);
 
@@ -648,8 +648,8 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 
 	if (spurious) {
 		dev_warn(pcie->dev, "Random interrupt (STATUS = 0x%08X)\n",
-			 val);
-		appl_writel(pcie, val, APPL_INTR_STATUS_L0);
+			 val_l0);
+		appl_writel(pcie, val_l0, APPL_INTR_STATUS_L0);
 	}
 
 	return IRQ_HANDLED;
-- 
2.17.1

