Return-Path: <linux-pci+bounces-40768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC76C493C8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 21:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1147A4E50AB
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2DD2EDD50;
	Mon, 10 Nov 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UhWQK11V"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414482ED86E;
	Mon, 10 Nov 2025 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806610; cv=fail; b=RdAGtP2xRllUdvjVF7lKPPQ20Ui8NiMkTU5IBX6d62HBmKrTxQiWmh0l6PiAwhy+26jN2CC3h/JFKdup4X1SfL3Qgdn90C/WWHszfnvxcRst2hUH+HTTm6daeLSp37/z9tm6Pq0vDVi4G+DU4rGhjgB7GbJgFDg25GAdT41iYW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806610; c=relaxed/simple;
	bh=qXqdL5tjQYTpjl1GEHBoAy5EGttGebzTRJnY5/tVi4k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aumaWEgQumTcs906SAfYFKR7DI2Vz8dV/TNwZIoy7X74oBiwl9o1L89ZxB5oKgwAY3cb18HVRi4DXtJHZLT7zoB1KRcChDRYyhT8w/VVsES5CE0K45Fb+ynr3v5Lz1P91O01SZSaxccFQYlZMuIvWR94uFR2COZOGmDk+wagFag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UhWQK11V; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj2u9Riyy/x/X6jWXu/hTks+pRfzfNlFfh/kGCZ4fmZVHhSVIT0FvsjH7KofKVp0zHNL/2w+ihDO/zQd5aXtwgWLHLiFv9BPKy0ecudFNaGIJB1Mxp1CXGUe0Tb0fuWsfv2HHFtxF60MTWAJrJJ3BrvNUGbDSsrVz/o6NlIv5MzxpPAaShlMdWKA2WQmQnxd980EL/pDDS/9nNgSOcC1VTom1Z5zsPSA21Wcds9hFdDcSMJ2SSzKTwGXT+HZiuX3Ojay4edvqDgEu0QdAd42jBW1BMFOq5qzpWZIN3GozKr70Did9ScQoU087IGQZy6iwYftDwQ9kqhoZCa5fKa2Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZlVyj0mHAEWtJI0/UraZYf0EjYuxE5E4EMasUsopnA=;
 b=n+Gw5SUEMUlLRptAq30Fj1HfmrBifJ0d/xuakJ+83zfY9kAbfLlARj/3irhz+HBquNVMqIuAIFRZ4YuUg5DUzzSQv0SjTBgqcembsaw3Rgg11OTS/tYse2l/w0JgO4JxPkT0cjX+nWPKjiK5mcitVcbKJAZXvsnY28xCorisI97hW2rAHL3hGsKZSe7URhwx08TvCkhKqLA1DH1CwYnPWzTi3iUQIsPNTOIGQJfu5O6qWJq6HnSGD04D+mjcjsEAgMNpTUuJDvAzc2v+pBJMlrZAEMFHyWTvZQqFxGw/0w8CXGuk7MusBy7OJv/7LIQz/i5LCfM0wDhlQwISIWiEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZlVyj0mHAEWtJI0/UraZYf0EjYuxE5E4EMasUsopnA=;
 b=UhWQK11Vb8IEYevx9eerxsF3rZlVs4EcIfVlkydg096CsC799nW302kA8mLUm+xOSQoQoquPE2JDH3w2EtFskeHDNBsB/Qdd9lSL5aBcwqVwlGZNfSAk2Hsz5QtGBKRGC1JyM/PcD+zcWVk+p3AYTnRj+zJovhkiPnjo9CDGtZgmh+tNMEgHuAg6d2p6RHp2kCgZA1d5x/cgEbwZ2qeVAHSmW7X2xvyg3sOmdGjtmwer8tJEMdaM3P4KLzbid+XWQVuedE3VTR/+uvuKNT6BAmX0fBn6qQYhfvzYh2FArLYoNHfrg1Rylxf+KO+hjVC+bUoXlgh6CUfMOVEfalKeFw==
