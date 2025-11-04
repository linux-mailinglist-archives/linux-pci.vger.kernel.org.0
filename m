Return-Path: <linux-pci+bounces-40233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78827C323B8
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8FB461A34
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77414339B38;
	Tue,  4 Nov 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kbv8rPX9"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5931A3314D9;
	Tue,  4 Nov 2025 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275811; cv=fail; b=nQurn57WPGhLBKDTFoTbMZuhVmWE22Yyfk74Z2H1Rh4DMDl3/ngf1FjQSXuAMPIzgsd0Hm9d0aDiMZ9KFnPAMC4VJpp4mNmLmul/NTaCQHrGL27+QS1+j1qZbyqvPrcVGzuei3QBX2gdUjsgYg4L4XL3+jHmqv5KVw2jCjkhKBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275811; c=relaxed/simple;
	bh=g3FaBmivLXEsdLHsGR3q/HycFRlWE+4Z0UwJedVcyvM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKwJxtupcQY6UK/vbDa08+v5zMSh8kEroNrIBcXJY+t0PHCJuFNz5HC1ZhBoPXeQp1+NLAU87karzc8b+Lxoo7n44I2OtBsiTCQd0oDesPi2S1LAt73EtS3Ha99cM7I5gSiZUD/qP+n8oNmnww4PHLlXuoC1qveg7W2bivREYgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kbv8rPX9; arc=fail smtp.client-ip=52.101.85.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcET8nX4l46ElEnphxJBU23FnM0lFFG+GCc7WqkBTc3jxY6mLwunxlaEcqgFWGRt7LQBJ9UMCKvZAE7VOtU30TSI6iOgP93GXICB4is5HS/xib9J0iEjSDYwEZx/6ayw7zZc2QYLHY/qprAzvA4NR2qU69j47+R0cWqLrKwUx9bwhX3I5DO9up4zLgahSG4AU8Yw8wW4i9p7nUtZMxAM+hZG6zQtaCbhS+rTe23qbZJfLlMSZPe/cZhyz80lBQ/X+PWnG51F2GqzFyz93P34XyJ5dOil0aAOaq9D4UPGta3Xk8ZpPUm3QkCOORk/Im1ByLJocKUSs6ZG65JQtlT1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWS2fX0x/S66+C4ZmEBor5+04oBd/k/c00Zl/ouOkC0=;
 b=IIdVkgIFqwe4BEYHKVsPhgt5/gwFhYVI3/Q7PbV/QfzoGm8Z5TQV0B+gl2N8hl5Lw97yr34zx58lD8hKcTsUmBjz13/7fw2TVBmPAwSInSaZasXJ+6XI1G6rsSQ7nr0zle4heR+yppRguBRMdWxJS19kt+f4hR+nFx/VkcX/3axKGs/jP2jtELQwdEUA2IvOb28vkVKehvOKaqDrRqfHhj5Rp0ri79/7pM5my+WQWgp2QjjZQ+eHQOv25ooBIp4irSZ16X5N/DAWLoGfrd9usxPNuAuOjb9DTdDMm0URQKZzqgq3b78iNB7L9a7uHp5+yT7H41thp4IUAtC8Jc9Iag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWS2fX0x/S66+C4ZmEBor5+04oBd/k/c00Zl/ouOkC0=;
 b=Kbv8rPX9A8zmiY9zErwrYqLXsz174zVyJUBLsObgYm7MZCkB1CmbeZBpMqDvVpeRfNp++J5XviwoGBO4OBkRhSuI44vxj4gZKeEf6iFqJ8pf1/Lg+BKSyPvH5urMfbKGzzEjk8zIjP4238MI0S6DxcQDBDkUdyyDX5g3WKwesGQ=
