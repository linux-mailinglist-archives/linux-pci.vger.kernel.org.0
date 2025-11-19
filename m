Return-Path: <linux-pci+bounces-41606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6978FC6E3DD
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 12:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A0CB4F53C3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 11:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB8A3559E8;
	Wed, 19 Nov 2025 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tkumh6ni"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CF935581A;
	Wed, 19 Nov 2025 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551371; cv=fail; b=X3NuVJyL0ECNicoYS1jUbLWLpZg3i1LP1eD/6LS9VYGwaTnYmJjgKNAjKS653YOkZCAHHixiSpMFaobArXjBdY3+RpLiqB1MXhFxk6oo5LevkAWDhIADX3ens1jtBJUlW2yb3D4idJA5b3pny4wxSmRyXlAt1l2/XnjPc3HFPQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551371; c=relaxed/simple;
	bh=UAlVehZO/BQ/Gxn53y1vcfvwyawrTeQ7k4WK965Triw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dB8ez5/ADtuel6A9zpbM/BQBG5jjT0D9AjwuCRYKEMpTndQ8olRNOSCCKpsPiNzwlAvs62+pbNUq8wVsMNQ2zFV+aSB9i86hE04Ukg+oXH4aJdsHvKajXxkBzAjUNRbhA6A93n+aQQvnCeETkSiUQ+zXIxVDHRDoWbx+k1Yo6Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tkumh6ni; arc=fail smtp.client-ip=40.107.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJ+SmZKkEGQZVf0+Qw/p7BrSa2gZwviK846PXmKNhy0OH87nWZOo36ibSVXXvDQk9jDollg97n80G44TZhs9s9dhAw6wRbvlE9lSJoljSqSgJh2WIyJH/CbcnQvCTrcmDhmcf3Br+aq4m/sfP8M7bxnUSCtw/oRUEunt+UOx8OIlheeQHQyNGkzTNVIZ64LFBvDbwfp+a6nzPZoxoYX9ModQsSwSZv7YXQZRYwKWBcxfOD4JvhAcSHyCFnkF5cW3Ua1N4Hqf/tqJ7TcnGhGEF3bd/Jvjbe6whnabQ+VVk+FA9a1piNau9de5ozzqG+0mhUtDYzDwQiv9DdolQrco1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttAQUT9oaBSccgpLNPFsHih6Q/up1j5LBKjPOrlSrGU=;
 b=J1Qo63ku0qlbOpcKh6vGtFLpOsFcaZ97Oq02dFUoIcAbzDYN8U0nfPHVswhzfVMtUbtRdWlylClclpTjVDt1Oc5dBDKGDJ7l0vnF1mSIZ/uZmJ2QvXae9JARsueHIPLJpeiMpS26w0BFIhk12PxE+xftRJuN5dOJYnWSqKqEL44ztwJVRR+hoIsnyCJ3d6kLmUU5dAINEIi2woAM8sErDFfSRNe8yyOSWJr6PpQMTraxm3rQWCOIhelXWrjETYER2xUJVWodPo5Mg/HVfw+c78HinXNDVq/CCB+UV/P78+W+ibBUeOqkWebsj/n9+mVSyNf8EWRTtFzXR8Dv3OHcwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttAQUT9oaBSccgpLNPFsHih6Q/up1j5LBKjPOrlSrGU=;
 b=Tkumh6ni0fzoupbh5o+VCAoIeIouzlFlxWu73nGECX5dHGU1QUs/58aVI+eKD/+avYN2KPTCp52FGZYHczvnVGt2rIq+8UeCdYfTg2nBRSbux8L9fjdhedD0CesSVTMmkluVbDy905fIdNkPvOmHolqrBc0J6xEfGQ87cpPHqRFZD9AhFoAvRRd94z4m72W0dCLAYEc79YGwPKc3lzanEgmUhVarnTwFxhMMNEWiwFFBzkOc2sN//X5gp6ZNVAnXSbYytesh8TiYadNxube4LCEo2RXlaQSnrJjaQ0m2WI+s9d+W9q+M47uWc7C6J/5KY9vsFxlKKZmDVSNV8SWGAA==
