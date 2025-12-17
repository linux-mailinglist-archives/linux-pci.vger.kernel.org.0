Return-Path: <linux-pci+bounces-43235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 893BBCC95A8
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 20:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C75B3008309
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 19:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECF4257852;
	Wed, 17 Dec 2025 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tDzwnUys"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EDF280A5C;
	Wed, 17 Dec 2025 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765998354; cv=fail; b=W8lSgJu0H7+UGDER2vCyh22vbYPmdQqcN1lmtgyqflFapr9XzsJSaD8xZbwVIj2oY7gXVHc8UA7SEFu1NvTvEQk3sEojQnOAOJKuggQ6Cvg3ZKw1C8I97Ldbo2V0nBKpBERUSOUdyS2k7hinsCUKZFqRwgBlRokH56x6SUWaUrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765998354; c=relaxed/simple;
	bh=G4bk2+Gje9PaQ87/PGDKKThlI6Q9WrWQJ3JVvy4krXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LW9vlOgz+6vnDkRpPA5gcorn5MPsgyh5l2amD/I/uaA8N+ue7blGVhOzC18FUfcDZj4Wp9udjRRPz6/z3KOq0rbaMZgZC1gNHYS4t1ONy3XT+2j0hehMYl8x5t//Tm/jJnAIAbjnn7v7sgT6hhky/p+uE4prKELSKJkh/Uhfpgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tDzwnUys; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW6vri/zEfDeetNPckX3tdiFY0wyyAtiDMywgz/MlafCQR5Pr5t8p4ahJDmxjHkH0P2GbJTmMzj/Y5HOMNUceiG9NSbgXcKfxfs9MiBOef78bWAgHrvJKjoNxp1qQUXRMzWQVM+rAvHBU7qYVNWnxYIV1+H0iT8BV2h1X90YBIt2/uFTe2RTFNvccNPH/pdtpVJ/SRYaYHPwY79pitCnvGU9SutLHWCfBMzl/d7v/V8g9HykecG2nL7LazHQynRb4JmKUkmuZW94Ie03tfrmuEQ6DhpHmwXcdVRgGFWvqRHGRl+On6avD9O2Rw48jEMhXhFdnde/uT4uMs01lqoFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm0fTuDrAy1nmU197fEcxtP4SUhRZbJgb0o5ivmqvJ4=;
 b=gtOKKSHpJssEQiqtokq2CMc+UnwhFTk93WvRTE4NcINIQEpfdmZ649Q+M495Tycps2zP7srmsgBFJ0UPGmRZDVHZAlBzxt5exfRhcq2mehT9vukuVsugQRW/WZ+z+MEYZBQtD1M1ljG/wyeaSjMRqSmG+DdTa1scX6qA+h81WdZYJygpIzWKjKIFtTPLDIaGH9uyzJ53r5kuBHoRyY2Hg8ZZ99SM3WtP1dS8BnUu8PfOGpaqSsimWZGXaf4JAJ74TJNCFrYOQH+2L9UBPeV1GzCVxxlQioyI9xuSnvKemJAqE6vpg38FisqSWU9M5s16DPTk6SXNFNEFUDwgaELHfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm0fTuDrAy1nmU197fEcxtP4SUhRZbJgb0o5ivmqvJ4=;
 b=tDzwnUyssG1f4iZyiw2kIzCZs8sv1GsQZcYhZpLFQf12mwzoMthQ/ctotgxXWEGBSHZ+ej8aou11yKGuxKqR+fqShFYvpLs26h+7Nh7BI69MCqip+bKJYscvmrkFNux/T6EA/dbL11igYEGoBoPVT2wY7Gdj0UtOtEagVDFIDzOa/vEMMep6x/31GJ9g8uBnYCKVP/ysIfJK/VELlYk86nw76tAJYvNdipHEt0QVc+xEMxjwO3g1qHt42z6K9lD9ZRen3FnTSNwWQ0oPnfJQUeGjtIw/m7CvcM7KOX7fzFrLq58DJNsCbSFM/GDxOn0qrdANIJfirVxielAfofzyBQ==
