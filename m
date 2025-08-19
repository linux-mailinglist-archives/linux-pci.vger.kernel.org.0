Return-Path: <linux-pci+bounces-34236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCA6B2B76F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 05:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C40087B05A4
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 03:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817482D249E;
	Tue, 19 Aug 2025 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TSOJONci"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FCC2E229F;
	Tue, 19 Aug 2025 03:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755573095; cv=fail; b=FTVAySFG/zR2HCLtNICIh2L5Z9sBNJGODXMMVUZPTpHztZ8dY57ILd9JZIYHWoLhFaR6Jg+ztJwPCojLA5Zf3KbZ+55hiL3wzkk7lVedzOWiDVZ5ZzXORJ3T1aLG/TWQaEYmcDObzq6kZPyzWVJxnXwIjq3QRpR6z0sPZJrNwI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755573095; c=relaxed/simple;
	bh=16tkj962GCF8Q7RtS/C1q+wihz1CUvNPMHECLrfsua8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H2HIzSDpgpOltSKWXGneIC+SUb4owZLx8/ehoNC9ZyaDhYlkRGV3LBnoXFskWeD8lDApnDqFXaFtcLoW7siqgtv8WstWa9gBQGOkAhZ75YwmgSPg2NxLFpRWnh3F8psWHN+UgddsOS94Q6hyEDl3ezQyLPEpoL1St2E2wdHEIZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TSOJONci; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U56qz5XRzcRru6GfvCd5hlQjEW49P3YBjoETE/sTNmPRxxCpIu8fjLhSs+7pDuRhrQunvnZmO9TuM+Ndq6helYcYHdb/AFjQjUEvCz0v0dPHl19IsAl5UBr9zMiEdhOulXXlC/Afh0581byesyXuJFUB1XLPqGNWwn7lDIfMQoG+KosnzHYXVUjZVc7egZmBebiuM6kJj0H6HdlF7sDSxiLW5v/PzI5DtHflSINr6GnI86tz/Kbb0O4FgmrzNdacsE2+LBWvuuz7SK0dbcbXA9N6rM1jW0tBTU9zSSS7/4ELwV+3erNzaMfiC3XxfngT+b5oQB7G6wN0CeX/OJCvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfpFn04HNdTCzFpvoU6q0HU/JTR1RZCHIoG+3o52kgs=;
 b=Zqc6kEbwn/eP3wl35SXXdHTXMrFedemjmCE29ybOscREdQH7SQSMKlA3CTcNt3V6VtgomAoF2G1oo54nbM9kzcsJEMcEb2bYv1enboJULBKx6masWQWKwXGXiOs8fuI03IfQ/SlzI7bkjcHxJn+1M53UGpY/PBBv4HaMc4wkfBDSa4OrCQZ1YFD3t0/jIZNOKBoZvTNS6g0eD6xbUvrKWMgIRFRWqJk2QDyMGP1vXLK0jPOu0Athfx9Q8jX6s4GL52ciWNUoI8jyqGSug9RWTyjYFY2EQ9Tjyh/ZS6S+a+tydAQAAzCDsLFsKbMPQ62TKBSl4Mo6m8d2d1BqQcnaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfpFn04HNdTCzFpvoU6q0HU/JTR1RZCHIoG+3o52kgs=;
 b=TSOJONciNtW4+/Tyb6C2ixEpHPIiF6mnmRmUORvTuw9IK/ieOhwzKGDgWEkn8UXpDD0jDj8QjO0N757VttZLt/UWikmJ6BPMGQ2sYXbp9tOiRPCPZdk4aIGNsGO0i5OuImWlHTCenoXINt6I6a5fvDX5EPq5ijkSe8YLzkWPHh2UKWDrJJwvi4Lump+ClDSxbc3Z6o4xLCSXJRWjO+hvaeCvIZOXz7isH8uukVqE3PKL1ulrUw69s1kHVH9LAk3oywyYEt+XxqZoVXaQ5SsSBZqm5UwqkSn3SZoK5MQrIkOvstqnbvW+kkZHs2vBrCsDW2ASgsnc7NzxS7CX879jNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 03:11:25 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 03:11:25 +0000
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
Subject: [PATCH v3 3/3] rust: pci: provide access to PCI Vendor values
Date: Mon, 18 Aug 2025 20:11:17 -0700
Message-ID: <20250819031117.560568-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819031117.560568-1-jhubbard@nvidia.com>
References: <20250819031117.560568-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::19) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: aa689f84-205c-419f-a5e0-08dddece14d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QI7YBNr+M9BNTBDV9gJ7DBQSHtSss35EXwurdGF6YL4zMofAgkBCx4C/H5pw?=
 =?us-ascii?Q?sYysSrT7eYJJ/5968kweKBnNGkmA7caQkQQEnyRIXBowA3lJZqZm+uZjPjNZ?=
 =?us-ascii?Q?zWtqkwq05P5jtI2nOnepaKl+MSRqAETn372d1Oq9W5hGhRalIGuFhdjBQxhu?=
 =?us-ascii?Q?mcXyTvXv1cV2iXefeqrbqZML7ZlSpQu3l4OCTDezrwbJDalnO+SG0bftuaJ+?=
 =?us-ascii?Q?BMjpQ9c8sqbMODxnskM+2JbnHUEVn36z25WLn89hllJOUDc9oNUM9NbO6Uee?=
 =?us-ascii?Q?PUbZ60DIjOAcIwB6+tRtXGQW/cYymqFxuwIlmg+b7swBkc3NjEN1MQB1hu1r?=
 =?us-ascii?Q?5C8Lt0KmtxYg3BDrMvYSiLfUlQGO1vbhZkUj2vU0IG5yahj5u1/H1Ps7silv?=
 =?us-ascii?Q?ZGFJG0JcLw89DjDDYJgrb64XJDAwmU8rR5cjhI1IrgIa9JqUUt9V42speAVq?=
 =?us-ascii?Q?TeajjzSmJMq3u6Xom/aNoGrDaW1Pt8piLADqFSwOLMPzCjStrmTS3mi6p3yh?=
 =?us-ascii?Q?aIbWsCSWJrfpcY2Bh+UfH+MaUauGkNLGNJftK+4FbETzfhDwX+6FIRTjqpKW?=
 =?us-ascii?Q?3mXvztda4oEWu8T0OG1Sc13udCznGWtz7iTtlYzqjSUYikLN9j7bZTFyjxLx?=
 =?us-ascii?Q?cSR1ui/N4Oqroh+lgy5tvueZyKMqgFHaAAA2iCfSITzH8N1RPHzg0uPAHu+V?=
 =?us-ascii?Q?AibS4qms4suHzb5O6/78lq2pumRzTRHQyqTtjt/oi9DqpJOrc7XQtFsk8xeD?=
 =?us-ascii?Q?ory8R018rFM40rN7ROA4Ww8SqrbRwqTPI8Nj2TKxecuuotXe24auLNf1D5ah?=
 =?us-ascii?Q?rm5rAeYm/ofDZtA0/DxVrwfcFjsYt1rEIbrg3O0bjpC23AWCMfzhI+59g21E?=
 =?us-ascii?Q?JZBMo/HgbxOEN13C6iyEGBmnJ4ixH9x3jze0hprLm1pq8LpwPuGkFQk+3fS/?=
 =?us-ascii?Q?jmOsq29lG4It8jYjbNJkUprbiUkFNyI7BkymHgEHQaj6yjPYYoqrIP914bVz?=
 =?us-ascii?Q?i0EvjnsfWtt8hg8UdeY4geG9yCLR/eH4i2/Ls9tVcUmtKqAyPa+Cf7Ix9Bkg?=
 =?us-ascii?Q?CH/0/jMbB87gh/WpPE72gbDRy9XtFlJaKpbfnQ1W9ZWhvPnvKi3wmEmHjPNK?=
 =?us-ascii?Q?JnIPQ4yM79DIBehucYCPoFaI+nzvvqZUprAr+yfLwt/F8fpxLufQgttDBNyL?=
 =?us-ascii?Q?MvNFsxFzaB0QN9LiABryA7WRFeGWHSozX+zJ+PEmxOnZuqhHt+yRfu9xDIKc?=
 =?us-ascii?Q?kXTjciE/8mW4Xtp60ecu8T354RqV/R+ZCctekUEPG5nUnnHAu4WusiPl2kmp?=
 =?us-ascii?Q?AFWJUOIYdO5taesPGgHhmOfpXVdJqp++z9qpznfwEHGEaDQIfWTjpedaMarB?=
 =?us-ascii?Q?Olp7GB3XbiX8uVTTsi1ot6ysO5uPL5DnXGm7q3R8f8XS1+nCaXD1p+YHu6YW?=
 =?us-ascii?Q?W5TACD3A5Sc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?orNrPj1JDADjiuhBtjx3TMDVWRoa+xfFSBVGN0vgo+Dsr+Uktdzyg2ewaNsg?=
 =?us-ascii?Q?hsLrGghHcl7Q/bGj7YqKKE2fQkAimihcc8KdJd+iFOU18BGyNX8aZNVffZVW?=
 =?us-ascii?Q?UnokNUtmqYiO/7SapBcAnDXsx8AVC1neJHcv7sMdIe6jyvBziYNDmWyqm0wR?=
 =?us-ascii?Q?cOMONUXSgQem0uaPHQQW3J60mHxaXrrskdt/EdEMrX5uAMyTTuRhSOcNJZZR?=
 =?us-ascii?Q?F1jWcas0WSdVD9vOYIsRSr9nSKPDs7gisDx3ZsaPaG1nf4s3hxBxzDvBvYsn?=
 =?us-ascii?Q?To1yHdMtc9Wt1YUoZOYZ6kY3u50ma+x4OQx43ZpyDF8feFycKgvlLhmeS72S?=
 =?us-ascii?Q?VsbzCgM+vMAnPYrsDYWVyrIMNrYYWHFTF6RPPMPfDZgdhekkLXgPlgwzUyR/?=
 =?us-ascii?Q?7ICRagS8yzKbuNPmCEGbrWkWL0Y5XDByWR529mpU6Slm6Ya3xvDDP1bBu3at?=
 =?us-ascii?Q?sPcjkpL4CazreWzc8/+n6Ax6LXEbUdi0pTnFn1kX9jJArNq67MfOsuJN1wpf?=
 =?us-ascii?Q?bKYtwYat8wkwvzSrZAH5Ej/KT1YltyMtdKU2r5UOybrBtbPmeZ87y4WcZksI?=
 =?us-ascii?Q?kMtwudr0M+vVU6G5160kh6+mbIb1iivkMQVXeu83/g+bIvgKGUjjDdaiqWGc?=
 =?us-ascii?Q?h8CghsVAPp1doQhGZkI5cBp1xC/d/1ysTD4iz8W6Tc+DUAKzQBOwnEiT/h5B?=
 =?us-ascii?Q?tO/XEMamsr3QwdXinkGu7Cp0cThsY8y7RnfiFlGSFF61EdbL0ja2tz8F1Wp9?=
 =?us-ascii?Q?7Sxm6tiDMvT+ualqOY4WB0Qk3xxhVa+264GGyy5dl8AH3R3U69td7EUrLrz4?=
 =?us-ascii?Q?9/A3PkEA8HiYYBkVq8WiO1rEFw3KkO5M4Ki2QZoEi0Rv8REAr5iboEnjg5IM?=
 =?us-ascii?Q?E0o+HviaTLR0SbSh1OSZN0WduTxWBjLkTJXQ0aXEFTvayVHnmBg7H2JpVOHo?=
 =?us-ascii?Q?pNGNvqAZABSPwvnYXQWW6y+rtSvwxN4cCXszSXX3rmXxTvbp8lP9lCJ/zh7D?=
 =?us-ascii?Q?J0bsceyrc7i4vk1SjJbMHTw8+Mi9WMp6Rra1UudHB8+II/flrv+R4Pt5b5Jl?=
 =?us-ascii?Q?XwzJAubHhNsWEKfBeU08ixn3CTwOOlWmHOYEhe7Em4RIcylO6VAtg7AxLy5K?=
 =?us-ascii?Q?sEfcZLrNi2KgHF7kNUj0S1t0zfuEUDfJxkFx/FHXYEioAMW1JJdqxdNCwnLi?=
 =?us-ascii?Q?gI9xmo9i96I9cWohYOI7UhIWpZvnuWerSPukg209eFnGCx951bdKL5Zw6iSt?=
 =?us-ascii?Q?YiyG7/4AbQ2Gspy27Zembol+az3wFbV46dJCh/lo5hxtietAZjmoyLAH1wZ4?=
 =?us-ascii?Q?+9P3MzFhffpQH/+YpuBXWjVnHtCxtXtYiHXusdO9+9j+l9NTS90o7TeFqkvS?=
 =?us-ascii?Q?lurSGOQ7gbG60+4HIZpQ9jpEV3ZipwKqEDHwGTjLZ7j96StVpgZWh17haOzl?=
 =?us-ascii?Q?NZnoG4yIIGZ+vqY02u0zrsy05jeaFLdzbMo0YfegmDhvbYkCAL6TDX8esZJm?=
 =?us-ascii?Q?5h/awYYBeLH37L7NG+OOyIy0MHQJKT+8+NLJoUkZB1HOzn65h7x+alndjEfg?=
 =?us-ascii?Q?4b2E+Kp8mcwC2F9tdba8MLWHhq7Ik3oo52Hkwi6E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa689f84-205c-419f-a5e0-08dddece14d8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 03:11:25.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5GrgEDrrTjE7gQghoQkXzwV+2Yn0c8yMNxroVhNRI8LHc4b5EIII2ZFT1zZbUZKEZVmOnbin6osRwYfsZRWRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095

