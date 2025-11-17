Return-Path: <linux-pci+bounces-41433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8043FC656C0
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 18:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 63C2328D1A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 17:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5A630F522;
	Mon, 17 Nov 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s7pGu1uZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747AF2FD1BF;
	Mon, 17 Nov 2025 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399709; cv=fail; b=s6Qr+yskhgtxSOaBsMaI4HfoNo0DPvpPnOJ/q5xJY+48FXzWqacLPkL9OysfNhtt3OU6pR/wJ5R+PV4DhCsBJ1Zmcl4RR1X6Jm75g5tr+1oPIuxYsJc+JOHiwLXyR2Tb07OAS0pmbm0JrnlPYp8flQUjdM6PAj2sMwUBTaZxnEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399709; c=relaxed/simple;
	bh=7h3gwy/XmnrP/3yTWMAFc/v3Q+KNjrlAh9rTvpfn4C8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OITaczh61TxgEXYCLlILSPTrZg0ewK9fDv7yOwHTKPN9aLTiV8SRCc7QUSmgeMRU1l51Xw1SmYyEe9tsvF6C0IGKaxq8Fn/PxIb/dIUelcaQkGhHSkSkYec6wtVX1mGsJjVdL12f7xuverT7q8NxDQObrV9aHa58FRztqLdlPU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s7pGu1uZ; arc=fail smtp.client-ip=52.101.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZfMsa8gRVGbiE/9ZuBHFl4KJmI52MRXXAubazGAkJbqTgllyEZNX3vVHpFh7D25NjoLtBHL9njST0MTPBFDbN8u1esgqkHCK6waBZyx6pg/JNSvSs68fYYC5SEP4dwA+jQb+0d+VNjwWQ8HoL0g5G2YoqH6q9SdkKdzAlKCUihxl+b8uwSuCVMFSAJyX843JS+H/t9B1UpkH6Qglcn+qu399SRkzuQw0u1vATZ6pgEUKiOdCn6CcRKTBTjAb9MxtVNbI/79sHPVIn/Yr2eRXaYLZWYgiQxDaMflckro4m6HDMzaWmOJPIIjo/B8YzW1J50gxMv1oqWA59vd9e2q1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h3gwy/XmnrP/3yTWMAFc/v3Q+KNjrlAh9rTvpfn4C8=;
 b=w6KPy0ruaM4T6O2aNxkkeyrd9vuRw9eXELSS/RzfTu03aRdbQ4W0hkAejOLyPdq9fyOpaMlbXY8/XTOdRr9FNpEVQWt1NlcsKJEcb8CN61316gPpGvjdVmQWssj6KQ1I0+N5JS0y05dIUW3ha9FDC5huAwX4GxgLfwl6vccZD1TxAH7W4AzI5A6sDeB9F4qpwFltyF7ze3UqIQHuxkrScJYBUZgiEUCapClAjzMjH6q+pMh/Qkchg6hD3NJd9IVgmIEPRbifh0HAS7/iB2cZ3rVkMTHD8SSYr9UDjrpyj2JRXbKdcI2Cdd2g1f7QQBKWGJL5luuuBcFTD4mKgPuGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h3gwy/XmnrP/3yTWMAFc/v3Q+KNjrlAh9rTvpfn4C8=;
 b=s7pGu1uZKP5zK2rZ7UvNIhNTtVHCPi66VRYSr302m09tF4wnHBFjFYnucnqdw3TqdWLIhXYoqKIqTYYmwXvvhTwxyX9okAT+uaw60pIudHnEYki1kOogFGCa/yhCAHN5TgPteY0flJZYYnJw5rWuIM71UPA8ikXbM0aKg2cMfMgzQwhau3ENf3RSs/4vQxierMHcqEXxJHjLduQ4q9BmMda1Y0wYuqwGbIGFLz7BovC1uIrs+fM7q3e/h+NEyPJFisE8Anqa7ASZp29aqQD044ByorWBTRauGHjXHJ8WY+I/Df9DVLOZ74MuULrleJc/Bacd0AL1j8IOjsLQ0eY1gg==
