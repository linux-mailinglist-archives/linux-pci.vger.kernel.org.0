Return-Path: <linux-pci+bounces-29257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE60AD25F4
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 20:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9190D1886121
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 18:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B4321D594;
	Mon,  9 Jun 2025 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CpRelVoT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F221CA03;
	Mon,  9 Jun 2025 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494745; cv=fail; b=LSXRhaGkSPkDvuDDZqkKUQaxklVMCKWK279pk3gxkQ7yhXEyK8OP0Iroz6fbGnRAst/cCgkUHTEfMKy8RKUeQxQrbB5VPm37klT71BucxAofU6AWc+a2RNVOAmGchB2DQ5SRdDG/w7prdV84qReQILp/UNnfQEsipep3AwcELZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494745; c=relaxed/simple;
	bh=6U5QNa0Xrcib71Izlg6sKM63hgi/WE9yyeM9DfuaF/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+vEC+HkgZujtq2IOrJPrEr00wZ9G+FjtVSS7+5H5YsalAWa/Q+mWgTSlSb4oELpMt/If+XQqcWZ3dIA+7zg41nNG+Q+1G1UHMIqi8nDu3VGcqWPZMv76wlPp5WkpgPsN93p3w+Lp5Ejrx/BDyq978/Vq8emIEqzgFH4Fo4W6J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CpRelVoT; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLjvZ/RnDDNafnYqys3tLOYxjY6nhA5xdMElFvEg5agmm4U2MjIoyMq0f2I4JvRX0h7niLOXg5ybYKl5Wu4LN4H4pNBIjM6vKojYC3gjDmQYYf12cr4XNVwEixnA1rylD+ZGGN18eWqh1ADMV9th3/iAR1/6b9kU1p1mYWyXO41OojiboW4CCUm2QZGRfdEViSh+jJBX3YCT11oN1b4TyO8oGnySPYuisCz8Wg3I46RjaL5X6R5AIAOSM5I9GLGnLfydVn9oyn4IORGtpgbFY3gtchwdY1PcJfPwCoPgWICm/YbE/aAI5/+sEuUM5hmVV3TpgH7K1dV5Aaa7cTL/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9t0BH9eU6WdnU8eixRvduEm9VpWFHxof6qktJDjSsm4=;
 b=WjBe0uOzvh75RR4JiLanxjj7OhdCoyZZnSfrPgG7bmAHTU5iBNJWo9OiTF+mBG8JRAzN68+tyOQSS7lut00WZK1qrHaXcpYoKNtQKequdsN4WvBH7bsIyk9a+Nuo5vAX1kyNbawC+zBrABjP4WCgfpNFjTZlMbPGpcnv2biuB9bsiAs/s2yVGaXoU/TRNPGdgQhU5ixio9hLz4526xu1UbyWOo12s3NfkIls0q9uw+ZuS/yDeMLnV/RT2g9txTrjC12GzYhn7Yv/CI3H0DKBbklu8U5Av1jC6NqyGatEDW+t21dlYWxi8s4tXVSkiyQIdVsepJhsEIZrJ+jnzAViUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t0BH9eU6WdnU8eixRvduEm9VpWFHxof6qktJDjSsm4=;
 b=CpRelVoTmOrcYLyUIM0kLrAoSTGDlTwCzxg09Zr9zonqXzIEOIwXxEbg0gn6TNB1PbSPyGSim6fRY0bxnPDz5nhhQ9ftJNQ1Wkd5mOULTU6OKNIfaUj+7dOLMfY9PnkLqQGMlK7FYBgj+l6vqAYt09W3/lZjYWqfkJjGXWOBTCtrvP2lGAMVXGWWvRc2mz5GDyfxLfZ8auRqVynjSk6R0tn0SGCNiJaDQUBBF3LdD1knf5XKBOJC/YTa2C0Ns9MiGQdZyl2RH5Ii/DIvSdpLnPglB6HxE9SrY3ax4uZDCJQ/wakoi7FFTpm+lxF4QY1WpSQvbxev62xc5dMWZSsUcw==
