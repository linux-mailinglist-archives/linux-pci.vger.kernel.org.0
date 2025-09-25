Return-Path: <linux-pci+bounces-37041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40A5BA1D27
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA9916AE84
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B029E322C76;
	Thu, 25 Sep 2025 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Md/lrYbr"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D7322752;
	Thu, 25 Sep 2025 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839771; cv=fail; b=FCTyWxBy8JzW41TWuw86KfQq1UAHanhiHJWfE+azWNnOy4a6BpKICW898LlEw0OsAhrjZjJYOgx5EQHrsIpeeSrBGZiHXYXvS2/aJXZusRGH0qSeZgWOmuwMkI+65eVYY+gacUOBzsEmnzU5MfZzoMNgoRWm2Rc+1/uMed/Uyc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839771; c=relaxed/simple;
	bh=m5T27RLZOzH673xQCDjJh7/h2ltU/O7gT4VCDC0sj/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svlX+huFIGL8hh/VWzRgX3mRjKUT4myYSd62OPjK4DCxUYxpMRQzBIei/08TmxK57BagN+OYDiK7GyYK5vHUePMoe9F9uE6v1GVMLGpUzCyZslcdLoteTkN4/ffGigGMKGBId/yl1ry4+CxTyY02G94lniFGPHe1EIrigSi0ycc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Md/lrYbr; arc=fail smtp.client-ip=40.93.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APGPQ9qpKYOH21JY37p7YVFVp8U9+FEwfS5iz9CsvM6mSiR4qeCNwpGZg6I2sYz7jbq+jdDaW2Bsprt8kTvwWRMw6NTspfJhPAgu9m4ojLYAIN0rGo3aM11mFcouhZPSOe80XjJGWaVEQBUzSfAAsMo15UlIO/XYv9Rfr9BxrP1PczU3UQJ/s/lN13D3BeBmiQcTMUIkRKCpzENBL0H9Yfe0T79iZmKWGrUB3Ke0IoLycMeRWIoz76eRoQxHVEQlZc1EUBO0YlUeyrvvR9cIZDMVrQj208v+WR9sKvfAd+W8xLMPHOhk6FiJ327XmjpIXxC3GnEvGL3dgXlyyRNm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBiEugo8Lgij2IjcEqvsURWzLsRI+u6MNHzhgl7Jpbg=;
 b=goIV/XGQqamYrPvJyCJvSfeVH6AmeKOIvN/dhfQNeO9drMpdG0RMl5q3ze37bCM82vW3C6BnKHcGbEAv+z9Ge691xerhRRZ1JhaWCjgaFy9zmFKYvFFWMdcciVh6jjZ3KwdMhNoFJjcCWKhuTqZxgpbMBqMD+ZypqdvHWPvRpO6Mno2r/S+3Oh90OjcFMilpZJSMw5gdUd4hhc+bMYsZByNLKQsL1hEYGqD0PEQ8icPr3klzPbfaJfi7peJN1eSb3xhCXDMsTPRwyINAeR99n4BDgtVSoqsJs77djxyKZjbtqY/xIRgUgP1CSrQPSV4kiD9mn+qD0ybqukJ4337WZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBiEugo8Lgij2IjcEqvsURWzLsRI+u6MNHzhgl7Jpbg=;
 b=Md/lrYbrdoKvOi3hdkiRwkcnpA3OUdljllxAm0tXNVFCfyKIygIJR7O3lTxCRZ9BQdbje2O2SdRMYAeyGDuk9SlcvKJxq+Ht8LzhYTHTY3ckyL4QiH+QrtVP2DwXh6JZe7HNhgwqYgAIEzOIqDyGpBCPmBz/Xfzae5vyTWzJheo=
