Return-Path: <linux-pci+bounces-38402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7159BE5826
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 23:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DC01A67B07
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718A42E7BA5;
	Thu, 16 Oct 2025 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PCbruv1m"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686A22E2DD8;
	Thu, 16 Oct 2025 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648619; cv=fail; b=b1bym0Bs9ZZ8NECI5hS4eET1xtpbR8wlk08qyAfZM8ewx4CC3Jm2gVViDQ23gR+d4Gy0XXsRW+xOBRAE04eqApI8plZscb7TQwWlNvtyVZkycpwaLT8v+AoUdEgxhkX9CbzogOEFsqfZf4qd5zV+fV8EvL1dgm0yeIY8bZwchc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648619; c=relaxed/simple;
	bh=J0Tr6dvkV1QfuQlkqC93GFzpPVO7FJoFltnSZ9doRlI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEGvGweUrbIPeUA0pKBtvB5mUF/ewj4l2LE8A63yFI6Dee229XN7Cn9vTf9r47ak3bpc27UDHfqO8n6KugCUJNNLsrVBUFIh6/W320H9Lj44Rp5+Vu6zHGc5nD6Nnqyp5SjJHDLbL72nOyFn0R6hiS5nPGEio2ezg4YM7pvyeSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PCbruv1m; arc=fail smtp.client-ip=52.101.52.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFHqyNpI6/MSuL63tOViji3J+kL2tNiStrq7/2v3scToGDjNhbsphS7y+HiuyXRvNl1VecDV6iCqi0+tsfgxIQ0GQFE+qJep4karPUIL22yqrRUPgxK1alQVz/1ysHlC43iNok58yqW8XV8OuFmViyTG/Wn36TtzwJK9X8RjmxaB9vZg/9zx5K4HD/WMH9P7aENPFBs0x1QbRpRcAIGqKHQJ5qEmiu2Ju0zy2YOzmAtSBgirAgt1qpvF7uKkzqvXan7HtZlayd5DOgo9uH2HYuMe9/bHqLKyyCuN2YgwnQwlVqfp7kHdmN8GufxYc1lAQmJpjePsa8GHZPL1rc/RFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5gUPtD3a9XLuOgIC1FLs9AMdHzyJgPl6G87uAG6c48=;
 b=btKOmO/hYd+UuU1NfOe2MT34EpyTUtGOebTIw6T/jcpzG17hx7GahaV9baUbY0ARj7eYA8kjZDnUBPH3uZx47dIq8PtS42rDd/KSuS00uCjbws8izf8avXpIajYbdAmXJv3yVkXf3y4pBRPiSxpckPyEsQv0L3yR1dbBeCYlqCahu94zwQ7qwVX89/a9TJXJMlDgd6/CZc92pX1WgXBN+U1NiL1e20bFpRf+fNWRC8EKJsBTsnU4nu28MK2EmhExH3JJioJzAoT9tp85EUvV7sRYiU6QD069JiIniTjhtv4P1m2kNDhYYfKbvrqa1EOT+LK9NRcnbJa+7dpArkKmbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5gUPtD3a9XLuOgIC1FLs9AMdHzyJgPl6G87uAG6c48=;
 b=PCbruv1m2ek+aJIVcbUWIBA6XS68i7PM28hKiHqG37NLB/3A6pYAIHhAdoLgNErICHnfHDJnMFjg/j4LTIkhxHBrSf3+xnUq3N0fiINpnXGFHbyCH6cvgnQ7lvs7jhHMBHvHxNcjDTnUa8T2MWM1DRZuEevPe13v/EE9sss8fG0ZSxIz+aNqAr2c89vMoZkCxDcJjkkcQKEpB1mOVwuPX60KINQTFaqZG4AqdOa0W1ljtuUfs59QQwyHeLtr3Bt1BUkLDjpBGc2gCBMdAqb+LiflZ4wgyJaqhiu+6mDqSO3s3b83vuGZ8SBprMKioM3GpZsd939KlN97P2zVZUCMdg==
