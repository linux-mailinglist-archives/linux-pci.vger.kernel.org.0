Return-Path: <linux-pci+bounces-32530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E157B0A431
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 14:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91FB5858C0
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 12:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC9D290DBC;
	Fri, 18 Jul 2025 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rRfylGes"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD8EEBB
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752841612; cv=fail; b=oVQeLZ4FjyLbL5nwwBcGHzgsYfKrZwLyjStwZQ8GqS3hxQ+3AaBmlY6wtQJSrsaOSEQuWG+wOdtwKCjOEF8lIoyik6/xBiUg8vLue9uQlgdquO8pbzRjy5giOHQZYZTOpE3/afVJwSjNAp7HA8lRJQzPVmYJ28i7ysKqj1B/ehI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752841612; c=relaxed/simple;
	bh=XnVLYb3v/6yPwoUVYsku2QXfVnM5irikKos55ASKwQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PSckXIVA2uQGDxILCBStCzvPQk4djvgcAKfu21TQbFDzUHVOISB0t0/5N2YFnZVflqqXU8WoN8N0Cy2GrTon+4kWtPHOMfE413TnK5IGZXLlqxUXtvAzVU1yiI2C3nP1MdRKdeobLlAL8U+oG0kLWFJn461bDeHR85tOLtQ+6Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rRfylGes; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hR131fEign3gN2Okam1xlFc3X0BfKfKUpnZ1tRWab1OjFMnQISSe682QVb3R3p1Ulobp+BzVngIysSmP4v4IA7JZQr5DByYYxLVGboaoWgcORU8SoYMHwRity2ONtXQanQ0Uqw9ykoKMfuCP5g94rMQLV41vARDbjG4v4Y5RoF8tgyApyIw+kv/zWa671axVheU5Dvcd4fZA3Dh25cic4smFgNfFH7G1xLKJ24FbpcpabAZgaf4rAAMpkviTxgEzU8cC7eUjh+37zLVxZng8D54CVmDJmKTHi8PHBbm0pNd0yXaSreqfhcZuWGt6gW5eYk1+J02DCWPyviT5idRydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeBp8VlqAO5neErI/5gq8AFP7GRX92M2W+8mPhSzFD4=;
 b=O8Ike0owZmaw9EXH8RHzlTUlQ0GW2y0Yu4YYKztqHK+7yeaVEZ+O8ksCENd5SGEXctQ8S1huvbPchUeujiuGTKn8+W996NePfm+fcCFHTCN/auylyNVEStYol+rHzHPr/w5WFCl1xpdpQexrFySna+zo0RN4PRsw72BDhDQb9Z16f98A8HdxpWpIQ3y3oZCkoiLXJqbSKMfG6IOPNjHSeWXyX/HwzXRovpiMjK2a2zEFKuUE+C7rofif4dJETf6fa3ZD3ODgx9ybFjzbUYTs+GUHbZYcn61jkDrhhb7oMZaOGNFmpubhTLBjXvJwENuBP20XHlzvcNXEUpadpSw/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeBp8VlqAO5neErI/5gq8AFP7GRX92M2W+8mPhSzFD4=;
 b=rRfylGesegav8RRmS2d/OCStzqoiv2A7XPVlf4X04Gn0TLldAsXGVOpIuGdo+5p6BGPSftbpuQOUwsNZQEwYHBpcVfXk5LA4vZZipQoVHdUTbJrXP1CEsdzqTuFDEmzqBG2d+lH+2aLItDA1f5XbbZ31snqwwVbVs2dF+C+SOhkrfKFMSTwtfAVurIJv6dti1qqsdb2YEYC+bAvTYWgW4FNHRK3pSIEtwok2wfyiBhlDEkE21kxajDSrJT7YEe/Ec3ZinKgjOpA0y7/OqbkoCZibQkq5VYxOUgehUjCSWlxzhJIRMiDW390aFYav8UjgXE7gh/9cqrUdZGyGI4hlJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA0PR12MB7092.namprd12.prod.outlook.com (2603:10b6:806:2d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 12:26:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Fri, 18 Jul 2025
 12:26:47 +0000
Date: Fri, 18 Jul 2025 09:26:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250718122646.GB2250220@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aHYtj/jyfXD4XhZy@yilunxu-OptiPlex-7050>
 <20250715130949.GM2067380@nvidia.com>
 <aHfIGJzqv+4XiO7f@yilunxu-OptiPlex-7050>
 <20250716163134.GA2177622@nvidia.com>
 <aHi0HxV1Y1TsauxF@yilunxu-OptiPlex-7050>
 <20250717124333.GF2177622@nvidia.com>
 <aHoQvkK6NOSRfTyx@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHoQvkK6NOSRfTyx@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: MN0P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 8845d53f-41ac-4e98-ffb9-08ddc5f65d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fUAhRWrJ9VXn7c/pz1mt5RwpJjLWBPAAJMLfIEhgvcFzqrOxpRXNPUyAR2QN?=
 =?us-ascii?Q?0ajDivxEhMjlIIZF28/tFwCsFN/zya7I4zAhExvtSeAVC86MvTrRClcGEyIu?=
 =?us-ascii?Q?RrDSt2X4z+H+yuvyFIPXWTFNagqbONamPbk2GhIs9DlHMpaqpt/B1kQRSQqX?=
 =?us-ascii?Q?aMBGLsWeJR1svLR3g6uml0uoferJ7zJ0l6JjxtCAZMNj/QaURVlcAzv1qwtU?=
 =?us-ascii?Q?ubSvlprZTTsrG4WLuac1d3zrzXYT46/POBKkkvgdTkGKGu34a4FihwCb/zRL?=
 =?us-ascii?Q?pNAgURQa3x8i6S20SchhvaP+3k/G1uxAbMLVpqLuUreymb7YkrCibJf6qeP7?=
 =?us-ascii?Q?yJekIKEleEXFKyvh9X2m08Zq4qw0wm6VTx+F6pUsWDi7j8cEjkhUmt0TzVsY?=
 =?us-ascii?Q?7m3wq+s7Igtr84Yt28b7/yzQemoFFcEBkBMBOywur6jpCZ3BF5MLEWNSPgcL?=
 =?us-ascii?Q?GSZsBL2WWHtsmzswGjb4GgiD3+ce/E0dqobdA/yZm7nSxDVrLWx+T2tTRqNg?=
 =?us-ascii?Q?7ZDRfAiPQmnxf/SJlghOCUpdDjYFyU/31mCCnZSE4eyGisWEWJshWqWWrg1P?=
 =?us-ascii?Q?WsLEFGMee7JcF7dTkV6lqkm7W69La4pxw+ZLeFLZUovYBXEDYi7MCmWEMTnZ?=
 =?us-ascii?Q?pW0tvqphPys7Nk/Lkp686XtjW229CaBZfZdldQRzrcW6X0sczFXpje/4Jmqx?=
 =?us-ascii?Q?Da/uJQh3dLOLqRzCJsmic+BczGPEJF8dD8kMqoVR4val8rrIeX7oo60WFtd6?=
 =?us-ascii?Q?0uH5HQqOmxHPjLBCdQ2w4FsQdxJs+LBfb79Z9KYSEtyTHuDM+stbsd8joWjx?=
 =?us-ascii?Q?p9MwzcwmCtZf+3seZmvJizNVFKlYN9f0sTGrjN6WG1DnTiWv+inLdVJDIkxx?=
 =?us-ascii?Q?B0sF85JeWx9ZzUXqzdEsD23QNdWkMatSyqTvhQZwhu0vtWmDY8iJYAfXpkxk?=
 =?us-ascii?Q?n9XUM1hqB68DnJZNbxfAbtPVe9PdWdHa5x2erHOuN+toOWLYLPAeY1Bxv503?=
 =?us-ascii?Q?Wch+vz8zG2VF33iUtgBuCk/n3lKuL9PVFvTAu28MjkjqwF+OPs0ZdzxscvS+?=
 =?us-ascii?Q?TcXHfIkIv+L3lEl7AnS6a8g8UWHE3u1x/D6WapX5I1y9N9uY4C9C424wGjC4?=
 =?us-ascii?Q?O3w+KOAC3L7pVzT8Us6+cV/mFLf28g885zmTktlc/ycX1mID94LKFXO20daY?=
 =?us-ascii?Q?wrdHjYkCrY1kJjsW+c9eWeWtbVrH2oGib7rYiOGVs0PpNesw3iHRuugWVHt8?=
 =?us-ascii?Q?DkBVXDjQXW++Vnl93J6ebq71JB0jRP/YG31/kvIpT6fkkaN197raOLOLQ+n2?=
 =?us-ascii?Q?cBcBfA7Yx3qY05U0Qq4FrGXZFSw9NiKeSkZOtVCeua42+ODrUGsUBG49lq8b?=
 =?us-ascii?Q?PxFaSFY31t+qf9r7nKIQYh1mzli4DKwJeAsLTzSQNdm7zkyODrO85foWzGgj?=
 =?us-ascii?Q?pHApi7wlf/0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SJJrsrlrCVxT8CB5Y17KCHPn48i/PVZgmLioiyBpe1IeGbWvbKoYO+v3QfYz?=
 =?us-ascii?Q?89ewwXuPFeF5IuUpURSS3AS7SFC6GMWMzO40D9KoYb8ancLkK7UtRyqDGPOJ?=
 =?us-ascii?Q?dOmV6hqd1+tZVVI2YPENNyOJSCNfN9QS+79P/QTyxd+ujBP59Ejkln3qdipy?=
 =?us-ascii?Q?qaOW3LjRZCWF5SU19bAct0CVMV6x/lSwxJ6cfDtfd2DRSgltTMJ0IPvcpUu1?=
 =?us-ascii?Q?WS11zPTcaVvXKH9Ewr5rNSn62Aho8Gz+E2nTcfpvtDKAevgFc5GGRUq6Z3N3?=
 =?us-ascii?Q?upeh+Kw1ozkEH5oemPbAItnFU1/UKbCTJHF9pA1jBQRKt1RevtBvtknrRoBy?=
 =?us-ascii?Q?OcoTX2DvE/zjOnmPbAZNVy2ra0rSEtdxhcXYXoVe7KHZOY2xVYS4JHs4Mlxv?=
 =?us-ascii?Q?O0VDRBLDEEBA9M50AAI2FqYHicvIIN+gdctjxTp4+QMqRw6Mk/f40/lB9Zwi?=
 =?us-ascii?Q?48KSbo+xEHQHl/mojG2WM0R5gg0NOw3P7AiK0nbyxqafl7+HWynBb3B9bLf2?=
 =?us-ascii?Q?NPeZwbpuuBlubXcrfnOfBvKV0aGMV+d7bNXrr0Yi/kthjvmlgjCztWX/B7hG?=
 =?us-ascii?Q?IMu7QLpd3/1FJLRIKFZXbvrmpnfgE59+8X6arRJz10EdxvwwfjY0JZoBS72a?=
 =?us-ascii?Q?F6h1SDqvWUVrws+EIRLhCfIaONQGAG6tZ3K9dnEHz6/WbsKofxovcnBNl1AX?=
 =?us-ascii?Q?IWxrS0qMqPWeMmPG/TVe49PNU5yqPLWPHDndLlHLUod/iUjkds/uAFiU7zua?=
 =?us-ascii?Q?diSDkPkHZXByx+gDGZN+pVVKCOV4mqVlozAhKq0vBMVyYDMg6YMo2DDIUoPA?=
 =?us-ascii?Q?1mBfKcSzADJlk+aH4Pj2gWsjfec48q5TQYGs6G9EK9twZ+J16lhttgUhLoHA?=
 =?us-ascii?Q?ajQgQckN0bbZR8cgid/3lR99LLxCqRkTpLCL86iq0vEIwn3hJI7+8ZIXoPSs?=
 =?us-ascii?Q?ZbVkr1383IcOBX6+g+1CkRN13ZPiOt732y8usvEPmLEufDc2KAtj2ePgSJIW?=
 =?us-ascii?Q?eY0iembgXs540WZ+AnRYn2zGFGdb7y1fLHnWyPeRoBVoXjS/w1UVygqKSsEO?=
 =?us-ascii?Q?tfeAf4URTkHX0SHm3g1+jf2ZbORPOw6T6ehxhBf7hgUyqqs/0uGLiTLoxb/8?=
 =?us-ascii?Q?yuruN7RX7+s4gwGdgMROoB4sD5py9BdxabNPwjnSE3X/674DWSIpvDus6ZbL?=
 =?us-ascii?Q?9cNbWraBCDFR1l3dPO/i1BwJuJmuzBGTPt3ajL4N/MLOQgMGhbckwF9Je0fD?=
 =?us-ascii?Q?6bqBhWReY2IsfgrwfnNmSNOIqhbNF8ZSk7UUXvslgE+XYGKC9dg5EsEF/63M?=
 =?us-ascii?Q?yeuMyXzvQ0wn624xS58S8NPjWaaaeo6UI3VWddRsElUMWjNe45+PSC31j4iJ?=
 =?us-ascii?Q?VM8Zsu9pOPERT8VLZag15cF61+ygEqlZ4+eApjCnAXjZs+9/ceKIXg6/Mnhb?=
 =?us-ascii?Q?F7p3YlEK+aVWgp1S6jb93SIXT5GYA/uIsiiip17EXw2n10hbVh+Kjvyr7wVR?=
 =?us-ascii?Q?BVYpgMh9xXQq+DY5G6AOGjH/oYTTasIoL7Jtc62p9FqjZv+qAovZINjY6Zp7?=
 =?us-ascii?Q?QsWa4guE1vhZjunUz3bUR94Cuy2Rq1AKgcyE4gGJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8845d53f-41ac-4e98-ffb9-08ddc5f65d57
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 12:26:47.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nn7Q1bAjSav2cP+TX2WI6/1Hix1/CeUg40rkgDItET4O0hIjWtGeMEatyS5berER
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092

On Fri, Jul 18, 2025 at 05:15:42PM +0800, Xu Yilun wrote:
> > I would say this discussion is irrelevant to this case since we are
> > not doing any kind of in-place conversion.
> > 
> > 1) At VM start the VMM gets the shared DMABUF and maps it to IOAS and
> >    EPT
> > 2) Bind request comes in, VMM unmaps shared DMABUF from IOAS and EPT
> >    then closes it.
> > 3) Bind is done
> > 4) VMM opens a shared and private DMABUF FD and learns the valid
> >    ranges in both DMABUFs (ie what PFNS are private/shared)
> 
> Who decides the dmabuf be shared or private? I assume you mean
> userspace, VFIO doesn't know about the shareability of each dmabuf?

