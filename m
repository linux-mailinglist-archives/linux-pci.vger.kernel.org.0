Return-Path: <linux-pci+bounces-34335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD054B2D257
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 05:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6501C4252D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 03:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443F727E041;
	Wed, 20 Aug 2025 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GXW6f9aQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9103B259C93;
	Wed, 20 Aug 2025 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659360; cv=fail; b=bAOcaF41DPVSg43mW24Izv1DtTm1IC4G4rZ1/MDTNNvAXk3pGmsBzWvB+gJkUZk53wohnXZzbB1F7vf6W+f5aCnLbI0LH6kKjL7QgkEZLOAtPOrT8JUO5orEW9DAo7SlaHNnY1XR85+2BAVckmXuJLq4PVwRkc1vHf9oFCSbfDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659360; c=relaxed/simple;
	bh=nI+65Im06KwXhUPqoWq3Y19iCYS+FEf0SBpiGET+Cfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c6g0lRnISbxFc2VcjFTYdzk3XIM1ESUTGlkkyShh5utgE8Vko/hrRd/Jw7vcBDFknnsMqDNnxI7CMD9y22eAbZMmutOug6cZ5J/ZLm0Ir6/oZ239QRzHpIawgppgG57q7BiNzdN1gGz5la06DeKf2r9LQUaY3UVxD/OetLq+ujo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GXW6f9aQ; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aF8CXsjytj7myfDDBD70LUqiH7RhMZZfwU2vGreXPHv7EDUEECwGPt1ZOx2aw/nJ8PcS2zmlbM2KBn4fJiSxMOpmdguVRQ7Gbp/cOU1NWoWEk+5HxIaipaK1JPhzVw5bJ+BLXTD4uw1Xocp0mwErDDRIvrcW45pk9R9yAugj9Iq5ZYLczANL7a9mSOFr/tmyGX6WC0bZMMSACkNjH5zieHWcbzu8/X8qb6fOSUVbmazGHhpURazjafQj3/qbeQAnQCkJCdRrQt33IgXJHtipZmuVeBn5WryPwNjJUfXIqjGqlpbu7sqVubYQ7z5OKrugWkgvoAfTCqi3oUqdhRsJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7Y2mJFukoAymxoPpBWlrP0urV7/PGyomNTigIUz/lE=;
 b=I/cgBT7dgFif4zT0GC9f9bpgOdVbO+Af8tV/WYRKLQZVqu3qGuwPd6nSxQVW7WuE6koaat89Paf5/jBAMZyHdLpoHe5U0Fo6ovI8SyUC/o+MSU6bs0DpILw0Pqids7JWYT086B/XmACFUWrhHmurpiIVdkjHm9iGWAECQ7aryFW3WeknqQa4au2RUQppxVA3D24VVzxQVGoXTI+eAMzh6QM7qBwOwSuIpIo0rN1QWDTMAlMHG8Tuzu/lPAtFYcqmtug6ttatCvMuyKzDaUujyVJhVqoHnIT1+Toq/zh+z7L7RXx50HcCg2x2FyTz1Ch0QBmvUdqGuKRbIFTnrkwkxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7Y2mJFukoAymxoPpBWlrP0urV7/PGyomNTigIUz/lE=;
 b=GXW6f9aQ5F3jEshNRWaa2SJbVd8snw7iti59Vtw2CT/5bfM3aFfZTI5zE3homU3kqvqnPmdHFXZ5rlG9pBnk3Zv63AXEghGWxlxkU5IQMbRZs8ft8OamsooMEMraddxxgURrEXV4uv+Crm7Qq1XvqfRseyG9ctGSt5wawQXU3ygmEwoo18EstAY7Y6e5ml8QHgS+srr+r2ZYdGWZYYTtHJzm/BlhcEruObEykrC5txPkE5jF1C5MDEmjUAiJSVp8LrRWKzEj8gHo7mhM45aGIb2dnVgVwWf2DW2gpMapjne3QK0r1ohBEgqAKIxMwGPO4LzNkIAyESj8RBusWGgrGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 20 Aug
 2025 03:09:07 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 03:09:07 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 3/3] rust: pci: provide access to PCI Vendor values
