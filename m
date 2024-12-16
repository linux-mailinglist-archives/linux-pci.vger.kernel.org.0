Return-Path: <linux-pci+bounces-18561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160CA9F3907
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BDCB18863FB
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17003204F92;
	Mon, 16 Dec 2024 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F85OYMHl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F392136331;
	Mon, 16 Dec 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734374035; cv=fail; b=jRYdva9QcfGRVs5pD+PDqfdpaMxjiDUs8HY2xh+tZc+QSlvTSOwwjihtmmuTokqxFZsVLkChbxsCU7ZCjdR/4p46NU609aj99ARcCE8RaORf6lT09tHG1N2Srp+etk8IBVs8JwasXzJjdoMle4Qlh51lotcUczm+n6lj041LKrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734374035; c=relaxed/simple;
	bh=V6ZSdJt5arM3jBndF5UP4sQy52v4GxVeaG+vgn1Ri74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a89zD7Sbg9TP7xWWuLeuOzA/5paMlWnb4GNlaDYn9VSULzw+yyRT3xdZncNKw5X3U1tPScBiyU9Onnc2CBYt7gbKGS0rBdYewdu/5Lm7tFQjcX4JCnnbD8ypFZ0rWH54PMMyt60tl4KLogauVzdzoutlWnAvEcFPjuSl/d89/Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F85OYMHl; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWP3Jo+yZvKj7Y2oNPC2sQE2QwBTBB8wcUMgvX5ey7dwC6QfN76OdYcsTfPCddqf7GX2DjhbQ+/0JnSwVxlMBmPW0GNEm9gLR3A+HQXc+wmeEkYWrVtnLI5FpaZ8lZ8/ZL0snOeSasXmvZGUWTEB3E2e8xv7QOY0qXhzwbM19RQ2iG03FXgSgm0qpFfOx9j94Hbp60j8rfYKXFFoC8YD2XoK3GrRRR0fs8h8cVUC38BmH0DL+hHlY5gWWg36ERi3oBUS1ySw43/K3qun3oPS2ZPfk3JZZ3HjFezpTXwnMo3zD7GA0DuK4i9yg+E3amKA3hQjL4uLPfl9yDBzMQbj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2kLImPGwh/k0lqMHdNxEVh0Jg22Jz5A4ckvjdqAlUA=;
 b=LDTpUVqwypBM5Q/IqWQ3E00nhxdqC5YRnYx54Jl5eMqqX3ASut3b/ur9FdKAef39tEAYIaehRvN+ZCtzOwAuDxA3CPffIZ6CEifpUodneEnE9ogDlUug0nTQw1Ti6x6teQ+v7jbeSQ19j0/9+buZ0JOu+TsaVeP5B4fXCrFH8XK9H/kn3Zm10qFB5gTU19iUXeceZzeJwS1jlKK7JXePDm/7mGrm+lQPHpIfOjdHB7pzZFpwaX63Fw6QM+Yc7IF/ZtVQVrNvFX4Sqd/XS8WnddzghAVT5T+NW8ITyviGmWaRBENBlR537ZtNOC4E4pYOXOg8fOOI6GLq4wAJtyJHYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2kLImPGwh/k0lqMHdNxEVh0Jg22Jz5A4ckvjdqAlUA=;
 b=F85OYMHlt/wSGXTuFWOVInLRbJsd5xr3sfXfNgCd8C4yP3JcE5S31IVM5yCDRT3Yals5LS1MChramxA/HgZyRe5OvuUpaWTE0FkcxFjv4sfEWcz6mBaxXqbKjsNIX3LRWD118jW0csgjiDByE6vCjs78BRFksHhlc6RiBJE3Lgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 18:33:50 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:33:50 +0000
Date: Mon, 16 Dec 2024 13:33:38 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, tony.luck@intel.com, mario.limonciello@amd.com,
	bhelgaas@google.com, jdelvare@suse.com, linux@roeck-us.net,
	clemens@ladisch.de, Shyam-sundar.S-k@amd.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, naveenkrishna.chatradhi@amd.com,
	suma.hegde@amd.com, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2.2] x86/amd_node, platform/x86/amd/hsmp: Have HSMP use
 SMN through AMD_NODE
