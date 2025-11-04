Return-Path: <linux-pci+bounces-40208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF9DC315E0
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 15:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4445034DBA9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 14:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D2D22D9ED;
	Tue,  4 Nov 2025 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fOaIpOoL"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF11E5B7A;
	Tue,  4 Nov 2025 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264974; cv=fail; b=L1zsUqsYiygf1gPrdb1Oru4xioV5simiDClC5tAmcDjyApPEmc6jMCs8xFLeoB9pltT5/L4w43G2FN+Ws7hpJE8LMpuFeUTQoqOqMNQQarXzP9jTYCTzin2BoCJsfMw9KTBLcFn2DW6gY+hAEJJezKvw+kbFOk6YFAH+Iw34zfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264974; c=relaxed/simple;
	bh=o/EMmpr1MqI2Ed/QxuGr9VYBhL+0NOKmRReM40dQkY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hn33gLil1OHVzt15Au6Od4yu1PFQE2Hpvgh8x/niDB/eyu+mXBhmtduCMMW5vK9Ume2TIZUkkWBMjg8dyjTQbAnULZfOTAsYuZ67YKqKaChaVOWXZWdFXtm1yhx7DyvtR995h42y/7oGMogTG0RC47ms9ptrjpSEBgT3Ypy4qeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fOaIpOoL; arc=fail smtp.client-ip=52.101.193.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JglIsvSAVTH33ssr0VjamO2toNTqXTJ97OH/3CTo/YxQEs9DryEmE94ht+TcbNOGeWQeMyUOJQw95AIgqIv48Me9uho4kYKX6k5Nfwx14z+LQHUbUplLZKq6SWIBF7wPaCopM8XExzxh0L1vb3L57KUCGJHDVJErRPKIgEeCL/P8j+lKuM2KRZITPmEHq0LE8o4nFkU9ls8YlNLhNG0YsJNhVDo+7SojlNIGG1EcIuqlA/dQoX8Vx/gbDPxdhzPcSWLhvMaGA3xtJtKBfjeBwnpRhtT377L41dXIlZzzTxGvRLo/XrwuVv0xYdKdl2aL7G7j8dLmM26sdUKR9pLHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mi6tkXYQO2Q+QmIdVXJW8I9E5uzjshhB+ggO5nmjabU=;
 b=LLNyCpgbOYo4wjwOeQBDWA9ILZxsgwpvx4ZPJlM60zrK5ai7D/8k59BecJlvrXLMExki/4u7tvZAFboYnzmQDB4PRZgdy+3AGfbnTwKJgkDze8bWz9DOyocVxD4+g+OY6zQA11gpOt+qWnYaxgv/674ev0dffwXVXlrHWs7OH8kQetpDp+y61J/WIgKWC3Ux8kybnU4byMaB56TnCGNoVwPErZPEVtPxkVnHttGIss8Jb5wrdLjzUV+oYUzHhT3HPuejGtNksH/p8wC8BG4SCdu188bgKp5s0wt+EXjYoMw55xkvLJyZWrwjLtWOmN4O+5nmnF/fnPYK9WAUZUTSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mi6tkXYQO2Q+QmIdVXJW8I9E5uzjshhB+ggO5nmjabU=;
 b=fOaIpOoLL3HXa3NgCr8QyvJWnJPEU5iNGH7YqHsDJFkja7JhFXXhhEVLberi6pURQ1RnZfEMrRYxfviH+xGM4Gm8ZAwfBH8dGLnRHcw3tdtoNHy5hytud3q8HB8B2YKtxE1Nxa9HSgcRXGSQmV9k48epaRJjB19eDVju3v0UgpxfeNSSpY/58e115x70x/Ruct/Ih5AyJDvCpNahoLa7rUoYxSIu43l4rFeCd15C9NtedHxpT7yYvyuxvv9QqtWwItBnOzbr80k4B0zWk+8gAyt8D6dJ8g8ctXi05NlWwOaf+mxqbxVGXev520MsrzXOGBw+E5jMXBQGsfiuo3YKmQ==
Received: from SJ0PR13CA0085.namprd13.prod.outlook.com (2603:10b6:a03:2c4::30)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 14:02:49 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::fe) by SJ0PR13CA0085.outlook.office365.com
 (2603:10b6:a03:2c4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 14:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:02:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:02:35 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:02:34 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 4 Nov
 2025 06:02:25 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH v4 2/4] rust: io: factor out MMIO read/write macros
