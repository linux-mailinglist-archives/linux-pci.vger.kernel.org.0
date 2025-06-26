Return-Path: <linux-pci+bounces-30856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F23AEA9DF
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00D71C4452A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE4A270577;
	Thu, 26 Jun 2025 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TeOBJ+lY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70767274FD3;
	Thu, 26 Jun 2025 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977875; cv=fail; b=RglhuJD0AYEotsYOWFqRFF7OKKQWJxy7W/2XKTPgxbdKeydO+Fg82X1GmrZLl4Dfx++eekFq9wrDVUpZpiOYFwRncbmcUAyrJ4LzPZgzfpsKuEHcB6tLKlbokfd7PywaHjHtGZYTaJQoh7sAKNgQl1wSwzdj7ZTi7JYpgNS5FTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977875; c=relaxed/simple;
	bh=/RVPgGY2zr2U+3GZORncNqyiBYmA8TBwu8x4RHIttbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6H1H4Cp86CAk1n7G9oq6vNVAFdHEglSONL5U+/9Hx2Dfcw1+KYwaKtQQjRlsuq7f6KFghRykk7U2YMZZo36aZmUQeZDPwnHm92fqDWY5KhGHRLcNuXX8k/3+Do4Cbt72mybaV7k1wScEcv+mCHTeQQeOIZg+V34TOCP+1fzn5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TeOBJ+lY; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PubZtwYpO0wZxElMa3BOqq1VmXbDROhldj5Ni71noA8JohXBJqS4q6NzEnLo4/LDB+cG19g1NBB1mY8n0YlgUY+87+le+7a4pO44WQtKG/YvyAPiFJ+v5Afu7gqx7K14DP7f/8r+m1yWV6CAj8GoXUQlVb//TjpZUhbXUIvKgJkdhAEsfUIEJbBCFjSKsVznbETq3NeGS08Fs/RXExwxX0vD5ZHkKpPvwXt1vvE16q8lnE366/JUaDHWaAhg0NgVvNjpzfdyLWkeRMyKKEPjXHdcQ4tdiN4/v37fqoTh5TszPEhhYuC3oUzHXUMOZ5z2rQo817GPMUihe+sonehlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnn3GmQ9o1OLtydxDL3OYjQiO7Z3eUYJVSqrzJ6crKE=;
 b=oUsagzPM88ZXAmQO2IHyauWzkvvQu3bR/sLfKm8uMtabD2ZD02uHPW1901SUJ+fuId3ODXEIBqI8qJSOhdG/uAuG4ONFHAO2hG+nKqLdXNClDHzcNZ6D7X60uPtc5LF/2MX8Cmq5f0MedfiGBO1YaNuIZyYE7Zsj9wCqpJujteJ+6MDXr3SaQJHmpr/6DPHqEsxcL+vgqG5I0aB+IttZ+30q4uDITqB+eBD51FvmcVTc4qJsk0CSqXY+K8wWu6mk6LRt8sBnm14BX1uYfBGJZsglpsp06W69/e1WZOmdJx98xj1LCuR+4Z5OyeyD1+Sh1p7jxyFnmp+xARUD5tUIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnn3GmQ9o1OLtydxDL3OYjQiO7Z3eUYJVSqrzJ6crKE=;
 b=TeOBJ+lYHaGmV996bIz6A8UZtSTlRVYeOZ3JHsunLu+HSuaYhBpsJ4C7qSZWqVeK/g3x27VF26Fl5Kg/yqVOGNcPsKcSM4TrUyni5k4/Bty9tuSXtcFUe3J1HnPCqo3P/oVo0bNLQF9iHa+iTG/KQj/tKjP8Pk4cUSNl8ghyQTg=
Received: from CH5P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::21)
 by DS0PR12MB7680.namprd12.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 22:44:28 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::fe) by CH5P222CA0017.outlook.office365.com
 (2603:10b6:610:1ee::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 22:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:44:28 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:44:27 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v10 08/17] cxl/pci: Move RAS initialization to cxl_port driver
