Return-Path: <linux-pci+bounces-45008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B848D29AB1
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 02:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B15C307B3A5
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 01:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D472586C8;
	Fri, 16 Jan 2026 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kQaqV24D"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C88126AA93;
	Fri, 16 Jan 2026 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768527752; cv=fail; b=CFnb/csg1sEJIaPfEOvYHCvwSnlrQVExX2BAxZzAJLGYJw5DHf0oXpo3r783hF/kWt8qZ/e+S3DqKntko1F6kyTQ11DllYsjJGYNvlPH54qBp07JOXkVPuaiSvb/PT1fKgX8UvuTjjbbJ9PwoxgdUw7LvUCra3FJ5KK92Redtf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768527752; c=relaxed/simple;
	bh=3midiOk6Wi2DvsRCrNGUIxHCKnV9I+tbUs+bZ7ZO6hM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMZOf3sUyUWPKuZSGWA5N9KMtJr8jwWdpK/TbA5qf1frQ/8c++s2D4XG1DWzoRKXgslyrEDf6bh08mgFCRcA7Q1ExS/P5bMTnCj6/BSeT4WF/yT1Fv6dh1HM23XaT92F7jgTqeMqBlxyc/XkDLJvEowU0j/6wp4+GQPVPjUQ22I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kQaqV24D; arc=fail smtp.client-ip=52.101.48.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WU4WTDnH6Coyg2D16UJAUPiu6LmtvHXjVtb10c1+z9nNI0DmTzQFtQoj3xPZUanwr0oDYlzwyM4cpdgjEApe7UL32VDgU128jpTPLusIJRCjF2fVEPX2rHk75bi6D8frCoIKTPaBQ+NnYXNboUZskAExGKm8J09gTTcv+III7B9uFoIT2YWOd7SmzJWMxQ/Q8rbbRD4GZ39HX3c2omRWKu/X7g9kCot6iP+PE8GuwgQb0K8oACmU0AzwV7AeXkdkRbMB32drTocgYVH8Fw9wmmiIn0rgx6/mTwuxSZDdNc3OydwiiI0ItuDNFYqXjMrzp38r7kPlaHw2++CMCx5shw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL1eIBVy2pouPbWETh9ftP81gWdveJg4VxY87o1Q/KE=;
 b=JjO3YxsOtmar8Tok3oeqXJP6lTRpHs6sNj5l8sapS0dVSwomVdaz3nBWzxv9krEJwo6r3qt5qFcfEbG8w+gOH9j+OAql21LIJYXLzuQnV7oaGf4TldU+Ro4oOMhnktwEnVotI4l2gAbdYk3WSt7/DOQmx6nTal76rHUmXbfrpUZPOSyXoXIv2JYlDeqIyNqcreAOSenzRAevC9Z5c6GL+bgxU7XNk/UB9DmZY2OsA8usIUWvbGDiU7AmQTgjXee8g+iev5e+Pf3pLqjvrpUuTuapmUTOXmSl9D0FeHqePqQaVhe0mgfm1CJWnpw2GPd5q0Mkp901MKWZmDllmjGNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL1eIBVy2pouPbWETh9ftP81gWdveJg4VxY87o1Q/KE=;
 b=kQaqV24DCDnYm344EPeQqVW9dC5Sq7b9hOmJnLZ9wcWN1Ylp7qC0RwLLUCqOM3cULqzy4u0paZAced5/iTJwKzP5XFcfZvTyFHv1OKrdarPBjMzwmGIcY1Zkdz9cIgAFhadVsLCQMKZeVZhZ4u+x6pmjn5kjH6DPiBIadTqjEcJsHCBYfY7DjzR7htPhFtB8dxu/Ep/UOqVqxNU36OgJNww3aFyEV0aj/kKH005PQclAtxECvARb24/5od7IkF8TcrohO2jCg/gIfkxj5jPM5Nsxg02eXvu2TX3wp0yYRR+TdAPnh0CZN9ccNxGJydq2XKRoNiGoOaGw/GrWUSwmcQ==
