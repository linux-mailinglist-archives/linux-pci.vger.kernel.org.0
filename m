Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19062311377
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 22:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhBEVZg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 16:25:36 -0500
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com ([40.107.243.62]:24545
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233796AbhBEVY7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Feb 2021 16:24:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7QR29RJ3ej+CT+PXtLKbsYJSuxuMt6zrC7EkhQ/EDe5q2bDOwRpTDDfCR96a93vu3U/7V5SIAPpCMBJ0Q5aqhc9sMcRYckJ7Ljk/8R7IZ6CvLXKvLfkc5y83euYEbwrQJ5rVqvkRgBbdWrhJBalrZcm/ei4QFIebaicudP3j+FxIaqrJeuikSRW3P7zVIGGeCJRmVJuoqNw0bKe3jQWQuEIdoFZC8gjngodVWZnmltp/BSXGHCr6fAGf+Qa8a2HzSozesFTPAHMbA0/QfN7iiL6dGtfPPazxwlAU4PxJM0xLM8RNoBqjZr+oPXbYoFup3wXBsFscJbqT9JhHEXccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUUfoNV7PnEGB2V1EuFxirVYlyCUVZyviI1PitKWrnY=;
 b=hQyYnF4RYc552f4UlAM4niE+Y04SFOLCyh+J4Lgo6LzLh/kbc7NFN4r8WGDzCSpkubRWUL9k/JsVUhiuwApiBUPT4hiDrdNBpmqmhfWm0EmZV8gBp9d09hAapjALtNSnbKMIBddAv1IJllURNm4T2XIyXt4GOKXxjg2w4lgshkA8thmGn7UMUX4+/IRh8hit67AyJ7FVWgHsYhiRO1WjL4aESD8N+2IyBmVrdEE1kEBaK6BpcCddvh3JhKw9x049lryYFCfmZDJwo468eUnzQEoLwkh7oPtrKwFRgpkXlyFw2urSCGtCtvrLmOTMew2jlaV71nFbBbgyJnOxwD1R3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUUfoNV7PnEGB2V1EuFxirVYlyCUVZyviI1PitKWrnY=;
 b=DIJJYn7Q5CpvNDZw8oCPvGPS1naZp17vQ0xpCwQEHMZ9M+olK11W4AzqSWMw74ee3BuWULQc21Q3igVrtuSNP4UNfYYEgqW9g3L7TTnyGM/Nc7/+AFn0XMqtoOli4AQrMh/VKkvkAqg0+RiNW17+9dLkBB8VZXp6Mc+WPovPNIM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2703.namprd12.prod.outlook.com (2603:10b6:805:75::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 5 Feb
 2021 21:24:05 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::41b1:11f5:fd1e:fc5f]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::41b1:11f5:fd1e:fc5f%5]) with mapi id 15.20.3825.023; Fri, 5 Feb 2021
 21:24:05 +0000
Subject: Re: Avoid MMIO write access after hot unplug [WAS - Re: Question
 about supporting AMD eGPU hot plug case]
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "s.miroshnichenko@yadro.com" <s.miroshnichenko@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>
References: <20210205194541.GA191443@bjorn-Precision-5520>
 <c216efcc-6c81-8a7e-a823-1ddb62ebddb7@amd.com>
 <CAKMK7uEKs=g817+ahvsQxv1qVx8yTWC3qZyu8T2ojd82yv+ayg@mail.gmail.com>
