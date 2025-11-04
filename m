Return-Path: <linux-pci+bounces-40168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 758F0C2E8A2
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B39C4EE626
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193BB41C71;
	Tue,  4 Nov 2025 00:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u4jkCQCA"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DA35D8F0;
	Tue,  4 Nov 2025 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215150; cv=fail; b=G78IXIazXjXetlG8WFy+qF/5CJR/oFvHy8u+lnQtcjIbjqrJLlVzMY/zX56TC0895aVONaA3TH6696qqAvPcMEld5xT50Nihbzz9DO7jpBF64kTOtrtn2XFkfOXilA/mCvtivqRlBwdMqigZfCDstySE/pMtoPECQUbr1tGyavA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215150; c=relaxed/simple;
	bh=p34hxKi5Jy4iLOp4uc0//RETPyPj8SOApC3uk9KH8ME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W96OyTK4z+mvJqHTHY6jm8Kmg1sDr6OTpK8EAGHu2NeNsUiygBjSMMOhPLybGRl/PcBDh6+83XLS3HJAEc4Z77gMgsT4dTxFrSTBSXQzkuhVX1k+m7C0jFbmoWMH2pQQmTr+GnzoORExwSDrKovFHOhATTGC/6p3unsQonUOhmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u4jkCQCA; arc=fail smtp.client-ip=52.101.61.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shSv67fp6eHE+6KZyzGglhxWbzgnbTG2Ha/ZuEEgNHcBT1jd4kIfEXvzSSqX2/JYly2yWqaCZEnp2vm0fJj9xdf7rqljlnH8lj198/4PQeMfvIBw2fbJQgv+K10UllrmhRsaGlUKHdQjW/SogHAgMJ9AivTGeGQoesWTFnbN/lLB8kXBvzSZhfVWp5q5Y+DDCFrSaxlSsYpeSPP8W1RC/PxbFQj3bYAaG7ncTDEgn57F8Qw9420YU31nOd90LC3KKY129yf8+r0MHoM+XmgudA2jrYlgWwppiRlrwjnhuQkOzVanpvxFUwjEiXB5Qf0vAUuBoBdSqmOtCBNRhgFRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykPvpFdsJd5H6SrC1TGpvspRS55nqonoB3Iw4GGG+5w=;
 b=GbncYnM4QIz9bPHRgxEyoNzp69I3EWYXDFo6jidYaYtQpmjipRuAHD+CWnxo5DYxzN+WbFg+LIc6p20Isi+qU4u/e5PH7867Qkd5v26rl5iKbegPpIhsGecKqNwTnGK0X+bC7uSIP53tV12+SKvX485KHfL4OCWJfqSpwHs0PbtnloFFjaBkfXZSQSw7LMm4eU7xQyNKRP7NUb7JG/Sx5mYebliLwDpdfk3EF3HIrLS2V7SBBMkGn/b40FmmEnV6wDW7c3u3B0uJNKO4mrhx3tKKucMAMm4yAJ4OCfShHalzS8uawMNIGW0r7JEZcmWc04QKWxY2ehNkHmFqA6/fag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykPvpFdsJd5H6SrC1TGpvspRS55nqonoB3Iw4GGG+5w=;
 b=u4jkCQCAyd8LMRf6DkKYyQnS79VQgwiwxfGMrwOSOYHzxY8STNpehaYjR4jF7LdZqmUXV+JmwzaBKXH1Wt8wFnYQTCixBOvRRUHlbB1A+MI3d1jEz20UoENvZcD3gWLU38bS1u+zLoB2DdWVTtVumePRlmbwXULDQSV+AHKhRfI=
