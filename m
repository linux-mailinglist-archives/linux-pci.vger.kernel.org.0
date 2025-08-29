Return-Path: <linux-pci+bounces-35153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C65EB3C4F2
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 00:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7971BA1798
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 22:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F402874F6;
	Fri, 29 Aug 2025 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BbH2h1GJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12C1D61BB;
	Fri, 29 Aug 2025 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507004; cv=fail; b=WeWEcg+1FuNauWn2suRF2y6gcShhO5QmNsJZ8xKi71p2QDwbpx9Xu4JPDEaKjxfzuHpQnW2iIa2aN7PMJyORnT0zTZk+H/HVTgzhpJ0+Ty2i1D4fxOyS/ugz5rcm4Exan2Ye5gUECnKltCD8YMiPHgzN67UAbOIB/uqCM6FIn+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507004; c=relaxed/simple;
	bh=yffmH6pT5Y5y1Ho/Yy/zk1hAmk7xHd72dF/T88df2SI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=c5BJGySxT2fft3Kux3iwR61cJ6MOHEhAcXVh+KbFSYsqQvqMt37N3I00WxAy1e1hQ3zSKfU5wXIPodu+Z+d4MI0NrRpzFy2G5uZnHORWyr3Gv2GwCCHlS1NVRfcp4rEqIIZgJ3it8FbqRJaAPWpydJpCYigsOYwF/cPiKHYRufM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BbH2h1GJ; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJLd02OnGBN+VrKYXB0klSE9vvHjI66ycAoOBnB2NGzjaeHtNVq/MO9YS+ZFkEOrdQZRiyabOWTMbnxzoBMDnSaJox0t0q7ydN5zwtFnd7yPr7K76xxDps0ixFl5hPlPvSTGQquAT/4B+kjWm73LT05p0FnWG3utHqyGdw+UBOVu21PsXjXYVujE6vMFJl4q7HiA79jYvjk8RIQca0Lm2xdT8YOokCNXwD3FsckK0QyduXDDBbHoTj5BtM1b2eEhhuB9ynhiDaSA+KLoYx6NAoFl+te0STUMYvey1eSX6FqQigSgOxbqGuB3DJrjgjesHXtVI7bDj9OuSXt4OgIEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nf8Lpi3kcKHoTUiYk0wnXz71dMFwssfOGGqQA+NoOBU=;
 b=t0QRpSQyy4sAHTMotSpFYkaPA8dTFlwiJOWingEcdjyF4tD3oY7ZjdMafTED0Td905MT4FLwJL2EMtrY4fuGsG39kRVky7AeDzz+bwSQlBeVOtdWU/BecFpfG3u84uDLFCrbdYy4z4npk8oxm1vuwYWHa/qsVnsTanWJy/MJpmz7GWC0wDsox+cOjbYfTfX3Doq/4XWsUDPRRFLsaE6Ih+RXIgKW2uK4ibry/mE92rNsP5vcMChu3+Zrp1hO5AOIbc9ftGXLzVJmQNPV5Qy2LJUMNa/h1TMP0PXLFJhOLYRvuvvr746MTcUldAYf+WRl+lG+r/15lPPySBirnrRdEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nf8Lpi3kcKHoTUiYk0wnXz71dMFwssfOGGqQA+NoOBU=;
 b=BbH2h1GJIha+PnZZaTdu9RIItwv8iN3o4jTqyWsmCk29DNO/pVCk2zOG5CkoZmADBp8eoCXNqQjeXSAUGfXpK9k40kxVwY8gctnpeyCXmb0xswkMlHSGuhesGT5aFPI11W+SjYTbzPIIcTcP+yuQAEUAbRDQ+fzbXv3US8bbZzTRGWih1PBcyAOkqJoLXmqMEqjxSGRC2miGgt01ahgDgIb+Nh5t4SLKCSFCcKbSrrvZJmEuDQ6nbGv5UJZqBwtSWRSp1lY8/EtsdhqHAVbJ58WLvP9phznekVaq5Tsvk2bBXF8Wet0ayhAnQ08v297mmAzGNLGNMFWiSKBDmVyS0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH8PR12MB6963.namprd12.prod.outlook.com (2603:10b6:510:1be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Fri, 29 Aug
 2025 22:36:34 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 22:36:34 +0000
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
Subject: [PATCH v8 0/6] rust, nova-core: PCI Class, Vendor support
Date: Fri, 29 Aug 2025 15:36:26 -0700
Message-ID: <20250829223632.144030-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::43) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH8PR12MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 88be195a-669e-4391-487a-08dde74c81ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QSMuBS0Mof4AP8P1yNOrHVNTQik4UWBK1FMUdY4tNcxSbTTdmgo07dQWcFvJ?=
 =?us-ascii?Q?pnABA6825vKqG4GV911SIe0lf4Tj2h0pi8Z9lO5rIqOIkDwUrs2VPzSOIMcx?=
 =?us-ascii?Q?+hrjXOUllHVw69RUwroLuIttJC2KU8jkknq91rCyfR3HUWmRgOa5t5bwi2xi?=
 =?us-ascii?Q?tie7mmJej7P0a1F0L8JiqiKMy/Ib3lFIu8lEZLQIfmHx76LVnaPZGVfDTHPE?=
 =?us-ascii?Q?g6sjI3IJiC2FlSdktsI6bzncw4SqdPPj1xOQZnc3izM4u4v4/riyvgAMadFK?=
 =?us-ascii?Q?yxcSKcguaQmkfGT0JbE2ua1yrD4g2yZOuByoPuP6aO0/kv5oMM7zaCFguLhz?=
 =?us-ascii?Q?kQ77g4gljeJwOfog0lFnRxNZkqHDj9ceXsSoAqYhdz3Xk0pKFYMzhQsPcLuP?=
 =?us-ascii?Q?pBGVQ678uDqtcwzURtPnmublqgBLMbi268dPE/RKRpCUqw2EiC9x/clO/acY?=
 =?us-ascii?Q?6idVjPyvlBiANcEZjoaLg/TkSKzRO2UZcthl9P2L5PHeChK4MsEj0vPtS8mR?=
 =?us-ascii?Q?zZw6TA2F9qgR3kG1lHMt138/yuhCAo+jVtJ6NLmTpd0iZK4a4u4f/kUOTZPK?=
 =?us-ascii?Q?dlARuFJMYKvkCupDsmXvEudVVz9wSLDsLhNtqD9gTNSYc9U9TKygRZzUSPaJ?=
 =?us-ascii?Q?HjJL7cqiIfeehLrpFYGRPzlPykBcJiLdropXagC7pF3zD0tLYmDEagnZSHsT?=
 =?us-ascii?Q?3uleJUQ66Vh7Sdn705BuolD1vGXBYwmaX1dE47vG9Tf6vZ6GCGj3cKVsuJFS?=
 =?us-ascii?Q?EHc4/9Cdf8Yxi/+nzbpGbZM9OiP2OIschHGJkl5vcx4aBtzQLXE7G2zxaPYL?=
 =?us-ascii?Q?7A34jpXQnrMjYSUMZSUKykKByJ2vgRZmTnqpKKYaIyBwS69hKZZO/mxbBvbx?=
 =?us-ascii?Q?fJUEM3ceTLi2XHbrdBRseLrs+cpHCv9ls9xEcI758wW+asGNwkhuHCUDXjgH?=
 =?us-ascii?Q?l2vG+4qw5Nu5+I6s99svvXNiOqTvA7cB7LTjwJpnnBfcNPASl3D9EYuA4Ef3?=
 =?us-ascii?Q?vKe+pN+e1rfnlXovJfd5HW+Y/fbIaOlu95B7STabEpKzPuZvpZ7uBirf/pmy?=
 =?us-ascii?Q?0Ic2TMkiMzXyWM8WGQ7FU1h1huvzRITTKK2WRfikIcEKa7oVzKwq7sREJyQk?=
 =?us-ascii?Q?X5OnsxuC9m2M4czlKqcIewzFnIy9vXH2+/ypLhglyQoyi6FiUdVD0q/vpAiZ?=
 =?us-ascii?Q?yRuADHhQp6feljOSDxgHpVxG0Gj6Rmn/Zj5CG2lcMJ4vs00stmXJUjC3tivS?=
 =?us-ascii?Q?KUsspK1QhYy2wk4WGXm35EFLSy8rLR5bwLTjmWhHhoibTr2AYyvOfO2+COoa?=
 =?us-ascii?Q?PZpiZ3AaIXWmyGGXit6TZzeROecYD4FRd50szNQSP/tfOrwM+jTp1oXhaehr?=
 =?us-ascii?Q?gKRjWoOpJ5dnMUuUwqCH/UigBV8NejVetaAhPNHCKBznoGFBuxG8MFmbq5ju?=
 =?us-ascii?Q?Qk3XO6o1Wgk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N3o/ktozoP6daEE3bQ4PP9aUOAmxZk4tOSWY+v8f3Jsx7l5QGcGbbt8W3e+m?=
 =?us-ascii?Q?EAAqA9RitCAP93y6mJruHO/ExKpYaJlp+vnLmP4ztjS/kb3TbWZEKLJ8jVO3?=
 =?us-ascii?Q?PKz/4ubG/NmzbWZBviWrw33XJcn4ShgOISsbe9g/t1FTLbI3jEqTkxKXo//j?=
 =?us-ascii?Q?kL0enBKQDDIq5pa/QJ0+RbK9joXy5R/JAZNUCpMfHVWtSNJjtKlC34MWe5Bj?=
 =?us-ascii?Q?3y1OtIRlIzTCdyKrWyAG9o9UDdWkK5qVKIh8OeP+Us5deQgNGqGJed1vt/LO?=
 =?us-ascii?Q?ge1fiKZiSwdwB+ZvNsyR24zc0vsIAyCuBQSJsa5Tzuq3uFjeUD3GTOpHKfbr?=
 =?us-ascii?Q?79HjVNFobTQBLFQS1ysdXYzRJEw0TncTAQR2XjBMIkS577W482uSzsn9newV?=
 =?us-ascii?Q?2ESKv9gtBSmmxBV7Vq2gHr1NcN2TzH3Sesj64295uop3uoKutVqoCmpzA2rm?=
 =?us-ascii?Q?BcB742k/OSUGUKit2kM8n7TecPzqf/gsxFB/HfON/qhMXhyVrWqUQdYzl3XW?=
 =?us-ascii?Q?+fM/rizZENwwNJTuqorCwY1/QQJ4Qv6vA1mIFw+waIhaCy/Q8kVKDBlv6/HK?=
 =?us-ascii?Q?/xFma1hVDnvvF6FeNDzViKFYNsUiuwG6LcpNm7KwluBgUcURGy4gOLs7GnGI?=
 =?us-ascii?Q?ldvU7+qi3AMSeclFqa7ktq/7IRlF+3s1TwZHg2LBQ7Cr7Vq6pV5KMFNKBeyB?=
 =?us-ascii?Q?ns1fT3OtiqvXLKx52yBFm+gkmDb+HCgivCaMbZr3c28VG8E9nHur/iY+Ph8o?=
 =?us-ascii?Q?uZp3gnK9UWBhdjrnw682uQ2ZqX4q5vaKSSixS4QFGq48rz3LVHt+GpidfDUr?=
 =?us-ascii?Q?QpBBnSJxEsFYh0FmcsfN0TWtWcSeMD+sn5AimDi6WUeA5aKQ+bHBRcYMiJcj?=
 =?us-ascii?Q?maO4ZEP4mQlSEqk3FmpCpT89eWniFqu6Jzr2cf7NBXPtWBybMcshPBWMwte8?=
 =?us-ascii?Q?TFORT0routZSqh8t8D5jD3hy2otp+/HBPIuMfCRxXNEtswHxyk3YFlXWu1B6?=
 =?us-ascii?Q?UYes5S5PVFblcXFcw9YxjGOxLlb8l+yF/GUZ+j22a1Ucco8hdhTqOp1s7B3/?=
 =?us-ascii?Q?GWNBC1jY4VKK5ZTSICtNR4QjJdeUcjg5MHiTmOTR2P3A/sghbCMGGGJol8Ea?=
 =?us-ascii?Q?TWdE3/v9YyAw4m42J8Pscjm5N2OaJg/1ORrvp8lMp6o22YW1Leh9hMKGc/y2?=
 =?us-ascii?Q?Hq9TIPs+J/va/aYiXSeLTWytsLUZGEehcEApGmMJr12En0KfLEoetgRyn22k?=
 =?us-ascii?Q?WhRyI5YJO6JsdvF6Bb8fBWLHIio0qhw3QFq0lkoPuaATQflHetYy6Zgwqsgt?=
 =?us-ascii?Q?u5jAnsA3xJWXZ8vOngsCFqfd6lwN0PZYDNuAocTjm4ZVQoFIgKsECgyE2SUu?=
 =?us-ascii?Q?b8yfGfhJ3PpoOKlGXmADNQq1jJYSeeGdLTKZPHHwKGuQEwzYlo79FtoEZ1SE?=
 =?us-ascii?Q?u/TYa1zKJL/eRRvS37HBzc/exLcGIX/Vo1T9BM0K+aV4sxdC8wsgatKYYtLv?=
 =?us-ascii?Q?CaO+5gzQnVpcxRMieICTfi0bFf+rRQVPT3YQKpF8NXM9jLHDkVVb4Bj7SKVX?=
 =?us-ascii?Q?Necje3XBW9v1g1Gk7fuZ7M72yueDE2eznQ3acPIe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88be195a-669e-4391-487a-08dde74c81ff
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 22:36:34.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqYRfBJCSfIIDu/tIaO7jGxAQ/Xv65ucVz1RIpe7OgqkXrNs4VEzvJUmU7tnyBtIoV4I3aBAgBhss9prO7OFTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6963

