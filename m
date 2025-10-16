Return-Path: <linux-pci+bounces-38401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FD5BE5822
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 23:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C0C582CE2
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 21:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935132E717B;
	Thu, 16 Oct 2025 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N3u8fvBO"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8DC2E62BE;
	Thu, 16 Oct 2025 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648618; cv=fail; b=drWP1zX3vbvS/YfcpFexkQ3G55y773YU09xDUSafGE+TKpEIcaCKLMFBGYby/SbB5a57jCKehtnNAuKBM2dNhVI4NjdwjRHcl+KabEU+zrn9pDRFywv7OnVA4wc2WPU4dg3zyR8viI/b9DHLVsPvYtso961wVvNpdtsVOcxryHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648618; c=relaxed/simple;
	bh=+c76FNmUj/hceF2p90pzBXjuZHbYdAzyTiQGX6mYyF8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W8sOA8odZydQ6YOqc1/0SildCxoaGNCsBLlVSr697G8oYSRdCMkv1d3jKDF+tGKiLjUb7xqy8MaTL6NCC8V6wFxRlDfeOznfipE2uJP47g7WT03O5sRut8xFPhBsNRn9nu5co2cjlsKhZFtNkH0Y9EelFlgSMDOdOAFRF1+9HLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N3u8fvBO; arc=fail smtp.client-ip=40.93.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQGKSZI3uoVyErP9RjTwk2UVL+6wf12U/xmR8b6SuFxsZ8Lw2R8KipFA53mfzSeGN64aMbjr1St0HDjeeOtt1g8JANH0HCvNQpPQAKneGtD37U+7+bIZfFswdmUcc+xQfLk02FTY4I7MsPlXUOqIgN9KN8zD6iRd0btuxQpu+upuBhHzwgeOGds29UDhWnQo78EoVJbI/vcSmPje8sKgp3Tz3nltXyDn4mgmWcOH8cSsL8wH2O+BXA5ctf9AyO8sF9kpdrRpgTS7jj82xmuYRYKUnKXLuj4bBLfeLGLWLNcgCWoHVIQCGF0/LGkUfqUP0GEscF1IIyRnAThsHsiFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtchNQ94mGGG6czSWDESX6ynQ8/ZHk0WEBJh6mqWVoc=;
 b=mbKHFIg4E+8KidKll7W4+bQOiC+vYjobhXrubW5aagIIuP9zrUNc/kPzdcWTv04aPQ5en5SXmtkMHyheX/mntydtdBuwBJ2UgqM06tRJXM2EHFHsPmZN65xmlh0xQeqNsbveAwEf45YBWwxd1/9Aq0GuTTop4cQHfA/vtM7KINiWsi7m9NxYJbt/Qp75UgnEg/aeJ1ePmFOcYkIToNLgkHEuOeCner35xOTPc+i+et0GnB/eqvCBoXUxanFKG0udBK0pyeLuVP5uTEZN3cbpN8HgEDGRudzJ0nQtAoxyMR9uWCzyemfEipONN7HfekvfqmeMJ2C1i8W9OKlAQiGwdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtchNQ94mGGG6czSWDESX6ynQ8/ZHk0WEBJh6mqWVoc=;
 b=N3u8fvBOqDW7/dpMlt/tgI8xIuBsbh/zDf2QpD5bVDSrOH5oc/CyQTZSVK40FNeFIea1Hu1fu2zCbqv4HB3P1HN5PKferqVCFA8OfQa93xIytXIbZjxEq50AS4TJgOolZGqtLGbYPajbHTWE6yOvh55LINedK2mfPvZDL9lnJW/2MkAEut7xI9CpOuhASSSFn9KvVUVzQnL+yQN/Yc/SuBe9MPyf39/qsS0U591urO7vVJ4I+n0jVir3Pi+cKKwWA3IaMqZCGqKMOW5vXG2mbH57nTaFhxYCJ4HDXqTh2TXpynZyOPTnfm5utyA5v9dwIbYvXlxxExaIs9LgrJt+AA==