Date: Tue, 4 Nov 2025 16:01:54 +0200
Message-ID: <20251104140156.4745-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104140156.4745-1-zhiw@nvidia.com>
References: <20251104140156.4745-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 009af669-9ddd-4450-39f8-08de1baad6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ViLePEW2+PFJHDgmXxo/TYyo2nFOeoqypjw/INld2jynPmDDVdgLQyDBvg/?=
 =?us-ascii?Q?HGDpem8l18V0INjEhFzAuDC9Tna56hdzcsSnpO6AGvq43cWm9OtJct/knWwy?=
 =?us-ascii?Q?kb0YO+EE3H6eq/tqYYbMuLmTfjg+Y9PrsKyrIKevon/EZzBEMyG8Upf01Djh?=
 =?us-ascii?Q?ahrSaecjYUIlFdkd4okaHxW/M8WEIT27ho+1CibuhvxazypIgXb5+ajngobr?=
 =?us-ascii?Q?pbc2yOAz8whFIuDLc/9cNLHQM4s4HE/x4srvLV3D2OytQ4NJTCPvQdGZKjb/?=
 =?us-ascii?Q?4XBUhROh56bvw50JjHHYBR1seokieTbBs25ADbCtt3dU6jYn2dumut60AK5D?=
 =?us-ascii?Q?VbunC8FQ4axIVDwzUNCO63z9vPbjsQEXvM+JUxVDA7vBdc5SjrOUFUl8izM3?=
 =?us-ascii?Q?TzHaT1KRySkPtdDNLBOTCqOEpu9RVbrPrwMnuNMJL7Ym1J82Vuj1EGJm3laU?=
 =?us-ascii?Q?K5/aUyk/+6G4ii+2knvtm6uVZWsmD8IgvXLpV7PjGv1aISj6FUYoRwOisTgd?=
 =?us-ascii?Q?Ul6jLumtQkUi0elK3Ap/zjlOVdcA10MwcH5xe5dBnc9pCobb9uuBvoo30fAH?=
 =?us-ascii?Q?LB5xqjPxG5pIh5DfPcH2kVDRzbQzgL4Vy+S/f58/2KHm/aYQCdwR3duRfn8B?=
 =?us-ascii?Q?XTCMM4eC9xZkhvlngqwFPxLHtiEyVr6wPYjPDOQw1g+KuTJHbE+vXDuqnlTb?=
 =?us-ascii?Q?L5xVS5MYWJq/YE0v21EMfmpaV8PX3rV6Xdu8JqVbKAUPkWb5bBkliAqgMF12?=
 =?us-ascii?Q?vqd4q3xuM2LeIvsuC7IkICJc45wLYnrWU4f3eRBZKLljgxChZxahRCHwIjUQ?=
 =?us-ascii?Q?hwsJOih4rQyb4aGGgnRt/UFOi9yuvmpH9p4227AuSzo1fQ2XSlo9pWVctWli?=
 =?us-ascii?Q?DyB8LSwwUiCeeXBUKpoxlESy06d2F+5Tm5vv4Ki28sf6ceT3hdQb61INx54H?=
 =?us-ascii?Q?+Gkw2jHlI9NwPshyI8x0aiQQDGpf0tMnnM4gQvKnyOqlGUAM9zf+DBahcCGg?=
 =?us-ascii?Q?2A8cFnRDa9UCqa1B30zkXkFWe8+4Ji1JREJvpLtK2frAMEdRoFiv4iVzBoTl?=
 =?us-ascii?Q?AncvVIystFhRsJ/bZK/mpENkTGVmPrVP3Aw2P3R16AKB284ecLD2wD8Iyk00?=
 =?us-ascii?Q?TG86BaOrdGNRprRHUfZhHTg9Mfsnl71pSirCh8ADUPeflIzx0zjP1wvvB1B9?=
 =?us-ascii?Q?PrXGUcbTeivua0qDwp3IIeARdFAt0fz9MVDs3eaAOsOXGvaBYEwrlgc6fyUg?=
 =?us-ascii?Q?5D/HYVGDJigUDj2YYKV0y2l06ys3fozC/4h8iO3TWKoYJCF9cfha/56KpOFC?=
 =?us-ascii?Q?rt5YgZQKoPNCltti+og55/x+g++buPt3MGig6Ic/WteLskkuIlmr8DwKRWUH?=
 =?us-ascii?Q?pydd2ECEGSz4OuWiEHGFbFKO1QScQtrUR7k8V+g81AnmLIaSFVdHgotK0R1S?=
 =?us-ascii?Q?xdxp/+cHSpky0rLB2B7cURpBYjEz1cVudGXt9ImQXxyZkM/Jrvtkdl+0iz8c?=
 =?us-ascii?Q?Wm8hjwPC2uI/jhcN9mhOu4S4tWJukcpVXL+FXuS0ZkP3oV1Zm1rSoAMgktmZ?=
 =?us-ascii?Q?UEn4wA6fSGS9Xd7J7P0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:02:49.2914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 009af669-9ddd-4450-39f8-08de1baad6bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648

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


