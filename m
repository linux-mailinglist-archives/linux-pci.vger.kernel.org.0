Return-Path: <linux-pci+bounces-40781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0E0C494AC
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 21:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE193B5586
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725182F1FC7;
	Mon, 10 Nov 2025 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FLcCSfBM"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A912F12CE;
	Mon, 10 Nov 2025 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807364; cv=fail; b=Ktxz5TpBePqe0Fh/jo+RKWa8s58lCJ9cXJWG0KqlalebZz0n7Mn7+GOJQNghh9Br9AFex+dYusqrtGI2nwGxhpknEGRpEj6hgIY5WA9NXD/rXWS1l6oxPb5rG/ClZRCtOC9Cp92YJw4/6sWMBKCww8HYRAlkiQgobnL3IrFxCys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807364; c=relaxed/simple;
	bh=e8Ydrmv4Ev0326GKQtzFIHGKYcg/f4w3gO1gFagO/Xg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSO3pjjxGbh37876wJvRkp7t3TUq8t97lDvFSQZYXAAkens6vnB5ky8L1kAu7EKm+1voilXvafA7mSvMc9yMB3NAKX05G0GUbGLzug8gIb7Lke3bIj5TgqZcQdNI7EwoWV0WjcWxz7deVXNPxlahX8VhQLFErmy/mmFQ5wHtffo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FLcCSfBM; arc=fail smtp.client-ip=52.101.56.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ri4NLrNvTS3KNavTUUUmDq9S6tOQCsX8f2DQzp+BiPctiZUO7z2fg0CoOEgEAXe7sZZ1V5zM0zBM0/4geiSNGx6LDDyhIZaDjlKwUIaidXuL7ByXHXRku7qTuql8A9/9inkPdBgqlRsyaNxclp7ZnqbKIprng4cgV32RmFUNBrYKghjfn7zEI98I+I1m27USJnPvBiRSljRnHrq7Mget0kvPb9GWrkgFtpAHNG8yUh4Qxy2D2W7ZIH4m+3YpAAjVZltxi6iUg056HCrvAs9VuZDBIE3hIIAIbUaS2eRbltSG4F6+ppBvcO8LX3XqzFYsFExnbDBfUobL0Av9+vB80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHnQoxlbDOiP4dHPSo0junE6UiQHvJ4F3aIyN85LrZA=;
 b=PEiKpI16vaMgmprZ/WjYyN12WkzFApbkQKLoKK0w9OZvEI/Zx9Kk1vxvbaRDz/AWYvRdOeancJyVypl5guAmmRM0cHsmWBFyv9Z31Gt/WXy0iNtXqiFCI2sY3fAPySOSSnMA4IOmZlXNbn4EYq5FiaCZyf3+GV4idFlZjvWo+6B4/HRsK85UNqqT+Db7CjL0WIdleH/yyU/U/dQsaQJigRqCD4jyHaYoO6/7lrhYIWqpzvfP6NoPvoTXMUWHNpYkeA2q3R2dvcvsFz6qa2zqjy+GFopiw9f7mM6pdlAvzvr7+X2k18BBN0bN9t6Tg1ox5ou5K5/iuYZXnKtXT+3MgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHnQoxlbDOiP4dHPSo0junE6UiQHvJ4F3aIyN85LrZA=;
 b=FLcCSfBMqVHY3jQVg/1hiwF21GGfiQHG3v95/3glW6uoapo49TMVc5ihsCc/nIHnZcivDUhJiXVeEk8dR6hsK3IfUJMkJ1dD1FKjKBzv+/T+qxN+Dn9wDFLsYP+dO1YCTy3iM+HeOngkkYw9sAOtB/rnhS9Rlait1i8K/CncPbVYr2rm4nZfOafm/Sg+g+02T/7jz8l9NEzh6JorFP2CjLdGeEUcwi1g/31RPho096+lvZs3fYdiFdhU6YdrZJdeL/HRRVmkg+0vT7qreNfm7MqqURav7AMTNAK3dfobpyPuYtGQaNqcggXPbElzz5a1TMPFkstQzJ89SJM4EB7oKA==