Received: from SJ0PR05CA0122.namprd05.prod.outlook.com (2603:10b6:a03:33d::7)
 by CY1PR12MB9652.namprd12.prod.outlook.com (2603:10b6:930:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 21:03:33 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::b5) by SJ0PR05CA0122.outlook.office365.com
 (2603:10b6:a03:33d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.5 via Frontend Transport; Thu,
 16 Oct 2025 21:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 21:03:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 16 Oct
 2025 14:02:57 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 16 Oct 2025 14:02:57 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 16 Oct 2025 14:02:57 -0700
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
Subject: [PATCH v2 0/5] rust: pci: add config space read/write support, take 1
Date: Thu, 16 Oct 2025 21:02:45 +0000
Message-ID: <20251016210250.15932-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|CY1PR12MB9652:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e995f19-8d08-4e53-f724-08de0cf77756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+JNsB8vDlZfojxKrKMh9mRI/vRncTCdwOdD+dmY1mDoIcIb5okeUKR/CXcIH?=
 =?us-ascii?Q?VrLGIwjGHllHjbwf1qmfa5RH5hJDFhNQa8d9ouxzEw/NpkiCXvEFALZ1mvzP?=
 =?us-ascii?Q?qVLq16gd4Lo2CzTM/mJ91lVtlBIMDEwUXeCRabjM3iTEW5XP4tORFPicl4p/?=
 =?us-ascii?Q?RBqEgnD9/rjkwBgUdKcUkUTYfd2OlV6tl+CjB2y83Haft+FznLq3YECrEQcV?=
 =?us-ascii?Q?Ews4kPMCwjCsPaHlWiRrQrLZWYQP3JwoeFIHPvou83oU7+zcbhmV5rVyshx/?=
 =?us-ascii?Q?LVc9fjrkzBIzzy13EJj/MgJcWJdPZ0SS+8qnk3D46UmAKo/ki4BcJDmeZnh/?=
 =?us-ascii?Q?OQNdOQWhEZMXr1W18H/N5UL3Lxlgwa78D0N81tPqdCFLT+PkyHbFycreum0F?=
 =?us-ascii?Q?rtQg/DnYkTrJfX1drG61oDIKtBzXauSA9J57oI5u6EYcTW/T3uj5IaD2RdG0?=
 =?us-ascii?Q?u4iCdcWt6QMStUtrx7AsTmvC51B1ioy2OE6Q5lubd36g/MdPn5wtC2OfxHiY?=
 =?us-ascii?Q?Kuw1jBiPkLJo/KtcHP7RYkrAaSA714OH4UlyGaZsEkM562sWnIqVv7tI5rAU?=
 =?us-ascii?Q?rMScn+jmdZJ1bAygJuDxIYkvhnZe2wo2121t5eR3eTMgkwQfntih4WUJNWqq?=
 =?us-ascii?Q?b8fU+Dj8DzmNbtA5CtDCcwYVkER2rramJryoIqAR3iZeMhPNdukQvnCl8U1W?=
 =?us-ascii?Q?KQpRuwQBaho2DEPdu6CicnU3RpwHyWvtQhyAMEm/kklQPtMx7C+kMPKAOTXF?=
 =?us-ascii?Q?OTj66q/37LSwmFsM/tQstSumcw8O/8OiVtQfDFaVEOZmMvkb9oavUmviVMZN?=
 =?us-ascii?Q?wQrZLMCsRYW96pvSVpNmXNtksUnproDZDHa+Z4WMwMCTVP9oXpusN5OawFAz?=
 =?us-ascii?Q?MnHL9azjIBVfSY2xewxd2wrBXkjz3S1Hg8HSCqS7ezIFV49pWo5NkbyVOyo6?=
 =?us-ascii?Q?/FvhptUy4yaQwx7TH/xXz/BOIxzmT/WQcYWne+xpehHzzbcENs3F5qiDBqNs?=
 =?us-ascii?Q?vLF40fmSd7DIXDVA6sIp7/xqzrXgWszkjHJB4zNVkumibZfVWQj9onntDjYF?=
 =?us-ascii?Q?acKHWptpZlpPg1wvFdmbI1jkwcBPdYZWinBSdaXV6R79I6QXLDvDdoXp19Lv?=
 =?us-ascii?Q?LPJUdqDBgBlpNW42IA6CkKi9zOAqo6a3IiV/FotW+n5Rab3DR06CbTYVUH5v?=
 =?us-ascii?Q?PpR7Aw1nsqCeSztsxhYk6Yih4uixOSvyGVQAyztyEvE9+vetBkZ6M7wPFXU1?=
 =?us-ascii?Q?QeyeargSciYQ3AbRJzErWI2OcdCRFrz5vodM4dpAZyxWqnovcb3c/1QpiDMJ?=
 =?us-ascii?Q?S0pislHk9PJNNruIUyITH8cvfNLaRW56UHKDQvZEaokHKvdIMojNPJtWf+wi?=
 =?us-ascii?Q?CF6s9Lm2dSslu6QrzoUWRf/AirXvdVm2pmOsI3Us3Y7RtJw7xVvX62Ut8sda?=
 =?us-ascii?Q?Xnus7trVRNdVn3DkkNnmURqGKAjiFSAaP1eXReU7ExB0NgNdFNLNvrYeyqo0?=
 =?us-ascii?Q?RUHqLWDcLluEZbnpOBkCrnTSu1PWmmOKmtmLl3lLAG90iLUSLosX/wM2v0V4?=
 =?us-ascii?Q?XDeVmunxpAd7sqrcusw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 21:03:33.0838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e995f19-8d08-4e53-f724-08de0cf77756
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9652

In the NVIDIA vGPU RFC [1], the PCI configuration space access is
required in nova-core for preparing gspVFInfo when vGPU support is
enabled. This series is the following up of the discussion with Danilo
for how to introduce support of PCI configuration space access in Rust
PCI abstrations. Bascially, we are thinking of introducing another
backend for PCI configuration space access similar with Kernel::Io.

This ideas of this series are:

- Factor out a common trait 'Io' for other accessors to share the
  same compiling/runtime check like before.

- Factor the MMIO read/write macros from the define_read! and
  define_write! macros. Thus, define_{read, write}! can be used in other
  backend.

- Add a helper to query configuration space size. This is mostly for
  runtime check.

- Implement the PCI configuration space access backend in PCI
  abstractions.

v2:

- Factor out common trait as 'Io' and keep the rest routines in original
  'Io' as 'Mmio'. (Danilo)

- Rename 'IoRaw' to 'MmioRaw'. Update the bus MMIO implemention to use
  'MmioRaw'.

- Intorduce pci::Device<Bound>::config_space(). (Danilo)

- Implement both infallible and fallible read/write routines, the device
  driver devicdes which version should be used.

Moving forward:

- Define and use register! macros.
- Introduce { cap, ecap } search and read.

RFC v1:
https://lore.kernel.org/all/20251010080330.183559-1-zhiw@nvidia.com/

[1] https://lore.kernel.org/all/20250903221111.3866249-1-zhiw@nvidia.com/

Zhi Wang (5):
  rust/io: factor common I/O helpers into Io trait and specialize
    Mmio<SIZE>
  rust: io: factor out MMIO read/write macros
  rust: pci: add a helper to query configuration space size
  rust: pci: add config space read/write support
  nova-core: test configuration routine.

 drivers/gpu/nova-core/driver.rs      |   4 +
 drivers/gpu/nova-core/regs/macros.rs |  36 +++---
 rust/kernel/io.rs                    | 161 +++++++++++++++++----------
 rust/kernel/io/mem.rs                |  16 +--
 rust/kernel/pci.rs                   |  79 ++++++++++++-
 5 files changed, 206 insertions(+), 90 deletions(-)

-- 
2.47.3


