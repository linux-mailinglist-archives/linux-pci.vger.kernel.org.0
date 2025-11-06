Return-Path: <linux-pci+bounces-40487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B32C3A47D
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 11:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 237644FFAC2
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1422DAFDB;
	Thu,  6 Nov 2025 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jK9t/1uS"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404127146A;
	Thu,  6 Nov 2025 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424968; cv=fail; b=S4rEHGc5QEKVBd7bcMqFxcUxiIUuv5Arh9vCKAAZ2r+wWtzh9Mnn/h1y4n/86Xs0pR94BOz9hbcneX4bs/5uztipgQqrxPXLxGKEYdav99opoy3uEWgkOVyohUqfd3ekVOOPf3yBxFYErmH5VJvtVphRG97M6sspl5fwLX9QDBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424968; c=relaxed/simple;
	bh=nZ5uRjvnikG3UlcRMk+bstrOo3egTlsAUroBORPOTUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkH7sx74PdyNZu3y2fAcxl3SLSPk51G2SpRX2x4hJ6ag/rho7gpzVag9oTfnaG+x6iI+QaI7bP687nmDt+o3Wq5dQJrJrmL67oSx7gS1J+p5tq65itBGiSRxDP4J1ypZMirSyNIegptziHz1J99kSB+uQm3zk94n5NfJ/bXzFRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jK9t/1uS; arc=fail smtp.client-ip=52.101.56.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/D19swRSlnYPyBx6jS27Kw0PhE2MRgK7F1uRpx6hwWjrkEX9kACiNzLc42KtOMh8KA2AavqkrtNlmkR1P8pNks8ScqFCgUK3KvVWy75SXFLYQsh8Hx/IBc3TNLxCYXHidua36zl5YWjREB34zFccfB1yYXMsdhsWrY1jBMXKB3Lxg1+kuOneeuD1fgl2bZOXOxiLrFgPSJB1z5YtBKHZ9bTZfHUb1nm7tp82LyTUaDuMosDRl07z6ZRhmq9aNmlxRpXiMLztGimKiK7IQCd0v6reNJNBGqmvPVY4VsGlQx4/K52szNPsgPbcVXGxQzPvpKYVIQFZldutZAPP3tIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5u0CQC1dytt2lFOLipyZ7wwoMLgyfW2BgnBaGjBMjwg=;
 b=vd+GXL4+4c1t00MnztDi/v+zW4DfdO/klGOlWdWga/gS94LS+G8184goQlwjyHEB+nx7yGQi24Qej8Wvl0Agc3UkxM3eBppaT6IIcZywc3uIhCap/0LBgR+U5RK4Bk4pmVaqKbHRwPUkr4HBORzUGIK6HWJk/fTeMZPCY+b4lhxeeul0ZTaHNexcm8LV5WTafKo0otS1ovxCrAIOCT019BHqtaNDGYRF+IiSfQrRu/raXPDzqj6VHYyUSQv1Iedb6WRzhkkBaakgzaQdB0jqL4UFbcnGLzarvAf7ZHQziD14B5dJGxfzO2hmQWZBOKcnP/dgSsfCWkdjjm6n886HQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u0CQC1dytt2lFOLipyZ7wwoMLgyfW2BgnBaGjBMjwg=;
 b=jK9t/1uSzObFi9gm61+yK2J0rHA7uM7/0MN74ImvWD8Dw8tVgOlEjINAhQpUMUc6P/3XG3SDVcxHYMSstJeW0OJmRRAoEhsprUA1ogHtH4wb6b14f7gXJ7FLKrwKjFGmKTYSJXSfEt66vKh+pAaEgy8FqhnfrwdOLH3RaHfsoQejN+n3n0Wd6O8nyRp3o+3uAn53cmGMtWBGshDjBrXGTuwCHzZFzuJ0Zzaab6N+v4K5nem+Y0KLmYJ63uAHZqgdSbiPM90SOwXW/WmVb4vJBsspkGs5bFQMQgdZ0UIhDjSBV49Dacn7cazGLM+R3FzpHz614M1LuQImeKH0HCUH/g==
