Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFA13110CC
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 20:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhBER3a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 12:29:30 -0500
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:49616
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233537AbhBER1m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Feb 2021 12:27:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+PAjGjYIpVqUg4QFiTAjvYSjMqYWloq0zpmGCN/TVjo3AIO+ncqrwN35lhe85WxDJSPa8bHMGI4aFNIaGGHxYGEzJc/GErFj2gskoM16S6XLcZQJQhtCQkRVmQHfjHolGfg/MQ62k6rkMbyWucf8pr2PZ370ekXtdaCDXNQ01xj2wHM+FoRYeAoTcsydh99TrOiBWyWq4Ebbo42heI46KBpt7klsoJSv9SC5rWDubOv8EGkzjqjlEJY7Xxo4eYhz7wqLRaJRnpe3i1bJwL+gb4pMhlVOM5c066tUyZzMRTppQFTIpgfgWLceELt+WPM2N0HDisK8rIIgM/VZ2iLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ry0j03vQuyLFlVPTtRhV5evV+y+7hJqYoN2rLNtG68=;
 b=BJDQz701kOFXp772PSoqk54ciM1yUXzXYw9DW++Xr1TyNbUNgBbsCgrZKDd1oo4vF1gCZR5j9A77n7+XGrsyJYqiwHSeuwKM42SY7dwNDlGjXlnpVOiITK5FPnkZjxqh36Hi/Gcem5/pDygB3JekEITK0iDOlZt+4uux7uPTLwl6Kx6HI2INfM2LYYvNf2a2P/4YThrX+jfNwgYoEA5za1NXHtxYffrtzMkoWIba6PKhapdA5pFU4iOQlRcZHV9OqNPVzhPbJzrlwHEV+UGLQPXVd7+q/9qyu9qCJszt8hIJzR9Aqw2vyNsfDunKm+alDW3b9Ef2VBavHvsiY6N3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ry0j03vQuyLFlVPTtRhV5evV+y+7hJqYoN2rLNtG68=;
 b=JMjt+HJksnXXR2YHxmtcQKnvVmOj4go9O1o9UYUVM8XNtLbMlrwaidixEfcN4iYOz7KQZ16xA1zM3NktUPcK6mcS0WoW9XfZP2kdg1w6sdLPwMvFyX5BJ9d3SLvLSRp7/2tGdA++lz3GXyj5oc3poPhSgHvsJA/IVr03SdKkgEA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Fri, 5 Feb
 2021 19:09:11 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::41b1:11f5:fd1e:fc5f]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::41b1:11f5:fd1e:fc5f%5]) with mapi id 15.20.3825.023; Fri, 5 Feb 2021
 19:09:11 +0000
Subject: Re: Avoid MMIO write access after hot unplug [WAS - Re: Question
 about supporting AMD eGPU hot plug case]
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "s.miroshnichenko@yadro.com" <s.miroshnichenko@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>
References: <20210205153809.GA179207@bjorn-Precision-5520>
 <423067e5-9d65-5f0f-bedc-9c5939a63be7@amd.com>
 <CAKMK7uHX=8LferSxaj5vdm4h1worDv_dxs=krurYvtzzBnbsVw@mail.gmail.com>
