Return-Path: <linux-pci+bounces-40489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DEDC3A48C
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 11:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 812D5500844
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 10:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12B62E7186;
	Thu,  6 Nov 2025 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ehgZK9pI"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF57E2E7199;
	Thu,  6 Nov 2025 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424977; cv=fail; b=p2i9bA312pLaNjTB0AIoS8Q0Xk7ML2n40w4fxKscmk/rbxxCnsT3yzclRMHIFVzvPkDr69aNNGYUbOTZCid2vYgJ4obt2d77iUPDNrAuR4X1G1etD1nR7lYdlM1bt1AP8fK5cfPhj/cuf0vc5UKCgp8BivMNLyBOqg+GVNdqwl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424977; c=relaxed/simple;
	bh=qKDCT6Fot5kl54evkbyTZBLuEQHU8xgLMuqpN44Yy38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dn9zg9pRBitT7viy8NPLQ5l0930mm0cjGGJSzIPI+eJVKRdssh3I5mmQ1ZIB1xJCRq/ekfJBx9gK2D97vvNo8jUwZWffjlqGgAPncy/5klWzVSjJc7lAcvZr8//mQJUxoW+vvNbi1sJZCyntmh4V/PGYo4rs2Npa5urI4HbTmsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ehgZK9pI; arc=fail smtp.client-ip=52.101.46.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bv4NkRNe0PA9T1N9oZtEw+xgio9Fw7kEP9ana7yY+j1idVjdMWt8cajuYqyBP+XEVdeucoW1FvdrjWZT2l9VP9VEJop5AHvLImbUCuF2ISpbUBXxoZrm/EvmGva6fikRblqRU1H0UVay5eyGoTqyO7H1ZWEi3XKACpPx1t3rnnv2LJDsf97SfE9dj2+Yn0hs6QApTvYKkSnJdBMp0F+x+Zf+rb+rhY+rsrvmM/Q+KDWRv0tavYaLEek47jMpzFwAq7nk/vAtnSXdoUexiiKq7jFmSUvsGK6WA8iD5c8uOs91P3C5rPzZmnW/27946qs3AXjxCGjWDs4JVt8VBorfzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tx0ay8hk//g5AWfF2x24wcJ2+KfbskWCXsboIWUQ+Y=;
 b=sKFn/qpUkWOiF/Fzm2p3YYbKhnJQ/mTk+dZsPaGP9OjceILICbtr0JFkJGLiiOQZWEaqIC9hB+hgRMVC9L/lTSW0ImqBIcjWtOubVzIFqO3KpOGkgttgAb/nRg2VIvMCz5e49eQ/tpvDlnELp2RqShwJ+bW4GMoac8OFAeotkc8OJtiWIV1K37pWj87dlsnMt/X784UC6LZqJTI1j82c5kDduiy2yB0fttYcZxiL96m3OOb80S2lf+SWzAnf0CUY825zWUJsmRNr+vMYvFerv9JrSt+2sxZoky+7scaBV9lH8fXIxQoZGnOY7A+R7wtyd2lBUD25dTa6g1UkYyexZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tx0ay8hk//g5AWfF2x24wcJ2+KfbskWCXsboIWUQ+Y=;
 b=ehgZK9pIq+mveNbp7m2N7P3JAkOvXiDIbjO7PNfLDICgDi0GnKmJLZVGLuViSO5LsRE8Uv+VYtOE66IEn3nkAWc4QTmRutABvO5JjfoQ2wBrUfVpXj4CFHNjvNn+Eu3aZp1YmvWsmIhURaMstBoTiPUB1424/sq5H8BihfQDRNvca0sMaXPshi7KiYSH+0Qte3JyGN1g/vLzkG5aLnI/5BEUR6hIp5j69OcBPBZrcKJA4Vt7GxDT2MNK+3U/8YKRxqmuglxMZ1AneKGi2g6/2XqEQoRc4zi3dmYRWkpn/iD2TkFMsD5HAU6X1HPnBU++Lbv5DOf3gYurNgx1tuEwRw==
