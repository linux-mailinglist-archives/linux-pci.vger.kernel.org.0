Return-Path: <linux-pci+bounces-37423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAA8BB3E53
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 14:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5223AE8FD
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3816726CE0A;
	Thu,  2 Oct 2025 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CuJIvEwf"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1218027;
	Thu,  2 Oct 2025 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408375; cv=fail; b=SwCG+8YvZKjVvfSlxY5/PRNqHk/LbavcWdk/mOOWBCv0hx3y8bH33Pi3dtXWKI41KAmPkc+HuM7+KHxtoVGbtfIHAY5DtQ5++LG0hm0Br1XpOIwV3kwi6TDQ02bBFr/B8AE2sLv+evOh0z/KjV76eoZtmrEJHI8MjZrKzYTOom0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408375; c=relaxed/simple;
	bh=eTBZiJ+Njy2YM1GxWunPNDUYbyfx05z96xb91IuCve8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BI6b3YEn35C43AFoMBwgEOX7u5Gv4pkEAYncfLRlhTIA7HYsoxcH4+TF1SXoZbJzFnEbcchrxdhZef6tTLW/z60KfS56lQq+ZzKVeMpT4BaM7HLYxS7mNQRxyT3j0N7Snw74qcZdxe91+LcWCPwWRfWELO7QUXIlRfccNF8960o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CuJIvEwf; arc=fail smtp.client-ip=40.93.198.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCODL1QsY6WtJrtoirLtfVCouBUDlDZEE1dRhh4lxOGht0szOPln/dD+EIvfPuQ9dTXnPFalRh6M5tJ8iW1ebj37UMkTUiNH0IKkp5OrCh58H1kiRV2Ao1RK7ITYX7Dj9vcwC1BGhE38QrvfW2ZEzdD9HxfACfDYRkb+Pue5qzArPrayMDTrb5Hf/vQ4WVYkxlG+1/NQNKnLL/ucHJud/H6LxZ475fNRB/LF0STIPDdemaYwA5SqsZbDaWerEoEBJQb7uLvWILRyYYX8MZOpBfqmIGgOiZ0XEKDXgahiLEo5W6MD7YfM+uTVMB5SM8NVnzqVepAf/hixKX5hl9rnYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njyPkytP7YuRnHcfi/DNKelXYvBJXUvRLGM12328ET8=;
 b=TJKLj4qwHIUYWpoIApTrCmuXfvw0VyXLAs8bkfC9I9SPkEW3PGeOViXk1Hs+efcUhHPX7U06oxjQnRq3mo8PMKZIVxFgVeGamWIOpFJShXlMQnQmgLwd5OOMRHX5HhZcrmBLTs+L8J9ZPnqazBaCyg0h3Ud1Xr0CVJUZBMk9sMvIBKPYfKtfe1IpiXwHpCYAgdSxD8gsQSvM0bdlnsK3z1SJoaYuzYY2p2wdmYyIU+9S8y3Q+Q7tk3FpdWSTba9IyEjLPRP26MheWmkyGgX5rE2bpu1kkU5Nphrz8m9xNLbqoSJ+0/3wW9A1ac9eeX5cAruBlGNelWUm9cXW/ehieQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njyPkytP7YuRnHcfi/DNKelXYvBJXUvRLGM12328ET8=;
 b=CuJIvEwfAJoKVYtjHFpe6CcdctiDxMLR5TdhGp+xWYWVa1jR1rTIMMK8CezxdzARfWMOKjjdb4jZPDtVCbutwwaDtTc82AbJEoOVX02CZ2FfrSnsFecM8+7Wk0izUtr4A/ZbqM7RwveLwJhrpkqsaHiFrzdNUDQdhpsSFsd+IK2G+JI9uLmOGm3ZzL3gPEq7f6FRQ1f4y1C78+EW8oSS2IAZLbNGI4NCn3Y8ZMkou9jkPzf8IgANudnyk15ecIPWU8x+OIDZ461cOwTxqiArHzCbxyEc/c5dwC+O8CBXfOQHyFZK4u75/4oCv5MGJ73/M5pbb3iyLlk9QInceSCcNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Thu, 2 Oct
 2025 12:32:46 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 12:32:46 +0000
