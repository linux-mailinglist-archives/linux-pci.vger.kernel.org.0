Return-Path: <linux-pci+bounces-39028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F120BFC363
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 15:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90DB19C6E09
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 13:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE1C346E7C;
	Wed, 22 Oct 2025 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e0pWYrJu"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC66B26ED20;
	Wed, 22 Oct 2025 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140358; cv=fail; b=Bj84GoqmgJAjy6I/wR7R5BIYXSdl55uloxqjSLiBwiNrFFkFzfhDzDbQq6ztFSl9uSJtckLX+XC4X1dJXaDSV9RT1qLWBoEhyLCrmXilVthNIjOLjnHh/AMl6oT6+yl4v+TzZKVUfL7gcYwuX8phwwbDNe0+dsqelNgX3VWLJzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140358; c=relaxed/simple;
	bh=nfeV+DhwnuBBgTXzCX0LirUDMm6PjcJBAY4RhXgSg4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LOLMxa01SCwlXQL+HS1NyFWWsTu6bX5HvS4nMyfrcwnmXQ738ILTqbBIR5oOBKIe21Ggg3AbXArLglqIixSzSaPfgC49Rq2JLecitQd4lJa5WZZD6pnBiqRHLQkD+eVOsImRblGNNffno2/Ihc0jjx0GwkjXw0HyzTDsABXIJw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e0pWYrJu; arc=fail smtp.client-ip=52.101.48.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvXuj3le0fvDv4nwEVO12iIqlZ8sU9GRClh1rmN5PpC0gWa5LdzRVLmfc0UDwywtmvqalWgoxthNyCIicWyR9TMT3pXFd4C+KiCX/fUWdjMNOqSLG6khl6p+kEYcnHhBmCWsHR2hAyZdVVFyptzVFxnNP2HupTnsGvWgeBha7GkfqIjsHN5Ial87BFovtmTKvBXi3/Ph9n4UaZqOzWmsuSRmiX9ZsJHfaWgOZ7eOFkoQbNnbDYG0+U3ovDZ9v0CbVasPKGqIB1m+X8QSlA4wr4KdUVwdMqmFDbdE/FXfbGL+EbUTShZVaYj9+CbdhHUXgw8A6LiSF58I5sstqfJeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJa3wa9z8rTqKSsNl08SAuDKm1qa14pT2e5cDLUR9SQ=;
 b=WUSeSLe4hUpqhVUHZL+Wl2LrZaW8b75bGWFhpzfWyxm3Fw/ZyXl1wUxaorVk9iPqdtjqTx2mvGAhwHbKHSX76lpDfhxNofAlZoCnXsJYWWsTk7yqzytjahvxz7EucTChe+7WDpP/udPBz6a0yROFyCk2DH+uJhTaEEt5Ozz+GUoxEGotwPJ85n++1LJExRaY74678wCxwwtE2wutx+7va53ZXOZrDMqnoMuqMyY9c066Qw8kOoTkVypCLHRusAWw5XVau4oh43Hq6ZMNlSGOqXd8Z3M2gDvPlyfZgQaiaDMyMXEs+F+9kWqvFdR2OW9UM7nT5pAPizbNzOwA4pNs6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJa3wa9z8rTqKSsNl08SAuDKm1qa14pT2e5cDLUR9SQ=;
 b=e0pWYrJu6sZNzOohkm516PaQjvb90Stx5Gv48SHIKcUhz7jkygkZ7hPAZOcJ1vqHsM0p2FrqVOS19gMB/Cu3tAATCo6dKeP2Hp/gCLMJcYbCuIlWvQeHSdf4uSapAY77DXC11FCPm21j7ZIsY/f9dXppPdcebMNuUNmdIt+StfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:39:12 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 13:39:12 +0000
Date: Wed, 22 Oct 2025 09:39:01 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Shyam-sundar.S-k@amd.com, bhelgaas@google.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
	linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux@roeck-us.net, mario.limonciello@amd.com,
	naveenkrishna.chatradhi@amd.com,
	platform-driver-x86@vger.kernel.org, suma.hegde@amd.com,
	tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
