Return-Path: <linux-pci+bounces-37467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9986ABB4F3A
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 20:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B06419E2453
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 18:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D2327A919;
	Thu,  2 Oct 2025 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T1gUFYlK"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A26927A904;
	Thu,  2 Oct 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431393; cv=fail; b=oE8gyfc80E1JLV9W14rRAYmKXnCBTZ0lj0+uZ2/+w2Ztk3FAurROxsWfOOfKfDNDvPpxeyfklTB4uoEwX1PMuSi1q/GCbr4dainivBgVRRM0NGF3R0FUHp5Se0AZrZUw5kzvrFHogh3KlrlO8CG7Pc3UMMqLN2i5MGdvB0wBk0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431393; c=relaxed/simple;
	bh=HjbWz2mg5gDUOWi+N4crTza+V/tH7m9cJJyS5d0Sl/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k+OU835Rk5kLlmOyr9pE8xw7UgEnzogUAPwHqYGcq5CXBlNzNZS6639m0+KXCKDxgdvCM/LyJoqEWhOWBumJm8XmP5X2K+z4hoJxQGM8xRLcN4CshoU8xwy5iVsFHDUKSvKm6GDqHB9rDckW9UE+va0RZGI8uyE4ijo9Qe3QsOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T1gUFYlK; arc=fail smtp.client-ip=40.107.208.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuNmfxlW1i8f4a5W1eoZCCvpyJxkbtiNirxaDQs9BQpYU6iJLPBrLnXmBQLF0n5Uctk+Y6cad45+KuPu07YxlQnvS0QZrXcgarhSDHVhw/0yuOvBYe+B6sTcmhtVJGwJF7tDzsx3PByTyYHos0Bu1lxvNWEbXTRrdqbdTdoAPISUiP80aY+VZO+nOspLRyzUuAKBXt2/ycuQJmAPZBG978rR7e4TfH6Q9bEj38Q2aKm3coLocwn3F5ySyilrRGPQrjBxnAOMgApVJfegp+3pQbbhIGXri6FoRr0jhC/cg/csk2Qm990KaB7xgQ5nxPo0zxQ9OXT6Fgsr56fwGPMmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70DZ3cASm7z6hRElWEo/U4aVVBTVBLHhmUMvds7xyMo=;
 b=MpB5I5/cma9/ltfuG4gD0LdvqBmyXaZO1+55RMQFaXLFF3m6ykWMaOVEIS2TDLuYxvE18pIGb8gc5FzCmerHRfByALX3fjGwwZ4U+Qvf205NS6w+AHRLegvzuuRoYN11DfPKH9itJV75x/NWKhW+WgClO8hGIxZMnMlmQezlGdMFvCvS+qTT6CuSELgqQq8pua/jbRKw5Vzv1GtDhhZaUavaiRjs6bhekSnl485kaI5w5U5hciKggnT+Dhmnpkbcrn/1ZPCXQoHYQayAzEZ9phYCkgt2q670XM0jBlkfiqzRkrW9IwqspIZ/TmER7jCFfI2/64VxD2TTagoSbIH1SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70DZ3cASm7z6hRElWEo/U4aVVBTVBLHhmUMvds7xyMo=;
 b=T1gUFYlKh+kzbC4/7zawh566B03a0HsL7xspIwnIWEdT8cdwzBAE6pmf5E5XZRljyVS/Vx+ruGrdn37qX4FV9rbvF+cPItovB411mkgwQmpy1uJKvbtJtWA+MUbYDn6tWqG1Xv84+PTz0GOMtyEfSsgggq58OqdHDymiAO/Dpd9pWqtRhBRI/9KNg2S8sNyA5/02cUsAgcJ2Za2HXjlB7PYsCtRWrpoGun3PHMtKjtsit1nx/ZQnaoAeUAMV8ZU6nRhUoUDZOzO0/F4PPzV3OIarmXn0Y7FGjEze3Qrw2PXTOeopmwObS4wvWanmraYYYUy4S7hiz7qr12kx0b05TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CH1PR12MB9599.namprd12.prod.outlook.com (2603:10b6:610:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 18:56:18 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 18:56:18 +0000
Date: Thu, 2 Oct 2025 15:56:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>, Surath Mitra <smitra@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] rust: pci: skip probing VFs if driver doesn't
 support VFs
