Return-Path: <linux-pci+bounces-43237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C8DCC968A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 20:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A404A303DD02
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 19:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60C5272E41;
	Wed, 17 Dec 2025 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pMmc/a98"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF22DF6E9;
	Wed, 17 Dec 2025 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765999307; cv=fail; b=T90+617xUm4GEEDtThm23p7T6qAbQsywymZv6O9FcWnWZMs3vCMq3yPmZLcLgSMqdQCwwYzWDiaJju/5u60SYZ/nST1ip2eKF/cMS/gYVnXf9CsGyHTqst+ryRVQ1HUheyS/alNVny6EldhATzl3LcrQ8IhJJSMxt4Ld80rw46s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765999307; c=relaxed/simple;
	bh=OD+0i4nzFKb13ZkFrJlq6nQogr5qYAJ6TS8UaJd0DFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGl5N8p6WWlnkcs2exIrzOXnwa1GeHw6ALOcnrfftInilrej70KdEPSemSC4V1zWn0NSygr8IC6a0iZ3UEzyXI2TDpPMOP8BnNgi1Ct0MnVvuABAbDtgEC5khByIoEcNK3oRH3i92grUUFKecVUKngd1t2iXA22uHTwulZciOPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pMmc/a98; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osfa8nCltYA5OWb131nxKAQpiaZVgNXMQ3ypX1YmKMnCicTzrWMfh0dwgdp78NB8iOGSB6wML5iYFgS3F0LVJ+8LihukdOjLCp6Lni/Ck1E4d2kc3hrc01HWZg7As1iScpeLiao8aZDP1cEU5pAO6DwMv/LbSQSNIaHCyTIa/Jn+ioSN341kosHAdHkwNcqcBAzCDcmftXgpAbrn1E7hHyeuWlLZ9OF66gnNFCvIg4RL/BVY5cCk6+mPTE3zqmlNEx97A7s5iY8OXjgaJgRAV4s9udfJk2KJ3CpcBn7NvxlVhnw3fF9ETFJWo8rRvbFLx7US3LGwi8Qg4VesBDTe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxAzLJo882LZYtEv0hQIYEW7daS4BbT18Q+40xRBUjY=;
 b=fqqomXFHT2+YXgxnctmtkRSJMnn3ISbxhY31GNOPtOwm3QvvP8afOzS2AWlHcxqcYdclN8A4lq9SBRHzfmrBCodPfrx+jb+2rYNRWWmWgf0WfniPsg2MYG/C8NMubYotqQ43vFGCPrOA26S4boUX2D5P6ahkNH9CE+2r5sNzEktXlsZKoP9iqV8fRFzNyKE9EmDylsOQTkSNRgzis62XSP9gCE88kcpnc3pzK6mMbK/mm/lNtXKnIjYX1TRcW5UrUFF20zY82LaXV7TvV3Hx9Fza1udkFKgaW+jWbJP6k9ZqRHFM6h7DGk0vJ4lJ4tWbjNqd95sRtkp1fgEUGs89fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxAzLJo882LZYtEv0hQIYEW7daS4BbT18Q+40xRBUjY=;
 b=pMmc/a98zp9CfimOqudJkQTBeqjehE1+UIUfy290bc59jsd3zkP9hiIQUEyIeYeGcs5R9+PTMV69ph1XDdOCBxgKMiIpjUWD2vdmEEckVlpr8+N1DAbzCrHpSzVejnFr+p2G2hghBglXKl7OmzQiF6CWiaUVp3hrCpV6+VwbyZCK3Yu1x8KRc/eMlPE+7PtDLsYnN/+/ACAqmffeypC9EgSEvmgLOz6IdVTJwaRFN29sUgo8UzXltdGh/8+mSlDEOqVJaeIdUC3sZURvwwT1y0xw6WO/FlSA5IkqH8Rf7w9+aI/ZTbJOvmrgRliwpe5iZNTUsWVXrVY0Gh99hQKZiQ==