Date: Tue, 19 Aug 2025 20:08:59 -0700
Message-ID: <20250820030859.6446-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820030859.6446-1-jhubbard@nvidia.com>
References: <20250820030859.6446-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::32) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 23790386-8496-49af-33c1-08dddf96ed3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BvnKRODH5P2w1+VaH7zROH4umry1UYM3OHaVaOKX6Cbl9P1W6rlmP8eVBtua?=
 =?us-ascii?Q?2qEAr9NJJQGzA/e2h1o49KK9Ap665wjMbm2eBiUPul4Ro4dD+ChCYfqjYZeH?=
 =?us-ascii?Q?X3Wg2vIal03xMLJP5YPPGKvSWDbzH9OBht67HdmmsL5Gj7LKuuCB6/UAVwHe?=
 =?us-ascii?Q?dkrDNwe7XP0AarvF89ElOBUnQwlA05HTU/t0xz6FgSG6TSTlmj9R46XwaKu9?=
 =?us-ascii?Q?frBMq5HRznPthMJ5NA39Yx3EhCvx8S0AIy/XRtg/TbWdSzAPl4QD+EafTp7K?=
 =?us-ascii?Q?apfYbFopJm+4RS3sUojRp86TtE/AyUTuhP2dO+wzq6SEW/g0KLzdoY16WPuX?=
 =?us-ascii?Q?YCtw5td1MKRHcann8Y69N01wZsWl+kbym4k/IUMeytCx2YmqnsKLFfhtWsR7?=
 =?us-ascii?Q?13lDRMfFBZrxE7Q4BGfs/T0t3K+qRn8y1DTvpnc0yP9bW/HTgw559BvVxH2p?=
 =?us-ascii?Q?Lt4NjJqvIjxuXklgxFTZoEEbSaNl38LhuvPflwxcnCDKZ+Vwpm53LlrEDd7u?=
 =?us-ascii?Q?dXoUr2upTm/+yISbVMzI3piCOO7SpSvG25Jcla0CG3eCXGZKAD7Hz+7EJWF3?=
 =?us-ascii?Q?i9S3ZpkxcLNErYNwpDD6h6Scd3d/BDXsmQA3NgZghWWmz/X9NlE18wu2l2YZ?=
 =?us-ascii?Q?llmsnEeMY+5abI4JzyYVZySSSNwiAoy9NZPYEioEZvDmDjcO5mTdu7II8hga?=
 =?us-ascii?Q?UAqYB8Zq78Ny8SPAj/DaBzINgjrucLO+wFKgyqrpab7bA2VPeb8dnC//nIbH?=
 =?us-ascii?Q?nfidxJs/YwtY8rr/cCZV9VA8j7k+cFkr21CPcMih9gnBZhmmpq4dBEuroDtU?=
 =?us-ascii?Q?vzHL6jgZ0faqr/5MmlfLhcecJgol7uYzfN+WLZXq20npov04ymurK9TxfcHD?=
 =?us-ascii?Q?79K5bqWXv0qndt45uyA+RjegelphJCjktM2E/h5rxpt3E828p67PpnvPAbAw?=
 =?us-ascii?Q?9TjUIKQAUs0W7F08zJubfRakn70nLUFsjSlAR9ZNLEmrjN0bi+dNkyosUgJU?=
 =?us-ascii?Q?jWNs+yLDNB1QxVDl7VLVgTfP/iyir4KxMoykzZxGSoULZ/pKg65usLEZUR/O?=
 =?us-ascii?Q?6JrlTrh6s3DeZjngWibUwSra/JtV3e5pmg5IhjgGZIz4to5DR12tjxO/N6vo?=
 =?us-ascii?Q?CLLBWKHcxk3Pf70aQ88PPVm4nzhDx1f4UJ3ul6ctv7LZC3EXWYcjHemqg3Rk?=
 =?us-ascii?Q?d25Ux7WqvK0LYpaZbpE6ya3q1zRZWnKxaISJcHwHT3flabwqCnbf5J0g/i3c?=
 =?us-ascii?Q?B/JB1VEh4JrdLkGWg+Pz5O4dL0G3FerVb8uB8ltVCBjHvZFVSQsIZCLua0mT?=
 =?us-ascii?Q?YcVgcOnJkTUBHMtWkSwLwg9VYeMpvOWrO7BB3r/KGRO9xGSzzwgY1F5SB957?=
 =?us-ascii?Q?NQKSjyWNMIbXAoDuwWlhjURAgSsq1IpCygTYeHm9HAkhoMIb1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HVOibFKwboHCbggV2hs6KwGdkb8zRlkmDkeOn9tLIC9C75w/f8J3hqXdMrLV?=
 =?us-ascii?Q?Oe1Q+isZJ90SprqS/EMAVitePP34dxs+xI6vsTEGTTnxMR3V/eR3SF0VcRHq?=
 =?us-ascii?Q?iZd7pRUenWeL7f1fQIbTDz7HjOqk/K6XsMjmiPKDbE9bQ/SWV0Z2y1KU8AKp?=
 =?us-ascii?Q?L5WVLVTzXXfhrINBypX/euIsaYFnVoTn9/G/E0GSrNlUdLjrWTvrmGROFpzp?=
 =?us-ascii?Q?AnDWoh8pISQZl5f7wy/ybKrxvz/wlgnpI93728o1CsbIMfHFONA+YyoqY/6c?=
 =?us-ascii?Q?Mxnap7Lc2ir4kedj0S3d2w2mnAwDUwcDkq16flbk/OY1UeFLGnhQuuMgCSx8?=
 =?us-ascii?Q?WsVsKsnX/EWS74WesTMQu91WtC2tnlFUNIdHnhCmYqh6HQwpH8nqnYdhdEEL?=
 =?us-ascii?Q?u9EPjk8dxvq5rM85Pj6UvHybrAD2rH2VsNQyuOI7RUj+pWTalgK+Dbh6egCM?=
 =?us-ascii?Q?TI/LJvP6B+3g6BiTAAt0bniHrh049zbTO25HovRgC0Fv+bGAu677F4EYQ8Gp?=
 =?us-ascii?Q?83GY41LO+qTfO+/4CUQ5ztPJRkf+YR0M41foTObOP0r9JlRSk8Nr5nipX/s8?=
 =?us-ascii?Q?dyhTQDJcROuQWrVzMunt4hq/eGT+ch3P/p3ZRLdpntoja/VqyoZRXf2SzJOb?=
 =?us-ascii?Q?Ld3PaDdg16W7nWD0C0s/w23S60mbBm6syxBqI89Wn5mX93cY7Z+Sh+GGhB7c?=
 =?us-ascii?Q?+S1KkYFHK3n+2+0/gLoKvmKASbP+hc1fX6U3hsskAysKXaQprxLpa3zsyyqo?=
 =?us-ascii?Q?tsj1Qbm7rRJ75O04X+8XpYLAoaD3G87pObmRF5qaFkkop2O1ZC/mW6dwuiSM?=
 =?us-ascii?Q?7/77IupQi64i/yfG7qW18qGc3T86DPnRqBXY7UtEC4wlCKSlJzeR4ZpaE4Be?=
 =?us-ascii?Q?0xJPK/bhTUZh0FTNbWTIKsypulCeixiSBYAK3TpleGUq4m3Vmipy3XLbr/Vb?=
 =?us-ascii?Q?xhnKU9D+u2wCK2AESmEFxix4ZKytldPvyLw9LXD0A1Fq4I5ew6haOm3bWwz2?=
 =?us-ascii?Q?h7IjLlDBOcZLqf32Tysb1k1fyhUtkT88OCXPByuxFs7Nps98ObBe6RiX7EJ6?=
 =?us-ascii?Q?3qgvDVqrrxVzwEwZosozjSEkw0r/ss5QE3YYEb0xZsOUQM2WOkc+UlQCTdy+?=
 =?us-ascii?Q?9EcIL5SM47mjez5VqpfA6SsN601hngMQ2p/H9kE0NpPERW7vm7IbovuXFAl+?=
 =?us-ascii?Q?nzlRGmifQ0WinqCdlnYWuwGhd+DeXUyR7rLuZsGTjijTfTiWiplDiMe7puo/?=
 =?us-ascii?Q?2BsaJsNO9n/jRUjpFY7rfe0O+fnEYWYAiRoFkgsJympSA0ZW42h41Mg1lejy?=
 =?us-ascii?Q?OHQ13S0phJWQmKh8eQcc5HG4uXIvCrQNjdEhZB7BvB8fEC1wU1S6s9qKFSNa?=
 =?us-ascii?Q?zFNDMERX8pfEoiKF8/RiZuz3ISXhTRKvDV4oaolAkucoY3NhhUGmDHsBIlZ1?=
 =?us-ascii?Q?4OWIViC3Tw6d9BIgivfcxu68yCocOjxbZuuOK5TFXuTxkL6hRCT4o2enlCS5?=
 =?us-ascii?Q?mdm/m5+Ms8u8pyQtvELJw5sHGzI6Mpk86a/+hOU3YgY/dPTCuGV5+ft3RJ5E?=
 =?us-ascii?Q?dohRhfvCKci3YMv10XQpBKgYy0c+tmLeJSaqfrlm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23790386-8496-49af-33c1-08dddf96ed3e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 03:09:07.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgU4EZMXC/fuXDhe6BJJrnR1qgcmVRi8LKi/17OJuvCAmMvv68KIPsFMm2s1XttGNYLGHeDsty/xi+ShXl/M7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174

