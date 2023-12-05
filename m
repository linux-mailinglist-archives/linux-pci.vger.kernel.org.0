Return-Path: <linux-pci+bounces-533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3541380618E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 23:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC171F21567
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 22:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222CB6E2BE;
	Tue,  5 Dec 2023 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2p+n4/RF"
X-Original-To: linux-pci@vger.kernel.org
Received: from outbound.mail.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED7D137;
	Tue,  5 Dec 2023 14:17:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj/lWqDynGdgNAHuoMjN4DEy9RUkT14aSVc9WaYe9ChuvLFzQOvACvtccj4fwEo65YkbiVHNYUKDu7nGUaFPDSW5JcBeYFJBPxJdyqa7roNZsOtjtxDMpi2s3byHtJjemC5tiD1PJB5pPxSH258asStTo1ctYw/dJAYvUHhS1vTh3Y2zjDLLJaEPFT4nPByOsuDjooAfoyz3FnJn1pZBjc8IiAN/RJuh01VZBNkK/LkVBuQOlJ38HeDxWdU36BJr8luGIczlxI1ei/WOQVbbY4fpPLK18wlN4tT+o2d/zHHan3m9NRMDvzBIs2/SuoqP5yzyxnY18/FtzYv2X8Zs+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxUbcMQ2vo2rIVzoWf3oxnZcGW3SD/HtxPXPUpCYeZY=;
 b=axXo8FC/v0hDTSU5wGLma8GeIROgkQiAVWrBzP8XceVaoEJuFUSWGhi+NGAr9MnUgb1aJ3A/4Dmen2urNPNOX2KIO/KliTW1kVeFv0Pp1ZCqw4UHkQVziJvIod1XqoyMQQpmcl8pu6daEqgCl0zC/Dj91wf3rKYMzIgqhRjJ5IH6NlJxyO+77liSYerCINHdfu1ekEg+21CIBor2PYyL4y1KOeqwqu0gtdiQz582iA0rRXUoc1nL9ewvQmMyp3YM4h50ZYY0a8yiTZ3HJn7gIWCRYMqwm5j1W1+17jOiYsTB0N6RhSDss/Ip6tgzBtH5TCilWAMn3/yQEaOwwcn8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxUbcMQ2vo2rIVzoWf3oxnZcGW3SD/HtxPXPUpCYeZY=;
 b=2p+n4/RFAuzy3NoljovzoGbRXa6Umhkaj/wbjuP/r3XjLWpkBxm4NxyufxMqoLnu6FzhRG/Y1utIOrSdTuY5WB2LJ/+XUuxIsJZjTlb0CAv3QaihOZBqhl2cQPw6OmmffJ34YwsVzdHk/PunkP9+PA10l1/09aMB2j6zjJxON5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 22:17:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 22:17:23 +0000
Message-ID: <da212948-61ea-4eb3-b7be-4023303d850b@amd.com>
Date: Tue, 5 Dec 2023 16:17:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/pci: Stop requiring MMCONFIG to be declared in E820,
 ACPI or EFI for newer systems
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231205173152.GA680118@bhelgaas>
 <7e730edc-2251-4f98-afc9-c8278157c894@amd.com>
