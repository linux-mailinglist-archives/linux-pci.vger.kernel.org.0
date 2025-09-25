Return-Path: <linux-pci+bounces-37038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE51BBA1D0F
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A141D74116D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04868321F34;
	Thu, 25 Sep 2025 22:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tjx5aCiF"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086032254B;
	Thu, 25 Sep 2025 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839739; cv=fail; b=S7voslhtNAljeh60D8i8G61sq9wuwsa49PTuPxR0Khc8kFaGfxqnHV1B2D4keZPU9AjsiDzEYi9RAux0qLVSBrE0YSQ9cMFwnn5on0JfDMZ4zNHIStUVbtLL5PNHZd7iENFsAFWXIi+F97tsIY++mNyGOXa1B4q4wVpEaW96TG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839739; c=relaxed/simple;
	bh=R/icRWsCuN6VLAQlO1vVJxvbRAOgg4Caxo+97obu3II=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKa8lcl2pz3lfcquSFwXjDsi1u56kNbJnHjozJORYqEdaeYhUIELe8ugFTVArm9svdXd3qfwe/u5mvxFyxvHZuLbYVUIZfsAjkDtDg1ogT6qA/oyeFkeT3nuzMWsmNcuFgV2OB6DlKncGX8b9CsbMLh5bIh/sGEuby+nTy2kEvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tjx5aCiF; arc=fail smtp.client-ip=52.101.52.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcTwbVm8w8WavenZ/rijtcrT8hbcAAGTecQNDi2wKSMkD+lRodBJ0JcA+1jyIzLnYlzeJj7fcxpdtOLtC9Wkcl0EMgudsurVbKAWeZoRSyGC0tb1Jdio6CeavGeEty18Uzne0Mzt569fv3hO7RGSCqRzUapqfPxYLmRHwRjk0ryUvmlQFiFYsmxSZheCMQysftqHtevdfeEPKZ0dIJHDmHd15pHbittyIBmEtzum05pWV1vDXo8MrI2Sd+pfTuondvgW132MSv+/dlApxx1ZB9PqzjW/bX0nkVvGXoDmpqSZpnPA/L2WwGcEMpNSBab37jRMVjwEnBEN6d5ca5F6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAbiw3+v28iubv5XLdKQyIPa997nl95Bv/IKIrPOgWE=;
 b=uJc6ODzH4r0eQzFBEBUNj4kcdjoErX0t2ECe++V6/IVUmDUFJAqCE7gDWIb0iTU72Ij5Lv2G40JXNzRJmieBszLlMFnkwsaN1RomnVP2hrofBZ902RsfYAQqKvVkcq0y3Gog0QCWfy0Xng1yaF+/viY68vqUowudJVmM2kpvtJB2uFMjHugsLhyGBV0j4fOZwE213Pag4P+FxCSvmOFQyjTDWLl66nsKxltfmMTElrFP2lkug6zcWEwdhHArNz+b6YtuN/xdM6+7BqqDFGT3ooOaj3VIDUOxUdw6cHo1T5ASpNpFTIeBpyYe+TDuU+RDKi8M37CGf3tIv+Q3Pprw4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAbiw3+v28iubv5XLdKQyIPa997nl95Bv/IKIrPOgWE=;
 b=Tjx5aCiFJswmef4amkh+3By9PJse4D0bJAHLP+nStwg1Dvb/S0xwCPgtWaazNEXG9fTVs7pMj+w8WkQiR5ljGK8Ivw6Kzwfc3ZuBlIlJVVxrRrN8F5muW7pq8losh/pdKMj52FJVksgJaw3P5BBDQONfyklIMN6EkDnihRq8tVY=
