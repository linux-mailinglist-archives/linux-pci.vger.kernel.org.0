Return-Path: <linux-pci+bounces-40776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 341F3C49476
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 21:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3344A3A2BBB
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338B42F12CE;
	Mon, 10 Nov 2025 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W4Jv4e2o"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935682F1FDB;
	Mon, 10 Nov 2025 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807320; cv=fail; b=Rnw3COWgFtyITDvFxdYAuBkPeSA4omI9zmhUYt7UifFSj09dMmM6qZCMuBVEm2ZBl4L1D7TnKzDcOcRUIBIWfwLXvM6CwXHFtlL7kqDPeHK1BBF5FhwCmmYB5N790M2x7WNFW5MQYRCuXRK3HO4w6HsrB2/j3Q9Knh2LHNYwHaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807320; c=relaxed/simple;
	bh=VsY6Kp5IhOw69gSSswt9Ca+CTrL2JOeuCSwPhlt2pa4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tp0L9Q6AcJ/IArRGMLd3uUSfg0OVq//rFkw4LyrwvVlgvaj8qyii1sFObuire11+yGBf0wJYglFWQyb0z952iW0RbdAKGOWe11B4uXYrQgEtsLm7r3lpxWuaVsoA8ovnLkqkDP5v9yMic8cmjWqszCJsmJrmPfViQaEDTbSP3y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W4Jv4e2o; arc=fail smtp.client-ip=40.93.194.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LR0409nSeJ/SyowOokopx20/2M489prVBLdA6DIkHZpAE5eMse22m/3h23cPKQ8keYK8IJaOaw193BJZuOvF6p+HVbx5cMpMUgKL0HiTf8Q5vre5CUM5MNsxqgPHuZgvZRdHz6Yp96wY1001wWJDzXE8tfNcIK83uqlFYRLr0S4nJiDoB+slVxwXqXP0Vk3beNrK4Wf+SUbzHo4NtFBQahlf7X78PaLKdbshW26gzT60PN39Ht3c56lsuOg3Izw+N5h4mx8+6uXUhH7+4Gt8AEUPQcNzZhbhsx3S+L/Vuid4nv/jFwrCKDQCufe/Z4rX5OH8WvI2Dd9dvd/0hlN5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9pfALPHfKIh2taGprc+4E0pWqVX8p6pKIoIn41Rqtw=;
 b=Q0CE8EJrwlD3L2YDGpQMvfjfAZQhxJiWG5QsupCGreySEmntIZm1SIdfbkHIk/3ANN01d8FJ8Qw6GDMj8wRpfz6wCfovqetPLE02NYYqjsgIfqpC+R9FHodT8CcUxn/9KODuzdJA8Wrcg6KTGmn61YzheokR/y6aOWEDAqlNUyi61DMai7uiErn861ShL3RG7Z/tKvYIyWd75IeYTMX9k+S7UOyjm6qaGtXKZPqSKSYMHE+tFV+fg2Ai9devko7xlCmH+xeIiRsFfyuHQsiHS1CUb9URa5JcJCRIOha0qupW+YRfjswrO6Yb7hPyp6yJQDAyrD39hgW/8VkGSh1Glg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9pfALPHfKIh2taGprc+4E0pWqVX8p6pKIoIn41Rqtw=;
 b=W4Jv4e2ohByIW7l1kUIG/8dxxQiP5xksRDKhBUy/rAdBe2iwk++oLQFKcCIeduvIQ6og8PG7dJsSboKpVnCn0rSfXMT7wR3UwF+w8/I1z/LN3jPVaiD1frgYUXSXFmc31UCcKmBMnlFbVteTG17Gk3+mdxBuZDyz0/xag+BVxgihW+DY3O+u7Q1j8ec8KFGyRy3MCVHaxikQT6gGnsEM3v2I/5NbyG6tWp3git+UwRDiHK0qeAREsGx4OrillwvkgjIM4Yrhrwf/I+F2kbcfLuuN4OHyz3fKVPnChd7sfYpxmLhJN/eH9lBNTY/ElvkmPRm22PsNV9iXdJg90gcopA==
