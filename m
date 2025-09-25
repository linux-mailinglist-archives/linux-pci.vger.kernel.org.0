Return-Path: <linux-pci+bounces-37044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E16BA1D36
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505002A07E9
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BED32255F;
	Thu, 25 Sep 2025 22:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mkXNuCWG"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9264322A18;
	Thu, 25 Sep 2025 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839807; cv=fail; b=sfVQPAknNdYaJsyxGBfT6n0EfSFVciEih9B1zq1FQc5xv2eehyhs3eb7Zi6FhRRx4cxZDHe1XliL5kLr61dK+egzYruN3mADK5Si8SBnhaVdnOB34j3Y3uLEwJL9V4b+sdNkyEp3Ii1I4+aICsxeoxrXUO8eI9oqMhqXctDkgpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839807; c=relaxed/simple;
	bh=Je7l0tK+jqVX+2Y1t4Bwr8Sa07jp70Y/FT0mZWkIzTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAovKfSaX8g1R7vD2r7l+PC5mG4KdI1J34Vn08PGVz/GJyYsaS9uTDQcNp+L6beLdOoNKh/0QR5urvwbIpRzeDKYrWz6RRcyEJo2kXmOfX99ZB+KVmHgyGjzT7/P3BwITHIsthmxhlDkeV/dWHX7ZAmuAzdpd+DZ0m79JIaIqBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mkXNuCWG; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g11FrNzlrEaqpnsT+KgSDUDun7yfd5hwaxj8RqqcXXiHCdkW3j/RgqGEkh2R8nhPY778esI2GgEJlWmH5KzTTSyvIYIq2zxTUfXiWUwYsDpqLvp79xqu2rqGv4VUIhMrFilwXixaQAAYmNORK5TvlDEMm7htgCBalySUmFWh2p6At/3Sm3StazQ/46SEFU9o+T2oEEYYryFt6Tb0uBlnaJ1BKAbTL+IkUN1PdZMo63n+Pftuwm91SdhBylKMTT+T/7WUhoogcABPYt/yxfELadbF+d/VGwFdUiy4mN+j0oXKU3xeHEs5XGqE57r1ETxuCvDb2HxcnrN4DZPMPWujEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTUAdXcxHECn52Kc50dOqQyrGevMAaE5nMzHgCu5Dd4=;
 b=r5yUwyLDxotZ0UpkzrWv3lNKQ5vLRXJc9BdUQrTsB90JjTaDS7MKJ9te8fOZmZR53dDACGxza66KPkzdv9loJTfSkCd0ey+v1kwkiCnO1FkvjIHLj7+WzSMegxRaka1exrOqfYMIoURLgNu+YJZjcex7vm5Kbih+rL5YLDlyOgGjW4u0LJIFDCd30kghOdIlaxXBiwRQAk6ZPj2HtemQK6B7JEPwq13KSJyW0AF5zMkACa/2rJd65ZT/dwmorGErVEO/zynCJqVDPlMmEl9tFEgKW+CINqy79ls1e6heDjGfP6JEYq7lleD/WEvFaTkzwKjcDKhpLXWYExhEj82MpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTUAdXcxHECn52Kc50dOqQyrGevMAaE5nMzHgCu5Dd4=;
 b=mkXNuCWGnEleaOqRIxLpI5fgIOmpG1bfO+9WvSulxGtnhAsT5YRS0e12AmXwBlILPDchmeKQYOr+Kg9Z+Y61lSEo+OG+YjuSV38inSUA2QRLA+I5cFPf8jOAmOKW8SpcegOpQ9Ef84R1mjVxxOURc40KtE8ZlBkS0VD8mR+TFXQ=
