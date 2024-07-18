Return-Path: <linux-pci+bounces-10519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E5A935015
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5EC28244B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F58A144307;
	Thu, 18 Jul 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5djuvA9V"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312E1442E8;
	Thu, 18 Jul 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317417; cv=fail; b=aZfXY15Q5lVJzQQDpkTy4E4B2pXUsdB5BPgMEsgkAibiq3RFt0OfHENqEbeqHKEFn1BiGIfpfu+QgSREvvvZxc068tAiWX3Z7JSYnIMWGkqcJ4vvlhHwnDK0+WeJgw+GE4OHyqK0UJ4wYdNMr0t4g006JOdW4EEoaoJ81s61wd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317417; c=relaxed/simple;
	bh=mZuITfHOAPcJxNe1a6rlUQ86+GHxjSkvibGN5Y4aWOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PQ08bZSdE/qWwo0RCFdVjXZRCVRPO68vUUzhMXdPi5cEQnD5e7PTrq0iTiCuehI3sjFoUa1bp+Pn83tHbUNZHOf8WR9FuowY3fi+wMaLyzoWar6H7tFcNxRtS1sPCNUVXPfVWZvjRyAMRah79j1ql97rHd37mqWDyFD//8XPtss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5djuvA9V; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGpmpbMtdaS4thWfo+JKVjQdh+cVubAqrXvw4pzffcQMW/iPLrzmo3153snduv4uCNOE1Q4/LsFm+XNTPwc8J8/J7v5U5dyol0fHBVNDx8ufaK3HgVq2rQh6svSPPCPByvISU1W7avdrT2TZw0/wS7+2zxbk3ExAMDwkFpKZtD1SDj2Oa1Ben/5n0aR6Hb8AQ1P3Mg6PZaequniQnyAul3h4UtD9KQz9GWG3UUGRhd34vRKpqBKPoQsINilrJ64VWpMBtlk47J7AxjiwZaeq86PktlLqDPLA5ZcmrWtl8bgp3VW2BboqZsizpaXf/WoHw933Le9wDEmY7oZKaIQoyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRs8TrUvjfbo0fiPnol/a0GSDQo/JjNKDx0MLNoGg18=;
 b=Tk3siYYpFMfCGsX4iiqg3cUBNCk/lvU5czkzqYSMljWtEusUUr7QJWtiBXaso5MOJcEe+hmnNr2LxLhXc9/pqbF2kAKOUo/kGOrMZFaesvxqQuCHXICn6cz8xjswqbyAWz1oYZUmLES6sq6z//1w+jhb4tcXaO7EoR3URqZWTJNvwIv8KQJGHcJysVnl1YaetK3D6prtvkheUAN4iUsPllloN8b1Wxn2lyVMQjmKq8plazoW/wRxlVwPT/dwE5pyzcWZWjk2+9zq8zodQVu2X3I6mrFjviw4naGraQf3c/QqqQ5Z+G6WVx2veQIkvHVcY1jtxwbkMZlc0tMg1FYadA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRs8TrUvjfbo0fiPnol/a0GSDQo/JjNKDx0MLNoGg18=;
 b=5djuvA9VpgcpTauFESbTSZZWqNwTJpRj1ZHndLQKKVnSqDnyP5gIK+m2H8Z+3CN2/TI7wpSlExErafUxGImIqtNCWtHWiysl7hbbh5iCTBQ3xkbxGEeKPgyx0c8YEdH3F3l80VQYPEWRySmUBa1gw60KoGD9BcQoEZPbfBAz8g8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM4PR12MB5891.namprd12.prod.outlook.com (2603:10b6:8:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 15:43:32 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7784.013; Thu, 18 Jul 2024
 15:43:32 +0000
Date: Thu, 18 Jul 2024 11:43:23 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Anvin <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	Avadhut Naik <Avadhut.Naik@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v1] x86/amd_nb: Add new PCI IDs for AMD family 0x1a model
 60h
