Return-Path: <linux-pci+bounces-40243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CF4C323A8
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 793C4340586
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9252033DEDA;
	Tue,  4 Nov 2025 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lo1zr7v8"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010036.outbound.protection.outlook.com [52.101.193.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049A8339B47;
	Tue,  4 Nov 2025 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275922; cv=fail; b=nSzKHZOeit8j0yTBpTik09PNqco1uZnRI/YPp+IMvZfYta5X5pEtCIT0VhrfyZwbWsA7lK9ST1R153LiiGW1xE1IHWYTCRggl59BO129xLCmx/++OJpzvzfztJpOY03OKH85unjsZh46lmXcvBs9tewMwN7Vv/tGMc+TWPOzkPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275922; c=relaxed/simple;
	bh=rIaav0Xf3rr1bOJEk/GlTvkt+qSvdPSvgi2lfd+TE/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcRZJogF644v6T6WXHXlbEY6jAhTSMMP/yl0NOnp/PfWfcKTAoXUA2nj5oi19dZunZJRRw+G13jKxtii9hy9gDSZ0Tt+AbV2ZOl/N078asfj1V0hcThdvkppfCbdmrx9Kreroz0oseZ+WipSZaGbGS0fv5PQWLqepb+BvPMtKEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lo1zr7v8; arc=fail smtp.client-ip=52.101.193.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOrRziBw22/48jwdmKHunr9TqXCP4wB4IfCVW6cxrRyRDgwcTkjzvDb9esHkgjb+upTCPAic7EeCy6puU+BwNmCuVKyhJfhOtCSTeIX+VM5v33haiT6HSJcRGhSM7Uz7pj/zermW5GvimX3CxlvVrUlRKq09jvRjS6MCFBIz2puikb8mkVbUWARtm5fZ8jboQdMqLIFaIx4W3XawnJwtEJrSlMG/oGRm1H/+4uqXR2mb2k2Y7ufSBSRbwf1M86HRVz+lPR64xSxCL2lahZB1coFeplre061zcx8HTbJKWwF4YKcf8OUznxU7YZyMFYXJSpox2NshKUB1cbjhO8RmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzqxRtnjRENW6FF3T8ZDiGue286gp53VQjtZK/uW3Mk=;
 b=u/OWIUbVI+EYQH58HFatBmWn6HgRus9aGPDLSmjSYonPeDyVl1LXiKc0BfLawvp9cM5huhUYh//ZgaF14V5n7vhSInMy5utJJosiaC5wEu0walSkmCW5JH5HkDd9sykx0l6egGus2Z/DGKtprylv96kCpxJJDZ7h5K2J+EG5LetfqLWMHsaHMVdIjjgFd/6ibw1cnSStZ+5xr1pfs6ZaNBVSLItLqcsiPSpm3fuFwIKNoKGKwEa5/wqE4Ljx2Yu0OpKdnitFq7my52n5PXw2WKLJmYSMO1gj3QmgFkVFBm64k5uKYktGQLd9mNhSi2FyyZjP0cWfcd4e8C9hEj0H0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzqxRtnjRENW6FF3T8ZDiGue286gp53VQjtZK/uW3Mk=;
 b=lo1zr7v8+gbAWDV9F6r4kvSXOfbHk6XdMYkSTio+T+TYHay2cnxRMsZBRKG3kU54mfl/YU5mMRXPPTVCUH/lowWbe1BOmyCw/qNM9XjvgyT0qbp4irOb1psul5LblUHksOzHW5h78IiIt4egx0iLC4A1Z57IaWN4xaWaHWrRHOw=