From:   Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <51cfe8aa-9ea8-986b-c8d9-f24b186ed77d@amd.com>
Date:   Fri, 5 Feb 2021 14:09:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAKMK7uHX=8LferSxaj5vdm4h1worDv_dxs=krurYvtzzBnbsVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2607:fea8:3edf:49b0:74f0:8064:c429:544e]
X-ClientProxiedBy: YT1PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::34) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:74f0:8064:c429:544e] (2607:fea8:3edf:49b0:74f0:8064:c429:544e) by YT1PR01CA0125.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Fri, 5 Feb 2021 19:09:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a16e489f-cc7d-47db-d701-08d8ca098535
X-MS-TrafficTypeDiagnostic: SA0PR12MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB446292DDB03D64591A3C591EEAB29@SA0PR12MB4462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ekgbNNisJbrT3fyaZUVkTle78713MHpqOIe7Ul283MQxhJK6k+lxRTwMaE8T0AZNw4r40HjaOZR4rgS/BJjmTcS/eP2KBqLQCeTGGWbmOxODMrS2QELn5xyHgKVQ38USH31w8r4Qtsa4oZ26ipCU1ECbvZ/686jp4/6iLCxsaWEOqkegJP1ZE+XlzueoA0gVVaPK2RQn3/Cal7cHzbBspTSHOTtgeO4+DOi9ENXMavCNIm+d1HE+ABc3QGxODHsqp4sb8b+8fSPsOvbnRxv2jg4WQ0YXqULqrZ+hwQjRGjSgDRSVAu72mWgY93U5C5MTSGpYeCmTWuh9tja4UZE3ovWeul9n7IWJjh7bopx/VHeFonoGfEzHTNsdBhQIbbsJNtL+mUSqIoEI1O5DMBYzTrT3HhYEAmJk3m2dv8Thu7E+9bV67jBVs3crYtI+X9eMZehhhRbLkgDQv8BM++rikeDoyGp7qYdhw7T8IvwmBgqvcFuQK52RzHmRemY0H5A4kOMRsoFCduTDtPtHXL6jdfNzR81VcD1Uhh5rehG+I71hCoLqowQxlqw/KMtmHsofSuUeaepwzZzE+ca/1mosqmW2nCAE0jpdxKKeGhF3K+17pBVmOQI3ArWHu26pF/bWRAOFeqX50d07g1xvclMIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(16526019)(6916009)(45080400002)(4326008)(86362001)(31686004)(8936002)(966005)(2906002)(66946007)(186003)(5660300002)(66556008)(53546011)(66476007)(8676002)(83380400001)(2616005)(52116002)(6486002)(316002)(54906003)(36756003)(31696002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZTdMVHFaT0pWa1V2RHU3TXZHOGNBWHdFSFlGRHhML2t0R1gzSTVJQVNlVmhX?=
 =?utf-8?B?U3dlL3JtelVmRVpUaXZ4TXMzTzM0bFY3LzBZRmhIQnQ2ZCtidGdoUk5wTi9l?=
 =?utf-8?B?UFlranRCVWd5aUtTN2NoMjE2eHNDaUNKZU9UVHFKY2dsc1VIOWU4ZzFFYmx6?=
 =?utf-8?B?ZjFkTW9veUpoS2lZd1FhY0QxV3lLNWQza0J6RzhrakhPMmNzV3NhTU1SdHFS?=
 =?utf-8?B?c0J0cWRxQVY3U3luakR1QmhONEx0Z2hHdWQwcEhGRG5LYk9PUVdxbUd0dEhK?=
 =?utf-8?B?QU9KL1FYWkF0ZmsveUt4UXVvdS85bitBbFMvNjJuYXF1V1JMeGYxcHp0NjFE?=
 =?utf-8?B?NmhGUnMxM1NPTlBiS0NzSDYzNnRaQUIraXVyQnRiajJpaXBXYkEvb21JR0U5?=
 =?utf-8?B?UUI4MDNDcHN1Y2lra3lVK2RUYkdSOXEzdTlWMWtVRkVTaUpZc1hMZ3hSMkc1?=
 =?utf-8?B?cFJCTnRNNmpKZkxaQ2Y1V2tIUFYxaUJpRUhYTDZCMEgvVXlRdVgwWEJBTlJq?=
 =?utf-8?B?TnNEdXVlM2ZlWEdwQ2FvTjBNMVV1bERJejRDdnd2clI0eW16TVZoU1ZZaERE?=
 =?utf-8?B?MzRpbUViMWkvTVh3VzkvU3J1Q3ljalBMVEdMNmIzbkpsQnRxdUZvYXA0WmZq?=
 =?utf-8?B?dWRnbUVqNWhiSDdrRHB0YnZFYyt4c2lwa2paZ1d2UXRnYXVRbWZ1dksvLzh6?=
 =?utf-8?B?cHpWRmhNTHlBUFg3NmZ2U1ZHTjBtRlhaTU9mYzFmK0tCQnZlQjREYkhjVGpF?=
 =?utf-8?B?UklmL3JlUktMVW5sQVd2azJPUDN1TlU3cWg5SEIwYmlqYkRPSW1USVZlQzNC?=
 =?utf-8?B?MnEwWVRpbEhjTkxkcytlZVBLQ1V3K1Bvb2FWM2J6SFRIM0g4VE9iaTlwVlpQ?=
 =?utf-8?B?cTZBN255WStYblA4MHFsOGhLQnFZaDNJMzlDakplNGlBYjBSM295eVMzUFZN?=
 =?utf-8?B?Q3QzTGNwbHdPaFBxTHNReEpsTzhTWktBcU5NVkkyeEF0TzdWWFJkR2RMZ2Vu?=
 =?utf-8?B?ejZEcWYyT1JnWDQ2eVNZNjdXaU9oUUhrTlJSSzc3TW1ob24rdzNTTktlVXZm?=
 =?utf-8?B?eFRySVJYTVAxN3VoN1dvSzZDdGVsbGEzNzJqa2Y0Ti8xckpiMFVxcFpiTVNn?=
 =?utf-8?B?OFRwMnErck1rVjBhelZOaEZjOXg0ZjdobmxBWWZnRE5KaStIQ3VaRHkvZHdo?=
 =?utf-8?B?ZTNtallnTzdIaTV2WDBNOFJHTDByZUpPSW41M2hnemQ5eGRlTFNVbWlCRDBm?=
 =?utf-8?B?MzdzZTlKSDE3cDlMbm1ySTcrQjNZUnJRUHh5bmFCdzE4VTJNZUxjaDA4VFBn?=
 =?utf-8?B?eTB5Z3B3bkRqU2tkVnFhRXd4QytuakNpNFZEc3ExdGVBWjJxS0VkTkFyRU1M?=
 =?utf-8?B?Z3hNdG1LVTFZc0dFQkNaVE9MdXptTllFTjgzbEEwb2l1dU51MDVZK1JYUDND?=
 =?utf-8?B?MXhLaUlMd3dWN3RGWWdwTjhrN3lkZmZOeDd5czltT3R0MlRCQ252amh0R0lY?=
 =?utf-8?B?c1hxNTlCaWF1QnF6bFd5Vnc5dk5obUwzdFdabGJNWVZWVWtDV2tBQk1PM3Ey?=
 =?utf-8?B?ZjcvcVZtNm41LzdHWXp6eFYxT25zT0dDcmtxbW00eFoySFRpU2pzTlBuSUls?=
 =?utf-8?B?ZWR1ZStBNG10MnJTcDJmbmtidTB4dExzRFNmVUdRYVJYcXprdThJcHFKd296?=
 =?utf-8?B?RHhITHdDTUxyUk42VDJFOEM4aHh3N0NJUHQ1TTlIUGVBV2VDYzNFU3I1MVQ4?=
 =?utf-8?B?T0VHUENlUWx1WlRGUjZOb2hjUXR4dmhyM2U1bDA1Q09idE4xcEtBYWxzMXd1?=
 =?utf-8?B?WXhpT0FXRFEvOWJoQ1BrL0d5SGt6UGlTemR3aS83WnJ5eHpNS1Z4OC9HbUZZ?=
 =?utf-8?Q?j6d0Ehvz5702h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16e489f-cc7d-47db-d701-08d8ca098535
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 19:09:11.4697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StcVMg2Z8IRs0K3TzU04fqpsglq7oJoXYkM4kA1PNtyskz/qZFI6v6V5xYDmUOlKxzTDxj+65fMRRZLoDWwpag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/5/21 12:59 PM, Daniel Vetter wrote:
> On Fri, Feb 5, 2021 at 5:08 PM Andrey Grodzovsky
> <Andrey.Grodzovsky@amd.com> wrote:
>>
>> + Daniel
>>
>>
>> On 2/5/21 10:38 AM, Bjorn Helgaas wrote:
>>> On Thu, Feb 04, 2021 at 11:03:10AM -0500, Andrey Grodzovsky wrote:
>>>> + linux-pci mailing list and a bit of extra details bellow.
>>>>
>>>> On 2/2/21 12:51 PM, Andrey Grodzovsky wrote:
>>>>> Bjorn, Sergey I would also like to use this opportunity to ask you a
>>>>> question on a related topic - Hot unplug.
>>>>> I've been working for a while on this (see latest patchset set here
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058595.html&amp;data=04%7C01%7CAndrey.Grodzovsky%40amd.com%7Cb45e7ccc6a9d44746b4608d8c9ffdf6c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637481448110995519%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=9tZ1zY3t3jkclPsNB0LEUWiN3CGcjAFGUGgXjV1KK3I%3D&amp;reserved=0).
>>>>> My question is specifically regarding this patch
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-January%2F058606.html&amp;data=04%7C01%7CAndrey.Grodzovsky%40amd.com%7Cb45e7ccc6a9d44746b4608d8c9ffdf6c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637481448110995519%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=PqD048XLtkaAz6dKygr0rRTnFdwH0Y8WYM9JEYQ1zdA%3D&amp;reserved=0
>>>>> - the idea here is to
>>>>> prevent any accesses to MMIO address ranges still mapped in kernel page
>>>
>>> I think you're talking about a PCI BAR that is mapped into a user
>>> process.
>>
>> For user mappings, including MMIO mappings, we have a reliable approach where
>> we invalidate device address space mappings for all user on first sign of device
>> disconnect
>> and then on all subsequent page faults from the users accessing those ranges we
>> insert dummy zero page
>> into their respective page tables. It's actually the kernel driver, where no
>> page faulting can be used
>> such as for user space, I have issues on how to protect from keep accessing
>> those ranges which already are released
>> by PCI subsystem and hence can be allocated to another hot plugging device.
> 
> Hm what's the access here? At least on the drm side we should be able
> to tear everything down when our ->remove callback is called.
> 
> Or I might also be missing too much of the thread context.

