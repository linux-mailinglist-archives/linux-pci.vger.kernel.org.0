Return-Path: <linux-pci+bounces-526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 397EC805D58
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 19:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAF81F216C0
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 18:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A9D68EAC;
	Tue,  5 Dec 2023 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5jYgdOvf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955AAD67;
	Tue,  5 Dec 2023 10:28:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcjQ8jNea4Qo3nVmZ0FYoFUYoj3e5NnIC1H1E5PB1rFa4lc9YYZ2qt2xmg2XsiSe54wA3e1nawyTj1JnCNAfD7VK7yr5XWBtZEYyO+FFp/yXR16l/ICcVELCyrC/aBePzkJvghcrrWbl/kIgZfAX5kNCpxwLLfiu656/VlLLteHYawHX4yXxDo+dsLF7fxDTrjHiVBditop4S/MakLOkxtLkPEwyL3A/Trtj0p/g/kcJnRLqbpF/7e/ducxP10rl9qXlNIOs45CJJgCkDuVuaaqMwAiP6Xtmi3fO5c4u21jx9rzsrNhp9SoxBfDOg2uEba4ORpUl2NrY0w4zhT5Cvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQezLADcaqDlysCMMD1q6g5uvYJDb0BkvEN6ef/K2M8=;
 b=ILrqyc5nuN8VWwVsT2nK6D9EeRREWFuoCoxWhpXCIrjYD7Y7PW4WJk2X8wFTXVKiSFtcWrE93NIdf3L7NfAZIoYY6jRPzymjXPmJqx+51/RaI//J1e074S9O48uIy8PVgrAwM6aAVd+W6SB2ycQc99MYpZGGTdIYalOFLWhdvsaHKNnljPwPpBfuio27abo509fKeziy3nb9fduJ/S/QSJBjQpj4hzNox3otu/KJteita6nXkmws3+tDhTr9tebC9gaaAI1iNse7TQyJFohnoCHp15cZTCtxoXoSo0bWQeg+H2fH9WnQ/ie5vMqB+yV/CnnWtLDWZUx/hgESg5qLdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQezLADcaqDlysCMMD1q6g5uvYJDb0BkvEN6ef/K2M8=;
 b=5jYgdOvfJvHVEtpXiiSlDfARblc95j1L/pu5PY6YfKk3popM5lsKGCLiOSG4QSUfaq8nA/DnuEcPwRhNw/UUKT10gojx+zXpRuJiq2s42TZzCkd5oULaEIgvzNq3YJQOLjq8PCbaSq8gFW15hk0l94rIltDn3/Dj7SNVKUs+9ZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 18:28:47 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 18:28:47 +0000
