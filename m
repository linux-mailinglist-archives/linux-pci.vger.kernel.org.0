Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE163B17B2
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 12:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFWKH4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 06:07:56 -0400
Received: from mail-bn8nam11on2058.outbound.protection.outlook.com ([40.107.236.58]:9537
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230161AbhFWKH4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 06:07:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX8IGQwfrFayDiiOLHIGN09xizR5VIu14s76iJULx7Fi78FyO0T/o6RyA5t7oHYMuqSS6iuuiz/r1gSA1ZB1ddgAgAgInTYD97i//LpHvi3MqF9dAcZOyChDTzmaHD+tig1RJiMNHI1Y9TW4MtmJKRjSiaIG0HeBg57k5TpYv0BmtcvLcRM2zpiKRKlOHuO4oxgwFoIVXWz0F7RrYSgjyrxwvO/847g7V8F8qjnyB0sC9oH2ABpVFEIIq3yl9F0adBgslkNt6QNN0wcS5/2hSgern2xzvD4Ji5TYsYmrAsO9BlJlncnFyo3zE3Em6himUKD/Thv4suNQjbLdQY9iEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZMZjn+4Fo/gI6yEzXS879DnuBbPfUHkadLjeFl+QWw=;
 b=K7GIyyDRXBhVCJVv+2R1cOAocq0+vkhobsIR2QUc7EiDK1rrtVrOjV4L87lE0flVIqTDF0fnim59Ra+NuynVGeNDcz+zh5ALKgTAdP+ik49wog5frSHJtosHQ/QaOzEQrVo75L0qwmQuD0zRx8cy/Q9MwFsLCwVqvSc8lazr51ldNftmJUXnwoQhAL3Jctyxpw7JYl04PoT21N2N/bqTwTdZZAHPm2H17EQUxfe721aXzSMgnH2iO8cYd6BxXiyAwQH77dj0Y8Jx7y8WpXL9aohQzxsFCTon1p7cFggdjSdB+Sw05QlYxiM2FAEA8hahs0t9iX+WOlscpJU/acFPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZMZjn+4Fo/gI6yEzXS879DnuBbPfUHkadLjeFl+QWw=;
 b=AmKuG+zjQ0AE1BszhgNKW516fHD9jJFLUuQcLT4UhTE559w6kSjH+Bn/BlVa4G1xmjnSooIQVYodsQB+f8hBnjQ6v0yj7AakoHUMmU8vtQd3gYFQ/FxpKa5VV7rF6Jexp6FVjuPLTrdLUlV1hB0eULF2bvyyKLMGijznKnM2MGfbK9FNEAWFap0l+MIiwG0qy9hnCWQFvJnFkCL2+7kxXj7rV3ew/NuL5imyb/Kpo/J0wgTrok8UvOGNu/iGZh2OzKRkpkgaY9s97nxcRMJY1FD8X/GOpUc8xy1ZSmQZZnH+MA3tajeGfzdod8xpLDnbr4UVqCfV0KodIOUYfQPmzw==
Received: from MW4PR04CA0322.namprd04.prod.outlook.com (2603:10b6:303:82::27)
 by CO6PR12MB5457.namprd12.prod.outlook.com (2603:10b6:5:355::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Wed, 23 Jun
 2021 10:05:37 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::4) by MW4PR04CA0322.outlook.office365.com
 (2603:10b6:303:82::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Wed, 23 Jun 2021 10:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 10:05:36 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Jun
 2021 03:05:36 -0700
Received: from buildserver-hdc-comms.nvidia.com (172.20.187.5) by
 mail.nvidia.com (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Wed, 23 Jun 2021 10:05:32 +0000
From:   Om Prakash Singh <omp@nvidia.com>
To:     <kw@linux.com>, <helgaas@kernel.org>, <vidyas@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V3 1/5] PCI: tegra194: Fix handling BME_CHGED event
Date:   Wed, 23 Jun 2021 15:35:21 +0530
Message-ID: <20210623100525.19944-2-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210623100525.19944-1-omp@nvidia.com>
References: <20210623100525.19944-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 667585e5-4fa0-4583-64e4-08d9362e72b6
X-MS-TrafficTypeDiagnostic: CO6PR12MB5457:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5457A0947AE72DF126C1676ADA089@CO6PR12MB5457.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LieBv5YllRrg5QkYX19E7UzRTfNqlROG4vEC/IhqDa39rYoArMUr+1jPqP9qR1d3LrwuxUD5FfIu3m6PjcDucd+TGdTR5w9+KCDd1JOR+PM9TLL0Pk3MtKAuRym5DUhMR3eKSTVJAPIro66Pg2BGUsI3kyk18zLVoOmFixLVAZuXKhlT/Pz3d+iIWtdJs2Cn1WBMYMFKaQ159JJO9h6fSdaxryd0+toHh9y9hyJiq+1Bwp+GbSBxkwuNxVu+qNUeTLQ7tyGihacs2/f8QawVRTfkAW6dIMza0sTEJpyPOxJZML2aSSRBIWJTbmDZCx2hl7bj7cbr/Z8u3Itv+BYn29GckrjYjF898QPZLs4edO32qeAaO/cAafIIMCOgTI7HQ+/xfdraO5JJEBFoqXzaCXrjvai5mN7AbOA8Q+RqbyGkwAeYAjvCwTRK2HyT2qjFoI0MAT+j1VRpSSBz6/y62MiLDnrE1VU4dTkMPvDyC0gxdP598FN9XwSSKpHwiSb9r4Y1WYqjaIyKgLVkQH5uDo+FG9mKa9eG9SL/GKzshi+/3aVGUwfgXTwPIIQQ7hN871AUwUA+33oFTB60kPHvEsiW7MNyGVcSX4o1Z0/kjPbFRUUUGGRGzMigKwb/9JMfzUIqs9xJYfw+NM5cei+CTCryXT0x5iqGmnSrjWN3afmvH3hqn2CBKkfFL9CDKUoQaYanXwMrR2Txg10yTTxhtg==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(8936002)(8676002)(110136005)(316002)(6636002)(107886003)(54906003)(36756003)(1076003)(7696005)(186003)(26005)(4326008)(5660300002)(478600001)(2906002)(82310400003)(356005)(7636003)(6666004)(83380400001)(82740400003)(86362001)(2616005)(70206006)(70586007)(336012)(426003)(47076005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 10:05:36.9368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667585e5-4fa0-4583-64e4-08d9362e72b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5457
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In tegra_pcie_ep_hard_irq(), APPL_INTR_STATUS_L0 is stored in val and again
APPL_INTR_STATUS_L1_0_0 is also stored in val. So when execution reaches
"if (val & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT)", val is not correct.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 30 +++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index bafd2c6ab3c2..6f388523bffe 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -615,19 +615,19 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 	struct tegra_pcie_dw *pcie = arg;
 	struct dw_pcie_ep *ep = &pcie->pci.ep;
 	int spurious = 1;
-	u32 val, tmp;
+	u32 status_l0, status_l1, link_status;
 
-	val = appl_readl(pcie, APPL_INTR_STATUS_L0);
-	if (val & APPL_INTR_STATUS_L0_LINK_STATE_INT) {
-		val = appl_readl(pcie, APPL_INTR_STATUS_L1_0_0);
-		appl_writel(pcie, val, APPL_INTR_STATUS_L1_0_0);
+	status_l0 = appl_readl(pcie, APPL_INTR_STATUS_L0);
+	if (status_l0 & APPL_INTR_STATUS_L0_LINK_STATE_INT) {
+		status_l1 = appl_readl(pcie, APPL_INTR_STATUS_L1_0_0);
+		appl_writel(pcie, status_l1, APPL_INTR_STATUS_L1_0_0);
 
-		if (val & APPL_INTR_STATUS_L1_0_0_HOT_RESET_DONE)
+		if (status_l1 & APPL_INTR_STATUS_L1_0_0_HOT_RESET_DONE)
 			pex_ep_event_hot_rst_done(pcie);
 
-		if (val & APPL_INTR_STATUS_L1_0_0_RDLH_LINK_UP_CHGED) {
-			tmp = appl_readl(pcie, APPL_LINK_STATUS);
-			if (tmp & APPL_LINK_STATUS_RDLH_LINK_UP) {
+		if (status_l1 & APPL_INTR_STATUS_L1_0_0_RDLH_LINK_UP_CHGED) {
+			link_status = appl_readl(pcie, APPL_LINK_STATUS);
+			if (link_status & APPL_LINK_STATUS_RDLH_LINK_UP) {
 				dev_dbg(pcie->dev, "Link is up with Host\n");
 				dw_pcie_ep_linkup(ep);
 			}
@@ -636,11 +636,11 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 		spurious = 0;
 	}
 
-	if (val & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT) {
-		val = appl_readl(pcie, APPL_INTR_STATUS_L1_15);
-		appl_writel(pcie, val, APPL_INTR_STATUS_L1_15);
+	if (status_l0 & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT) {
+		status_l1 = appl_readl(pcie, APPL_INTR_STATUS_L1_15);
+		appl_writel(pcie, status_l1, APPL_INTR_STATUS_L1_15);
 
-		if (val & APPL_INTR_STATUS_L1_15_CFG_BME_CHGED)
+		if (status_l1 & APPL_INTR_STATUS_L1_15_CFG_BME_CHGED)
 			return IRQ_WAKE_THREAD;
 
 		spurious = 0;
@@ -648,8 +648,8 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 
 	if (spurious) {
 		dev_warn(pcie->dev, "Random interrupt (STATUS = 0x%08X)\n",
-			 val);
-		appl_writel(pcie, val, APPL_INTR_STATUS_L0);
+			 status_l0);
+		appl_writel(pcie, status_l0, APPL_INTR_STATUS_L0);
 	}
 
 	return IRQ_HANDLED;
-- 
2.17.1