Received: from BY3PR05CA0008.namprd05.prod.outlook.com (2603:10b6:a03:254::13)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 22:35:33 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::eb) by BY3PR05CA0008.outlook.office365.com
 (2603:10b6:a03:254::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9 via Frontend Transport; Thu,
 25 Sep 2025 22:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:35:33 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:35:30 -0700
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
Subject: [PATCH v12 04/25] CXL/AER: Remove CONFIG_PCIEAER_CXL and replace with CONFIG_CXL_RAS
Date: Thu, 25 Sep 2025 17:34:19 -0500
Message-ID: <20250925223440.3539069-5-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: 6281a8f2-a1d5-4e07-7fe1-08ddfc83d6dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Jp9Vtldo63kfKEfpPyWoTCYo+O33L8icfAg2qfOwX3oh5XZxSSg35B96ZKD?=
 =?us-ascii?Q?qjd+PX4rGtRCUO1JlQcfXNdISogCZrjxFsGfKeqmzDvJnb/FVsK4SoAoHlAc?=
 =?us-ascii?Q?0ZPFWLnjdiIGM/wWjlt5MDrkpWVBEl/KyngnbreMQiQiLp/zHlbT1EWcJIzZ?=
 =?us-ascii?Q?hGQ9M1fKjgvgOs3siK9Efe70fr45YgGiWkdqmW6u4gH13jr9AZQ0jOH3xTjl?=
 =?us-ascii?Q?0FFp3naGGrY1L+uYndCUVRIB4Fb6oiY8UE2ZLyKIXh0A0ggYETzIegUmBE1f?=
 =?us-ascii?Q?epc/gnRU3401Eg52U+0T/Vui2uz0q8zfZ0l8U21s7KbtVHwU5A9x0+Gcjmqa?=
 =?us-ascii?Q?HAHWTKUbyDhgiW9jFKHHaWxFUQcK0yVAOsYtLAUmbVqoBl5re8bbkl/5cJoq?=
 =?us-ascii?Q?tKa7Z7InUR6mbV0uedlE6gqn1vw14rQb7wNwxntgjXvlNyBtOQLQ7+gD6+uc?=
 =?us-ascii?Q?kHoSXT3qQTwdlMMmIelH9VQN3c+ErbxIf4j+ymQ9atObnpGnBzS8VfmAuUH9?=
 =?us-ascii?Q?Gw+odmwIRtFyw1Ss0fznkaQrhxwxGzSegvnTzkfHCe/GOArRGPU8CG5Lcl+f?=
 =?us-ascii?Q?BbJ2yQjwJ0I8LBJDCKafYa8VkhRz/mJ/mfX7mggSBqYKIFMSiD03QkMfi9aL?=
 =?us-ascii?Q?PUfxMpCMcqesTkatk7cFVjS3Bxcm+Dgtmf1470s4+7avLiibYwk+SevB2Ev2?=
 =?us-ascii?Q?AtMXyF7Cd+ZNs4/ph/WgpIbOxagoJLASv4sCReWTGKgGYehWCPA8ZWq3Rou3?=
 =?us-ascii?Q?qKBr+xg8hFvmvKmBRLDp8ezI0omV4s3ZRsTmHXOD/wAj42UsHkYGYzU9Mw5b?=
 =?us-ascii?Q?JGyeJJz25NQROiCf4pK6v4XjMSE1lTymxix9vxb+7ObzoCyYuo9Gdb7IUK9r?=
 =?us-ascii?Q?Ehs84Du1sYNNmz+wDT08WIyqoQ+vQJ0UXpwhs5lo7H2CU4q0sSaQ+zeE4Xb/?=
 =?us-ascii?Q?/A1UQ/msTAFxfiSWwJxovMQsyVuRMMJAgCUmWJS50o/RYxJTR0iHEFkUe/tA?=
 =?us-ascii?Q?9i2XsHQDoXXjBE3uO12YguNftrxkNw4QIohk0Gh2Y0xo6tef7UH80PY+TG5C?=
 =?us-ascii?Q?4OmdsbfwhneppZSAsDBf8RhlfOvYejV0vTbBmMjZvyhu26qc259+PPGQURo5?=
 =?us-ascii?Q?FAFBHYOG8/jXLmGPn/aicEgklrQ/lIXqokjRXr3CQ0+nUlVsPZ442zQ70DXo?=
 =?us-ascii?Q?+gQSBUq+RtAp8RBHH3hrrYKZqGjiIiGNjNMf/DMAyqK6bKazpR/RCMzMEwdo?=
 =?us-ascii?Q?Gs/r3rpOBYtMGJR/fJOuCSSPx1CvVRXlSPhwTdmC/BP4HsZN0nAG5cTE4eQ5?=
 =?us-ascii?Q?S311ae3XwT2HFV7N9/A28SlcIcP6+8XpP2cRkYq2sfiv/fBOfN36urOBApiO?=
 =?us-ascii?Q?XbknkW5cRVcP2UCsfJTyRGZoRQchlCWXlus3ljR4Jq//Dy3s6imb3fryYK+N?=
 =?us-ascii?Q?u1QHs86A52us1tXABue7P2wwuUrpVZlXHlxU3kXdwGY//yCgueVIdfj+3khk?=
 =?us-ascii?Q?YkyYQhadIw8oJ90Z8j58+T2PJkFodWbf5hqKVC3zm93HkKoUOYCyAAvKXsFR?=
 =?us-ascii?Q?/Oaj9WKELqIigSqFBhVhnrnlA+0I+vz9DxNY0sbS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:35:33.0824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6281a8f2-a1d5-4e07-7fe1-08ddfc83d6dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218

CXL RAS compilation is enabled using CONFIG_CXL_RAS while the AER CXL logic
uses CONFIG_PCIEAER_CXL. The 2 share the same dependencies and can be
combined. The 2 kernel configs are unnecessary and are problematic for the
user because of the duplication. Replace occurrences of CONFIG_PCIEAER_CXL
to be CONFIG_CXL_RAS.

Update the CONFIG_CXL_RAS Kconfig definition to include dependencies 'PCIEAER
&& CXL_PCI' taken from the CONFIG_PCIEAER_CXL definition.

Remove the Kconfig CONFIG_PCIEAER_CXL definition.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

---

Changes in v11 -> v12:
- Added review-by for Sathyanarayanan
- Changed Kconfig dependency from PCIEAER_CXL to PCIEAER. Moved
  this backwards into this patch.

Changes in v10 -> v11:
- New patch
---
 drivers/cxl/Kconfig      | 2 +-
 drivers/pci/pcie/Kconfig | 9 ---------
 drivers/pci/pcie/aer.c   | 2 +-
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 9246f734e6ca..b92d544cfe6f 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -235,5 +235,5 @@ config CXL_MCE
 
 config CXL_RAS
 	def_bool y
-	depends on ACPI_APEI_GHES && PCIEAER_CXL && CXL_PCI
+	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
 endif
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 17919b99fa66..207c2deae35f 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -49,15 +49,6 @@ config PCIEAER_INJECT
 	  gotten from:
 	     https://github.com/intel/aer-inject.git
 
-config PCIEAER_CXL
-	bool "PCI Express CXL RAS support"
-	default y
-	depends on PCIEAER && CXL_PCI
-	help
-	  Enables CXL error handling.
-
-	  If unsure, say Y.
-
 #
 # PCI Express ECRC
 #
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e286c197d716..7a1dc2a3460b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1087,7 +1087,7 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
-#ifdef CONFIG_PCIEAER_CXL
+#ifdef CONFIG_CXL_RAS
 
 /**
  * pci_aer_unmask_internal_errors - unmask internal errors
-- 
2.34.1