Received: from BN9PR03CA0113.namprd03.prod.outlook.com (2603:10b6:408:fd::28)
 by IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:05:17 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::75) by BN9PR03CA0113.outlook.office365.com
 (2603:10b6:408:fd::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 17:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:05:17 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:05:13 -0800
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
Subject: [RESEND v13 11/25] cxl/pci: Log message if RAS registers are unmapped
Date: Tue, 4 Nov 2025 11:02:51 -0600
Message-ID: <20251104170305.4163840-12-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104170305.4163840-1-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|IA1PR12MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e31572-6986-4bf4-bfce-08de1bc45432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qbwcGsPealmcBLHPhhvSTl7mpgCQoaQ4wKbDaQvxXjojDreLG4pBSKVddoua?=
 =?us-ascii?Q?/OpEC+y2zpmCmVsd5dWm8TEEumS0Xfpziyz070r1epiNNd1wXJCYNnT9J3Nn?=
 =?us-ascii?Q?NrMGPS4Q6f+GaMSnx32fWCK5jNASuGI3/nLIJ6QE8fdl7Rl6CGIz3r+5haIj?=
 =?us-ascii?Q?eK/kuQa8oRVRKQc8kODKcbeCJfsdAQHey5ivvinbpCgDdSwpLBiSbworolJh?=
 =?us-ascii?Q?7AAzgrzDMBljSODJGNlYjjG4S9L5MLPqCg1pk3m2tUh3y5OD2gDlT6RPIZ44?=
 =?us-ascii?Q?TzQMaaSbzZjfUzMYBLnxOVfMYNnU3eniX+yn78dOlfiJ/iGy3cc6lGfexQSc?=
 =?us-ascii?Q?zLJe9XwMwG8E5vqN+EHfHQQG3GAXmfgChXKheDlqccvyuYxh2XOt4pa0/KaH?=
 =?us-ascii?Q?6/ZIlI4eId8TlJ+3z/7zE2xVEBHw+E3EU1vPFNGMsi/QzIGacmVnPJL2F2I/?=
 =?us-ascii?Q?V2tm7oF4Nfa1KD7cWRsgLjUe6zIS82KBW16lP6SKv49iY8+Xossapj6qwQqa?=
 =?us-ascii?Q?5YuKY9LHbIGrzcHTQ8cHvM49HH+KiDF1dt5xCDPB0TXNZMt3OK7z4htr9HNA?=
 =?us-ascii?Q?9V74jqYzDTeJZ2fVHFvA3lTBB40KJf/4MjW9qcFL1JEQdmCsX9z/ka2K4NWu?=
 =?us-ascii?Q?fi/UxDdBLiY2vxKmGE2JKqE0MEs6zw0Q7qa4xZT8TALBuB9xP8Qolv/G464j?=
 =?us-ascii?Q?A7wEvfjgL9ecVGIqhirs4eNatUpPlecTOc3jdHZ9mvCpy4IKQeDNSnA1QwLS?=
 =?us-ascii?Q?HgvAxPqgHThJkG08FQMIBhTf+8wkxfyrIII9zj4PDzR2GPPI+qatz3bkBaDp?=
 =?us-ascii?Q?bekxxsvOTWJ/JEco1OtWpxTe+iWt/3dTWTjOvjwUWL5n/NOJ8TkpoMyWYA8y?=
 =?us-ascii?Q?inHdKSvfkZp/WESTTDc34R5jkcPiCKpOjFd830CCyiWzwJKENjOs7WQVz0rH?=
 =?us-ascii?Q?K7q9wAHDqMVv/apmXU00/Np/mBfyVxHv6OH0BVy6wXenmGMkZAGCDJyKs9W2?=
 =?us-ascii?Q?3Dodi1UTJknTngAAsWrcmCZbbdbACeuMpIwFlQb6K30oEmqgV1UoAGbhFVf0?=
 =?us-ascii?Q?wADJuKOYfZBaHQUQhbJ5FnFophfX8/zww+l+PTgH6fowMo9p01gD8bMQL5a9?=
 =?us-ascii?Q?tOLo1sb7hVqJHy6vhVEe9Cm1BURnjGlglY2IycdM/4SDX6wF7tKXg6vQO4XU?=
 =?us-ascii?Q?NTQiXBXH6IDrrutr4vo3WRQuWkzQ247Jbe5HHJb6F5JUYw/XziGyCVcXPM1K?=
 =?us-ascii?Q?yiUGx2PZ4xJTb5ctwuS1zcf8KVqTc8Sz0ln/PzJ4VtoeDT8/P2JRkyWaK3bl?=
 =?us-ascii?Q?18FyH4a4RebhTM4Khr9/SSeaR4WvLTTG5bBQQnE2lZjW3qWnZYrzXGbcbeU/?=
 =?us-ascii?Q?joAVX462qL6yGT3aq+Xhpu/b1teyVMBCoaIPyVJXHRs6AcI0ZYW3YKub/mlg?=
 =?us-ascii?Q?+whLw7n8NA40GOB1gOWCRCsPrE0V3ErM9hTODpBW4M++N9K9zv3ZVfBiWZpy?=
 =?us-ascii?Q?mi+sd3sAPaoQUf30VmDCCo+4eWNRtifTCp/ySaRjqIB5t1G6t/yNzoh+fPef?=
 =?us-ascii?Q?9xzBdZ1Dk/dkNIMLStx47ufUP9L9nVnvWo+l9hTD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:05:17.2899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e31572-6986-4bf4-bfce-08de1bc45432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6435

The CXL RAS handlers do not currently log if the RAS registers are
unmapped. This is needed in order to help debug CXL error handling. Update
the CXL driver to log a warning message if the RAS register block is
unmapped during RAS error handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

---

Chan ges in v12->v13:
- Added Bens review-by
---
 drivers/cxl/core/ras.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 72908f3ced77..0320c391f201 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -165,8 +165,10 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 	void __iomem *addr;
 	u32 status;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return;
+	}
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
@@ -204,8 +206,10 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	u32 status;
 	u32 fe;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return false;
+	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-- 
2.34.1


