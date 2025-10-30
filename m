Return-Path: <linux-pci+bounces-39827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2930C210BD
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 16:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD91A4EBB1E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FC3365D31;
	Thu, 30 Oct 2025 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mSAbFr8+"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763093655C8;
	Thu, 30 Oct 2025 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839353; cv=fail; b=k/zPo4fawm/bSSi4a9wI7E/OuGZg/QW2i0b0DVAH3XJU23jkgFYEfbT+m/YnkC9WUGsuzUYdh1FQAVoo+Dr2dkShxmF8EH6F52akkqv+vG8x2kIWoKzufmVQNcI1NXqYhnuJqpt+2Z9GCPJ0MCP4+VIoPsAMHgLwmuvXmRlkmok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839353; c=relaxed/simple;
	bh=rRhHGCQ1kstpOWr/xxbJbK6KRnjpWobRGKP7Nvn42mQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsRTC03UFuN/I/FOFm+HpsvW0Ci8ZunirExfB7y/S7ecRwOtr7b4MXWNMuMezg2D6rVDiQWC/ckx2RuxyeXgELaHt8TSXdx9M4t98LWeW8ShXK8AUsVNctHt8FfWrCs7eNfeUbyKQV2n0UyjyG3IKsLSrZMxeRdhnNQuA8I03S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mSAbFr8+; arc=fail smtp.client-ip=52.101.85.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OW6DW0h0DMdvIyN7uzD/1uEhKmgBBdWuS9rSSpAA2bTnWPE9QcOau+zeuY7QUwHWEfEXXP3nNUgfiJzVIexxTc2dGXkOKAEhmiMypwfm6s78yY8Euelo6lKF35NT8GJq/BhXUOi4jyFqH5kEu4Gnlohx9zOolZiJnzxv9QaoCoxqJ8mxneTy+1F+O8qwXGiG/71CW/raI6/82av+WIZGFZAqWPZOEYryA18UK1ivclsQfUog8U/88HaOYq4IGKPfyO3BuaorTdW1ibi2Zd5/KLdD70R3fdl2OXPl2yu6bZk1EHuD8xujC/EhOKD5HLoQW0FjagkAM9jHFRP/obksqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RaAPirYXPHG/YiaMjCt5+7rzl+2l5kGFT7D7fJe6Gc=;
 b=U0BQwSHMTyeafVwLINLNa7qHFk81mM/Vw00Oe/8qPVdxxIGTpMosNSJSsmRrKK2NxHH8ZQxjUyRFLYJuaarTU6c8KggXE4UCHwJq37NuFKW2fkP0KxMP9tI8sXdZvHx+RN+F+/Iw1DsenoV4Oc5nkt0DYEQ/mPOsgv47j+Q6s/dER9urkKBYx5t+SHuxHVmYE8KPDN3qKYOV2m2YG5ISAEcf7PtIwdg9rfqztkx1XcyWfgkb+I5QyuWzi5SnVWstEEdzz7ghdKux8ebzFACUyX4U3HQzIYAwHWS8p6oo5PWSa1LineYuLwyQX/KA5VK+NiHPXOHYv21Touazmz5fOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RaAPirYXPHG/YiaMjCt5+7rzl+2l5kGFT7D7fJe6Gc=;
 b=mSAbFr8+/0zDjgWbuPDLSNJe9GKEMGo9ZdaXbpkLgSssVEujLatbt6IZ5rTHi8hjUVgOQxk2d0lLYtKHRu1roEo2zuVJ05bX03BgJbL72HS62/L8vhxvl8FmPkdb7+TqUcnv9m76vRyr1CzYrwKK6ug5e1uCKaGSreOSGfU+5ql4XgEqD2eGQCAqwj4IrDw7zcwqT3ZO/Xs18U0M2o1REkvi/bvFSfr1lV1KxinW3oUwUibmMF+oUxGayDNw7n/FNmq8JzEcYtePP1T1oMide2S4zsnFuy8E+Bouv8sXu62S6Dh9wXq3EEn6IoUxxxpfqOMQrp+Tc/e6rYMDgSY2dg==