Received: from BLAPR03CA0169.namprd03.prod.outlook.com (2603:10b6:208:32f::21)
 by LV9PR12MB9757.namprd12.prod.outlook.com (2603:10b6:408:2ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 01:42:20 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::9f) by BLAPR03CA0169.outlook.office365.com
 (2603:10b6:208:32f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 01:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 01:42:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:42:05 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:42:05 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 15 Jan 2026 17:42:04 -0800
From: <smadhavan@nvidia.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <smadhavan@nvidia.com>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: [PATCH v3 7/10] cxl: add host cache flush and multi-function reset
Date: Fri, 16 Jan 2026 01:41:43 +0000
Message-ID: <20260116014146.2149236-8-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116014146.2149236-1-smadhavan@nvidia.com>
References: <20260116014146.2149236-1-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|LV9PR12MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: 5150774f-cb0e-4d82-eee5-08de54a07d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8AmUkgxLf1aAhvzUy9ZsX8/sM+IqeFjb333Ii9qRrGXaAAbgXxg0Ryg5FlsU?=
 =?us-ascii?Q?zAJUa/oJLjoxyU9QTwVyglaHqv7WsvlgwMfz7Jy1gNWf1Tws58UhLIk6RKfJ?=
 =?us-ascii?Q?UKJ2I2qvxI47JlW04y1VleDH7XyOQAU7qsgmxT9qTSVJ9FtlaLYdoZarqiuO?=
 =?us-ascii?Q?4Y3+M8yDS0ZFiz5Y3BpvtxW9UHjqhNkRBCSh2ocj6JVJecdhrhu6vDp/8TYI?=
 =?us-ascii?Q?08Az7hhMoR2Gl/9NfQ8bLgfDCYY0lOvX8Bf8Arocr+SRjX9Ctwysmom5tASK?=
 =?us-ascii?Q?EYJkCFIY3Vq/hh2PSXvOxf96KDXa6/FbrswLoSs+AB+OHdf5OFox4VLt9PnF?=
 =?us-ascii?Q?MlSjMuRFIwlTuQ9RQwPZksG5393phQY2/gImdkfavjaGPRBXyyOjTHBk0CGJ?=
 =?us-ascii?Q?HR5CmCOyG6INse34SFvH489YLI20rzM+AN+HMShgKZG3Wawpqjf5lOncXrJP?=
 =?us-ascii?Q?36nwAQpfmmND29SOLDgnC46IycMaT0Bp3lErIHHdUEW/h4S/d4Gz5OLitGbG?=
 =?us-ascii?Q?2OlInETC/vk0exDrn6UmJQrcVCCFGwZUomW+mSmB89O8KWPfqNBQTivLl9Rh?=
 =?us-ascii?Q?cUf63egoUWmhx5hFL30MzMH9TPxXPq5yfwmzFq+Jrvq3EbZbq/pHvFYFThWz?=
 =?us-ascii?Q?qRlUEyxDrYg1F2Gz4XFSRDRw1BetpOjfO8/s1UfkqGOW7FYrkRHLOSLJfqok?=
 =?us-ascii?Q?okqHG/RXO4QvSTffFQJYoabK5Q3qZHXihp6G2wWKnYI+HR+zSjy8dWZF40El?=
 =?us-ascii?Q?fUil6pyKNgbOOebgJYWdLTbTncKgvzPAElVKLcUP2kgmzZdscACtXpGnRaLX?=
 =?us-ascii?Q?/UztLdCAHuehASJHdkDY2RYw+tiqSwVfP0KZXIVIMrDLZOLkwc7xu5Nr1VpL?=
 =?us-ascii?Q?izf/7mLyy347MexhxKDh9zddwf21iYJgzsTn91PlOY75fSTSWBqUkH+fprbK?=
 =?us-ascii?Q?5podqszRiOLt3YUQcw/2EO1OAdn1vRNsAIqSwCImXfDMx9ggTBq3QvaLQJox?=
 =?us-ascii?Q?ouFv4rHR4se5ye2G0lKO2Nm4SZ/6jxRvZOJ9DGg+7HdqlKFYGW694k0CVhNI?=
 =?us-ascii?Q?PcsjMCf0GBQTvSpr3YS/MmY6Vv/h8KDdasCusZCs+BRwHlJ0GtpnC495TlmI?=
 =?us-ascii?Q?nr/YeKgt/Q63E8U7e+sVL404LZiL8k60kYYmd4wH8/ed/tB/2AMD9DA5o0lD?=
 =?us-ascii?Q?5znW/wDetAws9QeQeOEq9igsL0UuUEJtphWokqU3RliU/8EEZPmtTYXfz8X6?=
 =?us-ascii?Q?6uThLekx3qY6ujaohcQJAWHL4kpE5gpj4/b2IJ5RPYb+weMESMsBJUj92ah9?=
 =?us-ascii?Q?5kNopamA/DZsJ8JJztvxEN15TCCO7PxLo6zQ+pEMeSBXfmIBM/FBRWwCWmNy?=
 =?us-ascii?Q?VXIQbSiQGiO+ubK8KeLiptHKTbjVZk/Ygj6aoZyn/g/YMmMh/RmcfkRm3FUs?=
 =?us-ascii?Q?MwOiBBKjrrKfgSQNEz840FiAVMHd1RYQEjI0EoEyHClgjb331RNryvo/H9ND?=
 =?us-ascii?Q?pyBzTGYYtTWpNs+HtzQBnnYwHH/zeLkJDwo22x0SGvITPrBGpNj+ctezKIL6?=
 =?us-ascii?Q?5vGhqSu9UMB8iV7FnZYHMMrhMIP7tq6LO5Ugt4vvk/IlHxCvKVXMdKubRiDF?=
 =?us-ascii?Q?3NvyXpZ7RW6GDiaMd8BdJYpZcReIutNuKytQjSI+5HhLkNtEFpopYd93HWFa?=
 =?us-ascii?Q?wBhtZiWVwa9YCdk9DLI/Up2xgws=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 01:42:20.0307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5150774f-cb0e-4d82-eee5-08de54a07d03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9757

From: Srirangan Madhavan <smadhavan@nvidia.com>

Flush host CPU caches for mapped HDM ranges after teardown and prepare
sibling Type 2 functions on multi-function devices. The host cache
maintenance uses wbinvd_on_all_cpus() on x86 and VA-based PoC clean+
invalidate on arm64 via memremap() and on_each_cpu(), matching the
required ordering before reset.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/pci.c | 150 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8da69c2125af..5d2bb4431de3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -11,6 +11,10 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/io.h>
+#include <linux/align.h>
+#include <linux/cache.h>
+#include <linux/cacheflush.h>
+#include <linux/smp.h>
 #include <cxl/mailbox.h>
 #include <cxl/pci.h>
 #include "cxlmem.h"
@@ -1092,6 +1096,71 @@ bool cxl_is_type2_device(struct pci_dev *pdev)
 	return cxlds->type == CXL_DEVTYPE_DEVMEM;
 }

