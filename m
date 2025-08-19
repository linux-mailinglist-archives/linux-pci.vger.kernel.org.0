Return-Path: <linux-pci+bounces-34233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EEFB2B768
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 05:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F10534E118A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 03:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EAD2D2488;
	Tue, 19 Aug 2025 03:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lQVzGCTt"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AEA188906;
	Tue, 19 Aug 2025 03:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755573085; cv=fail; b=ArlksgR/G582FJ6Q2gvEHYCa/UQzR4+F+5LNrV24eEKTrmkBVmn84d5q/n0O6dbkwNjAFAXMqGAALX/D774b8um/3SKGJdUUbFvuexYevvhtGTRofaajlk01kOPMdfbHh1J0A38fM19GBi9lJTqQ0H+tMn1PQpnGrR3O58hXVMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755573085; c=relaxed/simple;
	bh=Mh4tg1v8j7qWLibifkgnVj5OqT1OhWcWSuuiskdjJP8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TsLde8aDRMzw2r9H1Q+tg3mGSYX9ssHbLPJVpjMtxOaVUiW2YtKC0VDbcrOwUOypCl2tixn1uHj0cuqAHhedwSB7/FhHfnnOF0R8rb+cvRy6V+JeB17N5buXa0H/syM2nvK/khcdRMQGFCSHviSKBMgG3x3pHSeMna48hakHT9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lQVzGCTt; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELksxsgMcxkt5c8M8OR/GHhvj7j1AsigtC2BE3zSmudb3xECa41OijAfOpuspo5B4z72HQsMktWZIF2F4EPm7yX+aePGZ9bl+qJiW6yCy8vKjnGil15T+TEwmqIujct6AIa712J1+NCG0DSgXhtcSmh1+Al6VhgoRniBu6kOpCCDCdXInc7f+JjDxrMkQE07Wgvg4hWylJLdVjVocczLQjRjnSgsuy7q60AplrjKENyACMRokWpyQqiIFStJhxHdXDjqGIAoP0shbs7PG4vMEXpT2piJHk5YW5HCrQ6oxwsxKmBF6wNTMVkg7qI/xT+4Fute5u+JKQYAFrRClZ54yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65yH60xMqcPkSj+BPo7Uqc6R9UKdPxdD0H3P1ap4MVc=;
 b=oCpueyWXcUK3UsW7FLIwJ5+7LNVKJ/Jcd8Ymn+eQE+/q7QE7UPEFnvzPo9+XD2LMHsnQ91rZlp8Dzh81wPZSIPQmG+hOSO6K5PtkupugVs48xXw/+QZ6sEBUtVXnn7GxPukGfSBAd3hhb/RWXP2ONXvTOyNyjZEKCFiPJerHxh6sNCXr+ZmKNi3jh+7An1+si1Fovzx8+1+APtbjfqIRN5lPkyPfREGMVfGB90pUI/BDzwr3ERb7E1ZQhCiJagck//GJzynDrvTDQ6RxZKTdbcD//rr+MRpVmq/PJwc8fyV+v3KOCcerC9jNtgFL00c9xG5CyOWnsOyOOMxD1h77MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65yH60xMqcPkSj+BPo7Uqc6R9UKdPxdD0H3P1ap4MVc=;
 b=lQVzGCTtO9VsLHY4rj/DSwQvDPDnO5XcvQdg40NU4Txo9s0mc/So2fdQ9fJTzSkNhAW5GyAphZIca+y3mhINmuGbALg1pcOAD1QLqBsI8ZkuM+NbJTUzGSXVeWE9wW23/HghvkRSAxMsIVLVGewGkqlIF/FeU1cARLL3LtpplsYTZwRrD8OaEOdNjPwEC6gOz17jNncA4o7PMkNK5U3I/f1XFDkV0kgfH7Mh4OTIUBO4w1yc1K+8NnWx4tRT0JBjI2qOdiLZvMOHmu7A8Qwu0bn5Sj1HGUiu4PHiWcesZpmi6RdN+O07sASx35k6RYSdu47O1Qpys1vMSF+1CXKQWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 03:11:20 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 03:11:20 +0000
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
Subject: [PATCH v3 0/3] rust, nova-core: PCI Class, Vendor support
Date: Mon, 18 Aug 2025 20:11:14 -0700
Message-ID: <20250819031117.560568-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:40::41) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: c79e015b-fe82-4ec7-59e9-08dddece11e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0gDLPg63aLxVGe7xx0dcYjAl4J4cagDmoFjQLpfo0hGnOEw2wKe/QT1LUlr8?=
 =?us-ascii?Q?8fr0NhVw4pVrkud8CpvAwdcGx6w2Nxtz48f8JS1259JDjdwIl6gRN9ND5dax?=
 =?us-ascii?Q?B1juYsXdMTQw4a4i/UfF9XSUhIDCS3TA0azrTmPpYR3k/HQiSK2aYqk7s0Is?=
 =?us-ascii?Q?ACRhe7PAcOU7dSkAERcBfCK5b4CcFrOiNyHrK5hRXN5/BBLMbcLFm/Xi4Fgf?=
 =?us-ascii?Q?gHhlX9Kkxav08bexB8/HABAHhZLqPY81s6kBfQt4UXvHo9paej+sbw2R4n4k?=
 =?us-ascii?Q?H2/ot59Gd4avtDF4Nv6X/gzE6ubCgoUPq8BmRwtKS3EFE/6GaTUxD44W0wdT?=
 =?us-ascii?Q?CVR/B3qsPgT2X+qDNk7Hl22Zpq0xGJS3LHp9EI6uvW3BwGC3LIBMD0MMe8L8?=
 =?us-ascii?Q?1PomKq3ILDgR/ELWggGdWGUXww8m0YDRur/8s7opZBfJouhVGmUrr20NEG01?=
 =?us-ascii?Q?nOKqEOMOIoONeg1NJo9JpRzyctsaoWxjYlI9PjEPvpI90wDIJyMX4v8NTYvY?=
 =?us-ascii?Q?PLMW6Fidg++OIe9K6PaiC/q0OreNPIKyBwmIxFAOnuksM2OAI86FePCE5EOm?=
 =?us-ascii?Q?GHv4+BJXzj5xFhHhV8Zwi2BmAsj7Rl7SNesJYRke6GB5hbx0Q/8I6mFzwilQ?=
 =?us-ascii?Q?8X0jmH38gEnbIc5q2eLusaGYTHnloz3AA3UDQT4eSpt+tWdg9u3AkbxHbGcZ?=
 =?us-ascii?Q?qy/SXvDNjPNtA0/T2KpGsmnozmAINHmceBYGjKteSNdOAzOnO1SRBubFwIEx?=
 =?us-ascii?Q?9YUUK2zFZrLTtYGkdYnsUx0gMubybvxKIzypHnJ555o8vCDmF1ncAcImQARJ?=
 =?us-ascii?Q?gRDZAewo0kDU4qMnJNm0x9y1KL5IULk1Y4fEmgjABoKjh1fkLy03wC5DozF6?=
 =?us-ascii?Q?KtRXFYxs5nF1h+lfTLJv2Sw3PU0NDrh5l4dvpCSWfojBKuOCK7GpnFAoWrll?=
 =?us-ascii?Q?TfvBFnA2+TunTgr5UAPSPj7AdRr0T4W/RPTAyLkFNWQcG09VAVsYsOKHP6EW?=
 =?us-ascii?Q?Fts9nxtngc9uY5UOQUk+Yid9LFsZ/K8y+as4t/Rz10lX182PX2+i862kgeNn?=
 =?us-ascii?Q?Gzyo1K0LHrpUrS8ZHvnHhbek7EWviiCbrRyhM4OW2VyQyxy4ge8aDkD0NrFt?=
 =?us-ascii?Q?8QgRHE41iRLFehvATz+Lp0VJqiko9R8HGBOK/z0b8fixZ1tk/upwNjs2/Fbr?=
 =?us-ascii?Q?OcsvxupCjwaTN525/5cWuyCKTwRqs3v0kio4DV/v2xtjrXoG9G6dpMZKCK9Y?=
 =?us-ascii?Q?ZRdAaETr4+AlniNGABP/YhRseVfC622CkZEmN5yGFYPRYn3xS5ZPLSiP5BXt?=
 =?us-ascii?Q?Bj/aCpc+JY1RgDdaLkOAnmNRAVCIqx4JYO7Ku+Bpfg11Sh4p1AEfyQT7OM7X?=
 =?us-ascii?Q?dZ/RmEdB3MjGDYgXNvkKc9OuYhsSqCCUoO5ONfj85KKuL4RlWu7pi/o3vF8b?=
 =?us-ascii?Q?V3Lngr1UOxk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IpXXBg+noJOOJ2k1y8Uzc8r7PRUZTjiGJKNMHsh3zUcrKXLPBtj7lFcSq0KI?=
 =?us-ascii?Q?Dv1409bd8xLkEI9yj8FjkWdK0XJs+2l78YHKzhyaMy2m+O97C2F2BUTSS57r?=
 =?us-ascii?Q?fc8jQ6aqbBiU3G68c9eP47EkN3CH9WtpGn0amum3HkHfsI1fQ8ZvmB4c1FRp?=
 =?us-ascii?Q?rj71agy0gZfBEaMWWGVhBlTUthD+2o49DwTmHLacmhXGjRLo/rs8DZABVe47?=
 =?us-ascii?Q?19jRDNG9U+bIFE3yoX/aDftMtKJIhn1tKwtiB0XKUMYrCSuL2fDIYZpiQx+H?=
 =?us-ascii?Q?jE+ZRYyAqq5FYbOf+e4k6o5nAXsRnvkYYxYHiMWGuF4e+xZhQQfkkC4bTf+8?=
 =?us-ascii?Q?9dJS5u8vcKxJipZKBJSqV/AY1H5jJdHs8AptLx4b+N/2UbCDE7T6BbV4uBQh?=
 =?us-ascii?Q?MtXw8sjKHEsx1QLF1zSb2tAmZPa//rGFW71gRsROBRoFCwnn4qyKbaWVCHSn?=
 =?us-ascii?Q?i6gmdw0TPxAIstDYGvfDkHq2O9PUw7LOLd28t/swsGd4I+m5Pj1gk/jyqiMn?=
 =?us-ascii?Q?Qwez9dhdFOE4UxoiBXLLIS9mLe5QyRM4smMRGxL2nldT+Kfrn+n3xo7HHi8A?=
 =?us-ascii?Q?zRPX05ANX6M4t5nP2M2AHG+c20ZDOvKHVqP781LPiG4sW4UCuXZlcorl0GXl?=
 =?us-ascii?Q?vWLDU+7ZM2hdb3Zlv/20Fp+8Vs8G7dLYXmqt8McwbCfiT9iubmgBL2ZDUckj?=
 =?us-ascii?Q?VcPbDZXJT08wtYSzmOpRC/izqU9L5MkDC6llSnsAyg59K6uqEKtl+YndnXVX?=
 =?us-ascii?Q?rdMLefwLL4yIiZvfG8/JcwZez4PO3DZhh/kmBRvVOWyo3/u2ZSNhCDk4o2jD?=
 =?us-ascii?Q?0o/6bp6gaRpEXXG/02ML5OjnqaPHpmqQKCTOLAOMLZVysEbUsVBrYvQhYbZW?=
 =?us-ascii?Q?+h4oh52/Nd0b8Jper2XU8J6kn/sH+STCXGKDtOETdvEnt5T4vp+A/eUtc2uT?=
 =?us-ascii?Q?xZhgSxUTzRY1n9Nx4HrFSldnxo34PyAzN8ECY7a0tfg5bAsu7OK508M8b8Qa?=
 =?us-ascii?Q?7CxKxUC/ErK23ouCbFQ+KzQyptJrgvtLFioug5MbIss7vOo6kZJEwUzKLZy0?=
 =?us-ascii?Q?Mi5jjpn494cyZTPo41OZ/eucKxnxHSCz5wGxiIJz21yUeaUkf7Cn+5p91L4R?=
 =?us-ascii?Q?ZkV2qo1f1E04kaq50d54IgUjEI2VzML35pbFK/vMw+fDxw2axOz7s7TbTzY/?=
 =?us-ascii?Q?rjkEPoNYCIgsgFIf6aK4Auy6c1ax2EloOkNn31apeeGwAH11XzD3vdz2P5NB?=
 =?us-ascii?Q?EWZIf0RwoQANZzlWcxpQv7N6OiCKN25YwiuFLKtYYghHk5lJgZd0YASbXbKq?=
 =?us-ascii?Q?LnCoOY4UIIHmUfGc+jWwG33YXIA8bVSBUjvJbfoNs2AAWwedDReG+1q/rWqd?=
 =?us-ascii?Q?leVHP1+GyBHG7CJfUHDQBAIH6CsVoBaOXGxd6Z8KZyE+uvLcXFGfK2SehROK?=
 =?us-ascii?Q?VDKuy9kEfBybRMjRL6j4udI2bGP4G+Ans16KSaMwSi62C+UFF3VYOAdI/F3D?=
 =?us-ascii?Q?S5D0CzTSg9jQXtH/EK4m2tZtQIWHsSwB6S2CeffQ7da9p5xc3a3ura6HtglJ?=
 =?us-ascii?Q?t6y8QKKR9QM5bR6UKUMnImJiJZOMiR4Ia2AGFiOC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79e015b-fe82-4ec7-59e9-08dddece11e4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 03:11:20.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aj7aIz/R6b1sk0FKR0u+Xgg+vIcIyXn/DMkb29hyBa20zGLQj8vDroD61UarrbHm1QLtTZ2JgGHjgTS6bapv5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095

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

John Hubbard (3):
  rust: pci: provide access to PCI Class, subclass, implementation
    values
  gpu: nova-core: avoid probing non-display/compute PCI functions
  rust: pci: provide access to PCI Vendor values

 drivers/gpu/nova-core/driver.rs       |  33 +-
 rust/kernel/pci.rs                    | 574 +++++++++++++++++++++++++-
 samples/rust/rust_dma.rs              |   6 +-
 samples/rust/rust_driver_auxiliary.rs |   7 +-
 samples/rust/rust_driver_pci.rs       |   4 +-
 5 files changed, 604 insertions(+), 20 deletions(-)


base-commit: 0dfc23ac2c5b3a62ab27fb9b6ee582b4bb5ce33c
-- 
2.50.1


