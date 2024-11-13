Return-Path: <linux-pci+bounces-16711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749E39C7DFF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0405C1F23AEB
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332BE18C331;
	Wed, 13 Nov 2024 21:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iTggYuoX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A118C927;
	Wed, 13 Nov 2024 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731535029; cv=fail; b=ju1b6/ywUdi5w3kC86xoFIJuN4XkKR2MZ564q5WeaqBBAoi7uYu6u0PXIVU1+6SVNo7xwqyeraLciRL1FlgG0IcjohhMpuUpTbxQBiFNbfxM5qq4zn90biLyv54bUybwyXZ7Ix8dewj6zDrW38LsGx4Yp3NZnGHCxBcVCECraWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731535029; c=relaxed/simple;
	bh=+m6kTtir2XXq/VNbbTCoKkWIoRizvr5HWsnvON3Av6o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAP+xl09WLZgnetGnLnXVxxH/hqj5pX8Ft4qJcgIrfzBA8I1nA6SyRAN1X1mKEfqcLN25XMOaDq8daWaUm7j1FyNBMe6DPt9rpFH757epjpHnlOk45q3uFHhg2j6i6nxYo5yugT/fYkZj9kB6oIWZENWUHeoxKETQC988P5ehlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iTggYuoX; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+jh43zp7QJByatBt9OxVB2ZVjaHUhHf1l8RN5jJHcSoB3+WtxJrGW586aFL9unBX5JtjRPs0eDSzBJJ7RSoDP9KWwiWBgvBWGOnwYZG93yHFikeJu63R6BHF7QDTeN4T9kMlyyWbSLFVyKZnWaOeBr3MDTEEUxAB3L1N0aTHFABQvp1vnrfoQHZKYxFx+yh0XKNGTazFwZB0gCD2T+u1kJ2c3DqT38IULiQd5qYHdLLYYl1Xr2JmDL6dS3c98VLBLpPu/LZrpnnHD4AEtLgEwuZwmVEVvCxCKPHbbvXEwtfyRRfxZ07KcoxlJli4Mx40fcSxr3IWdXnDC85qszXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Jg6gnvb1wESM6+mlwxy1mOKaCzvLjP3UN3OUzwY90g=;
 b=AHLSmZGHO1qD2dlsqC5NNFuUvAiCeGbM/sHvJQUyKteHnxpDtyhifPk8+10pA8QKgWAWUiUMBCPNW9xAjxXVwJFKY34gvW6RBjOqsdh78V8eeVCwO6WilSP9nlUtbAOGaBfgbA6TJddjV/GIGmpOCR96cfakEraTQniNGDRVcG3VioadMC1MgFZ4VnNDEH/DoqBtfHz3sPQUF9hSbUOrVPaQjfSf8c7rJBb9kIP0IDt25wgKILwquIFUZNdck4Mn6d4fr7BtdSh1wwzGd0PsTqmXtu+5c3Q4mSO0+RYu26jrE5a91zbXj6U2ZUQ0s+SBo3nYUXjL2zGYqs/nWz75HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Jg6gnvb1wESM6+mlwxy1mOKaCzvLjP3UN3OUzwY90g=;
 b=iTggYuoX4g8vLw0ROG95iXVxqn3/ClHHB2psHleu3W2hb+24JiWuDVK+jR5oGP5PcMa8d/CYCTb+I28sy5gQ/+0iXVUieUiAr1GIfXHNlRyierRnaNxkdMcK4ieFijC68Crib92dSZ59lA1CRzktuQszMS0wBox7M8RmzdPNRGY=