Received: from SJ0PR03CA0098.namprd03.prod.outlook.com (2603:10b6:a03:333::13)
 by CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 22:36:38 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::9a) by SJ0PR03CA0098.outlook.office365.com
 (2603:10b6:a03:333::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 22:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:36:38 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:36:37 -0700
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
Subject: [PATCH v12 10/25] CXL/AER: Update PCI class code check to use FIELD_GET()
Date: Thu, 25 Sep 2025 17:34:25 -0500
Message-ID: <20250925223440.3539069-11-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: 02203528-1395-4ead-31ff-08ddfc83fe00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XnxTAQpL/lkUbbx0Nu7LDHIgpRc6YEysNlWxg4jgrOcDbedGgZCfaWHdhX9+?=
 =?us-ascii?Q?BIWzLLePqK/xaWKObxiRge4y1TGfFEFyTXa9C2nsR290hL63WY5SZrOzh3OY?=
 =?us-ascii?Q?Ad2bqBPuklkVcpMB8+ScJKTaqxeArdK9JVkUItC0vhPtAW4DIXGMMvnt4lgc?=
 =?us-ascii?Q?QZGCyYtErvRdpoVrbLdk/waCHwibdl+uUBdVsl/T2FvZeCQFpmpwi8GhRN05?=
 =?us-ascii?Q?ZHEXHNBlB3ZAgIKtk1skn/ykHMY1ytsyp4RIQMNKaibvvlELCVE8jxuj7kN5?=
 =?us-ascii?Q?stAAfGR1zkFMrNQiELT1l5XAvE1mALepqK9jlWHXCpqGCF4MoCsbzz0GLWLA?=
 =?us-ascii?Q?KNvEh0zFKJZ56/X5G+B4ND9cStn6NjM75RowLWIzjErcOs1HJ/idwX8UckrU?=
 =?us-ascii?Q?4QKxboYBm8/yYb1uePMmtjIN2wxQx69TWv4qyw14S+vngIKzeTNMtB5PdqDE?=
 =?us-ascii?Q?aCxS87ZdUpgOzsZnVjaGyD2fVluF4NpUBtwYpkrfN5JlX1PR9/kwoiNxFJLX?=
 =?us-ascii?Q?JmIj0PrEaFccOaJuT5IaHA8NO/crIEUCXdUbnLZl2ctNS5RBkymNkZeYTy1T?=
 =?us-ascii?Q?W4EfN/DepGC9Bikc0CduEbCkOlN9bZz3XTHpQhT+PDrYK3fitAwkQLxz1hON?=
 =?us-ascii?Q?HlJlCbHb4QR85Elmeri7j3sbyI5X1UIXbbSNyo7E/jihzXjHMekrD+0RbFYL?=
 =?us-ascii?Q?KQ4JFoieEoOJ1b+1wfft3ZRYKVJFGfRPfkfM81sxELJcFjaiKMcPsP1oj/SC?=
 =?us-ascii?Q?xZHEJcNFa2XcQT5v0bGgsdVr+ZtFDvSsoaIBVQ8sUelyRLSWb4Bi/HxPZn6I?=
 =?us-ascii?Q?O6itzfkzHWqmD55bvxg/70LSIImQnTavrzco601IK2sPMaGkKuZ1vjbGtZKq?=
 =?us-ascii?Q?lX3ZEax5p9Oe3lfWX4T/F5Rezd63iOYqDmkJU3yukikgctww1fPM5c6n0CRO?=
 =?us-ascii?Q?6q3CY+6gzocAGJIek131QGnEZpV+N85yjOKqHLdv857m9Z2uDCNnDtEvrjvj?=
 =?us-ascii?Q?PDzf4sCudj6PR1T+83JaJB76NRVkOaMTuN3jGkJCtjbrStNi+v5AQT3is4mh?=
 =?us-ascii?Q?jhRCaWS7rZ06KZKa2iiEXI7lCxVidG/NMvq/3UINq+GYC9McjFDN/w0O/Xkz?=
 =?us-ascii?Q?g0whprFjZFnofP9QMptgFRjuBvVB9hijFdDb7/A6WxKCmiU+52BN7ga6aUHF?=
 =?us-ascii?Q?/Y41x3Cpf/b30sU2YFtLD+vIWOvH+BwDF+wZ5ramF1VPDXm1dtI8SvGcGH4r?=
 =?us-ascii?Q?Ha+IakzSZ7okSXGg+fVgN82Aet1AwbfMDsFQ6FfvG4PPtxzjCIY0Gk/t6Ybe?=
 =?us-ascii?Q?Pk21/Ox2FIfLLRkfkddmEuiTs/QsE5/NEjysV8K3wMtEF/mFS7D3fcquK1dZ?=
 =?us-ascii?Q?Lz3VUfwdsOJAf7C8Zx6R42Jo/sMRfJx/qi5/kxl7TSjI24VXuJ9C4CA4umek?=
 =?us-ascii?Q?YdW69i8rT95ODcOkxNdeg2Sncv0NCOtagoQNl/97X46YApf2YQFs4c8vy9MT?=
 =?us-ascii?Q?u+WjfHtfU/SBqfcGcIF0hjGA/idO+iKMKd9fTDClyRPKMBYbaIuh16h/M6Qf?=
 =?us-ascii?Q?eHVxFrAakp78lY3sUsR3pNKTQ31D3OkqopS+h5WD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:36:38.7562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02203528-1395-4ead-31ff-08ddfc83fe00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339

Update the AER driver's is_cxl_mem_dev() to use FIELD_GET() while checking
for a CXL Endpoint class code.

Introduce a genmask bitmask for checking PCI class codes and locate in
include/uapi/linux/pci_regs.h.

Update the function documentation to reference the latest CXL
specification.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v11->v12:

Changes in v10->v11:
- Add #include <linux/bitfield.h> to cxl_ras.c
- Removed line wrapping at "(CXL 3.2, 8.1.12.1)".
---
 drivers/pci/pcie/aer.c         | 1 +
 drivers/pci/pcie/aer_cxl_rch.c | 6 +++---
 include/uapi/linux/pci_regs.h  | 2 ++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index befa73ace9bb..6ba8f84add70 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -30,6 +30,7 @@
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
 #include <linux/slab.h>
+#include <linux/bitfield.h>
 #include <acpi/apei.h>
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
index bfe071eebf67..c3e2d4cbe8cc 100644
--- a/drivers/pci/pcie/aer_cxl_rch.c
+++ b/drivers/pci/pcie/aer_cxl_rch.c
@@ -17,10 +17,10 @@ static bool is_cxl_mem_dev(struct pci_dev *dev)
 		return false;
 
 	/*
-	 * CXL Memory Devices must have the 502h class code set (CXL
-	 * 3.0, 8.1.12.1).
+	 * CXL Memory Devices must have the 502h class code set
+	 * (CXL 3.2, 8.1.12.1).
 	 */
-	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
+	if (FIELD_GET(PCI_CLASS_CODE_MASK, dev->class) != PCI_CLASS_MEMORY_CXL)
 		return false;
 
 	return true;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index bd03799612d3..802a7384f99a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -73,6 +73,8 @@
 #define PCI_CLASS_PROG		0x09	/* Reg. Level Programming Interface */
 #define PCI_CLASS_DEVICE	0x0a	/* Device class */
 
+#define PCI_CLASS_CODE_MASK     __GENMASK(23, 8)
+
 #define PCI_CACHE_LINE_SIZE	0x0c	/* 8 bits */
 #define PCI_LATENCY_TIMER	0x0d	/* 8 bits */
 #define PCI_HEADER_TYPE		0x0e	/* 8 bits */
-- 
2.34.1


