Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BE61B9065
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 15:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgDZNQn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 09:16:43 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:19532
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbgDZNQm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Apr 2020 09:16:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xwi5UrjhJVi+3dIn3C0F+AwS52RNpsK3viSlZ6G1/aErOUKnNw2RtTm+B8ZgXht6T27LG/RaSPkKQGxxTn0F7ddJABGz+Q2LM2bHL4CWX/5ZTsguiSV5NmJeV+rZwyYfMFBsCfKhLOK222lfM9KN+24myoEmPb4n2Vafih3EV6yu0BgSNhqv3iOIY2owQWhwe5D1qEVhVFENlJ4qg32zei0PsAb+YnFggaViXlFrs2nP8m1mKGfrhzSNU2KkBK2T4YwJ3a8ZJbahghl6YgUKSYBiiDStZChd3hbIrN8wBm7RgJsXbAZw+hy5B9l2BnuDlsUFCvp+s3YD889haOADQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdQV/d9lg7AABMcTJTM2f3jNz3kaTl/9nGGNcv2FX24=;
 b=i+uVtjjTP5DZwc53je2/mLYI5S555CUNPcW58MbSWd92Lj8l6lK6ahypJF1xuvjPGIlEmr/eBKTjjbbBlmyGfoPZZZYwcU1WNSMI7z7H/W1rV4Gr4kjDXXFFtohFuGMOnyGmnL3GcaMARut5cotcLQ0p1Lr6E+r/oH0nypaLRHk30lBhvCY7M5BbZV/8vDzSIlCDdip3T5n7dhBcN8agbnlVNUKt4K9Y/HUyzbvqaeXesyZR5tJQiMZqjRs9QISNW5iiF9IcvnWI1YgjlzOL0le+5i+Jw2ZviBr6YdQeKqn7FaSOrF78ehQyMu22A2XP71fOi2iUT+mxTBZ+ubf6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdQV/d9lg7AABMcTJTM2f3jNz3kaTl/9nGGNcv2FX24=;
 b=OELtc5mPVpj0Dks9a2fpH8MwnBdvApl26oGuNYsVkyh1FkAqXRRPk8PveCLE6OJKvZA/UcEDF4yDAD+hDL7FA+OxGIMTyalRaw4Dq4BmSgtO6uXQKpYL0b55nrcVIDVwykA2VyH6KNytpI7UvPBkWsAbNGJY3JnY0St4LnLg3Do=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 13:16:37 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 13:16:37 +0000
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
 <c740802b-8cae-dcdb-c081-e59171faf733@amd.com>
 <CAMj1kXF6ae7+UCqMYsiQxmKKZgprnmfo4Ows5KCyxRFRcZK9LA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b7bdd661-3b70-1c91-9bb7-57604b8af006@amd.com>
