Return-Path: <linux-pci+bounces-37792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBD3BCC0EC
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 10:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32FE0354B75
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 08:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31E727B320;
	Fri, 10 Oct 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WNrCdZtv"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C832749F2;
	Fri, 10 Oct 2025 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083435; cv=fail; b=IWTjLdBywkAD91NwQqlr4Ir0kPCfFkSHruadKB/Rxh49wlx0xTfuVuIHXfqqATg5utvtwJsuUiWk4+eY/CxRnYSbwIi1/s5Ac+cHM4INrbMBQLSoUwNzo8+Nkei62VZlxUg2GOvyZ6ZFClGTJbJmdf5KnXX07rd8cT4WvJrtmoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083435; c=relaxed/simple;
	bh=fQBoGS6cme0QZ/sRs12kGe41vzokk7MpDZ7iw0pR4B0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uig2g5vklnpN63QDLvVjvAmezzCALgJxUgRJqlp3V00Mfc4AHv8QI596xFgCC87rf3r3SkZ3EFhXpUbzl0D2vZZWrHDDEhF9ZkiO6KItEGhlFqnZ7kds9bAPtIPKnZsDcXOFdWZWUv8QQagPLjZnDZ6Hwxnz/SSqKFmurmcmMtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WNrCdZtv; arc=fail smtp.client-ip=52.101.61.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yu5FTHCy3pGrFcXJkAuTHs04wDMA2IxuhBwUHguuiMzLeuIMESo6Ayd/QP96VuXw6KzqEMEHh1VQGltA/+au5SxwY0IDvxtBGFz4HpgMNI8faZ3UU59Cp/6EORqtq+Jp9HNzqCN+aZJw843fekS/miezqClElM7lUaZH37vBJpKI0MGW8nzhnlFnqImgqgKPUDH530mu5clCBI0Q4QA26dSK087KLCuc+HULkAIXlsbPRNR7znN9ktG/qOx4kOSkfTnac903+lsdk0aVM+E1gVjOPrJso6mgqtKh6Y5JYRwW5JDZjCQvqjkSXN3m98xy+vKxvHqu5Fm7tyuCiIC2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnvinA9H65s9ntU9HtyLL5z0JPpmfqLP1FlyVZuAL5I=;
 b=WvONNquz1d2HbcYlFASrc2W78XKyB/4gxfgkKV4iTQ2+JjyZDkG8y7LcKG3Iivn9N02ahijP/+OBpkFDu5W9XhMUQ0NV9GrnTSs2hO/BOiOdt0vxVQfaEYpxOA9+e3kl7hUGJyj33x9EtyWWW6F43VJMk6kIOKC7mT7t5g7XT/GRhiRrn5HDOxBf5VXC7BtP1uGMbCC2BZJps1bbDUB5lNaSx+XsvLviBUD52IDqRlF/RI6tFdz2bDRXy1rUfZ9+JuRPxsr0rtAYqApPASm3TF1w6Q7oeDueaYqeJdF4GajdGkGJjiTsPvhQG24thi4DSP5rybtgBKCf/kGKD5HfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnvinA9H65s9ntU9HtyLL5z0JPpmfqLP1FlyVZuAL5I=;
 b=WNrCdZtvxynvViTiE45Gg4x813FmeZOzm08Z7iX87ANwEjdGj8PDHoXfhWz9mCoQW4Ugr7XbV36YFoak//cHjYWJYzwW0cGSjMJ8R+eu8jFZGUsAiQb2Q7Ye4YgtWbm2tLbGMlaMwDdljNpoIqhKrLNKDW8OOdfpmwjxIHQ2/11hu85M6ekQnm2HF0MrC4dmAJFrmrygTd+TPm/akf560glO2MdYXkyTvepGXEdSHGcYmmIkgf05Bm426mszT9buInFWzmX2ECmxbhdpaGczmHkCfzQtuwTBXwvy+ZK/uzs8yMGAL8AIp4E0Ba5M/3hcL4PLkerDOts4IyWTNFul1g==