I mean we could have a bunch of background threads doing things and periodic
timers that poll different stuff (like temperature sensosr monitoring ,e.t.c)
and some stuff just might be in the middle of HW programming just as
the device was extracted

> 
>>> It is impossible to reliably *prevent* MMIO accesses to a BAR on a
>>> PCI device that has been unplugged.  There is always a window where
>>> the CPU issues a load/store and the device is unplugged before the
>>> load/store completes.
>>>
>>> If a PCIe device is unplugged, an MMIO read to that BAR will complete
>>> on PCIe with an uncorrectable fatal error.  When that happens there is
>>> no valid data from the PCIe device, so the PCIe host bridge typically
>>> fabricates ~0 data so the CPU load instruction can complete.
>>>
>>> If you want to reliably recover from unplugs like this, I think you
>>> have to check for that ~0 data at the important points, i.e., where
>>> you make decisions based on the data.  Of course, ~0 may be valid data
>>> in some cases.  You have to use your knowledge of the device
>>> programming model to determine whether ~0 is possible, and if it is,
>>> check in some other way, like another MMIO read, to tell whether the
>>> read succeeded and returned ~0, or failed because of PCIe error and
>>> returned ~0.
>>
>> Looks like there is a high performance price to pay for this approach if we
>> protect at every possible junction (e.g. register read/write accessors ), I
>> tested this by doing 1M read/writes while using drm_dev_enter/drm_dev_exit which
>> is DRM's RCU based guard against device unplug and even then we hit performance
>> penalty of 40%. I assume that with actual MMIO read (e.g. pci_device_is_present)
>>    will cause a much larger performance
>> penalty.
> 
> Hm that's surprising much (for the SRCU check), but then checking for
> every read/write really is a bit overkill I think.
> -Daniel