From:   Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <9d0929f1-c7c7-5832-8c9c-3c52084bd56a@amd.com>
Date:   Fri, 5 Feb 2021 16:24:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAKMK7uEKs=g817+ahvsQxv1qVx8yTWC3qZyu8T2ojd82yv+ayg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2607:fea8:3edf:49b0:74f0:8064:c429:544e]
X-ClientProxiedBy: YT1PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::17) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:74f0:8064:c429:544e] (2607:fea8:3edf:49b0:74f0:8064:c429:544e) by YT1PR01CA0048.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Fri, 5 Feb 2021 21:24:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e278bd21-8e77-4bc5-c8b5-08d8ca1c5d84
X-MS-TrafficTypeDiagnostic: SN6PR12MB2703:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2703D5AC6E9137D35ABB1742EAB29@SN6PR12MB2703.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVFc/6KO5ehcoy91fjcG8AB97UymCBheqoutMPcp0gc/Fi+2iaPt4ZUAIziinZb08hYrFxvQNu8chz1XYDrqzeMPe9gTx2BOvemo6SE2hRiN9Q5lWrXY3zzm2N4WQF34i4EJxTyT7C8b7SEwH/Jpj7fJspjMO8aB3t5AQuUVWb/juwcU2ZRBVCLNMiAqpjw1gonKVP+GIX8+iRVkeeYqfZ+VAMhx5lz//8jF9K5403HZJB7uAtt35TafXu624hRwJshWEuHGX/bEZL+YxzUT4WHpRjvFNCGHUaC6YZz4n+bowRbXPSDGP0KqXffbprRpj6tnYAyOgMLUw2mrDwm64Bt4nSzZf7eJ/tUavH8joXYQh2qSPQm+szufT2XgT1pAHI8pHfRx0sR83Dz8m9w5Mw2MMJJ0+8Z/bg/2xXAGV9prbMSSOmbHurqRoFKi1mBAnp4Gt5L6tM3SGzxbjl//r8cPlvCRfc2jCcPL82k248Kn7Wg4DWPyCLk/y0mv3IqzmOliyoSf8v4T7+Oyx1351XjHoNIdfdu7tUOkLrN8/Lj+OKPD3YQDqzR3JgPPfSF/GLNS1fhjAWd2pmz5Q+Y9/xxBUbZi5f9WhNYQRYG+H9koc5cIO1LcTTIZy4iw+bg2hRu05r4FV3QOyC/IAdfQ/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(31686004)(6486002)(36756003)(186003)(8676002)(83380400001)(316002)(66476007)(2906002)(66556008)(52116002)(5660300002)(45080400002)(2616005)(54906003)(6916009)(8936002)(4326008)(478600001)(86362001)(966005)(16526019)(31696002)(66946007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U2VkMmpTdFloOWFvNlRndzVlcE1sQ0ZSYUp3eUdYQmQrbjMxcVc1SHI0WE5p?=
 =?utf-8?B?cVNEbWx0VHk3TmF0VS92MW9yZkdjLzRvdGt3cTRlRDM0dnFDa1AwV28ydDhS?=
 =?utf-8?B?YXFYNjdTWU5aQTZ5bUpaZVNvcC9wcUprQ0tlK0J4cjllTFRqbmM5b2JXa2V3?=
 =?utf-8?B?cDd2bm1BYm8xT0gra09lVEljWHZuYU5hZHQ3Tm05ekFLd0FDa3RueFpMczV1?=
 =?utf-8?B?c25MY085ZVd1djJyNXRyek05MUk1QUFaRWFsWlNMSHMza3hrOGtNbjRJazJq?=
 =?utf-8?B?bFY3Vmx3b0wvRE9TQ1hvMWh4QzE1QWppQU1PUC9pRzJRc2lVaVpTejh3VUs0?=
 =?utf-8?B?UXpteEVlOTBaNFJFakx2WU9DSFRIWStIcFhwMG5Ia0xKSW5sUzVERTJUb0o3?=
 =?utf-8?B?dXRzd2N4d3ZJR0ZsZ3A3Nk9kRURkWU1LVHFIcSt1QzhTN3VVaEgyN2V3U2hz?=
 =?utf-8?B?MUlTRWRmRDhYZHJsZ2hSNUQ2T2JJYnRvWVE3V0d6L3ZNTHZZQzZubHV5bW1L?=
 =?utf-8?B?TlA4bGxXQmlzdUZmaUpXdVJpT0ZnRUEzWWtPMm1JRWtyUWUzN1haUW1xcVd4?=
 =?utf-8?B?ZzFyTDZEdDJlZ05TV0tVNmRLenI2TEg5eVhvejZlUDB6MGdPUDIyL3V1dnEz?=
 =?utf-8?B?YkNZcDgzVHg5cTlTeXBuN2JZcmJILzFOZzBsZTFGWUIxY09ZcnRpOUlBRlhx?=
 =?utf-8?B?bEEvYWJ5bXdZVGdpZ09KZTEwNCtsY1E1d21TVVBFYmd6WjJXYm4xVnFzM3RI?=
 =?utf-8?B?TkRUa3FOVGF1VG5MR2c3N3FoTk1SYkpnMnl2S1hka3E0SEI2WS9LbmczaEQ1?=
 =?utf-8?B?QUlJRHBBUUYxRW16ODlpR3ZuOGxxRTl4WHFWRHpPd3lCWGM4VWhHK3VEZGV1?=
 =?utf-8?B?MmdEM201SGJScVY0blg1M2EwU0JDNUV3b3lCM2JNRW9EY0hkMkVTeGZGREdv?=
 =?utf-8?B?bXpFUXZpbGMvUzM2K0xBTU9iU1pMb0gzVUhCSW8vNGJwU3JKMFJmbis3Kzhl?=
 =?utf-8?B?eStLU2UzNmlzMEhRdXh4d2ppOWt6WnQrdjVqOU43ZHdxalZ0WnVpYlRxVXN5?=
 =?utf-8?B?UXZVTzZsQzlSMmhrY0trK1F5YzZvYjd5U0tMcWlLeC9mMkE5anlYaVAzMDg5?=
 =?utf-8?B?ZXlUSVdkNnYrVU9pYzFyU1lyQldPcU5qaHMrNzdnTDVGOERvMHZzU3JWMXdp?=
 =?utf-8?B?aHVkZG9GQk5Mb3lEMmZ6Wm9yVjBCV1FzbEg1VzBmZWw4YzRWVmdWVy9WTytL?=
 =?utf-8?B?NUVWVGhNMEZWZkxRcHVXcDA1WVc3MVIwenFqbThRM3hpa0xRaTduSTVlOHZz?=
 =?utf-8?B?WWZna0wyRmJRTzZrRER2dUJsMGdydmxMMXJ2cVJzbVZOMVZRTU5uY1ZIemNY?=
 =?utf-8?B?UXo5YVVZRW9jeFhKdDJqZlEvZkNhaHZESkM3bzhRRTloK2U4VmQ2NTYvcjdi?=
 =?utf-8?B?WWVPc25EZWhkZU04WkdnQVVTdlVTYlVWbTFGa1ExaHMrTS9HRDNDcDhpR0kx?=
 =?utf-8?B?ZDhqZXpoNFF0M3pzbTJyYnNUQnoveE93bndVR0FtcTJEMjVxeHdjMU9FTGg4?=
 =?utf-8?B?eTVFUlZ6V3dGVnNTVkdMVnNTUVRwN2dDbGxGTlZaZGxmMzBJRkc4WEt4cXBx?=
 =?utf-8?B?bnVOdHoxMk1pSkZ3OFY3dm80ZTNOaWFwN1dQbkJGTHl6UjFIRjMxaGFlc1NQ?=
 =?utf-8?B?YmQwcFJMN2I2ZlVNQmlEMGlTNkNKbnpDTEdsVzJobzVvS3JYRDJGRndXNERu?=
 =?utf-8?B?L0E3SnkybDhQWGJpMU92dUp3dWNQZlJtZkVKVDNLbjlGSFY4Z2YwdC9tZnpi?=
 =?utf-8?B?a1VENXZURXRWVytlc1diNDQzU1lOblRCeGdCTXBZZllpRHZTMlIrVXRwZ1Vi?=
 =?utf-8?B?K2pRRkdiaVc4blFOOENVK2FXTHAvY1JndUt4V011dk1qNmc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e278bd21-8e77-4bc5-c8b5-08d8ca1c5d84
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 21:24:05.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aKxR5JKDmcsdFzBoLuP5jbudpRtghI4XYvkBHqFhzR8FtgHHZlmHeVFLjsLyEAsvfrIdZo2j4ykhitvdc941A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2703
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/5/21 3:49 PM, Daniel Vetter wrote:
> On Fri, Feb 5, 2021 at 9:42 PM Andrey Grodzovsky
> <Andrey.Grodzovsky@amd.com> wrote:
>>
>>
>>
>> On 2/5/21 2:45 PM, Bjorn Helgaas wrote:
>>> On Fri, Feb 05, 2021 at 11:08:45AM -0500, Andrey Grodzovsky wrote:
>>>> On 2/5/21 10:38 AM, Bjorn Helgaas wrote:
>>>>> On Thu, Feb 04, 2021 at 11:03:10AM -0500, Andrey Grodzovsky wrote:
>>>>>> + linux-pci mailing list and a bit of extra details bellow.
>>>>>>
>>>>>> On 2/2/21 12:51 PM, Andrey Grodzovsky wrote:
>>>>>>> Bjorn, Sergey I would also like to use this opportunity to ask you a
>>>>>>> question on a related topic - Hot unplug.
>>>>>>> I've been working for a while on this (see latest patchset set here
>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058595.html&amp;data=04%7C01%7CAndrey.Grodzovsky%40amd.com%7C49d227022bff486d9fd008d8ca178ec1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637481549831907816%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=I0ma8E5vOKAOh3vPI0IcGrbZpeFeHtbjuBOkTA5mPSU%3D&amp;reserved=0).
>>>>>>> My question is specifically regarding this patch
>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058606.html&amp;data=04%7C01%7CAndrey.Grodzovsky%40amd.com%7C49d227022bff486d9fd008d8ca178ec1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637481549831917820%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=AS4ahmsk%2BY1bRvkqrLWC1KfrE8oNAGhbtKqIOm5AUQo%3D&amp;reserved=0
>>>>>>> - the idea here is to
>>>>>>> prevent any accesses to MMIO address ranges still mapped in kernel page
>>>>>
>>>>> I think you're talking about a PCI BAR that is mapped into a user
>>>>> process.
>>>>
>>>> For user mappings, including MMIO mappings, we have a reliable
>>>> approach where we invalidate device address space mappings for all
>>>> user on first sign of device disconnect and then on all subsequent
>>>> page faults from the users accessing those ranges we insert dummy
>>>> zero page into their respective page tables. It's actually the
>>>> kernel driver, where no page faulting can be used such as for user
>>>> space, I have issues on how to protect from keep accessing those
>>>> ranges which already are released by PCI subsystem and hence can be
>>>> allocated to another hot plugging device.
>>>
>>> That doesn't sound reliable to me, but maybe I don't understand what
>>> you mean by the "first sign of device disconnect."
>>
>> See functions drm_dev_enter, drm_dev_exit and drm_dev_unplug in drm_derv.c
>>
>> At least from a PCI
>>> perspective, the first sign of a surprise hot unplug is likely to be
>>> an MMIO read that returns ~0.
>>
>> We set drm_dev_unplug in amdgpu_pci_remove and base all later checks
>> with drm_dev_enter/drm_dev_exit on this
>>
>>>
>>> It's true that the hot unplug will likely cause an interrupt and we
>>> *may* be able to unbind the driver before the driver or a user program
>>> performs an MMIO access, but there's certainly no guarantee.  The
>>> following sequence is always possible:
>>>
>>>     - User unplugs PCIe device
>>>     - Bridge raises hotplug interrupt
>>>     - Driver or userspace issues MMIO read
>>>     - Bridge responds with error because link to device is down
>>>     - Host bridge receives error, fabricates ~0 data to CPU
>>>     - Driver or userspace sees ~0 data from MMIO read
>>>     - PCI core fields hotplug interrupt and unbinds driver
>>>
>>>>> It is impossible to reliably *prevent* MMIO accesses to a BAR on a
>>>>> PCI device that has been unplugged.  There is always a window
>>>>> where the CPU issues a load/store and the device is unplugged
>>>>> before the load/store completes.
>>>>>
>>>>> If a PCIe device is unplugged, an MMIO read to that BAR will
>>>>> complete on PCIe with an uncorrectable fatal error.  When that
>>>>> happens there is no valid data from the PCIe device, so the PCIe
>>>>> host bridge typically fabricates ~0 data so the CPU load
>>>>> instruction can complete.
>>>>>
>>>>> If you want to reliably recover from unplugs like this, I think
>>>>> you have to check for that ~0 data at the important points, i.e.,
>>>>> where you make decisions based on the data.  Of course, ~0 may be
>>>>> valid data in some cases.  You have to use your knowledge of the
>>>>> device programming model to determine whether ~0 is possible, and
>>>>> if it is, check in some other way, like another MMIO read, to tell
>>>>> whether the read succeeded and returned ~0, or failed because of
>>>>> PCIe error and returned ~0.
>>>>
>>>> Looks like there is a high performance price to pay for this
>>>> approach if we protect at every possible junction (e.g. register
>>>> read/write accessors ), I tested this by doing 1M read/writes while
>>>> using drm_dev_enter/drm_dev_exit which is DRM's RCU based guard
>>>> against device unplug and even then we hit performance penalty of
>>>> 40%. I assume that with actual MMIO read (e.g.
>>>> pci_device_is_present)  will cause a much larger performance
>>>> penalty.
>>>
>>> I guess you have to decide whether you want a fast 90% solution or a
>>> somewhat slower 100% reliable solution :)
>>>
>>> I don't think the checking should be as expensive as you're thinking.
>>> You only have to check if:
>>>
>>>     (1) you're doing an MMIO read (there's no response for MMIO writes,
>>>         so you can't tell whether they succeed),
>>>     (2) the MMIO read returns ~0,
>>>     (3) ~0 might be a valid value for the register you're reading, and
>>>     (4) the read value is important to your control flow.
>>>
>>> For example, if you do a series of reads and act on the data after all
>>> the reads complete, you only need to worry about whether the *last*
>>> read failed.  If that last read is to a register that is known to
>>> contain a zero bit, no additional MMIO read is required and the
>>> checking is basically free.
>>
>> I am more worried about MMIO writes to avoid writing to a BAR
>> of a newly 'just' plugged in device that got accidentally allocated some
>> part of MMIO addresses range that our 'ghost' device still using.
> 
> We have to shut all these down before the ->remove callback has
> finished. At least that's my understanding, before that's all done the
> pci subsystem wont reallocate anything.
> 
> The drm_dev_enter/exit is only meant to lock out entire code paths
> when we know the device is gone, so that we don't spend an eternity
> timing out every access and running lots of code for no point. The
> other reason for drm_dev_exit is to guard the sw side from access of
> data structures which we tear down (or have to tear down) as part of
> ->remove callback, like io remaps, maybe timers/workers driving hw
> access and all these things. Only the uapi objects need to stay around
> until userspace has closed all the fd/unmapped all the mappings so
> that we don't oops all over the place.
> 
> Of course auditing a big driver like amdgpu for this is massive pain,
> so where/how you sprinkle drm_dev_enter/exit over it is a bit an
> engineering tradeoff.
> 
> Either way (if my understanding is correct), after ->remove is
> finished, your driver _must_ guarantee that all access to mmio ranges
> has stopped. How you do that is kinda up to you.
> 
> But also like Bjorn pointed out, _while_ the hotunplug is happening,
> i.e. at any moment between when transactions start failing up to and
> including you driver's ->remove callback having finished, you need to
> be able to cope with the bogus all-0xff replies in your code. But
> that's kinda an orthogonal requirement: If you've fixed the use-after
> free you might still crash on 0xff, and even if you fixed the all the
> crashes due to 0xff reads you might still have lots of use-after frees
> around.
> 
> Cheers, Daniel

