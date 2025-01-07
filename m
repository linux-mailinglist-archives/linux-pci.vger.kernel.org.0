Return-Path: <linux-pci+bounces-19439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEBDA042EA
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBEF3A1D9E
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94611F2378;
	Tue,  7 Jan 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oPxEJ9Cr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EE41F2C58;
	Tue,  7 Jan 2025 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260908; cv=fail; b=jIfmaFG9fjJwalyFNXhV+37ZQFfJvzDrii+uAq4caon6dkU/qQZT5oT6e3p3K+lEG/HvuN8iRqEv5UJdRytJ0FDin9d/d08FIWqaw3uihgapqHbhHHZ3kXLga//RCw7K4tIc4Frjz/5gD9KXU3BA0e++3HE8Wp8XkefOQt4l9lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260908; c=relaxed/simple;
	bh=f/CxB6OwW3n9TJys1GW+2U1Dd271RlbeD4Wp4a8p5iw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOz03KnU7AQ3q6wL3hT43FnDWJXTnVCgx/5yKNp3gFGHVZfv2pn+d69W7odrwRQa+weF1uoqhI7Cjj8FG0fj5+cUm9p9dGjBi6OFPqq3PVXRoRpXX6QLVl/507sjy4dsaoSc/yVAe4P5UYC+YPmtJhY8tClYj9T5aAvaxnX28VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oPxEJ9Cr; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TC/PZTEvkmPsda1kCmSCRQkWjZMXRw7SjAWKH45b7chrxJUS2gx/XztRLe/iXOCSGGe8HZue2MhBXp97KJc+OzRI8YaEW8HXGbh0tYvCUoUwUAs+am9XC3L3tezbNgeLRLhf+mEN2xsoXZW3Iybd7KIO2H89q5D53BiJ7w07E5sACodrUaAXQPcztkB9Tr2GiG7iLQVPRFOKX1BeQBbFdCYw6iSKhybIol1pdrJBXnxSJ0zF1saya+LCZQ8MXbLzBf2DgzZ7jmpZwSsTy/NY687u3az3BubpFcYzPgZXsG/ZLUYi8rHNHMXfJmOu1YQIjepLbBlp2OnUUiIVSiQdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fa7tu7h7WA/M1+LNOyqzETUcIb1aRSmszxCQRXxQL6Q=;
 b=w2mbEr9pFE2GjYOA+ll654UYcJcxT428d1WlNJNr79fRKiiEeRi5LY955DZsjDl/nIQ8RDaYWszs8UxsTby6PhA7XQXjlqo6aNr0wQEAjTAGags2mc4GX4vG2Lex3s3ak43RJmUzYUBnHsdlAFy36bLpNZjJhDcHFEhmV0Dkv7KFoC8D+JaZMWQbQfBgoQbG7v2mAhpQrpFpLEWyWKmXPrsMdrzjEfzW5FZnobzWnRZQeHkGhtIZiftJ+UV2hk23Lvy3eLKnbM8z1LrLNqFEEggWj9w8TQjzx1JGhtJUHFqpNC3dYrACdcJJAXY/tSowF9u3LgzZ3jaBj03fJsriyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa7tu7h7WA/M1+LNOyqzETUcIb1aRSmszxCQRXxQL6Q=;
 b=oPxEJ9CrlscvDiUjirIghmoV78EhKqYUujgQiHb/eVDa9POD7jJw+HTkFTOxDh/VhkZ1wqOBTK5Ny6kJiN43h8QQGSJqD6Vwfl0WXPErQUt2BXHQ5aYv+U+p0Ai+raoMFldsc086Ql0Gng4RFu4AO9U5sg3igUV2sJ5E6WgkkJI=