Message-ID: <20240718154323.GA54785@yaz-khff2.amd.com>
References: <20240718140258.3425851-1-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718140258.3425851-1-Shyam-sundar.S-k@amd.com>
X-ClientProxiedBy: DM6PR02CA0150.namprd02.prod.outlook.com
 (2603:10b6:5:332::17) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DM4PR12MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 7828d2a6-8c47-41a7-9137-08dca7406080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sy6DiJ+PGDJ0Y+ezPiuuuIqhv9oGrT/j0a6JOtRTDUcuqVnsdtfj/ciqkv2Z?=
 =?us-ascii?Q?Sj89ivXtn/ZEVEitlNOZDyOqyDeW7zekpwEeMprE4rmvwsot9V6JyuofNKzz?=
 =?us-ascii?Q?VWundF18eVmKJ1hsRJME4lnYMTtRh/BwrNHztNdCQ30WWmIThF40cIOfW4es?=
 =?us-ascii?Q?JrYEntIwsIaUCF2kSBb+IXIPUQNnw3/EqMjXDcBJo/0VlBiXHaZRLTNopZGL?=
 =?us-ascii?Q?0OPl/y8bZ7kCz6yVcYWbswbxdetibGDzkkFBpRM0NrfSoXVHwLizMQHWvUPH?=
 =?us-ascii?Q?6HZus2vfDYSWnqzRTHsqfvgOA3IJg5/BJUlBVJcQfJm6GFqLxzBX9e3gGUJX?=
 =?us-ascii?Q?i7Sq2/bUjJe+0AgLAOWAkpRyPot2jSZuBZHaPmgirT5faLfjQpHh7p7dW9WE?=
 =?us-ascii?Q?3GdCKAbFQNltetzPPMrXQ1z8qlOdFPRAkxpU4O6KRuMQGhr0gZgMWsP7YOEj?=
 =?us-ascii?Q?yTCmzb6qIzLuGmWOJ9kfw9YOPvGb7Px/G7pHiNFRzLrmVz+3YY3mRme1OM+t?=
 =?us-ascii?Q?37/FhT9cgDkY8hXhkRvIPK0Mw1EjIWDIhvlsa2N+9+dBToVFP4gmpV9eU/ik?=
 =?us-ascii?Q?KhNlLK45+meE510EPhGYzQ4DzjtcfWfiXJrOv66MhnK5rKZkxNbycqiDSRG/?=
 =?us-ascii?Q?n0Bdy8h3+GXAxX14yT7b3epE1tKjqYadIz3+kN4///xEwI27KTZqGpOGRtbd?=
 =?us-ascii?Q?RpJCFgTuwY+3E9F4QzKIZ3dXKl14byg+IMovlFeyfaCRx7DehyDyDyirdwdT?=
 =?us-ascii?Q?FwZnVc+GaNVxIUPOrsJ4WBuGjcvF/6iItsS+BmeXvwGRghICjRZSzrsalPOr?=
 =?us-ascii?Q?4jGQWYYmgLjlWBuCFE19x1tized9eF/zfFoS57NsnmChhk67OrTJ9GmSRIm0?=
 =?us-ascii?Q?FtotvQu53cOwE/eOdonh8Z6IAg6P7Z8k7CPVJSj/u0UJwWdudinZQOkn2DhI?=
 =?us-ascii?Q?jwpeeiIYps2txxJniXpqXwgCsALxVg8HaVMb2pFK7wfoIAW7vO6XFxsxF0Gh?=
 =?us-ascii?Q?CmzA5fNq9cnxetKW+3kdZ+iVf2ZS3TBgbGGMaxZy1xvEqnIlkjLBub5gnBWf?=
 =?us-ascii?Q?0kMJeiKqAWWl52yMuBMP3p2kHoAGQbb9ycr7OIi++TiGBfRWrkJ3tIcsB4Pw?=
 =?us-ascii?Q?/LNfQYwJgRcQ3PPiYzCZVP4r5MAP/5DNTrIgR+i3xkIkJvY1ARbgqKGmz6Aq?=
 =?us-ascii?Q?A0Q28VyviKaEawJuWPf/kcRyrpCasB9xi5vAl4s1d83kddLL4szxWOsvjo8v?=
 =?us-ascii?Q?7QJdQkHnYq8QqxpKizGk8d4GObjposzf02kwdc/5PQToxZgKxdLdzb4+GzXM?=
 =?us-ascii?Q?JHfTHpPY40DzhD8kY7hivTrp2lN9BACHIB8nOrIj7FMndQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AIBSadtspfU4RrwtQv6MzFDunJSmVTsT2WZNab+xn1Z3qpx26yxeCg/+T0lD?=
 =?us-ascii?Q?ftUqlnHIUpRPaMxyiiqBK1mBgHFDpOVOg3P2qi1PSXFmAARySvw2QoR/SQoh?=
 =?us-ascii?Q?lrq9n928kbUBGY3Z3+71EnaX+FAjC4FkcupWyAG1jOrCqg1OK5kiT+qMr3v8?=
 =?us-ascii?Q?e90cO/LnhpwBFtSqc2cF2FXcgqUhFnivsQtlixre0OMpa8dUaS0cn+0Y8rtp?=
 =?us-ascii?Q?v9GiOyP/ChXpQuYEhe9Swei+Rd0ZIWFExzeujCY5hvXWOrEdI0C0c6wNtuuw?=
 =?us-ascii?Q?O1Hhvd2PPH3XLVl0CoaEFzW44//UMV6BeL2NSPipoA0fYoRqM3or/bYm3W45?=
 =?us-ascii?Q?zhJA/ei1e9IVWuesTT9Rpj+pgF/pzMXPXbXhKXZo9RRtkSpHbTy5Cmy9Neo/?=
 =?us-ascii?Q?rdU05zlKw7ze/S/0pI2rOIMfwrZPa1ru3L8H/Ed05P7+7gJKHtCDwOSeghAB?=
 =?us-ascii?Q?Xb0E2lA7MX1tGMrcP1OO3z+STjrt5DtRRJgajNAFeA9UH+DMA1M3bvjn6bXc?=
 =?us-ascii?Q?DX5hsQIGCyEzkk+ewJX1tL4g8Xa5bBbZ3N6NAGQCkREymiIJMo0erJagwu1R?=
 =?us-ascii?Q?ziNf5EvOvqeqqtpbjQT1tnH5BtUSx/5mb6kLNhSA1exjZrAsNfM1IkzubQlD?=
 =?us-ascii?Q?g4aJ4b82Kb0l3ml3Rz1L08N+0D9svq9J2xeWgzhXIFuOgy1THHIzi0VNpho4?=
 =?us-ascii?Q?5vr06YKa+kmTWV3FYIsC2YORug8Nc+rJ5fZHUtxoJA7emq/0Sywp4V+AqOV+?=
 =?us-ascii?Q?9I1ilQ7CSdn5+D9j29JGDnpRKr0ieoD1wOoFm/Tm5xyGm6iMoHNrJETvMnu1?=
 =?us-ascii?Q?rtZMgk00sVbJvyMdGtHZ0ZbZNozPXepbVTliOUyW8v0iqwB2GLHIXcqhDSAy?=
 =?us-ascii?Q?/KLkozSzVrDUqD07IiUOsQ28I+2s8ouTltCgYMklx3b7I4ZjrsIPa34zqwuY?=
 =?us-ascii?Q?Bg0bSNBVPiveXAGKUKeXHH6t2b62TYf9J4wqxKhPW5Biab07wP+lpqogleMc?=
 =?us-ascii?Q?rQIygvTSbvEoDdP1jPQOUoUJ5k1mpRAEZ3+w7ojimXE/UiX4cr23S5duD4Lg?=
 =?us-ascii?Q?bHyp3vwJ9OeG770rr7QnFkGOb0xpo4yXeZTkMusyjOaTUaD4mViSNYujeAqO?=
 =?us-ascii?Q?vssNzHRy+hYgaojLHw0N0un+P22Ohczukv/wdJdZ3L/hGwJQ4lO7ryHQeHz0?=
 =?us-ascii?Q?Tas765die5vDjiBTDccI+pDFzIWPDxhcUpcNDbg0SMtn3hzH4hE5QmgvSCTQ?=
 =?us-ascii?Q?Og5gfLgdihBWRePUHODjp8wlX6qTFnejeydHDBw94323hTTbbUl2V05OUfUp?=
 =?us-ascii?Q?+XKaBdzTCwMuHZ6IfhjiMZzQk99ROvIQp7HMVfwYf4g2NHd+iFlwrrigdHtD?=
 =?us-ascii?Q?CYGvnGGMv+D4dRR0CJDoRKKtuRCtxDEMwOYvUWNOtABTQCFi3klVO6/MMbm1?=
 =?us-ascii?Q?gUlbL9L4MVhZgErjnXQeeyyzm2HB5yRcnUTHIM9tmE91I6nP6uocjq3LzzTV?=
 =?us-ascii?Q?gfcFEvjAD1ifY/cQo/X+BKgR83hjR+ye/Eg8uA7jjneL3L61bL2xogqOXoA0?=
 =?us-ascii?Q?jwSdpp6fP0uqNST2rWgr8PxE7ptNWuDgiujAMwMy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7828d2a6-8c47-41a7-9137-08dca7406080
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 15:43:32.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: helz8bZBWdx5qQqXfwokH2fxQYbp2OAHtPf+iKzgDCx/QS8l7SVaHrv8t3yz/aj8k7eTt5Ila2uzZ7jnY3I1QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5891

