Return-Path: <linux-pci+bounces-30864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92771AEA9EE
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6205D56646D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672523A9AD;
	Thu, 26 Jun 2025 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pVLiIsyl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA35F235C17;
	Thu, 26 Jun 2025 22:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977966; cv=fail; b=KREf+eicx2GXz2m5ZJM/gGbQU9bxJ4WOJZWI0GduzNh5YylzdQx2DzzjJY+0OQPWLn2KEgM9+UQDwS82wZD1qMywkkx1cXgov8mOUHPNOJFG7jV0pjulquNZd6tdKfk9PSk/6LBz3YLjqkJ4X1nToSuSKkfqsnS4YKDpcurjnDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977966; c=relaxed/simple;
	bh=ecOKydtbuMqc/2kxPifhqx/IYzJ1xnLymkYxOczpm04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FT+Jcvd285siaKcTzyjDYIjTXl+hrARkuwIOzKarV63QbRRLVPGID75LCot1ZBJKWd0e53FvZBDJDhQMNyxhTp5H/uopk574NpTC4PbIkLNk+pfJMy6eSoChm3AsMtRXMbsjP5BKXlXwIEMyPiG8bFY/QO6fhz30dORr9qBN8aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pVLiIsyl; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jp7kwC2Oo09mNtbyzJzxtKFBpwtGwA7kjxgtLN+SDMhadlqfTc37HgJWiOThaAzkyw6vda0sLcEfTid7t9HTtOMn4RdCeXM1Aq39Wk7XfUVGyIIPIjJmqceoVKUzbiS5PTd9ZYeutci6Ppz2XDCRj6V+qFSCIMTXy1MfgZlNoFa9Ywg8t+vQDtQsgNTWMIVNZL+lSR+AAstA7v59hhJHg1oL+J9OOXj4O4zcKCAWo6K0cWdzfqXVzvmbQEbPxwVCPJOY1LuvuHfXoWh0yXeFJnhIfxmlUMsioIt2cWqH3Os6GMfpaakEJRMIXzY9se48ovnmiim6ltN5SO5jC9kF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXt1R693WXXDOuY/jWTg0+lVwEOSWhLwCUK/QDPn0/8=;
 b=WayxzC/dFm6NRM7mL0uBLzMS0Ml1v+kL5iHh2V0BIUT+HK3MWwjNPMPR7SorAk3d76DVV1BzH1SMjSrW+W4ORqKw1a2WUztfc8wfAf5XR6nwL7hdauZYr8+t0lVh1BriXxOkJqmowz2x6AFQCs1Wyjj9W43zryghmYxPEoJV6aEahu9cfksurez7DjKZvvKdA1zqx/5IfhY0weeX47iIuhjiqq6T6V+Vl5FRo+unA8niiQLUPjqcNfkuWL2Q+77TyxcaaHjRox6dxem3kffCRm1nkQIG3eqIGiYaS+tiyO6nQhku4OSr2YEGuLPesVC9N5I3J5oEM9IHkmCEDCSwyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXt1R693WXXDOuY/jWTg0+lVwEOSWhLwCUK/QDPn0/8=;
 b=pVLiIsylk+Dh3UHDNl9wfANLNG9f8uSvVCHW148dXHJl8fnwbxBDTfdm0vRsImfOp87hgpFuak5DwQv+Ks2IRmUdijDTYt0cT6HaNv50HbJAg4/VlxL7qwsz/OIYo562Ru1+9bx1o+MAUbtSweWyXulCB9H5shUq2c5dN+W+9wk=
