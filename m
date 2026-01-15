Return-Path: <linux-pci+bounces-44993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A0CD28B91
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 22:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A70DD30194B1
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 21:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845D328616;
	Thu, 15 Jan 2026 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BH466GCU"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB254327C1D;
	Thu, 15 Jan 2026 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768512476; cv=fail; b=KeKsG3LWsw1BNWJ1+bPVvxfpW79RNVw/N38qA64PHgkjXI4HnM+K8GfTBA4cfm4yLILEX4fRFJGx3gZAGvTcW6KV7HenWHwEsL7u7TmWMtCOSY7CJNunrUjmJMIN9PPJhS1yKlVKoXM4R0rO3SMyMf49X8XqPIjLpf+SvAHQ7G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768512476; c=relaxed/simple;
	bh=4bQWQSmjYxD0KovvThuMANgMv9IgNlKnp91B0oJiyTA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QziQk2iZbEqhEQe2r5jcSE1rCuNKEqk/YijBCWk3YUx47uf7VzW+qtn6CAkPCI/JReUTljBDveZjx1r3z+8QT79Epdf0jPMqYG+1VXjn5QHLeAr5BAUcNE3wI8uiFJ1hL5P4LzP5LZmA+zb+c+k8BSWqnZNLB/hvHtXsm5w+87c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BH466GCU; arc=fail smtp.client-ip=52.101.43.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wodT/5RZBnhMjccwtXihTi0IbeTVSEATMze8MX8oQhTaFevMw4pMS3QLHKi1PC7ie8SHOxmEMDHAAVaxhuSj/np0Y3SjuB2rloH7EVDEsvVVaaH3XPapkRybBgB6mWBzB8ZoEaxHFal9rT/uBfe+MsiuHb27a4W9+c/u/6lrpSqRnHQRS67wi9DUTdQz2QLHnYfMRNZOvrOLua7UUJ1MJ3bqYUvVerAUtaSIWduawN1CdIofNxS1XeShy8OZ3rn82I7WLVh+yUz4/QdQrvjQo73SqeeN1fkc5b9yyHbdRakHlVSgVtx+6ppsPGPFniFO4Pg4w8YwrQNYI1plp4GgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+1T4uOAOQ4YjYIIVRcFP0n4/yB5WT8Ues8WzJZr4yk=;
 b=l7CdyEGeOWFMv5dvZ10G2gS0mnnIsicBEmJYAfro7Egfylrg2ZOl4BJnROicmUdAdE7mRAf0TfOLH1Er0C+jHyfy9PlFK1vyUGFsvy5qqL0EUFIwDaBpF9aRCkNPits+Z/ejExZDNctZMFZTnBu5ymIlOGDIMck3AohhHjnt8MVA+i0ZxvHasZVIf0tNaE0eTunRMaEsQZ0Dmylw9xPlbcbwZGL1oxuTtiNfyr7SdkKI+wlP9Wx4NTnkc/fzhqVj2skXSrl6buUpTjUIwxZYzrr3rM3otmQoSPcNV4yEZAyhJ3kP3e6m+0eWZQ+tNYvQmh+hGPIYEoA+FB5wc1e4Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+1T4uOAOQ4YjYIIVRcFP0n4/yB5WT8Ues8WzJZr4yk=;
 b=BH466GCUpctpsXgWMyrp34cyR5pmPCyqPGf9UtoBaB5IoafrGwhkO5B1RgicG8R9Xk7GaxQlo295x7XrSUYAoDpuZH/x6y0YSuDtAB0lL5aIkrloraAoQz2z3Lm/knHPy4AjtaQTvSElsSvw2erH7bdvzYatMpsaSvdx5/c+lf94+ps+1gNFP0mThJUbGybQbAhi/7oWvJ49AArnLHdUKBqzXaZHzFCZy273dB2U7s4emujuV5zRuiH77l/0Y4KW2D17dXosckcfR0r/zdcIvMsYAPeVd13Wf28XqGtQLGk6eemXE87Inx7BvHazoypc4pogiZDVSnYWlgK+MgKr7A==
