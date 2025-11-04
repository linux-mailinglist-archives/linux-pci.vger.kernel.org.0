Return-Path: <linux-pci+bounces-40237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A4FC32399
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F0474F53A7
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6A4338F52;
	Tue,  4 Nov 2025 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0R8L0Wmg"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2856338587;
	Tue,  4 Nov 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275852; cv=fail; b=SwUjQFQk9BQnH5ZTroK+A7PKIRQU5nCHTp/+EHeMZ4ijD1r9ry/lGaagr7kkDtlkmRWL8H8wMjB7gLV1R/UpfU/uupd1U8aAvnkeB3mkyC17M6eGDFq/Jwx/2P5hy17zKjNc5VbOEkQlE7upplm4uvimUWx3FrfVa4qdeVOC39Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275852; c=relaxed/simple;
	bh=S1kqldKJ9/mCCNNiYsnqO4o8ImG6ylN7tTpmQ+R+IhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBZvQ2G2ayKfI++nkfrhCJ3ZjL/8SP2SXTyIwjSA+22/upG5vYaDTxc7nWyi9BzoA4VEo73w4nd7PIPqqYroSJphraQncMAE9SF312Tnoz4FsZp30Om0dzIL4RE5lpMaGTLbrIy2X7M89b2uupA+BFN+Z7wSv5AwhOT2fhj3C/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0R8L0Wmg; arc=fail smtp.client-ip=52.101.61.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0W+BX4vTtvvQuSGgljqBt8glKSyKr60KkWM1WsLudjLZDuWAhBKy/QtU8+S7zDcgNGMGYqib7uQ2cxICevUWF5tX35gJtEAcTGEQl8+kcTCBGg4vby/3sN99aWPYyjO4KlPoMMd/1KeC1QQ8aNp08+sZJH08QUx6r15jnGdoEBivGxjxen1H9fGN5RXmcVYNZgf3BTo1s3h/7t/YgWdGzM7DH8nuDSZ9cOCMGDNNu4LUB5Y/zwtVcWh+7P0qonzgysa8nWsZ5vTX+VP2iJSARwe2qcrNgIKVn/09dnfNTUDOcvPm2lIpsLRzLeN6gSRYtGYlAaGumnYLslA9vIpog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q9NaQhkh/fSvycGEgGjUPC18U8a+0EMkZV9I7BOad8=;
 b=XLyD4C62sI/SjscQY4y6gEdWP6HY9yQUz4JtZR3gJm7dsL3dytA8L7iwdZDEfeUWRt7kQ+/4ZhsHDu2Acmsg2W9iiSfMEYIGP2Hgz8Lw48RyL2uH9aKoVQo28UiT5KeQ7rrlWfuaaRtDmsSbeieEEsjMWd/hOCVRwEy15+0R0iJiz2iqkI6q5wBE60dOsuZAfE+Hq2K0nOPxk0LjrUHBysCEp1sBpc5rO2WrLS8GzgJEEEeHHIEN3Xh1P84b5GKQXi71bsDvoSzRd0GrSHYJtQqKjk3t/eJ2ZvzkKS0U47hY32N1zwpVNBnsIWfhMgHu9uPLjlIKCvW4qulxTj+q/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Q9NaQhkh/fSvycGEgGjUPC18U8a+0EMkZV9I7BOad8=;
 b=0R8L0Wmglnr2S5jRq9fmjN1xUcF9+68+YxX3m+MEVZAA5/VdSTNt4kTAFLfPvKe1Cx2sYYrae9gCA6HXEDoA3Uy2+rTk+865QhxmEUHYuZOs/7MbPT+yXNZNHhwhvj4CY1Yybqi9qEIeX41glkR4twddDIR74Vu50vk6GGlnSWk=
