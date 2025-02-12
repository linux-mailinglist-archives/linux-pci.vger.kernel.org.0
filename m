Return-Path: <linux-pci+bounces-21274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED223A31E40
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 06:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBE567A3160
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 05:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F052A1F9EC1;
	Wed, 12 Feb 2025 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZHlGbPbI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B71FBCB4;
	Wed, 12 Feb 2025 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339479; cv=fail; b=UsoGbVyBwsyxVznLsoTQ1Augzab/Aq4lArli5xPqQsVKYiQwfesG8UDARnJ7gSDaeU7iirgq5vsbWi+HY7xzfcdLJivJyjsGJhpSKuJKO3OQMqlvZzCYfK3dRIg9iFRnw11VrDx4cg/5cHcIC5S3sVFFpXAQOpkDpZzQauKkA1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339479; c=relaxed/simple;
	bh=ASai3JND5M6J/oCk/C3sSLL6HovwXS7EQz3+XVSAhjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Flz8WK/2qvaKJJwGgZdZXJFr5eEY0vclfe81DVJkxj6OKtAqY8Wu206/YTzfZBni/pHfVRn0vGNFM/sz53awMOFuxN04ZQGfSthqfPjNyylE1h/W8oG8TYrRAt/BlLJW0M9ozHmm73CanyADtIQ048Pv4C6elBcwBiSFvJ0U3j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZHlGbPbI; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXGuvw5pgjxwcJZzeGrxFbyU10KTN9gywGbuKzVOy893fOZ9ehbpBucjKDPMqQ+FVXcodzmxY08sl6ua4yeTDOFzno/gWUlToVqU+Y5ZVEV+YdDJVRjkU3wYA2+3OondfOOnU0AfgUdV3e3KvMBImuPWpQ1uTucdMqyJtOl+NNdkJbDnauksnREKTTjzftVB51QRPSre6cfuzWBjqA3NsrNTCZPwfTlfvsgOeJj0/N+u+E0BV3pYk7B6awNMgnxY+JfORgdDGvfbJ4D+cR19hg/AhejAXc8HT0MBockc7uVEkNN89opbKQfbAtFOHXz/n8nSUwJ7nlgwZlnDaQpMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiLMbizLBSLgUY2WZS6cumnRvPSut0Mi7+dvDRwL234=;
 b=k6aAoV3iP26ZEu5+ybzCX8kcLiqRiKW8pM08c9ISMykTlbswNdsHZ7gchtMX/qYyWRI5fBOuChKzxBIYH+3Mb+x9ZdjCmafx+IC5yOQTUk7B2E2sKxRB8uRBeyxfh3Ye09rfvR0hOOwpr2w1ZG8PoqZhuTzeeeFzurggF2Km2yURYZnb1SBu3hZlXy9lYX0tpja+idzauxiQ1plQ44LzpUi1A/5mGr89gyrVAh/6mpJp80fWlFqvVXBsBmzu0C+rou1RFZH7ZZ45fc98lItqLl8vl/CJs3s9uJpwVaWf8aLFwT4yhvnIUnHLQRhoAqdQE/8RYAQd6YBprp2nzAyPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiLMbizLBSLgUY2WZS6cumnRvPSut0Mi7+dvDRwL234=;
 b=ZHlGbPbIaNmOPPkDuuBwFfUy55ebrqIB211tREKQBrXiEpeUGwAVDA0WSLH6SnlgCdCe2Bn1o27x3k7oT5JyTEOhXMghxPtpFTP7S3B8RnBIuG6AkrVb6EPsM3pCrcAUZcYRrTN/0MJEKYrZJZQste4CEQaE1/FTI2X+oO8mqPY=
Received: from CH0P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::11)
 by IA1PR12MB9522.namprd12.prod.outlook.com (2603:10b6:208:594::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 05:51:14 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::48) by CH0P221CA0009.outlook.office365.com
 (2603:10b6:610:11c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 05:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 05:51:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 23:51:13 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Feb 2025 23:51:10 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v2 2/2] PCI: xilinx-cpm: Add support for Versal Net CPM5NC Root Port controller
