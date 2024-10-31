Return-Path: <linux-pci+bounces-15718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAC99B7E80
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31DE284994
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ACE1A3BD8;
	Thu, 31 Oct 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QlYnwePp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD511A2C04;
	Thu, 31 Oct 2024 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388598; cv=fail; b=sGMgz/32lQMdP0TKtRxZld2PitzAJ077jh45j68woLGtegyk1Rv+j2vmOuoJIHdPS2q/Zh7oDx26+WiaSXa2FiIRvVZ0bLPnFWmK30OPjYs0xOrPybpU7JVA3UdC0Q6RUqMXylLkBRDCTCyjciDGrccBzHPczEs9wNsBm+jGyf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388598; c=relaxed/simple;
	bh=4SwW6owyb5YZ9vwk42BaRBdXLCD41FVx8A3HXeuFi2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OC1Fn2hdoCPAQY76hceO8hRIQMZshvQ/XgT0KsctIz2Y+dVAgp95p8hDwsHvcYjgeD6bvMSyW6e2JBybEljB0dG8fgEy/pCffAQaby9Mu3+NjVkTG1+vXMsnx6Os3BYa6gYgS7G4JQkR4bLmN7ZxxRwMbE75Mz71COouR1iZo8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QlYnwePp; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FC6UQ4CrO302FS3N/2eXS1vk+BH7bev4doP5V2Ddv1xtMmkqWrLFPTObcMvg8cVPU4cm2nToKgquBKJFzznRf/zwzzWlErz1NzXmWYyTfQ3MV6kkPC+kipHR8ZhKK2uKLAFJxkTFalyqaDWotDIcCV9rGPVEr8r3DmT2vCdUYAU61+DFEPzhbFOdGp02JUSpzcT7eetjkHxDuXRHrNJgshoXRCKjBNuEO4mMIGEhfk0HLAUpMHlFAdupN27VsN25pZbqcaxJa3ijl45Gk4oKUunMU5yuNjKGPDj/G2EaAvW5DqA50pf5/tc+pcRCwRk8yR9vgIex4dFLom8L7KRFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baSorjumU1fOa/AqnjcF0WQPJI282RQjmv1AFjRgiRI=;
 b=mB79cIzfAOgAQfPF2KoDIf2TdV2gVA8vzUaoiVjPntiOuchvVBiOHM30ZgE3yS0S97hxij3XOprkXgBM3u7xwl7uorQnvHJh/uRIaEA1Ko/dMsFc1hV7peYFLt4BYn4KEs/ELpihREKqwu6uPrf0+W++GlYZHd9Uk1olDKrDJ/xo2OZJn599w1JPB8ajjrJgMNQxwWS6BYz36pgjF6KUXdQ+mbWNy3LdbkpBQMn39YDb5+aWzzqbfkQ07I2evDCYV8W9w4m5CZ9z/Cd/kWTtXKKmgZGmNFoLzN1ckIWCh237XV55KJgpISIPPJKBL3RmFAqvX7vmDjGNch5BUT4qSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baSorjumU1fOa/AqnjcF0WQPJI282RQjmv1AFjRgiRI=;
 b=QlYnwePp5np2H96zu/GmSfBGR3WnFA4mdpYJREo+7QUQoNBZdy8apZ73Mi9LCwFD4AGGDR1eF18QKr1V5HevUu5tSh4QCmczNNNvSedRclePzwA61RJhTklMtNlw+fa50oFqMeiE+AVqfxTGWxERwFFyIUW0R85SI3+qBEmnXo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.20; Thu, 31 Oct 2024 15:29:49 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 15:29:49 +0000
Date: Thu, 31 Oct 2024 11:29:44 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, mario.limonciello@amd.com, bhelgaas@google.com,
	Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com,
	linux@roeck-us.net, clemens@ladisch.de, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH 06/16] x86/amd_nb: Simplify root device search
Message-ID: <20241031152944.GA1511886@yaz-khff2.amd.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-7-yazen.ghannam@amd.com>
 <20241031112027.GIZyNn-2JkbpnNJhw1@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031112027.GIZyNn-2JkbpnNJhw1@fat_crate.local>
