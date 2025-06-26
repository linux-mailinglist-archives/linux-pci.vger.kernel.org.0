Return-Path: <linux-pci+bounces-30853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E5EAEA9CF
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2798B3B81BD
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B870283124;
	Thu, 26 Jun 2025 22:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P3Y7PEKr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E0284681;
	Thu, 26 Jun 2025 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977843; cv=fail; b=NLK7rvNaDneDq3h1oPWe/rn/aF+9V7spvMDfCU8geXGuXgTR05ROO1WmBqqWs2hyI8lfoJpHtP5F3lomvcWaP/uWfEoeSC2/3XZo4S9cdIwaUAOwaQSnRdbKox8X/7k4nbDMWHWzwU1IFnv8HHoQFVyUynQJ1iFU13lrSsSNNCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977843; c=relaxed/simple;
	bh=B/V5Db7CaHzIS0SKgGi9EsdZHP6oLRYoOgbO/hGLW1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJ0bseIbFCt47Awe7R8FKs/7nc+WbjNBe29QEoKImOBXYdB78UxZzZTz2Eq5yE5P1P6JGZUIL2qkFcxj6T5ZrrNBKx1EoYz8Rc9794V38Eenn3vGkBDZMK4lPngJnF3x+pQJzddPWrsZibQWrjUy6z9tq+38vQDYBAq9+P+g4UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P3Y7PEKr; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xI3VdK8pl2PFFr5R3WFXQpZ+GvOmQlwrrMjN9uc6i0DLZVnAWFGyb/3ZuxNa0wkVgNiallDFwey4zjWeE2dSaUo4qhBfY0pI+WSyxFoYHeifkI60zNDVcjx4cM/wZ+76IO14NOQEDvCpszjw10Byke0lhZtFERhwAG1Q0UfavJwuQZh9SIqTiJdPA7/NsQIvFKRHJ55bKay1yrVE8lwJaNivt3b1aQhkG46bIcqtVK39CyMbc30S7UCoB8OSaOj1mrJok40FdNwwnhh2CeouBMVNMDbhCkvjTMh2l7ua9qEqHKvqE1eKR1/ZnIPW9YNw44dzyRLarPfnuv6x8GWfzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRnRRr9TCNdV6wVDxtKVWGBaRQhTtoF1PFyTnsR0sDo=;
 b=DHOiXZLMXTw/xvDjkZYrUu1BwPlHvM1Gc6kCm4BdyLsAhstpr6POC7hG2CVsDjRtQc3QI199Kj/0ikKhlrwgtM2rRsKOGudRhuFI1F4+WaKmOdc3UXwSPrBUPB4ebRgoO18++QbImWCjB+7BR5UMgHNExk/OmrIF1Y0OYgXGfO9QtvtXvIlGaFF2EZHrpMhFMGozSp+aBomR9ZkmDEVkdVW/ojqYB/3OJtVe16zCbmqGsDjfFkcwcEy6xX93UUQ8MHd9U3VVRvDmOgAGfDCn/Wsk4dV5S6kpyQlCxbimsyQrb2RVvEwRa8Df0FsVSfSXVpeOnLC4c3oYqRh7Mv71UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRnRRr9TCNdV6wVDxtKVWGBaRQhTtoF1PFyTnsR0sDo=;
 b=P3Y7PEKryYB9fpvX7iDz5OFm3gAMFq8NNqfrLz3LBGMb2xXbP5mdF7RZkr9IInfT540bnxruCRE1GfCgSXzaR27UDk8obW+5pnqL6NidVI0IS9DWXe88R74IkKAht03c1e2sOyq6uNPo/c3Bqki+bqJOpRGA25BhD5XY7xLfoZk=
