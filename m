Return-Path: <linux-pci+bounces-10551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DDD937919
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 16:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 413F6B228EA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 14:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6EC13A899;
	Fri, 19 Jul 2024 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R8B6vzo9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE36383AE;
	Fri, 19 Jul 2024 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398754; cv=fail; b=ZG90dTtuJvSoiLMRwXR6idEhd67Afalhgh2AWb/RAqypjHBD+OhkG8819vUzRw7+xX2kDHZk5ZZdh4N1CH3EnXEW/RwK1JmO7wCM7zqiasZMGfOPPVqWUM6uu6PexzCLzctdT1bvjUH5JKKjtTdnbAA75edGXrj6vCUDJJDDHLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398754; c=relaxed/simple;
	bh=ieXttfR1nelNHd3lJQm77c1HzXC8TWpvA9cnL0jD3UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DhQZjGoNwJwv4ZqXwTKO1O1r5jC58KcD26CihN58/HkaiIFKksBiZLj/U9DnbpQYafpcqK9Up7q5g8dTNLvGrA+rMMtQAjBV5ZJaP7vWDnuK0YxZCYxL7z45eEoEOOUWolDlKk5DAYQc3QIkHkvtQFZX77M6G/cZFu86M6gW3dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R8B6vzo9; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwjFGYRqaXqnZw2NZTRA80ZyjEXM9yeXW15xbmsgEMADGyBSRA5nFqzJtYtJBw+pZF20Are+whYrs2BlvPORx6WG9pdYItWGpKnjgz/gE/vJrjVoQ6ara6i4umt5qmAUOP4r3LXNGMuocLZnJi/WJodOFiOQ+0ukg5E+3QspHYOpvI8L5U/U6UmTdkVjKWawfgQTxr0paVuFjmXsutJjQ2bzw3R6PQaZm43QHqo0WCUJbg195E4aC8DGdU2GlHoVLnkRNGs4dC37fnnCtYwjpwaXNM3HLorNgn6PgKS+/ev4VCkjqRlHhWxjWnZCjWRl2bWxDh1jCZBc9Oh0wuAkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFYtE+i0R8SUKcdfzr/lEZM6Ina2rSgRWFiMn2gnNXA=;
 b=xQr2wUmL0EzASNv5qAlyMRSf5arpdk9ycS5OQcOEC3JCb2C5D49UqF2h+YVgCI1jP0+d8H0+eeUvQbXqtm8/JAewwctQhMsyutK26qBwMfIzfHpCICaF3hObYK0XwrWcsiDvIImzcvrNVZznc88F//rFLBaRB843sjAv5FJ7AOhM4xt2ZeVhdUJz0JgrBw/autglSiEv7eBlP+C9dE/Q7+tdkSwVeIwTlz0z8P2RpxClJemekuovpJ3qwLmxNRpMCVN+USr+PFqNSax6zOOW7EcTOgLnV6s3lnPOqIqt/2bJtTUmqlw2s5UMfGxE4gs8+lr+2y1xxZIQU8YNi3f/lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFYtE+i0R8SUKcdfzr/lEZM6Ina2rSgRWFiMn2gnNXA=;
 b=R8B6vzo9bHLtqijJG8uK6yC9Xfuc01LfL0UFfqiX/i0IM5I8UoXqObaWqUT+ItMI+ainnsF505DW6f/xerHYGZAmakANP46kej74VuLjFlHvEcdGDmxQLJqF2mDFVkNOnE0dEHzzZDgLo80BSYHAzf9qfQRErNgZ9G58iUjCjmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Fri, 19 Jul
 2024 14:19:06 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 14:19:06 +0000
Date: Fri, 19 Jul 2024 10:18:56 -0400
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
Message-ID: <20240719141856.GA17507@yaz-khff2.amd.com>
References: <20240718140258.3425851-1-Shyam-sundar.S-k@amd.com>
 <20240718154323.GA54785@yaz-khff2.amd.com>
 <e4e59c9d-a44e-4b19-bec0-c7f7bdc808e4@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4e59c9d-a44e-4b19-bec0-c7f7bdc808e4@amd.com>
