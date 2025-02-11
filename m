Return-Path: <linux-pci+bounces-21149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5539A30595
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 09:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EDB3A7BA9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 08:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4259C1EE03B;
	Tue, 11 Feb 2025 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UtIWQ4Ha"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682751F03CD;
	Tue, 11 Feb 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261863; cv=fail; b=u2FwebGPpJBSwMvGMCPDnzz4oc7HUSfe1TQxwIUF5aEDZl4HJlNdOdaphfCdsP9f2EE+s8sgnVWQ91fYb4nPhlAXyrj8+2v9RmcXpA4FsBlORhEz3N8nqwqERzT/sY9+y+WnrU6dg8Y2QYwWAgUM16te8htZuQ6x+B4+LFfbkY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261863; c=relaxed/simple;
	bh=OXz/q3B0LK+/hWv57FnYxYMSjKhLG1+dZfl/korc0yo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jK1lYKKjijfVyeJGEdsTWHJESmUIMmWJcjWKRTWubN0jthpD6yrNFYR7NiyjmIrLn6GKnqP7kmknysKsuAzTyfoOcagOwKKCcptPP9DoZDok5NoxTKS/NiiFN/LNaRxIRHNBhNXY3MTsiepmL+HciCNNK8HXAMJazLW5CS+4HLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UtIWQ4Ha; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvIhawrBwtPky6j8/SyP4ZrUWSSPbkHeu2+jylgyxzTzqnrU907uQN3/ef21bSlaJ+QIrWC4fqFysvPA6HEPMTQMBeSKzg+k5YYMvxBIGjd0dCmgpCP77bTUTR8HN39+Pkun+ZvBsqpeZWoBPSv5B+Fl1j7q2cHU6Xl4IZKb4GHep7PolacJ6Scghqfz0nkB+RRL2goOcZ3zExmnHw+SlIu7jGA67+pRXCyjd3/D0bSS0zNkoLogs4pdNzO2mAR0gF016za1y+4BNfCk0TScS84+c54ynJpJ+kFXoTLsXOnf6cywQHTvdCnpLmg6Nt/BECw+iUexQgaSUV8Rq982mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeqhI8xKCkRdSfLSfEYIeQkuBWeU9ou7QLVHZlt+JsM=;
 b=cJ2ClS2F7cBwcSr6WYuAnQBenU1djzBrHqtsRaysFmqGcnfc7hcnAYmHJWY9caEZM8NbrzdoSQ7nk3VYqE2UCFTJwpbSDZFGNMOspuevPCJ9KUA/lEZznDViUZiyjROXEcEO/qpjKbNUAUqh1lMNvceJCG1axm4O5mtQaBN5JQc8mWRvy2Dtu55SuhxQBYXL0vFNOxq1S99Xgsxeo3zXBEHv//xrsClU1n4RRaMt7UwjJttR5FuTHi+o0AgkTXsb3kSOkDJUQ93i5UAOeCt//f9JPnMxN7ajcVA8xih/Liojcna6suhVbJqKM89LEJYXtD4pcnn/81v9epFD5gbrMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeqhI8xKCkRdSfLSfEYIeQkuBWeU9ou7QLVHZlt+JsM=;
 b=UtIWQ4HafgjYgiyC6znYTEqyF9NX/SczIYH2riI4ZqruNB1U4Hos9ZPaRggNfGh8FSfQyfRIleq0ChG/l2FjLjFqMCJSBN78WmkjpFyzdWSTYzwfVQ9G8RQiyCI3u5LvcY4cZCpB4ZGlqi+EhGJ+QpSffFZSdo8y1tR16vu2Zhw=
