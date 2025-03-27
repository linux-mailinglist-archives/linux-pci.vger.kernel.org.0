Return-Path: <linux-pci+bounces-24803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB727A7285F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F171882D09
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DB11A2643;
	Thu, 27 Mar 2025 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3FSET8Mm"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE601A239A;
	Thu, 27 Mar 2025 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040085; cv=fail; b=QXVXebo0/cmP4fFJgJsi+1cNJKpZwY6v9S7QFyB8ETskR4P/x3ZARsmUYNGIPSjgSrpWPPjhJRJjUy7pZ26bz0nPnEbUlabNVCRe5VzqUnwJAsEfC2vb662GsuYOWqARc+4lb7kDAlOfmQOT5/fhRp+tVXfdc+Oms4AsPAlChdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040085; c=relaxed/simple;
	bh=SBj5d5I1sClvT1svuTrCfmF8BhSgKqWo15vw+t7qA48=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glm5LxkWENjIr9L8+9/1CFyvXmauCGx2jt0yCqugDog+76yIlmRt4FTZBxOJ9XAnZHBaym5qiTERWpjJ7sjtCnCH197w1ZjIs0fSsMXwTegd1EoQ3mxkZuYc7RNlbi4tZ2b6MPCi25q52nF4hyvwNUVY0bOgmOpAaqbhhCKMAbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3FSET8Mm; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwJxYC7s7ey5ZJoyG9U6gCPtdS9dsSyvl86sBjJiVrK7GOhUk85BBS+EfHIQiuiFD5rxGlcFIvS3Y5ZJ0R31VEsVIv2HfmukSAQPdpYoYAIJhKoxRrd+R0ssN0eCznUX4F4IXjAlR5mQqEveg+wDoF+Mj4XZKnsTPFZ/B7RlCgrfAb1Vs70LPLbM1uCzv6ZtqNGP+rmhaneV/G6jLUpZTwdbhbrNv8RCwg2nd5aBj91JwA0be7q9mKptv9grP6uu5hS+nHdGmtIlABdOSJSgwK3uyq3WgyTTENUJ8VwGtnD6uW9rQDWodm/Me09rdLC2CTc4mZh6iCCGJJfG4IQzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxWG9JxvSxjfV1iPOfvMwj7sVWNlHSEELFOyA9lJN1k=;
 b=mesrUhWTtLcbql3yV7vrj9H4m+RFhRms2cJsp2F6N+IpBfdBsZubDv7N/fXbVDgc1EARjT8BE//sJpE+EIL+4yjGf5Zb6G5+ySiF6onOU+/gFzkfb0vIm8xQjxYN8ux117TXIDzRgGz6+OANKKo5akKkOhXNOEg09BaeQw3bXNq9UUsTkwdHoMpnEU8ew1Ks1dZ1nMgtu11RxfI0oqkPJVBK2/o36Bq02SfWlGw9m2Spkflppc8UP5Z2/BgqIE+IRvurvJhos/y3HTdlmv61OcNo+aN5abAlqGiTBrpt5M6dZ9e7Ch+/6SddKNfq9mQFu5tAxXe7kM3ANMp5rK/M1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxWG9JxvSxjfV1iPOfvMwj7sVWNlHSEELFOyA9lJN1k=;
 b=3FSET8MmbZXug9hevybw88JHG3Knnx39FVDiM78m5azpzBMFHEDCIeKPKt9jSAvRVPwX4VwGVHJsjPfRV1x/GfCQVSkjJ2BKM+JWqxHNGnMrB7eUciCr8BP2YmVqbObU8zA7AtLcC4DxfXGsdB06h68Qe5oy5yFOU+eTeaAepmE=
Received: from BL0PR1501CA0011.namprd15.prod.outlook.com
 (2603:10b6:207:17::24) by PH0PR12MB7077.namprd12.prod.outlook.com
 (2603:10b6:510:21d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 01:47:59 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::d) by BL0PR1501CA0011.outlook.office365.com
 (2603:10b6:207:17::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 27 Mar 2025 01:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:47:58 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:47:57 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v8 03/16] CXL/AER: Introduce Kfifo for forwarding CXL errors
