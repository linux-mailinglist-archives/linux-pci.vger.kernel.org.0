Return-Path: <linux-pci+bounces-40210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E7CC31616
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 15:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0F0188ABFA
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 14:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DEF32A3FF;
	Tue,  4 Nov 2025 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nGD304Q5"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFAE32ABC1;
	Tue,  4 Nov 2025 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264999; cv=fail; b=nO9ILQ5+YtElWKweqWzRAi8vhO03mI3YmOlLfDvdSrrN+0ucr2x2xRLT2Oxnwtq3SSU8ZAJbp/0ndO9qL3DbxbfSRp52+4OCWMGAK6nYrUF5pGUZgKIrKU4R6fh+6cGbT/OyKyqyMY+Y4HwOw23g/65mwRJR9WvJndVvHY06aeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264999; c=relaxed/simple;
	bh=hias5ScZwlQTAfM7AyxSX1r5HSWoS05gYshDCTYBAU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geR/L2fdGLNnmGqkOPC8nuYuGmPmR31vsMHVw6FS2e00JM7MqFHuVK6u19Aguk18rQGdv54XrWkH9A6Ogb3wFgLOnZ18GLYNe3AxhjlUKGat8RZ4u8sSfk1hOQIik0Qsj4C/TN7K4oLnl+QAi/YDrlk9esaYimp3M3+KTDRLOsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nGD304Q5; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCFKZ1nfYLuPv9sRAh13EQjezHvm0/puCuMbRo7CCUQYdtHbvwUygGyuTfz0QtBt9mkzw75eWHHLbfzoBNDGulBaH8BKgMYY37tY5MG9WYGMuVP/bLHrSiJUO+o94wVnVXhxy3UawbipZ2258z0Jq7o8dJ+mqjSzP2ED8jeCcZsYf5Nfq7ohTbY12zToWmC7j7liyhgun0Qed5t9TF3x+h9Sep5an+PCPc0gD+1RqVftMx8VzWbJv8n+eYpobxAZ4d9AYa9xI3ATsjky+EfXOFfj9b2/4Ds2qDxUWJCU5VSBZi1S7ht5bShcvfNgXaee1Jn/Kj0Scc0tBgSgj2yLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrvTj8zDL1L/F1mrTFcIMVm1etwwUp3nfsuT9XwljkA=;
 b=jYzqmhLnYWLWS+RPOelOm5cIggJIQkAZj9YkbxgZI7CYNoNoMGJGJv83uPrWw842NkULgBqyJtEWNQtkkEPs0R0oG1U3LLjqTcANLz+RyYa6+a6JCgYfyRQ6YFQZCzGEsPRYiNvMlNPM7ChhW4f+J8bhmtXgEbbwsDjpFVldE/5AIGDh/7U5F5uFSjU4h4nF09g4fcwGws3xlMvnP85IiqVR7ayIN3dRc+74wZ6JnS99GnRWj1kYB+HktOhpzlBMSID/RWnUhucc0ptDQ8Wd2OGeMJwgt6CKeIEynAly0BvUpX4nnq/kBfmyLu+N7abz6RglKNYXYbR7p2EHiqeVJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrvTj8zDL1L/F1mrTFcIMVm1etwwUp3nfsuT9XwljkA=;
 b=nGD304Q5gXzPOU413nXREtvbKIPNzqwSYLT8VMH6yH/r+YwfGcZ5BuKPXdAqT4i8TCS0JXTwsXDPl/kPpX476rp5+2wx/76zB9VhgQnPgK2HGQrAJY3Heo9UQKlK1j3CgeocUIGR82KRh7NO4+/VdSHXT5ElpzLWmeqtVF5RV45OJwpZkXqwe+P3b0UATC2b+enimxbHdq1slt3wnvWdN3DLX/NHwMaxq5F5TLjV56hINFaLbTZAoOasZSkjxOjJQ5C48n2IDh0UiGjCF5Tel5f1gLM9uzXfMJsg7Xuf21KzLlP+yXRFr8v+BLPnoF7BZDzeSwBOAXKdG0qVV/rlMQ==