Message-ID: <20241216183338.GA542682@yaz-khff2.amd.com>
References: <20241212172711.1944927-1-yazen.ghannam@amd.com>
 <20241213152206.385573-1-yazen.ghannam@amd.com>
 <20241214100507.GAZ11YU_9llLRq5AoD@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214100507.GAZ11YU_9llLRq5AoD@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:408:f9::12) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SN7PR12MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 41092ae2-4b47-4f80-cce8-08dd1e002f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l7rp4sARMqULsPOM/bcQk7IJFh5Y13nfIOd+e+wmI7kPqltCvCeQH15FK/Av?=
 =?us-ascii?Q?O57L5FgVyWS+Tl8UnfUCY5+v5EvuNOiucCr+BCELcAwunhAEtuxJmKT/m8jU?=
 =?us-ascii?Q?iJXPIwYZg2UOea45nhWT3Y24z1EIXjBWNzCuPnR9JeDUq3zGaElt9rHZg7bZ?=
 =?us-ascii?Q?WYEd04DhtGmT0LLPVo0jzQwHhUunl58n6CPBIYJ5Bw5kRxKkDrxPocFC4Vk+?=
 =?us-ascii?Q?QricQw2wRzLJ6KeSTTZAnoPGHgRD7+CG7cJJE+a6mNHj1Qw9FIuUemJoObtA?=
 =?us-ascii?Q?G+98p65Ra67mhc+qrVmWSzTmytLMSE5sIvhBNqN2HeC7LAjf9+vnO8xWrPQU?=
 =?us-ascii?Q?lnjO953cui2U0sLUt8/TWcwZQ867tgCUlhVD851L4z9iLW8M40szW31xgfIV?=
 =?us-ascii?Q?ddwix5Ty2F6W9G3kt/L0Rhxptj8p+NNTa3TYampHdfMNqHqWwIHnMFCWpE6+?=
 =?us-ascii?Q?xrDPhE75B89rCRsSFo8Ks3EI2Z5LsvcCYvkpsHzbhHiOaW+whrbYQUHieATc?=
 =?us-ascii?Q?QYhNoB6OaAO/njAGHP3EgbT2OoxZSW5v1tP4mUQMW8l6ue/uNIKPcF33r5pP?=
 =?us-ascii?Q?IVUvv2bLTsiLP3ofSvtMGXNXwrSREZeZnxbkQ8RLhHs2jJc5rgoeu+2JaSBd?=
 =?us-ascii?Q?DGXPYc7nZ2yjlq5eX2xqGjCE3oVQ9Ri4Shw3UkcRPv2SL8xXn2+4Vkj8HBae?=
 =?us-ascii?Q?b7NGMxdOTpCh3KSD05xCmgow9nH4lnwIomi5Zy2QzBrHHwqRmwULwA51NYXg?=
 =?us-ascii?Q?wxopezqh19HTlsYYS497suknQTaFwdKPqp141AnIFA9LrLUPxKgk1sw1o4N9?=
 =?us-ascii?Q?I+7YyzTs9M6/X0WJYnx3qz/iFlWRu/3MQeBBvs6vbmUepMIqlWHbaU5CvPH8?=
 =?us-ascii?Q?R8LBit+kKrAtK76+yTL6wGqT68+6kYV0XwF/U96szK9WrNLq+f4BAOibGKi6?=
 =?us-ascii?Q?z1x3oFpKKj5JY8XycGiviR52xxVYgFHH9u9D+PZgESUIDGjTkp1rrg1bGuMd?=
 =?us-ascii?Q?frietp/jxn5qXc4TkS91gFhXaPwyxxPepDalMUFuvJaSYV6xnIgngPe7GFaw?=
 =?us-ascii?Q?nGihjcx7fAAy3aA/14rJn43yLBLavNzH0kff8zk7xqgFarE5EIRdyNYCco+k?=
 =?us-ascii?Q?IRtF3Cg4e4uqPVQCcytu9Jxo7SI5rkwMTN/4vnV1qF1zyq5DZ9lWwf1pXICB?=
 =?us-ascii?Q?I+ZSFxrMPL3rsas7hmsPai0GBHUUymWgpIJusq9dKuyzSaCrHzKeChbXBw7m?=
 =?us-ascii?Q?+aCXakwVwcFcSKcBxQV1BmGO0goZIQMviBzHAyTPugnKCJUYDcF130u4tn28?=
 =?us-ascii?Q?eWs4+6wxZA623SWvimhNwK2Lrqrd/OeO8olLM8BYE4v2nFwztqRL9Lg7EvVD?=
 =?us-ascii?Q?pDPFrO5R98imfK1L0zlCZRXQM1Q3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F9Kv5lYfNNR6DeF89LOksyt6OVka2ASbTuUuYNTVaZHwv51RjpmhS2Y1Z3oy?=
 =?us-ascii?Q?OwblI9D5OcNBoi7Rz80wzJH3olEwy9DUfI7ouvRpguGvv6dw60vhHWwLhxfr?=
 =?us-ascii?Q?XPaFQyhgwJLRVj08Aiv1xxPl3cJgMmZHJyNQEe25a4NNGSl8x55fK+XzQ0/X?=
 =?us-ascii?Q?w1R0IQWQC4J+zIXFDC1jkjs+8C7NJqbtia0fzihwoOXaGE5LGLxf6k/Ua65+?=
 =?us-ascii?Q?qK5ZZ5Qf4/99yPciPevAp5H/udk34D1VYX6I3kTZMTAdg+E2h2FlxkSC4rOM?=
 =?us-ascii?Q?IdUzECplmYw00LknnmOPqmejYP540f1WzW/OJP/mU5VcAuBuxjGcsM5TFLz/?=
 =?us-ascii?Q?CZKitrHG8UOmhTiSaL5EBH07EJDHumD6RXjLKtqv2mxIJiujTlyMUVnZ2pV1?=
 =?us-ascii?Q?xXlg67W0rsOZn0rPEOh0K4tenjRoBUYhraQ5hANRjVbdfgbuXxxUyzBHgwKK?=
 =?us-ascii?Q?CcaiZTG6BV3lUntb590bBeHtfeS7BGtLHUs+OnxsMcuQ/BbxxealCf+h/+mj?=
 =?us-ascii?Q?AO7uSMxKdJfhb0lnqngExOBDC+XEiQiHmbi2ZW0K7fJfVJ7A/puaJCdszlJT?=
 =?us-ascii?Q?BbFj3tEI8oXpVB5Jhp0oyVgi3PX3+l563Wjwi5IPPmx0VxeGkRSQvK8hdd/e?=
 =?us-ascii?Q?acdEJlLriOmPrSrA74LYN6JNvL0theC9f/z8X4OWVPqeh8Fw0lHaYLW6yJpz?=
 =?us-ascii?Q?4Z6+9QLtILm44mOuJHhzPKs33B58RZZISaUNtmKH/+T6fplhU8i7PPqoF1nF?=
 =?us-ascii?Q?nvArhf3jAGX/MjpjQYng/YdAriinVhsBnThTI+vVrsQrONockTeYJmVPbsIq?=
 =?us-ascii?Q?xVudU/9mbZOQuS25Uk2ED5AnsBniTMurMVZa0Ds1txiCnbRdZJysnH0Lt1R7?=
 =?us-ascii?Q?uYGKpEX7+y5Eofb9Z0SbLJI77nuYoABXsfB8dEmkakoQN3cgzUtQgoxacfLu?=
 =?us-ascii?Q?dBL7DBmsLnWr/zZ3yBbwa4gruhjwWxgF28Q57yRIAndOdE+HFJUCYDd9DcjW?=
 =?us-ascii?Q?30+w/FVMur0YHSuHe7MW/+ahn7bF8Pz0lJQReYQL3F2ZDAb5GPbRiRx482rd?=
 =?us-ascii?Q?f9RQFhzaE4yn0X/Nx1Ms0aqUTd7UNbOcZbN9+GW7KNZrjG/nF30YK4oKnMUN?=
 =?us-ascii?Q?YHCQ4fD67cGiHPGxW3997Ed31bKumcoVuuE1iwjE5zP76hK19eQgGnvbvDAu?=
 =?us-ascii?Q?CW+Etw1/TcENxzkGUFS4YVGXko9qQy0bZKHguSZgcI3JeKCp2F8joH3Bxi21?=
 =?us-ascii?Q?rnkxKcsPwOaqc/1XM9HSRD5Of8y8I9E8XZQ1LyAN1gD+SRsYLVYSAcnOEXSC?=
 =?us-ascii?Q?T9+KxvQiwiqwRdzVs0CCBD9MFMO+JOK0oT+PTmVhjW61grYdaoKer3dDbAup?=
 =?us-ascii?Q?HhLSd879fAeK5lgMOaNVlwzTBgYmWigtogcse5QxskusTw1fzLT2tsUyhTlU?=
 =?us-ascii?Q?ad2Uykr5UmePTTIpd8eadXD0V87YO/eKQhD1usHuu6bqdeVaJpzQ8W74L4i4?=
 =?us-ascii?Q?UsBf8tYJOLwq45P7xkFlfOqpUPHFBRX5Vs2o43cNHR32fXrKB4VxA1moYvKF?=
 =?us-ascii?Q?QzD0yiFLr/NIk5COATlanWWA38ZL61+VeNbrUCAr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41092ae2-4b47-4f80-cce8-08dd1e002f95
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 18:33:50.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAXSIqO1c9fVV5HxoWcfn9qyP0gjy7w/px6hV+LN7IoK6yiReI7jVJqIztKvfNbsFrwA3S+voBneLMt722VbmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7833