Date: Wed, 26 Mar 2025 20:47:04 -0500
Message-ID: <20250327014717.2988633-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327014717.2988633-1-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|PH0PR12MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 8327ed30-da9d-4b67-892a-08dd6cd166ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5talz5bcjj2xJl+ZD14fLTb25F72ciZKHaFBNyDzEduXzwiwLeqDDUyPsGQT?=
 =?us-ascii?Q?eiJwPFALrKDIP9POien6nmSq8AESVQgEf6f0012kHqsy+mn0hy7PrHbuUIy0?=
 =?us-ascii?Q?mpGsI8Nbku6JA/X76mko1P3qBcUX8MwJzYh6tDw0T2BboKRckuFwgkulkCHy?=
 =?us-ascii?Q?fbAVXaBjx8X8f+vDUoyDBp8L4we4NH+eSEICz86xk2FBz/fSYYvovialDyLG?=
 =?us-ascii?Q?GFbwMskzlqEaAmmKqr0NEQQT55kcNHXnwp7nu6IkldTgpGsf9oUI+PkPqniG?=
 =?us-ascii?Q?+6OdB948LYTCIXWCcIGkVkeb5XXv9uLURSWn71hzhzXBU7GiUGQrBGvcLZYR?=
 =?us-ascii?Q?Nc8fJDKTo3o/nk661Bu9tAr+Nd5axCrhHumcTTLRiknFSHfg2I91fVgAWrUp?=
 =?us-ascii?Q?XWXPGaQye1reye4pr+wg+hlM1BS9h8CjvjTqQae17j2hDPL3kjAh5waZfZrz?=
 =?us-ascii?Q?a5hyG9MUC+PQE+QTADIWFTzYYYGZEr5HkOC2Kqzv+Wfi3a5hUzcAr+cqbbrk?=
 =?us-ascii?Q?ePyktGDbOq/LR/gqWSnqNbSvmHMq/xrcvFK2SRl63MAN+RT8242maKCXzR20?=
 =?us-ascii?Q?VWqoYxLpldtg+NrKOd5pBvGkym43DRGiueo/cIKU2svM9n6JLx1Q9YMLimyk?=
 =?us-ascii?Q?TLe1c325mfJAlmVOWEJmsuGUnhHkU1qLZ3WuxCGqcRPBo7+iQFUJQD0ky8nk?=
 =?us-ascii?Q?p/LqZVyNwiMVFSte63Ko/3ZbWyY8Qllw7US0x39X9Jmu4riaKiInrQELwBjM?=
 =?us-ascii?Q?vXkcfKiLtlZkE2lX2/ne1W29FvwXlEqueZTwefkGgodOW5nKlLdIy5gjdpux?=
 =?us-ascii?Q?5X3rl8o5Uhd+l2/pr+sHJnvvgM0psTecm9LzfDx/w7Rv/lbKW8C3li7yJGbY?=
 =?us-ascii?Q?H5cvZLvIpTJrxzperotnLu64kljKBZLSuGChcnitLg1CyuP3FI60HgZViKp0?=
 =?us-ascii?Q?MBfDcjxSDLBoVhwvGUhch1bdBATroH4zmoiB3iX5KCVCZOgBgvC/skz9xrTC?=
 =?us-ascii?Q?pR6nPcOy3ib3lDcNxqi+jLhCWVC5RISu0UqAPCyOa/u1/Ccq2JOX1vvCeG8g?=
 =?us-ascii?Q?CtOzhPezn2cmhJyRx3EuP7FGjisygre9vt2416Dwenw5sGMoc94WBb562VQ3?=
 =?us-ascii?Q?+D7lJjU/ygjg7dZnSnEdJeExnN4fnRhi36OCmWjJj20ZPlyO/vixcrAHDUJ7?=
 =?us-ascii?Q?+osrIzegc6Q6FJrf1y1hIVHQxZwFp2Cyp88G2+0djRpjezKX6LHrbkQzUdaA?=
 =?us-ascii?Q?JnFsSh7QHXm0S3kL1XlDhBAVo/lPRdSomu1kz5SVkAR+VDmqCtK2nPxleP7z?=
 =?us-ascii?Q?czch4vpYFh612cRus/Z+tMJiM3saOuEUdIMg9wIyphpIK/9Pw5eKy05paxRa?=
 =?us-ascii?Q?fThrvkDwm9utWVmMRq/fFgQsvnDyzXAhEa0kn1xVwUZB0Gw2K9qNaY8P8HEQ?=
 =?us-ascii?Q?L11xOdCXHu4JbSp+iFs831yYC3IHZpkGIP+orUCFKd+KMJE8npufWaPsYKO+?=
 =?us-ascii?Q?29zPdWSVIejK/ZSDP4SsRuWHjlypgJwKkgP3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:47:58.6752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8327ed30-da9d-4b67-892a-08dd6cd166ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077