Message-ID: <7e730edc-2251-4f98-afc9-c8278157c894@amd.com>
Date: Tue, 5 Dec 2023 12:28:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/pci: Stop requiring MMCONFIG to be declared in E820,
 ACPI or EFI for newer systems
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231205173152.GA680118@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231205173152.GA680118@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:5:174::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc808d0-c1ca-493d-c248-08dbf5c004f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	snKHdGrP071c2r83TiyUAp5kJQJLRRi9LWVWKO1anaNhkbgZi00rf/A58UwkYY/exxuE0OVH8Iga3oA2HufqBneaqEbfhqEopSy6cvtdGvtX6z20g3Mrx+BA7KCYhv8wtCCKrahNSCI2JsMSatJNn41mwFapFx3eh7AzDU24wMfp9NuUwU12qBaoWQxS0CUeEKH6A0IWpyPBIgxhRM4VNZhC44U81gSDdIW11VK+v6UX1V9lNGafeh1tZNT/1MYYktu5EFszV8hOkoPbEfb54Tpj+7/8b/szJXqXkKjiCxov8l7FD7TeCT6pGQr84QHQQdAcRAx3pmfWt9aVpuV31XyA+mvyUqG1l8VMgLqvpUJrt7T7ihzbTdOBHi3IzcRTV6owxmi1jfGBWj2iwUJz0+Nbk2YTxXQKiwMusVjKp8jbQEXsJABcDIP5effCD5alSCDQKI8V9ikPPivYFnsYvkh6vSMkykxIxmRy67QFfweZk8jc1p2WXQgqq8Eojtc1LyhcU4MtZ7R1eHdNRIqcUpL8UxIVSyoQgPVlMYjTgn4Ycg2p5pET7myA2VJLEGxEtsuUYl9WSfMLXh52R4mUCY8kX/1Ws6WIzBEeY/5qH7+cxqCWkvygruF/YotB3kPMSqGrwMEZkRoLlCRbocjRbUWXiS2ZPD//6kmm57+tJ/2G1lZSdAPa9sQ7j1Qec8Bb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(44832011)(31696002)(2906002)(316002)(6916009)(54906003)(66556008)(66476007)(8676002)(86362001)(66946007)(36756003)(41300700001)(8936002)(4326008)(31686004)(5660300002)(38100700002)(6486002)(83380400001)(478600001)(26005)(966005)(6666004)(2616005)(6512007)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm9MUHlqNElLRUQ1OEdDTVhUZ0E4NlhzQldTUTVsaVNWNlRoQitxVjMyZmdz?=
 =?utf-8?B?YkdvMjJydEFUU2FEclVDSDc5M3JIUks1LytWcGJNYjdRdXExYm9CQXFRc25T?=
 =?utf-8?B?S0ZGUGZWNHJDQURvL3dCb0dQVmwwT01KUzlNQWxBeGV0OFQ1SkQvaU5NVlZr?=
 =?utf-8?B?bVA2bVZwOHNiY1FUNW5LeUt3NnlGcExqK1Q5aDNPd0U3bk5CN0hRRHJRWVpj?=
 =?utf-8?B?SjNma3kwRjR2UVAxbHhpbkdxL3Y0UUdJS1RmNDRvSFAyaVFMa2ZaMWYzcHpj?=
 =?utf-8?B?a1VGTThDK1AwOFNFYzlqMnp1UHkvaVI2L1VWc21HV1I1OHErSnQ0djQzSSt2?=
 =?utf-8?B?Z3pHZ3VyNnlpN1BBOVlEREJQcXBKWjkvTmhLT0RqMFd1UTAwTHV2L3VJaXpZ?=
 =?utf-8?B?YUJrTkV4bFpGSm9pcC8xK2phdTFMZ1hZcllOdXlGTG5MM3p2ZmRjcTlscndl?=
 =?utf-8?B?cmMySUtFVDIwVncxekxLOWtxeDBuTVN5cENCVFNLc21YRGgzZVovekUrRFlM?=
 =?utf-8?B?dEdJUU1BNHltUUN2OWI2NVZ2U2ZRbmk4T0lrdWlnaERMSFZBL3Q4cDRORnVi?=
 =?utf-8?B?dUdWMktMeDFUakZQZXlhNWZNTHRVRU9lR3VCVkdudFViaktjNmJEVW1HdFI0?=
 =?utf-8?B?MjlTWFd2T2c1NTY2UkpBSjQwK2tJNUE1ZEw1bVRYVWZPSGIxSFhXTm5wZk0z?=
 =?utf-8?B?bFp4YU5HRkc5YjZXVDJJR21kYkhsUmxTWDhZcTJmMjRCT1pvNVgvUm9nRXZS?=
 =?utf-8?B?WGdCYUc1eUVmNm9MMFdNSDZCS2VlZEE5VjZyTGh0djEyS24wSmNseDVRcklt?=
 =?utf-8?B?MTkrRFM4Qk9nL2VSYk5mYyt6VTVLTm91OXEwcTVwVnAyNkpsdU92NXBSWU04?=
 =?utf-8?B?K1BlRmVJK1lmelhHbGNTMXgzY21kd1AvQ3ZoelpKWU5SMTMwSW1CLzYrbXFt?=
 =?utf-8?B?NHE0cUthQjFSOHVIblMzeitkemtCUDA4aWE1cVpqZ2grSVprZ0ZMTnRaS0FI?=
 =?utf-8?B?TDdGOHFuRHJNQTY1VmYwU3EwcCtVM3ZCUGxvejJXVkhEM3ZZRkp6YktndXJU?=
 =?utf-8?B?NmVnZnlDbU9hdnJVd0RsMjlINVN5dHRYZ29xYUtGVk1NQXZCTEM2U0NBWHc0?=
 =?utf-8?B?WWI2OHVmekxvZllaR0RJYlNPaHQwMTN5cm94ZGtuakU5TXhueHZrcTc3REUw?=
 =?utf-8?B?NlZsYVh1RXlVOERXNDExWUd6ZHhwdXVaeXI2cit4aTdzNkxqMnZ4TjdUR1ZH?=
 =?utf-8?B?eG0yNDV5TkRGcHcxc2c1S0pLRG5RRnlodWJvSUZ1N1B2WmJsaERiWlBpR1pW?=
 =?utf-8?B?VUNtdUdhMklWbHVJTnlaeTRUa0lWejJkQm1qd2xYeUxxOXlYdTFTQ1Fhb3Vl?=
 =?utf-8?B?SzRwODhaNnk1YnVkMDB5dWRycWpwVWN1VjhTVkZ1U291UmFyaHZJMmFSZWRr?=
 =?utf-8?B?OHI0WklwM1VoRkhNeUZ6Y3lZSndmOG51VTBQSURJSG93bnB3a2hYWkN0ZXp0?=
 =?utf-8?B?MFZ6dG80b1EwdG9FR2JVUkd0a3Z5ZVpIM0kwaDd2bUhXUG9zUjI1RXA3ZE9H?=
 =?utf-8?B?amJJOXlGWmVFeXErZE9VV2Zob25qdGdxeGpqMUc5SmxaTHE4dUlrbzg4d3l0?=
 =?utf-8?B?cldHUFNpSWlSUG9tWUp1OENtVExjU2c3Y0Z3TEg3Y2dDWmZHMll5T1B5VEx0?=
 =?utf-8?B?cStHT1cwM0x5ZjBMeTFiK1ZRdlVqRlJwQlUwNUhBaGF5ekdIT3c2NHFxVHdy?=
 =?utf-8?B?ZXdoRmFORXI2dTlJMXZMeGhDQklkVmZ6YVZSckRGQUkzVTNLc1hpdzE4WE5X?=
 =?utf-8?B?Mmkya0xWb2w4bis0ZE1QTURCRnF2Sk0wQ3NLYmVsOXZYQVdQcjhMd20xT1cx?=
 =?utf-8?B?V1pPRElEUGQ4T2Nmd0J2L3JjOTUzOFJua0YvVTNYL3VUUEVtMHN0b2dZSEtm?=
 =?utf-8?B?YlphNE9uYkFEYVpGUzNOZW9QNXM4VGwxd3U5S1BjbWQxOTRJaElQVXA1VUdT?=
 =?utf-8?B?S3hnSE80dGpaWGVMLzI3RlBkYUptT0NhYUpQL09BL0N0UDllM0hRMDFXTnVZ?=
 =?utf-8?B?RzBNZ0JBcXE4RGthNGdYMGM2dzI1cnRNa0hZbm5iZlBLVWJYTEpGOXFBcEti?=
 =?utf-8?Q?J3iVflRAF+ifZlnXBABMo4dJP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc808d0-c1ca-493d-c248-08dbf5c004f9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 18:28:47.0890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGeJM1NAecO8ENVJ3XF0X0Euv4lO+iOTfJ6eUIA/JD0Hu0gwLtQ+Fewv2EktQx368OU0MZpbtD9lFRhzYw76RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523

