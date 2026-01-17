Return-Path: <linux-pci+bounces-45086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D561D38C69
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 05:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60FB530321F6
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 04:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13558326D6B;
	Sat, 17 Jan 2026 04:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lwwkHhk1"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010044.outbound.protection.outlook.com [52.101.193.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008D327BFB;
	Sat, 17 Jan 2026 04:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768625828; cv=fail; b=X1GV2T0PsZKO6IVM4mrtEgcw4N2Qu0nOg6pFwSYb0hy+jtWTpJgj7z2Ydwg17tXxbfquzXIe+hwS4y1V5Texl5Hl2ZjP5ucN3vr6XZm4Y24iYNlEEbNebp6Jg7mD7ld2o2lAqGEui1XeXKYPQU+n2K55BWGgYiYDJdTTB7QehT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768625828; c=relaxed/simple;
	bh=L6s7n4Jj96TLp3sOIkLqpPAYU7wO1DeiSGijVI4QRRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8AcpD/bO5SBeR75PkkeXROvQE2OQ9yfjALkagqPwgqaIRnxVxbfVnmT/hWw0R+bdcRmBrkDJppE2TrD50RquTmjJD6E1qBYSuKacKZHmQuxWvcxfSJWqRI5AExKS9ToOQzRSfMBlzfbJnJK8Puu1/pqcdpEvv44Iyx/6vc+ch8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lwwkHhk1; arc=fail smtp.client-ip=52.101.193.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zP463cOuE77Jv8et8SZNOOXZe6e7kHLWxJcWy2TPUTtzwForazwdFqpEHsr3xohxEHc3xigIP69xm39dOam6cE20R5fcioiDdDcnbaCN3KQ3jr2lF5q8RDLIGGhd1YsK82AFM8uW4ETVmEDuxPVW7WxHPEbRMmePEX5qRuqai8sPdDcNHibOxGUhbaZpYDIFApoYCOfCCMbrXBid0Rehf0h86DHxQiQFwr+qrSQEYO2TLH57LKMHdL82OOTqwND44LDkSxaGSs+y1qeojuAFttrZbHXkkMCaBbjDTh9WWR6LPHDkSetaOhSuSZWWlyEt7WDqNlMdToD+2oaElfkX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ts3PitZ+B6lm33HYovCvYuzGDqhAItkZ5yJ1nVNyBL4=;
 b=wtPDnCbUs3gfOdjo2OCqi55pMr7B/XO1m+Ceb7ptvg76jxOgF48vL7/zRryI5AtVwakxiOmS/17ht55awXBe8YSjFduGjXeOXwVs0HVkVrSE4eTACriNmK+73mjcmBl5538bxKw7C70ge7eAbHB/XtRlWDMgPbme7uNPxOB5drxOPJFSlaqzJPEXgnA+NxoTJtF0cueaHvL7vwuPIUiu4KCOJpdm7MgCGaa0e3t4ierkWSAaGkpmrIF91XDWcEy7We/5W+DC/2jbjnFtUulM+2QbySk8q+GGpEZC8XXyXa5aQNxCT71XrA3esi59fkSQWhHUT7RARL7ufR2GR2+cYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts3PitZ+B6lm33HYovCvYuzGDqhAItkZ5yJ1nVNyBL4=;
 b=lwwkHhk1x2NzqzWM3AgXSsuYbQ+6dTNcpsElXKfTfvB266Gp86TIkRSAafLctERVDrRXOiwloe0Go0TXvdCtuqBPC7L30YA2B9Kn2DwFkbl39IJFpI1cLZP4u9JwNWwFP+m8v3dXO0upe/e8C1ARVqEuB743iRErRb6n5yfBB/yStHUruKyWyDIa9g8igiZKjDnTeyorVTlUxezJvSkIVpFajnla1YIdgPvSb7FmkWiWvhcp7einH9YJE8Okw21hK+PGuPnXb9vNe++QVDM789+15vFxNOfLl6fUvEKRe7OK4WSpUvOtRmWCwyasa0iYyNLUEfTI6Lvr9FRDxCl8Rw==
