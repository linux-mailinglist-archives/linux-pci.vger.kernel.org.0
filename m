Return-Path: <linux-pci+bounces-15601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D579B65A9
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 15:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 747FFB213B7
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B1B1EF953;
	Wed, 30 Oct 2024 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EAiCpQ7f"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B20BC13C;
	Wed, 30 Oct 2024 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298109; cv=fail; b=YYKJEGK89cXtWinuIWOjSB1HbVenFxOiUXJQbS6lHu2P6L8F3sxaosQX+M3zOV5I93TjjeCLzrniYDiPhx36aYUuUA+anom2M1zjd938PWwE/eLqqYzXjQKY61ix81RgsWcIcyzbzBF/YHVU5E0qdm3T/VXA9D4mmsO6IfwRtwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298109; c=relaxed/simple;
	bh=zdLwCHFKiraE/GCr9Kgj5NW6dydYrR/HZ6WK2wuJciw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aTMjHCga7j0fiEg/L9AAxrQmP8pHNf4G5KIfMDNitEisLS9urikggt466o8kJ2G7yX6vKoNPDu79Ny2FnQ+V0BB3bnK9dvlYdWxV0A/kkqHdXCsMbrDDJi2rXbnYs4IEtIEGKb2DIG4Sl1GN+HZP01OUCUMYhj9x3u1bJ0uGy78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EAiCpQ7f; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMOguOrzx5vcGNEjIInn+P+3z8jjcXJ1jUg8LGlrLxfPZTd2Qcemz5NB2Kk9R9WYauO9QPcdkdcK3Zzm0lcXQb6wCyw7RnEvSwekzESox+X+Wamgc92dR0yRWS5CY9KtyHXInVo/FuflIdxUAyUNUPVVGBfkqW5AvN6Q9f+VM0l8wO5QAXctefwcIOM1u9rWEzieP6f0dWlAwRx9Kig+6MA6NM2fX76Aj+W8yC16cBQDT42hLIUK4APqV0aI2VrTRKGEuLGwOtPmc6FjQAXR57ZYV3mE7as7HKXo2/AyGyAKnP9INANj5wJ0XoWQTk+t3KdZO1i4yMaFOIkZAhvOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtHqkzhYEMn3bgG7iWC24dUxF7wi96bcCpohvLc3nVA=;
 b=oV1YS/n+uVfAG4zF420GIOIlTJ8F6V7HApcwj5rR9zCokHlgm5wWXI2vhFxgzy1xA22l2Xch2APX3kNPq1fxaNOgsdFarpCbyvIF6qy8xaiQDCaK6hP0Ot1MO7BbQHixcLh7rwAaDRc205Qoa4oLjXrzNlRyi24KQ8WpbBpECAFP67UdExnkp69zgUiHUCl1wbt8QWjSF3GSfgHeR82dzbj1kTgeCv8mPZsMvI24kUOZUxhYvGDUlqwK6bdL+y0N4jky3W9fmHdVAIuYxSVQgk8H/Hv09L0o3w6YUdEa0hhdL3z8H17kMVCAUP0cnnPmvXV9Rf9si3F7qbRH5/DagA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtHqkzhYEMn3bgG7iWC24dUxF7wi96bcCpohvLc3nVA=;
 b=EAiCpQ7feOOTQg0bhdM89AYh2nwwQTzG9or1CB1LjKKAVtAN/BgDaMMbKCWJIg++bmM2BMuu0NtycWRHUmpx0e+YbazFDsjDIyNjs9/EopqgwRBzDsWKtEphpdjw+Cy/q1ZdFmI0NkdfRqwUX9pNOiWveul+6mXnyEfOQOIOb80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.24; Wed, 30 Oct 2024 14:21:44 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8093.023; Wed, 30 Oct 2024
 14:21:44 +0000
