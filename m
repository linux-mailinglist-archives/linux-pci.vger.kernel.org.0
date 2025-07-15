Return-Path: <linux-pci+bounces-32154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F78DB05AE9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 15:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E102D3B7363
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB742E175D;
	Tue, 15 Jul 2025 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hn9hc0Ht"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4F2D8790
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584996; cv=fail; b=fG0R9XCaPOpYceIcFuw46w0NFGgaVQGk0YZHBig1diObQb6xgcqfmUr7ELZ/xJBKud+ccbcktE8896/Rqmh2BARy5kNG6OM1yg6Tmb1Q+kzslhv5roZJ+nX69A1rY7jideY+p1wv7OwyVjdSAFkbprEKMy000HIFbhekAh1NcY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584996; c=relaxed/simple;
	bh=1OTPhFw7AuejZ5f0eUCkFo4+KA2OQDSdP0ho+QK+MD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b+CMU0XYLAsfp7plenHNJBpiLP9Tx+h4DpBrTUjZ/YQMkQ9iSnAR9Sh04dH8EDUlDREIghVGanvZgy8RSzLbVnIIV6Wq1gqHf4We0eqLgdkhG3UzTho9th83zB5El1UCN8rPahOSvNFqAjOJeQsF7rhkbVDuMqnTV3lvKREXehw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hn9hc0Ht; arc=fail smtp.client-ip=40.107.102.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFrRTRgWvVIbUlMQ5acQTkXt5WXLuiLPd9Z2l5F1Fn8Eg8oJN9DXxoDu3gpZLjq5hX54yQnkhYQQ8JFo63/3HY5dRaH7Dog2+gRxydxxgdRUq9cd8M4TD4zR2w/atMFf8Ly8y+vCtKVgW644D9DaRKprqKPQ2EIeZ0l7NL0FJzAlmbIgKYZknbMpf0XqYjOR3ZjvjH+TFDO7eOkhYYiD3fw/UrogyzhXMBiSNBb9g+v7tUkALRIQgY4HPM3fM0H/M1GIQJeRqpPOV62yPXPymDVR3gUh2abGsipuIWka3FxM6LUqVIT16oinD6Y/Iw3R88JvTN/FrBjjsBQBoomRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcdxqE3OosyZQVW1R0tccshNpe9/2hCPsMGUMIhvrzA=;
 b=UagsdUXut70tlr7eW9wyAJdk7L6DMmRPhfw6SDUdQMo+/nDWTsoixENTSphCUtqwzvgGI/0omYRY2kswIzaTuEoWWE2HeyKBwSMq7ZLao+Nw7TJGY5AXd2YCIUp0s5mMRFnrScAQudP0hM+n10GP13flp8l6pWDILClwgcqpjFFfk1wv+OEOcrSqPrFHEdKnQnXmpKrmvIED/7zlMkQ/SYwUH8pxJqPAKj2oLfoFKwtbZ3HVDC2zv4+ouNxpCTxy52yNcsIQennx0UXuB9vX/ASswtnKrH5rdhGA4hm5DHbwcagymHL3v4K+HkRhT8ZlmyvJfz615eTaKFTXhhUqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcdxqE3OosyZQVW1R0tccshNpe9/2hCPsMGUMIhvrzA=;
 b=Hn9hc0HtnYXI+8K8mKV5o4gXcaUQexhNHvIu3A8lciDWKokeYhXpWEcFNLiYHgAauFgAvtEgoPhYfNVQipWtfWuIMObSJY2VBFFUX7nQ69dGMVaF98bLMB3CBHtP7FsTqUSy1ku3b0+xlRejJhG1n1s3cp17/uNoNS6SScPN+JCnhSgFSU3VGTCijaZFlao9gpnVCvccbepAtYFRELwCJomKZzaFWuCczFlRoy9ZQzC3+U73ffw6/ICp+u0jfjvnO/g6kPBOReiB6DaqkBV5bX/l+wRojiLBUZq6IOsrI5pLK6J2tZh50I3OVXvCBgS0y3QxK0NomY4KaGnDsSkXmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:09:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 13:09:51 +0000