Changes since v7:

* Applied changes from Danilo's and Alex's and reviews (thanks!):
    * Removed a blank line, one each, from the Class and Vendor macros.
    * Moved example code location from struct Vendor, to vendor_id(),
      and introduced it in a later commit, in its final form.
    * Applied Alex's Reviewed-by tag to the series.

Changes since v6:

* Applied changes from Danilo's and Alex's and Elle's reviews (thanks!):
    * Rebased onto driver-core-next, which is here:
          https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
    * Changed pci::Vendor to be a u16, instead of a u32.
    * Inlined all of the tiniest functions.
    * Changed from Class/Vendor new(), to from_raw().
    * Made from_raw() only accessible to super, which in this case is
      the pci module.
    * Restored infallible operations. That causes Alex's request for the
      following reasonable behavior to work once again:

          from_raw(0x10de).as_raw() == 0x10de

    * Added a new patch, to inline the remaining PCI operations. This
      provides consistent inline choices throughout pci.rs.

Changes since v5:
* Applied changes from Danilo's review (thanks!):
    * Split the nova-core patch into two patches, for nova and pci.
    * Added rust/kernel/pci/ to MAINTAINERS.

Changes since v4:
* Applied changes from Danilo's and Alex's review (thanks!):
    * Reorganized the patches so that the Nova changes consume the
      results of Class and Vendor upgrades, all in one shot.

    * Made Class and Vendor types get constructed infallibly.

    * This was all somewhat disruptive, and also required one more patch
      in order to properly separate the various steps. But I think it is
      all correct now. And CLIPPY=1 builds cleanly too.