Received: from SJ0PR05CA0168.namprd05.prod.outlook.com (2603:10b6:a03:339::23)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 14:41:39 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::d2) by SJ0PR05CA0168.outlook.office365.com
 (2603:10b6:a03:339::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:41:39 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:41:38 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>,
	<alucerop@amd.com>
Subject: [PATCH v5 14/16] cxl/pci: Add trace logging for CXL PCIe Port RAS errors
Date: Tue, 7 Jan 2025 08:38:50 -0600
Message-ID: <20250107143852.3692571-15-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107143852.3692571-1-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5e838c-441e-487f-96b3-08dd2f29656e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4I1Fsu64k+aE3ZMFR8oIdGYinpk8W0uE1uF2I0P0lKb+e8B/FpkcEjaJSltr?=
 =?us-ascii?Q?41r8+ggjC5PdZ5YxM0BjLj/U8c9wrdBZyhloypZJHl1dBFwdz6hAbB7e1WT+?=
 =?us-ascii?Q?1BPgPi57YZMVUtc5y13z+5uMW+W6POpIm5ZZeUn3UQ55sBmlY+M2s2sqnWB1?=
 =?us-ascii?Q?9WpuWIETFRSe7TDxGfRs98gW2lCGivhzPOvGmTIClQiAFt2rneF+hSIbUd2W?=
 =?us-ascii?Q?LyOzc2kAX6GSw1oFxcx2cLIG8FLSEevnAZe4PEYpLG1dexhEWkiR9aE7syD6?=
 =?us-ascii?Q?vWUzhjP0MStvKPpvIVrtQelXrqT82aeBuvMN8bpHo3Mxz+IYJQJ/vejHO4/o?=
 =?us-ascii?Q?n6I+QPMnVfHP8Fe/waLc1Z6SfEw4zW4sWAuaJ/7bYnGwcmL9b9dD/z9aNfhx?=
 =?us-ascii?Q?qxrXJF7PqTxtorwOET6bTsD/ZpH0g3zR14CMiyC+thYkWgRm4YJ+WFR6gRpQ?=
 =?us-ascii?Q?ZSo7d1z0BptWuIH7aTpWxP2AXxLLnoJSB4feDvtATil01qLbDLmsrd8TmTWy?=
 =?us-ascii?Q?xWl637POHIUAkVyzC0/bH64ba2ctp1CQPVlXCR79yc7wFajY4WG3d3+fYsfC?=
 =?us-ascii?Q?Y7nBb3mfrBsqg2iavGdo5xjyeBcp7AxeN8Iuj3idJWladk2KGLQiBxF1/ahh?=
 =?us-ascii?Q?5b74ehYV7E7/iQC5rSNxehupQa4cabjNEjFtQqtBahK2ZBxZJRiUszp2kyhj?=
 =?us-ascii?Q?C3RCj3ynsZ8zrQKOhaxY972BucvRIClHg0B1v1iSIlHxFCgVne9T/0TCrVVj?=
 =?us-ascii?Q?fJ3zwPyJ9JofWS6lBqDnebidCmnnki0ENpAWrUaJ8n/4j0JcejKN5MlvqaNC?=
 =?us-ascii?Q?61/IF9NIiUvn9dY1GpOM3Eh9RSxLoNGTI0vsoc/EHqMknB3kxlymBMxnAq0Y?=
 =?us-ascii?Q?6g5cxqpaQN1fekNzkSgL4eYTUEKYZ5tw/UaMY8OfCRILXcfpOs7ldF036Tu/?=
 =?us-ascii?Q?5zSFNIPQePlBo509CrZVj+z6tRJAR1WpCWMUCA8m/4YBPtIhD0s2lvRlOCX5?=
 =?us-ascii?Q?d7Gn2VtjS1n0HPbF8dLmUPAfX/6ydem+h3Ak7o91ptLmM67BcpBhly1W9LHX?=
 =?us-ascii?Q?xnKiRYuCK39cypAtZXcFYCyq6xDa/mBFHcJ26MUXsbDrUpWg5fqnLHizl+L9?=
 =?us-ascii?Q?w6tb7EwmR0g7b0izsT4CILB15oHUkC16uvuI25Ni6ED4Kqr4KZ3q3Nkq7Emr?=
 =?us-ascii?Q?6Yud2DiC2nEC9rcCYnue24ckWsdEkkBsGg/541pmJI4hMTOBQ3iRozfkDP0C?=
 =?us-ascii?Q?fJVo+aEupwzy0iz9D+RhJyeBuKasDouvid5S67O9J6tKdl8a9gYhNM8cWvQB?=
 =?us-ascii?Q?xSBZ8NH3QWEh3GF0RA3B06sQQGK31nyqaB/+tDs8sJnTpCueZUUyJ4iYCvVr?=
 =?us-ascii?Q?kr0z99nU28+uAcLytXRnbKor/54OseU3PpLugdxOu3ZKgKqfE7o4e6pmdeC6?=
 =?us-ascii?Q?TSpJB1tvC4FVrh/43dDYxsEi/qFFBddhm7zcras+iHweDOQZrhr8Ji7BAFnk?=
 =?us-ascii?Q?XSzu71sFWPkENwGS+GyAa60hT2cISvkhgyZa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:41:39.6826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5e838c-441e-487f-96b3-08dd2f29656e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237

The CXL drivers use kernel trace functions for logging endpoint and
Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
Upstream Switch Ports.

Introduce trace logging functions for both RAS correctable and
uncorrectable errors specific to CXL PCIe Ports. Additionally, update
the CXL Port Protocol Error handlers to invoke these new trace functions.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c   | 17 +++++++++++----
 drivers/cxl/core/trace.h | 47 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 411834f7efe0..3e87fe54a1a2 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -663,10 +663,15 @@ static void __cxl_handle_cor_ras(struct device *dev,
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
-		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
+		return;
+
+	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+
+	if (is_cxl_memdev(dev))
 		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
-	}
+	else
+		trace_cxl_port_aer_correctable_error(dev, status);
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
@@ -724,7 +729,11 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
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