Date: Tue, 15 Jul 2025 10:09:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250715130949.GM2067380@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aHYtj/jyfXD4XhZy@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHYtj/jyfXD4XhZy@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: BL1PR13CA0296.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c24f9b1-954d-4243-33ab-08ddc3a0e1d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ht4wcp4/uE5FffV/NBBMplJ9mO+sXdGJuKrlK78lHaGfX3cvM5wqKHmnDK/3?=
 =?us-ascii?Q?XiZ9LsIgLWj7kE+7DKACkvYzePS4fK593/i6glE4PPz/lcXDGYGJPOnOVVDn?=
 =?us-ascii?Q?x/26255ppPl4SI9TIf3ZE0g5FLRO31Ng8lzuhobtVe3AzuTdVu0oYFN6bwvW?=
 =?us-ascii?Q?QG7bjIbnSCvffCLSHcUvtxZbVlCO3Fr01w8p9gtDejmvozAQtuOuUd5a1jgt?=
 =?us-ascii?Q?eyxNYMTxp21eeQ+dPywhZfM6+5dXhASOGPDarTYgsxtFDyazB6tm6p0Qx9ka?=
 =?us-ascii?Q?cQVOZiWsiaF9YZBFjbHxOtB6EJp2Zq4ZVcFW8s0ilL2XWUoeEIW5LuHpkzup?=
 =?us-ascii?Q?/dGrNe0JimpQT4fEqikexUZi0lP5ym0oRSU5PIzjVmkXZE/oxW4BsOjHM9MC?=
 =?us-ascii?Q?/PisUHHJrjhNf/73Mncb+VsJjXUiSOe880CVrTmbuOf6Qhsh+J7OlpfHne5t?=
 =?us-ascii?Q?NmQ1XYpEiwbpNTSfNg8k/LMMDYOcPUf6vZfDoSnA/O5aITnWhWaA84eMfVjF?=
 =?us-ascii?Q?EvleQWYsYDx3obZ0KIaddwPxGNiUFtXWzeg3/n/38Ibu7UDBLj1l+B3jLeFB?=
 =?us-ascii?Q?qd7rVUozCpOkzs6TZ1qxCAGJ2TmwHJ6ZxrE4fm9so4SGDkrzrg2a7LVVJ4ou?=
 =?us-ascii?Q?nwOZFp8YiKV6/iKCxZepL23jiWUhmLjyLP8XTs55uecKX3yFCb6h7hE86cRs?=
 =?us-ascii?Q?9IlzTgEjoS+Wg2uBjhACCi1gsfl7/CtnzRces0H4S8xxgon2WBW9z/0qic0H?=
 =?us-ascii?Q?N5Kmi7tGdCXLCnJTcw/u4BfVShiqpJT6qiPAJ5zZyilZBzE/v1+sVy7Xq0ze?=
 =?us-ascii?Q?V691ecLExgcEL1LFhSVTnfKPkQWAtnWWw7OPfSENq/Ugx397Q2iKuQHmTBEK?=
 =?us-ascii?Q?hl01niFPxD5+rHE07XIiqEQTdiVzTf4ThDEG9gjP/o5vwcgR6LqxsWKYkGeP?=
 =?us-ascii?Q?3oOWT//yngUSx2UQDZZ6Jgo5NQvbFFhRPUtM5ANS5cJbh0lit842wWgoANjn?=
 =?us-ascii?Q?zOux2eUt3k0fRG4QJVhkovNYlwowcYhbAAA4hTlvDrmuEbH2ku0Z1KxP6P7G?=
 =?us-ascii?Q?DABxkuOF329uDOvS6FTUBCXiScVg/lTN3QsBWldg4HD/4xuxvd00HFvzsheE?=
 =?us-ascii?Q?c+17HD0wcl3HjzSKJFuIPaFk9x5HoG+Yz/GpBRvR6wvx/N9DG51SEF41/EDI?=
 =?us-ascii?Q?OKx0YvDwhZy1Avx+qbe8AGkxFbC2FhKkfOnaKcB2odnLlNuSDnEu3qb1j3yb?=
 =?us-ascii?Q?83AzgZjGMAKgKZCol6K9cay8fxTDKyqzLzkRshRep+xGaZ0wAVMmOY95HKUU?=
 =?us-ascii?Q?8NuuBq1seEAIbwk7DqGWWkH1n2aYZ0YIoVNkAG6ewr2yI0JhhXZxOv+4KRBr?=
 =?us-ascii?Q?BbG48qV6cxjqRneaLo5sjot/t3oQCBzfaebVnzF3dP+Lo8Ea9z9wykB88XA8?=
 =?us-ascii?Q?MuBCxlWh9wM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+SvNbZ/3gl1D8rZIvFcL9Mqr9kE56Ht1gfKgXx5hsNPBGZlwGC4emJMEhztn?=
 =?us-ascii?Q?vdQHHclUELTJQ5F6ZWmRa4zO07I+lXEYON10RF8QIPKPmX5UEF1+1xD63BhC?=
 =?us-ascii?Q?5k09A8/9JAHDDb+8NCXAUwfG6NmSdqO9Q6FtJq3yci19LvYLi3RhiX9Ynp0h?=
 =?us-ascii?Q?s/Eyu5SnxgZ78BqZqxUZox9HUPSN84RV/RMOYdbQ60yF8apLdvjIOpC2u/FQ?=
 =?us-ascii?Q?UlSaCtTyogg/fDCZpheDZ0VTSmzlGZflxSuqOWLJWgkcM8B8xxapXiKYHVpw?=
 =?us-ascii?Q?5s3haxpqa1PFzXAhLCEnBAEN74bMur6xPKfNPCHs7moF6Li1ycFZVeVTYdX2?=
 =?us-ascii?Q?ACVH7F7tvkO83uTOJ3/uyzuX67tHNB1Bdq/3ezieLlg8tSOFCiCw04PuYCMJ?=
 =?us-ascii?Q?FF42zS8Eoo+YID8TBuLF8rlWEZJ4Rccuf5kynPnBqTyVgPBRbNAZOcntNTHB?=
 =?us-ascii?Q?VjwdHk4OQS8jkn0mPb6J4IzfbUrB/I2mP7wLyNGwXAUaILSH1wMkD0fXBDUK?=
 =?us-ascii?Q?HNI3DstrtyV3C0kDF3MXqZtyOqONngdjOi9LlX58IXw5xRYb2jAGcqkaqpev?=
 =?us-ascii?Q?cNmdMuu2DKUMr96kzAhj7f5iT7u1d0vyQfxzVFzv6sqjuq6euupHl+NXUFHS?=
 =?us-ascii?Q?5m+IRwxwJlC4odQkgEyjUhMJXwXN7k+alhg5vUz5+iSVCJa7pCdITbv1Q5fO?=
 =?us-ascii?Q?dgDax6IuZlGMvC0AR9J6NJZKccio/wimdJHh8lnF31swIb35/j5AZg7n8cDm?=
 =?us-ascii?Q?5w1M+XID7mYBGMMliwpHJds+CcdoKkrrTeWEjfnyLBX8ld+z5ESpmO1nXeXL?=
 =?us-ascii?Q?LBRxu3hOnoXP+4k8PpReH2fPj1ouVpu9SMrzVrrNtE3q8LsV3Bx1eMdF2k9H?=
 =?us-ascii?Q?f+qBryxM9+rsmfVBhQPZi21UHwy+iaaLASExEYYfUQTkNXOGphaClIgjISqj?=
 =?us-ascii?Q?BSvj7aRZ9tIK4ibpxwaAirKDEEpJGq2rlqhpFNKldW4EyhoK/zzXK2w0WQUY?=
 =?us-ascii?Q?+iG237UCrprxpXYE8/MOYNZ89ijBZAdTro8eA/VqP76x4nzRUnyugOKpm7O6?=
 =?us-ascii?Q?C0uNTncyd5Df+kiAdvdTwQxaeeGA/maoQVbgywN4xvNSlD9sU0u6yeL0Z7w5?=
 =?us-ascii?Q?/pl8aVzfMr4D/6IdVM8vkK/Yx1QF823uCAyqvZ0K6Ip1VLSItuywgnuJBVZ1?=
 =?us-ascii?Q?utonw6mTZcd6BF3DyZY5rYPGaEPRXdy7Ibj0tf9s/cwxEz5HnDICW1rW8Cdz?=
 =?us-ascii?Q?hZ6pbCYZnNRjia3VKNz+t84dST5a5rqMbrkH8VXFzfLap9GJgT2fqUMP7FUF?=
 =?us-ascii?Q?+md67lVtBc0lKpD1WNGrVar/LeEbxunbXVjIUkptlaQ2FeuISZjsBHQ4rOnV?=
 =?us-ascii?Q?jVebacUWcnt/8bmcGcWAF0wCh69GRn1prUVfcQ3AFXcnbYf073akqpCzZZXJ?=
 =?us-ascii?Q?m2e5i4+smTTm7od/a2Nrt5MYn+OCnMwa8Sm1DfD6KTve3M5MYi4EGD5nKCpm?=
 =?us-ascii?Q?iH3XUccitQ7XAHC2p8eF7fhiYJBN6NMUMSXoG14zTKdcUOK2ReloZ7tKRfdy?=
 =?us-ascii?Q?zue2Tgg6bD4bPHxd1Ta4EIfbfUaUBlvz7IplbP/C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c24f9b1-954d-4243-33ab-08ddc3a0e1d2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:09:50.9528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWhgwaJuuReOU++6dNTL+ry6kHugx0zyiu9Q1RdJy9n+AIHTYFEkQ5jHfsPuMQg3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

