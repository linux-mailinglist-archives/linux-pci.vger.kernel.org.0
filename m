Return-Path: <linux-pci+bounces-41600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E25C6E3A4
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 12:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56D774E7B8F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 11:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE5B33D6C2;
	Wed, 19 Nov 2025 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ApItoJ/c"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F3E31ED78;
	Wed, 19 Nov 2025 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551314; cv=fail; b=Ol3waoRR9fHYlUv8CgFlP5WNB6i6Tigd+JJetvtmD6ZNVkFx7Wn4YtSywKYVt6sOsbZg7EfPp3SOiKaJ4YjkNKloXPjZyWtyfTyWSocdLe9DnY8W17lTNNUIlIWO2q6rV7IMQbT4uH3dZzVJYkIttCqflHtyCE7VzCgqdE37ahM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551314; c=relaxed/simple;
	bh=ZsfUy629VNzFHM4aZSZTFQIB3aJdHRZe9IJbuLywfbs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f1Og1pIburSdkgLRStzPMRWL41jMItFA2fBEwOklGjzhzMV+XOpVNa7H2aHRqLG3x3qF6GU5U0nb9wYN1HSvd65gPXT7H3GlaJ28IwJSMBXYArWrEoTDMfGCMP6lVb1po4vS6qarjWFRbYdHaPIXI5iiNSDGUyqwygBjWLORvHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ApItoJ/c; arc=fail smtp.client-ip=52.101.85.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7dQKHxvwBRXd8zMuwfgS40OVP1J0s5riwPn8LtDwiTa2MP3VBPFz55s8trYbY7ZMZNcHVCpBNBKELieq8ZCrEft87g7PiO3/x4Rxw+eKP0tAiqk2uboRxCU0+0+RxgH4kIVpQ4OM1k5lHsYE1+zO3v1M5RnkrnOr9naepS6DzS5/oV8rVSlEzKwfWevzReunx10McCvZaOJd21nGLpFjHPTZcgfsHOLwinFfLgj27WnfoZsUqb0l/9iUqbmHVX1edAIswRAhGLzHpHgyJ5AfdbZ2ufBs4r1rfa0RuG+x2Kjnpf71b02TJIUMCia+0FJXkHBM6JfStuUFsh1EkUotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxAW8qOdUhyHcQOpcpJcV5qgpoft17lzlYc0U9y2HGs=;
 b=QXRpu9rTWkUTsOVcIOCurzgT6A6/CmPVJmVbtzeR3DNyMHAOL1dya0G+IZJW1ruT8k3qG20YQowHo283mzLSj57lnnRvtKixcY014kJwtqFXqb12iAiaQZydVGvb9A/u2lhML+y/ac7Fh7etjLw4q5I60Me4fs4GTsFoPA9o3sDhCehgEonulZLes+yVPTsKdD4gkeAO368qwaq5U8Z7NyuHkiDOefyGG5k7MpchKf+H59aGhEPZx1suO9cOzrsFXfpi5j0huaFB6Lpsn0KM6nTDQ9zARFokTmZ8qb++NrBEkLW8VIQ+pWu66Wq8jZLB95UXk/3AkkayQEhPQm8etw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxAW8qOdUhyHcQOpcpJcV5qgpoft17lzlYc0U9y2HGs=;
 b=ApItoJ/c66ZMpcqTU90eTEpgcjPdjTymTLw8+HhzGhuu5RwRgKCAfDlkhAvERivwmbMkIQy0+YM1PWwjeTdzxwIKBSBFRLT2yDBPSRW5YjljTXdCHLnCSkG7DP/61vxQMBtlYfYuSNAdQNbaqdsiBNoV+aI4QdVRE3TDeVlUJTehe9HSlEubr5oXmWf0mtI4VZn3IoNchqgoR3WG2BK1w82Fw8F+AvHhOnHnlDCdEwLiz/0MobGSrS0qRhqBXLEGDIXOxO0oR7pjdj/GoMPhSDyYVCcOMatdAnhfIggXpf1hcIritNOfxXPXYVTNi3oAUs4ZML1cxf2YqekBmsIPBA==