Received: from SJ0PR03CA0110.namprd03.prod.outlook.com (2603:10b6:a03:333::25)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 22:36:05 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::77) by SJ0PR03CA0110.outlook.office365.com
 (2603:10b6:a03:333::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Thu,
 25 Sep 2025 22:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:36:05 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:36:03 -0700
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
Subject: [PATCH v12 07/25] CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
Date: Thu, 25 Sep 2025 17:34:22 -0500
Message-ID: <20250925223440.3539069-8-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cca780-9e50-4d1d-0f76-08ddfc83ea57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?36XHeM0VcPTOwfVHQ1e9lumMYaoncGSH9dvO+YL2sYWOkkPEbSsFuIp4+SSp?=
 =?us-ascii?Q?Qg9IinVOPhSsOzvu80+kQIH0QzOsP5RwqN6fRzxfbXa0jyMBBUbFS3yC4ll3?=
 =?us-ascii?Q?wuHZtTf/p3Zv8tU6qc7I5eHhn3MQuSDm1pSwaFLSLGM27gLuCWRVC1fdkujW?=
 =?us-ascii?Q?1uFG/Mpc7Ik/w2QbyOUL4LN5bsyqwjMg9ZYibiB6z85F4XAaNy0Ie4iqAgoF?=
 =?us-ascii?Q?RHs2qYVWJ+joMuqMJM7I+1CtRqope1lCnqE5AVlxmhf1HQSx925+eLqZRM4k?=
 =?us-ascii?Q?Rn5v+wzaT+5EJNTciODSr/44rGy1GhRMue38EObD0MuFrDK3jcRXf3P/d5WL?=
 =?us-ascii?Q?iNWHXi0IRG3ybO10vLl6+m/RTAA3iU3e34Dz0OZAnMlQ3ZwZNhrtJOCtusrg?=
 =?us-ascii?Q?eOAZsayCudT64VCctYnhqbgqI1leEQQiiVNaEU8Lf1yEcU++ObJVkUUd/bIN?=
 =?us-ascii?Q?65WZd9WL3qTL7404hb9exmEHccJL3kVS1VuTaMqap1qMdPnrg9+hixhtX36S?=
 =?us-ascii?Q?3Za8vkXnrm9a/kRdWaankCNQU9+a1M7BBn6kQ7kTgPBlAi9To15RDbUZQAMy?=
 =?us-ascii?Q?P+TfR27jesrr+JfL8Ms4arcl0Rhrw/5zB2OPKxEBQ/bPEEuVjnKiHmeJVHFW?=
 =?us-ascii?Q?qJOYIumi7xQS9ti7oQpnI7ZmaySiXPzirsKUZ4+BSjnQ8R0IxBeR5X54XOec?=
 =?us-ascii?Q?+RxMgPgbifNR73mpW+TAJZJV7KDs1NbeUbeRPxZtIb1rGHv3wCqE5n/kRHVU?=
 =?us-ascii?Q?NKusDusLLc2t0cXMsxD0p5nKkRu5aO4z1+rqNE4UopatbDPDrjqKRCVLeerE?=
 =?us-ascii?Q?BSIrFuDS1HH0yZB/JzavMqChFchk8IY5C3liqVei3tn60E4d+XLLdJzevwmc?=
 =?us-ascii?Q?T2UCgpOUCDj6wht75Sv5NUym2SsNK9/Oc6+cr+kpyDCvEa3AlALq2I52FHyv?=
 =?us-ascii?Q?B5MkildZSAN/3c/0dr5Fd1OHwgBvIUoqq9PONWh5YO8lCFQUPvxJVScFWp5Z?=
 =?us-ascii?Q?t4t53BH0a215B+zOm2Uq+c4AMpJxfMsCWmugcMcbryZI8Zh6Mbvol+0gIuoP?=
 =?us-ascii?Q?I7dY5HJhkmRUqUV73JqZr2BovwDOTQVGJ3/1CS5Wu/gY03YSfj14LODAMlHw?=
 =?us-ascii?Q?zOFSc6FUVn4C5qrlb8mQ/ZSBJdMeeXskoLCfy5+mNBrvo19qkxtvpkAwAX0u?=
 =?us-ascii?Q?TX7gOeWnOkE0KO9LCFTlBgC+ZwbGjZ0fjyJZg7wsbJcY+Qw97ul5/rApndMx?=
 =?us-ascii?Q?RwD2m1neiqBQYv1M4OIbcdgvwGyUA6qYX5PzVqkm0+Cce/H1TM1RuWR/da2y?=
 =?us-ascii?Q?M04LeXuSX1KNHoDg+mwFyUe7HLFFlMoQMYdGMyox8oxH69V1o3BxFnaq6Tio?=
 =?us-ascii?Q?sl4p/EvURBANRr+7iv9plqz53ea3d3qptOXu515KlZLI9VPSZclyrsX5RjzV?=
 =?us-ascii?Q?Ppg4eekx7J08bfvweJTB6qKiZnHctb7cugLR3ZcvamzINM7b5hjzbyQaURAI?=
 =?us-ascii?Q?JaAyfLpld/lPwaI8ivbZD7idJDAEnDaMgxzSUWzlY9YRlhJB3v7zkM6KQg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:36:05.7705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cca780-9e50-4d1d-0f76-08ddfc83ea57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217

The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
accessible to other subsystems.

Change DVSEC name formatting to follow the existing PCI format in
pci_regs.h. The current format uses CXL_DVSEC_XYZ. Change to be PCI_DVSEC_CXL_XYZ.
Reuse the existing formatting.

Update existing occurrences to match the name change.

Update the inline documentation to refer to latest CXL spec version.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

----

Changes in v11 -> v12:
- Change formatting to be same as existing definitions
- Change GENMASK() -> __GENMASK() and BIT() to _BITUL()

Changes in v10 -> v11:
- New commit
---
 drivers/cxl/core/pci.c        | 62 +++++++++++++++++-----------------
 drivers/cxl/core/regs.c       | 12 +++----
 drivers/cxl/cxlpci.h          | 53 -----------------------------
 drivers/cxl/pci.c             |  2 +-
 drivers/pci/pci.c             | 18 +++++-----
 include/uapi/linux/pci_regs.h | 63 ++++++++++++++++++++++++++++++++---
 6 files changed, 107 insertions(+), 103 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a009a51cb0de..a74a39bd909c 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -157,19 +157,19 @@ static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
 	int rc, i;
 	u32 temp;
 
-	if (id > CXL_DVSEC_RANGE_MAX)
+	if (id > PCI_DVSEC_CXL_RANGE_MAX)
 		return -EINVAL;
 
 	/* Check MEM INFO VALID bit first, give up after 1s */
 	i = 1;
 	do {
 		rc = pci_read_config_dword(pdev,
-					   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
+					   d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
 					   &temp);
 		if (rc)
 			return rc;
 
-		valid = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
+		valid = FIELD_GET(PCI_DVSEC_CXL_MEM_INFO_VALID, temp);
 		if (valid)
 			break;
 		msleep(1000);
@@ -193,17 +193,17 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
 	int rc, i;
 	u32 temp;
 
-	if (id > CXL_DVSEC_RANGE_MAX)
+	if (id > PCI_DVSEC_CXL_RANGE_MAX)
 		return -EINVAL;
 
 	/* Check MEM ACTIVE bit, up to 60s timeout by default */
 	for (i = media_ready_timeout; i; i--) {
 		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(id), &temp);
+			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id), &temp);
 		if (rc)
 			return rc;
 