Received: from DS2PEPF0000455A.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::513) by DS7PR12MB5864.namprd12.prod.outlook.com
 (2603:10b6:8:7b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 15:49:05 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:8) by DS2PEPF0000455A.outlook.office365.com
 (2603:10b6:f:fc00::513) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.5 via Frontend Transport; Thu,
 30 Oct 2025 15:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 15:49:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 08:48:46 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 30 Oct 2025 08:48:46 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 30 Oct 2025 08:48:46 -0700
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
Subject: [PATCH v3 2/5] rust: io: factor out MMIO read/write macros
Date: Thu, 30 Oct 2025 15:48:39 +0000
Message-ID: <20251030154842.450518-3-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: e058283e-cf73-457d-8ec7-08de17cbdb5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WYDcpIK5gm2DHRo/Kc0IL0CqJmZtlGYCRx2QcBQ+c/Yem+5aQvZiAtQk1m5h?=
 =?us-ascii?Q?lrS8hPxd/2WUv3gfadhV3EBnF5T6hRWDb4Ht1s0grhnTT+6pm86Id9jFbW1E?=
 =?us-ascii?Q?5uZ1RMyddYfII2p/64v31+8zpTkJpEr1PWNACVh5qShBVGMnYsw7ttC7oVNf?=
 =?us-ascii?Q?avCxaKzUJ342qFMfsE3Ge28pgJwy7nI5AxI6v1eM6i2/9x9TQN4nGBAatqnn?=
 =?us-ascii?Q?U+h1JGF2DApZDPLtfkJimi384C+MJ0STuAPydO1QMBEb6LwcurKQZ4pRLNI/?=
 =?us-ascii?Q?qZXCm8lcrTg8uJGD1UwhE3fplttIizEg4UX4woPSR9vtP0k+RPhmkWs6GU+v?=
 =?us-ascii?Q?QaRhm9bkcUqWWY/7U9fteDXiW2kW8Hi6V5gL0A6bXR3JlGS+jvg61WuPkctT?=
 =?us-ascii?Q?1DmwucgmG3aNcmz0nTAoFdp+BpcALAWqKmlioqeMhiiSOkuWts6VBU2rqmwE?=
 =?us-ascii?Q?3heHniuZGgFoWxI6A9djzU+n7NqnTtlInh6HfXQu04jyv6cFJtBNTr4BaP4h?=
 =?us-ascii?Q?STu0pnIc9mBlAu754dfsXe+7J5lYl+vXJmqXAO57AJGWMIABs1hL5uyehujY?=
 =?us-ascii?Q?2IXCpUnxr5PTpKNhPDAmKQCxO4b148e7aIblV128uAQbqKzTMHPSxCS7xLf7?=
 =?us-ascii?Q?vG+bLp4E0Vcc4CbLilh07zz3Ki4u7D+ZHW8Yjyybpm5eM6GBeCHXFB+PaybI?=
 =?us-ascii?Q?t2OhjiA1NZHaLmvWN9ygfA1Xnut/40HyHiaf/9d3m+Fb0Xx0gp+COMFzh3WN?=
 =?us-ascii?Q?DxmFP+iD6SJX0/KyZXw62zOMaPhLcAtTB/w0GBvd74PIIwwYUr8RWgCMAb1S?=
 =?us-ascii?Q?7Kfmlb4w72458/ATz6dnG/wxt60K7KzJqbMFgp3cAC77IYbjUQq2qIk4YEXk?=
 =?us-ascii?Q?cN4ejWTblTqdipi49ABiSjriiAK1nKK3/qARqGzwdy+2aTlP+VpinGLKRIZ7?=
 =?us-ascii?Q?eAQc55ZljMZJt2IYdbigiIVQasciDoZi+q+MK5IGvj/czT4e62pkUbOHqQo9?=
 =?us-ascii?Q?ZbvLZ4f1x1MiWW1qfNqgxcJFqX7TC0/HEZaaEM2EMkJe+l5htUo35UfnSuVL?=
 =?us-ascii?Q?31GkFAJtOCGtvqf1npzi2HeQaxKKCi+09G4kLliyiVK8sjUU3rD6sH61c+lA?=
 =?us-ascii?Q?NwDkjQMjd/Onbf8An8dRK3fUsXBYR3dHaSP5fhRIqt2T0QmlU+m81Io4XYa5?=
 =?us-ascii?Q?tnvCkBtQZtpiPg4nMjx7v4YnD5qCShtsEtYnUfXPR2mCvcOKnPiEDR2ZVuSb?=
 =?us-ascii?Q?+/FfcuISNc3l7xPSrTMnyUuuWCJNszOR67X40Gyvtu8XkwdG+uc1soww/I1N?=
 =?us-ascii?Q?laNndWQ4N7t/238OEJQSQ0//bw7r8j1TTyLUKiLLhe3huOZk94MLfhGIXa6V?=
 =?us-ascii?Q?qN1u67zgdYX3OOywbeNtEdb0C0XOETVWLmmyoUw51bTfDWgOiGVax03RjIdb?=
 =?us-ascii?Q?5HT+ajpggHlHonbOpIxPhhulyryn9I3s9j+FNYMl4BH6abLr00QqITHhm63e?=
 =?us-ascii?Q?4eAXCu1NHxFevJsmdj0l9kPtZ5GM/EM4FVEH8NMJvT4A4+PSttt3EfDXAbZu?=
 =?us-ascii?Q?BveWnLEJvM3l5OfHfpQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:49:05.7845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e058283e-cf73-457d-8ec7-08de17cbdb5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864

