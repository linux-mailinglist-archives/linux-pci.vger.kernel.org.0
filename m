Return-Path: <linux-pci+bounces-22232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBFFA4270B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15DCD188D814
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A29626157E;
	Mon, 24 Feb 2025 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O10pax7r"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3706D2586E8;
	Mon, 24 Feb 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412250; cv=fail; b=BghDFz9sKB2xxEN6pMWinLrJbxGXnZrOH6EUUA+bxpwAc9pquYurGW1nWqQGA2yB8mnqJA93bZIeqOgxxeCGuAdIhqxvsngJu2x1+Ao8TYBZaCgWypVFZKgDEOKZ6jNmq+fr9IMgz/mgfRyZ7KiZv0dUbWDEurJo9NM+p2u0gPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412250; c=relaxed/simple;
	bh=30M90+FFNZgAX0nC9aQJh7G9TnbqTI25GYLNymG9G1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GN4w/wzicudR8gJ4D8m5zoQWDKQeQ2JBXro0GUqEaYJ11RZLta5pD7Zccql2rhhJc9VXSCaDazyaV+fEMsauZ3EuFvyUHWsCZKCb1HJ8jwNO5RAjJJEillQMi0FTOAhMkMfDZKTpeA70WS6kYYboXeH6DsAJj3HP5r3XTDKLmdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O10pax7r; arc=fail smtp.client-ip=40.107.100.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEujT+ihO6ufTWjTmvvRRT0zTGwUH4Q8l1klGp93iWn7J/1X4gQB6q+z3lFkPYbz+7myQnwh8G1a3J4d8d2PkpC5SG+AO1RNdiA5C41QAbSDJWOGSuEofFEIIpEN8j6mJuVp6PgbXQe59U045af59w7s9x9tNQVlrrMGmO/bcVsuUrVwhKw9XxRCU3yC3PYcb3sDfgfC8Hty5G2BWkkpoCYNMu/Ge0+mheGcRIH+8q+XQHdkw/nsQik8VEw7zLD8ff92rhk2JGyspjVpj2FMgMvDvn5fsfMo1lDcJ2lkqHw1p2QaNU6g0bBdjbS2Cj5mULvSPI3qSWkBROJ06MR/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eec2Q0/mCopHqpi0GybIWMt0npK+LktCDstuVeGMhls=;
 b=bQSzG00Kbp61T93AMlCokIWYTC4FkbkM4uEM9sikDQ8ud7z94zeBcdYWpw4efO6thkRn9uolklqg9BawVjnLlLd4vgsce4gZs+pPANEvnsX/nM9eBY0rj8vDmmLu0YQiQxfqqC+fFuaII2PkdGDi8TCX2fCFPj6GtMoSA2e1vctKRPzmavXCSjsh/qS4ISBg++600un53g7KPsUS2uRxGzxzA1Ocg0bvBn670FjrkIVRx1LZ/yY2bSHdQBt2Fx1klH/n9T2f8GHFhMNtotOG3/q3ptDj7hqsoSuyBMr8fo2Po3YAeSPXPBAwpN+dnwrGLojifSJvSQQ/1nmhw2xemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eec2Q0/mCopHqpi0GybIWMt0npK+LktCDstuVeGMhls=;
 b=O10pax7rk6SVtkEkXEuMlVyDTPh3GNLheMI+K3pxxeJeUhVwNZa7lTaRx70OU2K48DCFrcC6NJ+L0Gz6T1jXeJcEb4cIrcwrtegbmQYXW/v1HuyqDu8H8so25Al3zMuR4tA06ofd2uDMPAup1seMZkiouMkB7SOiKVynYNU7rBc=
Received: from BN9PR03CA0351.namprd03.prod.outlook.com (2603:10b6:408:f6::26)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 15:50:43 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::9a) by BN9PR03CA0351.outlook.office365.com
 (2603:10b6:408:f6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Mon,
 24 Feb 2025 15:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 15:50:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 09:50:42 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 09:50:42 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Feb 2025 09:50:39 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v5 3/3] PCI: xilinx-cpm: Add support for Versal Net CPM5NC Root Port controller
