Return-Path: <linux-pci+bounces-40770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AED9AC493DA
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 21:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC3F1890593
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2935A2ED15D;
	Mon, 10 Nov 2025 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l5tpDY++"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857B223DD4;
	Mon, 10 Nov 2025 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806634; cv=fail; b=MUbRN3yzeXpaYxH0W9Bmlp5q7xsLRQI4+yzo6rnw8oKTcus7ZcudjuWkjYXlX/g0OChft9GMWVPeByvdMpUT11IphbzJLZx8blybk/PFD9Atodz3/IY/ZtzDHnoAmcBLq/aDmk763O3T6G7owpxcVFrhs9XrlQI6wZjNEktgZpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806634; c=relaxed/simple;
	bh=emr+ZECNTKSYbs7H6A+VaQ+fmNirzc2pYrtjYU1FMN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQDUEcpibydgbgXY1vDZlBVrCWXS9fAhnokPeEDCWIq3xR69koQtskJCC0clcDlEiin0uR5aBloxGVHjVVF32OV6Eim2UIX6uJ4QRLSbObnw8RsTXzdNvzWV2X227bNpt3XSpgs3nsGIsvDBQ+9k8zbl/vVhAJCm8vzg1CsKz2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l5tpDY++; arc=fail smtp.client-ip=40.93.198.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maAVe6TaQYbKhE6gFaySwwSHY+6/Q7dw0qa3ife2Y+DyMS2tUmPNcz2bjdh8brK8ZtMwIBBW1IzLldLrblGHTB1kT42VS0VHLFk+DV2uKjdmYyTHebtGOxu+Z406PsdawfrC6klJUvHMqczrjzo1QV/nVkMhfwtl9ndCPyYixS8Zg+oq+Pj7P0HU2DGb3SFHnQYtwj5yCAnxXFSzJE1QEN//taTUeqge799HZElH2BqSwcC/66L9SYkC7I5ssETxxz5pyo5TDx3Zt4BK656gtwgFbgHKNapacxKmUwDX1Idhp6UhEuIpt+tUXIlTsoHVtq/HZepcgs0tuKEoj1tKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghiaD9mWVVX9Vqwm292OsyP64F+aT2gw44nIcpAjtTg=;
 b=RvfJSa9oMjjOayAiv9bElyvGexgkbtyW5sGb4syyZa8Gg2rH+xmJdbo+ZaXk/aSC1vRjhOBi4R3U6sfJDg/rhnI+vVOTHDVFmxzuNtrY9K9vpnTqO5nwi1q0P2GwjCyceiSFatoZBJxRk8uNcdml1P9OyOa7akzO31+pEPr9AnWRDybz+FqIYOCHBy14+IFwIlRgkPd8slVZHpSAvTOkJZfoRNuXypDRBuyacG43tihagoSiRjZrHjc+Lbb7qvcli9HQX2Nq1CWjGJj4z0fYeRZqRQBbfBYFWLJmGgEAnRzZ7sLe1xzfElbX/oQM+H7gnmRp2tVGM9XIoFSc8t5eGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghiaD9mWVVX9Vqwm292OsyP64F+aT2gw44nIcpAjtTg=;
 b=l5tpDY++f4HXtsboEMuECe/C++CB6JcTAYZGJYV8LrfTIkCfYbSJwjHCvOT+qv2Wc0VreNcvcqwzqFC9v8gb8QHD9iQ0Rb3hoMyYSW573DdWTsetJNoO/Uqo+0EVNvLR+3XINF2gKP+DK4T8FjznhCSJv7emVTImXbhyL/Zb9YaBTipEDCRPPe5BLvgwcrCY0l8CeBVeE//r8hxWdjrxpErt5J6hIVO3c5vK0zmHELCL7s2mT+vglf9qfIc3AJg+7qqqhVgYCyTXtrHCtdYAEFU+kcF3CnOPnxPJXtlcRkP0LXwfkpE/soEGhvx0P6qxhZJjWRoCHzSPlsNTBHJmpg==
