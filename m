Return-Path: <linux-pci+bounces-28898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEDDACCC10
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A1F3A89EA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB2A241689;
	Tue,  3 Jun 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fux0+Ewv"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDD924166D;
	Tue,  3 Jun 2025 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971500; cv=fail; b=YP0P55UM4ocLJymAVpTNoFkO6ArhT+wYESWePDk3FU+ERnplXZmrSPfNeQY0tDmOc/fteWZDwEgAkJRlX7w7WhbOtW/Ff3ZovCkyIjoAkhxdL8oQ/gs8PihSdP5eZ/DDeP9o7W+d7E3ltrC1CtL4bM5zf6G7jwUWtRoWu/G7Iek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971500; c=relaxed/simple;
	bh=wKYT2RX2WS2rMYQ8Nxy6U8dUrXd+1T0ePtqEyUHEK6s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmhcTqSq6VFay8uiBegUyClglotkdUB3G4bO9NOluP9qPHRy5asimtTClhQPlEj99FFXqutfVtHgRfdSAjez0oz/RNcdYwJ6DDHmfnQ6p/fvgFN6EjU0bIIGosWkZNnGmDHNvFXTFrlAzdffePCuz7bgGI6Jnyo0USk8JVyzyrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fux0+Ewv; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzlqzGsG8kiao/+kLeXHZ92WhW6NhaO1rgybOsSMNIRMyEUb3Z9ButrGqKeMy+I5+zIBzOFWcfUKPLyYWZiDCs0DjgXPOLQGsdKp67qppBZUUaJEDSTz424P5g5WeHj5Gi1rUBaxtsD9qsfkU/E63AUGjesrSeMxB8P1vLb2MmcnQJno3eQoktwne46JBaXxonYrkD/V7s4KfXQqxckAN6advwOYnb5deoTSWrBC9nYUgKR8HRnllCyKGe3wEL9uuyB53a6M5MHMMeNesCb6Q4zHAQb5TpIs/Hd9CzdPG9ybxZubTJQi+gVZWQfmtKI3TaY6a+zirYFNU9UXuoMPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Scya8gfCWFz1+mMbTZwepfFxg5bxLhLwPryvZ5GuzOY=;
 b=uOmig5UbWc8GiP6yYKydF2+7GnTJJzANGsRzcB6YcLmaeidSwvqKhHN+BNzNu1pg/UJbY4QcETd7kiSFhw+0MVttiDgc1DdQeSBJWvSOvsNZbCuWbOJfJx1xMcURvhaTB0+3o/YfmJPs8pdQT3NVHOpuXwpnjtSub9xGyHlAIwfyrw9v3GRTfAreBxphdspdeU6w03Ew1I8SQ7qGk/XvkEdGvKQn5MHrGPjOaPVWLt2qSzWvPHvi9cXE2Eug5csyvaCaGgC0fPWmSoGq0CXzNniO0DGVxBEMyt7CJ1Qwsq2RjMRVkwVgT9JPZDCKC8thEbk1mPdhGXLtJWxK4LrWqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Scya8gfCWFz1+mMbTZwepfFxg5bxLhLwPryvZ5GuzOY=;
 b=fux0+EwvE9CPJF5Fgz22lPDH6MIClIamhTdIpy4xCFFMMB+tjMbtgq8gvUH8pL/GjF7a9tVJE2tvbkKsYrpMjJvCfbEoc/Lyd2DY2MUZowFAbPFgAR4hxXkQ4CIjGbZYYMlYVxTg3zdTDiGoMvP/B525zVGkOJmklGrQPh/idFE=
Received: from BL1PR13CA0204.namprd13.prod.outlook.com (2603:10b6:208:2be::29)
 by MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 3 Jun
 2025 17:24:55 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::ae) by BL1PR13CA0204.outlook.office365.com
 (2603:10b6:208:2be::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 3 Jun 2025 17:24:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:24:54 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:24:48 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <PradeepVineshReddy.Kodamati@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<bp@alien8.de>, <ming.li@zohomail.com>, <shiju.jose@huawei.com>,
	<dan.carpenter@linaro.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<kobayashi.da-06@fujitsu.com>, <terry.bowman@amd.com>, <yanfei.xu@intel.com>,
	<rrichter@amd.com>, <peterz@infradead.org>, <colyli@suse.de>,
	<uaisheng.ye@intel.com>, <fabio.m.de.francesco@linux.intel.com>,
	<ilpo.jarvinen@linux.intel.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v9 11/16] cxl/pci: Update __cxl_handle_cor_ras() to return early if no RAS errors
