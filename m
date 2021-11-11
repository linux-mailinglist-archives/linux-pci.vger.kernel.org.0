Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B0344D632
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 12:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhKKL5f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 06:57:35 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:29647 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhKKL5d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 06:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636631681;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=H66Rz4/hkCpg9docinRjSUMoGbcVBQdLFU0PgKDGanw=;
    b=Wbr82gBp9eVAo8wiZJlwiJ+KslcursRLh+wK+kGgXnZxO98xNhY1pnAh52D5Kjo2fz
    8AFwwRcSU5xyCn0cHmmQm4knFrA22xGPkeJCiHY8Gq/WhKQqX94HtaXAFgwrKdaWtIQz
    eQmZlAot6ksqFOax4zExLqhF03MFfHUbhHrWdQvH4GYT37JkYPpTRNjNnQ9disIvdbAt
    KDPS3bIokVt/MSlJOTY2VyRm8R+yinT6h5Il7BC2LiAciuhsheku5jPhLk/kVKiZxKWR
    TKqyZXZP7e7wTtxqQJfX3IjZw5cd2T3hM7MXgEgc3AcCuSBfhocvY6Rv7a2msF/GP7f4
    5SOA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhQJ/j+Igj1vHVSyIIKKx+xMp8bog=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a02:8109:89c0:ebfc:315a:1371:b0b5:d7a5]
    by smtp.strato.de (RZmta 47.34.5 AUTH)
    with ESMTPSA id N03801xABBsdIcO
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 11 Nov 2021 12:54:39 +0100 (CET)
Message-ID: <656fc68c-0bfb-0e5c-a014-32ea4b5b27c4@xenosoft.de>
Date:   Thu, 11 Nov 2021 12:54:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PASEMI] Nemo board doesn't recognize any ATA disks with the
 pci-v5.16 updates
Content-Language: de-DE
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "bhelgaas@google.com >> Bjorn Helgaas" <bhelgaas@google.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        lorenzo.pieralisi@arm.com, Rob Herring <robh@kernel.org>,
        Matthew Leaman <matthew@a-eon.biz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Christian Zigotzky <info@xenosoft.de>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, kw@linux.com,
        Arnd Bergmann <arnd@arndb.de>, robert@swiecki.net,
        Olof Johansson <olof@lixom.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de>
 <20211110184106.GA1251058@bhelgaas> <87sfw3969l.wl-maz@kernel.org>
 <8cc64c3b-b0c0-fb41-9836-2e5e6a4459d1@xenosoft.de>
 <87r1bn88rt.wl-maz@kernel.org>
 <f40294c6-a088-af53-eeea-4dfbd255c5c9@xenosoft.de>
 <87pmr7803l.wl-maz@kernel.org>
 <c93c7f72-6e46-797b-bee3-c9ae3b444f60@xenosoft.de>
 <87o86r7x63.wl-maz@kernel.org>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <87o86r7x63.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11 November 2021 at 12:24 pm, Marc Zyngier wrote:
> On Thu, 11 Nov 2021 10:44:30 +0000,
> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>> On 11 November 2021 at 11:20 am, Marc Zyngier wrote:
>>> On Thu, 11 Nov 2021 07:47:08 +0000,
>>> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>>>> On 11 November 2021 at 08:13 am, Marc Zyngier wrote:
>>>>> On Thu, 11 Nov 2021 05:24:52 +0000,
>>>>> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>>>>>> Hello Marc,
>>>>>>
>>>>>> Here you are:
>>>>>> https://forum.hyperion-entertainment.com/viewtopic.php?p=54406#p54406
>>>>> This is not what I asked. I need the actual source file, or at the
>>>>> very least the compiled object (the /sys/firmware/fdt file, for
>>>>> example). Not an interpretation that I can't feed to the kernel.
>>>>>
>>>>> Without this, I can't debug your problem.
>>>>>
>>>>>> We are very happy to have the patch for reverting the bad commit
>>>>>> because we want to test the new PASEMI i2c driver with support for the
>>>>>> Apple M1 [1] on our Nemo boards.
>>>>> You can revert the patch on your own. At this stage, we're not blindly
>>>>> reverting things in the tree, but instead trying to understand what
>>>>> is happening on your particular system.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> 	M.
>>>>>
>>>> I added a download link for the fdt file to the post [1]. Please read
>>>> also Darren's comments in this post.
>>> Am I right in understanding that the upstream kernel does not support
>>> the machine out of the box, and that you actually have to apply out of
>>> tree patches to make it work?
>> No, you aren't right. The upstream kernel supports the Nemo board out
>> of the box. [1]
> That's not the way I interpret Darren's comments, but you surely know
> better than I do.
>
> I'll try to come up with something for you to test shortly.
>
> 	M.
>
Great! Thanks a lot for your help!

- Christian
