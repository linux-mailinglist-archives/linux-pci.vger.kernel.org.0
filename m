Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD0D3B17B8
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 12:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhFWKIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 06:08:04 -0400
Received: from mail-bn1nam07on2040.outbound.protection.outlook.com ([40.107.212.40]:27006
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230357AbhFWKID (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 06:08:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfS7IB4caaYL6EKIoXV1XRYIYxw1lzvAHUSNauD/khgoX94m6uSVRaAS3j6QqGyG040M6pDIT06sdzEOaxA6kKhs/ZtylvPPJpAY0T3uJTMrcyLuYvJX++9si9vlCMk0woh360+S3otlhlu3Wxt6Umc3qKepaQnZsbHbT1atuk48fJ8vBeipCt3ovosa0EZsb2xYMY5goPjRUESwVsi5KzKw0oc3sRejvkflevfzMac5A+h5hASb/RW6CFJ+nS/NVphjF3BQQVM/uUVyTqR+KA0FaC4yOANmi/vuRbDgB7ze/ZNMXWykFYQvClDp3ZADIxAcRZzNHF4mp/dq8afl/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbiHhwGHhjs/pOUYJYNgKx8Mm4tJRcMwflWQnHcqm4A=;
 b=OQzoVt6MOGRXxPnmDd/wx7+sDKEoSwi/8uLSjajp4btzxsvUuErH3F60BShKA65oictnAsDBB0YC9Yk3s/dtoEZD6loXy1ppDWGL8BLq/s3eeGOXjK5MQCbpuvCdP+61J/uX0rT46n5E6jecyHVXOkGbVjnFfKZfzNNz3jJbAkXtN+imOLFNYDUl2q1NjWPxQ637GCwRxjr6rrahNIUo1WkjySB3pYUvMA+/AI8arBPna2zwme2eZg853k78PxEwnLu7o1u0tbW0x/1S7F0flYdNU6HAJhw4L+0VEPcR4FfvDC0xYQ0QRadaofCAlbsmlFZnr+4z9EP1WauiHp+0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbiHhwGHhjs/pOUYJYNgKx8Mm4tJRcMwflWQnHcqm4A=;
 b=qWAwr0k8ZlRMvEmJxiPiJwXZz4QABIX6dNO5apN1RXdpTDDiQuCDLZb5YpiO0GLEfTGURfzNJS+mV7RsTnftXtYnuB4J8Xo/xns1rL8x0T8r7B1Wbe3hqHnst4FjAfRNnNXTicmflrQSf+dYjvcIzrGePCw4zs8OJK4TpwKSVO14vmlwy8iq8HLaWmc1SJYXPOjyOgQ706iGCqRMrZND4AfSv4B/5Ndl+lYRwQjc7rSEgUxZW4zIXNSJ//1qjcREiekofEyAQHwZMh99HXGxGo66uWslrFzDP462Ci4sFtKNShlrYGCEl1czvRECL8PMRMHE4o/jqbHC9sWKPa0zSw==
Received: from DM6PR06CA0088.namprd06.prod.outlook.com (2603:10b6:5:336::21)
 by BY5PR12MB3666.namprd12.prod.outlook.com (2603:10b6:a03:1a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 10:05:45 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::f5) by DM6PR06CA0088.outlook.office365.com
 (2603:10b6:5:336::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Wed, 23 Jun 2021 10:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 10:05:45 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Jun
 2021 10:05:44 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.187.5) by
 mail.nvidia.com (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Wed, 23 Jun 2021 10:05:40 +0000
From:   Om Prakash Singh <omp@nvidia.com>
To:     <kw@linux.com>, <helgaas@kernel.org>, <vidyas@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V3 3/5] PCI: tegra194: Disable interrupts before entering L2
Date:   Wed, 23 Jun 2021 15:35:23 +0530
Message-ID: <20210623100525.19944-4-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210623100525.19944-1-omp@nvidia.com>
References: <20210623100525.19944-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98f46072-b366-4f19-a623-08d9362e7783
X-MS-TrafficTypeDiagnostic: BY5PR12MB3666:
X-Microsoft-Antispam-PRVS: <BY5PR12MB366659FE2D928B2AD766888ADA089@BY5PR12MB3666.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TG6Cg2fcxyQuaj0ozrxLaJywfZU0CBptVJKQQFLfhrW94DURTxEYeHlExJgUkJlxbLEc0EjCRd9cAjX9INJOZTLPETWDwlku0VQRhiZIC3UicKKeHeyoDXiYINZC/iIfsnvrUpiGH+JGI4ihQZbNwUOHpKbb12ef+o3yDcegDojBecnB+zOqU1B3dZHMBoWm40XhjZlEAf9knrmk6lbhd/BSKOvEloVi4ST/J5gMR/otV4YkbVcSq3+W6fifhJxJoMED65BHwek/MH66f5zJeaFTYf8PA3TbdqYcaBriiGgffc5sqU5kVuFmHRIHRwNjd9xFZf5e9NtNhI/pXicx4mOG1fsdtxGhR3/TmhCRapneJeG829ADrdnR11T7jFxhOf9BbZ7nV2l5PvMA6qcClacyksUHFWWc5VzKPkzH2BBW/QpwJYJT6x+Rcfq/moEu3FWUfdS/NC1NzvRUnAH3TRWEsj4gsF0b5aTNwKuXget4i9GCkg6/HGWm31rT/7Atq0CoKVVfyXtF+HjdlUbjyffOHeTREuGlWXqZTpKi0Df9Thg4Mv42Wp+iy9p+zVmLO94c/8cirvTm01qfLDBPE4Z8mGUaQQe9CkQjHgvb8JzKIBmx0zGD/7pEMBLMcX5hfOWtAJ+CyADyVypiTNGstBTqEZ8kMdHqCYTbfrP52s4=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(46966006)(70586007)(6666004)(70206006)(83380400001)(8936002)(47076005)(86362001)(7696005)(36860700001)(1076003)(82740400003)(6636002)(478600001)(2906002)(8676002)(110136005)(336012)(356005)(26005)(82310400003)(5660300002)(36756003)(4326008)(186003)(316002)(7636003)(107886003)(426003)(36906005)(54906003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 10:05:45.0028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f46072-b366-4f19-a623-08d9362e7783
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3666
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
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Vidya Sagar <vidyas@nvidia.com>
---
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

