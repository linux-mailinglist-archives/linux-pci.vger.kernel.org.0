Return-Path: <linux-pci+bounces-45084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 174DAD38C63
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 05:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76DCD300F249
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 04:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33A7327210;
	Sat, 17 Jan 2026 04:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJ/9zLeD"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F59C32694F;
	Sat, 17 Jan 2026 04:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768625821; cv=fail; b=NOcpfY4oDDOfeYKP4j8nYYAtKFAVhBsf+YqCWMrFdtduNjMoyb7ZI8RJgjR+IrFlAtBmw57hgF9jZjtlVgyMrSrQoKy+KQ7irKwui+UeQQvDUr0H8TYSTJUXiEmoMVijNeuQltgRn3s5gxnoU0qByNa/gBy34i/I2KWSAsHWUXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768625821; c=relaxed/simple;
	bh=rF7sfiMTZMK9fetkgxqMmje7BXGzuvIfPfj3cJ2R8ks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+fObSGFrdfKyVvw1f1Ln6ctgRw6N8wAAX6tt6i4A/qu2Et007nmqarb1LgImagtNmJMk2dgDsLfoRFHLHJF82bTfu3OyctD/9gpakkhmPox5itSY5QsJII95IVvKGYiQKPfzeUQ9WyKSzCuf56+Qrxpuxq/LNzgxZgaVkop6A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJ/9zLeD; arc=fail smtp.client-ip=52.101.62.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEKGQwLPaSUiFEP+p7B0+SryRYnLUAtN0+aKRqfDOsYWGPNTIzJwIMLi0xkgNrEXLNSuHZoXL1gM/T7FEnvjlVxamQx0vVLv45kF4tuEq30thF4wxfoFeLhTap0rDXAwGgJ9OrP38ozlYN8iklkqcy3L4tNtVNc0BjJQnBs7Rfix80mivqxHlfmCenqAX+IdCLt+j24QZQLAy6noAzboBLFy3DVUA6OzdEhqoNqAND0cVo/D1SxVJa++dbDTervKEjS8ZPBOpmYuXj1C1a4nlhzrAnLXM3/gGQkE8m1CiON6HdQJNo9Wpe3MrOin0/QWxj3uLDKHzf41iIFrUYzYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOLnma/B2oSYDsW7ozgNNZfoaws1+F0GCvs1TbSDHd0=;
 b=Gh0HFYIl9N9AZWhS6sIdb5e7Gn/+kzkjSGQoFYp27DMGD9pb+qFKsKO0aWRAb+PYYaXOMpw5to258scWyxArDvbh3xMs1YG1pJyMYyObVlw/zykh5S95+iXljcjynO0R29Xnh2SrHqV7cgqhqDnZMDVofrK5Bz0oZ37VknH71fy6Sx4Pp10kD4KJZuv7exF3kwW02eOazQ4lS9KOsV+Ign/tpTF47SSBAmnudJBxQuldrCLA/FhhSHJUrRC/8nXwtfc0KR2YfRTGD/Nl5OWzoAk5Kwj1lmhvrfDzu6Z4qzzO60+CpaXziYO0DoNfI4gXzUHUatngY95vs3DowTd8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOLnma/B2oSYDsW7ozgNNZfoaws1+F0GCvs1TbSDHd0=;
 b=bJ/9zLeDxJ3JyGCowKqTVNYxoAkkpVWebN4eYpNllqCuOhfvDcjZ7AQE3UrB7ZsdNG/TXVrhWD5fRJkAxAXywFfXhR1PljmUpY2WJc5H0xw587x47KyjCAn0IcYgTmIzKIYSSW0FbFddna286HNL5WbOhhFed7E3BHmfW2X9eZkGP8qlolzkanCs6hzPXG1ojx2x0l+bvqbWY9i4NmJw8Cjr2PQ45gf+Jy+sGNn2J6JEwBr1iCCNz2KYLfnObPf3QD/ZWuQog/nGkxubpdzeQcbo+6KHz2DNMFPvlvWDplRb7xSOdmqFbWSGjI8/dM/Z3p75mA/xnAQbvH8gX5l3xQ==
