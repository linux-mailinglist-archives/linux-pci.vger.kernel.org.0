Return-Path: <linux-pci+bounces-18205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED1D9EDC28
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4BA282E01
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C9A1F37D8;
	Wed, 11 Dec 2024 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IGAtuHMy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631061F37B0;
	Wed, 11 Dec 2024 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960558; cv=fail; b=OX9GZrJWXnSB3u+eYMfuWA8AzFaoA5u5KvidIZ1/JyVrP08VZw3tMdiv/8cE05AbdHhmdhXvIuPwj5m43sC6FBKvplnGHE+zFxp9escF7rRNB4B2oFmgyWEqlzARk9ASN+oqIMPmWBAZbaF2DN+pJerxgXGM31hTK5KBgzAe/Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960558; c=relaxed/simple;
	bh=6QBwewHPT/LO0YJSqUxQOiFF8nN18qldRJ7wbyyNUOE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REI5LepiP6vzx2Ku06FVsySDmp4URk7bjXrtV2/saCl5Ae3yYbEwYYfLWEoRmoxQvvThHByOSEkKCmB+RGR7NxZlVpqTIGmTeBcFkA8c1Jz/6h/38j/P9304WKFk8mdtyH3nuu30EDt2DCp55IietHUhDYqtFOUyJyt0qLP/hVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IGAtuHMy; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/gMVEDRkWFP4oRYAS2ysC3VbysRyXDT8cYb0ITAWksJiINsbnkEx9ZqbnLPhomiV9cJxis7ec/9QHE2DuKnGlvSutQMn82f6zLwqnyI2jFn58UhwFzFpqT0Fjt/0zjt1Aiqs8XmbdeO8f8j9+uvxlj3FKMML1T073oV8VqeSm0WZ/XEsYqwT6rPQP/MyjNNrnrzPFhyr2GVR7i75aSM4whZlioZNDh2vnlECSnQRfKtQlcs8dpmecegiTc9yPMi6PinPl65G5Ql2nKeflOaJCNx4Ajk4BFwVfK5n5tFl1JQI91XTENhZ7meX7oxPLDsiHK/BF2IapXLCyXXh3MbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVa8s1ecQnT3J5D9RiAA476+5RaYmlod9XFoAbNtajE=;
 b=PM6n1DDGKvwx3C7dmsHeyhIqqsxFXO/cU+1OuaYZIWIN4g93q5Hyp0hHrRrNSXph1aQoF4vGuZ4HVg/FqIzo9Eem5ButBXxI6ezoK2iFHXxLL1ziDVvhkvlQ5HXAHN1mt8fSDAyDCo7Pmo6tZraEaNQrpXGZ774cyZndiLt7gkWe9/o54SbfjUIw5F8lgp4HJ8Tegw2Q8NT86pD+PPsXHipQHbvpSPg2l0rxzYlVoYa51Cd15NQm2kf4LYNEsN/CHYi58nprHYNHreWfsDwPWOxEyH+3G18X6cxfz5AGNpeLJmEa/y8KsmZc05qaKRZ7ZHrkY+GvzBztcyTXYZgyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVa8s1ecQnT3J5D9RiAA476+5RaYmlod9XFoAbNtajE=;
 b=IGAtuHMyTbuklJOr1r3JrfSkzKGiJmf6iwlqZjsSqFCVpPJre6QVEqBhj2wvORdyPznyC3d0wKjZMlIV9ceVWn61RKDfE1INIIsFRXsK3Y8jKBrMdWhzqAGaQijbnYxpcSf6uNbGNDQgYIHEk5M4N+YKFgK5KDHjhFKC4wUQ04k=
Received: from BLAP220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::33)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Wed, 11 Dec
 2024 23:42:32 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::d7) by BLAP220CA0028.outlook.office365.com
 (2603:10b6:208:32c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Wed,
 11 Dec 2024 23:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:42:32 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:42:31 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v4 13/15] cxl/pci: Add trace logging for CXL PCIe Port RAS errors