Received: from BN0PR04CA0164.namprd04.prod.outlook.com (2603:10b6:408:eb::19)
 by LV9PR12MB9831.namprd12.prod.outlook.com (2603:10b6:408:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Sat, 17 Jan
 2026 04:56:57 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:eb:cafe::2c) by BN0PR04CA0164.outlook.office365.com
 (2603:10b6:408:eb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sat,
 17 Jan 2026 04:56:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Sat, 17 Jan 2026 04:56:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 20:56:52 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 16 Jan 2026 20:56:52 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 20:56:51 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH RFCv1 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Date: Fri, 16 Jan 2026 20:56:42 -0800
Message-ID: <09cb6be1f8f7472a2f1ccab72154cc6e22cf570b.1768624181.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768624180.git.nicolinc@nvidia.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|LV9PR12MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db30133-0751-4fae-40bb-08de5584d7c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4YDCEvjAWmNijuxDTrEIii8M7PcFBI+rvGo095ekpL5GmJcX/9difJp3VkTg?=
 =?us-ascii?Q?IJZeT0vs71ONuyFxIA1DyOo7xTYVghvuQoA06Auub7a6IC3n4pVeBfwGwTgd?=
 =?us-ascii?Q?CjuVoAs6UJvbQZCRdbOU88MaRxYLwQO46eLC+2q59Q7w3pb8JKRdaiuYzIVh?=
 =?us-ascii?Q?Ci5182H5k4WVtLsiGDX9fbKS94rz1v5j4qc3+E8FD6oWRFcRsXYAlqSe9ws0?=
 =?us-ascii?Q?PnePnBVcemKbXyqudVUCTcEPCvnx+owOlsx9d9sJX2jDQHHiB1W4fDtMmLBm?=
 =?us-ascii?Q?GA5MAgLJByoEyf831BVG9jtCi78L/XZ0hHQNRj8q+KLKADbQkSpWfdESIbXu?=
 =?us-ascii?Q?HrNc5cJMU5JwTNCJMVdV4b+t6eEsYEEiEZPc7xb8ASye6rod02nGtg8Zl+6N?=
 =?us-ascii?Q?5yjO/Ztb5bxvHA5GUq5dS2oNrAnqhZCmzLHcI8HKkXh1WF5eOAnNolQxcxgY?=
 =?us-ascii?Q?r9UGR8NDaE22M4MChRUOjb0sLdfFF2ZjojF4FoNN4nXqZ8dMyQWFDiWEEL20?=
 =?us-ascii?Q?9BF0DsB9xiAhiJ22zplS9tbd1YP72q7KrfIONVHKk+60qP4yGLYEmAPEs3TT?=
 =?us-ascii?Q?OysyJng91UM/UmuApjZtsjPCSEdd2qVnUMAo6X3Z3GrXyHAU+LF7WLevrPDr?=
 =?us-ascii?Q?BjNCEQyZOJiMWL2Jx83mWtDYXuSPimT7FBdX6Whalaw08/Z1DMfI2YP+EoNi?=
 =?us-ascii?Q?TUi4ytb3YTIL+ZiID26iHGX28ldQIcQKz8Nwr8iNH8gEfI8YU24CeEcBDyvP?=
 =?us-ascii?Q?0OWWd6G2uZUUjizvZAogJSZOssyRZxNdBXVGOjYKezguCPYmLUfafDpC6lMD?=
 =?us-ascii?Q?S//W83DkuGaVCf6a+DPAd/xikL6rYcyoUtuWubBK4KDLM7DkqUk3Zh9Uy2/b?=
 =?us-ascii?Q?pXzkCtli2jDDSKWy+1fygcmhsg6tE3sICAUXDzHa8tVYQy5lU3CiJ6YrzfxJ?=
 =?us-ascii?Q?yh0ysFRu+oRewU0bGPgmcTATpXyQQiVNZrefgQ7XU0CEmI3sLukhB8pB5JTl?=
 =?us-ascii?Q?ygOzkoApshgn6GvVqKH9Rk3JnwsS3/gPCi9GT2pOgsGJCLVkmt6+7O0V37K6?=
 =?us-ascii?Q?nNIXmgi9MbL6GIsYOSVgYoi/RP3Pxnq1VwtpAUZBhozIcBjzGTMdgnbsym11?=
 =?us-ascii?Q?j6f6zHvB/4uoOVMfXFmuv0ct8jzheG+tpP1/jfZsQFmpin5m9RygBuVvtVR3?=
 =?us-ascii?Q?H37DDNtupvNA8EH+lSLojQY+C1QpZAPtAA4dwKDChyL5qUqmRvaKgGWKh6JR?=
 =?us-ascii?Q?U7PTbAenFCbt1ImRU3jIKeBtD4YEKD5ZHFLxJ5Vj90AIzarnpzK1376Jl9XA?=
 =?us-ascii?Q?dXyd0oUj8fEa0M6C7GBJ7HnYET6rQFmGEU0p9fpO6kwlE9Jq0Nv8W+nqELst?=
 =?us-ascii?Q?R/bOErl21G4fXMTaIXNqAGaY5koC8VUNeyP+vCkx+qB/WrOqwbtJ0PPjYndr?=
 =?us-ascii?Q?DqFbtzPAfuPH1bD93e065CYrVIDWTJ9XMj8qvZmBS2o/i/ZK3MSiElCFinrt?=
 =?us-ascii?Q?FiOT3ZqQPg9lxZo9LtQZhlGB3UxUxlBO1S0w8MYHJdoDy0cBvlEKjBQvb5vt?=
 =?us-ascii?Q?TxPFSR60XJLZgZVtI5O8Po6wXsli8mHPapzSShksf0+50DT4Hcd+9WWTqJHj?=
 =?us-ascii?Q?fUZsr6gGFvIef55KxJDYrcWuIeepEj5HaFYdao+0U3g28KZUmInZ+tdmJCMJ?=
 =?us-ascii?Q?FIhLGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 04:56:57.5793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db30133-0751-4fae-40bb-08de5584d7c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9831

When a device's default substream attaches to an identity domain, the SMMU
driver currently sets the device's STE between two modes:

  Mode 1: Cfg=Translate, S1DSS=Bypass, EATS=1
  Mode 2: Cfg=bypass (EATS is ignored by HW)

When there is an active PASID (non-default substream), mode 1 is used. And
when there is no PASID support or no active PASID, mode 2 is used.

The driver will also downgrade an STE from mode 1 to mode 2, when the last
active substream becomes inactive.

However, there are PCIe devices that demand ATS to be always on. For these
devices, their STEs have to use the mode 1 as HW ignores EATS with mode 2.

Change the driver accordingly:
  - always use the mode 1
  - never downgrade to mode 2
  - allocate and retain a CD table (see note below)

Note that these devices might not support PASID, i.e. doing non-PASID ATS.
In such a case, the ssid_bits is set to 0. However, s1cdmax must be set to
a !0 value in order to keep the S1DSS field effective. Thus, when a master
requires ats_always_on, set its s1cdmax to minimal 1, meaning the CD table
will have a dummy entry (SSID=1) that will be never used.

Now, for these device, arm_smmu_cdtab_allocated() will always return true,
v.s. false prior to this change. When its default substream is attached to
an IDENTITY domain, its first CD is NULL in the table, which is a totally
valid case. Thus, drop the WARN_ON().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 74 ++++++++++++++++++---
 2 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ae23aacc3840..2ed68f43347e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -850,6 +850,7 @@ struct arm_smmu_master {
 	bool				ats_enabled : 1;
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
+	bool				ats_always_on;
 	unsigned int			ssid_bits;
 	unsigned int			iopf_refcount;
 };
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d16d35c78c06..5b7deb708636 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1422,7 +1422,7 @@ void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid)
 	if (!arm_smmu_cdtab_allocated(&master->cd_table))
 		return;
 	cdptr = arm_smmu_get_cd_ptr(master, ssid);