Date: Thu, 2 Oct 2025 09:32:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Surath Mitra <smitra@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Message-ID: <20251002123244.GF3195801@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <h6jdcfhhf3wuiwwj3bmqp5ohvy7il6sfyp6iufovdswgoz7vul@gjindki2pyeh>
 <e77bbcda-35a3-4ec6-ac24-316ab34a201a@nvidia.com>
 <DD6X0PXA0VAO.101O3FEAHJUH9@kernel.org>
 <f145fd29-e039-4621-b499-17ab55572ea4@nvidia.com>
 <ae48fad0-d40e-4142-87d0-8205abdf42d6@nvidia.com>
 <DD7CREVYE5L7.2FALGBC35L8CN@kernel.org>
 <20251002120149.GC3195801@nvidia.com>
 <DD7TP31FEE92.2E0AKAHUOHVVF@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD7TP31FEE92.2E0AKAHUOHVVF@kernel.org>
X-ClientProxiedBy: BN9PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:408:f9::25) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: bc09ccdb-3d1b-40d8-4481-08de01afca85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P2UaifPaC3OkAOrFG80OnEcPOg+bkpworWL/J8wDWm2TvMiidsXepn5q2CZd?=
 =?us-ascii?Q?DF43egCREgZMNQF/rd2IqrNEPHU2ZaHICpE0mePExzsY04HqX2w1C82ADYme?=
 =?us-ascii?Q?XLFBzCruP+Pd7cFFxWNKOe/yzn/LnzuCE5TPrWeoKblUPODiCu6GyYC96p8U?=
 =?us-ascii?Q?iX1KG0nZTGXMvAFSR5qBtxDrbVRi5GnpM2/QubLZstjBAyeOZFpRgPPNcPFp?=
 =?us-ascii?Q?5tSMw1LJb86oCW0QvdTW3uKd9V9+b1DAE2LyWwsPqVRwCm1rtTR3ozB2yW2H?=
 =?us-ascii?Q?XIQL1CSCUAR7hZiGDQzJ8rz1XujLDLskg2NzMwggmqdDyOx9bgsa6OSGTjP4?=
 =?us-ascii?Q?DQrJ3VHMEiswuCGYmjPh5aZIqCrBweG1EyFUHBOLKDTodaF95Tivd0b2eKop?=
 =?us-ascii?Q?bYr9AgFhAsyIhIl/7ozcABXEEoKCobzzMAdZQCak70Qn0LqzZOVxoXJ4uTyY?=
 =?us-ascii?Q?PBCvmdXTO7GATkn4rjSbZC+v+lqxTikO/aSP5FWnix/1y7LKiaLdZrcSSAFm?=
 =?us-ascii?Q?rVH+CVZagkwEClba46oWV6UUrwaCbKdkASu86Tdqhiwu3M1tGjfE3uAbM9yO?=
 =?us-ascii?Q?aSfDhluEkVYVNQq9HdJPymJV9ILE63Og1LdXNLEqZyx0kw2OjamA/ubF+OV/?=
 =?us-ascii?Q?2I6JsSZk4BA9ckytarrdNRIR9oqMUtqRdITolUD/gI0Gv2jZAV08Ztj5FeAN?=
 =?us-ascii?Q?1/4scYJ06tX2yzhnUiqsGeszbcQZu64ChQmilELJKAR321K6uf7trJ57KVHm?=
 =?us-ascii?Q?t4upAUZkp0Kd1slIjE21XiACcPdn5JbjmqwQpjHP1K8/Cbfj1+WIU9eZG15y?=
 =?us-ascii?Q?F4+xOMM4jSd58IPlSOQAbFgMCj9z4rr45/d98+EchC2xX8MOvTr1L3vL3XMS?=
 =?us-ascii?Q?iGC/Nh4mRvph8rZ+N70+pTFTpJlB2HCwiiYeqe0AqrtsbxlyDfJO/DNmrDBE?=
 =?us-ascii?Q?dLEdIuqTbA+ua+2QzUUG0TKcqntdWZpA7WBnP+Fm7oz8DrgGAf7Cfaicpaoc?=
 =?us-ascii?Q?oezgc+PhmfX3HnDXT6cLyssoe+Z99VsGosng0nCBgW0sKSsCEnWQ6aIluuPv?=
 =?us-ascii?Q?0JHgjQvYJDrTns9Ha82oXZQwAPXOJ6u6rPdcIxomuDt6v4cy+OwTsLEqmB1t?=
 =?us-ascii?Q?JY9485qkFLmde90Pht9EMMpfk4HSG+qGho2wPVfQ+3pYPA5m85AVDdZnwcdh?=
 =?us-ascii?Q?NFLvxyvfvdN/EhgOeVbbinSD6rhM9nEjO2xB1Ta9U4ubfVwj6l78Ze4hLBqk?=
 =?us-ascii?Q?ijXew/BeHhd2fn1Np0YcDe6xS3ur7kF31JvvAAHTrIu966didpdLKr8AId6/?=
 =?us-ascii?Q?JK8oMHlowMCLUPp+lg7IMFAebnDbJQnGq52B7jASPzJ+uO8mAqMNpt/Im8OT?=
 =?us-ascii?Q?o4LkwkFMFPFaotPzyU1WWtHbxcwsxzWAVCbOE2lRGmAhRVAZct4gy+tY7gf6?=
 =?us-ascii?Q?2bzF+jY8BUMaP+L6lYfuXjvZGlN7G4th71TzduIiV+G7POMfJqrzXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BS/X8EKO14zxJd5mUY0xhaZW8CdrpoAZjTsVCRYESBEqeqSlI/8WjKvU9MD4?=
 =?us-ascii?Q?Q0ohobhzqpRV2IXENAKsuLxHWOMtgRfokMtbGTnCUHxZE1BjjE7SgnMeTQtn?=
 =?us-ascii?Q?LCVihnmD043028RI/0L4654QVNCo+/+QR8UyW440EnQOo1+OkGZhss0r8CJ/?=
 =?us-ascii?Q?tJIG0Ys3vqC+7heCCLWarWKyk0pBzMsnRT10I9GZl7Yqlrfv4BMcaTSFO6Ez?=
 =?us-ascii?Q?T2riHqczvPIzb1e4FGcZ8IHb0Qd7s2TNmKi3ot+3MBnEsCuWtY2XsMDoBlzi?=
 =?us-ascii?Q?kxASzj8/wm33cPcag9b/7x7D7Ti5tYElXQWEnVdYL+fzg9gwAqtDhX95Od54?=
 =?us-ascii?Q?L3GOn1lihoNCJlK+W0IdHIDahZG/Sw255HEEf9cPHKSKxNbAPnr5Fc6dMKTy?=
 =?us-ascii?Q?fApAJe+sJHCDK2vJqveYyV58hM4dq+dE/YxcdMI27aJE8QNPGlb4LX0Ubl1I?=
 =?us-ascii?Q?Ehtm5JNtiARLMKQVpV6X3TQIZBmd8SkeMtFKaahKt4vZhH2VJIuQ+vwj/C7U?=
 =?us-ascii?Q?3kma5r5BKZNQ08gVYQmfVOjhQ65k2LNaT8eEogU6hFchp5HDdipdO1atpTEU?=
 =?us-ascii?Q?KKOQVf7aJj+C2ZOfy4+JbuivvoEDh23ulOCod5BbBZzHYXh+WluJXPk6H4t8?=
 =?us-ascii?Q?tckpaT0oLgKQ7XfqxEUngR8uwvNnt01iYAa6Y9yvR6Ph5DMo4GdXhmq+M3Xc?=
 =?us-ascii?Q?oXxFJ22ab9vzuKdlJbOxVEQEzx2TpteseIDHlfnFEcPzHmG9dxP+sFw1VuBv?=
 =?us-ascii?Q?muUl8YZujvUx9cbwmdfOs0NXfr00HA2PvrVFHqd9FcKQim5IkdSKLrjtTZEw?=
 =?us-ascii?Q?W+UDTZ4L6oQ713rHkLslkIs1ihJUjWbQs7j6EhgYGdLK/vKBn30mLBcLLTtg?=
 =?us-ascii?Q?YoAdIzXSdoQ+re5ve5baScBZUsFFMq4geg7vEAPTR1xum/ITRO08ay2YjtCl?=
 =?us-ascii?Q?fMchjxH+/+TUizoD+7Maxv6MYADTWln3dMw8zTet1D/Uy5sEsAJN5TWgFLwT?=
 =?us-ascii?Q?XNj/pOn5Qd/9HKO9gNu2C67JDEqAaOe8LgBHywI2VNAJtnluTvW9E0C57Ukq?=
 =?us-ascii?Q?ZzeHRC8/1uUXYjo0gz2kuS6T4Tk7hY1QASVonrmHoPn0NEdFNuJ/CsgyRMVN?=
 =?us-ascii?Q?PSRechwWDhZ2Yd4/C3Qh/p6jmoxn4Qn/MBOAeuaYONfYpscQy6sB3tG8uXJu?=
 =?us-ascii?Q?NarCzJS3iEGV88fzLg19NBbOIb1/MHxSYrC29chJVVWODEv/9421Zl71zzZH?=
 =?us-ascii?Q?XC2w3L6d0sa70icAbMAOIQbDIBQV9a08NRRm+c9k8z3BjMHXCO/Du4pQpGvo?=
 =?us-ascii?Q?6wHUBa4u4zGZcHl7i3x1FagSjXc9pQiHYSJSwdUl/9oZqys2PjtJJ4XEaG3E?=
 =?us-ascii?Q?mcGEL6SDEAR5eF0RR3/pRhRoyINywnpRCy5IrIEqrtsdXTyxBuqYhMZzREZf?=
 =?us-ascii?Q?/aT8Z7VhQqc+82ZcVOUxucUEsSlcoxXDOZyqlJnrjUy62yaS3BtETDjPf2fl?=
 =?us-ascii?Q?VLBmnJ8ojzjXkciaT0tvNDU09EZJme4qAAwkh8+/nwhMBhY9WdbScZFJiBH8?=
 =?us-ascii?Q?evaCUuykU2BQ2VRNbUqWykzzqhuXTu3NS5+2evJU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc09ccdb-3d1b-40d8-4481-08de01afca85
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 12:32:46.3952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GE34AW7xy1ys93aqPIfLMwsrAHx+y0yTk2bTpOuDjW3d/mpnI9i3TXG354Ut2P8B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340

