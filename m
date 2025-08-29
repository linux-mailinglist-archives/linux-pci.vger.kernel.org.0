Return-Path: <linux-pci+bounces-35157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085A3B3C4FF
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 00:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D19FA20EEC
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 22:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FDD2D641A;
	Fri, 29 Aug 2025 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ohoLfOF3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EFE2D322F;
	Fri, 29 Aug 2025 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507012; cv=fail; b=Z0Jbkkm4C+Bpu7HAz1W2se1xtb4RKjRN3qnnCj1RZ6aDU7QkrVywz48zQwFkcyHbnVHsBD8w2nhyXAhnxOYKg2WlIn03cStJXDcqBPwcX+wHRURVjy3sjnrId86F4XU8qNMoeVukqbTXWndWi9OEBV6yIvOD9NdxrsA3I/Z5xK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507012; c=relaxed/simple;
	bh=UBGGdb8dFmTVZ7fmR5RTWRVUbJbA1Wq9K1RpNT1JB7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N88cGruM4OgTCovU9yHO4TsSLKEXJaGDT1g//VF7Uec2tvkcFJQTvITwAFHgO8ZAIa5vEbCDFy3VES6mWbNY0CwtE6LKAvlhnPsNctdMkrgFyOtPo0SUDMlAc4u/VLpkpO49EYJGRkOjTQZe0c/bIFxkQytepcIolHpWRNWbfXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ohoLfOF3; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5gpdNJDsXYRaLMjFcKWemw9s/XgCPp3bpgm7jqjvm7abnJNWhEz5tW9YkasawZtgv0Yfbsd4VxfUeEsZidQb8RF+kIcV4+ebn31mWOKA2CGMZ21rkazBu5H1FqYSrPTGKLfWlqaxr2E2ebeGqZ5zI7UInzkBUYDSZlLBoBoFJQfRmSmt9DXr5buOlyKRMm+2ryGHzH/Y8JOBpmtTpsqon/p26BgcSbTzUKlMCO+upqm4txbRuCX9LHsRVNRp/wUrLgegN038M2jaoLYMA4x9tCDqscgLKEzfJPx47zYsjkOWTy8xzXGL4GFXwXG6LqEwz2w+tYldIpDsbBOpxhRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUmGX29UyYneyqrLjc9vg3lvZqz/qvcdoP1efvhry+g=;
 b=DzSNwrElt8gbheZ/Zj2wSWTFFJrRcZ+GF82hBv5ZhR7+iFcDd5vP0x4Id9d0iUJIvjR42KXuH4iddl7W3Vz4g54HTVdy0POzoztaH9rNBkGGIhEHUqyzfjB0eyJ6w68Yiw1DTZZfW8N6frYYI8lVE7hbs9OIqM/Vg4rAMyMvH2nzIF2ETdLXCgJTHNmZdHee8veONPRp4V5UKfWkHp0TIsliz5ef8E65xZSuaoTbRImtcz/lknBt/BSgSCqj7g3qvH4XGHSTrNRpK06811P0aLQPW3NxW3BRv0BtyZRb4t7Ez860Y80r+c4XdNJ5ygCAxpqCfpvNtYdC4O+EyQ7pqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUmGX29UyYneyqrLjc9vg3lvZqz/qvcdoP1efvhry+g=;
 b=ohoLfOF3mJfd3yXIjimeSM4MnMSQua5xOiZc2Gv+B9FwwQNdxLYo5UQhuzUWBJABsRddpuoBib0cu2V6P8rHPAp1G7l073jX7prl3FiW9wjhC6PPAN+jq4UvD1ms4t2pS2VenEll4V3uMjAeCElyFgecptY49enG0MLxHtHlfiyQiLyu5Wt8KuU147Tjqml30FyGt/nxG7efdmM4/lz345Mqt/GsElmTZ7RJXZVwkRnmhKQN0zyg4u/2effmgosxYZ4blWAEOzHa+UoWBuvAqpRTjjqE6I9nZMezMtObUJnHLgsuQqhNYTN2vF+NFbwskMxf3ZgbMswwnH7xIll+yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH8PR12MB6963.namprd12.prod.outlook.com (2603:10b6:510:1be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Fri, 29 Aug
 2025 22:36:38 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 22:36:38 +0000
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
Subject: [PATCH v8 2/6] rust: pci: provide access to PCI Vendor values
Date: Fri, 29 Aug 2025 15:36:28 -0700
Message-ID: <20250829223632.144030-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829223632.144030-1-jhubbard@nvidia.com>
References: <20250829223632.144030-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::25) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH8PR12MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f49e13b-271d-49db-75f2-08dde74c844e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZyXOX518Vd2DBw2ZPSsO3nP9mI90wp3d0dAPEPFFpkifJueHs8x+ZiS29Yt2?=
 =?us-ascii?Q?4sa9DzomoBiY1EAN68JLxBLADKMKNQ8i9Pk2IPlwnpv7VAPMH62CbSbnTDXs?=
 =?us-ascii?Q?arWYn77F8TUJKqOJGYwOsp2yx/8WuF2kNYjAP+xcSFk5nM3DqS0o40DBLlhk?=
 =?us-ascii?Q?WBytIGBqB5M26VCzEZZV77eEi9rilxhqyQ78rdtrbIvO/grR0N6FhCcrje1a?=
 =?us-ascii?Q?XooFrMWo7egZ9RUZ3EPm3z9NHsxBuEnvKQqASFVMs/no29KevU+5ihGj78kZ?=
 =?us-ascii?Q?/bv1UPjqbDsUVj2X+K7sQMPFDW2MTVyu7uyZtykAeHOF4feU5B35K3HornCc?=
 =?us-ascii?Q?33s53OVBFU7cYiddvn/7dricFvpzOtBCScsVzP4HWbmGxpc8zxE6yYCLXmqI?=
 =?us-ascii?Q?cThc6QfxmBaQpPH6g2xNgCtsKHjmuW3MsVa+2Ia5ZhxXGjGdNKym7FU/6bIJ?=
 =?us-ascii?Q?UuRrM+2g8UWINvOcTVdL0lM2aPmW0AR+63JeF0aBVOE89UboKTqY9kwlykQt?=
 =?us-ascii?Q?2LQjXDhrtWn/15j3MAyQV45uhEyUtzg5kK0BtiP4jSIOuZXxYOdKHFWQV0ch?=
 =?us-ascii?Q?oqUeaIHO7HIRzQm7qD3OeFiS4LeIZhT9r1DPZWB3lQKyJzHLyENsjgGj1K+8?=
 =?us-ascii?Q?IdHBrgKgwJsVJ+z4bIGDBTgBZOBQSFMFS7NMjVx0eUcvlmAWqUOxmoAr9GzW?=
 =?us-ascii?Q?6ZWqW0Wrm9vylmJrG0GobqCJKOEC4SNjng2vs3f/qABjqWvYQVLHaPQG9tT9?=
 =?us-ascii?Q?pKfQseYS2Ln9KKlRZxUU+RNoeYGFoFJiVWeQm7dPp+VwpqcMNp4B9Pjzpp9Y?=
 =?us-ascii?Q?QMw/OcjBj/pLi0pJtzE+jPgqupgQ/DLIJO3chQT8Y526IMvawQjll0HXk055?=
 =?us-ascii?Q?3mhPMlsIRPAoqXth+UDa7ifcYjiiN/nNxa2mN8JyARWoqnD8ZgaknUOx2Qxe?=
 =?us-ascii?Q?yMSykarYXn/K7bJmxLhL1FG4ZbTfuSYXc/2aRRrChp539kzZxnUluywRo5kN?=
 =?us-ascii?Q?PKtJ3Ka6flUk9wOSb7QlqyCPeJGG+bb1HoM850bZ8UHlITizqL2W+A4NtuHn?=
 =?us-ascii?Q?mpB5UHDc0UdGqNkG+uzwqM72vVabLk9n20/dRYSG2a5LvO/J7RxSU5w5LXJD?=
 =?us-ascii?Q?h6rn6rzakIVUnlhewzf2MjriPrP8Nc4/MQNwxbyb/thUDjr8kQKVuxbzdcNN?=
 =?us-ascii?Q?N34C2F4IEadYcG5U4kxxKl1sG7kaSgiThECZ0Jm1MvzM01CDxCepXw465i0b?=
 =?us-ascii?Q?ZyOa+0ekS6mAykwqI3lQ9Gd9kRAuhjde/QfSKnF+yC9rMH8epYYPaQji5Kjz?=
 =?us-ascii?Q?gkEBq5oOx/FKsRm6QG8Gjc8p1MikVJFz+A0XaxpaFklNknfbOL+rHAW++Q+J?=
 =?us-ascii?Q?ZOgHiu8LsTPXmLwfbKQPrwC/itXgraT5Uw42YfP59nRRjQs/I0ULp1y0dobi?=
 =?us-ascii?Q?/XZ4lWojNrM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ag54b6tlrpy7ygmSP1bGc7Tzkoy5H0v9uth3A6vIL5Jfh4LWh9c6+Vjjlmc9?=
 =?us-ascii?Q?HYIVqforYT+YblsIDspvDUO2kZdtBhaD3HwA93jFSCUEsGRJ/k78FcxU1VbL?=
 =?us-ascii?Q?oJKrVLutklaXoq4UKl3r1od2Bs95LBR7mjnsjNKGAj/rtywfm5gN9SyZGRX9?=
 =?us-ascii?Q?uAnyGrEirxXhX6N5ei9kSuV2mqT7/+HY8NrBdKlLBpxZ/2ZMty4ZzfBv96M+?=
 =?us-ascii?Q?veYqJ+GgQPRDuQ9g+WGe21S7q2y3Yua+qbgLza+RWxjPz8blAKz7nGhobR3W?=
 =?us-ascii?Q?BhOR28bc2/UI/cd+GARYGMixYxdDjN5hWz6xTJBB2pB+L3SkKCqw4NRmuL9x?=
 =?us-ascii?Q?+hZuB8NJOXsgmKuP7Psblq+Dj879vE45bepzWM/S1Qyag1tAUmdtC9H9WMRH?=
 =?us-ascii?Q?uj2sqMkgnSbfSXFqv9fv6LNSYzEr/l9W2CtYpcDxbD0pR+qgpdI09sK2g1Lv?=
 =?us-ascii?Q?wIPOuiTUY35loy7CY4M6fusUCXFgfSMDioQicU5cXYQo1JDd/QK7pj9JiNbA?=
 =?us-ascii?Q?nytphHhiuPalNtVUdfSbvbhtdbcrdf6GnFOW5bqRk8PNqzFFdmVn0xxxYT8T?=
 =?us-ascii?Q?zbLS2DB7HtPoqSa9RmswjYNpySSVVwvfRczXWT7bC//B0153R/ipzR0ePqIe?=
 =?us-ascii?Q?M3+VaJEaYmaPU6yxv5n+KfObFOfsc6dIzfa0tGNUGqimRGHsvIj6wDXdBfub?=
 =?us-ascii?Q?2YU+DGpxjkgSBnlineTVARDyDsUvE1f5kOrNCMzwUsvQlQ4nS027ZsPmjjK5?=
 =?us-ascii?Q?nC7KHNLMX7VKvuNP6J2IcTTvWaV9dVIJocUf3waImWUl0MwEmuQEs33ZITf0?=
 =?us-ascii?Q?HVDHg4RWU11XhU5R0p7eB3XPi8svd9xjKPfjcAeGbcrdDm+Ep44WdE1/i1Zj?=
 =?us-ascii?Q?PPEXz7VL2BWu207ZU3DOF0coilhW4oOZNlF9MZNl0WF2Yq1F/BGRUPfjgZqC?=
 =?us-ascii?Q?5LzVgV6qFq09T8wwKkL1bR5RE0I0c0X+PNtz/Gc/n0mQbDN5joggcfqmb02X?=
 =?us-ascii?Q?qpLu80ZHZ5JZaD2bqr0ZuhITa0VGkR+85xKl2EwzPRkrBnhEJhgPJlYoGL46?=
 =?us-ascii?Q?wcpdVVo2ERDS8MQ2KQcEUy8qdv9jDf+9zPi51KAiSodCqZgW1CK+fpckGoOX?=
 =?us-ascii?Q?K6oppkyFbnTUWyHB+d0UPMZ7+1DLs5v9jVKgzuWXH21MsHaq00xg37MMvhb9?=
 =?us-ascii?Q?Bmb7Ic75KHayQTNpTgBY4gCV9hhG2MfjQDHfB1wr1Gd2Ik8EF+tqnRbjvFW6?=
 =?us-ascii?Q?qt3+vYsk/Q2/qILe18Hjk7H7LlPzgcJQ5D9zkIvGOh2bJGRwu9gUBCzOrhDu?=
 =?us-ascii?Q?INXnO/er78OrNUu1bb3E1ekIFDOrzXa3x5fbLrdhO5fSzAGEPPay6pqksmG7?=
 =?us-ascii?Q?r55T+8BIiHUn3TO3aoWk3jF9GUliQ4m+r4pX++TJREtRTXA1anCGgSyFaw3g?=
 =?us-ascii?Q?9bZC4uN87aNdtCYb3m6ZGAwCwel5Y6zzkjL0br2ZAX7V+cILwjMSwVw30GQk?=
 =?us-ascii?Q?fgEOwK5KkbV6RlzhnVgRWFr33In7ocYePp4dLhACaTh5qFbHY2ZofY6ZoQCl?=
 =?us-ascii?Q?K76abDnscGReeZuLk+LQbCjvi3AebbmRaLkTa+px?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f49e13b-271d-49db-75f2-08dde74c844e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 22:36:38.2449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ak9fw92Hioxvx+0HGw0GZxnj1IpJF+zCNmOhq78gc710eRD+8KPG6ALL4UqIQsu/e48AG32/2LWGwOLofV/H/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6963