In-Reply-To: <7e730edc-2251-4f98-afc9-c8278157c894@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da288a5-6731-4250-7a78-08dbf5dff495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HCdWryQZQzWqJo5rmxLPeXxefKVZkBypCr5TqSlIaFOiFDKWxbqytiq8ajtCNaYTBS37neJcP2CxRr54iAQoUcLQ3b35tRaDJOcKzRaKIv/GdAfB2WbGw9tsqBdT8BxPMwf7HeKJhiijUholVmsZ9l0xhtZvxDPp1NrdFMShdUpU8XEqVsYyGo3sUeCdCrwAcyC/NqDkjxbEPOF8TAPL3/SyrmtsSMvl8loKfnAp57v2Sp5u2RGVUXLjXL4FT3lsL593SfTNUoxqrwMBiw6pGLzjyiU09FWmiWkFWZZtk9qqS/uyT7juWS1pBWDwjoMqP+Far1Ga/WHMb5mc0FsYfd2HuxfQIKqFoMGrfcseNnT67TaPweKpnTayIrcXOYE6ntdRae0lUre7pq23+763bkqYkOtxNCXcuSYj/YIqDiNaRHgcZUCETJ0Ch8Zik8L/yh8dyJakWLv3acWxuytgD5qc8PFYghnbMjvTQzBk6JoHrFs7G0s8rvJmupxqoI5ruWs9TjfDTBq9RkHUho/8aUOvVrUJyXI3YU/bgj7KknyaJ15Go2kPZIpQ3xzUZjo0zamWbAnscAhywLnc7jqE+KGFl15NQoBIEumT8+T4vRaDT4mw7j/SuUvNdUzBG+lnFfh9Ik+44AGQpeEm9jQTx9i7QFXR2xn7kaVTEQSHQam/Fb3QVzd7uUvBmsoyJN+q0JdiqslRypezfT/eIt7ENUH7bgVHrjciq2ZVC/43s0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6916009)(54906003)(66556008)(316002)(66946007)(8676002)(86362001)(66476007)(4326008)(8936002)(31696002)(478600001)(6486002)(966005)(44832011)(36756003)(41300700001)(5660300002)(2906002)(38100700002)(6506007)(2616005)(26005)(6512007)(83380400001)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1hOYWZpWnB6N0JRaUtjV0lJbWJYSHNpMWxXNDcwbTU3NFNwaGFEeks1bUJl?=
 =?utf-8?B?UWRDYnNVcURLZlFIVFZidTFmOU9kYWVGSmxYMVQzQWdqNUpUclk4WTdmUENq?=
 =?utf-8?B?cFdCUzhsN0xscGNoWk1HVnhoRnR4Sk5LdUx6aGhHbzlJV1dHNkFrWGx2Qk1s?=
 =?utf-8?B?dHBodU9lbGl1c0podlM2U1pkMlI1Tm9OSURjeEpDL0Z5bU9DWTJKUGdnaVEv?=
 =?utf-8?B?NXhLOThsQk1jNm0vNW5PMVlvZCtncFBxejVhZ0QxVGROVFgrVWhOYXNhY0JD?=
 =?utf-8?B?NGo1RjhVMUdrSGd3SHVHWHNIcUI5SjJMYTVKRnQvUTJybGQvQ2VWeDVlRWtT?=
 =?utf-8?B?OVRYL0Z1eURuNjVnb2JxdWdkVmN2NkxDUGp5ZldLK2RJMmlXV0RqdGI1OGZr?=
 =?utf-8?B?blg3TTZWcy8zSGw0RDVOdUVkb0NwMWNmN012MVBreW1VU1dqZDc5Rm4zbDY2?=
 =?utf-8?B?VnZsWlZvTGYyTTFHeGV2bkszRGNzWEdpaGRIVWc0UHhIOHRMYmZNMTcvVGlM?=
 =?utf-8?B?ZlpadVNmMVl3M25ucTJHYmNFOWpQd2pVR3FXUWdFc3ZYTHA4andPQXJBNE1B?=
 =?utf-8?B?U0szRU0zRUl2aWFtdEVMVWNKQkJUNEY4T2tTcGhzYjJRZ3hsbXFicHRYQ21p?=
 =?utf-8?B?Y2tNQ2k2Z05BOFcvWXI1ZGY3dE9YYXFoZWN1M3FmOFRSMUw5d29XbEJON0h4?=
 =?utf-8?B?blI4VFF0WEh6bGhqSTRVWW1oV0h1T2JXK3JlSk1maWtQUzhhVDg1Z1d6SXVY?=
 =?utf-8?B?VFZaZm1HTEEvU3dEcUc4cHY4UW1Oa1pjNHAwdlZnb01tbjVrUENib3cwT1Rx?=
 =?utf-8?B?VFIwZ2ZZc3RxaEVpTmZqZXVGSmx4ZzBtZTYyMks2aCtISWNUbVkxUHYzRTFM?=
 =?utf-8?B?RWNOWFhJYmNaUEVpWXFqWk4vZ0hYSFUwTUxtcGZ3SmlRYzhEQkpXdmE0MFFx?=
 =?utf-8?B?cm0yUFpxVkFqeXU4VlE4bkhXSlBhdVN0ZzFOU0NBSUQrR3d1OW54U1htblF0?=
 =?utf-8?B?RHJ0bDlyTmtJQm9YWVoyUERUWUJVOGZYNmJ2eHNvTGxzcVNuNE9pVDczdGVV?=
 =?utf-8?B?dXRiWElwU2RPTnpkYXUrdUIxamlWWmxGcnI3YU1ROEUwaHZqemNUWjB3d2Fs?=
 =?utf-8?B?b1NZaVNqQjdTaWxicEY1UDljQ1RpVEdWdGoxUVYwdExHcTNtSWl6Z1VLR09Q?=
 =?utf-8?B?OXNGR3NxVjZpQ1FSL2wyM1pmOUZJVzNjQTZ1OXdvL1craWZsQkhER3RRWUti?=
 =?utf-8?B?Zkc3RllwcEU3MkM0QVZrcFJoOGJOYkt2ZGZtd3owRTF1UDZWV2lNek9sSmtW?=
 =?utf-8?B?SkxWVUl0THBIWmF1eCs3RCtBcVk3ZzhoeTJPM3c5OU52U0xQckZ6bFZ3SG83?=
 =?utf-8?B?QnQybksrc3lNQWRybTlFNmNmS2hTdE1GNU5ZWlhNVGFLa0ZsUkxHdE5Xbm9u?=
 =?utf-8?B?N2poV1cwZ3k1c3lHRWRkTktEU3FnNUR4dDNObE0xdXFHbkVtaUpUUHozKzlv?=
 =?utf-8?B?UEJlQTFCbU1jcGVzRTdTZDNVK0tHWEh2Z1VQNkxZdlRHZ3pqUTR4dG4zckVj?=
 =?utf-8?B?VUl1WjVtNXJoT0IrZ1hxNnhha2ZIcWVYakpXdk8raUpBNU5LdDZjSnBZWnJO?=
 =?utf-8?B?NlBWeWFaV2t2UVFhdmlhcFRSNjB2SjNGOW5idCtIa2swcjMrRGF4dzgzamFJ?=
 =?utf-8?B?ZktZT1RlVm9vSXdQM1NmTHlKN09UZlVHQjZrZlpwOEtCRHNTS3hSQndoR0lp?=
 =?utf-8?B?RUhxYy9EdXdPSU9wZEdpbFZlTHliWEE3VDRrZzV4RHhTVCt6UG9ONzI2SCtn?=
 =?utf-8?B?TmVvbzhLa2x4L0Z2TDhuOVhMM3FDZHRtQWZKOW9XVHJYUDk0YndGNHBNUWNH?=
 =?utf-8?B?YzI5eWtSSm9oc042SHVWZVl3Uit2UmtrTnhNbGRNVE1GMEtheGpLcVJmWGM1?=
 =?utf-8?B?eFY1eE9ISkZ0NTVpMjBQSGpRdzZhOXpJRVpDTEhNSytScWV2QmwyUEg4bXNs?=
 =?utf-8?B?Q0hNUnZpZDNFS1hkamlLRnV4aHoyTEpQUUVjMWNacldibnpTeEJ4YnVwY1Z1?=
 =?utf-8?B?ZFZ5R3hJTllDaWx3dHhWOEppZHg1bmhLVC8yM1d4R1M3YW1uTWZnLyswTzNn?=
 =?utf-8?Q?JEvXXbcoOJPpN8wQuaDiO03FC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da288a5-6731-4250-7a78-08dbf5dff495
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 22:17:23.4857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGVJEMLDo5P2Dn5PGEurAZ0s0hvxbWZrsqXHjXd4Wu2FQkKz2lSZ+4YkOaWBx5vdwcyoMk/ktDgzbQyk3XgG9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295

