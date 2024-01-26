Return-Path: <linux-pci+bounces-2601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A752583E2CE
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 20:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341361F24C37
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 19:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D970225A5;
	Fri, 26 Jan 2024 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4gpouSMf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFAC1DDEA;
	Fri, 26 Jan 2024 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298431; cv=fail; b=GEdKL0ljedNgSls7g5dtgrk+mgX34LDNy96UA8cUqLTobkU8hPUhVmKNX5Jivd3Y7WRIt7jRZC3VkuONSPG956GSdqgeqp1wzV4eTcdIjsENDg9Bm3Lnz2PwLoI0NBRQQ8wD7MPm3gNWnd5Zcq6/UUlbhd6Fd0I9emK709Uequs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298431; c=relaxed/simple;
	bh=YTiSJnFShliZOoNVASfe5bIqOtBznZxnfJpJ6rCtpKY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SYD54WodpRx0J77Vzag8iZ0mhSvrVZ7Xsh21Z6BjaMxk2yAI0ieB1IyKCooni0thQHhoVmc2a8zm9qip0lvl66LYx7HCamEAs+/PbM/IZ1SftZgRn3A+iDz1lBw95H3Gt8RDo2kMntk0671tgvELFlB8RDMm6xvqxO6H1VDqZ5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4gpouSMf; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOWWkBgvJ8YFKC5Mha44tDDpKxLrq3Ahi7fP7att177ZauOUtlXOqcwqnnpLUrC7wUpzmM7nFIx9iNKGHlOmcT5LaPbIIf8ox7jdu9WJpfz++jPoLqnucx4pI35dSii9QWqpovjJRcjVPy4P7HbMnfUb2nnGwhT6zcRZkcIPUmw4k3SvfgVxbj50K1FwSGaBNiIJ30fu/7cXg7E4Dmh6jCyzpvoPtz3+jFTr+m+BX3TVeoroyJLiJNdYyg5qrWVWOru9WnINJcK7TWDtmdLGPhfHF5Uxy9kUX3yOsb/NT6rC69U/J86tuloMWfViDXfZcUUG9/Ub50+qUwTfrUnIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qaea1QFZTl2g5ENZZljnSqyxHH1bB3iasJjFUGnolo=;
 b=NNMQAvBaF0CF2r4Gy5qkGCXMowWpS4HKfa/8Vm9JUrKwZmwEmthfMKwjN+dbY9qp2mAlAKBNQqaQWAX3A36MuCDgqXgC5XkxcpOfg7sZhrY6ovb3lbxebvmt5y+Q3l1EnGIzxBBPSdcfBvWYH1ktR2H9hHe6vr3w1+hHsIJb0RdzWqbeIUReWHugzQaD89wO8GwFYTsGVGUvNFiQ6apLANF8qI9/Y4VdfPtXpjAydKfpf7JuFIGVcjWQ2IcYi1XkMyaKVxZ/tEs3xr4u2DCUh5g/LiVFkdVR0vsuZ3imUl609961tWDEFXJf5eAJcXGP+Vw1Ow7E7gv9avyLjLc/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qaea1QFZTl2g5ENZZljnSqyxHH1bB3iasJjFUGnolo=;
 b=4gpouSMfBOcrsrpYZ7SsETe0CxRcmLaGnxld03UNedetNSrskVJEvfY/lLi39LYFc7CXOFILEUByBcmL5G0TANTJhY1KkOYNamwKWYC+AtJG81Km3NL1K3oKi2T2cHySMEbZBswFYLJj7s1KmAPlc3I0GGVe2Aq8aEqOUDzWVqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 19:47:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 19:47:07 +0000
