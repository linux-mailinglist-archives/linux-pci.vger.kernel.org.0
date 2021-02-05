Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500C4311353
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 22:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhBEVST (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 16:18:19 -0500
Received: from mail-bn8nam12on2064.outbound.protection.outlook.com ([40.107.237.64]:7872
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233061AbhBETAq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Feb 2021 14:00:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiVQaly3sI2Soxgprkp0zhIZWMLvKLskdooe6g6U9i74stWtOuPDNRtmdggx7QSVOzaKaRNKPJWfJXvqM1zuqJiv553nuy3Sel3jIKo5CDkw7uvf8KmXGMLBa8IN2zcBlM0MasTvVc3nf0EAHNm+H16MKMGvN9ZQlirhtim053O/fUe5l23d1KylqgKef80zZm0/+kXwm1dgkCkCnS8I/55hJ16g/2Hxcpyngv8Cto3jw7+ZCVMxrHqCS7vZ9DWh7fz4LDT3EV3orzqblmAYSEJ2z6KFDE+ZrYPOz1TvYnoyzLX6FatqdaSy5BFUbwKdZEn8JL01ZpnOGJhVbnz4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWZp+S+GwVwdPnfukVocQ00pCbSqlGBcVLNM0kqTKEg=;
 b=kXfAlcU3iaKp5YJku0MhlS3mKCKJgk1mTz7nt/+4he+qXnsfLfymsZeKijBiJakmzBOeu9yLyc58VHd3nQAGfwaueYLNzVqNoQEzFKpzJrQXaUOUG0IdQb0VslSxlCaFKUuvZcFCKEQigebt5Z++UhP80QJke8JhAwn3WwPtZ0YNTDCaQlvCzWEEnTL2v2UXWU2vgn5kxMpOpwE06t+G3I9/NqF4sN1a42znmhYuTuLDt9FXAva8OvzsiZczb3cwDWXNjZPFaEw4LYUSgK7KfX0qzluhAi0yyLzuHzvMekqv57bvSJwlZ1glmewGyFzGQT/dSpy9vaxjb9FWZfY3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWZp+S+GwVwdPnfukVocQ00pCbSqlGBcVLNM0kqTKEg=;
 b=IF/MGCABUG299ewgCGja+0DYlPjaEb+sOM80LP6oXY/P5CGewHHhKY/F2oCKF1219SP30yz+DadfVXx2nxgMRcqkj7r0MKKX43tGwWoY9xAeYpFUeBhXtLuqSb5wTrRX+wx9Ow4Ev6u4FTKkPmhXbGrnRuKnTximzWfdKCSGysg=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4541.namprd12.prod.outlook.com (2603:10b6:806:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Fri, 5 Feb
 2021 20:42:05 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::41b1:11f5:fd1e:fc5f]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::41b1:11f5:fd1e:fc5f%5]) with mapi id 15.20.3825.023; Fri, 5 Feb 2021
 20:42:04 +0000