Date: Wed, 12 Feb 2025 11:20:59 +0530
Message-ID: <20250212055059.346452-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212055059.346452-1-thippeswamy.havalige@amd.com>
References: <20250212055059.346452-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|IA1PR12MB9522:EE_
X-MS-Office365-Filtering-Correlation-Id: 6464dd36-17ec-4cc8-526a-08dd4b2942c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YAOp2FEQS7/XPkHtecF62+8xmJi6GjFpiuoBcz3pNsY8QcrsNcBV2uHNzLxt?=
 =?us-ascii?Q?5xxcNzjhmj8Gd4DCxxxxo72C+fDnJd0780uv6FNP4TSaJB/Kc4Ln4qF7L2n1?=
 =?us-ascii?Q?XD1I4uycu7Zd6HEMbTCGpHpxDyOur/5gSagVt2j6wW3nWC3oY7yTks9yOl4Z?=
 =?us-ascii?Q?avCetuv0ygdxs7c/MFhg/3KsaNH0qn2yfQhFJDnCoFd1yLyES9cz5JsY4zM1?=
 =?us-ascii?Q?MGOfDFpx/VJWP+i6To93CK8Bvw64cFwtV93LEjFkat/7Yb5krSOiuqXai8z5?=
 =?us-ascii?Q?7bInPAT9Sy0Lp3ApARrUUCc6fg2PuPK0eN4zLLuBYIlhRhdvT2VN1d4fRyEJ?=
 =?us-ascii?Q?KLcYRNxwx790sd5wjXESsw/CAPCYF4yV+v39lYGFByoQQJNUkvhUG8ri7+uZ?=
 =?us-ascii?Q?92SNJGonezUcYwpJbHE1aJSkxJ60bmxkuHYUX65wNQEVv3vMBrBpoHoTIwr/?=
 =?us-ascii?Q?z3yFnZ1gQz0/EKHalU5hKROUDAonriJho7lNtYnstzdNQnIKlvBKcdip62VT?=
 =?us-ascii?Q?uJV9GTEgKBSWOGE8Xv3XASjuVI1EYSQnvlruJNV6gnR+a38WeTE659S7YPgH?=
 =?us-ascii?Q?VFmhTrTK2l1KNypr6drkDk8e0HgOAQpQnzrvEA3X1ugUwYMFWLMBTb8TE0c/?=
 =?us-ascii?Q?VDo+0wHWDSq++KO1Mt67GmiXSvTFf7jRwr40JKNC9W6nNuIorDOZn2isZMly?=
 =?us-ascii?Q?x7IP8gUxhuhyLpd30TZ4mkdSHiIVxNlnI3T+I3d4BFnlykeOsv/K4GSLSaLW?=
 =?us-ascii?Q?sanE2SiaMQvu60vR7sMyXPJQokowP3T1LaLGgZpU+ungDQgELX5uqwUUZfe8?=
 =?us-ascii?Q?PUFmJjEQ6NfSntezLBmnDQpePXY40jAWNUtRHQ8xOwNDooBau2lScOHMhqI9?=
 =?us-ascii?Q?D8W1QK5dgaEdG5i5sg7KXO4jQaipvRmnMV3Q0T5VjmyP5gTa5cwLfeAt5EpI?=
 =?us-ascii?Q?Nu5DtXigv2Do08FK4FiFQuL/w55j64YSTiN3qaNjFei48CWn1zgrgV09/M2x?=
 =?us-ascii?Q?mySXlNGj/QahJKE4enyPzoTxatTVHrN9g9vkWIJob1f6W8qftIpBPpjizIXQ?=
 =?us-ascii?Q?hsNmcw9v0RewMZhuM5EyNgrpcAKDWj17sinopxfRH/pX4/OC7Hg1w2PUE+0q?=
 =?us-ascii?Q?cGpuKUquKhJDoFRx2J165IaO2Ly5NqF/0i2ES7UajGIQ8z5K9/o8vVOJGjCu?=
 =?us-ascii?Q?L6FXubN0/xwOKzKD/eP0T1v/HXnXPkMt+7AuO4JlVePo4vTATQsEWULRTOiZ?=
 =?us-ascii?Q?3EgKWpL4UXCH9ZCmzLX2nCFw7NI3E380yNkw5qJXgfi0RS8RKBbBV7VkJh4l?=
 =?us-ascii?Q?TFM3j6J2mmyNpAlcxQhDPOs74pc7OCqvY8dFDZUOmPzYI5WeiepaKgYEBq+E?=
 =?us-ascii?Q?CW2P+gMW/wWUNJisBWly9TOS7oP509iLjTncZTDsc7lfaqg3OyTHKbWcX0kd?=
 =?us-ascii?Q?/z2USpbFzPuBTQySyJFyJQljirNLbqyMMDw0fkHdxYDXtf88i43XGIdMcZXl?=
 =?us-ascii?Q?ulJK91n+tjn5CWU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 05:51:14.1380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6464dd36-17ec-4cc8-526a-08dd4b2942c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9522