Received: from BN9PR03CA0864.namprd03.prod.outlook.com (2603:10b6:408:13d::29)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Mon, 9 Jun
 2025 18:45:38 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::71) by BN9PR03CA0864.outlook.office365.com
 (2603:10b6:408:13d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 18:45:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 18:45:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 11:45:22 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 9 Jun 2025 11:45:22 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 9 Jun 2025 11:45:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
	<pjaroszynski@nvidia.com>, <vsethi@nvidia.com>
Subject: [PATCH RFC v1 2/2] pci: Suspend ATS before doing FLR
Date: Mon, 9 Jun 2025 11:45:14 -0700
Message-ID: <29cc1268dfdae2a836dbdeaa4eea3bedae564497.1749494161.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749494161.git.nicolinc@nvidia.com>
References: <cover.1749494161.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: edb7308f-ded0-47ea-8aff-08dda785d3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BMcuLIU23VKoB29OUdYuwZiFzjVwikhbI8aNZHfyM9y6Lf6SDO2JrHaRauKX?=
 =?us-ascii?Q?o5dZKm162G64dzvlaqKFSoAHVqxIjgD7t+pDPbXufm99ZMRiRXUme+MF1FZy?=
 =?us-ascii?Q?EPUAT12UhCitz9zAXq+P2LEA+ysuzXdbCBjQUgC66kLfaYMO9B3bb9QekvI9?=
 =?us-ascii?Q?EAVI5/sxUlrBwaIcMMO4DG+5shxmsQU9pbVD/TGP+hGe7VMz+U+GWprVPsDM?=
 =?us-ascii?Q?NaX5VhfgeSnkJeFq6ZxIuCjq76VLnqQbAXYIiSnqGiz2TuSk2fHCWRgJ2XLY?=
 =?us-ascii?Q?+a5n3QTwbMCiR/sgFjVyekSNBUfZoK3B9alvIigDFwb9j/RLpDxTEnTm7MDb?=
 =?us-ascii?Q?GQLH6mp1CKXCXoiKHqQbio6wvBEru2Z/ARQ8wNVWmph3IilwUvfoiREjKorw?=
 =?us-ascii?Q?OOdqtQCdtQIwgRdWNsVWLyVBr9AIkFxBodiNo5WzYCvJY7QFuyXhC4jvY4E7?=
 =?us-ascii?Q?UVFB979RSanlWCtoFACFr4LsawhKkwm/DllfcGyST6rqt5dD6rkdb+F7s9YX?=
 =?us-ascii?Q?hLLZi3e2uqGjtQtooCozFDq6TPWKjWUPF602O7WQpELRMGLidvz2GWu8g+OX?=
 =?us-ascii?Q?rEHmZOrZWSQlTgxzrzPaH45eNmJfOF1KFe+PyU93tOO3r+NEnui9LMDXB+10?=
 =?us-ascii?Q?RlKsejZjC2NKzyomOFHgIkrvmOu9ysgdN7VlaQmelU3R/Gl3n9gL+f+ZJsiS?=
 =?us-ascii?Q?L2EijvlYXl6YpyJIZVJIgSBpCm0ouf7GeplRnu5hpEz+/VOXso/T3k/5B963?=
 =?us-ascii?Q?20l/2tR0KRmpScUr/mPseq2qy7qc/YvKm0S0HjCwkXtQzfNvGgOhuAwdv7uX?=
 =?us-ascii?Q?WzWP8iEyeIyLdmbGRiy6dPHiKEdRGbLX5idDR2T5JLF9uUUWCDepwLW1t7sc?=
 =?us-ascii?Q?3lvvzoO+uRzDyR+d2xQOKTqYL74hIjqSJzK+SYm2nz3/ljvX/LtwiFE0UAIM?=
 =?us-ascii?Q?utf6rpv0/HEkdDWRqc0L/VqtaGXcThC35F5CV/RZOO9T4Rc8wSq7X3QwT02n?=
 =?us-ascii?Q?nR8IJtmI13DdLUSLH1dCJw1LnME2kOGfY/xWsFRAEG/H4YfJQx9RAkjDdlsZ?=
 =?us-ascii?Q?F0e/zYIyFPFoWPnyTMluJpXTd46v8Si2GlsTxcO3Ab+w8ljD+MuPlD/fAPE5?=
 =?us-ascii?Q?yBmX1dN/WLB/hTHroRs4af8t12Z0J9F4bIcwr+A3IAeQUKFLUTa+XI4ywTJw?=
 =?us-ascii?Q?IGsuEuxYovqtfCXzN4SwKmx3LKSMoScNThn6uCKXiOzhNUvq54vsjyF8o3CP?=
 =?us-ascii?Q?oTCJSkHv/Qz5P/hsr+NeXtB7b20Ds4fHQEkK34wpLGi0a5f+UL9We57cpCfz?=
 =?us-ascii?Q?ob74ML/JHEIP9iSd0wTuTGGunQqaDGVk11PeT7jWojzeFb88a3k9Qroz2qxx?=
 =?us-ascii?Q?C+DyzulASp3x9ErlUJ74o+fJrpdQdc8M4LJC/NhTzqTWDEUnh6dZ3UdCt1wF?=
 =?us-ascii?Q?69Q/z87BZOe0hHrQlv8zTTd4evDo4bqqgC+zTJ48eLX5LW4b99HfyoOL/3d7?=
 =?us-ascii?Q?zj7lUJTUlOneat6Qk/VePHnULa/4aaSjftvR?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 18:45:38.2374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb7308f-ded0-47ea-8aff-08dda785d3e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385

Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software should disable ATS
before initiating a Function Level Reset.

Call iommu_dev_reset_prepare() before FLR and iommu_dev_reset_done() after,
in the two FLR Functions. This will dock the device at IOMMU_DOMAIN_BLOCKED
during the FLR function, which should allow the IOMMU driver to pause DMA
traffic and invode pci_disable_ats() and pci_enable_ats() respectively.

Add a warning if ATS isn't disabled, in which case IOMMU driver should fix
itself to disable ATS following the design in iommu_dev_reset_prepare().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/pci.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9448d55113b..61535435bde1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
+#include <linux/iommu.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/pci.h>
@@ -4518,13 +4519,26 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
  */
 int pcie_flr(struct pci_dev *dev)
 {
+	int ret = 0;
+
 	if (!pci_wait_for_pending_transaction(dev))
 		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
 
+	/*
+	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
+	 * before initiating a Function Level Reset. So notify the iommu driver
+	 * that actually enabled ATS. Have to call it after waiting for pending
+	 * DMA transaction.
+	 */
+	if (iommu_dev_reset_prepare(&dev->dev))
+		pci_err(dev, "failed to stop IOMMU\n");
+	if (dev->ats_enabled)
+		pci_err(dev, "failed to stop ATS\n");
+
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
 
 	if (dev->imm_ready)
-		return 0;
+		goto done;
 
 	/*
 	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
@@ -4533,7 +4547,11 @@ int pcie_flr(struct pci_dev *dev)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
+	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
+
+done:
+	iommu_dev_reset_done(&dev->dev);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
@@ -4561,6 +4579,7 @@ EXPORT_SYMBOL_GPL(pcie_reset_flr);
 
 static int pci_af_flr(struct pci_dev *dev, bool probe)
 {
+	int ret = 0;
 	int pos;
 	u8 cap;
 
@@ -4587,10 +4606,21 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 				 PCI_AF_STATUS_TP << 8))
 		pci_err(dev, "timed out waiting for pending transaction; performing AF function level reset anyway\n");
 
+	/*
+	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
+	 * before initiating a Function Level Reset. So notify the iommu driver
+	 * that actually enabled ATS. Have to call it after waiting for pending
+	 * DMA transaction.
+	 */
+	if (iommu_dev_reset_prepare(&dev->dev))
+		pci_err(dev, "failed to stop IOMMU\n");
+	if (dev->ats_enabled)
+		pci_err(dev, "failed to stop ATS\n");
+
 	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
 
 	if (dev->imm_ready)
-		return 0;
+		goto done;
 
 	/*
 	 * Per Advanced Capabilities for Conventional PCI ECN, 13 April 2006,
@@ -4600,7 +4630,11 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
+	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
+
+done:
+	iommu_dev_reset_done(&dev->dev);
+	return ret;
 }
 
 /**
-- 
2.43.0


