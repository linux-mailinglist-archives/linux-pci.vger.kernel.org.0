Return-Path: <linux-pci+bounces-37461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA09EBB4E13
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 20:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AFD2A415B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8882A277013;
	Thu,  2 Oct 2025 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s4BqtQjZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A4027703D;
	Thu,  2 Oct 2025 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759429944; cv=fail; b=E8zyZemC2YMQV+iuSK3FEvbB0hfq7TgwhTGSg58xSGLoyuQkkbHNauzWpgAPsjOIKyWwoANLmQIwMWFvseEolvaqRBf3tW55OPRWIn1GRhpLoZJGyOzzFSQTkQazbgHZYtokalvfslMXLKkwrG8Sq3ey7ViT2BzABIH1errPmjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759429944; c=relaxed/simple;
	bh=YdDf//OU0ciIVmw7S6y5YQme+EUWWDOpdfrWF/3j6V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I4DK103EdLxVnJTVtQKo2UKsnaNSSpnwCVRdUwgzj2kAcCPzlI+8kzI2wIk28PBL1/iuFW7+YY2Q0HmtDMwy3Tdk3Xjg+rSuoPBw5b5gnx+Ev41OjdCkobV7aTJIGnQPx0kJvw+Hh3PagXOaYHDcAmV5yVOK0jlzMegZASM9WaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s4BqtQjZ; arc=fail smtp.client-ip=40.93.194.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HClgpPTJH5iU6cnFpQBclrDOtIWnU05FTLSlSm1bn2EmkYz97KFP6e+0nvmWG9hF0xbTxW66JGgACrcY5TeN1XDPit3/ANQRtTEa2L/pzicggAyI/SNe7hl47wTVwrghGFZbcc7p459m/GY6xYgxdVzA0hX8PKRFl3Kw/mH3E9ZU8CQFYv1sIwkGJyZRxqsHKCDgZ+gqfN2ik+icyFBXyd5J2tzV4ZqEMJE5Ht8UoqSx5jnfTfiT5ImXP8fUqReRTdSU6QCjgSRAUc1MfUGi7Ce6nlGEQYbJYGdD93/xSX/Cn6s9GGJITAR8yIm4UxeqBcJ2C/45fkQOAREinJyXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1dngkSzlD18F15jPTf21oWO2JfXCcXToRoT9FLBSdg=;
 b=A15RRmKpNfX6c6RcaXcJU/MVCstHjOncjrO3KNSep2fnLfeEv4dVQiCutgqNlUIaoKErTl94Ng99wucEkTrMLoTCKP+Ot2psuwNovqygbks1FQZAMilLO0vFcrZaoOk7Ae6qLsBSrI6nqFXLwS3or2TIaL0pvDz30KTC09qi/t8XW0oMg6p8Yd0ARIAW2ZcXvSjB9+5FasIYU8EvebASmMg1sNjNXqB2TWEA3shKpKgcis9W6bfCBFs4GGRhTooM82B6NwodWmVREEwMOjCftMflIh0fTbGUYKfojvNIQUWF+e/EcfC0nRwFyYrdCQZfAG63+iPtO9IBxgvEWck0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1dngkSzlD18F15jPTf21oWO2JfXCcXToRoT9FLBSdg=;
 b=s4BqtQjZTMU65EPB3mJSkSkyEUphQ2ZTJS5CJlA/4mjLB7+ua75gC6jiEccR6XNWuuQ8p2Sr2qxBjbug6dzMDS+VJvF2aMAMk5ru6i4d7nXCE5+x5il6Oyy4NNFZbV3cI3tyc/eE9a+Dw5JKZfnSgDVmKrhPT8ZogVTfm8R1qu9MrMdcw8odbDrvbP7OhIgetQEi2w2pxCIU1gh4zqTrayux5bFrXePBeXKdwg2uw+JIp3vStXCe14H99TKql2XRjueP7jYLrMH+y06GXRSH46lvygBoyiNeCLHa6nxLU51fgwSi+Hg0TQ8jWsa86HZz6wgkk+PwwgNTmomxIfISTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.19; Thu, 2 Oct
 2025 18:32:19 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 18:32:19 +0000