Received: from MW4PR04CA0340.namprd04.prod.outlook.com (2603:10b6:303:8a::15)
 by BN7PPF9507C739C.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:03:00 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:303:8a:cafe::85) by MW4PR04CA0340.outlook.office365.com
 (2603:10b6:303:8a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 14:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:02:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:02:45 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:02:45 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 4 Nov
 2025 06:02:35 -0800
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
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, Zhi Wang <zhiw@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v4 3/4] rust: pci: add config space read/write support
Date: Tue, 4 Nov 2025 16:01:55 +0200
Message-ID: <20251104140156.4745-4-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|BN7PPF9507C739C:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f407eb-040b-4767-b58e-08de1baadcea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uc4kZujLceF4F+9Lpj76fl36AbmCPONJ5orJhesnwY8Ab7Ytg7AGLJj0IDcA?=
 =?us-ascii?Q?WlGrTiMmBgzYW8P/royAAjubQivQ+PX4FaBMhQMooJEPPLIyBvcQ9z8oLaNH?=
 =?us-ascii?Q?FYYxGQxLFBygFkar+IgJoVcx6+C8TqRCE5Ea/J3j7Gxc3q1/Ah6OJtGChbhs?=
 =?us-ascii?Q?cY5JIeHvA/hVmTuOC5GA9G3c5CW1pOZDZQTq9yEGoofN7L/6dcR9qgG15lq4?=
 =?us-ascii?Q?1PmATKI+J42bfUHaaYVef0npnyvi+AgHNYvw7tgOJRgI+i6snXetkSdRFgEI?=
 =?us-ascii?Q?JtOSYaMLa+Byjvk6hm4fKnMuCxRNzZ2HbRakbHYRTnABbQqrSUdDlWaq93n8?=
 =?us-ascii?Q?xlLJeDpBxn5D+aF0vduAirfSGfOKRUZyam4o7ZUcvXsM/7Io/c8z9Y2k6ur8?=
 =?us-ascii?Q?uTatrFR8C3UQM+Pn+PZonq2VKqNB3aiiWVgnhCvm8V58omCT6xZVfZxmbkKf?=
 =?us-ascii?Q?PDsBwUr1+/bkyi02rm58A1O1gjTZ/mu5ige8R7f/NFsuwHhB97dv/WcUtltj?=
 =?us-ascii?Q?runwr8iGqUWRoLXIukBvIMZDuz+Uoq7qOzf5zlrcmpKwziooDq4rZUqWs/y0?=
 =?us-ascii?Q?vsK3ANTP3N4nghSBmrsp8yhHhydiXN1tcuPnR+Tv/Ny4pooB6Go4OnkHfW8u?=
 =?us-ascii?Q?m4xeCG4pzVpp2OiFCanoQHL3sbAD9YJrZnaNa5ZVEKktnSfF9lUlU1j4RXSb?=
 =?us-ascii?Q?qYJVMqjzGYxjdeCV53NIwY/jSOm8QTh6/6/rY3SoqAlfSKE/wTe1l+EqGXa1?=
 =?us-ascii?Q?pEcoCHmsGUa+2r2Ft7HXBKkOlTmpkRwEU5FBtFcUeFFnc1sEoIXDN1cAygrh?=
 =?us-ascii?Q?VARGZrCfkdP892v5kaODvW3VvkKIe/0cGlNDaWiqZ9jEo+Cz++P3DJ28g2Zc?=
 =?us-ascii?Q?56ZGbcdwKye5HAlUh9nTErQFn0GEK7N6l0ppT7MrfKZgnU1DakW8kPiMsw/R?=
 =?us-ascii?Q?IkhBGVttcxUrU9ICKgnMF8J7hnduSS0FWAKT3chH9CY78bGO9go8Ax1gGfE4?=
 =?us-ascii?Q?bPBICwqmflreaIWZeZPjrouCsA1CgUOiBLDVNcwoqZV4EFRAf3a7R/vSMGlR?=
 =?us-ascii?Q?d3n3y4tnZKJPjf3VgJ6VU/vFYtZIxgM4FHU7obvhWz1ndurIeKpdJoiKSeAd?=
 =?us-ascii?Q?zDadmfQ6ASNK1rhCUJJMwog6cQDhELZmxNKuJ/IrH/LCn5lil62K+6FFN7/a?=
 =?us-ascii?Q?MTEszAXB+jTu8QtCdcIOlx9JaLSV/H5LHGRoHUOgQdBnk6SbI1/RYm+sxguc?=
 =?us-ascii?Q?2o0TPudbnjjNTi8f26S8T+FkmWdMUcDCJga42G2OtbhPthGCeFxWll8zpk1W?=
 =?us-ascii?Q?vm+ddEUZiI3hPEbhZ6cV07CTab/wLcnnkzkQTrXufsWVvNlPxUckZhw+5Qjd?=
 =?us-ascii?Q?MH/FdPkHux9441FQPVaeBP6KxeXFVZOo46WeS+HEy4RqVto+sM4IUKZ2rxwH?=
 =?us-ascii?Q?LySQpLptLAEDg3hgiw0/1WVAHJI2x81SdmR0AuqGLv0JK8NnI27ca/d7ZPcD?=
 =?us-ascii?Q?DjU5H2QcJXS7s8mjC1mYIKdAwkI95eU1i/WrOf5XrUTynIRk0n30GnU3g5vm?=
 =?us-ascii?Q?sRVB5rC3/ezvQ2pZaDs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:02:59.6569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f407eb-040b-4767-b58e-08de1baadcea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9507C739C

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
 rust/kernel/pci.rs | 148 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 142 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 77a8eb39ad32..630660a7f05d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -5,13 +5,31 @@
 //! C header: [`include/linux/pci.h`](srctree/include/linux/pci.h)
 
 use crate::{
-    bindings, container_of, device,
-    device_id::{RawDeviceId, RawDeviceIdIndex},
+    bindings,
+    container_of,
+    device,
+    device_id::{
+        RawDeviceId,
+        RawDeviceIdIndex
+    },
     devres::Devres,
     driver,
-    error::{from_result, to_result, Result},
-    io::{Mmio, MmioRaw},
-    irq::{self, IrqRequest},
+    error::{
+        from_result,
+        to_result,
+        Result
+    },
+    io::{
+        define_read,
+        define_write,
+        Io,
+        Mmio,
+        MmioRaw
+    },
+    irq::{
+        self,
+        IrqRequest
+    },
     str::CStr,
     sync::aref::ARef,
     types::Opaque,
@@ -20,7 +38,10 @@
 use core::{
     marker::PhantomData,
     ops::Deref,
-    ptr::{addr_of_mut, NonNull},
+    ptr::{
+        addr_of_mut,
+        NonNull
+    },
 };
 use kernel::prelude::*;
 
@@ -305,6 +326,83 @@ pub struct Device<Ctx: device::DeviceContext = device::Normal>(
     PhantomData<Ctx>,
 );
 
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
+    pdev: &'a Device<device::Core>,
+}
+
+macro_rules! call_config_read {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) => {{
+        let mut val: $ty = 0;
+        let ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, &mut val) };
+        match ret {
+            0 => val,
+            _ => !0,
+        }
+    }};
+
+    (fallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) => {{
+        let mut val: $ty = 0;
+        let ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, &mut val) };
+        (ret == 0)
+            .then_some(Ok(val))
+            .unwrap_or_else(|| Err(Error::from_errno(ret)))
+    }};
+}
+
+macro_rules! call_config_write {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
+        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, $value) };
+    };
+
+    (fallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {{
+        let ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, $value) };
+        (ret == 0)
+            .then_some(Ok(()))
+            .unwrap_or_else(|| Err(Error::from_errno(ret)))
+    }};
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
+
+    define_read!(infallible, read8, call_config_read, pci_read_config_byte -> u8);
+    define_read!(infallible, read16, call_config_read, pci_read_config_word -> u16);
+    define_read!(infallible, read32, call_config_read, pci_read_config_dword -> u32);
+
+    define_read!(fallible, try_read8, call_config_read, pci_read_config_byte -> u8);
+    define_read!(fallible, try_read16, call_config_read, pci_read_config_word -> u16);
+    define_read!(fallible, try_read32, call_config_read, pci_read_config_dword -> u32);
+
+    define_write!(infallible, write8, call_config_write, pci_write_config_byte <- u8);
+    define_write!(infallible, write16, call_config_write, pci_write_config_word <- u16);
+    define_write!(infallible, write32, call_config_write, pci_write_config_dword <- u32);
+
+    define_write!(fallible, try_write8, call_config_write, pci_write_config_byte <- u8);
+    define_write!(fallible, try_write16, call_config_write, pci_write_config_word <- u16);
+    define_write!(fallible, try_write32, call_config_write, pci_write_config_dword <- u32);
+}
+
 /// A PCI BAR to perform I/O-Operations on.
 ///
 /// # Invariants
