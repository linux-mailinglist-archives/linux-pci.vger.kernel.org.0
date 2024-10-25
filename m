Return-Path: <linux-pci+bounces-15365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EED99B1170
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17D61C2204C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3FA20EA3A;
	Fri, 25 Oct 2024 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D3d8+qv/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A299B1B6CFE;
	Fri, 25 Oct 2024 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890343; cv=fail; b=m6Nrkl1sZBSW8mTsEaGBFnDCTyFKU5hx92+S370kWeb830tHvbQ50pq/Lc8MmGefuw0IHnE1VNYSEmcg6kFrblkYTAgBAQ2Cw6j833HQVY0rfO7o1YKznuRYNw/J1FMrret8WPzb7CrL3aKXcFhRqXZ4FI9jn8H332v8VXxibGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890343; c=relaxed/simple;
	bh=ejHoeT7Co2D/GMslgPzDJtkpzy8wQ7503exX6ezmgFE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chnqHXMWoBAUlNid1JoKig2CQq3Clgs6qd1Cr6Ki2evW/4t1yMUqAO6Fh0uc7Smjwb5sZ/HCVSofoJ2i6ShzL8RcKvcOsajTNGkGZ1+uAd+huRMTDSTIpVTtoRVuM8qo72SWpCzH70khj1Oou9xfjbprLThu8dgAuWcyDP2Out4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D3d8+qv/; arc=fail smtp.client-ip=40.107.96.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJyAHMvNAJ5DcUEfq3IIMv7AzPDtzIQP7fgK92W3oYrhYhmzrtlziZS0nJNaldcaVrxLWTbKJ2mrLjKPLsX4raj6cQDUMRFe9YTA6AL0bieMhc43Zuea0NMVqiB1JKIOmuWGKc/uHeQSvF9N+DHOHHqTLJZta2uu0iulmokjWIEPIZD/3cbX1HySsth21KPu43oDM20rTSYc4Bh19eIloOOEv5G9fySOAMBS4lBZh8so5xD2O/zI1BGnpWElbJtwC2bOfxcXk/jWWrak96Uf1tH44leVOoMV24II5SZioamsN6FI+bkhlI9l/DTc7p4cLv3m5TkUDTJ7IDm0IRbGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UEomUt7HvgMyZTWsAD3mhbMMWljS13GXBCiD8enWxw=;
 b=erkBmtZzywjSCTLfqdj/ihYswf7vawdR1gJidR8pOyEiPpotNloILZC3zcULv5MYPhxpvf3CaOrE7prQYusX1wmZ28zBf8+pZY6+64WseKr9nhkLPENJTEBOvOGKUBK9mgdzzL6gO0rR3xsew4UJwrygKZ6myYiN3lJTo2J1+8JiZRJ6XX77R5kwEVCRC3jOxB46DqEe4QVjVPi9XL0KudvhCSK1tYaSIB6FCUUxIU4pIHUlvkrjjsIYZpuMi0vstrGKk2QOs1Vt7FwrjZ+aBjDlNuyONZXYIbk5JxxeAXxdnzfzlUrUabOsPoWmvG3gNY7Errdo53AdX5wJOdMkGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UEomUt7HvgMyZTWsAD3mhbMMWljS13GXBCiD8enWxw=;
 b=D3d8+qv/UGWQPg0kxfShc58pCmG5Fya3YLG1fKE3ufomqHF3+L2isMms1gcaqJs9nB2bKx1uhrs+jdAsBD+bnAC4JCyMfxakiEDTrprPG/xTuJLrTVRzj11QFWoAdwLxE/oaqYhnPyTWk4msO5cp2JdSiC/Hax3rl1H9vkOB6XM=
Received: from MW4PR04CA0244.namprd04.prod.outlook.com (2603:10b6:303:88::9)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 21:05:38 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::a0) by MW4PR04CA0244.outlook.office365.com
 (2603:10b6:303:88::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 21:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Fri, 25 Oct 2024 21:05:37 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 16:05:33 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 13/14] cxl/pci: Add trace logging for CXL PCIe port RAS errors
