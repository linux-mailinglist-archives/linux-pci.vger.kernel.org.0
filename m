Return-Path: <linux-pci+bounces-40782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1A5C49482
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 21:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF0E734B425
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67802F28EC;
	Mon, 10 Nov 2025 20:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="syzoL/c0"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC812F1FF1;
	Mon, 10 Nov 2025 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807370; cv=fail; b=KPPrZKFxQNCT1479r9QcpS2hdQsX99/BXUHn0eXOCDd7MrqlbI6uOzMDVDWH0At8HObYSFg4haGaFt8nOwASjnJX7Eaxw3bjUuOQRRikaZjAjk82Coy6ydrPhI3livrAPFkLbXQhXAYoILPBIFh4fZrCM8F7qHczgTIwdXV/UsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807370; c=relaxed/simple;
	bh=Dzrsx+QVFjqKm0x0j1byTy9j7rQZf3O7OOWsZxxyaHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkkJhzKoI4Tnj908XAWeliHZGKra3udDe9e/TcTU9jReN5FsAGXhiFK5I+V0h22gW8A/+71WMwjzjoCM3p2QzzUPP0cQBnS4XieVzkk6V4V/G6PYEO/QLPn+cHfEO1uwd8Xm6NH2Bbe0bW0yGLg+447cgrwFTbbi//P9N35EAcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=syzoL/c0; arc=fail smtp.client-ip=40.107.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p71/XbVvTZ/cTG0DzIzAEcXfdunb62Dhx2atQ7v2BP1SO50gPv6XzXZdX1vRhUrNE89elQPKEu9abJETIVivVD4EifB68yEi0UL2NfwfimHKUKbeFGibozKxT5jnJdpLb7hwFSNNPjaEQKwe0by1AR0VE5ivWTm3l4OwqKUAfYtW/habSwg7QUS/tXKZLVf0xCXBzoIWzQULHwzEVyCIU4vyFECD+VCCdZPQx19e0ubemLKF3rUvA6msKqB7b+Kll+YW7r5IDVPTz1qQaDbL5uNYdcD40m8Q8/CJc5jj1b66FAFvicfd7wcuNNuwmKJS0Im3neJjPCDI0KyO/r8B8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NT8bjyQe2nAlCmerEsMSndqcE97s/duFhtst6TX76+4=;
 b=b1KN0wg0rYn5LOc7PbYYTeHANBVzSpBsYG5awBe4TlAzjrucoZum7hdU1E8aDVFYlBOhXOKWyTKrviUG+EQBYmKX7T1rKTcN/CzeLnmgsJNTLIf5PbgYk0c2V3qz/F5zgF8A62UQypNL6iPsPVzbNiyvjOJPV46DauwrIOE3I5simf++1JC+0ZWbywIKInIyG3zrkfbhXNtmouy2NBogZ8OhHdKpTD1Tai6c7nuA4Lvf1ewreLbSrOfBjA0edjsbfKFCbVxSmNKvdZqri67ROtx0Tu1HfotofWkGw65zWM31yqkuDBfPpJFwwwU3P3wuIl2W9FgIVR1Q0U6qTk1A2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NT8bjyQe2nAlCmerEsMSndqcE97s/duFhtst6TX76+4=;
 b=syzoL/c07HdzKArJjvhHyfWg/Xeqjo4X+QTYNBwN3oUbQzaZ68rczIKE7LsP4bIl0HitXjclukQIaN0tVEZCyd+g3HQm8OJJPRmt1EZSbTmCd1wMKCcyAa0YOlCCPfG4XNK/Q4SjVEBSD6CaddoWa7tll6XX1sxlF1A03D+kNbRQC514OJ9eoD/nGLeKn973irhScqbI+mRmSo/gn6VfznmBjANMzhgi7sxwCNwfN6Z67Xs5lOVoLYQDw+fulEybz3qcEJQ7mHFbY2PkD8vlSr1TV2ju+jeQnc7Vu0ECMPmwrCetvwiVZA1nZpkgAee8L2vMcmHIn6wwtQvL5hlMBA==