This allows callers to write Vendor::SOME_COMPANY instead of
bindings::PCI_VENDOR_ID_SOME_COMPANY.

New APIs:
    Vendor::SOME_COMPANY
    Vendor::from_raw() -- Only accessible from the pci (parent) module.
    Vendor::as_raw()
    Vendor: fmt::Display for Vendor

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/kernel/pci.rs    |   2 +-
 rust/kernel/pci/id.rs | 330 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 330 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 212c4a6834fb..f15cfd0e76d9 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -25,7 +25,7 @@
 
 mod id;
 
-pub use self::id::{Class, ClassMask};
+pub use self::id::{Class, ClassMask, Vendor};
 
 /// An adapter for the registration of PCI drivers.
 pub struct Adapter<T: Driver>(T);
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index 18a1b7f9afe5..a7712df1fc43 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -2,7 +2,7 @@
 
 //! PCI device identifiers and related types.
 //!
-//! This module contains PCI class codes and supporting types.
+//! This module contains PCI class codes, Vendor IDs, and supporting types.
 
 use crate::{bindings, error::code::EINVAL, error::Error, prelude::*};
 use core::fmt;
@@ -108,6 +108,50 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
     }
 }
 
+/// PCI vendor IDs.
+///
+/// Each entry contains the 16-bit PCI vendor ID as assigned by the PCI SIG.
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+#[repr(transparent)]
+pub struct Vendor(u16);
+
+macro_rules! define_all_pci_vendors {
+    (
+        $($variant:ident = $binding:expr,)+
+    ) => {
+        impl Vendor {
+            $(
+                #[allow(missing_docs)]
+                pub const $variant: Self = Self($binding as u16);
+            )+
+        }
+    };
+}
+
+/// Once constructed, a `Vendor` contains a valid PCI Vendor ID.
+impl Vendor {
+    /// Create a Vendor from a raw 16-bit vendor ID.
+    /// Only accessible from the parent pci module.
+    #[expect(dead_code)]
+    #[inline]
+    pub(super) fn from_raw(vendor_id: u16) -> Self {
+        Self(vendor_id)
+    }
+
+    /// Get the raw 16-bit vendor ID value.
+    #[inline]
+    pub const fn as_raw(self) -> u16 {
+        self.0
+    }
+}
+
+impl fmt::Display for Vendor {
+    #[inline]
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        write!(f, "0x{:04x}", self.0)
+    }
+}
+
 define_all_pci_classes! {
     NOT_DEFINED                = bindings::PCI_CLASS_NOT_DEFINED,                // 0x000000
     NOT_DEFINED_VGA            = bindings::PCI_CLASS_NOT_DEFINED_VGA,            // 0x000100
@@ -229,3 +273,287 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
 
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
-- 
2.51.0