On Tue, Jul 15, 2025 at 06:29:35PM +0800, Xu Yilun wrote:
> On Thu, May 29, 2025 at 07:07:56PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > ---
> >  drivers/iommu/iommufd/iommufd_private.h |  3 +
> >  drivers/iommu/iommufd/main.c            |  5 ++
> >  drivers/iommu/iommufd/viommu.c          | 78 +++++++++++++++++++++++++
> >  include/uapi/linux/iommufd.h            | 15 +++++
> >  4 files changed, 101 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> > index 80e8c76d25f2..a323e8b18125 100644
> > --- a/drivers/iommu/iommufd/iommufd_private.h
> > +++ b/drivers/iommu/iommufd/iommufd_private.h
> > @@ -606,6 +606,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
> >  void iommufd_viommu_destroy(struct iommufd_object *obj);
> >  int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
> >  void iommufd_vdevice_destroy(struct iommufd_object *obj);
> > +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd);
> > +int iommufd_vdevice_tsm_unbind_ioctl(struct iommufd_ucmd *ucmd);
> 
> Hello:
> 
> I recently have another concern about the vdevice tsm bind/unbind API.
> And need your inputs.
> 
> According to this:
> https://lore.kernel.org/all/aC9QPoEUw_nLHhV4@google.com/
> 
> Sean illustrates the memory in-place conversion, that the memory
> owner - gmemfd should own & control the memory shareability) and
> the conversion. I.e. For in-place conversion,
> KVM_SET_MEMORY_ATTRIBUTES should be disabled.
> 
> Private/shared MMIO must be of in-place conversion, similarly it's
> the MMIO owner should be responsible for MMIO shareability, maybe adding
> some new ioctls like MMIO_CONVERT_SHARED/PRIVATE.

