Return-Path: <linux-pci+bounces-45087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD794D38D36
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 09:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C87F301CEA2
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 08:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAD12F747F;
	Sat, 17 Jan 2026 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gP/0JFhO"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7126B0B3;
	Sat, 17 Jan 2026 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768638449; cv=fail; b=HB128ZR3jtXs2eaF2nPYWmCb7fbfWgCa9i5X+Ty8qcqoAmlctmeTElT3HYuj8w2E8m/961YzEp3+mETs3IYITT3WBAnZfn+59JwS+y4vstFM8QmQwMSPjxghmbY090P1KBkZ0HvxNub/6Hmho+sZPS5zAgmFhXAVtIzwFCKV6TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768638449; c=relaxed/simple;
	bh=7tlsE0eNTKaF5MXNIwtVKOvDZlbzdiz55Nlmd974s8E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3tHpJmTr7ZZkkt+9gJCvg3wSEhaQszjShKQ4WXrJ/NR6Wv1GGx1ht7nsQK0+PNVwbIE+/7iLDurvioHsUUklLUEFykM6iXjvWramXDHFhSCj1M1WP06YNBEnkEfvEiS4D4zFI0NRUrCTTm8RmiIiSU/+43MCqW2TJoFSZojB9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gP/0JFhO; arc=fail smtp.client-ip=52.101.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itZFQzIhAD6ngUxByijsO1bHhj/kmlBbDgrQQHphHq08t0kmHwYaGIM9bEWiL7Mbh6ZvfHgXaeaXVCZZFhI5d0J/Khqac7zJPsHWnGl6ufJtkvcSF2mv6HNp39AS0PoXgr0IaemLrv3u2gFO1av1ixugnI6LwyIzDRKS7O97L4iQuy2cwxju/ENit+NRpMPc7zcG9d7/77JdEj9BhBFqVKiupxQuSpd52TCjfGCIxjgkzXF53tHo8cqwEe7YcogILa82SulGWmb7sQLbsxzlitBZ4yPOt3YzE+38JctHAlKOltBdz+qMjvStUxhmwBEQpwF1lOxiCYpLvOsSltirLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lTcPrnx38nCD+jNvn9bUmhh00swWwFXsR+BX1HcAfI=;
 b=TkS7HI0pPVgDgYfvLz+Znx/G2tU9WUa3MjuC8E7xYVTVLt3mBrkRsH405rmLcpdNPFKWr5iqNY3k6BXTqtUi3FfKZjih87a9l3nE6OxH64NrDPFD2Ao5HAPN4Np3G2lJ+l5oi4X9opRlDmg+AKXUiUGkUdn1glo9TNKF/esQEETLjkINrj5Wc/eNHkQ9cmPGOgp8jIiM47+N7CzQ4a9KgwXKtXWBSc2PJUgpT6NVydBMgamC5UTG92Rzi5l+E9ykIPaWsvFaK7rbVvH/lXjBd5UB6Fk8WHV4BRKPBBN2Q/2aKxIXo46fBQMGW4YCyvjgHB/JyW/T6CS2zA1rDJ5azQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lTcPrnx38nCD+jNvn9bUmhh00swWwFXsR+BX1HcAfI=;
 b=gP/0JFhO0PJOrueK6GBXi6TenBZySXHmfDcD9PZWExyBbpNMCoTGyB+bx2UMWC8wN+v803YvT/9HzyUt5D2iYS/N5gPApI618vjxtgd81hyZ7EIe61CZcc/lwK0zBPcYFqy2TGiMUUbqJJeH2GXEp3PbQlOD1YBy/cqM/v29wvygA6WUXzR9xSvKCCwNGT1qJvgg222PqJIEkvquAkll7JAuLTR65uac8VWG4uyYZSN/38KLu+AbSs7e7hFpGNAtpP1eQkdeUNIeieVu+IjapXx7n2aSvHOSfwjDGwKR5EwhXdv5GHS+1eicMZLEI7xay/uLqKuElBpP3U1Mo5084w==