Message-ID: <20251022133901.GB7243@yaz-khff2.amd.com>
References: <20250107222847.3300430-7-yazen.ghannam@amd.com>
 <20251022011610.60d0ba6e.michal.pecio@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022011610.60d0ba6e.michal.pecio@gmail.com>
X-ClientProxiedBy: BN9PR03CA0438.namprd03.prod.outlook.com
 (2603:10b6:408:113::23) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: b20e576a-d9ee-44bd-cd1c-08de11706280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h64Vz0kjR4SfNY5EoeQ49s3jymIdJF0sJcmeyuiIqgO1OO1ZE7bmA3lLQWFU?=
 =?us-ascii?Q?hto6VqwiejHtBkMhI7UEWwMt4sv1rJsRVKeo6eTsSZXMn46tjJrBnaA50jiQ?=
 =?us-ascii?Q?AQ+HhvKCtPI3RgUa1XdpZoS2q7kJ0GoAL14JCly5RojVx8F8ZRCC/D08Ztp8?=
 =?us-ascii?Q?duGUlgfB0ilJdjlw8EG/MHzfQdD60YnxF4U3Rhw9b0dvWNzUzPGnEdrEEyZE?=
 =?us-ascii?Q?97PXHmqknAXGKyoQ923cwelY171kfyDSFaYAXDR3hTiZA2wP8cJxIdLEibRe?=
 =?us-ascii?Q?CaDnm29Fk32NPNuz76hGr1QJ5smK3LuO4I5pcQncqT4yk4Lfh8BMh5BFbuLq?=
 =?us-ascii?Q?fj/ZvFM+Fn1vEMedTbSAp+r6+FCsAZIeEmFA52CA3s3LT7aEmgBmSdBX9mhh?=
 =?us-ascii?Q?6x0nLHprJ0CdFmdqQs4Le81g++qvqt7/uXlT2DxBfdwYYhmIuDPfw7uXeN9s?=
 =?us-ascii?Q?Z9Dv9OVO5OMPUrIlBacm4t1aDLgoditLaT0pIh58wNONaGorAKAUC/AOVHM4?=
 =?us-ascii?Q?+IZMUJj4TK8XLj/FmvA+or5XYbTcjmkq81XO0izwyc4dSN3ET/XtnMw4sxAM?=
 =?us-ascii?Q?SW9mdLFdk1FELodKukc/VTxtLj+gARswF2wzYN+T4TLy9ovCKdaI5HR+gQt6?=
 =?us-ascii?Q?oRqdjCvv9a5WDZRTwOIbKeSxslOfvH3zNfjp0f70ZJE2GLriyAsQqlpor4LS?=
 =?us-ascii?Q?28Zkryy4N6lOoBXi5e4Wrvc6mkmA+pA6hMkTBGwg1paFXO8mYDxzIj78WUGF?=
 =?us-ascii?Q?KBePeM+tViogLid9LVwlU0VnKh3YiBTOGCMLma0AneWTIo1Eg+MLUTzYhlEr?=
 =?us-ascii?Q?X8eWwxJApbY2idFA0KX+qeKpdmG0RI7Wj3W3XqouSL5Aee4A2xi1s6Qw7iS/?=
 =?us-ascii?Q?gTMD0gs2djQ6cLWrmKiqh/xU6sL/jMl0djSCof7ZXU2sSfiAnc/XAPGpvemV?=
 =?us-ascii?Q?1ekocJBdbFLOq5XEo7AJiKy6KSOfzQVlmlfdx1xNX1Q4Ov47qbYAO0+6JqJg?=
 =?us-ascii?Q?Zh5zR3zgoxDezN6h0Fb0MpvDO0AjZzOwqHKU46SKifvUO7OH5PDIr4Ebu2k6?=
 =?us-ascii?Q?EHPSm/vDa+svAFn8hSmKcrsadPooz6nkTKO+z6z/chaaxHeU6v2ONgk+6c4y?=
 =?us-ascii?Q?JFPFQrF8vxsWTi6I8OnJRV/lkOwP/E9mNXaGNMQ05k5nnzogTNbKAs+fzg7C?=
 =?us-ascii?Q?Z0Sws23NgACSnZrQ034itMST1Oy3ROKGwwnyGalrbKNv0fIGkVsZwAjzLF3O?=
 =?us-ascii?Q?KZg6bMsKZ50t4mVUDbFB3LQK8GeL32SY/6S0KGK++b6uLW8/hV/wWNjr33WR?=
 =?us-ascii?Q?j3r2/OEyZgELNUtAR7WIjNmv92qI3sJk+uNq6QAv43wK2HePL9IvDbwi1deq?=
 =?us-ascii?Q?U1FNXvobKgwwmjT+MIziNfx31TY4P79lj1sFdTNod6k+KiyDkwBSTJOXV66o?=
 =?us-ascii?Q?t57851Sf32B0XfohYram319HQDb4z986?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jjZLS0rre15vE9oxCri8wK1JqBL/bnCzJ4TtNH6MVrc9/80/84ENvWMV3WO9?=
 =?us-ascii?Q?hrejBz54vGW0ZnAAGnko5dxbOuWb4S5Li0VRRc4UFAvRCFuT4nq9CrcoRN9S?=
 =?us-ascii?Q?xUvIwSGVodkkSfzCYdRtQKAE5HNhQOb+dC/uxWqWVhSJmikw8dh+PrLPG1J5?=
 =?us-ascii?Q?rnCUf+tjgdCItXJwh+mspMhYTbR6wHpQIouBowHZtjJ/IBZgBYNOy+A2dVYM?=
 =?us-ascii?Q?J2lbdskUP0ReBYrFnrq/zfDw47G/zo0h42YWCYmws8SdYVnsE5Ap7GBs7EXo?=
 =?us-ascii?Q?SLZjVilrjAMNqGpRWAD3oCUcIb5P+RZGIZGSbdf/A+TDaWI5Ipf85HnSw0sG?=
 =?us-ascii?Q?XyM6gxCUc5FHwSJL2b1umnm7H5ygWPnrneLyE4zE2N8Kow8dH4nRPC20qGJT?=
 =?us-ascii?Q?HunwOF/SBedmUc7rs6m/0JnWICGgsMApWMBNfa90G+ZdUTfF0psSTJ/zqYL7?=
 =?us-ascii?Q?fY1s9u4MohIbiTIzKZzPj3OrBGvqdFhVkcgqWLblv++r5g2eTPPOeO9rKVyi?=
 =?us-ascii?Q?gsLAkYYuus3gZ0TZrU7s2+M+ZvOmTPTHSpVTVSLssEoPSLnZrggrvUpAAa+6?=
 =?us-ascii?Q?/SAv8qj+8Vnrj/JQIJycs989O8mdd62dqvBEgQLYXyyGJGvt/vHjyVDQ5mVE?=
 =?us-ascii?Q?bkn4o3W2P595Dh8eXO9JqzqnRYocQo2bPJR8+y4UoiZ5xGFjRcHmmWPL81sX?=
 =?us-ascii?Q?rDIzeJpHskG3TmcZpqE+jDuvOGbFl+OqbV6WZhhw09IJdF9UqgP0ODG0UL3s?=
 =?us-ascii?Q?3PiIahxGdg4VWnI9NHkARCtjuEDkV2xH21Y6eTlwdyMka0H+dM9nRnXx8twm?=
 =?us-ascii?Q?Zmc7Jq62Zkg5yoCI49ATFlo6N6Vd9y6/TsmY5Xd/MRZwGJvShL4/wSH3Il8j?=
 =?us-ascii?Q?UCc5dl750KsPmhqDCM+NPWyUg7oL/TM17ziqIFRWvbrf8mXN16flIXtJkSGI?=
 =?us-ascii?Q?n9dVMgrHgnpnWsxem3uJ5rYP2ibI2l+6+qUhBm29buKZ+fiqP3fwlWox1mTw?=
 =?us-ascii?Q?bw9bDnpBdqDPpNdRlYM3SXTVGAm6NSo7yKP1Voxat5fAadTUXONfmxeZgZra?=
 =?us-ascii?Q?JkmDoLVc4GV1cjRo0YqFx4wtrgKOdb4MpxbkcmfKaBlzsqP9qcoFYT85gofD?=
 =?us-ascii?Q?odT4uYmem20nooZrEJVUkr5lxYVcXtL4cSGcP28oqjiUa20FIF6vRjmgzQgI?=
 =?us-ascii?Q?fh0itGBHbM6OoB5LuS5zWmQVFAygRMaEAZvPxs6cmGGobnJqR8zu/kgc18Yu?=
 =?us-ascii?Q?AKnh9YdNsHMzbbiW1u5R0VBU8efHq5nBBat2bq+pGpM+pA0lJkqPLDtBD/99?=
 =?us-ascii?Q?Fp9Ii4ulu6EeX2rGXtp9iriXW2FZvwmhSyzDOXqIwl6AlvPy5NiE4zSkWIqF?=
 =?us-ascii?Q?o7mE1eTsqrRlntnq/4KYjJrudkISzQ0gaPhIcuK5t9WLhYlCOFe8HvkUmhis?=
 =?us-ascii?Q?SIvfuXgVqwa1rqeuzFf1dODPNLnnFY15DHXahSWxNBLkQXG9wKMALjVpNHER?=
 =?us-ascii?Q?iWHJCFqS6udWJo+wZnDoAYgWyYOhv5p+2/l62T2ddfQKcq3lcUZLuUqTTomQ?=
 =?us-ascii?Q?MSbiDyw/JKwRhLq/Wc/jW0J51ta6dT2cjyKYTb0r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20e576a-d9ee-44bd-cd1c-08de11706280
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:39:12.3104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4J+e9fpYdyKEpbR78s5Tje5MeK7mrebcN+3glzvLNsX1TGq6O5EX/E/He86JNZIPNkWzR10vpMhPEgtoXWhxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736

