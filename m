Return-Path: <linux-pci+bounces-40773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE9CC49401
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 21:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DC634F0155
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1C2F12C1;
	Mon, 10 Nov 2025 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uNy2fPuy"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E7F2F12AF;
	Mon, 10 Nov 2025 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806671; cv=fail; b=btzm4d6wD+GsVYm1R9MTHk2+F8ispAQmviSu1mWt9AxJKZAKarMOcGdpMQdUlLKMPGA7Lx6MsIolsPNQ57gTdCn7NI7kn1gbe3gkKttpb+SyYiNBSO48zITsu68ojp3cAjKc1XxU4Hoy4hz+Mi0lgbMjbk0CQhitd/vAE6N12KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806671; c=relaxed/simple;
	bh=e8Ydrmv4Ev0326GKQtzFIHGKYcg/f4w3gO1gFagO/Xg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wp2Wg1pWzLp7TSQfNOuGddTCsfojw0ht/UApC0yZRnLow7Z9QxBoPJVizbZQ0QiiMJPTnTla1RFKEJxYaE0k5ILIAE28YyL/B1C0OlF4Z/PtBb9RvBSlZENt7w3nWcnfD5FTORBTy5eWcSKk+HysPJMcY22t4xPE9Ae+umEb6TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uNy2fPuy; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBQFYX9nLCVZYn69GQddjMeXBWJBNOOi+WiilPVr9EXIZUBuJAr27KiDahvHcrMhd2KRg5bZ4UYnEBl4VppbqHtga65HVBESlY+Z3+HM5rkHE7BmS/s/NPNJ83tAxn+IWYTox4SupBYJTW1rvYETNZa+ao7Gsw9BMd40aEmQZm5PurYl5r3H1bdgpMyn3F5G8nTwN3gK48FJtI2PPNWj3s9a/rMxPJmB33gqjUQ3zEMbeWE8Gb85P8z7EuvQxjnlKSkbiOGTSPrCV2NlGl7vXbhw0aFF0plRbF6bnYZZaooTHV+ie1cUsJal29dNcNaxPC2TiW50ONWv+yxzsvnYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHnQoxlbDOiP4dHPSo0junE6UiQHvJ4F3aIyN85LrZA=;
 b=Fgo+AOYGJWeZy5H/cOk9VjniFxhMo+JyqDzHObzwUUmmJNf+FTKDzTeViTYnz6Z+0x7CKXnwm8tafyAWrP9IQC0J7CjPh37OqrKBgLHdrBdyVxAydx8tFXQtFG0VYIJUic8ypHAn6zxK/+8poZ9mD5Dc1SrrJAWHuO57Gz7Chx9XjegF8pbTjTOIhjDxq9erm1PlmgaE7nNln8eoJoeWNUNDNYbYDB1r1NauvL5J3eFP8yDvAwt4xgSA4lOxeJaOOgQ1226kEgzOA85NDXTMJcnE6dt0rX4h94BT4MSCs4YBESm1DNrIEk1w9xIGt3lxYtoaF/AR1HJFlXFtQ3C66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHnQoxlbDOiP4dHPSo0junE6UiQHvJ4F3aIyN85LrZA=;
 b=uNy2fPuyt2oRqBFaaWPExt+gWcyFsWNdqbA3X0TVfeZ8GT53bgOg4p9K+NsqLchLjMfs6ZOPddicV1TRjk3168+RZCR8stMA7AEUG7JZgVUixUC1dnHwpNkt3UXiRhc86QziJcMzM2Ct1i9rn/vtsfbQIRS5bXyzZZqj4/0v0FXXRHw1dO1JoHmnWjM21lQcWdjldVTybo4GpPaY4z9cLMFHjfH99sUqgZe5E7N6nD9l7ExKp2ggAc//PW2H7YJTEO0/gp/Ycpcn9xdo2lv3bqEceCM1LCoX32Bg65I7l8E6ZbRQnvjc1PgdeXro3MjljguaGU68z3XlmVP16UmqVQ==