Received: from DM6PR07CA0090.namprd07.prod.outlook.com (2603:10b6:5:337::23)
 by SJ1PR12MB6193.namprd12.prod.outlook.com (2603:10b6:a03:459::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.34; Thu, 26 Jun
 2025 22:43:54 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::dd) by DM6PR07CA0090.outlook.office365.com
 (2603:10b6:5:337::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Thu,
 26 Jun 2025 22:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:43:54 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:43:53 -0500
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
Subject: [PATCH v10 05/17] CXL/AER: Introduce kfifo for forwarding CXL errors
Date: Thu, 26 Jun 2025 17:42:40 -0500
Message-ID: <20250626224252.1415009-6-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|SJ1PR12MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f51e58d-4df5-4e03-ebc2-08ddb502ee45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rpj+mHrj+INSWhwxH3oajpCWCO6lEnfuDOcoY/7SZCiuO9ZVnvfghq/MSJf6?=
 =?us-ascii?Q?GZjamE4VGEH7xHouB7T/YVvTEo/N0YtlfQJ8Vr6Hu9bKB19aqHKk3ie2Gliy?=
 =?us-ascii?Q?eGAsHkA6/x3QnKSr8VbTHO85QDySHIi43NYp895NkezxN3JvfQsGCFT+oJ9g?=
 =?us-ascii?Q?4RjmCVOc8/alCG+S4Vtc8P4KMCxYgfp8iUyyshYvLNYLO5Rdi8LnMpAd5U//?=
 =?us-ascii?Q?ChwI5NccmTmK5f4j1KIob8Gat7BTECu924SSfWtUQRrzn46YxHxCLYsWNq23?=
 =?us-ascii?Q?Qa84+zmoehQZ+7cY8DflRo6RvIjNHFOG8Rgo6BF6jNf1+q15eiITSv62qj/R?=
 =?us-ascii?Q?qvQvZWdAC/CIUu6UmHtaCwnYamOWDTk00qFG/AGlx8S+FikUI8nVyLDlOgZN?=
 =?us-ascii?Q?0NDxSahTQzh/ytmj58yblOWE8t7whHZtqpWsrk9yWcTQQYxzOJw9ZfiM6iCb?=
 =?us-ascii?Q?dON3rDrayj2dbHy6vieMiIFwsFkSYz8KYYK4UfSSzUottAA1BPVl1Uj3CWmb?=
 =?us-ascii?Q?Fb8v0jGsiMVtobqFtuwH2URRjyUyqU0WCE4KOPT0RwDqxrbzKGziDDczP1xR?=
 =?us-ascii?Q?FsFpxCg/cFCcVASXzAKkjvTqgmokepv0EjeWZ2IDoENGoF1GHmZNESz53C7i?=
 =?us-ascii?Q?Lb8/HVDiMGJxefdeRphSUUScJWdKpywqmkztdPyIoMLwJ1kA2WKVddZ2Dw25?=
 =?us-ascii?Q?RxuT0z8NZ58bWEZN+6OBVltaet9ykQ3LYJ//JrIpuf9fe5cpiBNFmPfmDT8Y?=
 =?us-ascii?Q?77KWeWUAP5ciZkJ8e1n3YvBpgZkzMsRwc5fc0qvBRbBq3gmqYyJL1CwLokub?=
 =?us-ascii?Q?zJGhdiAxZjKMVU1lAVILtvASPb24q0xWTXMgp6zuuqudHKae/SZm10hTXMDT?=
 =?us-ascii?Q?I+nY7ySRa5DDw8SBAju1aBTKzTqBYJPjju18yBywzQ4MxW/4l19UX2m1A3mO?=
 =?us-ascii?Q?Yn3NSgx6T68U/r7RQLsf88/PfGp+oq32eEI+h/fxZhqxO+SMZ43SBvXUFqN2?=
 =?us-ascii?Q?rULotRpdfLJ2B4KMo83c/WDJ3RDBW4UyAi3ANHYjxp4qecNc1VUHeKUSBAvx?=
 =?us-ascii?Q?ll4mifNNBUlWS8j/RoMFkD3nUaUNm4+YlqtCKrghGlViq89g3xqbQPhB4LbJ?=
 =?us-ascii?Q?aXx5MxUnTf5cGMZjIhe/syvupegdB5FAJGx7V3s2TS83FWcKYdQAGzSv/YM1?=
 =?us-ascii?Q?8rpHOw0Ldmxo1GPprha+dHDpBEvOBfFoUoaag9bYqSIt/BZsQ3MnWoWQTOfk?=
 =?us-ascii?Q?evNgPMPCJVaRZm+kKW43cQYLP5sGTNb6ZrgZJcik+vnXwHYKtQxG27ayPMDg?=
 =?us-ascii?Q?JATuZj9N4Qx9kiHe8Xz0mor1F4mXjHDAkp/tofRZBtCytVr5VcJdGhpsE5Z7?=
 =?us-ascii?Q?mEUIDgrk4Q1iBGspEd3Q7SvGqnU+BUsTAWGhRS9CpGH/IshtTWaUQX3f9hrT?=
 =?us-ascii?Q?4QTzxoq0dlPrtb0eebmFR2zqwNN0dlqZYldapDslXHuG2i0Gj6NFU42Qi+4V?=
 =?us-ascii?Q?wW7w4Tx85rsDrhgigqyTpo7W0J0ZqU2CtLngdm1UkSPWSzakFdhA0dfDMQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:43:54.7801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f51e58d-4df5-4e03-ebc2-08ddb502ee45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6193

CXL error handling will soon be moved from the AER driver into the CXL
driver. This requires a notification mechanism for the AER driver to share
the AER interrupt with the CXL driver. The notification will be used
as an indication for the CXL drivers to handle and log the CXL RAS errors.

First, introduce cxl/core/native_ras.c to contain changes for the CXL
driver's RAS native handling. This as an alternative to dropping the
changes into existing cxl/core/ras.c file with purpose to avoid #ifdefs.
Introduce CXL Kconfig CXL_NATIVE_RAS, dependent on PCIEAER_CXL, to
conditionally compile the new file.

Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
driver will be the sole kfifo producer adding work and the cxl_core will be
the sole kfifo consumer removing work. Add the boilerplate kfifo support.

Add CXL work queue handler registration functions in the AER driver. Export
the functions allowing CXL driver to access. Implement registration
functions for the CXL driver to assign or clear the work handler function.

Introduce 'struct cxl_proto_err_info' to serve as the kfifo work data. This
will contain the erring device's PCI SBDF details used to rediscover the
device after the CXL driver dequeues the kfifo work. The device rediscovery
will be introduced along with the CXL handling in future patches.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/Kconfig           | 14 ++++++++
 drivers/cxl/core/Makefile     |  1 +
 drivers/cxl/core/core.h       |  8 +++++
 drivers/cxl/core/native_ras.c | 26 +++++++++++++++
 drivers/cxl/core/port.c       |  2 ++
 drivers/cxl/core/ras.c        |  1 +
 drivers/cxl/cxlpci.h          |  1 +
 drivers/pci/pci.h             |  4 +++
 drivers/pci/pcie/aer.c        |  7 ++--
 drivers/pci/pcie/cxl_aer.c    | 60 +++++++++++++++++++++++++++++++++++
 include/linux/aer.h           | 31 ++++++++++++++++++
 11 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cxl/core/native_ras.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..57274de54a45 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -233,4 +233,18 @@ config CXL_MCE
 	def_bool y
 	depends on X86_MCE && MEMORY_FAILURE
 
+config CXL_NATIVE_RAS
+	bool "CXL: Enable CXL RAS native handling"
+	depends on PCIEAER_CXL
+	default CXL_BUS
+	help
+	  Enable native CXL RAS protocol error handling and logging in the CXL
+	  drivers. This functionality relies on the AER service driver being
+	  enabled, as the AER interrupt is used to inform the operating system
+	  of CXL RAS protocol errors. The platform must be configured to
+	  utilize AER reporting for interrupts.
+
+	  If unsure, or if this kernel is meant for production environments,
+	  say Y.
+
 endif
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 79e2ef81fde8..16f5832e5cc4 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -21,3 +21,4 @@ cxl_core-$(CONFIG_CXL_REGION) += region.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
+cxl_core-$(CONFIG_CXL_NATIVE_RAS) += native_ras.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 29b61828a847..4c08bb92e2f9 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -123,6 +123,14 @@ int cxl_gpf_port_setup(struct cxl_dport *dport);
 int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
 					    int nid, resource_size_t *size);
 
