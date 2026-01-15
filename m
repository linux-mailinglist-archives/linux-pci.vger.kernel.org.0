Return-Path: <linux-pci+bounces-44990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBC1D28B76
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 22:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8404B3012BEF
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 21:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1823D326D75;
	Thu, 15 Jan 2026 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SWjjdX90"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013036.outbound.protection.outlook.com [40.93.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0543203B6;
	Thu, 15 Jan 2026 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768512449; cv=fail; b=HAm8ADXvPG1+P6PiZqA3GChhiih3TdF1pGMPyofOFnSpK01M3sgvSAf+IxryMt9OrCy0wvQET3MsuGVC9AYH4HYG8ZpaY5rX+DPV5xjbvKJnur5w1DUqZQH2SeXF0gvMjYA/VDzzd0wRYSmrX6P2rRlEv8JJDBfzy/6tMPGLSSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768512449; c=relaxed/simple;
	bh=LXyNAP3s6UqW75f7QNAVkHQbPyrRiiANm9qgxNjkcBg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QUTD2sEadgtqWCiRZ5Pd+wAV7ELhX4FxMqgaE6m3U+20Ten8n4jnwuXxs3lWha+aGkbf+4AQEiL4t9EdGjYwAAJMGfpvQZXIqJC+Udx0hKLh8iXnb9dpAITCH4f0+HJHxd9akSemcdtiM2zYtKjsz7NXxdJAlgfSxkq7telDvkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SWjjdX90; arc=fail smtp.client-ip=40.93.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOYBOUK12tNhZFMmTzgFjS1m4oKH23QF6gwkC3jKQ8686HWJzxyvmqIfSq+kUv2u+PKAVTYaJ2C48JcToRhxUd9DB9WuvtoPDdLfL525DmS/EMmcloLIBdQlPiEYsUeRjggsBf+bMWqJBO7w0eIgv05AAlqOWEhKpP4vtF3qfvfGMsvqUEgwQz7iTa1mD3GrBQnmgM0WGcbAzBr62ZUS+zki+1XYIQ+M4eamCE8ogPUencC7tO1KYitfw5Nv8Zs7Fgste1UwJZ8SYJ4N298lgxgmNDY+0sImntOgZT4GPZrrLO50KHSfsBum7QeEhknOxmAuah7sWp4nooJSzeAe8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aGgeK4IFJotPlTDf5Cj0y+TGSMnILBTY7moapHQ7uw=;
 b=inpYE7YrNfxTG3wEkw3K12QDjGA5zcX+l8fMJ4uZy7X/7iZdDLbQ9IODVkkMwV2395Uz37fsD5zm7ZygcZW8Flaw92Xv/wkZ/b6Hr5PWWrNYZTA1DO/KvDpmtcU13ZY8qdiEcEsQLXJVDWWCcwx9pOyP+KS8/3rZtLHoQR2/3bo3FYrQ9p94qh3TJeQvZLdqYEhiujBP3P7ucFyTJ8JUo7HuzRfDZcjzQHrKWTLbOsd09m84lwIHk/JoqjGdX4HSlL3tFj90XgtYSYvrGXlkAbGMAAvN19EGfpF2ktueGu/MhDrS8OURn7UWKe+sxN+hbkJ3B48E3k2VUhc1t5/Z/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aGgeK4IFJotPlTDf5Cj0y+TGSMnILBTY7moapHQ7uw=;
 b=SWjjdX90X8+V5esTyX3l7jSQPeUXpJGSqVIleAlY1CducmvoEr2Ude/1Ik0JUIB7RVKwpSyiofN/wEcXx+H0icUMGeB0qhqcPfAchWnetB1FY6KcfjB9TB71yH5cTzMzzVrbMeohDIZIfkSR9yWxE8lkvwBgJ3T1VKFZ1IGAq1eNBPcGaCzy1Oexdv1zZOd6Jkym/f5OyKpsD7xicbIQqfXKa2xfQptAKpjxHoiJQm9tyqmSjyLJWBJUN/VyuqZq6pNAVAmDxwVJBb529vnQgJxAa2L4SJYhTWjPFgLn3ZcuE0gTFIFnyps4/a+Uh/TWLWZk0QvoOyF5DxChdvpEEg==
