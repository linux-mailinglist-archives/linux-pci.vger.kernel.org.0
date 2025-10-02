Return-Path: <linux-pci+bounces-37449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42D4BB49E8
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 19:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F30519E3FC1
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE9386342;
	Thu,  2 Oct 2025 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DqSb7uzU"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012069.outbound.protection.outlook.com [40.93.195.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9355C19992C;
	Thu,  2 Oct 2025 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424717; cv=fail; b=O8lmGpUenrCI7CXKp/UAA+nLj60vlOTn1ZdLfYAVY8YZmN5/WYJVCh9mVNBITmBN8pU+1nJHQujV1ZRLUPgL7sDxNJx/KF1LSLEqJUe9BWumBw6TNRh3/v4wyTPhxrx4wyZjOsDTZLgSEUzUnPvPy/95uWjxCIJNq8a2x4oi3aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424717; c=relaxed/simple;
	bh=1BTRiquymZsHpJD5779pZyju+joZqP8EazwjGkciDzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k4Vh3Tc9g1JvSzU8QhX29tDTo5C+M6+lZV+o/VMhY/vvyNYDBNQshzkNt/Mu+kS/n/4i+1QcuTZW9rMqKQDPX/f5gGLncEE0bPzcS+js2B6ckQgNRprEFhFaKp7yma3Zju44l+76XKUkmzlOZSKoUVONnB3PtK8CL30xutPzXok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DqSb7uzU; arc=fail smtp.client-ip=40.93.195.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KW2k7iTU8pMaYEUVhtnBdutWWnu0doOpGZag5QLkezT3B+JGMP35hpdCiRUN6i0HMgUU/lcjCoCTZ4PhD6LPy7Ow9urRMebUqs8Vr9nIsP8kcE1cZIB4784nWfuLfgXPTcR0cmqzLLM4RFsqcoh5+v7W9hh7ulIMOL8U2HQuatVIBb+GG3850DvCi55nh93U8Jen+2jhDSw3Q8ttHvBuIcI7GMme669y0SNaJCApVvPoMTdRQPu+6nOu2E9SjHZ6+n0csabfJnrcIlnjD62bovQXGS6x1Od1MF5JTf37M3fQSnYxeL0y5YJjd32/xSwPckNANQ2kH115PTBjFelMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqHQ8LHeFVcoIoI9Klr2X9mw56KQ0kpRTytvrDMDqQA=;
 b=flpGjEY2EDyjkrb8wl7FHojdmwWg34vui9NF1rwYZWTZxefYXm6E7Q1fuMoi1gasPiaBMW+hfiB0U/JJzhqMLR7fJO3TREFW0s6A/Z14bR8XRhmZOlf8ozoVggWPL4QiJuS2u+tg3VjG+KHuGTUFWDBilpyuTff5aa1GpD9P97s/YcK/DIugy9P1obtKdjJIZ89XCcDrUVgDfwQZ+NKOIBV9MdnguBtSRzNBo1gikpKcrO7FkvhQFLqobKKx8b7vfMMNYZILRKoqotH/obM+AcAPHSoHcoOpl4xVoBN3+7bcoGEapeCRYoaK4saogVFShl37cphMssxNQhFmTj83WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqHQ8LHeFVcoIoI9Klr2X9mw56KQ0kpRTytvrDMDqQA=;
 b=DqSb7uzU1LKAJlLrknsSdOFDlY2ztKXsve5aJ9+pp/kBHrd0CR+vlj0mtnNkfPMtvWwMRmzoz4g842eBham8URTrwEplTl1s0Yjv7qQZ4tnSYyrDnlDfjRt+5NfgEUGvOtYVaFN2L8fhH74QsuPp2H0JFRMwK3GyLGKRx5415R0D9UozQ5XO9LSfRnRKMRLEqTDLZz0UlsndpxbHwc0/zWsxEQothsiy/lpojyWL3uY5eSsNURsq7KJ85k4AV6/u1k3/Ff9n7n+P9kS7lcUvO1T6TmK28Cjs+v37Cf9i4Bq88ItGZy0uxLfrJtOUmntMu4Y5Rmc8AoHCEMZGexwlkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 17:05:08 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 17:05:08 +0000
