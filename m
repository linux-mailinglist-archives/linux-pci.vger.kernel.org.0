Return-Path: <linux-pci+bounces-1072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DE3814C16
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 16:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82AD4B22665
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEC539FD3;
	Fri, 15 Dec 2023 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Qg/fQNa"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67CC381DD;
	Fri, 15 Dec 2023 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2E4et904JUeCFjfQ/k9Df5oxgxjoRP4027gLM2z+A2hMf9RYncunWK+5JJu1fUaLLNIAFJyUVFARlmyqwnCcfGSFTeTC88zmhhpFxi7ieLpe1Qw5ksZ/94C3HCEVOdCEgjnjpiFk17599iR4I/V/yRhnrjeQ/j+ejoTjLIS/qNoFak00uqH7itq3ZcZK52g9EbyErxTmf/MZzR0tARkH3QK9DMpnhUleZP87Bms9qSNjdBObFis8g0Iio1l1BUWNvRYZg08MJqWHlKq25muB1jJzDvqhctHagbEta/KT7j2O2GKKdMgfp94aMdFF27D/osKB6czpgYxDFTZH6W6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHZ/5TYstacDjlJh7CjuLrDgHMQl2d02K3FZ59UADPI=;
 b=ftOeG51/UpapkRZlcmoJZQEweevZ0zxwF5QztEDE4mpPdEEZRunGAYHQoIAv6P4huqG+qHAfC8d0azr5KqSrqIsDsdGabBKkPY0RcGMZINyD5chlUgiEAloZ+LR698dX2ahhAa9Qe9b0IksDncC8VDGGuuIFgfnRgEoV3pcierzfa033kXGQ28ILWA/K9BLcnT2U/0CSF1UIsZBl+4X6iZXYz70eUh2h3MJU4spu0Vmm5Oi48dpgdH2lbQ4VOoJ3OueoP0rMjd5iKlRzUWPp8eEZBe9UZGgjnmHys7RYPWuyz6T0OdP/OpPEuNTrl/VvxjAxH45L5AxwFindSpOvCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHZ/5TYstacDjlJh7CjuLrDgHMQl2d02K3FZ59UADPI=;
 b=5Qg/fQNaymIhMzCchM8ztogSBSGx14D/wEBGcE8Qb+nzxH8mG52ce7YmcZtTlGuQ5hBAVsmCg01tCiowktCm18+QXSKb0uO9oeKHLgdxh+6xUcEXt8fNEzFQlq7aACx2UxMHaggnm/ElUmzjtr/ijmthqyrmgAVisqeKnatSS3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 15:49:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 15:49:10 +0000