Refactor the existing MMIO accessors to use common call macros
instead of inlining the bindings calls in each `define_{read,write}!`
expansion.

This factoring separates the common offset/bounds checks from the
low-level call pattern, making it easier to add additional I/O accessor
families.

No functional change intended.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/io.rs | 110 ++++++++++++++++++++++++++++++----------------
 1 file changed, 73 insertions(+), 37 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 0b48edabf39a..ded0f4ecf2ad 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -113,8 +113,34 @@ pub fn maxsize(&self) -> usize {
 #[repr(transparent)]
 pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
 
+macro_rules! call_mmio_read {
+    (infallible, $c_fn:ident, $self:ident, $type:ty, $addr:expr) => {
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($addr as *const c_void) as $type }
+    };
+
+    (fallible, $c_fn:ident, $self:ident, $type:ty, $addr:expr) => {{
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        Ok(unsafe { bindings::$c_fn($addr as *const c_void) as $type })
+    }};
+}
+
+macro_rules! call_mmio_write {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($value, $addr as *mut c_void) }
+    };
+
+    (fallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {{
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($value, $addr as *mut c_void) };
+        Ok(())
+    }};
+}
+
 macro_rules! define_read {
-    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident -> $type_name:ty) => {
+    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident, $c_fn:ident ->
+     $type_name:ty) => {
         /// Read IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -124,12 +150,13 @@ macro_rules! define_read {
         $vis fn $name(&self, offset: usize) -> $type_name {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(addr as *const c_void) }
+            // SAFETY: By the type invariant `addr` is a valid address for IO operations.
+            $call_macro!(infallible, $c_fn, self, $type_name, addr)
         }
     };
 
-    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $c_fn:ident -> $type_name:ty) => {
+    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $call_macro:ident, $c_fn:ident ->
+     $type_name:ty) => {
         /// Read IO data from a given offset.
         ///
         /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
@@ -138,14 +165,16 @@ macro_rules! define_read {
         $vis fn $try_name(&self, offset: usize) -> Result<$type_name> {
             let addr = self.io_addr::<$type_name>(offset)?;
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            Ok(unsafe { bindings::$c_fn(addr as *const c_void) })
+            // SAFETY: By the type invariant `addr` is a valid address for IO operations.
+            $call_macro!(fallible, $c_fn, self, $type_name, addr)
         }
     };
 }
+pub(crate) use define_read;
 
 macro_rules! define_write {
-    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident <- $type_name:ty) => {
+    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident, $c_fn:ident <-
+     $type_name:ty) => {
         /// Write IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -155,12 +184,12 @@ macro_rules! define_write {
         $vis fn $name(&self, value: $type_name, offset: usize) {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
+            $call_macro!(infallible, $c_fn, self, $type_name, addr, value);
         }
     };
 
-    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $c_fn:ident <- $type_name:ty) => {
+    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $call_macro:ident, $c_fn:ident <-
+     $type_name:ty) => {
         /// Write IO data from a given offset.
         ///
         /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
@@ -169,12 +198,11 @@ macro_rules! define_write {
         $vis fn $try_name(&self, value: $type_name, offset: usize) -> Result {
             let addr = self.io_addr::<$type_name>(offset)?;
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
-            Ok(())
+            $call_macro!(fallible, $c_fn, self, $type_name, addr, value)
         }
     };
 }
+pub(crate) use define_write;
 
 /// Checks whether an access of type `U` at the given `offset`
 /// is valid within this region.
@@ -316,43 +344,47 @@ fn maxsize(&self) -> usize {
         self.0.maxsize()
     }
 
-    define_read!(infallible, read8, readb -> u8);
-    define_read!(infallible, read16, readw -> u16);
-    define_read!(infallible, read32, readl -> u32);
+    define_read!(infallible, read8, call_mmio_read, readb -> u8);
+    define_read!(infallible, read16, call_mmio_read, readw -> u16);
+    define_read!(infallible, read32, call_mmio_read, readl -> u32);
     define_read!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         read64,
