Return-Path: <linux-pci+bounces-16048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813CA9BCFE5
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 15:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117301F233D7
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2CA1D90DD;
	Tue,  5 Nov 2024 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IOvJ2eZC"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721AEAD2;
	Tue,  5 Nov 2024 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818717; cv=fail; b=Bpd/GqDvJf0DxTjvKtymmQthD+j1Aq+evl+TAek0cqWZ6paOiKmw0qoYNfVnQK+xOkZEnZQaYpN9iXjQRm4tbHOPjbrBowTyaArq1O3HT6enlfN4oxa3jVRb1tb0Pwn0YxmLIWv2pSxXFIibR8Qqn6FGwSTqY5U/B396ZVKEz0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818717; c=relaxed/simple;
	bh=1fJ6e0hBi0ZzEiQmwYy2gGDlLblOd566hhtlHvvBskw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b5XF1sI+Flz/r07zmcF2xOG3bACsHDlWsSheU8X3/OYZR6lpHgT68kMvb2HIT4RkPW1zh9/pyUWbygPFhp+NNMY2nyNMDzzOqD5kiEM/iXkwrI4MDILG6BvuGa8IqmDMBGJkh3IVsB/5BveKSFBOYfx/UyxIkJh5xukpurzz2iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IOvJ2eZC; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJdLbZNISTS4mkTk6G1qHt4WjpjgElm+mB12v+UkEMmvdzUrZFhEXWZ1EDWNPDBj7Ytphh/+vyMH5ZuJIbt2Q24i+pHyjTJWA76kIR94EFoSXEUZU9ZWSuCRJFLf9LAyonZA0YYb5KZK49+0ax6zy5z0zlKyN2juJnGdEysr3LiKbGHaCxv9Q4ZnryEXLRdFGp06FzSoNHQYjC4U+U3hrsuV6bxZpGoXqSZAHJk4tfSbSDeO0LdnPs1Q4fCWntmEv/E+pqhcVGU3e8E1f1ccQRkzavHzcHqOHewQ/EikU2CcIm1oCPNSdhBRCRGm4DXbnqNBjt9q2ffdwrI2YjSWfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMyHhxbfzPRBaXJHZPxePdcKiKlggMK3STYuEK/LSZg=;
 b=kkwUyPrMPTaSWLT7D8AyXP7KatIfm2XLHiEFrx8691TwfBGrJ11Yel0Xmrlf6JyCb2H+VHcKKbDDV9JU3VXoNwbBo4J47KNzsVJ+njvhZ9MT8x6agnbRMel84i4ndsXIrPYP3nHicet+cbZGtIMZOtCHXeuDxMhU1/CiokFdgikzlkwA5xwiF6/lrB80Bh2Gms+qyJYsRhROSxu11aDgTqib3fUUa0J+FPGDou/uMiS6Vh9HITe7o7BCNv24tBEDe5ypuWjf/mzFlJmRtrD5VbfbK6gMWU48D8Y6tXzSgjS54q7cOeOLNdkx9TsHgOwJcu3fvSKAu/qeBsMkOyYp5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMyHhxbfzPRBaXJHZPxePdcKiKlggMK3STYuEK/LSZg=;
 b=IOvJ2eZCOHP9AaWfuRarTzFkQnbbbhgJpc+y/9Z8SwP2HS4rPzSYVqH3u9/pjfulkO0+kJKUKiRi6rM0ZQ8Q+9epAKRPlYyfDWsXWLG5th5jJcaC8lzbyzPVDMz08ApCTWKKKs5eXj0o257yPPUGxRVxl0SNo/RvstwJw2U6cRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Tue, 5 Nov 2024 14:58:32 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 14:58:31 +0000
Date: Tue, 5 Nov 2024 09:58:26 -0500
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
Subject: Re: [PATCH 10/16] x86/amd_nb: Move SMN access code to a new amd_smn
 driver
Message-ID: <20241105145826.GC916505@yaz-khff2.amd.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-11-yazen.ghannam@amd.com>
 <20241104142958.GVZyjaZtONnLIJAUo7@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104142958.GVZyjaZtONnLIJAUo7@fat_crate.local>