Received: from SJ0PR03CA0061.namprd03.prod.outlook.com (2603:10b6:a03:331::6)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 21:27:49 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::6b) by SJ0PR03CA0061.outlook.office365.com
 (2603:10b6:a03:331::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 21:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 15 Jan 2026 21:27:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 13:27:43 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 15 Jan 2026 13:27:43 -0800
Received: from inno-vm-xubuntu (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 15 Jan 2026 13:27:37 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH v9 5/5] sample: rust: pci: add tests for config space routines
Date: Thu, 15 Jan 2026 23:26:49 +0200
Message-ID: <20260115212657.399231-6-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260115212657.399231-1-zhiw@nvidia.com>
References: <20260115212657.399231-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: efb19455-e75a-445f-78c4-08de547cedf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q+CpuuaouOYaZBjnyoJFSY6klkSuAcuXpco0pk4fAfB3DTfcWeKhhgfoxuId?=
 =?us-ascii?Q?a2Cld9S5UGYD+KggE+Xke/hf4k53gJa6Q4X56+LgVzU6KeRJhU+YN+pBCBLo?=
 =?us-ascii?Q?k3H6OXsVZyz8zCsHDrDf2lXWteS9EPsrRAnG8ImtZ5bBqSe6iTPqaGwd6wCA?=
 =?us-ascii?Q?+fbYmW7BsQyo2896xki6ZtAGu/VAMtnAm7fw2E9v31JkOQUOjSAA3NSp0cJV?=
 =?us-ascii?Q?3xb9qTDU6t3V3WEsRsqVQNh9NWMisoMHomKcFu7ALRKCgf0z21nKHSJFjQ76?=
 =?us-ascii?Q?4WhWMsq+AkanXNwT3sO40/0TOw/9Z28Z3GaGJfYKJ8yUGvBdqdPpih9kiiDb?=
 =?us-ascii?Q?zekUwwpht48C7Gs7wvrsKiaouo24zF7NWs4EwbjnBV07s5mJ3p1PHMr1P6NM?=
 =?us-ascii?Q?Ba4gDh0e1WXDyEa0LaQyC9hkb5Rt1XTQwNSS/S3r3/YX12B/f2yEsdjkXht7?=
 =?us-ascii?Q?De+oO8NNq/3n2HiTjz3vTSt1+IgGsjdIBJMGzxgdi3+2mazCrp/mMa8q44Yb?=
 =?us-ascii?Q?Lrnhmtb2c6rFGzFLpjGylhwQRabTdtZ9CXizwliR5JdvOQ+RngmaawM/3j0t?=
 =?us-ascii?Q?elks0HsH+sMPS8nXYmMcOt3MtXI7v7qlU6T+GnTDkPFqUYQzf6wyx0WTINyu?=
 =?us-ascii?Q?5FAO9tMhpe5/XjnbqIZZomFQ4pnsvN4oRTBEqOxFxjl2fkEyxPvqqMQ8vV1B?=
 =?us-ascii?Q?n8EooUe8zsVVnj6Ex4oQUSbhl6NHj0JpUTfXcU8J91ybDGwQcvSr0gQUgMo2?=
 =?us-ascii?Q?SgQdl5Sfgzl8553fhQpGHgVbalqNB+Yk42jYCjNpHd5r8zKtzGNlvxDjyNiP?=
 =?us-ascii?Q?YInrljwJuEentdJcSlnez6+MNw2BxDgXHBPFOp/i7/bj5R7xuIhQLveGDPmN?=
 =?us-ascii?Q?5AUbICohUicBBOqJZ5kon3X3VwPjksre3SidxitgtJ1kqOgXe8JY4oSjh5jK?=
 =?us-ascii?Q?ae33mW32Dl8szbkIMKrPvYB/8R01BIhLVitOXsSJp2kPERr7BktTSMM9e+qW?=
 =?us-ascii?Q?VSYfWO0gJ15Y/9GiqWSLCsvUcNQLwlQr9FgJCtXe5fzy3yB2bRPoUrZwXCoH?=
 =?us-ascii?Q?E3DBrFHqGdCabMuQ+inL1Jr9X7TUaba4Qa2PMAlOLNl2nbpk5I6zYE8yOoVL?=
 =?us-ascii?Q?N8W1fnH5DUGBzMPo4pUXrdsuOoNwHA29VV46v+UUrKSJyMGJN24lMH+7uFuv?=
 =?us-ascii?Q?fe/hqCdybyMjJtz0yEo+STq9ec6MfGzZd2mO/FWAxh85nyuVa5fV+4sDO0nL?=
 =?us-ascii?Q?kC7JSwh1b9BMMXmbqGQZ1FmJfaqZYJDpjoFjNNutgSnM6Mlibz0Hfmx3yD/p?=
 =?us-ascii?Q?D/Q5gRNZd5NfXIsRoF33yGG15qJ2hxR8nHhOwMNZKzr9SZiLVOQ6/vod4e7T?=
 =?us-ascii?Q?bbRpJ1xXs16+tnoPpYaOW4HPb7gN7X7Lt0wvD3XpyHSWJBBQtBZ74OSHOk+S?=
 =?us-ascii?Q?wpIb6RBSW4c5wZKija2a55Ubw3HCyfTwboiC72sL5iFu6EiGcVG/3a2rQ0f+?=
 =?us-ascii?Q?OGhCDR7C9DglX1BuYDeH58xPtg3mZSx3ZiSUVwcCQJRgXjPdMdJNGui1R+Fn?=
 =?us-ascii?Q?RU3+6LKaFLS/J5i5QuORQNJ5vo3NFCxL1mLm155/bE9Odgef1lrnHKWvg937?=
 =?us-ascii?Q?DAbG9cnwrYrPsczPh9FLf7EH6ZYg5PZAi67Czdt/qXdByBJDBulBpW5YEBsb?=
 =?us-ascii?Q?T54Vsg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 21:27:47.7814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efb19455-e75a-445f-78c4-08de547cedf3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804

Add tests exercising the PCI configuration space helpers.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 samples/rust/rust_driver_pci.rs | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index f7130a359768..c5f4c6fc7cc0 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -5,6 +5,7 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
+    device::Bound,
     device::Core,
     devres::Devres,
     io::Io,
@@ -66,6 +67,32 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
 
         Ok(bar.read32(Regs::COUNT))
     }
+
+    fn config_space(pdev: &pci::Device<Bound>) -> Result {
+        let config = pdev.config_space()?;
+
+        // TODO: use the register!() macro for defining PCI configuration space registers once it
+        // has been move out of nova-core.
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space read8 rev ID: {:x}\n",
+            config.read8(0x8)
+        );
+
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space read16 vendor ID: {:x}\n",
+            config.read16(0)
+        );
+
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space read32 BAR 0: {:x}\n",
+            config.read32(0x10)
+        );
+
+        Ok(())
+    }
 }
 
 impl pci::Driver for SampleDriver {
@@ -97,6 +124,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
                         "pci-testdev data-match count: {}\n",
                         Self::testdev(info, bar)?
                     );
+                    Self::config_space(pdev)?;
                 },
                 pdev: pdev.into(),
             }))
-- 
2.51.0