Date: Fri, 25 Oct 2024 16:03:04 -0500
Message-ID: <20241025210305.27499-14-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025210305.27499-1-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 970caabe-ae17-4867-221e-08dcf538c689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pKurUUr4sDHAZfx1OePYXHAwZDoEPQWqipKuz6LPTXh8yJcYEJJIn0h8weay?=
 =?us-ascii?Q?6EsM81Uo/QfDSBfJfKsuTnvZxLAFzp8vyq0NSs7K/72a+biIVPkpFdTIy9bt?=
 =?us-ascii?Q?IBB3y8vfZzJFdQimG5iMMMcG3BqcnWltRfygR+qUINUQX+KtSvUfYl4f8qkk?=
 =?us-ascii?Q?8shXQTZQOKmK/UhpwPXHasEJjQaZOrFZCUWyuLKFJaegcN3vfFpLbxhbrAdF?=
 =?us-ascii?Q?2I2qdIqXnt8iECwsQ8lAHDDeyItFv8ovY7phUCzrKYs2hhE8g5Hmiq6IIPyq?=
 =?us-ascii?Q?B9K21GhHE/mEUK6MXj82xJr4vJUUw+ER/KgE3tYCLTsCRiCMmX9gMGz3Iaim?=
 =?us-ascii?Q?HE/Fxw4GMtpehkhLwfm6cUt7j9Ehum9qlgD9mFV4kEs0H9oBdYGS/4k1L/jh?=
 =?us-ascii?Q?sFJVl4jdNswjuAwbUfmu0IuMn4u/+fPPtU9WhoXwOgdMEOHRBc0jrzzAhKsN?=
 =?us-ascii?Q?3d0xdVFDVaAb0vomdm/PfrAOTXXKhrSWZ51tnbJnRjRY1ok/+NjrABjBDdHC?=
 =?us-ascii?Q?ot8clUP7eLhwgWD0sYN5+oyZYp/krxCFptZVs/t8VomVPC3YWTBuyrd0Fzy8?=
 =?us-ascii?Q?OsRr5GgvS3rHqxCCKV8qJeWC4qh7v3b0UEA5yc1qkoNmGuejFozjzwuuWbG7?=
 =?us-ascii?Q?vOZK48IimYhQVN///2ODv8b2+kd3hbVH8IT+F277tA6nHlnUQJqqN9R6Tt7J?=
 =?us-ascii?Q?C9LMRJbtZLqURstztuJZZK7k8QSHBgwDeHGGoSqqrMBmZ3HWBSnsO97dpSeS?=
 =?us-ascii?Q?aaPHngTSwxPLrVU4WrB5PpqPzRwIxe+MluSjHnNWlTj/K0S0Uv5tVie34bY/?=
 =?us-ascii?Q?X0mGx5yThxafVUGbk4kDSFHH2YVuy0mD56jS9gb/I5tL37uxF3VVNwgQ5jim?=
 =?us-ascii?Q?lGPHYrMFEsAsm7PyjzavTeFFFAObKJhYLteg4S4BAnxbD6DpBxH71tWX1s09?=
 =?us-ascii?Q?n3h99CAcuMru7ml++gd2TEsbgNBrprjKwe1lfBt+OddubuGTb1rKRuyCHwWm?=
 =?us-ascii?Q?RbLxdNsjamnvseW7ddeQARAvK3wVILea3LLME6XkwLJ3PhbXkMCvZI4hu7RY?=
 =?us-ascii?Q?aKUi9IerDnofULndDRTCSM6enQQgqxTLkxQxeZtJ/ewqSuJXRF5I8kPylJNS?=
 =?us-ascii?Q?MrjMXSV7GQR2FQHhug5SdlCzyZi6KxsSVAEHIGZ2ZOYnTE+/y7tddx1BQKxt?=
 =?us-ascii?Q?/uIGHpatcaXEboIP6gRzfiQthDz1SvCCeqHdqjguVjHjdtglatAbq7HKJ/Dd?=
 =?us-ascii?Q?VMks8ZLJC1Ja77bIu4zYsdnt1RzXYjEdwWW7DgVBxUkxpBiPJRVztNPdb//z?=
 =?us-ascii?Q?kZ+y4NeeXqKkQ4DTuWfkuNfrjySGrW19+TuOMkUzFm1yrOPY7WSCK1NMcREn?=
 =?us-ascii?Q?cOG5onJdShMiFM/HT7GK0ddCIqw+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:05:37.5742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 970caabe-ae17-4867-221e-08dcf538c689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039

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
index adb184d346ae..eeb4a64ba5b5 100644
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
+	else if (dev_is_pci(dev))
+		trace_cxl_port_aer_correctable_error(dev, status);
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
@@ -720,7 +724,11 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
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
index 8672b42ee4d1..1c4368a7b50b 100644
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