Received: from PH7PR17CA0034.namprd17.prod.outlook.com (2603:10b6:510:323::12)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:31:03 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::18) by PH7PR17CA0034.outlook.office365.com
 (2603:10b6:510:323::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 20:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 20:31:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:30:36 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:30:36 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10
 Nov 2025 12:30:27 -0800
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
Subject: [PATCH v6 5/7] rust: io: factor out MMIO read/write macros
Date: Mon, 10 Nov 2025 22:29:37 +0200
Message-ID: <20251110202939.17445-6-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110202939.17445-1-zhiw@nvidia.com>
References: <20251110202939.17445-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a74496-d873-4d95-81f8-08de2098102c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ndDaxT5YM6fymGegqHhx0sqzxuUJDRJyNBhDACXM1pIs9tRDztjey/LwidL?=
 =?us-ascii?Q?VX6409hB5nP/8KiYDmwMdsliIvyWuRsXMlk6ZQf25wusk1HobL1chKdX71r9?=
 =?us-ascii?Q?duCWwoSbhnxuTXNPgck9BPSHVyZIQwm5qNqrLVOQtFha7NmXS59st7AJTB8a?=
 =?us-ascii?Q?d2HDppauhD8VW/jAHibkfrvVvU2r2u39AmGbBtDLXsx0gCWldJfblm8x+kVb?=
 =?us-ascii?Q?zmM7R099uWOooTa8f1RC+wFo4uIS8iUOzemOlne6RNH4aEL4mNcEY4efHxIK?=
 =?us-ascii?Q?EXe+zL3A2eNl0pDJ1+IPAmyBnkVFZhN8ufRVHCz9kdmFnOeyPqkBNWpbd58o?=
 =?us-ascii?Q?V+CIwiemXPPXHT2F9/yi1doW2w/I7A+GF2xhfgtrvcp0xK4J1uWxywdFD5U+?=
 =?us-ascii?Q?es+hjo50BVMgoPRyptTwWpwR4/XG6neDFW32viII6GBYi2HQUUN/ynbtKaNk?=
 =?us-ascii?Q?Db4UkgGuyGkL3ivFrAfYG3+rDcTxwMjmzG7yQqoLpTlU2Eyb8XnvCVs4OylX?=
 =?us-ascii?Q?KdAmnFjFOgTm8Jmk8Fjx3nWfnS15yw9XW1hGc/hakyJDEFFxCwE3hntlsLwf?=
 =?us-ascii?Q?uMRxDa31zNoeUgyLKtpvB5GVHe8xWz13CEAdYr8JCkFSbupsQrl72z5TATQE?=
 =?us-ascii?Q?H+r8mgDa9XEpgrdux1cqrt9Z+vJfd/C4JO/rEBJ3J8ZZu86bg+sGqeY4vwY+?=
 =?us-ascii?Q?lBvDryg/R/WbGUZB+KKOUR6MEvjy+zAVsi6/E4TuuXQrS9iORebmNT4mujNL?=
 =?us-ascii?Q?t3C+o6N3ZvLjOyhwklLZ3si0WIh+8ZUBDW3rXL1gbK93bydgpvqy1SYjUDqw?=
 =?us-ascii?Q?5rYRZ+pRdRLUYlORwTPXoTAij00DXccDJ1qagGP8dmzJdim700LCkArVMs4w?=
 =?us-ascii?Q?2cDR0c501sK5wQwcSZUdfEg1D7i6cYhYXNeCSRnrIL4RnukfiNpcpJwDzkgw?=
 =?us-ascii?Q?auGm1MFL6j+7j2fh9d3GU5FHhHz2QAmZ4aKOwSpk/nBEZOet8Gd1jOVwiUvY?=
 =?us-ascii?Q?i6BBPij0800bTIaWBJQTmIUz6pY6SeB38E2fnbU9HPjO2GK8ySCvVUnqpnW+?=
 =?us-ascii?Q?k2wFMKppSKMXhDjdMktSZwlPHXTUOKk55WvvHFlGtjT+0l0EBastu78pFqMz?=
 =?us-ascii?Q?u+QRuH3xeOxyOV3g/d1laZFVg+PmgYIYEX4jBZxnv0cgNhiaPywNKZ5OZt//?=
 =?us-ascii?Q?UNrrU92kjB4IfaBTgkjX4xoafdZpMQMcde+zNsxnap7rWH+u3/4ugSpneIBk?=
 =?us-ascii?Q?Soad7C3utSF3OyZmWbpzEs67e4PJrLlSeaUdluGIjWcJcA2/LriPjicVeIcR?=
 =?us-ascii?Q?VH+BlTuAIkUjEFmrxUFeDrGqXc3Ssalw0aVHe7CZqPduwYQxwcT1E4WBU+75?=
 =?us-ascii?Q?GzYppXawv9ExmG3pPOFULotSmuVdG029YyqGEVAHkOq2LPaUKCi+cWDXicbl?=
 =?us-ascii?Q?QFuHwxPu0lyIEFN5fhZiv0tePcEMPV71tjPSZkAqf/iinVdF9PvqoNJGg8Bf?=
 =?us-ascii?Q?IQGHsRcFW82Ze8HXUicK2ksJDdDHKxq3qTWUUB0+BfjiguxnzLJoqR66VbqM?=
 =?us-ascii?Q?Md8nDPfyYjnhbM8Jkvw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:31:01.0436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a74496-d873-4d95-81f8-08de2098102c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802

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
index 4d98d431b523..090d1b11a896 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -124,8 +124,34 @@ pub fn maxsize(&self) -> usize {
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
@@ -135,12 +161,13 @@ macro_rules! define_read {
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
@@ -149,14 +176,16 @@ macro_rules! define_read {
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
@@ -166,12 +195,12 @@ macro_rules! define_write {
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
@@ -180,12 +209,11 @@ macro_rules! define_write {
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
@@ -298,23 +326,23 @@ fn maxsize(&self) -> usize {
 }
 
 impl<const SIZE: usize> IoInfallible for Mmio<SIZE> {
-    define_read!(infallible, read8, readb -> u8);
-    define_read!(infallible, read16, readw -> u16);
-    define_read!(infallible, read32, readl -> u32);
+    define_read!(infallible, read8, call_mmio_read, readb -> u8);
+    define_read!(infallible, read16, call_mmio_read, readw -> u16);
+    define_read!(infallible, read32, call_mmio_read, readl -> u32);
 
-    define_write!(infallible, write8, writeb <- u8);
-    define_write!(infallible, write16, writew <- u16);
-    define_write!(infallible, write32, writel <- u32);
+    define_write!(infallible, write8, call_mmio_write, writeb <- u8);
+    define_write!(infallible, write16, call_mmio_write, writew <- u16);
+    define_write!(infallible, write32, call_mmio_write, writel <- u32);
 }
 
 impl<const SIZE: usize> IoFallible for Mmio<SIZE> {
-    define_read!(fallible, try_read8, readb -> u8);
-    define_read!(fallible, try_read16, readw -> u16);
-    define_read!(fallible, try_read32, readl -> u32);
+    define_read!(fallible, try_read8, call_mmio_read, readb -> u8);
+    define_read!(fallible, try_read16, call_mmio_read, readw -> u16);
+    define_read!(fallible, try_read32, call_mmio_read, readl -> u32);
 
-    define_write!(fallible, try_write8, writeb <- u8);
-    define_write!(fallible, try_write16, writew <- u16);
-    define_write!(fallible, try_write32, writel <- u32);
+    define_write!(fallible, try_write8, call_mmio_write, writeb <- u8);
+    define_write!(fallible, try_write16, call_mmio_write, writew <- u16);
+    define_write!(fallible, try_write32, call_mmio_write, writel <- u32);
 }
 
 impl<const SIZE: usize> Mmio<SIZE> {
@@ -333,6 +361,7 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
         infallible,
         #[cfg(CONFIG_64BIT)]
         pub read64,
+        call_mmio_read,
         readq -> u64
     );
 
@@ -340,6 +369,7 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
         infallible,
         #[cfg(CONFIG_64BIT)]
         pub write64,
+        call_mmio_write,
         writeq <- u64
     );
 
@@ -347,6 +377,7 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
         fallible,
         #[cfg(CONFIG_64BIT)]
         pub try_read64,
+        call_mmio_read,
         readq -> u64
     );
 
@@ -354,46 +385,51 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
         fallible,
         #[cfg(CONFIG_64BIT)]
         pub try_write64,
+        call_mmio_write,
         writeq <- u64
     );
 
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


