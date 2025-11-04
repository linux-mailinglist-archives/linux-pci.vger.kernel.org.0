Return-Path: <linux-pci+bounces-40207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534B4C315EF
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 15:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577F11891BED
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B8A1FCFFC;
	Tue,  4 Nov 2025 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gk1vEjCB"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013000.outbound.protection.outlook.com [40.93.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2721E22D9ED;
	Tue,  4 Nov 2025 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264961; cv=fail; b=lnxhjfONVBp4eUs0qY4UA+Qtyx9Uc7CT9/Gka/SZ+g2GpnpAyy3LLayQWlyBx7KineG+IbTYoazaKGZhGRamiDcjWKgRw3sz7M8cQUc8Bb3X97vXA7vtKE0SgBdZAOer+UnfMtFP71vSvkAwwRyfCQfI3YmpSc0qffPQJ55p+ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264961; c=relaxed/simple;
	bh=gEz2+rHSWSYbp7hmrxw8AXW25yf+07ExMCNWpF9SIE0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DiRfcN8FGdexCg5/J2OH9LUcrj1TpR7UluxY11VIUtQKvUQ33ZB7azI6JXTNLdLWM8Wcp5Doz1jsIyDxifV9NvB0kYPBE+TeY4mT9NDC0rO208MczgqMRcJQJbSZQDXnrpKkm66Xl5flXMlTApP4WuVdPUR8OJS6W0U0poYqASA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gk1vEjCB; arc=fail smtp.client-ip=40.93.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwivA4mHz/nIZCqrZRZyE1m4zyhw5XCRQuexFWf/q0Y1G6SNipLO6erYYKQHYYwKcAjXoOySHo/Gim718LJy91EopjubIVVi5oX+Qf5+DzZozTqNaB/+/E0NBVxL0P9v+qjXOhKAXmrdeLjDn6BZkXbFflAl2CFARRFhYpxdK0YNEED4zdQ/0QgJ8fLVyRn4gekJkmm+hV59tjHaUeKnFJ3gbxeS3rHRE+TTAKjjQ4B29En8MO0+itzf0rtQl9uvsFdWM3j0Lrk1S7PND/y9WRyIiBF5jFW23uvTbfxam7BU3/I76TlHLW+7+GjmJWnU1dAMeponeoIvePJdmHxMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmITIElCi+D8OyTjp3/BtR3HKO+jnGZpm0HRO0uDVys=;
 b=NuJEPWhkqHbstrmIE9r5gNO93nf2u2z3dP4x4H4xVynLFIx7n13GkDaaECXHqgsKMKN2B1TWGJ6fDta+DKS3FKbfeLKKKxyntxPtKMo2bhsAAnsQ996WQ5/kUBa/ubXs/b2mm0OOi5GFfQ8onaJs80/R9/tLsnVfDz6VUbMGuvlow/0mofLP00a6RWdAkPz4eRr8RWsJaNG9PbqViBUgRyWibYBw2AibbkACu4b7waG0alTVqDEROZbInGQeGsSLrEvHbl5GNU21JLF41agIEYzsjP0d/c2KYilbqhv/bf09LvsuE9Pjm3mFbslIA9hmflAuua1hAe2kRU4nXlFMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmITIElCi+D8OyTjp3/BtR3HKO+jnGZpm0HRO0uDVys=;
 b=Gk1vEjCBwOsg7B79Jo6PDduri13dD0/WvliMGYSTAz5W6IiBZeWIIP2ojVq6CT35mDEiS7kw3QO2HhVeRTj7tSZbz2UPqs9BdK1CfWkgUR2T4LONCk+nEh4YZLoAoe/oUugELl9VJZEyz2IcyMJYKPm6RKj+ABtAQWonrXmcC8Iqfdeo7EOA3mONNBirvHH3fSDuek08qg8MwBxaRlIo5u28zuMZYs3SdjOMybrqdm9J8vJ33GglF6BOQ7z1P34v5/IVejckR13iKcrJtcU/vBhkUcncYZsDu8gZYyuhBqbPrwDVU2omn+mCc4m/f5XAhHAcGCQ/UBYQIBNQ2iNtgQ==
Received: from BY3PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:39a::14)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 14:02:36 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::5b) by BY3PR03CA0009.outlook.office365.com
 (2603:10b6:a03:39a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 14:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:02:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:02:14 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:02:14 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 4 Nov
 2025 06:02:04 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH v4 0/4] rust: pci: add config space read/write support
