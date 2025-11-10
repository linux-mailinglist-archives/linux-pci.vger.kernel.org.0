Return-Path: <linux-pci+bounces-40783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261DDC494BB
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 21:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E56E3B64DD
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BDE2F3632;
	Mon, 10 Nov 2025 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wfhp7iPr"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906B82F3615;
	Mon, 10 Nov 2025 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807376; cv=fail; b=VTZHRx8p33H7HBWXWpbC1DBW50Fb+EsS8c7j17hewXuMnV178VWp3Uj/JhO6eucObghpBkZanqq63TWcqUcM+ETn2O2v4iEl7tGX1kqmgjM6NSr2wVm02UQmJ0mWoU0HRfQwhbcyS+T1E/3EUX3xB1mwdnpAomQxXuZHojVFyAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807376; c=relaxed/simple;
	bh=zt4NByBYsQbTKmEppLpWCxINSBnAgfhYJ+22IzRknc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QjN3j3J4DzrOiFqyi8JuV33PqmCosqQct+v5DzZsW71uNZgqE+T225/7gt6VKLk4CVD8XDk0+4WnE6cJw/iWpfi+Re25XuqryDPeeoMaVgmQWlDaZ0srEJI0TY4wszngXpYZwaN1piCFMw4qhxo+TVewIZPbBLHciZ5Uza+IGnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wfhp7iPr; arc=fail smtp.client-ip=40.93.196.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIVfydaqe2hlzGIQHa+wRKXsvV5r6ufnrtE9uDWURokCEZHJ2LfUPquYU7P+JN4O8z5lKtBkjDbbUjANoMUiESqQWgzFvGIl7cPLlofwKEsT/QHlUS0O2CIMHSal5mk7D1tWvioyH+z5e7/m+6zlHfNwKcR0k2FC79YL7dz5fxa7BtUm+CXTHMoy+cOu9dnSBsfmnwEAtY2K3qE8TqSBQTbLr1ejb1qckSunzkwBGDs/PHWAjDTpB877moRMjCl47V43g/zzBSD99z+kg+ynmDtzUjhF8+1zPFJFPW0xMW4EbQNlIzNMH13QQ2GuxQKLlIKtzeInAQ7RPSxKH2fZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3nz0pMo4LlshKiXjVTfZ56/qt3kMs1hfF24DzcSvGw=;
 b=dt0+nIRjTAAhb1YhF/rc5xX6vuMbmf2oZioF0MIlyiOjjftFcg7EZJC5IbJT1dxXaxShiz353c8T9UqMDCTfVAdF+VsBCxLrFvD4vbpC2YK1UYDiGSsmkHSuZ6erBkGjqiZKp/3L7u7LuDpM7AaNjubd2epsaCYeWn18XyulwsKsTWnCd9JHl4Ew8vqmYZbP9erfbDj7TL6iXPJ+2zlzLGs/Ce44Hhh2hSGjYiZncJjQBv7t1Q0iD6LAuAiIo3FDhsfBkXkbRCaVMmMGs+VANC3M8E6GnHlH2XX+bzuEjlTdiDgf+dTVDgGVImH1pAg/q/w4sIFYW5qUrOzPjS+9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3nz0pMo4LlshKiXjVTfZ56/qt3kMs1hfF24DzcSvGw=;
 b=Wfhp7iPr5znOqCGDxIaOqW6TbYbjpu6POUkQzpU01Ts2kkcnQ/SS+VdgU9zohjvxQARE9mQaYag9l52hX4Qmx6Gnek4ZWX6fyXxy7sfXWZqx6eHpOQAhxTCK8ZuJcziD4ZoG6hMB+Zhq1O51xRFjyCRIrEEZwCytVrN/ElxD1bmGKNwBND/2GX7oU6gQ80YXNTNXYGAL5EV/fuWWuU4rA2mb/bCRC6gN6ib4eLX7TKFqe73Qw33Q7JNnhrZN6VjIHP7hkQ87ftGL46IsbeWBvGjWgrW9DmvR0I7GbWhiSNcVnPpFacrdpPeoZCg6Km3IhDL2yCn8MYAzw9pxrWpF9A==
