Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9BA1B8F6F
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 13:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgDZL1m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 07:27:42 -0400
Received: from mail-bn8nam12on2087.outbound.protection.outlook.com ([40.107.237.87]:6054
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726118AbgDZL1m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Apr 2020 07:27:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZh7viI3Rbcu0Avsmilb2Hj/prqE/PznxKHwqqE3/RWDp3qBLfcvBkTl9oUYP94ihK1hHJh9vrmsTU8I2IVeQOaVHzlrX73W6oatas13JSz1Xfyz2tQexcwoRtvmpSnKanXz6PI/s0+usWeM+j+zfmMTs6aNH5++9twElZvNVsuetImr4zB1JaHsPd2tc8xlDkKQR8voJBrQFZas8ypo3hkw5yz6bHcT4UM0Blj/tUDGEumiyDVJWqQmnM7/Xxzo3uAbBGBvfKlKUTweMljUUOYScJb/Shj/dnPdvJyetFddGUolAVJTRXlTaOSe1YNMY+ktRcvAwB0W7+uwVyI2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBb7t1XhD8MDVlpoexAOQ+dFIoRXtqpTKCfjYGz/tWA=;
 b=eHCKY518+oUbiJmPlfi2TpxsW6ELdIx/EDLOyB4sv2YeP1/q2aGrWbzt/0O80R2QQuAuDWPFwjSAxCluWstnFix8Fb5fZR4M6DEXVPvwsIzP7UFtvbpOes2C5ZhMXbsXZRmb14cZeisKiGmRrowGCQ91rP+WY4KUIJrDgLdObGrLw5oe/YgbynydqV6CBABMzWBomFSYk7jDZ4U9dmx3YCnCt33jOzlkYr2P7ddc8JQvoX/DDkhJf16zKIMeYtzJxVW42vXbuQbWBrRI5swFI4sDlrUS4Ffdgwk3juYIu8JqEFQfTTOiO8c2JoeM2zdsLp8KzFxeZXaU9cWugAYtgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBb7t1XhD8MDVlpoexAOQ+dFIoRXtqpTKCfjYGz/tWA=;
 b=deZLFTdyroTDFFdtj9gs3tz/Lt9+YCLOD4GGqMAySY2AGCu8zmdSS1rwUSg82KnWPLkv4WnxiOIFlK1TNROlbFlwyHloN6bS5Qu2d2Lv9yLYrdA9hMUwkw0LDtaug3DTUdce0s7ph5Vvrtdk28wNP6vuUgUU36ZXPJiL4gH3JjY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3193.namprd12.prod.outlook.com (2603:10b6:5:186::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 11:27:37 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 11:27:37 +0000
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <59f26d64-70a0-687d-45d8-2ae1b63a7c11@amd.com>
Date:   Sun, 26 Apr 2020 13:27:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CAMj1kXEtcyOcLJ4WdcoLaV9tvLH2mvPBYjhi60po4XWk9sqw4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0108.eurprd05.prod.outlook.com
 (2603:10a6:207:1::34) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM3PR05CA0108.eurprd05.prod.outlook.com (2603:10a6:207:1::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 11:27:36 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e2f5782-4155-4a15-1b72-08d7e9d4d2c3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3193:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3193AFD148328DF6403B05C383AE0@DM6PR12MB3193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(66574012)(4326008)(6916009)(66556008)(16526019)(6486002)(186003)(31686004)(66476007)(66946007)(2616005)(2906002)(8936002)(6666004)(316002)(36756003)(86362001)(81156014)(8676002)(478600001)(31696002)(52116002)(5660300002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V85AUIyRUQOjcQCBK58QKt5ac7aoj8WEYqCbqGp4qmFw9XT4UlBxDGh8YiLME5La9pMerOfQnayiazhlfq+jU2JHClkM0FEYuHNJG7gBUQB62+zHe5dZyMQURX0nqluezVh/+/02xq6A8DXSrEkUmjfN3nEiKOFGLjR+QTVeUIAxadcow9eFEAmEtnvTeVfrwdJ5hJslu7NIOz0TcbtH+sTXwhLRcE1r62b2sH+TKtV8nTAujkwG/8F4ZOm8MEXJNrF/zVtuNVWsgCSWyAayGph3sdz6t1xd0iC27huL9OH9GhhVhfxL1rZTHxpvjNbFcT6rGZoTl6NIGXHkWvJqPoj+yg0Lhf5O5WIU8ys6XaaksuDDk8+lwXRqrvH9JGaOSvJrrUQgxWs+qJBI1x3pfEI+qI5+nB+txbg3ehECz7uKMopLQIz1HcbbkTo8GL0z
X-MS-Exchange-AntiSpam-MessageData: dOLLlsAWV+n9tADyEzs8lYeOTxEmLOQcvApe66k+NceSBO3B8N+0NlflrIxt3H7nNvUcDXdcXUDJn3bC1RZUVIX8Xwhgt+e7r0jtxkI0hfhmuwIwz5IzaEU8O2WiolFCPuDiB9vJ61VMY+tKra16bQnnxTYFQ3/xF4dWiw0oc8kXdbVqrhHokK7llBYeZWeZDgthwX3ZpWjDBmXctILGx/9ht4+uvj3ES8x6oJ0UDTINnI4y3iEtRG8AA392X120Y4wYTAKPy+qoesxd1aFJN98lNqdvFKaT2sGCDH2LJPSmp6ahpavj2QqGUO9Ce/aXtptHWa4J4gH+9VkVhkXsqCWKJyo1QrjenCbnCXkAwSOS27QxLOuvouyTOCYl3XPSYxX07ku83uazmMYOQi8minSs5ru7jdMsozNUm2/t4dxESTDCzMp2eekThXmpWiVXN7vqi62ojyY4qPg7/x/gzZJ+2AI/cg5xH+hIa/VCWwLVt87Jieco1W4oAgXZeBEWVoaMBrbki3DvC4ONbJjLd0txCPjBNIeLbtVucU0x5iH1Tv3KG9SvMh2Tb+FBf5jxOaum7i0OJNNz1LpAs7cFoxx5dgMHMYQD30yT/kGKmEU6dKmkz+S+tTFf25HSgTjhhHKdUOTW3oeodyKXIazzaPhSg7YaIdi6x7084cx2UPcb6xOdGPW4oqs70mXbXWHIi1yC3RyiOPDUMNU2MDyICZJK6k1v+c5TUypooYTEl0U20kwP1yIw+ZjrNnqha29EV9+kE/4LduMXE6lSIRGO3VgpJ7CSC/8jWZcwGimGMuRPG8rnz+a2U81Lw0a13HbY9dluf33EqIZKvHYpqUoFwSw+lPJhPGm+4/Frvld29zo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2f5782-4155-4a15-1b72-08d7e9d4d2c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 11:27:37.6755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPuAxnAcSnP2HNMMNbsh88A+uB2SfSbh3qWUiIjUC9rbyH6AxthWGFEnbTsNiEp8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3193
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 26.04.20 um 12:59 schrieb Ard Biesheuvel:
> On Sun, 26 Apr 2020 at 12:53, Christian König <christian.koenig@amd.com> wrote:
>> Am 26.04.20 um 12:46 schrieb Ard Biesheuvel:
>>> On Sun, 26 Apr 2020 at 11:58, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>> On Sun, 26 Apr 2020 at 11:08, Christian König <christian.koenig@amd.com> wrote:
>>>>> Am 25.04.20 um 19:32 schrieb Ard Biesheuvel:
>>>>>> On Tue, 21 Apr 2020 at 19:07, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>>>> On Tue, 21 Apr 2020 at 18:43, Christian König <christian.koenig@amd.com> wrote:
>>>>>>>> Am 21.04.20 um 18:22 schrieb Ard Biesheuvel:
>>>>>>>>> When resizing a BAR, pci_reassign_bridge_resources() is invoked to
>>>>>>>>> bring the bridge windows of parent bridges in line with the new BAR
>>>>>>>>> assignment.
>>>>>>>>>
>>>>>>>>> This assumes that the device whose BAR is being resized lives on a
>>>>>>>>> subordinate bus, but this is not necessarily the case. A device may
>>>>>>>>> live on the root bus, in which case dev->bus->self is NULL, and
>>>>>>>>> passing a NULL pci_dev pointer to pci_reassign_bridge_resources()
>>>>>>>>> will cause it to crash.
>>>>>>>>>
>>>>>>>>> So let's make the call to pci_reassign_bridge_resources() conditional
>>>>>>>>> on whether dev->bus->self is non-NULL in the first place.
>>>>>>>>>
>>>>>>>>> Fixes: 8bb705e3e79d84e7 ("PCI: Add pci_resize_resource() for resizing BARs")
>>>>>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>>>>>> Sounds like it makes sense, patch is
>>>>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>.
>>>>>>> Thanks Christian.
>>>>>>>
>>>>>>>> May I ask where you found that condition?
>>>>>>>>
>>>>>>> In this particular case, it was on an ARM board with funky PCIe IP
>>>>>>> that does not expose a root port in its bus hierarchy.
>>>>>>>
>>>>>>> But in the general case, PCIe endpoints can be integrated into the
>>>>>>> root complex, in which case they appear on the root bus, and there is
>>>>>>> no reason such endpoints shouldn't be allowed to have resizable BARs.
>>>>>> Actually, looking at this more carefully, I think
>>>>>> pci_reassign_bridge_resources() needs to do /something/ to ensure that
>>>>>> the resources are reshuffled if needed when the resized BAR overlaps
>>>>>> with another one.
>>>>> The resized BAR never overlaps with an existing one since to resize a
>>>>> BAR it needs to be deallocated and disabled. This is done as a
>>>>> precaution to avoid potential incorrect routing and decode of memory access.
>>>>>
>>>>> The call to pci_reassign_bridge_resources() is only there to change the
>>>>> resources of the upstream bridge to the device which is resized and not
>>>>> to adjust the resources of the device itself.
>>>>>
>>>> So does that mean that BAR resizing is only possible if no other BARs,
>>>> either on the same device or on other ones, need to be moved?
>>> OK, so obviously, the current code already releases and reassigns
>>> resources on the same device.
>>>
>>> What I am not getting is how this works with more complex topologies, e.g.,
>>>
>>> RP 1
>>> multi function device (e.g., GPU + HDMI)
>>> GPU BAR 0 256M
>>> GPU BAR 1 16 M
>>> HDMI BAR 0 16 KB
>>>
>>> RP 2
>>> some other endpoint using MMIO64 BARs
>>>
>>> So in this case, RP1 will get a prefetchable bridge BAR window of 512
>>> M, and RP2 may get one that is directly adjacent to that. When
>>> resizing GPU BAR 0 to 4 GB, the whole hierarchy needs to be
>>> reshuffled, right?
>> Correct, yes. Because you not only need to configure the BARs of the
>> device(s), but also the bridges in between to get the routing right.
>>
> Right. But my point is really the RP2 is not a bridge in between.
>
>> Just wrote another mail with an example how this works on amdgpu. What
>> aids us in amdgpu is that the devices only has two 64bit BARs, the
>> FB/VRAM which we want to resize and the doorbell.
>>
>> I can easily disable access to the doorbell BAR temporary in amdgpu,
>> otherwise the whole resize wouldn't work at all.
>>
> OK, so the example is clear, and I understand how you have to walk the
> path up to the root bus to reconfigure the bridge BARs on each
> upstream bridge.
>
> But at each level, the BAR space that is being reassigned may be in
> use by another device already, no? RP2 in my example is a sibling of
> RP1, so the walk up to the root will not traverse it. If RP2's  bridge
> BARs conflict with the resized BAR below RP1, will the resize simply
> fail?

Yes exactly that. When BARs on upstream bridges can't be extended 
because some other downstream BAR can't move around we just abort the 
resize.

Regards,
Christian.