Received: from BY3PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:217::26)
 by IA4PR12MB9833.namprd12.prod.outlook.com (2603:10b6:208:55b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 17:15:04 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:a03:217:cafe::e7) by BY3PR04CA0021.outlook.office365.com
 (2603:10b6:a03:217::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 17:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Mon, 17 Nov 2025 17:15:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 09:14:37 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 09:14:37 -0800
Received: from inno-thin-client (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 17
 Nov 2025 09:14:29 -0800
Date: Mon, 17 Nov 2025 19:14:27 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Tamir Duberstein <tamird@gmail.com>
CC: Alice Ryhl <aliceryhl@google.com>, <rust-for-linux@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v6 RESEND 4/7] rust: io: factor common I/O helpers into
 Io trait
Message-ID: <20251117191427.2923aebb.zhiw@nvidia.com>
In-Reply-To: <CAJ-ks9=8vm9Ggt2iJRr-QpTN+why5ZbNAzHYRmbDxiBXP4-b4Q@mail.gmail.com>
References: <20251110204119.18351-1-zhiw@nvidia.com>
	<20251110204119.18351-5-zhiw@nvidia.com>
	<aRcnd_nSflxnALQ9@google.com>
	<20251114192719.15a3c1a7.zhiw@nvidia.com>
	<CAJ-ks9=8vm9Ggt2iJRr-QpTN+why5ZbNAzHYRmbDxiBXP4-b4Q@mail.gmail.com>
Organization: NVIDIA
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|IA4PR12MB9833:EE_
X-MS-Office365-Filtering-Correlation-Id: daf99444-3b32-4475-4f16-08de25fcd909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzZ6Q0NoOFJhTVB2OWxaWEt1cFlET2oyQ1g5V2ZPVGxVL2xyZzFuSzl5N1BN?=
 =?utf-8?B?cjE3Q2taNlhOZm5hNkozVDVMMEJ5eEFMaXlWTHRxNXI0V0wrTjJoYkxyN0hI?=
 =?utf-8?B?WnRXL092dXVBRUs1NVg3V3pJZnl5cklSMjlzdmloNFhLM2w1c01YRXlYVUNs?=
 =?utf-8?B?MkU5dXQ0RkZISjBsaVhuVmwxMjRxN0FIVXh0a2dDSVB1UDFSUnJFblZoZ1ZC?=
 =?utf-8?B?aS9QQi9reHhXeWQ3c1c1Z1NpemVRekpkY1lKTHFFcHloRnl3U21zNEMwVGVL?=
 =?utf-8?B?VlpZcytNY1FMLzdxRVZjaWlFRTBJeGFaZEtCZUhDMDNseUp2Wm9KWnRCczht?=
 =?utf-8?B?UCtNblBTUnVtMEcydUFGc0xPajc0dWRwTWNCV1ZXTlVTcmVaWjhsemNLMDBq?=
 =?utf-8?B?MVdWN1Z0OW4vUzNQODZWNk5PUHFySmp6NlFrSjAvdU1yZUpZQWlyaS9TeUpx?=
 =?utf-8?B?MEhEbDJUWFE1WmdWelZvSmxXbGFRd24zcDNSc3JVVzNyN2R6SUlPZVVpQ0FJ?=
 =?utf-8?B?dnB0VHBRM2pReExndXdQZ3pKQWNEQzE1N2w3aDRpanBoSzB4ZnJ2M2JaZU9O?=
 =?utf-8?B?VW1ZMnRKYmhnVTNpS1gvU1Y1VnJFSG5OeE8yR0hUMmRML25hMGpsb2FJT1VH?=
 =?utf-8?B?VElEeGZZTWZabU1iNjMzQ1FmaER3Vk9iR3JPenZTQ1ZlVlF0QXE2MzV3bWZG?=
 =?utf-8?B?NzJidEJMcjdycnRneTlacWpSak9pcTdSbUJlNEIzdHBVc0dsSTduVnhPMGo5?=
 =?utf-8?B?T3doRVRUclFybG5zbjZzaG9VeVN5ang4Vkc2ZlhqRUJsTUlkNHJzSGtDbElk?=
 =?utf-8?B?THpvMnkzbFVWS3FWbSticExzemZNZEhkVkYzcDBvMFp0aUVOdDJkaGhhbzBQ?=
 =?utf-8?B?NlFGMWR4VFYySmg3RDBITUYvLy9INEU0a09vS1Q2MTFneGM5ZG9ycVN3cWJ1?=
 =?utf-8?B?bnZjdS9ZQXgvY0crd0dwcEExNEdPR0ZzRmVNYkM5VG1kUE1jQnRjWG04R0tx?=
 =?utf-8?B?YVoxYi9xZ2Nla1o0WEVpWlg2QWhBR01pV3d5TTlBRzhRMEpWc0lXM0lXWGYw?=
 =?utf-8?B?NHRjRkkxRGl0dnY3c3VtMExlTEZmQmI0VGdjbHF5aVNpTEgrYmM0bjF6N2ZI?=
 =?utf-8?B?Q3YrUko0ZFFTYVArVmdUUG1EL0tKTVErWUNFTEdoOXlNTnB2ZmgzQ21YMVNq?=
 =?utf-8?B?akljZ0xmU09hT3A1U2QvTmY5N2NCZXlibFczNmNYT1RiMFNRM21qdTR3ekhH?=
 =?utf-8?B?bGcvRlVsazRWOHVEUVdkVzlxMy9mb0VpWUQ4TUN4dlF1Rzc5eE5WdlBEUzBL?=
 =?utf-8?B?TDAyaWZDTitoc3cvSWthTjdzUzI5QmsyRGpjNEpYNG5KdE9QejNmY0VXYnhJ?=
 =?utf-8?B?U3VZQU9ZaElKOTRhNWpkSnUxZ001aWJwYVJsWTFiVWtPVmtrZDV6d0dDcmk3?=
 =?utf-8?B?a2k3bDVRQy9QQll6VkFPNHZDWWhTNkNkR2FrVVg5eVFwdnRnQm80NUM5R0tp?=
 =?utf-8?B?UjYwMFVsQkMvYVJ3bFRSVTB3VU5FRXk4YTNlUzJ2TnNHYjJwTlRPR1ozY3E1?=
 =?utf-8?B?c1JXUzhMZzA2bXpvZHhIYTEvQ3lhTitueXJCQVFFK04yRzdaemwzeVU5c3FL?=
 =?utf-8?B?MHoxN2graUVSaE50cmZobFdGdkZIMno2K2o5ZExWN1lJb0ZrdjUvcGo0UlZN?=
 =?utf-8?B?ZUk0S1lrZDJ3bVhwVFpLUFR4cEd4czVaREhISSsvUlhRenRQUDBJWWsrNC9w?=
 =?utf-8?B?dzFEMTZVQ2xGZmVYWWhsR1g3VUhzNHN6MnRVSDRTYzhwT3VvTXBPeEJYNjFV?=
 =?utf-8?B?MXZ6VEZ4aEUvTGNrZEdRZ0tzQnBNQkdVVjFqOGRVN3hIUUNpQmJaUHM4Q2la?=
 =?utf-8?B?czNySTdHclZhcC9ieERkNnBUdWxpNWVBUFNMSlRrckdXSDhHanNDVUViQWFj?=
 =?utf-8?B?WUlTb3pDcDg3VHJoTkZqRXhOU05YM3VIejl4dXdNV1lKY2RnRHYwUHNzZDJG?=
 =?utf-8?B?TzFDUFNwTTNtS0wxTklVcEdJVmVQd29ydVpIcDdmQ3hONHNXL0ZUUjN4VThp?=
 =?utf-8?B?UmxKeVZMVTJQT2lWNGRSdThvMi95SjJQbXJuWHh2eFlOZ1VsZ2dEYnZsYVBZ?=
 =?utf-8?Q?Pcjk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 17:15:03.5296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daf99444-3b32-4475-4f16-08de25fcd909
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9833

On Fri, 14 Nov 2025 13:53:01 -0500
Tamir Duberstein <tamird@gmail.com> wrote:

> On Fri, Nov 14, 2025 at 12:37=E2=80=AFPM Zhi Wang <zhiw@nvidia.com> wrote:
> >

snip

>=20
> What about using an associated Err type? In the infallible case, it
> would be `core::convert::Infallible`. It would be slightly more
> ergonomic if associated type defaults were stable[0], though.
>=20
> [0] https://github.com/rust-lang/rust/issues/29661

Thanks, Tamir. From Alice's and Danilo=E2=80=99s discussion, it seems we=E2=
=80=99ll keep
the fallible and infallible traits separate for now.

Still, I really like the idea of an associated Err type. Thanks for the
trick. :)

Z.