I see, so, to summarize and confirm I got this correct.
We drop the per register access guards as this an overkill and hurts performance.
Post .remove callback I verify to guard any IOCTL (already done), block GPU 
scheduler threads (already done) and disable interrupts (already done), guard 
against any direct IB submissions to HW rings (not done yet) and cancel and 
flush any background running threads (timers mostly probably) (not done yet)
which might trigger HW programming.

Correct ?

Andrey

> 
>> Andrey
>>
>>>
>>>>>>> table by the driver AFTER the device is gone physically and
>>>>>>> from the PCI  subsystem, post pci_driver.remove call back
>>>>>>> execution. This happens because struct device (and struct
>>>>>>> drm_device representing the graphic card) are still present
>>>>>>> because some user clients which  are not aware of hot removal
>>>>>>> still hold device file open and hence prevents device refcount
>>>>>>> to drop to 0. The solution in this patch is brute force where
>>>>>>> we try and find any place we access MMIO mapped to kernel
>>>>>>> address space and guard against the write access with a
>>>>>>> 'device-unplug' flag. This solution is obliviously racy
>>>>>>> because a device can be unplugged right after checking the
>>>>>>> falg.  I had an idea to instead not release but to keep those
>>>>>>> ranges reserved even after pci_driver.remove, until DRM device
>>>>>>> is destroyed when it's refcount drops to 0 and by this to
>>>>>>> prevent new devices plugged in and allocated some of the same
>>>>>>> MMIO address  range to get accidental writes into their
>>>>>>> registers.  But, on dri-devel I was advised that this will
>>>>>>> upset the PCI subsystem and so best to be avoided but I still
>>>>>>> would like another opinion from PCI experts on whether this
>>>>>>> approach is indeed not possible ?
> 
> 
> 