On Wed, Oct 22, 2025 at 01:16:10AM +0200, Michal Pecio wrote:
> > Currently, the total AMD node count is determined by searching and
> > counting CPU/node devices using PCI IDs.
> > 
> > However, AMD node information is already available through topology
> > CPUID/MSRs. The recent topology rework has made this info easier to
> > access.
> > 
> > Replace the node counting code with a simple product of topology info.
> > 
> > Every node/northbridge is expected to have a 'misc' device. Clear
> > everything out if a 'misc' device isn't found on a node.
> 
> Hi,
> 
> I have a weird/buggy AM3 machine (Asus M4A88TD-M EVO, Phenom 965) where
> the kernel believes there are two packages and this assumption fails.
> 
> [    0.072051] CPU topo: Max. logical packages:   2
> [    0.072052] CPU topo: Max. logical dies:       2
> [    0.072052] CPU topo: Max. dies per package:   1
> [    0.072057] CPU topo: Max. threads per core:   1
> [    0.072058] CPU topo: Num. cores per package:     4
> [    0.072059] CPU topo: Num. threads per package:   4
> 
> It's currently on v6.12 series and working OK, but I remember trying
> v6.15 at one point and finding that EDAC and GART IOMMU were broken
> because the NB driver failed to initialize. This fixed it:
> 
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c
> @@ -496,8 +496,8 @@ void __init topology_init_possible_cpus(void)
>         total_cpus = allowed;
>         set_nr_cpu_ids(allowed);
>  
> -       cnta = domain_weight(TOPO_PKG_DOMAIN);
> -       cntb = domain_weight(TOPO_DIE_DOMAIN);
> +       cnta = 1;
> +       cntb = 1;
>         __max_logical_packages = cnta;
>         __max_dies_per_package = 1U << (get_count_order(cntb) - get_count_order(cnta));
> 
> It was a few weeks ago and the machine is currently back on v6.12,
> but I'm almost sure I tracked it down to this exact code:
> 
> > +	amd_northbridges.num = amd_num_nodes();
> > [...]
> > +		/*
> > +		 * Each Northbridge must have a 'misc' device.
> > +		 * If not, then uninitialize everything.
> > +		 */
> > +		if (!node_to_amd_nb(i)->misc) {
> > +			amd_northbridges.num = 0;
> > +			kfree(nb);
> > +			return -ENODEV;
> > +		}
> 

Hi Michal,

Thanks for reporting this.

Can you please share the full output from dmesg and lspci?

Also, can you please share the raw CPUID output (cpuid -r)?

Thanks,
Yazen