Received: from CYXPR02CA0035.namprd02.prod.outlook.com (2603:10b6:930:cc::7)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:41:52 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::7f) by CYXPR02CA0035.outlook.office365.com
 (2603:10b6:930:cc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 20:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 20:41:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:41:33 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:41:32 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10
 Nov 2025 12:41:24 -0800
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
Subject: [PATCH v6 RESEND 0/7] rust: pci: add config space read/write support
Date: Mon, 10 Nov 2025 22:41:12 +0200
Message-ID: <20251110204119.18351-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: a62b38b7-f253-4e3b-9a9e-08de20999403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vIKA3RQ+pfBRWoW1L1QGAMSL3hupJqaq6CAT7LfrUYlKirrWWLkmYRJymtmU?=
 =?us-ascii?Q?a1cEWiZfl1iXfTy1opb0JNZF9G1lVnTOtWLRva7CRWq/6eRrPlkWpr4Csvd3?=
 =?us-ascii?Q?HREqLwfVh5V0SokkThaggQme988l26kLxEny6kXVLk8XTM0jKdeKYAb/QCaM?=
 =?us-ascii?Q?ruzZf8q6VovNJDjWnjdH3LtgZPgDsWAyLYYbHPqO5f1wdCXrs7qVGldBnz5i?=
 =?us-ascii?Q?Zx5i5UleSsEKJVMNVvMa6d4ZToTN8RetvTYCqBQYcInsH1F5HJXzP5x+9IJC?=
 =?us-ascii?Q?xSMXCVrXyuZ6egtzixDQBKIf0+gTrzOu5a5AymzNWbhK8owNaOuZW5WCQf9y?=
 =?us-ascii?Q?wxbJUW17DH1P6HM3TA0swiofsfr3zYFQJ8SoWVhtfmHMiyxQBy3ruTAl/h3q?=
 =?us-ascii?Q?4l+WaPE5lmMMBQbtYF/OTRNvs/ttYHIkklpwoQUymGwhy0LVOb8JIoTzLMUJ?=
 =?us-ascii?Q?3WZQCw/kFUUSwrZL3S1n7hvgFTAECAryXyuLPNvxjpU+O5O/zAdiYG2QUvL6?=
 =?us-ascii?Q?bipM8lEDbe2Ro9ga3MRjs+FDoLO0jXB1JKPmh8+i2KqOJHzexnkxKAWBwfas?=
 =?us-ascii?Q?kBnBE3QpTKXZOGLa7EPp+XDxA6OYHCw5/BA5dBqyH/v2QtNOYPzaB6Ik2XGd?=
 =?us-ascii?Q?e9oedV/jhvcU+fk1ezXhsjRTBUF1mQIktl9F93AnZ2v65rNdpx802gDWJWhd?=
 =?us-ascii?Q?XY322Ifq6BJHCzHyhKvM7LItgSqZXPs907JVkf4vO6aUUGKMQcupIZelbbOy?=
 =?us-ascii?Q?1TDp6VC8Ptz70RZ5B8sdLoKRkR5GcbrYYmdX2zdhu186OSuMPiVWbxpR0CWm?=
 =?us-ascii?Q?mzxCWmagu46uX5sgqPP4a4OEhtoR/mtZVpdaPoZwc3FDoEw0PWAkkoCne3MG?=
 =?us-ascii?Q?Wr5vo0Fx/YjLbZxY6eevE2xISyOUMUJ/zvbQzKEipvn6i0hqojy+Ni/QeCvC?=
 =?us-ascii?Q?WacFb0xUJh5zTNPIt7xZZPyfu02NHEndEkgJZ8dJSJrwTpmkO2mZfHl7yQh3?=
 =?us-ascii?Q?CdjvOUzSNllg7NoBLat8u28XTJ+dy51yr4uuK6+5OJlfSTlO4hNLo2izJfID?=
 =?us-ascii?Q?yIvMflso+QYrVgOJZHOg8TcwuS6sOgD5e++MLTOivASpn5iH3tXUF5hhT8no?=
 =?us-ascii?Q?bjsfS3ImozxsvsBB9B3/sERYmiUtDyk/IK8p4QjPFVqh4L8dT/zf3klce71Y?=
 =?us-ascii?Q?p7T6yv0vguz3OGNXVXWrq0yyYS343cXUo+Jsj/njVjPar1o3q+ulcNKOPLaX?=
 =?us-ascii?Q?HpDGzPhu8b0WTfwYYCM1tERlT7hgquwockypCGLbmPTLoUqBQMEo+7y9550Y?=
 =?us-ascii?Q?/zYJhwFahoiSyKnCfLj8HUnmXGU70RjCxrV5D7Y629Z2oHUw0WeVrrXTO026?=
 =?us-ascii?Q?vIIpXEcR6d7t6mVcLHJ5SVN++QLPPWj68dGVbtIyXVs1ZA4yrbyQ08UuXVy3?=
 =?us-ascii?Q?SAi/6gA9hOP9zP2eEPaW4FB4kxOCeSwR0qslWZHZyRI8hPoeRa+amV6Ps+93?=
 =?us-ascii?Q?yy8S++jzpeKzbc6LdFoL3yzCicyTBWqjqDaMuyO3OojpPKfKDJqHsnvEqsxq?=
 =?us-ascii?Q?0qqFVMjM9Skb/gTejOQWvJF7nksbHigbX23XdWxB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:41:51.7462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a62b38b7-f253-4e3b-9a9e-08de20999403
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

In the NVIDIA vGPU RFC [1], the PCI configuration space access is
required in nova-core for preparing gspVFInfo when vGPU support is
enabled. This series is the following up of the discussion with Danilo
for how to introduce support of PCI configuration space access in Rust
PCI abstractions.

This patch series is implemented based on kernel vertical fixes patches
[2][3].

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
[2] https://lore.kernel.org/all/20251104133301.59402-1-dakr@kernel.org/
[3] https://lore.kernel.org/all/20251105120352.77603-1-dakr@kernel.org/

Zhi Wang (7):
  samples: rust: rust_driver_pci: use "kernel vertical" style for
    imports
  rust: devres: style for imports
  rust: io: style for imports
  rust: io: factor common I/O helpers into Io trait
  rust: io: factor out MMIO read/write macros
  rust: pci: add config space read/write support
  sample: rust: pci: add tests for config space routines

 drivers/gpu/nova-core/regs/macros.rs |  90 +++++---
 drivers/gpu/nova-core/vbios.rs       |   1 +
 rust/kernel/devres.rs                |  64 ++++--
 rust/kernel/io.rs                    | 323 ++++++++++++++++++++-------
 rust/kernel/io/mem.rs                |  16 +-
 rust/kernel/io/poll.rs               |   8 +-
 rust/kernel/pci.rs                   |  41 +++-
 rust/kernel/pci/io.rs                |  85 ++++++-
 samples/rust/rust_driver_pci.rs      |  38 +++-
 9 files changed, 519 insertions(+), 147 deletions(-)

-- 
2.51.0