Subject: Re: Avoid MMIO write access after hot unplug [WAS - Re: Question
 about supporting AMD eGPU hot plug case]
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "s.miroshnichenko@yadro.com" <s.miroshnichenko@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20210205194541.GA191443@bjorn-Precision-5520>
From:   Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <c216efcc-6c81-8a7e-a823-1ddb62ebddb7@amd.com>
Date:   Fri, 5 Feb 2021 15:42:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210205194541.GA191443@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:74f0:8064:c429:544e]
X-ClientProxiedBy: YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::11) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:74f0:8064:c429:544e] (2607:fea8:3edf:49b0:74f0:8064:c429:544e) by YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Fri, 5 Feb 2021 20:42:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cd427361-02df-4a02-28b4-08d8ca167f12
X-MS-TrafficTypeDiagnostic: SA0PR12MB4541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4541F26F10E173F8EDEF46AAEAB29@SA0PR12MB4541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DjllR/e99sZivK28JR0kYgW5FHf/+c+gkWgSjbw69cfJxwB+nos/QPD8eVI9rkZFKUlCGK9gY+cMy192FEzSQC2c5XQ/4oe9gQbN9Pi/JQPXBQmFW9K2y8jualBk7RB9+Tqgn/yV0GDzUJmhSjvYn+BnXzv/2oNi6w8LtFJoeRObjph/lBthNB/WdnCC9Uuuz2Zg/GOt+e8H3m29HAb+bsN0LDTBWpsVhbQgZ2aB0ioy+86VxFyyBatdnjDyN6CDaZQri7PCSVAwvlaIg5d2g3S9k/SORzpSXht7SPcABkJFPPyKjlUOVV9EczDmEto8uRzHNCLkfslM02wlmDJLLXbF18ZgS1Cvk7KGAXd2wZ0s55W9Pn3dEuR2bPT47mdlCKaHXU18KIq+Tc/C0pMSHEyH/QZhSE5PAao1tg0m7zDEEDg/ZS38+DvbwojxVk7xroxhEvlDnl+hPmmmgtuG/48hn2KO2YD//xu4remyGktszz+tGe+gHBpXXDDgKUinlP5NJ0fAimtg96r+zdDs+8H4fxEk614GO9tlblBlqdLDlJ3Mi5pRbRtTrkty+uiIHusvKyxVnkCtCj+NOLM8rn4+Coq2NgnLR3I7oAtAEpttBUI0QTikNZP2Q6ku0qnj0BO5LCHe8YeXp1F1srEcFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(36756003)(2906002)(6486002)(16526019)(8676002)(52116002)(66476007)(53546011)(66556008)(66946007)(5660300002)(4326008)(186003)(6916009)(31686004)(86362001)(31696002)(316002)(478600001)(54906003)(966005)(45080400002)(2616005)(83380400001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MnNrMXN4Mm5pTWMzc2gxL3NvUVI2WjdpMG1GOUlnclNtL0tMZG9zU1ZMbWYw?=
 =?utf-8?B?b2tjUXV3YmRMWUczcnpoT0tWcG45ZWs1ZUR1V3o0RDZKSWxIS1BsRTFEdWRG?=
 =?utf-8?B?ZHFpQXBRQjgyc2MyRWZLQXpkeW1LdHY0WG4zbjlLY21XTitnNjdsQ2lwY2d3?=
 =?utf-8?B?blY4VkgzbHZ2R0NPTkdaU2cwdlllaDlEOUtFTU5aM2E4YjlPYUxlOVppK1Bl?=
 =?utf-8?B?S1VheHpFVHYxWmNWVWdHYVhPTjArVFFyNExLaTYyQUZUSkUwWUFvN3NwWWxs?=
 =?utf-8?B?SWd3QkgzVUVaekwwQmhGVEo0bTI4TjhzaGFxRzY1MXh5UzR5L0J5NEx5Vnhv?=
 =?utf-8?B?dnZtclViK1puaG9CUjNoZVVtWjZNVmp0bTVzUjFLWG5tVlpXR2NyK2tRbEpm?=
 =?utf-8?B?MjRlSndZWEpPWWRWUVpSTlBWbm83RkROY3ZVLzVVK1lhNUF2cWkwWWdVclJs?=
 =?utf-8?B?OFlmTmtSVG5jY3htZi93UnZRMy95WXFjVFNlblpoMTV0MmVDM2tzcFh0OWtC?=
 =?utf-8?B?aXBOWm9UY2ptTHIxWnNhK3JhajRLK2YrZUxsQUZjODh0V2J3UW1icVdJS3k5?=
 =?utf-8?B?eURMTjJ6bmd5elB0VTdwY0RTZnYwOTdMZFZmM2dCdlB4bDl6MzViSzVTcHhQ?=
 =?utf-8?B?MXlUYTZHejN3OFJ0M1VXeENZZzlpS2pHNUp1Y1pacGtNdmZrbCtMRTB1Sjly?=
 =?utf-8?B?a1V2ZGpSQnVkaUpkV21odXQ3VXF0YjZLT0dCOFlOempxay9mVURFQ2dCRlJt?=
 =?utf-8?B?c3BlS055c082KzJWRTdQN0Y1NkFZcXl6d1ZCYWZGZEVPNWZhZmpvSVlDSTU1?=
 =?utf-8?B?czBSRFRzRjRPdmhINXNEWWpxSFdnSVpFY2JUMC9TbGFIcFJ0MXluZkVvYXB2?=
 =?utf-8?B?OXRIVS9SaDAxS3l6NDg0VXlmVWt6VVhhdXFPVlY5U1h6N0pNUmdYVm5XUTVX?=
 =?utf-8?B?Qmd2WXd6Q0h6c25qdHl4b0gyZklOaHlHRlRHd3ZVYWtaYUFQUkJlZTZRbTlG?=
 =?utf-8?B?U2xpdjJUdmdicXdYdkVJdTVLczZsbDRqOE1SeEF6Y0puUGRNeHg3Ti9mc0Uw?=
 =?utf-8?B?TDNOY1hUVFhqUjJpZGlvMURaU1I2bEdaTi9WM2VKbkN1SDEzdWlRMXNqZ0FD?=
 =?utf-8?B?THM2bXZyTkRNUnRUTWg3S3E0K1JiVlFtTDk2Q1hyb2dlcTZ1VHlXUnE1dW1U?=
 =?utf-8?B?TGtrNmx3Qi95SW9wWjFzcjd4dkh5RXVxTlM4ZHJVZC9ZZXdNY2I1QjRFRjl6?=
 =?utf-8?B?V0VHSlBxdGpJTEdwVEpSQ2R1bXpwc0h4ZzJ6WWlpa0F4ajlpTUl5ay95Sm1G?=
 =?utf-8?B?UG5YQmdDbTJXazhubTJWQndMYk12SlQwdTdKU0xyUk1OWHplZVNETjNFUWJy?=
 =?utf-8?B?L093WDJQaHFLVTg2ekluaEZRYmxGcU54TEZvdkxxVklRSi9Pa2tUK2lWa0ov?=
 =?utf-8?B?cjgrUXVjR3lmTGtsZ2F3NUFCYUlSNFB4MkFyemc5N0Q1OHpnQTI0NTJjUGxh?=
 =?utf-8?B?WU13eUlZeHhwcjRCUmt1YTZCc1RaQ3l1TkZyTW9HaWd2MnRCZUo2eDlYYU5E?=
 =?utf-8?B?NmlvRkZmZlFHcnpMVjk4Um0yR0c1VkVPVDF3WUlKeHMyQ3c3VW8vQ3B6alVO?=
 =?utf-8?B?VDFHTFBsWkh0Q004cWR6ZGp5dWRPcDI4V2paZjhFelUzd1YxMXJJcTV0OUIx?=
 =?utf-8?B?aWtnTWNWQjVadFBNanF0VDRTVXNzTFZEdjlkNTYxQWZ4V0tyRlQzZzNka3h3?=
 =?utf-8?B?RUUvS1pOS3pYbDJPU2VwWWNYVFJPempaa01yeTBPSGFWQUVHblgzZnVITXUv?=
 =?utf-8?B?M1B4cXVPTWxha285SDViZ3ZQOXU0MTFoZWFsekZicjVlQmphSkRsdFJxY3A1?=
 =?utf-8?Q?5H/AqRyi8Mr5C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd427361-02df-4a02-28b4-08d8ca167f12
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 20:42:04.8040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwET27VmYWXDts4eMxx9TdYr3IO9hXBWl4wy+u3FjTTUm8HOJAlyFu04ddLVJORdAagQZlfmjFGOUy/VzIRMVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4541
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/5/21 2:45 PM, Bjorn Helgaas wrote:
> On Fri, Feb 05, 2021 at 11:08:45AM -0500, Andrey Grodzovsky wrote:
>> On 2/5/21 10:38 AM, Bjorn Helgaas wrote:
>>> On Thu, Feb 04, 2021 at 11:03:10AM -0500, Andrey Grodzovsky wrote:
>>>> + linux-pci mailing list and a bit of extra details bellow.
>>>>
>>>> On 2/2/21 12:51 PM, Andrey Grodzovsky wrote:
>>>>> Bjorn, Sergey I would also like to use this opportunity to ask you a
>>>>> question on a related topic - Hot unplug.
>>>>> I've been working for a while on this (see latest patchset set here
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058595.html&amp;data=04%7C01%7CAndrey.Grodzovsky%40amd.com%7C67eb867f5714488f604608d8ca0ea0c8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637481511484863191%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=sPRG9cnJDUPR%2FJ1%2Bls0zM6Bidut6bbT%2BpCYuufnc24Q%3D&amp;reserved=0).
>>>>> My question is specifically regarding this patch
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058606.html&amp;data=04%7C01%7CAndrey.Grodzovsky%40amd.com%7C67eb867f5714488f604608d8ca0ea0c8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637481511484863191%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=YsGsXwyK%2FtiErUONC9BbcXcceGcljtbnOBWb131kl%2FI%3D&amp;reserved=0
>>>>> - the idea here is to
>>>>> prevent any accesses to MMIO address ranges still mapped in kernel page
>>>
>>> I think you're talking about a PCI BAR that is mapped into a user
>>> process.
>>
>> For user mappings, including MMIO mappings, we have a reliable
>> approach where we invalidate device address space mappings for all
>> user on first sign of device disconnect and then on all subsequent
>> page faults from the users accessing those ranges we insert dummy
>> zero page into their respective page tables. It's actually the
>> kernel driver, where no page faulting can be used such as for user
>> space, I have issues on how to protect from keep accessing those
>> ranges which already are released by PCI subsystem and hence can be
>> allocated to another hot plugging device.
> 
> That doesn't sound reliable to me, but maybe I don't understand what
> you mean by the "first sign of device disconnect." 