Date: Thu, 26 Jun 2025 17:42:43 -0500
Message-ID: <20250626224252.1415009-9-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626224252.1415009-1-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|DS0PR12MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad4b71c-0685-4598-7b51-08ddb5030245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r8zUqWSjJ4VOJZ+DWY8HlNw4A8V1/5lwtGny5YusxWSHQXN6TYQF3pJm9jhG?=
 =?us-ascii?Q?B9U7xuLYqJS/ATK9k29iCp7mlqVsd72D+vUvFaqGPE+3a9Daof2RFEDcmGmN?=
 =?us-ascii?Q?QqLDUjZAGOZvCa09x8Ie2Bx4oXh8Z8UQLKQGpn9sizJc7dVEfPv1GkzSzC0N?=
 =?us-ascii?Q?BgrOdbV4TDil6j+WmbpGk7iMDyD2ZnbON7V1w1K8pICK6QBAUbQzSTgSKV+q?=
 =?us-ascii?Q?4hQHvnNUwv5p4MMHcccNgxeZSJ2uKs/BZpTIm+5A8QQjmBLQuy9H4fsImeuG?=
 =?us-ascii?Q?4ChE19l/2/crPoKJp3BAjkvuPyjXH3d8nmWMZYZeX4yODoco7OIIGy5/0gMk?=
 =?us-ascii?Q?uranOhDtAQLoZfPIRhpwzIGdQUmj4va/WB+dO6GonUbEIXDCo51zKsUN5A7+?=
 =?us-ascii?Q?fRHlAAhKqVAp+CAq0KZTAOq7KIiFVuLhZCulEkyo//pyV4NqY7qHd11b/tiq?=
 =?us-ascii?Q?DkpmXi9v3MFnfr7G233uDSbY3hEIBZM7IjTtpdMd2W4iL+p8fW1AMYrK1ypW?=
 =?us-ascii?Q?Td5S8NmMmFM0Jh5qHUnlSx8w4LeKH971dE4mV2rTaepC4PQDpajYPfF6j5C0?=
 =?us-ascii?Q?HcastNfXXTbudC2h+VOJWqGArebVenXQ5Pap+6jBuqzgJXBbvXAd7pn6btDz?=
 =?us-ascii?Q?PE+dv4ch2FCdQtHISdtDjZqCHnP9OiuGuMEieb7dMq7vC5AKlQEd3+b9jyvJ?=
 =?us-ascii?Q?e74xnqdz84+TO7ZJaYoBcY/ZWGTpt1f0PkUmLd58uUTYXknw9JuNAc3JakEV?=
 =?us-ascii?Q?fY+LHrjeVT5XMfb17L2wgJOCKFHPTkbfbEA3GX34C6VSdu/vf4lwro4r94WV?=
 =?us-ascii?Q?SVOxdqSwwTHoKZ4nmLZLQoJ/yp71Z2maGCkOU9nr5LkrGV9lrFT7SC24YCnS?=
 =?us-ascii?Q?E1ej2Hf1lwJFDVyCoLWVIPnbmbQu5TMCNw+l8lvIvRw3k3i3YBHoJCyavOPH?=
 =?us-ascii?Q?PcBZxRajhAPOwU5u7tOYTrU6tbai8uKSWtSMPe101BlJFuuCSU70AQGXnpHf?=
 =?us-ascii?Q?si41sT1jBimLksZUxpHhr4vbPwL7o5hWrjbwp/AEUS9TEfaKe062jMncFexT?=
 =?us-ascii?Q?gNxXdulGYyz2gi3jYk78gTjxZA1L2uXoDNUP60Gf/TH6lZSrbXQjhS2kLCVG?=
 =?us-ascii?Q?vUYB+acudPM6ZO4fN1ay1lWA690E7MYdAkL1fv+/8coyy+jiXa2dEB6o6GXJ?=
 =?us-ascii?Q?fO1rGcvBLKDy5S63w6oQJzWQzJJ9aOanBLbYKiMqp9Q8BRQ02TOaRLf3U/r0?=
 =?us-ascii?Q?LNV01Lh8V21EphmaItSdcSA7pLbF6YkRXBUHYThSIJGD411mhq1H+M8VfREM?=
 =?us-ascii?Q?QkXTnRN70+jcCBrHrSuGW4dmO9Oz00ogjua7uyJcB5XUqWoGWE2HyF68R9c6?=
 =?us-ascii?Q?Hre+m+A73Q8cjt3WPbJhGbd1nb1rAo0Jg+eFXscxInvCmkiK5Oe0FHTKu9PY?=
 =?us-ascii?Q?nELU2jUOsPG9gBJGcSx7PFVJBMCCgomRUx0NZiqdxAsplEgheDH5i25CFG7Z?=
 =?us-ascii?Q?1vbNrcVkSdihu88yqqVyqR9XEAfuktTD97sula94KpD1RXxyJbtxWR1x9A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:44:28.3284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad4b71c-0685-4598-7b51-08ddb5030245
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7680

The cxl_port driver is intended to manage CXL Endpoint Ports and CXL Switch
Ports. Move existing RAS initialization to the cxl_port driver.

Restricted CXL Host (RCH) Downstream Port RAS initialization currently
resides in cxl/core/pci.c. The PCI source file is not otherwise associated
with CXL Port management.