Message-ID: <20251002185616.GG3299207@nvidia.com>
References: <20251002152346.GA3298749@nvidia.com>
 <DD7YQK3PQIA1.15L4J6TTR9JFZ@kernel.org>
 <20251002170506.GA3299207@nvidia.com>
 <DD80P7SKMLI2.1FNMP21LJZFCI@kernel.org>
 <DD80R10HBCHR.1BZNEAAQI36LE@kernel.org>
 <af4b7ce4-eb13-4f8d-a208-3a527476d470@nvidia.com>
 <20251002180525.GC3299207@nvidia.com>
 <3ab338fb-3336-4294-bd21-abd26bc18392@kernel.org>
 <20251002183114.GD3299207@nvidia.com>
 <56daf2fe-5554-4d52-94b3-feec4834c5be@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56daf2fe-5554-4d52-94b3-feec4834c5be@kernel.org>
X-ClientProxiedBy: BN9PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:408:f5::15) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CH1PR12MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: adecf824-23f1-49e3-81c3-08de01e55ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tR4QA47p2QoNLJvVOfqtliR2Ii9cb49K+sA1AxWegvWKaZyeLBO5XNE8xVVa?=
 =?us-ascii?Q?Hmt6/w37BlZ2JBlIjG51ofhCJMvdbkU6GUDtM/7LbgPQTT1ZjvJAInyjB1pf?=
 =?us-ascii?Q?fEHF3v4BIZinckHDhMlr7WiY2Pw7Mrbv+Itzg2HusiIw+Agk79/ABfTuWEnG?=
 =?us-ascii?Q?QCwo5dadff3XIfUv9PTCCvoESC1Z0S4OwbyVkmG1SAi5vzSvf82Io8QJu+MJ?=
 =?us-ascii?Q?B3uE7LtGnfN95IkBkEKgbomPajJzdFIZSE/OB5lZHiOT+qMuFYTfYSNDKTgb?=
 =?us-ascii?Q?tKKpexuJxncM4yKEJtietY9xi9Q6/Lzm+zdyqmrMmR7QoAPl9xDuMOvGoYoX?=
 =?us-ascii?Q?u74JaFcGerSMsaatNwlUXsK30N8INoL4/rFtTwU7akKi9x/OKYNYh80xDdre?=
 =?us-ascii?Q?1sYcDebtUzPJZ9zQEaDsoiuUY2lELXJotzNxu6V2mMHlIJ1yKVm4HYxT568v?=
 =?us-ascii?Q?2fdRYM9soBONhnCrAxvacS8rCMrQGG4u5OZOHpmpQ6N5MO49kPxpTgFPFKba?=
 =?us-ascii?Q?wuWioQXLT7LIPC+UiimrzmdZA/4JynjL/zysewfbcxDU7vruySj0HhYS7v+j?=
 =?us-ascii?Q?D+6tzNTBsCW35KQd6MyD3aJmv6wAaYUGoosse/oQzHbFTzAd+2Y6NeKDRy3k?=
 =?us-ascii?Q?hhysWqOyP6031mRAlom/UxbfsvG/KFj5FzsVK/QBximnG22ghLVIzFgUDBAf?=
 =?us-ascii?Q?lugUpJkwk9RqXv5PBXmpSMlsXZb0zyq/BpbE6E0+X/PjKhvh6DZXNoIOIGWv?=
 =?us-ascii?Q?JGaxdbLbYddj/StNaihOyDHg2Nhe5tbrF+pzICVZ0B5nilhJgdV9d0Aj4FsF?=
 =?us-ascii?Q?A2fiaTaMjl5Yt7ijxw3YGsm1bSjgOA4budiHTPpug3L3rEpbIbBX6irsCn/Q?=
 =?us-ascii?Q?TbnPm0/TZeRFcRvgFKKnCqcJk+0RVcgKKbHkcAMrTnte+0Ddy0nWIRPg+7Q1?=
 =?us-ascii?Q?ScIJgYyDI+rfKXO5rIz5Q4RuOEQBJ8n5Kf1oG/UNQoUHoDbwRfzUcoYs5W6T?=
 =?us-ascii?Q?io+9PiyWMFO4mEgQ2wIrvaXyNWYtv5wBi2HVrNSmlXCF7kquudUKFExxj447?=
 =?us-ascii?Q?5gODZOaJ0EF566E2T99x8O90yZcf9XFM9Wb6iHmnRzLEigMYdPaJEuAfrnav?=
 =?us-ascii?Q?vl1V24NHe9Ln/kGeRZF/8PwRjwG+34dnZiEmIKPxo01G7XQs6+41zA9W6xUx?=
 =?us-ascii?Q?6W1OrzVvGHhN/VdITinUugt+rGNB4vfIzcuacHN7RoCheAoIzF0DyCEgX/h3?=
 =?us-ascii?Q?TOFdsn7YZhCW6vcdDTCkEChsAfpV6+mFdBBezuQA5dEURB68Kg8N/MdsleuJ?=
 =?us-ascii?Q?t8jWXtYcxVXn7aCY6dZsnEdqLy7OWsvdz1igVvNbOIZh/mEdrightUaBprmi?=
 =?us-ascii?Q?0XXVOFVK0iJcfW7cu0VhrsoMLBLOMdgQ18s2laKr6twwiPzmm9IbycD0QtcF?=
 =?us-ascii?Q?s0x5aLYKx/byu7IlJecfGhVLGqrVibHO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0rf7lZtbZQPprS2uarGUjbWr84oun8Kb3XG6MNQ3q23UenWuHt6K1Q1TQczT?=
 =?us-ascii?Q?sO50tIPeO+PerJCqgJkSQVEVpbFqyYy0U9SB2UOsGRSxuVIANczoOSuybCAA?=
 =?us-ascii?Q?fwjYQ5GNpfNcDxljZnijfI3XMOaU101V/TjAGUl0XybAq94N4OY29mSdcOLZ?=
 =?us-ascii?Q?Kgzu6dzkUHrSkWiioq/5/64Tykk53m6nfSLvBJZB5spJfNXF7YBT7Z6HGz+U?=
 =?us-ascii?Q?pr2OHli6qo3anffdgsWVK8IColDDtUREYMphoRiMCgzuzoP58XvsyOBoDZNP?=
 =?us-ascii?Q?q+wrEcX4T/uM+G1M/mRm/7o9yKYleht+Ld4HwmP9gFEIayX8PDy5WA2PAoa/?=
 =?us-ascii?Q?ADqZXDQgb5d8URMmfxFs64RZBB0p9NEP6EMjZymQDQkaW+dCcxhBAN+VlxOA?=
 =?us-ascii?Q?uTinV2Nn+T29QUfsXgjNQ/8wnLGlhIQScwVl+x8Aahi6V/XX1WzDfVDmAafi?=
 =?us-ascii?Q?oRsEGSyWXfArD9i14h3A/nUf6CBU6F9lQUjz0MLSq+FWT78W6bcQONx0nYyE?=
 =?us-ascii?Q?QFiagnFOfHASz7s3LzdbAvoYhd4gbW0YUC4P7UAKKwzUbngCNISdw3RMTVui?=
 =?us-ascii?Q?ybRJnwh9uZmJ5TElFuUPTHNhJuiRwkjdRm76T3+9o7tTe5+Wn4Sxp/UQDYxR?=
 =?us-ascii?Q?xfOU1P4aM9anJLywGmUiTbGiROf+pnoojqKGx9aOVOhB4tDWLyNu+BYMafDw?=
 =?us-ascii?Q?1wQdN6Dt1nf9x0/+AVFt6Dha1U2+SQ8A8Fp6Xr8D7spCMvZUhqhqQqDv1j03?=
 =?us-ascii?Q?lDxOjO6dFxwCVsib6Vsu2cziyS2Yf98gxNtlJetJl2lJLA+u92wm2HahTRoI?=
 =?us-ascii?Q?zjGv13r2ZT/lSAF5aOIxvHx8HBS8xnYaKydXq/gT2T6BZqBhOoHRxdWVRBwX?=
 =?us-ascii?Q?zNjpY4XJGnJQ6gg4PUQ+58/QwBdX+u6/KpGUXdTSrgWIYCHPNIFdnA9Dks45?=
 =?us-ascii?Q?wjbTAvNGhu5T6SaLBRfuvrQqAzZy2GgottqbjAry6dU7w9YahD+S7GPQ6EUg?=
 =?us-ascii?Q?DWS4+ceyaXClywCBqckpgB6ECd0PnooeKg+fFaawZzaapPRQuh4YCzmKrM6U?=
 =?us-ascii?Q?TIVaP1go6ngCEcW57kOiMH97630MTlL+a8gllit5fMWJoe2MBh/kga+zGrFb?=
 =?us-ascii?Q?AlcOrND0d+5m1Vm0aXFvnS+Up4CnsYibumRiiwhkan2ufclQ9K+pLO04tuJy?=
 =?us-ascii?Q?UkRIYjuUb01u01W3Q/95qWF++vc/ETaIJjHideo3+zdaZCv3n5Be2yuKsrNh?=
 =?us-ascii?Q?poPsrvgv8DYVQYcezPZz5gp2xDahBupFh7D390Yt/MJEbmYKFKGPtGt8hIpN?=
 =?us-ascii?Q?sMgef0VtIh1n+2nhT7i8zYdTYdBYfcbrtCH9BBWhLPGHJEISgdYbNbp1alaa?=
 =?us-ascii?Q?KKsyaztVxM407pSOuVdixg8YewkEiSFuKYAnE2DSKwMBrQVStK3NhFg+oMht?=
 =?us-ascii?Q?38jgoYpMcP4BRsi6QgtlKSfMtDqr5IoHiJa5tXPz2Cn3v6qXr3wVEKLC6FFd?=
 =?us-ascii?Q?qWmn2yhnLrLyZgJxPHHeJ0VCLxo/L3i8z2WEpk+3mzmQFtL3g3jmFj5D64Si?=
 =?us-ascii?Q?vLvko8MAVWg5Gppc3Ss=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adecf824-23f1-49e3-81c3-08de01e55ee4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 18:56:18.6134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHdSOzLYHXDPkRJaVZKvPRprz/e4j2AMy0jJArTlw2OQSnk+9TLLxdAJRIvmM1Lz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9599