X-ClientProxiedBy: BN9PR03CA0764.namprd03.prod.outlook.com
 (2603:10b6:408:13a::19) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: ed013702-4a09-49f0-3f56-08dca7fdbded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uxqAr8MgibKdS+ZyNR19pLVaTz6Y/PdcHYBs2RN/KsszifhBSaKh/Wa0LU4x?=
 =?us-ascii?Q?TzOWC10MeiPY6QBZubUOOL92scjRONBDeMHnODEm/Ej2hmH0E7ECUaoLgfRl?=
 =?us-ascii?Q?+yNd8tjACs6UFDWNnVNuVLpu85lSld+dqfpmHdAs5NcwMxDkcK41WL5IEHA4?=
 =?us-ascii?Q?BlkgaxqZ+bz/vItBPT8HXKLk07T1PSWCSbz3ViPbrrkBJ1CW5BGR9hpw+XDh?=
 =?us-ascii?Q?qbHKrH5HTrTBIvgFzF75t54TE3tbhSkBxuTIZQ3/PDi8KrIQR/xPUPzqAtAp?=
 =?us-ascii?Q?VJ7Ccy5xCSuIM1M+L468puOfEUByilSjq3uaQJUcxC7s37UQevofPpsFtEld?=
 =?us-ascii?Q?nLFu23PuaXR48+4XjxtGibkhC6Sl9KDzqrf51/WCSjUhLNMtIJq/4e3gYLU5?=
 =?us-ascii?Q?IF6/IaSHG0MdD+sa1cuxNvVqJB3UIGGYA28P9hhFIQqMcoyg19iSE76pFCly?=
 =?us-ascii?Q?HkOvIzQSY9mRxDQjEfPDDkuko4H5PNvWHABgNyl54PnOJ0Jwz+/63ZVhaVkv?=
 =?us-ascii?Q?m6PQmu+APh6Nlc15CWNc1bgPjyGOhxs2tzLwOqqvJH/ahvTpzN9f9gNDh/Nl?=
 =?us-ascii?Q?ptcX4puX69/2TH0FrKe6AwUAtLJqFK6LhwWM/QqXwnRaifvQP6BcnhUuKyTi?=
 =?us-ascii?Q?DygeBK3xf5fHJOFo8rac2b00BcicQezsb316emxr81wDE9d5tML5ISefAL4c?=
 =?us-ascii?Q?y2f3slgcqRzGgrF5wLmQafe5P5SrNmrT1hnlw8uqWJ5AFWlKvKzrhmaR/iHg?=
 =?us-ascii?Q?O+zQ0zr72n2LJyYLmOSekQTkZ4yQLxfCBnJa1Y284twJ9utQ5Cot5zx6J/9i?=
 =?us-ascii?Q?S7hGAyCSuG3nefGidw9lDjJH7VgdVZrN5z9ozQzuSEbFVEP+1z3cYARRfTjy?=
 =?us-ascii?Q?i/PXlXA8sbHodppDfYImliePy+DnFLFKuFPwTig6UQ28hsy5Kbi9yeINfx/x?=
 =?us-ascii?Q?JSwieiO5Mk+P8pr9OjMVglfad7Ty1SrWwTaDFTKMCH7wUst04tV64g1o8BmS?=
 =?us-ascii?Q?SOpnYOpiPHVGYMfg0VQqeoS5p02Icj1QU7On5YBDKVsUh/4HXcdLJjjdnNQx?=
 =?us-ascii?Q?k0+ZKB5Os0h/1K9CLzq9B8+oYcHjUViF9iDczc1NfVX8v/FSGO/270BSJUKu?=
 =?us-ascii?Q?TS1lFgtMvfvZ8R1YWTKZr4TZYtSd+cI+viwdSPP97xz/Yi4y1gxZiGg2RFm2?=
 =?us-ascii?Q?IdYmmk6zrd13fatiJgHbqk7jW0VWPHBMNWAX8v8IF3lK64osRQkknoHU4xvv?=
 =?us-ascii?Q?XzqAwdRtYPh+ybmWCCptvzndwXjhB/jh4D5IL7IzL1iPmo+isVkfN0PmP+rx?=
 =?us-ascii?Q?iA8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZoppmZvAgoQ5Lo8jbadHUe8vxJGt6mE5aFN2DEZ7AK80dI3lVxjYqu6b9vCC?=
 =?us-ascii?Q?X/2UjBVbgwwtgpEPq53+f8JubwW+YN/c7EJ4qHfR+YPALxokH7w6J/Uw5Ru/?=
 =?us-ascii?Q?e0s9wRxkz+JA7tRp5wNNNyiF5BjE/cLqRHXMfuPP2D8nySpBCwHlWci0zb9J?=
 =?us-ascii?Q?KVWcsFbIJjRcfzaOYWuSIeTlmQgcqVRuc/zdNPU/CI2QK/smYEaBHjkpw+Yq?=
 =?us-ascii?Q?u32nvaPU6LViBG508B6SgURhxnX1LQI+2BPhcWohKPrgG7JYbPB41zpEEVmT?=
 =?us-ascii?Q?wO69ZmmWJhgBAITk1sL9/SCfd7hoPL0ZPBm9ZSh1P17FbFZIwhyU1F7pHPWq?=
 =?us-ascii?Q?EmfcHXrMdMISsuqO/GG6ek3/v7q/zI+jI3InVfYkJv+HbRyEC0ubdaJLtyZX?=
 =?us-ascii?Q?OFfQDWtjoP88dEvHvji0K84WGkaTZFaTVLFyGcA9rRZRGlYrHMkezZg2Erdf?=
 =?us-ascii?Q?XaO7EgDzN1/OcZjTUZ0w2tAHbD+yM9ae/zt0saIPo3vcOXQS5T2PYuzAeMa5?=
 =?us-ascii?Q?x49yfiOZtoYjuD6+ptPBHNXHgjzuwnwhpjfGl4qNckWdf4D0r5wcl4WYi4mM?=
 =?us-ascii?Q?t6IA9YX0UJJwRfyR3PLCdKBF2HfdpHDeGSNCS0PwE/BtSxIULV96u7avWLFG?=
 =?us-ascii?Q?ti0rGmuL7eYzSMqcAsT0lAQmGNxg9oeDCxfDbSX/8o+H9+ttxXuPG31Pe6Lf?=
 =?us-ascii?Q?rEGbG2BK2GNWcRarlV5oFP63mKHHr4WK6YhhxZhAYW8aOt4VkEVZvgTGO+6X?=
 =?us-ascii?Q?0qX5xqVZgBucwdkyEcEJWabTgOfFMAObhhBrIACGq0do/5n6ybsAoSD4aAIM?=
 =?us-ascii?Q?cPnsZASGzWZIE/Shx2Z5D6S25OL+M0bmeoa8dWC5jCkqRUeGFaU1w29eF944?=
 =?us-ascii?Q?5mnOmmtz8bxAyJT8qvPMWdK0WgwQtj8oHXQkLGyClnqh+180ItSXPZ45Cw9E?=
 =?us-ascii?Q?nEEyBXdNNHmO8SlBEVVsTaf9ScBqrIomI+3IGIpHUPKo+F2+dqeak0J6Vr5a?=
 =?us-ascii?Q?urAn5Ap8YRulJyl6CmByXhPgmbeQPhuYMaZ7si2RDWhNMOsOuNmft6MMRPqJ?=
 =?us-ascii?Q?7O5QpIoK/Xh85ssT7+3LgFdqtoCh9T4MPQOvp42Mk9iXwjfMaP7OXZfprmAb?=
 =?us-ascii?Q?i6PN+Aj8l1oyMb5d4mK9B56Ze0mWih0eRz8/uGoEH9788IiM3JaAss9FmkD9?=
 =?us-ascii?Q?tpUaubJFzVScMHist4kjJ5JGGCn7SSO42wuQpALCkwyukf0coxqSvqSl8zge?=
 =?us-ascii?Q?i9Zo7aKpebvPYMZbFzvG7csxTDO4/1S0e9cUO18OkKURTyt8YyWhhEUPIJ+H?=
 =?us-ascii?Q?Nfq+O9gMMysgsAjOgjdKOlNgLFMwv/1m9qNZrLVYfmI0Bb4ICrz8WxjHSMR/?=
 =?us-ascii?Q?F702DaOUruN4C6iz6EHytK7ZtL777uCbFx0Xe8dXJc64vcFAU+sT5DSiDcUj?=
 =?us-ascii?Q?T514icsFVUYuYz8PLFadTM0x2hqnqGjLCpViVTLHTma/EVrINcnLalbV5i8Z?=
 =?us-ascii?Q?rjinJde0UrObSmIUUzheC7JcaLFCPUk2rtljwbicsWIeh5ZGoA+cxsPkLDLK?=
 =?us-ascii?Q?0pB4/dOEaewKFUt2SLj4EwZw5oln+Z1r38Gul+1X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed013702-4a09-49f0-3f56-08dca7fdbded
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 14:19:06.3017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGoImos/apu7OWOg9pLOlH6niGACfCEnLrXsgIgw8SchfIglhLDxPWwAqY3dRmk3I631V0u64dK0C0pOCNOs2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715

