Return-Path: <linux-pci+bounces-45212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7750D3B82A
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 21:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8900303ADC8
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 20:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42B22EC55D;
	Mon, 19 Jan 2026 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dOO8q8oE"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3792E229F;
	Mon, 19 Jan 2026 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854223; cv=fail; b=uMwkCvHcgpPhD6HpCRNvf6HIOGrU5f25nKb/0XPxBxiPF3hZCgf2m1EiN11sBMoCR1c5bdddTqn3y4jRX64KDY8cR8IwvR9UiurY6bt2PWgGsQ81nHvlHhHy8DxWi/UMtQb+nqL4adZgDSEzFlYxNIJJJpYKoMVbl7gclYr7Mwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854223; c=relaxed/simple;
	bh=F1JazJoud6jQxm6Y7+C5FSSGtS66RbfZgfxhE0V90z4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvcKm3tPqsn09zkLTUhVu0Ip+76Hs93O5YjvlzIoCWU7J7mZB/inPxPbypvK+XuhzukYNjn9F8IJvfjVCMC2SNjtYBqEo1jdYcWirbwDt7e/obzbowbfDKnRrQAUYB+lOrkN6sVK8M/yPMeK5xD5ZY5iMY7IPu+ghkaGrkSJdGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dOO8q8oE; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ho+shrLVa7xUXpQFLMlZMk1teXR1NAJsp3MzKWOXGt8p21aqgwISbe/E0MwEBoPye8XQcuW7x2ZoJxNuAHZhfISsl4vXio/8AEFzsaP5UUfsQ2WjZuELQy9h+qEbxA9xUEGr6rj8/V9pdUvm+Hy6KjBsYxL+BwhZHbKOMiIQ7j9bkvn5zQfsTwdWxkDKr4hO2w1IEatl9I0vnFYZYE2zkPaRDlrwKSPR46bL1HLwhAHFWPtGxMQB7rMoI68x9Y8J4bFS8Jb4rPdkUTMLrKNZzQOjizFqz/R0FuHqI0bcHNc8m+TjVARc8GzqN40X0BIgIVOjpi1krFZhTNhndr/Obw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoYtLOPLeT72NY4ucI8cbGNZWPoTcWFM8dfYMDB9rLA=;
 b=kOCkeOCxFBKoEQTXLW/5DtgR0KrjObAJAOTRvStll/2WLoNz1iWc6O/J4S5rAzROMm8gu1onOT6sfyLq2Dz5KjlAUeViQ1Kl6TvwM2ry7Fp1eEsp2k/ijI98yWoAbWBkE3lLFWut0ldJsnt6WhyFvhZhJklWqNDGTAQwqIRoZes8+kVfW7AMiyNB5bxu63tXq9UycQdULmyr1oZZTTkup07zasQCKBNq47pLfn9xp5bf/EvMjakouwrvqS9huKvYWMck2GzR7tA5tUUbxuk4AK5AMYYGBWkJUSZmcBXooW8A3msimROL+EAu38Ep0HXcGYGOodfRd7A45eCVP1tDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoYtLOPLeT72NY4ucI8cbGNZWPoTcWFM8dfYMDB9rLA=;
 b=dOO8q8oEYm9sgnga/47KT3WSh5cfYh4kN2J437OmrtGOnyR2cQeDmhQS3YEVC+NFnSIrTI9YkZHXP084wXesjeGpqZvpexxeHXDYvSbfhM6u81Q0JdU/VKHc/tx6nSbNPiLuk9mbGcvVLYBX+EDLcl5z0sFunb2DS+xt83XRFRQVxA76aKH12jXSfB7WaNc4w/hdNl628WqfeUPJwEkYbLgzJaRHBFWVrkGCFcIOkl141ww2x82BA+2b92cjVLJ3vGgpIra3v+Yfhc/1eoMY6JZN/YSjsV7JsqqqjYYd8htGfcHd10lWsr83J/bbNUh7ivwCGU8B7DriTy3rvbooHQ==