+#ifdef CONFIG_PCIEAER_CXL
+void cxl_native_ras_init(void);
+void cxl_native_ras_exit(void);
+#else
+static inline void cxl_native_ras_init(void) { };
+static inline void cxl_native_ras_exit(void) { };
+#endif
+
 #ifdef CONFIG_CXL_FEATURES
 struct cxl_feat_entry *
 cxl_feature_info(struct cxl_features_state *cxlfs, const uuid_t *uuid);
diff --git a/drivers/cxl/core/native_ras.c b/drivers/cxl/core/native_ras.c
new file mode 100644
index 000000000000..011815ddaae3
--- /dev/null
+++ b/drivers/cxl/core/native_ras.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
+
+#include <linux/pci.h>
+#include <linux/aer.h>
+#include <cxl/event.h>
+#include <cxlmem.h>
+#include <core/core.h>
+
+static void cxl_proto_err_work_fn(struct work_struct *work)
+{
+}
+
+static struct work_struct cxl_proto_err_work;
+static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
+
+void cxl_native_ras_init(void)
+{
+	cxl_register_proto_err_work(&cxl_proto_err_work);
+}
+
+void cxl_native_ras_exit(void)
+{
+	cxl_unregister_proto_err_work();
+	cancel_work_sync(&cxl_proto_err_work);
+}
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index eb46c6764d20..8e8f21197c86 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2345,6 +2345,8 @@ static __init int cxl_core_init(void)
 	if (rc)
 		goto err_ras;
 
+	cxl_native_ras_init();
+
 	return 0;
 
 err_ras:
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 485a831695c7..962dc94fed8c 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -5,6 +5,7 @@
 #include <linux/aer.h>
 #include <cxl/event.h>
 #include <cxlmem.h>
+#include <cxlpci.h>
 #include "trace.h"
 
 static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 54e219b0049e..6f1396ef7b77 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -4,6 +4,7 @@
 #define __CXL_PCI_H__
 #include <linux/pci.h>
 #include "cxl.h"