X-ClientProxiedBy: BN1PR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:408:e3::33) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|BY5PR12MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf4b250-a73b-480e-2401-08dcfdaa5044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jVlWtXAWROqnV6yJzgiiBFyqZoKlNwNC5aPYh9t7g9pXliy4o/8zUhNGGf3L?=
 =?us-ascii?Q?8thVJlbPTMlKuf2Di5j+Z6wNMyY9AMHQEn0TxCVca6gRAQPokAJZAKXQDBv8?=
 =?us-ascii?Q?0nk82eZ8MECnGuNRYmTVRj2+zx31qsI+S3cVPvjYyha1jM4Jjti0Vrt4slEU?=
 =?us-ascii?Q?5cE0auI/t/epfX7Fn/YFces2eL1KVk5A4F9bHRHSY+ONMtnHHAQ63UwB+o5x?=
 =?us-ascii?Q?ZbgQjxRUVe4l1IvAVRJUJNtvaFMZSI62mN1Omw+qMpMdumh0O3+L3nyuEBvR?=
 =?us-ascii?Q?cFTsdKt2+HQuKmxRWrT1wWYPbKphb6U07XJr21K1NBW3Ci1PHD/ar44LRSNl?=
 =?us-ascii?Q?zZpv8iRzQUg0r0YeukY5sxTl0OFucRepqn2Y87NSBXafAnyxt5kSTCAm5f37?=
 =?us-ascii?Q?6kHG+ZVYV9AmB4/m2+fjCzk/TkdjIrczW4GF6qDbHjqakzuzrDEzdBdmbePy?=
 =?us-ascii?Q?v3+3fA3Jc4+NhOZ/gyH0/0gY3mWDuXwxs3idiuWxjcRlTn541AJvRD5hHWA/?=
 =?us-ascii?Q?iUf7V+mMtROO7S/NIHXwuXlvmyQx7n+0vLPdiUsyczdL6lsDLyAJa/yEYA3P?=
 =?us-ascii?Q?QFJmiLpotoIl8M7yVtqMNgogLb4Kiilk9zt1v9P6C/zQvC//wmnh1EUjOALl?=
 =?us-ascii?Q?0Tgg7Oo8Qch1LMB1SRInciQAvVGn1JRN7oh7nMwhIgq5o9Vo77iikfLFeTWm?=
 =?us-ascii?Q?2Ar1MUrMs9N9pgl9BAeTrIQSl6yJhaPcIdNqFMZkvvmZHtx1b6kaeET6De2G?=
 =?us-ascii?Q?StAiEtQXu763HFpn8UPJdpyvnCmfOoU4xbOPm5JByuTK9aD9qo9uwmnjehzT?=
 =?us-ascii?Q?FiDZytSsW9M/+icF+4EEDZo+rE/LB+JfQ13xfan8VEytqN7KcehY1XRkwkQv?=
 =?us-ascii?Q?e2OV/N6V0eLKFE3hijYTWnjwzeUBcmm6a0iaXsRH+U2oGxisKQ3CPJS6B5DR?=
 =?us-ascii?Q?SIFCOik7wiOxLbibYiSXN/lkqNVH0XINt+DJ8VwoL2oXGlC5DjvnU+Lmk4yz?=
 =?us-ascii?Q?JGfoZXqtLR4tH0dicggDT4f0KE/zsmZI+iMfkE018kmEegmMrkaTLOv1Ur2G?=
 =?us-ascii?Q?RKXZygvqmBEUEH/Yxik9do0nkfS5CZyv3wcW4duA8ErXQQ5JlrvwZSkKV9SJ?=
 =?us-ascii?Q?ipx4HZV/qRY91o7Qcw/vAdECmzzsE4l/whHYQhoNKIPmRPkq9zc+Ka0/if+V?=
 =?us-ascii?Q?aU4S5Wzq/2b6Ls6txV4IcelTT15Xal4uq98ttg2MgSB54d2RqONSC2SnRNpf?=
 =?us-ascii?Q?V++XEEWoauQx1I0dAhDKixNDypGUOMAqm3jeZqMOLFJL1/+c+sKNmmmiUiTP?=
 =?us-ascii?Q?2rA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ux5NkRsNVlJGNrp+zKVWEnvGQkb2r/7ylKuuZozp8lPED2boAWb1van91Oj8?=
 =?us-ascii?Q?FLhbCVBR2gc9KG5afVNjritOW9HywTCxPyfSENMMY3f+Qb0iYxy5Dm4v5Lz+?=
 =?us-ascii?Q?R5BiQ9Fvd4EFJnD9T6KMZjx4MeXQ1h7wWadw3pL+basd1gPfvyGMP5tUbo2i?=
 =?us-ascii?Q?ExK9nHsL9CUCz7OuFNvTc9Zb9MzTquIW5HRl/Wrjf+mHCyumZt3yJQM8uKX6?=
 =?us-ascii?Q?svOGvlCQqMlzdPWzrmy7kwckyvasdYyjqaJhqhVAL9agbTnAeaQrNf9J02vg?=
 =?us-ascii?Q?QMhco15+o92jb1hDtm2U3Zlc4TO6RbYfNpPWQWAxr6Khl4suBAZ/X0O4nYyL?=
 =?us-ascii?Q?Eds5GZIrpu2eFUsZ50qbCld+wO5c6xytv7wPVlRjtt55z4UKPksgZwUSMm0a?=
 =?us-ascii?Q?8wgi06TjLWnyrI0I8tWaD63ubO3IgHLP6+PUbxbsSGXtjWySrQU1rfwWHFuV?=
 =?us-ascii?Q?AfJIEYe8LqQA8SpFFZFUCuaYLkE6bLPFqp4fsVea4J4+BUsDSHrNMOKDMduK?=
 =?us-ascii?Q?qyqLK6VuyzVW7rUv7/xcvwctT0T2Q83fAATgv0nJMiCH4ClpxPqIFLihdqvD?=
 =?us-ascii?Q?we9cqy9QyW0pvb3Y09SR6iQfU37Q/FeqAJBOpguA1q20P/i86RmbPsx2VpPm?=
 =?us-ascii?Q?6ySgTOT7fgeTZHA8YGAAleSFx9bdalI9uDdLl8R2zrLrJ4OUYDhS72w9TeoV?=
 =?us-ascii?Q?3pbsz2CBGcQsj//3vgdAyUpNxxp4poC8RykukklIamcwkHFBDLtYSxBmJaVq?=
 =?us-ascii?Q?cnI08bIlXQ8bPQkib+pZd/vaDuaIZZSWqVUTsI8mnKsl2jkhUVO/avXPnL+B?=
 =?us-ascii?Q?3lqMPs+oeVfWuvt1aALe2gdrgMlOwydO4LRB0sIARzsKRy/4Mcy8yxfht9gL?=
 =?us-ascii?Q?SXn7R7MAGcvPYUiek2avYNZAjUzYP9CFC5LNRnVAjt5RvP8ywM/4ZGVhLjVe?=
 =?us-ascii?Q?AiAA5pWoyApFhpXVU/ms5VBjScPDPMsNH5BvIfW1KfaO/ioddTndlx3+PKZo?=
 =?us-ascii?Q?E7CWyviA4IiZVZHhtTt5yWK7dpokmTDDAiWqQZOlfvVIbAMhOZCd+NUjKcPQ?=
 =?us-ascii?Q?cd8XFBuou2SP3CDyMyL3I70Osa8Hy7/0m44WbHC1rURzzKPPpP8CGYE5atY8?=
 =?us-ascii?Q?9VXgV01yBRToeTDA3gIO96SuZTXmdTXEXEtIg9YyC8D6u03oLH3VbqVmiKqG?=
 =?us-ascii?Q?rkNWpmfXdZQI6R6eVI79Lz89SMYW2+ZixXU+rMGPzfHOqAPtmkE5Q/SWvMKt?=
 =?us-ascii?Q?X/G+vrgfyBeaB0eigs4T3OnY/elQ+ASyn9TfOP5ltcG+P5a9MezC6IUA59/3?=
 =?us-ascii?Q?IWY1Xhl1mqHb4+WWIZ6dX8En7z/y2mkuL+ieJw2rfgP3aPzX0JxGnBlbH3QQ?=
 =?us-ascii?Q?24d7+p1Z6l0covMYNFrrCjTODoC2lNFrfIJ4xa4BFCdzikYC0qlB8X5OCcnJ?=
 =?us-ascii?Q?AKYnP3XzuvGPp4VVxcZ4cGrulgCukUEV5s7UvdNFzBzNn+xF/zOg5x8EWo7s?=
 =?us-ascii?Q?CsvSYDoc1ry1Q3jPeN863F5sBXT3oNQOGj7uhVAvesq/sT6plU6zPRXv8vRA?=
 =?us-ascii?Q?duozCxVEe5glkCOFYerNFdqsK0fqlXOR7rLi2k52?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf4b250-a73b-480e-2401-08dcfdaa5044
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 14:58:31.4438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CcxNdBxw6L9AXe19A5KFZuCRKif6cvZKdB/WRjUndACjzME4hT4ECD4ebUeD/HREKngKpNhKelCbFfNjfBlZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179

On Mon, Nov 04, 2024 at 03:29:58PM +0100, Borislav Petkov wrote:
> On Wed, Oct 23, 2024 at 05:21:44PM +0000, Yazen Ghannam wrote:
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index ba5252d8e21c..a03ffa5b6bb1 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -3128,6 +3128,9 @@ config AMD_NODE
> >  	def_bool y
> >  	depends on CPU_SUP_AMD && PCI
> >  
> > +config AMD_SMN
> > +	def_bool y
> > +	depends on AMD_NODE
> 
> Why is this a separate compilation unit and not part of amd_node.c? Especially
> if it depends on it.
> 
> I don't see the real need for having smaller compilation units. Both the node
> and the smn stuff will end up being built-in in 99% of the configs. So why are
> we making separate Kconfig items and yadda yadda?
> 

AMD_NB (legacy systems) and AMD_SMN (Zen-based systems) would both
depend on AMD_NODE. The thinking is that a user could build a minimal
config for either legacy or Zen-based systems.

> Just do a single amd_node and that's it. We can always split later, if really
> needed.
>

Okay, will do.

Thanks,
Yazen