Received: from SJ0PR03CA0256.namprd03.prod.outlook.com (2603:10b6:a03:3a0::21)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Mon, 10 Nov
 2025 20:42:47 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::c2) by SJ0PR03CA0256.outlook.office365.com
 (2603:10b6:a03:3a0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 20:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 20:42:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:42:27 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:42:26 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10
 Nov 2025 12:42:18 -0800
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
Subject: [PATCH v6 RESEND 6/7] rust: pci: add config space read/write support
Date: Mon, 10 Nov 2025 22:41:18 +0200
Message-ID: <20251110204119.18351-7-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c98da3a-eaaf-444b-e842-08de2099b47c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AxlKaBhJ+BKBvR0eCrd1063y6xeaDyIJBdFP4RbyyPRsvam1P0HXhZVJsLXg?=
 =?us-ascii?Q?XvLG94Y5VANbabbundl/fAZ73HjnfwaljfFPPfPx3mHawA596OfDMTDnzlth?=
 =?us-ascii?Q?AM969ChVo/CUaicTeoTlF9au62X3MJoXd0kj674wFwJQabaV/GRBo785VLta?=
 =?us-ascii?Q?craLht8j81Hgj4DPjj35ctJcJ0dws9YAqu2vWb7NEDJoguNszXdPzHk+OG7F?=
 =?us-ascii?Q?fsf8BqihI2xC6L8KcnKAm7RFg+asLPWSiuqt1JuJgrYuU0KJtJQbOtUkwa/p?=
 =?us-ascii?Q?Ga5IFoHa88RYep0rcZ+8t7+B/6LuOocqJGrGj5SkSZQG9WBIul8PmRcWEtVO?=
 =?us-ascii?Q?qIWEHs1Z/0V2QZKtNkOLn01sCqVkMjyEJVHHLucDsgUnISeZ2eQcvjjJX0lL?=
 =?us-ascii?Q?DtEph4fIJF9XBxU7C9t8Z/wpvZTb26GYj7mH6AbgAu0lwYUm75sQrcRonUT7?=
 =?us-ascii?Q?qNHy7SOp4G7BSujhQb55jtGWOmOslxGFnZUDlVACIjB/xXDresWi/jPfibl4?=
 =?us-ascii?Q?Z4eAhHqDaeMndt3vORWu4V5fRypQau04TlPzE/VGDABCJwxXDciVxKU+jZl6?=
 =?us-ascii?Q?clJ2dMHNVwUMNN92McMdOJriNNJXJCQR714IbnZs5Cd8UIRnhchZ01AaaUUK?=
 =?us-ascii?Q?OLmotMQSFXVmfmA58NjeR4tndYByw1xnJD37ESiO11ALCpGjM4ZDcNUpRQVX?=
 =?us-ascii?Q?wAjbofxfI1Tf9Z3xrhvMeFsfu6jU93bx58Jo/zEkqNyr+rFE83AfJ5yVvkeE?=
 =?us-ascii?Q?6/TMpvtrnGyjF9ufwqUhxIF7BTf437mWqPxYcRJ0ddc1dXMYRgLN+u9H/X8U?=
 =?us-ascii?Q?7yixsfOmcnCpLBWF2H8UjwQI1EV5aMq73jlBMMiBmNM8ERmchn/77LORW2QF?=
 =?us-ascii?Q?8042+IH9bQ5ITkfkvh7ruqIi/gXFl3CcG+iuoiEht2P+P+VqfEdGH9LLEGGS?=
 =?us-ascii?Q?jg6zqxKVMarCdmOXPkOzDHH3MxhwcQxyFsAo79zv9GcLVrAX1PUPlQklNJvs?=
 =?us-ascii?Q?AB1i1Rilz6ZDAXc16F0Y/9DEJFE5ioIKDuotdyNz2eYlROxlfgHF9i54Li21?=
 =?us-ascii?Q?yJOvmrUZYQVFglNrMIwuKRNi4jCgUSIgAad/q1o5Ph7qpXFoIYCvFfublGkI?=
 =?us-ascii?Q?akGEg+6it+2EJjhXSeldAKqxn2LRTbutpA2IkMyUzZVraIS0+StnMLpoYF23?=
 =?us-ascii?Q?u80TBIh9WHQ2b9hwGUvTJFu5s7sb+5t7YXb6c9G/PwpH3Ii/0TjhKDspMN2u?=
 =?us-ascii?Q?kFhLTrU/xh1B5VRVTUNFbXXoBQ4IL1FVtiKpPkzsaHdETRpmn/7QYOoLDbE3?=
 =?us-ascii?Q?rfmcfXLyj/bUFxg6uRHvtB3DFJneYnp7D1zWpGhHwdytbm0q7/xPJfTfBVgf?=
 =?us-ascii?Q?D59dsPv6b288fF6hJcQUttGe0BVfM5H2Bl6aYJvbXnKR7ChpntcAPkhr4NiK?=
 =?us-ascii?Q?YwczmNxb79xZ5Jkp7woD13uWtSLmxnSqw+3KpDbrLJFQnuzSonT97crIQE6H?=
 =?us-ascii?Q?6DiUamDYfHw5f/plwAwMKQcf2iURS16W2IO/tKAfawHr6CdkNS3Q5K4Y6Zj6?=
 =?us-ascii?Q?xOiZJ2qF2OoyOfbjJcs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:42:46.2447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c98da3a-eaaf-444b-e842-08de2099b47c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488

Drivers might need to access PCI config space for querying capability
structures and access the registers inside the structures.

For Rust drivers need to access PCI config space, the Rust PCI abstraction
needs to support it in a way that upholds Rust's safety principles.

Introduce a `ConfigSpace` wrapper in Rust PCI abstraction to provide safe
accessors for PCI config space. The new type implements the `Io` trait to
share offset validation and bound-checking logic with others.

Cc: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs    | 41 ++++++++++++++++++++++-
 rust/kernel/pci/io.rs | 75 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 410b79d46632..d8048c7d0f32 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -39,7 +39,10 @@
     ClassMask,
     Vendor, //
 };