Received: from SJ0PR05CA0139.namprd05.prod.outlook.com (2603:10b6:a03:33d::24)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 21:03:34 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::d7) by SJ0PR05CA0139.outlook.office365.com
 (2603:10b6:a03:33d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Thu,
 16 Oct 2025 21:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 21:03:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 16 Oct
 2025 14:02:58 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 16 Oct 2025 14:02:58 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 16 Oct 2025 14:02:58 -0700
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
Subject: [PATCH v2 2/5] rust: io: factor out MMIO read/write macros
Date: Thu, 16 Oct 2025 21:02:47 +0000
Message-ID: <20251016210250.15932-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016210250.15932-1-zhiw@nvidia.com>
References: <20251016210250.15932-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0bf8f6-8961-4a24-ed91-08de0cf777ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gRP+HVvNxnjTiQ1Hic2QnAa6487fdcr021up6wF5A1Faku0DVkpoahrpl7AP?=
 =?us-ascii?Q?/ydrewKoijqIyYgR+FeBX0m0pASE5bA7T7McfbGF0NPRAqF14QnGJgVWXAne?=
 =?us-ascii?Q?dG7RVcz66Jr5TqlvcqZKNsbzpbNGpt1KfZ94/c8nKpL3Tfhf+w79DkDez5Aq?=
 =?us-ascii?Q?QGM13dY3jvGhSLsHOUPQ74JcXHnKK7rUsRrPCpyDONKNKP8JcfyeZJDVrPr7?=
 =?us-ascii?Q?EDjjXnV8/bGgxWdfoSHBzS0yCQtzG0BJtwEGGy5EpGz8m/JainOIUkqHAUR0?=
 =?us-ascii?Q?OQLr3ius2uzj1Tu1U4h5+0poXCNCfV/ieEwEsfo7savXEL0DOmBkxtjEN5an?=
 =?us-ascii?Q?HI/ULy/Y/HfMhMDttFiF3J7xCqeAu4Vo64x2y4mjKS7qi4iIyT23Z7FRACOD?=
 =?us-ascii?Q?/htqBxJWpnpnu8YWMRPC5My3xVj4CGvOwy9zw05BzlAOuQTy/ruzDxmzc49+?=
 =?us-ascii?Q?FLqaNtHgb5GRnuPLU0f0/n6yujihT7I725a3CPPc/TlLZCug3k6yxprIsduw?=
 =?us-ascii?Q?flwMU9zFe/8wq3Kd+SRLnWbEcP0gqyZ/ibc4jI64MwsNoj8xlKkixkOimmMD?=
 =?us-ascii?Q?pTMzY2/CHBd0i7vQYn0iJCQxf3ao+a3pwz/m9zUe75cGg74EmokBGZUe16a+?=
 =?us-ascii?Q?46SBIWQ55MwVEMGVqGQc8RMGi+EGojhk6JaMpB7R8V+ssmwqi5a8ZCq+kDVo?=
 =?us-ascii?Q?KVMWAeoHh/393xE1EtGT8Ot28++bnZhFJwQr2t0Ctznogd0O06slDIdPZLWg?=
 =?us-ascii?Q?F2Ohx4JleOSifsLcQfqqzXc/nSXl3r1WDyzUfeD5DGD1T6DHsJao0fdQHKTi?=
 =?us-ascii?Q?gAHb0x6o30K5m3JnoAOUD/Bq7wCAzlAlKxrlvvcWmt8k7dcenmKLsSwYVfAo?=
 =?us-ascii?Q?+MaYSDm/a6fpfA7UWTePPU7JZNdSC/1TjrvFbxGxWTnsEqZ/Iasm6WZXaQi/?=
 =?us-ascii?Q?7jnZPbIzTvkKC6/FvV7nMkOCoy3cQSNUFmegdlL6WbCqf5JJlq9TwLDg4Zou?=
 =?us-ascii?Q?0W5L90EyNHI295bFbq9UuADUgQnL0L9fQW5rNx0q2UZiRgSlVFLPi0w2HkLu?=
 =?us-ascii?Q?UEMnFvsFatQCTJ+4DMeiLEmcIOw1iArhHAW/t4bHAzayoB50ECblwbYm+Vou?=
 =?us-ascii?Q?C3OoXXh374qGlQ/8moy6wDMWQhvwcSdqwlQ2091yjGbXNuLMiKXiCKYGv2Y7?=
 =?us-ascii?Q?RKCgTynyFAbIkH8YgyAzNvHj5VVKGwgnMJ0/WjoFd7MAARiC5iJge0WEEgzQ?=
 =?us-ascii?Q?uGiQ0liikZvmF/CpD8mFhtP2ffPDoI+SKIcWDLJdY3FJ47tCKJ3I9MoESuPB?=
 =?us-ascii?Q?TQ7YtwupaWJAfa+kdA4m9o6QPrBv5G9xhlF9PTYYEa1YfuASK/+shf3aEJo/?=
 =?us-ascii?Q?vn6cURijri5mjwq1rtUjzomUUjt3PU+/JNuX6YcB/ffBESu8ci2xkqrmtuEO?=
 =?us-ascii?Q?inKEIyYOov+Ydpv7gnSbHtrOuIvZ0UYbbJJLx2IiZhD20rnE2mh8uBAouupt?=
 =?us-ascii?Q?meOR2e3seBNYRqrpILa5Dl94iBYNDFrIOBGso57bxWZdKkcE1bLx4QftrPQM?=
 =?us-ascii?Q?FX6zyfrt7asS4JPYTVU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 21:03:33.7456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0bf8f6-8961-4a24-ed91-08de0cf777ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190

Refactor the existing MMIO accessors to use common call macros
instead of inlining the bindings calls in each `define_{read,write}!`
expansion.

This factoring separates the common offset/bounds checks from the
low-level call pattern, making it easier to add additional I/O accessor
families.

No functional change intended.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/io.rs | 72 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 78413dc7ffcc..78f7bbc945ad 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -4,6 +4,8 @@
 //!
 //! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
 
+use kernel::error::Error;
+
 use crate::error::{code::EINVAL, Result};
 use crate::{bindings, build_assert, ffi::c_void};
 
@@ -113,8 +115,23 @@ pub fn maxsize(&self) -> usize {
 #[repr(transparent)]
 pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
 
+macro_rules! call_mmio_read {
+    ($c_fn:ident, $self:ident, $offset:expr, $type:ty, $addr:expr) => {
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        Ok::<$type, Error>(unsafe { bindings::$c_fn($addr as *const c_void) as $type })
+    };
+}
+
+macro_rules! call_mmio_write {
+    ($c_fn:ident, $self:ident, $offset:expr, $ty:ty, $addr:expr, $value:expr) => {
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        Ok::<(), Error>(unsafe { bindings::$c_fn($value, $addr as *mut c_void) })
+    };
+}
+
 macro_rules! define_read {
-    ($(#[$attr:meta])* $name:ident, $try_name:ident, $c_fn:ident -> $type_name:ty) => {
+    ($(#[$attr:meta])* $name:ident, $try_name:ident, $call_macro:ident, $c_fn:ident ->
+     $type_name:ty) => {
         /// Read IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -122,10 +139,9 @@ macro_rules! define_read {
         $(#[$attr])*
         #[inline]
         pub fn $name(&self, offset: usize) -> $type_name {
-            let addr = self.io_addr_assert::<$type_name>(offset);
+            let _addr = self.io_addr_assert::<$type_name>(offset);
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(addr as *const c_void) }
+            $call_macro!($c_fn, self, offset, $type_name, _addr).unwrap_or(!0)
         }
 
         /// Read IO data from a given offset.
@@ -134,16 +150,18 @@ pub fn $name(&self, offset: usize) -> $type_name {
         /// out of bounds.
         $(#[$attr])*
         pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
-            let addr = self.io_addr::<$type_name>(offset)?;
+            let _addr = self.io_addr::<$type_name>(offset)?;
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            Ok(unsafe { bindings::$c_fn(addr as *const c_void) })
+            $call_macro!($c_fn, self, offset, $type_name, _addr)
         }
     };
 }
+pub(crate) use define_read;
 
 macro_rules! define_write {
-    ($(#[$attr:meta])* $name:ident, $try_name:ident, $c_fn:ident <- $type_name:ty) => {
+    ($(#[$attr:meta])* $name:ident, $try_name:ident, $call_macro:ident, $c_fn:ident <-
+     $type_name:ty) => {
         /// Write IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -151,10 +169,9 @@ macro_rules! define_write {
         $(#[$attr])*
         #[inline]
         pub fn $name(&self, value: $type_name, offset: usize) {
-            let addr = self.io_addr_assert::<$type_name>(offset);
+            let _addr = self.io_addr_assert::<$type_name>(offset);
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
+            let _ = $call_macro!($c_fn, self, offset, $type_name, _addr, value);
         }
 
         /// Write IO data from a given offset.
@@ -163,14 +180,13 @@ pub fn $name(&self, value: $type_name, offset: usize) {
         /// out of bounds.
         $(#[$attr])*
         pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
-            let addr = self.io_addr::<$type_name>(offset)?;
+            let _addr = self.io_addr::<$type_name>(offset)?;
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
-            Ok(())
+            $call_macro!($c_fn, self, offset, $type_name, _addr, value)
         }
     };
 }
+pub(crate) use define_write;
 
 /// Represents a region of I/O space of a fixed size.
 ///
@@ -247,43 +263,47 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
 
-    define_read!(read8, try_read8, readb -> u8);
-    define_read!(read16, try_read16, readw -> u16);
-    define_read!(read32, try_read32, readl -> u32);
+    define_read!(read8, try_read8, call_mmio_read, readb -> u8);
+    define_read!(read16, try_read16, call_mmio_read, readw -> u16);
+    define_read!(read32, try_read32, call_mmio_read, readl -> u32);
     define_read!(
         #[cfg(CONFIG_64BIT)]
         read64,
         try_read64,
+        call_mmio_read,
         readq -> u64
     );
 
-    define_read!(read8_relaxed, try_read8_relaxed, readb_relaxed -> u8);
-    define_read!(read16_relaxed, try_read16_relaxed, readw_relaxed -> u16);
-    define_read!(read32_relaxed, try_read32_relaxed, readl_relaxed -> u32);
+    define_read!(read8_relaxed, try_read8_relaxed, call_mmio_read, readb_relaxed -> u8);
+    define_read!(read16_relaxed, try_read16_relaxed, call_mmio_read, readw_relaxed -> u16);
+    define_read!(read32_relaxed, try_read32_relaxed, call_mmio_read, readl_relaxed -> u32);
     define_read!(
         #[cfg(CONFIG_64BIT)]
         read64_relaxed,
         try_read64_relaxed,
+        call_mmio_read,
         readq_relaxed -> u64
     );
 
-    define_write!(write8, try_write8, writeb <- u8);
-    define_write!(write16, try_write16, writew <- u16);
-    define_write!(write32, try_write32, writel <- u32);
+    define_write!(write8, try_write8, call_mmio_write, writeb <- u8);
+    define_write!(write16, try_write16, call_mmio_write, writew <- u16);
+    define_write!(write32, try_write32, call_mmio_write, writel <- u32);
     define_write!(
         #[cfg(CONFIG_64BIT)]
         write64,
         try_write64,
+        call_mmio_write,
         writeq <- u64
     );
 
-    define_write!(write8_relaxed, try_write8_relaxed, writeb_relaxed <- u8);
-    define_write!(write16_relaxed, try_write16_relaxed, writew_relaxed <- u16);
-    define_write!(write32_relaxed, try_write32_relaxed, writel_relaxed <- u32);
+    define_write!(write8_relaxed, try_write8_relaxed, call_mmio_write, writeb_relaxed <- u8);
+    define_write!(write16_relaxed, try_write16_relaxed, call_mmio_write, writew_relaxed <- u16);
+    define_write!(write32_relaxed, try_write32_relaxed, call_mmio_write, writel_relaxed <- u32);
     define_write!(
         #[cfg(CONFIG_64BIT)]
         write64_relaxed,
         try_write64_relaxed,
+        call_mmio_write,
         writeq_relaxed <- u64
     );
 }
-- 
2.47.3