On Sat, Dec 14, 2024 at 11:05:07AM +0100, Borislav Petkov wrote:
> On Fri, Dec 13, 2024 at 03:22:06PM +0000, Yazen Ghannam wrote:
> > The HSMP interface is just an SMN interface with different offsets.
> > 
> > Define an HSMP wrapper in the SMN code and have the HSMP platform driver
> > use that rather than a local solution.
> > 
> > Also, remove the "root" member from AMD_NB, since there are no more
> > users of it.
> > 
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> > 
> > Notes:
> >     Link:
> >     https://lore.kernel.org/20241212172711.1944927-1-yazen.ghannam@amd.com
> >     
> >     v2.1-v2.2:
> >     * Include <linux/build_bug.h> for static_assert()
> >     
> >     v2->v2.1:
> >     * Include static_assert() and comment for sysfs attributes.
> >     
> >     v1->v2:
> >     * Rebase on recent HSMP rework.
> > 
> >  arch/x86/include/asm/amd_nb.h         |  1 -
> >  arch/x86/include/asm/amd_node.h       |  3 +++
> >  arch/x86/kernel/amd_nb.c              |  1 -
> >  arch/x86/kernel/amd_node.c            |  9 +++++++
> >  drivers/platform/x86/amd/hsmp/Kconfig |  2 +-
> >  drivers/platform/x86/amd/hsmp/acpi.c  |  7 +++---
> >  drivers/platform/x86/amd/hsmp/hsmp.c  |  1 -
> >  drivers/platform/x86/amd/hsmp/hsmp.h  |  3 ---
> >  drivers/platform/x86/amd/hsmp/plat.c  | 36 +++++++++------------------
> >  9 files changed, 29 insertions(+), 34 deletions(-)
> 
> ld: drivers/platform/x86/amd/hsmp/plat.o: in function `amd_hsmp_pci_rdwr':
> /home/amd/kernel/linux/drivers/platform/x86/amd/hsmp/plat.c:44: undefined reference to `amd_smn_hsmp_rdwr'
> make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
> make[1]: *** [/home/amd/bpetkov/kernel/linux/Makefile:1225: vmlinux] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:251: __sub-make] Error 2
> 
> Config attached.
>

