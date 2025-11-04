Return-Path: <linux-pci+bounces-40212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6824C3184B
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 15:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C37B64F770A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B726532E6AE;
	Tue,  4 Nov 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nJPNntmp"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7C3271EF;
	Tue,  4 Nov 2025 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266504; cv=fail; b=VYaa/QcQNUOi/uiPdpzv+tfGgd/H4NyuB0Nlw93A4MVLInynuNwukyVOfoxWHnn2fp/hpkMXO0e3gRVJhmhuiBKovzkvU02sfDI+QieUZ1kplwOIdWc9AmxTB1NYlZ98HEl9eWJ1H50ZKlBapaC71SL5yVHEcoBrcJb5aAGdIcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266504; c=relaxed/simple;
	bh=gEz2+rHSWSYbp7hmrxw8AXW25yf+07ExMCNWpF9SIE0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iw4irwpsKDto8bpAGJwO5TzpG0g6826EZcyezVk98FAVWqoRuKcDrBtrgNCBTnDfFfwhtDdya6Q3pR59cX8AZDI/IesULu70ozeTV6ytzuq9qI6eViyxjO7QdHMiqHsHNz8yixBGv14vjKOPUTYV7G5PN4w7zzowqIrlddx0wr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nJPNntmp; arc=fail smtp.client-ip=40.93.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNbkaMEOhCP6tu9+sVdzV9LiDTwswhXiENmlimDWv/AIPjpGzeF37yTgLjtT8Vb1whyxqwmv28fzsPjCEACvN4t530wlo4F75utmNcd8BmecXCcZnrAB39WDGufGbo4MiXkZb3DsBnhku5rQeiYX604VOe5N1RYgiu7m1n+MwOEALluMxcu8Ec+Ma0O4b5neEV1uvNqgYhgWMEZ5zGdn/iLF8pwkdqv66o/PZPjxskHzEcqpHhInRvzIcmXedyLsq0iPLqVrxBBMuSW3IoaaS8Du3EMReHkAnTa4XJ+ImMvbDr1XBW5maR9cZQ9KOjUyr7HULxdTTY/o1r1DxmYUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmITIElCi+D8OyTjp3/BtR3HKO+jnGZpm0HRO0uDVys=;
 b=X9lUhtHXXSPokd8QqWf9/4Qc83+IZ0ktlKipUGgjKqlOGvNGKyYUB/bOBWCLeixbb+RqjxLedbxugBZ6Ut5pDye6Dv8pGU/V5camp33EJYKQ7+9hPWSEC1KV+bA9cO68isBOJvKoUshoW49RqoIloaZbUZjtcIUlQZVrkTFhdmzA67idHVyDqT4ZayX2cyzCP/TmQs3K9VG8n0whhMEtHPxxr9XOXSzcGONN+kCcvjC5IKXkYITeysute3z9syOb9dgDRpLlSViRH3eLzTQsaq0+WgfNMZzOBVPx+fDjj+i2D5Bb9qfRCOXl5+tWwyUArz3gf3XL+85uoSWsRRJgUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmITIElCi+D8OyTjp3/BtR3HKO+jnGZpm0HRO0uDVys=;
 b=nJPNntmpgRfiygF76MR8Kmd09JHRcCRiVizYUFod9tlxDPJW0PWHKSQsPzJUVajVUjXraMuW3Uq6cD2olMMGDy1c1/jliFVJ/rhzQBnJbuwIAbvNCipHTXxia2vd2+duC7nXqGd3hh0i7sRYy1yXi9eFrvG05n/rnBaANGLosu9lFRkb7TIkjFtJgEjweSz4HEWblQi+6KqdZuIk6e0dA6YARg4v/8FkMqxFuv/B4aLIGRmedo5Jhw3lXelYP+LL7wP9xtX11oXOI2ZW4J7mr3r+j9NtryUmIOFtIsXE4LAE0sD0iyBolUQZUoamaBvJsBL35H0uzSuyYr5SfL02cg==