Received: from PH7P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::14)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 20:23:30 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::55) by PH7P222CA0001.outlook.office365.com
 (2603:10b6:510:33a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 20:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 20:23:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 12:23:12 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 12:23:12 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 19
 Jan 2026 12:23:05 -0800
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
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH v10 2/5] rust: io: separate generic I/O helpers from MMIO implementation
Date: Mon, 19 Jan 2026 22:22:44 +0200
Message-ID: <20260119202250.870588-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119202250.870588-1-zhiw@nvidia.com>
References: <20260119202250.870588-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 959f0237-d466-4be0-633e-08de57989c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9R3MXSZBbm1E4/1raR83aqemSlzzxItTwmrjpY/W2ToO7mBy6EfzK11TNEFp?=
 =?us-ascii?Q?KfGtAMMpk81V8L87g7Iw2raJcSMaU2h9AI5Wgkv+/TFBwPAYMtcom5uvCvTp?=
 =?us-ascii?Q?yWrUGKihr0aWebFodJt5K+USwcOUt7m+X6Pj8YXv4Uj9NOu2xLRgiV44qyy1?=
 =?us-ascii?Q?QVKYgpzR7tEyvKSGe/EqOChukjTXlirE6jfEF36ZWH5rb6+IMkkICA3We27t?=
 =?us-ascii?Q?d5Da42AkpjYj5QpcVlnJFMkXxDxxFnZdVgjpizzk13mHWOASHaShLVDNurKy?=
 =?us-ascii?Q?dUA/4QC9tRtB6ipJbVk+2mFWb9bKTLhCzF+7vHyvSxYlPhhbU/u/i7M8CwiL?=
 =?us-ascii?Q?7izXasqwd4BzccJ8p/ZN3PNfKk+HpGxSt12jmmbKMh95tINw+4xIWy1kXY5E?=
 =?us-ascii?Q?oRGpKAOS88xm/DIfmrDLaZG79Y96Xb+nr/zZXT6ImpimhW4P7BE+Zr5XFqji?=
 =?us-ascii?Q?RxqTZg3YQQHmar95Jr6Gn3pZTW0Z/0Q4WES/dJCNFylUUZ6vQaiPEsAFgpoe?=
 =?us-ascii?Q?YD3NzI23h4jEf4cU9c4GD6WlPAaNQn27h5PmVk05ipVElyu5b5dLYWzsTEJL?=
 =?us-ascii?Q?nwzE9Fl9WtCOtTAtpqYz+RbQyGpjtvoc+3rxtw5EfpKuAeeUEL9HVuiLF1i3?=
 =?us-ascii?Q?P/AjgRkAYH9W06lwFj9M3fQPe1QE4UZEHdY6j3Qxxbm4Mp/SiCMwEPNQ8cjj?=
 =?us-ascii?Q?VALQkqS/Nf0n8iagp1qVCGgmo6XrOu7Z4oPzNcYaaQNFCnXj6/Sh3wo5iMj+?=
 =?us-ascii?Q?lJ2WcYr3yDRnGNp0Z1uzRVz86HE+X13weEd06EyNfdNpfVZBgYAHWcU4BvE1?=
 =?us-ascii?Q?Eabjfos0uFLEVEZdWh26nHAAgEg/4rI4aSQSLKYQ05j4oX55cuv7qdfOO41T?=
 =?us-ascii?Q?0V6mps9kgjY3OFk/EKB3IsHq6oNxs9TUuiJJqZWSCToR/QPndPPWFKvKkQEJ?=
 =?us-ascii?Q?R4S+vyKmxtxq06O0qVs3BdbmZI7PI/SoyPOPN6f3yJxshoVMUONVg6esCNY+?=
 =?us-ascii?Q?XvArr0cCh05NPkO5MTvGYRRaIyA+XApfeKvNQhbkonY5Sna/HK8Qbq0N2Vc1?=
 =?us-ascii?Q?eFzbzenzurYCjW+92gktbsC7LVu1mhzPbLjzc7SAPnIYzmrR9BoTxKZ/t77E?=
 =?us-ascii?Q?YwQXxzcp1ile0AdO5qDF1mZ3Ifsg8dXOOagqm+7BLAd9VFAcGl7w4ECSIeVg?=
 =?us-ascii?Q?aOvvlhd45bLZMsAORghj6r0wJYNuzFne4unnzlsMfr5MgHIHlvdtBmT5zWrb?=
 =?us-ascii?Q?nL0wrINB3SJOiuOZJuov3y5VSlGStuYudMi0DUk+D2u6qXoYFojCg7XQAzHo?=
 =?us-ascii?Q?Pm10F1Pz2fY1936/NMGopij5TjEJCD22/WjcVirGHj/J5tOo8477uQ02gEOh?=
 =?us-ascii?Q?eSFI5vANUBV45wEWLLz55STxotQzfxmQ84gogSolJ3v0ZAtyzn+vaQ7R/QEv?=
 =?us-ascii?Q?PFUlvEjPNnQo7Wy/Cg9GF5gfRQiBm1xafvsAAgbQbNC3iJykXT26iZRGPSlU?=
 =?us-ascii?Q?ypc23sDJZ7X/hAc4MtcgE+ptps6P9cd19WS+dzVenosdEvVEKiXRD2wafVYt?=
 =?us-ascii?Q?PIzsIowpgg+z0Y8sXEVX8pFESTzj3LC7zfo36MVIOccKXUyAPqEZsZBmfKll?=
 =?us-ascii?Q?BNyBUJWV2YfSbpmSyofGqhyrABJQJbkzaKQt4wkofUx2zHxmoY2CscZmcqtr?=
 =?us-ascii?Q?LkSOlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:23:29.9153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 959f0237-d466-4be0-633e-08de57989c36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767