Date: Mon, 24 Feb 2025 21:20:24 +0530
Message-ID: <20250224155025.782179-4-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224155025.782179-1-thippeswamy.havalige@amd.com>
References: <20250224155025.782179-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da703d8-05df-47a9-ee66-08dd54eafef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vljjkxPWafqtSUL2BBai3SDN7U0W1KVD6muGJs9aTW+JbWPw46pkB3l1cTcY?=
 =?us-ascii?Q?stocmzrKRywNPt85WcggCOQpZqk/zYWbuErwuUeheJ1e682C5g11PAxTG6jA?=
 =?us-ascii?Q?3tvkiyZkCEv5KplFuaH/+6PVNyaAttyCmHsof+E6g0Ax0utoHj2iIuKrNTFE?=
 =?us-ascii?Q?CpKZ/R7m5a3BpkFBG06OobHCH7cg9PikQH7iYYwmO75lMR1yozbXuVyH5pWA?=
 =?us-ascii?Q?jHMgom0uunTieO5MZIc0VvUidbFtMRI94CxNeTDQUhQDa/JwHshxMIyp0xfC?=
 =?us-ascii?Q?lZ00ZXqwQ2rilm6wZt1uqU2m24KKq0fRxmFzRU2lW5NADWTrsY/Ir5NS6iv0?=
 =?us-ascii?Q?2xzGZPgHa0H9INZk1wfQ9g8jrBl+uSdSEVf20jp4FPt9NAKMgdpW3y8vx93Z?=
 =?us-ascii?Q?mtyXepqYcWNPu7JeLSG0seJ6KKSg9iSpCdj+YkA63MuqtTC2Rs2Vc9V0KrUY?=
 =?us-ascii?Q?JbepHvLAUkKjCj7gNNIk5ni0O5ycCItHH3f5bZmB7257yhfFNBbcYNjNXmD9?=
 =?us-ascii?Q?47Icq7ld0WiNlUNX629vWy1miGayfJCJbdkzAKlFdi+Ye3HA/E0NcECFrJxc?=
 =?us-ascii?Q?Jl3xBwc7uKkgSV83ZjIlU8YxoA8FQ0ZXDKyK+AtXC9Mmph9uzLl+vo3pisnU?=
 =?us-ascii?Q?9vaNarPJvTW4Lx+XJQdCi1MpQCmwNJcoY6JUwKS4FdG+RHxubF5S3qMbeCdY?=
 =?us-ascii?Q?2mxaYEF8G08BPPs//jHofspLd8KCPSzYBM6P01F0AURAqX+//sp0fc3zQc7k?=
 =?us-ascii?Q?/G94EsSDWGJUHS6JOjb16qA8jJ9Yb14zTCPLT7E56F63t6ZzeOeVB6e8HZGV?=
 =?us-ascii?Q?nv5cINE4yvDGsa7hQPr1cBFlu4GuMbpDX6M5v/z760YEOpDOkf0WXDur551D?=
 =?us-ascii?Q?SvG6xE+6LLHt6lrShCm+Jvo15Ok1+vEjlfhBWGktqBRgtwn/6tNFaxBZWQ+4?=
 =?us-ascii?Q?XalP9RYv5zBwPsKCmf/7p8kD8kkneiOFyyWyZKGvSwbWxKV59z6MsTPltmMN?=
 =?us-ascii?Q?a7JroQX6IEbNrfTN4sc/ThCkMomFttBphtD+zpjgV1aWNpZpkO7/+x4rQEKY?=
 =?us-ascii?Q?r/VFORxzFP3vSfKaIvLjch8tZk1S1EP7QGpyEnmW5G1MvKlw251crzaJ7nhJ?=
 =?us-ascii?Q?jWLE9uePoZxfSwuRpD+E2iBC50dgQDW26tYbdBIKj3D5/o6XKvSZBIfAMRt3?=
 =?us-ascii?Q?Hva9ds+b7F6jZKPdexpvJ5sM+fOBx3+tDVCWYB/NaKC0PbtfnGPOrjBknosr?=
 =?us-ascii?Q?BpGk68UlwYYgx0OEC9PWzSYdUSrgMXg68ynUPNNUTqAp/d2P/wvnzrrTiCXi?=
 =?us-ascii?Q?cTl2NHUfL22UBvVDW42G+8s9i2Sqg0sufNyaSztSwiPQzyZftOZ+4+FIwllA?=
 =?us-ascii?Q?udOpdUCEO5LK2jro6rQRgDLAENPbSpZUz8KN1JpdnGjDIAgep0wiusksKAd3?=
 =?us-ascii?Q?g2WH+nCS6CN8zlTWzOYeF5ctJ2p8LREuKwsE0M6USl69bdER1qisTlkeXekG?=
 =?us-ascii?Q?jggqdaKsQCwB6hY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 15:50:43.2267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da703d8-05df-47a9-ee66-08dd54eafef2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222