Date:   Sun, 26 Apr 2020 15:16:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CAMj1kXF6ae7+UCqMYsiQxmKKZgprnmfo4Ows5KCyxRFRcZK9LA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0501CA0047.eurprd05.prod.outlook.com
 (2603:10a6:200:68::15) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0501CA0047.eurprd05.prod.outlook.com (2603:10a6:200:68::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 13:16:35 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9dbd6609-f419-46c8-946e-08d7e9e40c82
X-MS-TrafficTypeDiagnostic: DM6PR12MB3739:
X-Microsoft-Antispam-PRVS: <DM6PR12MB37392CF93C10C856A22EE0EB83AE0@DM6PR12MB3739.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(66476007)(6916009)(66946007)(2906002)(31686004)(6666004)(5660300002)(31696002)(36756003)(478600001)(52116002)(66556008)(86362001)(66574012)(8676002)(8936002)(16526019)(2616005)(6486002)(4326008)(81156014)(316002)(186003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/66fc+PudiHgFzMLezhebdRhIL0VdRXECp9nNtLXKWeQjwxLcHREc8gJa3EDQ20Hn3Z6JhjuPlCTIwmvuwDxWuKdHc/8PDfzg+GZke/xiNLE1zCfNAzDtF7CJKBtIHXFjMgfiWT5WMDPtDACeJehcpBHuVlJdZbm61S+dIC2sElGzD2gGNEYUAmk+TCZUHX55VM7+DSOqDkdANd23N0/2ordYXqE7YrS2Z5+ug8BHVweeo3jRsVdp5wJDL4+GBl3LPWbwUl/CZVj9IvQqm15dGPQH6fiA4HPp87aDL2muUAlIhkmRNPi5U9Nh4kc2xHsExoFcAGBMPGgD9XplWE2QBwVEtiGGfvuCjdzkgslTf8LWMOSGu89E4ZlE1ELmqAjHVq/vK7n+psJCtiDj69Antzt2epSod4tENQ3IipqVdZzut6lriz61TUt1E3gB59
X-MS-Exchange-AntiSpam-MessageData: XyMGFbmHan6SYLWw7DNOcE46K1tuCsD8Sk3CHdf7KSJY9VM8/oouOydpe6RJ9CsY1a1394aaUdSRVK5EyjrV3qnUavwUDJ5E3h42ePMe+Bs1kH89WKdnEd6DGLu2KkoNXqTQWcTG4dd6D7ZjciwDzlWHvJvCKMdtpfv8rztGz0g29BV2zCOBD3N9MabPMSBahOL5fUgKdv0vBhy1wimBZBWxR+SN8fCeVN58HK9NdyNYslFx/pOQyYL4031WoFW+wWJoO3YDJDp8/Gz9+ObLoKPbW1jLxbwQCrkGSfmEG4JaUA/EXYdenuBuVtMIr/pziY9GE1vTM1mw95lzTng0rkGKLjlbnDRRhTorJVkfZltX8AYeXCqqp9jaxuGyApIncoUnLr+5PQcNXLbUilzF/lYTkldXoufS3G+/a0zZxEVQf2pEmwpGEqVPLkMC7Eo4PMwyi2X9BGPUsplS+jWlRmSAtVj05yTm7x5mibdP/1yzw/WN99r7Vg8Zn6cqvmhnbC6sjkJxLPNaZbE2Z+YxKq1n1FU3lzJlYDFNBjOSO3bekj7QyzaVrL7bTvrt/XBBHELKIaAvisfQvbH/kql6WkkWn21NWQqXLG49qqK8pAoCc5pnmJ9eBMu1ZAbR/6Y7PEbWKX+nFAsMvNakzX1L5VBIP+IzV9pnaYoT99nLLaQVSpyCRF9XLgVSyPWamfmSK0QNI16uj5XBzajDKNbSRHWhvkM/d22WIu7HeriiNHoKnYpbyBiiJea/8S2SsxyJNtnR9jwUpDE+glDUJOK8eX3FxOELqdUElqgGTDqIBjiSK9sHH2F8J0u5nrH8y0PiOgDjS8lm6kbVzPfyX5CMKAte5he2zYZ+jvauNVh42Kc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbd6609-f419-46c8-946e-08d7e9e40c82
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 13:16:37.0761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6Vyx3uKzFOmpVvoaIcQpCX6TNPS5NaLkGKQ5yrRhTWALT/AsANzk2eHSupJC30w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3739
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 26.04.20 um 15:04 schrieb Ard Biesheuvel:
> On Sun, 26 Apr 2020 at 14:55, Christian König <christian.koenig@amd.com> wrote:
>> Am 26.04.20 um 14:08 schrieb Ard Biesheuvel:
>>> On Sun, 26 Apr 2020 at 13:27, Christian König <christian.koenig@amd.com> wrote:
>>>> Am 26.04.20 um 12:59 schrieb Ard Biesheuvel:
>>>>> On Sun, 26 Apr 2020 at 12:53, Christian König <christian.koenig@amd.com> wrote:
>>>>>> Am 26.04.20 um 12:46 schrieb Ard Biesheuvel:
>>>>>>> On Sun, 26 Apr 2020 at 11:58, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>>>>> On Sun, 26 Apr 2020 at 11:08, Christian König <christian.koenig@amd.com> wrote:
>>>>>>>>> Am 25.04.20 um 19:32 schrieb Ard Biesheuvel:
>>>>>>>>>> On Tue, 21 Apr 2020 at 19:07, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>>>>>>>> On Tue, 21 Apr 2020 at 18:43, Christian König <christian.koenig@amd.com> wrote:
>>>>>>>>>>>> Am 21.04.20 um 18:22 schrieb Ard Biesheuvel:
>>>>>>>>>>>>> When resizing a BAR, pci_reassign_bridge_resources() is invoked to
>>>>>>>>>>>>> bring the bridge windows of parent bridges in line with the new BAR
>>>>>>>>>>>>> assignment.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This assumes that the device whose BAR is being resized lives on a
>>>>>>>>>>>>> subordinate bus, but this is not necessarily the case. A device may
>>>>>>>>>>>>> live on the root bus, in which case dev->bus->self is NULL, and
>>>>>>>>>>>>> passing a NULL pci_dev pointer to pci_reassign_bridge_resources()
>>>>>>>>>>>>> will cause it to crash.
>>>>>>>>>>>>>
>>>>>>>>>>>>> So let's make the call to pci_reassign_bridge_resources() conditional
>>>>>>>>>>>>> on whether dev->bus->self is non-NULL in the first place.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Fixes: 8bb705e3e79d84e7 ("PCI: Add pci_resize_resource() for resizing BARs")
>>>>>>>>>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>>>>>>>>>> Sounds like it makes sense, patch is
>>>>>>>>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>.
>>>>>>>>>>> Thanks Christian.
>>>>>>>>>>>
>>>>>>>>>>>> May I ask where you found that condition?
>>>>>>>>>>>>
>>>>>>>>>>> In this particular case, it was on an ARM board with funky PCIe IP
>>>>>>>>>>> that does not expose a root port in its bus hierarchy.
>>>>>>>>>>>
>>>>>>>>>>> But in the general case, PCIe endpoints can be integrated into the
>>>>>>>>>>> root complex, in which case they appear on the root bus, and there is
>>>>>>>>>>> no reason such endpoints shouldn't be allowed to have resizable BARs.
>>>>>>>>>> Actually, looking at this more carefully, I think
>>>>>>>>>> pci_reassign_bridge_resources() needs to do /something/ to ensure that
>>>>>>>>>> the resources are reshuffled if needed when the resized BAR overlaps
>>>>>>>>>> with another one.
>>>>>>>>> The resized BAR never overlaps with an existing one since to resize a
>>>>>>>>> BAR it needs to be deallocated and disabled. This is done as a
>>>>>>>>> precaution to avoid potential incorrect routing and decode of memory access.
>>>>>>>>>
>>>>>>>>> The call to pci_reassign_bridge_resources() is only there to change the
>>>>>>>>> resources of the upstream bridge to the device which is resized and not
>>>>>>>>> to adjust the resources of the device itself.
>>>>>>>>>
>>>>>>>> So does that mean that BAR resizing is only possible if no other BARs,
>>>>>>>> either on the same device or on other ones, need to be moved?
>>>>>>> OK, so obviously, the current code already releases and reassigns
>>>>>>> resources on the same device.
>>>>>>>
>>>>>>> What I am not getting is how this works with more complex topologies, e.g.,
>>>>>>>
>>>>>>> RP 1
>>>>>>> multi function device (e.g., GPU + HDMI)
>>>>>>> GPU BAR 0 256M
>>>>>>> GPU BAR 1 16 M
>>>>>>> HDMI BAR 0 16 KB
>>>>>>>
>>>>>>> RP 2
>>>>>>> some other endpoint using MMIO64 BARs
>>>>>>>
>>>>>>> So in this case, RP1 will get a prefetchable bridge BAR window of 512
>>>>>>> M, and RP2 may get one that is directly adjacent to that. When
>>>>>>> resizing GPU BAR 0 to 4 GB, the whole hierarchy needs to be
>>>>>>> reshuffled, right?
>>>>>> Correct, yes. Because you not only need to configure the BARs of the
>>>>>> device(s), but also the bridges in between to get the routing right.
>>>>>>
>>>>> Right. But my point is really the RP2 is not a bridge in between.
>>>>>
>>>>>> Just wrote another mail with an example how this works on amdgpu. What
>>>>>> aids us in amdgpu is that the devices only has two 64bit BARs, the
>>>>>> FB/VRAM which we want to resize and the doorbell.
>>>>>>
>>>>>> I can easily disable access to the doorbell BAR temporary in amdgpu,
>>>>>> otherwise the whole resize wouldn't work at all.
>>>>>>
>>>>> OK, so the example is clear, and I understand how you have to walk the
>>>>> path up to the root bus to reconfigure the bridge BARs on each
>>>>> upstream bridge.
>>>>>
>>>>> But at each level, the BAR space that is being reassigned may be in
>>>>> use by another device already, no? RP2 in my example is a sibling of
>>>>> RP1, so the walk up to the root will not traverse it. If RP2's  bridge
>>>>> BARs conflict with the resized BAR below RP1, will the resize simply
>>>>> fail?
>>>> Yes exactly that. When BARs on upstream bridges can't be extended
>>>> because some other downstream BAR can't move around we just abort the
>>>> resize.
>>>>
>>> OK.
>>>
>>> So how does this work with, e.g., other functions on the same
>>> endpoint, like the audio adapter that is exposed for the audio part of
>>> the HDMI port? Without releasing its BAR resource, it may end up
>>> overlapping, no? And you cannot really release it without
>>> collaboration from the driver, afaict.
>> Correct yes. The trick we use with AMD GPUs is that the audio endpoint,
>> GPU MMIO register etc.. are all 32bit resources. The only two 64bit
>> resources we have are the FB/VRAM and the doorbell BAR.
>>
>> Since we usually need to resize the FB/VRAM BAR much larger than the
>> 32bit/4GB limit anyway we separate the 32bit resources from the 64bit
>> resources.
>>
>> This works since bridges have separate 32bit and 64bit windows for 32bit
>> and 64bit resources.
>>
>> But yes if you have a mix of 64bit devices behind a single bridge this
>> will currently fail rather obviously.
>>
> OK, thanks for confirming.
>
>> What we could maybe do to improve this is to teach the resources
>> assignment code in the PCI subsystem to take resize-able BARs into
>> account. This way we could trigger resource reallocation before drivers
>> load and start using the BARs in question.
>>
> Yes, that would probably be better.

The problem is that this approach usually doesn't work with your primary 
video device.

Either the vga, vesa or efi driver are already using the BAR during 
boot. So you need to kick those out first or otherwise the resize just 
results in a crash.

That's the reason why we haven't gone down that route so far. But I 
think that improving the size estimation for 64bit BARs would still be a 
good idea anyway.

Regards,
Christian.