On Thu, Oct 02, 2025 at 02:08:27PM +0200, Danilo Krummrich wrote:

> Why? What about other upstream drivers that clearly assert that they don't
> support VFs?

They shouldn't be doing that either. There is lots of junk in Linux,
that doesn't mean it should be made first-class to encourage more
people to do the wrong thing.

> Why would we want to force them to try to boot to a point where
> they "naturally" fail?

We want them to work.
 
> https://elixir.bootlin.com/linux/v6.17/source/drivers/net/ethernet/realtek/rtase/rtase_main.c#L2195
> https://elixir.bootlin.com/linux/v6.17/source/drivers/net/ethernet/intel/ice/ice_main.c#L5266
> https://elixir.bootlin.com/linux/v6.17/source/drivers/net/ethernet/intel/igb/igb_main.c#L3221

This usage seems wrong to me:

commit 50ac7479846053ca8054be833c1594e64de496bb
Author: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date:   Wed Jul 28 12:39:10 2021 -0700

    ice: Prevent probing virtual functions
    
    The userspace utility "driverctl" can be used to change/override the
    system's default driver choices. This is useful in some situations
    (buggy driver, old driver missing a device ID, trying a workaround,
    etc.) where the user needs to load a different driver.
    
    However, this is also prone to user error, where a driver is mapped
    to a device it's not designed to drive. For example, if the ice driver
    is mapped to driver iavf devices, the ice driver crashes.
    
    Add a check to return an error if the ice driver is being used to
    probe a virtual function.

Decoding this.. There is actually an "iavf" driver, and it does have
special PCI IDs for VFs:

static const struct pci_device_id iavf_pci_tbl[] = {
        {PCI_VDEVICE(INTEL, IAVF_DEV_ID_VF), 0},
        {PCI_VDEVICE(INTEL, IAVF_DEV_ID_VF_HV), 0},
        {PCI_VDEVICE(INTEL, IAVF_DEV_ID_X722_VF), 0},
        {PCI_VDEVICE(INTEL, IAVF_DEV_ID_ADAPTIVE_VF), 0},

In normal cases iavf will probe to the SRIOV VFS just fine.

The above is saying if the user mis-uses driverctl to bind the ice
driver to a function that doesn't have matching PCI IDs then the
kernel crashes. Yeah. I'm pretty sure that is true for a lot of
drivers. Bind them to HW not in their ID tables and their are not
going to work right.

I would have rejected a patch like this. The ID table is already
correct and properly excludes VFs.

Jason