-		active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
+		active = FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE, temp);
 		if (active)
 			break;
 		msleep(1000);
@@ -232,11 +232,11 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 	u16 cap;
 
 	rc = pci_read_config_word(pdev,
-				  d + CXL_DVSEC_CAP_OFFSET, &cap);
+				  d + PCI_DVSEC_CXL_CAP_OFFSET, &cap);
 	if (rc)
 		return rc;
 
-	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
+	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT_MASK, cap);
 	for (i = 0; i < hdm_count; i++) {
 		rc = cxl_dvsec_mem_range_valid(cxlds, i);
 		if (rc)
@@ -264,16 +264,16 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 	u16 ctrl;
 	int rc;
 
-	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
+	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL_OFFSET, &ctrl);
 	if (rc < 0)
 		return rc;
 
-	if ((ctrl & CXL_DVSEC_MEM_ENABLE) == val)
+	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
 		return 1;
-	ctrl &= ~CXL_DVSEC_MEM_ENABLE;
+	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
 	ctrl |= val;
 
-	rc = pci_write_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, ctrl);
+	rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL_OFFSET, ctrl);
 	if (rc < 0)
 		return rc;
 
@@ -289,7 +289,7 @@ static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
 {
 	int rc;
 
-	rc = cxl_set_mem_enable(cxlds, CXL_DVSEC_MEM_ENABLE);
+	rc = cxl_set_mem_enable(cxlds, PCI_DVSEC_CXL_MEM_ENABLE);
 	if (rc < 0)
 		return rc;
 	if (rc > 0)
@@ -351,11 +351,11 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 		return -ENXIO;
 	}
 