Received: from CH5P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::21)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:46:08 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:1f2:cafe::86) by CH5P221CA0011.outlook.office365.com
 (2603:10b6:610:1f2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 15:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Wed, 17 Dec 2025 15:46:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 07:45:45 -0800
Received: from 82875d6-lcedt.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 17 Dec 2025 07:45:44 -0800
From: Nirmoy Das <nirmoyd@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, Will Deacon
	<will@kernel.org>, Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux.dev>,
	<jammy_huang@aspeedtech.com>, <mochs@nvidia.com>, Nirmoy Das
	<nirmoyd@nvidia.com>
Subject: [PATCH v2 2/2] PCI: Add PCI_BRIDGE_NO_ALIASES quirk for ASPEED AST1150
Date: Wed, 17 Dec 2025 07:45:29 -0800
Message-ID: <20251217154529.377586-2-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217154529.377586-1-nirmoyd@nvidia.com>
References: <20251217154529.377586-1-nirmoyd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 809cccd5-ef42-4d6a-a1f0-08de3d83653d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iGN2QMrQYqK8OpfJUmWTwvPFjNvW4gGULrHRgLOiOn0ixgFx3YIAyrmySF9H?=
 =?us-ascii?Q?h9ORVLl9Yyz7RK+qTi59Vyyo392OR9mDtCkpPwykGtUrxjLnCrTKZEE8yLna?=
 =?us-ascii?Q?cQvSqZMQ9mQv60U9JODrs3EjIHxGqZLWx83I/sPRWER8XPmukF+lk3nTseTF?=
 =?us-ascii?Q?odHgpO0Y1JZjAAKWikcsPHlZOfqCJIx+09jFSNUgUfrYZN6Btl0JtrpEm3iN?=
 =?us-ascii?Q?lVhCB4TBryswZzekEc0iIodvlUohJORrEYWFYlzpFRiM+/W1BH4d1E45JFsh?=
 =?us-ascii?Q?cFbbjU/jO01otV0GR9V6WtkOj8xZq0DV0bz4ZOr+lhlSchJcOZ9DJ7Tz9STP?=
 =?us-ascii?Q?ghPtuwxQ8Omp5LipMq2+Y3HUhViPWRKIuw5t5rLtLPKfLPVfYw4UnBQ+H/0p?=
 =?us-ascii?Q?evqCJ7Res1i8AhAi1n6MmXzj6Ld7o0LqwCAPyo6AG9TES2EinfZAM5WKS9hn?=
 =?us-ascii?Q?QxfHZPld9+njK5FJEOm8dUzybUASrxSJKEY+3NUB5NlN0DVkV76uCBD93miQ?=
 =?us-ascii?Q?xXND0xb22FrZSRF6zZvUOIn6WKYjrXfI8q9UECCIJZh0GOcMDFk1UhN3OIOr?=
 =?us-ascii?Q?rN2MTjET97e9hc+GriN0bjPD32s2Zsp3655vTPjT/WZGAPciQNgYhXoXmyLA?=
 =?us-ascii?Q?IYHXoRsarf8loYrjTVoTSYAHSDajZD5iKYWEFmHqQszz8Of9nY3qMRK7dYJ0?=
 =?us-ascii?Q?uQodf4Kwny04laJkJqeDuAACTGizSAprYC7ULcXf+i+2D5UngDtUMGsXbTKd?=
 =?us-ascii?Q?mdmJ4E2ekg6a3shQFng82DI8mWTSpKmkZyfJ1qrvn11E/nGjuPhl63T6lDPW?=
 =?us-ascii?Q?Gxlf+sGDS88aHQW6P8vfx6wZjKjdsglmlCHoz3Hugcu3xWjqc+/qxDMe5Msy?=
 =?us-ascii?Q?wVRYWfTx10dU+Knob2mTPvT52S1Fjn1MjFalPlfRZlQqtIuR2ORXc3GhuiPD?=
 =?us-ascii?Q?pMiPXoadrv2ceRFF5qxOPdoKzyIwKtACvcUR6dsx9oj0XKv+AMFgrGNqkgci?=
 =?us-ascii?Q?L1hUDjtDjE0N6oWvNc6mJHNEovrAhtyS5fMwrjxuiZeATtGOPuADMiH5Wtwg?=
 =?us-ascii?Q?ZCI/Rn0xwxHeeBY490xwjp/iHU55eI8qNgOFJGzjJ6MasSbHYrbK/gbsk7Cv?=
 =?us-ascii?Q?M6/zDq+BPFXK2TcorsVsn72g+/Jnv10o8HPJPdXM/Ufsecr5Gl4XF17Qi6LC?=
 =?us-ascii?Q?lxtC7gXSYtMA90MSFqXQk+vSTxwxpA4C3orWY4EbijKaUbtbA2ViAQ6Zaydl?=
 =?us-ascii?Q?LiscfEsMQFlb5BIjp404ylpWKSHLLm0IC2vqxv/t4IgzpvQeKHdbFO9fMOMc?=
 =?us-ascii?Q?hgn09HP/Dh7KjA7SHztOCuddIlUsqLtzwdlMiehAhqW9Cn+9kkr5u95Fcu7X?=
 =?us-ascii?Q?BR+k7bntfsYSFuM50cH10LaUXz8YQfeG+ngpk0qCEPFqKZlxutLQXfMzQ76Q?=
 =?us-ascii?Q?FFN4vKQLiSe7IjM69YRrN5JA+qvDcljj1mKRzJPKN10fxDOdcpW2FFgd2kl3?=
 =?us-ascii?Q?Jspd7DHA9nmPPggIteSc0kctX05bF1LJWYlBGDwbsyw1rgeDYPvr1+boAZkz?=
 =?us-ascii?Q?kMlL7OAT07+ir6JbNSo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:46:08.0117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 809cccd5-ef42-4d6a-a1f0-08de3d83653d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355

ASPEED BMC controllers have VGA and USB functions behind a PCIe-to-PCI
bridge that causes them to share the same stream ID:

  [e0]---00.0-[e1-e2]----00.0-[e2]--+-00.0  ASPEED Graphics Family
                                    \-02.0  ASPEED USB Controller

Both devices get stream ID 0x5e200 due to bridge aliasing, causing the
USB controller to be rejected with 'Aliasing StreamID unsupported'.

Per ASPEED, the AST1150 doesn't use a real PCI bus and always forwards
the original requester ID from downstream devices rather than replacing
it with any alias.

Add a new PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES flag and apply it to the
AST1150.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
v2:
  - Use new PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES flag instead of
    PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT to only skip aliasing at this
    bridge, not stop the entire upstream alias walk (Jason Gunthorpe)

 drivers/pci/quirks.c | 10 ++++++++++
 drivers/pci/search.c |  2 ++
 include/linux/pci.h  |  5 +++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b9c252aa6fe0..a37b7305ae5f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4453,6 +4453,16 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9000,
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9084,
 				quirk_bridge_cavm_thrx2_pcie_root);
 
