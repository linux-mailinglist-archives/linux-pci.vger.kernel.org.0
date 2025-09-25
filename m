Return-Path: <linux-pci+bounces-36914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C22B9D07D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 03:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B3D38195C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 01:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C60411713;
	Thu, 25 Sep 2025 01:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PDsEDwOG"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5594F1E487;
	Thu, 25 Sep 2025 01:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758764049; cv=fail; b=uIstPlAFuu8nBVLaAbACJUwVmsgPSBfTvwJuvJ6Pipq08DsqI/IX50g7pqLs8TVN4BW6/FwVfbjSVxCZu3qPwjpHbU3VvgDtp3eiBtyhoxozyrRlHiC0/Csq3oe9N+liyCjosVypXKoJ5Pakn8ICexRYpPOh6233xmlzxNZl+pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758764049; c=relaxed/simple;
	bh=0slJ2uhILqOYGWgXolXkgSEEtqC1KLdvOy+zfK2ZRBg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q9tXyLZD0B3DjFtpVsvWn35yvz9cYvTB97pqbzJmIubzlCFKANVKHrdEr+HnsprvGZASLO+3kfEXwszPt849GbM+z7Yg5oZ4gi6iGzWPQSVm3u2phhH1C8keINoId2EuWdlhTupbdbSvQrbcJy3K5gIlu0eaN5XK3VE2VTuvUHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PDsEDwOG; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vpt6Tb/cs3PoULyOUQ6oX6VPGQHzppuPvOzBp1jr+zmDd5j+IB4WlOZvyyTukNgq+lhA511AT8oAhIXyv8ZjGoRq+YapEWBwTKJLyp9hsAu/Q/t53SbUnp/rWE1PvInzoJOop6YA+1f4zlulu1LE0C+QH8Ctz/uSCMyUd0zKgn0drH+zLybzdvXtBjlbi41IC/2TTwwQiDlvKZIdshI0kH5v6jPkQOONuIzY6yD2n5CkGszwhcS8tohyqRxnLwDlazooGmIh18e1ycSqKv36doYfvrv7+HOLlcs8gFt70jVTqyA9PYCf9eoso/7aQr74yBdfsceZqAjOkVOgTjNaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PE0yM8nj+df6/CYTPO6BAJnBRtNQswQRbb5RMMmS5Qs=;
 b=gtfl6BQg2vCdORK8xa7NlKm94G4ABmBGZATOM9Za7q3SYOlBoS/pOEpD2kGib3TEU4aMDvRLis6BF4xSx8iWU8BtZMl5M/CUr8/jGqMYbUb4WagNA5buhe7WLhmoBz6QwA6xS2k0a/LosMTBPu/lOxy5XO4JZADmt5kLeGq9iwOZe38WQIG3Su8uwU/0iG631A16m0tV7Nz1m4/NHYgEwPTXXjcbfnvTlTCjurDUgAmTduhf2Hg6zPs1HlcvLVYLB3bcLSavADHD2FejlwGqz8DW+XerVeQc3rHftn49y4dKr7i7ytalQ/Rsfn4RH2KiKEjfCUT/9PV3GDnvReq2uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PE0yM8nj+df6/CYTPO6BAJnBRtNQswQRbb5RMMmS5Qs=;
 b=PDsEDwOG+XniPpXeYrMuqgzUrG4sUodcJdGnseauLgfxiGqdBv48GkFW54KvPzXfj1Y5rohuX3KpnKgZQr6y4OusHVVQ3ScsDpYEzm/lAMi/AHMI4wnahu7JwC6O5L2ev1fq5IwWPa7P8Mlaa6ynYZuiK3LUbk8TVzEVcOZv2QDlcvrZLFdzEHGRZXRGXX371+xLmt+laWYuDqhaSKBw0YugJ32TWU0AyAC8s88s/S32VjvhcPX4DZEMaVrB/JrEBzmKp6z7QQvcZxX8E9MPazwd9le8O08E3cRSwpWK2eGiIcqcK7wMzY+inqzQrRL13DPyH33BUXmwfFDKsEDu8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 01:34:05 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 01:34:05 +0000
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
Subject: [PATCH 0/2] rust: pci: display symbolic PCI vendor and class names
Date: Wed, 24 Sep 2025 18:33:57 -0700
Message-ID: <20250925013359.414526-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:217::29) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 9daf4552-7baa-4cbb-ad05-08ddfbd39d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DlYvCMc/Q80mLjgZ3864M8Cen++a6zGUYi6q9T7Y3DroZPNFpTz9iMg3tMfb?=
 =?us-ascii?Q?yf5/eTwyLh5wVBBsGQZM30fMYHpVshbNvaNHiGwud20lBOGVcBqhAsUYDmL4?=
 =?us-ascii?Q?ZOWu40F1vSoWslOSMOmcpidiLgrwtgWMRhfEqmIvAQbISY3fc0Q+KZ9J3vOJ?=
 =?us-ascii?Q?S7e6SptMfrRW7DQeUQ4R8k2zF+6YFRTzSZ+DmtobDcl5guNgClF/jB4oji9u?=
 =?us-ascii?Q?lDUUY+4KjoztdQhpQXlgi5BVsGsDIWRtrefXqkCu7K9UZAoGdYcSKiOKn/Dv?=
 =?us-ascii?Q?yX5QNKbdk6cx0+n+10T1lVVmP5QsaXuxM9wUBwbe/41dCW/S1MRn62oAh8dr?=
 =?us-ascii?Q?OjuV51e7T4z8pu/9z4r9SmRsD9PsqUhYrSKSXK7oti2unpln/GmpBVL6VWx6?=
 =?us-ascii?Q?2Hfms3RSCEzz2Dw7g9RU9Ji70pdm4sy5EdmqaDCuTFbtGsLGeX37J3sdDhaA?=
 =?us-ascii?Q?G7uSVIKWF2w6ABVPwKDgCKYxQUzXIKon0Gwh4JgBrAa6KraR8Co+W024fsk+?=
 =?us-ascii?Q?l/jDKE6wWpo8HCXko28n26Q35whX67VZOff9ZVGYg9v7Ov06bfmKAbODeiPT?=
 =?us-ascii?Q?WmpZkEGjggnZ9yGBv2y/j61QcHrZfRpo1bxXdY+SdZMfQf/EVPfI+grf4bCw?=
 =?us-ascii?Q?nb/L1FXiJj2i+90DUOVDdww3fMCD7yLM6oZU/qYCBPsna2Jju5T24/RT1bUB?=
 =?us-ascii?Q?D5ygRrlWQah5W7wmztaLxu8anUcCudftdf+JEwNW2hc0hFQlG+4GZS+PDWCu?=
 =?us-ascii?Q?E7cE1v2APDrpJlm8mo55ReBBAf+ylKlFgyk6ePgZaKBeDiZXIYxXdXjkv3YT?=
 =?us-ascii?Q?aeZ1mFg/eZa9fQpsPHbNY17PDS7e99o45tUrwC8aBdEaGtCoSjtnkv5eudOD?=
 =?us-ascii?Q?Q0YcRgEDA+4NcNW+ENjaYTSCjtWThgRkjt9tz7JCM/lHzMUXp0ir+cDmsPmF?=
 =?us-ascii?Q?ab4cuUruiPtfc/kfRw446O/ya7r0F1TcAGFtYe0eXBX+fOF/apqxNAeYb7mK?=
 =?us-ascii?Q?iDwISkYwY6+L0gtFKRaKkDgN+Ry5rn2VOYszRG4DDwsaVwFWo+B0UkYEfpjL?=
 =?us-ascii?Q?dmrB6v10a7VijJu7jUYDSL9w7UXFjc+X8RCYdtaiB0DXMMlndKbp1UzWlecQ?=
 =?us-ascii?Q?BmNzz2MpqVARzTpVmegXKeqg/YalqiSMBvEQHPOui03OmcuUDVUiUAIP1Kqq?=
 =?us-ascii?Q?JibMEhXK/v6fDNY/I1kICLDzW4x8LpnxzzTwt+rccpuHYMJku0IUFUfG97Gz?=
 =?us-ascii?Q?ForSraeRbf2emYlKv9mI96d0vsFUIhBKEQI5nqOxHVp5tjJ3+WAqpjyAkcXE?=
 =?us-ascii?Q?qpiSluvBvNPIYtQ91oSZ85t29+5DLMYRlClEkgJ0BoYgl6dZWW7cp/50WJFo?=
 =?us-ascii?Q?/Hch5BcoF7kBIpkP8osn/1v9OYEiHLTKFPccbabGjqEBaQJZ0lthsw6o6P7o?=
 =?us-ascii?Q?I8IaE6UeRlbPk4Da3STiI2oJBcwkXk0k1XpLF9Rooq3wc8ooBqmqoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6A0xxrCOSakYWWfaLJmSQCk01SRm8k5NYbxkxpLdKspDzhTDqCz501BzQBwf?=
 =?us-ascii?Q?COJf9pY6GSSa3lCq9GVnBN5wLajkbk0dXddkweItxhAwXGuunXYyB4cA3/y4?=
 =?us-ascii?Q?1XMOQW8MslUgubVs6+6vLiLzdUBcyrFDFWYWjeBzjMym/rqIZ535G8RfbrGj?=
 =?us-ascii?Q?05co6Gu6toevCHZ6iaNSHsUa6dtBpQtyAEKlGHaYRnDISxEeyD9g8mV0s4rW?=
 =?us-ascii?Q?eob5K2nZDnyyvh++p+7NIP09tAF4XwsQfEHId9/SvhvNaVgCB9QjUgvwnp/j?=
 =?us-ascii?Q?wEMtcm2VQZ6+3k1GD0WgA0zFiajcTFDG8Ph2XTgSY8VsddNn9fdu5BafpMS/?=
 =?us-ascii?Q?Ew+U/AJHPqNuIWShoQsQ2z8zrX2xvxEFyz1RMMIzxC0/uQVixukPe5Q2mU7i?=
 =?us-ascii?Q?pf8o2eXxKxgtJnwsQmFoRc1ChsApTGnYh7tCg2ykhMilALxYSo2aWoRlmUkp?=
 =?us-ascii?Q?WYCNF7mq+sXGnHT6O8O2NfSlhLVa1pHQVu4p2t2IFW+w9Vm/auIZGfbF2iYo?=
 =?us-ascii?Q?Y+vElM1bHPBnQaow532KSvwxRywAeiqTZ3Tem1vrmSlLgedNQOtiux7bkG6i?=
 =?us-ascii?Q?tWPFj3sEkLo6DF0NsrAce80J6KJ+imXJ4nfPSgKLQKra68ifUnpVNdIpY3ZJ?=
 =?us-ascii?Q?JtTkmqHZwa3diBUbYelavk7HTVcUZ9YO27Mm2ilDKsbwGzN3Or1y/TzoIWRt?=
 =?us-ascii?Q?fY+PrxmDLGOCyat5Ie+zNxdkJN7iAjDmr2gAJeR9JlSjhEfedbmOOxGCVeu1?=
 =?us-ascii?Q?mGfC0uhzAnlH9K1O0c15aiewJCCDwep1G/h2wEXYV0jLoidXMsofroq2hKVx?=
 =?us-ascii?Q?vJRD/dsmveLbmNlYqGXEalEJWUJKfPEIHrudkwcpz6fjQL05Wl2H4NtcJkXy?=
 =?us-ascii?Q?p5jIO4FGtmsXTQRwIeL9hc04SCUl6MFP27gMN5EnxxlfMOw6+sELG9PkwPpI?=
 =?us-ascii?Q?oS+RdlvKGtXzmMSkIaAiQ+0vdxiDo7xq9ytp5o9AsIqgU9wRjZg97c2zPYt/?=
 =?us-ascii?Q?m8RqeiyJTHmfO/EjYYDz8ulswU6hgijySV24IrwCD6QBGBcWDU9GQ0zfcNDS?=
 =?us-ascii?Q?/7WVN+BdUgjTrnFB+9QYA71V4sbhvrOZXoCkPlf0fp+8juB3fzeAXBAbqD3j?=
 =?us-ascii?Q?MxzgFlsVqt3V4E+LsUswTxkY5u0fFNv29cABgRoEL1N1voOZzQFU85afHoIg?=
 =?us-ascii?Q?ONYD5QVz2THPvG2eSyawAb3uVkZdWtpaSp7VtPd2RMAMmnkc5DS3xeNmbbMZ?=
 =?us-ascii?Q?aeqKftvW6QV+zIR9b1rmOQRO+R5UmGb3eu7TweBfFObCc3xczO3azx3NKmwE?=
 =?us-ascii?Q?9qm8vYTEj9P5usCZ/xOSvcALasJ1W+YyUr2JwgSt408bLAPQbzQSZiZOtoEY?=
 =?us-ascii?Q?bvVFOpy8ndmwzjLxaLwxHiCSN0uAA96V1pcGMHxViYk9V4HsTLzGAm+szf2b?=
 =?us-ascii?Q?wrTBskosJObG0nP576ESJ4UsfjvoaUkZdBaYZSmM8PIlfyrvtUEeEFTX2DHu?=
 =?us-ascii?Q?WVlFdP4w2S4lmC2+crtWMtEWwJLpCyDycf/QafulXokpHuXwtn6ALb0Y11Xh?=
 =?us-ascii?Q?eJDUeo7GXKDt8atb98gRhrFWoEZkHZWlFcVUgFMu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9daf4552-7baa-4cbb-ad05-08ddfbd39d1e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 01:34:05.0880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyYsQ/Svybeh508DDQb39fJBUtu5SAojz/siZ71KxFN07UC6JzPGbjBHQmrJQnfmXPU5yHHGyaj+8CE015IlNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879

Hi,

This applies to:

  https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git

It's a small follow up to these commits in that same branch:

commit 5e20962a9fc8 ("rust: pci: provide access to PCI Vendor values")
commit ed78a01887e2 ("rust: pci: provide access to PCI Class and Class-related items")

Danilo, I've added your Suggested-by to these.

John Hubbard (2):
  rust: pci: display symbolic PCI class names
  rust: pci: display symbolic PCI vendor names

 rust/kernel/pci/id.rs | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)


base-commit: d4a5d397c7fb1ca967e0da202cac196e7324f4ea
-- 
2.51.0