The previous Io<SIZE> type combined both the generic I/O access helpers
and MMIO implementation details in a single struct. This coupling prevented
reusing the I/O helpers for other backends, such as PCI configuration
space.

Establish a clean separation between the I/O interface and concrete backends
by separating generic I/O helpers from MMIO implementation.

Introduce two traits to handle different access capabilities:
- IoCapable<T> trait provides infallible I/O operations (read/write)
  with compile-time bounds checking.
- IoTryCapable<T> trait provides fallible I/O operations
  (try_read/try_write) with runtime bounds checking.
- The Io trait defines convenience accessors (read8/write8, try_read8/
  try_write8, etc.) that forward to the corresponding IoCapable<T> or
  IoTryCapable<T> implementations.

This separation allows backends to selectively implement only the operations
they support. For example, PCI configuration space can implement IoCapable<T>
for infallible operations while MMIO regions can implement both IoCapable<T>
and IoTryCapable<T>.

Move the MMIO-specific logic into a dedicated Mmio<SIZE> type that
implements Io and the corresponding `IoCapable<T>` and `IoTryCapable<T>` traits.
Rename IoRaw to MmioRaw and update consumers to use the new types.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/drm/tyr/regs.rs            |   1 +
 drivers/gpu/nova-core/gsp/sequencer.rs |   5 +-
 drivers/gpu/nova-core/regs/macros.rs   |  90 +++---
 drivers/gpu/nova-core/vbios.rs         |   1 +
 rust/kernel/devres.rs                  |  15 +-
 rust/kernel/io.rs                      | 396 ++++++++++++++++++++-----
 rust/kernel/io/mem.rs                  |  16 +-
 rust/kernel/io/poll.rs                 |  16 +-
 rust/kernel/pci/io.rs                  |  12 +-
 samples/rust/rust_driver_pci.rs        |   1 +
 10 files changed, 420 insertions(+), 133 deletions(-)

diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index f46933aaa221..d3a541cb37c6 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -11,6 +11,7 @@
 use kernel::device::Bound;
 use kernel::device::Device;
 use kernel::devres::Devres;
