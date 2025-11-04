Return-Path: <linux-pci+bounces-40162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03699C2E878
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C0D14F3750
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1FE52F88;
	Tue,  4 Nov 2025 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QmLqYXuQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4F572612;
	Tue,  4 Nov 2025 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215082; cv=fail; b=sgv3tUp813qpLXTjki7myijulPp4dlqKskUwyETOnZHgvHUyNsme82Su+So7mN8H944qIBhzlbLG6unwzwFwURhcaHJrnkDrvmmrsGqx0D/lu79Tax/Hl8unlAajz6RezlzQymAZlaUHcI0J2l8/L7M239m3tfpNvA+AXmX8nKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215082; c=relaxed/simple;
	bh=FPm8ZZjEulz+In18IUYe115zXjh2/fGOcmW+/KNbiQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0PhCQ/n/7VklBR79yZ5EHftAy7VD9cZhS6fGhN12FtooZ2uG3StShQhaqtYzGRxCa0yQ9m6xXbqo7YLA4WIGEHEGfa5Hbw2cqNKLFfhSIiato62rcNk6wXBCFOFYH2HB8XRXQnFnRqOz+bA+WxJWgSnLyMiJwH5cUKoMvVnK4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QmLqYXuQ; arc=fail smtp.client-ip=52.101.52.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGEiYBvRIES3UoGf/2B678Smn3jyyeABpTORxChPWkeS8WKbDuPqzLMVr3joSkP8g0Ez9nbS5KO9Euk/YqsqwIk2mSrcC3hPOufOHzUOBVEqZlLTwbiW19fNYff2OVlEI+EHpK/laj3kD0KjX+a3vaQvvCjUJs+G3Gtn1GSYNnmbyOxHcw1mmDJx2pLetKflULHET05Qb65ood7FaZJvV7DuuXQiEfK5g0hqtpA156sqwsb9B3oKx41mNumB4TLFtYYB04tSAW7R5nW0HwrRtwkcjabFe8LBcQoiT3GXDf++aICS2VWksc0B1fFn1H04xwAdQ3lWuBYkUm2ngLXLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuM+XBsWnpY8CJY0NxYPLtyFjru+oMBnAmOdABVFCpc=;
 b=kDh59knoqp8aZ/29KzLHCVK7E2xwvVkPAaExhzwmB7au7cI2SQy6wSs7fjmdG8obw7yCLVlIVgRv/xjHVL+PtiR3NTmsm5CuOsQfva58zf88uO/ufItH5Jc6X9XuNeUtAFM1AZ7Z+waxYRbTh6RFLSgE0kfE/DJGGAMTv9lF8E11qWbm88JE/zVrwyzXkvzdnpO4eJJQk+hC8vrvCaXghXML8s7gACXmqWiUbB15JZARXOV0mrX71y0tJJ1fFQQj+W3sDFRnA5CO40C0wtNmUQTNMxJpWy5tCo54iG+UqQ8upmHRfVPSI7CczIiTRuSyQhDeE/zhMe79U8YCf6Dfuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuM+XBsWnpY8CJY0NxYPLtyFjru+oMBnAmOdABVFCpc=;
 b=QmLqYXuQNvRQE3/7VFbtoxp9Hz4MOJ7aPfdXJaeo6rs07oNhprk214JJMhqPCRM8CZiLLcvDm7fsuIuZNmzmHhH1ccklkD3m1ImTmRIPOTkogcf2ZyMxhZ+f+gLoZMAxqUR7AJ6I5MDDqqz06ZyYcnjG2PjSIhSuXoqYLx/Y2dQ=
