Return-Path: <linux-pci+bounces-39189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B8CC02EA2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 20:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2FD3AD992
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 18:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02A834C12E;
	Thu, 23 Oct 2025 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KdSH+nk5"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5270734BA3C;
	Thu, 23 Oct 2025 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243916; cv=fail; b=GgEyRimCdi9iNAYHw2S4/1wVCQyQniFuxn/iwydUuzmIa8KbF+9jnHzBipWZZxW6cLuZWN4HAup5/dV05MM4PqWciVRZC1l/CUDGMLtCOAIhxR4nBgSGkrRtemvu+TMYQ4/eoMbmWNTcXeaPm8KXr9SpgCjhOV6bt/tmSyNR8V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243916; c=relaxed/simple;
	bh=eF3LuMU+BvYvtrZYTwFFx0egW0V/Dl0BWnfYEr2Me+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WF1g3N/aVPEOeXZQTJIAdb7ePTnFZETv5qDbQSNyI5hOxolhxupJbB92egQZIMCJyutnM7TW02VRU/cnFeLLDlI0ceNysgEGjdwBWNHNejC5EpajN9irlWeEdhJHtd2Z/eiV8T/LA6n8AxYhE0Y+M7YNUrJnNOq501S/M2bhliQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KdSH+nk5; arc=fail smtp.client-ip=52.101.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBSizr1REvnbEc5EfqwoAkCkBe7PT9a3GAYQKrCznsAy9eKnazfeuUGvtiGqQCz08ZPG4z3h6CiIGeGx9D2suyitKhIj8AEag118jaULRcDLrpAFPPtjLf1256wWyaN7wkk6gBw1ZPnhLEJq2vS5zIrYXaMdjtX5RadbdhVTneTG4ysN+/WG9lPuKA60t5WmwFEk/07DzDF31ZsZM7rJKQTcR+sQDIEOuNqLgXGV73QOvF8G//6H/d0rbypeYCP7LzR25jntqhlxonH5kfCmn+AtlLubZv9cHZbuYuTcRYhnchfGbFiCe7Fy3yo314wpQGzLNdPdnDhe9RkEN0OPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YByjaXkRfJf4YaMDafVJOqBG0TSIXsEHaV7E2DRhuo=;
 b=oUh2zzPZ73Va6DUg7bk6m+ROPXG/U/MDUv/WrINF5zQKiZnvxb1MaylDHkLKHh2WTHZqnvsIL3TvakBgwjM0wossqJUCIgCzT1yop3BRx/AsHZJggDvbYxSPTbMyTLyCdS7U1BIcAc1rWyjtdHyiHVawOMyUA78rTfZmnhjZ2y4yB19xWVaWAnTeJCNibQniK3/+yGQ0UWO/gzxaxN47RJiCznQojzN/ZSgn781uSwgfG0oOiMeKNix92wtBYdyVTIJSsYBF5hRFNtetdFreOAz5FR/zHhEG/B0X4aak3TL2nShrmRaK6sbH48Ka2/wV9pO7u4w2qoqOu45Zlg977A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YByjaXkRfJf4YaMDafVJOqBG0TSIXsEHaV7E2DRhuo=;
 b=KdSH+nk5vb9pfdwbRXYzB3jUi5c/PL0Vp3j52DwJUB4kFmfqpjXQIczd2Tx/ajadAeCaELqBg2IupBk4IWT3Ig1kvXUdxRurkTx+Je1ZVKfgF3GrzToB8tDtNIRLEZrEng21oWea1jwo3K9emj2JUMbCRV6iXfPHuY764OO4gCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 18:25:12 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:25:11 +0000
Date: Thu, 23 Oct 2025 14:25:06 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Michal Pecio <michal.pecio@gmail.com>, Shyam-sundar.S-k@amd.com,
	bhelgaas@google.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
	linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux@roeck-us.net, naveenkrishna.chatradhi@amd.com,
	platform-driver-x86@vger.kernel.org, suma.hegde@amd.com,
	tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
