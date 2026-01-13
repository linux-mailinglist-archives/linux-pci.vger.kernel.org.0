Return-Path: <linux-pci+bounces-44589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A00D17B14
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 10:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B615430E1A9F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D139389DF4;
	Tue, 13 Jan 2026 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N3Qlwnp/"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482DA389440;
	Tue, 13 Jan 2026 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296211; cv=fail; b=N1iRaLesfXff6xdI2F7tlcywus7eTXPW3X+7azLeywugAZrUukvRv4oVBQybr0i7f8CS5HS+QWA2pWl3tPPXgra635aKrUNMHJGqZ1AGnpYz+xWSQAcu+ATn+11B4c1+fZulIuZDqVnDEhrFPDZSuGxxndjrO7PAYKyos12zfAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296211; c=relaxed/simple;
	bh=nzQsK9QClVGmZJJvF3QRR8xy7br+ECQrkmY4FSeiLVE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JZDESYUkOdi2c0mUAw6e1Q8QU0UGozXeZNPruaHlpGoyfiA2ZiTVCCdMbSj0w4DD1Vz3PnhNNpHeDfzr6JB3WH+eIl/m/5m6RX9t4FYngQtNH3m67XOlwtgeZiXGQ2uKZVz77g57iEZgmP5fJQT7ojHPBoptMdUvkzJg0TuVJIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N3Qlwnp/; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvCNCHwC1nrcIpb+IFuA7Hth6r1B8sYj20H6otF4a7bAx7q89QhGXkmxBtGBh0LjnGdojIgaoFLccDXPBVQkP/Sj0hxANtDUREaXVTfcWHkSWTT5cQjUfyH4tbKtfYvz3iwSMg0f3HHoLNGdajmNbkDlqUkErR7H2dDGwF7rWtFMxIeAwrReQvTjV+z7C41ltbju+GZ7dCes05W24x8EV+kQS1PFLUzkVqNaYq/HgekAYnX2lBv8ItKNdzBuGMyHCSRULa9Fe6hTvJlPS51+aVi0b/dq9VYYyv01RKjy5KD1zNRt4V8NNGdQiKFzFdaT3pxRgS/SpUnu48mrgm4/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zCP3Go0v53jtsRGCguknsHi5NIvhzuKpmEuKuLxQu8=;
 b=adacQBhAxBV3mW7adI5JNMrKsmPSzdmNu5+vCtfQTmTVsH3K9dqtqzHeTd3zKduHVwdJzEZB0astE8icOlpGR7mJvuBwWr0soPUDgObKwcdExWuMGcpobVtpJ92OyFMP55iZUG3Ex8vPukLb8CyDUfrE+sIIV6ui/Qko02NznmsrXEl8vmZou66WzS0JcaJBSVX+JdoDsfDlXNQkCCd9c74ef1HoF11FHPib8cqfIRuPc6nejwU/8vsy0qQo+PsFEbmPjvCDv1Rq0hnJE26plv0wrzel6RE1WeMwfxnMJdUPhyRd+9xJr1+WBDhT0tvGQ0IoZnbNtoBNXJvbyak+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zCP3Go0v53jtsRGCguknsHi5NIvhzuKpmEuKuLxQu8=;
 b=N3Qlwnp/zOooKqO5IIvXEc7gZ8fTMHKniFJVBDwwrPN8Ngnocv7EfC5hSwf6yTrVYJuPUhspk68ptycBrfEfvII737Jxis5hcXbtj7xgbBfNSeup+LqVkoLIQQNDhKlfLDCwxiiXKXNiDJ4x68cnpEHPB+UR4ormI+vGvRnLWwL/E65QN909JlsbjDSK39u0/47GfNAFhy//RYWNgaOK/G9dQPTLiZyckJwTAlGfmCIGmXqkTyC7KE/f+vZodKgykIrf68KBQLg0roy2vgqRy6ue467Bg9ijV4Gwzeq4ZxAira+jQUxBjddlL7GM9TXivzQuglFj7YHnuUJ9AxS3eQ==
