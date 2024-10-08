Return-Path: <linux-pci+bounces-14018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7575C9959FF
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8121F21706
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BE1213EF1;
	Tue,  8 Oct 2024 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vwR3gW7A"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DD921503B;
	Tue,  8 Oct 2024 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425972; cv=fail; b=h8BRGJuXjlWILfXbtxINbfIcUo13vYNpK1gQLaLsTSjZNNF3wO7h+FtzjboJTDvLGJekADZxaegL4Jr5ZoWR5zoygkBgmxOXFrTvGpvZFt8Kj1FpnSg3grgczvSglS9vfK2Myi7i2Qc1A2KZa6xaArhcRCPIi+HyDMlCzq6uSGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425972; c=relaxed/simple;
	bh=JrXreU8bAVYSLae02dgo+C2Q1O9B1VPtNz8E5rdCVF8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aw0k3qMDVMgcJUq2TxYTR2CS2SUu/0AzHwjzPWGoSd9TrZtNaZZGKcru5gthrgbTgl0C3lYZo5Nnr/Ka9fWfppfbU00yMl0drTfgz+auHWlRfnNymVihzCqh0rBMPom/dzWJCEtCJX15x6DVZ+LXOvxJRiXseCF+JckVwJlIwXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vwR3gW7A; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKoYwWnTN0fsoiq8xs/j2/TcnLeJ7GQQpRxd0iJJrt63W8foqXQ/BZV/Kb98EEPWm2Zm0UbnOhnBgi2pGIWrqQ3zqpcNht5Dghg7bu4LkYVxdaQJVghguAxpQnOurKuD+zSwRuAWZRLKOtl/w879unsLbqwN58aqQuVV+891UvAeE5h+ed/WUoE9WPV1HZ38uTAujZPAasixg5ZLKl1P0aajB8RasfiqQV9ldNsIYLfH/ZgLkia+RyXX8RMxg5MNJAofe0qJTc6J4aOUHqFVf9hsRgLCqg0IJTc66DorobQkiJzwZlslNXilzV7t/8wKdGeagIRqbLTL1BOf1A5k4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baLU/8n16ZjbbGjYZ9V333EBUkQ5W1UUAvVlCOa2Jhs=;
 b=oV+7JGyiugbtOOs6mFifMEbncgbGHHjFQfgQyR4yzcSJznMIgs+sGwansmDCkQpK8U8As5p4H7LGqTvpWfX6tWnLi0zYAERh28a/SwWcFGhBZCTGaygtcb3wbs64ckR5G5Ya/FNaD66Qv4ceHBF2LAj5edfUH0Tbx5Zc0n1t82EZzKR1oaUmd0GmK9YcrQCPq8DJ7pZnRruTFoUTOJBjuN21LS36diydDZSb4drnzQk089Fn7/wLDoTagRoI7D2b/y7zjQAyT9xDEvNl4HAhFj9Czb2CmZkB5KTjE7BpTC+OBGPpdzFG/Q27JWFWlOzjslPwzhlmxjAQ9pUrXQXbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baLU/8n16ZjbbGjYZ9V333EBUkQ5W1UUAvVlCOa2Jhs=;
 b=vwR3gW7AHzEw2HpIVo0KjECJ9CZrU98Rtzlp53K9Xju6Dyf90q2MHxwH4G1UU1Obr8w9YeLb4rInpnLu2LwlOVO5L3TZNywvB8bb9gnx1DW/QvR94y7337Z9kdBice1UeU0HwOagBrCAIPfwAMz/9R3IVy32Vpjp3SNQO3F3DJs=