On Thu, Oct 02, 2025 at 08:42:58PM +0200, Danilo Krummrich wrote:
> On 10/2/25 8:31 PM, Jason Gunthorpe wrote:
> > This exactly how this function is used.
> > 
> > The core PF driver provides an API:
> > 
> > struct mlx5_core_dev *mlx5_vf_get_core_dev(struct pci_dev *pdev)
> > 
> > Which takes in the VF as pdev and internally it invokes:
> > 
> > 	mdev = pci_iov_get_pf_drvdata(pdev, &mlx5_core_driver);
> 
> Oh, I see, that makes sense then. Thanks for clarifying. I think I already had
> in mind how this would look like in the Rust abstraction, and there we don't
> need pci_iov_get_pf_drvdata() to achieve the same thing.

I'm skeptical, there is nothing about rust that should avoid having to
us pci_iov_get_pf_drvdata().. It does a number of safety checks
related to the linux driver model that are not optional.

Don't forget in linux you actually can bind VFIO to the PF, start
SRIOV and then bind VFs to other drivers which then fail
pci_iov_get_pf_drvdata(). Blindly converting a struct device to an
instance memory without this check will be buggy.

> Yes, I already thought about this. In the context of adding support for SR-IOV
> in the Rust abstractions I'm planning on sending an RFC to let the subsystem
> provide this guarantee instead (at least under certain conditions).

Certain conditions may be workable, some drivers seem to have
preferences not to call disable, though I think that is wrong :\

Jason