Received: from CH5PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:1f4::17)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:12:22 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::5f) by CH5PR04CA0017.outlook.office365.com
 (2603:10b6:610:1f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:12:21 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:12:20 -0800
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v13 12/25] cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
Date: Mon, 3 Nov 2025 18:09:48 -0600
Message-ID: <20251104001001.3833651-13-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104001001.3833651-1-terry.bowman@amd.com>
References: <20251104001001.3833651-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|CH3PR12MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: d21c84eb-2ea6-4514-d8be-08de1b36d2c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oGMv2iywHBrQTtQFCGeAyS2ZMAernIgEE1tMZYMOdD+TDEjfEwE3/Rc/DM91?=
 =?us-ascii?Q?3AbMJKx9ar0JAT2SopWBG/dSgwaI8cK0sr7078AIBdKpjffCi1GDRpOwMgJF?=
 =?us-ascii?Q?/eOeQ8BN2xCwFsOs7R7fTgeVDGH5O6OucMjHPZqb94gpocaF5+ZFSrfXGVfQ?=
 =?us-ascii?Q?yC0zw8syK4zPlTUWz3VNwWbye+WcBoLdJykB9hA4KH5LGob3SSBYKYXHv7he?=
 =?us-ascii?Q?JCCZoIvh1LNocOSa+N+mcwW9mBZMsUVAKPv9uYqtV+nKTWVe0i64W+bi8JUz?=
 =?us-ascii?Q?ZMrgEAkbjj4ipsttX1KOgT/16kb1FyEF+WGJGAXTe9sQR0X4BZHZ5nFDQJ+N?=
 =?us-ascii?Q?JY4lxXEOjCBQHbZVJB2yzLmZ/Nm9540P1QxmtNsGXFYXMLY2PhoGD7g6jceM?=
 =?us-ascii?Q?mLI0UvWaQxitJT0ZcRdavHNeD/x88sGAhnp0RrCc1JzE/zzOZMGoL5WPEAFi?=
 =?us-ascii?Q?G7mwrUVFhuVe34p0K6Xk6hifPtpRmvn6SlrUP46Graz0sY5SKXCcIKDbf5Ph?=
 =?us-ascii?Q?FN0sRWnRQbhylOGTsOQmx3EmFdXdtWUwi25t71JyFiSmb2kNoX8wUbgE69Ux?=
 =?us-ascii?Q?QWVsSVdcwawcHIRicNuMnByXSr/EIJe8CdBKRxoa4CyAotvgRoE/sLdpU4mS?=
 =?us-ascii?Q?tUrjhrEH8KI3T5yHrCKg4gEjLHEU6UCd9TqA8Ga3btcQO1wlASf3DPAQe8A6?=
 =?us-ascii?Q?uL6O8zyHrlr5IHdK3QwEoBYnHqBOJR3kM2tq1BF/QoGJ1QDznm7oZnprIjX3?=
 =?us-ascii?Q?PObGOG+qsE6eho1BsV+G/ehh/06NTkDNm8SJykb7Xq+NHtMUzU+BXDtNsoAe?=
 =?us-ascii?Q?qYG3yVgyTEqfWlULbaj87By/ahqI59RVFIkwcKpFivGZHNGrAyjJPf4gO7NL?=
 =?us-ascii?Q?9yW9HovzMOMJvn9A95mXv0VWkQRIehsyp2aUmor0J31To29+Mw7/w/46AvR8?=
 =?us-ascii?Q?oYUIA/Zvv65R7m16Nf7WIFkK26w4SQcsMNCe/ESs3IUCVu+7PKbcKlp0pRRY?=
 =?us-ascii?Q?Qv46U6NnCSJB1Rrzkh/eroXbVfHoss9IY+7ltNt1Bn/NIT9WgqTyO3rer32L?=
 =?us-ascii?Q?ysc6Z4HnynrVZIKiSHn6WlQuX3g64RQ9a9IMFbxtRxdd7ZmsZpATRtevjaOZ?=
 =?us-ascii?Q?TlBVy1WvYkxOJUjXI/bj8i6F3HjXQuUmNjk1Pasp08TuMnfyY5qVQxuSy296?=
 =?us-ascii?Q?LBIzpwerIjzB9PgPM1PmSJzGmc6InD7eA5/87rlJcIC5MGC7vaF0GvstqAQo?=
 =?us-ascii?Q?9O7Cu52VaFD+AhwJkzTb2kPcsjiqM3ehoSa7FCrQ2PllZ4p+zeSrfMo6uWyh?=
 =?us-ascii?Q?l6I0axyhO+wLX5p17TWfn9zMy/1C7D4P27rsof4VkeYzlrkTI5Ri+OfZklUN?=
 =?us-ascii?Q?ScVA2Xe8WJcGvk881aI40/nkl9ZXXE4AzVhFjNpzCSeJ/EAswU2gUjUa7PSk?=
 =?us-ascii?Q?eRLheCvFp33lscz3T9u8e9N3MlQgeploHOFPPHeQ9UlQA4P4GqiU759VNNag?=
 =?us-ascii?Q?UyWHgYuRzpvcSOnvtFFvl16J7v3e1/qisBhjvNeOxI749kNNVfB4qZ2duit7?=
 =?us-ascii?Q?tDMAY0YHjacnql6MekTsQHS0eSK9enosWYFvsSKK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:12:21.0690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d21c84eb-2ea6-4514-d8be-08de1b36d2c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432