On 12/5/2023 11:31, Bjorn Helgaas wrote:
> On Tue, Dec 05, 2023 at 11:00:31AM -0600, Mario Limonciello wrote:
>> On 12/5/2023 10:17, Bjorn Helgaas wrote:
>>> On Tue, Dec 05, 2023 at 09:48:45AM -0600, Mario Limonciello wrote:
>>>> commit 7752d5cfe3d1 ("x86: validate against acpi motherboard resources")
>>>> introduced checks for ensuring that MCFG table also has memory region
>>>> reservations to ensure no conflicts were introduced from a buggy BIOS.
>>>>
>>>> This has proceeded over time to add other types of reservation checks
>>>> for ACPI PNP resources and EFI MMIO memory type.  The PCI firmware spec
>>>> however says that these checks are only required when the operating system
>>>> doesn't comprehend the firmware region:
>>>>
>>>> ```
>>>> If the operating system does not natively comprehend reserving the MMCFG
>>>> region, the MMCFG region must be reserved by firmware. The address range
>>>> reported in the MCFG table or by _CBA method (see Section 4.1.3) must be
>>>> reserved by declaring a motherboard resource. For most systems, the
>>>> motherboard resource would appear at the root of the ACPI namespace
>>>> (under \_SB) in a node with a _HID of EISAID (PNP0C02), and the resources
>>>> in this case should not be claimed in the root PCI bus’s _CRS. The
>>>> resources can optionally be returned in Int15 E820h or EFIGetMemoryMap
>>>> as reserved memory but must always be reported through ACPI as a
>>>> motherboard resource.
>>>> ```
>>>
>>> My understanding is that native comprehension would mean Linux knows
>>> how to discover and/or configure the MMCFG base address and size in
>>> the hardware and that Linux would then reserve that region so it's not
>>> used for anything else.
>>>
>>> Linux doesn't have that, at least for x86.  It relies on the MCFG
>>> table to discover the MMCFG region, and it relies on PNP0C02 _CRS to
>>> reserve it.
>>
>> MCFG to discover it matches the PCI firmware spec, but as I point
>> out above the decision to reserve this region doesn't require
>> PNP0C01/PNP0C02 _CRS.
> 
> Can you explain this reasoning a little more?  I claim Linux does not
> natively comprehend reserving the MMCFG region, but it sounds like you
> don't agree?  I think "native" comprehension would mean Linux would
> not need the MCFG table.

