Return-Path: <linux-pci+bounces-41603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDAFC6E3CB
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 12:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06EE84F43E6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 11:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E5E32F74C;
	Wed, 19 Nov 2025 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TzTjUVBP"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E47F31ED78;
	Wed, 19 Nov 2025 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551348; cv=fail; b=dJ3uwCL/Bt3TRJ2gm9k2nuJu82cYao9G0IGbCmjuAK8Vcd3RwyzXuAHDJaAN9kJFXHofF3a9E5VwUwV8OOVwKn3MmLPFBTB/Gbqqi24sg0+gMwtbiBFHGycnntrHlln0KC3YcU5F6lKNbu5ocCha9yCdO4WTyfYjtWmATpFwVXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551348; c=relaxed/simple;
	bh=QHHFP+vkxMVgoPfga3DNBHRlKIfOv0zKIyJAzWQkNjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cf8vCLmWU0lgVQB8cBBCcWN5Ha7lsolxWpcwdHH+mFcWtvHf21LAxUvYUDn09fdCXJlFbrwJUF0UpK56sJEtGlMcvMmUa8J5NUFdf+UVJLfngEXuObZI8wiXVwneVqlICs8HaKwDb9ieZedjZDGZqvtsqtrX5W0ZKaMby1ZGcBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TzTjUVBP; arc=fail smtp.client-ip=52.101.48.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXjwVRDVGPMfqQ7NfbuoGEcLH0/+B/qLamnR491hvy4oxrf0mn/n3a9eXCSpskr3HzIRHpT1e8/g1ceqIrHLLSwRbunb9pYctCoGIb8YDoonoDXMni8ux+tTXN9LjdSxmG+6ep8ETuvT+nx+fGAadQ5JZui+WLshoUvdZKszl56fSjeyNIpkZyvdHWaINuarSiunkPfPU2+OmPk6yFnNdL9IZpqsxFU1lXW27N8evEr+g8QubDhTu8mUJuanzv5gK7Y2baEV8TII+QunsPnNDWjMQutvusEmfqmQpMMpl98vdqS82cGI36glAgIWFNYuRkCnR65+fRjH0/Vaw0f6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZampANZjTjfHIFrgibjVx1+JSMHi+x7OCIFWMqTBds=;
 b=imdBD4cVR2h4WJvFmcMBlhQENvfsdtLug/LeDdkHfLr02ngAm1Bhgy6eeeE6kqYjl4MACHPF8KjKwu97rBtd54AbOWdt9t8YWlYN+9O3nCtzKw2tObXp9+ln7aTeo7mWkQjBY5hk9yFl4yFbQ44IH7ktn0A8bk9g47ChDzK7qLBeJoJ4HutED7W3CJHRbTb8I/4ze4RvL798tUHv5Gpk0yFpruKZxB7IiApRminYJl1R3QDrFkoB8KMnrq3bCa+StkoC4GV9mmt3mAd8zY0O44wMviyWisNXwQGrmervHIEek04uCfCRV2c/RJwGg+idZXiPtDi1ysWHt5Pay13u2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZampANZjTjfHIFrgibjVx1+JSMHi+x7OCIFWMqTBds=;
 b=TzTjUVBP/GWMP1O9cMGaASq8U0+m4W0hIO1hJMrKBPetIeEQbZCz0MacOtnUjVRzgee5uVZfbyeKV/UKPGjFLWtDWhBhBCnMrnl86JOwQnaDsmc4qs/9mYLxBM2dm2k0soL86OAC6+uXlseSE3DeMaezwmSHfjZ6CWyRuKPNBvQ7Zkop5qzN7Z7CoEfAQYaPvgOZdhvC9DDpAgQJ6n7RcPKwy7r0AgnCS0KcKgLRtq6GrnmA0W1YQrMwMREb2K6qCrg51925c3GmtZGPywgM9RTKSwf2UtLo9mXg1TpPsAR5iG0E09q+ZEYLIeshGuA9wuOxy4dmMSb9QUJ4XNXwog==