@@ -418,6 +516,19 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
     }
 }
 
+/// Represents the size of a PCI configuration space.
+///
+/// PCI devices can have either a *normal* (legacy) configuration space of 256 bytes,
+/// or an *extended* configuration space of 4096 bytes as defined in the PCI Express
+/// specification.
+pub enum ConfigSpaceSize {
+    /// 256-byte legacy PCI configuration space.
+    Normal = 256,
+
+    /// 4096-byte PCIe extended configuration space.
+    Extended = 4096,
+}
+
 impl Device {
     /// Returns the PCI vendor ID as [`Vendor`].
     ///
@@ -514,6 +625,17 @@ pub fn pci_class(&self) -> Class {
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
+            _ => Err(EINVAL),
+        }
+    }
 }
 
 impl Device<device::Bound> {
@@ -591,6 +713,20 @@ pub fn set_master(&self) {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
         unsafe { bindings::pci_set_master(self.as_raw()) };
     }
+
+    /// Return an initialized config space object.
+    pub fn config_space<'a>(
+        &'a self,
+    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Normal as usize }>> {
+        Ok(ConfigSpace { pdev: self })
+    }
+
+    /// Return an initialized config space object.
+    pub fn config_space_exteneded<'a>(
+        &'a self,
+    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Extended as usize }>> {
+        Ok(ConfigSpace { pdev: self })
+    }
 }
 
 // SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
-- 
2.51.0