Received: from CH0PR07CA0024.namprd07.prod.outlook.com (2603:10b6:610:32::29)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:30:28 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::48) by CH0PR07CA0024.outlook.office365.com
 (2603:10b6:610:32::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 20:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 20:30:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:30:09 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:30:08 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10
 Nov 2025 12:29:59 -0800
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
 Wang" <zhiw@nvidia.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v6 2/7] rust: devres: style for imports
Date: Mon, 10 Nov 2025 22:29:34 +0200
Message-ID: <20251110202939.17445-3-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: c12b27f1-0346-41b2-1bd5-08de2097fca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UsqmOra6ou8Z3ehryg3HgsfkKPit8CI+JL3slDytqb8kMAQKRRZ+K9QfQr/b?=
 =?us-ascii?Q?3rHdRrDQKxHwIbJnYUpitds//IwHZToQL5u56Ln11K8ZaGzlakVKiI1ManBl?=
 =?us-ascii?Q?G5xc/S1sSx04OrhozdHs5skcKmSXgQdDvgA63QDoBnH23snL0pQnLNh5sV/f?=
 =?us-ascii?Q?wFJSbPM4lARTT8gBS25MeygvZrXaDvgEg260vtMJuBbContlobgqlXmjCnwV?=
 =?us-ascii?Q?Bj1jhc8jO4WmDGy/OenHgAOFqFNesUhcT0sZSBBzikyIUoEHi7mx7Ra7Lq6j?=
 =?us-ascii?Q?mfudiYNnvqowD6YRgw8Vrhd+Bpa5xu0GUZqFvAx28Fxs62Q48NZW/2BfSm3W?=
 =?us-ascii?Q?FwFSuDbnLVZ19y4Gn5cbOkhnGVLPwl/wpjwqhpFU91jZihiAPARJy+YnH7wl?=
 =?us-ascii?Q?w5vBtk7i/G9x92onErKVbU7cDt2bx5Kuh2bVurxOEz9gewXv7NqFd86dlo7+?=
 =?us-ascii?Q?MmqvbRzlnHvka/KOiEyp6US//ocZ2O/ftU12KtT6RhPflH41FSZoa/MeDfZt?=
 =?us-ascii?Q?KHYVA+QjW7J5RM85iewiSKN9u8snHl1vuESHHq0UO0fyKe/BKCW3E/WUaCK5?=
 =?us-ascii?Q?9nuKPGhcBwK3Bnarxn17BOHjoG3ZB8vT9W1bpRsdljY3Lv/WhpfKYnrcE5gk?=
 =?us-ascii?Q?nNDiYYn9rodkRP8lj3O0jhAcQGiGzYSjk65metXvpKe7WnN2zBrBvSzEHwSk?=
 =?us-ascii?Q?qxPZThbDtCLXQxWq55yBzkZ4A8RL4UTB/32PF+UMRvG+vcsMFb6ZfyvseSe8?=
 =?us-ascii?Q?Go7qR9f4LydUU3mob3jNPLcunW63Kj9C6ySGmR1hoOftkIm/xDQ0KlIm8/Fs?=
 =?us-ascii?Q?oevhAO4wjwWzAhd1df9AxX05Ka4m4FOEioBMmfdOIFIsolEhByLg+tNDKkgB?=
 =?us-ascii?Q?IuWsU15ikuAH0LNUqVbCBaDRF9P6M17thBuJSyUO1IZoZpFkLXgkJFy/KebB?=
 =?us-ascii?Q?6iK31MJPFs1jOjmiGGimQOZr/pqyiRD/yU6MBIwBB+z0rFh+bbIUwlQWsF5u?=
 =?us-ascii?Q?hLubawyWrPg6227BPyvXR0kZp3JJO0bF7p1S6GrkbYUPISA7dFNpaKI1xa3P?=
 =?us-ascii?Q?iXG1t/ViOM1YMImmKo32zwvcevsLGgM7cz9eiN2atooI/sgQmop6kTFcFP9E?=
 =?us-ascii?Q?EORv2f9MyAbhWgw30ZVGF9WKfUgSZOg1hOFPqDdktiG6A9Nlh+5Vx3opeOOs?=
 =?us-ascii?Q?Ji3b9/3qH8oqikdxzsjdv6WxitKI5fuCQOuFfUDbS3Cj8gadrfsWfjqab57q?=
 =?us-ascii?Q?8fLYZo1oPQheO2qosJiyGnxR+d9BIT3X/O0V4xLsUGe/oEX+WXTXaxUMVeVj?=
 =?us-ascii?Q?L562bi/o4FsPb5Ly0acG4jXFs7gGxBufuvfbvjBtkSMlcYGKAFNFWwQASgp0?=
 =?us-ascii?Q?/jRwW46yjdyRs/rdpebvU/bEY5tjlgqTT1cizaAkDR+sD33N+q2uhjbqgVOl?=
 =?us-ascii?Q?okYISWcomeqPqKsiOAVRuxnySIMd56H6ji6IRDjzyiqUkjW9Brr2DLOVVp22?=
 =?us-ascii?Q?vHEubvZLjZSZw3qyK+SZbymdgE92sOuF0Uz9YqnlbMU1HXY9wDmtzHK8caGn?=
 =?us-ascii?Q?8DsHhTBmz/nPTH+VX0c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:30:28.2464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c12b27f1-0346-41b2-1bd5-08de2097fca0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829

Convert all imports in the devres to use "kernel vertical" style. Drop
unnecessary imports covered by prelude::*.

Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/devres.rs | 54 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 10a6a1789854..9527f9b96c42 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -8,13 +8,28 @@
 use crate::{
     alloc::Flags,
     bindings,
-    device::{Bound, Device},
-    error::{to_result, Error, Result},
-    ffi::c_void,
+    device::{
+        Bound,
+        Device, //
+    },
+    error::{
+        to_result, //
+    },
     prelude::*,
-    revocable::{Revocable, RevocableGuard},
-    sync::{aref::ARef, rcu, Completion},
-    types::{ForeignOwnable, Opaque, ScopeGuard},
+    revocable::{
+        Revocable,
+        RevocableGuard, //
+    },
+    sync::{
+        aref::ARef,
+        rcu,
+        Completion, //
+    },
+    types::{
+        ForeignOwnable,
+        Opaque,
+        ScopeGuard, //
+    },
 };
 
 use pin_init::Wrapper;
@@ -52,7 +67,18 @@ struct Inner<T: Send> {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{bindings, device::{Bound, Device}, devres::Devres, io::{Io, IoRaw}};
+/// # use kernel::{
+/// #   bindings,
+/// #   device::{
+/// #       Bound,
+/// #       Device, //
+/// #   },
+/// #   devres::Devres,
+/// #   io::{
+/// #       Io,
+/// #       IoRaw, //
+/// #   }, //
+/// # };
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
@@ -230,7 +256,11 @@ pub fn device(&self) -> &Device {
     ///
     /// ```no_run
     /// # #![cfg(CONFIG_PCI)]
-    /// # use kernel::{device::Core, devres::Devres, pci};
+    /// # use kernel::{
+    ///     device::Core,
+    ///     devres::Devres,
+    ///     pci, //
+    /// };
     ///
     /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x4>>) -> Result {
     ///     let bar = devres.access(dev.as_ref())?;
@@ -333,7 +363,13 @@ fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
 /// # Examples
 ///
 /// ```no_run
-/// use kernel::{device::{Bound, Device}, devres};
+/// use kernel::{
+///     device::{
+///         Bound,
+///         Device, //
+///     },
+///     devres, //
+/// };
 ///
 /// /// Registration of e.g. a class device, IRQ, etc.
 /// struct Registration;
-- 
2.51.0


