Return-Path: <linux-pci+bounces-39927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1792AC25182
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 13:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1015D4F5013
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 12:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEEE1F2BAD;
	Fri, 31 Oct 2025 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ayxEpg57"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745731E834B;
	Fri, 31 Oct 2025 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914937; cv=fail; b=IgU1eKgDzzoygvbRFdCsOWEmytDlJevTFh3+TdNrDDiTsW2beJLC2WHmcRYSnh7I7wOx1RuiBaaEPV61yBzK+keYwjGHnY0KnU8JNXw3n1d5aJsmoibj451U0kmYI/6zOL0taiyzZ7fUIdpHuNgWSXNhiMmdgWkSJzs5YT4zaAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914937; c=relaxed/simple;
	bh=kFZxebMPRhuUqmWAQpvlZuq064AlasoeHQK4Kc2Xp6w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9iyimr6heWIt1N09sUtbZPviN983U0VpSeQK+n7lZ1U+sDzuLNVUesLIJDqGI28pSi79UOacw6GhHx/JFuQOEKJh6XoZNjYel3m2AK3P4L6p7Liqg8DVBBekj3cWJRFLuhnPgRZCa5D1BAb4y8axYWGz04HRisiUKaI3XYbq80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ayxEpg57; arc=fail smtp.client-ip=40.93.196.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbsqgU6tWY4Q8QtG2TMVSvAV17PWjV2oQu/GyiSt0lXfC1uJQVe9Et+MPlEZLYEauHjQ54nMH0GBTG1pEIAcKyAl+ey53bQenkEw6UjC+8enmu8Aq7CJtCU1fB0iVTwmzEPuMWzmVrlB+G/feHTUve+2VM42pMul4cTVsiUysUVRGvRgxDCauwk27UFjtofXnbmclRVAuixQZtxpBuMtJ3rplfgOw3u8CtRAgi7yUhqxcpwD00LKbSTcoxLQC9tHxty31Jt1j2Bw95WCYdPTwRGcJwtn8AcQqJRC4p2HA1GpUMM41WTQ+jfux3TUj9IZkY0veUszfYimEvHMh7yfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hdc+1AovOWAr6ABBfyVnJBt6a/0lWD0Jb4eugJKJJkA=;
 b=djiv8xvDuyfc/OUG5dHBb0IHk2no5dAXLqtXNLAZI+vNVz+LQR7e4dVRAIuHNVBgRL+6+XHOmnya51tqJhdOAS7H7uo63pa0g0I2UgzmTXlPVZBu/vqlRrXbl+evz3ri9SYRL9JCMwUwV5d27zGz1qa7ZOHay/zensRwOQBJvV9RpvLWlrUJovzv0WlXd7fEALJ9p4HO5ceUHCijtx2inbgsm82gkDaYl2e+nanq041d96nuQqzJjGq+/8SisL2fGZaK+Ayf1OjXjg4FaNkxMRwcRsv7/yrZsFIH/U8HmEms6IbTrU5Ihj7IMx19qGxHap1qtAiFuKHnChf48ZH7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdc+1AovOWAr6ABBfyVnJBt6a/0lWD0Jb4eugJKJJkA=;
 b=ayxEpg57cjGbhrSesbak63AWE5ZDylqNqjIr832Y4NKCZk886x7QIrLyxguR+riPLDdZpRY7SM3OQHiP/Xoq9Bpy3ZNoFCCiEP9QlM6hiz6nSKPUy6Qfv7+KOFb/BqrL+7eUGH+UJbJIm6ID+yMLoEy/gP3X40/o5r35kpNBvqgK+g2y2tsjhA/B2PNvknFfaAK48Uxn1oLzGc7LJYPyCjKwqgCWv5aWHhQ+vmNpPC/bzZPoG75fbgLfAdkBQNBBuuiQ52psJjALD0Zft8YOLow21HIww2h82sxkpSHNJsPuHMJ++8hCXgc5RORA9R81vTGXxuvcFFsaPsJR9Iz1AA==
