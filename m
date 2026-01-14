Return-Path: <linux-pci+bounces-44800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAD7D20CAE
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4395E304F8B4
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EAB2F39D7;
	Wed, 14 Jan 2026 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RbKBKeRN"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011071.outbound.protection.outlook.com [52.101.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B5184;
	Wed, 14 Jan 2026 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414966; cv=fail; b=gPPPYo8wwszOdZLsWvu7eTRSA7uKlI+DkY3bvLyQL6xQAjr9f4BC96O6HV6a/r2yKcVQnnNT8jS0hurWhCyPHmwZJDFIgQd85weVhR8vlstO0ARKfnZe2U6RULoPRH7D4z1CmYUyV+M2A3oxQ8xhrSVz1VckkpzE8jCoA+OYTm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414966; c=relaxed/simple;
	bh=vz5cPF1NawMzP1jAgTWjC9mCr0eMNXwcCMAtwOjTLVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nB3UV9G+b27WJw1bVkwW3Ay02YiZYV3vxkOFXFmAnJl/rJx3OqqFwzhq/QpOS+OlQ5W+3zR3JnK45OhkqRx3RNGjUOFbfhw1wYeUnZ0ECezTvjJKeFxqdZQIplSBGevdIqvAGZX2qATr7xyW4XS9cYa1IicVpESh+U+nS/Un94g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RbKBKeRN; arc=fail smtp.client-ip=52.101.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ru2/2R3kzrcLw/MWL5rDdilTQMSggdc2VwodWOjSWfnFAOm5kUOEzXd7qr6hATBIaeW2YWYy9b3Lw/Ugp7aR4PItUCWz/LP4gD4bbZtkIX6HgS03OBvw9Mdw24VnyiUqL2D/zQTUafEXQ0objj2pVrJkZss6u7bN8jOcXW6IPEk6TTnIAVbemLbxoeYDWREpzODC4ae7BzvoDyW8r5LrM3nyTv5+PygTqmqLE7wap25TSJv0kSqJUFwl1OPahMc/W8eAV2BmAl5DyiNSy1K1LP/yHYCAOvZIEsLurOYqyp95LYj7rqhnAv9p9QMpVcaM848CY1CMgT+WlK/U6YZeCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT+xIZ24RPg02QNEVmqDfATTfxzv7T5jgrkuFvEobpU=;
 b=yIyneO8//wzLfnYzPn+APobHt+Y8YSM843rio7QxUgI0WEm52Olx3/ARYV5zJJf5L62nbV9LsBNKWv+oLWhpGqN8CGP1aFBh+0z0RoJO0HpQmqsx8uDdPGGQD3hTJ05MINAPotLPxrySo1bVq0wBULvx282NGWaxPKeVNdDsXv/OO/NUR220l2ShN05hHl+4m6gtHyzdR89pWGLnNlS2Dj3sbF2Po8Cr0n3GNxLv/ORIEJ5nz3jSg3+ZqcAnqUXiDwEzJA2t+7yAymTj8UjtmK5mw7JoWwNwOIedoFlYmLLI18Tqi3xjgEwUVZ1cFp6JJ0TJh/2L7LOW2XTSvda7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT+xIZ24RPg02QNEVmqDfATTfxzv7T5jgrkuFvEobpU=;
 b=RbKBKeRNKI/3so2oycK3uLlqsBNFbdVdSFKFl3d6Yabar0lYVVCe+DhDvNXd4phdndH1X7kPCuCtCsu0vPrIsWYN+IjY8Td2Ry+UUPyiHu6mQH2PA1CuQljNsOW/lh53r0lFfRCQixREp3RsrJ1e9Rbp/AHV3A6/j3R2ylm96sg=
Received: from PH7PR17CA0051.namprd17.prod.outlook.com (2603:10b6:510:325::14)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 18:22:36 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::bd) by PH7PR17CA0051.outlook.office365.com
 (2603:10b6:510:325::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 18:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:22:34 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:22:34 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 07/34] cxl/pci: Remove CXL VH handling in CONFIG_PCIEAER_CXL conditional blocks from core/pci.c