-	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CAP_OFFSET, &cap);
+	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CAP_OFFSET, &cap);
 	if (rc)
 		return rc;
 
-	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
+	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE)) {
 		dev_dbg(dev, "Not MEM Capable\n");
 		return -ENXIO;
 	}
@@ -366,7 +366,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 	 * driver is for a spec defined class code which must be CXL.mem
 	 * capable, there is no point in continuing to enable CXL.mem.
 	 */
-	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
+	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT_MASK, cap);
 	if (!hdm_count || hdm_count > 2)
 		return -EINVAL;
 
@@ -375,11 +375,11 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 	 * disabled, and they will remain moot after the HDM Decoder
 	 * capability is enabled.
 	 */
-	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
+	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL_OFFSET, &ctrl);
 	if (rc)
 		return rc;
 
-	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
+	info->mem_enabled = FIELD_GET(PCI_DVSEC_CXL_MEM_ENABLE, ctrl);
 	if (!info->mem_enabled)
 		return 0;
 
@@ -392,35 +392,35 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			return rc;
 
 		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
+			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i), &temp);
 		if (rc)
 			return rc;
 
 		size = (u64)temp << 32;
 
 		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);
+			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(i), &temp);
 		if (rc)
 			return rc;
 
-		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
+		size |= temp & PCI_DVSEC_CXL_MEM_SIZE_LOW_MASK;
 		if (!size) {
 			continue;
 		}
 
 		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
+			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i), &temp);
 		if (rc)
 			return rc;
 
 		base = (u64)temp << 32;
 
 		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_BASE_LOW(i), &temp);
+			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_LOW(i), &temp);
 		if (rc)
 			return rc;
 
-		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
+		base |= temp & PCI_DVSEC_CXL_MEM_BASE_LOW_MASK;
 
 		info->dvsec_range[ranges++] = (struct range) {
 			.start = base,
@@ -828,7 +828,7 @@ u16 cxl_gpf_get_dvsec(struct device *dev)
 		is_port = false;
 
 	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
-			is_port ? CXL_DVSEC_PORT_GPF : CXL_DVSEC_DEVICE_GPF);
+			is_port ? PCI_DVSEC_CXL_PORT_GPF : PCI_DVSEC_CXL_DEVICE_GPF);
 	if (!dvsec)
 		dev_warn(dev, "%s GPF DVSEC not present\n",
 			 is_port ? "Port" : "Device");