This allows callers to write Vendor::SOME_COMPANY instead of
bindings::PCI_VENDOR_ID_SOME_COMPANY.

It also allows removing "use kernel::bindings" entirely from most of
the affected files here.

Apply this to the various Rust for Linux callers who were previously
using bindings::PCI_VENDOR_ID_*.

New APIs:
    Vendor::SOME_COMPANY
    Vendor::from_u32(), as_u32()
    DeviceId::from_class_and_vendor() now takes Vendor type

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs       |  12 +-
 rust/kernel/pci.rs                    | 351 +++++++++++++++++++++++++-
 samples/rust/rust_dma.rs              |   6 +-
 samples/rust/rust_driver_auxiliary.rs |   7 +-
 samples/rust/rust_driver_pci.rs       |   4 +-
 5 files changed, 360 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 4ec5b861a345..d0272289f863 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,7 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use kernel::{
-    auxiliary, bindings, c_str, device::Core, pci, pci::Class, prelude::*, sizes::SZ_16M, sync::Arc,
+    auxiliary, c_str,
+    device::Core,
+    pci,
+    pci::{Class, Vendor},
+    prelude::*,
+    sizes::SZ_16M,
+    sync::Arc,
 };
 
 use crate::gpu::Gpu;
@@ -26,7 +32,7 @@ pub(crate) struct NovaCore {
             pci::DeviceId::from_class_and_vendor(
                 Class::DISPLAY_VGA,
                 Class::MASK_CLASS_SUBCLASS,
-                bindings::PCI_VENDOR_ID_NVIDIA
+                Vendor::NVIDIA
             ),
             ()
         ),