+#include "linux/aer.h"
 
 #define CXL_MEMORY_PROGIF	0x10
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 91b583cf18eb..29c11c7136d3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1032,9 +1032,13 @@ static inline void pci_restore_aer_state(struct pci_dev *dev) { }
 #ifdef CONFIG_PCIEAER_CXL
 void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
 void cxl_rch_enable_rcec(struct pci_dev *rcec);
+bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
+void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info);
 #else
 static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
 static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
+static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
+static inline void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info) { }
 #endif
 
 #ifdef CONFIG_ACPI
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 0b4d721980ef..8417a49c71f2 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1130,8 +1130,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_rch_handle_error(dev, info);
-	pci_aer_handle_error(dev, info);
+	if (is_cxl_error(dev, info))
+		forward_cxl_error(dev, info);
+	else
+		pci_aer_handle_error(dev, info);
+
 	pci_dev_put(dev);
 }
 
diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
index b2ea14f70055..846ab55d747c 100644
--- a/drivers/pci/pcie/cxl_aer.c
+++ b/drivers/pci/pcie/cxl_aer.c
@@ -3,8 +3,11 @@
 
 #include <linux/pci.h>
 #include <linux/aer.h>
+#include <linux/kfifo.h>
 #include "../pci.h"
 
+#define CXL_ERROR_SOURCES_MAX          128
+
 /**
  * pci_aer_unmask_internal_errors - unmask internal errors
  * @dev: pointer to the pci_dev data structure
@@ -64,6 +67,19 @@ static bool is_internal_error(struct aer_err_info *info)
 	return info->status & PCI_ERR_UNC_INTN;
 }
 
+bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
+{
+	if (!info || !info->is_cxl)
+		return false;
+
+	/* Only CXL Endpoints are currently supported */
+	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC))
+		return false;
+
+	return is_internal_error(info);
+}
+
 static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 {
 	struct aer_err_info *info = (struct aer_err_info *)data;
@@ -136,3 +152,47 @@ void cxl_rch_enable_rcec(struct pci_dev *rcec)
 	pci_info(rcec, "CXL: Internal errors unmasked");
 }
 
+static DEFINE_KFIFO(cxl_proto_err_fifo, struct cxl_proto_err_work_data,
+		    CXL_ERROR_SOURCES_MAX);
+static DEFINE_SPINLOCK(cxl_proto_err_fifo_lock);
+struct work_struct *cxl_proto_err_work;
+
+void cxl_register_proto_err_work(struct work_struct *work)
+{
+	guard(spinlock)(&cxl_proto_err_fifo_lock);
+	cxl_proto_err_work = work;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
+
+void cxl_unregister_proto_err_work(void)
+{
+	guard(spinlock)(&cxl_proto_err_fifo_lock);
+	cxl_proto_err_work = NULL;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
+
+int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd)
+{
+	return kfifo_get(&cxl_proto_err_fifo, wd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_proto_err_kfifo_get, "CXL");
+
+void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info)
+{
+	struct cxl_proto_err_work_data wd;
+
+	wd.err_info = (struct cxl_proto_error_info) {
+		.severity = aer_err_info->severity,
+		.devfn = pdev->devfn,
+		.bus = pdev->bus->number,
+		.segment = pci_domain_nr(pdev->bus)
+	};
+
+	if (!kfifo_put(&cxl_proto_err_fifo, wd)) {
+		dev_err_ratelimited(&pdev->dev, "CXL kfifo overflow\n");
+		return;
+	}
+
+	schedule_work(cxl_proto_err_work);
+}
+
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 02940be66324..24c3d9e18ad5 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -10,6 +10,7 @@
 
 #include <linux/errno.h>
 #include <linux/types.h>
+#include <linux/workqueue_types.h>
 
 #define AER_NONFATAL			0
 #define AER_FATAL			1
@@ -53,6 +54,26 @@ struct aer_capability_regs {
 	u16 uncor_err_source;
 };
 
+/**
+ * struct cxl_proto_err_info - Error information used in CXL error handling
+ * @severity: AER severity
+ * @function: Device's PCI function
+ * @device: Device's PCI device
+ * @bus: Device's PCI bus
+ * @segment: Device's PCI segment
+ */
+struct cxl_proto_error_info {
+	int severity;
+
+	u8 devfn;
+	u8 bus;
+	u16 segment;
+};
+
+struct cxl_proto_err_work_data {
+	struct cxl_proto_error_info err_info;
+};
+
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
@@ -64,6 +85,16 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
+#if defined(CONFIG_PCIEAER_CXL)
+void cxl_register_proto_err_work(struct work_struct *work);
+void cxl_unregister_proto_err_work(void);
+int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
+#else
+static inline void cxl_register_proto_err_work(struct work_struct *work) { }
+static inline void cxl_unregister_proto_err_work(void) { }
+static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
+#endif
+
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
-- 
2.34.1