I think the fix is this:

diff --git a/drivers/platform/x86/amd/hsmp/Kconfig b/drivers/platform/x86/amd/hsmp/Kconfig
index d6f7a62d55b5..fc90ef11a8ad 100644
--- a/drivers/platform/x86/amd/hsmp/Kconfig
+++ b/drivers/platform/x86/amd/hsmp/Kconfig
@@ -7,7 +7,6 @@ config AMD_HSMP
 	tristate
 
 menu "AMD HSMP Driver"
-	depends on AMD_NODE || COMPILE_TEST
 
 config AMD_HSMP_ACPI
 	tristate "AMD HSMP ACPI device driver"
@@ -29,6 +28,7 @@ config AMD_HSMP_ACPI
 
 config AMD_HSMP_PLAT
 	tristate "AMD HSMP platform device driver"
+	depends on AMD_NODE
 	select AMD_HSMP
 	help
 	  Host System Management Port (HSMP) interface is a mailbox interface

With all the recent rework, only AMD_HSMP_PLAT has a hard dependency on
AMD_NODE due to needing the SMN register access interface.

Various HSMP files still pull in <asm/amd_node.h>, but they just need
defines and an inline function.

It seems COMPILE_TEST is not needed, since this change allows
AMD_HSMP_ACPI to build without AMD_NODE which seems like the intent.

Thoughts from Platform/HSMP folks? I can send another revision if this
is okay.

Thanks,
Yazen

