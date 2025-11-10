Return-Path: <linux-pci+bounces-40774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34136C493EC
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 21:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69FE1890AE0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4B22EDD50;
	Mon, 10 Nov 2025 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hHgN503H"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010043.outbound.protection.outlook.com [40.93.198.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2492F1FEF;
	Mon, 10 Nov 2025 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806674; cv=fail; b=GDp+QHS3z2q45gYaNrnh7iLFy0uSfdfMV0Sah3GZ9lIFR/a9ZPv+Q+W8Xh1u7FS909liSQM8Nh3/zBlUYr+yrnKBnCGKJx/0hUW6r6kZ1sq8rPcSDhSJCoFFblkgpOSRxECgjwhhTxmfy+I/gAguj0DRQbQ2XezgBTLsvlWlUr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806674; c=relaxed/simple;
	bh=zt4NByBYsQbTKmEppLpWCxINSBnAgfhYJ+22IzRknc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fArv0gHN1aiM/6wtj1fVMOrL+wSkZBTEIDWvBwX9+CZGCniup2D66gwAkWDQ1cFVyu64KoSJZGZXDiUoNoWVNQoKelZ3lEmxEx2lAugZEmnRVuL37qZEVgPGcZ+GvK+krWoWjDedFxZaEg8Oa/jZeY33CbJ/imdKHbDGLWWX+48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hHgN503H; arc=fail smtp.client-ip=40.93.198.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ml0uxQ4WXfO0vRDCw934dq8yxuwCEMfAeb/vus5rZ8LWsDJnNYnT0jq7Tb5Qvk8UKUcvedYNXOqM6klJivfRExudQ9fO2BZYc2uQ/UAdTynY48ubZeCMYWS5SA6XQK6Z3EGzDmKqvRulmWkxNq8aPSNjIHWb2hKTUCptFCKZYZ1IYLe9T1M1intOxWRTibO63T7/4PhiDdPkAyzZgFwxz8WP8dp/acn3w2zqtiI47MtmXdhFSmf9vd1DtieJNVaomkTcCHQ4sf1/+iPHK6K/D1eZsfNtF8aq1rRbygyAfgNshzs2cESXkQPkXj/QGTAxQWeFtWNf4FOsbVPBUvPPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3nz0pMo4LlshKiXjVTfZ56/qt3kMs1hfF24DzcSvGw=;
 b=gQ5DdgZ3/bGWfIna0HTmq1eLqGVzlQkB9zfVc/bNeDZslfUNI+VgjWExLGz5bXG9z9ZZvD9Kq+glWUo3hxZjgv4b05uItr/0HLQyOX91U13TIu1KVFR/pQK8w+XnolFwqnarogDMr+J8dSuKQES/KSzeopZz5QHG3dSB8jja4cgsWvowjhK5raV2VnAeOOSH58SOl7u2yjY8vqri78K1fGqyr7xQDpcuBvCu0cOtKMN8F2nA+kIjlVCH/SzeECk0cr3LMHB8TJKcQ7nUR8VINYV1OI5vTASJJq0pcoihU36TC+cT3vMH7cwwzqV0Um5C3NHC/JvAeUxmcgTQCh9F8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.117.160) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=nvidia.com; dmarc=temperror action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3nz0pMo4LlshKiXjVTfZ56/qt3kMs1hfF24DzcSvGw=;
 b=hHgN503HijgJNQGFMLwJOVKPl7PoN56wei13e/d+/wiDzAQNJAoJCTswCarTwhGxzIliA7KporFN6awLShxstKCiRP9x7z3o847I+R2B9qWpubGNauZUXhvv7vHZZVwOOQW1ZnprHEIm0qHROrAXr02SMikeIpZkxP4rbH9x7e5BGY75Rx+A0RMd2ncDXKfjygLO+3isFVDpMGccVWF96Ms7UpCCe6vCBXBjKxDKnvpldgBca2pcDQz1rV9FwZvi3Nrl9rUJwtSwzF8kxoK/fLXQSuU9mt2zR6IlkDDDptnv2yqLgxQMVeUdDX1Z6YqQ14L2gqaNYwX1pQ0TIsGYhw==
