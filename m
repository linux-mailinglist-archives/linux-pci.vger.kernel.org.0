Return-Path: <linux-pci+bounces-40214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA29EC31860
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 15:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EF71897527
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C2932F75C;
	Tue,  4 Nov 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DYm4IwC9"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450F33030D;
	Tue,  4 Nov 2025 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266517; cv=fail; b=H39RXbjKWW4AoJ0+57pzc6nVaICzlSN5T5mwgetCEIMJx25VuRLvi4YQpmfSuApM/LcoxVOwHbnud3to35CguT2N6BGUv6UWujVyUX+gSAFqe+N3LIw0o+i7yrNDeevG1DY/ysPgfdvzkBfTadW4oRGxqkTsgCml9yIQI98l4qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266517; c=relaxed/simple;
	bh=o/EMmpr1MqI2Ed/QxuGr9VYBhL+0NOKmRReM40dQkY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpJLDH7Kc89Y7YShr7eUpxB6t/+aT79Wot7grzy6WrMwoVQYnTw65RV/7Lf3APqdo68Y+LzwPbigMTiOsAmkob+b+nU4/hCTbDB+sE1/Z+VMLD9y7RGJruRsqU/UgqylhFyb28DYkn8/MMWStxEtkERk5IYZO2iEK5/byFh6naY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DYm4IwC9; arc=fail smtp.client-ip=52.101.46.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDzxsqsg3gCoeEaL4xu6FT2EM3tkk7JChOXwVPv8G9gHNWG2l8LjSlEjvqVGCrYW6clNdy0kg/OY0h0FL6MiR5rAZGAfx6mf6CR3/2pd8Z2jpuso7UN/HPxBoCCgEM9o97gx2azKFKoBizEqgb69P3QVtwZrUkwNmbdZdW/2HKsUWZYqTXGljJNcCtSIGKmCSuaGau9HjtmKZW/xoE2mLaYDNClHu3macPMw/FpP248gA32Tkn3B04o1JW+jvUShb58ZUlah2/GAFNzk+WeOiPa6+BsiK49rcxmH6eT3FwRCof9UhGC5gVCAgSMzquWkhXu37jGBKMjmiEWMN4S4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mi6tkXYQO2Q+QmIdVXJW8I9E5uzjshhB+ggO5nmjabU=;
 b=N2SZAf+2l0wNxKGwBZlWjiH26TnUIyLPeQVVl0wMuKfIdOKz/WfRya94chOXKRDj75U8QMe7wxeihwpbjE54zqFJ55EBYT6H4hKrm61y2tAw9u6TMbB2R+a3n219U7JsOqGY6ZTIpsgExniPu0Vg+3pXrSlgkhwA1NB4Hz9AImEE4XP9/A0TLx+KLR9ij6TU+AM1PrP6L1NcAJqPpczYxhOTilsG3qxTOrVKMTz6NxwyXbBmqzeYSoiUsMAHYzg7ALG0twOH50uX/+b5j5etcmZPHIQJUi9RhzIIefgTshULexM6ZYhQtRso7wUNTIuMjgF/EEW4NTTn1snM/a5tKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mi6tkXYQO2Q+QmIdVXJW8I9E5uzjshhB+ggO5nmjabU=;
 b=DYm4IwC9PFW4RRBtwIM+s+OjxoDHNgG3k2ZOC3tFhI1QIvsdRFXU0wSxYNx59+dNz0vbRAg1GmjFfYRbdENHj9CQ8ArCzdtH4Q/B9hoK2yuWwGQFI6IUF8OuRFwm8LohQ8Nf2ff6HkeBrwhDFAD6RJcYxOUvXSNSziGylTkpOMPeXhSZqkfpbdgCdPvIyD8TiWzzgcnQNy36aJClnHWwl1LWGmoNmEv81NRSAxRImdpVgYYxZi7L0sx5ZEV2XC4HJ/vRTPIC5BDeHbdPPPc/q8vIPgqYVCfD+ETxT88sdhjpD0SAC5GX+K/Jx56h6Sk0VuxwVBjbHbEgcNPb/Q75PQ==
