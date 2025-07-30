Return-Path: <linux-pci+bounces-33205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7AFB16878
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 23:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FAA5469FE
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 21:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB8413D246;
	Wed, 30 Jul 2025 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jYPuQ9Vp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569BC22068F;
	Wed, 30 Jul 2025 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912082; cv=fail; b=PvNnKX/dsX82gaT45sB39tMEadmtA6+lMLGyibIkNz/TJCsoat9u8mg5tedw9O8H9GrRGvtUewY06lTnbw+gQ6YKnvWilYnJDiuPSJ2arOE8v2kYr3L43cmxWjJQmr3XielhyWz8CQkA9cjTFJslaSFx6pKLN6xjBw4jS7o6v00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912082; c=relaxed/simple;
	bh=YwHvylV35izlWDVW8JsrBZMlGKDwEk2e2oDAjt+PLSw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDUgIou8ugevnycEv/2Yqeb1NjQXhYV8t38A/p8Qe8TXKqWToxzE9HioLFqGXQ9v4QD4M7v4gqqVClOgeeBS2X7wnIAmv6cRopl/FMX8FjJcVCSwjzPZy8Sl+gCJa8MB9f9KAOFe+TMnqopzE0WiXaml+6oy18F35DpNdMCs87w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jYPuQ9Vp; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+BLajCXa6cyRlG3ciEaC3TYJkZVBqmPnJNuns1JjXO+THUJB9L+shmXtfu8vGMiSkOZov+9CoE1M1qvHlmb+/34zgyNfxxiSryYGUmgtwbQEuh+fsWR1IxnjXaOiJgNGXqJOgKay6hTU3+CvJkiZGQrZMr9Z4mKgVqr+80rKgKhS3btDXf+QQ9pkSnrcj74IaxTuEFBQJCqiDFHj/0FeOINb6wWsngPRVS6Z4c6k95YPSbmBO2Eh2iu/8WNFyOGZnGdrdh2G+UBgRZ/2/prGrSJo14aUdCrIOvOu3tRQxaPd7qNchDQ2Ubp+sjk3HClHBG3eh8H+HQ+oxp9oPftJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tCbh85AUNWT1/7e5jifNraHVWujD5z9mkhoX//xv2c=;
 b=nBrfqcyvJ0fIA/EJX+WM5zpba4T8W3hQtp3IM6w6RjbJ59gr4tXYIzvDk+x0hQuzRF79FGjapIa9RpRN1AxZFGEy3VpT9wjET5RLFp9Yt7puMPtrA/n09vMZvp5P3VuSgtUrQk2Mm8RCuc89mBjSNxW1Z3/ZwCpMpguqKQLrTdc57MZgY0VpRlCFVelcgSqnpVbv0Ot5qMTxeYRdyEfyoTItTydP3aKHud8A36FbnzWMJZ6S0owceMf9Ub4zjx/GyzYM4UsII7AtldsyRGncoWfcTzcQFPJWsKfVZaykJlgctkUumdjPOfbzNWJ0kIeiVqrF2UAIPR85Mv7LfGLyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tCbh85AUNWT1/7e5jifNraHVWujD5z9mkhoX//xv2c=;
 b=jYPuQ9VpXf9urCGElF86Ng3IrxHKkMY9AXiv9uujnsA0PstxBd/CqJA7h616+HmWRaChQIYucuXZf2KIptIZfildmHB970EeIvCImeLjq8HLXEzJ+tKMnETKO8fCoTgTCPw46NuhvI7Z3HHwdHvyCBgw8zZQI1N1nAqilxi4/n0=
Received: from BN8PR15CA0069.namprd15.prod.outlook.com (2603:10b6:408:80::46)
 by SJ5PPFEB07C8E34.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 30 Jul
 2025 21:47:56 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:408:80:cafe::9e) by BN8PR15CA0069.outlook.office365.com
 (2603:10b6:408:80::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.13 via Frontend Transport; Wed,
 30 Jul 2025 21:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 21:47:56 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:47:55 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 01/16] cxl/regs: Add cxl_unmap_component_regs()
