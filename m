Return-Path: <linux-pci+bounces-44590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D611CD17AA2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 10:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81CAE30C2CA7
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 09:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0701E38A714;
	Tue, 13 Jan 2026 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jY3WY3LQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC7F387369;
	Tue, 13 Jan 2026 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296236; cv=fail; b=KFss3VaGva/nUbdiaybXB+dHGaxhsWICbkFbwa+81GygkxbZDRZrdnFT4kSnAs80G89CLqbu7l9j83dT9xAuK5KTTfgCrwEdZ+M9INFzoFJSeChVZGTmLE8OYtKF4G/gbosMVNDnNnDY37yjlAYxDz+SZ8HME+6KLewhiCkggkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296236; c=relaxed/simple;
	bh=p0yxXjEiqVyPX7b+q4Xgi1OOJ7ueTTtmTj31juyiatw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DURkXyltgQSmzM/CN6pqlU9r6AghVjzhkS1RYQmNObIwctWrUJDpBmpr8KGQE5BNGgnasRGbenR71tq9Sulck0UeoQDaykuHuwRJIZn8SXSUCtauDeSoUk42tG/MNPlxCvp3BzqJgvyfbg01AdqVXm+O1s64Oe8SO0BPJeX0RzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jY3WY3LQ; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AN8VpPuOUKqQT+YisjhBaemoxSnNHf1xA8mpDxsCD71lGvTBqZOrxo8ZwfbiVARvsDAD3e8zOOcOxXn4lmyXQUQxn70hgp7/Y6SQZY5KBokAHye77nnXCc7PDHA+Q7iOER2svZeJEr3flF5Ys21eWzEAc5+SD3lSzqxp3gZJrhami65LNOWr82Qhzc87oTUNh6PNPyUMjEuZBoxsNH5ck+3D3r63CwXTrgk2NCvXDWzVziWxlKIWMRFSJrOQ9kp6QOIbY6omJJYEBK4VIeaLWwKxpcOGFvNZLGGh4ty00kHR3snoKEkgWbTy+mwh2eDJcfOEo4k8fmOqPS8DZTHn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nEFHISzbGcYLTTFZzw+n+PnJ5gbBFKhfHOAuGv4t4I=;
 b=U2OQWTqr0MGkMcqHoiDDaKEO6J8Q/FOD/xQA/eMvqoDqJc/JEhdNA2eq5j1HhIQBvYsTNnFJc/qTJfk1bKsMM8cu07HrzE2LwyetXg2xXxtQGN8dUqdv9983GZGM60RAD+B6NERaBy/tjUKeJusT3T+DSbdXIQtlua7L4fVscYNeI25pqw1SUwJBmgkrcIo5gRzPFN+7N3d2OPwDSgCu3uAAyzfu9QskMW0bBoqbvCyIOikwVgt8u+ENdWzEYM1zvXd4SWQZch5OlyhsUNcNuFX58A2Jr91RWajBt52SIgZiqtmTDbpizjoB9E6hJdfbeG4CbwlbDSmzSu54mVS2Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nEFHISzbGcYLTTFZzw+n+PnJ5gbBFKhfHOAuGv4t4I=;
 b=jY3WY3LQv9216ROG8GgTU4NTQxr0Mn910Yrmuac+BYaNcywNd1Pclq08IPfSbMzgDs3O3rHqH6jVKNyqyT19d1aBa4eSt3uDIZ5sygXgoBcV2eSuFfgb3bR4Dm8wwhFjXE6kG73BpX1mD3T26V4i62ft3TAwfLbhAvc1Iapeqo2S+aexf/q0x2oReQkxn0bCTqZbzjRKjV0HaqBIJctjeLq4Sgm7uQ8BupICDLov2My5jWNWLB3s1xwF1ru6fAknL5fUZx2mS9YkrE1UXpiN1hFvLa2OAm9Xnk5j+JBwsyepQH2MC5tXD13puw0EnY+OqGDB2rQ0q7CVUdtpCprkSw==
