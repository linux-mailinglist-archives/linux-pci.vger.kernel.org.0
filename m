Return-Path: <linux-pci+bounces-39829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D10FC210B4
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 16:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EAB467823
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDA6365D5A;
	Thu, 30 Oct 2025 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I6XB/YD0"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B383365D2A;
	Thu, 30 Oct 2025 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839354; cv=fail; b=u/Pn51nIxMS8CWMPAUlurDzx+k5Tp30Glr/qjjLYV1Un1l5YWlwUdm9yyHxqc/zLjZtKyHImaB9OFDsciteddqlExp/UDGbL9b3QhCqjnmILKGEstTb6aBjTp938WSPjUcszrMfcUryvoLAZUydJ57DY10crDHF/IjIqRKKxbfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839354; c=relaxed/simple;
	bh=RpbvDJtkw2/AUnfYeXm1Q/jOely8M/XVE2bCQk1f/Xs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBfiBCM/BZ6JEDSpZEbz/igVgM4Z+/w4Rni+9YN0wJ+QyrNVKdYNffpWkuQEY4cMFyfYIRe1iHiefZjvXCZkM2cIBl411p6F+i5V1IavwDbXaGCpZk9GPcwTuBXbfn5s1Yq6OqFS7Ik9xBtmhdw26yEnyKH0mqj4ik/HlA/hcrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I6XB/YD0; arc=fail smtp.client-ip=40.93.196.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsbNuf+uogX4kBd888Q6P2kHp8gQYsbet965C0RwT/a5h5ufkHfB2AourcRoGm4JXD8kp9jjhc6r7xYrcHFeLZKuoY4PEeEgc67iiqyw/T3KU0tz15M327haoC8tvNEdFzkjwUc5B1KGhlDdDGfnSbLs9LMWGc/reoXwkui6GD1nz5uIO8ORK/TORwCApI3Dt1YsTRJJV6Nrow0CJWurBwnM27moAD6zLm8otJs4c4XwfKeQGhIUoiiCV07XTwBWVHqRJPJ6VBlBb1DfYhe8Z6kn4mhn4FYXlzJfu/9hfEBLtQ6e4k2PWw6tMGX5yoVQdbpcZhzdxIg24LMuejr1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9c6vpHLEGEGYFzFW6RKkAkL27E23uLlwsfhX0CedRQ=;
 b=FTyUh+9A6O6aW5QB7bKFZFlL5ItIr9y6oKO/wS0cho5LVbHoVL3A2c+WpvfrSRR1joU/EKUjV5Zf5cScngy6DVFYKc1SlxlM96a/jPiqVaRyM5zjUWP5/lPF+A2aJSg1IPaFfZVBPJjRlQb3gGu1qqJ1J/8gfVHfxwI9/Zajw+xHGLRBCyy9iu65DsN2/Er9hRQ/IveuMWEtTuzIC51sVmEh87A/y+2kDYXHhMCdBDM7jOIAxMwsol3y9yQjDNN8A774QBoaVhvV2WglGAdMqipmFuuDP4yXADvu5000nZrvkZst/nxHwLBpxJbVqHfBTm9npT6/XmH5BqjfBoVy9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9c6vpHLEGEGYFzFW6RKkAkL27E23uLlwsfhX0CedRQ=;
 b=I6XB/YD0Ohk5bISu+VlDKaeHpBS29gk8JXR5EVJZpbvycNNVI34K6vuf/jQ9J+UjnJ1XehZHeqbvWgO1hPbOhsxgsLOwiUtQp2tDfaYPjD1sx7z9xknvcv97QwsUA5V6eSj8bLB4Fn6kag9Rj/CdKdnWH0apeTTh1prc1zq1ZT0ZDZH0lsl/GXSyeC/c4H4yUZUcHOj/KVHNDZ5srs6gNTYnp2Uidpzrns3v618T6+SoAnG7A4lL51L8+t8vQg0WInfiX275oGusmHLqST1Q/ECeXNmjBs+lFAc1pdjkpRlushDoOXQAbkxvbrGDvaFk3PiFtyNQTkYrSq4H3D3Rsw==
Received: from DS2PEPF0000455E.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50b) by SN7PR12MB7297.namprd12.prod.outlook.com
 (2603:10b6:806:2ad::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 15:49:06 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:8) by DS2PEPF0000455E.outlook.office365.com
 (2603:10b6:f:fc00::50b) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Thu,
 30 Oct 2025 15:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 15:49:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 08:48:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 30 Oct 2025 08:48:47 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 30 Oct 2025 08:48:47 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>