The Versal Net ACAP (Adaptive Compute Acceleration Platform) devices
incorporate the Coherency and PCIe Gen5 Module, specifically the
Next-Generation Compact Module (CPM5NC).

The integrated CPM5NC block, along with the built-in bridge, can function
as a PCIe Root Port & supports the PCIe Gen5 protocol with data transfer
rates of up to 32 GT/s, capable of supporting up to a x16 lane-width
configuration.

Bridge errors are managed using a specific interrupt line designed for
CPM5N. Intx interrupt support is not available.

Currently in this patch Bridge errors support is not added.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
Changes in v2:
- Update commit message.
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 85 ++++++++++++++----------
 1 file changed, 51 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index 81e8bfae53d0..c26ba662efd7 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -84,6 +84,7 @@ enum xilinx_cpm_version {
 	CPM,
 	CPM5,
 	CPM5_HOST1,
+	CPM5NC_HOST,
 };
 
 /**
@@ -483,31 +484,33 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 	else
 		dev_info(port->dev, "PCIe Link is DOWN\n");
 
-	/* Disable all interrupts */
-	pcie_write(port, ~XILINX_CPM_PCIE_IDR_ALL_MASK,
-		   XILINX_CPM_PCIE_REG_IMR);
-
-	/* Clear pending interrupts */
-	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_IDR) &
-		   XILINX_CPM_PCIE_IMR_ALL_MASK,
-		   XILINX_CPM_PCIE_REG_IDR);
-
-	/*
-	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
-	 * CPM SLCR block.
-	 */
-	writel(variant->ir_misc_value,
-	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
+	if (variant->version != CPM5NC_HOST) {
+		/* Disable all interrupts */
+		pcie_write(port, ~XILINX_CPM_PCIE_IDR_ALL_MASK,
+			   XILINX_CPM_PCIE_REG_IMR);
+
+		/* Clear pending interrupts */
+		pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_IDR) &
+			   XILINX_CPM_PCIE_IMR_ALL_MASK,
+			   XILINX_CPM_PCIE_REG_IDR);
+
+		/*
+		 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
+		 * CPM SLCR block.
+		 */
+		writel(variant->ir_misc_value,
+		       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
+
+		if (variant->ir_enable) {
+			writel(XILINX_CPM_PCIE_IR_LOCAL,
+			       port->cpm_base + variant->ir_enable);
+		}
 
-	if (variant->ir_enable) {
-		writel(XILINX_CPM_PCIE_IR_LOCAL,
-		       port->cpm_base + variant->ir_enable);
+		/* Set Bridge enable bit */
+		pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
+			   XILINX_CPM_PCIE_REG_RPSC_BEN,
+			   XILINX_CPM_PCIE_REG_RPSC);
 	}
-
-	/* Set Bridge enable bit */
-	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
-		   XILINX_CPM_PCIE_REG_RPSC_BEN,
-		   XILINX_CPM_PCIE_REG_RPSC);
 }
 
 /**
@@ -578,16 +581,18 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 
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
 	if (!bus)
 		return -ENODEV;
 
-	port->variant = of_device_get_match_data(dev);
-
 	err = xilinx_cpm_pcie_parse_dt(port, bus->res);
 	if (err) {
 		dev_err(dev, "Parsing DT failed\n");
@@ -596,10 +601,12 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 
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
@@ -612,11 +619,13 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
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
 
@@ -639,6 +648,10 @@ static const struct xilinx_cpm_variant cpm5_host1 = {
 	.ir_enable = XILINX_CPM_PCIE1_IR_ENABLE,
 };
 
+static const struct xilinx_cpm_variant cpm5n_host = {
+	.version = CPM5NC_HOST,
+};
+
 static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
 	{
 		.compatible = "xlnx,versal-cpm-host-1.00",
@@ -652,6 +665,10 @@ static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
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