+        call_mmio_read,
         readq -> u64
     );
 
-    define_read!(fallible, try_read8, readb -> u8);
-    define_read!(fallible, try_read16, readw -> u16);
-    define_read!(fallible, try_read32, readl -> u32);
+    define_read!(fallible, try_read8, call_mmio_read, readb -> u8);
+    define_read!(fallible, try_read16, call_mmio_read, readw -> u16);
+    define_read!(fallible, try_read32, call_mmio_read, readl -> u32);
     define_read!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         try_read64,
+        call_mmio_read,
         readq -> u64
     );
 
-    define_write!(infallible, write8, writeb <- u8);
-    define_write!(infallible, write16, writew <- u16);
-    define_write!(infallible, write32, writel <- u32);
+    define_write!(infallible, write8, call_mmio_write, writeb <- u8);
+    define_write!(infallible, write16, call_mmio_write, writew <- u16);
+    define_write!(infallible, write32, call_mmio_write, writel <- u32);
     define_write!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         write64,
+        call_mmio_write,
         writeq <- u64
     );
 
-    define_write!(fallible, try_write8, writeb <- u8);
-    define_write!(fallible, try_write16, writew <- u16);
-    define_write!(fallible, try_write32, writel <- u32);
+    define_write!(fallible, try_write8, call_mmio_write, writeb <- u8);
+    define_write!(fallible, try_write16, call_mmio_write, writew <- u16);
+    define_write!(fallible, try_write32, call_mmio_write, writel <- u32);
     define_write!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         try_write64,
+        call_mmio_write,
         writeq <- u64
     );
 }
@@ -369,43 +401,47 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
 
-    define_read!(infallible, pub read8_relaxed, readb_relaxed -> u8);
-    define_read!(infallible, pub read16_relaxed, readw_relaxed -> u16);
-    define_read!(infallible, pub read32_relaxed, readl_relaxed -> u32);
+    define_read!(infallible, pub read8_relaxed, call_mmio_read, readb_relaxed -> u8);
+    define_read!(infallible, pub read16_relaxed, call_mmio_read, readw_relaxed -> u16);
+    define_read!(infallible, pub read32_relaxed, call_mmio_read, readl_relaxed -> u32);
     define_read!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         pub read64_relaxed,
+        call_mmio_read,
         readq_relaxed -> u64
     );
 
-    define_read!(fallible, pub try_read8_relaxed, readb_relaxed -> u8);
-    define_read!(fallible, pub try_read16_relaxed, readw_relaxed -> u16);
-    define_read!(fallible, pub try_read32_relaxed, readl_relaxed -> u32);
+    define_read!(fallible, pub try_read8_relaxed, call_mmio_read, readb_relaxed -> u8);
+    define_read!(fallible, pub try_read16_relaxed, call_mmio_read, readw_relaxed -> u16);
+    define_read!(fallible, pub try_read32_relaxed, call_mmio_read, readl_relaxed -> u32);
     define_read!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         pub try_read64_relaxed,
+        call_mmio_read,
         readq_relaxed -> u64
     );
 
-    define_write!(infallible, pub write8_relaxed, writeb_relaxed <- u8);
-    define_write!(infallible, pub write16_relaxed, writew_relaxed <- u16);
-    define_write!(infallible, pub write32_relaxed, writel_relaxed <- u32);
+    define_write!(infallible, pub write8_relaxed, call_mmio_write, writeb_relaxed <- u8);
+    define_write!(infallible, pub write16_relaxed, call_mmio_write, writew_relaxed <- u16);
+    define_write!(infallible, pub write32_relaxed, call_mmio_write, writel_relaxed <- u32);
     define_write!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         pub write64_relaxed,
+        call_mmio_write,
         writeq_relaxed <- u64
     );
 
-    define_write!(fallible, pub try_write8_relaxed, writeb_relaxed <- u8);
-    define_write!(fallible, pub try_write16_relaxed, writew_relaxed <- u16);
-    define_write!(fallible, pub try_write32_relaxed, writel_relaxed <- u32);
+    define_write!(fallible, pub try_write8_relaxed, call_mmio_write, writeb_relaxed <- u8);
+    define_write!(fallible, pub try_write16_relaxed, call_mmio_write, writew_relaxed <- u16);
+    define_write!(fallible, pub try_write32_relaxed, call_mmio_write, writel_relaxed <- u32);
     define_write!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         pub try_write64_relaxed,
+        call_mmio_write,
         writeq_relaxed <- u64
     );
 }
-- 
2.47.3