Date: Thu, 2 Oct 2025 14:05:06 -0300
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
Message-ID: <20251002170506.GA3299207@nvidia.com>
References: <20251002020010.315944-1-jhubbard@nvidia.com>
 <20251002020010.315944-2-jhubbard@nvidia.com>
 <20251002121110.GE3195801@nvidia.com>
 <DD7TWUPD83M9.5IO0VX7PP1UK@kernel.org>
 <20251002123921.GG3195801@nvidia.com>
 <DD7UVCEVB21H.SQ00WZLLPINP@kernel.org>
 <20251002135600.GB3266220@nvidia.com>
 <DD7XKV6T2PS7.35C66VPOP6B3C@kernel.org>
 <20251002152346.GA3298749@nvidia.com>
 <DD7YQK3PQIA1.15L4J6TTR9JFZ@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD7YQK3PQIA1.15L4J6TTR9JFZ@kernel.org>
X-ClientProxiedBy: MN2PR01CA0044.prod.exchangelabs.com (2603:10b6:208:23f::13)
 To PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: fc884af4-ad81-4632-9e7a-08de01d5d6ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FdLdjOA+JIuvRJaUEib8OH58+AWqJQVwBgeTVUCwm2bAy/5tIfjIpXwJXAXR?=
 =?us-ascii?Q?aInpZGOLn/D8aXc42kxLyND0kSVs1JlYdDAiD/lJqGFcBf2FAGnkMyYttMc8?=
 =?us-ascii?Q?uVjetTxDXI5Te5eGgrl+hq1MRK2Gc9DYH3D2pH7SFZY9KHvXNubjAtLEuUd8?=
 =?us-ascii?Q?pGcp90nD/E95SwiacPsZQizEoW6gpT2uDkJ8Q9Xfr21UV8xHzAPRjOCLCxE+?=
 =?us-ascii?Q?9/IxH9NM0bl6uod89iDppKA/CzpcIRDnrnHaDjGfQUt9oGpnNP+6HGYRppf8?=
 =?us-ascii?Q?GYtNqfNOph01ko9Y5jxa+W58+EFtAh6TSD1tEsQ/w6ZJ+rptDT4SNIcfUaU6?=
 =?us-ascii?Q?YXkvcjWAnD35AJkZsBGqlrDRZATWdsapnb7jv6PVhu27uR/4o1QHqmpwb5Ij?=
 =?us-ascii?Q?gqH1eI5Yalh45pyO/BrEqf/nYUDjISuEC/mMYGk9smXNph+rPkufADj6HbiX?=
 =?us-ascii?Q?8P03K6fadWdxWf8dHPYalREqVFWKw3RwPEZU7elJDmQSsCkZEOskQRR2YF+K?=
 =?us-ascii?Q?dtTahOnm5kGe7y7n7tUVPam48jYjuEosjpbfJOOAMZeDhD++pMRQQtnfRV2i?=
 =?us-ascii?Q?2LdlE2cryvGXmgInJhpgJGbPCRhHotwkUbLte5YJFdnLmjihZWfzkxMJXks0?=
 =?us-ascii?Q?9/0v1K+ssMZPwB2idVYEHmm2X3FLUZ26Cz932/s/SpeMq21keeZVjwvSB7J9?=
 =?us-ascii?Q?4FC/W7znKMDXuXaLxWUC9aFeNKkZBIRxvXnVqaMtwK4BOmwF9K9ORqEAsGSb?=
 =?us-ascii?Q?qvTnfYffxn6mmL6AX4Aq8xlioHJJk4P+ErI/xX2iYDwGB3j9bbZVZ4yZpLAU?=
 =?us-ascii?Q?sSC/4MWse79WyCO3UAF/v41WQTlAJIb51JmWfgtFwDmRnVNOD6RuhR7uFazQ?=
 =?us-ascii?Q?xiuOQU9JFb5xUDq2ML5cvLSNAV0lR4lollGi6KOCK5GOVnhLjvjoimdtlTNH?=
 =?us-ascii?Q?k83+/ZtsIgJPYwFAxXiNwgFYefG+OLtVV155O9WregdlnKAkaFT5YNz6kzbd?=
 =?us-ascii?Q?tyc0M8MUjzz7HZNQplWsiuGZ1PGMAvb2KGlt26JA0idEMx1urEcrBTKSFaIe?=
 =?us-ascii?Q?7AfP9VFQIoWWA49Kqh3dO5l7VoukVctm4pvFXZvyCZrwkP8KiWxBnJm0OL1T?=
 =?us-ascii?Q?s1rd4T+Xg2APYcpKcZpotnNx7ZRql6zY2R7sVXEuhyqM9ukaG0bSlNn6DDO4?=
 =?us-ascii?Q?aXWVj1LUVBGFGYIE4/PM2ZvckYkl7W5MHtLrSsOQeaEM/0E+sGsEiaS95zil?=
 =?us-ascii?Q?vvm+0UB3DQ+695teMWdMN1cNp+kxbadS9ESmcPOysOqgywMeWUbuFV1VO/Ic?=
 =?us-ascii?Q?1rooIFGnx38/Vc/18GcxzC5/rtB7DeIFTHr40RsirfctM2IoGgRceSxfxvYY?=
 =?us-ascii?Q?rJeEJtd82inv2qQI9ghirwnAWuzCjmNMXfh0fm/DNAtkQ3hNGCRfDX3UfEYl?=
 =?us-ascii?Q?mpNeLk58k6um0y4zM+QCrneQ1vJuC0xS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NbyFV+Xj67tgBplnQjMgQR4nmIxseyLysk79Xaj3+Q+eSYtqaUbkGDirwAl7?=
 =?us-ascii?Q?VpQh+ahH/5ybE9FagZ0Nj+NG2xv0iapTS2OrirbX8NLtg1p+uSt5YLRLA3Q/?=
 =?us-ascii?Q?ahVUil23q9pqanXZN66/yjEIevtJvwkJVjbWspVCuijKCaL00ypZRwy32vuU?=
 =?us-ascii?Q?tciWIUMaUvdrmIkFtKsNZkRgofyTZ8TURKppMgipylPRGs/9M7qSeDEY+bkG?=
 =?us-ascii?Q?oiHVsa6qyF+m8JamHtls4jcIvxZkn0fYBh9k4oZqu1rO2w69UpSjaFPveyf/?=
 =?us-ascii?Q?BF4vHGz2A1MDMFgKUiJVvxa83HVSi9K6Ct45XYRpIg0OBT5NIvXOUY0Xl/tj?=
 =?us-ascii?Q?NegiWyFFOedH6oRI+KVuaLLdzdke9a8P9qXGO7ZakRs1BayTRy2SBQ5Otqg5?=
 =?us-ascii?Q?QOT14ZUQdGW1oxwwSVfHtF1WVoSfRSLVOvWty7JGHyNbOL2EJJ1yxjXDtnbl?=
 =?us-ascii?Q?h25kEuDxNIXilJrpKswptnZkMc1FR4PptXvmPLa2c5R3HJ2OdaTFVwsGBtVe?=
 =?us-ascii?Q?nhBkoItYpuyLX+9jYdEN5bV8CqGBzM7cm572FiAc1aSmG/xM22do15hdx2tr?=
 =?us-ascii?Q?k+Kd0BWKndkeYoTiChH7aZe68HmSf8s8cqDwJyJibLfhEByXX8Rx4ayTEUBW?=
 =?us-ascii?Q?Exwv7/i15ba44Tb2xkhkZqbSz0x9fwcmMB51Z1JXGK1tNvAC18Va5kV0bftR?=
 =?us-ascii?Q?doAlWpQpBstcgzpjMw0d7fvoJeOImJtN3JnyP/PX9q14wxkhCwtOH0q8OxQS?=
 =?us-ascii?Q?oHAuaf1Nha+tQkt/2u7NJ5vtBKdg8cJlz6Khqu4NzVQywqfkSc129IC8siCO?=
 =?us-ascii?Q?33PelANi9FxYnwcK7sMryIiIZRTKvKNWkEH2QTtsbEy/XZJaqakjQ3txPEZ5?=
 =?us-ascii?Q?nBTzb3b2HW3eTKjKIHfZHDSzpDs/pB/O+09RHtkorRIeVAOvBlTnGK3ayuzB?=
 =?us-ascii?Q?i1+YqjBXYCt9Hzu4gZeHQjXvcK/au/yZ2BSwhu0DeCCd5AtcBnECtg7o29B9?=
 =?us-ascii?Q?eahI1944r4m2qJhNcyFNR/ZVzPuImAbqHRfxSqg6HJOXXYK0NvBRV9d5982q?=
 =?us-ascii?Q?oPwVEJHYmcEA5VQUorfLGUJBblM44Xb8bTHAvmP2c6EOxg3VpJZWMVT54jPO?=
 =?us-ascii?Q?t46vqqQDbuS3XgVVEZRJMJrv3jsEPS/cGnPlXbraa+TCjlWM/kd9cr4Ndp4s?=
 =?us-ascii?Q?i0kb5N9e5kFLNidNqNTrClWkV9lsoDNxn6Q8dUkQnSBg38EQlRUHJRckXWnA?=
 =?us-ascii?Q?7mO4Tfg/KmSts4HlxKOukL3m/1IGGk0vIkcCQ7PXCKYncoqtcjM5RzfLPP7c?=
 =?us-ascii?Q?T2hp8QX6wY6GhmBtMmener/amMICxOMNAMR/sF0YxqM3cWKmDmEcf0G896sy?=
 =?us-ascii?Q?NN5R/CefJDmGBP8mzT7kEG8NfyPNqwi5HKnBMeWksF4je+p+i7h5NC7lbA3V?=
 =?us-ascii?Q?Nf0Xg9h3shRZ2IJkbNqCzrf/UcLaQLjH2H1p0NDU1l583Y085e9tnoOvwGv8?=
 =?us-ascii?Q?YKEM8srlBTXWZBKuocgEDpZxOAl7IUFysT0kakLyrsklIlbimTOLtNuJtCld?=
 =?us-ascii?Q?hExnfg11rgw0g64YzDE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc884af4-ad81-4632-9e7a-08de01d5d6ce
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:05:07.8953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZD66SV0R24KoKtHNKPtlkhPtMSBYPibfM1fJMgZjsf+VwHsWuuXHezDxlNhiCV4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586