-	if (WARN_ON(!cdptr))
+	if (!cdptr)
 		return;
 	arm_smmu_write_cd_entry(master, ssid, cdptr, &target);
 }
@@ -1436,6 +1436,22 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
 	cd_table->s1cdmax = master->ssid_bits;
+
+	/*
+	 * When a device doesn't support PASID (non default SSID), ssid_bits is
+	 * set to 0. This also sets S1CDMAX to 0, which disables the substreams
+	 * and ignores the S1DSS field.
+	 *
+	 * On the other hand, if a device demands ATS to be always on even when
+	 * its default substream is IOMMU bypassed, it has to use EATS that is
+	 * only effective with an STE (CFG=S1translate, S1DSS=Bypass). For such
+	 * use cases, S1CDMAX has to be !0, in order to make use of S1DSS/EATS.
+	 *
+	 * Set S1CDMAX no lower than 1. This would add a dummy substream in the
+	 * CD table but it should never be used by an actual CD.
+	 */
+	if (master->ats_always_on)
+		cd_table->s1cdmax = max_t(u8, cd_table->s1cdmax, 1);
 	max_contexts = 1 << cd_table->s1cdmax;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
@@ -3189,7 +3205,8 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
 	 * When the last user of the CD table goes away downgrade the STE back
 	 * to a non-cd_table one, by re-attaching its sid_domain.
 	 */
