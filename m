Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7591B9037
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 14:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgDZMzU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 08:55:20 -0400
Received: from mail-eopbgr770072.outbound.protection.outlook.com ([40.107.77.72]:18336
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbgDZMzU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Apr 2020 08:55:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZ+g0oFE2hHBquGOYbHcykaAMseQE2g6zZ6QtjcZ3s6lEEI3vkdE/H1tbkilUvcHs7ICZdUJq8dH37ad9wyusjRuqojZjkDU6Kah0ztL0szqEO/f1gavFiEBt8Hbk1kZ2KFqVewo9EXbncj/iMzUXEVkUwNk6u9CKzXpumvvwLz3ELmFoYaohFfoSpn1cnmybRGNjxpRsg4o7fgaKTTcXEn3lLmTDDGgsTscra985SUvUOvj7mi8gzvzsNRnzzto0cZIJ/W8dZ3BHC8VKd9wuxsMjr1EdB33KC+iOoUl3PdSbWA0HcrzzF8jQSxIh20GpPBUaOm0ncy674NxaBX1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RA0mVJMaLpYlkUoT8mggVXyQGdgJX3ftna+vzdid3A0=;
 b=Bhxu2Dzc0hzdtyubh+NkCAdhBTU9NWBOeGSHc9yb+3STNGoIlF0ry2bQURS9Etf0wBBs9yjaf+MY6oMV/aRrob3cSbhcU7z5ASA6T/+scoK8bXFxh5Y/7XOPGC3NKDNusHSUwGBF02yGsVV8rRaztQ++piOLZ+Ab7dKWxy8MYhqQmNv81s8mAdtxjDdCiohne00UqP5mEKZUmeheNlBaGMcGRq/bcEmmZENXMijufuUPC5TCb96LWAL0p6ktTBmkxQLVrAJ6xDaRt4VYfezC2fWBzsf3Oylry9kF/lLp4rBU982TvoAjnUQJY30rq1KOH3rQA8qH9aFx0u1TymXwDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RA0mVJMaLpYlkUoT8mggVXyQGdgJX3ftna+vzdid3A0=;
 b=kB12a4ZwKhpAh1c2R6Hq1m5vZ34P2A3VHRP4fX22ENP7N5Acw7UKY3peS22vUOO4lGJ9znvH2rCW/Joo8VHbvwsEWc1Drlwv8AF+E54KZZSkEEkwVKOzalvEwsrA1H1K9n9hzzdCsMkLc2vYCDjjUBIoQKzLtWIyJBsWvavfufc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sun, 26 Apr
 2020 12:55:13 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 12:55:13 +0000
Subject: Re: [PATCH] PCI: allow pci_resize_resource() to be used on devices on
 the root bus
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        jon@solid-run.com, wasim.khan@nxp.com
References: <20200421162256.26887-1-ardb@kernel.org>
 <2fb2b8c1-89be-1e59-c82c-b63e3afa62d5@amd.com>
 <CAMj1kXE0wFtyD7YGxXzKWAx+BT6x9CYreaFyEeFfeYJFeQbo_g@mail.gmail.com>
 <CAMj1kXH3WVMehgbMwUEjBSYudAM7PtWAcAYcWspyq4eZJzBwTQ@mail.gmail.com>
 <d06a3062-ce45-fdd2-6f22-c56e2e2f8f4b@amd.com>
 <CAMj1kXG04ehc6WxR=YSzjrV33O07h6hcWocUAfnfdGpDG13w6g@mail.gmail.com>
 <CAMj1kXFWfhYPwfO29Qv6w1-Dk=Ph+ZZEXPgvqf5Abrg3qf2jWA@mail.gmail.com>
 <ea3f1f02-e7da-8baf-1457-ecfe3d95bd02@amd.com>
 <CAMj1kXEtcyOcLJ4WdcoLaV9tvLH2mvPBYjhi60po4XWk9sqw4A@mail.gmail.com>
 <59f26d64-70a0-687d-45d8-2ae1b63a7c11@amd.com>
 <CAMj1kXFA=aXWqQ2XDa=1wYKQfrMR26du76HowzUe2fdK+FBgow@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c740802b-8cae-dcdb-c081-e59171faf733@amd.com>
Date:   Sun, 26 Apr 2020 14:55:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CAMj1kXFA=aXWqQ2XDa=1wYKQfrMR26du76HowzUe2fdK+FBgow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR05CA0095.eurprd05.prod.outlook.com
 (2603:10a6:208:136::35) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR05CA0095.eurprd05.prod.outlook.com (2603:10a6:208:136::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 12:55:11 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05072bce-ab59-4339-9ecf-08d7e9e10ee8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4108:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4108616B317861FF3598EAC983AE0@DM6PR12MB4108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(2906002)(52116002)(81156014)(36756003)(8936002)(186003)(66946007)(6666004)(66556008)(6486002)(66476007)(16526019)(6916009)(8676002)(4326008)(31696002)(478600001)(2616005)(5660300002)(316002)(86362001)(31686004)(66574012);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IX3KjtFGxlH6JHJqHHNk8wkwPH0ZYHmKwznYRFh24YfbErABWjYh1Mf+Xc4jnaQ9CvMQbIqEX1a8JLAW8NrdgQ/YM8A+qw6AK5hacfzRtcvdAXTPaFT/6fy3SaJ8vjujCMItSbiu/WgYOdEprMARm/3Cs2/VtwQ/VqKBqvlUOHn3Ch5Bby16aeRt8c9m6gIw2fQQwslo7iuz0Kf6PdPbKvNsN0cE1M84fYttuQispvWhrKqBKTOX6RViOnbbAMlyAKFes51JIH8RIz0STu+FwYpzoNDYvOtg8srSkNNdO4SFmNj+QY6H55XUyp5hF/D0Gx4nRr6BGyxlO6TGgA2d/yoWxO6tpO4aUEitS8C+yo2UB6RtYt6WeprRfKkhxP6YMm9+xQ1Yq8s5dCzN3+puam+hedLVFSshYWhqfvs0znj7EdlYsh4kIRD6wyR02qgY
X-MS-Exchange-AntiSpam-MessageData: NI9Ypk0p/oSI1nLRoeEDebFLoSML9wz8aY7GObOu2NuOF9Wgvt/yJ4f2bsAhADefOlJBP9LE7XKmvJhdxI1yt8zTr6eIgDT6zRnnn1U/ohJQ0eqPkt9vqEgwjNx9j93W4W9OZGt0bSG808mOos8Abrxxtxuzqh7FDhBe+cmuhd4LyG+cG3Xmud7SK6IF0ZfkEImKSypQT7XhZQEtSvLbQF6bfLxedS/B0jrier5usUV8QegswaOtZJT5sc2r1FP6MZG8qsx+I9gDzZW4DvbHcN0bSOgjUjOAwIXl4waIqb7SoCNLg2xm/seRJ3fIbn6tqLmCYRhl9+F6sPnBcn53BvFzriD0GhaOqs988bX/K+1F4inZR544XVzpz0MzY9Q41gyNiIu+q3Ji87DZC0wh5Lhr81NHX1hZhAnM9NsDv55w3+SGpcRbXILjam4PBAqIDdHKFkYCtriOJQOrJ8UNphYBnt8tpSSvfkVOYeKvoZkh2ZEn0b1Gue4Zcyjh2g/vUSKr5GLHpY9XVG0reKU85EbdY07elILDUR8kdxrNMXuv/voM1XtV7OCNsDnoTA1Nt+QfawISWUpFKwhhNsw/y8xTVMMXNGOJ+WA+eMh10rS0V/jLG+CUh8TacDofgyXEx66xNzsT7eDGbe23XV60k3iA/p/+b/COR1XCX+Po2Rfsa09k5QZ9qJshp2M6KCm0wPqJeLA+9zT58htyKWrcVp+YS5UzI9grUCDu4c30IRiudNUudyb8ncGAGnHv3Wgl4JA+ZYieMZn2uE0//WS4GmeiGnPIKXOJ7+cn9nMkwOFeCYPwJJCS/J27itTvcnSi1x/zxXb2Jf3s0uHPxNVgczxl6GL0Pv/vg427/4b1fQc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05072bce-ab59-4339-9ecf-08d7e9e10ee8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 12:55:12.8481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxazPfr6opAz4XjQU2NpEGqQB5BDLmKGk7Y/RYUPcgQEfKNoI/F6/iTr1PZvWY1O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 26.04.20 um 14:08 schrieb Ard Biesheuvel:
> On Sun, 26 Apr 2020 at 13:27, Christian König <christian.koenig@amd.com> wrote:
>> Am 26.04.20 um 12:59 schrieb Ard Biesheuvel:
>>> On Sun, 26 Apr 2020 at 12:53, Christian König <christian.koenig@amd.com> wrote:
>>>> Am 26.04.20 um 12:46 schrieb Ard Biesheuvel:
>>>>> On Sun, 26 Apr 2020 at 11:58, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>>> On Sun, 26 Apr 2020 at 11:08, Christian König <christian.koenig@amd.com> wrote:
>>>>>>> Am 25.04.20 um 19:32 schrieb Ard Biesheuvel:
>>>>>>>> On Tue, 21 Apr 2020 at 19:07, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>>>>>> On Tue, 21 Apr 2020 at 18:43, Christian König <christian.koenig@amd.com> wrote:
>>>>>>>>>> Am 21.04.20 um 18:22 schrieb Ard Biesheuvel:
>>>>>>>>>>> When resizing a BAR, pci_reassign_bridge_resources() is invoked to
>>>>>>>>>>> bring the bridge windows of parent bridges in line with the new BAR
>>>>>>>>>>> assignment.
>>>>>>>>>>>
>>>>>>>>>>> This assumes that the device whose BAR is being resized lives on a
>>>>>>>>>>> subordinate bus, but this is not necessarily the case. A device may
>>>>>>>>>>> live on the root bus, in which case dev->bus->self is NULL, and
>>>>>>>>>>> passing a NULL pci_dev pointer to pci_reassign_bridge_resources()
>>>>>>>>>>> will cause it to crash.
>>>>>>>>>>>
>>>>>>>>>>> So let's make the call to pci_reassign_bridge_resources() conditional
>>>>>>>>>>> on whether dev->bus->self is non-NULL in the first place.
>>>>>>>>>>>
>>>>>>>>>>> Fixes: 8bb705e3e79d84e7 ("PCI: Add pci_resize_resource() for resizing BARs")
>>>>>>>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>>>>>>>> Sounds like it makes sense, patch is
>>>>>>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>.
>>>>>>>>> Thanks Christian.
>>>>>>>>>
>>>>>>>>>> May I ask where you found that condition?
>>>>>>>>>>
>>>>>>>>> In this particular case, it was on an ARM board with funky PCIe IP
>>>>>>>>> that does not expose a root port in its bus hierarchy.
>>>>>>>>>
>>>>>>>>> But in the general case, PCIe endpoints can be integrated into the
>>>>>>>>> root complex, in which case they appear on the root bus, and there is
>>>>>>>>> no reason such endpoints shouldn't be allowed to have resizable BARs.
>>>>>>>> Actually, looking at this more carefully, I think
>>>>>>>> pci_reassign_bridge_resources() needs to do /something/ to ensure that
>>>>>>>> the resources are reshuffled if needed when the resized BAR overlaps
>>>>>>>> with another one.
>>>>>>> The resized BAR never overlaps with an existing one since to resize a
>>>>>>> BAR it needs to be deallocated and disabled. This is done as a
>>>>>>> precaution to avoid potential incorrect routing and decode of memory access.
>>>>>>>
>>>>>>> The call to pci_reassign_bridge_resources() is only there to change the
>>>>>>> resources of the upstream bridge to the device which is resized and not
>>>>>>> to adjust the resources of the device itself.
>>>>>>>
>>>>>> So does that mean that BAR resizing is only possible if no other BARs,
>>>>>> either on the same device or on other ones, need to be moved?
>>>>> OK, so obviously, the current code already releases and reassigns
>>>>> resources on the same device.
>>>>>
>>>>> What I am not getting is how this works with more complex topologies, e.g.,
>>>>>
>>>>> RP 1
>>>>> multi function device (e.g., GPU + HDMI)
>>>>> GPU BAR 0 256M
>>>>> GPU BAR 1 16 M
>>>>> HDMI BAR 0 16 KB
>>>>>
>>>>> RP 2
>>>>> some other endpoint using MMIO64 BARs
>>>>>
>>>>> So in this case, RP1 will get a prefetchable bridge BAR window of 512
>>>>> M, and RP2 may get one that is directly adjacent to that. When
>>>>> resizing GPU BAR 0 to 4 GB, the whole hierarchy needs to be
>>>>> reshuffled, right?
>>>> Correct, yes. Because you not only need to configure the BARs of the
>>>> device(s), but also the bridges in between to get the routing right.
>>>>
>>> Right. But my point is really the RP2 is not a bridge in between.
>>>
>>>> Just wrote another mail with an example how this works on amdgpu. What
>>>> aids us in amdgpu is that the devices only has two 64bit BARs, the
>>>> FB/VRAM which we want to resize and the doorbell.
>>>>
>>>> I can easily disable access to the doorbell BAR temporary in amdgpu,
>>>> otherwise the whole resize wouldn't work at all.
>>>>
>>> OK, so the example is clear, and I understand how you have to walk the
>>> path up to the root bus to reconfigure the bridge BARs on each
>>> upstream bridge.
>>>
>>> But at each level, the BAR space that is being reassigned may be in
>>> use by another device already, no? RP2 in my example is a sibling of
>>> RP1, so the walk up to the root will not traverse it. If RP2's  bridge
>>> BARs conflict with the resized BAR below RP1, will the resize simply
>>> fail?
>> Yes exactly that. When BARs on upstream bridges can't be extended
>> because some other downstream BAR can't move around we just abort the
>> resize.
>>
> OK.
>
> So how does this work with, e.g., other functions on the same
> endpoint, like the audio adapter that is exposed for the audio part of
> the HDMI port? Without releasing its BAR resource, it may end up
> overlapping, no? And you cannot really release it without
> collaboration from the driver, afaict.

Correct yes. The trick we use with AMD GPUs is that the audio endpoint, 
GPU MMIO register etc.. are all 32bit resources. The only two 64bit 
resources we have are the FB/VRAM and the doorbell BAR.

Since we usually need to resize the FB/VRAM BAR much larger than the 
32bit/4GB limit anyway we separate the 32bit resources from the 64bit 
resources.

This works since bridges have separate 32bit and 64bit windows for 32bit 
and 64bit resources.

But yes if you have a mix of 64bit devices behind a single bridge this 
will currently fail rather obviously.

What we could maybe do to improve this is to teach the resources 
assignment code in the PCI subsystem to take resize-able BARs into 
account. This way we could trigger resource reallocation before drivers 
load and start using the BARs in question.

Regards,
Christian.