@@ -34,7 +40,7 @@ pub(crate) struct NovaCore {
             pci::DeviceId::from_class_and_vendor(
                 Class::DISPLAY_3D,
                 Class::MASK_CLASS_SUBCLASS,
-                bindings::PCI_VENDOR_ID_NVIDIA
+                Vendor::NVIDIA
             ),
             ()
         ),
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index bd34b1a54ecc..3b0ba71668b5 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -221,6 +221,347 @@ const fn to_24bit_class(val: u32) -> u32 {
     OTHERS                     = bindings::PCI_CLASS_OTHERS,                     // 0xff0000
 }
 
+/// PCI vendor IDs.
+///
+/// Each entry contains the 16-bit PCI vendor ID as assigned by the PCI SIG.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::{device::Core, pci::{self, Vendor}, prelude::*};
+/// fn probe_device(pdev: &pci::Device<Core>) -> Result<()> {
+///     // Validate vendor ID
+///     let vendor = Vendor::try_from(pdev.vendor_id() as u32)?;
+///     dev_info!(
+///         pdev.as_ref(),
+///         "Detected vendor ID: (0x{:04x})\n",
+///         vendor.as_u32()
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
+                pub const $variant: Self = Self($binding);
+            )+
+        }
+
+        /// Convert a raw u32 vendor ID into a known Vendor constant.
+        /// Returns `ENODEV` if the vendor ID is not recognized.
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
+impl Vendor {
+    /// Get the raw 16-bit vendor ID value.
+    pub const fn as_u32(self) -> u32 {
+        self.0
+    }
+}
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
+
 /// An adapter for the registration of PCI drivers.
 pub struct Adapter<T: Driver>(T);
 