+/*
+ * AST1150 doesn't use a real PCI bus and always forwards the requester ID
+ * from downstream devices.
+ */
+static void quirk_aspeed_pci_bridge_no_aliases(struct pci_dev *pdev)
+{
+	pdev->dev_flags |= PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASPEED, 0x1150, quirk_aspeed_pci_bridge_no_aliases);
+
 /*
  * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
  * class code.  Fix it.
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 53840634fbfc..2f44444ae22f 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -86,6 +86,8 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 			case PCI_EXP_TYPE_DOWNSTREAM:
 				continue;
 			case PCI_EXP_TYPE_PCI_BRIDGE:
+				if (tmp->dev_flags & PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES)
+					continue;
 				ret = fn(tmp,
 					 PCI_DEVID(tmp->subordinate->number,
 						   PCI_DEVFN(0, 0)), data);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b16127c6a7b4..963da06ef193 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -248,6 +248,11 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
 	/* Device requires write to PCI_MSIX_ENTRY_DATA before any MSIX reads */
 	PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST = (__force pci_dev_flags_t) (1 << 13),
+	/*
+	 * PCIe to PCI bridge does not create RID aliases because the bridge is
+	 * integrated with the downstream devices and doesn't use real PCI.
+	 */
+	PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES = (__force pci_dev_flags_t) (1 << 14),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.43.0


