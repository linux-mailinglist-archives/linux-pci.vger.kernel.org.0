Return-Path: <linux-pci+bounces-37794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9633FBCC0FB
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 10:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0D51A64A6F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 08:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2661A28137A;
	Fri, 10 Oct 2025 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WsHEdUSO"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F6027FB31;
	Fri, 10 Oct 2025 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083442; cv=fail; b=ubjWfbUZII46jamuX+CdkjqV3hrR/8D6B9z0sVRpe6UenqWqgbYfUAQRYPVtjFIUBYtgqUwmtq0aa2lEsw+CHsEDiafyTMlx8M0VkbIx+33Ibs20FgH6PUFgDBp8GXYL6463rwK6aONBSKUKdcoral5s6peWpldXDVYVX/g+efs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083442; c=relaxed/simple;
	bh=aJBX7rhjHReB3unZfgi1cghtqPtvrxz99NeKC9MlYlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATzBeTmODCIL+9ypgFFpT7hb16VU2O2JdRNz8u25NClH9k55PoBmFeNQHtfhZYjW2DIHpZ01X9A/QOxxW632nDWy8Sg5smlzs9EyOoF3X9cnYpB0bne74JP2dgVh67+vJQauyd+4L+dqzTdtcJL4biWMfhUHj+rMEykQfULXWcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WsHEdUSO; arc=fail smtp.client-ip=52.101.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIpJN5Tn2q4mEUs+czKWTysh80VJysnxtUkmeMnNPS9A4cj+xPAojNsBsuEjnEpDHd6EWZSVTlvCY6mas+wxU/nIM41S/F8vqSwjaiSbxU7eZ95FDCdYJgiDxMuxoE/xqMNQAbvarZ+PIefgjBda3GmdwO8qqZ7qtDpaHUjSwWvAeDlV0XYFhoey+KuIHA7LLJ/U+mr257qxqbP++zOu6S7gF/jXic6TvU83zgkrMTWS2dEfBaUEER7QnXnoFbd51785VTt9npcX7q/xYgOYGVNwXHLmVaVIQWT+zRChX3vWFcsiLqdMwIjNadgSe9PH4+WSswCy+koTKnh2K1TPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iv9OwkGiglW6Pf/gRQ23fjgXCeHMzY1eAzwKmCs+cUQ=;
 b=APVkSkQ+QQTlb4lrIaCNagr/JWe1cKSSFNeiJ8hD+Kk+zPo0yFoXa/1sdjtO/gR0A+IaD89vgZRM49IDQOCgD528oodVR5j5Un8dNmzlHqrBeRzOP1qxQM0R5PT11njQYHqzZrDLJ1MZQ9gjIc/u95k9isUIRry1vFSPMycI5NfV1tG9Yg9aONVg43PCPO+3pxC2RYTUFyvdCNBvA2jdSbFeRyE+XJMFy2rAXRYiwDWU6ZBVKyDtL+fLNSiletG6tlfMTKuPR07x2/E4/oE37cxQd92DB+zJD+TZb5ppJ0so54JNRiHjyRgszGvOp92fBptPFqqOIKrh/5j8Vtm1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iv9OwkGiglW6Pf/gRQ23fjgXCeHMzY1eAzwKmCs+cUQ=;
 b=WsHEdUSOn6g8poURxsJn1k8wMjfaQOWOjcUQMY8GDSh0R2L/Ali5JNT5OpjkxIhsqEWDF4IvQPrjJaTv5kkYh8nXP5vq7RkhLFUM1x+OAjxodiYXPU8ydejhC/QOJRB7d8rHHrtMh2fC8VCMnzoNJ12j61ITPScJUVCfeH4h/1wieZ5PIurTSQPp9NLyIFL8Ros8vSX7MWMLEpNnCowvBS7E/ldmNenBejuAaw23HSt1LSbzK/+ghxu13v4LFvmvXgf41HSEemrgf2Q1JhF2zj5Js+nea78A9nMCraq0C7a5cH4shucs3LUecljzHvXxD+nEtvNTwG8EQxiAIGYRPQ==