CXL currently has separate trace routines for CXL Port errors and CXL
Endpoint errors. This is inconvenient for the user because they must enable
2 sets of trace routines. Make updates to the trace logging such that a
single trace routine logs both CXL Endpoint and CXL Port protocol errors.

Keep the trace log fields 'memdev' and 'host'. While these are not accurate
for non-Endpoints the fields will remain as-is to prevent breaking
userspace RAS trace consumers.

Add serial number parameter to the trace logging. This is used for EPs
and 0 is provided for CXL port devices without a serial number.

Leave the correctable and uncorrectable trace routines' TP_STRUCT__entry()
unchanged with respect to member data types and order.

Below is output of correctable and uncorrectable protocol error logging.
CXL Root Port and CXL Endpoint examples are included below.

Root Port:
cxl_aer_correctable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0 status='CRC Threshold Hit'
cxl_aer_uncorrectable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'

Endpoint:
cxl_aer_correctable_error: memdev=mem3 host=0000:0f:00.0 serial=0 status='CRC Threshold Hit'
cxl_aer_uncorrectable_error: memdev=mem3 host=0000:0f:00.0 serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

Changes in v12->v13:
- Added Dave Jiang's review-by

Changes in v11 -> v12:
- Correct parameters to call trace_cxl_aer_correctable_error()
- Add reviewed-by for Jonathan and Shiju

Changes in v10->v11:
- Updated CE and UCE trace routines to maintain consistent TP_Struct ABI
and unchanged TP_printk() logging.
---
 drivers/cxl/core/core.h    |  4 +--
 drivers/cxl/core/ras.c     | 26 ++++++++-------
 drivers/cxl/core/ras_rch.c |  4 +--
 drivers/cxl/core/trace.h   | 68 ++++++--------------------------------
 4 files changed, 29 insertions(+), 73 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1a419b35fa59..e47ae7365ce0 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -149,8 +149,8 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 #ifdef CONFIG_CXL_RAS
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
-bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
-void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
+bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
+void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
 #else
 static inline int cxl_ras_init(void)
 {
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 0320c391f201..599c88f0b376 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -13,7 +13,7 @@ static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
 {
 	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
 
-	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
+	trace_cxl_aer_correctable_error(&pdev->dev, status, 0);
 }
 
 static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
@@ -28,8 +28,8 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
 	else
 		fe = status;
 
-	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
-					       ras_cap.header_log);
+	trace_cxl_aer_uncorrectable_error(&pdev->dev, status, fe,
+					  ras_cap.header_log, 0);
 }
 
 static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
@@ -37,7 +37,7 @@ static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
 {
 	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
 
-	trace_cxl_aer_correctable_error(cxlmd, status);
+	trace_cxl_aer_correctable_error(&cxlmd->dev, status, cxlmd->cxlds->serial);
 }
 
 static void
