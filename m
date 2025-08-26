Return-Path: <linux-pci+bounces-34804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF75B37557
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B777AF6C2
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 23:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800DC3019B3;
	Tue, 26 Aug 2025 23:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ncXPlWrW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF75F301466;
	Tue, 26 Aug 2025 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249959; cv=fail; b=hYnLBcB0qVTFolKHmzmjxtk0XuyJyTgzqyAcsnOrqZJQWnKTkqs3ADNTukWToRZMFjv5eErfTHAUjLn7LNlGEYysXll9gCEJvBmXw+aCNpkS3qMmL1UOgMHweTkhoPp6B5dWBLa/BBgzc77/lRdSlkAIbHagG/w/2kPbEGOoLIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249959; c=relaxed/simple;
	bh=khDQw2moEMjqFviEp8B0aXXXCfsJvxaawghGP0Sl9LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kcutp6loHtMGIkpf1PHzR7I95MhUrpT65ut1UjxkD1QFJ2UFMl+iAu+G8pQ3/DfaXVZP3IsJZPnqsIGSS7+mNxvtxArqVf0erGYoaIytB+ZoDwy0XeSeKEL/s4oz0wno1vPHcOl6VQHI+4rnR3S9JCjhWgNKTGWvdDxB0O5yvFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ncXPlWrW; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaWAvSswzRSqoX3BppFGr/6e4BJRsIyZk4NXRKdR3ZDutY0DYbliByKUY7TZFLYLWpSI5+oXG6Hzct9i6LeNBNwIcj67q2BEbKwev5GqtO1CHzqRd/sDSxOD6tr6VbSHDwy0187ZNjg6bKPK8YjTF8AIBHWp5ROvdY7gJr21urVTEGk2ZtM7k/Tww/T38Oqy/J/SRmXFkIijo3X7shxIXQ5VpnkTjeznZnaLjX86oMjydk4SkxMzV1wxLXDhdQzq1UYwI0sZ2JNqjb6G8HSqpXmseSZ8R0HpIvHqJ+FBK2AjuSnzNcB/t4txTG4uQROUhcYtvftwJV5bLRNoMMDySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0KlkMAZs8cCIGfnJcfwgPgyRKzpxVoAHdzShyrFt6Q=;
 b=J2NGCPKjAsdKsCPra0UYbKFPvYipApHrqK5wDKWsidpGanYYuaQ1eMHrpot92KHBZgHD72OMbCR+K0pUsuaFWWxfBq7sbzQHF1ekV1A4TEjKxyfIasF4B9HRWVlcEovRLdHZF0tUy73iV0rHMN0ily3Kpbbai5kHxT40kvx28vLHb7oHrOdUbosTi5vIzw3cg2Ju1GDITRQ+lIjHiuMJfZfVxN1raUs+ZZ7k534XnWGSC5zDRFDHxojzpE43ou96MiHBujmhag2U+sPoqxEpe5GgOla8+22diWJFHROKm6vVs2zL/njWhjh27fonrlpVoZjFjghSQ+1VGYoD1wB0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0KlkMAZs8cCIGfnJcfwgPgyRKzpxVoAHdzShyrFt6Q=;
 b=ncXPlWrW9L26rKbtel2ei5/cgBFE6TreME6ePO6o2Qlg9/nLkHeXliHoWL2hkvj7/claVz2rI+u64rcQpBERhaW41L5gVcYTBvs1Wcxe2TZh29s3CAgrxDnIlG/Gxxb0lO9GH4j3hII9IP0VZYIhFbJycVsPZIkt+ov5yUkXAITPqbYXLizTdJDj8ZMBgnoX6VTSvFV/57CiYQLnacSISIQyCiG1HpmXMHvKDYOF/eYr0Wz0Oj/O5gHvT+mUACePSwbQSl6FZoR1kdT5AWwF+w8JJQeWFLxw5bXqD+g6d7jkNf7MNi77Bz7FmHi9I2VqqNQhnh/ni36AGtO+MZyZNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 23:12:35 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 23:12:34 +0000
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
	John Hubbard <jhubbard@nvidia.com>,
	Elle Rhumsaa <elle@weathered-steel.dev>
