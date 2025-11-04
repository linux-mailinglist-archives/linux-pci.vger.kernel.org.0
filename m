Return-Path: <linux-pci+bounces-40213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C9EC31878
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 15:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20983AAE44
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BD1330338;
	Tue,  4 Nov 2025 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hvKuCVJu"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013019.outbound.protection.outlook.com [40.93.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FE732D7F3;
	Tue,  4 Nov 2025 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266510; cv=fail; b=SFyHJGFM21LFfWWq7729KSb0aK95mfI7EEzjkML0CoCZfbHYZoTd/ekKFIJZl6dzr05eFAvoteyMyBxB7AFbYC7GlTdt10iiUVCZIqVTWXGX/c0kMZ1zkTroCi134QODq8SAk+5/zHq2aTJKnpGwrQ0rBHkoALiT2aUHX/XPeF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266510; c=relaxed/simple;
	bh=2q22Kxmnm00m11YquhhB7SqCVR1oUT40dhmJZesQLGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYog59RHG62xK1TkQSL0gEQ9gNyXVl1ycbOm0Ri3wcpy8+nzamh+QRpedc/GNE3d/RAb5D/OogVw2JqRvJI84IU/uIyACyBDwhVrfC8T++nDznsHjvhJH5dL1iM7ivDmFY5rbmdzwfX16ZSXaxAsp7KZWUHLcartBKBNXyjYQ0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hvKuCVJu; arc=fail smtp.client-ip=40.93.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrs0t5FFhpJ+nVAikWY41cQJuc3vtrl9NrlhkAldAD2xRwRGlw5Ve/StR5tYXJO6ea5Xf4OU2MT2iLh4SNNFJphQx3xlZ8MAv5tky1ODM2joh5xBQuoiBvgnC1NL7vYP0gBJNTYX1qfovYXk37AprkkknBE1h94/3e2oh/12XUa4hkoU5QzAeNRPXwQCm4Lk8suvX+YHnUcXYlp9iC7ZkrAI2WK9XFndqvIL8dFzJqFGv7XGHduN4/q3qPUl6pvX8wFyJc6SXrLKguFjJfKg0bp7GdnGntDK3BdQ7yQHDdkYW+dspd7glxs6p31XFH9Uj/DAJL43h5dA5hmpY4qiNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+brNBeaSMeJEjiAxSaQEnFpgmMmvarfNg3fCvZvYYw=;
 b=N94Ak5bf4VPG45sY2TAt2OS5d2z7A3Z++qWm0sL5l69c2HunW7X9uAl6TKD287tBTTsGcUkf7KJfB2B++ILsW4WMFRCEfso5jm+9+f+MbD5Sm3Ift/r5n6Y7UqquIAyk8Xi6bEHmkglop+vTBiC/tsjOCexPeWXdIDXeY/b75EWm95JukV1Tq6euwvVj3nKVk0V5h4RqhnsPcVGX25QM1EpySoJWFk35AQmPpNiHJajAuWmd1qUMnV7Cdj883MS9nvuaYzDrvCTpvPGIoU5vGI3fX8c53isH3lXI9xtU82qQ8/wqbsDSBYAIJ1V7dnQxFwxDWC/h+YZnLoaBHo9aZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+brNBeaSMeJEjiAxSaQEnFpgmMmvarfNg3fCvZvYYw=;
 b=hvKuCVJuHQDQNUQ2RLqVLdnuOdKeB2IjUXir/xiL9TGVCbgIa8Q//9TNNfvAXuX10xNAGNvrVEMBqXWlGfoxhi81Xw0GRHs9/01JsOPe8dIdSdJYydQFx+Fpt1t084Z36VGMatUV3H61b2hZb450CbT+Fwyx+6e4Um8hYwVQtFqlF5u38OQk3gO3+W42zcIZWolB5ufBF/q/zsUMdOhjFwVenRoLRqj2+BISnOzlIwYTlbN0pMxIrg0Qf0b8hJ9TOqGZWht84a75pvtF1YXZ4w/QX3f57kjwoQwfjXxfSzoYYEldzgwUbOP+foxn4yiRBYKlXPuvSXFEbPuyv32QDQ==