Message-ID: <167f6083-4a79-4527-a0c3-3df74ae5d15d@amd.com>
Date: Fri, 26 Jan 2024 13:47:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/pci: Stop requiring ECAM to be declared in E820,
 ACPI or EFI
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240126192937.GA448790@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240126192937.GA448790@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0043.namprd17.prod.outlook.com
 (2603:10b6:a03:167::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: b8229b0f-b5bb-4e4f-768f-08dc1ea793e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	axcrlN9i1W2ljUpixE4r72jwXOsjnsFV7XOSiPTuVIhFk3F0B4293Un5VBObEXsfY0NFdezl9SyJJ9i8gj2YJLb7HpP0yIgaM7Nj3ao5ZdnGxGDHuSWX5dWE3bmKPaTG9r4AZlZrhKEHSya1/pGLMpBpOICTP2WOGh8uWnTKpqAafTDDuH/E0iMpimauJ1t5ZJH6QDbKs2OQ+uYZZs9gNgUm0CjO6M3ySQv+3ntCxPV+zCFUIX4Z6f3GInw4v+LAC7H8/bDr+fLurXP4vwQ7RpGP1lGht90+g/jxWPYdShcZFe6FleowLFXhDSZP4roYxl4zYZsOm2Le0GGApD5pPW9uT0qbU70bO8fVpCnqVLm9UndVQXZzn7RhnFmTwBA9NS97hy1tujnc6/YnKYRvGcX6wMPALk/IW6rMrlthjLTYBfVCf1UJReW21GqUW6ea/avW7sFnw1S/NUaRQfUs0ez7VMiENf2DaAZnErtgruZXAlFzR25uLHhFTfxUy+n60uAOrg0fo9Cedp0UqKpP03PYgCFP2o0xRTwZOFw9jTrlUD9+blMEneEeFFgiJnN1Tnk0e9GHPWYJuxc60Tl4b/d+OIKwdqrd+93+d55gvUDCFabWdY2iz9EAQ/TJkIAzhryKJUipKzsqoUIIoa92DTB3Z6NUdd4iXmsx4mRb3Zy2LI6STWN6IsHYqnNA9r8J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(186009)(1800799012)(451199024)(2906002)(38100700002)(36756003)(6666004)(31696002)(86362001)(41300700001)(53546011)(6916009)(54906003)(6506007)(66946007)(478600001)(6512007)(6486002)(316002)(44832011)(66476007)(966005)(5660300002)(83380400001)(2616005)(8676002)(4326008)(26005)(66556008)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3lKOEZMTEQ2eE9UVFNHZmtwUm9FVCtNNGcwTzIrYXk3VlVOeVZYRDU4RWhw?=
 =?utf-8?B?d2Jzb3JBYUxIa25LTXFEWjFuMGRFY08zV3UycXZvb2ZvNmV1ZEZyNVExT2ky?=
 =?utf-8?B?bFI1WXBxNmZ5c2pUanZEc3A5STcyRWF5UHBLcG1sRFdTV1BBUjhxVjlCQnB4?=
 =?utf-8?B?VFhUeGVEczJ0cTE5YUk4QkcwYXpzVnM2TW51a3l4aE4rMzQySWhwMzFQSFBj?=
 =?utf-8?B?RHdHYTFVak05WnBLOTVodDg3TnZYVzdNTXZndUF0cVVaVUNhZS9iRG43M21E?=
 =?utf-8?B?d0xuelNOcXQyL1FoT2xpbGVRQnQxd1FzditiOWNBbVpWWG5oZldzQU5tZ3ht?=
 =?utf-8?B?L21jVkVOVnFrV1MzSDFEV2J5ZXZISUpBZnNpdjJ0dWo3RUk2aE1YaTZSd3lm?=
 =?utf-8?B?cTNqblVWclV1a1NlYkJpWWZXeGYyc0ZtcFhUTUNEWEJsRkkyVktGVXdiN0R3?=
 =?utf-8?B?WGlqR0pNbWx0WXM3ZWtJQ2RLUlhKSkcrVzhPQXlGYW1wT2t5b3Z2V0Y4T01B?=
 =?utf-8?B?ajVKR2d3YTNROHZNTEIvSmI1bVpva2thVGRTUTlTK1ZEMFlRZXkzMGhsbndy?=
 =?utf-8?B?dndPbEpTRTZWNG1Rcnd0UnByTWtsYzdJMDZwUU96bUpKVUdjZ0lhaTJTOWpU?=
 =?utf-8?B?VlB4aS9XUFpUa3FHVThMVXVKQXBPUURHSjNBVHNEZ2t1SDl6NjVyY0tKSktx?=
 =?utf-8?B?N29Nc1JEUWVoNzhHL3lhbzJFR2ZSUDFTVnNjV1cvcnVLMGxybVVhSVB2ZDlq?=
 =?utf-8?B?T3NwUWpkbUlHZU1CdnNOSUxPaDlodWRXYnV3cXNTWFVtSXYwc1UybTFNK1Mz?=
 =?utf-8?B?c1NGZDhaM21GVEF3OWd2dThScC9wV3pveTNYV1pjZUNsTnMzRWF3a3gzd3h1?=
 =?utf-8?B?ZFVjcUxLVDdUN0lxL0JwYTM2U3lTTUZCYllYSVVySXJhbFloSUhEYXo0VFo3?=
 =?utf-8?B?WDJ5RmlaZW9hZFVyRnh4WUlFbG9NakJERStPMFpGWHYyb3NGNlgzVE1xa0Zh?=
 =?utf-8?B?WTBxUHQ2eExtM2p4MjlVYUF5ZjZYbDJOS0gwYjR2T2Y2TlorTWt4ZVpHNC80?=
 =?utf-8?B?bGxJUVpGVGQwMzZCQ2JhOVB4L0pOcnNybmVNdHY3bS8vQkQ1c09yVkttWXNC?=
 =?utf-8?B?NHYveGxBZVUwenRpaTZYWWlkZk1CQ3VQN3dyZzVtbFNOVmIvSW9mUXdDQThN?=
 =?utf-8?B?dXZjZ0crbDlzU25MQXc3UjZ6Z1k1TWRvcVJQczU2NFJCQ2hFRmJHMDFjaW5E?=
 =?utf-8?B?dVNac05WVlBPREtQYW0za1MxcUV4Mk52THBVWkFWWGc4dlhhc3JBUTlxVFFG?=
 =?utf-8?B?RTVPQUNTZ0FxbkRRcysrZGFyT2pBVTNIY2FrSThQbE56SmRBQzU5YUhpZGdC?=
 =?utf-8?B?QnVjY0h5dWtBOUIvcXBReEJweFBIa080VTRRalI2SmtHcHpFLzU3dlBXU1cy?=
 =?utf-8?B?Y1ZmTENHYS9nYXF3L3gydktiTnB1aVZKUDVFcENicEVTd2RZWEgzNTBHY0hU?=
 =?utf-8?B?Y3pFWkx1dTd6QmZtNjBRaHZ3RHEvcU8yRnY5eGUyZ3hKbzRPM2lycFNadzVR?=
 =?utf-8?B?Q2tFVStaNjZtNW9naFdaYy9adjZOWDQ2WHdDeEFEcGc2Nmh2clBGYmQ1elpL?=
 =?utf-8?B?WGhSdUt2bFU0TnV0TDlxNWtVbWVoME9oYXlDWTJuc2xDNWJQT0JNTFp1MEta?=
 =?utf-8?B?THNxb3BuZEZkTHFBODhzcDhBaStldm1Ma0JxQ3QyUGlEVXF5T0o1cFJJd3Bj?=
 =?utf-8?B?Qll2OTkvNE9zKzN3SlRhWVZ3a1VtNUxTNW9OTlR4emdRNXZlL1BZRmN5WFkz?=
 =?utf-8?B?VU9iaE1DRlB2UDBLTDdwbU5peDJIUklIQ1ZNbDZ0bXhlMHJWNHhIRThsdWcv?=
 =?utf-8?B?SEs2Qlg1QVZNTXl5cTJCeVlYcStPNnpuSWYvaU5kL1VldlgyOVFCekJ6ckxn?=
 =?utf-8?B?YU84YUZvMmk4OU8wV21JVHlvcktXTjdsUlEzUzFDTHM4aVBJL0lnSGtjcHFH?=
 =?utf-8?B?S3dVRnV2cHZjOWk0VG0zUVVRc0VqUmhrbHJXMVBxS1prcTM1MnkvdEd2YTVZ?=
 =?utf-8?B?Vm5LamhQMEMvbThNVHU4Sk5YOFUzUUVNcDZrWndTdFMxRWx5dkNveDIrdDlx?=
 =?utf-8?Q?u7w4RAyV35fQlG8+j3l0BY17f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8229b0f-b5bb-4e4f-768f-08dc1ea793e6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 19:47:07.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuADRtTg9wezhOMHPfgoi7/zS1mpg0zIdU/sSDYlrFtB8uDIQvxLRw2nA3XM1+91/ywXCN9GrShHLsiAnKNFVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596

On 1/26/2024 13:29, Bjorn Helgaas wrote:
> On Fri, Jan 26, 2024 at 12:32:34PM -0600, Mario Limonciello wrote:
>> On 1/25/2024 18:35, Bjorn Helgaas wrote:
>>> On Wed, Jan 17, 2024 at 11:53:50AM -0600, Mario Limonciello wrote:
>>>> On 12/15/2023 16:03, Mario Limonciello wrote:
>>>>> commit 7752d5cfe3d1 ("x86: validate against acpi motherboard resources")
>>>>> introduced checks for ensuring that MCFG table also has memory region
>>>>> reservations to ensure no conflicts were introduced from a buggy BIOS.
>> ...
> 
>>>> Any thoughts on this version since our last conversation on V1?
>>>
>>> Just to let you know that I'm not ignoring this, and I'm trying to
>>> formulate a useful response.
>>
>> Thanks, I had been wondering.
>>
>> FYI - we've also added another place to make noise about this ECAM
>> issue in AMDGPU.  This warning should go into 6.9:
>>
>> https://lore.kernel.org/amd-gfx/20240110101319.695169-1-Jun.Ma2@amd.com/
> 
> Looks similar to the PCI core warning here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/probe.c?id=v6.7#n1134
> 
> The comment says it doesn't work for devices on the root bus, though.
> Maybe it could be made to work there as well?

IMO it's not loud enough either.

I think it's better to keep the both, here's my logic:

If someone has this problem that prompted this series the first thing 
they notice is problems "with the GPU".  They'll probably start looking 
at the kernel log for ERR and WARN related to the GPU.

> 
>>> mmconfig-shared.c has grown into an
>>> extremely complicated mess and is a continual source of problems, so
>>> I'd really like to untangle it a tiny bit if we can.
>>>
>>> One thing is that per spec, ACPI motherboard resources are the ONLY
>>> way to reserve ECAM space.  I'd like to reclaim a little clarity about
>>> that and separate out the E820 and EFI stuff as secondary hacks.  But
>>> there's an insane amount of history that got us here.
>>
>> I guess you know better than anyone here.  But if my idea is
>> actually viable then the E820 and EFI stuff turn into "information
>> only".
> 
> That would definitely be a good thing.  I would like it if that were
> more obvious from reading the code because I spend waaay too much time
> staring at that labyrinth.
> 
>>> The problem we have to avoid is assigning a BAR that overlaps ECAM.
>>> We assign BARs for lots of reasons.  dGPU and resizable BARs are
>>> examples but there are others, like hotplug and SR-IOV.  The fact that
>>> Windows works is a red herring because it allocates BARs differently.
>>
>> Have we actually observed a case that assigning the BAR overlaps
>> ECAM region thus far or it's hypothetical?
> 
> Yes, it has happened.  There's an example in the commit log here:
> https://git.kernel.org/linus/070909e56a7d ("x86/pci: Reserve ECAM if
> BIOS didn't include it in PNP0C02 _CRS")

But so in this case; if there was a full ECAM reservation made from 
MMCFG instead then Linux wouldn't have tried to put it on top of that space.

> 
>>> And of course, if there's any way to solve this safely without
>>> adding yet another kernel parameter, that would be vastly
>>> preferable.
>>
>> The kernel isn't static though; something we could do is keep the
>> parameter around a year or two to get the bug feedback loop of
>> people testing it and then rip it out if nothing comes up.
> 
> Yeah.  It's pretty hard to remove those options though.  For example,
> "pci=routeirq" was added in the pre-git era and probably isn't
> necessary, but how do we know nobody uses it?

Detect it's in use and drop a notice() or higher into the logs like this:

"pci=irq has been deprecated and is planned to be removed from the 
kernel on YY/ZZZZ.  If you need this for your system to work, please
raise an email to linux-pci@vger.kernel.org"

If you give it ~2 years, that gives enough time to get through about
2 LTS kernels.  People who need it by then but chose not to report it
still have several LTS kernels to fall back on.