Received: from BYAPR06CA0010.namprd06.prod.outlook.com (2603:10b6:a03:d4::23)
 by BL4PR12MB9506.namprd12.prod.outlook.com (2603:10b6:208:590::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:33:08 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:d4:cafe::75) by BYAPR06CA0010.outlook.office365.com
 (2603:10b6:a03:d4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 13:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 13:33:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 05:32:47 -0800
Received: from 82875d6-lcedt.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 17 Dec 2025 05:32:46 -0800
From: Nirmoy Das <nirmoyd@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, Will Deacon
	<will@kernel.org>, Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux.dev>,
	<jammy_huang@aspeedtech.com>, Nirmoy Das <nirmoyd@nvidia.com>
Subject: [PATCH] PCI: Add quirk for ASPEED AST1150 bridge to prevent false RID aliasing
Date: Wed, 17 Dec 2025 05:32:32 -0800
Message-ID: <20251217133232.274942-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|BL4PR12MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa21f07-a29e-4bf0-ba1d-08de3d70d0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P3RRmk3TdEzEj47uNrUYfzIR+PhJTe3r2TZyabXddBrHFrF+wsyrI1X+xWvQ?=
 =?us-ascii?Q?4qluG8Z25RxdTrzE9ecbo60ujIXESgPoXfbqtFrYoJDvlnUsMVveV0NC16uj?=
 =?us-ascii?Q?1vVHrhoLUL6w3giGXgT/E/EgY2gp/Z097fz9tpB9aGwCa2SIVMf+/Y2M4JlU?=
 =?us-ascii?Q?lzNopFNE8qJnXUx849WMFpuMCgcaPlL7RkqETVHW4jcQAcnHZNipc55CHNOg?=
 =?us-ascii?Q?yru3k4doijsvHvhaOFARNHGh3bcUEfea+pOE8suNb3fDkOaBc5LwlPfhpOew?=
 =?us-ascii?Q?8DlSLT3spmss8YQy81MKrIOzovFmLL0zgowokEIFquf+1kErOqV11BymNiOU?=
 =?us-ascii?Q?6e13Gg2md0C/vhaFj0ILHjf0SYS+XGbh02hXvLmauyflBZadZRoWi8aCo4Sj?=
 =?us-ascii?Q?7e4OCwocuhZOMmZDL19BzmBzr/BBdzxDtHN9um2BXTuruLUbGXXORZv70GAs?=
 =?us-ascii?Q?anlqTfmX53TzcEDZWi/9WmDRjT9he/k9aL4wDnSKD4jP3XGuQOzJRpytLWM5?=
 =?us-ascii?Q?ykOXhp2UC4V1iVRz8oXuR3L3hNxCzgkAAN57WyQMnTa1mk8ECDaCZYbj2ebA?=
 =?us-ascii?Q?+Lm6lenlFdrGFW9BT1irXOTsp0fILR1Wceje8oJxyL+8zEgpt39CdpgyH4d0?=
 =?us-ascii?Q?ajevdZmjILx0OLEeijmZ/YRXVEQlN2fSQUpAPc6FlqXfNq6lPZS3ZmbcN94U?=
 =?us-ascii?Q?O/zu5J4IXyGgzhrKcWQ+bwM5e4kTTeWCTvIpAd6ugdsJRTZb32oHExr611SO?=
 =?us-ascii?Q?ObNSEuDAifCVrWhWwbhs4sTWJGFQKyNqG/W7BJ88hAVXG7rS3UfhwFZpvKpP?=
 =?us-ascii?Q?AVusXv90n/PUAHEkX9vRz7MW2khUDWYTdHDlM6vTOQxI/NwFGM7JslZFR3JV?=
 =?us-ascii?Q?DYBj7SoKKRmprUTsvJ17/9+khW+IPlAoEfDPetjR4dhhpWqq+rdIe73+jiAt?=
 =?us-ascii?Q?JEydnHAGTyy3fhcc4aZlMFYz36tO212W9d1cgUymszlZKstnU4p8+ctx4Zma?=
 =?us-ascii?Q?we1SrdnfYFlZjZAVtVU30YyhxwndZs0zpUnHgrE20FoV605kCNNy0SVBkevJ?=
 =?us-ascii?Q?BtyxhEhVQK5lBq4hit3dvU/0DqmkF8d8EgAQnA5exv1uh43nk1ncdnMP/pRz?=
 =?us-ascii?Q?6JCJO45pD4h4PEAum8/YCbpGtdBOyzVr7LFSN4zjftUYRlZjBfrXjDlqpGac?=
 =?us-ascii?Q?uqUx9x5QBXvd++F9vrMV0LsLbmZO1Z49w4jy0q8FQIAN0MHZw4s2PCPZCi/B?=
 =?us-ascii?Q?SlLYy0PS30yCvAIbpFHXuwgOwxuw4t2Zzp+0CylJ34ckZqXelR5P3XgE6KbW?=
 =?us-ascii?Q?7LXtXkl2zjok+TB7zNHcI5udS3yWFTwLcUjHZCswuTlb2UBsSfkbU+GYNRta?=
 =?us-ascii?Q?1sRIRHkGiHvn1zQbrDnZal6oS5pVeXtoFYBgeJ35GwHi51Dx4J1EpCppoqV8?=
 =?us-ascii?Q?UkIkQKQBXyjFquOtawlGkPjSHJrY8sENa6rbe0qR9bwRyROYGy3wBIkA/t8j?=
 =?us-ascii?Q?xvWntKsNSZeGQf7skq6U9L90ypbFK8GjFbV18pOOlgk/JCd0zeynhrTC0GF8?=
 =?us-ascii?Q?WqflN/7QLe3Sdzu1nhQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:33:08.0972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa21f07-a29e-4bf0-ba1d-08de3d70d0d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9506

ASPEED BMC controllers have VGA and USB functions behind a PCIe-to-PCI
bridge that causes them to share the same stream ID:

  [e0]---00.0-[e1-e2]----00.0-[e2]--+-00.0  ASPEED Graphics Family
                                    \-02.0  ASPEED USB Controller

Both devices get stream ID 0x5e200 due to bridge aliasing, causing the
USB controller to be rejected with 'Aliasing StreamID unsupported'.

Per ASPEED, the AST1150 operates in PCI mode where downstream devices
generate their own distinct Requester IDs. Set
PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT to stop false alias detection.

Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
 drivers/pci/quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b9c252aa6fe0..a7a1bf4c4354 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4453,6 +4453,20 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9000,
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9084,
 				quirk_bridge_cavm_thrx2_pcie_root);
 
+/*
+ * ASPEED AST1150 is a PCIe-to-PCI bridge that operates in PCI mode (not PCI-X).
+ * Although it reports as a PCIe-to-PCI bridge, the downstream PCI bus does not
+ * perform conventional Requester ID aliasing - each device behind the bridge
+ * generates its own distinct Requester ID. This quirk stops false alias
+ * detection at the bridge, fixing IOMMU StreamID conflicts that break DMA for
+ * devices like the USB controller behind this bridge.
+ */
+static void quirk_aspeed_ast1150_bridge(struct pci_dev *pdev)
+{
+	pdev->dev_flags |= PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT;
+}
+DECLARE_PCI_FIXUP_HEADER(0x1a03, 0x1150, quirk_aspeed_ast1150_bridge);
+
 /*
  * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
  * class code.  Fix it.
-- 
2.43.0