This allows callers to write Vendor::SOME_COMPANY instead of
bindings::PCI_VENDOR_ID_SOME_COMPANY.

It also allows removing "use kernel::bindings" entirely from most of
the affected files here.

Apply this to the various Rust for Linux callers who were previously
using bindings::PCI_VENDOR_ID_*.

New APIs:
    Vendor::SOME_COMPANY
    Vendor::as_raw()
    Vendor: TryFrom<u32> for Vendor
    DeviceId::from_class_and_vendor() now takes Vendor type

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs       |  13 +-
 rust/kernel/pci.rs                    |  26 +-
 rust/kernel/pci/id.rs                 | 357 +++++++++++++++++++++++++-
 samples/rust/rust_dma.rs              |   6 +-
 samples/rust/rust_driver_auxiliary.rs |  12 +-
 samples/rust/rust_driver_pci.rs       |   9 +-
 6 files changed, 392 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index b60c9defa9d1..5d23a91f51dd 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,8 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use kernel::{
-    auxiliary, bindings, c_str, device::Core, pci, pci::Class, pci::ClassMask, prelude::*,
-    sizes::SZ_16M, sync::Arc,
+    auxiliary, c_str,
+    device::Core,
+    pci,
+    pci::{Class, ClassMask, Vendor},
+    prelude::*,
+    sizes::SZ_16M,
+    sync::Arc,
 };
 
 use crate::gpu::Gpu;
@@ -27,7 +32,7 @@ pub(crate) struct NovaCore {
             pci::DeviceId::from_class_and_vendor(
                 Class::DISPLAY_VGA,
                 ClassMask::ClassSubclass,
-                bindings::PCI_VENDOR_ID_NVIDIA
+                Vendor::NVIDIA
             ),
             ()
         ),
@@ -35,7 +40,7 @@ pub(crate) struct NovaCore {
             pci::DeviceId::from_class_and_vendor(
                 Class::DISPLAY_3D,
                 ClassMask::ClassSubclass,
-                bindings::PCI_VENDOR_ID_NVIDIA
+                Vendor::NVIDIA
             ),
             ()
         ),
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index ee887d616320..c677e7f2c4c9 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -25,7 +25,7 @@
 
 mod id;
 
-pub use self::id::{Class, ClassMask};
+pub use self::id::{Class, ClassMask, Vendor};
 
 /// An adapter for the registration of PCI drivers.
 pub struct Adapter<T: Driver>(T);