On 12/5/2023 12:28, Mario Limonciello wrote:
> On 12/5/2023 11:31, Bjorn Helgaas wrote:
>> On Tue, Dec 05, 2023 at 11:00:31AM -0600, Mario Limonciello wrote:
>>> On 12/5/2023 10:17, Bjorn Helgaas wrote:
>>>> On Tue, Dec 05, 2023 at 09:48:45AM -0600, Mario Limonciello wrote:
>>>>> commit 7752d5cfe3d1 ("x86: validate against acpi motherboard 
>>>>> resources")
>>>>> introduced checks for ensuring that MCFG table also has memory region
>>>>> reservations to ensure no conflicts were introduced from a buggy BIOS.
>>>>>
>>>>> This has proceeded over time to add other types of reservation checks
>>>>> for ACPI PNP resources and EFI MMIO memory type.  The PCI firmware 
>>>>> spec
>>>>> however says that these checks are only required when the operating 
>>>>> system
>>>>> doesn't comprehend the firmware region:
>>>>>
>>>>> ```
>>>>> If the operating system does not natively comprehend reserving the 
>>>>> MMCFG
>>>>> region, the MMCFG region must be reserved by firmware. The address 
>>>>> range
>>>>> reported in the MCFG table or by _CBA method (see Section 4.1.3) 
>>>>> must be
>>>>> reserved by declaring a motherboard resource. For most systems, the
>>>>> motherboard resource would appear at the root of the ACPI namespace
>>>>> (under \_SB) in a node with a _HID of EISAID (PNP0C02), and the 
>>>>> resources
>>>>> in this case should not be claimed in the root PCI bus’s _CRS. The
>>>>> resources can optionally be returned in Int15 E820h or EFIGetMemoryMap
>>>>> as reserved memory but must always be reported through ACPI as a
>>>>> motherboard resource.
>>>>> ```
>>>>
>>>> My understanding is that native comprehension would mean Linux knows
>>>> how to discover and/or configure the MMCFG base address and size in
>>>> the hardware and that Linux would then reserve that region so it's not
>>>> used for anything else.
>>>>
>>>> Linux doesn't have that, at least for x86.  It relies on the MCFG
>>>> table to discover the MMCFG region, and it relies on PNP0C02 _CRS to
>>>> reserve it.
>>>
>>> MCFG to discover it matches the PCI firmware spec, but as I point
>>> out above the decision to reserve this region doesn't require
>>> PNP0C01/PNP0C02 _CRS.
>>
>> Can you explain this reasoning a little more?  I claim Linux does not
>> natively comprehend reserving the MMCFG region, but it sounds like you
>> don't agree?  I think "native" comprehension would mean Linux would
>> not need the MCFG table.
> 
> After our thread and the spec again I think you're right Linux doesn't 
> natively comprehend (reserve this region;) particularly because of the 
> stance you have on "static table" vs _CRS.
> 
>>
>>> This is a decision made by Linux historically.
>>>
>>>>> Running this check causes problems with accessing extended PCI
>>>>> configuration space on OEM laptops that don't specify the region in 
>>>>> PNP
>>>>> resources or in the EFI memory map. That later manifests as 
>>>>> problems with
>>>>> dGPU and accessing resizable BAR.
>>>>
>>>> Is there a problem report we can reference here?
>>>
>>> Nothing public to share. AMD BIOS team is in discussion with the OEM 
>>> to add
>>> the reservation in a BIOS upgrade so it works with things like the LTS
>>> kernels.
>>
>> Is there some reason this can't be made public (it's obviously fine to
>> redact proprietary details)?  It's really hard to make this code work
>> for all the cases even when we know all the details, and practically
>> impossible if we don't.
> 
> I just don't want to throw the vendor under the bus as it could have 
> been caught "sooner" and fixed by BIOS adding _CRS.
> 
> I'll share the full dmesg below just redacting the DMI information.
> 
>>
>>> Knowing Windows works without it I feel this is still something that we
>>> should be looking at fixing from an upstream perspective though which is
>>> what prompted my patch and discussion.
>>
>> We definitely need to change Linux so it works correctly with firmware
>> in the field, whether that means fixing a Linux defect or working
>> around a firmware defect.
>>
>>>> Does the problem still occur with this series?
>>>> https://lore.kernel.org/r/20231121183643.249006-1-helgaas@kernel.org
>>>>
>>>> This appeared in linux-next 20231130.
>>>
>>> Thanks for sharing that.  If I do respin a variation of this patch I'll
>>> rebase on top of that.
>>>
>>> I had a try with that series on top of 6.7-rc4, but it doesn't fix 
>>> the issue
>>> (but obviously the patch I sent does).
>>>
>>> # journalctl -k | grep ECAM
>>> Dec 05 06:37:46 cl-fw-fedora kernel: PCI: ECAM [mem 
>>> 0xe0000000-0xefffffff]
>>> (base 0xe0000000) for domain 0000 [bus 00-ff]
>>> Dec 05 06:37:46 cl-fw-fedora kernel: PCI: not using ECAM ([mem
>>> 0xe0000000-0xefffffff] not reserved)
>>> Dec 05 06:37:46 cl-fw-fedora kernel: PCI: ECAM [mem 
>>> 0xe0000000-0xefffffff]
>>> (base 0xe0000000) for domain 0000 [bus 00-ff]
>>> Dec 05 06:37:46 cl-fw-fedora kernel: PCI: [Firmware Info]: ECAM [mem
>>> 0xe0000000-0xefffffff] not reserved in ACPI motherboard resources
>>> Dec 05 06:37:46 cl-fw-fedora kernel: PCI: not using ECAM ([mem
>>> 0xe0000000-0xefffffff] not reserved)
>>
>> Can you boot with 'efi=debug dyndbg="file arch/x86/pci +p"' and share
>> the complete dmesg log (redacted if necessary) somewhere?  It's
>> important to know more about why and how this doesn't work.  I added
>> more debug logging, but possibly it's still not enough.
> 
> Here you go (6.7-rc4 + that series you linked):
> https://gist.github.com/superm1/eca87ae661793b9ab969829946adb084
> 
>>
>>>>> Similar problems don't exist in Windows 11 with exact same
>>>>> laptop/firmware stack, and in discussion with AMD's BIOS team
>>>>> Windows doesn't have similar checks.
>>>>
>>>> I would love to know AMD BIOS team's take on this.  Does the BIOS
>>>> reserve the MMCFG space in any way?
>>>
>>> On the AMD reference platform this OEM system is based on it is 
>>> reserved in
>>> the EFI memory map.  So on a 6.7 based kernel the reference system 
>>> you can
>>> see this emitted:
>>>
>>> PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved as 
>>> EfiMemoryMappedIO
>>
>> The EfiMemoryMappedIO entry is not a *reservation* (this was a poor
>> choice of words in the logging, and my series changes it).  This entry
>> only means the firmware requests that the OS map this region to a
>> virtual address so it can be used by EFI runtime services (UEFI v2.9,
>> sec 7.2).
> 
> In that sense the only reason this works on the AMD reference platform 
> is because that region happens to have been reserved from a subset of 
> another region.
> 
> Per the stance on "static table", we should advocate for _CRS to be 
> populated with MCFG on AMD reference platform too, right?
> 
>>
>>> But on the OEM system this is not reserved by EFI memory map or _CRS.
>>>
>>> That's why my assumption after reading the firmware spec and seeing the
>>> behavior is that Windows makes the reservation *based on* what's in 
>>> MCFG.
>>
>> Is there some spec language that says MCFG reserves space?  I'm not
>> aware of anything about ACPI static tables reserving MMIO space.
>> Here's my reasoning around static tables vs _CRS for reservations:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/acpi-info.rst?id=v6.6#n32
> 
> Reading your stance it makes sense more of why we're where we are now.
> 
> Let me ask though - why does the distinction of old OS vs new OS matter?
> If a vendor wants it to work with a kernel that didn't use MCFG to make 
> a reservation _CRS or some other overlapping reservation is their only 
> option.
> 
> But if we changed this behavior in a newer kernel then the stance can be
> something like:
> "upstream kernel 6.8 or newer will reserve MCFG if not specified by _CRS 
> or any other overlapping reservation"
> and
> "upstream kernel 6.7 or older require explicit reservations".
> 
> It seems to me that this type of issue would entirely go away in most 
> cases and it would satisfy the spec note about
> 'natively comprehend' reserving the MMCFG region.
> 
> 

I don't think this should be any surprise, but this patch on top of your 
series fixes the issue on that system.

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 0cc9520666ef..6a77441565e2 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -571,8 +571,6 @@ static void __init pci_mmcfg_reject_broken(int early)
                 if (!pci_mmcfg_reserved(NULL, cfg, early)) {
                         pr_info("not using ECAM (%pR not reserved)\n",
                                 &cfg->res);
-                       free_all_mmcfg();
-                       return;
                 }
         }
  }

And from what I can tell this *does* make a "reservation".
Specifically because pci_mmcfg_late_insert_resources() uses 
insert_resource() to put it in place.  I would expect if something else 
tries to request that region later it would get a conflict.