Received: from BL0PR02CA0108.namprd02.prod.outlook.com (2603:10b6:208:51::49)
 by CH3PR12MB9080.namprd12.prod.outlook.com (2603:10b6:610:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 17:04:08 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::ee) by BL0PR02CA0108.outlook.office365.com
 (2603:10b6:208:51::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 17:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:04:07 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:04:06 -0800
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
Subject: [RESEND v13 05/25] cxl: Remove CXL VH handling in CONFIG_PCIEAER_CXL conditional blocks from core/pci.c
Date: Tue, 4 Nov 2025 11:02:45 -0600
Message-ID: <20251104170305.4163840-6-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CH3PR12MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: a71acd43-474e-4aed-5c11-08de1bc42aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nl4gkvjHPOxqsAIDqq0JVDc6YfS7CTz16V5SiXSy/QlYxHbMiK3ZzLR0BVpi?=
 =?us-ascii?Q?m4QP4I/yBF68J7FZqY7b3BV5iYLjAVvF09T+fSgJONtv97+uUYZ3sMjKuPGL?=
 =?us-ascii?Q?kaJT4depXdKZzFtA8iExCQnBsS3U2kZzzJPhw9Q/yIr984nPOHyQGRhKx5z8?=
 =?us-ascii?Q?FrZsauEOBSjvVoflwEHZ1t+hkyGPWBlSugAiDhlWal1Mf5byMX6/nFbOLLAX?=
 =?us-ascii?Q?jaIz/jS+eQedNlNjEniG/AjDnDEj7QohQzykmVuswF3EDKnqYm+fJPGSAHnO?=
 =?us-ascii?Q?YUyF8hgS9WHMrr6zcVFsfF/ZqB+7bwpg/mw0CHoOi/+5eSonV6aU4DG/5BHF?=
 =?us-ascii?Q?jphmyhp/Tqe5KjHLdI86AxG8XNy6SMo+VEHtzTH+WBuHFrkC0/aAZpmpBXW/?=
 =?us-ascii?Q?vDv1m1BvLLaPbamQnwPI+CnmWLR7vQ2YIh385jfFnRmKSzUU1jJs4OU5KwwD?=
 =?us-ascii?Q?TStcUj/ktuDgOTnniveBk/0+QmRnW3fF1+OLCS+vHF9DDmn17b3EYXYGtY/Y?=
 =?us-ascii?Q?dV7D8oIiYu9wWDup6XV9YgwsZ43MZ9GEMAlVX9ZfG6IXDeLKZ2Lni6r+4CFn?=
 =?us-ascii?Q?crJHtSLsNFlzl6OUKxWfO1oPUYzth0fs0Q9oqQnqsSgoJK0U++qjmjyc+0Kd?=
 =?us-ascii?Q?M6z5I1LKjh5bvWv5zbPefKL2/gxT+SutoJpdpNcY+B4jwXzgd2GChTq+Btjn?=
 =?us-ascii?Q?XFeKZmMycGb0hLZwF1f9liYnd4PkjP0ye4bzWdBQrQRga9NvhQwA8tyuvszd?=
 =?us-ascii?Q?jLHHeHbcJfi2IFExFYpmzH36a7Waf4RRggHgKgdejgCA9cVoRbvrLuanftgC?=
 =?us-ascii?Q?txN8YssoTZaBEpx/gqA0x/138rQFHGh2B7yBtgOBMSps4aYqB7zKR98PfrIG?=
 =?us-ascii?Q?14jFbx82F8AULV2Z64ebSuijx9cR+TG9BvEeCOLSIIOI/7/NEvfyDYKg8GB6?=
 =?us-ascii?Q?dybxBBNJaEFUFR0GciQop8HXY+fKELflq014buJZBal4/RSYF8P5Lw/Sl83a?=
 =?us-ascii?Q?ikihlWPJhUFayemjA2Jpdrdevphp4MYRzCBJzDUuQmRJ7PErAWCabK/ZsaFw?=
 =?us-ascii?Q?yfi8yI92LP2m7LdIEkxvH7zQd4C8WucQsOyDLYKIbLlC3t4DgokLPxZnXTh/?=
 =?us-ascii?Q?Kla3COb0/aT9QWtmUgUTXST0Vxk1ci1M7QAfBJ/e6Q556hoCxtwb62ihz9jZ?=
 =?us-ascii?Q?S7EivMuvT7vLEGGUj6nWY3YwRGGlsrDsbfW9uKP610YJbXcRfVb01+vg6thv?=
 =?us-ascii?Q?2DravpGw3C2qus7VeKlMXRSgg5ZuHZbbD3jvweyizXo4BUpgvQDfTwdpKm/P?=
 =?us-ascii?Q?GHmT9k9DDiWF+Po4JAVCZYBYrNXGmmVPBqo/ts6awrZ4yOzwOU7EqCd9Xlqr?=
 =?us-ascii?Q?uEvJxmIKzczg7fN/ayy4pP3+F+mUrbVNIC5dTSvC2D7eVtuN/9K+ir5WIKkN?=
 =?us-ascii?Q?D1gCiId51+PJM8+eaztVa0IOzMKLwv0bCIB6W5Bipi/D8apX7O/zE+ShBf3x?=
 =?us-ascii?Q?tm9WwF8LC4L6KErlabHs1iad70EXeCBqwWcLkNcWyXK02kkPSTsSfREvtyW2?=
 =?us-ascii?Q?tgQUS+C297+8ZK2vKzGRQvGnyLoYwGLTOQTP55rt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:04:07.6353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a71acd43-474e-4aed-5c11-08de1bc42aae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9080

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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

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
index a0f53a20fa61..cd73cea93282 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -711,81 +711,8 @@ void read_cdat_data(struct cxl_port *port)
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
@@ -800,19 +727,7 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
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
@@ -836,28 +751,6 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
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
@@ -906,7 +799,7 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
 	return false;
 }
 
-static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
+void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	struct aer_capability_regs aer_regs;
@@ -931,82 +824,8 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
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
index 231ddccf8977..259ed4b676e1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -776,14 +776,6 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
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
index 4985dbd90069..0c8b6ee7b6de 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -77,7 +77,23 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
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
index 0d5ce4b74b9f..927fbb6c061f 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -58,12 +58,12 @@ cxl_core-y += $(CXL_CORE_SRC)/pci.o
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


