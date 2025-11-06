Return-Path: <linux-pci+bounces-40483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50855C3A453
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 11:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FAD44F9D96
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 10:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DC745C0B;
	Thu,  6 Nov 2025 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uUUHCm3B"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C532227146A;
	Thu,  6 Nov 2025 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424914; cv=fail; b=HYihltC6rc4H99iDvzrqQD4vFapYbDzJVijNR/Q2ahA/bZGrHdHNWCESlsAUQcNnWme4SSvA+0C0hDMZqtn5ejzWsjWVNWeI8diTgJ4GmvR2aWa3h7XdQGlcBzHpjadZUJ1HyV7p5zrCfCMqVGFMDjf4uTU4+4uBQjgHR1392K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424914; c=relaxed/simple;
	bh=gdT/XA/4igtT6eDKeRGpgJsuiZm+lqhu+scoejtsLLA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L90vfq8LIj1K09dMgLUxgiVrAI5OI5Yd1wuQ4vIlC06lezjTO+6BcDKN5SZcSyRo/DLQnhPgdbUVbWjSiAW6zmKi0+esJN5zN09LhH7lZnonERNNBpxrEVN6+1fx7Nqjaxmwpuix+e639RJrUcq3pdaIuSd/ha3wTcv8u5ENce8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uUUHCm3B; arc=fail smtp.client-ip=52.101.85.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joV1dtB8C41k5zCr2PwWr5wufMP+Q8TqvYYlTHGIioeHXH8lZxNbdd29UU5qWHrxtrN1TuWtOWHDrmxGUS7XH3Yml6mG7pBbmBj+PDNpTHS/y3rN/0H903BKxbELoTEZqTXZkW5UyZ43hZxDlk+YtuUWVGcMwd/7/btrR/AidKRPngpoY3VMnSBnQXIlre+cK/7NcX2cyHP8opJ79s3Szyo/g5mkz4gpGHq8hdCKmB/7qXXNT9qm5R/bjdyMgeZRoRLDkQ0x0T7tLw3L3CwEDqYLeagagADh9oA3qj3Dn9EW85O1B7uqTYhJxzOr/zMGKowwHCJVALW+YlRoPm2MOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aK/6K7n7hC/vuXK2ZSD9nw9KErQWKBRzz3VLn6B53pc=;
 b=UY2WqVYsPUV2PhLGnyalV0bpV4hniYPRcKSZ+PY78aODtkfTrZbWmHS55VHi9i91wpQRqLg7BsowT5b//Od49Q1s6xG1cx4x5q+gVGzdbrNRjw0JdIHeJK4D1p33MdSMLwkeUXwHcxD7+lS10ZZwmd0ZLmJe2/v8lGBw5DJMA2ilGFECj5TApc+7D4sWQ/i2vlNAU5kntnVFKkcQ9AguaUo3t/iJdF4CCzYPbNzq7nFJ/pdHECzQ2ObQuO5McvETQWSX4IFtnQ2e2MnuM02qCtJk6/QUQoEsP1KvGiX08CvIsve/cNGMUOoV/1RbX3+kNQNd8kPBopXgJjAZo0SYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aK/6K7n7hC/vuXK2ZSD9nw9KErQWKBRzz3VLn6B53pc=;
 b=uUUHCm3BAq1m4wm+I6gs5gCPR2PZYeYlLpcrbCrA/ujBbQljJ69IAUIj9ZUUh40SQAuql5UDFJlljBkzyv2Ucejwr1pXVeXNpOudcXqIqDH198IlHtd0p+kDUEskasmrbnT52Le6pfd8lW1u27L/n3rSu1Tg9y+4gZDMICi1K1j4whYRkHCT/5cmKMzQXuJhqiuTNbKUMbFal35IkyhmyaqvG5JWpcRGRCa8aUb/GEo94yq3nsKzXjlne6DgZnPwACsvDFnhBfPxAmqlUKpkFD11DHQFD+tDn2oRlr14sAWq3qSLUwpD08EPSH2xL7YLg9+CFuI5782gMNhZOfx0wQ==