CC: <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
Subject: [PATCH v3 5/5] sample: rust: pci: add tests for config space routines
Date: Thu, 30 Oct 2025 15:48:42 +0000
Message-ID: <20251030154842.450518-6-zhiw@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251030154842.450518-1-zhiw@nvidia.com>
References: <20251030154842.450518-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SN7PR12MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f4c475-c688-492e-855d-08de17cbdbd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CGyY93HQKa4j6n6DfAJfiwzCxQTML+BKBjZ0At3R1cIEYW4AdM73OU4bOXh6?=
 =?us-ascii?Q?3UKJu1k7tKwzWlIiEerFOa6hSIo18F8gmvHE0DxHEEPfzx3tKZa+5dK4wFK9?=
 =?us-ascii?Q?MGLu2W/4P05ymElJu3BS8hepy+K/ODhVHI5K5IeZOOPbjKnmQH8NjRxDuJWY?=
 =?us-ascii?Q?keDTFj0oN+clarLA7HTdeTbIJnxcUGL09E28jSAz/NyPWVowHJnBQSvTXLqF?=
 =?us-ascii?Q?8f9z0FSyqivGjE+P/DryXo1ZiFWC9poWTdjSNvK0d1BsCndvXynuvP1r5X6Y?=
 =?us-ascii?Q?lC5VYBvOx6MDp4EWcyLw9D9eWtziPQ2nZuKiwvWwRyz3KrY6jp30BY6pZTzl?=
 =?us-ascii?Q?i7OoBDGr+U1PMLwebCK6lQK0nhpHd6cCbqNh9JH5wFChpO9UJfp1YsZDHhNN?=
 =?us-ascii?Q?uXQsUtu6EZ4KIJ3g/JkIgnMFQQRhfta0q+aRU1LSxRPR+iZP188vMnB9VLlg?=
 =?us-ascii?Q?HDmq6Wn2fHuoWb+BHKbKuAP0FWCpsY5ezmx+G3VI2rQIiyJul+ddETWDXdBp?=
 =?us-ascii?Q?5iY/25+wlxS7UK2USByQdKLVDsqRKXiNkfwpSphs8TveFi97PAvHPcdh19tU?=
 =?us-ascii?Q?8zE8Z4GfxeKYPqQVI/SCVmmmDSLVFs+KMX84zpC2txF61sI3GRz40uhevH7X?=
 =?us-ascii?Q?hxtWSoLEeU0cVlRslWyGWQ0dgv+BbGDMjTmITvWsImRtZb5B53IXNyMozhLB?=
 =?us-ascii?Q?l6oZcFCq66IzJLqnEt4BiCkUUf0SEWiNz8kDxMZuqb5fiPlVdscdUlwoK+MQ?=
 =?us-ascii?Q?g/OE9jKVpVrhLkJ6YO4dhLmWJgicEL/+QJAv+1rwsJ4ZPgum/WrXbv5yXXXI?=
 =?us-ascii?Q?BvL64A6CbNit617J4dAnKO/BU14Kf3bUJRES6waM61P/6hEb1Rr2LkNZ6yVF?=
 =?us-ascii?Q?HPhLJXrLsSaPjcrAmggwheYKIS43FqV6YgiJur6Zj3KAIw2cBx76EFok5dxE?=
 =?us-ascii?Q?/zNXjXkB+ks5jHB4Rom/W/krRoF7JAb7NwCJCpf8tUKkIWJkwj/DdXa4yp0k?=
 =?us-ascii?Q?upr+VLmnv1WaueFHZkIuInfvDB4H0aShlELKBtBWoFaTXWdRuvPAYIN/mS3O?=
 =?us-ascii?Q?UcsNsGiIt82lkS+vGfrCO4ocu557IsprglLOqtgSMsY2HQi8wvbkSrf3h/aw?=
 =?us-ascii?Q?GY+Jape5E7uWt7YdVGllZHlPSTx5aA0hBHqWL/F248FgwvwZubiAjF/DFj/v?=
 =?us-ascii?Q?c2v7LZZ7nLSDoZBSWfrWMYJWhmsZdw5FNNRYQoa9AEMCortRrYmo7gMBJBS5?=
 =?us-ascii?Q?Q6IRmWxVLckTy10EGx3W2uAEO82xbCQJOyktaq52lzQ/m6aXg3icrqd4NKrY?=
 =?us-ascii?Q?Cm4E+MtdfFypxfKbQNF9P/N27qkmS9x2yXcjcRZ4rLJB86/18qs++lTUjXtJ?=
 =?us-ascii?Q?hVQg//Qn4nMxE0215PpRvtaJ59ydMkvbQtb/kSO+8i9JG7F9xPCfu98w2n3Y?=
 =?us-ascii?Q?ki02dPzTHeq2R7g3aml4fh6ozi4Gzxr0e+Bq+0ZXzRBnuRrQ4KzadpcW+DSB?=
 =?us-ascii?Q?ro+2qNUBRqlY/Kd9U0lbULw5+deuuMWBZzzQqED8NrikiIl5KX/ToxSM6RCn?=
 =?us-ascii?Q?OM8XpGVRflxaLLgeTd8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:49:06.5791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f4c475-c688-492e-855d-08de17cbdbd1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7297

Add tests exercising the PCI configuration space helpers.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 samples/rust/rust_driver_pci.rs | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 528e672b6b89..f02ae6d089d0 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -58,6 +58,30 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
 
         Ok(bar.read32(Regs::COUNT))
     }
+
+    fn config_space(pdev: &pci::Device<Core>) -> Result {
+        let config = pdev.config_space()?;
+
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space try_read8 rev ID: {:x}\n",
+            config.try_read8(0x8)?
+        );
+
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space try_read16 vendor ID: {:x}\n",
+            config.try_read16(0)?
+        );
+
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space try_read32 BAR 0: {:x}\n",
+            config.try_read32(0x10)?
+        );
+
+        Ok(())
+    }
 }
 
 impl pci::Driver for SampleDriver {
@@ -93,6 +117,8 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
             Self::testdev(info, bar)?
         );
 
+        Self::config_space(pdev)?;
+
         Ok(drvdata)
     }
 
-- 
2.47.3