@@ -327,9 +668,9 @@ impl DeviceId {
     /// Equivalent to C's `PCI_DEVICE` macro.
     ///
     /// Create a new `pci::DeviceId` from a vendor and device ID number.
-    pub const fn from_id(vendor: u32, device: u32) -> Self {
+    pub const fn from_id(vendor: Vendor, device: u32) -> Self {
         Self(bindings::pci_device_id {
-            vendor,
+            vendor: vendor.as_u32(),
             device,
             subvendor: DeviceId::PCI_ANY_ID,
             subdevice: DeviceId::PCI_ANY_ID,
@@ -360,9 +701,9 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
     ///
     /// This is more targeted than [`DeviceId::from_class`]: in addition to matching by Vendor, it
     /// also matches the PCI Class (up to the entire 24 bits, depending on the mask).
-    pub const fn from_class_and_vendor(class: Class, class_mask: u32, vendor: u32) -> Self {
+    pub const fn from_class_and_vendor(class: Class, class_mask: u32, vendor: Vendor) -> Self {
         Self(bindings::pci_device_id {
-            vendor,
+            vendor: vendor.as_u32(),
             device: DeviceId::PCI_ANY_ID,
             subvendor: DeviceId::PCI_ANY_ID,
             subdevice: DeviceId::PCI_ANY_ID,
@@ -421,7 +762,7 @@ macro_rules! pci_device_table {
 ///     <MyDriver as pci::Driver>::IdInfo,
 ///     [
 ///         (
-///             pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, bindings::PCI_ANY_ID as u32),
+///             pci::DeviceId::from_id(pci::Vendor::REDHAT, bindings::PCI_ANY_ID as u32),
 ///             (),
 ///         )
 ///     ]
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
index f2a820683fc3..3c511db3b001 100644
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
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 606946ff4d7f..2fa5b8f2284b 100644
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
-- 
2.50.1


