Return-Path: <linux-pci+bounces-45210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D58D3B824
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 21:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7282C300A502
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 20:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0362DEA70;
	Mon, 19 Jan 2026 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fDGwvD+o"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013031.outbound.protection.outlook.com [40.107.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80D2798F8;
	Mon, 19 Jan 2026 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854193; cv=fail; b=XR4rr8aQBF48mYMVUsmnedQbojOs3f4EgdJd4ZMR3Wgf76bvUAV2w/1PaKxxTPhuEtV7i0+d93FEICcLXVcRdhDwWctJYWltFvl/YkxIRIulXqI8eR5WFlsRmipfKE0TctFA3miQI6YqEIZXrBKEyYdgsFIbTne1c1nI2Cx7MAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854193; c=relaxed/simple;
	bh=WpV4tJ9cxy/nBqw0IXuaqYlsw3j9d/lNbMntL6gq62E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mRkmYUIOHeFtKS4foYAtcLUhjK60yK4dDhM8zKTEICi3IgI8wDjsPA71+zIJgiObJYUxtHjl5HJGkRuU9pEPiRnjgDAgp6ltM6kofus1peflI4u98kUlksbwONkzwyvTZ+A9n2ezf8Olqcw/1CeJpEbpLIaekGDW2HDzP4LSKG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fDGwvD+o; arc=fail smtp.client-ip=40.107.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2631hLdX0iwmdP4mOn9Zruhtu89eiGIpmFAaheMtQoAtax39hKVAeDWzVL95J5T6TXfj9nrimpNuem4L+o9JVmrB/hLNsGDu5t7RJHFUrPIHCgy6ih5Tx2oqwln2hFl/PyugDOmZFcPp4emT8oxfiavlxb/QwhdQB4xgC+rU/pGa/5V2xjhEBmKtpM4ZpW/PYgWjaNGHGX1FI3REKArzT1lQdCwuSJzsayUFd5MkcXUycs5LaC6Qcb6R/5zgICmJxrRE6pa3V0PKidQGmALlWBJzXtranoWyBbZbDt8kL504Ko3PooOiitgMZy3gwmSuDAFYHbMrGYqk+6yXLNjLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFr8vvaiub//DfmcF6ckVS9tNsakcWq96NsIonvsICk=;
 b=jklbEgLmmI3qIWmatCisw2q5zJ5bMFlz5XXYspy7VvZih/Ck8pu1OIkk+NzbrkaiAALG9G2XbIdd2vuyS0P7SE75ADh/UOjf3v4wOuWkoBcHirPBNS4Ox8X7c0hnSSo0eNJJ8fJYwb0z918vRgM6yvxqt9aGw55bSbaZK9k+1vJjfFixYbToUZlm/Xk2TCBCjaxSPeqCp2T7tt0g6KCU8IBqUnGoiYONpQHm5qZkdbRy8Nc7sXGhIQykcgawXEBPq86ICTNZZJGaU+j2ehucqHCSVB9q5ePdmusKqiOXK9YvFAvN/9wiUPbsCBvVe5bOqBeYjhzJQ0QjR4rs2nAAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFr8vvaiub//DfmcF6ckVS9tNsakcWq96NsIonvsICk=;
 b=fDGwvD+ogMo5VCvpt9EnwF6FRcPnSME9BoRsOc3OqOyeMUYiicZR4YgDdjdXDfB6liWOIfSHrEw9K4wKKw+dxbeT8BeBL5+9JFbA/096s+v/4Otas0cwGF7Z4A96hFV2+42K17Hm22QvHhKGssP6GKMwgWlGYZyqyMZoscYcGSPllN0WVUz5BHLqxlRNexOsetZ9nAa/R9LsfWA3z1x4T6p2JVBGQixN7+Hc0mU3SrKxuiqz34k9QrMnKkefsAHvNkhuWD6BAghUwDD1BN5DPaE8Pm4U+qJDl9ECYRfof9JHRAOHWAhHDy9Sww2Gb3n3H3BcBmCoy1z3theQxOzPNg==