See functions drm_dev_enter, drm_dev_exit and drm_dev_unplug in drm_derv.c

At least from a PCI
> perspective, the first sign of a surprise hot unplug is likely to be
> an MMIO read that returns ~0.

We set drm_dev_unplug in amdgpu_pci_remove and base all later checks
with drm_dev_enter/drm_dev_exit on this

> 
> It's true that the hot unplug will likely cause an interrupt and we
> *may* be able to unbind the driver before the driver or a user program
> performs an MMIO access, but there's certainly no guarantee.  The
> following sequence is always possible:
> 
>    - User unplugs PCIe device
>    - Bridge raises hotplug interrupt
>    - Driver or userspace issues MMIO read
>    - Bridge responds with error because link to device is down
>    - Host bridge receives error, fabricates ~0 data to CPU
>    - Driver or userspace sees ~0 data from MMIO read
>    - PCI core fields hotplug interrupt and unbinds driver
> 
>>> It is impossible to reliably *prevent* MMIO accesses to a BAR on a
>>> PCI device that has been unplugged.  There is always a window
>>> where the CPU issues a load/store and the device is unplugged
>>> before the load/store completes.
>>>
>>> If a PCIe device is unplugged, an MMIO read to that BAR will
>>> complete on PCIe with an uncorrectable fatal error.  When that
>>> happens there is no valid data from the PCIe device, so the PCIe
>>> host bridge typically fabricates ~0 data so the CPU load
>>> instruction can complete.
>>>
>>> If you want to reliably recover from unplugs like this, I think
>>> you have to check for that ~0 data at the important points, i.e.,
>>> where you make decisions based on the data.  Of course, ~0 may be
>>> valid data in some cases.  You have to use your knowledge of the
>>> device programming model to determine whether ~0 is possible, and
>>> if it is, check in some other way, like another MMIO read, to tell
>>> whether the read succeeded and returned ~0, or failed because of
>>> PCIe error and returned ~0.
>>
>> Looks like there is a high performance price to pay for this
>> approach if we protect at every possible junction (e.g. register
>> read/write accessors ), I tested this by doing 1M read/writes while
>> using drm_dev_enter/drm_dev_exit which is DRM's RCU based guard
>> against device unplug and even then we hit performance penalty of
>> 40%. I assume that with actual MMIO read (e.g.
>> pci_device_is_present)  will cause a much larger performance
>> penalty.
> 
> I guess you have to decide whether you want a fast 90% solution or a
> somewhat slower 100% reliable solution :)
> 
> I don't think the checking should be as expensive as you're thinking.
> You only have to check if:
> 
>    (1) you're doing an MMIO read (there's no response for MMIO writes,
>        so you can't tell whether they succeed),
>    (2) the MMIO read returns ~0,
>    (3) ~0 might be a valid value for the register you're reading, and
>    (4) the read value is important to your control flow.
> 
> For example, if you do a series of reads and act on the data after all
> the reads complete, you only need to worry about whether the *last*
> read failed.  If that last read is to a register that is known to
> contain a zero bit, no additional MMIO read is required and the
> checking is basically free.