Received: from BN0PR04CA0073.namprd04.prod.outlook.com (2603:10b6:408:ea::18)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 14:28:20 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:ea:cafe::51) by BN0PR04CA0073.outlook.office365.com
 (2603:10b6:408:ea::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 14:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:28:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:28:05 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 4 Nov 2025 06:28:04 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 06:27:55 -0800
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
Subject: [PATCH RESEND v4 1/4] rust: io: factor common I/O helpers into Io trait
Date: Tue, 4 Nov 2025 16:27:30 +0200
Message-ID: <20251104142733.5334-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104142733.5334-1-zhiw@nvidia.com>
References: <20251104142733.5334-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 978c3349-a828-4af9-d894-08de1bae6707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2PvNus91scDJ9lGNg+WO8kpwQ7q4r8utuS/3oWAdVP0XCOnUNsqFTvhSb0Fw?=
 =?us-ascii?Q?h3Tv+mbK0VNbf5XcPkFIXa+oTdd3tUYt/vHklUhSFQv8ZfKMkMyRoBNZO3rL?=
 =?us-ascii?Q?c2IQdbIO+2L4CWRK66a9QbDw3T8UJ8U7Kt8reSNtpXGVOx8DSYKZJWkH2loP?=
 =?us-ascii?Q?+WqE9BU1RqAssvjs0EKq6D24C4Ldtq3tDTnR5cJGpWub/ciI/bJ4V3wBt+rc?=
 =?us-ascii?Q?StvO63Tlf2e8iox3scBX8zz5+tbv/A4ovsPe9lch465lWHlKR7P/7oeuRpmQ?=
 =?us-ascii?Q?5ACDGRtmdAF8qxaVlOZdccqHKcw8EUG5M3ev4tTcpOKt/q7gvkbX0Z1hN9uY?=
 =?us-ascii?Q?vABMU73/gwYOwZU9QO+Wm38oR9WsfsHAZIei+7YcI+fNdlYWMm3Z0we3pmhu?=
 =?us-ascii?Q?Pejn7voYDxVvpmxip/2G0vEL3Amzd6owCe6+kCyTpq99k5M4drUSuNvr4qfJ?=
 =?us-ascii?Q?9zM6VYk22rFGi8Ej9HmTozRHvwwMrl6LRV05xV4kyqLOETVKlh/uX0qLCE+W?=
 =?us-ascii?Q?zKFJmx0UOW8e1Cb1AoTcR49ncA+cWky+mdhK9XU3XIwakweVJyRsE5WdcAqy?=
 =?us-ascii?Q?j1tTSBYdntazEGFtBbXnsd92TDAKZd1pWNJUbmfcMvqvFBLng/JKzBpGq6h5?=
 =?us-ascii?Q?7sUoGTZxbKj42idXPxZLe/KHYCPXyUb5bAlzaeCcBzHksV95nFZzK6dxKzfr?=
 =?us-ascii?Q?3FgECZkXNZsOr50utwd0TdopIq+aewF9SqgRxXaQuoh00nyKXYC7jxP7oNkT?=
 =?us-ascii?Q?G3mObMGuxJwGiahCHxIe428qE/B79AeMjTe3QtLJcuyMMiKzdAKvhl5q5J06?=
 =?us-ascii?Q?0aiykjdy4OkN1KYAGn62n0LvxBJ1rygNMlHWEkIL8jUuVfO/JbvbAkaRf5Od?=
 =?us-ascii?Q?1JOtY1uL+Yb7gDn2U/PAA9EbSkkK3a9mkpodKBoBjSFcjRTvnS0bMTdrsnnH?=
 =?us-ascii?Q?lz2B/UbCHQjxJuU+sNS7nbK14jkm0i0c91gZiX68lJbsOgqPKWCBl9HH9a/Q?=
 =?us-ascii?Q?SGJ/l0BET79SaHfBKvu9yhLX/zAruPyYpDxRak0wRP+4fZHDGmsHJpPMao1U?=
 =?us-ascii?Q?lMF9r8OsSmWPFw3RWTLMYZVaMCJDbeCeeR0/NjNqNdyhiwylKrhmZvBLCgL0?=
 =?us-ascii?Q?JZ3UhyO2ut0N6X5GphAeQvixSHWkLmc27S5sEN7v36YzeaiOOO52PV4aZ38w?=
 =?us-ascii?Q?jRy9ZyQ5dTWLLXFukm06jRhe3Fu0L/0iU2mUAXJMtKOSdwbWUD+Ec18JjWKa?=
 =?us-ascii?Q?Sshlawqzb91ApQnsXAKCuuDZXkvtAUbtCzGL+9mbZj5bQlZJFjERv8qLaLtv?=
 =?us-ascii?Q?/RuLsVjSnD4+0tW6oqJf6+/x1eKuB9CtI4/g31Tx7ESNeNNg0NKriK1fuZ6B?=
 =?us-ascii?Q?j6i58seo6um05uAEFP1fGuCiCZCwCkyYp/YeZadMZUHmO4sx0fDYipZjI9Im?=
 =?us-ascii?Q?/g4Leht47XEfFabgepyhRXkqza94A+QtJvoPNjS9LcEjlBsIUuxPDVkz+6aE?=
 =?us-ascii?Q?I/EOJjWhxDnNmABnd9q+ZbOYTcvQfTDKWCAX/DwkJU7EYST7pT8QMji0ZR+W?=
 =?us-ascii?Q?KjzesZcX0Q18c9YUH48=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:28:19.8685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 978c3349-a828-4af9-d894-08de1bae6707
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157

The previous Io<SIZE> type combined both the generic I/O access helpers
and MMIO implementation details in a single struct.

To establish a cleaner layering between the I/O interface and its concrete
backends, paving the way for supporting additional I/O mechanisms in the
future, Io<SIZE> need to be factored.

Factor the common helpers into a new Io trait, and move the MMIO-specific
logic into a dedicated Mmio<SIZE> type implementing that trait. Rename the
IoRaw to MmioRaw and update the bus MMIO implementations to use MmioRaw.

No functional change intended.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/regs/macros.rs |  90 ++++++----
 drivers/gpu/nova-core/vbios.rs       |   1 +
 rust/kernel/devres.rs                |  12 +-
 rust/kernel/io.rs                    | 248 +++++++++++++++++++--------
 rust/kernel/io/mem.rs                |  16 +-
 rust/kernel/io/poll.rs               |   4 +-
 rust/kernel/pci.rs                   |  10 +-
 samples/rust/rust_driver_pci.rs      |   2 +-
 8 files changed, 255 insertions(+), 128 deletions(-)

diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
index fd1a815fa57d..5033bc0929ab 100644
--- a/drivers/gpu/nova-core/regs/macros.rs
+++ b/drivers/gpu/nova-core/regs/macros.rs
@@ -369,16 +369,18 @@ impl $name {
 
             /// Read the register from its address in `io`.
             #[inline(always)]
-            pub(crate) fn read<const SIZE: usize, T>(io: &T) -> Self where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+            pub(crate) fn read<T, I>(io: &T) -> Self where
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
             {
                 Self(io.read32($offset))
             }
 
             /// Write the value contained in `self` to the register address in `io`.
             #[inline(always)]
-            pub(crate) fn write<const SIZE: usize, T>(self, io: &T) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+            pub(crate) fn write<T, I>(self, io: &T) where
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
             {
                 io.write32(self.0, $offset)
             }
@@ -386,11 +388,12 @@ pub(crate) fn write<const SIZE: usize, T>(self, io: &T) where
             /// Read the register from its address in `io` and run `f` on its value to obtain a new
             /// value to write back.
             #[inline(always)]
-            pub(crate) fn update<const SIZE: usize, T, F>(
+            pub(crate) fn update<T, I, F>(
                 io: &T,
                 f: F,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
                 let reg = f(Self::read(io));
@@ -408,12 +411,13 @@ impl $name {
             /// Read the register from `io`, using the base address provided by `base` and adding
             /// the register's offset to it.
             #[inline(always)]
-            pub(crate) fn read<const SIZE: usize, T, B>(
+            pub(crate) fn read<T, I, B>(
                 io: &T,
                 #[allow(unused_variables)]
                 base: &B,
             ) -> Self where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 const OFFSET: usize = $name::OFFSET;
@@ -428,13 +432,14 @@ pub(crate) fn read<const SIZE: usize, T, B>(
             /// Write the value contained in `self` to `io`, using the base address provided by
             /// `base` and adding the register's offset to it.
             #[inline(always)]
-            pub(crate) fn write<const SIZE: usize, T, B>(
+            pub(crate) fn write<T, I, B>(
                 self,
                 io: &T,
                 #[allow(unused_variables)]
                 base: &B,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 const OFFSET: usize = $name::OFFSET;
@@ -449,12 +454,13 @@ pub(crate) fn write<const SIZE: usize, T, B>(
             /// the register's offset to it, then run `f` on its value to obtain a new value to
             /// write back.
             #[inline(always)]
-            pub(crate) fn update<const SIZE: usize, T, B, F>(
+            pub(crate) fn update<T, I, B, F>(
                 io: &T,
                 base: &B,
                 f: F,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
                 B: crate::regs::macros::RegisterBase<$base>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
@@ -474,11 +480,12 @@ impl $name {
 
             /// Read the array register at index `idx` from its address in `io`.
             #[inline(always)]
-            pub(crate) fn read<const SIZE: usize, T>(
+            pub(crate) fn read<T, I>(
                 io: &T,
                 idx: usize,
             ) -> Self where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
             {
                 build_assert!(idx < Self::SIZE);
 
@@ -490,12 +497,13 @@ pub(crate) fn read<const SIZE: usize, T>(
 
             /// Write the value contained in `self` to the array register with index `idx` in `io`.
             #[inline(always)]
-            pub(crate) fn write<const SIZE: usize, T>(
+            pub(crate) fn write<T, I>(
                 self,
                 io: &T,
                 idx: usize
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
             {
                 build_assert!(idx < Self::SIZE);
 
@@ -507,12 +515,13 @@ pub(crate) fn write<const SIZE: usize, T>(
             /// Read the array register at index `idx` in `io` and run `f` on its value to obtain a
             /// new value to write back.
             #[inline(always)]
-            pub(crate) fn update<const SIZE: usize, T, F>(
+            pub(crate) fn update<T, I, F>(
                 io: &T,
                 idx: usize,
                 f: F,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
                 let reg = f(Self::read(io, idx));
@@ -524,11 +533,12 @@ pub(crate) fn update<const SIZE: usize, T, F>(
             /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
             /// access was out-of-bounds.
             #[inline(always)]
-            pub(crate) fn try_read<const SIZE: usize, T>(
+            pub(crate) fn try_read<T, I>(
                 io: &T,
                 idx: usize,
             ) -> ::kernel::error::Result<Self> where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
             {
                 if idx < Self::SIZE {
                     Ok(Self::read(io, idx))
@@ -542,12 +552,13 @@ pub(crate) fn try_read<const SIZE: usize, T>(
             /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
             /// access was out-of-bounds.
             #[inline(always)]
-            pub(crate) fn try_write<const SIZE: usize, T>(
+            pub(crate) fn try_write<T, I>(
                 self,
                 io: &T,
                 idx: usize,
             ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
             {
                 if idx < Self::SIZE {
                     Ok(self.write(io, idx))
@@ -562,12 +573,13 @@ pub(crate) fn try_write<const SIZE: usize, T>(
             /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
             /// access was out-of-bounds.
             #[inline(always)]
-            pub(crate) fn try_update<const SIZE: usize, T, F>(
+            pub(crate) fn try_update<T, I, F>(
                 io: &T,
                 idx: usize,
                 f: F,
             ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
                 if idx < Self::SIZE {
@@ -593,13 +605,14 @@ impl $name {
             /// Read the array register at index `idx` from `io`, using the base address provided
             /// by `base` and adding the register's offset to it.
             #[inline(always)]
-            pub(crate) fn read<const SIZE: usize, T, B>(
+            pub(crate) fn read<T, I, B>(
                 io: &T,
                 #[allow(unused_variables)]
                 base: &B,
                 idx: usize,
             ) -> Self where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 build_assert!(idx < Self::SIZE);
@@ -614,14 +627,15 @@ pub(crate) fn read<const SIZE: usize, T, B>(
             /// Write the value contained in `self` to `io`, using the base address provided by
             /// `base` and adding the offset of array register `idx` to it.
             #[inline(always)]
-            pub(crate) fn write<const SIZE: usize, T, B>(
+            pub(crate) fn write<T, I, B>(
                 self,
                 io: &T,
                 #[allow(unused_variables)]
                 base: &B,
                 idx: usize
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 build_assert!(idx < Self::SIZE);
@@ -636,13 +650,14 @@ pub(crate) fn write<const SIZE: usize, T, B>(
             /// by `base` and adding the register's offset to it, then run `f` on its value to
             /// obtain a new value to write back.
             #[inline(always)]
-            pub(crate) fn update<const SIZE: usize, T, B, F>(
+            pub(crate) fn update<T, I, B, F>(
                 io: &T,
                 base: &B,
                 idx: usize,
                 f: F,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
                 B: crate::regs::macros::RegisterBase<$base>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
@@ -656,12 +671,13 @@ pub(crate) fn update<const SIZE: usize, T, B, F>(
             /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
             /// access was out-of-bounds.
             #[inline(always)]
-            pub(crate) fn try_read<const SIZE: usize, T, B>(
+            pub(crate) fn try_read<T, I, B>(
                 io: &T,
                 base: &B,
                 idx: usize,
             ) -> ::kernel::error::Result<Self> where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 if idx < Self::SIZE {
@@ -677,13 +693,14 @@ pub(crate) fn try_read<const SIZE: usize, T, B>(
             /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
             /// access was out-of-bounds.
             #[inline(always)]
-            pub(crate) fn try_write<const SIZE: usize, T, B>(
+            pub(crate) fn try_write<T, I, B>(
                 self,
                 io: &T,
                 base: &B,
                 idx: usize,
             ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 if idx < Self::SIZE {
@@ -700,13 +717,14 @@ pub(crate) fn try_write<const SIZE: usize, T, B>(
             /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
             /// access was out-of-bounds.
             #[inline(always)]
-            pub(crate) fn try_update<const SIZE: usize, T, B, F>(
+            pub(crate) fn try_update<T, I, B, F>(
                 io: &T,
                 base: &B,
                 idx: usize,
                 f: F,
             ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io,
                 B: crate::regs::macros::RegisterBase<$base>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 74ed6d61e6cc..cafb2d99c82b 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -10,6 +10,7 @@
 use kernel::error::Result;
 use kernel::prelude::*;
 use kernel::ptr::{Alignable, Alignment};
+use kernel::io::Io;
 use kernel::types::ARef;
 
 /// The offset of the VBIOS ROM in the BAR0 space.
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 10a6a1789854..12a4474df3c3 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -52,11 +52,11 @@ struct Inner<T: Send> {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{bindings, device::{Bound, Device}, devres::Devres, io::{Io, IoRaw}};
+/// # use kernel::{bindings, device::{Bound, Device}, devres::Devres, io::{Io, Mmio, MmioRaw}};
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -71,7 +71,7 @@ struct Inner<T: Send> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -83,11 +83,11 @@ struct Inner<T: Send> {
 /// }
 ///
 /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = Io<SIZE>;
+///    type Target = Mmio<SIZE>;
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { Io::from_raw(&self.0) }
+///         unsafe { Mmio::from_raw(&self.0) }
 ///    }
 /// }
 /// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {
@@ -230,7 +230,7 @@ pub fn device(&self) -> &Device {
     ///
     /// ```no_run
     /// # #![cfg(CONFIG_PCI)]
-    /// # use kernel::{device::Core, devres::Devres, pci};
+    /// # use kernel::{device::Core, devres::Devres, io::Io, pci};
     ///
     /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x4>>) -> Result {
     ///     let bar = devres.access(dev.as_ref())?;
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index ee182b0b5452..0b1e79075c99 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -18,16 +18,16 @@
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
 /// the represented MMIO region does exist or is properly mapped.
 ///
-/// Instead, the bus specific MMIO implementation must convert this raw representation into an `Io`
-/// instance providing the actual memory accessors. Only by the conversion into an `Io` structure
-/// any guarantees are given.
-pub struct IoRaw<const SIZE: usize = 0> {
+/// Instead, the bus specific MMIO implementation must convert this raw representation into an
+/// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
+/// structure any guarantees are given.
+pub struct MmioRaw<const SIZE: usize = 0> {
     addr: usize,
     maxsize: usize,
 }
 
-impl<const SIZE: usize> IoRaw<SIZE> {
-    /// Returns a new `IoRaw` instance on success, an error otherwise.
+impl<const SIZE: usize> MmioRaw<SIZE> {
+    /// Returns a new `MmioRaw` instance on success, an error otherwise.
     pub fn new(addr: usize, maxsize: usize) -> Result<Self> {
         if maxsize < SIZE {
             return Err(EINVAL);
@@ -62,11 +62,11 @@ pub fn maxsize(&self) -> usize {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{bindings, ffi::c_void, io::{Io, IoRaw}};
+/// # use kernel::{bindings, ffi::c_void, io::{Io, Mmio, MmioRaw}};
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -81,7 +81,7 @@ pub fn maxsize(&self) -> usize {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -93,11 +93,11 @@ pub fn maxsize(&self) -> usize {
 /// }
 ///
 /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = Io<SIZE>;
+///    type Target = Mmio<SIZE>;
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { Io::from_raw(&self.0) }
+///         unsafe { Mmio::from_raw(&self.0) }
 ///    }
 /// }
 ///
@@ -111,29 +111,31 @@ pub fn maxsize(&self) -> usize {
 /// # }
 /// ```
 #[repr(transparent)]
-pub struct Io<const SIZE: usize = 0>(IoRaw<SIZE>);
+pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
 
 macro_rules! define_read {
-    ($(#[$attr:meta])* $name:ident, $try_name:ident, $c_fn:ident -> $type_name:ty) => {
+    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident -> $type_name:ty) => {
         /// Read IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
         /// time, the build will fail.
         $(#[$attr])*
         #[inline]
-        pub fn $name(&self, offset: usize) -> $type_name {
+        $vis fn $name(&self, offset: usize) -> $type_name {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
             unsafe { bindings::$c_fn(addr as *const c_void) }
         }
+    };
 
+    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $c_fn:ident -> $type_name:ty) => {
         /// Read IO data from a given offset.
         ///
         /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
         /// out of bounds.
         $(#[$attr])*
-        pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
+        $vis fn $try_name(&self, offset: usize) -> Result<$type_name> {
             let addr = self.io_addr::<$type_name>(offset)?;
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
@@ -143,26 +145,28 @@ pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
 }
 
 macro_rules! define_write {
-    ($(#[$attr:meta])* $name:ident, $try_name:ident, $c_fn:ident <- $type_name:ty) => {
+    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident <- $type_name:ty) => {
         /// Write IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
         /// time, the build will fail.
         $(#[$attr])*
         #[inline]
-        pub fn $name(&self, value: $type_name, offset: usize) {
+        $vis fn $name(&self, value: $type_name, offset: usize) {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
             unsafe { bindings::$c_fn(value, addr as *mut c_void) }
         }
+    };
 
+    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $c_fn:ident <- $type_name:ty) => {
         /// Write IO data from a given offset.
         ///
         /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
         /// out of bounds.
         $(#[$attr])*
-        pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
+        $vis fn $try_name(&self, value: $type_name, offset: usize) -> Result {
             let addr = self.io_addr::<$type_name>(offset)?;
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
@@ -172,43 +176,40 @@ pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
     };
 }
 
-impl<const SIZE: usize> Io<SIZE> {
-    /// Converts an `IoRaw` into an `Io` instance, providing the accessors to the MMIO mapping.
-    ///
-    /// # Safety
-    ///
-    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
-    /// `maxsize`.
-    pub unsafe fn from_raw(raw: &IoRaw<SIZE>) -> &Self {
-        // SAFETY: `Io` is a transparent wrapper around `IoRaw`.
-        unsafe { &*core::ptr::from_ref(raw).cast() }
+/// Checks whether an access of type `U` at the given `offset`
+/// is valid within this region.
+#[inline]
+const fn offset_valid<U>(offset: usize, size: usize) -> bool {
+    let type_size = core::mem::size_of::<U>();
+    if let Some(end) = offset.checked_add(type_size) {
+        end <= size && offset % type_size == 0
+    } else {
+        false
     }
+}
+
+/// Represents a region of I/O space of a fixed size.
+///
+/// Provides common helpers for offset validation and address
+/// calculation on top of a base address and maximum size.
+///
+/// Types implementing this trait (e.g. MMIO BARs or PCI config
+/// regions) can share the same accessors.
+pub trait Io {
+    /// Minimum usable size
+    const MIN_SIZE: usize;
 
     /// Returns the base address of this mapping.
-    #[inline]
-    pub fn addr(&self) -> usize {
-        self.0.addr()
-    }
+    fn addr(&self) -> usize;
 
     /// Returns the maximum size of this mapping.
-    #[inline]
-    pub fn maxsize(&self) -> usize {
-        self.0.maxsize()
-    }
-
-    #[inline]
-    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
-        let type_size = core::mem::size_of::<U>();
-        if let Some(end) = offset.checked_add(type_size) {
-            end <= size && offset % type_size == 0
-        } else {
-            false
-        }
-    }
+    fn maxsize(&self) -> usize;
 
+    /// Returns the absolute I/O address for a given `offset`.
+    /// Performs runtime bounds checks using [`offset_valid`]
     #[inline]
     fn io_addr<U>(&self, offset: usize) -> Result<usize> {
-        if !Self::offset_valid::<U>(offset, self.maxsize()) {
+        if !offset_valid::<U>(offset, self.maxsize()) {
             return Err(EINVAL);
         }
 
@@ -217,50 +218,157 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
         self.addr().checked_add(offset).ok_or(EINVAL)
     }
 
+    /// Returns the absolute I/O address for a given `offset`,
+    /// performing compile-time bound checks.
     #[inline]
     fn io_addr_assert<U>(&self, offset: usize) -> usize {
-        build_assert!(Self::offset_valid::<U>(offset, SIZE));
+        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
 
         self.addr() + offset
     }
 
-    define_read!(read8, try_read8, readb -> u8);
-    define_read!(read16, try_read16, readw -> u16);
-    define_read!(read32, try_read32, readl -> u32);
+    /// Infallible 8-bit read with compile-time bounds check.
+    fn read8(&self, offset: usize) -> u8;
+
+    /// Infallible 16-bit read with compile-time bounds check.
+    fn read16(&self, offset: usize) -> u16;
+
+    /// Infallible 32-bit read with compile-time bounds check.
+    fn read32(&self, offset: usize) -> u32;
+
+    /// Fallible 8-bit read with runtime bounds check.
+    fn try_read8(&self, offset: usize) -> Result<u8>;
+
+    /// Fallible 16-bit read with runtime bounds check.
+    fn try_read16(&self, offset: usize) -> Result<u16>;
+
+    /// Fallible 32-bit read with runtime bounds check.
+    fn try_read32(&self, offset: usize) -> Result<u32>;
+
+    /// Infallible 8-bit write with compile-time bounds check.
+    fn write8(&self, value: u8, offset: usize);
+
+    /// Infallible 16-bit write with compile-time bounds check.
+    fn write16(&self, value: u16, offset: usize);
+
+    /// Infallible 32-bit write with compile-time bounds check.
+    fn write32(&self, value: u32, offset: usize);
+
+    /// Fallible 8-bit write with runtime bounds check.
+    fn try_write8(&self, value: u8, offset: usize) -> Result;
+
+    /// Fallible 16-bit write with runtime bounds check.
+    fn try_write16(&self, value: u16, offset: usize) -> Result;
+
+    /// Fallible 32-bit write with runtime bounds check.
+    fn try_write32(&self, value: u32, offset: usize) -> Result;
+}
+
+/// Implement this trait if a backend supports 64-bit access.
+pub trait Io64: Io {
+    /// Infallible 64-bit read with compile-time bounds check (64-bit only).
+    fn read64(&self, offset: usize) -> u64;
+
+    /// Fallible 64-bit read with runtime bounds check (64-bit only).
+    fn try_read64(&self, offset: usize) -> Result<u64>;
+
+    /// Infallible 64-bit write with compile-time bounds check (64-bit only).
+    fn write64(&self, value: u64, offset: usize);
+
+    /// Fallible 64-bit write with runtime bounds check (64-bit only).
+    fn try_write64(&self, value: u64, offset: usize) -> Result;
+}
+
+impl<const SIZE: usize> Io for Mmio<SIZE> {
+    const MIN_SIZE: usize = SIZE;
+
+    /// Returns the base address of this mapping.
+    #[inline]
+    fn addr(&self) -> usize {
+        self.0.addr()
+    }
+
+    /// Returns the maximum size of this mapping.
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.0.maxsize()
+    }
+
+    define_read!(infallible, read8, readb -> u8);
+    define_read!(infallible, read16, readw -> u16);
+    define_read!(infallible, read32, readl -> u32);
+
+    define_read!(fallible, try_read8, readb -> u8);
+    define_read!(fallible, try_read16, readw -> u16);
+    define_read!(fallible, try_read32, readl -> u32);
+
+    define_write!(infallible, write8, writeb <- u8);
+    define_write!(infallible, write16, writew <- u16);
+    define_write!(infallible, write32, writel <- u32);
+
+    define_write!(fallible, try_write8, writeb <- u8);
+    define_write!(fallible, try_write16, writew <- u16);
+    define_write!(fallible, try_write32, writel <- u32);
+}
+
+#[cfg(CONFIG_64BIT)]
+impl<const SIZE: usize> Io64 for Mmio<SIZE> {
+    define_read!(infallible, read64, readq -> u64);
+    define_read!(fallible, try_read64, readq -> u64);
+
+    define_write!(infallible, write64, writeq <- u64);
+    define_write!(fallible, try_write64, writeq <- u64);
+}
+
+impl<const SIZE: usize> Mmio<SIZE> {
+    /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
+    /// `maxsize`.
+    pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
+        // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
+        unsafe { &*core::ptr::from_ref(raw).cast() }
+    }
+
+    define_read!(infallible, pub read8_relaxed, readb_relaxed -> u8);
+    define_read!(infallible, pub read16_relaxed, readw_relaxed -> u16);
+    define_read!(infallible, pub read32_relaxed, readl_relaxed -> u32);
     define_read!(
+        infallible,
         #[cfg(CONFIG_64BIT)]
-        read64,
-        try_read64,
-        readq -> u64
+        pub read64_relaxed,
+        readq_relaxed -> u64
     );
 
-    define_read!(read8_relaxed, try_read8_relaxed, readb_relaxed -> u8);
-    define_read!(read16_relaxed, try_read16_relaxed, readw_relaxed -> u16);
-    define_read!(read32_relaxed, try_read32_relaxed, readl_relaxed -> u32);
+    define_read!(fallible, pub try_read8_relaxed, readb_relaxed -> u8);
+    define_read!(fallible, pub try_read16_relaxed, readw_relaxed -> u16);
+    define_read!(fallible, pub try_read32_relaxed, readl_relaxed -> u32);
     define_read!(
+        fallible,
         #[cfg(CONFIG_64BIT)]
-        read64_relaxed,
-        try_read64_relaxed,
+        pub try_read64_relaxed,
         readq_relaxed -> u64
     );
 
-    define_write!(write8, try_write8, writeb <- u8);
-    define_write!(write16, try_write16, writew <- u16);
-    define_write!(write32, try_write32, writel <- u32);
+    define_write!(infallible, pub write8_relaxed, writeb_relaxed <- u8);
+    define_write!(infallible, pub write16_relaxed, writew_relaxed <- u16);
+    define_write!(infallible, pub write32_relaxed, writel_relaxed <- u32);
     define_write!(
+        infallible,
         #[cfg(CONFIG_64BIT)]
-        write64,
-        try_write64,
-        writeq <- u64
+        pub write64_relaxed,
+        writeq_relaxed <- u64
     );
 
-    define_write!(write8_relaxed, try_write8_relaxed, writeb_relaxed <- u8);
-    define_write!(write16_relaxed, try_write16_relaxed, writew_relaxed <- u16);
-    define_write!(write32_relaxed, try_write32_relaxed, writel_relaxed <- u32);
+    define_write!(fallible, pub try_write8_relaxed, writeb_relaxed <- u8);
+    define_write!(fallible, pub try_write16_relaxed, writew_relaxed <- u16);
+    define_write!(fallible, pub try_write32_relaxed, writel_relaxed <- u32);
     define_write!(
+        fallible,
         #[cfg(CONFIG_64BIT)]
-        write64_relaxed,
-        try_write64_relaxed,
+        pub try_write64_relaxed,
         writeq_relaxed <- u64
     );
 }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 6f99510bfc3a..93cad8539b18 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -11,8 +11,8 @@
 use crate::io;
 use crate::io::resource::Region;
 use crate::io::resource::Resource;
-use crate::io::Io;
-use crate::io::IoRaw;
+use crate::io::Mmio;
+use crate::io::MmioRaw;
 use crate::prelude::*;
 
 /// An IO request for a specific device and resource.
@@ -195,7 +195,7 @@ pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> +
 }
 
 impl<const SIZE: usize> Deref for ExclusiveIoMem<SIZE> {
-    type Target = Io<SIZE>;
+    type Target = Mmio<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         &self.iomem
@@ -209,10 +209,10 @@ fn deref(&self) -> &Self::Target {
 ///
 /// # Invariants
 ///
-/// [`IoMem`] always holds an [`IoRaw`] instance that holds a valid pointer to the
+/// [`IoMem`] always holds an [`MmioRaw`] instance that holds a valid pointer to the
 /// start of the I/O memory mapped region.
 pub struct IoMem<const SIZE: usize = 0> {
-    io: IoRaw<SIZE>,
+    io: MmioRaw<SIZE>,
 }
 
 impl<const SIZE: usize> IoMem<SIZE> {
@@ -247,7 +247,7 @@ fn ioremap(resource: &Resource) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = IoRaw::new(addr as usize, size)?;
+        let io = MmioRaw::new(addr as usize, size)?;
         let io = IoMem { io };
 
         Ok(io)
@@ -270,10 +270,10 @@ fn drop(&mut self) {
 }
 
 impl<const SIZE: usize> Deref for IoMem<SIZE> {
-    type Target = Io<SIZE>;
+    type Target = Mmio<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         // SAFETY: Safe as by the invariant of `IoMem`.
-        unsafe { Io::from_raw(&self.io) }
+        unsafe { Mmio::from_raw(&self.io) }
     }
 }
diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index 613eb25047ef..a9fea091303b 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -37,12 +37,12 @@
 /// # Examples
 ///
 /// ```no_run
-/// use kernel::io::{Io, poll::read_poll_timeout};
+/// use kernel::io::{Io, Mmio, poll::read_poll_timeout};
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result<()> {
+/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result<()> {
 ///     match read_poll_timeout(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 7fcc5f6022c1..77a8eb39ad32 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -10,7 +10,7 @@
     devres::Devres,
     driver,
     error::{from_result, to_result, Result},
-    io::{Io, IoRaw},
+    io::{Mmio, MmioRaw},
     irq::{self, IrqRequest},
     str::CStr,
     sync::aref::ARef,
@@ -313,7 +313,7 @@ pub struct Device<Ctx: device::DeviceContext = device::Normal>(
 /// memory mapped PCI bar and its size.
 pub struct Bar<const SIZE: usize = 0> {
     pdev: ARef<Device>,
-    io: IoRaw<SIZE>,
+    io: MmioRaw<SIZE>,
     num: i32,
 }
 
@@ -349,7 +349,7 @@ fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = match IoRaw::new(ioptr, len as usize) {
+        let io = match MmioRaw::new(ioptr, len as usize) {
             Ok(io) => io,
             Err(err) => {
                 // SAFETY:
@@ -403,11 +403,11 @@ fn drop(&mut self) {
 }
 
 impl<const SIZE: usize> Deref for Bar<SIZE> {
-    type Target = Io<SIZE>;
+    type Target = Mmio<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         // SAFETY: By the type invariant of `Self`, the MMIO range in `self.io` is properly mapped.
-        unsafe { Io::from_raw(&self.io) }
+        unsafe { Mmio::from_raw(&self.io) }
     }
 }
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 55a683c39ed9..528e672b6b89 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{c_str, device::Core, devres::Devres, pci, prelude::*, sync::aref::ARef};
+use kernel::{c_str, device::Core, devres::Devres, io::Io, pci, prelude::*, sync::aref::ARef};
 
 struct Regs;
 
-- 
2.51.0