Date: Tue, 3 Jun 2025 12:22:34 -0500
Message-ID: <20250603172239.159260-12-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250603172239.159260-1-terry.bowman@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|MN0PR12MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: a84b1f4c-de6c-4c8f-a65b-08dda2c38e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LTaujmTU1/JfAvY7Lsr+xyr5m1/xL7uQbRKnpuhmLOJTyLYgbkGHeudG4hgp?=
 =?us-ascii?Q?LWEUOU7n7yrE0kJQEHeAEIfoQ2O8PeqZzsDMRf1v5ps8BoS0ZGl9p4DC6CSh?=
 =?us-ascii?Q?hIBu8uxUH5/ocFXwU2jlCx/hBsjkyLqL6Ubl3Z66O+TrQmvT5n0vdTCtBcVZ?=
 =?us-ascii?Q?FfQfh+GQu/BPSphp+UQlcWmOcAwzWEVm8DfiaF58jklWQX5KNDr98YrpuDmD?=
 =?us-ascii?Q?m+NMRsZvCnbYPyCQlGdoiLYrrEkyeDiYKFPCy3g8QnrJRuINs/EPY/UXOBsp?=
 =?us-ascii?Q?kdr2ZWTGu+fMQBTFKXRyYgn1R9q8ejWadEEgvMZ5ZmctiUmGheDsQPe5Qr5Y?=
 =?us-ascii?Q?TB5NrZQb071mDc4Y+Sx8mj3Frr9d9+FFzKSTsgFpaT88WG2qfeQ1CPrN1dVW?=
 =?us-ascii?Q?xdR9pgX7idgULLFrbo4WLXFYPc3gCyDrKgGp+QFmxvClEoL3e3YJ06+c7K5W?=
 =?us-ascii?Q?mfs+sTelaGHS548xrsX8qMhFgchiWSZFXI+OKdcRlqU4uBiWZztYFaL/XW4k?=
 =?us-ascii?Q?gMXn7YNxMwWWOuQHNYF3Rv+XWE5YKhuLh+ev1JkQ7dLZ2wxV2SQtRpeuFHg3?=
 =?us-ascii?Q?HubSrzJg11KxzikedRVnuRNwpTEs5fcNrbYeja+pqbtZzEA7Mg3nAK/lGAKY?=
 =?us-ascii?Q?/jeiFaMJ0i8KipwKhW51W8MEtMGvgN6Zx1BAFqydKsk9ZsXVZETOYCS22WG4?=
 =?us-ascii?Q?kUnRRxrriVziw/75WnrThDHB/HjAH+pyx3KZVAnIn31q3eQIiTV6ElG75FrS?=
 =?us-ascii?Q?Nn7ACmHPW78aoHSCRxyJT10Hy0910sWjDYdA2BclFlJlYAwdn48h8dWivrcb?=
 =?us-ascii?Q?XyTiF4yjo52JTOgfufnC12mlPqVCxOVlHZ/3E08cs0243xpxLs4Pvy5sXPt1?=
 =?us-ascii?Q?B4Bnc6VRI9gKowaQ7MY36HtOUfqxImXxGyaPZx445CDHnZMjZN8F4b9RGoDB?=
 =?us-ascii?Q?EPljLN1+/YDRkgn0Il0sBtd3B/PBlBQU7rZLejSgCxGAs3dMNVP7+L3QDAuj?=
 =?us-ascii?Q?9D7yHF6r+iNHo1C2cZ8Swtkvsr7cTSqszJHzEA4Ats+1t9ErzkR3dHQsLQy0?=
 =?us-ascii?Q?dj5U5VbJ7XBnqndzUAWW/7Vy5V1wrxfxKcX2eZ/bm/6m3UuTpWSJ3txzclxj?=
 =?us-ascii?Q?0TRbeuCTiTByvxwJKEfrou2S+NUcti++jwjt/SHda52johO7QkFHx3eZMnPl?=
 =?us-ascii?Q?XWlIJWlffPvCAmzG0HgXWi8XjRyPWZwjXFkrbbAycsPHoDjNTg1YiXEoTdFQ?=
 =?us-ascii?Q?AOV1aPvAld/DrHI9v1JVj67GCE4GjveUIr27yoPmtYvvwB1KRJq2iMB+em3D?=
 =?us-ascii?Q?2MT93+j2h87Va+buu9eIJS3d3t5FCK+AEccKMu0e6LSJqvnVU0miJ6MF04E2?=
 =?us-ascii?Q?ZL02G8IAvkAuR2fZu08TuhxTStwRz3kYNiLEtxJ5MlkaMzZhCS7QUA2vEXYr?=
 =?us-ascii?Q?pfCVtyPxuUmJGs8l1fCLk62/cvHqKxTq6411KqapXAGme2FEOcTtMByzo6uQ?=
 =?us-ascii?Q?pTlmSMIPhFw/u1EIryHmAdfxQoVoaiZbwLbKJoOFxo8EJH2DQgInOcQh2w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:24:54.1356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a84b1f4c-de6c-4c8f-a65b-08dda2c38e09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882

__cxl_handle_cor_ras() is missing logic to leave the function early in the
case there is no RAS error. Update __cxl_handle_cor_ras() to exit early in
the case there is no RAS errors detected after applying the mask.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0f4c07fd64a5..f5f87c2c3fd5 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -677,10 +677,11 @@ static void __cxl_handle_cor_ras(struct device *dev, u64 serial,
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
-		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(dev, serial, status);
-	}
+	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
+		return;
+	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+
+	trace_cxl_aer_correctable_error(dev, serial, status);
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
-- 
2.34.1


