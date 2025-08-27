Return-Path: <linux-pci+bounces-34822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DA4B37711
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DD07C4632
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FD91F239B;
	Wed, 27 Aug 2025 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xW1Mkdj0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB778F4A;
	Wed, 27 Aug 2025 01:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258608; cv=fail; b=XyLzn5S+8OPo6/UmDpKrgHiLnfsmMjiIz6mm4FLy3383+Fci29bc5Srt3O4+7P2Jx3kl8882tsBo+Xj74uMtyB++3yOGC3iSsSw83TUmrosT9hIii+my7QcgFYu/9YkgKXYkExuDUvjEZXfWdI1QGMbuB7jYJxm3HRoYIpLQpFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258608; c=relaxed/simple;
	bh=fGk9t3ALmBVLfqY91OSEyuXabpvrWL4iACvYo6IDz4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyi9qovU5ia+tBRcgm+KyowY7yGjFsBLdhasXkSKxe36QTjK41S/3px1ObJHoCq/WSm5d8TBLCS9k7Py6jnoGgN6YyVtt2Q9FR3a429D0NHhLRXcLuk6tu2VNTY7BkR/H8hKjaTH/GZsF2lrzrrQg7uVsSbeiYReosOrJlnFO2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xW1Mkdj0; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SB+ftBjYKbn1MazRWBx8swuRMxgzC2O7s8LNtFsUZ4HrK8bhmiOyPu31Oe29C8NrKes+sKu1q3Lg7LL4x3SY90n3AlieYcG3Jv+c/2tnHLubM7outNDpQDukcg/ZSDJMuVa4i3oPaL5Gh9uBhGwTdJ/GxHj1M/0D7TEHu/waiucMpVASbUf+BhgaoQCCrCEWxW8RKK+gloq+Gv8MoahPLNkQYOhYiQjGTjDyxcbffuGszQu9sXuftH4VDmO4Go+IP1J3NTemTvAtpDDnitHbkbnHTlB/TNcZi1CWlcPnqdSeqfnGHiiY3i0NDlThmYxiPd35aEvZSCvI3FuJS+nkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CKZqj7o3BAESj8HGYqE6Jn3H8KI2sPsUi/J3Z/nXbU=;
 b=Gos4tWGwkOUCV9qWBCyGGKHAvHrZdv3V7jTcW8vBQPouqWm21BKsjDXOKHraNIY2sGMDudaJJmeiCS/yjKZFy4Y5oUAkFAOR1EgsGlUMl83nbcptecN0QY5v3fFdolpBXjwZr0bWY0IStsJYuTmAtoIanH46WS0y+B9SmthkrYMUInFqqf+GOQ77nGdYmLh+aD6NTmwCITO1nJuEd8no17aPDpgz6yndSu9dIGyq5sgRiPO+rUkLxK/PZFxyDWlSkjXRf7zwj2Ewa78svH9KN4BqGHZqVpruZInvK4BeLZkjn1LXrU6wXm9F5EagQiYiHu6kYo7vvesppfGljja6Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CKZqj7o3BAESj8HGYqE6Jn3H8KI2sPsUi/J3Z/nXbU=;
 b=xW1Mkdj0i+OykPioA68X1SVIEiTEB2r6ZcadCeXtJNB08E3sEr9POPHhoTrhutSvfGra2q1yXXETFot832vputAQwT4rwWv3267WU9ft4HakALSQlsnc23CdzYj+gT5q4UwyqDbSxgaddnyjpk4Lz0k7iNzDaWYYQEAfF8L1LZM=
Received: from BY3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:254::31)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 27 Aug
 2025 01:36:41 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::1d) by BY3PR05CA0026.outlook.office365.com
 (2603:10b6:a03:254::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.12 via Frontend Transport; Wed,
 27 Aug 2025 01:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:36:41 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:36:40 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v11 05/23] cxl: Move CXL driver RCH error handling into CONFIG_CXL_RCH_RAS conditional block
