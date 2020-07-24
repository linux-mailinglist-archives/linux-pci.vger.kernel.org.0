Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81CE22CE96
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 21:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgGXTVI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 15:21:08 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60198 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGXTVH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2020 15:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3uSMvInD2Jk/6cMDVdGrLAgWn9ZHoqePo02Lz6hivfE=; b=P+weo+cY0o/lpm5Nzy0Xmn5+jK
        dix62OJ3ciCGa5qYQThWzrPst7nAnSt2UJBWzBb0n6JLallV8DS8wMhcPcvyEqTWmTCOfCssOS7GD
        uyh1Bdnu92ZzqaNHboHbwHAVTKv6nNvz3kRMt0bGpCxUIM4oKgcD16r3lVquIZjcDVMDmblq+8qLe
        aF5ywXjS3PsILAhPbfyVRPxB4hryFcP3JlD45yM7bZU1olKdE0lHfNaj4NGTnC38MWG/zwaNZNOhI
        YRjBYQ/8LRQNTL0cB1Gh+En1J1Rjkhy1y4iD99pT0KP1EcldanXJujY8LROUTcOP45Rrh/CZ9pr/X
        C+mC+d3w==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jz3Fc-0000ue-JE; Fri, 24 Jul 2020 13:21:02 -0600
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Andrew Maier <andrew.maier@eideticom.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20200723195742.GA1447143@bjorn-Precision-5520>
 <89d853d1-9e45-1ba5-5be7-4bbce79c7fb8@deltatee.com>
 <CADnq5_NMKK83GaNA+w85MR8bqDbFqvcdvn9MCqZtLwctJKmOUw@mail.gmail.com>
 <CADnq5_MCPTyxG31guPFL-uvs7HisGxwO5KpALnufc=Bj4MfYCw@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7ba8fff5-990a-a59c-53cf-b0c9e9b54a6e@deltatee.com>
Date:   Fri, 24 Jul 2020 13:20:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_MCPTyxG31guPFL-uvs7HisGxwO5KpALnufc=Bj4MfYCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: hpa@zytor.com, andrew.maier@eideticom.com, ray.huang@amd.com, christian.koenig@amd.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org, alexdeucher@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH] PCI/P2PDMA: Add AMD Zen 2 root complex to the list of
 allowed bridges
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-07-24 10:07 a.m., Alex Deucher wrote:
> On Thu, Jul 23, 2020 at 4:18 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Thu, Jul 23, 2020 at 4:11 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>>>
>>>
>>>
>>> On 2020-07-23 1:57 p.m., Bjorn Helgaas wrote:
>>>> [+cc Andrew, Armen, hpa]
>>>>
>>>> On Thu, Jul 23, 2020 at 02:01:17PM -0400, Alex Deucher wrote:
>>>>> On Thu, Jul 23, 2020 at 1:43 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>>>>>>
>>>>>> The AMD Zen 2 root complex (Starship/Matisse) was tested for P2PDMA
>>>>>> transactions between root ports and found to work. Therefore add it
>>>>>> to the list.
>>>>>>
>>>>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>>> Cc: Huang Rui <ray.huang@amd.com>
>>>>>> Cc: Alex Deucher <alexdeucher@gmail.com>
>>>>>
>>>>> Starting with Zen, all AMD platforms support P2P for reads and writes.
>>>>
>>>> What's the plan for getting out of the cycle of "update this list for
>>>> every new chip"?  Any new _DSMs planned, for instance?
>>>
>>> Well there was an effort to add capabilities in the PCI spec to describe
>>> this but, as far as I know, they never got anywhere, and hardware still
>>> doesn't self describe with this.
>>>
>>>> A continuous trickle of updates like this is not really appealing.  So
>>>> far we have:
>>>>
>>>>   7d5b10fcb81e ("PCI/P2PDMA: Add AMD Zen Raven and Renoir Root Ports to whitelist")
>>>>   7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to the whitelist")
>>>>   bc123a515cb7 ("PCI/P2PDMA: Add Intel SkyLake-E to the whitelist")
>>>>   494d63b0d5d0 ("PCI/P2PDMA: Whitelist some Intel host bridges")
>>>>   0f97da831026 ("PCI/P2PDMA: Allow P2P DMA between any devices under AMD ZEN Root Complex")
>>>>
>>>> And that's just from the last year, not including this patch.
>>>
>>> Yes, it's not ideal. But most of these are adding old devices as people
>>> test and care about running on those platforms -- a lot of this is
>>> bootstrapping the list. I'd expect this to slow down a bit as by now we
>>> have hopefully got a lot of the existing platforms people care about.
>>> But we'd still probably expect to be adding a new Intel and AMD devices
>>> about once a year as they produce new hardware designs.
>>>
>>> Unless, the Intel and AMD folks know of a way to detect this, or even to
>>> query if a root complex is newer than a certain generation, I'm not sure
>>> what else we can do here.
>>
>> I started a thread internally to see if I can find a way.  FWIW,
>> pre-ZEN parts also support p2p DMA, but only for writes.  If I can get
>> a definitive list, maybe we could switch to a blacklist for the old
>> ones?
> 
> After talking with a few people internally, for AMD chips, it would
> probably be easiest to just whitelist based on the CPU family id for
> zen and newer (e.g., >= 0x17).

That seems sensible. I was trying to see if we could do something
similar for Intel, and just allow anything after Skylake. I found
this[1]. It seems they have been on family 6 for a long time, and I'm
not comfortable enabling the whole family. Their model numbers also
don't seem to increment in a favorable fashion, in that "small core"
atoms (which have different host bridges with very much unknown support)
have model numbers interspersed with regular "big core" CPUS.

So we might be stuck with the Intel white list for a while, but using
the AMD family number will at least cut the number of additions down a
fair amount. I can try to put a patch together in place of this one.

Logan

[1]
https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/intel-family.h#L73