+use kernel::io::Io;
 use kernel::prelude::*;
 
 use crate::driver::IoMem;
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
index fd1a815fa57d..6909ed8743bd 100644
--- a/drivers/gpu/nova-core/regs/macros.rs
+++ b/drivers/gpu/nova-core/regs/macros.rs
@@ -369,16 +369,18 @@ impl $name {
 
             /// Read the register from its address in `io`.
             #[inline(always)]
-            pub(crate) fn read<const SIZE: usize, T>(io: &T) -> Self where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+            pub(crate) fn read<T, I>(io: &T) -> Self where
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
             {
                 Self(io.read32($offset))
             }
 
             /// Write the value contained in `self` to the register address in `io`.
             #[inline(always)]
-            pub(crate) fn write<const SIZE: usize, T>(self, io: &T) where
-                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
+            pub(crate) fn write<T, I>(self, io: &T) where
+                T: ::core::ops::Deref<Target = I>,
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
+                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
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
index 43089511bf76..a2089e7431d0 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -74,14 +74,16 @@ struct Inner<T: Send> {
 ///     devres::Devres,
 ///     io::{
 ///         Io,
-///         IoRaw,
-///         PhysAddr,
+///         Mmio,
+///         MmioRaw,
+///         PhysAddr, //
 ///     },
+///     prelude::*,
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -96,7 +98,7 @@ struct Inner<T: Send> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -108,11 +110,11 @@ struct Inner<T: Send> {
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
@@ -258,6 +260,7 @@ pub fn device(&self) -> &Device {
     /// use kernel::{
     ///     device::Core,
     ///     devres::Devres,
+    ///     io::Io,
     ///     pci, //
     /// };
     ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index a97eb44a9a87..fa1a81ba656b 100644
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
@@ -81,14 +81,15 @@ pub fn maxsize(&self) -> usize {
 ///     ffi::c_void,
 ///     io::{
 ///         Io,
-///         IoRaw,
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
@@ -103,7 +104,7 @@ pub fn maxsize(&self) -> usize {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -115,11 +116,11 @@ pub fn maxsize(&self) -> usize {
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
@@ -133,29 +134,31 @@ pub fn maxsize(&self) -> usize {
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
@@ -163,74 +166,116 @@ pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
         }
     };
 }
+pub(crate) use define_read;
 
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
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
+            unsafe { bindings::$c_fn(value, addr as *mut c_void) };
             Ok(())
         }
     };
 }
-
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
+pub(crate) use define_write;
+
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
+/// Trait representing infallible I/O operations of a certain type.
+///
+/// This trait is used to provide compile-time bounds-checked I/O operations.
+/// Different I/O backends can implement this trait to expose only the operations they support.
+///
+/// For example, a PCI configuration space may implement `IoCapable<u8>`, `IoCapable<u16>`,
+/// and `IoCapable<u32>`, but not `IoCapable<u64>`, while an MMIO region on a 64-bit
+/// system might implement all four.
+pub trait IoCapable<T> {
+    /// Infallible read with compile-time bounds check.
+    fn read(&self, offset: usize) -> T;
+
+    /// Infallible write with compile-time bounds check.
+    fn write(&self, value: T, offset: usize);
+}
+
+/// Trait representing fallible I/O operations of a certain type.
+///
+/// This trait is used to provide runtime bounds-checked I/O operations.
+/// Backends that do not support fallible operations (e.g., PCI configuration space)
+/// do not need to implement this trait.
+pub trait IoTryCapable<T> {
+    /// Fallible read with runtime bounds check.
+    fn try_read(&self, offset: usize) -> Result<T>;
+
+    /// Fallible write with runtime bounds check.
+    fn try_write(&self, value: T, offset: usize) -> Result;
+}
+
+/// Types implementing this trait (e.g. MMIO BARs or PCI config regions)
+/// can perform I/O operations on regions of memory.
+///
+/// This is an abstract representation to be implemented by arbitrary I/O
+/// backends (e.g. MMIO, PCI config space, etc.).
+///
+/// The [`Io`] trait provides:
+/// - Base address and size information
+/// - Helper methods for offset validation and address calculation
+/// - Both infallible (compile-time checked) and fallible (runtime checked)
+///   accessors for different data widths
+///
+/// Which I/O methods are available depends on which [`IoCapable<T>`] and
+/// [`IoTryCapable<T>`] traits are implemented for the type.
+///
+/// # Examples
+///
+/// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
+/// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
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
 
@@ -239,50 +284,257 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
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
+    fn read8(&self, offset: usize) -> u8
+    where
+        Self: IoCapable<u8>
+    {
+        <Self as IoCapable<u8>>::read(self, offset)
+    }
+
+    /// Infallible 16-bit read with compile-time bounds check.
+    fn read16(&self, offset: usize) -> u16
+    where
+        Self: IoCapable<u16>
+    {
+        <Self as IoCapable<u16>>::read(self, offset)
+    }
+
+    /// Infallible 32-bit read with compile-time bounds check.
+    fn read32(&self, offset: usize) -> u32
+    where
+        Self: IoCapable<u32>
+    {
+        <Self as IoCapable<u32>>::read(self, offset)
+    }
+
+    /// Infallible 64-bit read with compile-time bounds check.
+    #[cfg(CONFIG_64BIT)]
+    fn read64(&self, offset: usize) -> u64
+    where
+        Self: IoCapable<u64>
+    {
+        <Self as IoCapable<u64>>::read(self, offset)
+    }
+
+    /// Infallible 8-bit write with compile-time bounds check.
+    fn write8(&self, value: u8, offset: usize)
+    where
+        Self: IoCapable<u8>
+    {
+        <Self as IoCapable<u8>>::write(self, value, offset)
+    }
+
+    /// Infallible 16-bit write with compile-time bounds check.
+    fn write16(&self, value: u16, offset: usize)
+    where
+        Self: IoCapable<u16>
+    {
+        <Self as IoCapable<u16>>::write(self, value, offset)
+    }
+
+    /// Infallible 32-bit write with compile-time bounds check.
+    fn write32(&self, value: u32, offset: usize)
+    where
+        Self: IoCapable<u32>
+    {
+        <Self as IoCapable<u32>>::write(self, value, offset)
+    }
+
+    /// Infallible 64-bit write with compile-time bounds check.
+    #[cfg(CONFIG_64BIT)]
+    fn write64(&self, value: u64, offset: usize)
+    where
+        Self: IoCapable<u64>
+    {
+        <Self as IoCapable<u64>>::write(self, value, offset)
+    }
+
+    /// Fallible 8-bit read with runtime bounds check.
+    fn try_read8(&self, offset: usize) -> Result<u8>
+    where
+        Self: IoTryCapable<u8>
+    {
+        <Self as IoTryCapable<u8>>::try_read(self, offset)
+    }
+
+    /// Fallible 16-bit read with runtime bounds check.
+    fn try_read16(&self, offset: usize) -> Result<u16>
+    where
+        Self: IoTryCapable<u16>
+    {
+        <Self as IoTryCapable<u16>>::try_read(self, offset)
+    }
+
+    /// Fallible 32-bit read with runtime bounds check.
+    fn try_read32(&self, offset: usize) -> Result<u32>
+    where
+        Self: IoTryCapable<u32>
+    {
+        <Self as IoTryCapable<u32>>::try_read(self, offset)
+    }
+
+    /// Fallible 64-bit read with runtime bounds check.
+    #[cfg(CONFIG_64BIT)]
+    fn try_read64(&self, offset: usize) -> Result<u64>
+    where
+        Self: IoTryCapable<u64>
+    {
+        <Self as IoTryCapable<u64>>::try_read(self, offset)
+    }
+
+    /// Fallible 8-bit write with runtime bounds check.
+    fn try_write8(&self, value: u8, offset: usize) -> Result
+    where
+        Self: IoTryCapable<u8>
+    {
+        <Self as IoTryCapable<u8>>::try_write(self, value, offset)
+    }
+
+    /// Fallible 16-bit write with runtime bounds check.
+    fn try_write16(&self, value: u16, offset: usize) -> Result
+    where
+        Self: IoTryCapable<u16>
+    {
+        <Self as IoTryCapable<u16>>::try_write(self, value, offset)
+    }
+
+    /// Fallible 32-bit write with runtime bounds check.
+    fn try_write32(&self, value: u32, offset: usize) -> Result
+    where
+        Self: IoTryCapable<u32>
+    {
+        <Self as IoTryCapable<u32>>::try_write(self, value, offset)
+    }
+
+    /// Fallible 64-bit write with runtime bounds check.
+    #[cfg(CONFIG_64BIT)]
+    fn try_write64(&self, value: u64, offset: usize) -> Result
+    where
+        Self: IoTryCapable<u64>
+    {
+        <Self as IoTryCapable<u64>>::try_write(self, value, offset)
+    }
+}
+
+// MMIO regions support 8, 16, and 32-bit accesses.
+impl<const SIZE: usize> IoCapable<u8> for Mmio<SIZE> {
+    define_read!(infallible, read, readb -> u8);
+    define_write!(infallible, write, writeb <- u8);
+}
+
+impl<const SIZE: usize> IoCapable<u16> for Mmio<SIZE> {
+    define_read!(infallible, read, readw -> u16);
+    define_write!(infallible, write, writew <- u16);
+}
+
+impl<const SIZE: usize> IoCapable<u32> for Mmio<SIZE> {
+    define_read!(infallible, read, readl -> u32);
+    define_write!(infallible, write, writel <- u32);
+}
+
+// MMIO regions on 64-bit systems also support 64-bit accesses.
+#[cfg(CONFIG_64BIT)]
+impl<const SIZE: usize> IoCapable<u64> for Mmio<SIZE> {
+    define_read!(infallible, read, readq -> u64);
+    define_write!(infallible, write, writeq <- u64);
+}
+
+impl<const SIZE: usize> IoTryCapable<u8> for Mmio<SIZE> {
+    define_read!(fallible, try_read, readb -> u8);
+    define_write!(fallible, try_write, writeb <- u8);
+}
+
+impl<const SIZE: usize> IoTryCapable<u16> for Mmio<SIZE> {
+    define_read!(fallible, try_read, readw -> u16);
+    define_write!(fallible, try_write, writew <- u16);
+}
+
+impl<const SIZE: usize> IoTryCapable<u32> for Mmio<SIZE> {
+    define_read!(fallible, try_read, readl -> u32);
+    define_write!(fallible, try_write, writel <- u32);
+}
+
+#[cfg(CONFIG_64BIT)]
+impl<const SIZE: usize> IoTryCapable<u64> for Mmio<SIZE> {
+    define_read!(fallible, try_read, readq -> u64);
+    define_write!(fallible, try_write, writeq <- u64);
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
index b1a2570364f4..75d1b3e8596c 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -45,12 +45,16 @@
 /// # Examples
 ///
 /// ```no_run
-/// use kernel::io::{Io, poll::read_poll_timeout};
+/// use kernel::io::{
+///     Io,
+///     Mmio,
+///     poll::read_poll_timeout, //
+/// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
 ///     read_poll_timeout(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
@@ -128,12 +132,16 @@ pub fn read_poll_timeout<Op, Cond, T>(
 /// # Examples
 ///
 /// ```no_run
-/// use kernel::io::{poll::read_poll_timeout_atomic, Io};
+/// use kernel::io::{
+///     Io,
+///     Mmio,
+///     poll::read_poll_timeout_atomic, //
+/// };
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
index ef04c6401e6a..38c949efce38 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -7,6 +7,7 @@
 use kernel::{
     device::Core,
     devres::Devres,
+    io::Io,
     pci,
     prelude::*,
     sync::aref::ARef, //
-- 
2.51.0