Message-ID: <20251023182506.GA796848@yaz-khff2.amd.com>
References: <20251022133901.GB7243@yaz-khff2.amd.com>
 <20251022173831.671843f4.michal.pecio@gmail.com>
 <20251022160904.GA174761@yaz-khff2.amd.com>
 <20251022181856.0e3cfc92.michal.pecio@gmail.com>
 <20251023135935.GA619807@yaz-khff2.amd.com>
 <20251023170107.0cc70bad.michal.pecio@gmail.com>
 <20251023160906.GA730672@yaz-khff2.amd.com>
 <5764e711-4c3f-4476-9ecb-1f7643e3b60d@amd.com>
 <20251023190644.114bf9f8.michal.pecio@gmail.com>
 <945b3be6-3392-4104-aac1-35d460e40cbb@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <945b3be6-3392-4104-aac1-35d460e40cbb@amd.com>
X-ClientProxiedBy: BL1PR13CA0275.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::10) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: f0802435-c580-4431-18b0-08de126180ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q75pJgsgJ+JLMaaq5/oYUbyRPQMCBHPhoG0uJ3KFAewI+JPnYZNN4NMY8edi?=
 =?us-ascii?Q?B7i0pdDKns8KnlKreVlaqMmSVDGdh5mvd1KCMMmkl7Xg9TUZrDq7pwToLPtL?=
 =?us-ascii?Q?dcgcAh3hiHqxB+Z6uau6+qB9gCVAXgy7Eayk4UlTZK5+whRsfrff7dMIIT6z?=
 =?us-ascii?Q?i/WoKX0z27+Id6MBVEEJsTIcJ2ipFBPMWihH9Q+1Vf3MF3H7S/hjjgRA8RTA?=
 =?us-ascii?Q?W3bzvzRpF74IPpsHVW84LCZn7uTsYkpliTtOnHMyU60REFbx8gbry/RL9pIn?=
 =?us-ascii?Q?EmL8KYgwwDi27i7CIau3PirRbrYWm8mULavvJeVwHXKfWgq+yY8KX0JGdLBO?=
 =?us-ascii?Q?LhcQ95Wi95XJgl7hrWnslTraN/YVutmgIVI/Lp6fOV/og0Hgy8TdWvHRYSPF?=
 =?us-ascii?Q?INdOTV2snX+zXA3sv8E3P3EDVgLVmQQDIVMOfGxjLVWh3xQMd6zjVn6ZfduR?=
 =?us-ascii?Q?gfAZZLd70RAcqSXGcptOi6VShwe7+z0lQ++9LwHxNDMfeRsE/3WqzqCPD4mz?=
 =?us-ascii?Q?y2dp11p7NLDL2r318kijZBk9smydAL+E2WWLZnQlw7V2Oi8WG9YaOLezy0EN?=
 =?us-ascii?Q?xVcGBH6vpOAhjNhRL2n+d0ej1oj0HZBmfz5GysGLcHqQMtLoUMowU7p8X2da?=
 =?us-ascii?Q?PYe+cDVcbfX2w8r6co8MWbHRUCjSWXh1+TJFUCfvV5vlKCExwAK4od0Riw0H?=
 =?us-ascii?Q?eu3Kwj+/CIohp7oytCQ5dW63z4twF/4PADeaiHN75Gu8Od80bwo5qgW0UCFF?=
 =?us-ascii?Q?IFpo6i0jXnqADZfbrrBaw3/FMs8q/IlZg7pPTi10RaHZiqkoqX0uVbNZpbkP?=
 =?us-ascii?Q?szG2SGxmFTvof6MDvy8dmvrp5ttGFUfgHbnd4nb4xCZhLz4ovOuYODTGYUZ8?=
 =?us-ascii?Q?4C9qkvMIiBuGTH2cEJQw0dc+h78nMijn8EdCA6BdGtxw+u7TWfjqcrfyYTQ/?=
 =?us-ascii?Q?wOpXCuyR1Zs+L2YPFv5xii7SosJSOY2kC/4KIjGJWQiPc2E/FnxyfB9pxcfW?=
 =?us-ascii?Q?Siq9rE1j1R8SgO8yl3c4FGZdXSqxlxhmuMm/h39DkLdfJpnoZhWLepM2ge2Z?=
 =?us-ascii?Q?gJOOg6262g+QiDR95cnL1xq82xJiPYh+6nZtEbzI5dIT0Iaxve6pbtuymsWa?=
 =?us-ascii?Q?XTRUQafS6s6Lie1ZGsOM8EbEemruf9UYskBK1doYl6iSgBP7tFWDeCWKshCj?=
 =?us-ascii?Q?bs8UsBGiV3Gw5mtUIYwyXDywFlAcI+JUz5a9i3vKLwgRP+A3ntZhxv3QCKYv?=
 =?us-ascii?Q?dTorufS2w7nPgNnmcxri6WrBPfrxGyFo7QbVuX3Ls91kT0BsHrYhEyfmhgQ0?=
 =?us-ascii?Q?4yhirH0d98AcxmnQW7t3myLu8rsU/2mh5niMzLVJzRIyvRiy0cZxSXtbnIA7?=
 =?us-ascii?Q?44XRYqzjOx6XTduV2Z/N2Z8ZWHMmfsGAD3aWXp+YHh/Gqu2smpyoJM21cL1+?=
 =?us-ascii?Q?flydszl6rpZYsLWPXCJj7ozm4p1G1d/S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hpVU9F3oBwwdZ3TqBNTXz1SOnCQv+nnoCcvjki8BUVzkQQbgabOgiUZjhWrW?=
 =?us-ascii?Q?yC7yKeDlJLILNXPwaNGpZYZxjBXn4Fh1AR5K1g2f6TXag6aRPoIZ9R0ytxFA?=
 =?us-ascii?Q?XFshi4gqo9xxc9TFhL+9LRMZaP71vJd0eqH8OvjKA2+18AXDs7qQu1VBljzn?=
 =?us-ascii?Q?NFqeN00jA8eJ7Tj8zFExx+pZMaTth/+McqIcSHn6MyngCQQw7Mnw4rgiYsAr?=
 =?us-ascii?Q?Mbd/p72VHggXt64YKUtiz/HY6+w+qC/YCxeVHvmCqQcNnkjhoxGp/usDKygS?=
 =?us-ascii?Q?mYwFythiBdulhArsfwpb4rIkUSMWQVWIMDYMRqICPenAWSJhYXzCl/uojlHJ?=
 =?us-ascii?Q?9X9dRKSA2huM6USj8ZOwW3pXihTteBOa+NcJsnipw3Pa8lutnmVSXz9QGard?=
 =?us-ascii?Q?o1KHUgrD0H6i6rNm7tEWBb8uN+jK7gs4r0BfoxEdjIOIYVirK905AoU/r5zl?=
 =?us-ascii?Q?UrcAFc9U/PhubhFyIhP4/UFJMQgK7E9COnS1MJ6Fl2Q8vevspzLd3kFwKfH8?=
 =?us-ascii?Q?RvYiKvyhG2gVBnW/6fnTs5VON5SkC95REZMQPrV6iJXwOkpgz43upCy+D3Ji?=
 =?us-ascii?Q?pOhlJ8EQT1/5qo9qVPoZVSddTCNtHdyX81bsc2iPo9LnOFqIIbmlcPG+/ryM?=
 =?us-ascii?Q?ZUxaopzfqMCu5rUFxjoL1e65pg/+/qizRque9jxNoeFb3xuNRrvaPA/WG8x5?=
 =?us-ascii?Q?DgwgLJ7KUcSwxluG/n49jBPLpBFR1OqUDtfCJtrrWppQjnVHmukFZCVTP81Q?=
 =?us-ascii?Q?SbniFVelS5B9m7be9Ma4XTDlZ5EFr4OOD2/3vdiMjOcQVvJ+77hXlyC4BFLY?=
 =?us-ascii?Q?UPZheAS6jPLgttL7lAd1rZm6c/l7N+8hA3xeGJ1/kwrm2iVOaAtSzJBnu9O4?=
 =?us-ascii?Q?cktD4Du+H3a2FxDYGUMUnQZa8UQyuIVbJzxQj+6HqKIHpZzEotLnBmTk2I7p?=
 =?us-ascii?Q?+J3ehwgfMVA4ZrdF4e4r1BEk3DY/PbdOReUJkuWJRMKEu7tAdya7CkX4ecfw?=
 =?us-ascii?Q?pPFgGWpegwZCETbAe6a1Vt+0TC6n+XJ8b9eqxN4p1Gi0QS7u46wNfwsalzKr?=
 =?us-ascii?Q?hPuctmxMV6h2cqhLOVj0rDJwuVNi3iJvWmAaA+uypZ9MZTWRkGBBJHZrSkoi?=
 =?us-ascii?Q?Jgg8ZukR1fmcV39gZSiROG9Vvh4idAwjRi+KbY9kEqifHdbypjGRwqfEoSef?=
 =?us-ascii?Q?emj9H9ENscbURxzh1iEGERwjjtgDhLBF8pwHXLJCQu4UCT9KL0iGS5+Ye6P6?=
 =?us-ascii?Q?yzV6TvJFZVJrCGuuk1di8VJ0TEoh/DO8kWWrJYViz0upxOrZyeQCPUnic+El?=
 =?us-ascii?Q?dq9o0XjsrFtLaLBT8vbWJD/H8wNKakcjE7/pGpQ6HRAASqFaBgtkIqf7PLjZ?=
 =?us-ascii?Q?QMdMjaQRs1mp3ecRZ5/yoc/tJFMaFRI3JCsUDsddofHIMPxYc6DAweJjWwVo?=
 =?us-ascii?Q?LS02g8j3SznyEgFBxmwyEvFZcAHt+uGWeXsdMHfSoOMD7GdiSvp+Smdci4zZ?=
 =?us-ascii?Q?/oGgr0nhwVJb1zv3vDHltDnd12wwuZAfxrEACwlPhhpeIg7HzCGepzoTbuXb?=
 =?us-ascii?Q?U9KExqM5UQBwkHZxzrLXhO1wWLmUG1ShioRS4o7y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0802435-c580-4431-18b0-08de126180ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:25:11.6635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATe5JcKoaF4tzZxIdhhpFBzIe4O0+r0vUvHHNV5X2ZJICMPLenzAy9CVt4vbLtUeR/CTbxxLDnMO+/CW5DMRtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002