Received: from CH2PR19CA0030.namprd19.prod.outlook.com (2603:10b6:610:4d::40)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 11:22:44 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::e) by CH2PR19CA0030.outlook.office365.com
 (2603:10b6:610:4d::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 11:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 11:22:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 03:22:35 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 03:22:35 -0800
Received: from inno-vm-xubuntu (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 03:22:26 -0800
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
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: [PATCH v7 6/6] sample: rust: pci: add tests for config space routines
Date: Wed, 19 Nov 2025 13:21:16 +0200
Message-ID: <20251119112117.116979-7-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119112117.116979-1-zhiw@nvidia.com>
References: <20251119112117.116979-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be97cc3-be5b-4034-9378-08de275df5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TFxlziS5Ljfwjl2FB5DpVm4rNRuPcLxnfM4pPX4tCvP7RpHTHw+6bg9EjxR4?=
 =?us-ascii?Q?kPRL6Mw8N2pi80YmoJ5fs5ASzhaHGfTKZw/g8zKJtd1hH0EUQWXerGbtoVfP?=
 =?us-ascii?Q?5JxXfXKtzDFswRzCCO4vMiXMCKJaco1aKQFahw6C+ZZ7R1PaQfLpZylvHqHt?=
 =?us-ascii?Q?S6hLAaReEb5RZAn/xrNEkFYlks/nUKZeSrAtOoaM3KkWXlEd98vX+OfL5qNa?=
 =?us-ascii?Q?s0G/S24D5lIbRWiMEq7HkVcWJgJa5/YN6kYhVswHwhtFyEPmtpp2hTJ7f5v2?=
 =?us-ascii?Q?94oXwbtccQui3y45OPK9gV1mR/VYQE/sTWd7oO5yq1HeMgMMN7C7rryD2ndO?=
 =?us-ascii?Q?xGLLW69smKs1qJs02m1N6xhp8/p2Mq8KsJqLE0+E+jQL44vFRwfLgjxsvhfK?=
 =?us-ascii?Q?f6nWjrFJ5xhRApfC1KsQXQV1w5zBNaot4rECZy6i3eEN9F54rAUslChkT++9?=
 =?us-ascii?Q?WtmjXafahvCmD3gaCrTbraxU7F2u5WBv3+BP1L+rb6YA+Emgl5+bg7V9/feQ?=
 =?us-ascii?Q?D/cvulm/XW9D47tQeRcgGDywM1aruK7oiIRwfqWhCfJHGvIhqvYZ2eZxbR6q?=
 =?us-ascii?Q?norVOxIUxRRav335cJnyARX0EMA1pIQK4V6HpZRajMV04o0+6FAfDp6AIGOx?=
 =?us-ascii?Q?f3wzRBhHwo30IOX/NjG8bLr3qaLosUOvk3RAywEYCpKE3IWb/i3LIfpUlRPC?=
 =?us-ascii?Q?2rmN+ZXpu0TLiijC4eSeioGKMDCPv2RyciQacQX84W8C5ypkb+u12uMZkx9v?=
 =?us-ascii?Q?CCPFcJLeC8NlI00XxqEXJ/Ma1N08pstOAROjmPy0ZZ+cXgcZsRDovEFkQa58?=
 =?us-ascii?Q?/y0Z01SCzeXRz/W4qLOR4Vh+bfLhXaRQkqqLDzPN6d5HkJhbOmBmW2iJ1olr?=
 =?us-ascii?Q?SDaDo7Lpxx/p3QPEh6+atM3TRUsX9rbBBfS9zkpJ5W9VHchoFi7xOOnyTbfD?=
 =?us-ascii?Q?vwjlhBJo9rwq6efDVf65tObVvb/8w8GT7l6drrH7D8f3FQ5i9eO1gMiKz8oI?=
 =?us-ascii?Q?yEAr7atIw+K0ixtKjHno39sS1Fl9eKSMfIgpCWkhBuZ9NfCvqgw8gMTuj26D?=
 =?us-ascii?Q?/cK+RVX+ghdygFvcooM9MvkcCDmnlCjDL/ogpFiMrH/8W9zHhvjNXWhfg6O0?=
 =?us-ascii?Q?Xu0jha9wZ3BooQdlt4dTAc7PkwTqV0UgO9XuxlYLmL5sNhL9t+63LmWVvpyd?=
 =?us-ascii?Q?8f987IUhQs1w86+rtML1rh51zHzxm+OukTmBOzKsADuGZMTb9m2FxXOQ8uYB?=
 =?us-ascii?Q?3iEchPuG+6s1n0F4K0TxAdXmZBM9OKd4/aN/HhOFpUmwRSbsSfdh1L3H/+tm?=
 =?us-ascii?Q?ifMtZsS9sA4ZB2hjQnQq45VQrrjEMAYObqvNNvY3xPE71WNhksDBaCuutKl2?=
 =?us-ascii?Q?g/mgCyd0hGg5KHoBnMPFwEb/tHVVFnnvQkGTlT8sUUyDWAf4CtptsMp02gYE?=
 =?us-ascii?Q?0c+9QkXMnYFJ7W+HKL+sOhqCXPm8yM4VBEtz4n/4rbLeYniGLx/t9/HwJ4K/?=
 =?us-ascii?Q?lQ8SC2hJERdn98PjqUknKLAAW647CdpcvRFkNyKki+pDjgYxYA1ZfldfoanH?=
 =?us-ascii?Q?uOE1M1TggX3lLel99OQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 11:22:44.0655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be97cc3-be5b-4034-9378-08de275df5c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158

Add tests exercising the PCI configuration space helpers.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 samples/rust/rust_driver_pci.rs | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 74b93ca7c338..8f549b2100bc 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -67,6 +67,32 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
 
         Ok(bar.read32(Regs::COUNT))
     }
+
+    fn config_space(pdev: &pci::Device<Core>) -> Result {
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
@@ -98,6 +124,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
                         "pci-testdev data-match count: {}\n",
                         Self::testdev(info, bar)?
                     );
+                    Self::config_space(pdev)?;
                 },
                 pdev: pdev.into(),
             }))
-- 
2.51.0