Received: from CH0PR03CA0087.namprd03.prod.outlook.com (2603:10b6:610:cc::32)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 12:48:51 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::3f) by CH0PR03CA0087.outlook.office365.com
 (2603:10b6:610:cc::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 12:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 12:48:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 05:48:44 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 05:48:43 -0700
Received: from inno-thin-client (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 31
 Oct 2025 05:48:37 -0700
Date: Fri, 31 Oct 2025 14:48:36 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>
CC: <rust-for-linux@vger.kernel.org>, <dakr@kernel.org>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 1/5] rust: io: factor common I/O helpers into Io
 trait
Message-ID: <20251031144836.110ac310.zhiw@nvidia.com>
In-Reply-To: <aQR8OPVnU_fPJTCI@google.com>
References: <20251030154842.450518-1-zhiw@nvidia.com>
	<20251030154842.450518-2-zhiw@nvidia.com>
	<aQR8OPVnU_fPJTCI@google.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: d5dc40b8-ed8b-486c-c9dd-08de187bd7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzFOdVU2cWRldTJSbWdRRmRJSkRUTUljeGZxb2lRM1g3VmpPQS9jRmJGTGlS?=
 =?utf-8?B?OHpJbzV3RzRkYzRGS05JOWFVS3B5emZac1AzOUFENy9oV3ZLMkFIRTVSRVRv?=
 =?utf-8?B?VzhkZnJmTGw0OE9YZEJYREJKOHF6dmpQUVFSZ3FQNmxpYlV1L1FCVzJVWE44?=
 =?utf-8?B?am1VSmZlZld5Q0VVbEtORk5rRDNmQkNKQWdUOG91N1dTR1VpRmR6WkhvVjRJ?=
 =?utf-8?B?M1ZqRlpLMUFlR21YOC9UY1NJNTQwcjJzWkpGeHZjT0RpeUxKQTJscTR2UFl3?=
 =?utf-8?B?RzhYckF1WEpweGhCK0lhTTlEWmMyQVp6YTNnMmU4MlVmOHdFZWgwdi90Zjd3?=
 =?utf-8?B?V3orQWhXajRpMFNibXBNdHA4N2pJY21ZVVVaVVlmYUpqVS9sejltRTBmNWlU?=
 =?utf-8?B?Y0I4N0JmWitWSHpZTGpFUGR0UHgrL05xUU1oZkd6UXV6S0xwYlFMV2pjck9k?=
 =?utf-8?B?NGUwOEpPRjNJT1VnbURoUmlBdjJNaU82WnVWeU5YeDQ4VXdDaS8rNkNGaDBK?=
 =?utf-8?B?YXlsazRPR1ZjNFFNaWc0UFN1Syszc01OMysrbEV3UTFnUyswQXpRdUE2VjRp?=
 =?utf-8?B?WEtjbktHMnZLVFkzZkt6K01lcXhhOVhGNTE5TkcrUzhwTjM1bWtkcDEvODlj?=
 =?utf-8?B?UnNFNkVJV3ZjZTc3UWRQTFBySHZEckE1SXRadVpHaUhINmtDT01ML3g3cWFT?=
 =?utf-8?B?eGZOSDY3RS9aVDd4SkJSUjFtSmQ0czZRVVpsRjRKb05iajFNZ2lFS2MxQktX?=
 =?utf-8?B?U3Q4TWhXZkpQZUxjdkd4MVI2UzFacXYrVDBMTFc5UVVveU5CMVRkL2xlMjJU?=
 =?utf-8?B?NlIvbHAxblBVSWtBSFM0aEFuRDBqWDhGZlgxL2doRlhNbFdtRjNFblJCM085?=
 =?utf-8?B?aWdadkc0Q04yU2VrUG9pS2Z3eHZuWEt3Mk5ETFNxNEo0Zmg5dW1Dc3dmaDdT?=
 =?utf-8?B?SS9kbS9iSm5YMnMwQW5kQkxJZk9WTWloOXc5YVk3bzl4SDA1biszUXFOUFR3?=
 =?utf-8?B?WVVtTkpYVk1Ea3hGc3U5NFg4Uk1rYUdxMXNxR2ZHMC9qVThwSmNiODdidlhP?=
 =?utf-8?B?UmZYQ0UraE1KNTlxcEhXZHZXU2E5TitjMVFJaUNHK3ppVTN2WEpVbGFJT0t3?=
 =?utf-8?B?VkVsWnhHS08rcWgwMmtIQmNXUEFUS3NZSzA1L1p2VWVOVGI4MFdLT2xPL1cz?=
 =?utf-8?B?WDZWR1hlZ3lXcExEdWFzSkZrZ0hrUXcwTnlCamoxZE1kMDZvVmFMTHJvZndn?=
 =?utf-8?B?b3lzc1M2ZExrckFrUm96WHIzOFRHYmQrT1AzRGRpbVVRQWVDMFBUbWhERUU3?=
 =?utf-8?B?dndQQmtOVEpJZXVyVEhacitpWFBTNGJTcUF1TDdYSCtVOWIwU2t0NXV1WnEv?=
 =?utf-8?B?L1k0a2taM0NJYU8vV1diMTRYOWdqbVEyNmMyWFNMcXlYSE5QcklxN2d5YVp0?=
 =?utf-8?B?ak9zSmJiZHdGNDJCT3JjdE1uYzljVld1M3pVQ2E4eVJwR2xISUQyZ2pKMTJK?=
 =?utf-8?B?dVR1TmVwbG4vRDloNzJYK290OEpQcFlVUjB4WkpqUmowd1g4WkROSXFmNUsr?=
 =?utf-8?B?LzdoUzFra2JtdElWZG1KdkVVTm9DeWpYNnJ0V2RjK1ozT0ZsUTBxU01UUWFq?=
 =?utf-8?B?cDJSd3pzb2o1dWVUU1FBOC8xdWUrZE1Pa0hCZzdPZ0RKWmtSOE93T3hPaVJM?=
 =?utf-8?B?SW9DallLQ3JXSG1DNFBqVDZPVzlnQ1YzVW5HdFladUVCb09JN1c2Z0hIcWVi?=
 =?utf-8?B?OW9QdHRIRVptUThYb2VqZmczc2xQY0RJdXh0bWZZWVVwSG1TbWNQdmJDMlgv?=
 =?utf-8?B?MmhrR3l6dnh6RWhMcmp3UzVtbTAwSU5vc1lXS3o3S2hVY2tWYjdCRE5tNlpn?=
 =?utf-8?B?VG50ZmdwZGozeUlJVStXU0RSZWlMYnFmUlRQeDdjTjJKVGhQTkZOZE5hUnV6?=
 =?utf-8?B?ZU5vL3VveDM4S1o0aEFodklGbk4wc0NsaXVlbGt2YkhocmtGcyt5eHRPYlVV?=
 =?utf-8?B?ajdiVEZPRnVBeSs5MGdpV0huak50VkJJblM2dytJK3RoVmhoT3ZWdG0rQ2cz?=
 =?utf-8?B?R1RXS1FialpNRUswdW1pdWR1UnQraGxJMXdkeVBnMzcvOFhKdXR0MUlyUmNP?=
 =?utf-8?Q?cWjc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 12:48:51.0862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5dc40b8-ed8b-486c-c9dd-08de187bd7b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716

On Fri, 31 Oct 2025 09:07:04 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Thu, Oct 30, 2025 at 03:48:38PM +0000, Zhi Wang wrote:
> > The previous Io<SIZE> type combined both the generic I/O access
> > helpers and MMIO implementation details in a single struct.
> >=20
> > To establish a cleaner layering between the I/O interface and its
> > concrete backends, paving the way for supporting additional I/O
> > mechanisms in the future, Io<SIZE> need to be factored.
> >=20
> > Factor the common helpers into a new Io trait, and move the
> > MMIO-specific logic into a dedicated Mmio<SIZE> type implementing
> > that trait. Rename the IoRaw to MmioRaw and update the bus MMIO
> > implementations to use MmioRaw.
> >=20
> > No functional change intended.
> >=20
> > Cc: Alexandre Courbot <acourbot@nvidia.com>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>=20
> > +/// Represents a region of I/O space of a fixed size.
> > +///
> > +/// Provides common helpers for offset validation and address
> > +/// calculation on top of a base address and maximum size.
> > +///
> > +/// Types implementing this trait (e.g. MMIO BARs or PCI config
> > +/// regions) can share the same accessors.
> > +pub trait Io<const SIZE: usize> {
>=20
> I would consider moving SIZE to an associated constant.
>=20
> 	pub trait Io {
> 	    const MIN_SIZE: usize;
> =09
> 	    ...
> 	}
>=20
> If it's a generic parameter, then the same type can implement both
> Io<5> and Io<7> at the same time, but I don't think it makes sense
> for a single type to implement Io with different minimum sizes.
>=20

I see your point. It also makes the code look cleaner.
=46rom my understanding, this is essentially a choice between performing
static boundary checks through the type system using const generics, or
using build_assert!() with a trait or struct-associated constant.

Let me take a closer look and experiment a bit with it. :)

> >      /// Returns the base address of this mapping.
> > -    #[inline]
...ditto
> > +    /// Infallible 64-bit write with compile-time bounds check
> > (64-bit only).
> > +    #[cfg(CONFIG_64BIT)]
> > +    fn write64(&self, _value: u64, _offset: usize) {
> > +        ()
> > +    }
> > +
> > +    /// Fallible 8-bit write with runtime bounds check.
> > +    fn try_write8(&self, value: u8, offset: usize) -> Result;
> > +
> > +    /// Fallible 16-bit write with runtime bounds check.
> > +    fn try_write16(&self, value: u16, offset: usize) -> Result;
> > +
> > +    /// Fallible 32-bit write with runtime bounds check.
> > +    fn try_write32(&self, value: u32, offset: usize) -> Result;
> > +
> > +    /// Fallible 64-bit write with runtime bounds check (64-bit
> > only).
> > +    #[cfg(CONFIG_64BIT)]
> > +    fn try_write64(&self, _value: u64, _offset: usize) -> Result {
> > +        Err(ENOTSUPP)
> > +    }
>=20
> Why are there default implementations for all of these trait methods?
> I would suggest not providing any default implementations at all.
>=20

Yeah, I actually tried that in an earlier version.
I noticed that each backend is a bit different =E2=80=94 for example, the P=
CI
config space routines don=E2=80=99t have read64()/write64() either. By
design, we don=E2=80=99t provide infallible versions for the PCI config spa=
ce
backend (unlike the MMIO one). Other backends might have similar cases
as well.

So I ended up keeping the trait=E2=80=99s default implementation "minimal",=
 only
including the methods every backend really has to implement. The default
impls are mainly there to catch situations where a driver calls something
it shouldn=E2=80=99t.

I should probably make the compiler complain when an infallible op isn=E2=
=80=99t
supported by a given backend. And if you have any ideas on making this
more elegant, I=E2=80=99m all ears. :)

Z.

> Alice