Message-ID: <060e79c3-c195-42de-9c85-e1b49a248122@amd.com>
Date: Fri, 15 Dec 2023 09:48:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/pci: Stop requiring MMCONFIG to be declared in E820,
 ACPI or EFI for newer systems
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>
References: <20231214233059.GA1106860@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231214233059.GA1106860@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: 772130a1-7cd1-400e-8534-08dbfd8560df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4tVEguPNfH4/7MgBwduBUnhmy+LYt61LQ+xpjbjy3qoodjj/us3gFNjqSOq+X/RYui1WqXZD7ElIYH0FizXWUpSigs6N9eAmL8zOMEIDf6/4MNMMrR8ZkPS9J1e5oHVKk5jGvOeVeIMD3ooIAbfN3KqANIjLdy/X/ZlC5D67SiHC9mb/lh44oDY5+Xggj9qUgIwl5+XcSOtfiT6vyn89o73EdN7ltsp6rkEj1yIfNWNjCDD6KNGXKWg2yLlj6J8gPUAiMN4uNSbWtm4KK/WKPgEdKX7IECFRKYdMhvoudzjaiNfJT86b+AjdXztp3+4DkEDloCXx2dmPOTJr8scYfHeFvbuU9jO3FFD/UOo5k/Bgb2SQjtN+sUDP+/+E68IrbNxzOXE8ON+YKZYOnpd57ua0n5tXx1GtMCi5WpX0xBpz4eIPTjEeruTG0Sl9HG06DzO+xeBWnvpxoOP0RKq+ekHjvbktyZNrNsVXRU7woEuXgCBjrnACCMlqsCHMK8ZoXumlgKeLnXM37k5mI9A8vdUJMp20IFo3XrBQNSQs9h3u0vXXTvwMwWEcmxJw2R/QUEB1EivYxrWFtd/TLQCrYV3q4l7aENuo5hz3Ij98c4vGrmPL8asMfy9pqqmR6KjZSIp+MkyjCl3gW4zDcjN4ww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(2616005)(83380400001)(26005)(36756003)(31696002)(86362001)(31686004)(53546011)(6506007)(6666004)(6512007)(478600001)(6916009)(316002)(66946007)(66556008)(66476007)(54906003)(2906002)(8936002)(4326008)(44832011)(8676002)(5660300002)(41300700001)(966005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEk3WjMxTnlYd0MySUx3WlVZa0FwWEVIYmlEcC9MWEJFc0FpMGF2TzNZdEZq?=
 =?utf-8?B?QkRlcjFqdlc5cElRcGc0TE9ZVVdNY1ZaVnY0RjJObVNoQ3JsS1RZNmdOT3o0?=
 =?utf-8?B?dmxuNitXeVBhUVhscmJTb2JmeGpMamhqRWVha2FRaWtLZ3JONkIveFV4c1lJ?=
 =?utf-8?B?ektVMGl5eDcya2RFSkhMcUpQNjl1WHdkS1dESW00YzZUQzlSellad2lVWXNq?=
 =?utf-8?B?Q2t1V3RBVFR2Z2JwSDN0MWc4cUsrczR2K21kRWZKSlZ1OVp1d21BSEZNSThq?=
 =?utf-8?B?VnpsVkhoOFFSNU1Vc2p4dHY1Q3JaYnlodzc2aDErSVR3eklIRWV4U2FXR1RG?=
 =?utf-8?B?SGo2T1k2WXo4TU1XTFJLOW9IYkdoR0RaeG5vbXozTWZuUGdhTGxXWTVScHJP?=
 =?utf-8?B?VldTQ0Q3SjBZdVNITmZ5SUFiV2NqdDJuRTFtZTVrNzV4cC9MRldmRE5WTTBB?=
 =?utf-8?B?Ym1NM3NpTjN5MzdYNDlkWGhGWlU5TDkxNmNZYXluTVFQN2dEMktscDdlN2t0?=
 =?utf-8?B?VnpPL3JtdmJkeW5nMVNVVVMwWGQ3cTBhSVBYRkk3eEtOTWZOclhWVkFEQVdt?=
 =?utf-8?B?dFhUdkIreURReEUxT0pWMlVHS1FpeEUxV250SDlQbG1KZk5Jb3h6eWtJY1Bk?=
 =?utf-8?B?K3pzRDhsMTB1M0ZPeFF3dlZpZElzc1FEN0xyWUVvWmNTUHRaUmdXRFcyMHRH?=
 =?utf-8?B?b0pPUStHcXFKOHJsdXZsbkJPc3RtZ1dFOW0yTTdTa2RnRHhyMldmbVdZTlV4?=
 =?utf-8?B?MkwzQVVZcnduZjdHTXQxQzR2b0dHTll6N3RKZE54TE9YUXlkVVRKUGlNSE9K?=
 =?utf-8?B?bWphVGZnZzJZek1pRHc0ZitVbzNudFFudE9Tb1grRnBhMDd4UC81c3d4eWJn?=
 =?utf-8?B?OXU1TnpyRUFyM3FOUEI5SW5id01tZ0VRME14am1sZmRGQkpyNTFnbjZoOFRi?=
 =?utf-8?B?MitGLzNNL1VpRlE3VTBhWmx5ZXljRE5yS3VObjN0UFNhN0h2aHd0MTI2Skhm?=
 =?utf-8?B?K0hwR25xcFJxNk9GN0ZEUHMzU3gxSUN2SU5kYmZiWnYrcWhaYlYwSVdjbnBy?=
 =?utf-8?B?MHBKelM2UllxZDJ0eHhpYkVqdENGeXh2akRadFFJYUxXaFhwRzBNM091elhj?=
 =?utf-8?B?OXFYRktoNFRvMzZVVW80TVc4Mnl1SlFNRXF3Z2tsVkdUcCt6RTJjcGRzY3dS?=
 =?utf-8?B?K2Y5SXpMeFBUVjgwUFg2b0E1WlU1bWFYWWFSZFh6VHlzZi8yeE9vb1VXQmFG?=
 =?utf-8?B?eU1zOHNNMnlMQUZ1S3h2S3VTZVZ2UVhoVDhQOTZFMEhMbjkvQnhjMldQaXhu?=
 =?utf-8?B?TXU5RzU3M0NGU1JWN2VQaTJxRHViS1JVeWJHd3E3Z3Zhejh3b1JKTjdSRnhZ?=
 =?utf-8?B?YmFsenZVNGxPTzNvcFREZEEyMTgxNk9jZko4MGYvQ0JwTi81OTR0QnVyckNx?=
 =?utf-8?B?QjRmMVVUNGlRQjlXa0UrUWFsREt3TWhGZjE3bkFDdU5qQ29qMGd0T2lKNDJC?=
 =?utf-8?B?Qmh2ZUsyUEs4SE9sbXByVXAybnNrajdGRE8xK0hoUThJV2wvdndxMGJlK1Ba?=
 =?utf-8?B?MUppMVZPWm1GN1BGUThvU3hxNGYzcjVEd2t3M0NSSklNQmVEQWU4em4zQ053?=
 =?utf-8?B?dFFJSThaMDBhR3dTVFBJUVhxUGUvVVZmR1ZUclB4bXA3VHorME9MQnIxVG1p?=
 =?utf-8?B?NVQ3bU9PcFdiMndPbUd0Z3NWc0ZzR1kxWi9lVU9TaW9ZeTRNNGlNSzRIUVFD?=
 =?utf-8?B?d1cvNE5Galg3cDdYRmJVRDF4WXBVdFVCVDlvOW5XK3NlRldVSVl5MExBdVFF?=
 =?utf-8?B?b3RkMnZUcExLVFJZT0kwQk54VWNqbkJpVTc5WjNkK1N4eitBSEtvZWQwUndW?=
 =?utf-8?B?Q1FBTjFLSW1UTVI0N2ZzQVpxaGkveGc1alRaZTdNMGVLWWFHZXBaSHZKZVh3?=
 =?utf-8?B?QWZLNVh5U21vMG0xNFZyd1hwekRmQmVJZWIvSVJQTEZzelNOM3BZeGx2NzB0?=
 =?utf-8?B?WDFnNFRvdFpaYTllbFF1UVVJU0J1TW5mZEZsTVc4TDk2QmkxME1yRDJMQWNh?=
 =?utf-8?B?RkpvdzBkQmpITTVjTDRxV2FwN1A5cmN6Y1pWVFA2REhBRjk1YmcySmlOTGQw?=
 =?utf-8?Q?zDTHEmJddVH2EbsYUckvsa8kv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772130a1-7cd1-400e-8534-08dbfd8560df
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 15:49:10.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yng/9Lw3BLvitylxPdDyqa65nyQi4NbZSVVpXs6hCeKuYRLt+Awa/FBnbRBJi7K1IXha8nGnrwBZMt9iLZFqFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565

On 12/14/2023 17:30, Bjorn Helgaas wrote:

>> I'm fairly certain we're just getting lucky in Linux on a lot of
>> devices that the region is often overlapping with a region for EFI
>> runtime services.
> 
> Ugh.  Yes, I'm sure it's not an isolated problem.
> 
>> Given the severity of what I've seen it can do to a system I'm
>> proposing FWTS to move it to HIGH:
>>
>> https://lists.ubuntu.com/archives/fwts-devel/2023-December/013772.html
> 
> Thanks.  I don't know anything about FWTS, but I'm a little skeptical
> that it actually catches this issue.  It *looks* like FWTS builds its
> idea of the memory map from a dmesg log or /sys/firmware/memmap, which
> I think both come from the E820 map, which is x86-specific, of course.
> 
> I don't see anything that builds a memory map based on _CRS methods,
> which I think is what we really want since the spec says:
> 
>    The resources can optionally be returned in Int15 E820h or
>    EFIGetMemoryMap as reserved memory but must always be reported
>    through ACPI as a motherboard resource.
> 
> (PCI Firmware spec r3.3, sec 4.1.2)

You're right; it doesn't catch the "root" of this issue, it only catches 
specifically when the region doesn't overlap with an existing 
reservation (like EFI runtime services).

A more thorough check would need to build a memory map.

> 
>> What is the actual *harm* in just using this MCFG table to make a
>> reservation when there isn't a PNP0C02 _CRS region declared?
>>
>> At worst (a buggy BIOS) you would end up with hole in the memory map
>> that isn't usable for devices.  At best you end up with more working
>> devices without changing the firmware.
> 
> We definitely need to work around this in Linux, and your patch might
> well be the right thing.
> 
> I'm a *little* hesitant because all the code in mmconfig-shared.c that
> attempts to validate MCFG entries suggests that relying on them
> uncritically was a problem in some cases, so I want to try to convince
> myself that we really won't break something.
> 
> Bjorn

As I mentioned in commit message this type of check was first introduced 
in 7752d5cfe3d1.

$ git describe --contains 7752d5cfe3d1
v2.6.26-rc1~369^2~18

That's roughly ~2008.  This is a long time back; IIRC it's before MMIO 
over 4GB was really added to BIOS in many PC platforms.

How about we build an escape hatch for users to put on the kernel 
command line in case of problems to restore the behavior that enforces 
reservations?
Maybe "enforce_ecam_resv"?

We could keep that around for a a year or two and if nothing pops up 
tear it out later.

