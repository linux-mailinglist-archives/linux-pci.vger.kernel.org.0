Return-Path: <linux-pci+bounces-21588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D345A37C33
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 08:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FFB16506F
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 07:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B15519C578;
	Mon, 17 Feb 2025 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PkRpxEib"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397C194A6C;
	Mon, 17 Feb 2025 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777290; cv=fail; b=rwCFmNocNh3ah1fzQ6FV8Gv+9ABpTtlAuwmO1trlMyLxmskK6AFdjN5QpTCPIKD0M416itRTAiMh7aKiQeQc1FF0skTHuiuaRV16TuDY73XsBsyEnarJlhWi82BtcaPCbk+niOIpMhY/oVG7fhkqgSQeJj9GlWuAbNIsazTgEPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777290; c=relaxed/simple;
	bh=rYIAvpsIoyf0Q0GuXz+1UCRAApQnmxa2b9gu1o/V7fw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKMLNCFemrVPeUsbmfYzNc7+xU7bXeNDOgiNa0UpV8wSO6DcbVwMmhGsseqURqRZgot+SYGP3qbQ8tn09d3pJyVCu7fT3Ehx7RNJizj5uC9tyWV6ueqN3xdYdf/99DyhrHtaD4nNlXdX/5zXTqFOSEQihk6RtF4nQSkNdazuh/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PkRpxEib; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mS8tJBH+0ErAfKjTmrA9pNMLUqOS3jA1F43PcIqcw9OvhLXbMWAfA5XYKouC5+dqitsDG6qAVH3a9cTAtxZfEeEUgSl+UlI1lqRZr01FZNEQesWCqQg0WGuM2s9VT48f0kjofflVMiRqgWYb6Fpswq/8P1Ksl+UlEpuF5XVWWyqa3oDFqavky/IbRKSarZFqWsWbG4wf6hvU01tgm7guiKtCJpsiwla3+GqOw37UvRB5W6hZZKTiw5rWj29Qhf/7rAiJhEx/vgLqKjdeMtX38isURCdlg2kB3k7o3ilYLfzukSg3OliaQGcTxazgADY18zKd+q3CzR6DFsTY4EQ10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sPu4XY3L853RwT4FWVluUfmms4EzqPgPW65Wg6DJOU=;
 b=BdIE/umvs2boyv9u6Y8ApLOeo1CHi0Ex1HL8ErkBlou4KazzRHghm+1hovAOTk7hqfBf2MBNqhVU1K03NxMas7Wy/NhIx1axRIi0Fj0JSGqBHkeJudtY6y9SA12ylvPeclu68lViiukDUKtXAe+Rr6TN721zU5gYWf4iIQHiMbC0wCdrp+l5f4VArGn5GZ2lrJNS/BmiJujvchxxYlJMpRF1TFgVrn+PsoCtC1zLaYHsPXd0soRd6kC1AIwpmFWwXFl7sZl8fA9V9mxUkh1fnifxA0KqbXM4bk4c/9yYltcNzmU2gAjEXdPmsOBPBBD+7nbgaKSVYMh17FEaX+6JgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sPu4XY3L853RwT4FWVluUfmms4EzqPgPW65Wg6DJOU=;
 b=PkRpxEib1BRL7YAsOC0naES9SatIBxXxjxFd5l05I/+/XQUlKEt47FN4lKghOIe+NkrCjQGKbHmOaMt5K91K516Alw7VG5q9O8zTlgkHtihRMNPJQjQ2aetzXPlywysg1PmA8YD19+tBRUULoqqfkyVsPdjOedySIgOjsfaozdo=
Received: from SA1PR02CA0008.namprd02.prod.outlook.com (2603:10b6:806:2cf::13)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 07:28:04 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::36) by SA1PR02CA0008.outlook.office365.com
 (2603:10b6:806:2cf::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Mon,
 17 Feb 2025 07:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 07:28:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 01:28:03 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 01:27:29 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Feb 2025 01:27:25 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v3 2/2] PCI: xilinx-cpm: Add support for Versal Net CPM5NC Root Port controller
