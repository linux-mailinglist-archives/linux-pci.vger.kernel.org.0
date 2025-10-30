Return-Path: <linux-pci+bounces-39825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65737C210AE
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 16:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC865608E1
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813A92D738E;
	Thu, 30 Oct 2025 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gDTGD1Fd"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012000.outbound.protection.outlook.com [40.93.195.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FE24DD13;
	Thu, 30 Oct 2025 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839345; cv=fail; b=CBmcE/5Vnsl3uznhbupsP3y8Oi5MEUR7yb7DPMKCxpBZu98ID0H7ElKMV4VXsbjD6kthQSLfetTXU4YuFN3wEFm6H2VLGSjAeONuTtnt3Xm41YDnoZ7Ev6i2qG2zLpzQjEJvoy8CJgDbFRgvKXQMl1H7sxDlsMwVi4jiKlOSrpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839345; c=relaxed/simple;
	bh=qkw8U9vkNLEOv58lf9prTx851i6NOqAxlr0vxyxDvbI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IXb45MK6FIWrClghF+Joj87467tSpLZiWsinQqRt6TAAtA7lk4WHwS9sAuDtU9tN5PVWKswUDHVuter8tOeMxgnQL64os4jEyfJ0rTSYC/KzIGULDYF24gu87bmzmPT3iEPOIq6hGKgu6VFEkBldEqMGqVKad9cl57m0vcTTO8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gDTGD1Fd; arc=fail smtp.client-ip=40.93.195.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EuMS/UtGWMG4hzXKDqFTAMmmNTXYwmjBURSL2U71AGhzpN+pTYmZ0KR7MNJ+FuSdKG+ES/7hIOrvLSqRgbjjRUIo3i47VCH1yhWymc6NS02y54RLcYoL/u8z3LBfgEE6evbdfB7YUXr80CovjCxc0mpD3KilpKMNxYqjtaKo3r2zczaOnn67g0JZkuTKAnOaQ55z8DqkU663iod5nipaXeTnKLJxtyeC0JgTejgvzewor5ZWmISDrD66oBV/6YVm84UUroS7HYB14lmDae8EdQXc/R0JzrJ3KnGBrJaECtCmrDh6bbtSvch62cUhrAtiMxzq50hXm3tyDc2xqVl8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I42Cx2cIGBdzPSYIhNNdEKAnbGAgYRbGVp6AA4QCDJw=;
 b=MH/sBcqNsR8YadulkTWYfnwA/5cPoPYw04BwVOtAt9kbzurnf5g8QbFxwqSKBLb/Qz/fPnwCsZLSY+3MEOBl8HFepdnaKAiKpCkbYSik0ixtb896y/8kCeU1V7QrDriYp/1X5a4tnluMjhIMJB5JuI7Za6I39KJtIZ5bqzprnfPeBVrWX8qF/z61c4fDzy7yZV+HMVrKPwKBlnC3NF4wGY9SbOErTben029T386zVQtGNSf5cZeQE0auqodwTFAI03q3ogxQn0ROy1vkW/1ffEOpy/o2SurA5eh7g+IJ0q5gEmyUzdt/YG5Hv1vR5N6+AxmeX6VK18Jj9y6GxU8qPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I42Cx2cIGBdzPSYIhNNdEKAnbGAgYRbGVp6AA4QCDJw=;
 b=gDTGD1FdZl5de3gUJj2beR8YffjbY1w8iGrYk1QmaTQYyt16zrmEUVVIOuYP3VAaVf1ZSIY//ZW9AOWI/C/J1agf7Wk59+rt4goWqkAKYY4DqHAsENcTMovfL6ewp/X4SLf7jsTiPfz9cOX9PeoiJ7i7nbrYUuDhVUqwBSuM4cS/6F6pnfVRqDrzo+CAadcI+tEp2l/k+TJ2LV5r83uq/3fofiwsQB0iTqPI3bRXrelk95v/SwoD/H0fIBNkWxlh7w1pjossulYpXtf1Cs3s0nW2tSb1fGKOaraRbBy5gTvxFn7VgYq29w0TXGXPV1S84FFl+rwu7Gv8yGNMFyaY/A==
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 30 Oct
 2025 15:49:00 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::2c) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Thu,
 30 Oct 2025 15:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 15:49:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 08:48:46 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 30 Oct 2025 08:48:45 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 30 Oct 2025 08:48:45 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>