Received: from SN6PR04CA0073.namprd04.prod.outlook.com (2603:10b6:805:f2::14)
 by MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:28:17 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:805:f2:cafe::36) by SN6PR04CA0073.outlook.office365.com
 (2603:10b6:805:f2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 14:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:28:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:27:55 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 4 Nov 2025 06:27:54 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 06:27:45 -0800
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
Subject: [PATCH RESEND v4 0/4] rust: pci: add config space read/write support
Date: Tue, 4 Nov 2025 16:27:29 +0200
Message-ID: <20251104142733.5334-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: fef8698f-00ec-4880-45dd-08de1bae6507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5+TJgf2UgRatXCiENklbBm2YZgpMhCp6uaCegLhYguee+EACpz/MCE9Swbpt?=
 =?us-ascii?Q?eND5GDbUq1rNMI1aAT9lu6qiWWkkq/H+JSjDAktevIkzVxAnifvsDiIx8Kjw?=
 =?us-ascii?Q?/pSjRO5tltOLav2SQbnYOlEUWLSXqRwaSRiMcYWjmy5bYTfeLZEEyXQfFNLz?=
 =?us-ascii?Q?6rgLNXgekaSmgwtMGqRM5oSR/iqp7x0GJWwC50KFDwtomjKybqMwZRphbFS4?=
 =?us-ascii?Q?qqidFEzKXNLLRwxW6KRLu11ERVDu61ixluuMAhN3oqp7JqV05kg3mwMbD88U?=
 =?us-ascii?Q?LoCTLor2J4/50GDcrf1uuU/TCtSbSjJeOB5/SAI9Tv5yCTLWT5KoOymeh1iD?=
 =?us-ascii?Q?LMfItFUWYhnJXJ+qaZnqTUrmPE8662vA32jAAGSpYShg+VBzvXKLf9NUqF6j?=
 =?us-ascii?Q?br73kTT9nWjT1tTWv7sUvGWMRPHpYT8iuej73AVV/snhwxvTpQLQOwazcFEe?=
 =?us-ascii?Q?Mx8cUk8+rznGqLW9JBQamwSS/8ol/PXwK0Lk1aise2oAbOIy4S7WWxkGfw23?=
 =?us-ascii?Q?rEVVAEMjU3WNI2z85abXRtMfH+8SfSZdXjGqKauVeUcpIzurm1+bOBFNFBdT?=
 =?us-ascii?Q?1xUY6DVFEPIiETs416SFvVtkVnA3L6vvi8DKcJ+/BqGOCmusfC0Vr8wa/nZh?=
 =?us-ascii?Q?Z35VCDZMoPTKAk3XpSzDqcT800n7ltwZPHpSjhxXWl8m6WKQ9aDzd+8k6YIo?=
 =?us-ascii?Q?cn2NG1hFP59EEWKNWA93dmeCciWXjtR7x3WV1Sj2GB/LtmSBvuOhSzFCz6T9?=
 =?us-ascii?Q?XzWfh5j8pPe3hE23b2hzrFdDOkbPDS3URfD1ZOOuAE+HTA517TjUGQBP90nA?=
 =?us-ascii?Q?w9lg8b7t3knAaTrqomMDCqnl71vtE+BXTTIHm5wRlyIpudRUTyafQB2LVyxC?=
 =?us-ascii?Q?lAfp+sdWnyHxvW5UARClZkFb/I+f3KpEuEao0E4D8zcXU/TVycsJbCI4PhWl?=
 =?us-ascii?Q?1TZDiuclTbAjK6HUnXA0J1E81ZTy/RiNpy3bPOVx9M7eKo+eoncoktXDL21i?=
 =?us-ascii?Q?19I6E9I//XlKtMOxpFWpSVLD5aEclLKuRs1cpI2rrkop6m1qDZCZHMi6qMC5?=
 =?us-ascii?Q?QH9omV5OFKDdtJwW2CwHbsr7C2sjB360zDdYxVBQq7dK3pGox8cLOfsFr8+U?=
 =?us-ascii?Q?ybndwx4D8vg1YZjDGJRJIRRhbwb3O9BqRk87Q0zboEO/FAIGTqVLbpr6okwy?=
 =?us-ascii?Q?W8c2f53URd73UV/mj3QODF0JHSdNmtdF+fYEwaN588RDXezMolGFa97pgwoD?=
 =?us-ascii?Q?GEEW+lHoj1g/6FzP9JTxX8PsBp0DsuGJC3IisPNOtRhswZ6nvKIdIcCIRaTw?=
 =?us-ascii?Q?xHJixMX29akyT+D8qT66YWAFxYVVdeLqKGQNtAC8eBAfYJT5LXmmbbi+P2hX?=
 =?us-ascii?Q?s9T8v8uDXTbcIz1D9lQUA5VjkFnW995kPrkOGJboam01uxwEA5XFrZGuJSSM?=
 =?us-ascii?Q?dl8dphLyP2w8PTst14jU5aYjFHZrxIArwdtUy6CWoVhdLOqtzDg1ym9xMsJs?=
 =?us-ascii?Q?JJCFk4dMTlSLkNQepkOPN1thF3yaLna/gnmV1qqOMyOi+X2TrYsxDmW6QTIX?=
 =?us-ascii?Q?ZwQTsqSG7RwAUDKos+E=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:28:16.5102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef8698f-00ec-4880-45dd-08de1bae6507
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515

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