@@ -45,6 +45,7 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
 			       struct cxl_ras_capability_regs ras_cap)
 {
 	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	u32 fe;
 
 	if (hweight32(status) > 1)
@@ -53,8 +54,9 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
 	else
 		fe = status;
 
-	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
-					  ras_cap.header_log);
+	trace_cxl_aer_uncorrectable_error(&cxlmd->dev, status, fe,
+					  ras_cap.header_log,
+					  cxlds->serial);
 }
 
 static int match_memdev_by_parent(struct device *dev, const void *uport)
@@ -160,7 +162,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
+void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -174,7 +176,7 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
+		trace_cxl_aer_correctable_error(dev, status, serial);
 	}
 }
 
@@ -199,7 +201,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -228,7 +230,7 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -250,7 +252,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -279,7 +281,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 	}
 
 
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 4d2babe8d206..421dd1bcfc9c 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -114,7 +114,7 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, 0, dport->regs.ras);
 	else
-		cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+		cxl_handle_ras(&cxlds->cxlmd->dev, 0, dport->regs.ras);
 }
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a972e4ef1936..69f8a0efd924 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -48,40 +48,13 @@
 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
 )
 
-TRACE_EVENT(cxl_port_aer_uncorrectable_error,
-	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(dev, status, fe, hl),
-	TP_STRUCT__entry(
-		__string(device, dev_name(dev))
-		__string(host, dev_name(dev->parent))
-		__field(u32, status)
-		__field(u32, first_error)
-		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
-	),
-	TP_fast_assign(
-		__assign_str(device);
-		__assign_str(host);
-		__entry->status = status;
-		__entry->first_error = fe;
-		/*
-		 * Embed the 512B headerlog data for user app retrieval and
-		 * parsing, but no need to print this in the trace buffer.
-		 */
-		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
-	),
-	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
-		  __get_str(device), __get_str(host),
-		  show_uc_errs(__entry->status),
-		  show_uc_errs(__entry->first_error)
-	)
-);
-
 TRACE_EVENT(cxl_aer_uncorrectable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(cxlmd, status, fe, hl),
+	TP_PROTO(const struct device *cxlmd, u32 status, u32 fe, u32 *hl,
+		 u64 serial),
+	TP_ARGS(cxlmd, status, fe, hl, serial),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
+		__string(memdev, dev_name(cxlmd))
+		__string(host, dev_name(cxlmd->parent))
 		__field(u64, serial)
 		__field(u32, status)
 		__field(u32, first_error)
@@ -90,7 +63,7 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	TP_fast_assign(
 		__assign_str(memdev);
 		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__entry->serial = serial;
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
@@ -124,38 +97,19 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
 )
 
-TRACE_EVENT(cxl_port_aer_correctable_error,
-	TP_PROTO(struct device *dev, u32 status),
-	TP_ARGS(dev, status),
-	TP_STRUCT__entry(
-		__string(device, dev_name(dev))
-		__string(host, dev_name(dev->parent))
-		__field(u32, status)
-	),
-	TP_fast_assign(
-		__assign_str(device);
-		__assign_str(host);
-		__entry->status = status;
-	),
-	TP_printk("device=%s host=%s status='%s'",
-		  __get_str(device), __get_str(host),
-		  show_ce_errs(__entry->status)
-	)
-);
-
 TRACE_EVENT(cxl_aer_correctable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
-	TP_ARGS(cxlmd, status),
+	TP_PROTO(const struct device *cxlmd, u32 status, u64 serial),
+	TP_ARGS(cxlmd, status, serial),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
+		__string(memdev, dev_name(cxlmd))
+		__string(host, dev_name(cxlmd->parent))
 		__field(u64, serial)
 		__field(u32, status)
 	),
 	TP_fast_assign(
 		__assign_str(memdev);
 		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__entry->serial = serial;
 		__entry->status = status;
 	),
 	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
-- 
2.34.1