CC: <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
Subject: [PATCH v3 0/5] rust: pci: add config space read/write support
Date: Thu, 30 Oct 2025 15:48:37 +0000
Message-ID: <20251030154842.450518-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.47.3
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SN7PR12MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: d12df7bc-958e-4ffa-4c95-08de17cbd822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kZstCyCzLEhDv1wxKK8OHgi656dpbuqRYPlXfBfa48zu1MxLeijKlfIaddC7?=
 =?us-ascii?Q?I5kfO4RKDnhUxjE+sKJn+lZGixDpJR75NXsafdo1QNHikQ83zPe8XLmlGHK7?=
 =?us-ascii?Q?53DzabP2TyolJBSSJf9Sn/LD83QRm9S/XVpyI3y/DygKCWvxS9CkVJGhqRoq?=
 =?us-ascii?Q?Grq0L7cpUTciKPMfPuAPN8NOzaSMg+SkWXwLs9Nb3KFynPBh4Pxdbo4izlcN?=
 =?us-ascii?Q?s9O2p58oCP6uwE6z1wo5BjRAX5Zof5trBBKx+SV4x5Nqn81CprjEJ9QzbHoU?=
 =?us-ascii?Q?Dc2PbcilLXWPMvmXvNNaOcJgq+Yck4aerAuvn4aNNRUqnbuJP+uxwHuaOJlf?=
 =?us-ascii?Q?ITdsN3gPqv7cmscVSp04Wh41pAsIxCgWccn0qDaDNwlGEEgaq/1W/VzwU10X?=
 =?us-ascii?Q?ZzwWH3/jbr8Rne2jhXvilhxzd1QMIXeRySQLyR4MC0+mgGbAWxFWdv6AqAi/?=
 =?us-ascii?Q?Z/F1YwKt0aBqbMkR1eh+AbZkQCEf80wM9O/D4c0D6T53p1SW/kgZlofG77Ak?=
 =?us-ascii?Q?uHfKP7+Rbh5UZX5VAJ9fdV3wPDToJViN1LfTw/hPk0gU15bYhdDFB7wD9EkC?=
 =?us-ascii?Q?TFSRZFW2MWmaXJwfrPd7zsZ/r6U1m9raGq3x/fQ5Su3o7eBtp59xW2kBcjoc?=
 =?us-ascii?Q?Ki42xpFiedFJRas9tXtFh0PFqedg0nCvHejvhzVlDzPQQibZU9iqRQvKDbMx?=
 =?us-ascii?Q?2ZST0HEtgKaRrral/U7Qwf4j+CoBUNDdQwamuiS55eZP58vlgjf0IUE8Tqtf?=
 =?us-ascii?Q?a0pegE/i9Y13QO/H8NFeik7K7larHaeEYw57O3483/iU8RnDxDmuGxn1Sqk9?=
 =?us-ascii?Q?ac2gCk664dTdL2DcU/RUXto8IAd7AFiLcDplcvRLm9A/EgNYO+vU/RRtGHBX?=
 =?us-ascii?Q?XvMHJcvzq8HYIWV9JYWet9+BXe4KIkByl+L3b7hxSlZj2KO8Rxq5hUDjuUz6?=
 =?us-ascii?Q?OBTnMVEQRAxSpK1UKTb/Eaj4D9xk/Zs3TKZhiX1lCETuE2/oiuKut5tpI0zj?=
 =?us-ascii?Q?jhxVxUtxeeWPEMuLiq10XLJr3Dk3SPfHlHHj8YAQY8dcqC1QPBXd052xSm2v?=
 =?us-ascii?Q?8Snzc4OPIr+J4SoqMs2TqJMDj/68l1tPtW4pnfckec+7Q/XB0JNyXHrG0qEq?=
 =?us-ascii?Q?wfnNfuvwqBZ0KtsYSq48eN7tzeTptbpTcEqyuzylfzRusZWunjnc/JfJubms?=
 =?us-ascii?Q?HXrVSLb8oFUT5a133xazKR5MZqy7hnQvMk9ebQRXQphoImW7r2q0sixRLnnQ?=
 =?us-ascii?Q?p4M+UQGflSWp7WYnodXZ0Li5zT83Fd15qoGq/nL4UBLXqYCMUnCkyCyVd1fs?=
 =?us-ascii?Q?lDivcDHkr2AlA7dMrDkXXE5V6S+1C9QX5e+mVTHXKtbR1UAsgueLXcN4fvzm?=
 =?us-ascii?Q?DUKPBs91dOVgcpP6T8VM0CsvlKK52CcVqrnggBoTIuqPMXvKzJ928Y8vQKd+?=
 =?us-ascii?Q?TGZg4+zCf8RhwCRZjzO80CtoKngY+2zCUmrPo8JAx96h2DuLrcZCoQ8xk9dY?=
 =?us-ascii?Q?Dwh2GMmmxZQSmxDwNkaRLilGdpeDJkvyCsJZ0PyaSZUD0q8ZWen1NuM/jlmO?=
 =?us-ascii?Q?GSz7xIrRCcl6sZNqfJU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:49:00.4076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d12df7bc-958e-4ffa-4c95-08de17cbd822
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7107

In the NVIDIA vGPU RFC [1], the PCI configuration space access is
required in nova-core for preparing gspVFInfo when vGPU support is
enabled. This series is the following up of the discussion with Danilo
for how to introduce support of PCI configuration space access in Rust
PCI abstrations.

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

Zhi Wang (5):
  rust: io: factor common I/O helpers into Io trait and specialize
    Mmio<SIZE>
  rust: io: factor out MMIO read/write macros
  rust: pci: add a helper to query configuration space size
  rust: pci: add config space read/write support
  sample: rust: pci: add tests for config space routines

 drivers/gpu/nova-core/regs/macros.rs |  90 +++++---
 drivers/gpu/nova-core/vbios.rs       |   1 +
 rust/kernel/devres.rs                |  12 +-
 rust/kernel/io.rs                    | 333 +++++++++++++++++++++------
 rust/kernel/io/mem.rs                |  16 +-
 rust/kernel/io/poll.rs               |   4 +-
 rust/kernel/pci.rs                   |  94 +++++++-
 samples/rust/rust_driver_pci.rs      |  28 ++-
 8 files changed, 444 insertions(+), 134 deletions(-)

-- 
2.47.3