Date: Tue, 26 Aug 2025 20:35:20 -0500
Message-ID: <20250827013539.903682-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.51.0.rc2.21.ge5ab6b3e5a
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f663e9-4f2a-4e33-0ddd-08dde50a2ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qOkaSABmz0hG00/KuvGZoT/C3MWVZOvWIaBkcQgOl+2WIzvYnmTAcGFvEeL4?=
 =?us-ascii?Q?mb1GByZk9P7XUJPWE++BZTcoOPemZoLnEw3AA61XhPVfmwlZl2EdDnALgYuo?=
 =?us-ascii?Q?3Yo4+yMCPzengPdRQYBwlXz8KfoGh7ticuqW7NJbtPDir1ZaKHaT6uhRlOJM?=
 =?us-ascii?Q?j9GbwjCGez2KLY/4icAlgRRCxeLVlEFTzElQ+0KEi8LoAC+pVEApAsxn3FDh?=
 =?us-ascii?Q?ief9Cz8qi7GXwDGS1m55g2+/OiOWwerxhauCjgooJIKAXZ/c9J0DTU9K4Pux?=
 =?us-ascii?Q?5NBzG87oS3oDXbozhkOg+WeDbz7tooA4KL85T7OBKdatR8jEztMPSlS0xgNH?=
 =?us-ascii?Q?1dMsSZJFynS05Isnm+Q3NJm8BOhDPSRhBVYQH+oRuRHGlVn7/bvkneW8TpHq?=
 =?us-ascii?Q?0RKm5DzgVwZTAJCAeRoMauvrMArSBbLLvRWaB97yAoBixwEDGOXYNVRLbjBM?=
 =?us-ascii?Q?GvS1i4W8EJ1vxcYojA7kpxdZAnw8mdRGnJvW7qQp8ndlwyA1VZt3GVw7ZjHZ?=
 =?us-ascii?Q?Ce2KR8D+65Tn1kq/KPkU30nAjCGp8fNQi05TD9vu34uxDwY0+4OQuKtQ7H+4?=
 =?us-ascii?Q?dfln53+xjQRSAsJDeD47l+6MIBMF0MjmSZK5ZrQpFeeh1HSwSyqz7Y4olhKn?=
 =?us-ascii?Q?A0ai0cnZujJ2tuat9qqnI6ZWqbRLtnBHMvlls/tsLdOoB5/rwg/btKoysxlY?=
 =?us-ascii?Q?tnlxFnaBnAwbrMnBHUw2qOEExwLKWpuOJMJjYGxdFwP0D5MGekQHYcD5dsWV?=
 =?us-ascii?Q?mFySYtzkv7d5R/LiRDDWhdsbMSnkor421Wq/VvlskVLGmuG6xzc16EhPFZtE?=
 =?us-ascii?Q?DiGMSayoIu7KOGYrTsr4EvDglQymVl87EJoM4wYLTBIOwkoEc4ENtlZqqJ6p?=
 =?us-ascii?Q?z5x7fvsiVrRjv5FfnIExt8yXPQ8Z1QeLpynTIkBQFEbi/e3fHkt1bHYkkvFL?=
 =?us-ascii?Q?E8XO7zQ2N/DqamTPLwVXkS7TTFVktOJ/Un09l+7r6VZx4eJreFYXasvUKPX/?=
 =?us-ascii?Q?VkohLyuB6xZ27i2uA/HEWIR6vU+kQrsR5FWiQwBdK1xNcipePBdQErG9OVGk?=
 =?us-ascii?Q?/rR9V20W9B0HmFm9qhr8HN2DD01mu0BwnqpQf08xcpeZpE6abdZSGQfQmLdV?=
 =?us-ascii?Q?rYPUCEh0jaJBFDntdC39CDpDDOi/exq9HtaUJuywenSbDP4PPBRMBYGgs6vy?=
 =?us-ascii?Q?uMtiK3L6S+jbGXwZGKrPCs0lMEM7t7ID6MkpfTckgUX0X3/IKm8uubkanb1e?=
 =?us-ascii?Q?hvrXp0eyAbopOi4lMuBeVOosUItQuPjPQ33Uku09a2GHBzETZbaoj2NaudUN?=
 =?us-ascii?Q?v/7zPaoPjeAawic2e5+n24YrX6WeO9h0Ti0JiTLEGqwcBGlgLrYtEbNCcCcL?=
 =?us-ascii?Q?Dfg/wvJ6xLCM+ME/4JOa9Cp26lt2BNjJR6uoDNH7fixF37gu5GtobcdlEmpp?=
 =?us-ascii?Q?pyFwTiRtlDj0/BhBntipNnUB0QB4lUvGLJGcpHarZnzXax1cWoxZOGCGLGSr?=
 =?us-ascii?Q?GjLNnmsuNutc6/lC/enZF4ty6aYLngXanxYxC+ucAhcOcp5xDCDef2FJ1A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:36:41.6442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f663e9-4f2a-4e33-0ddd-08dde50a2ca3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712