Received: from BN9PR03CA0955.namprd03.prod.outlook.com (2603:10b6:408:108::30)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 20:23:06 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::38) by BN9PR03CA0955.outlook.office365.com
 (2603:10b6:408:108::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 20:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 20:23:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 12:22:58 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 12:22:58 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 19
 Jan 2026 12:22:52 -0800
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
Subject: [PATCH v10 0/5] rust: pci: add config space read/write support
Date: Mon, 19 Jan 2026 22:22:42 +0200
Message-ID: <20260119202250.870588-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6a5468-dd61-45ee-51f0-08de57988e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4yRFVwsjH6kWh0MakthBTvoJNhZnuU257MjROFGPPoUg22ik9mTU4/Xf4TUE?=
 =?us-ascii?Q?wlMsPcq3fY0PdsYV3aPozbaWkbPTBYx5F5u0lueTWlJgz1PTmpvoWRc7Sdvb?=
 =?us-ascii?Q?ByqJVrb075HniI/U8RS/8PsoM4OdINLYgnrlzXGpg8kv9sip77ew+uRsOBCz?=
 =?us-ascii?Q?HIx9nAmhCT36yfe/fsTOdO/PJrUJqsSJDq7am5kIbcnLOjH3lKFfL7UUP0QZ?=
 =?us-ascii?Q?VPjrFimQMZWPOcAkRvAcG65tDwYJnnEPAMpzDoBu5TX2NeP0XjsC9DuuUrWf?=
 =?us-ascii?Q?pYxi8jZ0zCMSrtF9RIfrfeYppXFkM2MUYolVySpsKupoOyHj4ZBZ7laCb25Q?=
 =?us-ascii?Q?w//RMLMR5EDK4LK9UNu2+WWejDJio94CrtQXvInudBaSdfA/rfFHPuaHgOYG?=
 =?us-ascii?Q?m5xASH+If/at+SJHthEhLLbKEE9YGqJZUbIOeHUbCKeQWuXuIBC7rH8PboLm?=
 =?us-ascii?Q?GMIUM4ADrkYw0LvoZoMojmn19z44pqEw/xk6pIBxfpQgOLFWryznYwCk6ynx?=
 =?us-ascii?Q?xPIESe+LwXQbB+1mpzYV2XRROSnr5UYv29cWyCpRLMkXuzrGnjcrWT3x0PiH?=
 =?us-ascii?Q?zgznaVDlbdcgow2sCiKhcEbAfsvPQDSnQcMKADSqhsj+fpTb5W77C9t+lMfM?=
 =?us-ascii?Q?EDKnj4ZWRGShmcU5jCF1hLUTm0IKh99I7KfJcx2nLAn7aSsRVXa2Z5cDwdK7?=
 =?us-ascii?Q?lAQT3xQKsQGQbQ5eE5zXIHdu0zRA5A/VODMYaYAiVJmY0T8cS2r4BMQelR2c?=
 =?us-ascii?Q?cY/pOOLi9kUND2b81ILvR+K4XBSb6PH3buvpEdbsGgfTLXECOEwSuwElKj64?=
 =?us-ascii?Q?VzGP755r9dzOe7Mmq6Syt2h8fhVv5csn+tVM/rNbOM+1fVTpyYHqADS8SUFI?=
 =?us-ascii?Q?N4ozmN00I9GmOEBHgRfvOxjCnUDgWER8jJJa3OwqzozfxD21VCLA2Pjx5EhW?=
 =?us-ascii?Q?muRJQaNMpPiXw8pu0jpv6sITi8OD4x0QYZ+8zWmqnHPKfStjnv7Jg7GVLrbB?=
 =?us-ascii?Q?4VfjekbSwHDwqjkmg2yQI7TzgRGJ2ToHMOKtrXbzkPWdUptqyUaLtOFcvOE1?=
 =?us-ascii?Q?CcrasAU/SfL9kMsfIHWY2hydey9nAatrc+01rFGQITczvFgjA3wkMdw408k+?=
 =?us-ascii?Q?Q7OTRdz79ZA2j0KURGPM0rvklvFcdp9D6rsFw2+PWIR/7xXTlbJOxxiOhuhO?=
 =?us-ascii?Q?QjjLXXElPHdTeinqqbiJX+ysbwH5srGdt4pUe/lm3XcvT2iDHF9pE11MTePb?=
 =?us-ascii?Q?49+3X+SyERttSxCrrsKavtFnqeU42s/BMh+4esMiTYdNxxoOt/SyAK7DeuE1?=
 =?us-ascii?Q?cQPmckkkgqp/DwsdPBlDC5PJh4YIq1If4uc194pwHRC4gYrzQaZqqYt064/n?=
 =?us-ascii?Q?xcys4IBzl86Y+6rv9LHOs91qSbCDxE9gifxoh1mlwTn7476CIAPcGiX1JY/V?=
 =?us-ascii?Q?bi+Q+fsQy8sN3Pj60EIwrjVThsPZFqd+4icIph71DCt/FBAWIA/CSesyYp3r?=
 =?us-ascii?Q?lCwnHnGJEbP747fvFbJjADw/SW6OW+/hT9q2Ypf0KpYHN89pkcZBCucZxLeB?=
 =?us-ascii?Q?gfBf2Jar5iQLJefSjC18aD0Z5bQIKH9KpCBNjQZ9usFojCRZbQ0xl0Vbtiyw?=
 =?us-ascii?Q?JvC965Lz3R03e2z/PzAAoZXIZcUzGZP9nO+gbc8ykCyGP9HUTAlXJA7s5ofX?=
 =?us-ascii?Q?7udJvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:23:06.2005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6a5468-dd61-45ee-51f0-08de57988e18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452

In the NVIDIA vGPU RFC [1], the PCI configuration space access is
required in nova-core for preparing gspVFInfo when vGPU support is
enabled. This series is the following up of the discussion with Danilo
for how to introduce support of PCI configuration space access in Rust
PCI abstractions. Alice/Alex/I had a discussion of the next steps of
this patch series in LPC 2025. We agreed that first introducing the
functionality before the BoundedInteger work and other refinement is
settled. [2]

The repo with the patches can be found at [3].

v10:

- Merge IoBase trait into Io trait to simplify trait hierarchy.
- Use IoCapable<T> and IoTryCapable<T> functional traits (not marker
  traits) to separate infallible and fallible I/O operations. (Danilo/Gary)

I tried implementing the marker traits idea, but I found that the
compiler still requires a default implementation for each function in
the main trait to avoid forcing backends to implement unsupported
methods.

However, Gary's core idea of "capabilities" is extremely valuable. So, I
adopted a dispatching pattern:

- All I/O accessors are defined in the Io trait. They use default
  implementations to dispatch calls to the underlying IoCapable and
  IoTryCapable traits.

This addresses Alice's concern about the complicated trait hierarchy.

It preserves strict compile-time static checks. The compiler can catch
the case if a driver calls an accessor not implemented by a backend.

- The actual logic resides in IoCapable<T> and IoTryCapable<T>.

Backends can selectively implement IoCapable<T> or IoTryCapable<T> based
on hardware support.

This addresses Markus's concern regarding backends with limited access
sizes (e.g., I2C).

For example, the Mmio backend implements both IoCapable and IoTryCapable
for all sizes, while the PCI config space backend only implements
IoCapable for u8/u16/u32.

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

- Introduce IoCapable<T> and IoTryCapable<T> traits to allow backends
  to selectively implement only the operations they support.

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
[3] https://github.com/zhiwang-nvidia/nova-core/tree/rust-for-linux/pci-configuration-space-v10

Zhi Wang (5):
  rust: devres: style for imports
  rust: io: separate generic I/O helpers from MMIO implementation
  rust: io: factor out MMIO read/write macros
  rust: pci: add config space read/write support
  sample: rust: pci: add tests for config space routines

 drivers/gpu/drm/tyr/regs.rs            |   1 +
 drivers/gpu/nova-core/gsp/sequencer.rs |   5 +-
 drivers/gpu/nova-core/regs/macros.rs   |  90 +++--
 drivers/gpu/nova-core/vbios.rs         |   1 +
 rust/kernel/devres.rs                  |  31 +-
 rust/kernel/io.rs                      | 473 ++++++++++++++++++++-----
 rust/kernel/io/mem.rs                  |  16 +-
 rust/kernel/io/poll.rs                 |  16 +-
 rust/kernel/pci/io.rs                  | 169 ++++++++-
 samples/rust/rust_driver_pci.rs        |  29 ++
 10 files changed, 686 insertions(+), 145 deletions(-)

-- 
2.51.0