I imagined userspace would put a flag in the ioctl to VFIO to get the
dmabuf kind it wants. VFIO would have to be told from iommufd what the
per-pfn shared/private layout is and can use that to manage the
dmabufs.

> > 5) VMM maps the shared DMABUF fragments to the EPT and IOAS
> 
> Userspace could set a shared only memory slot.
> 
> > 6) VMM maps the private DMABUF fragments to the S-EPT
> 
> Userspace could set a private only memory slot, but maybe the concern
> is KVM can't trust userspace about the assertion of private. 

I imagined kvm can query the dmabuf and learn it is all private from
VFIO. The whole dmabuf, not per-pfn. Same for #5 it can check it is
shared memory too.

I sort of imagine using the same mechanism for p2p where we can mark
memory in the dmabuf with a 'provider' indicating these details. We
will have to see.

> If VFIO should be aware of the shareability, IOMMUFD to VFIO callback is
> needed after TSM bind.

Yes, whever this list of per-PFN shared/private must be shared between
VFIO and the TSM.

> It is simpler on kernel side. FYR, may introduce some complexity in
> userspace, this may result in 3+ dmabufs. There may be shared holes
> in the BAR, and kvm slot can't be gfn sparse. This may not be a big
> problem.

Userspace probably needs to create multiple slots for sparsity

Again this seems much better if userspace handles it and just uses
simple mostly existing KVM interfaces.

Why 3+ dmabufs? Isn't just one shared and one private per BAR?

Jason

