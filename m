Return-Path: <linux-pci+bounces-21005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39953A2D240
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B4E16A2AF
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDF354F81;
	Sat,  8 Feb 2025 00:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tHnxyC/3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F975C603;
	Sat,  8 Feb 2025 00:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974739; cv=fail; b=mx2gKtQvtvAwmuqjqX1xVxGaeHFjQUMSjXUSELBS03yGJUSx5y9P6pcdrUqSPJe+1YH5sHkyF3M/gxPHDFfT8nOWobs8Rym4mjDRXUXJvf6JiSCH4Ajp5WQD3iYIvKSYUrE0J6Wj6vg7qDG2o4Ciu15/SUsSlSyInsd3A7lLgZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974739; c=relaxed/simple;
	bh=Q1Wjo5dPr9dvctdJUYxNPPc6x9KWNjgLxk8CFyjQpTk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqnZsWaqQiK/a8mDRlF7OytKkb+KmgejAoLmUphwkAcDVRP+oii0HYlvvdeFkjrtB1QFraUPa79/QCPYXgdYo91vOI7doo2yOPApOvpuiwf2suM3pFurABoYbcOe0OAGxMz6JiQWOLlAvp3uGmJm4HnGcoG44fBpH8hNCcAmjJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tHnxyC/3; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtahWg/iVCHFU+2e/PqDDkNkps4zuGiQ8e/y4EkM4pyGxoMbctP5C+ggUKBrTSKcS+AuMXu0uWh0VbbTS/Dxv1aLrO9T4FGM3RnLgBV1M7hBh4XDSm/zFNmtLAcPFmjaz6d5CndDdVR42fv6O8N2GvlyZ9AIHZUxsXW/tA5Pv4ogiqX12WeyylNohgOUnfReCJoDk+bjCebFy2yYkoyyHuXk6pXe75pmhRjsFAqvDEuzmMq/5tuA3M2l7LxuS1UeeVRFckVqcpUjpJo4wOYyqUqSRxr8RjCOeAh4peEpLpQXZXryjvrXOHATsJqWQ+jINo/2W26K7lN2UOyI2OC2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUR+oXs23TiScd51iU9BzfEOEUcWIbpuD7GW0pCosAs=;
 b=uldpIvSUA/hTd76QPVBXxu6xc2mOyLzzZ3XEUH3dF+Zm6vLFOKaLQ2yfRMlnjqUZ0tvqiMc+kL4ZjSjm3QSWpiK8b4Xk3ZzzDCcKvXcSRtGAIiEn2l2IoE59DwrJszm7/lLI+InXudtJiNN5+ioi4JpFyrNld7qAtA7xhAURahpo1hQmGURQOGnxwl99UCn/L4M2cwQ3lp/xswdSx2uIiIL3aY25dDQoaSj92VP8cqWldrYhuFejYec4v9qeilsGMAobhsru2wX3ZCHSQQwG2/WoMNH5g6o7IudjUdN0ZDeJG3T1tJViV7pNeFyp/QECIxV7zPR/drikRvmwBns7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUR+oXs23TiScd51iU9BzfEOEUcWIbpuD7GW0pCosAs=;
 b=tHnxyC/3cPsY1XoABK+LBCtlCtOveXtjwndb9i4WEMBk1+lwoxySQar/Pq61i7gUN2PVu1oBCmWQLFIF3TZmol9u2L+4MazVyDCtkMJbrUIzl1Cue6bXVq9uu2neGjXI9V5/hsUJv0z+v3UB3ArRQIeOV+qVcfWbIzhH/tyRe+4=
Received: from MW4PR04CA0350.namprd04.prod.outlook.com (2603:10b6:303:8a::25)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Sat, 8 Feb
 2025 00:32:14 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::6a) by MW4PR04CA0350.outlook.office365.com
 (2603:10b6:303:8a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Sat,
 8 Feb 2025 00:32:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:32:13 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:32:12 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v6 13/17] cxl/pci: Add trace logging for CXL PCIe Port RAS errors