Received: from BLAPR05CA0042.namprd05.prod.outlook.com (2603:10b6:208:335::22)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 22:19:28 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::2) by BLAPR05CA0042.outlook.office365.com
 (2603:10b6:208:335::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 22:19:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 22:19:28 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 17:19:27 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>,
	<terry.bowman@amd.com>
Subject: [PATCH 13/15] cxl/pci: Add trace logging for CXL PCIe port RAS errors
Date: Tue, 8 Oct 2024 17:16:55 -0500
Message-ID: <20241008221657.1130181-14-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008221657.1130181-1-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d056cbb-ef32-4b20-31ea-08dce7e7467a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SSCA244ozanzgReeL6O0rNBuh8byD/8n4GSCm+hylyU2I7nGbcuxvGeAYR6N?=
 =?us-ascii?Q?hD9NL0nZ1SSdo8uO5CrHiI+YBx7on5FQHI7eAfRoOTYQhweHLquR8oZRX0zj?=
 =?us-ascii?Q?Z/64Qulfw/yhbW+sETyFtRwxOByKBqkf98yOuWu+kjOT17kj856MdY1g3CUB?=
 =?us-ascii?Q?QSuRI7B61YS8yw0qW2J5vSBVQCJDDmjaX+2gTzslNqQZGThfpJo7vejVSIPD?=
 =?us-ascii?Q?55W8+wlrzXXa1K+fs2u+xY6n2HBHb5UWLakBxrLEvviCmDJ6QBns64EIVvZ5?=
 =?us-ascii?Q?bEjsl3Tlx5byBI4cjr9os86sA3TiOLu8c4c158SNXtdEQVqsE8RchwAZgaKp?=
 =?us-ascii?Q?4CHZIQ4hSgZLRukFUHEOcBsQ4v8J0EJeMI9ErTQemNwG1mH1P06vTHs6RMuu?=
 =?us-ascii?Q?TTGnP9dnFosIH66JgMU5Fjj5ApiNfhErs9IxxZ6/JxeC0Gc/nsG6lw98P0dC?=
 =?us-ascii?Q?oDVg/Tx3g4qOIGhH3q5DqLUktyE0eO39zw1fMoIk6UfMFtvYAIgH505D8Otn?=
 =?us-ascii?Q?9uh1wPBFkUfyxMwQJcScblpV6lyYHlt6BVovk0xS0MkJ6ESzDtx2pkZCOvjl?=
 =?us-ascii?Q?JdDzMiGMYFWmUOfnnS7YfUwGMX0QKwgP8x1918jD+eZEaHiFa6BCciTp1qu6?=
 =?us-ascii?Q?kM3pqGFrqMJF2zie7ZQaH6KgLrJNJC8D3vadmNZFqVv5lx7M4wGzqRhAl3nC?=
 =?us-ascii?Q?KUOYxBt/qmyNh+tbKMCuvM8V5p2LzyCu8hLgq4qLtCynQ8dmJYLY4fpS2zJR?=
 =?us-ascii?Q?MuxFye/Ci+zKh/Em3OCQ9PMgWyet7Cc+bsJQcuVSmhzv/UpdtK8tjunT+Kfg?=
 =?us-ascii?Q?RQJk0ZV/zOjRWJTK/HIBF4qqf/PUOPS+wkeREBYwfHtdIybuWCidUW6q8iup?=
 =?us-ascii?Q?CWm+/wXg1T6/rcgmpAqU0wTRHZAalty2Mr3nuuGOzroQTASA5w6qZxjiBfiq?=
 =?us-ascii?Q?obwldmzU0QiJajO1qhYqnGfYLaVF8E1Gq5eLiSmOrtuJLCjvlpkXLP2w1yWk?=
 =?us-ascii?Q?HZt654DZ7QyH9X5AewE6FlZhfFwBI6pVjL4r8uCDyo7JZnqnfvuQDh/EZ0ed?=
 =?us-ascii?Q?ndu6xGcEE8yu4Mkua2Q//zAlPLpjtk4CTmWIeMZF3XfS/3XfyjIwpnUVDSJ9?=
 =?us-ascii?Q?hSINA+nfAuhBF6gHvxDFiBS3tYH7rve+9zxGGkxyFVD6KklGb+vbGs736pQi?=
 =?us-ascii?Q?pIZQKCJGUthdd5kvzIik7XxH7Bl2/NuXyqB5zZS90D1PSWYw8GNVds73lWRj?=
 =?us-ascii?Q?pfYySzBawTjVPbSngokvaGwNe7wVgAp7U8Ggcopb77b7aJVnu2rVNy5EzyZQ?=
 =?us-ascii?Q?3Q/2BOIrJSYVJcLIWu13pH5bowRCmFaShdjbSPXh/nmpI4QyoLtFtVcOBfJF?=
 =?us-ascii?Q?MxDawJZQinOFS7+ksY6i5QyG5a5w?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:19:28.4861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d056cbb-ef32-4b20-31ea-08dce7e7467a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

The CXL drivers use kernel trace functions for logging endpoint and
RCH downstream port RAS errors. However, similar functionality is
required for CXL root ports, CXL downstream switch ports, and CXL
upstream switch ports.

Introduce trace logging functions for both RAS correctable and
uncorrectable errors specific to CXL PCIe ports. Additionally, update
the PCIe port error handlers to invoke these new trace functions.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c   | 16 ++++++++++----
 drivers/cxl/core/trace.h | 47 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 7e3770f7a955..4706113d2582 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -697,10 +697,14 @@ static void __cxl_handle_cor_ras(struct device *dev,
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
-		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
+		return;
+	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+
+	if (is_cxl_memdev(dev))
 		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
-	}
+	else if (dev_is_pci(dev))
+		trace_cxl_port_aer_correctable_error(dev, status);
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
@@ -756,7 +760,11 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	if (is_cxl_memdev(dev))
+		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	else if (dev_is_pci(dev))
+		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
+
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 9167cfba7f59..6305c0eea627 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -48,6 +48,34 @@
 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
 )
 
+TRACE_EVENT(cxl_port_aer_uncorrectable_error,
+	    TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
+	TP_ARGS(dev, status, fe, hl),
+	TP_STRUCT__entry(
+		__string(devname, dev_name(dev))
+		__string(host, dev_name(dev->parent))
+		__field(u32, status)
+		__field(u32, first_error)
+		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
+	),
+	TP_fast_assign(
+		__assign_str(devname);
+		__assign_str(host);
+		__entry->status = status;
+		__entry->first_error = fe;
+		/*
+		 * Embed the 512B headerlog data for user app retrieval and
+		 * parsing, but no need to print this in the trace buffer.
+		 */
+		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
+	),
+	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
+		  __get_str(devname), __get_str(host),
+		  show_uc_errs(__entry->status),
+		  show_uc_errs(__entry->first_error)
+	)
+);
+
 TRACE_EVENT(cxl_aer_uncorrectable_error,
 	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
 	TP_ARGS(cxlmd, status, fe, hl),
@@ -96,6 +124,25 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
 )
 
+TRACE_EVENT(cxl_port_aer_correctable_error,
+	TP_PROTO(struct device *dev, u32 status),
+	TP_ARGS(dev, status),
+	TP_STRUCT__entry(
+		__string(devname, dev_name(dev))
+		__string(host, dev_name(dev->parent))
+		__field(u32, status)
+	),
+	TP_fast_assign(
+		__assign_str(devname);
+		__assign_str(host);
+		__entry->status = status;
+	),
+	TP_printk("device=%s host=%s status='%s'",
+		  __get_str(devname), __get_str(host),
+		  show_ce_errs(__entry->status)
+	)
+);
+
 TRACE_EVENT(cxl_aer_correctable_error,
 	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
 	TP_ARGS(cxlmd, status),
-- 
2.34.1