Received: from BYAPR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:40::23)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Sat, 17 Jan
 2026 08:27:23 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::df) by BYAPR04CA0010.outlook.office365.com
 (2603:10b6:a03:40::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.9 via Frontend Transport; Sat,
 17 Jan 2026 08:27:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Sat, 17 Jan 2026 08:27:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 17 Jan
 2026 00:27:09 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 17 Jan
 2026 00:27:09 -0800
Received: from inno-notebook (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 17
 Jan 2026 00:27:03 -0800
Date: Sat, 17 Jan 2026 10:27:01 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
	<rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
Subject: Re: [PATCH v9 2/5] rust: io: factor common I/O helpers into Io
 trait
Message-ID: <20260117102701.3aecf2ce@inno-notebook>
In-Reply-To: <DFQ4B7CJR5EW.TMEE2YAES7O2@kernel.org>
References: <20260115212657.399231-1-zhiw@nvidia.com>
	<20260115212657.399231-3-zhiw@nvidia.com>
	<aWoWntMxyhBc9Unx@google.com>
	<DFQ481S2NI1S.3HMMZMYEQ9QP8@garyguo.net>
	<DFQ4B7CJR5EW.TMEE2YAES7O2@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 196e3e5f-cad6-4784-3639-08de55a23d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e4N+6BvJDCc24J3mBeVTAmshDmwI4frt+6IOIK0ZVlQaJmwsvqzgORZW/R/3?=
 =?us-ascii?Q?bMbsIbGGE9gJgYWcfAZul1DnTOadBtv88Mlp/m4pCvAbRvrhVf22bQk10GqA?=
 =?us-ascii?Q?rj0EZFh3/dKjPkx4QfIQs9O9iS/eFOxnw7hW2DYYQJ1PAvXLM3Jk/G3mVj4o?=
 =?us-ascii?Q?sGzVBWYZ14Ndj5nwfff9l8n1kcNGdHTI3vzbmQD8jPCjslCtZvGZK5wMDdBD?=
 =?us-ascii?Q?cloGMfqNCy6KWQrSdA1FcaLVLfZYpQVbPURCizsWko/W0y4sbCEdEqpEhuxb?=
 =?us-ascii?Q?mIe0pPn88pf9or28qKvNLZVhcJ+zxea2ffYKfipQ4wJN3JUIfKVIkcNPYSmU?=
 =?us-ascii?Q?XDZ6bXi6dPOWOYK5x5Ip9+FluxeAoueUvkew04yFMnyp2kpctGx/S1L3h1T0?=
 =?us-ascii?Q?BndO9Wv+XmTs6J4lUyGv4vBtWrYcvUX7DTKyZGvfmhsCYaC/HOaKKA7W1BjK?=
 =?us-ascii?Q?3QsydFnFLlYiA1QHbtKTKCUkLJUpYwJicGE5kZBCh+HB/8v2lQY6Ts2r+I3a?=
 =?us-ascii?Q?8RpRpGvJ1fXPOlHik3spZDnMb4i3WR9//MPbbfBblbeEBGGHjB2RAsyLeQS+?=
 =?us-ascii?Q?0mWh+4UQNmKdi7/8124E7yvS/YvqP+EQE/97gZodjj0cAJHT06LLSUizmHGf?=
 =?us-ascii?Q?hqKPc3r1kqm/iYnW9ACgAZVRguEC+CelHjTgIb2IGdeN+o6tsKTz3OfNrGeA?=
 =?us-ascii?Q?7sAeTBm2oVwbvS0gBjQK2i+pZny0LnszWoniDZlOaCbcpzJjuxVivORa7BZc?=
 =?us-ascii?Q?FnSeJEOayEXIQbdYvrMIcDxl8RUc8OqBPntNQl8J9RMT3dWZm4tCgfyi6mT0?=
 =?us-ascii?Q?8QmLDwgyzvoHoI34u6m8pNI13DvUQcL0/yKLV7kzlzwGVRTfNeROkCxIkzgL?=
 =?us-ascii?Q?l48NQoLzuQlx1l3pTrvcPWZR2uyE7yFej/Q9UkdoHfOQF2L4ZI2bL1Y3Zs0U?=
 =?us-ascii?Q?P6qMm0YBiCNM1oDFou0hAEf49CKI8i6VDP6deWofCfPgHlAnBk8TobnkPdyy?=
 =?us-ascii?Q?oQmZUe8dL8lGOXKtOCft8Fl3gaiAJB/h3nn98qM++eIj1JqLCOBsljpZVhbi?=
 =?us-ascii?Q?B2m9qogq/Tokqd3AdB9SIzgz7XcTHbPJuGD5dJ6qHxU8T2CAkBkXvt6pRK7e?=
 =?us-ascii?Q?OkZda1Vb/mYfk2n0+eBtQEFh4brwV99czmzZiHZt5yOVrvKrLY2yziePxr7N?=
 =?us-ascii?Q?69JnJqQhUvwo4D70aHFjK8Cw5c4CW03bQY+lHCD72+kXTIftzXvnGBpTJTlj?=
 =?us-ascii?Q?6ExIqEroI5J1vQSZUra9LtCI/gdkP3t/G5OF48mGD19SbEIVumYhWJD3ja/T?=
 =?us-ascii?Q?RjiL/4T9zoBaSiIayn8JAay/MRg9QPfZLiZesBZ9smQr/7ZOiBtsj9oegRpL?=
 =?us-ascii?Q?HVXFyL1LVBfKPrpKm1E2dnA5YS4qwtQ1yXytMZCIdHyMpvGqLhYEVy7IMXzu?=
 =?us-ascii?Q?pdhFXLfAuXGvNS5hFQ8PbPUUqHpjwkzRr7hKbnWYEidj5STIhTGjlI1u6t4P?=
 =?us-ascii?Q?gHwtNGTcZaF3P10RqXS6CjUIvKc0CJ9NVc0U8ygyUeUcIUvyAAUIgwFUqfYw?=
 =?us-ascii?Q?zgnyDcad6cvgTBrM8J081WTDqht0vfHmZHkoSh6qP0AghyLTcCI1ui1AGjU6?=
 =?us-ascii?Q?18//pLrA+qjGyncAV1q/bdlsIP8+RFLeLqUcofQhfIFVVKUkHnXlvCTR1c1W?=
 =?us-ascii?Q?hjcNbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 08:27:23.4697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 196e3e5f-cad6-4784-3639-08de55a23d5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969

On Fri, 16 Jan 2026 16:27:27 +0100
"Danilo Krummrich" <dakr@kernel.org> wrote:

> (Cc: Markus)
> 
> On Fri Jan 16, 2026 at 4:23 PM CET, Gary Guo wrote:
> > I wonder if we can keep all methods on `Io` trait. And then have
> > marker trait to represent capability on performing Io access.
> >
> > Something like:
> >
> > trait IoCapable<T> {}
> >
> > trait Io {
> >      fn read8(&self, offset: usize) -> u8 where Self: IoCapable<u8>;
> >      fn read16(&self, offset: usize) -> u16 where Self:
> > IoCapable<u16>; fn read32(&self, offset: usize) -> u32 where Self:
> > IoCapable<u32>; fn read64(&self, offset: usize) -> u64 where Self:
> > IoCapable<u64>; }
> >
> > Then you have a single (non-marker) trait and not a hierachy of
> > them.
> 
> I think that is a great idea. I think it will also help with
> supporting I/O backends based on regmap.

Agreed. The IoCapable<T> marker trait approach is much cleaner and
solves the hierarchy complexity Alice pointed out.

I'll pick this up for v10. Thanks!

Z.