On Thu, Oct 23, 2025 at 12:12:50PM -0500, Mario Limonciello wrote:
> On 10/23/25 12:06 PM, Michal Pecio wrote:
> > On Thu, 23 Oct 2025 11:22:29 -0500, Mario Limonciello wrote:
> > > As this is an ancient BIOS this reminds me of some related commits:
> > > 
> > > aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")
> > > a74fabfbd1b70 ("x86/ACPI/boot: Use FADT version to check support for
> > > online capable")
> > > 
> > > Does reverting that second one help?
> > 
> > Not sure if it's worth trying? My BIOS predates the ACPI 6.3 spec by
> > several years and (if I understand correctly) MADT revision is 1.
> > 
> > It seems Yazen guessed right: they list 6 APICs and mark absent ones
> > as not enabled. But I don't think we can assume any ACPI 6.3 flags to
> > be valid here.
> > 
> > I wonder if some quick check could recognize those consumer CPUs and
> > simply ignore hotplug there? AFAIK it was never a thing on AM3.
> > 
> > Michal
> 
> Oh if the MADT revision is that old, then yeah reverting won't do anything
> here.
> 

I think this commit is interesting:
fed8d8773b8e ("x86/acpi/boot: Correct acpi_is_processor_usable() check")

Thanks,
Yazen