X-ClientProxiedBy: BL1PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::30) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f6cb85-56b7-4827-0b62-08dcf9c0db76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C+cYaY4/XvyHYmOzpMsmdtBObujwguqambrPqm4BXL8zFU0TJkfbzzIkHJOS?=
 =?us-ascii?Q?zhbD/+Izc48UjYkjsjAa5qpNlvaIQPzOC8OyaBEer9kPo6Cp8GG8+VRyPBXU?=
 =?us-ascii?Q?QvLfQV0VziUDaxZmiPu/UUAa2ewbewQukPyMRF3pPhMRrBZT1g19e9zO6CC3?=
 =?us-ascii?Q?BGxni5l9JtdI+3B5s3XWAOt1u47qDXICz49oTrxbA/BGurkxto+L428MlR6r?=
 =?us-ascii?Q?vZjGOePlCvUkDL+Ywju9llktRRy5H+Gn57D3CEeBlbV9Qw+DKxXT1xVFrc+c?=
 =?us-ascii?Q?CfrxJZh4K5i77g8v0BxqY3x/wRIvnnpAgwBm0Or2wBxM6Qg2RXdIWQBKkfdm?=
 =?us-ascii?Q?5Sn+xIYH/yZjUoCzcWasDHaerOAa0CzUB97bo/dApMtDdiphKaVGpbzLfZxS?=
 =?us-ascii?Q?KNgw7dlrvlY7h/MOo8O/kKH+y1c/oqcmzoGWqUitPMWKevcVCfuhhZe5kbJ8?=
 =?us-ascii?Q?w5KvmJjUvXLMOn1orpf1KPqsnaNpmeF/whGZrjf/lmJpRlGXVJQcD5kqD5V2?=
 =?us-ascii?Q?1f44wyZaAhjD1tA7a+ONPQYWbWwsIlVSeXpMfDUj59eU/0UNdB3MIrzZWB0o?=
 =?us-ascii?Q?02pSbXukpqN/cGLJOuK4JVfN5tg3LOxf7S+/HNhGekNdcerT8KgDXzMqbRdv?=
 =?us-ascii?Q?oeUNtDUj6t3gJLqu5vU1uYXt+KAd5gslAtpBPlF4wQC2593W0ZnUqlKXGicw?=
 =?us-ascii?Q?o7YagrwTEgPOyYUcyOWiWFBTBLY3W9ii/DrGuFuTQasZbsDMMbpjIdGsrP1E?=
 =?us-ascii?Q?RC3JvIAdlcB90eGF3o85uNUNZAs+zXAfJiW2HlzkVGMD94F+NnVk1PwhjCFb?=
 =?us-ascii?Q?ihPES/NQexWfx4z5ZFGBOBEDfZQzRBBqhA0yOFxwLKKPNd4Hq0YNPepsUFFU?=
 =?us-ascii?Q?qDQ4QwNSJi8BZoaQP3oGAbS25lGH0h76xEhxgAB2Ji4O2KFN9bJe4CO2rW8l?=
 =?us-ascii?Q?huu9yo/sHLpqsw0nYND5xvkBg6TT7kcFmAhpNHr8C215/OxdmXIHm1azWfTE?=
 =?us-ascii?Q?le6l6cJQZwmcMDx6sNuvGPnhrvNmE+WLz6qA7S9aebtqJU0WFW9p5AP4wex5?=
 =?us-ascii?Q?MZNgFj04RuUJJSL4FPFHScv7XB4WEi1hDcjZWH/3yoKBoIkUMr6YraZDFtJq?=
 =?us-ascii?Q?Crj6VhK1S90GUQk5t6swWpZher3Bdb/Wa9k03bLXDq2lK07GUTJYD8rcekFn?=
 =?us-ascii?Q?KOyQ+Nu0Vws/tg7X1+Fl/4hRVGMnbHm6ln7cG8kexvPG69MxiTeE8bfMXRsl?=
 =?us-ascii?Q?yi3bF57piLeCVgGz0eBqspNOtfoEkM5fLX4VyIHP+0i9yqb7qe4Wfg8xwSW2?=
 =?us-ascii?Q?L5xo/CC7Tufi32282FpMbKzJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?St/oj1i/Z+LTTuXyvJH5y0NTNHHFwyErSwvGiSnIT+PIKPVvKTvxXdy0xblY?=
 =?us-ascii?Q?1IwlxDHitt1X6fSPOMhY7hXsTGZXFjwTiXqBoxJKzcirMhhf/xvcLtvATwlr?=
 =?us-ascii?Q?78B1fA2273flJfsXlRhkfBWcGpm/ySwB2rOu7jqj47i/W8ymRnze8o+9iX5R?=
 =?us-ascii?Q?VmeEEy1kO5oQOyW11sXbWjhsIGhbbGcqPfjxu/OyI/58IekuEu6YW4XA4R3K?=
 =?us-ascii?Q?R072snhcgQGqQ4KkuFsomXjGXrMj+Hpd731qyVFZWjEd/7QZCRiEv12gMVxi?=
 =?us-ascii?Q?mahd93Nx8jSR8hEVtqNQpF6d4soe0BTy48V6JO564n32heBiJOcuqyBDMuhz?=
 =?us-ascii?Q?YBLmEL8d2ISeGdlKxx1nvgUzEOeLQDX6Jynt3/g4S1tPoTxRHYfLhjFI8lZN?=
 =?us-ascii?Q?JRkqUAPmiCwaGFQZj3XHCoX9floPMvjRdFHab0xIDiDllWBoGmvAMQ9jr1aN?=
 =?us-ascii?Q?jQ7HH03sKQf6WTrCBMkit7RXzM0mY5uFwfkEaJ5mfJAYDVrg70Xm9q5C64Dj?=
 =?us-ascii?Q?Tw3jtQVm+OjIWfmWdMS4vsDjDGrFYjNHAqn6LeCbMmOB0bcfL3eSNQ+f0nZY?=
 =?us-ascii?Q?atd2JfrGadCT3uE7UXvOzPTszQSHIMnU8mSJdXFe5+z9cStR40+KFHmIKRQy?=
 =?us-ascii?Q?E0p8Fs8bkKkfJUHFmgxUh+BGTIHdXELVXPa3uAWbWgkYHaXTDwxThtshHzGo?=
 =?us-ascii?Q?F8vY7YuCD6JQbS+DC0JOMfjWo8Gth9ePNRUbY6NIDnDbNBAX3Uikr62PPCLz?=
 =?us-ascii?Q?nofwbQWjsaPs6/3QMIC1ArODUSr1yGW6EzdBF0maoaHxFsozy6sQ0HhVUtsB?=
 =?us-ascii?Q?1CysSgV5jDZ53v/ejtP/A75DUCjR3yjADmPGmHaH5FVu+t1WCncEW3uJr+40?=
 =?us-ascii?Q?HOlvlNjb89atGc+4zsNb4DkWOqPI6GppVtFCeqmkS6cmtQP0dODC9tgaVfoW?=
 =?us-ascii?Q?tLazY/pdG9o+kgBHZvQliqUXXfFGP/g5N/Um4UiHST1Vw/Qnrg9PhVhe1gMl?=
 =?us-ascii?Q?mNp7ph9iK77WBjr5+Q3aZl8hE4HNW0mXXTEkcrUfadvKbzDieHuuMLJOaPTC?=
 =?us-ascii?Q?JouXuozeRMXv7NZahafcWdQQUqdfQ3yj/9a4+92CbBk9+c2FTNfTLeg2gFgr?=
 =?us-ascii?Q?VUjJJRkCrf0XHS/5e7CW8/WoKtIyuM6N9jcavYV1foSGNNgYeUkI+llF8TmW?=
 =?us-ascii?Q?q7DFAjeEz9cDg1cBrCakYAmYea9sgHNIbR3dfHYL9V9zFgUZNAKhStYT3uyL?=
 =?us-ascii?Q?RNr0Ggm/zn8LRBQbn5gIGMF2Oen10hf1ngC+Q1Tw8wGPQ4Ba3/bNJEx1gs4O?=
 =?us-ascii?Q?ovR9afFdsuGcPOAPzJ9kZsnXtz0ECdr87EoHazn8s8rRnuSE1SBdD8KSJFH/?=
 =?us-ascii?Q?k6hkZb1dvHnrO99Vm/xBuyY2jYCr21Y6qhVgSG5844mL3ZzY1TGe6stkKiwN?=
 =?us-ascii?Q?MLRNpF8NvnACyYFtyb3G6LrixiuG2rVnBbbt/XcyhUfL7tQlOpTFzx9u+iTg?=
 =?us-ascii?Q?JrwrPD/Vh+m36tND0To3G8vmmkpAvz2/b5Xq4YS6+WB5/0bkLkk8LdmVt3Kl?=
 =?us-ascii?Q?9/2O3MoSebq36kIQcTr+UrUmYRRY2AxwcpdWNFGy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f6cb85-56b7-4827-0b62-08dcf9c0db76
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 15:29:49.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGJbtf3iQhHL6KEERcpbjiSVycOeYkgbNzcbKdAfWIRyqpE10BsoQQ6p7r45zmRjK/VIs4Mm8/+HrmMFEBByvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901

On Thu, Oct 31, 2024 at 12:20:27PM +0100, Borislav Petkov wrote:
> On Wed, Oct 23, 2024 at 05:21:40PM +0000, Yazen Ghannam wrote:
> > The "root" device search was introduced to support SMN access for Zen
> > systems. This device represents a PCIe root complex. It is not the
> > same as the "CPU/node" devices found at slots 0x18-0x1F.
> > 
> > There may be multiple PCIe root complexes within an AMD node. Such is
> > the case with server or HEDT systems, etc. Therefore it is not enough to
> 
> HEDT?
>

Sorry, forgot to spell it: High-end Desktop.

> ...
> 
> > +struct pci_dev *amd_node_get_root(u16 node)
> > +{
> > +	struct pci_dev *df_f0 __free(pci_dev_put) = NULL;
> > +	struct pci_dev *root;
> > +	u16 cntl_off;
> > +	u8 bus;
> > +
> > +	if (!boot_cpu_has(X86_FEATURE_ZEN))
> 
> check_for_deprecated_apis: WARNING: arch/x86/kernel/amd_node.c:67: Do not use boot_cpu_has() - use cpu_feature_enabled() instead
>

Ack.

Thanks,
Yazen