Received: from BN9PR03CA0382.namprd03.prod.outlook.com (2603:10b6:408:f7::27)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 21:27:23 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:f7:cafe::9b) by BN9PR03CA0382.outlook.office365.com
 (2603:10b6:408:f7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 21:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 15 Jan 2026 21:27:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 13:27:10 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 15 Jan 2026 13:27:09 -0800
Received: from inno-vm-xubuntu (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 15 Jan 2026 13:27:03 -0800
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
Subject: [PATCH v9 0/5] rust: pci: add config space read/write support
Date: Thu, 15 Jan 2026 23:26:44 +0200
Message-ID: <20260115212657.399231-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5b97f4-1555-4707-8cb7-08de547cdf48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bqkLd2I8pS+QspjAKaoNRuuNoTAjPAsdj7LU8CPp3uRRfKpc1mDra+23DQ5t?=
 =?us-ascii?Q?Bwujbn6Y1MnilMHrhrP3PrM4f+XNDkRF9RBQa6zH1jzJ34imZVuSan8qPQz/?=
 =?us-ascii?Q?/LaQK+4lp7RH0j2fihwta8ug6srkt8vxyEQPaOUt4aBVouGMsViIOzLwOJWG?=
 =?us-ascii?Q?hOKHrJ6U5DAzqIJddKXpzWhfZIV/ahsY9TVVIPAFMkgiAVBzNR/Kuw8H3VHq?=
 =?us-ascii?Q?DuiyS2rmeZ9EadCn4FwdkvgFov3NQzTbIQDsODX3SO1J1NKl4pLUOjVhK93N?=
 =?us-ascii?Q?kPy4qIhAy3KROtK30LYeyUzdxN5L5ytCeCgRlXvtIpha7TAM+Sx3FkFjOotE?=
 =?us-ascii?Q?/BtwK7/Lp25qMnl/B5iqVgiUZmJ+uqeTRJ/idyWAPzMupPIaQ9JVe5HQj/Hp?=
 =?us-ascii?Q?GTlO5fk+BFwyIaSd7PAc0p5NDda4qw4gYfKmIFqE5lrQ1y8kVwPuiKzyQ84n?=
 =?us-ascii?Q?J9VunSVh62UDMJ9kbigSg/p2+tpUiLuvSc42/5dJOqOSWXAvyEJ53VrX6J+M?=
 =?us-ascii?Q?w2BvV34NXvn2GS05Y7zAS0NZFuxSrCWgfxkaJ4c6VuY1Wu6C0ZJCIxIwzgUf?=
 =?us-ascii?Q?nNaEiFVSa5ilM31W1Fn05bStQFyjw+tRlWbO2iPxOiiBF0kTaNvxLxapCeeb?=
 =?us-ascii?Q?gyNkbNKQXyJFiHvej/X7J0qmh5ulcT0i7jSRXCGuvpY1IrbTXp1CYXmzGDv+?=
 =?us-ascii?Q?eDkjbpNftvW1/TGGglMS5zLXA1S5/2EZETqWLxmzcJFeD7cr1B0CNCKVRJMB?=
 =?us-ascii?Q?OUAw4s7Zrzy6oV9xqnj2EfL8dOQwmxmZ+mTvfzjxQDpM9iE8SQLKt1NRRxeK?=
 =?us-ascii?Q?3UNps0Ii+rA7JuD3VwK1eAfGVgGnxKanpjmZaVyp+ph0oRZ8qil3HWFAiKij?=
 =?us-ascii?Q?kZN9h5QcBvK+U+3wQ3h6ii/lDcFKJhdAv7vu9lNGIuj1Lmg6sTtLyEH7IOTh?=
 =?us-ascii?Q?YYMniJ2jgw4MzDxPVus9YVKk2kFtq8Hfm7CTQB0toRvoHYNZleFMNsTqCB/K?=
 =?us-ascii?Q?+d38s7F4ZDuY3dDYqZS/Z5dIs4lvQZFbFL4TmkQCeRi942P5g3akp3Py5jVV?=
 =?us-ascii?Q?LrW9OPenU2kE8ZgwXkERIhlf72YVajbqlPXr58mCNo2SLlZXYB3lGEg7/fgk?=
 =?us-ascii?Q?w47sIa/YlHuWQoq9dPAeLepiUilplOLPETKPVZCLIx9m6p1Zur7jppsz5o+X?=
 =?us-ascii?Q?7y9UWPaoMvmq42URH1POLvzqA34cucUF4BXvvkiQxV8kMbZZ6wbeQ0jk45yg?=
 =?us-ascii?Q?8b5/QXjaHFpJpxqY2A/P5DCHXaAlJO9gypRRriaTBMHwqkLAcJk9o49JpXIT?=
 =?us-ascii?Q?umzwBsGE04E/rH0yDokMlj/5cSg5sbnfU+3wGz68hWr98vz9P3x2RjtatHF8?=
 =?us-ascii?Q?LmaNY0kOSZAjQMk84Rp5S7agMyABOPvgmUL9jluO/zr3itUpz8/fawK9oJUv?=
 =?us-ascii?Q?raqlEF85k9TuNPRjJBSUSMVBS0L8gRMjNTvEn+SJZF9/N1AvLMajylsAZkCl?=
 =?us-ascii?Q?fxf7JU1/JlFAdcZpz8zMYqipTrbBvPeJ+JYgcv/LbpukJe3hnIKB2KbIChmU?=
 =?us-ascii?Q?sMYEgiM0hRU1TiCCPQ95+2fbmAeG9SCPBtlbK6PVF+qreYRjMMmHMm+pFGRq?=
 =?us-ascii?Q?j+I8agTEb6HYfatEGBggiRvciBsm/xPH7jxFlTxkiBFbNP9nOkD7EhXHBVe2?=
 =?us-ascii?Q?eyZlOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 21:27:23.0159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5b97f4-1555-4707-8cb7-08de547cdf48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298

In the NVIDIA vGPU RFC [1], the PCI configuration space access is
required in nova-core for preparing gspVFInfo when vGPU support is
enabled. This series is the following up of the discussion with Danilo
for how to introduce support of PCI configuration space access in Rust
PCI abstractions. Alice/Alex/I had a discussion of the next steps of
this patch series in LPC 2025. We agreed that first introducing the
functionality before the BoundedInteger work and other refinement is
settled. [2]

The repo with the patches can be found at [3].

v9:

- Rebase the patches to the latest driver-core-testing.
- Move ConfigSpaceSize to pci/io.rs. (Danilo)
- Refine docs. (Danilo)
- Compiling test on Tyr. (Danilo)

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
[3] https://github.com/zhiwang-nvidia/nova-core/tree/rust-for-linux/pci-configuration-space-v9

Zhi Wang (5):
  rust: devres: style for imports
  rust: io: factor common I/O helpers into Io trait
  rust: io: factor out MMIO read/write macros
  rust: pci: add config space read/write support
  sample: rust: pci: add tests for config space routines

 drivers/gpu/drm/tyr/regs.rs            |   1 +
 drivers/gpu/nova-core/gsp/sequencer.rs |   5 +-
 drivers/gpu/nova-core/regs/macros.rs   |  90 +++---
 drivers/gpu/nova-core/vbios.rs         |   1 +
 rust/kernel/devres.rs                  |  30 +-
 rust/kernel/io.rs                      | 374 +++++++++++++++++++------
 rust/kernel/io/mem.rs                  |  16 +-
 rust/kernel/io/poll.rs                 |  16 +-
 rust/kernel/pci/io.rs                  | 163 ++++++++++-
 samples/rust/rust_driver_pci.rs        |  30 ++
 10 files changed, 580 insertions(+), 146 deletions(-)

-- 
2.51.0