Received: from CH0P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::28)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:30:04 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::ac) by CH0P223CA0018.outlook.office365.com
 (2603:10b6:610:116::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 20:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 20:30:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:29:50 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 12:29:49 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10
 Nov 2025 12:29:41 -0800
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
Subject: [PATCH v6 0/7] rust: pci: add config space read/write support
Date: Mon, 10 Nov 2025 22:29:32 +0200
Message-ID: <20251110202939.17445-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f65a28-990f-4101-a229-08de2097ee61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lHjvTnccXUUUIRyRqu5xxZAhUFOlMvcBuw4Oto1ztZpFwK0Hkg19M2qED8hE?=
 =?us-ascii?Q?n1WGgs2oHDROl4yOLtrEORMioiE5vufE9sNlp8wR7jKMzFdMZmCzPxay8Ltn?=
 =?us-ascii?Q?mkOgV7uwfUvr/aQ4eRzsGenvRAYQXaEwB3kiLWXg7wIcWriSJir2RVT3xIPa?=
 =?us-ascii?Q?wBJcqOWVE0q8Eh1RFURVOQdkVWbK6blgJsy3QNdpIraak7+Q72DR3Ip7cXZk?=
 =?us-ascii?Q?9itM/Z83Q+E7qO7tIniEwzrhKGjDvkxA5NHbl8TkKJ454RuKnpTrS/0b+m7N?=
 =?us-ascii?Q?Wl98AOXufbpNqaDlBCN4elGS4oULK00TJE1fnBtWU7pzbg+aRf/WdXDMDRO+?=
 =?us-ascii?Q?6LUhEqcEV1z5XdbHTmb4ASboR95X8a/1SqiBGHqCBuOz3p4ZjnABNhhCbZdg?=
 =?us-ascii?Q?nPwYceb/e66kVrll6Puw6LtdDQiUfjB0HRL4uUsW0afciHll6WSDkX3yWi7S?=
 =?us-ascii?Q?Cu6zNgzvHKXZ7vOc9sH9QmUUuCbOlXKpTxrtU5k6FUzwsqiYPi97C3CdzSB5?=
 =?us-ascii?Q?Psp1TWouIuH5syybJo8eecrwWFaO1Q4apCPgT6Qcn2sJ+ZwWofoGIPuh13ra?=
 =?us-ascii?Q?K+kA3UfqDfDwvL2iTncE7zdH1ZfNk52040WlLJ1wrXahOUodQug5gp6V2ul9?=
 =?us-ascii?Q?PucHNhOM32+Ap+hrlgZPGYjpx1OeiHybxMLTRexD4cqPZdEGiT0ew7nlGrRh?=
 =?us-ascii?Q?RYnaZi0cCMpfG8dYy68oqXBjkSIUFQrRtmtx2ta5XL1fu1j37WjYybZuh/GM?=
 =?us-ascii?Q?KHFf5uF2WUA15zvm3nqUf5Xdw8g9kbP1/9pyCNGmNN3PmxsVt4DCIO011JxG?=
 =?us-ascii?Q?tAUFvuZDXOLYb/J3gUaQY9ZTwj8WTqkc56urAIkiB6RiusKYsdlz1uqJ2bet?=
 =?us-ascii?Q?lb81xb0O4Lx1yGJn1x3a3sb/qDgxwyhof9jqWgtB0JiwPrcfWVKdCaLYWOpF?=
 =?us-ascii?Q?VsXUHzoaapw9k6XKcSePJwdL0jJAbmRFUqVHEAWCK9brK/WpFTatl0ysaci4?=
 =?us-ascii?Q?qqKB6MF8Y02/f7jUMpx9G8T3mUDuzZDsPv6jrzXjdGVTxNJE9WpdUrWTF1dH?=
 =?us-ascii?Q?qWuHwKRlpTvR/fyAoaN2DtMKY6BdrbnjsOCgYn5kDpWNhuJ826AgZCa7myMd?=
 =?us-ascii?Q?rnh/N1JmzZVYCNdd0LBsJkiVCj1/p+Sw+xO7vv1r0rwp4b0J2dhgSZ+y4Qvb?=
 =?us-ascii?Q?Mxzctch+09hVD0+Uq/wMOOAemHtF0wYCiHWxKH2KCTn+ni6X9QBVUZEB6cit?=
 =?us-ascii?Q?vpfbbMsZEfFGwHfx7P4miayjFc/qN7QuKLrgYowYdADN9lRjcHOaDKJrnG+j?=
 =?us-ascii?Q?ESCfkbduhdtx66KyvtVGPG9Mc7vYSBP4IkF79QTz9f6HeJS5+Er/8Vo2Sr4j?=
 =?us-ascii?Q?oaiw0sQ5RnmVo+Rvg7Sb2kfiU94mMWVpnNMlmTmTb6uyRHkADJXHSWHj8RNX?=
 =?us-ascii?Q?JZ5Yr32SYzt2OtVszeftjKi1kyc73fwx6NFnqnbHApb7RX7vrmwo0RLve1Nq?=
 =?us-ascii?Q?9NIAbLpRXw3CMrSEUayUT0iINju62gVByMwDeu0qzsyuc4kw2qgq5vbkWn1D?=
 =?us-ascii?Q?33txCQzVdRpanap+JKmcvBp5pzXThayejWBUAQZz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:30:04.3026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f65a28-990f-4101-a229-08de2097ee61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400

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