Received: from SJ0PR13CA0152.namprd13.prod.outlook.com (2603:10b6:a03:2c7::7)
 by CH3PR12MB8995.namprd12.prod.outlook.com (2603:10b6:610:17e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sat, 17 Jan
 2026 04:56:55 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::17) by SJ0PR13CA0152.outlook.office365.com
 (2603:10b6:a03:2c7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via Frontend Transport; Sat,
 17 Jan 2026 04:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Sat, 17 Jan 2026 04:56:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 20:56:51 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 16 Jan 2026 20:56:51 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 20:56:50 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH RFCv1 2/3] PCI: Allow ATS to be always on for non-CXL NVIDIA GPUs
Date: Fri, 16 Jan 2026 20:56:41 -0800
Message-ID: <61388f3f7d660994fa03e77bd37aa84b6c5fa3b8.1768624181.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|CH3PR12MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff3148b-ac07-43e8-2b5a-08de5584d660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gXd2TnLal6GayUfR7lYq9JCmx/7VEKKzC8RHcfoJsYd3LOAXlZckAkBgI+ef?=
 =?us-ascii?Q?P5hQy7JJr1YvzY77uo1yy30oAkiDNfVvvsk+1vCff1OYAjyOZmINlSAmQCLx?=
 =?us-ascii?Q?9hIhG12o0Q2R+zfkxXIuDtq7um+Vec+4BU8zzLKXXrARgjFjD4s/N4/IcdgI?=
 =?us-ascii?Q?2ltOvdea6DNWTTsINLQCTk3EcDUf1FUp9pjNdd69T6+q9HqkTtf2uciODF/v?=
 =?us-ascii?Q?zVjhKdGjEG3SbM81G5XI8HLt/5AG84lNg9EP8QToJU89c07vKe13XL4/O+qI?=
 =?us-ascii?Q?xZT35Mlwthfwel6LFq994OKB5MiiFwjm04ARIM3AP1DKBKGdi0FLKLFKLT3J?=
 =?us-ascii?Q?7X48RiebSsBgBs+nYSfmFbS2+7oXdcxnL1m+gG8CrbvN08OBHQOW4/CiQgxG?=
 =?us-ascii?Q?q07YBazelEOkrCzT7T+oKn0MhXv2s/fwLgz6p9UsYWeZMZas5BLy7DBcJDr2?=
 =?us-ascii?Q?41KX/7pRqbtTztKf8yf2EMe472y20DtcluOAy5EFxJA7F816B3/sqDUSn9hy?=
 =?us-ascii?Q?5lt762SZLEbDkasSv2+6dyaWtMWLHlpwVe/JbbO5P4ii8kNo2N5nxsDAyYz3?=
 =?us-ascii?Q?YHiXiRFeNxL0bDKcFx9v8K9CZg0IgbZVa6GkR4rxsTg2T+wYvEo5lkxDU2Jn?=
 =?us-ascii?Q?WAmf3XC0uQz8GfShp7mEBGh91oJYieBz8Da2sWi208+yynRbVWaRhzi4+AwY?=
 =?us-ascii?Q?qEaGy6vkwFPgdTbrB+aUGq3l17W/l8NVOZ6ufbTxv4SZOvrXRLITrN/uemaZ?=
 =?us-ascii?Q?WLkZ5BfROUGbEULGb3rghimChpMnpeVJNYOWjYDLf1IpNeHK8/+dQ6qRsgt6?=
 =?us-ascii?Q?7a3WS9V1vSDlQGBfnXyFmWfiPsJGuQO95KiZGtWmBrW1wulZvxZjt/8Zf1Q0?=
 =?us-ascii?Q?UTBufPXUeCY6qQefO4D8Icq77pYLfBAKefU9+4r0Kfri4pCAR2cUAYh9+ZKC?=
 =?us-ascii?Q?RQrBUW1kq+MPL5JotiDobzHJh2d5QEwlxCGYCxP4Xm6H7OC7sSjdEF41ZRaN?=
 =?us-ascii?Q?wQhRjxTtF0KvTCgmEdJvRATKwrwDSPELNEukDNqoa990DdB9CCalFab7tfYq?=
 =?us-ascii?Q?0/UOh4ZScC2azVwd88+ksJK5pMgyBzN+t32s3yv+V6KYui1WJ4yfNZf6ZmUa?=
 =?us-ascii?Q?mmZsjcxzzc6iPqAIwB4XHES8wp6Xhx95OvAFEt1093D3Zsr6iUwBnVoRMMeU?=
 =?us-ascii?Q?AboUt6zLmNIfT/Yvbbii+70uQR62YtaSkWrqEXE7h1a4xmzlHyTGoxSv9uFT?=
 =?us-ascii?Q?4GVw+kCMxX2fvylcajTYJFGk50b6ly/6zYotdNnQbciYB1exOyyvv3qm+s37?=
 =?us-ascii?Q?uq+SCdam1YM0OAEq/8SX71k76XMZohLxvyAtrC3k+phriWrk8ZoKlj+UVhvB?=
 =?us-ascii?Q?tSbvzFRkVyVNGYhEM0umq9dNoBNesKPKIVQTnSGBVHzBhzlCf6oT4J9O6eGw?=
 =?us-ascii?Q?Ad4DNKCsXi71dWAOvmhUPPF4emFDxJvSgHWBeMBIvj63uiodIfLHoDXn52qP?=
 =?us-ascii?Q?1Jq/3IVEr7D5lcLs8gocw6bQ59O6hIowt1eM2Qq/oQ1hwhYQyEUhSVKDXGXx?=
 =?us-ascii?Q?HhQ1ppvwKdPTXLoNsJ80fZhtttb5Yxj4q0QSYkmz8+6+gxG0fcPqlsIC0bM3?=
 =?us-ascii?Q?6mN8nsRHtHfcgxgr+mBur/EyK4LN8Ak+pg8U03pl7jTjBfjDV6c7lSRikZoI?=
 =?us-ascii?Q?stN7nQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 04:56:55.3650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff3148b-ac07-43e8-2b5a-08de5584d660
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8995