Received: from BYAPR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:c0::49)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:42:31 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:c0:cafe::3a) by BYAPR05CA0036.outlook.office365.com
 (2603:10b6:a03:c0::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Mon,
 10 Nov 2025 20:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 20:42:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:42:10 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:42:08 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10
 Nov 2025 12:42:00 -0800
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
Subject: [PATCH v6 RESEND 4/7] rust: io: factor common I/O helpers into Io trait
Date: Mon, 10 Nov 2025 22:41:16 +0200
Message-ID: <20251110204119.18351-5-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: f22b7e33-63d1-46ec-7618-08de2099ab98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DM7ypbq+YIikNocbPBfpbOONoHQo3BajZNQ38H4bv5l97Kn/aHtgVvt2+4BF?=
 =?us-ascii?Q?5l7HOv2Zj7ewHUT5E24IhnDp8E/XjSmBu+t0U7RPUfPlq5xTm/ghc7YusZPK?=
 =?us-ascii?Q?WNEUWK+dUUtiaxTy/XD697haFGZ1HqgmGOxFhQEcT6sg3D6NtMeH2y1Vk0UH?=
 =?us-ascii?Q?CVwHFFO9s2Zi7vyjiAMsvmp8FznomNUZnZihqFpenj2eWYCEifB/Ik97q9L6?=
 =?us-ascii?Q?VM6TnMw1d/0rPRJIXtonwVp84q5EUIxs15hrBXlAdkIynG6fB1AkqjJw7Zqz?=
 =?us-ascii?Q?INfPaK28pddp69s31wQUCt/0BEi1DANMLne092Qp/RyE5p4tiCiz1xT4fHFq?=
 =?us-ascii?Q?tGeMB5mwvUWEUuOr90DD32DNmgqakBEAqZprrtVCk/Ws9kCwuSSJkx6MPxEr?=
 =?us-ascii?Q?kAfP6tDXWA/XQplN0ZL/CTqwwVYtAzcuc5RcpIa0SA2naER1oa9pVrhPVuox?=
 =?us-ascii?Q?K7Ya4DzRcfXau0+fSa5r8MY1vHtpv6yMfQPMlmM9NeegQTe1bxaFTCtwDr3W?=
 =?us-ascii?Q?5FMkL3DGe5d5p2zIFP6gwwLLtyAz2cqoybRojRG1ahRZSemztJUJFhMH+Tep?=
 =?us-ascii?Q?gc611Pv+atCKVr0X169RBekNabB/A4W1XKpa9gsm07I1pN//xKi7LANRetpW?=
 =?us-ascii?Q?MhzSkn5SUMU0vlhWFcMKMcwNydbTJ0h9nr9tdcw1nrkxhoKAeEmYUrV0KEpu?=
 =?us-ascii?Q?qwySYE/BqWEjRE1smOc53evF3IGYeV7xuE3hkp6fv+v5rNXzNQNy4xCWebpq?=
 =?us-ascii?Q?ViIQVC4F4HlJh188IYHP9e1gSG++14aqxOWGXliWc/IVSPyMOYl13TwiJ5j1?=
 =?us-ascii?Q?Uqza0L9P26S5fgTpT4Bz44JDJ8ggONQGslMs2Wffsnu/xIwMXci3vs5IcXiw?=
 =?us-ascii?Q?d6T/WyPRLq7Tu8I98N98da13E/bQcMJyEVBptRUp6QofsNGfEN8voDNYn/p4?=
 =?us-ascii?Q?mrrnYtGKZC63ahkzLFTz0hERWmODUNXv9NmOuOddjdVJl6Ra2bcvojNT2O9t?=
 =?us-ascii?Q?2dG93AKU58MBdEs90Qmj29DGIX8IOh/0f4XW26Uzj7DJkwUwT8Agd1qITx8k?=
 =?us-ascii?Q?E2rc3l5BVASJ51Fuir6IddGvnNsXcq6H5pk00bK+yKhEX+Sgmr7GHFRIm/CY?=
 =?us-ascii?Q?1Jr0TCQx9hldz32rAyZgW7qANc/G0F0Ej07YS7BBc2vPHlO3WKLP4/k8E56g?=
 =?us-ascii?Q?Vv6vunLmZz3h9/2bwoiAlw2arPddA9lxuZSGo56hYmTogxOXeb1WFbKTU4EB?=
 =?us-ascii?Q?70dKUECFN8kl08QsfkQTgLrvYH0nRkP+oDCex7/XSE/eVXGOZtilpeHx/eL9?=
 =?us-ascii?Q?bk0OYN8DZI+CBVhOG9R0c/VKAmT+CjguoPi+zV2Pt4HSU1X17zSrbJXv1RWN?=
 =?us-ascii?Q?LrFgoX1wi36kdrsvI3kckIf0VGoTn64wcrDLZNhJelhbQrYfd24MofU7Vbk3?=
 =?us-ascii?Q?DpX1d5mKXxXvxfPZ84r7bTCheijvSoARWHXZfGIWWlh0t5TaPDarkONr3oLU?=
 =?us-ascii?Q?OJuY6aYxn3IM1WC6KPtkDD6B1Cjzw1bO4aeotYPEfxz60LMi/n1DwGGsTKI6?=
 =?us-ascii?Q?4bBWvVlWvm3wsw20Mac=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:42:31.3227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f22b7e33-63d1-46ec-7618-08de2099ab98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696

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
 drivers/gpu/nova-core/regs/macros.rs |  90 +++++----
 drivers/gpu/nova-core/vbios.rs       |   1 +
 rust/kernel/devres.rs                |  14 +-
 rust/kernel/io.rs                    | 264 ++++++++++++++++++++-------
 rust/kernel/io/mem.rs                |  16 +-
 rust/kernel/io/poll.rs               |   8 +-
 rust/kernel/pci/io.rs                |  12 +-
 samples/rust/rust_driver_pci.rs      |   2 +
 8 files changed, 277 insertions(+), 130 deletions(-)

diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
index 8058e1696df9..39b1069a3429 100644
--- a/drivers/gpu/nova-core/regs/macros.rs
+++ b/drivers/gpu/nova-core/regs/macros.rs
@@ -608,16 +608,18 @@ impl $name {
 
             /// Read the register from its address in `io`.
             #[inline(always)]
-            pub(crate) fn read<const SIZE: usize, T>(io: &T) -> Self where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+            pub(crate) fn read<T, I>(io: &T) -> Self where
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoInfallible,
             {
                 Self(io.read32($offset))
             }
 
             /// Write the value contained in `self` to the register address in `io`.
             #[inline(always)]
-            pub(crate) fn write<const SIZE: usize, T>(self, io: &T) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+            pub(crate) fn write<T, I>(self, io: &T) where
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoInfallible,
             {
                 io.write32(self.0, $offset)
             }
@@ -625,11 +627,12 @@ pub(crate) fn write<const SIZE: usize, T>(self, io: &T) where
             /// Read the register from its address in `io` and run `f` on its value to obtain a new
             /// value to write back.
             #[inline(always)]
-            pub(crate) fn alter<const SIZE: usize, T, F>(
+            pub(crate) fn alter<T, I, F>(
                 io: &T,
                 f: F,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoInfallible,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
                 let reg = f(Self::read(io));
@@ -647,12 +650,13 @@ impl $name {
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
+                I: ::kernel::io::IoInfallible,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 const OFFSET: usize = $name::OFFSET;
@@ -667,13 +671,14 @@ pub(crate) fn read<const SIZE: usize, T, B>(
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
+                I: ::kernel::io::IoInfallible,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 const OFFSET: usize = $name::OFFSET;
@@ -688,12 +693,13 @@ pub(crate) fn write<const SIZE: usize, T, B>(
             /// the register's offset to it, then run `f` on its value to obtain a new value to
             /// write back.
             #[inline(always)]
-            pub(crate) fn alter<const SIZE: usize, T, B, F>(
+            pub(crate) fn alter<T, I, B, F>(
                 io: &T,
                 base: &B,
                 f: F,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoInfallible,
                 B: crate::regs::macros::RegisterBase<$base>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
@@ -713,11 +719,12 @@ impl $name {
 
             /// Read the array register at index `idx` from its address in `io`.
             #[inline(always)]
-            pub(crate) fn read<const SIZE: usize, T>(
+            pub(crate) fn read<T, I>(
                 io: &T,
                 idx: usize,
             ) -> Self where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoInfallible,
             {
                 build_assert!(idx < Self::SIZE);
 
@@ -729,12 +736,13 @@ pub(crate) fn read<const SIZE: usize, T>(
 
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
+                I: ::kernel::io::IoInfallible,
             {
                 build_assert!(idx < Self::SIZE);
 
@@ -746,12 +754,13 @@ pub(crate) fn write<const SIZE: usize, T>(
             /// Read the array register at index `idx` in `io` and run `f` on its value to obtain a
             /// new value to write back.
             #[inline(always)]
-            pub(crate) fn alter<const SIZE: usize, T, F>(
+            pub(crate) fn alter<T, I, F>(
                 io: &T,
                 idx: usize,
                 f: F,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoInfallible,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
                 let reg = f(Self::read(io, idx));
@@ -763,11 +772,12 @@ pub(crate) fn alter<const SIZE: usize, T, F>(
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
+                I: ::kernel::io::IoInfallible,
             {
                 if idx < Self::SIZE {
                     Ok(Self::read(io, idx))
@@ -781,12 +791,13 @@ pub(crate) fn try_read<const SIZE: usize, T>(
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
+                I: ::kernel::io::IoInfallible,
             {
                 if idx < Self::SIZE {
                     Ok(self.write(io, idx))
@@ -801,12 +812,13 @@ pub(crate) fn try_write<const SIZE: usize, T>(
             /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
             /// access was out-of-bounds.
             #[inline(always)]
-            pub(crate) fn try_alter<const SIZE: usize, T, F>(
+            pub(crate) fn try_alter<T, I, F>(
                 io: &T,
                 idx: usize,
                 f: F,
             ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoInfallible,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
                 if idx < Self::SIZE {
@@ -832,13 +844,14 @@ impl $name {
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
+                I: ::kernel::io::IoInfallible,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 build_assert!(idx < Self::SIZE);
@@ -853,14 +866,15 @@ pub(crate) fn read<const SIZE: usize, T, B>(
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
+                I: ::kernel::io::IoInfallible,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 build_assert!(idx < Self::SIZE);
@@ -875,13 +889,14 @@ pub(crate) fn write<const SIZE: usize, T, B>(
             /// by `base` and adding the register's offset to it, then run `f` on its value to
             /// obtain a new value to write back.
             #[inline(always)]
-            pub(crate) fn alter<const SIZE: usize, T, B, F>(
+            pub(crate) fn alter<T, I, B, F>(
                 io: &T,
                 base: &B,
                 idx: usize,
                 f: F,
             ) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoInfallible,
                 B: crate::regs::macros::RegisterBase<$base>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
@@ -895,12 +910,13 @@ pub(crate) fn alter<const SIZE: usize, T, B, F>(
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
+                I: ::kernel::io::IoInfallible,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 if idx < Self::SIZE {
@@ -916,13 +932,14 @@ pub(crate) fn try_read<const SIZE: usize, T, B>(
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
+                I: ::kernel::io::IoInfallible,
                 B: crate::regs::macros::RegisterBase<$base>,
             {
                 if idx < Self::SIZE {
@@ -939,13 +956,14 @@ pub(crate) fn try_write<const SIZE: usize, T, B>(
             /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
             /// access was out-of-bounds.
             #[inline(always)]
-            pub(crate) fn try_alter<const SIZE: usize, T, B, F>(
+            pub(crate) fn try_alter<T, I, B, F>(
                 io: &T,
                 base: &B,
                 idx: usize,
                 f: F,
             ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoInfallible,
                 B: crate::regs::macros::RegisterBase<$base>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 71fbe71b84db..7a0121ab9b09 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -8,6 +8,7 @@
 use core::convert::TryFrom;
 use kernel::device;
 use kernel::error::Result;
+use kernel::io::IoFallible;
 use kernel::prelude::*;
 use kernel::ptr::{Alignable, Alignment};
 use kernel::types::ARef;
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 3376c7090ccd..1dc7cb30d9f2 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -75,14 +75,15 @@ struct Inner<T: Send> {
 /// #   },
 /// #   devres::Devres,
 /// #   io::{
-/// #       Io,
-/// #       IoRaw, //
+/// #       IoInfallible,
+/// #       Mmio,
+/// #       MmioRaw, //
 /// #   }, //
 /// # };
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -97,7 +98,7 @@ struct Inner<T: Send> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -109,11 +110,11 @@ struct Inner<T: Send> {
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
@@ -259,6 +260,7 @@ pub fn device(&self) -> &Device {
     /// # use kernel::{
     /// #   device::Core,
     /// #   devres::Devres,
+    /// #   io::IoInfallible,
     /// #   pci, //
     /// # };
     ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 5af04c3b807b..4d98d431b523 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -20,16 +20,16 @@
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
@@ -68,14 +68,16 @@ pub fn maxsize(&self) -> usize {
 /// #   bindings,
 /// #   ffi::c_void,
 /// #   io::{
-/// #       Io,
-/// #       IoRaw, //
+/// #       IoFallible,
+/// #       IoInfallible,
+/// #       Mmio,
+/// #       MmioRaw, //
 /// #   }, //
 /// # };
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -90,7 +92,7 @@ pub fn maxsize(&self) -> usize {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -102,11 +104,11 @@ pub fn maxsize(&self) -> usize {
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
@@ -120,29 +122,31 @@ pub fn maxsize(&self) -> usize {
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
@@ -152,26 +156,28 @@ pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
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
@@ -181,43 +187,38 @@ pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
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
+pub trait Io {
+    /// Minimum usable size of this region.
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
 
+    /// Returns the absolute I/O address for a given `offset`,
+    /// performing runtime bound checks.
     #[inline]
     fn io_addr<U>(&self, offset: usize) -> Result<usize> {
-        if !Self::offset_valid::<U>(offset, self.maxsize()) {
+        if !offset_valid::<U>(offset, self.maxsize()) {
             return Err(EINVAL);
         }
 
@@ -226,50 +227,173 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
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
+}
+
+/// Types implementing this trait (e.g. MMIO BARs or PCI config
+/// regions) can share the same Infallible accessors.
+pub trait IoInfallible: Io {
+    /// Infallible 8-bit read with compile-time bounds check.
+    fn read8(&self, offset: usize) -> u8;
+
+    /// Infallible 16-bit read with compile-time bounds check.
+    fn read16(&self, offset: usize) -> u16;
+
+    /// Infallible 32-bit read with compile-time bounds check.
+    fn read32(&self, offset: usize) -> u32;
+
+    /// Infallible 8-bit write with compile-time bounds check.
+    fn write8(&self, value: u8, offset: usize);
+
+    /// Infallible 16-bit write with compile-time bounds check.
+    fn write16(&self, value: u16, offset: usize);
+
+    /// Infallible 32-bit write with compile-time bounds check.
+    fn write32(&self, value: u32, offset: usize);
+}
+
+/// Types implementing this trait (e.g. MMIO BARs or PCI config
+/// regions) can share the same Fallible accessors.
+pub trait IoFallible: Io {
+    /// Fallible 8-bit read with runtime bounds check.
+    fn try_read8(&self, offset: usize) -> Result<u8>;
+
+    /// Fallible 16-bit read with runtime bounds check.
+    fn try_read16(&self, offset: usize) -> Result<u16>;
+
+    /// Fallible 32-bit read with runtime bounds check.
+    fn try_read32(&self, offset: usize) -> Result<u32>;
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
+}
+
+impl<const SIZE: usize> IoInfallible for Mmio<SIZE> {
+    define_read!(infallible, read8, readb -> u8);
+    define_read!(infallible, read16, readw -> u16);
+    define_read!(infallible, read32, readl -> u32);
+
+    define_write!(infallible, write8, writeb <- u8);
+    define_write!(infallible, write16, writew <- u16);
+    define_write!(infallible, write32, writel <- u32);
+}
+
+impl<const SIZE: usize> IoFallible for Mmio<SIZE> {
+    define_read!(fallible, try_read8, readb -> u8);
+    define_read!(fallible, try_read16, readw -> u16);
+    define_read!(fallible, try_read32, readl -> u32);
+
+    define_write!(fallible, try_write8, writeb <- u8);
+    define_write!(fallible, try_write16, writew <- u16);
+    define_write!(fallible, try_write32, writel <- u32);
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
 
-    define_read!(read8, try_read8, readb -> u8);
-    define_read!(read16, try_read16, readw -> u16);
-    define_read!(read32, try_read32, readl -> u32);
     define_read!(
+        infallible,
         #[cfg(CONFIG_64BIT)]
-        read64,
-        try_read64,
+        pub read64,
         readq -> u64
     );
 
-    define_read!(read8_relaxed, try_read8_relaxed, readb_relaxed -> u8);
-    define_read!(read16_relaxed, try_read16_relaxed, readw_relaxed -> u16);
-    define_read!(read32_relaxed, try_read32_relaxed, readl_relaxed -> u32);
+    define_write!(
+        infallible,
+        #[cfg(CONFIG_64BIT)]
+        pub write64,
+        writeq <- u64
+    );
+
     define_read!(
+        fallible,
         #[cfg(CONFIG_64BIT)]
-        read64_relaxed,
-        try_read64_relaxed,
-        readq_relaxed -> u64
+        pub try_read64,
+        readq -> u64
     );
 
-    define_write!(write8, try_write8, writeb <- u8);
-    define_write!(write16, try_write16, writew <- u16);
-    define_write!(write32, try_write32, writel <- u32);
     define_write!(
+        fallible,
         #[cfg(CONFIG_64BIT)]
-        write64,
-        try_write64,
+        pub try_write64,
         writeq <- u64
     );
 
-    define_write!(write8_relaxed, try_write8_relaxed, writeb_relaxed <- u8);
-    define_write!(write16_relaxed, try_write16_relaxed, writew_relaxed <- u16);
-    define_write!(write32_relaxed, try_write32_relaxed, writel_relaxed <- u32);
+    define_read!(infallible, pub read8_relaxed, readb_relaxed -> u8);
+    define_read!(infallible, pub read16_relaxed, readw_relaxed -> u16);
+    define_read!(infallible, pub read32_relaxed, readl_relaxed -> u32);
+    define_read!(
+        infallible,
+        #[cfg(CONFIG_64BIT)]
+        pub read64_relaxed,
+        readq_relaxed -> u64
+    );
+
+    define_read!(fallible, pub try_read8_relaxed, readb_relaxed -> u8);
+    define_read!(fallible, pub try_read16_relaxed, readw_relaxed -> u16);
+    define_read!(fallible, pub try_read32_relaxed, readl_relaxed -> u32);
+    define_read!(
+        fallible,
+        #[cfg(CONFIG_64BIT)]
+        pub try_read64_relaxed,
+        readq_relaxed -> u64
+    );
+
+    define_write!(infallible, pub write8_relaxed, writeb_relaxed <- u8);
+    define_write!(infallible, pub write16_relaxed, writew_relaxed <- u16);
+    define_write!(infallible, pub write32_relaxed, writel_relaxed <- u32);
+    define_write!(
+        infallible,
+        #[cfg(CONFIG_64BIT)]
+        pub write64_relaxed,
+        writeq_relaxed <- u64
+    );
+
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
index b03b82cd531b..5dcd7c901427 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -17,8 +17,8 @@
             Region,
             Resource, //
         },
-        Io,
-        IoRaw, //
+        Mmio,
+        MmioRaw, //
     },
     prelude::*,
 };
@@ -203,7 +203,7 @@ pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> +
 }
 
 impl<const SIZE: usize> Deref for ExclusiveIoMem<SIZE> {
-    type Target = Io<SIZE>;
+    type Target = Mmio<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         &self.iomem
@@ -217,10 +217,10 @@ fn deref(&self) -> &Self::Target {
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
@@ -255,7 +255,7 @@ fn ioremap(resource: &Resource) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = IoRaw::new(addr as usize, size)?;
+        let io = MmioRaw::new(addr as usize, size)?;
         let io = IoMem { io };
 
         Ok(io)
@@ -278,10 +278,10 @@ fn drop(&mut self) {
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
index b1a2570364f4..543a4b7cea0d 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -45,12 +45,12 @@
 /// # Examples
 ///
 /// ```no_run
-/// use kernel::io::{Io, poll::read_poll_timeout};
+/// use kernel::io::{IoFallible, Mmio, poll::read_poll_timeout};
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
 ///     read_poll_timeout(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
@@ -128,12 +128,12 @@ pub fn read_poll_timeout<Op, Cond, T>(
 /// # Examples
 ///
 /// ```no_run
-/// use kernel::io::{poll::read_poll_timeout_atomic, Io};
+/// use kernel::io::{poll::read_poll_timeout_atomic, IoFallible, Mmio};
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
 ///     read_poll_timeout_atomic(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 0d55c3139b6f..2bbb3261198d 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -8,8 +8,8 @@
     device,
     devres::Devres,
     io::{
-        Io,
-        IoRaw, //
+        Mmio,
+        MmioRaw, //
     },
     prelude::*,
     sync::aref::ARef, //
@@ -24,7 +24,7 @@
 /// memory mapped PCI BAR and its size.
 pub struct Bar<const SIZE: usize = 0> {
     pdev: ARef<Device>,
-    io: IoRaw<SIZE>,
+    io: MmioRaw<SIZE>,
     num: i32,
 }
 
@@ -60,7 +60,7 @@ pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = match IoRaw::new(ioptr, len as usize) {
+        let io = match MmioRaw::new(ioptr, len as usize) {
             Ok(io) => io,
             Err(err) => {
                 // SAFETY:
@@ -114,11 +114,11 @@ fn drop(&mut self) {
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
index ee6248b8cda5..74b93ca7c338 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -8,6 +8,8 @@
     c_str,
     device::Core,
     devres::Devres,
+    io::IoFallible,
+    io::IoInfallible,
     pci,
     prelude::*,
     sync::aref::ARef, //
-- 
2.51.0


