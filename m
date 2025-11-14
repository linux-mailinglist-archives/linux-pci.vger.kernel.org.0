Return-Path: <linux-pci+bounces-41252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 097CAC5E489
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 17:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 694A23A1571
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 16:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6926259C80;
	Fri, 14 Nov 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JTOkn4dB"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F52221FB1;
	Fri, 14 Nov 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136443; cv=fail; b=iJf60WK8jnPMNeSkc4sZ1j2Ydx9B4UKDZROHsaUoRH74VA43wC5l0evvERhot2n2I/nUGYJEwFlB4cPkjlzb7rTDKbewiykypAVtxooRq1q7fazXvtiSd8UROX5pqVHk3PIADWE8Onef8Fc3Kg3tpWw3xX1BzBJxU8fjQaX/ou4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136443; c=relaxed/simple;
	bh=BpW1nCoGOhN83sGb+Y+iVkHCHjXvP4tMAYnuJgTQgac=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kws7mD+Kcl9teL1qH/bdOpGNLiBAKobLNxXg6prWjRiLSOQAoDXSRVHpbOJhQBejQ84RQX1W1rP7K8ZrKLaBpZnVp3iGU/o+uPzkzFQVKYSYG8LatBWsyFJlGnC2Z9E3aAsfZWaJ5bWuybt/MWbhMH8V+fK3mSutwjfpy3rqOtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JTOkn4dB; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTRaQHqQXPdyYQFEhRUiBI7FgVzM1CYoAinGUgrGRBRZjiwhrBayHn8aT3e7yoCAJYESgusMOQIaX0pRIHeC2GmnY5EKlnIcuNl1hpcKz1z5PoW069ITyiWL2ngYsMvIAPO18xZqLVqVBCGIwDUOUNvLdXsj+521rh/dFPIcYPig4q3JokDy0Y7MFuIMDnsFV9/TDM73/mhmxFDAaMvukf8T7DlF+qM0t8HujRbSeXFWpp57+aeTIjCE8KJowI3pVXDgvDBGCIGQQYQ+HmF1DOr3W+r/BMPYsQksKToTtrgdMH2jv2vpcLuo9vWymglE5GeFiyZ893LED+YOZVtNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vE79wRBMsMKF6Q27XEuPiX1+8ENyHGij/CfhWxrskk=;
 b=Fdbw0CFl4TAXAq73mxU8WXAHxNsyp6IhkDud1HsHPk2FgEn8PFMaBJX6wjn7AqRVSf2PPUAfn5hxet0AMfKPPTNDcAhH6c/SOO6k/bfscGZnRyBF3Me6ROe7gg8BK/ql0Dn+DTHkXBbkNYCh/AgOLHdvKz18qIWN4s67+az02kmOOFmZb4ib/pV8K0oUplwnMOuQPp+TmVZjlijVUVaXYnzvd88sCvRIQaPFfz65fS66QHsUeRZhWOuPh+CTf3/RDtwQsbK3y+zZU3OUh058+o9Tb1q9DU4v1JAZCCEXXo1xq5IkDQVtXZXFJcSffwkrxXqCWxiA0mXvRmkvE/CtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vE79wRBMsMKF6Q27XEuPiX1+8ENyHGij/CfhWxrskk=;
 b=JTOkn4dBtfR6VoEQ2lAWUA0dlHoGvtg3/VDPYHDpK5TprxtVzh7eJ9jhSrwGJTi3ClclENzNSkXJKIG2XPVTRZSKZ28IzisaFQx6sg6fj3HQAn/EKbufAUAmojtFNUfsk/y4ucD6WFTKg/0om14EJB6DH6phf69BZHl9xUbhtdRl3vNuhlaiT9ByLMhtXJq+xx2fR+tbnjvOAZVKMxq3f1qhjSxzFKGRtNw9R1XHKiIjNgJPcUGSwujkLR2qMCyxgI/ZPWvKmobM0nHQS+QV55TkHU/SAJDIeTz/5LpyjHw1PwHUnqgfTFKANdjt7XiMvEYbjYwk32nIb4AD/HHwcw==