Some non-CXL NVIDIA GPU devices support non-PASID ATS function when their
RIDs are IOMMU bypassed. This is slightly different than the default ATS
policy which would only enable ATS on demand: when a non-zero PASID line
is enabled in SVA use cases.

Introduce a pci_dev_specific_ats_always_on() quirk function to support a
list of IDs for these device. Then, include it pci_ats_always_on().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/pci.h    |  9 +++++++++
 drivers/pci/ats.c    |  3 ++-
 drivers/pci/quirks.c | 23 +++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0e67014aa001..1391df064983 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1032,6 +1032,15 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
 }
 #endif
 
+#if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_PCI_ATS)
+bool pci_dev_specific_ats_always_on(struct pci_dev *dev);
+#else
+static inline bool pci_dev_specific_ats_always_on(struct pci_dev *dev)
+{
+	return false;
+}
+#endif
+
 #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
 int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 			  struct resource *res);
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 1795131f0697..6db45ae2cc8e 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -245,7 +245,8 @@ bool pci_ats_always_on(struct pci_dev *pdev)
 	if (pdev->is_virtfn)
 		pdev = pci_physfn(pdev);
 
-	return pci_cxl_ats_always_on(pdev);
+	return pci_cxl_ats_always_on(pdev) ||
+	       pci_dev_specific_ats_always_on(pdev);
 }
 EXPORT_SYMBOL_GPL(pci_ats_always_on);
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b9c252aa6fe0..afc1d2adb13a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5654,6 +5654,29 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
+
+static const struct pci_dev_ats_always_on {
+	u16 vendor;
+	u16 device;
+} pci_dev_ats_always_on[] = {
+	{ PCI_VENDOR_ID_NVIDIA, 0x2e12, },
+	{ PCI_VENDOR_ID_NVIDIA, 0x2e2a, },
+	{ PCI_VENDOR_ID_NVIDIA, 0x2e2b, },
+	{ 0 }
+};
+
+/* Some non-CXL devices support ATS on RID when it is IOMMU-bypassed */
+bool pci_dev_specific_ats_always_on(struct pci_dev *pdev)
+{
+	const struct pci_dev_ats_always_on *i;
+
+	for (i = pci_dev_ats_always_on; i->vendor; i++) {
+		if (i->vendor == pdev->vendor && i->device == pdev->device)
+			return true;
+	}
+
+	return false;
+}
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
-- 
2.43.0