Received: from CH2PR08CA0026.namprd08.prod.outlook.com (2603:10b6:610:5a::36)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 11:22:16 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::6c) by CH2PR08CA0026.outlook.office365.com
 (2603:10b6:610:5a::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 11:22:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 11:22:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 03:22:06 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 03:22:05 -0800
Received: from inno-vm-xubuntu (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 03:21:56 -0800
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
Subject: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io trait
Date: Wed, 19 Nov 2025 13:21:13 +0200
Message-ID: <20251119112117.116979-4-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119112117.116979-1-zhiw@nvidia.com>
References: <20251119112117.116979-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f06be6-6251-4700-5792-08de275de551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aldb/4ALLlIB88gjZO1WGLLivQwUANh0uQ6pCaywqMFV82DhGvEY2Y+ux52K?=
 =?us-ascii?Q?zVjaH2KcsdZ8LKV5OB3Ude/ug7N3xqpM4rFhXzdVr0daS82X5LZJwakDXQ+j?=
 =?us-ascii?Q?c0Ku7WLbgkmsK1s/zOs117ehPa3E9faV/d+VNadYjNQzD8Id6GR2v9wX0cLs?=
 =?us-ascii?Q?w4hK6XrWgAG5kFP5kGhGiMklXVTAibp3/my7KrLtUlo09RDo4faHSTZHQO7U?=
 =?us-ascii?Q?zuegSXeaGOwjrD5Tg4Vz8ayyjH4cF1HpWbSwnuFBnsB2jfFGHyDdQ352Kt/r?=
 =?us-ascii?Q?Na4KzSp5ShklokC56Gw0o9OMwkeoKQZok2u80PWkN4vsl2d6w7ldGG4PBirf?=
 =?us-ascii?Q?BhMjcDcWqYjiJsq95rTHTLskYO0uKBsHA3QRzb8kcEu9wmBuU/Sgas8QYLmu?=
 =?us-ascii?Q?khMsCQDrrV7l65SbrZUWwfD0W95XXrEKYDr1MUHnXn0Y2t+XbD0+MbJEW9Hp?=
 =?us-ascii?Q?I1gCMdO1m2i9fpmHo/lXu5SWne66e/ndKOB4vuMxJP0i4iZdfZRkxTs1qPfi?=
 =?us-ascii?Q?xaH2rtRxNeGuRuC+i1oNz1R659HZM3fh8oGkxAv2/zXNPB8CUwpaZbSfNdQc?=
 =?us-ascii?Q?8AJ7JaeeoFO9yobdelUUhz3F77IbFDzHIrPzzKpF2cjU5sGm/8iYCK5kyqEe?=
 =?us-ascii?Q?JlGgdL7FFup/jFonJHaxWnaBuZVhlskSYZZRd3152ZKi2yeFj3QkSuLCDNG2?=
 =?us-ascii?Q?LL/Q8VYZQoHDSzBVmMPQv13VTWeePwYcTxy06bCE66JrJ4bKslFh0PBe7Ndm?=
 =?us-ascii?Q?n2uXmKIIoPCa0G+C9WzBiu6Niz1bSEVjqADfNjtVw0C4ozR8WrXpsJy5g4YN?=
 =?us-ascii?Q?R9EjcxUSxgZ8avMA/IKbvdkhsw+VUx1lbPSLGdXsLnBIvyr/InHm1MiNXysL?=
 =?us-ascii?Q?Ml8HsLzhNwqVjIXaVJn6tZSRz4bKecWGhvlaYxb00qUivdOgJTYNTmsg39tq?=
 =?us-ascii?Q?7JhubNbQ3zMJDFuODhb67gYUKVP5XMzVyMCu0SR8qrfQL75e2nl9qd0yuVdo?=
 =?us-ascii?Q?ZOQTnpLjHveRWycaNeQuAzz+AASFZnAh8c5LydcOJXaU3AE713qXPzb31GZC?=
 =?us-ascii?Q?VJTI0KkgfOYQcYiRUk+9/7T1eIxOT0e5y8PVvVuZSV6JDgzc4b2emXOccz6q?=
 =?us-ascii?Q?GbOlGY8Hs+bn1ZzhOtvhWBmEUHIOO+W+Vg14V1TvJrHqal95ItotysqD9NR+?=
 =?us-ascii?Q?YqXWr8ZMDTJ+DB2RXKKiu9Ab+3fMBcc8S9lWbdKO3v38kjfvdnsodRCoh71B?=
 =?us-ascii?Q?4uFM7ZfOXZfeLeTysa0wtJPvOMBK2wSbS6VKr3iTjmydojpGyvoS0DTX1b84?=
 =?us-ascii?Q?3VKbPQfX9aNST55ewDWSAIeUUcwpbvVjG7Vchk0imb8Rf76oQRYDtlWEfkOK?=
 =?us-ascii?Q?YfrkUPOXL3LBQLDzly5To7d84eUygkZS+dklZ3QPplnmtENEwIlzIQ573wLS?=
 =?us-ascii?Q?TPGmUpPA4Mzso5HI6TTFch/LPCbszMpDV8Ivkud5oKN6M+tbSgP47mOtg7Em?=
 =?us-ascii?Q?+cdN3AhBsRAqiS1GIOI0AUtSU4wO+ypL6fC8qvSD2V2zFyL8FgT/1pwN1QKq?=
 =?us-ascii?Q?CLAPxwDq00INoMBqSTM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 11:22:16.4706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f06be6-6251-4700-5792-08de275de551
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461

The previous Io<SIZE> type combined both the generic I/O access helpers
and MMIO implementation details in a single struct.

To establish a cleaner layering between the I/O interface and its concrete
backends, paving the way for supporting additional I/O mechanisms in the
future, Io<SIZE> need to be factored.

Factor the common helpers into new {Io, Io64} traits, and move the
MMIO-specific logic into a dedicated Mmio<SIZE> type implementing that
trait. Rename the IoRaw to MmioRaw and update the bus MMIO implementations
to use MmioRaw.

No functional change intended.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/regs/macros.rs |  90 +++++----
 drivers/gpu/nova-core/vbios.rs       |   1 +
 rust/kernel/devres.rs                |  14 +-
 rust/kernel/io.rs                    | 283 ++++++++++++++++++++-------
 rust/kernel/io/mem.rs                |  16 +-
 rust/kernel/io/poll.rs               |   8 +-
 rust/kernel/pci/io.rs                |  12 +-
 samples/rust/rust_driver_pci.rs      |   2 +
 8 files changed, 295 insertions(+), 131 deletions(-)

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
index 659f513a72a6..ad72943adbbe 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -75,15 +75,16 @@ struct Inner<T: Send> {
 ///     },
 ///     devres::Devres,
 ///     io::{
-///         Io,
-///         IoRaw,
+///         IoInfallible,
+///         Mmio,
+///         MmioRaw,
 ///         PhysAddr,
 ///     },
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -98,7 +99,7 @@ struct Inner<T: Send> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -110,11 +111,11 @@ struct Inner<T: Send> {
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
@@ -260,6 +261,7 @@ pub fn device(&self) -> &Device {
     /// use kernel::{
     ///     device::Core,
     ///     devres::Devres,
+    ///     io::IoInfallible,
     ///     pci, //
     /// };
     ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 98e8b84e68d1..3e6ea29835ae 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -32,16 +32,16 @@
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
@@ -80,15 +80,17 @@ pub fn maxsize(&self) -> usize {
 ///     bindings,
 ///     ffi::c_void,
 ///     io::{
-///         Io,
-///         IoRaw,
+///         IoFallible,
+///         IoInfallible,
+///         Mmio,
+///         MmioRaw,
 ///         PhysAddr,
 ///     },
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -103,7 +105,7 @@ pub fn maxsize(&self) -> usize {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -115,11 +117,11 @@ pub fn maxsize(&self) -> usize {
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
@@ -133,29 +135,31 @@ pub fn maxsize(&self) -> usize {
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
@@ -165,26 +169,28 @@ pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
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
@@ -194,43 +200,38 @@ pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
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
 
@@ -239,50 +240,190 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
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
+/// Represents a region of I/O space of a fixed size with 64-bit accessors.
+///
+/// Provides common helpers for offset validation and address
+/// calculation on top of a base address and maximum size.
+///
+#[cfg(CONFIG_64BIT)]
+pub trait Io64: Io {}
 
-    define_read!(read8, try_read8, readb -> u8);
-    define_read!(read16, try_read16, readw -> u16);
-    define_read!(read32, try_read32, readl -> u32);
+/// Types implementing this trait can share the same Infallible accessors.
+#[cfg(CONFIG_64BIT)]
+pub trait IoInfallible64: Io64 {
+    /// Infallible 64-bit read with compile-time bounds check.
+    fn read64(&self, offset: usize) -> u64;
+
+    /// Infallible 64-bit write with compile-time bounds check.
+    fn write64(&self, value: u64, offset: usize);
+}
+
+/// Types implementing this trait can share the same Infallible accessors.
+#[cfg(CONFIG_64BIT)]
+pub trait IoFallible64: Io64 {
+    /// Fallible 64-bit read with runtime bounds check.
+    fn try_read64(&self, offset: usize) -> Result<u64>;
+
+    /// Fallible 64-bit write with runtime bounds check.
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
+#[cfg(CONFIG_64BIT)]
+impl<const SIZE: usize> Io64 for Mmio<SIZE> {}
+
+#[cfg(CONFIG_64BIT)]
+impl<const SIZE: usize> IoInfallible64 for Mmio<SIZE> {
+    define_read!(infallible, read64, readq -> u64);
+
+    define_write!(infallible, write64, writeq <- u64);
+}
+
+#[cfg(CONFIG_64BIT)]
+impl<const SIZE: usize> IoFallible64 for Mmio<SIZE> {
+    define_read!(fallible, try_read64, readq -> u64);
+
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