* Elle Rhumsaa provided a Reviewed-by for v4 (thanks!), but due to the
  churn in v5 here, I thought it best to not add that tag to v5 yet.
  Instead, I have directly Cc'd Elle on the patches for now.

Changes since v3:
* Applied changes from Danilo's review (thanks!):

    * Moved Class and Vendor to a new pci/id.rs file.
    * Added ClassMask, to constrain callers to use only the two valid
      masks.
    * Removed pci_class_code_raw()
    * Changed Class and Vendor .as_u32() to .as_raw(), because after
      Danilo's comment I looked around rust/kernel and learned that
      .as_raw() is the overwhelmingly used convention.
    * Changed vendor_id() to return a Vendor instance directly.
        * Also, validated Vendor during construction, just as is done
          with Class. Both of these items are expected to match known
          values, even for new devices, so that's a reasonable move.


Changes since v2:

* Applied changes from Danilo's and Alex's review (thanks!):

    * Moved everything possible out of the new define_all_pci_classes!()
      and define_all_pci_vendors!() macros.
    * Used "impl TryFrom<u32> for Class/Vendor", instead of .from_u32().
    * Made the new DeviceId methods infallible.
    * Upgraded DeviceId::from_id() to accept a Vendor struct.

* Changed the names to be a little clearer:
    * class_code_raw() --> pci_class_code_raw()
    * class_enum() --> pci_class()