@@ -844,14 +844,14 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
 
 	switch (phase) {
 	case 1:
-		offset = CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET;
-		base = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK;
-		scale = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK;
+		offset = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_CONTROL_OFFSET;
+		base = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_BASE_MASK;
+		scale = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_SCALE_MASK;
 		break;
 	case 2:
-		offset = CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET;
-		base = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK;
-		scale = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK;
+		offset = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_CONTROL_OFFSET;
+		base = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_BASE_MASK;
+		scale = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_SCALE_MASK;
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 5ca7b0eed568..fb70ffbba72d 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -271,10 +271,10 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, "CXL");
 static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 				struct cxl_register_map *map)
 {
-	u8 reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
-	int bar = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
+	u8 reg_type = FIELD_GET(PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
+	int bar = FIELD_GET(PCI_DVSEC_CXL_REG_LOCATOR_BIR_MASK, reg_lo);
 	u64 offset = ((u64)reg_hi << 32) |
-		     (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
+		     (reg_lo & PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
 
 	if (offset > pci_resource_len(pdev, bar)) {
 		dev_warn(&pdev->dev,
@@ -311,15 +311,15 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
 	};
 
 	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
-					   CXL_DVSEC_REG_LOCATOR);
+					   PCI_DVSEC_CXL_REG_LOCATOR);
 	if (!regloc)
 		return -ENXIO;
 
 	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
 	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
 
-	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
-	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
+	regloc += PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1_OFFSET;
+	regblocks = (regloc_size - PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1_OFFSET) / 8;
 
 	for (i = 0; i < regblocks; i++, regloc += 8) {
 		u32 reg_lo, reg_hi;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 970e84cf49e9..0c8b6ee7b6de 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -7,59 +7,6 @@
 
 #define CXL_MEMORY_PROGIF	0x10
 
-/*
- * See section 8.1 Configuration Space Registers in the CXL 2.0
- * Specification. Names are taken straight from the specification with "CXL" and
- * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
- */
-#define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
-
-/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
-#define CXL_DVSEC_PCIE_DEVICE					0
-#define   CXL_DVSEC_CAP_OFFSET		0xA
-#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
-#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
-#define   CXL_DVSEC_CTRL_OFFSET		0xC
-#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
-#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
-#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
-#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
-#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
-#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
-#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
-
-#define CXL_DVSEC_RANGE_MAX		2
-
-/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
-#define CXL_DVSEC_FUNCTION_MAP					2
-
-/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
-#define CXL_DVSEC_PORT_EXTENSIONS				3
-
-/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
-#define CXL_DVSEC_PORT_GPF					4
-#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
-#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
-#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
-#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
-#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
-#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
-
-/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
-#define CXL_DVSEC_DEVICE_GPF					5
-
-/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
-#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
-
-/* CXL 2.0 8.1.9: Register Locator DVSEC */
-#define CXL_DVSEC_REG_LOCATOR					8
-#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
-#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
-#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
-#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
-
 /*
  * NOTE: Currently all the functions which are enabled for CXL require their
  * vectors to be in the first 16.  Use this as the default max.
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bd100ac31672..bd95be1f3d5c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -933,7 +933,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	cxlds->rcd = is_cxl_restricted(pdev);
 	cxlds->serial = pci_get_dsn(pdev);
 	cxlds->cxl_dvsec = pci_find_dvsec_capability(
-		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
+		pdev, PCI_VENDOR_ID_CXL, PCI_DVSEC_CXL_DEVICE);
 	if (!cxlds->cxl_dvsec)
 		dev_warn(&pdev->dev,
 			 "Device DVSEC not present, skip CXL.mem init\n");
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0f4d98036cd..1a4f61caa0db 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5041,7 +5041,7 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 static u16 cxl_port_dvsec(struct pci_dev *dev)
 {
 	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
-					 PCI_DVSEC_CXL_PORT);
+					 PCI_DVSEC_CXL_PORT_EXT);
 }
 
 static bool cxl_sbr_masked(struct pci_dev *dev)
@@ -5053,7 +5053,9 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 	if (!dvsec)
 		return false;
 
-	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+	rc = pci_read_config_word(dev,
+				  dvsec + PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET,
+				  &reg);
 	if (rc || PCI_POSSIBLE_ERROR(reg))
 		return false;
 
@@ -5062,7 +5064,7 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 	 * bit in Bridge Control has no effect.  When 1, the Port generates
 	 * hot reset when the SBR bit is set to 1.
 	 */
-	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)
+	if (reg & PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR)
 		return false;
 
 	return true;
@@ -5107,22 +5109,22 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;
 
-	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET, &reg);
 	if (rc)
 		return -ENOTTY;
 
-	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
+	if (reg & PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR) {
 		val = reg;
 	} else {
-		val = reg | PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
-		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
+		val = reg | PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR;
+		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET,
 				      val);
 	}
 
 	rc = pci_reset_bus_function(dev, probe);
 
 	if (reg != val)
-		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
+		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET,
 				      reg);
 
 	return rc;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f5b17745de60..bd03799612d3 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1234,9 +1234,64 @@
 /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
 