Received: from CH5PR05CA0024.namprd05.prod.outlook.com (2603:10b6:610:1f0::29)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 08:03:50 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::eb) by CH5PR05CA0024.outlook.office365.com
 (2603:10b6:610:1f0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7 via Frontend Transport; Fri,
 10 Oct 2025 08:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 08:03:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 10 Oct
 2025 01:03:39 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Oct
 2025 01:03:39 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 10 Oct 2025 01:03:38 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>
CC: <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <zhiwang@kernel.org>
Subject: [RFC 0/6] rust: pci: add config space read/write support
Date: Fri, 10 Oct 2025 08:03:24 +0000
Message-ID: <20251010080330.183559-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d6eeb2-9056-4093-69b4-08de07d38bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Ub1vorti1Xx8XH7ypDriTxaGwkFYIzkkcf+RNPFRs0cpnL3AKSO+IwA2aYp?=
 =?us-ascii?Q?92CAd/5y/ixyDIzTo2Q1HzsU15wXYDw/b7/FcDaKC3Mg4+6Qq7xyDajtu8DA?=
 =?us-ascii?Q?fJiCZAqe7aZD9R8PZXpx6fiLNdfKpJaaFJkwtPQ3uRzPwsd5onXgdhTYyHGh?=
 =?us-ascii?Q?zvMxnBLtV3nbgwg/cdJyxw1jttBHX4u1u//dIsb3xOnuJx4BscSUo6clI1i9?=
 =?us-ascii?Q?pFVB23nb9xUbcGvNS3j3AfftQrg4mwKiGlzrglL90N3Mx+kaAFV1SgeG+Liu?=
 =?us-ascii?Q?Kpu1Dj8ZQzNSt5+rafgGtSZLicrhtqPmN6UUcABgXHP2CP7m48nXUfHeqljB?=
 =?us-ascii?Q?dGpKlbHzQQveAW1kd4CDvO4sCF5kCUM2VohCqYwJfAy69OVd4jsDd7Pzh6f+?=
 =?us-ascii?Q?6ufsLbiWc328pac0rhgAKfRzGQxKPL9KahD4xvIKOyH7TcyvDbUc9sKLeQ7S?=
 =?us-ascii?Q?VOPF+1qtbl8PGbiat8tgcWviSqOHONm4MeOxHq9zYlG3VAldzirR2TC0E2wF?=
 =?us-ascii?Q?JRZS4hdfbdi/0S3qE1KbcVHNWSP1kha6PIpqfuGbIQe+X2dzQDFK422w61mu?=
 =?us-ascii?Q?r+bP+ZGaIiNP3I9MMAPIqQKA61LMKdNcXMmv2TMqDHeX66M1yJlxRoaieT7z?=
 =?us-ascii?Q?g2habONLa7D5VVYKPt995ehbTz3exIkWbKXJw/7Dy75no4IoFYoArvCMbMRq?=
 =?us-ascii?Q?KBpveFVmiyVDFLwUDRNYtxbCRlrCyVVxUjQYm6YipVmIBn/f/NGfRq3Em236?=
 =?us-ascii?Q?pTc9wYZ+fsKria9ZOgfiYYqyokOfhhRGczpsLFN9HgYjB+4QOuDv+uZfJ8Sb?=
 =?us-ascii?Q?rjmuEsdijzCEuxNu9KJCn6HesZl5iJ7Hu1Eq8/x8yR0xPFZkRhNz0JJe/Vh0?=
 =?us-ascii?Q?lrI2DPwU+0dhNt4gn9RQuPXwPolwLsyd+4LMRh2AZpvEOQMD7B9SNr8E42bz?=
 =?us-ascii?Q?UFsgAeHG6f/l8+63AvNRayTrLC50ZKK78v4T24i8gBhTHfcX9ltjQe6WyZr0?=
 =?us-ascii?Q?uM/MtPPqCclHCdJLdJdyjEo4O2ycBabTGQ4BRpf00racIB97oVjmAj8pQ8rG?=
 =?us-ascii?Q?ts83BGfh++ohb1f207+DQNH4HCWWhCO5I1eFbOJ9e1Q944IAayvNaKIRLEzp?=
 =?us-ascii?Q?Q86gix9WLjWnK7P+rG1ic5Gega5dCITc0gSpToPwSBslX/aJRfan5fbg6tOh?=
 =?us-ascii?Q?2wi7n12enSEOlZaGSIkYu/6djVsUUPL2jyeCkOYrbbzW4R6FTXGv1ubi+WVq?=
 =?us-ascii?Q?HnKtjFx878Z+rIyns/Y1qikHMnOoqhTXvZaLe1sf4cxUPO9zlJ6/1sgelDwk?=
 =?us-ascii?Q?qb6t581j2QbftjTe1leFExUbUiWk4mvJkxg8zpaE7mlbDSbQJA4uiKbkI5um?=
 =?us-ascii?Q?wtm8M4MTTXhaN4i8yIk5txahmvPFvc9zEGBx91E4Y1XDLEhTNRQyYnFWFr2J?=
 =?us-ascii?Q?IL+G+k9O8JoLqdvZH8LXsyhFUbukiWGeDyzpwKi4TYc/hEWRTrLJRgIwpB1u?=
 =?us-ascii?Q?r8TFHVmHLHxSKRjZKNj8/PdMYLi8ArMZhpyqWhBRaJpc2n94LigY2TO0EA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 08:03:49.6621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d6eeb2-9056-4093-69b4-08de07d38bce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055

In the NVIDIA vGPU RFC [1], the PCI configuration space access is
required in nova-core for preparing gspVFInfo when vGPU support is
enabled. This series is the following up of the discussion with Danilo
for how to introduce support of PCI configuration space access in Rust
PCI abstrations. Bascially, we are thinking of introducing another
backend for PCI configuration space access similar with Kernel::Io.

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

  In detail:

  * `struct ConfigSpace<SIZE>` wrapping a `pdev: ARef<Device>`.
  * `IoRegion` implementation returning the device's `cfg_size`.
  * `call_config_read!` and `call_config_write!` macros bridging to
    the existing C helpers (`pci_read_config_*` /
    `pci_write_config_*`).
  * Read accessors: `read8/16/32` and `try_read8/16/32`.
  * Write accessors: `write8/16/32` and `try_write8/16/32`.

- Introduce an rust wrapper for pci_find_ext_capability(). Thus, the
  rust driver can locate the extended PCI configuration caps.

Open:

The current kernel::Io MMIO read/write doesn't return a failure, because
{read, write}{b, w, l}() are always successful. This is not true in
pci_{read, write}_config{byte, word, dword}() because a PCI device
can be disconnected from the bus. Thus a failure is returned.

- Do we still need a non-fallible version of read/write for config space?
A rust panic in accessing the PCI config space when device is
unexpectedly disconnected seems overkill.

Zhi Wang (6):
  rust: io: refactor Io<SIZE> helpers into IoRegion trait
  rust: io: factor out MMIO read/write macros
  rust: pci: add a helper to query configuration space size
  rust: pci: add config space read/write support
  rust: pci: add helper to find extended capability
  [!UPSTREAM] nova-core: test configuration routine.

 drivers/gpu/nova-core/driver.rs |   4 +
 rust/kernel/io.rs               | 132 +++++++++++++++++++++-----------
 rust/kernel/pci.rs              |  74 ++++++++++++++++++
 3 files changed, 164 insertions(+), 46 deletions(-)

-- 
2.47.3