Received: from CYZPR17CA0016.namprd17.prod.outlook.com (2603:10b6:930:8c::25)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:42:38 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::42) by CYZPR17CA0016.outlook.office365.com
 (2603:10b6:930:8c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 20:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 20:42:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:42:18 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:42:17 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10
 Nov 2025 12:42:09 -0800
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
Subject: [PATCH v6 RESEND 5/7] rust: io: factor out MMIO read/write macros
Date: Mon, 10 Nov 2025 22:41:17 +0200
Message-ID: <20251110204119.18351-6-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110204119.18351-1-zhiw@nvidia.com>
References: <20251110204119.18351-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e12843-5b01-453a-37ca-08de2099afd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z7rhlCVWLYk/IUiBA3zm/RXRfidIsbdJ1hMefPYd1rN2db+XU4pxDpcKBvRu?=
 =?us-ascii?Q?6y0dzQsrAL4QOTZomR+d8aYECSIDntP6LZMloonm925F6y8OodEOrgnNHmv+?=
 =?us-ascii?Q?dvwUgg+6Gbsaa06tuL5VHgVzW6wp4sxWyouFMt1zJnOAu6lJFi3EuWlXnrvG?=
 =?us-ascii?Q?nYcpEGLAeXR7p3O8R4JemQzgIhBe1gzBmHM8L74i42cG9X7Pw+7dJJCrpC97?=
 =?us-ascii?Q?hgn+VPRExHCuyrkpRcpU3iAscNzY6wGYjJYV7/C9uj/rWUMkH3EYthESGLna?=
 =?us-ascii?Q?igU+kXmmQmp8Bs4unry/Yf9tIOQAh0y0NscE299muIMYZRPGgZbfgkiVmT24?=
 =?us-ascii?Q?2DXhSFE2kz8ITzlaoVht6UZo8Ls4uhSPvB9WgBw9epad3uWMVoTfBbWbU6yM?=
 =?us-ascii?Q?p+PVlYtHp4sQgUMDiyqcdZwFnAnq1hejwtXbyU2P/AR3iRerUoEBdN+xFGpL?=
 =?us-ascii?Q?5/cUCgg21dz8HMX3r38UHoqNDrYrsUMsiYRcLiJ8iGCPdSUdEq/0RBYtO4z9?=
 =?us-ascii?Q?xXjjXHCvNrSBWmoOU8HOac7PbGB3ih7hxY7JuycwCcpDcwFGH4MJXLxarPgT?=
 =?us-ascii?Q?AHufu+j47p9X8znb+jc7Syjw1ykR8vgoM2OdLxSvCTW+yA1yJaa/7KYEEfXb?=
 =?us-ascii?Q?dxNVFHbx1bVNL+dI7RQyf1YH0bPr+PHs+3LYw8PSyMZBoJmtOSdExmv2Yh7f?=
 =?us-ascii?Q?klsdN+vl4Sel00ZwvfpeuHkX9I1fFFFQMsUhsegyDNWwhTwzpeV6+8ZG+bas?=
 =?us-ascii?Q?EpPqzT2/5MLrKRpXXY8MctxMPFN3tMXJq2A3FStDadaXqQJ+ZCXMEJZi5Zbi?=
 =?us-ascii?Q?MVA4ZiKDi7FEc5AStssOY/t8RDXiyIvW6eGNGCymSCQ34SBvchojW1szRpzz?=
 =?us-ascii?Q?ME1nYlSyqrtZ09P17kDNn39laghtGaXGSLMZuJUGG09RTi1cY6GF3QPU8KBz?=
 =?us-ascii?Q?bPf6Qz0JV5O2tZTLhlvsHFSRMDJb2cRL2C+yjBxehnpueHfQXH0ZXGj1T2aD?=
 =?us-ascii?Q?EY2cOU33vT6bcJmKdIfWB4GTpbIycXKEBYyNzqpk2n6yQLEws6DrUtjQ8+DY?=
 =?us-ascii?Q?IqHcuwJPlldsrXdCkeOkyEwlWk+ctbw1iMpx+fRWE0QsL6JLRdOXrCInJMmA?=
 =?us-ascii?Q?pAC2BNg/LMaXl5HDnX9ipdmXPrTCZ9ct08TWlS3+PQ5IGMjjKrIA8Lojp1FZ?=
 =?us-ascii?Q?W1NUOCqhoeeHGUniv6HPFOkL0vJ13utKzXTZyOcliPTJrheil2IbI6rh0yck?=
 =?us-ascii?Q?aU7AonsmDQXahoKLXrEWelCQg1dWtkXJAFvDtQBG5OPknqa+nsVh80xv491f?=
 =?us-ascii?Q?4B/ThCixECwRIzox8+z8aLKnFyI9xQdbnQq1Uhh+XYsy8K0gPUZIxMJckGe+?=
 =?us-ascii?Q?wrc2nAesW2LQpg0Ns9OdGzApWpTnFrqdeAryphIs6oEyTqvI5K+wyZdpnjq2?=
 =?us-ascii?Q?950onHkjNMr8wx0bA9oEjTq1VsY0fibLolPr8TkJj2W/AQLn8Lg2/v/Xkdqx?=
 =?us-ascii?Q?3qmlj2lNF55kr35NAnFqLQEwAvn62A82jm9edtZkVmBt46vOyh2T9n9dClyC?=
 =?us-ascii?Q?RHJppHisNjCJ2qoIcp4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:42:38.4342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e12843-5b01-453a-37ca-08de2099afd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467

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