@@ -132,10 +132,10 @@ impl DeviceId {
 
     /// Equivalent to C's `PCI_DEVICE` macro.
     ///
-    /// Create a new `pci::DeviceId` from a vendor and device ID number.
-    pub const fn from_id(vendor: u32, device: u32) -> Self {
+    /// Create a new `pci::DeviceId` from a vendor and device ID.
+    pub const fn from_id(vendor: Vendor, device: u32) -> Self {
         Self(bindings::pci_device_id {
-            vendor,
+            vendor: vendor.as_raw(),
             device,
             subvendor: DeviceId::PCI_ANY_ID,
             subdevice: DeviceId::PCI_ANY_ID,
@@ -166,9 +166,13 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
     ///
     /// This is more targeted than [`DeviceId::from_class`]: in addition to matching by Vendor, it
     /// also matches the PCI Class (up to the entire 24 bits, depending on the mask).
-    pub const fn from_class_and_vendor(class: Class, class_mask: ClassMask, vendor: u32) -> Self {
+    pub const fn from_class_and_vendor(
+        class: Class,
+        class_mask: ClassMask,
+        vendor: Vendor,
+    ) -> Self {
         Self(bindings::pci_device_id {
-            vendor,
+            vendor: vendor.as_raw(),
             device: DeviceId::PCI_ANY_ID,
             subvendor: DeviceId::PCI_ANY_ID,
             subdevice: DeviceId::PCI_ANY_ID,
@@ -227,7 +231,7 @@ macro_rules! pci_device_table {
 ///     <MyDriver as pci::Driver>::IdInfo,
 ///     [
 ///         (
-///             pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, bindings::PCI_ANY_ID as u32),
+///             pci::DeviceId::from_id(pci::Vendor::REDHAT, bindings::PCI_ANY_ID as u32),
 ///             (),
 ///         )
 ///     ]
@@ -408,10 +412,12 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
 }
 
 impl Device {
-    /// Returns the PCI vendor ID.
-    pub fn vendor_id(&self) -> u16 {
+    /// Returns the PCI vendor ID as a validated Vendor.
+    /// Returns an error if the vendor ID is not recognized.
+    pub fn vendor_id(&self) -> Result<Vendor> {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
-        unsafe { (*self.as_raw()).vendor }
+        let vendor_id = unsafe { (*self.as_raw()).vendor };
+        Vendor::try_from(vendor_id as u32)
     }
 
     /// Returns the PCI device ID.
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index ed241af07dee..6288d1441a70 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -2,7 +2,7 @@
 
 //! PCI device identifiers and related types.
 //!
-//! This module contains PCI class codes and supporting types.
+//! This module contains PCI class codes, Vendor IDs, and supporting types.
 
 use crate::{
     bindings,
@@ -124,6 +124,77 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
     }
 }
 
+/// PCI vendor IDs.
+///
+/// Each entry contains the 16-bit PCI vendor ID as assigned by the PCI SIG.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::{device::Core, pci::{self, Vendor}, prelude::*};
+/// fn log_device_info(pdev: &pci::Device<Core>) -> Result<()> {
+///     // Get the validated PCI vendor ID
+///     let vendor = pdev.vendor_id()?;
+///     dev_info!(
+///         pdev.as_ref(),
+///         "Device: Vendor={}, Device=0x{:x}\n",
+///         vendor,
+///         pdev.device_id()
+///     );
+///     Ok(())
+/// }
+/// ```
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+#[repr(transparent)]
+pub struct Vendor(u32);
+
+macro_rules! define_all_pci_vendors {
+    (
+        $($variant:ident = $binding:expr,)+
+    ) => {
+
+        impl Vendor {
+            $(
+                #[allow(missing_docs)]
+                pub const $variant: Self = Self($binding as u32);
+            )+
+        }
+
+        /// Try to convert a raw 16-bit vendor ID to a `Vendor`.
+        /// Returns `ENODEV` if the value doesn't match any known vendor.
+        impl TryFrom<u32> for Vendor {
+            type Error = Error;
+
+            fn try_from(value: u32) -> Result<Self, Self::Error> {
+                match value {
+                    $(x if x == Self::$variant.0 => Ok(Self::$variant),)+
+                    _ => Err(ENODEV),
+                }
+            }
+        }
+    };
+}
+
+/// Once constructed, a `Vendor` contains a valid PCI Vendor ID.
+impl Vendor {
+    /// Create a new Vendor from a raw 16-bit vendor ID.
+    /// Returns an error if the vendor ID is not recognized.
+    pub fn new(vendor_id: u32) -> Result<Self> {
+        Self::try_from(vendor_id)
+    }
+
+    /// Get the raw 16-bit vendor ID value.
+    pub const fn as_raw(self) -> u32 {
+        self.0
+    }
+}
+
+impl fmt::Display for Vendor {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        write!(f, "0x{:04x}", self.0)
+    }
+}
+
 define_all_pci_classes! {
     NOT_DEFINED                = bindings::PCI_CLASS_NOT_DEFINED,                // 0x000000
     NOT_DEFINED_VGA            = bindings::PCI_CLASS_NOT_DEFINED_VGA,            // 0x000100
@@ -245,3 +316,287 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
 
     OTHERS                     = bindings::PCI_CLASS_OTHERS,                     // 0xff0000
 }
+
+define_all_pci_vendors! {
+    PCI_SIG                  = bindings::PCI_VENDOR_ID_PCI_SIG,                  // 0x0001
+    LOONGSON                 = bindings::PCI_VENDOR_ID_LOONGSON,                 // 0x0014
+    SOLIDIGM                 = bindings::PCI_VENDOR_ID_SOLIDIGM,                 // 0x025e
+    TTTECH                   = bindings::PCI_VENDOR_ID_TTTECH,                   // 0x0357
+    DYNALINK                 = bindings::PCI_VENDOR_ID_DYNALINK,                 // 0x0675
+    UBIQUITI                 = bindings::PCI_VENDOR_ID_UBIQUITI,                 // 0x0777
+    BERKOM                   = bindings::PCI_VENDOR_ID_BERKOM,                   // 0x0871
+    ITTIM                    = bindings::PCI_VENDOR_ID_ITTIM,                    // 0x0b48
+    COMPAQ                   = bindings::PCI_VENDOR_ID_COMPAQ,                   // 0x0e11
+    LSI_LOGIC                = bindings::PCI_VENDOR_ID_LSI_LOGIC,                // 0x1000
+    ATI                      = bindings::PCI_VENDOR_ID_ATI,                      // 0x1002
+    VLSI                     = bindings::PCI_VENDOR_ID_VLSI,                     // 0x1004
+    ADL                      = bindings::PCI_VENDOR_ID_ADL,                      // 0x1005
+    NS                       = bindings::PCI_VENDOR_ID_NS,                       // 0x100b
+    TSENG                    = bindings::PCI_VENDOR_ID_TSENG,                    // 0x100c
+    WEITEK                   = bindings::PCI_VENDOR_ID_WEITEK,                   // 0x100e
+    DEC                      = bindings::PCI_VENDOR_ID_DEC,                      // 0x1011
+    CIRRUS                   = bindings::PCI_VENDOR_ID_CIRRUS,                   // 0x1013
+    IBM                      = bindings::PCI_VENDOR_ID_IBM,                      // 0x1014
+    UNISYS                   = bindings::PCI_VENDOR_ID_UNISYS,                   // 0x1018
+    COMPEX2                  = bindings::PCI_VENDOR_ID_COMPEX2,                  // 0x101a
+    WD                       = bindings::PCI_VENDOR_ID_WD,                       // 0x101c
+    AMI                      = bindings::PCI_VENDOR_ID_AMI,                      // 0x101e
+    AMD                      = bindings::PCI_VENDOR_ID_AMD,                      // 0x1022
+    TRIDENT                  = bindings::PCI_VENDOR_ID_TRIDENT,                  // 0x1023
+    AI                       = bindings::PCI_VENDOR_ID_AI,                       // 0x1025
+    DELL                     = bindings::PCI_VENDOR_ID_DELL,                     // 0x1028
+    MATROX                   = bindings::PCI_VENDOR_ID_MATROX,                   // 0x102B
+    MOBILITY_ELECTRONICS     = bindings::PCI_VENDOR_ID_MOBILITY_ELECTRONICS,     // 0x14f2
+    CT                       = bindings::PCI_VENDOR_ID_CT,                       // 0x102c
+    MIRO                     = bindings::PCI_VENDOR_ID_MIRO,                     // 0x1031
+    NEC                      = bindings::PCI_VENDOR_ID_NEC,                      // 0x1033
+    FD                       = bindings::PCI_VENDOR_ID_FD,                       // 0x1036
+    SI                       = bindings::PCI_VENDOR_ID_SI,                       // 0x1039
+    HP                       = bindings::PCI_VENDOR_ID_HP,                       // 0x103c
+    HP_3PAR                  = bindings::PCI_VENDOR_ID_HP_3PAR,                  // 0x1590
+    PCTECH                   = bindings::PCI_VENDOR_ID_PCTECH,                   // 0x1042
+    ASUSTEK                  = bindings::PCI_VENDOR_ID_ASUSTEK,                  // 0x1043
+    DPT                      = bindings::PCI_VENDOR_ID_DPT,                      // 0x1044
+    OPTI                     = bindings::PCI_VENDOR_ID_OPTI,                     // 0x1045
+    ELSA                     = bindings::PCI_VENDOR_ID_ELSA,                     // 0x1048
+    STMICRO                  = bindings::PCI_VENDOR_ID_STMICRO,                  // 0x104A
+    BUSLOGIC                 = bindings::PCI_VENDOR_ID_BUSLOGIC,                 // 0x104B
+    TI                       = bindings::PCI_VENDOR_ID_TI,                       // 0x104c
+    SONY                     = bindings::PCI_VENDOR_ID_SONY,                     // 0x104d
+    WINBOND2                 = bindings::PCI_VENDOR_ID_WINBOND2,                 // 0x1050
+    ANIGMA                   = bindings::PCI_VENDOR_ID_ANIGMA,                   // 0x1051
+    EFAR                     = bindings::PCI_VENDOR_ID_EFAR,                     // 0x1055
+    MOTOROLA                 = bindings::PCI_VENDOR_ID_MOTOROLA,                 // 0x1057
+    PROMISE                  = bindings::PCI_VENDOR_ID_PROMISE,                  // 0x105a
+    FOXCONN                  = bindings::PCI_VENDOR_ID_FOXCONN,                  // 0x105b
+    UMC                      = bindings::PCI_VENDOR_ID_UMC,                      // 0x1060
+    PICOPOWER                = bindings::PCI_VENDOR_ID_PICOPOWER,                // 0x1066
+    MYLEX                    = bindings::PCI_VENDOR_ID_MYLEX,                    // 0x1069
+    APPLE                    = bindings::PCI_VENDOR_ID_APPLE,                    // 0x106b
+    YAMAHA                   = bindings::PCI_VENDOR_ID_YAMAHA,                   // 0x1073
+    QLOGIC                   = bindings::PCI_VENDOR_ID_QLOGIC,                   // 0x1077
+    CYRIX                    = bindings::PCI_VENDOR_ID_CYRIX,                    // 0x1078
+    CONTAQ                   = bindings::PCI_VENDOR_ID_CONTAQ,                   // 0x1080
+    OLICOM                   = bindings::PCI_VENDOR_ID_OLICOM,                   // 0x108d
+    SUN                      = bindings::PCI_VENDOR_ID_SUN,                      // 0x108e
+    NI                       = bindings::PCI_VENDOR_ID_NI,                       // 0x1093
+    CMD                      = bindings::PCI_VENDOR_ID_CMD,                      // 0x1095
+    BROOKTREE                = bindings::PCI_VENDOR_ID_BROOKTREE,                // 0x109e
+    SGI                      = bindings::PCI_VENDOR_ID_SGI,                      // 0x10a9
+    WINBOND                  = bindings::PCI_VENDOR_ID_WINBOND,                  // 0x10ad
+    PLX                      = bindings::PCI_VENDOR_ID_PLX,                      // 0x10b5
+    MADGE                    = bindings::PCI_VENDOR_ID_MADGE,                    // 0x10b6
+    THREECOM                 = bindings::PCI_VENDOR_ID_3COM,                     // 0x10b7
+    AL                       = bindings::PCI_VENDOR_ID_AL,                       // 0x10b9
+    NEOMAGIC                 = bindings::PCI_VENDOR_ID_NEOMAGIC,                 // 0x10c8
+    TCONRAD                  = bindings::PCI_VENDOR_ID_TCONRAD,                  // 0x10da
+    ROHM                     = bindings::PCI_VENDOR_ID_ROHM,                     // 0x10db
+    NVIDIA                   = bindings::PCI_VENDOR_ID_NVIDIA,                   // 0x10de
+    IMS                      = bindings::PCI_VENDOR_ID_IMS,                      // 0x10e0
+    AMCC                     = bindings::PCI_VENDOR_ID_AMCC,                     // 0x10e8
+    AMPERE                   = bindings::PCI_VENDOR_ID_AMPERE,                   // 0x1def
+    INTERG                   = bindings::PCI_VENDOR_ID_INTERG,                   // 0x10ea
+    REALTEK                  = bindings::PCI_VENDOR_ID_REALTEK,                  // 0x10ec
+    XILINX                   = bindings::PCI_VENDOR_ID_XILINX,                   // 0x10ee
+    INIT                     = bindings::PCI_VENDOR_ID_INIT,                     // 0x1101
+    CREATIVE                 = bindings::PCI_VENDOR_ID_CREATIVE,                 // 0x1102
+    TTI                      = bindings::PCI_VENDOR_ID_TTI,                      // 0x1103
+    SIGMA                    = bindings::PCI_VENDOR_ID_SIGMA,                    // 0x1105
+    VIA                      = bindings::PCI_VENDOR_ID_VIA,                      // 0x1106
+    SIEMENS                  = bindings::PCI_VENDOR_ID_SIEMENS,                  // 0x110A
+    VORTEX                   = bindings::PCI_VENDOR_ID_VORTEX,                   // 0x1119
+    EF                       = bindings::PCI_VENDOR_ID_EF,                       // 0x111a
+    IDT                      = bindings::PCI_VENDOR_ID_IDT,                      // 0x111d
+    FORE                     = bindings::PCI_VENDOR_ID_FORE,                     // 0x1127
+    PHILIPS                  = bindings::PCI_VENDOR_ID_PHILIPS,                  // 0x1131
+    EICON                    = bindings::PCI_VENDOR_ID_EICON,                    // 0x1133
+    CISCO                    = bindings::PCI_VENDOR_ID_CISCO,                    // 0x1137
+    ZIATECH                  = bindings::PCI_VENDOR_ID_ZIATECH,                  // 0x1138
+    SYSKONNECT               = bindings::PCI_VENDOR_ID_SYSKONNECT,               // 0x1148
+    DIGI                     = bindings::PCI_VENDOR_ID_DIGI,                     // 0x114f
+    XIRCOM                   = bindings::PCI_VENDOR_ID_XIRCOM,                   // 0x115d
+    SERVERWORKS              = bindings::PCI_VENDOR_ID_SERVERWORKS,              // 0x1166
+    ALTERA                   = bindings::PCI_VENDOR_ID_ALTERA,                   // 0x1172
+    SBE                      = bindings::PCI_VENDOR_ID_SBE,                      // 0x1176
+    TOSHIBA                  = bindings::PCI_VENDOR_ID_TOSHIBA,                  // 0x1179
+    TOSHIBA_2                = bindings::PCI_VENDOR_ID_TOSHIBA_2,                // 0x102f
+    ATTO                     = bindings::PCI_VENDOR_ID_ATTO,                     // 0x117c
+    RICOH                    = bindings::PCI_VENDOR_ID_RICOH,                    // 0x1180
+    DLINK                    = bindings::PCI_VENDOR_ID_DLINK,                    // 0x1186
+    ARTOP                    = bindings::PCI_VENDOR_ID_ARTOP,                    // 0x1191
+    ZEITNET                  = bindings::PCI_VENDOR_ID_ZEITNET,                  // 0x1193
+    FUJITSU_ME               = bindings::PCI_VENDOR_ID_FUJITSU_ME,               // 0x119e
+    MARVELL                  = bindings::PCI_VENDOR_ID_MARVELL,                  // 0x11ab
+    MARVELL_EXT              = bindings::PCI_VENDOR_ID_MARVELL_EXT,              // 0x1b4b
+    V3                       = bindings::PCI_VENDOR_ID_V3,                       // 0x11b0
+    ATT                      = bindings::PCI_VENDOR_ID_ATT,                      // 0x11c1
+    SPECIALIX                = bindings::PCI_VENDOR_ID_SPECIALIX,                // 0x11cb
+    ANALOG_DEVICES           = bindings::PCI_VENDOR_ID_ANALOG_DEVICES,           // 0x11d4
+    ZORAN                    = bindings::PCI_VENDOR_ID_ZORAN,                    // 0x11de
+    COMPEX                   = bindings::PCI_VENDOR_ID_COMPEX,                   // 0x11f6
+    MICROSEMI                = bindings::PCI_VENDOR_ID_MICROSEMI,                // 0x11f8
+    RP                       = bindings::PCI_VENDOR_ID_RP,                       // 0x11fe
+    CYCLADES                 = bindings::PCI_VENDOR_ID_CYCLADES,                 // 0x120e
+    ESSENTIAL                = bindings::PCI_VENDOR_ID_ESSENTIAL,                // 0x120f
+    O2                       = bindings::PCI_VENDOR_ID_O2,                       // 0x1217
+    THREEDX                  = bindings::PCI_VENDOR_ID_3DFX,                     // 0x121a
+    AVM                      = bindings::PCI_VENDOR_ID_AVM,                      // 0x1244
+    STALLION                 = bindings::PCI_VENDOR_ID_STALLION,                 // 0x124d
+    AT                       = bindings::PCI_VENDOR_ID_AT,                       // 0x1259
+    ASIX                     = bindings::PCI_VENDOR_ID_ASIX,                     // 0x125b
+    ESS                      = bindings::PCI_VENDOR_ID_ESS,                      // 0x125d
+    SATSAGEM                 = bindings::PCI_VENDOR_ID_SATSAGEM,                 // 0x1267
+    ENSONIQ                  = bindings::PCI_VENDOR_ID_ENSONIQ,                  // 0x1274
+    TRANSMETA                = bindings::PCI_VENDOR_ID_TRANSMETA,                // 0x1279
+    ROCKWELL                 = bindings::PCI_VENDOR_ID_ROCKWELL,                 // 0x127A
+    ITE                      = bindings::PCI_VENDOR_ID_ITE,                      // 0x1283
+    ALTEON                   = bindings::PCI_VENDOR_ID_ALTEON,                   // 0x12ae
+    NVIDIA_SGS               = bindings::PCI_VENDOR_ID_NVIDIA_SGS,               // 0x12d2
+    PERICOM                  = bindings::PCI_VENDOR_ID_PERICOM,                  // 0x12D8
+    AUREAL                   = bindings::PCI_VENDOR_ID_AUREAL,                   // 0x12eb
+    ELECTRONICDESIGNGMBH     = bindings::PCI_VENDOR_ID_ELECTRONICDESIGNGMBH,     // 0x12f8
+    ESDGMBH                  = bindings::PCI_VENDOR_ID_ESDGMBH,                  // 0x12fe
+    CB                       = bindings::PCI_VENDOR_ID_CB,                       // 0x1307
+    SIIG                     = bindings::PCI_VENDOR_ID_SIIG,                     // 0x131f
+    RADISYS                  = bindings::PCI_VENDOR_ID_RADISYS,                  // 0x1331
+    MICRO_MEMORY             = bindings::PCI_VENDOR_ID_MICRO_MEMORY,             // 0x1332
+    DOMEX                    = bindings::PCI_VENDOR_ID_DOMEX,                    // 0x134a
+    INTASHIELD               = bindings::PCI_VENDOR_ID_INTASHIELD,               // 0x135a
+    QUATECH                  = bindings::PCI_VENDOR_ID_QUATECH,                  // 0x135C
+    SEALEVEL                 = bindings::PCI_VENDOR_ID_SEALEVEL,                 // 0x135e
+    HYPERCOPE                = bindings::PCI_VENDOR_ID_HYPERCOPE,                // 0x1365
+    DIGIGRAM                 = bindings::PCI_VENDOR_ID_DIGIGRAM,                 // 0x1369
+    KAWASAKI                 = bindings::PCI_VENDOR_ID_KAWASAKI,                 // 0x136b
+    CNET                     = bindings::PCI_VENDOR_ID_CNET,                     // 0x1371
+    LMC                      = bindings::PCI_VENDOR_ID_LMC,                      // 0x1376
+    NETGEAR                  = bindings::PCI_VENDOR_ID_NETGEAR,                  // 0x1385
+    APPLICOM                 = bindings::PCI_VENDOR_ID_APPLICOM,                 // 0x1389
+    MOXA                     = bindings::PCI_VENDOR_ID_MOXA,                     // 0x1393
+    CCD                      = bindings::PCI_VENDOR_ID_CCD,                      // 0x1397
+    EXAR                     = bindings::PCI_VENDOR_ID_EXAR,                     // 0x13a8
+    MICROGATE                = bindings::PCI_VENDOR_ID_MICROGATE,                // 0x13c0
+    THREEWARE                = bindings::PCI_VENDOR_ID_3WARE,                    // 0x13C1
+    IOMEGA                   = bindings::PCI_VENDOR_ID_IOMEGA,                   // 0x13ca
+    ABOCOM                   = bindings::PCI_VENDOR_ID_ABOCOM,                   // 0x13D1
+    SUNDANCE                 = bindings::PCI_VENDOR_ID_SUNDANCE,                 // 0x13f0
+    CMEDIA                   = bindings::PCI_VENDOR_ID_CMEDIA,                   // 0x13f6
+    ADVANTECH                = bindings::PCI_VENDOR_ID_ADVANTECH,                // 0x13fe
+    MEILHAUS                 = bindings::PCI_VENDOR_ID_MEILHAUS,                 // 0x1402
+    LAVA                     = bindings::PCI_VENDOR_ID_LAVA,                     // 0x1407
+    TIMEDIA                  = bindings::PCI_VENDOR_ID_TIMEDIA,                  // 0x1409
+    ICE                      = bindings::PCI_VENDOR_ID_ICE,                      // 0x1412
+    MICROSOFT                = bindings::PCI_VENDOR_ID_MICROSOFT,                // 0x1414
+    OXSEMI                   = bindings::PCI_VENDOR_ID_OXSEMI,                   // 0x1415
+    CHELSIO                  = bindings::PCI_VENDOR_ID_CHELSIO,                  // 0x1425
+    EDIMAX                   = bindings::PCI_VENDOR_ID_EDIMAX,                   // 0x1432
+    ADLINK                   = bindings::PCI_VENDOR_ID_ADLINK,                   // 0x144a
+    SAMSUNG                  = bindings::PCI_VENDOR_ID_SAMSUNG,                  // 0x144d
+    GIGABYTE                 = bindings::PCI_VENDOR_ID_GIGABYTE,                 // 0x1458
+    AMBIT                    = bindings::PCI_VENDOR_ID_AMBIT,                    // 0x1468
+    MYRICOM                  = bindings::PCI_VENDOR_ID_MYRICOM,                  // 0x14c1
+    MEDIATEK                 = bindings::PCI_VENDOR_ID_MEDIATEK,                 // 0x14c3
+    TITAN                    = bindings::PCI_VENDOR_ID_TITAN,                    // 0x14D2
+    PANACOM                  = bindings::PCI_VENDOR_ID_PANACOM,                  // 0x14d4
+    SIPACKETS                = bindings::PCI_VENDOR_ID_SIPACKETS,                // 0x14d9
+    AFAVLAB                  = bindings::PCI_VENDOR_ID_AFAVLAB,                  // 0x14db
+    AMPLICON                 = bindings::PCI_VENDOR_ID_AMPLICON,                 // 0x14dc
+    BCM_GVC                  = bindings::PCI_VENDOR_ID_BCM_GVC,                  // 0x14a4
+    BROADCOM                 = bindings::PCI_VENDOR_ID_BROADCOM,                 // 0x14e4
+    TOPIC                    = bindings::PCI_VENDOR_ID_TOPIC,                    // 0x151f
+    MAINPINE                 = bindings::PCI_VENDOR_ID_MAINPINE,                 // 0x1522
+    ENE                      = bindings::PCI_VENDOR_ID_ENE,                      // 0x1524
+    SYBA                     = bindings::PCI_VENDOR_ID_SYBA,                     // 0x1592
+    MORETON                  = bindings::PCI_VENDOR_ID_MORETON,                  // 0x15aa
+    VMWARE                   = bindings::PCI_VENDOR_ID_VMWARE,                   // 0x15ad
+    ZOLTRIX                  = bindings::PCI_VENDOR_ID_ZOLTRIX,                  // 0x15b0
+    MELLANOX                 = bindings::PCI_VENDOR_ID_MELLANOX,                 // 0x15b3
+    DFI                      = bindings::PCI_VENDOR_ID_DFI,                      // 0x15bd
+    QUICKNET                 = bindings::PCI_VENDOR_ID_QUICKNET,                 // 0x15e2
+    ADDIDATA                 = bindings::PCI_VENDOR_ID_ADDIDATA,                 // 0x15B8
+    PDC                      = bindings::PCI_VENDOR_ID_PDC,                      // 0x15e9
+    FARSITE                  = bindings::PCI_VENDOR_ID_FARSITE,                  // 0x1619
+    ARIMA                    = bindings::PCI_VENDOR_ID_ARIMA,                    // 0x161f
+    BROCADE                  = bindings::PCI_VENDOR_ID_BROCADE,                  // 0x1657
+    SIBYTE                   = bindings::PCI_VENDOR_ID_SIBYTE,                   // 0x166d
+    ATHEROS                  = bindings::PCI_VENDOR_ID_ATHEROS,                  // 0x168c
+    NETCELL                  = bindings::PCI_VENDOR_ID_NETCELL,                  // 0x169c
+    CENATEK                  = bindings::PCI_VENDOR_ID_CENATEK,                  // 0x16CA
+    SYNOPSYS                 = bindings::PCI_VENDOR_ID_SYNOPSYS,                 // 0x16c3
+    USR                      = bindings::PCI_VENDOR_ID_USR,                      // 0x16ec
+    VITESSE                  = bindings::PCI_VENDOR_ID_VITESSE,                  // 0x1725
+    LINKSYS                  = bindings::PCI_VENDOR_ID_LINKSYS,                  // 0x1737
+    ALTIMA                   = bindings::PCI_VENDOR_ID_ALTIMA,                   // 0x173b
+    CAVIUM                   = bindings::PCI_VENDOR_ID_CAVIUM,                   // 0x177d
+    TECHWELL                 = bindings::PCI_VENDOR_ID_TECHWELL,                 // 0x1797
+    BELKIN                   = bindings::PCI_VENDOR_ID_BELKIN,                   // 0x1799
+    RDC                      = bindings::PCI_VENDOR_ID_RDC,                      // 0x17f3
+    GLI                      = bindings::PCI_VENDOR_ID_GLI,                      // 0x17a0
+    LENOVO                   = bindings::PCI_VENDOR_ID_LENOVO,                   // 0x17aa
+    QCOM                     = bindings::PCI_VENDOR_ID_QCOM,                     // 0x17cb
+    CDNS                     = bindings::PCI_VENDOR_ID_CDNS,                     // 0x17cd
+    ARECA                    = bindings::PCI_VENDOR_ID_ARECA,                    // 0x17d3
+    S2IO                     = bindings::PCI_VENDOR_ID_S2IO,                     // 0x17d5
+    SITECOM                  = bindings::PCI_VENDOR_ID_SITECOM,                  // 0x182d
+    TOPSPIN                  = bindings::PCI_VENDOR_ID_TOPSPIN,                  // 0x1867
+    COMMTECH                 = bindings::PCI_VENDOR_ID_COMMTECH,                 // 0x18f7
+    SILAN                    = bindings::PCI_VENDOR_ID_SILAN,                    // 0x1904
+    RENESAS                  = bindings::PCI_VENDOR_ID_RENESAS,                  // 0x1912
+    SOLARFLARE               = bindings::PCI_VENDOR_ID_SOLARFLARE,               // 0x1924
+    TDI                      = bindings::PCI_VENDOR_ID_TDI,                      // 0x192E
+    NXP                      = bindings::PCI_VENDOR_ID_NXP,                      // 0x1957
+    PASEMI                   = bindings::PCI_VENDOR_ID_PASEMI,                   // 0x1959
+    ATTANSIC                 = bindings::PCI_VENDOR_ID_ATTANSIC,                 // 0x1969
+    JMICRON                  = bindings::PCI_VENDOR_ID_JMICRON,                  // 0x197B
+    KORENIX                  = bindings::PCI_VENDOR_ID_KORENIX,                  // 0x1982
+    HUAWEI                   = bindings::PCI_VENDOR_ID_HUAWEI,                   // 0x19e5
+    NETRONOME                = bindings::PCI_VENDOR_ID_NETRONOME,                // 0x19ee
+    QMI                      = bindings::PCI_VENDOR_ID_QMI,                      // 0x1a32
+    AZWAVE                   = bindings::PCI_VENDOR_ID_AZWAVE,                   // 0x1a3b
+    REDHAT_QUMRANET          = bindings::PCI_VENDOR_ID_REDHAT_QUMRANET,          // 0x1af4
+    ASMEDIA                  = bindings::PCI_VENDOR_ID_ASMEDIA,                  // 0x1b21
+    REDHAT                   = bindings::PCI_VENDOR_ID_REDHAT,                   // 0x1b36
+    WCHIC                    = bindings::PCI_VENDOR_ID_WCHIC,                    // 0x1c00
+    SILICOM_DENMARK          = bindings::PCI_VENDOR_ID_SILICOM_DENMARK,          // 0x1c2c
+    AMAZON_ANNAPURNA_LABS    = bindings::PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS,    // 0x1c36
+    CIRCUITCO                = bindings::PCI_VENDOR_ID_CIRCUITCO,                // 0x1cc8
+    AMAZON                   = bindings::PCI_VENDOR_ID_AMAZON,                   // 0x1d0f
+    ZHAOXIN                  = bindings::PCI_VENDOR_ID_ZHAOXIN,                  // 0x1d17
+    ROCKCHIP                 = bindings::PCI_VENDOR_ID_ROCKCHIP,                 // 0x1d87
+    HYGON                    = bindings::PCI_VENDOR_ID_HYGON,                    // 0x1d94
+    META                     = bindings::PCI_VENDOR_ID_META,                     // 0x1d9b
+    FUNGIBLE                 = bindings::PCI_VENDOR_ID_FUNGIBLE,                 // 0x1dad
+    HXT                      = bindings::PCI_VENDOR_ID_HXT,                      // 0x1dbf
+    TEKRAM                   = bindings::PCI_VENDOR_ID_TEKRAM,                   // 0x1de1
+    RPI                      = bindings::PCI_VENDOR_ID_RPI,                      // 0x1de4
+    ALIBABA                  = bindings::PCI_VENDOR_ID_ALIBABA,                  // 0x1ded
+    CXL                      = bindings::PCI_VENDOR_ID_CXL,                      // 0x1e98
+    TEHUTI                   = bindings::PCI_VENDOR_ID_TEHUTI,                   // 0x1fc9
+    SUNIX                    = bindings::PCI_VENDOR_ID_SUNIX,                    // 0x1fd4
+    HINT                     = bindings::PCI_VENDOR_ID_HINT,                     // 0x3388
+    THREEDLABS               = bindings::PCI_VENDOR_ID_3DLABS,                   // 0x3d3d
+    NETXEN                   = bindings::PCI_VENDOR_ID_NETXEN,                   // 0x4040
+    AKS                      = bindings::PCI_VENDOR_ID_AKS,                      // 0x416c
+    WCHCN                    = bindings::PCI_VENDOR_ID_WCHCN,                    // 0x4348
+    ACCESSIO                 = bindings::PCI_VENDOR_ID_ACCESSIO,                 // 0x494f
+    S3                       = bindings::PCI_VENDOR_ID_S3,                       // 0x5333
+    DUNORD                   = bindings::PCI_VENDOR_ID_DUNORD,                   // 0x5544
+    DCI                      = bindings::PCI_VENDOR_ID_DCI,                      // 0x6666
+    GLENFLY                  = bindings::PCI_VENDOR_ID_GLENFLY,                  // 0x6766
+    INTEL                    = bindings::PCI_VENDOR_ID_INTEL,                    // 0x8086
+    WANGXUN                  = bindings::PCI_VENDOR_ID_WANGXUN,                  // 0x8088
+    SCALEMP                  = bindings::PCI_VENDOR_ID_SCALEMP,                  // 0x8686
+    COMPUTONE                = bindings::PCI_VENDOR_ID_COMPUTONE,                // 0x8e0e
+    KTI                      = bindings::PCI_VENDOR_ID_KTI,                      // 0x8e2e
+    ADAPTEC                  = bindings::PCI_VENDOR_ID_ADAPTEC,                  // 0x9004
+    ADAPTEC2                 = bindings::PCI_VENDOR_ID_ADAPTEC2,                 // 0x9005
+    HOLTEK                   = bindings::PCI_VENDOR_ID_HOLTEK,                   // 0x9412
+    NETMOS                   = bindings::PCI_VENDOR_ID_NETMOS,                   // 0x9710
+    THREECOM_2               = bindings::PCI_VENDOR_ID_3COM_2,                   // 0xa727
+    SOLIDRUN                 = bindings::PCI_VENDOR_ID_SOLIDRUN,                 // 0xd063
+    DIGIUM                   = bindings::PCI_VENDOR_ID_DIGIUM,                   // 0xd161
+    TIGERJET                 = bindings::PCI_VENDOR_ID_TIGERJET,                 // 0xe159
+    XILINX_RME               = bindings::PCI_VENDOR_ID_XILINX_RME,               // 0xea60
+    XEN                      = bindings::PCI_VENDOR_ID_XEN,                      // 0x5853
+    OCZ                      = bindings::PCI_VENDOR_ID_OCZ,                      // 0x1b85
+    NCUBE                    = bindings::PCI_VENDOR_ID_NCUBE,                    // 0x10ff
+}
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index c5e7cce68654..f3385c4a7e5b 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -5,7 +5,6 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    bindings,
     device::Core,
     dma::{CoherentAllocation, Device, DmaMask},
     pci,
@@ -45,10 +44,7 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
     PCI_TABLE,
     MODULE_PCI_TABLE,
     <DmaSampleDriver as pci::Driver>::IdInfo,
-    [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
-        ()
-    )]
+    [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
 impl pci::Driver for DmaSampleDriver {
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index f2a820683fc3..1191dd56e924 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -5,7 +5,7 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    auxiliary, bindings, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
+    auxiliary, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
 };
 
 use pin_init::PinInit;
@@ -50,10 +50,7 @@ struct ParentDriver {
     PCI_TABLE,
     MODULE_PCI_TABLE,
     <ParentDriver as pci::Driver>::IdInfo,
-    [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
-        ()
-    )]
+    [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
 impl pci::Driver for ParentDriver {
@@ -81,11 +78,12 @@ fn connect(adev: &auxiliary::Device) -> Result<()> {
         let parent = adev.parent().ok_or(EINVAL)?;
         let pdev: &pci::Device = parent.try_into()?;
 
+        let vendor = pdev.vendor_id()?;
         dev_info!(
             adev.as_ref(),
-            "Connect auxiliary {} with parent: VendorID={:#x}, DeviceID={:#x}\n",
+            "Connect auxiliary {} with parent: VendorID={}, DeviceID={:#x}\n",
             adev.id(),
-            pdev.vendor_id(),
+            vendor,
             pdev.device_id()
         );
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 606946ff4d7f..fe30a280cfa8 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
+use kernel::{c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
 
 struct Regs;
 
@@ -38,7 +38,7 @@ struct SampleDriver {
     MODULE_PCI_TABLE,
     <SampleDriver as pci::Driver>::IdInfo,
     [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
+        pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5),
         TestIndex::NO_EVENTFD
     )]
 );
@@ -66,10 +66,11 @@ impl pci::Driver for SampleDriver {
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
+        let vendor = pdev.vendor_id()?;
         dev_dbg!(
             pdev.as_ref(),
-            "Probe Rust PCI driver sample (PCI ID: 0x{:x}, 0x{:x}).\n",
-            pdev.vendor_id(),
+            "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}).\n",
+            vendor,
             pdev.device_id()
         );
 
-- 
2.50.1