Date: Wed, 30 Jul 2025 16:47:03 -0500
Message-ID: <20250730214718.10679-2-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|SJ5PPFEB07C8E34:EE_
X-MS-Office365-Filtering-Correlation-Id: b471cc3d-bb12-4278-1018-08ddcfb2be62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q2BH5zwCmFKorsigk6ZbkQBrs2PvX3BS5DgQbY/a57R6VR/0DbYKDTDiIkco?=
 =?us-ascii?Q?/gV+lb5wb6wRNuJpdAfJOEFcICoHcPS25Cs6KzxUpCjMbsX9ZkJZ8pC1F9Me?=
 =?us-ascii?Q?TMlxXUg8MI8RRwb1I07TTk0za2iKtfk9QqGaFGs+3a7mVDPEruIlEje3QAV7?=
 =?us-ascii?Q?ytTpJBgj8THtyECxkN3UYveqDgP4tol2wL63uyeR4zBe4JhQKrbXWFiVHcLK?=
 =?us-ascii?Q?7AefeZccpA83o1pV/ca5Jk5zCCnap9XbAxkAxNyVor/ozBJykwNzPgpxk+AQ?=
 =?us-ascii?Q?WpzxUtggOgHQt0rC2aOjxd2J9ClntmjVaJCgWgqUvcaNsNDhnmxFfvc8BBug?=
 =?us-ascii?Q?jR1bHcsEJzs8chn0Jrs8x9gJdd80NyksRehgBzbcCrEE2zE4A7Rurhn2NSrx?=
 =?us-ascii?Q?KMAdIFdxCHSdpkn3s1R/TfUHRO2+kBib7DYGpXQqvs3GWat8u0c1BC5/mFz7?=
 =?us-ascii?Q?ozUUDX/qMoDMRnHV296VALz3Mp+HWQsbC8EQlQzWq9fegCLfcV+eAw0jtQux?=
 =?us-ascii?Q?tj1dzKcFEijfsfMbM4GQTewO4IYgzQIMGq4VbP4bXVrnxYrcLuZuP8DipOyI?=
 =?us-ascii?Q?ehiV7Zm65BP4dhSFIVcXCm48wv2vu4mwcGTXXHJoU25ZBY6gQ58m5gkAfR0c?=
 =?us-ascii?Q?LKHDrpVclRXQKPcQNQisgAGHZ8BhFs2zvACOourGEIhyyW/YYUgywPaJJcKk?=
 =?us-ascii?Q?2WmBU2lGQonNGVor+R0x5JjZxeUS0tZ+qc+Csp86yg+Zenm1yWj2ez8JgYPW?=
 =?us-ascii?Q?fm0HFB9cLdUk9GDDZJzhNUYlxAE5+/Fi1shqsg9pGMY8Ttg0f4j67bh+9eDl?=
 =?us-ascii?Q?yyQSDgs2J09PeyROjdqSLN9c4QLztoCpG1vqecNVJLokxYQjlQDDb/2Lwd1/?=
 =?us-ascii?Q?KyOTXse31uR6o6Ts4Y4P6RV5AV4uY0hKGUOxHdMCuxQNx55kjZvTKwGWElaG?=
 =?us-ascii?Q?4dv9bjyyaRJCw3bXBu18bsPNmEL07tdVaJS5A6INwnDcI4Cc+/FQniOTS/o3?=
 =?us-ascii?Q?vojoMo7Zz84KAeGm4bwYHVo7cJt8YNDO3V+MZAkZqgryjXgsbQnZRe8ljOPm?=
 =?us-ascii?Q?Br8eOOEPiXwQEbAiYlcPx9w6JenEg92mPPYn9wa4ferBSg74G6m5o1/4z3tF?=
 =?us-ascii?Q?zO5bsf3jgFzbIqTWi+Q7R4CS5m/V2Ohj42BQ2nGczzSACbXfKuNu7LMYWJYG?=
 =?us-ascii?Q?Ygen37jmK9SKMQtBo+f9QRD+CseVcFOhc0CPO/ezVnNDgdX7+i8k8VkO3Kwq?=
 =?us-ascii?Q?VkVFg+xF9ekXG9d/LHoz8FkgKWZIrvuENqna9uv3vTpWoLofwws2aIsQELgj?=
 =?us-ascii?Q?om/w/MbDrYeoUlapi110NwyNlf8EBsjc9QLjPkfxZWJCeffc/Yj9Fc5jlyR2?=
 =?us-ascii?Q?7XLxYoyUOdYT1qTMIi9CTDj+EshmCVF2ZLhUsMWQ8x2CQ1KrKMC8fxEUk/yV?=
 =?us-ascii?Q?3yiRyPtJ9WQHuh94hYp4P1wkuNorXBh4+5c5mY1z1eRZc+NtCvVNK7wb01uA?=
 =?us-ascii?Q?VkXS35QSMqmCkkJT8ByqlV+/W2sHzW84MRfj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 21:47:56.1276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b471cc3d-bb12-4278-1018-08ddcfb2be62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEB07C8E34

