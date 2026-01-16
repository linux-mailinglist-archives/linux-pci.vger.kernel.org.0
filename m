Return-Path: <linux-pci+bounces-45006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F0BD29AAE
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 02:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3224C308D792
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 01:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EC62DAFCC;
	Fri, 16 Jan 2026 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RScUNelM"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0349332EA7;
	Fri, 16 Jan 2026 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768527749; cv=fail; b=DyZGiuuRQ8VHCmOnJ/P3yxjy+EhFRMIWHUxeZrD2mZVHYuzSQ8JkCS9ba6YByHYLhzmYq5zpYYyJ+J4WzsQkTzhVfFCKTRbfkZj0eshl+j0VBlX37PsOduvu5yeCklZxNXPpDsQsWv5hxfNAKJpYunpgNw49pUj/zkiunQkeeEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768527749; c=relaxed/simple;
	bh=JP/Vwza3UfkniCGXJfXgOdIU1mp++M8oOt179IuQtUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9E5nRBormri+RrvcO27Mqmwx48OdF0xkJqpUQaDPF1whKD0csxuVVSBrQfN3KBIkJEsRDhLyRKtG5XWH81pHvk3Li1a3HgDcSnRw80A4O+nFRdG4ckO0YFTbNa9VyR8Y+inz4dPbxjYSnsF4izbV8RU1L5Bhdh+JndrQ4eYRCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RScUNelM; arc=fail smtp.client-ip=52.101.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QT8o0yMByPJ8V5hrjB5UWPhDlN+3PQC/3yx+gZMa+t+g5Te50xpPit7fcMwvPOFvRkuTc4SEQcMQInpUHq0gg5MsIxH20xrILxhsOfO3aLaJJcQSkfcUGGuRtdLvu4jgyTj1lg3K/2icO26B02sR6lVBSb/q8wiIo2ngjzhbjHZrEppWwd7TDSl9KKYOmbj2N3ZqrakIk3gbJP81hMIUIbDk5FZJMLRGg9h2t7PCGUT0wjDXrIIj3Kf322uo2+dw/sYVGe+63+ATWajpdPR8ZEAFpqRFm+ivxsm8DwaEX2hj6IUuBrQfirWlyXGVocn22mRqZeVaEKuduc5CxSb/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HP64AfHQTEd6lbss/eJgZaRZ8eoAuWMLfi5KN6pwpVo=;
 b=C2OO1hQENT2d0yr2VxLrZBZ5qjC7+zu0M8UDAWjDXdQ0FNs7iWWU0e5hbTHx8r1GwF0P1ZKsmvq6t/H3tuofGYalwW6m788TN1P0t00MfCOtgqgRTw8vW+eotKXmmVYzYl2aQps2aTF/GeOakk2KM/8mkwp4XrAn6bEOXv9oQD26Lfyhtwkf9AZB9N+M6aeUoCsGqIRS8C8e7yUaBVBX5Omyji1S1kuX7YjFcztf0KfGT1Hz9Kd5PB1tOtcxC/jDAXyLF9u/FC4g0y4YfT3lqOHaeljcFFOE2ucM0qgcU00yuJ1WmnefQTkfqwLnm3lPefjOymnSQgCxVDPVFXIU/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP64AfHQTEd6lbss/eJgZaRZ8eoAuWMLfi5KN6pwpVo=;
 b=RScUNelMh+cgdmbl5+vIFNoVKh7yt4nvkcm2URr3xxEx9S3KpaMjDCWnvz9dh+rK+tYal58yBrb9fBJ0fBoY01YM4pCtAVYKjEgCEiCyu4lstrJUvByw4YugkM3F4MeQw7ZFt4Z6f24ONVur4gSfKclQsHPgUBoFnqsakmGyH9H1GX2mpg0CNEoS3ef1BHzx8RKwWWClF1xE3Wmap2Qm9MKMecnU1TPUj6014d5+6bIaZLihsrl6pDwaMUTS3MCQNmUaSPreQvDUR2dASIClTaKyHl/+bq+S2n1KoxxU5jBOuYPnyt7rY89YeKavg69Tc/ED8/4mOl7hvNj9D/rHkw==