-pub use self::io::Bar;
+pub use self::io::{
+    Bar,
+    ConfigSpace, //
+};
 pub use self::irq::{
     IrqType,
     IrqTypes,
@@ -330,6 +333,28 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
     }
 }
 
+/// Represents the size of a PCI configuration space.
+///
+/// PCI devices can have either a *normal* (legacy) configuration space of 256 bytes,
+/// or an *extended* configuration space of 4096 bytes as defined in the PCI Express
+/// specification.
+#[repr(usize)]
+pub enum ConfigSpaceSize {
+    /// 256-byte legacy PCI configuration space.
+    Normal = 256,
+
+    /// 4096-byte PCIe extended configuration space.
+    Extended = 4096,
+}
+
+impl ConfigSpaceSize {
+    /// Get the raw value of this enum.
+    #[inline(always)]
+    pub const fn as_raw(self) -> usize {
+        self as usize
+    }
+}
+
 impl Device {
     /// Returns the PCI vendor ID as [`Vendor`].
     ///
@@ -426,6 +451,20 @@ pub fn pci_class(&self) -> Class {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         Class::from_raw(unsafe { (*self.as_raw()).class })
     }
+
+    /// Returns the size of configuration space.
+    fn cfg_size(&self) -> Result<ConfigSpaceSize> {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        let size = unsafe { (*self.as_raw()).cfg_size };
+        match size {
+            256 => Ok(ConfigSpaceSize::Normal),
+            4096 => Ok(ConfigSpaceSize::Extended),
+            _ => {
+                debug_assert!(false);
+                Err(EINVAL)
+            }
+        }
+    }
 }
 
 impl Device<device::Core> {
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 2bbb3261198d..bb78a83fe92c 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -2,12 +2,19 @@
 
 //! PCI memory-mapped I/O infrastructure.
 
-use super::Device;
+use super::{
+    ConfigSpaceSize,
+    Device, //
+};
 use crate::{
     bindings,
     device,
     devres::Devres,
     io::{
+        define_read,
+        define_write,
+        Io,
+        IoInfallible,
         Mmio,
         MmioRaw, //
     },
@@ -16,6 +23,58 @@
 };
 use core::ops::Deref;
 
+/// The PCI configuration space of a device.
+///
+/// Provides typed read and write accessors for configuration registers
+/// using the standard `pci_read_config_*` and `pci_write_config_*` helpers.
+///
+/// The generic const parameter `SIZE` can be used to indicate the
+/// maximum size of the configuration space (e.g. 256 bytes for legacy,
+/// 4096 bytes for extended config space).
+pub struct ConfigSpace<'a, const SIZE: usize = { ConfigSpaceSize::Extended as usize }> {
+    pub(crate) pdev: &'a Device<device::Bound>,
+}
+
+macro_rules! call_config_read {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) => {{
+        let mut val: $ty = 0;
+        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, &mut val) };
+        val
+    }};
+}
+
+macro_rules! call_config_write {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
+        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, $value) };
+    };
+}
+
+impl<'a, const SIZE: usize> Io for ConfigSpace<'a, SIZE> {
+    const MIN_SIZE: usize = SIZE;
+
+    /// Returns the base address of the I/O region. It is always 0 for configuration space.
+    #[inline]
+    fn addr(&self) -> usize {
+        0
+    }
+
+    /// Returns the maximum size of the configuration space.
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.pdev.cfg_size().map_or(0, |v| v as usize)
+    }
+}
+
+impl<'a, const SIZE: usize> IoInfallible for ConfigSpace<'a, SIZE> {
+    define_read!(infallible, read8, call_config_read, pci_read_config_byte -> u8);
+    define_read!(infallible, read16, call_config_read, pci_read_config_word -> u16);
+    define_read!(infallible, read32, call_config_read, pci_read_config_dword -> u32);
+
+    define_write!(infallible, write8, call_config_write, pci_write_config_byte <- u8);
+    define_write!(infallible, write16, call_config_write, pci_write_config_word <- u16);
+    define_write!(infallible, write32, call_config_write, pci_write_config_dword <- u32);
+}
+
 /// A PCI BAR to perform I/O-Operations on.
 ///
 /// # Invariants
@@ -141,4 +200,18 @@ pub fn iomap_region<'a>(
     ) -> impl PinInit<Devres<Bar>, Error> + 'a {
         self.iomap_region_sized::<0>(bar, name)
     }
+
+    /// Return an initialized config space object.
+    pub fn config_space<'a>(
+        &'a self,
+    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Normal.as_raw() }>> {
+        Ok(ConfigSpace { pdev: self })
+    }
+
+    /// Return an initialized config space object.
+    pub fn config_space_exteneded<'a>(
+        &'a self,
+    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Extended.as_raw() }>> {
+        Ok(ConfigSpace { pdev: self })
+    }
 }
-- 
2.51.0