-/* Compute Express Link (CXL r3.1, sec 8.1.5) */
-#define PCI_DVSEC_CXL_PORT				3
-#define PCI_DVSEC_CXL_PORT_CTL				0x0c
-#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
+/* Compute Express Link (CXL r3.2, sec 8.1)
+ *
+ * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
+ * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
+ * registers on downstream link-up events.
+ */
+
+#define PCI_DVSEC_HEADER1_LENGTH_MASK  __GENMASK(31, 20)
+
+/* CXL 3.2 8.1.3: PCIe DVSEC for CXL Device */
+#define PCI_DVSEC_CXL_DEVICE			0
+#define  PCI_DVSEC_CXL_CAP_OFFSET		0xA
+#define   PCI_DVSEC_CXL_MEM_CAPABLE		_BITUL(2)
+#define   PCI_DVSEC_CXL_HDM_COUNT_MASK		__GENMASK(5, 4)
+#define  PCI_DVSEC_CXL_CTRL_OFFSET		0xC
+#define   PCI_DVSEC_CXL_MEM_ENABLE		_BITUL(2)
+#define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
+#define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
+#define   PCI_DVSEC_CXL_MEM_INFO_VALID		_BITUL(0)
+#define   PCI_DVSEC_CXL_MEM_ACTIVE		_BITUL(1)
+#define   PCI_DVSEC_CXL_MEM_SIZE_LOW_MASK	__GENMASK(31, 28)
+#define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
+#define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
+#define   PCI_DVSEC_CXL_MEM_BASE_LOW_MASK	__GENMASK(31, 28)
+
+#define PCI_DVSEC_CXL_RANGE_MAX			2
+
+/* CXL 3.2 8.1.4: Non-CXL Function Map DVSEC */
+#define PCI_DVSEC_CXL_FUNCTION_MAP				2
+
+/* CXL 3.2 8.1.5: Extensions DVSEC for Ports */
+#define PCI_DVSEC_CXL_PORT_EXT					3
+#define   PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET			0x0c
+#define    PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR		0x00000001
+
+/* CXL 3.2 8.1.6: GPF DVSEC for CXL Port */
+#define PCI_DVSEC_CXL_PORT_GPF					4
+#define  PCI_DVSEC_CXL_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
+#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_BASE_MASK		__GENMASK(3, 0)
+#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_SCALE_MASK		__GENMASK(11, 8)
+#define  PCI_DVSEC_CXL_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
+#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_BASE_MASK		__GENMASK(3, 0)
+#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_SCALE_MASK		__GENMASK(11, 8)
+
+/* CXL 3.2 8.1.7: GPF DVSEC for CXL Device */
+#define PCI_DVSEC_CXL_DEVICE_GPF				5
+
+/* CXL 3.2 8.1.8: PCIe DVSEC for Flex Bus Port */
+#define PCI_DVSEC_CXL_FLEXBUS_PORT				7
+#define  PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET			0xE
+#define   PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK		_BITUL(0)
+#define   PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK			_BITUL(2)
+
+/* CXL 3.2 8.1.9: Register Locator DVSEC */
+#define PCI_DVSEC_CXL_REG_LOCATOR				8
+#define  PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1_OFFSET		0xC
+#define   PCI_DVSEC_CXL_REG_LOCATOR_BIR_MASK			__GENMASK(2, 0)
+#define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID_MASK		__GENMASK(15, 8)
+#define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW_MASK		__GENMASK(31, 16)
 
 #endif /* LINUX_PCI_REGS_H */
-- 
2.34.1