After our thread and the spec again I think you're right Linux doesn't 
natively comprehend (reserve this region;) particularly because of the 
stance you have on "static table" vs _CRS.

> 
>> This is a decision made by Linux historically.
>>
>>>> Running this check causes problems with accessing extended PCI
>>>> configuration space on OEM laptops that don't specify the region in PNP
>>>> resources or in the EFI memory map. That later manifests as problems with
>>>> dGPU and accessing resizable BAR.
>>>
>>> Is there a problem report we can reference here?
>>
>> Nothing public to share. AMD BIOS team is in discussion with the OEM to add
>> the reservation in a BIOS upgrade so it works with things like the LTS
>> kernels.
> 
> Is there some reason this can't be made public (it's obviously fine to
> redact proprietary details)?  It's really hard to make this code work
> for all the cases even when we know all the details, and practically
> impossible if we don't.

I just don't want to throw the vendor under the bus as it could have 
been caught "sooner" and fixed by BIOS adding _CRS.

I'll share the full dmesg below just redacting the DMI information.

> 
>> Knowing Windows works without it I feel this is still something that we
>> should be looking at fixing from an upstream perspective though which is
>> what prompted my patch and discussion.
> 
> We definitely need to change Linux so it works correctly with firmware
> in the field, whether that means fixing a Linux defect or working
> around a firmware defect.
> 
>>> Does the problem still occur with this series?
>>> https://lore.kernel.org/r/20231121183643.249006-1-helgaas@kernel.org
>>>
>>> This appeared in linux-next 20231130.
>>
>> Thanks for sharing that.  If I do respin a variation of this patch I'll
>> rebase on top of that.
>>
>> I had a try with that series on top of 6.7-rc4, but it doesn't fix the issue
>> (but obviously the patch I sent does).
>>
>> # journalctl -k | grep ECAM
>> Dec 05 06:37:46 cl-fw-fedora kernel: PCI: ECAM [mem 0xe0000000-0xefffffff]
>> (base 0xe0000000) for domain 0000 [bus 00-ff]
>> Dec 05 06:37:46 cl-fw-fedora kernel: PCI: not using ECAM ([mem
>> 0xe0000000-0xefffffff] not reserved)
>> Dec 05 06:37:46 cl-fw-fedora kernel: PCI: ECAM [mem 0xe0000000-0xefffffff]
>> (base 0xe0000000) for domain 0000 [bus 00-ff]
>> Dec 05 06:37:46 cl-fw-fedora kernel: PCI: [Firmware Info]: ECAM [mem
>> 0xe0000000-0xefffffff] not reserved in ACPI motherboard resources
>> Dec 05 06:37:46 cl-fw-fedora kernel: PCI: not using ECAM ([mem
>> 0xe0000000-0xefffffff] not reserved)
> 
> Can you boot with 'efi=debug dyndbg="file arch/x86/pci +p"' and share
> the complete dmesg log (redacted if necessary) somewhere?  It's
> important to know more about why and how this doesn't work.  I added
> more debug logging, but possibly it's still not enough.