Date: Thu, 2 Oct 2025 15:32:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
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
Message-ID: <20251002183217.GE3299207@nvidia.com>
References: <20251002135600.GB3266220@nvidia.com>
 <DD7XKV6T2PS7.35C66VPOP6B3C@kernel.org>
 <20251002152346.GA3298749@nvidia.com>
 <DD7YQK3PQIA1.15L4J6TTR9JFZ@kernel.org>
 <20251002170506.GA3299207@nvidia.com>
 <DD80P7SKMLI2.1FNMP21LJZFCI@kernel.org>
 <DD80R10HBCHR.1BZNEAAQI36LE@kernel.org>
 <af4b7ce4-eb13-4f8d-a208-3a527476d470@nvidia.com>
 <20251002180525.GC3299207@nvidia.com>
 <41a58726-ad31-4514-aa76-d0afd9b58268@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a58726-ad31-4514-aa76-d0afd9b58268@nvidia.com>
X-ClientProxiedBy: MN2PR15CA0036.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::49) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e792a02-2515-433c-811e-08de01e20532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9eSfkDt1Z15SshP/GQF5eopxnZLAi0XYyVPuCrbPF+00Xn2PzrOoiOJBM89k?=
 =?us-ascii?Q?ZZsriu9RoLcVpM3IAKpbDBQMETDGfarqfQ5SPgr9ulX9hq5n0p0PJcUEqC9F?=
 =?us-ascii?Q?EyNTsY1BI2GYS9HYZQB55rSNgDbh2ucqMk3UOH6dMvwIpIzG40rEH1g2paD8?=
 =?us-ascii?Q?X6HspG2ecdfDVze7E0jSQlUAJuAKuUeMf2PKc4gb1Cwri0qiCsm4TKGjGR8X?=
 =?us-ascii?Q?oXtRU8Fx3cYGQhOukiJCXTtY/xi4KoKcapAbKJpg8EFth3/duUxZ8ztt/ejy?=
 =?us-ascii?Q?JgVX4SFl/ou3EOPGaXbRX8JGGUpUivNYKRYVf3Xrrtn//VHrM/g5MWxd1V7W?=
 =?us-ascii?Q?pmIQ0ptIZ2+MIPO7hW6nffQX9XWyxVrSdfTcnefLCp98NKpWkr8kNCD3Qxzs?=
 =?us-ascii?Q?r9lWniVH2F+p91gdnVfHmdUvGLkScuXkr3BvM86mQTaRgNsFQhohLc3HgRD6?=
 =?us-ascii?Q?2owh153bDJjphkmJh2eeh5fFeQT3WG4hYLHBnFwtU8l1ooxphY8PJFcVRGYz?=
 =?us-ascii?Q?Xo6MRUgsg1OUyIyy9xJpDsUmgP8ByHEPxWKcUR61TlWzzdEs0OKVewz1EhHi?=
 =?us-ascii?Q?OYeaTwVhGBJ2vU5C8jq4YIfxdaPjSUIf2tddn5pHYYFavmafrJXpZVwSmWVF?=
 =?us-ascii?Q?k6JYcgsDrliXwnLRiu4f/Iu0vqbPW2VF/np+aLB5SVbyXvW7Ii753wgdeBTg?=
 =?us-ascii?Q?GjAiEI+65p1sB/+6Iq7bop1WNNfeeKZMFgh7EGj4+y4nYIA/GPvjHNLnrHcS?=
 =?us-ascii?Q?c80digHG9tYPBDLbvQA5esxMW9f+xhL5EPHfT9NTSqxVguMHG+H4Un/YtdTZ?=
 =?us-ascii?Q?T32Kd2j4prjrWBKYW6ZKIqC4lGxpxpnqpKMYR8nb1cP9gY3G00nFwBfLVddT?=
 =?us-ascii?Q?1LMoDLimvTH0Ri6stMujxEv27QSXSexnpvLHHFxNkdSN3Kn7A2ufHGRxWQ93?=
 =?us-ascii?Q?gv5F8jo4ViJLtO518tRpe8sHzOsmjXiyCC7mIdR15BTlP+K7TShuaVAW7qhW?=
 =?us-ascii?Q?2bZ1k143b2zSyz9PV1EnI5zaOgSm9hczVgXng53sJeAuVBM58J8xj30pn0NM?=
 =?us-ascii?Q?eRLdGg1tNpF+98/STcBJnP7dNf5QnenkBfg2L2NksX3ehsWKa4fvHSaQu61p?=
 =?us-ascii?Q?PUL/GyyJ4Hl2qRLL8IMk3b4pbSielfbgNqcQ1v5VQDzq1WZRvA6tbIxfENTp?=
 =?us-ascii?Q?UBVzciKZgP9sOGZ4U16INAzQcuyXjnN7vfCtpIvqLkqB7oirfwJys8pm9J8A?=
 =?us-ascii?Q?vlwCQH2YWczkKT4ZAIWxHL9jX2M8mfF+eiqS4w8fgUg+R6CNWBdJfTA5unn3?=
 =?us-ascii?Q?Gea7Lt5/A4NctO4oauECvtyNOxeOciqokXtY64YJmz3Gf0iQfvT+iOArhpHO?=
 =?us-ascii?Q?8w66NLlfBBjLWiiBcBKHJATFL8y6ZxXdc16/3sTS+NjHA/5AysVS8rlV0nIR?=
 =?us-ascii?Q?5mUGAaRSoWtPnNPWEcqv/lCr8p4s4uaf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lFxZsjg2cEhCLvqe8ep81dxSifqqE/BtCxLNyzs9DGWicUeaixh5r8nLUb8I?=
 =?us-ascii?Q?tb1CwoB7sCwjPNu1O31bPcGFsDvML6sDBdBdvE8SEchwCPgOp0jVkDw0pOrd?=
 =?us-ascii?Q?PjJ/O+nGxtbH54450X2Q5J2rtRi+8d1cJ8YmUGF+HjupTAh2K811ajGs4q0T?=
 =?us-ascii?Q?Dt0lCO2McTgpCbFlQTsbGFBXaP9n7JfOsIqS4EyQE+aIRm0AyjmQCH6w07py?=
 =?us-ascii?Q?8AFDzvXLEi7pE8DPgOJr5rd356dciVZH9ajDQXY5zaKR1gm6dsorlRMpzYnF?=
 =?us-ascii?Q?jMAneA/AQd47jXm9IWfoXXoUzJ27ae0WnrPymq/hQb3ah/8voTLMUSa2LkGd?=
 =?us-ascii?Q?rxVNqxM6yv0kK0TZtIC/8UUWTwOYnrOfHeiUyVSM1uXifUwYytWa4IpRkuy1?=
 =?us-ascii?Q?Fr7+lu/tCsWICdd0MOwm7Qiq5sGuzH+whAPqsMCQLQWEK9saV05CsDfbH7e7?=
 =?us-ascii?Q?eJ3WgPRyPepbXbrcqJVcxL+b/6ZD+WS/dKnvXSGwks4sM0XugU0I8fxMLcJi?=
 =?us-ascii?Q?rJfEJ53P6dnBPLL42FNDLBx07rM72+8F9LU0uSvcwUvljrP1UUKHXTLAkx+h?=
 =?us-ascii?Q?OtPfRtn3RIkrkrm/WPRr+Yn2YPn3373uvg4HO80QVt0V3Ug5iZkE4vH68QKn?=
 =?us-ascii?Q?hs1d2RnpROC1qgvi8bPUDDGhmjfuLkImXHrzQxHZgA97bimqL51qp6PTqLHH?=
 =?us-ascii?Q?0YJqK3bBQ8JtO2g9KSzUH+b0KFRu7Hye6iTpKaqX0mYbBXk5WSKCc+HIRjku?=
 =?us-ascii?Q?hkgN9hvau0Xx6Elh3NXXy7do/jbX2j/TfIYdfI/vR2rDpnXbFkt9jM4ZBzgZ?=
 =?us-ascii?Q?HM2M5v6DyJAnAdCr4Hg4gPrMdLGamEGrdK4UwCNclwO/TgDjhWX4InqHWImF?=
 =?us-ascii?Q?LpEsmnyC1DBrmJn5F8HNUZMPa6MpqBtBbANdU2G9CGpAUD5+aRDRHofLgm2X?=
 =?us-ascii?Q?MSnRAhAtuu/OyWNlIuZDZnUGi6C6bk5y+PD/qQCsN4CbX82tuTb7+TsGKYuZ?=
 =?us-ascii?Q?XZhK1ksWHpknPkBQ6STuDTyVaI8ZgZ14pk7W3l7mlP/bN/amAVyj2eUUNaNC?=
 =?us-ascii?Q?3y/Du1a/6AD8duWqEY+7+H27Vt6nzkusq9m6tFX3qDKDFz2mhoPfvZuWiG+5?=
 =?us-ascii?Q?an98TFTg115GW9nWnTDly7cj1FpeXh52VPcdlbwU1WqAxaGxNmz06WKfUwBp?=
 =?us-ascii?Q?NVOejtiGFtD2SDiF60X1P+7+Yu1o7LucV1bG5VMt4X+ySRMvmm7fuADSZhBG?=
 =?us-ascii?Q?70riXYBljaSW6SNXuCwXqQ5amBxkwcHllUvZBEhcQ3c4U0xyWRVQhh0Fd18R?=
 =?us-ascii?Q?dyAeep00rVvb/qwwGeytXZojw9asYRN/GcABRb/LVGn5tVNF7jj/OSPhaSt2?=
 =?us-ascii?Q?6n+cYtk3cSrovvtkv2XGU1R5fRiCBRRQL7dgOT7vQzCk7n3k5PwhvQ/hB2FQ?=
 =?us-ascii?Q?BbD3zCMONJ+QvX3OIUIMvNXMgrUUIvsFWYiyRFxux04qnQzfz1OFYfSpFHCo?=
 =?us-ascii?Q?mqxAY11BrYsFpHI/p/EnzmgED+b83HEzxvYA7UeX0lwDaR6wWyN+l74EwOmU?=
 =?us-ascii?Q?WUbV0nqBCD7mDR16mfU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e792a02-2515-433c-811e-08de01e20532
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 18:32:19.6533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDmYg3d0KD0+LpDHdXe+dQBUf85b7MRWiN5rx1fThCv6TLHHYvpEP7TXxqKe9ohN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611

On Thu, Oct 02, 2025 at 11:09:40AM -0700, John Hubbard wrote:
> On 10/2/25 11:05 AM, Jason Gunthorpe wrote:
> > On Thu, Oct 02, 2025 at 10:49:21AM -0700, John Hubbard wrote:
> >>> Forgot to add: But I think Zhi explained that this is not necessary and can be
> >>> controlled by the VFIO driver, i.e. the PCI driver that binds to the VF itself.
> >>
> >> Yes, this is the direction that I originally (3 whole days ago, haha) had in mind,
> >> after talking with Zhi and a few others: nova-core handles PFs, and the VFIO driver
> >> handles the VFs, and use the "is virtual" logic to sort them out.
> > 
> > To be clear, no matter what the VFIO driver bound to the VF should not
> > become entangled with any aux devices.
> 
> I was fine until you said "aux devices". :) What does that mean in this
> context?

Something using

struct auxiliary_device

Jason