The Versal Net ACAP (Adaptive Compute Acceleration Platform) devices
incorporate the Coherency and PCIe Gen5 Module, specifically the
Next-Generation Compact Module (CPM5NC).

The integrated CPM5NC block, along with the built-in bridge, can function
as a PCIe Root Port & supports the PCIe Gen5 protocol with data transfer
rates of up to 32 GT/s, capable of supporting up to a x16 lane-width
configuration.

Bridge errors are managed using a specific interrupt line designed for
CPM5N. INTx interrupt support is not available.

Currently in this commit platform specific Bridge errors support is not
added.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v2:
- Update commit message.
Changes in v3:
- Address review comments.
Changes in v4:
- Add reviewed by.
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 40 +++++++++++++++++-------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index 660b12fc4631..55a8b14473be 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -84,6 +84,7 @@ enum xilinx_cpm_version {
 	CPM,
 	CPM5,
 	CPM5_HOST1,
+	CPM5NC_HOST,
 };
 
 /**
@@ -478,6 +479,9 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 {
 	const struct xilinx_cpm_variant *variant = port->variant;
 
+	if (variant->version != CPM5NC_HOST)
+		return;
+
 	if (cpm_pcie_link_up(port))
 		dev_info(port->dev, "PCIe Link is UP\n");
 	else
@@ -578,9 +582,13 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 
 	port->dev = dev;
 
-	err = xilinx_cpm_pcie_init_irq_domain(port);
-	if (err)
-		return err;
+	port->variant = of_device_get_match_data(dev);
+
+	if (port->variant->version != CPM5NC_HOST) {
+		err = xilinx_cpm_pcie_init_irq_domain(port);
+		if (err)
+			return err;
+	}
 
 	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
 	if (!bus) {
@@ -588,8 +596,6 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	port->variant = of_device_get_match_data(dev);
-
 	err = xilinx_cpm_pcie_parse_dt(port, bus->res);
 	if (err) {
 		dev_err(dev, "Parsing DT failed\n");
@@ -598,10 +604,12 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 
 	xilinx_cpm_pcie_init_port(port);
 
-	err = xilinx_cpm_setup_irq(port);
-	if (err) {
-		dev_err(dev, "Failed to set up interrupts\n");
-		goto err_setup_irq;
+	if (port->variant->version != CPM5NC_HOST) {
+		err = xilinx_cpm_setup_irq(port);
+		if (err) {
+			dev_err(dev, "Failed to set up interrupts\n");
+			goto err_setup_irq;
+		}
 	}
 
 	bridge->sysdata = port->cfg;
@@ -614,11 +622,13 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 err_host_bridge:
-	xilinx_cpm_free_interrupts(port);
+	if (port->variant->version != CPM5NC_HOST)
+		xilinx_cpm_free_interrupts(port);
 err_setup_irq:
 	pci_ecam_free(port->cfg);
 err_parse_dt:
-	xilinx_cpm_free_irq_domains(port);
+	if (port->variant->version != CPM5NC_HOST)
+		xilinx_cpm_free_irq_domains(port);
 	return err;
 }
 
@@ -641,6 +651,10 @@ static const struct xilinx_cpm_variant cpm5_host1 = {
 	.ir_enable = XILINX_CPM_PCIE1_IR_ENABLE,
 };
 
+static const struct xilinx_cpm_variant cpm5n_host = {
+	.version = CPM5NC_HOST,
+};
+
 static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
 	{
 		.compatible = "xlnx,versal-cpm-host-1.00",
@@ -654,6 +668,10 @@ static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
 		.compatible = "xlnx,versal-cpm5-host1",
 		.data = &cpm5_host1,
 	},
+	{
+		.compatible = "xlnx,versal-cpm5nc-host",
+		.data = &cpm5n_host,
+	},
 	{}
 };
 
-- 
2.43.0