I am more worried about MMIO writes to avoid writing to a BAR
of a newly 'just' plugged in device that got accidentally allocated some
part of MMIO addresses range that our 'ghost' device still using.

Andrey

> 
>>>>> table by the driver AFTER the device is gone physically and
>>>>> from the PCI  subsystem, post pci_driver.remove call back
>>>>> execution. This happens because struct device (and struct
>>>>> drm_device representing the graphic card) are still present
>>>>> because some user clients which  are not aware of hot removal
>>>>> still hold device file open and hence prevents device refcount
>>>>> to drop to 0. The solution in this patch is brute force where
>>>>> we try and find any place we access MMIO mapped to kernel
>>>>> address space and guard against the write access with a
>>>>> 'device-unplug' flag. This solution is obliviously racy
>>>>> because a device can be unplugged right after checking the
>>>>> falg.  I had an idea to instead not release but to keep those
>>>>> ranges reserved even after pci_driver.remove, until DRM device
>>>>> is destroyed when it's refcount drops to 0 and by this to
>>>>> prevent new devices plugged in and allocated some of the same
>>>>> MMIO address  range to get accidental writes into their
>>>>> registers.  But, on dri-devel I was advised that this will
>>>>> upset the PCI subsystem and so best to be avoided but I still
>>>>> would like another opinion from PCI experts on whether this
>>>>> approach is indeed not possible ?