Restricted CXL Host (RCH) protocol error handling uses a procedure distinct
from the CXL Virtual Hierarchy (VH) handling. This is because of the
differences in the RCH and VH topologies. Improve the maintainability and
add ability to enable/disable RCH handling.

Move and combine the RCH handling code into a single block conditionally
compiled with the CONFIG_CXL_RCH_RAS kernel config.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---
v10->v11:
- New patch
---
 drivers/cxl/core/ras.c | 175 +++++++++++++++++++++--------------------
 1 file changed, 90 insertions(+), 85 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 0875ce8116ff..f42f9a255ef8 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -126,6 +126,7 @@ void cxl_ras_exit(void)
 	cancel_work_sync(&cxl_cper_prot_err_work);
 }
 
+#ifdef CONFIG_CXL_RCH_RAS
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 {
 	resource_size_t aer_phys;
@@ -141,18 +142,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 	}
 }
 
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
 static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 {
 	void __iomem *aer_base = dport->regs.dport_aer;
@@ -177,6 +166,95 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
 }
 
+/*
+ * Copy the AER capability registers using 32 bit read accesses.
+ * This is necessary because RCRB AER capability is MMIO mapped. Clear the
+ * status after copying.
+ *
+ * @aer_base: base address of AER capability block in RCRB
+ * @aer_regs: destination for copying AER capability
+ */
+static bool cxl_rch_get_aer_info(void __iomem *aer_base,
+				 struct aer_capability_regs *aer_regs)
+{
+	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
+	u32 *aer_regs_buf = (u32 *)aer_regs;
+	int n;
+
+	if (!aer_base)
+		return false;
+
+	/* Use readl() to guarantee 32-bit accesses */
+	for (n = 0; n < read_cnt; n++)
+		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
+
+	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
+	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
+
+	return true;
+}
+
+/* Get AER severity. Return false if there is no error. */
+static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
+				     int *severity)
+{
+	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
+		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
+			*severity = AER_FATAL;
+		else
+			*severity = AER_NONFATAL;
+		return true;
+	}
+
+	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
+		*severity = AER_CORRECTABLE;
+		return true;
+	}
+
+	return false;
+}
+
+static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct aer_capability_regs aer_regs;
+	struct cxl_dport *dport;
+	int severity;
+
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return;
+
+	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
+		return;
+
+	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
+		return;
+
+	pci_print_aer(pdev, severity, &aer_regs);
+	if (severity == AER_CORRECTABLE)
+		cxl_handle_cor_ras(cxlds, dport->regs.ras);
+	else
+		cxl_handle_ras(cxlds, dport->regs.ras);
+}
+#else
+static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
+static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
+static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
+#endif
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
 
 /**
  * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
@@ -270,79 +348,6 @@ static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
 	return true;
 }
 
-/*
- * Copy the AER capability registers using 32 bit read accesses.
- * This is necessary because RCRB AER capability is MMIO mapped. Clear the
- * status after copying.
- *
- * @aer_base: base address of AER capability block in RCRB
- * @aer_regs: destination for copying AER capability
- */
-static bool cxl_rch_get_aer_info(void __iomem *aer_base,
-				 struct aer_capability_regs *aer_regs)
-{
-	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
-	u32 *aer_regs_buf = (u32 *)aer_regs;
-	int n;
-
-	if (!aer_base)
-		return false;
-
-	/* Use readl() to guarantee 32-bit accesses */
-	for (n = 0; n < read_cnt; n++)
-		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
-
-	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
-	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
-
-	return true;
-}
-
-/* Get AER severity. Return false if there is no error. */
-static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
-				     int *severity)
-{
-	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
-		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
-			*severity = AER_FATAL;
-		else
-			*severity = AER_NONFATAL;
-		return true;
-	}
-
-	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
-		*severity = AER_CORRECTABLE;
-		return true;
-	}
-
-	return false;
-}
-
-static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
-{
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-	struct aer_capability_regs aer_regs;
-	struct cxl_dport *dport;
-	int severity;
-
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return;
-
-	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
-		return;
-
-	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
-		return;
-
-	pci_print_aer(pdev, severity, &aer_regs);
-	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(cxlds, dport->regs.ras);
-	else
-		cxl_handle_ras(cxlds, dport->regs.ras);
-}
-
 void cxl_cor_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-- 
2.51.0.rc2.21.ge5ab6b3e5a


