Return-Path: <linux-pci+bounces-40244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F2BC323F1
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732A618C42B5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E7C33A038;
	Tue,  4 Nov 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r4jmfGJP"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013010.outbound.protection.outlook.com [40.93.196.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6578333A021;
	Tue,  4 Nov 2025 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275934; cv=fail; b=CvPoJwA8RT4Tg49BkhewpBbEiJslobe/n8t67rEbHmuWy3uVMZdrDP/25ZHVVQCk4UpjcQMpdVFTtjF1Yvc54pKSI/IZ1xXdf6OFtAreKotBRTQUdDJg+aoTwCYuBmYaDcZw2HpyvTG89ajHvY0qrDNiRpr7ujA45PEpaSzuqkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275934; c=relaxed/simple;
	bh=p34hxKi5Jy4iLOp4uc0//RETPyPj8SOApC3uk9KH8ME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gGYqkMTVg/eQ4vG2eviU6Zqbr1eJiMaaXGyqniErV5bAiat6Q+I9CiQJ7JJP2hPUU+eFMCykw5P/FnzbP5ThPQxDjaF3VoBLEOGXnc9fFf2sLWp6ajdMvd8NyVqXi/yG4kmnd+M0eexxvzY9VnZYPKZ4/ZPhapMRSP80r8+NDmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r4jmfGJP; arc=fail smtp.client-ip=40.93.196.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9uKqhVt5QQrkF02VQxDcp0We2WJTpa9aUz4oYHYYrurIzH4NBdM92ZOf2hohyuXoTHqijXLdiVm+eC8nHDNq6hTCKlRjo+kKvO7Pgi/2Mf64Iu0ZBB8ZDf+U12KgsLl9+UONepGUcZu/S0M0+TJAqU/Ktq7cDkiXdRuZzmQjgKC622nUnWuBkpgpD0dyqOuq2kw5UxTntlkFPQKObCApC1HajhPkM29O6OsWrAXLAYif+mr9W3mKCXBboZwaOPm8M6wC2LMra7nZkmjO+ecD+YtUa/qHRwuWeEUNG0MzXM2aOMtyW6rl+YB6ERJ4TOpZAuaoIOClXAkMvivmyaZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykPvpFdsJd5H6SrC1TGpvspRS55nqonoB3Iw4GGG+5w=;
 b=AtExSWaDdevGVfn0rnVLhqyATni34vIiKQOwa6xJYYKG2FbD2RdUgfhLOLh4MNOdumRN/HDXu000BydUY3+0MNh3VdE40pi5aG5Ew5Hz8iPHV4Nb+CgzXqUsC2eiPjoXXsAuawQRv3ShbuBBRyoZLOTiQ8bOzYgY6WMEZxIaNwRbHbqozcQVp4il9jq6lCHqwlRnngcmdbFoQExXE01hxBTcByWGUycbBN+xCMrIq7wK954g97oUtsiSv/tXQpMN1T6rqy5dU7XZJ2GfmMWIsNzA2pnLm739kzBedt6N7Pj2Frzr2dC+yXx+9ROL+ygdQXZ5l/gPKk19uTtBgC3Nyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykPvpFdsJd5H6SrC1TGpvspRS55nqonoB3Iw4GGG+5w=;
 b=r4jmfGJP90TRd+GYL8xGbDxnIf3PfJOkzWG+JknbHNeL8v8QAyG07S8eViW4V9uyNmkXKpXqJ6EC45uySwTcC0Ent73Anb6e1YHYe6WHR4blaUPiuDSFV6+wmB8SNMHQM1lrTBtbaRScsvFwB0yLP9kbvtGz5oo9PbeDIXMzXVE=
