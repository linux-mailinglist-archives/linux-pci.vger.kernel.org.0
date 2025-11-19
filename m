Return-Path: <linux-pci+bounces-41602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5000C6E3B9
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 12:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4567357180
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 11:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C74352F87;
	Wed, 19 Nov 2025 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZVvmKi6F"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7835294A;
	Wed, 19 Nov 2025 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551332; cv=fail; b=CXyGTNXk0ozdnj+74uR+1N4wAv4Ud8mVUMxwACSgQBp3oRWPBoAeu1jwKcmFhf+RSihcDFblr9Cq4A1JaxRVl7Pc9e0nIJHtXVVDMvXCOi+zqR3STwVIPrrli6JZAywvCGga9tY8UqrqQytmwzAN9hon7FUGVJOs+FOpfic7uUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551332; c=relaxed/simple;
	bh=oaDU9R0c+0AZkUuqLiBKWaNqYjgoBQ7eqT5ZyfVrhDc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpY//ejNQvkgPVukGMTz5OUieoAHBxsIAMOki3eYqEatmB5+BUGb9JPtnBaqijv+d55LCoGDzd0fhGRwYxOyaKU7zUa3g0boiD+o6sKb+Q3U766d/z1cms0ZSL9RnFRTFv8sr2zjoJyKRhObozSy9akHWowqIiUI0k95uFJenBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZVvmKi6F; arc=fail smtp.client-ip=52.101.52.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuX8Vz1ZWkalH6IygOZ5a4O+ONxJY4Pdi8PvoNUSCmztPrKf4cdUVeN2p2kMfz6yTuy5E1j28uuOrbjzjGgxeq3/Hy1gvsTSlgDiieWLIQbdWBMhfR27tzgm1nC1jKZzuRlM31ga+mfdMIKG8bn5b0OyGmJ/+sXcmX702tw4EEkoxTzmD9atDUi5FwjcHRsseNX5GHth3ivpNJd8LRWH3U5bB4dfkSUSF4pvOuTP9FaFsAS79BqpbVa5+Azc7Rr+FxygKjCtsFrKYcWNYp/GE72uj6giNk/1fdPS9zndMV9K96qCM3rKbegCoZ0+f06P3PLjiE4XMPGJavN8630RXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8x4yj/G7vGU6AZsdydxgsuC44+rEqE6fphBnwlUugdM=;
 b=AlHULiCC0mmQXp/hl49R8LoJQQD0ktNJMMehymll+5nz5Dnee0g7M3TmS5wd8pbXPZhefriWunExm2mYELlbDknfZR9XxvKPbhwZd89bsUnpx3U+viV/hf51evTD/KGxaGWjHHLFtGQDhWepKR6D5dQeAoOeCXKUp0gFdfb92zjkPICHsXzgfc4TiEFz5KrXZ5WCrAZ9Sv6YlLoLFbXSBGik7ECBoTdoXogKk3Ld2yStQxk9Hh1f0AsAmvBLOLWKDElaNZ4QFRkG4db5sX+UFW891MabRcG3ZG9zCaDHQ5nMbkELTqOpfkSG+gJV7PsCMYVqGDslE1y4G82x3Z4jsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x4yj/G7vGU6AZsdydxgsuC44+rEqE6fphBnwlUugdM=;
 b=ZVvmKi6F3izEMOa+Fakp+X7TpKX8ofubSfdGb5LRsIEHcf2RiMgORpUrYo5O6JfFGZXgsGAYeYWD+Ju2vo3f6evgNg/9GeyezwbzDC/pg8b+/rFHhst5/qObiC8RZA7UXFBHkjxtuYblVfkS9DGeuFkrSgOG00WrXVeFwJckq4jK1YNu1U1B+kmNjEXnHyTFTT6xTUGVMrCZe5h+LHrhmtig4ZxL7SYtBEa/wND63QQYbO3Da9wDOV4DulekLsG2AX1Fx/qoJM3tkKPEiA4fYW2BOeyqS3oJqAJcf5f5L5VaQK3RXRz8A9oQM46kowT6CnJVP++pr8a+Z1UGVrmyMQ==