CXL error handling will soon be moved from the AER driver into the CXL
driver. This requires a notification mechanism for the AER driver to share
the AER interrupt details with CXL driver. The notification is required for
the CXL drivers to then handle CXL RAS errors.

Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
driver will be the sole kfifo producer adding work. The cxl_core will be
the sole kfifo consumer removing work. Add the boilerplate kfifo support.

Add CXL work queue handler registration functions in the AER driver. Export
the functions allowing CXL driver to access. Implement the registration
functions for the CXL driver to assign or clear the work handler function.

Create a work queue handler function, cxl_prot_err_work_fn(), as a stub for
now. The CXL specific handling will be added in future patch.

Introduce 'struct cxl_prot_err_info'. This structure caches CXL error
details used in completing error handling. This avoid duplicating some
function calls and allows the error to be treated generically when
possible.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/ras.c | 54 +++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxlpci.h   |  3 +++
 drivers/pci/pcie/aer.c | 39 ++++++++++++++++++++++++++++++
 include/linux/aer.h    | 37 +++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 485a831695c7..ecb60a5962de 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -5,6 +5,7 @@
 #include <linux/aer.h>
 #include <cxl/event.h>
 #include <cxlmem.h>
+#include <cxlpci.h>
 #include "trace.h"
 
 static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
@@ -107,13 +108,64 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
+int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
+			     struct cxl_prot_error_info *err_info)
+{
+	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(_pdev);
+	struct cxl_dev_state *cxlds;
+
+	if (!pdev || !err_info) {
+		pr_warn_once("Error: parameter is NULL");
+		return -ENODEV;
+	}
+
+	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)) {
+		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
+		return -ENODEV;
+	}
+
+	cxlds = pci_get_drvdata(pdev);
+	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
+
+	if (!dev)
+		return -ENODEV;
+
+	*err_info = (struct cxl_prot_error_info){ 0 };
+	err_info->ras_base = cxlds->regs.ras;
+	err_info->severity = severity;
+	err_info->pdev = pdev;
+	err_info->dev = dev;
+
+	return 0;
+}
+
+struct work_struct cxl_prot_err_work;
+
 int cxl_ras_init(void)
 {
-	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
+	int rc;
+
+	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
+	if (rc) {
+		pr_err("Failed to register CPER kfifo with AER driver");
+		return rc;
+	}
+
+	rc = cxl_register_prot_err_work(&cxl_prot_err_work, cxl_create_prot_err_info);
+	if (rc) {
+		pr_err("Failed to register kfifo with AER driver");
+		return rc;
+	}
+
+	return rc;
 }
 
 void cxl_ras_exit(void)
 {
 	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
 	cancel_work_sync(&cxl_cper_prot_err_work);
+
+	cxl_unregister_prot_err_work();
+	cancel_work_sync(&cxl_prot_err_work);
 }
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 54e219b0049e..92d72c0423ab 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -4,6 +4,7 @@
 #define __CXL_PCI_H__
 #include <linux/pci.h>
 #include "cxl.h"