So i guess there is no magic bullet to this after all and we back to some kind 
of gurds around the sensitive stuff such as blocking all GPU SW schedulers, 
refusing father direct IB submissions to HW rings, rejecting all IOCTls.

Andrey

> 
> 
>> Andrey
>>
>>>
>>>>> table by the driver AFTER the device is gone physically and from the
>>>>> PCI  subsystem, post pci_driver.remove
>>>>> call back execution. This happens because struct device (and struct
>>>>> drm_device representing the graphic card) are still present because some
>>>>> user clients which  are not aware
>>>>> of hot removal still hold device file open and hence prevents device
>>>>> refcount to drop to 0. The solution in this patch is brute force where
>>>>> we try and find any place we access MMIO
>>>>> mapped to kernel address space and guard against the write access with a
>>>>> 'device-unplug' flag. This solution is obliviously racy because a device
>>>>> can be unplugged right after checking the falg.
>>>>> I had an idea to instead not release but to keep those ranges reserved
>>>>> even after pci_driver.remove, until DRM device is destroyed when it's
>>>>> refcount drops to 0 and by this to prevent new devices plugged in
>>>>> and allocated some of the same MMIO address  range to get accidental
>>>>> writes into their registers.
>>>>> But, on dri-devel I was advised that this will upset the PCI subsystem
>>>>> and so best to be avoided but I still would like another opinion from
>>>>> PCI experts on whether this approach is indeed not possible ?
>>>>>
>>>>> Andrey
> 
> 
> 