Received: from BYAPR11CA0067.namprd11.prod.outlook.com (2603:10b6:a03:80::44)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 11:22:04 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com (2603:10b6:a03:80::4)
 by BYAPR11CA0067.outlook.office365.com (2603:10b6:a03:80::44) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10
 via Frontend Transport; Wed, 19 Nov 2025 11:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 11:22:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 03:21:56 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 03:21:55 -0800
Received: from inno-vm-xubuntu (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 03:21:46 -0800
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
 Wang" <zhiw@nvidia.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v7 2/6] rust: devres: style for imports
Date: Wed, 19 Nov 2025 13:21:12 +0200
Message-ID: <20251119112117.116979-3-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae43c80-7a07-4c89-cbe5-08de275ddddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mWuel347yx6aeLhHAKXjdLnD+A80YQ9dtLJ4Q2cxG3MSyPAncFWZdBfGDzg8?=
 =?us-ascii?Q?WAgiaWE7puyNiEQS2byBIfUP5Rrp2dUK/5fzxUnkCaCNgkQCR4L5S7+Iu3du?=
 =?us-ascii?Q?+fFU5zTNQFWDJdjU/B+JDYxFCmBlQyF5iI6xw9twPADmzDknlCb+OWftZ4/d?=
 =?us-ascii?Q?Wsf+8k6MLVcsda4SAxsyPJqU1x5wWoJ/Vdj4gOQo9n9k+/UXYQTuuZAR+MC7?=
 =?us-ascii?Q?GumOvFUJX3ostLxRY/6dp18KIIHzqGcv2255bYRSuw2DKYomwA/yMQR+4R6q?=
 =?us-ascii?Q?26DWDrMZMLO5ONooagWvef1WWJa1hNhXT2oHo7VhRxBpUmYC0bQWERNzmgib?=
 =?us-ascii?Q?JQb625drU3/2OicaZK+l9JwWeXLF980DxnnvZH4MEt4z916KDK/5ySVJMxWI?=
 =?us-ascii?Q?nRINxBkIUOkNRt/qtzYGm6SqqZ9C2a3KxeDRvJQQehkIkjFuc27CRiVw48om?=
 =?us-ascii?Q?Fogbxuo3pXpgOlAJwdeMPTBy3rJBRU3Rb4FCGhdpEPSEmQn+J6/Vok/AfUQq?=
 =?us-ascii?Q?8ay9aUPy5tJvmqT4pWLHoMxqX3JY4E1Q2vt3Bz86NM3s5yP3tE2MHorWIYjX?=
 =?us-ascii?Q?zDtmmlAZ4R3pkelpTI9HNsHTNwmi80C7653jJcSpJA5ALoZZ932IcwWPgXal?=
 =?us-ascii?Q?NlVfnGqbdQ2/i67HBgea3sGuwDMYBN7rWFnD6ipxdSDIEx3A5zdqr0/KQ6G3?=
 =?us-ascii?Q?tTKaarg6afenD9qXGoozSLoQfSr3rl2+sItaTir0kI3DPGrtBbKgskgwK/1G?=
 =?us-ascii?Q?8jQFxE3gVE2ikvpX3RauHKdM+GqS/uDnkxTlk+IwOq8Pujc/3u5MGK7ZU3Mf?=
 =?us-ascii?Q?iaKaAkPsPxIAzUlyrmtugDBTb3kbDohzpGGgaOcxh2UWl4dSqyo+/fR2sT4e?=
 =?us-ascii?Q?BnzL6Qs6rBHhu1jey+oglxMgL/xrNQvJg+frJFzKdXrdlfA7SugGhALz20Qu?=
 =?us-ascii?Q?nkU26XyVUF/JPlgON4OivVimcMaircmZbe7rJw1uj+rY781BncjsXh9AQgGz?=
 =?us-ascii?Q?GFbA2/9XKJR9uVn0N/VszA7CRf9Ol5PIhGeQ8MhTkhzbdfa36aYRii/QihDW?=
 =?us-ascii?Q?CDYfmrqzJAKROMNOKgM+L9Whj/85enwG5E6t1/6A4RNzHt2Dx3CzccXJNCvU?=
 =?us-ascii?Q?e3RKAG6AL5hbbKgDfEeIOslYyCIDgTJSASEYhGsRGDH2titoCR9f7EusjRSs?=
 =?us-ascii?Q?XjFFXYUjC4W4SsOJv+RwEDlSDIxi3cI2TMoltrF+09pjtc+Z04o7UzHw+wi0?=
 =?us-ascii?Q?qqRE2Nfls1vhLVSdGODC65hC2TBz/4+XROp+JBp1Udc5lhsw07zyYN9YSiA4?=
 =?us-ascii?Q?OG1ePel2fSBOt+jrCOMiyW2TkZyLRB0MiRMlK0jlQf8Nf31x1r1nN7hY9YRS?=
 =?us-ascii?Q?hXyimjuAYwyJyyZccTtY86VJWSNCPbOUvpKSptORj6HY4aErjU/Ow4pUE3pC?=
 =?us-ascii?Q?N+/ZwYr4M01J4phBPFbffdSEWaAsz9Fc+PP5KXcRpupQ9nEZ5lagXyuaqwV4?=
 =?us-ascii?Q?cnH2LenP6ZeELqz03iedNjiiKQZsGnY+bgWRlrunPU/9ix5BmeKLSvks1KtQ?=
 =?us-ascii?Q?b2RTmIWms4iFMDsoAHA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 11:22:03.9933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae43c80-7a07-4c89-cbe5-08de275ddddb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397

Convert all imports in the devres to use "kernel vertical" style. Drop
unnecessary imports covered by prelude::*.

Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/devres.rs | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index e01e0d36702d..659f513a72a6 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -8,13 +8,28 @@
 use crate::{
     alloc::Flags,
     bindings,
-    device::{Bound, Device},
-    error::{to_result, Error, Result},
-    ffi::c_void,
+    device::{
+        Bound,
+        Device, //
+    },
+    error::{
+        to_result, //
+    },
     prelude::*,
-    revocable::{Revocable, RevocableGuard},
-    sync::{aref::ARef, rcu, Completion},
-    types::{ForeignOwnable, Opaque, ScopeGuard},
+    revocable::{
+        Revocable,
+        RevocableGuard, //
+    },
+    sync::{
+        aref::ARef,
+        rcu,
+        Completion, //
+    },
+    types::{
+        ForeignOwnable,
+        Opaque,
+        ScopeGuard, //
+    },
 };
 
 use pin_init::Wrapper;
@@ -241,8 +256,12 @@ pub fn device(&self) -> &Device {
     /// # Examples
     ///
     /// ```no_run
-    /// # #![cfg(CONFIG_PCI)]
-    /// # use kernel::{device::Core, devres::Devres, pci};
+    /// #![cfg(CONFIG_PCI)]
+    /// use kernel::{
+    ///     device::Core,
+    ///     devres::Devres,
+    ///     pci, //
+    /// };
     ///
     /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x4>>) -> Result {
     ///     let bar = devres.access(dev.as_ref())?;
@@ -345,7 +364,13 @@ fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
 /// # Examples
 ///
 /// ```no_run
-/// use kernel::{device::{Bound, Device}, devres};
+/// use kernel::{
+///     device::{
+///         Bound,
+///         Device, //
+///     },
+///     devres, //
+/// };
 ///
 /// /// Registration of e.g. a class device, IRQ, etc.
 /// struct Registration;
-- 
2.51.0