Here you go (6.7-rc4 + that series you linked):
https://gist.github.com/superm1/eca87ae661793b9ab969829946adb084

> 
>>>> Similar problems don't exist in Windows 11 with exact same
>>>> laptop/firmware stack, and in discussion with AMD's BIOS team
>>>> Windows doesn't have similar checks.
>>>
>>> I would love to know AMD BIOS team's take on this.  Does the BIOS
>>> reserve the MMCFG space in any way?
>>
>> On the AMD reference platform this OEM system is based on it is reserved in
>> the EFI memory map.  So on a 6.7 based kernel the reference system you can
>> see this emitted:
>>
>> PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved as EfiMemoryMappedIO
> 
> The EfiMemoryMappedIO entry is not a *reservation* (this was a poor
> choice of words in the logging, and my series changes it).  This entry
> only means the firmware requests that the OS map this region to a
> virtual address so it can be used by EFI runtime services (UEFI v2.9,
> sec 7.2).

In that sense the only reason this works on the AMD reference platform 
is because that region happens to have been reserved from a subset of 
another region.

Per the stance on "static table", we should advocate for _CRS to be 
populated with MCFG on AMD reference platform too, right?

> 
>> But on the OEM system this is not reserved by EFI memory map or _CRS.
>>
>> That's why my assumption after reading the firmware spec and seeing the
>> behavior is that Windows makes the reservation *based on* what's in MCFG.
> 
> Is there some spec language that says MCFG reserves space?  I'm not
> aware of anything about ACPI static tables reserving MMIO space.
> Here's my reasoning around static tables vs _CRS for reservations:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/acpi-info.rst?id=v6.6#n32

Reading your stance it makes sense more of why we're where we are now.

Let me ask though - why does the distinction of old OS vs new OS matter?
If a vendor wants it to work with a kernel that didn't use MCFG to make 
a reservation _CRS or some other overlapping reservation is their only 
option.

But if we changed this behavior in a newer kernel then the stance can be
something like:
"upstream kernel 6.8 or newer will reserve MCFG if not specified by _CRS 
or any other overlapping reservation"
and
"upstream kernel 6.7 or older require explicit reservations".

It seems to me that this type of issue would entirely go away in most 
cases and it would satisfy the spec note about
'natively comprehend' reserving the MMCFG region.