Received: from BN9P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::29)
 by MW4PR12MB7190.namprd12.prod.outlook.com (2603:10b6:303:225::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Tue, 4 Nov
 2025 14:28:31 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::96) by BN9P221CA0030.outlook.office365.com
 (2603:10b6:408:10a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 14:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:28:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:28:15 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 4 Nov 2025 06:28:14 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 06:28:05 -0800
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
Subject: [PATCH RESEND v4 2/4] rust: io: factor out MMIO read/write macros
Date: Tue, 4 Nov 2025 16:27:31 +0200
Message-ID: <20251104142733.5334-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104142733.5334-1-zhiw@nvidia.com>
References: <20251104142733.5334-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|MW4PR12MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 89468016-6724-472e-9556-08de1bae6d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?621Y6k2OFl3zFAY/gn5Gr7STx5gszG+Pr+CpZOIPiKzUq+RkYaQ42tBKhEL4?=
 =?us-ascii?Q?dFZsA4ILr1H2gA9oilqT8YYN7vnClclLkC70ngR+W4Rzx33jQOzd2X6XpIb6?=
 =?us-ascii?Q?VMhaBTKcXDXohj2ziehLcWSDDzrurUC9i4l6NtmY/8+CdGYSLFAzdLwkergb?=
 =?us-ascii?Q?9AuXYfUFK+L/YPkS5/npxe4fURsR841SDk+kIARhe7+twyw7dbVTT1a7pUEu?=
 =?us-ascii?Q?Y6o/2YLA9Yg5MQEpxwtnmTLKTahxKku1vQ8hgme8myzXui5c9Q4vDV70EFBh?=
 =?us-ascii?Q?SZ9taleHY4ajfZBj+3hYNtco8FrPmt5m7lfExOhIari6H69Rpn/YRWvDIlmh?=
 =?us-ascii?Q?b+8HW1vPXluuRq36JjF0coby2YWLcAdHGMhe+HDRZPStuJEBVintSFd39K78?=
 =?us-ascii?Q?61PoU2VJmZIZotUSw9h6TvAmLak5xLNRWSCra/B3dCdX4MePWHWRY5CqC76n?=
 =?us-ascii?Q?LXIl2o7YW53BOyhNzz/VkDjjbAhMiIf5Od2svqY3PmMhKA2d8ykWwzoH/oib?=
 =?us-ascii?Q?HixiL5y2K5XtFaBAMKAa8KU+T5yxSKoY3YkLXVMxBh8A4i6eijHw8Eyi1QXG?=
 =?us-ascii?Q?U0HezLtNND9rVxP1lr0L0OV+hVzrar+n3krLyiZkgGYPV/Iob8YBunFuEPal?=
 =?us-ascii?Q?q3mS41ZJ8ryiA2dIusKZLi4WXXm+kJN4yXi0jEWaA4thKTWhlbuQT1q5eMT2?=
 =?us-ascii?Q?ktazxsUDUdqRrW/i3QM1hfmdBTPPRFS6iPeem0DXQFK+rsv4l6PuPNJ+in+D?=
 =?us-ascii?Q?b75pvQcXs67ofc4r1hipfj86jqE9ep+ElHA3oYBF9bgMdJnn7zNkNEXaekXb?=
 =?us-ascii?Q?GAdDZ/UQ1jfrwE2y4FVaxf8ls1tfdxeEEQ97YX0+1awArEzHACa3/OPnvG/l?=
 =?us-ascii?Q?b/U4Q26bdtsF9+U2I7kZzf0qyHev6+NvSMnNrJmm3qRLuSzIQuEg6N9ejMs7?=
 =?us-ascii?Q?h/W2MxRgvncwr3PiE0dcGtgYYnEOYNlYtDXBDVxgEXGKXVmipcXyiCFldg3I?=
 =?us-ascii?Q?GfJg0Gyg10fEw3XMWDYjBMv9Dm0P6w89eRosTY6ekW8L0jyw1Qrr/BqRKJju?=
 =?us-ascii?Q?4BNpnAKYRFKM3hKxklrkhKIpcCSVv/jEZZSc/0XNoTgWwrYA5HS+gvVjHCDJ?=
 =?us-ascii?Q?/V+cPpS9scVzdCJP5D02+DHSrskYHgOrUh8SQSStNzIzmhO3HfLQ91YUTPvb?=
 =?us-ascii?Q?9y59Ty5k78qXLCme7sERJXmorrbnfRPkSFD9it2cjXInkNGJPf1IfDGISyN+?=
 =?us-ascii?Q?yNUUa0Y7qZdQAU8awXfbZE7Wn8DWJoaZt8Em+YzmFbIBcT7iPU3GoX3pwzAQ?=
 =?us-ascii?Q?TELFP6WraR92+PSAtRD/1zE1wNdz+Az21xGiPbmbq7xiNHlk4BUmV4UrcqeO?=
 =?us-ascii?Q?G85Vmkw02VHZrxcT4Lkbhfvi3HUfaqBMB5idL2tCl9h5oSM0W7DJfPT5KNx6?=
 =?us-ascii?Q?uwA4JVT2McKLkHRuqCQ1WaeEIVmWvC4YcozFB27TwogHgyK/EY4kopuMuZVH?=
 =?us-ascii?Q?hjyTgL5SENmPsAH5rMQtJwGG3UJ8jyR4gf3gxanYSZUlck8O5WAA85Kbxu4W?=
 =?us-ascii?Q?gYvTi618HSlAYpVyXxc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:28:30.8406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89468016-6724-472e-9556-08de1bae6d98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7190

Refactor the existing MMIO accessors to use common call macros
instead of inlining the bindings calls in each `define_{read,write}!`
expansion.

This factoring separates the common offset/bounds checks from the
low-level call pattern, making it easier to add additional I/O accessor
families.

No functional change intended.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/io.rs | 114 +++++++++++++++++++++++++++++-----------------
 1 file changed, 73 insertions(+), 41 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 0b1e79075c99..2f4206166b86 100644
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
@@ -294,30 +322,30 @@ fn maxsize(&self) -> usize {
         self.0.maxsize()
     }
 
-    define_read!(infallible, read8, readb -> u8);
-    define_read!(infallible, read16, readw -> u16);
-    define_read!(infallible, read32, readl -> u32);
+    define_read!(infallible, read8, call_mmio_read, readb -> u8);
+    define_read!(infallible, read16, call_mmio_read, readw -> u16);
+    define_read!(infallible, read32, call_mmio_read, readl -> u32);
 
-    define_read!(fallible, try_read8, readb -> u8);
-    define_read!(fallible, try_read16, readw -> u16);
-    define_read!(fallible, try_read32, readl -> u32);
+    define_read!(fallible, try_read8, call_mmio_read, readb -> u8);
+    define_read!(fallible, try_read16, call_mmio_read, readw -> u16);
+    define_read!(fallible, try_read32, call_mmio_read, readl -> u32);
 
-    define_write!(infallible, write8, writeb <- u8);
-    define_write!(infallible, write16, writew <- u16);
-    define_write!(infallible, write32, writel <- u32);
+    define_write!(infallible, write8, call_mmio_write, writeb <- u8);
+    define_write!(infallible, write16, call_mmio_write, writew <- u16);
+    define_write!(infallible, write32, call_mmio_write, writel <- u32);
 
-    define_write!(fallible, try_write8, writeb <- u8);
-    define_write!(fallible, try_write16, writew <- u16);
-    define_write!(fallible, try_write32, writel <- u32);
+    define_write!(fallible, try_write8, call_mmio_write, writeb <- u8);
+    define_write!(fallible, try_write16, call_mmio_write, writew <- u16);
+    define_write!(fallible, try_write32, call_mmio_write, writel <- u32);
 }
 
 #[cfg(CONFIG_64BIT)]
 impl<const SIZE: usize> Io64 for Mmio<SIZE> {
-    define_read!(infallible, read64, readq -> u64);
-    define_read!(fallible, try_read64, readq -> u64);
+    define_read!(infallible, read64, call_mmio_read, readq -> u64);
+    define_read!(fallible, try_read64, call_mmio_read, readq -> u64);
 
-    define_write!(infallible, write64, writeq <- u64);
-    define_write!(fallible, try_write64, writeq <- u64);
+    define_write!(infallible, write64, call_mmio_write, writeq <- u64);
+    define_write!(fallible, try_write64, call_mmio_write, writeq <- u64);
 }
 
 impl<const SIZE: usize> Mmio<SIZE> {
@@ -332,43 +360,47 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
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
2.51.0