+#ifdef CONFIG_ARM64
+struct cxl_cache_flush_ctx {
+	void *va;
+	size_t len;
+};
+
+static void cxl_flush_by_va_local(void *info)
+{
+	struct cxl_cache_flush_ctx *ctx = info;
+
+	dcache_clean_inval_poc((unsigned long)ctx->va,
+			       (unsigned long)ctx->va + ctx->len);
+	asm volatile("dsb ish" ::: "memory");
+}
+#endif
+
+static int cxl_region_flush_host_cpu_caches(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	struct cxl_region *cxlr = cxled->cxld.region;
+	struct resource *res;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	if (!cxlr || !cxlr->params.res)
+		return 0;
+
+	res = cxlr->params.res;
+
+#ifdef CONFIG_X86
+	static bool flushed;
+
+	if (!flushed) {
+		wbinvd_on_all_cpus();
+		flushed = true;
+	}
+#elif defined(CONFIG_ARM64)
+	void *va;
+	size_t len, line_size = L1_CACHE_BYTES;
+	phys_addr_t start, end, aligned_start, aligned_end;
+	struct cxl_cache_flush_ctx flush_ctx;
+
+	start = res->start;
+	end = res->end;
+
+	aligned_start = ALIGN_DOWN(start, line_size);
+	aligned_end = ALIGN(end + 1, line_size);
+	len = aligned_end - aligned_start;
+
+	va = memremap(aligned_start, len, MEMREMAP_WB);
+	if (!va) {
+		pr_warn("Failed to map region for cache flush\n");
+		return 0;
+	}
+
+	flush_ctx.va = va;
+	flush_ctx.len = len;
+	on_each_cpu(cxl_flush_by_va_local, &flush_ctx, 1);
+
+	memunmap(va);
+#endif
+	return 0;
+}
+
 static int cxl_check_region_driver_bound(struct device *dev, void *data)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