On Thu, Jul 18, 2024 at 07:32:58PM +0530, Shyam Sundar S K wrote:
> Add the new PCI Device IDs to the root IDs and misc ids list to support
> new generation of AMD 1Ah family 60h Models of processors.

Please be consistent with formatting.

"Device" -> "device"

"misc ids" -> "misc IDs" 

"Models" -> "models"

Also, you have "0x1A"  in the $SUBJECT, but you have "1Ah" in the commit
message. I suggest staying with "1Ah" as that is the format used in AMD
documentation.

And "v1" is not necessary in the "[PATCH]" prefix.

Furthermore, if you CC the "x86" alias, then you don't need to CC the
individual x86 maintainers.

> 
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
> (As the amd_nb functions are used by PMC and PMF drivers, without these IDs
> being present AMD PMF/PMC probe shall fail.)

This comment can go in the commit message. Otherwise, it'll be lost from
the git history.

The comment is helpful in that it gives a reason *why* these new IDs are
needed.

> 
>  arch/x86/kernel/amd_nb.c | 3 +++
>  include/linux/pci_ids.h  | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 059e5c16af05..61eadde08511 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -26,6 +26,7 @@
>  #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
>  #define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
>  #define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
> +#define PCI_DEVICE_ID_AMD_1AH_M60H_ROOT		0x1122
>  #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
>  #define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
>  
> @@ -63,6 +64,7 @@ static const struct pci_device_id amd_root_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_ROOT) },
>  	{}
> @@ -95,6 +97,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 76a8f2d6bd64..bbe8f3dfa813 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -580,6 +580,7 @@
>  #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
>  #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
>  #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
> +#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
>  #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
>  #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
>  #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
> -- 

I can confirm that the IDs are correct.

Besides the formatting issues, this looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

