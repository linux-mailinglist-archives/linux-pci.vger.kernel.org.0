Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E1039CE06
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 10:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFFIYP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 04:24:15 -0400
Received: from mail-co1nam11on2058.outbound.protection.outlook.com ([40.107.220.58]:35169
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230003AbhFFIYO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Jun 2021 04:24:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfyM3ZLlZOxO0emvSj1cYHu/rP042UhX4Z17NQd77W+ZmFhZGbXiGRpE+1J/GdfY1vlH0lWJRYQVrGK5JG+VWgSj5Lymeuo1sIQhIhlJkbvKQrTTXBdUsaXZC/z6LZTWQll+cj3uBZEVjM24rKGHHC0aolJkWmBrKBvz5/xnjysOINcPLDqKZyfGRvqHKSlNUrF8S3Z6rhL0w/K6ZqSxBU9wJIyRBU8PstJh8Mpc0DHbEoN8sb4a+dVwGGY4nuo/KbVgftfRtu3jnjcRjxU/8ymIzyIT1GcRhnf1pBU1rTCLZV2fZZPAIOwLMpsC9fJsrAJND8q/YU5aLADMCJ+Tag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZnEPQXIHG9MoWEiFDSr/UJvBI9FLxc04k/qdesXp2Q=;
 b=Ce4hmmS2vEnADZkycmra7iv3/kNmtYOEb/RbHjV/f6NmJWdAcBMChySJ1XQAnggni4r0eF4Pmnit7jAs5/VdeSMpSu5u5sbFnGCKJXb886CIigkhGSgseme7krDyBXreUV3SIhcOXYM9wL+zMN/N70WbNqQS8QErPaS6YIM9btufquPtwpM9cYr6lObrs51Wr3O+ua1XQJcHo9eJdEVMXNPpBb4pWGHml3Hq3fLP1iKgjp8zD7s50S/hrJcWpD3XvSW6tg8fTMBvKTD0/2/plkEJYjVmyZasYwwHQalFt119oCzROSciONWNj4MzF92iKjovzcoiCOlfKFU11vhwIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZnEPQXIHG9MoWEiFDSr/UJvBI9FLxc04k/qdesXp2Q=;
 b=TIJcLtgixGmZIt2KBrXIu1NUrPBotz9ugMJmSmxEiUnWFzfbqY/zwZ9JFBhF6SxxtsTIQ+P7VDg+jh3H4wExjuBeM298DgfJwyBO5BjSD5zy0k+ULpvn1w3NbrKeHpWoyHQEIkf4689he0rurPkQdNHummpVeHGEExqDikeYm2FVX3v1wKbDuoDTnwjuq++yHvgvWD1OtMyPQE2kVZm2r6aMcTvbsMtTnSHfohbMGA10ZCoLHmGTkBP8lJZqJj7MXL7qrA5lkT4G/SSIAdrD5ximUZR0hbmtpUiAU1tG5XkhwH+FbYTJMOP4wbiP7rV7wxndW1ezkaztEM4PBocTPw==
Received: from BN9PR03CA0140.namprd03.prod.outlook.com (2603:10b6:408:fe::25)
 by CY4PR12MB1622.namprd12.prod.outlook.com (2603:10b6:910:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Sun, 6 Jun
 2021 08:22:23 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::ed) by BN9PR03CA0140.outlook.office365.com
 (2603:10b6:408:fe::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Sun, 6 Jun 2021 08:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 08:22:22 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 6 Jun
 2021 01:22:22 -0700
Received: from buildserver-hdc-comms.nvidia.com (172.20.187.5) by
 mail.nvidia.com (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Sun, 6 Jun 2021 08:22:18 +0000
From:   Om Prakash Singh <omp@nvidia.com>
To:     <kw@linux.com>, <helgaas@kernel.org>, <vidyas@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V2 1/5] PCI: tegra: Fix handling BME_CHGED event
Date:   Sun, 6 Jun 2021 13:52:00 +0530
Message-ID: <20210606082204.14222-2-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210606082204.14222-1-omp@nvidia.com>
References: <20210606082204.14222-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be20e93e-d9b6-48bf-217f-08d928c435d8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1622:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1622A6220CAAAD0E336E1907DA399@CY4PR12MB1622.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tBVI++F/a/Gtfer1iNEH9TwfX0mTj97NHZTZe22z0m4SXA1ojByne2Z+sRJA17582Jd/pQcKVI4TLZVaVdwCH8rSmAlUywNz5Up3lJG0t+qISm03ap3jxpfJkGR40kKN283dQu/Fs6cyAGkX3pnOW//+7Z62WW3zaAWa7H9KVyy5Hz9WEd5bAnvJwKsSeYvvwzvkyxy/WqVFRAl+FOt1B40ctFsP+MbE1/UVeobUG6GcStZiNaHxWAFO8thHabf/WfYisKDvXS3cBOYKCxckHRG6E4F+qqZmYOyYkJY4qyvXsYTgDAgxA/GeRh0ZPtW7FvHsSybb+HcFa7Z2qdcbIPS26mneNminP7jYE/4ijnytKoOM8+xzrSEdfYkHF6UIe/j23N6+xbVxnQuDr3cG55T4y62ObN7D6aiKZUdYwSOHJ0umxihGNG1Qv39kpSkhGY2p6H6g2vOPaYo9Wb4kUbLDtDcRfL8sdXvOxlRauVHyS8Mx86hKH+UbHDG7vIcksNaTSqnpBQVsZ0NX6EawDzJ50K8AJsFUO2FHP/UTeuCVArIPWZ8LGMyRXsXGg/IHhqCjgnTlVAGKolvsEEZwu9oVsUbIdKU1wqy37ettBI7s55HIHFN+sGq+bjrBj6ynKKXqovxf2V8vSnPY/bfXpGLx44GdL02hFWGsews1xAg=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966006)(36840700001)(7696005)(426003)(86362001)(478600001)(8936002)(336012)(36860700001)(5660300002)(36756003)(82310400003)(2616005)(8676002)(47076005)(186003)(1076003)(70206006)(70586007)(26005)(7636003)(83380400001)(4326008)(6666004)(2906002)(356005)(316002)(107886003)(82740400003)(54906003)(110136005)(6636002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 08:22:22.9807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be20e93e-d9b6-48bf-217f-08d928c435d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1622
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In tegra_pcie_ep_hard_irq(), APPL_INTR_STATUS_L0 is stored in val and again
APPL_INTR_STATUS_L1_0_0 is also stored in val. So when execution reaches
"if (val & APPL_INTR_STATUS_L0_PCI_CMD_EN_INT)", val is not correct.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
---

Changes in V2:
	- Update variable naming as per comment from Bjorn Helgaas

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