Date: Tue, 4 Nov 2025 16:01:52 +0200
Message-ID: <20251104140156.4745-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1db34a-50ab-46b0-5d8c-08de1baacec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Wg1M3/17pJ3VE4fH4vHvDlzJ4oAL+YotheTc7ai/nwcQGY6IYBnaueeiLgD?=
 =?us-ascii?Q?WPEEsqphJGY6ZWMGj/GOcFGMVT65QILSZ/rppMD8ya68OhavyPn0XhBEf8Fs?=
 =?us-ascii?Q?3+5Pwmx6Uh0pk6KNf5H2n6vCqHiM0ySmqmPEs72CFOp1VEwPaVsNeAxTrpJT?=
 =?us-ascii?Q?Xbqm3qYLMVNgo+3hoUVWzpIjs+wuootWTs+k02056MUV140xrhu7I1wYM8t0?=
 =?us-ascii?Q?fHZaA/qYjRDD7J/S9HErQe//gPYVBQnOyjjFC4oUILUy08kk7nctabRebVU2?=
 =?us-ascii?Q?Ibp+4gbIJpYEMQVjm3yPyRNaDJVhtCkUV6nMMaDMZfMbYhqVvPizTp8+3zn7?=
 =?us-ascii?Q?V4d6cqBVCrLMVZjtjb7knvTxNsbReU6Q5G1FhCCs10bY1eb/OUtIN6sNl5p0?=
 =?us-ascii?Q?O77quPOV7vliV5aINEoE9auZOxsj6xNMAGN3OnYahK0zbFPsgsfhkVPV0hXB?=
 =?us-ascii?Q?3mp2wijZvRzuahshwL39cDSJ2jMZYBmExSsJZAM+btcldsMHpYWNbjcroOUw?=
 =?us-ascii?Q?H0eOvrGCW4PIQh6/q8bKgRzK+lqiFcOj0O8o/6jDr/OtKJ7/SXqv6JL2ocTX?=
 =?us-ascii?Q?DxOaKQVxjGBRv851VQ7sZXa1BJ909rRUNNY7QRJ6IbRkvIcjh525IrpjS8Yw?=
 =?us-ascii?Q?YYrWGhSR6+2hNSsHOEcEHX4WeJLee4wHdzv8DKdjyR1HAke9f0fstJa4Ckte?=
 =?us-ascii?Q?PH5w+kHmVIDIbj7VhI+JHd+ajYmLi2KlyNRK7EBVazIIancMmWNdLQHKMgd9?=
 =?us-ascii?Q?9Bi2hjfUQ7FT0NrzpBFMhnBWFi8nY9NWyXaoB+b/eP84yZfq8aAnR0FmH6K0?=
 =?us-ascii?Q?W9cNTw9Q5+ZP6ZkNalUQT4/7cyrN2OP3QAnMyAbMkFrNaGdlgVxx/TXyDeqy?=
 =?us-ascii?Q?OQFMiZiKn+2irDdm00lHQlDa3zfRnpnGnFRWO/e4ajIS1fxWGc4qOpW2G9dY?=
 =?us-ascii?Q?TjPIKwGQTTQntqfYsBm6s+8TzoiA0nHpuzAhAbxEruR41JgQjiev40tyCLww?=
 =?us-ascii?Q?SusE2qs5dWZQoeJFAk9DPfvYFhb3Yu8WKJ737J3+PW3xR7ep6wuXuvKIqwxY?=
 =?us-ascii?Q?6RUzTefCfV7ba6bUc9OLi5pz9Zoz+yRgXc5skVAk093mJtJt8RjHy+HIDpup?=
 =?us-ascii?Q?IOaD/E1b82RsyjOA6uvFlugf8m1uT22YOYHISjwngnU9h0BgNMek1xxfyEd2?=
 =?us-ascii?Q?KoVIBOfEcXvvNqtf6wOaxOvWwiJabsHxV6lNbX5lPA5NXgROl2jpl0aOxM/q?=
 =?us-ascii?Q?XNleXR4n/wEy6rsMVMCORQ5k+M10pS8n4+JUoaww1iJpYQSs2YX12irk0zrS?=
 =?us-ascii?Q?1942YR5Ks802yW8vQNmLl0ARzh3h8/fB3752tej00LH84fw/NNMlcNxAOVj9?=
 =?us-ascii?Q?QaQvde5/c9zTvL7HOp6iY6jwi+bvet04OWXoDpXg/kPq59bu3B/o7FFjqFZZ?=
 =?us-ascii?Q?DBoU2pQ/q1YDYyimzxEjrEB3v1GZjByIwUbVORYQaK9aejbC6mxPUnIZXjsd?=
 =?us-ascii?Q?MsfaLeTXI181/N/fUBm1P5hXKL6XYtTU+tqGDEKVRG0ZUY+CM7RpLcYfnALb?=
 =?us-ascii?Q?QSdKofv2VWRlyg7zdCg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:02:35.9016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1db34a-50ab-46b0-5d8c-08de1baacec7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109

In the NVIDIA vGPU RFC [1], the PCI configuration space access is
required in nova-core for preparing gspVFInfo when vGPU support is
enabled. This series is the following up of the discussion with Danilo
for how to introduce support of PCI configuration space access in Rust
PCI abstractions.

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

- Factor out a common trait IoRegion for other accessors to share the
  same compiling/runtime check like before.

- Factor the MMIO read/write macros from the define_read! and
  define_write! macros. Thus, define_{read, write}! can be used in other
  backend.

  In detail:

  * Introduce `call_mmio_read!` and `call_mmio_write!` helper macros
    to encapsulate the unsafe FFI calls.
  * Update `define_read!` and `define_write!` macros to delegate to
    the call macros.
  * Export `define_read` and `define_write` so they can be reused
    for other I/O backends (e.g. PCI config space).

- Add a helper to query configuration space size. This is mostly for
  runtime check.

- Implement the PCI configuration space access backend in PCI
  Abstractions.

- Add tests for config space routines in rust PCI sample driver.

[1] https://lore.kernel.org/all/20250903221111.3866249-1-zhiw@nvidia.com/

Zhi Wang (4):
  rust: io: factor common I/O helpers into Io trait
  rust: io: factor out MMIO read/write macros
  rust: pci: add config space read/write support
  sample: rust: pci: add tests for config space routines

 drivers/gpu/nova-core/regs/macros.rs |  90 ++++----
 drivers/gpu/nova-core/vbios.rs       |   1 +
 rust/kernel/devres.rs                |  12 +-
 rust/kernel/io.rs                    | 298 ++++++++++++++++++++-------
 rust/kernel/io/mem.rs                |  16 +-
 rust/kernel/io/poll.rs               |   4 +-
 rust/kernel/pci.rs                   | 156 +++++++++++++-
 samples/rust/rust_driver_pci.rs      |  48 ++++-
 8 files changed, 483 insertions(+), 142 deletions(-)

-- 
2.51.0