Received: from CH2PR08CA0006.namprd08.prod.outlook.com (2603:10b6:610:5a::16)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:11:14 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::fa) by CH2PR08CA0006.outlook.office365.com
 (2603:10b6:610:5a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:11:14 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:11:13 -0800
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
Subject: [PATCH v13 06/25] cxl: Move CXL driver's RCH error handling into core/ras_rch.c
Date: Mon, 3 Nov 2025 18:09:42 -0600
Message-ID: <20251104001001.3833651-7-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104001001.3833651-1-terry.bowman@amd.com>
References: <20251104001001.3833651-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: c3351046-9bb9-4984-84ef-08de1b36ab0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uw7z1WXEvGZePraLN5aJyhZIyMdf6WRDFj0NKk8Zd4slupe3jrg6FJI3JzUC?=
 =?us-ascii?Q?ZIEhAyrLCqen9IuUTgRKLADYjJcm6PT7GA9seM6ywANcQdwVzfeny/L/4AZI?=
 =?us-ascii?Q?R7V1qyaKcbmu9bOsW1pBdsJybnkcgVYvF93etSxvi4fOmGHXEf9jC3elGz3F?=
 =?us-ascii?Q?zblq620u+Fyv28cYNs7wQ1vJ+J7xAtNh/6rV/0iDFmIwa1unRzOAri6KX3dq?=
 =?us-ascii?Q?OlY5Z9GnZhdaxxk164/P+ZDX8IfNsC0ROizgEOnCfR+fprkbylSE//BU5cLc?=
 =?us-ascii?Q?ZSxz5tQxHHPKYumNNX6k/ZikUMqDFVzVUvfPpfADNE+IFT161L9SzT6Bg7Rw?=
 =?us-ascii?Q?GZ3HFhEGHOG4wau/aCbrD9UMCMUshkkV63iHAWaYFbwbrngXQFoZiXTU1PEp?=
 =?us-ascii?Q?l0zdRYF0apiA4NL/qK/1YDhmWkw46zPIYcnUSAu2TSGNx4J0OKSjocMtl76m?=
 =?us-ascii?Q?Wa2CQ8ie+CEXDsq0NNoASH1n6bw/ciLwMuJup8PxwN+Q0RK3hxBPQC6/NPcR?=
 =?us-ascii?Q?yXSFNo6ZCTgBuiCANguKv4elSLJpghMQcAM0R8FY5pn87wKqSPeQosYQOvdE?=
 =?us-ascii?Q?exQqv0t+TcDiIktiw9ZqtXCIwuRkM8C6slxSZN0EkmLNHZQHJi+3JGdmDvsQ?=
 =?us-ascii?Q?HVqR+r5bLLWWB4Y4WSt4Ilh0MG4uCpzpZHiBZ9b8hY1RS3SKx2Zu8xBQ31BE?=
 =?us-ascii?Q?lWOCNz8FtyrlieT6wdk3xIXnwPtzDlch5pG/+8G6vsRd8hdi0hLG3w1/YExb?=
 =?us-ascii?Q?qTKAvBzKIiojeL/FGN/lKgSZFRqwGSikm3WLBB+xuRZk3S8YgLTGHeytOgES?=
 =?us-ascii?Q?dqWPMaDcimU3WrrIflIkOw5hz+B+jBlF/MFT7+D1P+CV1Yza8AB/aZLnAYwD?=
 =?us-ascii?Q?E+zoV/Oz49kfzawjeIx6DCQm15NAjH1Is4UaZwryHln4f7fh+7Yjk1Ars5RV?=
 =?us-ascii?Q?hALA4zF9leAxXj8wqSeRkqRDuvj7gAKVqxTaRkRbJ1F6Ezc0YBqpq608ePM3?=
 =?us-ascii?Q?PzsYWJIlrD0G4V1qBHQAdwwnPcO2md5VeElaXt0XyBUzVbneTA5bJ7rVcM89?=
 =?us-ascii?Q?PuPi7187ca12NWqpYVGhI7tRM7Q2LcrtaBB/Uah4GSueL1u3ciHIgGNA368h?=
 =?us-ascii?Q?i9sA5msqYOffS4WgeXEDPh5enYaGsgXjV180QHTJ3rj15y44R4v5bDK5CmMp?=
 =?us-ascii?Q?CvR8GOt9ZL89GYMuRW0/pWXA7hdqoThz3LtIcuQ6Kuw+DtZA7KFmD41QbtmZ?=
 =?us-ascii?Q?8n3E7kX+oTA18IDKWlOEt9TBmil5fylRm/LvMiRtasgWkp36cpwNmmMwyw5A?=
 =?us-ascii?Q?QbfVeWrwOvhUHcnX86PM85nv64dfBP9gYde2ql/3JvYfSvmF01VlybqHzsf9?=
 =?us-ascii?Q?hk/Sgw3x64YJmpp+7vJhnSGpBFvxWSY/M5/IzBr2ipyX89cMqglFybf+C9xc?=
 =?us-ascii?Q?7WkEPpXPeyiLVCmbC2xtNstGbMFaRQxKg1rqiiv+WGBHULekDQIAOSKMl1ae?=
 =?us-ascii?Q?Q57+oiVERwmCnROyhcroLg81C14STcX5f/mGedVv+2ye/qcyUtaSfQedsnp6?=
 =?us-ascii?Q?dHE1TxHq2QiAm6IJOMB1ikxOOGpf6LDDW5pfJ+CQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:11:14.4701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3351046-9bb9-4984-84ef-08de1b36ab0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236

Restricted CXL Host (RCH) protocol error handling uses a procedure distinct
from the CXL Virtual Hierarchy (VH) handling. This is because of the
differences in the RCH and VH topologies. Improve the maintainability and
add ability to enable/disable RCH handling.

Move and combine the RCH handling code into a single block conditionally
compiled with the CONFIG_CXL_RCH_RAS kernel config.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v12->v13:
- None

Changes v11->v12:
- Moved CXL_RCH_RAS Kconfig definition here from following commit.

Changes v10->v11:
- New patch
---
 drivers/cxl/Kconfig        |   7 +++
 drivers/cxl/core/Makefile  |   1 +
 drivers/cxl/core/core.h    |   5 +-
 drivers/cxl/core/pci.c     | 115 -----------------------------------
 drivers/cxl/core/ras_rch.c | 120 +++++++++++++++++++++++++++++++++++++
 tools/testing/cxl/Kbuild   |   1 +
 6 files changed, 132 insertions(+), 117 deletions(-)
 create mode 100644 drivers/cxl/core/ras_rch.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 217888992c88..ffe6ad981434 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -237,4 +237,11 @@ config CXL_RAS
 	def_bool y
 	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
 
+config CXL_RCH_RAS
+	bool "CXL: Restricted CXL Host (RCH) protocol error handling"
+	def_bool n
+	depends on CXL_RAS
+	help
+	  RAS support for Restricted CXL Host (RCH) defined in CXL1.1.
+
 endif
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index b2930cc54f8b..fa1d4aed28b9 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -20,3 +20,4 @@ cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
 cxl_core-$(CONFIG_CXL_RAS) += ras.o
+cxl_core-$(CONFIG_CXL_RCH_RAS) += ras_rch.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index bc818de87ccc..c30ab7c25a92 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -4,6 +4,7 @@
 #ifndef __CXL_CORE_H__
 #define __CXL_CORE_H__
 
+#include <linux/pci.h>
 #include <cxl/mailbox.h>
 #include <linux/rwsem.h>
 
@@ -167,7 +168,7 @@ static inline void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem
 #endif /* CONFIG_CXL_RAS */
 
 /* Restricted CXL Host specific RAS functions */
-#ifdef CONFIG_CXL_RAS
+#ifdef CONFIG_CXL_RCH_RAS
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
 void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
@@ -175,7 +176,7 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
 static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
-#endif /* CONFIG_CXL_RAS */
+#endif /* CONFIG_CXL_RCH_RAS */
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
 
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index cd73cea93282..a66f7a84b5c8 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -711,121 +711,6 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-#ifdef CONFIG_CXL_RAS
-void cxl_dport_map_rch_aer(struct cxl_dport *dport)
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
-void cxl_disable_rch_root_ints(struct cxl_dport *dport)
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
-void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
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
-
-	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(cxlds, dport->regs.ras);
-	else
-		cxl_handle_ras(cxlds, dport->regs.ras);
-}
-#endif
-
 static int cxl_flit_size(struct pci_dev *pdev)
 {
 	if (cxl_pci_flit_256(pdev))
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
new file mode 100644
index 000000000000..f6de5492a8b7
--- /dev/null
+++ b/drivers/cxl/core/ras_rch.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
+
+#include <linux/pci.h>
+#include <linux/aer.h>
+#include <cxl/event.h>
+#include <cxlmem.h>
+#include "trace.h"
+
+void cxl_dport_map_rch_aer(struct cxl_dport *dport)
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
+							     sizeof(struct aer_capability_regs));
+	}
+}
+
+void cxl_disable_rch_root_ints(struct cxl_dport *dport)
+{
+	void __iomem *aer_base = dport->regs.dport_aer;
+	u32 aer_cmd_mask, aer_cmd;
+
+	if (!aer_base)
+		return;
+
+	/*
+	 * Disable RCH root port command interrupts.
+	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
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
+void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
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
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 927fbb6c061f..6905f8e710ab 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -64,6 +64,7 @@ cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
 cxl_core-$(CONFIG_CXL_RAS) += $(CXL_CORE_SRC)/ras.o
+cxl_core-$(CONFIG_CXL_RCH_RAS) += $(CXL_CORE_SRC)/ras_rch.o
 cxl_core-y += config_check.o
 cxl_core-y += cxl_core_test.o
 cxl_core-y += cxl_core_exports.o
-- 
2.34.1


