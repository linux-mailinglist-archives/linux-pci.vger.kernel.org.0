Return-Path: <linux-pci+bounces-21204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0568CA31566
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A9F3A62B7
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066BF26B2AE;
	Tue, 11 Feb 2025 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YMYzEUEw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8C826B2A3;
	Tue, 11 Feb 2025 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302044; cv=fail; b=HW3K0rDORYfAHNXH3YPDhVzNmu1XrTY2+kkUMNzjgyaCMFOTXLy001if7oe76mzgpjJSezx/Yuqc/N0GtWV7rp3kmSXFSb9qTCVWcvKSq8C/pmYbPOFIfZjZ4C2NPxWukiMA0bn3Me0xkwvsZNh63b/sndoSSJD3wi8Qwt6f6QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302044; c=relaxed/simple;
	bh=1VdHonycBVBgnwpsadSJeE2rR1DTDUI2DNmljidRqRA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUr+3ZDh69gj+vUkpQR+DewJdc/Ul0aER/IEr0Ozyr3mdqsgdohxXpog8M9NxSfVvPi1KpZfVAgMBmiudhNijSAWWu52ZvR+mGyeu2MY8JHLauSMa5EJpGJsycXOeSqrjJa4BqgMY34Ix25rV61/3a8kmBQlGp8USe0gTO/okJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YMYzEUEw; arc=fail smtp.client-ip=40.107.96.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYYz/K/Dq5zBXyOzrfFNI8vh/2OU9Qg6+Wl0GUBSi0CoP8cL5bYxWs8qcgYQUmWX//NMOXMc9aq5dPRrVcv3uwxsTOcJXqqxZ926Mu/grbW8HeFaTu7M1YS7ZmLZRYgnn9ZtkvMKC8snu9AHHf5/GiId1dB9ppvuINH/hkScLfRdi9L0adwt63Et9OibHjj5nPFJYLVdcheeS6VZvyAiNQLcBNpxA/TPk3XWXW886xAWjlOEARXqwcYLBoA8g9O8mXcdJZfCztEBRWbNfD3dUAs2ZMyesCQyf9YAAltG70Y8AWo5cN6W4dCuGxAEqtM4lvCcnAjXjggCq1gO1AfMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBN+fSlH/h7XgMUgll0yOoa293Ui81yD2w7U2wjL1YU=;
 b=san7G1g5zL8RX69sgZpe8D2zuwFPdXEJyvAWLtUNMVeWAvk4jW0vurw3GUyz/vFAkiwYePfrXZDC36FR77HsR0tZdZS0zWF8PB84QjSKT5fzktukh3w0SFKWYXn/t6vi1tyEZrs5+cW80Q1RzD26WM4U2NirMzmzlczCGxylbeVkLlkEv+3d2vigZIwlk/a/tMH7udEViZw/7K+3DN6N96gH+IWqAjlqrtgobTfQturfAp/hxUufUMa5o4PMEVKDarx1ei5NXP4/AsI+2iau1vGE3coJShlmgrwS1VeEZbKVQHeOz6cVMUY1lo0pxFl9QzEKXgwpl6SZGPmjvavq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBN+fSlH/h7XgMUgll0yOoa293Ui81yD2w7U2wjL1YU=;
 b=YMYzEUEwejc0yCajAUztVCwAgNkSg4MrS8QOvbEVM4rQ0sJfzX/g4o35uxKJTFntZFXYRIqpU/n+dFj1elhPJUGM6fgw61t/szBCFdwkwSszMcOT4wlSWZBkH2qp4ktEsDbd3uEmjoUMTD3AwUUZaHQIKHSeHKlQfdT07QLvlX4=