Received: from CH3P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::9)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 22:45:58 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::16) by CH3P221CA0007.outlook.office365.com
 (2603:10b6:610:1e7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Thu,
 26 Jun 2025 22:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:45:57 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:45:55 -0500
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
Subject: [PATCH v10 16/17] CXL/PCI: Enable CXL protocol errors during CXL Port probe
Date: Thu, 26 Jun 2025 17:42:51 -0500
Message-ID: <20250626224252.1415009-17-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e06c24-babb-4f69-a001-08ddb50337a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7GjUzS5FQDv7WrlM0wxy6gfGh0M4axsQyX1tvFyI09H4gPbEHymrzaFEHA40?=
 =?us-ascii?Q?IPvETrryOTQFc+ESFeA96AeLajQ+ShVPn/y4yVk7oKQFhaBNYoZQfyXqD5ZR?=
 =?us-ascii?Q?Bz6Rw11cUbYyw+YwVOAFgof/dhy18uZ1zKqk8SN//w3h2G7x4npS6lmzZ+LT?=
 =?us-ascii?Q?Dyh3AdEAQw2nuq5QV3m8FVm9z6H48AxzFp6kRSK2Ev1RvXvYt615cdbXa2nK?=
 =?us-ascii?Q?heH6fXw2Z0R05/8APA3adYBhSsCUDqVJSHS9oJ8DZMVq2z5gVjtmXLJ789sQ?=
 =?us-ascii?Q?fW6ao9GB4Ti/OlqXESnZrrk4mHuxY0pxo7JaMBb9JkEwkUHh1omv8Fa+cOnM?=
 =?us-ascii?Q?ly5Tvgc3spTki+y49bH2Z4cgOO/kbk13jLt/HJ//Fv+DTQb+dmP2twfORK6k?=
 =?us-ascii?Q?4g8eAdSTwE0o9ka5TNx1t7iO1IC0OJs/KxVGOOxUibuOxREaBeYAOqKl0vav?=
 =?us-ascii?Q?qS4YaS/Dc58Vul96H02n2XHqUFvKwKXCWJm4QlqkKNTYjGfOgtx4qua7nW+1?=
 =?us-ascii?Q?PNe0fv7LWLhGRaEPoB13DCBsQXruvhc2g4Hy1edzBjqvR2GGZRaLMX8YANvF?=
 =?us-ascii?Q?kLuzyYQiQN1nY74DRVZweMZPhIChp9GcFqvKP+hIIPST5uOnruXToM+59N8a?=
 =?us-ascii?Q?WYj+tU4P7a/qQEJK4/DjM9VJRrKrJ/swNDQG0S/crlqOVTqL2C4mP7TgdUn2?=
 =?us-ascii?Q?GWQs1nONK+Xj61lMzdjYGZPOUXGtdk7ln4CGad+JpVnsOH+Bvi7THR/9M+dr?=
 =?us-ascii?Q?mfhZsZVVZ+xgTgbR3rz/W1LXwBLQRsBWp5Q57MGqJ5zJ4Pw/n4JS8uBMEdKS?=
 =?us-ascii?Q?ZSX6+rrNt6Sf2tSfL/QxpuvLmzai/9QNTLqdY1sW8JBWDmI1/XmNhCVNtAji?=
 =?us-ascii?Q?r41O8ufsecHdVkkqGXIqv1CLrVMX2jyFx/2F1yDa42KylR03ZWTeKvmHbHnw?=
 =?us-ascii?Q?m92acLS3A4NuBD9do3cYenhPc2lc0X5mnMpX3/ncKBsZTiRtNdHuKH1tbzVx?=
 =?us-ascii?Q?DfDoZ3AnC25E0ShT78furpwWlgllkHFtwGMvD7jQxECkfOgW5oLQz+PMBgb8?=
 =?us-ascii?Q?5Tapr4ErWkq0ZxXvu1/6+na7aBwud8GPcCrYWzTjv/kYvPfTilFtmg8gsgKM?=
 =?us-ascii?Q?CGoNcSGklJvB8wb+9pbvKyjLDy+zfbS299H4fpxqzCCrviA2lG9PIy7+WyFx?=
 =?us-ascii?Q?bVWx5K8/FKYugUTsrPP5fMM2FSnGy4IDv/19GsEgtQ5I1IbAcCcZoct2GpHD?=
 =?us-ascii?Q?Ua6m4HE37VoNQVHBiIVIa915awJbmZofgDSXxdtvbQ2+aCsDyCLTBdk/slt+?=
 =?us-ascii?Q?oxxU7n7lZ/+0bjIGLIknjvYp9b75KfhXeIsYncPp9cmAPfkL37YyMGVRA405?=
 =?us-ascii?Q?+imHJOyk1B0BpknsW9OrY1pRKfY3VVQj2JASg/yYDy13FORvwJxDcGsISbv7?=
 =?us-ascii?Q?9Gf8hY4uyylWyJriB4PVQ4A2Ueh3G5KPgdXlSUm/o0zW4mGw4cic9LSr4c5l?=
 =?us-ascii?Q?9+kubpKdA5ZRXSDW4+HHCS09IuUkql0YbOK4riHgLREYnXdWZppBE2A3QQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:45:57.8955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e06c24-babb-4f69-a001-08ddb50337a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841

CXL protocol errors are not enabled for all CXL devices after boot. These
must be enabled inorder to process CXL protocol errors.

Export the AER service driver's pci_aer_unmask_internal_errors().

Introduce cxl_unmask_proto_interrupts() to call pci_aer_unmask_internal_errors().
pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
correctable internal errors and uncorrectable internal errors for all CXL
devices.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/cxl/port.c         | 29 +++++++++++++++++++++++++++--
 drivers/pci/pcie/cxl_aer.c |  3 ++-
 include/linux/aer.h        |  1 +
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index b52f82925891..b90f5efa5904 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -3,6 +3,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 
 #include "cxlmem.h"
 #include "cxlpci.h"
@@ -60,6 +61,21 @@ static int discover_region(struct device *dev, void *unused)
 
 #ifdef CONFIG_PCIEAER_CXL
 
+static void cxl_unmask_proto_interrupts(struct device *dev)
+{
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_dev_get(to_pci_dev(dev));
+
+	if (!pdev->aer_cap) {
+		pdev->aer_cap = pci_find_ext_capability(pdev,
+							PCI_EXT_CAP_ID_ERR);
+		if (!pdev->aer_cap)
+			return;
+	}
+
+	pci_aer_unmask_internal_errors(pdev);
+}
+
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 {
 	resource_size_t aer_phys;
@@ -118,8 +134,12 @@ static void cxl_uport_init_ras_reporting(struct cxl_port *port,
 
 	map->host = host;
 	if (cxl_map_component_regs(map, &port->uport_regs,
-				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_dbg(&port->dev, "Failed to map RAS capability\n");
+		return;
+	}
+
+	cxl_unmask_proto_interrupts(port->uport_dev);
 }
 
 /**
@@ -144,9 +164,12 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 	}
 
 	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
-				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_dbg(dport->dport_dev, "Failed to map RAS capability\n");
+		return;
+	}
 
+	cxl_unmask_proto_interrupts(dport->dport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
@@ -180,6 +203,8 @@ static void cxl_endpoint_port_init_ras(struct cxl_port *port)
 	}
 
 	cxl_dport_init_ras_reporting(dport, cxlmd->cxlds->dev);
+
+	cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
 }
 
 #else
diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
index 38dc82df0baf..3c5bf162607c 100644
--- a/drivers/pci/pcie/cxl_aer.c
+++ b/drivers/pci/pcie/cxl_aer.c
@@ -18,7 +18,7 @@
  * Note: AER must be enabled and supported by the device which must be
  * checked in advance, e.g. with pcie_aer_is_native().
  */
-static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
 	u32 mask;
@@ -31,6 +31,7 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 	mask &= ~PCI_ERR_COR_INTERNAL;
 	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
 }
+EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
 
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index f14db635ef90..8fb1eca97c37 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -113,5 +113,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs);
+void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #endif //_AER_H_
 
-- 
2.34.1