Received: from MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33) by
 LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 16:07:18 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::d1) by MN2PR01CA0064.outlook.office365.com
 (2603:10b6:208:23f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 16:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 16:07:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 08:06:57 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 14 Nov 2025 08:06:57 -0800
Received: from inno-thin-client (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 14 Nov 2025 08:06:51 -0800
Date: Fri, 14 Nov 2025 18:06:50 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v6 RESEND 5/7] rust: io: factor out MMIO read/write
 macros
Message-ID: <20251114180650.7f74ea13.zhiw@nvidia.com>
In-Reply-To: <DE7E7YXGLRWP.39EGH02PEV46Q@nvidia.com>
References: <20251110204119.18351-1-zhiw@nvidia.com>
	<20251110204119.18351-6-zhiw@nvidia.com>
	<DE7E7YXGLRWP.39EGH02PEV46Q@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bd8cf5-4502-4d99-5544-08de2397e2d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1hhVFNiQytPcDkvVlhSKzA2OHd2WjBidisrWUtrZXZRZ3kvTExzeUFHb2Yx?=
 =?utf-8?B?OW9Nb3hMUXVpNys3NWF0Wkh1d2lJYWp6eEdvMnNvYXNnZG5EOTJMNUdQZVNq?=
 =?utf-8?B?ZWZsK08xcFRGUHY1NkNubjlDTjRwUUlwbHNKTzV6YTR0VngrN29CS3A4blhm?=
 =?utf-8?B?dHMzYnVRMmVyUmdQYm1jMWlrSGhScmxxMGRvNjZZVkJGTXU1ZHg3Sk85Ukpr?=
 =?utf-8?B?Wk04MlVQNnpKK2V2dWJtUStIcEswRVlzdnU0M0xsbU9GOWFpV3ZjMm1wd3hi?=
 =?utf-8?B?dTNyT1cvanpDcUNTR1BOdGNhWWNGc2RJQXk4NWVHOGszSEdMSlRiS2tQMmU5?=
 =?utf-8?B?MkFqOTByUlpobFdWOUszb1ord3ZuZ2ZXZ1dlWnNlZisybkNvNTlsUHo2Uzk2?=
 =?utf-8?B?UG9JNW9DZ3MzOGJiWDlYU290RElmbnpBU0pzQ3R6amt2TDNML3Q5eGpacElP?=
 =?utf-8?B?S0NTOHZqc2xVeWk5Q3VHQ1JleHU1eURMQkZhWVlCMVNManp4RlBZQzNxMS9n?=
 =?utf-8?B?bUdjUElxMEthWFF2dGROdmtkaURpRjIxMFM5MlhmaTdRUXE0Tit0RWt6Mjd1?=
 =?utf-8?B?MXN0WVRjbjJvY2V4YWViK2VxRFJoT2I1NTlxbExzZGNUbThYWDBxTTA3ejc0?=
 =?utf-8?B?b2xHcFE1R1duWnh3TVRhU2hnMktSZGJFMS9CcFY1SUxoZGx2TkdLZEFibE5p?=
 =?utf-8?B?WTROUlQ2d0VYNkd3L0RJbXhhSzE4MEpoQnhyVmlpdlZYWmpka1VmVWg1Yml4?=
 =?utf-8?B?UTUxK3FuV3RrQ3ZRV0FmS2dvTlQvZmJUbGhGYWFWRDFsaVdIZDlFbmxvM2wr?=
 =?utf-8?B?UEpIRDFzazd4RFJLdHlWNTRaVHZZb2lYUWpwbzZ1bVVTb2pNbUVWYzYyeUtE?=
 =?utf-8?B?d1o3Y2pXdnBRUXhJM2JQVFo4dlM3ZHcxWEl2clY5empEOXFMU0wwSXEzZ2NW?=
 =?utf-8?B?OE1obEw5ZFp6c1JLbVJFbllQamFvTkhpZHgzM3ZKSzd6RHVhSGhJOENybjBJ?=
 =?utf-8?B?ZmZjN2VBaVhtdXgrSlhGZElmUmVQbmpoOXEwa0tQK2hDLzBUNWc1WU4wZGFI?=
 =?utf-8?B?UHd0OGsvdkRGdGNPazgwOGpYYlpWTDBIbWlTRTQ3N25lWlBYeVFpU2ZybkZl?=
 =?utf-8?B?U3N1cTgzNW1QQXZwQ1NWa00zVHl6c1Qwam9UTWpreGNtSXdkNVBuSFl3RXlI?=
 =?utf-8?B?WnJneTJhNC9DMWZTam9PalJHT3pKRUNLZzlmbTkzdFNXOFVSU1k3amVlU2F0?=
 =?utf-8?B?WnU2c2tZaUJlc3BValcyMjdvWEczYStyaW0vRXRNbWQ3b1B5dnNBK0lMMVEw?=
 =?utf-8?B?RGt4UG41bVkydDliWDI1VExBWFRic1BsNjJYcUpOL0hOKzdkYnprQlJBY0xY?=
 =?utf-8?B?MnZUT0pDc29JU0c1ZlE1N1AzdTZpNTJ2aWlrWDdBZE9WY3VhTHJ1QjlWbVJN?=
 =?utf-8?B?VGNnUklZdG5yOVdLbEgwSUZXRytQUXFaQ29haENPbmh0bHY3ZWk3Vit6RkQx?=
 =?utf-8?B?K3ovQTAvdWZKK1F2TngyZXQ4UlFNWHljOFNxVHNZdXUzVzM0M3VwenIwUVFq?=
 =?utf-8?B?akpac3E1NXM2R1ZIaTF3a2EzeVNGVTc1VDlDVkpSODFTSUVvSGRMV2x1ZFNi?=
 =?utf-8?B?Z1krN2xCd3pLN2xUT1I4dVJ6NDIrNEJZaXFQcW5EYjdNN0haaXhkOU9BdUZZ?=
 =?utf-8?B?OUNEMDdlWHhjK2lxdVU2U0tXbHdveUx3QzJ1MWl5VEY3dWtTR1R5eXR2ZWNZ?=
 =?utf-8?B?YnVzWFVXREV4aEs3QU40RDRXRG9OTEpxeGtXM1RPc1ZBRWh6MGRyVGdCNjgw?=
 =?utf-8?B?andKRWlhWDIwbEZnOWZTTDhvdmc1L1Eydld6eWRQeDhtWkhKbFNxbWpGeElj?=
 =?utf-8?B?ZU55VVJEMzZ4SFZkUEJvd0RYbCtpVDYvNFlleUk5Ymx2VmMvZjlqdVBnMFRR?=
 =?utf-8?B?anRFS1AxRGQzUHlMaFI4MmZMd1kvaXdoUmIxYVduY2FrT24yQ1BnVVdhVk1a?=
 =?utf-8?B?dC95UGpIcjdLbUZ6SWU2d0F4Y3NmOTJhY0lFWWx3VVNGTzRJVGcycEpwQjBK?=
 =?utf-8?B?T1NiOE5DRUhUZ1h1dzBUMHVRbUVTNndJNlJsTGNCMGhzVkFITVBDa3M0ZXV5?=
 =?utf-8?Q?XPl4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:07:18.3828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bd8cf5-4502-4d99-5544-08de2397e2d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800

On Thu, 13 Nov 2025 16:36:47 +0900
"Alexandre Courbot" <acourbot@nvidia.com> wrote:


> I understand the intent from the commit message, but this is starting
> to look like an intricate maze of macro expansion and it might not be
> as easy for first-time readers - could you add an explanatory
> doccomment for these?
>=20

Sure.

> > +
> >  macro_rules! define_read {
> > -    (infallible, $(#[$attr:meta])* $vis:vis $name:ident,
> > $c_fn:ident -> $type_name:ty) =3D> {
> > +    (infallible, $(#[$attr:meta])* $vis:vis $name:ident,
> > $call_macro:ident, $c_fn:ident ->
> > +     $type_name:ty) =3D> {
> >          /// Read IO data from a given offset known at compile time.
> >          ///
> >          /// Bound checks are performed on compile time, hence if
> > the offset is not known at compile @@ -135,12 +161,13 @@
> > macro_rules! define_read { $vis fn $name(&self, offset: usize) ->
> > $type_name { let addr =3D self.io_addr_assert::<$type_name>(offset);
> > =20
> > -            // SAFETY: By the type invariant `addr` is a valid
> > address for MMIO operations.
> > -            unsafe { bindings::$c_fn(addr as *const c_void) }
> > +            // SAFETY: By the type invariant `addr` is a valid
> > address for IO operations.
> > +            $call_macro!(infallible, $c_fn, self, $type_name, addr)
> >          }
> >      };
>=20
> To convey the fact that `$c_fn` is passed to `$call_macro`, how about
> changing the syntax to something like=20
>=20
>   `define_read(infallible, $vis $name $call_macro($c_fn) ->
> $type_name`
>=20
> ?

Then the macros will look like:

define_read!(infallible, pub read32 call_mmio_read!(ioread32) -> u32);
define_write!(infallible, pub write32 call_mmio_write!(iowrite32) ->
u32);

The readability is indeed better - I=E2=80=99ll take that, thanks. :)

Z.