+#include "linux/aer.h"
 
 #define CXL_MEMORY_PROGIF	0x10
 
@@ -135,4 +136,6 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
+			     struct cxl_prot_error_info *err_info);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 83f2069f111e..46123b70f496 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -110,6 +110,16 @@ struct aer_stats {
 static int pcie_aer_disable;
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
+#if defined(CONFIG_PCIEAER_CXL)
+#define CXL_ERROR_SOURCES_MAX          128
+static DEFINE_KFIFO(cxl_prot_err_fifo, struct cxl_prot_err_work_data,
+		    CXL_ERROR_SOURCES_MAX);
+static DEFINE_SPINLOCK(cxl_prot_err_fifo_lock);
+struct work_struct *cxl_prot_err_work;
+static int (*cxl_create_prot_err_info)(struct pci_dev*, int severity,
+				       struct cxl_prot_error_info*);
+#endif
+
 void pci_no_aer(void)
 {
 	pcie_aer_disable = 1;
@@ -1577,6 +1587,35 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
 
+
+#if defined(CONFIG_PCIEAER_CXL)
+int cxl_register_prot_err_work(struct work_struct *work,
+			       int (*_cxl_create_prot_err_info)(struct pci_dev*, int,
+								struct cxl_prot_error_info*))
+{
+	guard(spinlock)(&cxl_prot_err_fifo_lock);
+	cxl_prot_err_work = work;
+	cxl_create_prot_err_info = _cxl_create_prot_err_info;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_register_prot_err_work, "CXL");
+
+int cxl_unregister_prot_err_work(void)
+{
+	guard(spinlock)(&cxl_prot_err_fifo_lock);
+	cxl_prot_err_work = NULL;
+	cxl_create_prot_err_info = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_unregister_prot_err_work, "CXL");
+
+int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd)
+{
+	return kfifo_get(&cxl_prot_err_fifo, wd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_prot_err_kfifo_get, "CXL");
+#endif
+
 static struct pcie_port_service_driver aerdriver = {
 	.name		= "aer",
 	.port_type	= PCIE_ANY_PORT,
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 947b63091902..761d6f5cd792 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -10,6 +10,7 @@
 
 #include <linux/errno.h>
 #include <linux/types.h>
+#include <linux/workqueue_types.h>
 
 #define AER_NONFATAL			0
 #define AER_FATAL			1
@@ -45,6 +46,24 @@ struct aer_capability_regs {
 	u16 uncor_err_source;
 };
 
+/**
+ * struct cxl_prot_err_info - Error information used in CXL error handling
+ * @pdev: PCI device with CXL error
+ * @dev: CXL device with error. From CXL topology using ACPI/platform discovery
+ * @ras_base: Mapped address of CXL RAS registers
+ * @severity: CXL AER/RAS severity: AER_CORRECTABLE, AER_FATAL, AER_NONFATAL
+ */
+struct cxl_prot_error_info {
+	struct pci_dev *pdev;
+	struct device *dev;
+	void __iomem *ras_base;
+	int severity;
+};
+
+struct cxl_prot_err_work_data {
+	struct cxl_prot_error_info err_info;
+};
+
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
@@ -56,6 +75,24 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
+#if defined(CONFIG_PCIEAER_CXL)
+int cxl_register_prot_err_work(struct work_struct *work,
+			       int (*_cxl_create_proto_err_info)(struct pci_dev*, int,
+								 struct cxl_prot_error_info*));
+int cxl_unregister_prot_err_work(void);
+int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd);
+#else
+static inline int
+cxl_register_prot_err_work(struct work_struct *work,
+			   int (*_cxl_create_proto_err_info)(struct pci_dev*, int,
+							     struct cxl_prot_error_info*))
+{
+	return 0;
+}
+static inline int cxl_unregister_prot_err_work(void) { return 0; }
+static inline int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd) { return 0; }
+#endif
+
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
-- 
2.34.1