Received: from DS7PR03CA0023.namprd03.prod.outlook.com (2603:10b6:5:3b8::28)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 08:03:53 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::65) by DS7PR03CA0023.outlook.office365.com
 (2603:10b6:5:3b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Fri,
 10 Oct 2025 08:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 08:03:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 10 Oct
 2025 01:03:41 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Oct
 2025 01:03:40 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 10 Oct 2025 01:03:40 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>
CC: <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <zhiwang@kernel.org>
Subject: [RFC 2/6] rust: io: factor out MMIO read/write macros
Date: Fri, 10 Oct 2025 08:03:26 +0000
Message-ID: <20251010080330.183559-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251010080330.183559-1-zhiw@nvidia.com>
References: <20251010080330.183559-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|BY5PR12MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: 17664e80-f31e-430e-e7de-08de07d38da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OX5x5L+xhhmPFRT8mRNmdhIomjwZMpUH9p+WvtY7neLzFKRPFH+F16Fm9GoY?=
 =?us-ascii?Q?earfJ4ICFslfAvmd4Bk/BepgQy+er2xQsDa9OzEwhdBsZab82EPBjKPUyVPN?=
 =?us-ascii?Q?2Eef921pNKZxJsrX7acoyacL4DftELBQwxlNwsAAfODo9kazMUylywTghFfJ?=
 =?us-ascii?Q?H8c9kAKT+hPM4M0hNoIyITNo74j/fYtUUPBVgWqUSE8+eqoCOaAHFXlMqa37?=
 =?us-ascii?Q?/20espCRX9jCZ16peGlD+8wpbWFmfVnLs1K7wk6uAQdePmkigNDPj1euVeBY?=
 =?us-ascii?Q?wW6tZ2sLLQq7N2V2cQSfLFIDkJKEHyN+8OqMCSxv90qEOGi6AHBkaN6CcHsa?=
 =?us-ascii?Q?ckjkNdRLwX7w6BVvZ+0p29qANVJ/GjsyFDwRvQmJLorhKAeziIKQ3Tk15EYC?=
 =?us-ascii?Q?DTZfSj9psRy3M6eMj/wUfvkJrFCSQOat+e4VrAnSGe+LstNNn55g0xJEu5GS?=
 =?us-ascii?Q?Ww2sRDDchn3EAIQKypsPoYXzg/bjvq/PO9moSWQ55HegTqPe2/RBO6w+WmZV?=
 =?us-ascii?Q?BvW2epVeHrKi1rsRPoUULIv4z91D04Vmh1HHcfApz1BaWw6cPGC2iz/V4t8T?=
 =?us-ascii?Q?xrp0IlORHdK1UJXnP+mXdIN7L/xr4sES0LFv+pYU+JXeV/0rIpiRwudzaqof?=
 =?us-ascii?Q?0IijeHDu/W0n3CnpRriRxlH2KcL/zpXTa1ZgnPDfOYULEC7uP1cZSf9nOfWP?=
 =?us-ascii?Q?jDtY2sdIm1/Vl5Ewf0olmcT1uGnWc9iNGRj0KYUwfHZoLruqX7n4VvVnbTUz?=
 =?us-ascii?Q?uKTWBs03lAwa9KpzkAwrkbEQpwWOlJ80pnxu2tdvWsI5eHj53HF5YdP2FAzO?=
 =?us-ascii?Q?WNg/A7F6626c+i8HTqegBkP2lJfs3JgCPjcUojuHwEkRTWBTloA9K9X1VkyC?=
 =?us-ascii?Q?tC8vV3AtZoFfAii3fzAKwMCOR+cY29L3+/SA2z5/0t+LQuAxSaKN2TiLqfRe?=
 =?us-ascii?Q?+Wix4e2FBDgd5N4zJ09iAtXVmAP2Z0cEe2mAUHrRixb0lGbu/mIVRw2QMyyX?=
 =?us-ascii?Q?uyrY8gXoGvtv2p9jt5R/lJB5HMm2t5/8mUfdB166RginIdoKGop4s5RMJEOp?=
 =?us-ascii?Q?nfJJMaxodo63GEeI++k1Pbv1w1lHtnHfFJok/+3PgPPcTa1riwMqwiym2USJ?=
 =?us-ascii?Q?ndB46atg5U5X6sLVJ7xW7tK0v44OdQoPOEK8xRBjDXMs7UJQa37l3he2xvKD?=
 =?us-ascii?Q?OuMPrGPYZZihPwmYos313BXK6BufXw2nsBFRqWJQQi1EpLaZ7UObuhp1p8jQ?=
 =?us-ascii?Q?A6hCKQsqADJ9HhEEsgwxyyPJJOY55T/wsqcYwdBXSC5mTZIjlAtRWAFqSg/I?=
 =?us-ascii?Q?N9RLh9dDcw1MMRNXcoSqzOfShPb6ZHNpSMUgJ+4q7IXst2Ap20Aap8+MtAA8?=
 =?us-ascii?Q?q7XgpWzXtj0c86lhqaSEziBeExLmSg5MZksL2dgfwgjK+sjeMb8kJoLMr7Fw?=
 =?us-ascii?Q?wqytPPMWCuMLL75GSGi8B+1SI9cM4vURqWLO8KF6G1YxxY6kgtNcRJMwbd72?=
 =?us-ascii?Q?cxXgn1LrKfRv0x3gi6RAFBluUKIJjsf83Zlx7tLYbHHNojGNTk0lNy6e+/UP?=
 =?us-ascii?Q?c4xR3XNkh1Zze0QBSmE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 08:03:52.8041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17664e80-f31e-430e-e7de-08de07d38da7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227

Refactor the existing MMIO accessors to use common call macros
instead of inlining the bindings calls in each `define_{read,write}!`
expansion.

This factoring separates the common offset/bounds checks from the
low-level call pattern, making it easier to add additional I/O accessor
families.

No functional change intended.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/io.rs | 67 +++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index f4727f3b954e..8d67d46777db 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -112,8 +112,22 @@ pub fn maxsize(&self) -> usize {
 #[repr(transparent)]
 pub struct Io<const SIZE: usize = 0>(IoRaw<SIZE>);
 
+macro_rules! call_mmio_read {
+    ($c_fn:ident, $self:ident, $offset:expr, $type:ty, $addr:expr) => {
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($addr as *const c_void) }
+    };
+}
+
+macro_rules! call_mmio_write {
+    ($c_fn:ident, $self:ident, $offset:expr, $ty:ty, $addr:expr, $value:expr) => {
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($value, $addr as *mut c_void) }
+    };
+}
+
 macro_rules! define_read {
-    ($(#[$attr:meta])* $name:ident, $try_name:ident, $c_fn:ident -> $type_name:ty) => {
+    ($(#[$attr:meta])* $name:ident, $try_name:ident, $call_macro:ident, $c_fn:ident -> $type_name:ty) => {
         /// Read IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -121,10 +135,9 @@ macro_rules! define_read {
         $(#[$attr])*
         #[inline]
         pub fn $name(&self, offset: usize) -> $type_name {
-            let addr = self.io_addr_assert::<$type_name>(offset);
+            let _addr = self.io_addr_assert::<$type_name>(offset);
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(addr as *const c_void) }
+            $call_macro!($c_fn, self, offset, $type_name, _addr)
         }
 
         /// Read IO data from a given offset.
@@ -133,16 +146,17 @@ pub fn $name(&self, offset: usize) -> $type_name {
         /// out of bounds.
         $(#[$attr])*
         pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
-            let addr = self.io_addr::<$type_name>(offset)?;
+            let _addr = self.io_addr::<$type_name>(offset)?;
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            Ok(unsafe { bindings::$c_fn(addr as *const c_void) })
+            Ok($call_macro!($c_fn, self, offset, $type_name, _addr))
         }
     };
 }
+pub(crate) use define_read;
 
 macro_rules! define_write {
-    ($(#[$attr:meta])* $name:ident, $try_name:ident, $c_fn:ident <- $type_name:ty) => {
+    ($(#[$attr:meta])* $name:ident, $try_name:ident, $call_macro:ident, $c_fn:ident <- $type_name:ty) => {
         /// Write IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -150,10 +164,9 @@ macro_rules! define_write {
         $(#[$attr])*
         #[inline]
         pub fn $name(&self, value: $type_name, offset: usize) {
-            let addr = self.io_addr_assert::<$type_name>(offset);
+            let _addr = self.io_addr_assert::<$type_name>(offset);
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
+            $call_macro!($c_fn, self, offset, $type_name, _addr, value)
         }
 
         /// Write IO data from a given offset.
@@ -162,14 +175,14 @@ pub fn $name(&self, value: $type_name, offset: usize) {
         /// out of bounds.
         $(#[$attr])*
         pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
-            let addr = self.io_addr::<$type_name>(offset)?;
+            let _addr = self.io_addr::<$type_name>(offset)?;
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
+            $call_macro!($c_fn, self, offset, $type_name, _addr, value);
             Ok(())
         }
     };
 }
+pub(crate) use define_write;
 
 /// Represents a region of I/O space of a fixed size.
 ///
@@ -246,43 +259,47 @@ pub unsafe fn from_raw(raw: &IoRaw<SIZE>) -> &Self {
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