Received: from PH5P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::7)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:31:08 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::80) by PH5P222CA0004.outlook.office365.com
 (2603:10b6:510:34b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 20:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 20:31:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:30:45 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:30:45 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10
 Nov 2025 12:30:36 -0800
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
Subject: [PATCH v6 6/7] rust: pci: add config space read/write support
Date: Mon, 10 Nov 2025 22:29:38 +0200
Message-ID: <20251110202939.17445-7-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a150bb2-d6f8-4932-8e33-08de209813d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nE45wChIgbQeGdDmFE8DybtwIBv7nnvpOG+fL0KYw+hvwoR6Vz9N5JYRNX0E?=
 =?us-ascii?Q?MFKMscLRCWaFj3IL0mEakx+6IhWcXhjG1UFDrK4aNprhqpdTdo+OIAHVCB1f?=
 =?us-ascii?Q?wuWPK3mlBTO5RXcVNBmxcKd4WcZghvObXExq82wz4dHki0Dx1I02euMXKrNf?=
 =?us-ascii?Q?fnTYcHiZLwyVRGzgheHLxuDlSCnW5KKgN9JvES0qwn6Qiz+6O3KNP8c/DiHW?=
 =?us-ascii?Q?V1jM6bJDfQ1gtVWu7BURcjWltMNCkDUpDgymDsKEThTuxx1sjFF0NrxfBQTx?=
 =?us-ascii?Q?M9J3gbUClbL/jiUCcDYLa1BSmoAwDp0O3STjQsJXL7g+LBYaye6Xin1aYzls?=
 =?us-ascii?Q?A/aVlxvWfCK5TDZ7xKofQauaUDHVMf2Nl7GiJt2fV+e7z8EwNh6hYXBkBCb9?=
 =?us-ascii?Q?/4Io+E9dMEXCIj/orZYshzU4SUaiZRwXKzekJ1aI+ljTX4PMYv0zu1BIfKMP?=
 =?us-ascii?Q?YrAS7FsOcD6G9axHsPgB0hIFt6VzluJmyJiF80O+MQFl0HIU8baxItG7zEBt?=
 =?us-ascii?Q?OOjZ0gP0mkVbUg7/uZoZiU7b1Go6/UyrK+ih8iKr7sXkQwIfuESncGcZgWh/?=
 =?us-ascii?Q?MipnNMCV1bz4VhvSs07/Rr+XBb5KQU8a0SGMoqWjkqM6CQDx8/d13EyZnWDc?=
 =?us-ascii?Q?ha2F6sSrGDefE0taAYML2QNq/DkE4Z5ZenIo8uzwJpa2fWXi99R0r4AmJVe/?=
 =?us-ascii?Q?8CfxlwH9a706qh2XQcqe1SaDv34Tix+1yyV+7UZ3ChtM9DvFvW7AbZ0XtfkJ?=
 =?us-ascii?Q?9AdxXEaxriEHeC4bLMXDntAuWoWnFdzp0Jy/s4B93UuhR/U6+UwXYqjYzGfK?=
 =?us-ascii?Q?Fntfj50hsgMWru3rrnmOE0mvop3HpDQKhgdZ3iG42LlnMzOXg9QjHpc+xyMP?=
 =?us-ascii?Q?Gw8BGyyzYYD2s/SsRWUKt/7G+OR03YCABZoHa3bNZtqAB8uJcjcXx87d8uAl?=
 =?us-ascii?Q?q6+ea2IFB8v1+YjFin7tTYaCGaOS9wF4CFaJDJr9YywU1TIQ2XYJF+5APhkF?=
 =?us-ascii?Q?bru567KasBfUHhUSc6WdlA7hp5spfbfxkT1P41ftZPgRE4Vusj6ZXkWolqdq?=
 =?us-ascii?Q?9fnxNEMWeJw2V+BkpbGL++twya9WzQhxO/E4guNAHtzZ5olWbMlMDSZJ0bZE?=
 =?us-ascii?Q?bhsBrhXj413wQltuG9bgd5ev1YZFrbY1uxz19t9wL7/wuJCBKgEO4/pkf1qQ?=
 =?us-ascii?Q?Xks78F9xEFHXbZggAiKJDutkm57VKyxV7ekYg9LU+fCMKQPgGJdyM9sKxm0d?=
 =?us-ascii?Q?8ij5inkr4qKSIu7p9ZVawWk9eCSZcn/Zo3MvhqQZ7AZ8Qx4p0Ys2IyaFz/Zu?=
 =?us-ascii?Q?g5BR3wUFQ8Ap88BqPXjagX2/tam0pnvMH1BO1DUACyKcA3pMoSpQOQvUdYTj?=
 =?us-ascii?Q?oKtVV/SQxdaK+te7FiYbsYMdEFBvCHk0m2FSLXfOJXGx8cYLLvq2G6Zq/CYL?=
 =?us-ascii?Q?9EdBjGNQ+OlbRp3BKdVZ4uMe9HaIKR/yxFBK4QbP3KF1XWgvTJVN7rJxG3p9?=
 =?us-ascii?Q?QEiZFiehWS79V6mEV/aNctQyMX7RzjP5pv2jTpFfWR5tEW65Sqkocje+nxI+?=
 =?us-ascii?Q?vpi8JrMXKaH0Mmnld2M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:31:07.1518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a150bb2-d6f8-4932-8e33-08de209813d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116

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


