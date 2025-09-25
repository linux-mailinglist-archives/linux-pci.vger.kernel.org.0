Return-Path: <linux-pci+bounces-37037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FC3BA1D00
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E89740F81
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF9F321287;
	Thu, 25 Sep 2025 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kovPtDCQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012006.outbound.protection.outlook.com [40.107.200.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED17F321F2F;
	Thu, 25 Sep 2025 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839730; cv=fail; b=LFlyXRUeeoLnF47ZiqV5AKCv25gS5xz3clzSyEd620foyQtLqtxMN7BjtOyF86XYBCLeXdnHq3AIKAL9zaGY0RhYwCjY+rBE71eGGls8yU1ZM6xdVrBag3KJ81PWkX2PJntJHhNdN6jvrhIm5K/LuJqYwL2Rala97JOZ6CUVpdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839730; c=relaxed/simple;
	bh=YindZzQ7jJYBZYOPLcjHw2cLrMmcpckFElZxvtx2qsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUW/uh/3hN2dKAdtanpxvGmmLZldSAIC7bFTUJh3wznYnujudgA7PCux4An+071hCDacEvpBtLWlunlLUVZI0h+vbsF1/N1wuGX325T08B0IBYWIlGaqF6e33QM1bXG8fBdArwQBjagzsf2c68+3n9i0Dzq7lCXGUN9RbjXMhkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kovPtDCQ; arc=fail smtp.client-ip=40.107.200.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T45ayTfCvq4tFqscgxlkxh5GfOiKDaZpYNhqY9mhX9I6q6k6Sy519JsMucyGZCDNXJAtujljzxdxeCo3HKwcvGrIfQ6x1eI67TgtYZke1QkzH8J5FsTQVji21WbXe2xy6jyJwpeZiNDvSQlUiwvATNGg7msCvcOkpBdDL8vV6A/WpGIn8rkngNKVNDCfq2ShISJaYEvsLba555LENdtPDLqkck32+o+69KidO7Tc2PlRKVIUOJ74xHz+6vFetZS63F2W8C2du7XZhZsEPExwLjxymixlVLHJFCYaGiKgHD+Su2A7tt9PRXLb5J9LKLPPAussk8fJhLd7SoQF9qaGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXUkmTqIlsMg1zZctgVtObxGs6zYmIkRkPghjcSTuF0=;
 b=DFFIcBSVVDVugMNKCCh15ElLCKbTthWtkHxiFl8oZhZ4ZZ1gJFJ9+5TRgMgkwTcqmQw77lyjO0bbKoL7kwqlTpxNnOIpF6ZF8MauDPXHLi+WAmUzPFi/NvrQ9MirV8SWdvl5fhpYWGh6tUfaT1CptGOH36PSmr3W1htLp8WwMkNJOHYn1V0dYPraxR/XIUk1Fhm6+lGl1orlkMIROpYEbiyXx1Dt58mNxT0T9SAfGLoxWyGx+SLnqsZWxhNFLrlmbO2P3KXndijMtzbzSAmktvnz3HC6DiegbUlI+jyDuedRbM3hhHxX52DxgZSFL86gONRVwNHM0O2ansmP7QGWdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXUkmTqIlsMg1zZctgVtObxGs6zYmIkRkPghjcSTuF0=;
 b=kovPtDCQ0WhHL9XaPplBQnn8hjTVND0MRPokruBLA9KPvxESLXm070vFMXK1dxz4ULcTzaSMduLtS6g3qqQ7XhRETE1nWgqaSf9S/CbJA/FGlsSS/RhzZh7yPWjfXafFuN+B//zN2QOQ8yluhoBzhEoiAzmm5Aq6ZD/FButJ5b4=
Received: from BY3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:254::12)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 22:35:21 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::66) by BY3PR05CA0007.outlook.office365.com
 (2603:10b6:a03:254::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.5 via Frontend Transport; Thu,
 25 Sep 2025 22:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:35:20 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:35:19 -0700
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
Subject: [PATCH v12 03/25] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c
Date: Thu, 25 Sep 2025 17:34:18 -0500
Message-ID: <20250925223440.3539069-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925223440.3539069-1-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 8758ccc5-8593-4dff-526f-08ddfc83cf84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kKO1iucUZNYae/ZUCzP+tQ5jrrQMm7F8ZP4AA5HdxXcV8W2orKsy9aK0GlE0?=
 =?us-ascii?Q?vjkN4kzQDeM3Kpd1H6l4BJ66Rc9u9RnenCYf2mHWgJcOiXRor8sJXs/jCuSs?=
 =?us-ascii?Q?UedIttSOivt/aGuXfQuxJNogQx4R21REQDml5JJVY9AYP943hrUSvXbi6f2o?=
 =?us-ascii?Q?YbK4VcEbSPN7bf1N1YOcgKdMZx3XDJdNJpAi545nKS88QgmCuluz/h5ymnwb?=
 =?us-ascii?Q?WwAtehWOoW+PMRYZM9YLMf8I+SPJF+8etZufFffW/fc8qicsY/GdSDl2naLx?=
 =?us-ascii?Q?CI9/kKtyBkW6ac7p0bb/55b1mOpDM/R3Phfvp6wH9WT0A5zqOa/vL+jtflM7?=
 =?us-ascii?Q?9y0wUq42qVeWwveccXHuGn/MlW5r2gN5cJMHP4tm9MUkM2SAwNkoyB0Ilfkt?=
 =?us-ascii?Q?g5GtqrWM5XcDImATf89gpnzuvnyjuM1WEJ7X1NLntwqG3ON1G7ye85/kgUxo?=
 =?us-ascii?Q?Ke/l1GcX+PLC5tChQqUlT6WUoY44aYgtAx/iY0OMxNB+vknA/o7YNXIjB/Ey?=
 =?us-ascii?Q?HHhNwAhZHZTBDccWPawvi1c6S2tkUt2shuDATgAXt1StsLBlgGRat1tBpXXe?=
 =?us-ascii?Q?6p7fklvHNekduYI2Jxg0qoOvLwPazgKK+nf5SsDIo6WKQKDFJlTIICNrbh6S?=
 =?us-ascii?Q?RSHDIsofKoKIg3LdcSJUZjFdnoe+yxUcJWNbbkFUYiOGBMHhfw9Yd70+I15/?=
 =?us-ascii?Q?C1jAP+olDKq2vxzCAGnBxR19FJut4Cb+3ovHpndKISxa91s+Kr5lGfgtm8lF?=
 =?us-ascii?Q?nGqld+Yvf+JN/KPDrsnCStlfULgLFGdH71t+A7wlNf6Z//jPOUYioJkmtCNf?=
 =?us-ascii?Q?V2gFL1TrZpNAzUF4F8lmotMik9N7CUG/+Dgd+4sev9LV6l0Mz4YvtvERiCFQ?=
 =?us-ascii?Q?JnALPijv8fKf7+dvZj1wDs8aGeDft1+MxkeLejCmjryexb7rksjaWfrfcWSe?=
 =?us-ascii?Q?63D4DwNPb2kaY34DvpScmQlKlc7YdmHFtcj+HSHrEpY8KNLddzEQjukhmJVI?=
 =?us-ascii?Q?5/y7OypaLqVuo2W4bIsO/Hp3tn0FQYxekAysBypuBWJyQU2vAG63ratHxIEK?=
 =?us-ascii?Q?VzCTW7LDG1cHdT7SsyZEHNW7rvk2GlM1+AzW9KlkRhjx+2+8fCVS1pYbutTB?=
 =?us-ascii?Q?wrz8dGQRSwLKq5Ldanu+sd9X6+oiWuzoziojSjcMsXRRsobkJPUSUiYUFL1R?=
 =?us-ascii?Q?gQ6qsZ2ASdYr0i85wVryu0YieojZXCjEzwLE2UMFmZiQqSuwO5au7iYO/ek9?=
 =?us-ascii?Q?I8o83cYocvj8BBazJnh9dyW6JVtI27P7nVVSykOgeP6NuxC34wjCMaG2x5LU?=
 =?us-ascii?Q?xC5lHk8I03W9M3IHp+Z2zxlv4ofiOEmJvXFqGMbB8YLa5onrvMKYVS6V/6y6?=
 =?us-ascii?Q?YXvT6oTN8HsBfyCXKonIWR82wssnVJtJ/4C+7uca6Cl7rNLcGKbzQleUcDQ3?=
 =?us-ascii?Q?VpoDXRtMdMglBER3etz7ibspKq8ulGGp4UHtYRx/hs21smn4Fqr6G2P4OPp0?=
 =?us-ascii?Q?BOCTHPsAn1/nLviZuABq0zrN8B3XC86Rkee6XKjKfw1JEKUSER144KruhQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:35:20.7611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8758ccc5-8593-4dff-526f-08ddfc83cf84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403

From: Dave Jiang <dave.jiang@intel.com>

Create new config CONFIG_CXL_RAS and put all CXL RAS items behind
the config. The config will depend on CPER and PCIE AER to build.
Move the related RAS code from core/pci.c to core/ras.c.

Cc: Robert Richter <rrichter@amd.com>
Cc: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
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
 drivers/cxl/Kconfig       |   3 +
 drivers/cxl/core/Makefile |   2 +-
 drivers/cxl/core/core.h   |  12 ++
 drivers/cxl/core/pci.c    | 297 --------------------------------------
 drivers/cxl/core/ras.c    | 289 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   8 -
 drivers/cxl/cxlpci.h      |  16 ++
 tools/testing/cxl/Kbuild  |   2 +-
 8 files changed, 322 insertions(+), 307 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..9246f734e6ca 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -233,4 +233,7 @@ config CXL_MCE
 	def_bool y
 	depends on X86_MCE && MEMORY_FAILURE
 
+config CXL_RAS
+	def_bool y
+	depends on ACPI_APEI_GHES && PCIEAER_CXL && CXL_PCI
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
index 1fb66132b777..9f4eb7e2feba 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -144,8 +144,20 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 
+#ifdef CONFIG_CXL_RAS
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
+#else
+static inline int cxl_ras_init(void)
+{
+	return 0;
+}
+
+static inline void cxl_ras_exit(void)
+{
+}
+#endif // CONFIG_CXL_RAS
+
 int cxl_gpf_port_setup(struct cxl_dport *dport);
 
 struct cxl_hdm;
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3fb9462954da..a009a51cb0de 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -6,7 +6,6 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
-#include <linux/aer.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -711,302 +710,6 @@ void read_cdat_data(struct cxl_port *port)
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
-
-	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(cxlds, dport->regs.ras);
-	else
-		cxl_handle_ras(cxlds, dport->regs.ras);
-}
-
-#else
-static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
-#endif
-
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
index 2731ba3a0799..0875ce8116ff 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -5,6 +5,7 @@
 #include <linux/aer.h>
 #include <cxl/event.h>
 #include <cxlmem.h>
+#include <cxlpci.h>
 #include "trace.h"
 
 static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
@@ -124,3 +125,291 @@ void cxl_ras_exit(void)
 	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
 	cancel_work_sync(&cxl_cper_prot_err_work);
 }
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
+							     sizeof(struct aer_capability_regs));
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
+static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
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
+static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
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
index 7ae621e618e7..970e84cf49e9 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -130,7 +130,23 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
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