@@ -1252,6 +1321,9 @@ static int cxl_reset_prepare_memdev(struct pci_dev *pdev)
 		return rc;
 	}

+	device_for_each_child(&endpoint->dev, NULL,
+			      cxl_region_flush_host_cpu_caches);
+
 	/* Keep cxl_region_rwsem held, released by cleanup function */
 	return 0;
 }
@@ -1266,12 +1338,79 @@ static void cxl_reset_cleanup_memdev(struct pci_dev *pdev)
 		up_write(&cxl_region_rwsem);
 }

+static int cxl_reset_prepare_all_functions(struct pci_dev *pdev)
+{
+	struct pci_dev *func_dev;
+	unsigned int devfn;
+	int func, rc;
+	struct pci_dev *prepared_funcs[8] = { NULL };
+	int prepared_count = 0;
+
+	for (func = 0; func < 8; func++) {
+		devfn = PCI_DEVFN(PCI_SLOT(pdev->devfn), func);
+
+		if (devfn == pdev->devfn)
+			continue;
+
+		func_dev = pci_get_slot(pdev->bus, devfn);
+		if (!func_dev)
+			continue;
+
+		if (!cxl_is_type2_device(func_dev)) {
+			pci_dev_put(func_dev);
+			continue;
+		}
+
+		rc = cxl_reset_prepare_memdev(func_dev);
+		if (rc) {
+			pci_dev_put(func_dev);
+			goto cleanup_funcs;
+		}
+
+		prepared_funcs[prepared_count++] = func_dev;
+	}
+
+	return 0;
+
+cleanup_funcs:
+	for (func = 0; func < prepared_count; func++) {
+		if (prepared_funcs[func]) {
+			cxl_reset_cleanup_memdev(prepared_funcs[func]);
+			pci_dev_put(prepared_funcs[func]);
+		}
+	}
+	return rc;
+}
+
+static void cxl_reset_cleanup_all_functions(struct pci_dev *pdev)
+{
+	struct pci_dev *func_dev;
+	unsigned int devfn;
+	int func;
+
+	for (func = 0; func < 8; func++) {
+		devfn = PCI_DEVFN(PCI_SLOT(pdev->devfn), func);
+
+		if (devfn == pdev->devfn)
+			continue;
+
+		func_dev = pci_get_slot(pdev->bus, devfn);
+		if (!func_dev)
+			continue;
+
+		if (cxl_is_type2_device(func_dev))
+			cxl_reset_cleanup_memdev(func_dev);
+
+		pci_dev_put(func_dev);
+	}
+}
+
 /**
  * cxl_reset_prepare_device - Prepare CXL device for reset
  * @pdev: PCI device being reset
  *
  * CXL-reset-specific preparation. Validates memory is offline, flushes
- * device caches, and tears down regions.
+ * device caches, and tears down regions for device and siblings.
  *
  * Returns: 0 on success, -EBUSY if memory online, negative on error
  */
@@ -1290,6 +1429,12 @@ int cxl_reset_prepare_device(struct pci_dev *pdev)
 		return rc;
 	}

+	rc = cxl_reset_prepare_all_functions(pdev);
+	if (rc) {
+		cxl_reset_cleanup_memdev(pdev);
+		return rc;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_reset_prepare_device, "CXL");
@@ -1298,10 +1443,11 @@ EXPORT_SYMBOL_NS_GPL(cxl_reset_prepare_device, "CXL");
  * cxl_reset_cleanup_device - Cleanup after CXL reset
  * @pdev: PCI device that was reset
  *
- * Releases region locks held during reset.
+ * Releases region locks for device and all sibling functions.
  */
 void cxl_reset_cleanup_device(struct pci_dev *pdev)
 {
+	cxl_reset_cleanup_all_functions(pdev);
 	cxl_reset_cleanup_memdev(pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_reset_cleanup_device, "CXL");
--
2.34.1