Received: from MN0P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::9)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 08:17:38 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::c8) by MN0P221CA0023.outlook.office365.com
 (2603:10b6:208:52a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.11 via Frontend Transport; Tue,
 11 Feb 2025 08:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 08:17:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 02:17:36 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Feb 2025 02:17:33 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal Net CPM5NC Root Port controller
Date: Tue, 11 Feb 2025 13:47:24 +0530
Message-ID: <20250211081724.320279-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211081724.320279-1-thippeswamy.havalige@amd.com>
References: <20250211081724.320279-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 64422522-f108-4719-d5cd-08dd4a748c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vRpcKe+RdylDEdjBIqcPIeWBZm4FumQYSW5f++xW3QpP+fnCKYceDm8Zjp56?=
 =?us-ascii?Q?JE5M9KtSEWF8nb+0i7TXr7kOKywJX+mr8hMC0tKXuWzCKqBnXR10w0xDt4Zp?=
 =?us-ascii?Q?oxb9QahH40XE1TiZ1psc53slh/ci67GpeYE/5PEQlCURAmqItQqN6hLFlx0O?=
 =?us-ascii?Q?yHUhyLmScCVas5rG67UU2VysrOTpTyiSsAnTt8eM4gdWgrLoDpZ8eUPkWcy6?=
 =?us-ascii?Q?peNCvcu3sHfRSPWYgXPcYdQ/LvEfusk4ucCcSf9tWP1qEuFmWPeQvC/4Db8a?=
 =?us-ascii?Q?CW/Sj25YHfiZvn9v6u6RAnVkWmAP4urn2Fcdnjkkbqzecv9XHRM8fJl9C0Bx?=
 =?us-ascii?Q?nmwkqDs4wDetC3IBC6oCy3RnMUJUZz2IxtC8fsEV4M2YsBpirZFf2W4MGjOl?=
 =?us-ascii?Q?yTqJey1Xue5SWFvVsIENIIiFFxgkVa/WCuLWZYousnsoNQo9/cRvBRBDomAG?=
 =?us-ascii?Q?ge5dQacMTKr0SjKvpTs7xLjJK0NWACr2yi4JAKWatJF30Qpq4ozi/IFRSoy4?=
 =?us-ascii?Q?SdlnV5gQiL66VQA+RuwBLGtU3V/I6h/Mxbwi3pRsQM7OCdPfBH+9MZhS0PDx?=
 =?us-ascii?Q?WpPBV+U/FfqAprVZKGYjoItLvMlGICZpWL2PbODtrO1pKeRCstBZnFmAnXbS?=
 =?us-ascii?Q?3sRWqTw0UTwhQ5V27xYyaZq2js4B74prt9s0gzooGeMROQD8NqJE/P52k3p9?=
 =?us-ascii?Q?5w3Dx/92dLyb6vcT+crQbJb5EPbpRmz8IH+VAVgWC0c2RbipSJB5lIf1SuA6?=
 =?us-ascii?Q?aUcmb35JjynDIzVfxWh9dNWXmW4BqzjrE9wVksgzWzarRSnBe2NUgJXxeKVy?=
 =?us-ascii?Q?BhOV4sFhUXgn1ejs1gNOeIJMqkm2CBdBdY0fhK2T3h9Lj53ebzBfHQaYlHHR?=
 =?us-ascii?Q?A/YNOkeMH0U+ri/5alVujiCv56hpKCvodHXIgYBd8pVsIPXjPQ30jw0gvn8H?=
 =?us-ascii?Q?QxkeFpmNnNVrxSIuzEn0ZMw/hbQGcSHz042pgAv5to3QR/liYmCHU2T/Z0Ko?=
 =?us-ascii?Q?MPp3F8Kfjk1Fk3SmkgS8hsyZ1luH6dBX/4W6tqgpNgpzWnEY2yJUiZ2NWmHj?=
 =?us-ascii?Q?nQ0fZ4il08r9BBgidC+Srrreub4t3t2Q+kZdUkg35Es6pyhVDa5Qlu6szKgM?=
 =?us-ascii?Q?jqATen4W3C8uoaItlMwNMSNZYgNvfDU/3N08+BWIATtvBWnvGlhluiWMQ///?=
 =?us-ascii?Q?v4CoD4IS+Y7JnIvKa7dJEt7Qw7NmrJ0VxIuBDHBz8K6Kh04dvfqAOzMF28Eb?=
 =?us-ascii?Q?SeIWbp/+po9uasucCET+43B5bf52UQYERLRTDypbgmu9KpkIdW5jRQYEX+cP?=
 =?us-ascii?Q?/p/5+dyaHfsjPYh9UurDWHXUvGsbD2KJkql/bqLnhmZ+9Ufnmhw7cC4csP35?=
 =?us-ascii?Q?oEhenReMXf6IuI9pAWGkwumzbvFPTdSeiQ2Fcb0Upo5+y3fK0Kinj1ZSEL3F?=
 =?us-ascii?Q?qo5AzjOn3l9L4mmaLuAl/2re9WjzLrFnHCGX4jZGNCAk5fDYuhiPZor4UGFH?=
 =?us-ascii?Q?zBTrke9tHhurlJw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 08:17:38.1289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64422522-f108-4719-d5cd-08dd4a748c01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549

The Versal Net ACAP (Adaptive Compute Acceleration Platform) devices
incorporate the Coherency and PCIe Gen5 Module, specifically the
Next-Generation Compact Module (CPM5NC).

The integrated CPM5NC block, along with the built-in bridge, can function
as a PCIe Root Port & supports the PCIe Gen5 protocol with data transfer
rates of up to 32 GT/s, capable of supporting up to a x16 lane-width
configuration.

Bridge errors are managed using a specific interrupt line designed for
CPM5N. Legacy interrupt support is not available.

Currently in this patch Bridge errors support is not added.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
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