-	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
+	if (!master->ats_always_on &&
+	    !arm_smmu_ssids_in_use(&master->cd_table)) {
 		struct iommu_domain *sid_domain =
 			iommu_get_domain_for_dev(master->dev);
 
@@ -3205,7 +3222,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 				    struct iommu_domain *old_domain,
 				    struct device *dev,
 				    struct arm_smmu_ste *ste,
-				    unsigned int s1dss)
+				    unsigned int s1dss, bool ats_always_on)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_attach_state state = {
@@ -3224,7 +3241,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	 * If the CD table is not in use we can use the provided STE, otherwise
 	 * we use a cdtable STE with the provided S1DSS.
 	 */
-	if (arm_smmu_ssids_in_use(&master->cd_table)) {
+	if (ats_always_on || arm_smmu_ssids_in_use(&master->cd_table)) {
 		/*
 		 * If a CD table has to be present then we need to run with ATS
 		 * on because we have to assume a PASID is using ATS. For
@@ -3260,7 +3277,8 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_bypass_ste(master->smmu, &ste);
 	arm_smmu_attach_dev_ste(domain, old_domain, dev, &ste,
-				STRTAB_STE_1_S1DSS_BYPASS);
+				STRTAB_STE_1_S1DSS_BYPASS,
+				master->ats_always_on);
 	return 0;
 }
 
@@ -3283,7 +3301,7 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
 	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_abort_ste(&ste);
 	arm_smmu_attach_dev_ste(domain, old_domain, dev, &ste,
-				STRTAB_STE_1_S1DSS_TERMINATE);
+				STRTAB_STE_1_S1DSS_TERMINATE, false);
 	return 0;
 }
 
@@ -3521,6 +3539,40 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	kfree(master->streams);
 }
 
+static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
+{
+	bool s1p = master->smmu->features & ARM_SMMU_FEAT_TRANS_S1;
+	unsigned int stu = __ffs(master->smmu->pgsize_bitmap);
+	struct pci_dev *pdev = to_pci_dev(master->dev);
+	int ret;
+
+	if (!arm_smmu_ats_supported(master))
+		return 0;
+
+	if (!pci_ats_always_on(pdev))
+		goto out_prepare;
+
+	/*
+	 * S1DSS is required for ATS to be always on for identity domain cases.
+	 * However, the S1DSS field is ignored if !IDR0_S1P or !IDR1_SSIDSIZE.
+	 */
+	if (!s1p || !master->smmu->ssid_bits) {
+		dev_info_once(master->dev,
+			      "SMMU doesn't support ATS to be always on\n");
+		goto out_prepare;
+	}
+
+	master->ats_always_on = true;
+
+	ret = arm_smmu_alloc_cd_tables(master);
+	if (ret)
+		return ret;
+
+out_prepare:
+	pci_prepare_ats(pdev, stu);
+	return 0;
+}
+
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 {
 	int ret;
@@ -3569,14 +3621,14 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;
 
-	if (dev_is_pci(dev)) {
-		unsigned int stu = __ffs(smmu->pgsize_bitmap);
-
-		pci_prepare_ats(to_pci_dev(dev), stu);
-	}
+	ret = arm_smmu_master_prepare_ats(master);
+	if (ret)
+		goto err_disable_pasid;
 
 	return &smmu->iommu;
 
+err_disable_pasid:
+	arm_smmu_disable_pasid(master);
 err_free_master:
 	kfree(master);
 	return ERR_PTR(ret);
-- 
2.43.0