Received: from DM6PR11CA0036.namprd11.prod.outlook.com (2603:10b6:5:190::49)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 01:42:10 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::5) by DM6PR11CA0036.outlook.office365.com
 (2603:10b6:5:190::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 01:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 01:42:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:41:55 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:41:54 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 15 Jan 2026 17:41:53 -0800
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
Subject: [PATCH v3 2/10] PCI: switch CXL port DVSEC defines
Date: Fri, 16 Jan 2026 01:41:38 +0000
Message-ID: <20260116014146.2149236-3-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: a4275194-e9ad-4984-35e4-08de54a076f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DwkTqcXbrOGfvRb7X58Y/RsgBM4Tv82dY5d/Y11juufYMkD2FyzMJwTRjCKD?=
 =?us-ascii?Q?lfJHzoib33GcBjnUxEXwVH1V7x8wM9uM/HaV8GDAzPlRm1MDIeaToTRrsoYz?=
 =?us-ascii?Q?O9cRDzB/RP7hMR/OAh5jM1mPgLRhLOMefJqZInMmC3nOfEJvyomcQeVxg7B4?=
 =?us-ascii?Q?ZkaHFU5Y16zT2IDboSrbAvGl5G5h4CbBLe7iKJBfJ2kT/OM1hb3V7Y29vQEp?=
 =?us-ascii?Q?BNIorgp4zKC8udNf+VWW44PNrbFn08jHAHxvy4EDWjKB11A52ArgGVfLa3G8?=
 =?us-ascii?Q?Zva8HzZKzSt9cp3yhFZUpNPZGG8qxdmeE9n8oB/Pz36hWD8dbGMxGafe5pNW?=
 =?us-ascii?Q?Cu715wL23Ympq3MgTpykkbpr6w8X5YHtaWbWFzfnwQnk3CVK83xmlmweNvBD?=
 =?us-ascii?Q?RvnvNRkiORIal0npyF8f7F6jiEYq9Bs/z7KIj0JtY+DlkucS9sbxgWbleePA?=
 =?us-ascii?Q?scazjdqyeXF87hYiDj+vor1KUm8udZ/0StLrlsWHl89VXubbuV9Ok1KfvHWO?=
 =?us-ascii?Q?BJPqBkZE0wP2QbDDjY+WbCS0DgZ82/+XN6ygw2hav3xOzhX8JLGbn5o0i3mc?=
 =?us-ascii?Q?pZSpN7d78Pxg85OuWOGPjxgOUhC3Bud4GHvMQkrMYTSr0xVS7l3ZYWvj/C26?=
 =?us-ascii?Q?INbfYHdlR3XVpgon+CjgM0T90eXCOhpkBKlMbwsNHM+72G7hH1+Lo0xlzMDW?=
 =?us-ascii?Q?uammJBO2OE1V5osbDnubaEGCzgEpBHzhFRGHio/OhBDSMylq1OcAuNUvEVDJ?=
 =?us-ascii?Q?rw4GeAR3y0M74t2lhaDishsYdbGvHl+X0Iu1u305gOwvw3mMgLzc3NMx8hNO?=
 =?us-ascii?Q?bcLCj7PYhEbdGZMQHq0ibX3d7GlBAfx5/pqIfu/hR7tJIrYG9ZHkwyxq/qPL?=
 =?us-ascii?Q?+SCbv8TOZFuQB0LWqOS2KpGLWF4PBiOoSwsEdmU5VpBuEVso3FGh3sAH3iIf?=
 =?us-ascii?Q?KXWDRcDYCY5MPhEu2Dy6FnVeAOJlgVaMvhT3AnrX9NgTxpMmgzYVlZS/JlWc?=
 =?us-ascii?Q?3v672eAHLZSdItMH0agDVapdUu6QgH+xU1s4NesSCIgWEpftIE0j4DNjtiRU?=
 =?us-ascii?Q?JEpUCzNTOMM8PssS8XcdZU145NOT69D0M9kYx1pifvfJXoY6Z44w/cW2Bg4X?=
 =?us-ascii?Q?kYH/nAvbhXnAc0l5kBgCvaoZ/3CnVO07vfbFA4h3TCg8mSEd4GgXuM7U9k8F?=
 =?us-ascii?Q?/HND7mk5MiA+6CosIwRngp0/uKaRfHsP7/UKTYDWR6LPApu5g9oEtDwTp5op?=
 =?us-ascii?Q?+amnCgJq4qQe16L3GQMRaO8iWNMN9jFRRNSv1/lP6+Zx5JUAehGfqRo6dRRd?=
 =?us-ascii?Q?e+CvLkHMAyqhLJNQMEoWTC1kwOF/csVKK3ifjUk/7+3YE1NTTbkiwbzGfkmx?=
 =?us-ascii?Q?ryN22HAeGKR76RhoeiaFZbDqqbBvxcKp7GdzZF27dHqNYRRV3H/Z3h0tvNS3?=
 =?us-ascii?Q?fTL6hu41U9ArByUM9rCiwCyGzzIsWnXoow3U056yWSU7EQ/D927BYKe6sGRv?=
 =?us-ascii?Q?IG4BKVDUFUIi3Dlifa6wD4IsmQbd1L7yh6BSbvu4+WfDRQvWG0b5WP97FjSD?=
 =?us-ascii?Q?iqGnPLB3fPrXnj26kOVLJ2K8FHWiOYgXGgG7AZwQ5d8dJG7hsAYfkiI0wnYb?=
 =?us-ascii?Q?VrZxxfUBZbA4qhaxNOPzlOE2U7z5gOezSgVKoFA9mnhtKz0WvNatC2ZLCyCX?=
 =?us-ascii?Q?Ktp868HUrqbGpLbTwL6rVRDbor8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 01:42:09.8554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4275194-e9ad-4984-35e4-08de54a076f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897

From: Srirangan Madhavan <smadhavan@nvidia.com>

The PCI core consumes CXL port DVSEC fields for reset handling, so
switch it to use the shared CXL PCI header instead of the uapi header.
This aligns the core with the header split and keeps internal code from
depending on uapi-only definitions.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/pci.c             | 17 +++++++++--------
 include/uapi/linux/pci_regs.h |  5 -----
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..8bb07e253646 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -30,6 +30,7 @@
 #include <asm/dma.h>
 #include <linux/aer.h>
 #include <linux/bitfield.h>
+#include <cxl/pci.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -4842,7 +4843,7 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 static u16 cxl_port_dvsec(struct pci_dev *dev)
 {
 	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
-					 PCI_DVSEC_CXL_PORT);
+					 CXL_DVSEC_PORT_EXTENSIONS);
 }
 
 static bool cxl_sbr_masked(struct pci_dev *dev)