Received: from DM6PR03CA0007.namprd03.prod.outlook.com (2603:10b6:5:40::20) by
 MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 21:57:02 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::c9) by DM6PR03CA0007.outlook.office365.com
 (2603:10b6:5:40::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26 via Frontend
 Transport; Wed, 13 Nov 2024 21:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:57:01 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:56:59 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>
Subject: [PATCH v3 13/15] cxl/pci: Add trace logging for CXL PCIe port RAS errors
Date: Wed, 13 Nov 2024 15:54:27 -0600
Message-ID: <20241113215429.3177981-14-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113215429.3177981-1-terry.bowman@amd.com>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|MW6PR12MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b1d399-6852-4da5-bb0b-08dd042e1af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7PIrUc1qoJ2dfgVckHhWtJrwvo1TwjOxnMLPsJ5yNXmmL6VLs+JNtcuh+XUS?=
 =?us-ascii?Q?5H0Ktvu36pR8oOoSTCb49/C5KvQfNJa0hJ7G5fVbwZl+rqjpqpPuwb4ZHxRP?=
 =?us-ascii?Q?Id/G4Cbfgf832VInyLYhxAPgbFuB2QrXHXfMX7hlvEeCGXwIm7JO7Z3txZjT?=
 =?us-ascii?Q?AjwbWLLMUjOfunzJhFJ4gA4xRqBsIXy3eAsjsJK27H/Av5pWV4gOqT5HzVcV?=
 =?us-ascii?Q?Cev0Jk2uHd8PbWW6TIGu/dPHgcmuia/Lg90i9dEjB9YjcB3Y1fAs1/+He2SE?=
 =?us-ascii?Q?cvRXi4l179qa9Cxxuj+o8Lm1Yaf7hIBvD70jzWLYpuyXxB5K3CMf9uqXslvN?=
 =?us-ascii?Q?QwxuT1rZ6vyH4Z1wyAPC11IWQs4U5fBgcU3QszSMVveLCP9T9K379P+sKvMP?=
 =?us-ascii?Q?ZquEo4C2HwYuvkwboLkhnCLAO3XWyqu/KtwgAHNCBUUbhKg6ZUAl4G54G9J9?=
 =?us-ascii?Q?FC0RFuVcC2mAvzvR1zIFcigci9r9fbaXcmWGXc0yTcFJsgZuQO65yZ33sSzg?=
 =?us-ascii?Q?C1OdARA/rTmBNtVlGuaJqhAXeg0MqTZsmMD+lOBor+puMkY6c03O0ky813D8?=
 =?us-ascii?Q?R6Mj8D+QiTM9RxMY2JPDlTJLg3vr2lpZU41CUnWoLF3xSCyB9Md4l2ZpACkq?=
 =?us-ascii?Q?S+6fgY6nJNSm0f/qV1VYjdRNLwLGllZvCIN1cM7XJjH73xdfVFBMVuBhV0bV?=
 =?us-ascii?Q?hodws21tJo+uAimBWwP5uL+z+L05rw4eMUntD9aeKnzjC4/ZAXn/mvE6h/Ut?=
 =?us-ascii?Q?RJWWeyATbHp9SR8xtLdnmOkMLm2HC5pBi2B03x+bzBVmFmbP8TgezN7pxVNy?=
 =?us-ascii?Q?M/Dgg96O+CMcj2yXJ1IfoF6Wgw8JYRo1+1Xm+Pb03weBuO/B+nwYUdhMVi04?=
 =?us-ascii?Q?BTtP5yj761Z5UoJEOC5JKALsvJum842RkGKrlJthx5wzzHpFLFWVEU5nRT0x?=
 =?us-ascii?Q?dbyh6H4XcJuzRirikWc5dI0AyVgQc/csrSPY77uXrkUesWzQ7Y6jzCitlk8n?=
 =?us-ascii?Q?LXY5pN8Oj8VcCJH2aPOr+AbIvcoUPDoeMlvht38sAuNmtz4nA7VBz17iMHOP?=
 =?us-ascii?Q?yWifLto3evhVAZXx/gXs7vHfKSttYgEFsrR2tLosnYH66DWpc4Nt3Z0N1LNN?=
 =?us-ascii?Q?uKt+z2zypK0KiJQFroNzF3lcG0M/O0KacZZOuU8OkxtU+1iWL/mwW8hQemsP?=
 =?us-ascii?Q?XHFz2p4mTI4Cm8gsXnToWwkbWlEbQc+3U1/BZxBFezzLvKbcBxdJXhEUQxWh?=
 =?us-ascii?Q?BkHbek4CFwAZ16hkQazy0Z+KA/we1S2zr9EmCoi9ZeVfSRqCATu4+Bu4XEZ5?=
 =?us-ascii?Q?1ufgONi95fXTv2wlZg/NLcRWZBRR00F2hNNCGxRvXLp+7cgr24An6HHF2yQN?=
 =?us-ascii?Q?tAqGeHEKDya96D9mSe/fZTT9PGYk6xdN4ddl7o4jVyE3rfctBv+z0HyUPRtV?=
 =?us-ascii?Q?3xsRZLURZKo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:57:01.6659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b1d399-6852-4da5-bb0b-08dd042e1af1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7087

The CXL drivers use kernel trace functions for logging endpoint and
RCH downstream port RAS errors. Similar functionality is
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
index 2c5cfc506f74..794a601fdbf9 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -661,10 +661,14 @@ static void __cxl_handle_cor_ras(struct device *dev,
 
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
+	else
+		trace_cxl_port_aer_correctable_error(dev, status);
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
@@ -720,7 +724,11 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	if (is_cxl_memdev(dev))
+		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	else
+		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
+
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 8389a94adb1a..681e415ac8f5 100644
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