Received: from SJ0PR03CA0378.namprd03.prod.outlook.com (2603:10b6:a03:3a1::23)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 09:23:39 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::70) by SJ0PR03CA0378.outlook.office365.com
 (2603:10b6:a03:3a1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 09:23:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 09:23:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 01:23:17 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 01:23:16 -0800
Received: from inno-vm-xubuntu (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 13
 Jan 2026 01:23:10 -0800
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
Subject: [PATCH v8 2/5] rust: io: factor common I/O helpers into Io trait
Date: Tue, 13 Jan 2026 11:22:49 +0200
Message-ID: <20260113092253.220346-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113092253.220346-1-zhiw@nvidia.com>
References: <20260113092253.220346-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca0f9d3-1a0e-42f5-b613-08de52856f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pcdruogk88XlwsiNaEfPi9luK41WVHby1j17c6Mf/EdLc+CtW56vXSG/wj4p?=
 =?us-ascii?Q?mhvx94JANLJjZVmcvqw+DBiaaSrY/udkRTSfbtVHQkwKRkeoRejN/G6+2xlf?=
 =?us-ascii?Q?63LAc6J3ncoir8LBK5/0AAUkBPiFPY9/Rj3p+0fpWPzeZE+sin7XndQiGShW?=
 =?us-ascii?Q?cgSKEpT5smJF/r0bvn/Tel0gjZa/pO/LVRpU3P9rlX14AqzqsSnpUsUBcpSP?=
 =?us-ascii?Q?FGXM5bmtPPtKoRu2V1nu/a5Zi3RTRM7C7d2zrrg30LZRGO5aio472RTe9vpI?=
 =?us-ascii?Q?cvL/otcds5w2caQWz3RT3Qh3GnsZjLkuU+97wvK3zk5ES9kKs6d00KFfcZpB?=
 =?us-ascii?Q?ytSTBJfCC1MyYenvOnT/QekpiY6Q+ncCAJsZQfvOQzrxsdUC/CDIJ94d5gSg?=
 =?us-ascii?Q?+db6D43W7DMQL+YdUhEEUphE/nJf5qhrkR3WCw9y0J7oVkK6pYn63DWrz2Ci?=
 =?us-ascii?Q?rFyl1XZGXBCJTFWmlpRaE3g4HgquELTIBnVkdT50+7U05sRM/dkYZa80Dc/J?=
 =?us-ascii?Q?sdRmfjHGyoF/qtlVJiwoYlIKi9rw2WD83ouGHbd1DQWcUi7+b+hHGROCpV7s?=
 =?us-ascii?Q?Czh72XxbyH5CWZ09LWLgY0K3cRQ0MIZ+yjY7thFUokmQBNjV/MvMwmcUtNBi?=
 =?us-ascii?Q?bbSP3WqkunTlk0VBaHNCLxLEMhf2FH+KMoprvNTVtxVfweL8osclmcfIjeJm?=
 =?us-ascii?Q?uCO8hLPwl5jQFwy0Upw4UM2649BVMG8jhnIVUuiWcQD5TUbJKq3VaCa91jB3?=
 =?us-ascii?Q?yiNPwPt6roR0GPEVou/a4h34GgM56mq9wi505izVLQF5y8IYIrEiTlKRTNv/?=
 =?us-ascii?Q?zl1rN2Atk1ff0VXa+yhjz9HtQCOeCN1IYuZhmeU0qxwpzUIvBqCE1bFE6k4L?=
 =?us-ascii?Q?6Av1pe/oFABESYukMFeUn4r1PGxsmlULLXjcuhMnSSCIemr1NHh5k52YLOvt?=
 =?us-ascii?Q?k/1mVS0s4jR56cVJYZ/wVndrLtouiCUeOmqGAou8pV4SiCa60twPGAuSJDAj?=
 =?us-ascii?Q?OhWsdQqfZU0pUYchQaei/d2alWImPAAj7/K+9lCGDW4J4a5SouxObTdc/aou?=
 =?us-ascii?Q?Tb6SBctoTy/u+J6T9QyfXs12deYj+VsCtSHdVSVr52ZCoF5d/nmmONZSAD/t?=
 =?us-ascii?Q?7Wu648l7/yl+mva6ZIeMkOWfEfASrov38j4wQP4pL9AoxfidORYsXeBkCrDS?=
 =?us-ascii?Q?pzkWfmY8rK5Ky9+MJkFhn081FdcN+8Xwj69lCbGgz6bP03R1W8f5b4mxhYeW?=
 =?us-ascii?Q?REAlLATIq1Egx3gbwOk555RniN03tiPKZzqBWE2yE9UxDrZf/ivKWXuzwXFA?=
 =?us-ascii?Q?eoWULDl4OmTsJxog60EEwfAK8to8dYpUx3ShZsHDmNLBX/1EVrVcopLIHRUU?=
 =?us-ascii?Q?D0Oq9UGWebyBWuhfpQFSkL1GIxDnrB8KzAwSdZf64hlWQhN+e9mApzn6XluI?=
 =?us-ascii?Q?1Kz3LWnDrOq/H2finmUFd4FY6Nye59REmnzVvhOjoBzaFE4TTdpIxhwpMiFA?=
 =?us-ascii?Q?FLd3dmwsuFUFm1gWGR5kXD0nd/iAepCdccqAzOVwoX65bUEtS8ulBOvrXj2o?=
 =?us-ascii?Q?RsMZD/etW/nz+fZX6y8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 09:23:38.7604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca0f9d3-1a0e-42f5-b613-08de52856f90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756

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
 drivers/gpu/nova-core/gsp/sequencer.rs |   5 +-
 drivers/gpu/nova-core/regs/macros.rs   |  90 ++++----
 drivers/gpu/nova-core/vbios.rs         |   1 +
 rust/kernel/devres.rs                  |  14 +-
 rust/kernel/io.rs                      | 271 ++++++++++++++++++-------
 rust/kernel/io/mem.rs                  |  16 +-
 rust/kernel/io/poll.rs                 |   8 +-
 rust/kernel/pci/io.rs                  |  12 +-
 samples/rust/rust_driver_pci.rs        |   2 +
 9 files changed, 288 insertions(+), 131 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index 2d0369c49092..862cf7f27143 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -12,7 +12,10 @@
 
 use kernel::{
     device,
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        Io, //
+    },
     prelude::*,
     time::{
         delay::fsleep,
diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
index fd1a815fa57d..6c7d164937a0 100644
--- a/drivers/gpu/nova-core/regs/macros.rs
+++ b/drivers/gpu/nova-core/regs/macros.rs
@@ -369,16 +369,18 @@ impl $name {
 
             /// Read the register from its address in `io`.
             #[inline(always)]
-            pub(crate) fn read<const SIZE: usize, T>(io: &T) -> Self where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+            pub(crate) fn read<T, I>(io: &T) -> Self where
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize,
             {
                 Self(io.read32($offset))
             }
 
             /// Write the value contained in `self` to the register address in `io`.
             #[inline(always)]
-            pub(crate) fn write<const SIZE: usize, T>(self, io: &T) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+            pub(crate) fn write<T, I>(self, io: &T) where
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::IoKnownSize,
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
+                I: ::kernel::io::IoKnownSize,
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
+                I: ::kernel::io::IoKnownSize,
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
+                I: ::kernel::io::IoKnownSize,
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
+                I: ::kernel::io::IoKnownSize,
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
+                I: ::kernel::io::IoKnownSize,
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
+                I: ::kernel::io::IoKnownSize,
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
+                I: ::kernel::io::IoKnownSize,
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
+                I: ::kernel::io::IoKnownSize,
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
+                I: ::kernel::io::IoKnownSize,
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
+                I: ::kernel::io::IoKnownSize,
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
+                I: ::kernel::io::IoKnownSize,
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
+                I: ::kernel::io::IoKnownSize,
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
+                I: ::kernel::io::IoKnownSize,
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
+                I: ::kernel::io::IoKnownSize,
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
+                I: ::kernel::io::IoKnownSize,
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
+                I: ::kernel::io::IoKnownSize,
                 B: crate::regs::macros::RegisterBase<$base>,
                 F: ::core::ops::FnOnce(Self) -> Self,
             {
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index abf423560ff4..fe33b519e4d8 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -6,6 +6,7 @@
 
 use kernel::{
     device,
+    io::Io,
     prelude::*,
     ptr::{
         Alignable,
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 43089511bf76..dfaddac2af59 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -73,15 +73,16 @@ struct Inner<T: Send> {
 ///     },
 ///     devres::Devres,
 ///     io::{
-///         Io,
-///         IoRaw,
+///         IoKnownSize,
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
@@ -96,7 +97,7 @@ struct Inner<T: Send> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -108,11 +109,11 @@ struct Inner<T: Send> {
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
@@ -258,6 +259,7 @@ pub fn device(&self) -> &Device {
     /// use kernel::{
     ///     device::Core,
     ///     devres::Devres,
+    ///     io::IoKnownSize,
     ///     pci, //
     /// };
     ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index a97eb44a9a87..6e7f0d48ba3e 100644
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
@@ -81,14 +81,16 @@ pub fn maxsize(&self) -> usize {
 ///     ffi::c_void,
 ///     io::{
 ///         Io,
-///         IoRaw,
+///         IoKnownSize,
+///         Mmio,
+///         MmioRaw,
 ///         PhysAddr,
 ///     },
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also `pci::Bar` for a real example.
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
+pub trait IoBase {
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
 
@@ -239,50 +240,180 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
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
+/// regions) can share the same KnownSize accessors.
+pub trait IoKnownSize: IoBase {
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
+/// regions) can share the same Io accessors.
+pub trait Io: IoBase {
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
+/// Types implementing this trait can share the same Infallible accessors.
+#[cfg(CONFIG_64BIT)]
+pub trait IoKnownSize64: IoKnownSize {
+    /// Infallible 64-bit read with compile-time bounds check.
+    fn read64(&self, offset: usize) -> u64;
 
-    define_read!(read8, try_read8, readb -> u8);
-    define_read!(read16, try_read16, readw -> u16);
-    define_read!(read32, try_read32, readl -> u32);
+    /// Infallible 64-bit write with compile-time bounds check.
+    fn write64(&self, value: u64, offset: usize);
+}
+
+/// Types implementing this trait can share the same Fallible accessors.
+#[cfg(CONFIG_64BIT)]
+pub trait Io64: Io {
+    /// Fallible 64-bit read with runtime bounds check.
+    fn try_read64(&self, offset: usize) -> Result<u64>;
+
+    /// Fallible 64-bit write with runtime bounds check.
+    fn try_write64(&self, value: u64, offset: usize) -> Result;
+}
+
+impl<const SIZE: usize> IoBase for Mmio<SIZE> {
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
+impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {
+    define_read!(infallible, read8, readb -> u8);
+    define_read!(infallible, read16, readw -> u16);
+    define_read!(infallible, read32, readl -> u32);
+
+    define_write!(infallible, write8, writeb <- u8);
+    define_write!(infallible, write16, writew <- u16);
+    define_write!(infallible, write32, writel <- u32);
+}
+
+impl<const SIZE: usize> Io for Mmio<SIZE> {
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
+impl<const SIZE: usize> IoKnownSize64 for Mmio<SIZE> {
+    define_read!(infallible, read64, readq -> u64);
+
+    define_write!(infallible, write64, writeq <- u64);
+}
+
+#[cfg(CONFIG_64BIT)]
+impl<const SIZE: usize> Io64 for Mmio<SIZE> {
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
index e4878c131c6d..620022cff401 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -16,8 +16,8 @@
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
@@ -212,7 +212,7 @@ pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> +
 }
 
 impl<const SIZE: usize> Deref for ExclusiveIoMem<SIZE> {
-    type Target = Io<SIZE>;
+    type Target = Mmio<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         &self.iomem
@@ -226,10 +226,10 @@ fn deref(&self) -> &Self::Target {
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
@@ -264,7 +264,7 @@ fn ioremap(resource: &Resource) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = IoRaw::new(addr as usize, size)?;
+        let io = MmioRaw::new(addr as usize, size)?;
         let io = IoMem { io };
 
         Ok(io)
@@ -287,10 +287,10 @@ fn drop(&mut self) {
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
index b1a2570364f4..65d5a370ed14 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -45,12 +45,12 @@
 /// # Examples
 ///
 /// ```no_run
-/// use kernel::io::{Io, poll::read_poll_timeout};
+/// use kernel::io::{Io, Mmio, poll::read_poll_timeout};
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
+/// use kernel::io::{poll::read_poll_timeout_atomic, Io, Mmio};
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
index 70e3854e7d8d..e3377397666e 100644
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
@@ -27,7 +27,7 @@
 /// memory mapped PCI BAR and its size.
 pub struct Bar<const SIZE: usize = 0> {
     pdev: ARef<Device>,
-    io: IoRaw<SIZE>,
+    io: MmioRaw<SIZE>,
     num: i32,
 }
 
@@ -63,7 +63,7 @@ pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = match IoRaw::new(ioptr, len as usize) {
+        let io = match MmioRaw::new(ioptr, len as usize) {
             Ok(io) => io,
             Err(err) => {
                 // SAFETY:
@@ -117,11 +117,11 @@ fn drop(&mut self) {
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
index ef04c6401e6a..f7130a359768 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -7,6 +7,8 @@
 use kernel::{
     device::Core,
     devres::Devres,
+    io::Io,
+    io::IoKnownSize,
     pci,
     prelude::*,
     sync::aref::ARef, //
-- 
2.51.0