In order to allocate the MSI/-X interrupt for CXL error isolation the
PCIe portdrv driver needs to map the MMIO-space isolation capability
register that contains the interrupt vector. The CXL core already
provides a function to map registers in this space:
cxl_map_component_regs(). The mappings given this function are managed
by devres. If the isolation registers are left mapped by the PCIe
portdrv driver, the CXL driver will run into a devres conflict when it
goes to map the same registers during probe.

Add cxl_unmap_component_regs() to be called from the PCIe portdrv
driver. This function will unwind the devres allocations done by
cxl_map_component_regs(), which will allow the PCIe portdrv driver to
map the isolation capability register without conflicts.

Factor out the register mapping retrieval code in
cxl_map_component_regs() to be reused by cxl_map/unmap_component_regs().

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/regs.c | 77 +++++++++++++++++++++++++++++++----------
 drivers/cxl/cxl.h       |  3 ++
 2 files changed, 62 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index b8e767a9571c..da8e668a3b70 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -201,40 +201,81 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
 
-int cxl_map_component_regs(const struct cxl_register_map *map,
+struct mapinfo {
+	const struct cxl_reg_map *rmap;
+	void __iomem **addr;
+};
+
+static int cxl_get_mapinfo(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
-			   unsigned long map_mask)
+			   unsigned long map_mask, struct mapinfo *info)
 {
-	struct device *host = map->host;
-	struct mapinfo {
-		const struct cxl_reg_map *rmap;
-		void __iomem **addr;
-	} mapinfo[] = {
+	struct mapinfo mapinfo[] = {
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
 		{ &map->component_map.ras, &regs->ras },
 	};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
-		struct mapinfo *mi = &mapinfo[i];
-		resource_size_t addr;
-		resource_size_t length;
-
-		if (!mi->rmap->valid)
+		if (!mapinfo[i].rmap->valid)
 			continue;
-		if (!test_bit(mi->rmap->id, &map_mask))
+		if (!test_bit(mapinfo[i].rmap->id, &map_mask))
 			continue;
-		addr = map->resource + mi->rmap->offset;
-		length = mi->rmap->size;
-		*(mi->addr) = devm_cxl_iomap_block(host, addr, length);
-		if (!*(mi->addr))
-			return -ENOMEM;
+
+		*info = mapinfo[i];
+		return 0;
 	}
 
+	return -ENXIO;
+}
+
+int cxl_map_component_regs(const struct cxl_register_map *map,
+			   struct cxl_component_regs *regs,
+			   unsigned long map_mask)
+{
+	struct device *host = map->host;
+	resource_size_t addr, length;
+	struct mapinfo mi;
+	int rc;
+
+	rc = cxl_get_mapinfo(map, regs, map_mask, &mi);
+	if (rc)
+		return rc;
+
+	addr = map->resource + mi.rmap->offset;
+	length = mi.rmap->size;
+	*mi.addr = devm_cxl_iomap_block(host, addr, length);
+	if (!(*mi.addr))
+		return -ENOMEM;
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, "CXL");
 
+int cxl_unmap_component_regs(const struct cxl_register_map *map,
+			     struct cxl_component_regs *regs,
+			     unsigned long map_mask)
+{
+	struct device *host = map->host;
+	resource_size_t addr, length;
+	struct mapinfo mi;
+	int rc;
+
+	rc = cxl_get_mapinfo(map, regs, map_mask, &mi);
+	if (rc)
+		return rc;
+
+	if (!(*mi.addr))
+		return 0;
+
+	addr = map->resource + mi.rmap->offset;
+	length = mi.rmap->size;
+
+	devm_iounmap(host, *mi.addr);
+	devm_release_mem_region(host, addr, length);
+	return 0;
+}
+
 int cxl_map_device_regs(const struct cxl_register_map *map,
 			struct cxl_device_regs *regs)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 51b7058387ef..a0fda305e25b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -300,6 +300,9 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
+int cxl_unmap_component_regs(const struct cxl_register_map *map,
+			     struct cxl_component_regs *regs,
+			     unsigned long map_mask);
 int cxl_map_device_regs(const struct cxl_register_map *map,
 			struct cxl_device_regs *regs);
 int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
-- 
2.34.1