Received: from SJ2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:a03:505::8)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 09:23:22 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::6a) by SJ2PR07CA0008.outlook.office365.com
 (2603:10b6:a03:505::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 09:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 09:23:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 01:23:02 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 01:23:02 -0800
Received: from inno-vm-xubuntu (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 13
 Jan 2026 01:22:56 -0800
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
Subject: [PATCH v8 0/5] rust: pci: add config space read/write support
Date: Tue, 13 Jan 2026 11:22:47 +0200
Message-ID: <20260113092253.220346-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: babe093a-7be0-4402-71f9-08de52856511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lmhCdcMPdZ11Y6+s2oveqyNCSx8lnQ+9+WJvMpvQowrKPIxD55auM3uixZp+?=
 =?us-ascii?Q?CQ5hPbPTQ+H4GDQbYvjPOeYwNOUo2wstna+ovtO3r4iG4tjFVvRtV20CzrwG?=
 =?us-ascii?Q?BF77rTfY3SwRdkqkk4XjqfWtglsvKYi+mrMYSAOzZ4/uNqwItN9JU9P6P3Bz?=
 =?us-ascii?Q?XUW11zkRPg6HaciZsKT+xGAT9Hy1J8ZJLbmT6j+wf1Z10EXzbf9gKZ+gEjAm?=
 =?us-ascii?Q?vUh66PWBrITbzgdbYLEuylb0ihY9xyjemaAeu4QH26/tatbeAesUb6UhzQM8?=
 =?us-ascii?Q?ADRX4AgPsy5oCuWwOnUqIhRFv17Z+OGJA4wtpvyEKmSL13948xOVffMwIjKc?=
 =?us-ascii?Q?OTZItM7cPoQVpuziXlm9KX+RY95h24cJBVtgcSrhrQlHxt/p03hx06aek8os?=
 =?us-ascii?Q?iCYdEgrR2k1w3B0i52cvnCLc3xXfd9MllTItLKzcg5+qCkXSPCJHg1YpJkaz?=
 =?us-ascii?Q?RzlQ76sz9LIjlGo/qzFpRyyTxtdECEt5NlpFP5CbcNF7eMnM/VdWIdCv+BYi?=
 =?us-ascii?Q?XXJ+Www8yi2F7OKXCenZD6lSkfGnsYLksBYZlGpmBK9fIDcL3LiVjwl+C7R7?=
 =?us-ascii?Q?gyXwB2zw3tpAngjtCoYdwcquovEd4HbxFapQbnl6/3vrGHlhgYOSxT/fmUtT?=
 =?us-ascii?Q?U9SLcR1cw2UQgWNTzXBQt5xFZkBxr4X3SnOzDHh1AWRFNW38kiXYe/jt8M/a?=
 =?us-ascii?Q?Gko6z4JUH1DfBel+eqCHoZZtln26+jAzqWrgEgF4TTlrxKtGNzrcXps6Ny+V?=
 =?us-ascii?Q?kwxICtMqf2lIllYG8jW7NYWBJlzha/uk8IzHcKWWMV5ojD8MX8s65a7LXxK+?=
 =?us-ascii?Q?WpFSlgWBjSzeckU0/dawwfzzUIYhdGN729Xft/Qskydy4Bj1V7Xcf5/oyiqg?=
 =?us-ascii?Q?zpOP316+TR+AESn26TrkOBZobcDDgvRW4pVRstHM/9IAb3HKlydfRZ6GVlwf?=
 =?us-ascii?Q?06tIiW5m2CqO5j3X6VsvI/GeJVnG8/NIeZY8dwNU1Xoo6wXYfRYNZjxte55i?=
 =?us-ascii?Q?nldMKSVk9FD1DfkLhIsbQO8UkkFoqKDAnhspTCKe7v5yLbCheL5gENVbgx+a?=
 =?us-ascii?Q?m3XkJoQuggWNbQ1QvRhoT2blKeNAZM5AjVJ0SAnA1+t09UvJIXfQJj8y9n06?=
 =?us-ascii?Q?B6AEopem5tYfUigQmjbMJvKxj5deSf88VCUU15HvZooKcDs4glajkowWL2k6?=
 =?us-ascii?Q?S5eLUoMgF9kzTSO1iEDHo2jJhKK9qoIwDvI22heBcBgcopaW8wjXUvuleNbH?=
 =?us-ascii?Q?TjxUcDJvZUDBzm6qX0QWonV4x95Z2HwlhWjBpZNJSo39SX9bBcVQXBCtN3dP?=
 =?us-ascii?Q?4RmNGnNkWJavikMJ6DQwcrwAi7XFHt5iC5NkNoCb03Qi0amhTNlhgN855HxF?=
 =?us-ascii?Q?1q4QqC8TzSUzVPomPBh0FiWEdOGAycgdLodG4O7MybmnSJCH61JZ7SvRUxkd?=
 =?us-ascii?Q?YmGUJ6IrSCQn1E54auUdjaME16SS5fQJJZ+auP7udpySjKrCj8BZ8SQOdFa1?=
 =?us-ascii?Q?OtAS83XqD/KU74v9nm5HgQ7W3rr44Dh8+2kz1Ium35SimGNiIJAjIzfD0Pg3?=
 =?us-ascii?Q?eL+DRSf3YsiadpUdPgs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 09:23:21.1524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: babe093a-7be0-4402-71f9-08de52856511
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217

In the NVIDIA vGPU RFC [1], the PCI configuration space access is
required in nova-core for preparing gspVFInfo when vGPU support is
enabled. This series is the following up of the discussion with Danilo
for how to introduce support of PCI configuration space access in Rust
PCI abstractions. Alice/Alex/I had a discussion of the next steps of
this patch series in LPC 2025. We agreed that first introducing the
functionality before the BoundedInteger work and other refinement is
settled. [2]

The repo with the patches can be found at [3].

v8:

- Rebase to latest driver-core-testing branch.
- Refinement of traits name and hierarchy: (Alice)
  * Rename IoInfallible trait to IoKnownSize trait.
  * Keep Infallible helpers in Io trait.

v7:

- Rebase to latest driver-core-testing branch.
- Introduce Io64 trait. (Alice)
- Add docs for call_{mmio, config}_{read, write}() macros. (Alex)
- Improve the define_{read, write} macros. (Alex)
- Add SAFETY/CAST in call_config_{read, write}. (Joel)
- Fix typo of method name. (Alex/Joel)

v6:

- Implement config_space() and config_space_extended() in device::Bound
  lifecycle. (Danilo)
- Fix the "use" in the comment for generating proper rust docs, verify
  the output of rustdoc. (Miguel)
- Improve the comments of PCI configuration space when checking the
  output of rustdoc.

v5:

- Remove fallible accessors of PCI configuration space. (Danilo)
- Add #[repr(usize)] for enum ConfigSpace. (Danilo)
- Refine the handling of return value in read accessors. (Danilo)
- Add debug_assert!() in pdev::cfg_size(). (Danilo)
- Add ConfigSpace.as_raw() for extracting the raw value. (Danilo)
- Rebase the patches on top of driver-core-testing branch.
- Convert imports touched by this series to vertical style.

v4:

- Refactor the SIZE constant to be an associated constant. (Alice)
- Remove the default method implementations in the Io trait. (Alice)
- Make cfg_size() private. (Danilo/Bjorn)
- Implement the infallible accessors of ConfigSpace. (Danilo)
- Create a new Io64 trait specifically for 64-bit accessors. (Danilo)
- Provide two separate methods for driver: config_space() and
  config_space_extended(). (Danilo)
- Update the sample driver to test the infallible accessors. (Danilo)

v3:

- Turn offset_valid() into a private function of kernel::io:Io. (Alex)
- Separate try and non-try variants. (Danilo)
- Move all the {try_}{read,write}{8,16,32,64} accessors to the I/O trait.
  (Danilo)
- Replace the hardcoded MMIO type constraint with a generic trait bound
  so that register! macro can be used in other places. (Danilo)
- Fix doctest. (John)
- Add an enum for PCI configuration space size. (Danilo)
- Refine the patch comments. (Bjorn)

v2:

- Factor out common trait as 'Io' and keep the rest routines in original
  'Io' as 'Mmio'. (Danilo)
- Rename 'IoRaw' to 'MmioRaw'. Update the bus MMIO implementation to use
  'MmioRaw'.
- Introduce pci::Device<Bound>::config_space(). (Danilo)
- Implement both infallible and fallible read/write routines, the device
  driver decicdes which version should be used.

This ideas of this series are:

- Factor out common traits for other accessors to share the same
  compiling/runtime check like before.

- Factor the MMIO read/write macros from the define_read! and
  define_write! macros. Thus, define_{read, write}! can be used in other
  backends.

  In detail:

  * Introduce `call_mmio_read!` and `call_mmio_write!` helper macros
    to encapsulate the unsafe FFI calls.
  * Update `define_read!` and `define_write!` macros to delegate to
    the call macros.
  * Export `define_read` and `define_write` so they can be reused
    for other I/O backends (e.g. PCI config space).

- Implement the PCI configuration space access backend in PCI
  abstractions.

- Add tests for config space routines in rust PCI sample driver.

[1] https://lore.kernel.org/all/20250903221111.3866249-1-zhiw@nvidia.com/
[2] https://lore.kernel.org/all/DEOMBKIRDXH6.2CF2MR2RB2W2C@nvidia.com/
[3] https://github.com/zhiwang-nvidia/nova-core/tree/rust-for-linux/pci-configuration-space-v8

Zhi Wang (5):
  rust: devres: style for imports
  rust: io: factor common I/O helpers into Io trait
  rust: io: factor out MMIO read/write macros
  rust: pci: add config space read/write support
  sample: rust: pci: add tests for config space routines

 drivers/gpu/nova-core/gsp/sequencer.rs |   5 +-
 drivers/gpu/nova-core/regs/macros.rs   |  90 ++++---
 drivers/gpu/nova-core/vbios.rs         |   1 +
 rust/kernel/devres.rs                  |  30 ++-
 rust/kernel/io.rs                      | 354 +++++++++++++++++++------
 rust/kernel/io/mem.rs                  |  16 +-
 rust/kernel/io/poll.rs                 |   8 +-
 rust/kernel/pci.rs                     |  43 ++-
 rust/kernel/pci/io.rs                  | 130 ++++++++-
 samples/rust/rust_driver_pci.rs        |  29 ++
 10 files changed, 558 insertions(+), 148 deletions(-)

-- 
2.51.0