Except it doesn't work like that for MMIO. Shared/private is a TDI
operation only and effects the whole device. We shouldn't split it
into two actions.

I also don't think it needs to be strictly 'in-place' as we expect the
VM to be idle on the MMIO during this change over. Faulting would be OK.

> From previous discussion, VFIO is the MMIO owner (implement as dmabuf
> exporter), so manages MMIO shareability. And IOMMUFD vdevice is the TDI
> state owner for TSM bind/unbind. But MMIO shareability & TDI state are
> actually correlated, do we really want to manage them in 2 components?

Yes, we've been over this. There are two components, we have to split
it somehow. It makes more sense for iommufd to lead the ioctls because
it has more information about the full system.

Any case where we need to get back to vfio for something needs to be
managed with a callback of some kind. We need to get a list of what
those things are.

What do all the arches need here?
 - ARM I suspect has the TDI locking operation install the MMIO in the
   secure S2, not KVM?
 - AMD just leaves the MMIO mapped all the time?
 - x86 presumably needs to carefully map/unmap to KVM and iommu in the
   right sequence or you get a MCE?

So what is the plan? You want to wrap this in DMABUF, but will there
be two DMABUFS, one for secure and one for non-secure? Is userspace
expected to map/unmap in the right sequence?

Something else?

Jason