Date: Wed, 14 Jan 2026 12:20:28 -0600
Message-ID: <20260114182055.46029-8-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e7421d-fcaf-4c64-11dc-08de5399e3d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7S3rfFkacs8Ex2BztGVyQ8muJv0fe8MBNZL8mmAgfhIbnK+l4ldsBa0hx+EV?=
 =?us-ascii?Q?ooXpT6MmOiUW5CC7XUEKHdAkEidoIzzW3f03m4+/NClqJdek2vmYcbcmNCIV?=
 =?us-ascii?Q?FmGRcGxOBPMg5hmaP2pQ1bCVNnNbGysvRpxXn1/bihlMxPQnLaRNDuoZuEyL?=
 =?us-ascii?Q?CrXqoFbPbJF1T2iiB7jZ5wTyp3RMTD3KxZNF5G6paGkdnpk28aiR+bhatOAk?=
 =?us-ascii?Q?OSXsx5aGf963WlS/6X1Jp6Ip/15Jk4orwx7L+G8AtUx/zBadqNirhyUjpgx8?=
 =?us-ascii?Q?rMCDyAzV95rMOh0CLPv+xW/Jv+lQChM70OTRD6KggxfYWXg3Z6wWY4uMPV1F?=
 =?us-ascii?Q?j5//ANpB+reeev0lLtlN53rm5RBshfkP+K2IQwN17Mgknp5ep7OJ60VWSAn3?=
 =?us-ascii?Q?/BiZHkiA2/wiJsh0muOVXsZFhWTjUcu9iXyLi8L5gxrceA0IeEfLuLxgprwa?=
 =?us-ascii?Q?dToPFNdRFcNMmAAnpJls9joVN9cfHNvIhHPGnl5ojPgD3zm0qWPfLhepkOLF?=
 =?us-ascii?Q?bEasIwT8IVm0/c9uLaXqWXpSjlQLRkl2g0qNue+d6xxvUxZ27wSHkKCy7yeC?=
 =?us-ascii?Q?ryxOuhDCu2M7fm2mld6MnoM4UQFWNE0LpXY7jMRmjgPib+J8eSq9ts39iiiZ?=
 =?us-ascii?Q?mRGBeRheatEZHaYoGnUshleYE9jr1tJL28HXe4HCs8SHWDL/tjWW4bSRfo7j?=
 =?us-ascii?Q?89YIPBxb5hnh7DA+/PvrxMgCDThQ0W/4xCoKwP3l2X5SA0aSV5IB2ua1wvVP?=
 =?us-ascii?Q?R8RsdNTfwU4rcCOGew6qEXDGotr3Keb177HwrrSOqrKkOnRO2ar29CZx5tRi?=
 =?us-ascii?Q?1ZLUwWmNvMHxNNpD9pvStoxah0Ie+bGx0iyZUydGsx/L9ZAXo9B68X3oAOTT?=
 =?us-ascii?Q?0StUPdAIsM4T7EYUJ84N109nUID0Wys0RH0xl97CNb2F2A5R0TFBhvDSBstu?=
 =?us-ascii?Q?vCHplIAqm8EEetqyT5wOYdadwmRNPPMMf5ygdlvPsoZ2Kcl/iVGQeDhD320D?=
 =?us-ascii?Q?GKS7Bl4Zy98SljFCv6Q5h+nKU+VKt13dwxM2IiUdWbAJC+17zABZvQp2taas?=
 =?us-ascii?Q?X4vf8pHe0/uZic/FsnMq2PBhOvjWoT7HlISHCgcCBMx0JSQsO6BugoU4WlUY?=
 =?us-ascii?Q?vRY3f917a5DoXat4bZVfw6lWgqgutusJBsny71LkaaJUem2Ac9tLPMD6cCzh?=
 =?us-ascii?Q?AYb0WeDu3gutz5fTjrofJsJgrrSO+h6IAG6Uie9JBPv6DG5d2s+Db1U9EGl8?=
 =?us-ascii?Q?RfETaYe9H9i06G4ZdPkwJGmX75NJzpt9+rTHhl7imQiEXXH5h/uBFZH61C1+?=
 =?us-ascii?Q?P7yrfjbD7rFaML54mCCPv3BqOHe1OUzFqln/OiGZlvCL2fJBAVG0s1g0rsog?=
 =?us-ascii?Q?G6R5KJwfceLEaXW14VgZnZysNbJX4YXRKE49zZvT4ghVlAXg/KwOP7VOcJz1?=
 =?us-ascii?Q?uzwkz/iSHrRaZZG/AGWgusQdJW8u+mgw1JeV3cGX0XDSTMsHd0mv5VA7Mbnc?=
 =?us-ascii?Q?bad8XvDS4EIsPixCauiSy7AuVmCc3/bOVzDyl1i4W+hgdUyNV7OvFJuYjEcR?=
 =?us-ascii?Q?dTm0jeZ9rutMgYbBGG0ATdUSqAjwAk8eJG/o/lT/JGIzhdTLjE+Stt4HlHUW?=
 =?us-ascii?Q?VX2Rlc+FXSom/gHlzDRsgby8ImGB0KlJ++U9NjZa8MxuLfAEnW6ZliU+LsRn?=
 =?us-ascii?Q?Hie6SY5EFywfpkVv83xBq1rBOXg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:22:34.9993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e7421d-fcaf-4c64-11dc-08de5399e3d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375