Additional CXL Port RAS initialization will be added in future patches to
support a CXL Port device's CXL errors.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c  | 73 --------------------------------------
 drivers/cxl/core/regs.c |  2 ++
 drivers/cxl/cxl.h       |  6 ++++
 drivers/cxl/port.c      | 78 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 73 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 06464a25d8bd..35c9c50534bf 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -738,79 +738,6 @@ static bool cxl_handle_ras(struct cxl_dev_state *cxlds,
 
 #ifdef CONFIG_PCIEAER_CXL
 
-static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
-{
-	resource_size_t aer_phys;
-	struct device *host;
-	u16 aer_cap;
-
-	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
-	if (aer_cap) {
-		host = dport->reg_map.host;
-		aer_phys = aer_cap + dport->rcrb.base;
-		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
-						sizeof(struct aer_capability_regs));
-	}
-}
-
-static void cxl_dport_map_ras(struct cxl_dport *dport)
-{
-	struct cxl_register_map *map = &dport->reg_map;
-	struct device *dev = dport->dport_dev;
-
-	if (!map->component_map.ras.valid)
-		dev_dbg(dev, "RAS registers not found\n");
-	else if (cxl_map_component_regs(map, &dport->regs.component,
-					BIT(CXL_CM_CAP_CAP_ID_RAS)))
-		dev_dbg(dev, "Failed to map RAS capability.\n");
-}
-
-static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
-{
-	void __iomem *aer_base = dport->regs.dport_aer;
-	u32 aer_cmd_mask, aer_cmd;
-
-	if (!aer_base)
-		return;
-
-	/*
-	 * Disable RCH root port command interrupts.
-	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
-	 *
-	 * This sequence may not be necessary. CXL spec states disabling
-	 * the root cmd register's interrupts is required. But, PCI spec
-	 * shows these are disabled by default on reset.
-	 */
-	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
-			PCI_ERR_ROOT_CMD_NONFATAL_EN |
-			PCI_ERR_ROOT_CMD_FATAL_EN);
-	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
-	aer_cmd &= ~aer_cmd_mask;
-	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
-}
-
-/**
- * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
- * @dport: the cxl_dport that needs to be initialized
- * @host: host device for devm operations
- */
-void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
-{
-	dport->reg_map.host = host;
-	cxl_dport_map_ras(dport);
-
-	if (dport->rch) {
-		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
-
-		if (!host_bridge->native_aer)
-			return;
-
-		cxl_dport_map_rch_aer(dport);
-		cxl_disable_rch_root_ints(dport);
-	}
-}
-EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
-
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 5ca7b0eed568..b8e767a9571c 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -199,6 +199,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
 
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
@@ -517,6 +518,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
 
 	return offset;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
 
 static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3f1695c96abc..c57c160f3e5e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -313,6 +313,12 @@ int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport);
+
+u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
+
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length);
+
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index fe4b593331da..021f35145c65 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -6,6 +6,7 @@
 
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "cxl.h"
 
 /**
  * DOC: cxl port
@@ -57,6 +58,83 @@ static int discover_region(struct device *dev, void *unused)
 	return 0;
 }
 
+#ifdef CONFIG_PCIEAER_CXL
+
+static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
+{
+	resource_size_t aer_phys;
+	struct device *host;
+	u16 aer_cap;
+
+	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
+	if (aer_cap) {
+		host = dport->reg_map.host;
+		aer_phys = aer_cap + dport->rcrb.base;
+		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
+						sizeof(struct aer_capability_regs));
+	}
+}
+
+static void cxl_dport_map_ras(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->reg_map;
+	struct device *dev = dport->dport_dev;
+
+	if (!map->component_map.ras.valid)
+		dev_dbg(dev, "RAS registers not found\n");
+	else if (cxl_map_component_regs(map, &dport->regs.component,
+					BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_dbg(dev, "Failed to map RAS capability.\n");
+}
+
+static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
+{
+	void __iomem *aer_base = dport->regs.dport_aer;
+	u32 aer_cmd_mask, aer_cmd;
+
+	if (!aer_base)
+		return;
+
+	/*
+	 * Disable RCH root port command interrupts.
+	 * CXL 3.2 12.2.1.1 - RCH Downstream Port-detected Errors
+	 *
+	 * This sequence may not be necessary. CXL spec states disabling
+	 * the root cmd register's interrupts is required. But, PCI spec
+	 * shows these are disabled by default on reset.
+	 */
+	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
+			PCI_ERR_ROOT_CMD_NONFATAL_EN |
+			PCI_ERR_ROOT_CMD_FATAL_EN);
+	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
+	aer_cmd &= ~aer_cmd_mask;
+	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
+}
+
+/**
+ * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
+ * @dport: the cxl_dport that needs to be initialized
+ * @host: host device for devm operations
+ */
+void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
+{
+	dport->reg_map.host = host;
+	cxl_dport_map_ras(dport);
+
+	if (dport->rch) {
+		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
+
+		if (!host_bridge->native_aer)
+			return;
+
+		cxl_dport_map_rch_aer(dport);
+		cxl_disable_rch_root_ints(dport);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
+
+#endif /* CONFIG_PCIEAER_CXL */
+
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
-- 
2.34.1