@@ -4854,7 +4855,7 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 	if (!dvsec)
 		return false;
 
-	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_PORT_CTL, &reg);
 	if (rc || PCI_POSSIBLE_ERROR(reg))
 		return false;
 
@@ -4863,7 +4864,7 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 	 * bit in Bridge Control has no effect.  When 1, the Port generates
 	 * hot reset when the SBR bit is set to 1.
 	 */
-	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)
+	if (reg & CXL_DVSEC_UNMASK_SBR)
 		return false;
 
 	return true;
@@ -4908,22 +4909,22 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;
 
-	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+	rc = pci_read_config_word(bridge, dvsec + CXL_DVSEC_PORT_CTL, &reg);
 	if (rc)
 		return -ENOTTY;
 
-	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
+	if (reg & CXL_DVSEC_UNMASK_SBR) {
 		val = reg;
 	} else {
-		val = reg | PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
-		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
+		val = reg | CXL_DVSEC_UNMASK_SBR;
+		pci_write_config_word(bridge, dvsec + CXL_DVSEC_PORT_CTL,
 				      val);
 	}
 
 	rc = pci_reset_bus_function(dev, probe);
 
 	if (reg != val)
-		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
+		pci_write_config_word(bridge, dvsec + CXL_DVSEC_PORT_CTL,
 				      reg);
 
 	return rc;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3add74ae2594..4f9e6dddc282 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1253,11 +1253,6 @@
 #define PCI_DEV3_STA		0x0c	/* Device 3 Status Register */
 #define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-mode detected) */
 
-/* Compute Express Link (CXL r3.1, sec 8.1.5) */
-#define PCI_DVSEC_CXL_PORT				3
-#define PCI_DVSEC_CXL_PORT_CTL				0x0c
-#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
-
 /* Integrity and Data Encryption Extended Capability */
 #define PCI_IDE_CAP			0x04
 #define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
-- 
2.34.1