Received: from SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::35)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.8; Thu, 6 Nov 2025 10:28:29 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::c2) by SJ0P220CA0019.outlook.office365.com
 (2603:10b6:a03:41b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 10:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 10:28:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:28:14 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:28:13 -0800
Received: from inno-vm-xubuntu (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 02:28:03 -0800
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
Subject: [PATCH v5 0/7] rust: pci: add config space read/write support
Date: Thu, 6 Nov 2025 12:27:46 +0200
Message-ID: <20251106102753.2976-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|DM4PR12MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 452a9f92-6fe4-40f7-ab63-08de1d1f3a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KarSjOGj9uXpHFV6n4XQ6jprA91ZHSPy0g9szqqCptu2vuV5DQb73a6HRPoA?=
 =?us-ascii?Q?pGHE975Vi31hsBjfiQP0CPzrPs/+KKP+tONmMqA3uGo2QWSRZyjH00/rSlUY?=
 =?us-ascii?Q?960eU0g8sZK5xxOVPk4yC+BmN0d4SWaVpvSOXtWvn9I4hqFCLfhA2vvyV2ZA?=
 =?us-ascii?Q?Az08onJCgYwJTmmWXm/LQI1Fh3Zi6/8yNmy1toP5z+70h6PV+AfK7qBkD+NH?=
 =?us-ascii?Q?ubkQS/NtM1fRe9JSEPc8pmi/V/OKn6AJSCL2/p7Kv0hnYSUDB7Yc0OEn2KUn?=
 =?us-ascii?Q?12eRGNp5+m/vkYj/Ev2wrT64Xijxd9/3a9oDP0hAgenCGhHoiNOtOQ9ms1Ao?=
 =?us-ascii?Q?Bpk5rB5rc4USaXzmRUF86cAoctmVc0i7zYBx0QmI5q2JCvj1kp115W8I7/6t?=
 =?us-ascii?Q?YvpOftw3AwStHaLWyapTVbruw55tZuTiEaVmTSXHUXDoNEAPcWmChv0RN6Pz?=
 =?us-ascii?Q?dJpGMy7lrdzQe5bOFbExHC+l5nPKMObXXPujJC8OBzGR6Fm7jwxwNL/nA1kV?=
 =?us-ascii?Q?BurQ594TFZ224erbRlkU/lf75YxSWdJ4eW2tbonKHErw6IczN6hOitewiZf1?=
 =?us-ascii?Q?5NtRPGVpsy6mjGCqf+o78PNFvB/mCZPKWx3hxfQzEO9VOuw9ZvsE4ZDPpJIP?=
 =?us-ascii?Q?urYd5+sy/CCwVoppqQZvZxXem27URJ999k/qdgDOJuPbMfzLA+QWkrC2O7rM?=
 =?us-ascii?Q?pyCNJuz8LerSF2GOYoUIgj4Cgo9a+YZxkRBAJjfAEs7KyRVc/cf41qckNthm?=
 =?us-ascii?Q?BNYUpdAvxTe3WRaFTdvj1Q4Wgh2nQgUObAv5QwzQNaIB3Z5JBBmmWThojKaH?=
 =?us-ascii?Q?tEQlCU7kyB7we5vyIxe/hG4KBH08ci9+qye9wYAFPMTWbfO8UzvcxjelsDwp?=
 =?us-ascii?Q?g+C+cZo1+4+YxAhZW4Tre0sqiPBoCGboWMMI/N3i+a45uTeFkXSzRo7eBQIE?=
 =?us-ascii?Q?5WajCsXC98XIqEqH8czyMFAQyv3IYY+jNfgnjQO3YY2NyUy6Ice1vkC5iGsl?=
 =?us-ascii?Q?EK78df03eRhlEq1RFAqD6Z4CzgZmCQQYx6RGxV/gX449kllis7eFVNkCms3K?=
 =?us-ascii?Q?+WJqKZAvzzUYBO1oDTT+2Z5lt2xJRsekojCg5XscU0MyeXaD7mpBh0yLqTAp?=
 =?us-ascii?Q?PYioI/zs04/91G+nBojpZBtmI4L113xRPKr0vMqC0N4Bv+7KOffsiKojJVBz?=
 =?us-ascii?Q?MRXfAi6wYuHx7TXH1ueX2utL3tRKRmaj715/BLAz1+W/K7c7d8TlqkDiOuJe?=
 =?us-ascii?Q?BUYd0n9CaikyPk04TLRUMrmsm6uMnCjQuNY0H+glGqTbTJTHuBo6TnETLQbc?=
 =?us-ascii?Q?00LhWjNlWOmIEDWe7TaW52b2tp2iPtMgUMbI6+NMdR+dz8YwEcMDMy4Szsr7?=
 =?us-ascii?Q?4kA4738WziCniqjeuP7gnBi5UG04iwhdC7QjIcFFJFvwnh2WbfnUxqbxjCGr?=
 =?us-ascii?Q?D3Y6wodwH/X6YAxPHwx35lLZEjCg8Odcw2NjEHrN0mjaoYOHkrxw25XbNb/A?=
 =?us-ascii?Q?FyXqHA6cMZdM7rOBGJLNw6z4X8NXVsQV2xotB1dpVSQXa0toVeVhylKvE6vX?=
 =?us-ascii?Q?COC0SLGdfDzIlyTl5ao=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 10:28:28.7192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 452a9f92-6fe4-40f7-ab63-08de1d1f3a00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472

In the NVIDIA vGPU RFC [1], the PCI configuration space access is
required in nova-core for preparing gspVFInfo when vGPU support is
enabled. This series is the following up of the discussion with Danilo
for how to introduce support of PCI configuration space access in Rust
PCI abstractions.

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
 rust/kernel/devres.rs                |  34 ++-
 rust/kernel/io.rs                    | 323 ++++++++++++++++++++-------
 rust/kernel/io/mem.rs                |  16 +-
 rust/kernel/io/poll.rs               |   8 +-
 rust/kernel/pci.rs                   |  55 ++++-
 rust/kernel/pci/io.rs                |  72 +++++-
 samples/rust/rust_driver_pci.rs      |  38 +++-
 9 files changed, 496 insertions(+), 141 deletions(-)

-- 
2.51.0