Date: Wed, 30 Oct 2024 10:21:38 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"avadhut.naik@amd.com" <avadhut.naik@amd.com>,
	"john.allen@amd.com" <john.allen@amd.com>,
	"mario.limonciello@amd.com" <mario.limonciello@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
	"richard.gong@amd.com" <richard.gong@amd.com>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"clemens@ladisch.de" <clemens@ladisch.de>,
	"hdegoede@redhat.com" <hdegoede@redhat.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"naveenkrishna.chatradhi@amd.com" <naveenkrishna.chatradhi@amd.com>,
	"carlos.bilbao.osdev@gmail.com" <carlos.bilbao.osdev@gmail.com>
Subject: Re: [PATCH 03/16] x86/amd_nb: Clean up early_is_amd_nb()
Message-ID: <20241030142138.GA1304646@yaz-khff2.amd.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-4-yazen.ghannam@amd.com>
 <20241025155830.GQZxvAJkJnfLfNpSRx@fat_crate.local>
 <20241029143928.GA1011322@yaz-khff2.amd.com>
 <20241029150847.GLZyD6f-Hk6pRTEt2c@fat_crate.local>
 <SJ1PR11MB6083AA7B2E28F2DA24E4B456FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083AA7B2E28F2DA24E4B456FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0455.namprd03.prod.outlook.com
 (2603:10b6:408:139::10) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 9913450e-3150-4923-e576-08dcf8ee2e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rHLlJfhonTob3KJSb9TVyfL7c/3Eb7qWs20YBK3Vn0VX082eS/2n0udz2C4f?=
 =?us-ascii?Q?5hxJDGzV8K2+EKo2Tj9KhaKdyOtGlCGFs6qg8sVUfCfpohwRR6G9+yxBpEaC?=
 =?us-ascii?Q?ZmGEkMEFvuAYKEInZAG85HXsySF1fd/0FMOzmw6gbXV/tVmNWBjAjX9wDfCi?=
 =?us-ascii?Q?aOBmrWwpSXaSdAK8/4QLwZbhOv5MJ2KaPMjdaVVC83fbPzT0xuiIi9Xx+sDI?=
 =?us-ascii?Q?M9spJYNn+jl8KqsJDEPNxNwsMTBepEz55WwS4YKbPrn1rKoCvozmVH1vavRw?=
 =?us-ascii?Q?KV0ZXKVEW4X+I4CR3LrV1WspqdTOENSXuLC1W+j9LDGNDmv1OvmSWkpA/010?=
 =?us-ascii?Q?vNR0XJcGsBkODZupm7UdYDNvM6mf3iVNG2H5/rJhbP5ukHp7A3bcLo1tHJxl?=
 =?us-ascii?Q?gGyqoHSkAHyQMcdj5dELN3nIbwd0+NsjXIYgHOb7RMnbbTpe8IvqSLUiFLR3?=
 =?us-ascii?Q?drFxZnCaQAAPhUM0o/fR6PfVOjsZdmGzXZr6Q15PrchsENbhSIf9lQlHm3XR?=
 =?us-ascii?Q?YO+FnHILnHjwDhntdrsikoCqvIAlDdIc/EDn3xfJZqm3rcS2tMzRvbNlDM8A?=
 =?us-ascii?Q?RMSTBrd9YjxHOXKEIn/jCczGYK2hXD7hHhaTo+2H+iVE2fYZTikrRVoVNa2/?=
 =?us-ascii?Q?7RrhcCjmSflfvS+sbf6bwHyFvMY7nq11/OLC2k9BiYPS5clqV4OAwuAvIm6X?=
 =?us-ascii?Q?Vw3yn5YdI5aCorXNnQFxmJpEthTCRME90PR/MOc+tNTxE+q4IIUFhITbig8M?=
 =?us-ascii?Q?HVz7J8/zgSUyNkkWJavrFFoLkYrj3Is6KOSzUskCmM2tAR0swdgUNzU1M0Wf?=
 =?us-ascii?Q?djQMuRsjMAwFS/LVmdd12in5l4WtTIIpRQKgbib9mDE9ksuhRurSp9T10R4r?=
 =?us-ascii?Q?PPj0Nuaz9nf1RJVLBb5FDbeiyEAt3DgfWi+wd3vEL++CvEAcHQPwec5x/y0N?=
 =?us-ascii?Q?PkTsLiSrJYmNsVG4uXyg9JSMezGeLnJztGZzopXgGA6Pohcn8d/2jrfalak9?=
 =?us-ascii?Q?stc1jnvRHOeJpa4AxZuqFEX2bDaNMh1zbtdOdEaf3jYoTkleHlsZjlt/Cd7M?=
 =?us-ascii?Q?w38x8t1UxxqkP42pBZJJ5O9M1jG0lvnPgsFqzzzyLm1Barvz4E2UnJrqO8L6?=
 =?us-ascii?Q?tpoBT5ow0e3ywqC3EwgUScv2s5y3W55ZnyVIyGqoFL/l6dmeFEODrH5gmjsQ?=
 =?us-ascii?Q?kAuSPyEzwBc2vYce8ciljsFfiqReY1+NmEFcIRXhNRVWjR/0CU5zVgAfGZ/k?=
 =?us-ascii?Q?oqpzVxWj4oa8l4mFRrFTUnjm5cvJf8UWmIgpaYimtfkmQuQhsvYIOHMzBT6z?=
 =?us-ascii?Q?qnnQOCPjgxWZhzsbUD789xg6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WafwMQ5/YXva000ketpZr9ktU5H2saD8C2ujSukSRRK7NsuTDRddMv1kakDQ?=
 =?us-ascii?Q?mTIzN5kfrTHtEf/P64Sy3mIhPQUXmhC1+egbgBkD6bnW+pL0TbdeuiSaTXPD?=
 =?us-ascii?Q?onOQ7MOYreZVbAET3UzvicbIwHCbnRl6h8KDNCx+dJbRUL1TjRYEYbRzrBG/?=
 =?us-ascii?Q?ofruE7ndXYkGbmfEQBGHfO0t4vzotMIZIj1aI7bS2IJOww1NlbIPBQlc/EYv?=
 =?us-ascii?Q?4vj7epo913ACG+yVMcrMCOYyTVNNwmXh5b+u+O7QwBkbjAWgt1doHuRGFm9m?=
 =?us-ascii?Q?TmM2qlhjdc4Lrk4uFJzMPnYIKTKgwDiGWC+lfIcUYyHaSMyo5JAmGuee3ocD?=
 =?us-ascii?Q?MFJf/+7yrYTCAfpD4gGzj46MkF9x/VCVtgPQ5tXmCu5hak5OK+wtg+3Iaoeh?=
 =?us-ascii?Q?vqbyHnKt8Udj3BozOu0ZQ5HiSq30+ooGq+WvwhI7F75LkCGU9ofXNorfmc/v?=
 =?us-ascii?Q?q3k6Yx7jNhefIkQOnMtDHTBTAVmS1/O7vELvRgW6l0PP9H4Gy9RbdKV7wLy0?=
 =?us-ascii?Q?qonh6T7VMbwpimohnkk3nOJ0BtSHXRqhCy0xO3NcoRsNH+5y+hqYJtzSxpfL?=
 =?us-ascii?Q?XZWvY/B0djUF0Fukxo4oVJiP2rAgFrqWanfboQBFdl2J6IVOzsaLNhznNLlO?=
 =?us-ascii?Q?b2rwGffe5K5KoGo1gdRmkCbOUYMAHJfAlRzBFgjTgFuUu4V8yGZfupTwjDSJ?=
 =?us-ascii?Q?RCn+ld48ct2eEPzE4XK3Y7FoSgazw/9azJVcCIXlPmODcEnXYCd960x0e+S9?=
 =?us-ascii?Q?VWzV9sSNd/T01HuL30TdPm3hEYovTT/sHWqzzlfLxt6GvTeLo9qk57y9HmN3?=
 =?us-ascii?Q?bCkGsisDcpWqKTvuCb3GcUl8zspqMeJy6Mfr5KtwsFkWxrxFVa1qUL23Ak+f?=
 =?us-ascii?Q?cCtAa8pXigBbfkrNsPaEDXPEbJR0N+ZHyF06J05k1z0Pbq9OUGJZUzhKx5w7?=
 =?us-ascii?Q?QgFVn6XzNyTtXhp6/3z3226AuWsaWd3FfamOsb/X5o5HaDQOKRHp6M+F6I5r?=
 =?us-ascii?Q?nPLd9FqgaFNRoj1Cyt7dH3sBbTdNg/6XU2otN3mbEZ9jARBJwCLpJdhAPqZB?=
 =?us-ascii?Q?2inv39vZHbls1UuJxT++waN30Fj25ePDGCFPBx84K12NYMOyVHmkX3IbI9T+?=
 =?us-ascii?Q?A1HuwtLPbIagmgthkg3AE5UgFExiBQ8BfU82sczivnc5Q69Al5Gd4n8wDnZY?=
 =?us-ascii?Q?R+3ldULJkjlZW72WeuZjwNES6rRLZXx/dWJI6nw+AyR6NH2zleBlazgfWIKW?=
 =?us-ascii?Q?ciD3qKGa7uV1iOtHEjbeluPjACTlV/kJVej6V70HPEOsnsUHO4MGzFw6e/bB?=
 =?us-ascii?Q?JGe/4hvPcCCDCoPW+AWqJeFhmp9Qbm8i6x1d23BI1qRmTwoEeC8SPqqJv5FA?=
 =?us-ascii?Q?unODEzuct5+uj1pewuNMdzwhcxRkmkh3RUP0/Jb8vSb3mG8oD7PNIYqq9a13?=
 =?us-ascii?Q?7ykvI0LKUIYh4vow7dS0CFOOgSYKVLqnPjGEi9YGarAeTqi8xznk9twKxP6N?=
 =?us-ascii?Q?D5lQ4fqZGHEO+sBVxlVdwEqYcVL2EoWpTBqFqzWVaGomRWGU1uW59r6pHIb7?=
 =?us-ascii?Q?oFMM+W8bGtJ7wevNtZPkwReCtlqwd7pdxQG3LUZ3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9913450e-3150-4923-e576-08dcf8ee2e05
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:21:44.0306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Npu8G4P2Ot+oTSfnkz7700cLp0mY491954gaZneqQsJH9FHF2IhnaM0N9NXnUVvhvMHeZTJQ9Wrbq/yonJyn6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630

On Tue, Oct 29, 2024 at 04:15:33PM +0000, Luck, Tony wrote:
> > > > > -       if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> > > > > -               misc_ids = hygon_nb_misc_ids;
> > > > > +       if (boot_cpu_has(X86_FEATURE_ZEN))
> > > >
> > > > check_for_deprecated_apis: WARNING: arch/x86/kernel/amd_nb.c:395: Do not use boot_cpu_has() - use cpu_feature_enabled() instead.
> > >
> > > Sure thing.
> > >
> > > How can I enable this check myself?
> > It is part of my silly patch checking script:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=vp
> >
> > in here:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/tree/.tip/bin/vp.py?h=vp
> >
> > but it probably isn't ready for public consumption yet.
> >
> > I probably should try to package it properly when there's time...
> 
> Sounds like it would be a valuable addition to checkpatch.
> 
> Maybe Joe or Andy will find time before you do.
>

And if not to checkpatch, then maybe it can be included in the TIP
maintainers' handbook? That is, if others are using it or something
similar.

Thanks,
Yazen