Date: Fri, 7 Feb 2025 18:29:37 -0600
Message-ID: <20250208002941.4135321-14-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208002941.4135321-1-terry.bowman@amd.com>
References: <20250208002941.4135321-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|SN7PR12MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e3c8c1-1ee8-47ac-92f4-08dd47d80885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wV92ppfL0g8owknUls/nklwoIk3E7qdxAaqDr4BxB4VTYILAo+P54aLogc6m?=
 =?us-ascii?Q?rq4aePOui3y/bMSXXpYHBZACaQnZH/xKz09YnmOCo+EWUzTBDgsutqtXI2Za?=
 =?us-ascii?Q?jjyT6ieUYRftaF5lMMHdF+UAqZ0QBT1DkLeIyahqAWyilPKIXqETyEs4vpAA?=
 =?us-ascii?Q?0ZhYv3NHhYnHbleAgUNCG35+397kajUTrO6pfoNexH2g0v0IFdGsILAW3nsU?=
 =?us-ascii?Q?z8wDLZFfFHoR5SeYeZlSKDdCGvvxdj90tcdpjTcmJkYASDCWCFUIjYxrCnl8?=
 =?us-ascii?Q?qvkZCvMLYYmHpq3OFPcKLsquw2pTYe2RS1wFoCNHZWg4QBzdercLzINXuqDb?=
 =?us-ascii?Q?E48LRQrVrcJevPR++fdqPOnxFwIAabFXkaUHHz4Eb/Cnh7HKwbGEvz88TY1b?=
 =?us-ascii?Q?obqUGeSMl6uk4xAS5Pj8a1Gvwz8+EHdb32e7e2iAKYO0Yv7d9FfYhmMWELYy?=
 =?us-ascii?Q?LYXZ1gQuayotINcQo/66XqFbeKlVmeZ2ctz+3fGdn4uKHNH+1+i2LlTm1RSn?=
 =?us-ascii?Q?Zcv8FfyLT+5QYXgw5nf605P4AiUH9bvX3E3d/pdI4WH4olrdUtEJ16WNS0kf?=
 =?us-ascii?Q?lQvN1p7KZNPxkO0klI/Y5IZ5Lr0sy3DR0wD1zSXnh5xoHT63n2D5ms60RfM6?=
 =?us-ascii?Q?AGwYPyZVeYrmBN0jnlK2Shz9yoGTokqTDsY09hfIihyNFXc+LknKi/bybGl8?=
 =?us-ascii?Q?3pHbWM6QegtULnlE9/tM5gzTNU6iUjXh7kEQ61jwQveG7Najc/YcsCZDvPW6?=
 =?us-ascii?Q?NgEg7e+ccuU2cqXNqtti6HZXwT5D5MnNdvUWqvPXA2r4gUFGqhYwWgqpU3He?=
 =?us-ascii?Q?stS/QMq6JUa7R1wPPVhTUCLD5tPO85YiqaCxXFCkBObgqIdrCrFvGP1emKVK?=
 =?us-ascii?Q?v/USMBG1u+3RqFguNZA7/U6Z/QIYWhMKKUxgDMOm8Ej6NQwjy/UoWPuhB19E?=
 =?us-ascii?Q?gvzZADsWIbTA63D5KoxMi8uxjVOsPtuIgUEa0IwmnJZKfanfP/23qDLr1K3b?=
 =?us-ascii?Q?ZYi/Xc+cE7OSb6SL49YspLHlZDcgs04ovbZZmO8blF39CaDIyhObNo0AFSRw?=
 =?us-ascii?Q?GO1ZKwUs8QkTBndV7o+1Wm+mB+AKPsaOFJrlQmw9xl9d5G/x0PdKz5k/GUEF?=
 =?us-ascii?Q?CJ0tz+bZ9AgkYc5bk3YBwi4n+10OsT3aSNMBYM9GLS8ajlL2/TlolD7nZIW6?=
 =?us-ascii?Q?u1egc4Age0/PqAJYBvlLNtEB3iAPCanRSPqo1N8ZBEddn3Esty2i4UrkE5ca?=
 =?us-ascii?Q?Iy5nMQiXydI+N+RYe4kai/RnJcO6LA9sCrui4Tbcx2HNpmU0SNAn/stSSuSP?=
 =?us-ascii?Q?mhlROSsyA9NmbcuuechiPQQjjoRUvK8o5c+rChlT/hLpyeF2dP3BY+E8J9DH?=
 =?us-ascii?Q?wBTLx055aXdJuyOILB7JpsU94dsObA6VRCRF0MX9AWWjySIO9dE5QaUGB24H?=
 =?us-ascii?Q?xuxf2cIO9yidAwB51RmAgwYS/9okMFpSz9oLN/PKrjaD0GN4vTgvGV+2Mn+0?=
 =?us-ascii?Q?ZZuts7xbevH0sTiH2sEoe7wqRMjZkpifjxmj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:32:13.6395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e3c8c1-1ee8-47ac-92f4-08dd47d80885
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106

The CXL drivers use kernel trace functions for logging Endpoint and
Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
Upstream Switch Ports.

Introduce trace logging functions for both RAS correctable and
uncorrectable errors specific to CXL PCIe Ports. Additionally, update
the CXL Port Protocol Error handlers to invoke these new trace functions.

Examples of the output from these changes is below.

Correctable error:
cxl_port_aer_correctable_error: device=port1 parent=root0 status='Received Error From Physical Layer'

Uncorrectable error:
cxl_port_aer_uncorrectable_error: device=port1 parent=root0 status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Erro'

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c   |  6 ++++-
 drivers/cxl/core/trace.h | 47 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 4ebc4a344242..61e6d33d2270 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -730,7 +730,11 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_b
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	if (is_cxl_memdev(dev))
+		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	else if (is_cxl_port(dev))
+		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
+
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return PCI_ERS_RESULT_PANIC;
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index cea706b683b5..b536233ac210 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -48,6 +48,34 @@
 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
 )
 
+TRACE_EVENT(cxl_port_aer_uncorrectable_error,
+	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
+	TP_ARGS(dev, status, fe, hl),
+	TP_STRUCT__entry(
+		__string(devname, dev_name(dev))
+		__string(parent, dev_name(dev->parent))
+		__field(u32, status)
+		__field(u32, first_error)
+		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
+	),
+	TP_fast_assign(
+		__assign_str(devname);
+		__assign_str(parent);
+		__entry->status = status;
+		__entry->first_error = fe;
+		/*
+		 * Embed the 512B headerlog data for user app retrieval and
+		 * parsing, but no need to print this in the trace buffer.
+		 */
+		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
+	),
+	TP_printk("device=%s parent=%s status: '%s' first_error: '%s'",
+		__get_str(devname), __get_str(parent),
+		show_uc_errs(__entry->status),
+		show_uc_errs(__entry->first_error)
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
+		__string(parent, dev_name(dev->parent))
+		__field(u32, status)
+	),
+	TP_fast_assign(
+		__assign_str(devname);
+		__assign_str(parent);
+		__entry->status = status;
+	),
+	TP_printk("device=%s parent=%s status='%s'",
+		__get_str(devname), __get_str(parent),
+		show_ce_errs(__entry->status)
+	)
+);
+
 TRACE_EVENT(cxl_aer_correctable_error,
 	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
 	TP_ARGS(cxlmd, status),
-- 
2.34.1