Subject: [PATCH v7 4/6] gpu: nova-core: avoid probing non-display/compute PCI functions
Date: Tue, 26 Aug 2025 16:12:22 -0700
Message-ID: <20250826231224.1241349-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826231224.1241349-1-jhubbard@nvidia.com>
References: <20250826231224.1241349-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::30) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: e74a05ea-95f3-499d-b039-08dde4f60a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?691vzTZBA5wUA5TkflOp2G777IO0SPa+xQcUBFtC0yEWSKYbTVRyLevDvD50?=
 =?us-ascii?Q?dP10P57NBrX7IWwcB/uOXFXcZxhnfxTDjOpjEYFDEmsg57ggVzjdPUwh7uT3?=
 =?us-ascii?Q?eeZ4sea3g7+497+A+KesJq7KKiRzJG+tJEwTDtVZD7ithSiumrFZuEquzHHp?=
 =?us-ascii?Q?dse4/zAMLA8/B9e8F4AIP79PD1JIw+HWF76hxAHFPtWfo7mUDhkfBqbf/U8f?=
 =?us-ascii?Q?s7jF9ZXYDOwsRozjJ15cLK3C2/gWMvwzaPef2yqm9D2DZttBnVfQu9qyYocf?=
 =?us-ascii?Q?k9NlzGXsUm5hhbBM4v9KGUbX/F44TWG2rE6yeL7DyIMRtVKAYXsfNxcrCqoK?=
 =?us-ascii?Q?fgP25fKQJRcUMWczXzBOTyDx1jh675jt37AuP62f+P8GkkcTDa7crGKAD5Cp?=
 =?us-ascii?Q?YTg3uPvZ7z0dbj34i7ditHpXHF69DBsoPX/AAwi9AudLB7xSMxZA8HCnJHoz?=
 =?us-ascii?Q?NTXRdaRXtiHWvN0x7HO01d3KL+8CPiNb60yzeZSUijTYZo9KiqO3LSldEWCN?=
 =?us-ascii?Q?eHUog885kniLbM1AqhH46hxvSUb19wfzbXkQbW2l+JIgxKWX9zSV3yMF33O+?=
 =?us-ascii?Q?LHqEzo4maV+q18CSsNdK+Vim3vgvHmZc3YrFFrPLSYXIyV8aLAJhFx87sv9+?=
 =?us-ascii?Q?NRPxfCenDJzkzO2zffU5PvUKijGZWAloepdJgKsqqf/wmmV18g1w1UFGSUsc?=
 =?us-ascii?Q?k6D/0C/UeXyI8Fb6NvSGbbC9d/ANA3z5wObiXOxk73uM6TrK1CuVk+yZEopi?=
 =?us-ascii?Q?4o9akHqE12EwQh3ihT/wkyUBMzpjCm56FTEZbbaAhMrNL9iPTv0I61EhDylY?=
 =?us-ascii?Q?cML1wpaZQDt7ZL1l2cFZ0byJYJqOcKg8UhN8jxM6RuuCLyDouO1wdzu2RiRo?=
 =?us-ascii?Q?NF1wLrEtyrUvF/ngnrw8h2Tw5uilqsr50Iy/DspcVfDxQtr6rPgTX5UL3k7x?=
 =?us-ascii?Q?9hFDtscsgkZ8VhBv5tvDeQL/jwEd37GrSNWb+HMDzv/4kqggd4SevlX/1bPR?=
 =?us-ascii?Q?OKGUZjLTDAb3iiFfhdHkcJOeVXOmMDs1h7XqiIdNvfg+J8vFwIUkfR7acT/8?=
 =?us-ascii?Q?Fgw68vTDFB8AZGEI7WaWUg/WwHOV/tl161xR8hjkS7DXX4LzvObwg8Ox9OB5?=
 =?us-ascii?Q?a7VSyaq56Fjedjti8ie6+k5eP3351k4i52ENuzhFemXh2mBZatqIliAZzDHZ?=
 =?us-ascii?Q?eoXsl3CZzhYiscocz5EcYVR2Gtgn5WouoNfOQuDuZJf6hyJb1iHRXtULmYJo?=
 =?us-ascii?Q?3j7LvBpjJSwCrxeI4/2d+KxNrZxCqLZtVtHnwoyLOBIW/c+HIyX52B7bP87W?=
 =?us-ascii?Q?yDQpMA6INi1AkZr3l1deVUcfqPoHgGYx34dgwjq+tK0klv9Umo7cJrmkosuA?=
 =?us-ascii?Q?F96LVxIMLaYZZ7bbfvi7oje+V+sjmYOPnJ1R0SPshVTmnExYo2A0YT84KxRn?=
 =?us-ascii?Q?ka7a288lvmo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9jkmGadGg14x65R2F8qB3dML9APVZ4maCNFklwhoAMwe+k3/H4TaU2FYyPRI?=
 =?us-ascii?Q?4U4Mgcj1WdO66Uq2swKpd1+6DPnLbOoDRdHAAmR1Aja9SfGkooZqXHgiNY7B?=
 =?us-ascii?Q?RH7RGWJtdVZ9+iJpfvc685QvrvPezlK2MdGoygIWA080CvXKDLhHNnz+quPv?=
 =?us-ascii?Q?cWLxCeUE1HZ4BV0aQsl/JNXARV5cavflYbztv3gL+nWZ4KIe8aeeSpC3HWQt?=
 =?us-ascii?Q?qJs69X2sRFMgH/QNb8qyeuJrpqfVlUAVkKttYcqDQDTjqgMbAZKbRSK7l616?=
 =?us-ascii?Q?ctlsVoXvcAgyktbwJAAZUztdu4gsLwxVWaXQzqHyfQgKbEBOo6D4FZSuvjgQ?=
 =?us-ascii?Q?FW5XqNX1cBAw07bLgz2LPnxbg7izD3a4y8N+OhSGYBfBgKSzwruMhKJSjUpa?=
 =?us-ascii?Q?3slJYT/IQcxN4N/C6z0XsMv773g91o+JTt0m0UTVVe2sFBBlRGSce8v+TqEp?=
 =?us-ascii?Q?3vdSBkepv2uSOf+ZXPkGaaA1huIOQFPpSGa/Z3c40ExJMfbiaINqnmcr80+6?=
 =?us-ascii?Q?K8r4dd4lPBR7HG4y0bgeWq7dSGQ2aIU5DBtlHnzFZmEyyJ6a3zlLHSfBegMX?=
 =?us-ascii?Q?QoAZcIRqMUPRkF2N2VUM2idXEiXIetyO6moTimrHDkfJNL6KigpAVQKL1BaO?=
 =?us-ascii?Q?03e7JHOmT855hzgQRPKcycwxWXSnDTti3Ki53JMbio5aaUaRwClw08NFI2Ve?=
 =?us-ascii?Q?XyLpoxkZjO+iZb8LBEm4bPPjBTeyLiDTCCDKtBieyQLW0gJxE0yUo0mTpY77?=
 =?us-ascii?Q?quKUroq4SrZptx8uP0ktpN05sy4kQ0A6XPgrhgI01/dKi6GRJHOwPa36E5hU?=
 =?us-ascii?Q?+LZGskhVP2HMh3uG2m/Rls/DCB7VTBcVTYcq0eaRAXG1If8zOjBKThGu82kq?=
 =?us-ascii?Q?JnVoy4ZOT6pHA7n6kVP2JdkmdpNFb2cPojYrWL/Zi9Hqu5oDGqwwWX5lrByp?=
 =?us-ascii?Q?0+9i5IR4wIPp0QqhD2x2kY+nqiBPJWcfZwzVu7jLvjaGIVsCu++SPiLVVhpd?=
 =?us-ascii?Q?Cnz7SxZ3lONsoJxh6uVMdn9s5oFlysh3qEfAkhFWedj3w+SwtJ8NwCWTZwYn?=
 =?us-ascii?Q?Ib8WeGVe6wffT84DrlB8kgakvmXoOFrmUv0Sw2zmgrDlTn5TJQ9o3SRN93st?=
 =?us-ascii?Q?Errb6pVGeNeemoF8Xj0xd5AuFSjHTbwvAd1ZhlN4pmzZC5BJer+aSGCeiPl9?=
 =?us-ascii?Q?lNCHBCfSv92ij3AEDjmB2Yq+XCrm6PTf7miZjpW19NSsLegWv0HgHQR++Enm?=
 =?us-ascii?Q?HznGAmyCYNUYCNWHLlgmf5zSaQ/HLEFMO1oMyrUkQ6RXitl5IotLrXAsskwv?=
 =?us-ascii?Q?9mzl76i3N+VunGHs6yG1Mn+26iM0mk8tikJllY7MfpJ4NeJsaxT6ZpkYM/r+?=
 =?us-ascii?Q?DyuRN9HAkBgHvE6SdO9aJ6j7w9Z/ETYRNHV4B0ihkThKkNTaNBuXr9kQ9eip?=
 =?us-ascii?Q?Wm/wt1hr4YIRVjYdOCO28WpQmS2vhqn/ZWBejYGi8cT/5Y6DK9KXkH363qwR?=
 =?us-ascii?Q?FaDsX6FQHySuDGIS3vVI1PbnoJ4P2hTy10HizWyfDPsd1VOBTn8C52Saj/7m?=
 =?us-ascii?Q?9NomEjK5ksy5Ph7WNAtvYqbm5g1VP6fEx7597bcJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74a05ea-95f3-499d-b039-08dde4f60a87
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 23:12:34.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVa6v4XGpWUXTki1mCuedkA7KP59A3sRBvLcTJDn+0kx/l0zhGPJjUp9HKJDU2WNfURvMtiIFFh/09/dARXGxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913