Date: Mon, 17 Feb 2025 12:57:13 +0530
Message-ID: <20250217072713.635643-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217072713.635643-1-thippeswamy.havalige@amd.com>
References: <20250217072713.635643-1-thippeswamy.havalige@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: 1148b044-51b5-48c9-8b0c-08dd4f249dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9RC7/TpZOGT5msArjpLMBXTK5FCU704ukkYOHT34NQcKbG8gYlJuVptIjI+C?=
 =?us-ascii?Q?Jf8GdZFG+7KlGJTcNzVDYvgreQgbefIfEGH/zVP4PrTA83bmyvz6TzFT0iqz?=
 =?us-ascii?Q?5J8en5a+sA01Yfyv7j6A+1VW5I4oIwSPTv+WKazLkGP+B9uKs0vI9qCLPC25?=
 =?us-ascii?Q?FXxQ56E57DgyjqU5Go0Asj0iHjgQWp+evX7TwkwOGjR4RoSSXiG9CIeIhmUU?=
 =?us-ascii?Q?Z2/4jQ2weAO5cRde6bSKQ10nQSASDzoKB7dDaZMyZU8fM23+RUUNTt3Z0pxH?=
 =?us-ascii?Q?yhlqIpJh3cXfbsJXWz+HspVqvRIrK0edpVlJ8e3XHj9QXT3G+y4F0O+qNaNt?=
 =?us-ascii?Q?4fXbdTmDurkhpKtd2vxMbmRPWspo1yhvV35m5fTH+R9FsAKWGEZDNWzrUlxP?=
 =?us-ascii?Q?pDH2O2bFbtNVySfv5CMv4Dz2PlfJ7Ff3asxd41WHeYBfYLit4aFxCdMMnQwb?=
 =?us-ascii?Q?7rzE82PhR78LlPssk6okzDI2DJbQ7sxzjA5x4ER+cTlv3JnlCKqCXAO+GKet?=
 =?us-ascii?Q?5p7acOBsJQ2ddQTUX5f2SUArBQULWRVphG+Gm3m4qfHEpRWbDK2QWYfV2R+b?=
 =?us-ascii?Q?nf8Uj0FTxjjTsu/8Amd0UFRnnfUAO9/oXz5xax7KsqseFPE31B9QsRKUCrtr?=
 =?us-ascii?Q?PGC9yVdgj5fSfXc4fOJny02hx7Bh7+WcFwFhzI661OsxlqR0+NbUGP+2fIss?=
 =?us-ascii?Q?1TvuPI4m7DfE2Y+YYSdy6mT0d1Ka8CflcY6KxKxAqS5At0o5Hpfbn+q+z6cV?=
 =?us-ascii?Q?PaXRobYf5S5rQjhAmRImOfWuus9B98HbXmzAkbSjbHd/Zs92HGikLsQ6lKa3?=
 =?us-ascii?Q?ZIkK1N1SzrUV+u8+XSPzwg70EHLdtebfBZntRPkaO04e2UhoRDsSnRBapJCc?=
 =?us-ascii?Q?oLUPVVpucBh7wSmFDM3p4XyXMRupNhkZd+Wv8ofyAwD/yUk02ogmL9+x8SGk?=
 =?us-ascii?Q?41zm7bgMEcEeO+InhWXf2+nJRuqRQI9WT5CXp8mTzPhCnInVyXphqsECwusv?=
 =?us-ascii?Q?hb+0AqVs/Z4ww6Lm6Q4jAoNsmZBW77S42EBWAYR2u7fOG1g/25RbvAXQ1sUl?=
 =?us-ascii?Q?miFXkI3Cw23fZnueFX5lTYJ0UaddPeFC/HRgIavyAw+HDZ2vvdor9NBTVufM?=
 =?us-ascii?Q?2GhkwbjibosIz0lUWfbzf7KA9/7n4jLj3YLNdqfmud96M0ccFWZuV98j+aHY?=
 =?us-ascii?Q?xvPPXtnkWFXJZ8iYDhbHvdci3b0Nq8kue9AVyLPLGgRoD8GXInohg8mz+2sF?=
 =?us-ascii?Q?+V7gNHur/bUxXXOyYFKmOJwdIrljSM5NbvXHtgREZET2kNxNNRCwhy//+iRU?=
 =?us-ascii?Q?ymzS2f26JLHf+FHsleFoI3Xgm7tjIkoD3EAQ7or3hS7DkuKORB519ptjsn+O?=
 =?us-ascii?Q?1pPy5DAkmb7MjK/jaQQ9s1H04XzRHYmCE5YIhYgC85KZ+ygBFmhD0GbuMzfb?=
 =?us-ascii?Q?UnImCTY7ijh/ubo/MH3h955t8jxCG0HqjK/HLYqrv1PIFSNz+djVQy32h3qB?=
 =?us-ascii?Q?e75M8NxtaU2/pIQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 07:28:04.1327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1148b044-51b5-48c9-8b0c-08dd4f249dd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509

The Versal Net ACAP (Adaptive Compute Acceleration Platform) devices
incorporate the Coherency and PCIe Gen5 Module, specifically the
Next-Generation Compact Module (CPM5NC).

The integrated CPM5NC block, along with the built-in bridge, can function
as a PCIe Root Port & supports the PCIe Gen5 protocol with data transfer
rates of up to 32 GT/s, capable of supporting up to a x16 lane-width
configuration.

Bridge errors are managed using a specific interrupt line designed for
CPM5N. Intx interrupt support is not available.

Currently in this commit platform specific Bridge errors support is not
added.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
Changes in v2:
- Update commit message.
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 48 ++++++++++++++++--------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index 81e8bfae53d0..9b241c665f0a 100644
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
@@ -493,18 +497,16 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
 		   XILINX_CPM_PCIE_REG_IDR);
 
 	/*
-	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
-	 * CPM SLCR block.
+	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to CPM SLCR block.
 	 */
 	writel(variant->ir_misc_value,
 	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
 
-	if (variant->ir_enable) {
+	if (variant->ir_enable)
 		writel(XILINX_CPM_PCIE_IR_LOCAL,
 		       port->cpm_base + variant->ir_enable);
-	}
 
-	/* Set Bridge enable bit */
+		/* Set Bridge enable bit */
 	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
 		   XILINX_CPM_PCIE_REG_RPSC_BEN,
 		   XILINX_CPM_PCIE_REG_RPSC);
@@ -578,16 +580,18 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 
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
@@ -596,10 +600,12 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 
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
@@ -612,11 +618,13 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
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
 
@@ -639,6 +647,10 @@ static const struct xilinx_cpm_variant cpm5_host1 = {
 	.ir_enable = XILINX_CPM_PCIE1_IR_ENABLE,
 };
 
+static const struct xilinx_cpm_variant cpm5n_host = {
+	.version = CPM5NC_HOST,
+};
+
 static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
 	{
 		.compatible = "xlnx,versal-cpm-host-1.00",
@@ -652,6 +664,10 @@ static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
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