Received: from BN9P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::26)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Tue, 4 Nov
 2025 17:03:24 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:10a:cafe::a0) by BN9P221CA0007.outlook.office365.com
 (2603:10b6:408:10a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 17:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:03:23 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:03:22 -0800
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
Subject: [RESEND v13 01/25] CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
Date: Tue, 4 Nov 2025 11:02:41 -0600
Message-ID: <20251104170305.4163840-2-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a25f57c-c500-4410-ec65-08de1bc4101f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fIV4+QKyXXImak4HViCY0juyzlVNJIBphxMfP3/ketS+0bRJaEMY+tMHP5tD?=
 =?us-ascii?Q?VH0BR9PH9zVZNLisbo5XXICWGaVrA/rzPSvYJKT6fTe9/gYxcREMeGh7EJDr?=
 =?us-ascii?Q?k0z3L8qswXHw3kA6BouhTu9KJoHZhNzYWRXr4s8iyKdTlF7WDzHKKDr/xoge?=
 =?us-ascii?Q?07U686zKAx9bf4XOTwDLfFekI0RNrCoKF4uryVNnrhk9hSaAbBiRKmi+TuXh?=
 =?us-ascii?Q?2hAAv6KKFBvdgj5gGScrdgvjfNQLMnNTS5OXUPGvOwmm3kHD3djqw2vkhup7?=
 =?us-ascii?Q?TUpyBmn+S7X3qZ9+ThHFni4awceQgL3Gi17cHJ+UH0ZQqhX+eO07DPx9tAAF?=
 =?us-ascii?Q?6EhaNZrO0WtzKoxyOtnqgd8qXMfZexWlZtfz70FD79RXBMBuayZOF5msi2RA?=
 =?us-ascii?Q?b+norGnHfXR9WJJRUpGMDn2g92/+xTB0It3lc4leDMXoDxtTN7qiAje/qwKf?=
 =?us-ascii?Q?lzOXPe31OBiqla/2PxSC3OX9vHVYkTeIdHTWkWZmYu8OQVDVzrB8bExrn+DZ?=
 =?us-ascii?Q?Ft/Wd+fhAk2IFBwA/1VOGfdQA4Vb/Y6xeNLCc7i1PfgdXM4iyII7MU4AZzKo?=
 =?us-ascii?Q?49DD9w1eNAEWBcgoLm10E0/V88SbWDqnRvX4T0gfLCGZU65GRtmW4jBhbo7U?=
 =?us-ascii?Q?4hD9QMTduvqehBWJr9aVhmHv/BTxiwM8ImNBbWgRwKSrkA782iWHcn6Fe0HW?=
 =?us-ascii?Q?96sm43bL/5AuvMNoxryhxTHPV2pw0RscBNI52JJ6KtNrw9NnJrw8a+A5kIC+?=
 =?us-ascii?Q?dvfWFMdVMB5kb9DK97SDn9GBbQUhYcmcXTlMZHwnw+MbnwL/Kb8SNwSuZnwX?=
 =?us-ascii?Q?E4GMw8q99RcFnhNZI7UXnN6txqf0a2kxJLajW9fGxOPd/V2NuHxl+QXUt3r4?=
 =?us-ascii?Q?nN/MEauh7Dd2ytW3GIuEjbatrrSWpsQrrn/XsXBrTtmtCY8OoynFxgOBObSr?=
 =?us-ascii?Q?hOpwGsZ6E+s2crW055UMbGwBy6jsuM0I3flfAj8IP5oZkzoAiBKjfci1DT7z?=
 =?us-ascii?Q?peVoddzJ8WmBxzEao8BrL0GVdPHjSFd0K9VBBDOUdzxGRPB/rCvqnIEWuxk6?=
 =?us-ascii?Q?kcUzR1pqziqqz+7tdfPRn+wV8DoRGU2T0rGFNqLeH7g5hBdNbVhukXfbHCnW?=
 =?us-ascii?Q?Hn9IS0Oocdc7lDJPK5/4xyAkohi0fxQUPFaaZnx1pdhIVYWK8GoLRkKWSkQW?=
 =?us-ascii?Q?/8ZyKTJvxyYlH9+HDYffXGZ2eDdBmyDKTMC/Rv3CFeENGvVJAOk5RH44CyI8?=
 =?us-ascii?Q?77px1YPxjVKn9GWEWinBPYyOaAuJbhdPkEdZzUOPKfJI40qFsSV27SLXKRkK?=
 =?us-ascii?Q?+7YoXNXU1Zs+it1Tc9N3W8HpVSPs/ePKHvY3R4/4gnzDhVtC4Mk7f/PxPZDw?=
 =?us-ascii?Q?Cq46NJq1D0xgK5sFQt6/+viV0Zn6mVzMQx6fY0vwFZvW/wYe7uBzAB8pHSAw?=
 =?us-ascii?Q?YNPVkllpiBiaO5Y2Rmbr5WYplfzmNUDHOYk/lXDTb86i+4iobN1keNZOYG9A?=
 =?us-ascii?Q?5p4SM70sjtbBV3pFVaWAaXeFeQGmmN6ez7Khd2zs+JIEN57LI/D4cug/16D7?=
 =?us-ascii?Q?E48LRQsf/Rl0b7NoNNKqb7pTbAHY4bjiFY5TRTdM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:03:23.0746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a25f57c-c500-4410-ec65-08de1bc4101f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712

The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
accessible to other subsystems. Move these to uapi/linux/pci_regs.h.

Change DVSEC name formatting to follow the existing PCI format in
pci_regs.h. The current format uses CXL_DVSEC_XYZ and the CXL defines must
be changed to be PCI_DVSEC_CXL_XYZ to match existing pci_regs.h. Leave
PCI_DVSEC_CXL_PORT* defines as-is because they are already defined and may
be in use by userspace application(s).

Update existing usage to match the name change.

Update the inline documentation to refer to latest CXL spec version.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

----

Changes in v12->v13:
- Add Dave Jiang's reviewed-by
- Remove changes to existing PCI_DVSEC_CXL_PORT* defines. Update commit
  message. (Jonathan)

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
 drivers/pci/pci.c             |  4 ++-
 include/uapi/linux/pci_regs.h | 63 ++++++++++++++++++++++++++++++++---
 6 files changed, 100 insertions(+), 96 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 18825e1505d6..cbc8defa6848 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -158,19 +158,19 @@ static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
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
@@ -194,17 +194,17 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
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
@@ -233,11 +233,11 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
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
@@ -265,16 +265,16 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
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
 
@@ -290,7 +290,7 @@ static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
 {
 	int rc;
 
-	rc = cxl_set_mem_enable(cxlds, CXL_DVSEC_MEM_ENABLE);
+	rc = cxl_set_mem_enable(cxlds, PCI_DVSEC_CXL_MEM_ENABLE);
 	if (rc < 0)
 		return rc;
 	if (rc > 0)
@@ -352,11 +352,11 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
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
@@ -367,7 +367,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 	 * driver is for a spec defined class code which must be CXL.mem
 	 * capable, there is no point in continuing to enable CXL.mem.
 	 */
-	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
+	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT_MASK, cap);
 	if (!hdm_count || hdm_count > 2)
 		return -EINVAL;
 
@@ -376,11 +376,11 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
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
 
@@ -393,35 +393,35 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
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
@@ -1147,7 +1147,7 @@ u16 cxl_gpf_get_dvsec(struct device *dev)
 		is_port = false;
 
 	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
-			is_port ? CXL_DVSEC_PORT_GPF : CXL_DVSEC_DEVICE_GPF);
+			is_port ? PCI_DVSEC_CXL_PORT_GPF : PCI_DVSEC_CXL_DEVICE_GPF);
 	if (!dvsec)
 		dev_warn(dev, "%s GPF DVSEC not present\n",
 			 is_port ? "Port" : "Device");
@@ -1163,14 +1163,14 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
 
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
index 7ae621e618e7..4985dbd90069 100644
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
index b14dd064006c..53a49bb32514 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5002,7 +5002,9 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 	if (!dvsec)
 		return false;
 
-	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+	rc = pci_read_config_word(dev,
+				  dvsec + PCI_DVSEC_CXL_PORT_CTL,
+				  &reg);
 	if (rc || PCI_POSSIBLE_ERROR(reg))
 		return false;
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 07e06aafec50..279b92f01d08 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1244,9 +1244,64 @@
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
+#define PCI_DVSEC_CXL_PORT					3
+#define   PCI_DVSEC_CXL_PORT_CTL				0x0c
+#define    PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
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