* Added doctests for the items that are not yet used in real drivers.

v2 is here:
    https://lore.kernel.org/20250818013305.1089446-1-jhubbard@nvidia.com

Changes since v1:

1) Use the pci_device_table for filtering, instead of open-coding
   filters in the .probe() callback.

2) Add PCI Class (class, subclass, implementation) and PCI Vendor to
   Rust for Linux.

3) Rebased onto the latest nova-next branch, which is here:
    https://gitlab.freedesktop.org/drm/nova.git

v1 is here:
    https://lore.kernel.org/20250813232859.224316-1-jhubbard@nvidia.com

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>

John Hubbard (6):
  rust: pci: provide access to PCI Class and Class-related items
  rust: pci: provide access to PCI Vendor values
  rust: pci: add DeviceId::from_class_and_vendor() method
  gpu: nova-core: avoid probing non-display/compute PCI functions
  rust: pci: use pci::Vendor instead of bindings::PCI_VENDOR_ID_*
  rust: pci: inline several tiny functions

 MAINTAINERS                           |   1 +
 drivers/gpu/nova-core/driver.rs       |  33 +-
 rust/kernel/pci.rs                    |  72 +++-
 rust/kernel/pci/id.rs                 | 558 ++++++++++++++++++++++++++
 samples/rust/rust_dma.rs              |   6 +-
 samples/rust/rust_driver_auxiliary.rs |  12 +-
 samples/rust/rust_driver_pci.rs       |   9 +-
 7 files changed, 663 insertions(+), 28 deletions(-)
 create mode 100644 rust/kernel/pci/id.rs


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.51.0