On Thu, Jul 18, 2024 at 10:19:47PM +0530, Shyam Sundar S K wrote:
> 
> 
> On 7/18/2024 21:13, Yazen Ghannam wrote:
> > On Thu, Jul 18, 2024 at 07:32:58PM +0530, Shyam Sundar S K wrote:
> >> Add the new PCI Device IDs to the root IDs and misc ids list to support
> >> new generation of AMD 1Ah family 60h Models of processors.
> > 
> > Please be consistent with formatting.
> > 
> > "Device" -> "device"
> > 
> > "misc ids" -> "misc IDs" 
> > 
> > "Models" -> "models"
> > 
> > Also, you have "0x1A"  in the $SUBJECT, but you have "1Ah" in the commit
> > message. I suggest staying with "1Ah" as that is the format used in AMD
> > documentation.
> > 
> > And "v1" is not necessary in the "[PATCH]" prefix.
> > 
> > Furthermore, if you CC the "x86" alias, then you don't need to CC the
> > individual x86 maintainers.
> 
> I used get_maintainer.pl to send it. I can remove individual names and
> send it only to the x86 maintainers.
> 

Understood. I think this only applies to those who are listed as
maintainers: "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)"

They are already included by "x86@kernel.org", so copying them
individually is redundant. At least, that is the feedback I have
received previously.

For reference, please see "x86 architecture" here:
https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

> > 
> >>
> >> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> >> ---
> >> (As the amd_nb functions are used by PMC and PMF drivers, without these IDs
> >> being present AMD PMF/PMC probe shall fail.)
> > 
> > This comment can go in the commit message. Otherwise, it'll be lost from
> > the git history.
> > 
> > The comment is helpful in that it gives a reason *why* these new IDs are
> > needed.
> > 
> 
> My previous commit 0e640f0a47d8 ("x86/amd_nb: Add new PCI IDs for AMD
> family 0x1a") included this note in the commit message, but Boris had
> to trim it. Therefore, I excluded it this time.
> 
> Should I include or exclude this note?
>

I see. In that case, you can exclude the note unless there is more
feedback from others.

Thanks,
Yazen