On Thu, Oct 02, 2025 at 06:05:28PM +0200, Danilo Krummrich wrote:
> On Thu Oct 2, 2025 at 5:23 PM CEST, Jason Gunthorpe wrote:
> > This is not what I've been told, the VF driver has significant
> > programming model differences in the NVIDIA model, and supports
> > different commands.
> 
> Ok, that means there are some more fundamental differences between the host PF
> and the "VM PF" code that we have to deal with.

That was my understanding.
 
> But that doesn't necessarily require that the VF parts of the host have to be in
> nova-core as well, i.e. with the information we have we can differentiate
> between PF, VF and PF in the VM (indicated by a device register).

I'm not entirely sure what you mean by this..

The driver to operate the function in "vGPU" mode as indicated by the
register has to be in nova-core, since there is only one device ID.

> > If you look at the VFIO driver RFC it basically does no mediation, it
> > isn't intercepting MMIO - the guest sees the BARs directly. Most of
> > the code is "profiling" from what I can tell. Some config space
> > meddling.
> 
> Sure, there is no mediation in that sense, but it needs quite some setup
> regardless, no?
>
> I thought there is a significant amount of semantics that is different between
> booting the PF and the VF on the host.

I think it would be good to have Zhi clarify more of this, but from
what I understand are at least three activites comingled all together:

 1) Boot the PF in "vGPU" mode so it can enable SRIOV
 2) Enable SRIOV and profile VFs to allocate HW resources to them
 3) VFIO variant driver to convert the VF into a "VM PF" with whatever
    mediation and enhancement needed

From a broad perspective we in the kernel have put #2 outside VFIO
because all of that is actually run through the PF and doesn't use the
VF at all.

#3 is the vfio driver and I would like it if vfio drivers restrained
themselves to focus on the mediation, live migration and things like
that which are directly related to VFIO..

> Also, the idea was to use a layered approach, i.e. let nova-core
> serve as an abstraction layer, where the DRM and VFIO parts can be
> layered on top of.

Yes, I think everyone is good with some version of this..

A big question in my mind is where do you put #2, and what uapi does
it provide. It has to layer on top of nova-core because it has to use
the PF to do profiling.

I'm not a fan of the vfio based sysfs as uAPI for #2, for reasons
touched on in this thread.

NIC drivers are using fwctl and devlink for profiling, managed by the
PF driver. I think I'd want to here reasons why those interfaces
cannot be used here.

Jason