From: Dave Jiang <dave.jiang@intel.com>

Create new config CONFIG_CXL_RAS and put all CXL RAS items behind the
config. The config will depend on CPER and PCIE AER to build. Move the
related VH RAS code from core/pci.c to core/ras.c.

Restricted CXL host (RCH) RAS functions will be moved in a future patch.

Cc: Robert Richter <rrichter@amd.com>
Cc: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes in v13->v14:
- None

Changes in v12->v13:
- None

Changes in v11->v12:
- None

Changes in v10->v11:
- New patch
- Updated by Terry Bowman to use (ACPI_APEI_GHES && PCIEAER_CXL) dependency
  in Kconfig. Otherwise checks will be reauired for CONFIG_PCIEAER because
  AER driver functions are called.
---
 drivers/cxl/Kconfig       |   4 +
 drivers/cxl/core/Makefile |   2 +-
 drivers/cxl/core/core.h   |  31 +++++++
 drivers/cxl/core/pci.c    | 189 +-------------------------------------
 drivers/cxl/core/ras.c    | 176 +++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   8 --
 drivers/cxl/cxlpci.h      |  16 ++++
 tools/testing/cxl/Kbuild  |   2 +-
 8 files changed, 233 insertions(+), 195 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..217888992c88 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -233,4 +233,8 @@ config CXL_MCE
 	def_bool y
 	depends on X86_MCE && MEMORY_FAILURE
 
+config CXL_RAS
+	def_bool y
+	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
+
 endif
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 5ad8fef210b5..b2930cc54f8b 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -14,9 +14,9 @@ cxl_core-y += pci.o
 cxl_core-y += hdm.o
 cxl_core-y += pmu.o
 cxl_core-y += cdat.o