NovaCore has so far been too imprecise about figuring out if .probe()
has found a supported PCI PF (Physical Function). By that I mean:
.probe() sets up BAR0 (which involves a lot of very careful devres and
Device<Bound> details behind the scenes). And then if it is dealing with
a non-supported device such as the .1 audio PF on many GPUs, it fails
out due to an unexpected BAR0 size. We have been fortunate that the BAR0
sizes are different.

Really, we should be filtering on PCI class ID instead. These days I
think we can confidently pick out Nova's supported PF's via PCI class
ID. And if not, then we'll revisit.

The approach here is to filter on "Display VGA" or "Display 3D", which
is how PCI class IDs express "this is a modern GPU's PF".

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 274989ea1fb4..5d23a91f51dd 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,6 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*, sizes::SZ_16M, sync::Arc};
+use kernel::{
+    auxiliary, c_str,
+    device::Core,
+    pci,
+    pci::{Class, ClassMask, Vendor},
+    prelude::*,
+    sizes::SZ_16M,
+    sync::Arc,
+};
 
 use crate::gpu::Gpu;
 
@@ -18,10 +26,25 @@ pub(crate) struct NovaCore {
     PCI_TABLE,
     MODULE_PCI_TABLE,
     <NovaCore as pci::Driver>::IdInfo,
-    [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_NVIDIA, bindings::PCI_ANY_ID as u32),
-        ()
-    )]
+    [
+        // Modern NVIDIA GPUs will show up as either VGA or 3D controllers.
+        (
+            pci::DeviceId::from_class_and_vendor(
+                Class::DISPLAY_VGA,
+                ClassMask::ClassSubclass,
+                Vendor::NVIDIA
+            ),
+            ()
+        ),
+        (
+            pci::DeviceId::from_class_and_vendor(
+                Class::DISPLAY_3D,
+                ClassMask::ClassSubclass,
+                Vendor::NVIDIA
+            ),
+            ()
+        ),
+    ]
 );
 
 impl pci::Driver for NovaCore {
-- 
2.51.0


