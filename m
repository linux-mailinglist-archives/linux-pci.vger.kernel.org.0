Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290FE392D34
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 13:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhE0Lye (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 07:54:34 -0400
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:42016
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234417AbhE0Lyd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 07:54:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLD+BkyM65F7fzqDJi9mL6TH8Khc5GDWHLUbgyWtGP8juXGDBcRqM9CuYtCHTPSVdtxVXnj2eFZwWdRELS9hx7Idy9GS6BbfSkd9nx7+XZ4J7Hdzap4/LlLuBMtInKPZI+bHDILPQPdm2PhhgSSVtDiHmdc9Ot+L3EH09r71qijQ05M8cSYHltq+Gg+lkVOGQtjEG17JDGrwCg6O7AbVIsKwAvjV6aUePzHzN1Z7ujEQfL09lSRstTgpQW/tL1GaHIYN5xgNiQgV1sQEL4lTQRxwbYCflR7Hb4j9XUzORhWkHYULZjtp0xBqJph3HjFCBwBTJylkU7OHf7MhGVZQjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwYiYHzRO9TuQvjUemHCBpGmrulkM/eHDZKMQXYIimU=;
 b=WroeSDUJkAjd55gyr2KEBKXgRfbIsXozvE+//IbeVP3Vtgnr3evu0dxrs+X+d4T9zZeMzesZg1dQhg6uyRQSJq1Fq4cTyzNGQPTBvJ2hJRNDMTt/ltmp5nQTNS2e/QE5RVJiTMyo6SX+sQohWjmgrYAz+iLnTkeSqxyNMW7qRk/djRU6W/zzCDKGyN7l0CHaBdwGGNNlHPJFP+rfcFQIMyCIov6g8Lj0fSaF7Wya0MCO4pwDLKvqBPvyNW5HE5iChjy4mib/VZvOSx0FBXMJJQLKzF85ocrKYchdFntL8Mwrs6/aoDgC+Yi6MGI2o5+8/fP/rpk+Nj3pmIYugxDOEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwYiYHzRO9TuQvjUemHCBpGmrulkM/eHDZKMQXYIimU=;
 b=BmNj4QM+WJ/5iqXviNDY+utlgNRMwVSvgoUzNSODpwziZzKXFHDeOpvWLzsigqN4VssErhjpI1badx6xbmzVU9i9Wsp28QEWj0rsHq56wWRq9YIU1CiTOcjftZZkJ0yR/oK1iaRAizISSqwmzrsHhoXCnw5VqFVdJCCqXmzYdEZonX3FpfxGYrehMbOn8ksoMRiAP8cqD06CRxqmLfaQz/dHgAI7uxaAAPDvPQMn2ongTOAkOgWN5EWBdJviS+Qvn+n8MyBb2b/8vfnXZE1WH6LiMk0qhafv4tcdwVC4jvbxsToXhspc13qhZiUrEUq3wQveUaXe9nvZTyvIYZqH6A==
Received: from DM5PR16CA0029.namprd16.prod.outlook.com (2603:10b6:4:15::15) by
 BN8PR12MB3201.namprd12.prod.outlook.com (2603:10b6:408:6c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27; Thu, 27 May 2021 11:52:59 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::23) by DM5PR16CA0029.outlook.office365.com
 (2603:10b6:4:15::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 11:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 11:52:58 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 11:52:57 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.145.6) by
 mail.nvidia.com (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 27 May 2021 04:52:55 -0700
From:   Om Prakash Singh <omp@nvidia.com>
To:     <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [RESEND PATCH V1 1/5] PCI: tegra: Fix handling BME_CHGED event
Date:   Thu, 27 May 2021 17:22:42 +0530
Message-ID: <20210527115246.20509-2-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527115246.20509-1-omp@nvidia.com>
References: <20210527115246.20509-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe494918-8997-429f-e936-08d92105f949
X-MS-TrafficTypeDiagnostic: BN8PR12MB3201:
X-Microsoft-Antispam-PRVS: <BN8PR12MB320178FAA693483922D36ACFDA239@BN8PR12MB3201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 48y+iZ8wG0XPysv6drkHcDwwCsWyUslYaIjp0ywRfOPzMpcPm4plLujdxsC7LhFVCql7+v4fqrWjNNY4uOL6KtDaO1KXaLFmn0Srid9IZz8sAADODy/xTfkIzx+KrtvjqpC9WR3Azerovc6p0jkEg21SkbzsHf4dEtYDHYEDig1kDUMrhjuJB2DaZL36QQMYh7RQ+B/0SJrH+Io7Fl0XF29M7csPGmY+2EBTL1jq5z5y9U2LvoDPDEvvzNqw3C/Sfxvb9SqtLc0y5zuIUVBc5EkbyH116irp4NCo1mAyWftaG55+ZWwb22jfaBdRdYSC3/bW6ycV28d00t34Tb6i9+hocwjvmfJ0fy2IS92SvT1XniDdLeHF/spgvQyqxICsBcfGXoJoSNElmyHiLz03CXrMRD3LBRAEabjWRqaLmwT5yqBT4nAUckxAhLEqVWS3ezn/zLx9ltDnLcHOTU+UbFYUslv0MEEQLHv4ybc66IYys8UMLF57GGdzxSW1HwXYfr+YDQsMQMrxevohiw7SE7jJYBl9I2P5ASHNk47aNRMz14C1JI1niyTiQyYmkDWJ1czO/QO61LiioRZ98e85vmYb5TwaMoP2KqTIZIjZRN6LAoV3jjVj+P6IGnt2pNzDmlHNMn34l+X1tSppAT0tQwxCNdDq6f8OlhSHrIJutDI=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(36840700001)(46966006)(36860700001)(426003)(336012)(8936002)(86362001)(70586007)(316002)(4326008)(6636002)(186003)(36756003)(7696005)(2616005)(70206006)(47076005)(8676002)(107886003)(478600001)(5660300002)(54906003)(110136005)(6666004)(7636003)(356005)(83380400001)(82740400003)(2906002)(36906005)(1076003)(26005)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 11:52:58.9530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe494918-8997-429f-e936-08d92105f949
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3201
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