-cxl_core-y += ras.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
+cxl_core-$(CONFIG_CXL_RAS) += ras.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1fb66132b777..bc818de87ccc 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -144,8 +144,39 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 
+#ifdef CONFIG_CXL_RAS
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
+bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
+void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
+#else
+static inline int cxl_ras_init(void)
+{
+	return 0;
+}
+
+static inline void cxl_ras_exit(void)
+{
+}
+
+static inline bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+{
+	return false;
+}
+static inline void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base) { }
+#endif /* CONFIG_CXL_RAS */
+
+/* Restricted CXL Host specific RAS functions */
+#ifdef CONFIG_CXL_RAS
+void cxl_dport_map_rch_aer(struct cxl_dport *dport);
+void cxl_disable_rch_root_ints(struct cxl_dport *dport);
+void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
+#else
+static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
+static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
+static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
+#endif /* CONFIG_CXL_RAS */
+
 int cxl_gpf_port_setup(struct cxl_dport *dport);
 
 struct cxl_hdm;
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 51bb0f372e40..e132fff80979 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -632,81 +632,8 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
-			       void __iomem *ras_base)
-{
-	void __iomem *addr;
-	u32 status;
-
-	if (!ras_base)
-		return;
-
-	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
-	status = readl(addr);
-	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
-		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
-	}
-}
-
-/* CXL spec rev3.0 8.2.4.16.1 */
-static void header_log_copy(void __iomem *ras_base, u32 *log)
-{
-	void __iomem *addr;
-	u32 *log_addr;
-	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
-
-	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
-	log_addr = log;
-
-	for (i = 0; i < log_u32_size; i++) {
-		*log_addr = readl(addr);
-		log_addr++;
-		addr += sizeof(u32);
-	}
-}
-
-/*
- * Log the state of the RAS status registers and prepare them to log the
- * next error status. Return 1 if reset needed.
- */
-static bool cxl_handle_ras(struct cxl_dev_state *cxlds,
-			   void __iomem *ras_base)
-{
-	u32 hl[CXL_HEADERLOG_SIZE_U32];
-	void __iomem *addr;
-	u32 status;
-	u32 fe;
-
-	if (!ras_base)
-		return false;
-
-	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
-	status = readl(addr);
-	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
-		return false;
-
-	/* If multiple errors, log header points to first error from ctrl reg */
-	if (hweight32(status) > 1) {
-		void __iomem *rcc_addr =
-			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
-
-		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
-				   readl(rcc_addr)));
-	} else {
-		fe = status;
-	}
-
-	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
-	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
-
-	return true;
-}
-
-#ifdef CONFIG_PCIEAER_CXL
-
-static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
+#ifdef CONFIG_CXL_RAS
+void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 {
 	resource_size_t aer_phys;
 	struct device *host;
@@ -721,19 +648,7 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
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
-static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
+void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 {
 	void __iomem *aer_base = dport->regs.dport_aer;
 	u32 aer_cmd_mask, aer_cmd;
@@ -757,28 +672,6 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
 }
 
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
 /*
  * Copy the AER capability registers using 32 bit read accesses.
  * This is necessary because RCRB AER capability is MMIO mapped. Clear the
@@ -827,7 +720,7 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
 	return false;
 }
 
-static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
+void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	struct aer_capability_regs aer_regs;
@@ -852,82 +745,8 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	else
 		cxl_handle_ras(cxlds, dport->regs.ras);
 }
-
-#else
-static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
 #endif
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
-{
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct device *dev = &cxlds->cxlmd->dev;
-
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return;
-		}
-
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
-
-		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
-	}
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
-
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state)
-{
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlmd->dev;
-	bool ue;
-
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return PCI_ERS_RESULT_DISCONNECT;
-		}
-
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
-		/*
-		 * A frozen channel indicates an impending reset which is fatal to
-		 * CXL.mem operation, and will likely crash the system. On the off
-		 * chance the situation is recoverable dump the status of the RAS
-		 * capability registers and bounce the active state of the memdev.
-		 */
-		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
-	}
-
-
-	switch (state) {
-	case pci_channel_io_normal:
-		if (ue) {
-			device_release_driver(dev);
-			return PCI_ERS_RESULT_NEED_RESET;
-		}
-		return PCI_ERS_RESULT_CAN_RECOVER;
-	case pci_channel_io_frozen:
-		dev_warn(&pdev->dev,
-			 "%s: frozen state error detected, disable CXL.mem\n",
-			 dev_name(dev));
-		device_release_driver(dev);
-		return PCI_ERS_RESULT_NEED_RESET;
-	case pci_channel_io_perm_failure:
-		dev_warn(&pdev->dev,
-			 "failure state error detected, request disconnect\n");
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
-	return PCI_ERS_RESULT_NEED_RESET;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
-
 static int cxl_flit_size(struct pci_dev *pdev)
 {
 	if (cxl_pci_flit_256(pdev))
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 2731ba3a0799..b933030b8e1e 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -5,6 +5,7 @@
 #include <linux/aer.h>
 #include <cxl/event.h>
 #include <cxlmem.h>
+#include <cxlpci.h>
 #include "trace.h"
 
 static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
@@ -124,3 +125,178 @@ void cxl_ras_exit(void)
 	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
 	cancel_work_sync(&cxl_cper_prot_err_work);
 }
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
+void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+{
+	void __iomem *addr;
+	u32 status;
+
+	if (!ras_base)
+		return;
+
+	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
+	status = readl(addr);
+	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
+		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+	}
+}
+
+/* CXL spec rev3.0 8.2.4.16.1 */
+static void header_log_copy(void __iomem *ras_base, u32 *log)
+{
+	void __iomem *addr;
+	u32 *log_addr;
+	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
+
+	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
+	log_addr = log;
+
+	for (i = 0; i < log_u32_size; i++) {
+		*log_addr = readl(addr);
+		log_addr++;
+		addr += sizeof(u32);
+	}
+}
+
+/*
+ * Log the state of the RAS status registers and prepare them to log the
+ * next error status. Return 1 if reset needed.
+ */
+bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+{
+	u32 hl[CXL_HEADERLOG_SIZE_U32];
+	void __iomem *addr;
+	u32 status;
+	u32 fe;
+
+	if (!ras_base)
+		return false;
+
+	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
+	status = readl(addr);
+	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
+		return false;
+
+	/* If multiple errors, log header points to first error from ctrl reg */
+	if (hweight32(status) > 1) {
+		void __iomem *rcc_addr =
+			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
+
+		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
+				   readl(rcc_addr)));
+	} else {
+		fe = status;
+	}
+
+	header_log_copy(ras_base, hl);
+	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
+	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
+
+	return true;
+}
+
+void cxl_cor_error_detected(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct device *dev = &cxlds->cxlmd->dev;
+
+	scoped_guard(device, dev) {
+		if (!dev->driver) {
+			dev_warn(&pdev->dev,
+				 "%s: memdev disabled, abort error handling\n",
+				 dev_name(dev));
+			return;
+		}
+
+		if (cxlds->rcd)
+			cxl_handle_rdport_errors(cxlds);
+
+		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
+
+pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
+				    pci_channel_state_t state)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *dev = &cxlmd->dev;
+	bool ue;
+
+	scoped_guard(device, dev) {
+		if (!dev->driver) {
+			dev_warn(&pdev->dev,
+				 "%s: memdev disabled, abort error handling\n",
+				 dev_name(dev));
+			return PCI_ERS_RESULT_DISCONNECT;
+		}
+
+		if (cxlds->rcd)
+			cxl_handle_rdport_errors(cxlds);
+		/*
+		 * A frozen channel indicates an impending reset which is fatal to
+		 * CXL.mem operation, and will likely crash the system. On the off
+		 * chance the situation is recoverable dump the status of the RAS
+		 * capability registers and bounce the active state of the memdev.
+		 */
+		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
+	}
+
+
+	switch (state) {
+	case pci_channel_io_normal:
+		if (ue) {
+			device_release_driver(dev);
+			return PCI_ERS_RESULT_NEED_RESET;
+		}
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	case pci_channel_io_frozen:
+		dev_warn(&pdev->dev,
+			 "%s: frozen state error detected, disable CXL.mem\n",
+			 dev_name(dev));
+		device_release_driver(dev);
+		return PCI_ERS_RESULT_NEED_RESET;
+	case pci_channel_io_perm_failure:
+		dev_warn(&pdev->dev,
+			 "failure state error detected, request disconnect\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ba17fa86d249..42a76a7a088f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -803,14 +803,6 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 struct device *dport_dev, int port_id,
 					 resource_size_t rcrb);
 
-#ifdef CONFIG_PCIEAER_CXL
-void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
-void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
-#else
-static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
-						struct device *host) { }
-#endif
-
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index cdb7cf3dbcb4..6f9c78886fd9 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -76,7 +76,23 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
 
 struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
+
+#ifdef CONFIG_CXL_RAS
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
+#else
+static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
+
+static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
+						  pci_channel_state_t state)
+{
+	return PCI_ERS_RESULT_NONE;
+}
+
+static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
+						struct device *host) { }
+#endif
+
 #endif /* __CXL_PCI_H__ */
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 0e151d0572d1..b7ea66382f3b 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -57,12 +57,12 @@ cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
-cxl_core-y += $(CXL_CORE_SRC)/ras.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
+cxl_core-$(CONFIG_CXL_RAS) += $(CXL_CORE_SRC)/ras.o
 cxl_core-y += config_check.o
 cxl_core-y += cxl_core_test.o
 cxl_core-y += cxl_core_exports.o
-- 
2.34.1


