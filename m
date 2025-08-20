Return-Path: <linux-pci+bounces-34334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8EBB2D251
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 05:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294197B42E3
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 03:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA34F26F295;
	Wed, 20 Aug 2025 03:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B72gnx0O"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDCD259C93;
	Wed, 20 Aug 2025 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659351; cv=fail; b=rV+EVlmJukuMPwHI/Q1aq2wJF5uK/V7JaMny4PbgRzat6JjHW280VLHGu2eJ0jZfVU5QDt6ga9eWbNo9DrXUN6UTSxOeRhC7rwBa5OmxbUTa3iLUiGKZKHZBbHXDOBzsuYF1nyy4HnPzSGJ60Tg/eur8+gArnIVxb0cDTiXJ8r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659351; c=relaxed/simple;
	bh=eBaFvvQdc38+PuLa6+IGAJmT7CuPmoXfC0rhp6fELiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bm4komdgNb8r1+Tlw+2jFjsHzxfMGzcGdx/fnUmL00DyPlfOfu5kCdIY1Z0nLL1fCYBtQp8b8JBzsi4QtlXJRyVaHjrdMPF1+COKIIIf6EMcl25QRmsILQxqS9LGnP8mHRoA19jkz8JxjSHjuUb3eww+Ebe+0YtkxXMuwYLf7l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B72gnx0O; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/IkYXyYHYan8bOJ/Klf503KHlyWtgpjHUvi3bSnbicv66WZYqNsziPmms8QxdbPGfGzCtlhTwo7mMVWGsO20qQUegiKnO105N3jdzzP2gfGbvA0XlnI0r3vkX11x7NUH7BL8/6sdNwDZGoTVVjG23LZMuVZGOqlhOJjtdH/xHhS58ckh7r57MRwKj+yM69jHT3uc3i+kk/gZKAZZ1fb1ZlJx9ktpKH79cKkQ2rH2FgNq/69Pjz8q5ssr2K5SohIoVz5KAdZs71Kv9qi1h79e+MUu1GtSzUyhXHvm+UFWnKySCrGF1Sk72yb2Ui2Qk7NnR59g6HaWOrsbVwAo48Zow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgwQa6nEHdcBRHpXUcKe/Gq+vjlI9jTIgkB/2zraMos=;
 b=NDdOJlGkplYq58BN6SRoewGl0zLHbfYcGya9deGP9YcHRFXx+J/aeL+BGN8k41h4Peqs02NrvO6BND8vy2pAfYUEB5XaVnyRQIYof9sxG429iHe+ordOIDYjuHApk6eQ2Ng2vtL4YVd4yeUnLMJds1i7OOHknSndWUhbo61qIhQjTqj+eK36HgSyjc1qz0iTW/pN0KM4E2Q8ta+K46P9Yd5rZtdv7TjOZ1PwAp/pk8uQVbCMUliTJ5a8xiyO9cTqPgY49/kNWxsUH2h5bOtwMHZOQMcA/AbB4gh7fYkYXZYWK20lm4mlWqL0+YTWxdGORe1DSvSWHbSWvxlmobTkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgwQa6nEHdcBRHpXUcKe/Gq+vjlI9jTIgkB/2zraMos=;
 b=B72gnx0Otn0wx/QHxjgM9u3HAmB/pLn/fu/3E3zvLEAuzm/L9k2dYKyz3dt+1EAiJ4XHCdYSLLi054AwxTQK5BrAnfOaidkJbYGKiXVKiIe86dip7GS1AnK/JAm3NjaOebEkbwM7faQ/7t0iyqVLX2RswxcY1nyP6U6/LRn4cCjUA9gzBHqAWVZcDuq1mUxoBXnZfEIGU0J2bc3/bjgytcmoZ8RIVlBk0IGFsDos7rtyAdq1vFboMPiUF57ecfdzE6YWZSCJe5+erD+JuaXcZcA/D35y1k05mEDh6h3IcdBfUrgY3zDAIOXGvqrPUMe+1ZiPDosrdxVupZn+kFUtMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 20 Aug
 2025 03:09:06 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 03:09:06 +0000
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
Subject: [PATCH v4 2/3] gpu: nova-core: avoid probing non-display/compute PCI functions
Date: Tue, 19 Aug 2025 20:08:58 -0700
Message-ID: <20250820030859.6446-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820030859.6446-1-jhubbard@nvidia.com>
References: <20250820030859.6446-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::28) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 50dd86a2-5c5b-400d-ebe0-08dddf96ec3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a8nwsInR1wj85axdGlMGxojiac0DtEfo8Eb1DZBvUSMltb/0uFJWGZPg21ST?=
 =?us-ascii?Q?SSIO5O8mEYg0gR0cr52WmpRuUcXxP3+TZ4EZwYM/gJT9JsY13h5BhUm18hfb?=
 =?us-ascii?Q?WBY9+8aKeiIjKdxSL4XWdSUpwzghTJrjcpItcW/1IUjV3GczZdvjSck978/w?=
 =?us-ascii?Q?1DTob9gFvI9vYccjNEYVXgGMMw+344AE/r7QWJZYUrB6RGiWjl0ZMWbfBZj0?=
 =?us-ascii?Q?flRbnh4wnSF1pIzjo+DHa8cHCX8c8UlujEHLrF2F8nJ1oQjIr8qsAnTVj2Ld?=
 =?us-ascii?Q?GvQpztMXpYbOYUThDcl3WZsG3SVQY9/JFFA2SzuPwtPe2xzn/QXqbJQqXgWb?=
 =?us-ascii?Q?ZQ30i2dlUzaEyiNOc5vozcEpivZW1qCClMeim8AzXkgpBD19UgBuuVHh4YcO?=
 =?us-ascii?Q?AJHXJ7REnAqP8Eo19/sh5oOVH7fJRuT5ZFQCMR8YzBZgMrQHgkskoAwt3Bvk?=
 =?us-ascii?Q?HDX69NLhlHnNEVwlOJ0WqfMXRsRoxv8qQpvf4A4spR1te0KnMtLVwAeVpEch?=
 =?us-ascii?Q?8lsqbOqD3PzzD09DnCTqExByu+LOfOnZTiDgjLhUy+LiCg7x98smcgAsstoF?=
 =?us-ascii?Q?nE/RtNcGigW7D//gWQQApVkbecPrUDv4znxbBisu6n6d4D/QZdADARFn6vZD?=
 =?us-ascii?Q?2kTv5ygY60ZStm42Aq2NAVEVWni5rHlrd7IeU9P7iZaxlrQ36ZFXTavUnAGs?=
 =?us-ascii?Q?z+HLyZLlDjP2gwTsJWXJ4yDb8HSW9crHZpFmKb2ypJi1XL5jX6en90KK+hHS?=
 =?us-ascii?Q?VjkOpIobLk0X2XzRpHiTnkcGYo5nqJR/E2ldHAlNDvcNyOYeQMFkG9tKpmQG?=
 =?us-ascii?Q?shXGcQogwHvUCylK78Fvyv+42Vj6rFDrC+nZxbp1FeOuVNwKtq1qZepJy6qC?=
 =?us-ascii?Q?yKPXqxE8oLHNHVctGZTkhIQBLHFITIrU2vyv0j4gGWOuSp2cxdvz40McosPp?=
 =?us-ascii?Q?vQVHtW4619Kcrpxh3Xi1E+soa10095GzDRhygDdAEpXCMAiif4/jMlwkG7EM?=
 =?us-ascii?Q?yn8jkI/S9+rSPFxH8gmdDINOKDaZ2uEauvHCtZ3wVANAO8qCd8Fr52z/GRRl?=
 =?us-ascii?Q?yYRAq6r68SX7oEzu03HAi9CUKzCrD3xynuEEFpXQCdDLyvBYKCkTykoR9E43?=
 =?us-ascii?Q?HEu3XoDaMXOW30iPm0lZKVd0wi8FeFlbBrHmfeZgfgOmrWAaXASwqYwLxmQq?=
 =?us-ascii?Q?oGgTRvyAIysl/62aLF0RkHOnWvnTbYcOYXWepXiiLbHGoaJYvA5wgvoEZiVU?=
 =?us-ascii?Q?WbsJaYvhpJ8WarlHkCf39mGldlV6iRkkYVpLF+6uaMulHVfRmMV4ZVJiSZop?=
 =?us-ascii?Q?NQ8z0oh/rngJ4C4TTeNDkW9mKMD0/FmUmJNo7lXdrOYT1yzzfaABCi75ei0Z?=
 =?us-ascii?Q?OJgc6ck6U69eH+P3uQOn6J8szkdS9EgUhyHfKbKItX126rQHY12Q2qmtUR1F?=
 =?us-ascii?Q?w2fmyJ2Rz+g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jLcUasNCee6YCVAhWVGm13cT0R5jf+u+Wd1tGU8DN2ykS46humQlBbjxoEYh?=
 =?us-ascii?Q?9xN5uJpScoRUZKpxopBaNY2L3l9sjyOFvJlXbDAiCWH0t+3OX6i5TpvzwkDk?=
 =?us-ascii?Q?xZ8vqQcYf8NaLLK4E3F62aFz0kX3ccYQYvyvjv/J82XhYf5MZwPSMoa2+FOO?=
 =?us-ascii?Q?B7d2cmTAQ848ri4x2RKRNcE0Ur88G4hqa2qzzD4XNB98s97+TEZQXkQC7pJ7?=
 =?us-ascii?Q?bdZVageO0FQydRv/zRA1DuNmqj3IIx8hxg56SZE2cQ/A9sNW1/NuYcRkUD+m?=
 =?us-ascii?Q?BRaRz3O5fpULHfQ04Kvg9Oq8bNOtHaoa5XHa4wUe7nzoVG4Fl7/e1YKiccNs?=
 =?us-ascii?Q?Ao8RKC3PmQQJ18q8axi5ZPmdkFxV2SO/R9BL94wznPo66q3872GVpBP1ek8O?=
 =?us-ascii?Q?Ii7bUBELn/GzM41/LHmmi54FX4pATjDbA0hdPkCdkdq1LL8N9Df/+YrJYvUc?=
 =?us-ascii?Q?1y63J6YV+s1eBFMvoXngWTDBcTVEn/oTVdUtpImx/YaHl/U+H/gIWr2zrhgd?=
 =?us-ascii?Q?DDM96upcdLHF7duR9G+GT+qtx3ZNQ9SUHO2O3D5CvCRQaKmXYZ2Ckii/rnQN?=
 =?us-ascii?Q?PZPjgVEBncgbolj926lpySdtY78u6c3y2K2X7CqT2czkg6HtCOjHy5sJLSZC?=
 =?us-ascii?Q?9kXG3u4d5d+30hLt/X3Fjlc8iyDwSjB+3pvb6Qbi2O1d8z4Yhoi04uwELzvf?=
 =?us-ascii?Q?LgeMTIuVyDoFu1fTzvNi9g6wHs1ttOqGXluCxK9dda/B7A7hdVBQzfSelGsh?=
 =?us-ascii?Q?QdKbXY9xF8dOvSgEXh7dfJRCs8peeuPWiDTp0ytdmEuR2ztAWSiIJmpApPf2?=
 =?us-ascii?Q?CltXrQlo5CKhD75iysxVTcsv0vPPu/b/cGWtdbaJLAtAhnkK2W9RjaO+MUUq?=
 =?us-ascii?Q?sTn1TX3ZfwgNc0c0AqHWZcEHXGZps3Un3ROVpBh8xQpc6QM4Rg2br9fMy0qf?=
 =?us-ascii?Q?FVrFSZ9feSopVUf2lyOv/LQmHlOv8/n/cktHDkGZ1t61el0MEV+KU4wLCLg4?=
 =?us-ascii?Q?0m+kIKcGkTZagqDo1te+DHYM+JnbL9pKVxGG5pwfcXRcoDsaNEbeU4Unycq9?=
 =?us-ascii?Q?ur2r+TP1WkMMQBnEsDqaXK1Gcz6dFw05YBfgQWNZTCDiphdkemIShpAK2D6W?=
 =?us-ascii?Q?chbRGuDLFphoiZtQknr2Gmm1vfkEG9bVGROEY5epYjOqVUBrGXT5u6JCjiMe?=
 =?us-ascii?Q?C2KObgtlfetO9MrsPHgd4MC44lWhm8MemGJojOvepr19ooWB4xfyMkylr7a9?=
 =?us-ascii?Q?pUV83ZdAdBJwrX7Lw893WQQmsg4MQqa0daKJfF6uLUGYeMC7FecNjivNBVaj?=
 =?us-ascii?Q?+6krd3LTXqbJ7DNdTeYdE+5HUCIn2oFI/UDt4wLcpEfs7iSLH2/o4EBWO2SH?=
 =?us-ascii?Q?FyGKQw6BymhyppJKxeJkz0ITwWEj4AdTk5qbLUJ14TuzfkgvUOgE2fMMV1NF?=
 =?us-ascii?Q?Qn5CRPnHUTjzUwy9zxUzjic24ZKwL9iUYUmqQBCxTZjY8J3v2RLhtvUVjV/Q?=
 =?us-ascii?Q?CQgIT0z8FAVTfGeqvzG3zKHpypJfboLnfdGTJNfPIarxIqbUbNvNgzdxOEiU?=
 =?us-ascii?Q?eWV0MSYeIpWh19bZtk+rm6FQHSjmeLXYN2sV8F3z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dd86a2-5c5b-400d-ebe0-08dddf96ec3f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 03:09:05.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gm1HpbVPNpzQhplVDdlUeczBMhvpvGfc5uOfQbvDFIGJjlf6FTEH+BAqDCJm0qTxkmTGiYLmpu6Ke905GwUv7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174

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
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 274989ea1fb4..b60c9defa9d1 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*, sizes::SZ_16M, sync::Arc};
+use kernel::{
+    auxiliary, bindings, c_str, device::Core, pci, pci::Class, pci::ClassMask, prelude::*,
+    sizes::SZ_16M, sync::Arc,
+};
 
 use crate::gpu::Gpu;
 
@@ -18,10 +21,25 @@ pub(crate) struct NovaCore {
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
+                bindings::PCI_VENDOR_ID_NVIDIA
+            ),
+            ()
+        ),
+        (
+            pci::DeviceId::from_class_and_vendor(
+                Class::DISPLAY_3D,
+                ClassMask::ClassSubclass,
+                bindings::PCI_VENDOR_ID_NVIDIA
+            ),
+            ()
+        ),
+    ]
 );
 
 impl pci::Driver for NovaCore {
-- 
2.50.1