Received: from CH0PR07CA0007.namprd07.prod.outlook.com (2603:10b6:610:32::12)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 10:29:20 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::ce) by CH0PR07CA0007.outlook.office365.com
 (2603:10b6:610:32::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Thu, 6
 Nov 2025 10:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 10:29:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:29:08 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:29:07 -0800
Received: from inno-vm-xubuntu (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 02:28:57 -0800
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
Subject: [PATCH v5 5/7] rust: io: factor out MMIO read/write macros
Date: Thu, 6 Nov 2025 12:27:51 +0200
Message-ID: <20251106102753.2976-6-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106102753.2976-1-zhiw@nvidia.com>
References: <20251106102753.2976-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 691b0fee-1194-4527-99eb-08de1d1f58b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FIV6r4Ll7h4G3JvmD+F7gn4m9IyFe7dhsNo1gv7Rzuz+yys3BYaCOUA1VawK?=
 =?us-ascii?Q?PBkSx2R+BbskFOVdqdVg8nv7BLzZo+c+/01eJjXV+Yd2ABbzvXqoGHz03SdS?=
 =?us-ascii?Q?Tlm0WmYOJBg/ywo0JGpUnX9dmdhUuFgC9XgzxASf6tLBOygckCS6hSwRLFQ/?=
 =?us-ascii?Q?mIgPvR6NY/kxuswpAGnXis1LFagdgrfi8TCUDZPDyM/jth5Hm7YdXAFEQ+Bn?=
 =?us-ascii?Q?cGswGTS6DycCSdFpvgPrG1UqRZv8ZMDFWiDXvbJDWoCIgiqdxS7g2yDgFd4g?=
 =?us-ascii?Q?s1+nbH3ks4EoEOA+1wzAgE9LGFgIWIn/9xuJGRnqmPboGO6eqNI4fuJsPbTq?=
 =?us-ascii?Q?LusCil6S4X/TDHSob7pnfHBM7Q6wcziAidJaVlHucT0+10P7FKAlIoNzzg2o?=
 =?us-ascii?Q?umMuxRkIZ0psMFVAmYlwA2Xq1AP8QwJGyYnAv0nt9zMgIc5mtPlrTHUfT9G9?=
 =?us-ascii?Q?sFC6fOVnlFxwZyPoAfOSBx2BV0CqmCMKkQECEIq0vDD4PwOCe+iK7e7gFfEA?=
 =?us-ascii?Q?P1l6MuX97SKURDAvzx7tYj3PLA1o5nbQ8rPDtkT4rxiGeweD6V48rplSmdR8?=
 =?us-ascii?Q?NDyFr04+SVN0m8u2Y4+AYpPOtfqoooxYULxgXlGWWUJ77r1Q+Apn8TMP6IsV?=
 =?us-ascii?Q?H2JUd6XOMnOyLxRrUQgMsq85JdQltatwGGfRkqvsNJiCszOwAUonAq6Q4Haz?=
 =?us-ascii?Q?rYsr0uWZK23D/0fd6b0JQGrjPIlZ8W0X2VmJOURPXRaIensr2TjXyN+oiN1e?=
 =?us-ascii?Q?YzuK0los740CTzAFicUzOLTJWCY5Oh+l93Q5Xa5RLhYv/0NzVE/na60NrCl9?=
 =?us-ascii?Q?DuxfWsTVjqLqzXIzsbzYhPbEtHDtgFBij/hM4my4wWR8MxZDR6BOaSZcyDZJ?=
 =?us-ascii?Q?CyFKc9Gf/l1aA8AAxU4ZQKVqqNXZ55WwQFulnUGIQBATPs/9AQkaAorEm60Y?=
 =?us-ascii?Q?AdnD15IWIt/iwfjzf09z9otkP4O1Vs0l5AD8sCsErWXk26OwB+GSoR5jz2NN?=
 =?us-ascii?Q?EZ+U8FZV7VSFPPVzmsS8CBemAxVR/2USp2ubfeA2IhwVJ4kMgy+dVoVG8Es8?=
 =?us-ascii?Q?Y4J3EiFCBJEBhubdXf0BY3rThIynBQFrtgbu/7bdscEosqmFxjM9XdyLTaPT?=
 =?us-ascii?Q?C5jDsuhHoXqAvu6Fe6+wXXYz/pkEyuhdY5citxqCM2TT1UA7sX0IhKoRzdOr?=
 =?us-ascii?Q?9PZAwjNYa7Wh4pheLNNGL2JMg6/wPlJVzMgL38I1rc5VODjs9rhKep6ChCfO?=
 =?us-ascii?Q?EMJEkeKKeU64zjC+KAMNHaz8cs5uU1sZzyIQaj4LKd73B99fk6/VEar+tm0O?=
 =?us-ascii?Q?mp1H2EEmnbL1LOQuR3mBnodYcTkxjAugla8wdhCQS4aufxfKibaNjIaYpKAG?=
 =?us-ascii?Q?ONmqCI85bYvmNrkpXdau3DYdvPLgjnkhxR/2pCwf1+KXLXjWZJfvfgbt4aIt?=
 =?us-ascii?Q?H3CjoHRTPySp2e6zeVNSY8a8SlaUxR/XsadQkKrexvZtsWAEyUZC2x0RyvCY?=
 =?us-ascii?Q?eRJaJ9n//Z1DdnXsKQANLNYrrub/v15blRToTMQ4/j5Hht1BVvu/duZVS3zC?=
 =?us-ascii?Q?W2vKQtlmhK1C2xBqBRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 10:29:20.1434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 691b0fee-1194-4527-99eb-08de1d1f58b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657

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
index 6221dea9c8c3..9401c6c21689 100644
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