Received: from CH0PR03CA0317.namprd03.prod.outlook.com (2603:10b6:610:118::12)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 11:21:49 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::74) by CH0PR03CA0317.outlook.office365.com
 (2603:10b6:610:118::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 11:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 11:21:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 03:21:36 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 03:21:35 -0800
Received: from inno-vm-xubuntu (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 03:21:26 -0800
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
Subject: [PATCH v7 0/6] rust: pci: add config space read/write support
Date: Wed, 19 Nov 2025 13:21:10 +0200
Message-ID: <20251119112117.116979-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1f7146-3ef3-477a-ecf4-08de275dd4d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3shwMEnIXWE1w8hvYyNOzx4Wuiz96fScUuhYFJ521LzJwRbdv0v8mv9DiF+t?=
 =?us-ascii?Q?O6juXwALJCMmZjKIXRVdClr93ZA+QT60/jXodg/GVqeTrTLUgf7vNNkxAf4t?=
 =?us-ascii?Q?QgBamqfGhM37nw9BbXQPxlzJqD6+iYoIEe/zgYOlvwB9IDEUc8q3LX6JJtKg?=
 =?us-ascii?Q?6tCiT1DqO33QXN3cmiUgAdi2KwXB2ZcPJgD0NcDR2Am1oY52tekxD/kjr4M6?=
 =?us-ascii?Q?RG5tMai1WOHgjgGQkiUHnrW6KZN0ejmgEwZMOQWCfhiQ4QlZL4JMMYNfQYnp?=
 =?us-ascii?Q?xIXxoLn99D4dxPGVmxWCGHE2jit9WpmbYS6JjbFaz+v8rlLg6CnsVea3OIbr?=
 =?us-ascii?Q?NaAWBGvsWP+jqiKHiiuDnDFK1Xl0y476V25cJxzgs2rt0+Dw2a/vxrChO8yZ?=
 =?us-ascii?Q?wqOIEW91uid/Bag/nBM8iUaSMUixGCc1+mxKr1GeTao7WtMwcH72Ne5fnaWB?=
 =?us-ascii?Q?CtZDbPvdV+5yMNrvrKws6GfblSI/LkOfmZEBJjJMMKeWmAUnUU2hrVJQpy5s?=
 =?us-ascii?Q?D5xlkGiwLe/HUlq5XYQ2ORrZ1xafr9xSmPqtpwcF5yE9blGq08P9R+B5vL/Z?=
 =?us-ascii?Q?V3MjEejaZqCKhCelqx7Y0wKEBoytJuthDgQB9vLWT0dW4nBWP0pHGFIGB2y0?=
 =?us-ascii?Q?LjlG2zGA6pdFgFtkNbBd1l9cTn5WAUViTQhPnBRv3FeqGwpnNFiyNbH2IIe0?=
 =?us-ascii?Q?im7pbB41Oo7n5m/6vJ665yr90gC+eKJXAhVZzlcgRULlruwls/aKrMrgDsuD?=
 =?us-ascii?Q?+Mwi+cmoo4A3zXk3qITX6yQebWLk7g1QAlQIlC8s89/b4n4ULfsADMGVcH/s?=
 =?us-ascii?Q?cKP8ADJCm0O1ifzc3yTIBB2umFjQY/af2mlXEmXR/CzZXHWFKdrw9FoEud/6?=
 =?us-ascii?Q?zGQFtUi19k+7tPfbZNTNGBW6tk+nDSMS483299Gt5EZJZ1HCP6rhTgwSQprQ?=
 =?us-ascii?Q?AGb0sc5pThCT8nVya/YEyUBCfNKVeV+qMcEyQ9n0z2g9Sy1ldUIg2VcDx9HC?=
 =?us-ascii?Q?y3GqUYNh2FEJuLy+UYiAEax9OtH1jMGqanpJOUPAYl6djgQ0IGkrO0B8lhE3?=
 =?us-ascii?Q?P8FDUd9sto3wfZ8h4tMesFQwlp0CH4eh9++ZydgjqvHPI54lbS8sI7PK15Bb?=
 =?us-ascii?Q?rJ/coDnonT6dq12qGlMVkdJsJdpoGGaUgQWmqILD5/XoR4Kqn2i5kxrT0T4r?=
 =?us-ascii?Q?+vH/plOjnPZuBiu2PDjXCZ61GSqC2JYDeEHMVpiYWlrKbYWutv/XsAzH7/x+?=
 =?us-ascii?Q?PdQFNrmAR7ADYaidYPxVE9OYllowlWWzy+AVig29Yh2NLhZBUj26wHZtSQgf?=
 =?us-ascii?Q?FCoA/fsI9tKlH5xaO07MIbxZr5yFUNn6g7EMOl5noTJwxlsvH5NZ0pJ3Moac?=
 =?us-ascii?Q?pGQTbikjo3S6jI8v5bGWCBQWGA+M5umliCsZRPWxjXb9vTsWg+FidJ5VNWr8?=
 =?us-ascii?Q?hKrKXrDfXuh7SBRS9sh4xuhAJ9s0zMB2rJ7Sq1rGYduB/BZD1Xwy8dUyxvAd?=
 =?us-ascii?Q?+MxoGrFmOQkQXS8PifxqJ62aFLZJFPXBbIpigP8aI/agZJjYPG+BSgde2X7P?=
 =?us-ascii?Q?yhvPzWVFY4YEhbT2mRJe7DowKeHz9oDDIuQKMiP6?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 11:21:48.7889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1f7146-3ef3-477a-ecf4-08de275dd4d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527

In the NVIDIA vGPU RFC [1], the PCI configuration space access is
required in nova-core for preparing gspVFInfo when vGPU support is
enabled. This series is the following up of the discussion with Danilo
for how to introduce support of PCI configuration space access in Rust
PCI abstractions.

The repo with the patches can be found at [2].

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
[2] https://github.com/zhiwang-nvidia/nova-core/tree/rust-for-linux/pci-configuration-space-v7

Zhi Wang (6):
  samples: rust: rust_driver_pci: use "kernel vertical" style for
    imports
  rust: devres: style for imports
  rust: io: factor common I/O helpers into Io trait
  rust: io: factor out MMIO read/write macros
  rust: pci: add config space read/write support
  sample: rust: pci: add tests for config space routines

 drivers/gpu/nova-core/regs/macros.rs |  90 ++++---
 drivers/gpu/nova-core/vbios.rs       |   1 +
 rust/kernel/devres.rs                |  57 +++--
 rust/kernel/io.rs                    | 366 +++++++++++++++++++++------
 rust/kernel/io/mem.rs                |  16 +-
 rust/kernel/io/poll.rs               |   8 +-
 rust/kernel/pci.rs                   |  43 +++-
 rust/kernel/pci/io.rs                | 128 +++++++++-
 samples/rust/rust_driver_pci.rs      |  38 ++-
 9 files changed, 593 insertions(+), 154 deletions(-)

-- 
2.51.0