Date: Wed, 11 Dec 2024 17:40:00 -0600
Message-ID: <20241211234002.3728674-14-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211234002.3728674-1-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5a068c-d4e4-44cc-0a41-08dd1a3d7bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nZBo81der8kZ28DGlshNfN0iP3Jve6iyMTh/cLSs5wXbfQG2qFMtXedJOFkE?=
 =?us-ascii?Q?bs2XSnIjPVJtPokYK44YaD9ULBp4bfZXZ2JCwRJ3t1xXUOeXqMHhqrgFXOp2?=
 =?us-ascii?Q?PFl7rlvSe0HD91Bd3cUe+gwlQeYsm3ffdeqve5fZIJwTNe/OqdpePOqRsGbg?=
 =?us-ascii?Q?VHTKxlhsqrA9TxPCmPyhv4ydW7MlD4Y+6IrjQzzJavmKDEDMUGpnngxeTHXC?=
 =?us-ascii?Q?pomE4PDUj1gG3xrmrpJhEoOpoXYRUiqNOz9amaXefhQTVDN2TQ4yqe83oGwn?=
 =?us-ascii?Q?UVNjKEtMlfhKhb2mobpu+o7C3Nk2CIJ8GACa7gd0t9sqFl/3HgZzkDmcKD0K?=
 =?us-ascii?Q?6rCCQbUlsivlzSiFO72Dv59ITPPu6tgQicE8ewPlMCW8PfvCoHsScXmJuqoK?=
 =?us-ascii?Q?iyysKS7J2A+KArgiuwnMp5FaBq6qWCJYfrEYTbdwCnAYGPCrUzHlnRETNU3M?=
 =?us-ascii?Q?ttZVYWKOgbqUoOEiFE54mdrUDwbHLySUZonMKsZid0sdElsRdu7/8oDHjUkp?=
 =?us-ascii?Q?wHUf+C/YCJaeS21lP376lYTjneHFN7MRfVWxm0rq7neegCMw6A9+rD4g71OX?=
 =?us-ascii?Q?NNcabZ9cbbwaMyEnk901LM5V0q8VY7tlvuMG7wwvWuIODG7zFzXAXJkwkHxY?=
 =?us-ascii?Q?BTAKavqguabmnIp5VDe8UkdmLXvChhnvk+oalOIVg8VnqXIoX4Gyu+to9YWA?=
 =?us-ascii?Q?oktih2Gc+C+3XRqqbHLIdfASotCMnrjLjUVOT3UfkWHEdwId7cNt9qNycXgd?=
 =?us-ascii?Q?e69oQf+Q9c+XWoX9BZE4EI09bFdetLN6dNcrVIO5w+0Av+KybdcuFlkw2yyy?=
 =?us-ascii?Q?+uV5J7VJrgud35Bh2wZhOdo/YqxGJKJE/tJXCCcZ4SZN88NOc4kzaOKYRWwN?=
 =?us-ascii?Q?bJU/y6pObubddehWYei+sL7OECwI4i58g+riN2TOyKd0i+GGSsj9iH/LjFkL?=
 =?us-ascii?Q?9qJcxZ+P6ZPHrafmSlYcM5vuBTtT4Kvksw7jojlI/2SYFfCi8bfRn1AFuXM4?=
 =?us-ascii?Q?0e0iMTDXP16s3Nt8JHlN4mJKf3eSKZu8HQIvRqTDlRzUBstUPYzg4Wa8jCvu?=
 =?us-ascii?Q?cDwdQVQ9yxZxUeG34jj9e/hnYTadPPFHMwN+75YzcgeRYFISDz8FOtD+CPeM?=
 =?us-ascii?Q?le1/gDOT3Ekc3c2PCR8JHyLbNEpv4DN8U9DNAq3Qs9YN4BHUwaXHCoiQX/Y/?=
 =?us-ascii?Q?R1PdBov+Tx7AaB5UaA22qgb6FHyBATQM7MSHerr9klNg/Xd9ddy8UIjl+T7h?=
 =?us-ascii?Q?iu8trjbdrfkGkzRIlq8O1JNZoQpBo/c4GJ7/slZuM9m6E5fBcNNr7swDIrAx?=
 =?us-ascii?Q?FqrMIcifXaG90zVG+RJNQn2x9imGTL8DDtmmupDPiTUiWPDz7Lzq9Iz5poJ3?=
 =?us-ascii?Q?8wIc3o/MxSe6PLr+Gl1BuhZoDj1lcWtvDhc1adpnaG7dQbnqNeNfoYkgfejE?=
 =?us-ascii?Q?LemRg0TQc5RsH/fNwC8rzVZo510VPh9a27Xd8zOacf6wNgzj25Irww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:42:32.6577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5a068c-d4e4-44cc-0a41-08dd1a3d7bb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104

The CXL drivers use kernel trace functions for logging endpoint and RCH
Downstream Port RAS errors. Similar functionality is required for CXL Root
Ports, CXL Downstream Switch Ports, and CXL Upstream Switch Ports.

Introduce trace logging functions for both RAS correctable and
uncorrectable errors specific to CXL PCIe Ports. Additionally, update
the PCIe Port error handlers to invoke these new trace functions.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c   | 16 ++++++++++----
 drivers/cxl/core/trace.h | 47 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 52afaedf5171..3294ad5ff28f 100644
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