Received: from SJ0PR13CA0224.namprd13.prod.outlook.com (2603:10b6:a03:2c1::19)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 19:27:16 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::f2) by SJ0PR13CA0224.outlook.office365.com
 (2603:10b6:a03:2c1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 11 Feb 2025 19:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:27:16 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:27:14 -0600
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
Subject: [PATCH v7 13/17] cxl/pci: Add trace logging for CXL PCIe Port RAS errors
Date: Tue, 11 Feb 2025 13:24:40 -0600
Message-ID: <20250211192444.2292833-14-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211192444.2292833-1-terry.bowman@amd.com>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: f5311cac-70d8-4ed6-3d26-08dd4ad21842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Nu6VuNyHESmo+HMRgfdHEXGJvejAgQhlG+mptlpFufQ/Kv5SxUasxefc44i?=
 =?us-ascii?Q?6ZEBHxhhZ6z0/RKdrcb+6gnPQdRBFfJ/aYQongkxe0zagVfKLzVG2qyDeGU1?=
 =?us-ascii?Q?3O2d8glnvUX4ymp41cLgSnE+oz9nZwH+t5/A7PceFqItvcpqpT3ptoOiNXme?=
 =?us-ascii?Q?jgDVj1h2HMSku/aNskRa2C4f1BRVjCJrm+46zI7XCjF+MX2pr5NPjitml7Xz?=
 =?us-ascii?Q?ux/Wno283Nh7H1ajkI6ySena3TiTc8eFQ3vYp3KGTWpsLHTsi5wXUPEl6vZ4?=
 =?us-ascii?Q?DUZPpYm4P1qbY13ILIfsjdgPCLQQQinPJD15jQnrkjz18+PKbymVy6mRs2uf?=
 =?us-ascii?Q?VlfHET+QmhYAalMU6E8J10oEJED6CdzXomFBllo3xQmM9m3Pyha2PsfpDQ8g?=
 =?us-ascii?Q?Myv/Te1TRvf/WFbqaEdv/zSpQP2mYAXx61GpF5Wp7MTWqxKs0dkNn8aV3vBN?=
 =?us-ascii?Q?RzFbMG8chnSLQm6ha09PGwIEdbKi0oKcR40ewbvQcxqcJa+y6LyXg7bnN14l?=
 =?us-ascii?Q?pItovnl8PPdy0QeBsbpDypQkUhdOaLCMVt8JSoTlq5tJfKNWB7/WIdcmqwh3?=
 =?us-ascii?Q?Frz3MgiT+p3WPh9fASQRgfwLRGmyy2Aa1ac7w26TOPmhlWPAWtimyJXkSoHB?=
 =?us-ascii?Q?qsZ1LDfjr/BdWxdL4KPRE8293G5FbkydNMAW9qM6D6IUgmT7+p77vI/6Ro6+?=
 =?us-ascii?Q?t/l/J2YuwxVyFHMOnIasVID1mZTFQUjbKTlXLMoFDbUQB6vkA7go412RM1fi?=
 =?us-ascii?Q?2HNfo1Vptr2o/asyCMItz7AAeYysvEXqwO5gBPcz3cdxhGPvPJzxNMN3v0aZ?=
 =?us-ascii?Q?K+p3CvDDBALwSZ+GOOm8fMUOMJzXcnmVHrO3bBsN+qs+E7DklheNyxdVwgGO?=
 =?us-ascii?Q?8TOZRJQZwLOibDYB+i0rgJjliaQJxDVkh0aqUuGmHZCO+imYPluTdW1HbLuU?=
 =?us-ascii?Q?NNoFAl2fqd26dDCML3WLejltroIXXSUWrmSsfV900/3tXzgSRjGcI9e77qFB?=
 =?us-ascii?Q?jMdD3Y0IfXKOJxxEtQixSqduPCFD0B2YKUTi3NFC6yUJeH9agwNrIzNBElFe?=
 =?us-ascii?Q?2uOIqpSz6yKqBPhZak0xiffa+wUh8mVp4QizI1CZ8XBK6RI4OPFtaih+NS1S?=
 =?us-ascii?Q?xSjGnOoanuf76yhOgL0G9BWDHLNjCgXe/wIWsPjBfRK49zerzSq4hsyTa3LF?=
 =?us-ascii?Q?iQ1rFB+kC9gxnoPC6Z0ynmNHyYU/SBJOTkJxyKsQQKIiZotnK5SV+7+fOrcY?=
 =?us-ascii?Q?lJAwnE+eQhYStPrfyA3qvUx2Xx2CahZ/OOPLo0/FLJ98ECy96eOxD/Ix072o?=
 =?us-ascii?Q?EM8Lp/7xCWL2gy0VNF+V25+tiqWs4vA7nqNy00GU4Xyut3mSu5OIRsB3rlJl?=
 =?us-ascii?Q?/GQuBVg2mkTRRV8fOA6w6hbdAAUmQqDCAw9B3k7vItV8zZkflK5ElwSGNRsC?=
 =?us-ascii?Q?V6XgKnSanEeb2KCfBUSmGvZjKmfnVAAvyUHKUBoLUzM+E+UV/pV9i77P6Yex?=
 =?us-ascii?Q?/+e6Qm5SDHs+tdk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:27:16.5653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5311cac-70d8-4ed6-3d26-08dd4ad21842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252

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
 drivers/cxl/core/pci.c   |  4 ++++
 drivers/cxl/core/trace.h | 47 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3f13d9dfb610..9a3090dae46a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -671,6 +671,8 @@ static void __cxl_handle_cor_ras(struct device *dev,
 
 	if (is_cxl_memdev(dev))
 		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
+	else if (is_cxl_port(dev))
+		trace_cxl_port_aer_correctable_error(dev, status);
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
@@ -730,6 +732,8 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_b
 	header_log_copy(ras_base, hl);
 	if (is_cxl_memdev(dev))
 		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	else if (is_cxl_port(dev))
+		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
 
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
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