Received: from BN9PR03CA0976.namprd03.prod.outlook.com (2603:10b6:408:109::21)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 17:05:25 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::3d) by BN9PR03CA0976.outlook.office365.com
 (2603:10b6:408:109::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 17:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:05:25 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:05:24 -0800
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
Subject: [RESEND v13 12/25] cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
Date: Tue, 4 Nov 2025 11:02:52 -0600
Message-ID: <20251104170305.4163840-13-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: e631d0d2-509c-4c09-231b-08de1bc458f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0v+wVu4S3oEQo4lSFhCdNZV2jRFMX5XU1evCzynwg6xW1Mb5bAWGBmZ81l3h?=
 =?us-ascii?Q?bVHAFDoP8xA/S+RgCxm8u2F8rI88N+mADJSLVqvMdjCwQcr0yJMkbIuByk8v?=
 =?us-ascii?Q?eNXyVMFv7QnRbNVwwyVc/iSx/xtqF8sS/M4KABJ1ZK0z1pMuiaQeWaqoDFtV?=
 =?us-ascii?Q?kuq6i1oOrvd9Luuv0IP58gILagNgDT4DGJOdRtTT7bMOgxftWez8Cg/unTJF?=
 =?us-ascii?Q?YHcrGz/tk6fXPQPEFldCJkGO3QOcp3ixA96D4pIJCMro7hs1Kpw725IR4xBx?=
 =?us-ascii?Q?8UGFyDAnZHZb9RH0V5Dz4nse8cjgfuWEaZmT6NdAoxi3wtRMlUO9hewYyyXE?=
 =?us-ascii?Q?LTERPchPB00cHgVeIuSpx3nnVb2kSImsxte0cZtNCgiF0FM4e/+3O9D9Y0HA?=
 =?us-ascii?Q?fvwlWXGjT/jx9So8LbycgxdaOyoulLx7YtLZRRpXUYtrNzOir4tmre+GK3oG?=
 =?us-ascii?Q?xZq+hmpMhGfPp7Ps0HgoPA4fygKZfDE6G+TadRNQEq+TQwNBblMDokwRTmnC?=
 =?us-ascii?Q?3WWBN6ClBp2vhI9oh57Ke9FQZ56PTz3IdlVv/QNL4AuYDsPAflihdDBIjw72?=
 =?us-ascii?Q?nOkXzAAA55Nv5FCB0BSqgvaD4Gs9KNmQWINYQWQ80SVGMCzkQviQCENIyuVa?=
 =?us-ascii?Q?pxDMAxTDo/AMXyK+vaQcTNcDgp6ak7pI9914049twamRuabZjBQubeA6oMe9?=
 =?us-ascii?Q?3aeDKSzyAN2cwSTNZWXCzPXuURqOi/sT/aOItntA4IsbRiknpqGgfmoy6tSI?=
 =?us-ascii?Q?BLbxY4AOpeDOh14WqYPty/KQ3R7PI4Dhz+jRP4jMjucOeoVcFyzpCOtTsUKS?=
 =?us-ascii?Q?FBuClz9eDcOG9+IaRazpCOHGvFRWs25zxeomT2ktRk4LsnclDkoJM6FyWqYN?=
 =?us-ascii?Q?xU+Z6KT+dBfS5Jlrp+Y4eNp25bNnFA9CS2/WDwCC6/KYLz0ndzzR+zkCowgs?=
 =?us-ascii?Q?9l2bx4yx88On+mu4wATgZtwVeHBOsXDcEaCig8UFzc081h5xcHkEcmO1ubuj?=
 =?us-ascii?Q?fnmfY19ZBpHMVYH1erT3KW8l1Xr34i1xmm+OvqI9a4jU14rm1vT4mTNX6Lrj?=
 =?us-ascii?Q?fiOxb5BZRn6vCyMLBY6+ZZRokFQemqR6t969HhhBfiR20hNBT2ZCoNCiGuA7?=
 =?us-ascii?Q?CYMsvT1I+cbd2vEbHEO/nEWANv1JvuAby6SpygHqAGY07RqT1Bz4U46WI1xc?=
 =?us-ascii?Q?WnX9VNYxBC47zs8cf/vOywE7Cjc48+bC3Upv0bfVxRjNaXVMdH315vVqq9jn?=
 =?us-ascii?Q?WvjP0B27dKmzUxO6pldv4eaWhEKygm2r3dKpeLa+HeF+qpbsnSEJIwKDj8Od?=
 =?us-ascii?Q?lHP6Tsd4aXVhu+IMF4gTbFpZ1U3LfiotY6Q6X0+vNKUC0z/9Ly+8fHzuuioS?=
 =?us-ascii?Q?nSNC/400Qy7Y7unER2+FR75ThaQIfhMrD0jz40375sNS2fU7r15mEOeCOYZY?=
 =?us-ascii?Q?Ml7ZhJ17+hlyoe+02WqqEeyy/AG45wrzYH4uaoJx7M905ofXctiUnUEOE/od?=
 =?us-ascii?Q?wCPa37I1qMxAeYDnglDj30mVNbl/kLXqwRt6j7WlMKm693mKPdvIDJIIDHsM?=
 =?us-ascii?Q?DnLhvjN2U6fQndPqV1X6lfKDkZ8uXoem1ZWQDkE1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:05:25.3008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e631d0d2-509c-4c09-231b-08de1bc458f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927

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