Received: from BYAPR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:74::20)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 10:29:31 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::f0) by BYAPR05CA0043.outlook.office365.com
 (2603:10b6:a03:74::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.6 via Frontend Transport; Thu, 6
 Nov 2025 10:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 10:29:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:29:18 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:29:18 -0800
Received: from inno-vm-xubuntu (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 02:29:08 -0800
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
Subject: [PATCH v5 6/7] rust: pci: add config space read/write support
Date: Thu, 6 Nov 2025 12:27:52 +0200
Message-ID: <20251106102753.2976-7-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3ab7ef-7e10-4f20-c4ef-08de1d1f5f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QONL+4d+op2oqinNNc0XKYASABocY/PVmyu8STBHWQqNxKG3MA2c572kpnUf?=
 =?us-ascii?Q?lBypVNIhVqWKrzp8eEF6hzLU5DcM1akFKFhnlcSPQ5OpgZBecYP+QraqHzPZ?=
 =?us-ascii?Q?XNhfmQa9K43RBicvQfy/v7BzciBzXEyDrTvV+07UOB5CwxtiG0FT0STe2EzQ?=
 =?us-ascii?Q?l6p7hDS2tU/exdagfdQzNuXpaK+EbOBeX9ubXmTdMgduKIOf76iEHp+Hki1t?=
 =?us-ascii?Q?yhulDsdxo6mYUbTpl7bmT6csJnVS+TstL9iRtgCJSiPUqjqL7ivuVhEPrBzc?=
 =?us-ascii?Q?K7wF87LjH2/d3b1kx/7ClUXeEs5pbgoXUdqrykDkYSYpVlZUidaXs/5toQrC?=
 =?us-ascii?Q?hQTJvmeNr3oXawGASKE1eR/u6RqrpIV/Ko1AsI+mIpRHxNliCRofd81UPTTe?=
 =?us-ascii?Q?BHuhlTlOomvHxmjBNmTjn0M1z4VsmrKCTvh0xYMkVTkY6brrNdjLKKJZ2tXy?=
 =?us-ascii?Q?WGZDN4i+Wfw19E/e9V3lM585KNw8KZrRUjIE+ng/6NzTGwhhVdZVEP942Ohp?=
 =?us-ascii?Q?HEgrb7eg/kYLC4iVmApi0xl/yzwJWAXUaMcexBGIm1vW0ldYWBdUzEPJAhjh?=
 =?us-ascii?Q?SzUZWL5ZTvS9eMLAZcLUP2S6I3UrJN5E7n8wNP2MLXCuvafOY41KWUgWtE/6?=
 =?us-ascii?Q?oht6FGP3C8kFZzP7RtDOK09aGlYgU/Wm0P7EYxD5msFuqgnE/Il4X7goGF99?=
 =?us-ascii?Q?RWTMhUzpD+O9Eh/Cod9T9FYJR3sj3908jGZBinmerkflxJDXgLyoUoGJyIuQ?=
 =?us-ascii?Q?cXaSXmz8mQoNV71FtDHHzQoWtg7m9KPVkN170//+2FrYZHJhmrMt81v5BNHS?=
 =?us-ascii?Q?wWRmoUgJLaYf7drqFt6+AA+jr1AHvj+D1/BlW4Mar58wwgaF2B/D526U9AkR?=
 =?us-ascii?Q?A6TYQqzMnBJA4Wy3iKoCm2rz0MgVuJRkT+4OpYYi2RtbGVl+I33b7/IurhqX?=
 =?us-ascii?Q?VJ28XkAq8jpqYyiLcCDURvRhyb1wKu1kQM6AliZs0XTDAPBm1skPGkKKhDpy?=
 =?us-ascii?Q?NX5pA1I01uWb5Ch1c7njkpMRvdzQFqD99VLqlayjPMJIj8sG3cFy9K9Tb8kg?=
 =?us-ascii?Q?Ek+bMEL3htCng5RU7EDh2eZfEl7uk2XC6aimk40Vhh5BTo6luLV+0QdeEOBN?=
 =?us-ascii?Q?FMxNQlZ0RIwhM/jC5+6Diaojv6ZgDaX5vYFm4FSaJynS0cYueLHwB+e9ucVi?=
 =?us-ascii?Q?1rP7wJE1X2iry3OSFrYwUp6ZkgV0ZRXgObyYKlEeQleqGd5/jsivErvI0Dwb?=
 =?us-ascii?Q?taasPsfVsuGxhi7Memm3aBRJk/oMTnfHrRcWRhV8PEAZxlL4cqbq6JeC2x/d?=
 =?us-ascii?Q?1BrZfRQhCwPCSTO3Z0XUlJZUcXKu8ORI2r1EG+CPSp1cHuE8ldeuG1RS99FQ?=
 =?us-ascii?Q?XPKzZPCm+OQZKM8+KtRAoxo4D7HdowzsON2TjP1BUQ/VtMXQntrc9TzL2o1N?=
 =?us-ascii?Q?f8w3eAM+hGZCYE3abDjYhBn5EyS0ufeKnUsnwY6vTsDcb0ogy2gfWu7Kqa7e?=
 =?us-ascii?Q?x7/7VwbMhw30X0h7zhKk1Gy/pZoOGe4sOdRhHFDZrZRQEpdi5ZYkYw1Dkw0q?=
 =?us-ascii?Q?0A809adlBXKxd/nCWYg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 10:29:31.4060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3ab7ef-7e10-4f20-c4ef-08de1d1f5f5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461

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
 rust/kernel/pci.rs    | 55 +++++++++++++++++++++++++++++++++++++-
 rust/kernel/pci/io.rs | 62 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 410b79d46632..0b8064d6c0d1 100644
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
@@ -441,6 +480,20 @@ pub fn set_master(&self) {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
         unsafe { bindings::pci_set_master(self.as_raw()) };
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
 
 // SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 2bbb3261198d..a9895ee2c5c8 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -2,12 +2,19 @@
 
 //! PCI memory-mapped I/O infrastructure.
 
-use super::Device;
+use super::{
+    Device,
+    ConfigSpaceSize, //
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
@@ -16,6 +23,59 @@
 };
 use core::ops::Deref;
 
+/// Represents the PCI configuration space of a device.
+///
+/// Provides typed read and write accessors for configuration registers
+/// using the standard `pci_read_config_*` and `pci_write_config_*` helpers.
+///
+/// The generic const parameter `SIZE` can be used to indicate the
+/// maximum size of the configuration space (e.g. 256 bytes for legacy,
+/// 4096 bytes for extended config space). The actual size is obtained
+/// from the underlying `struct pci_dev` via [`Device::cfg_size`].
+pub struct ConfigSpace<'a, const SIZE: usize = { ConfigSpaceSize::Extended as usize }> {
+    pub(crate) pdev: &'a Device<device::Core>,
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
+    /// Returns the base address of this mapping.
+    #[inline]
+    fn addr(&self) -> usize {
+        0
+    }
+
+    /// Returns the maximum size of this mapping.
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
-- 
2.51.0


