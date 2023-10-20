Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A70F7D0E10
	for <lists+linux-pci@lfdr.de>; Fri, 20 Oct 2023 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376932AbjJTLEK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Oct 2023 07:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376745AbjJTLEJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Oct 2023 07:04:09 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A1ECA;
        Fri, 20 Oct 2023 04:04:07 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qtnIU-0003KO-3g; Fri, 20 Oct 2023 13:04:06 +0200
Message-ID: <c9a99e29-1a16-4b46-8e3a-afd0aae5b76e@leemhuis.info>
Date:   Fri, 20 Oct 2023 13:04:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pci: loongson: Workaround MIPS firmware MRRS settings
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org, kw@linux.com,
        lpieralisi@kernel.org, stable@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
 <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com>
 <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
 <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com>
 <20230907011828.GA2865@thinkpad>
 <6e1bdebf-f335-23a5-c79f-d603c5d0150c@flygoat.com>
 <20230907050805.GA3218@thinkpad>
 <91336c97-0831-3ce3-5ff0-54344f18e065@leemhuis.info>
In-Reply-To: <91336c97-0831-3ce3-5ff0-54344f18e065@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697799847;c25b5c96;
X-HE-SMSGID: 1qtnIU-0003KO-3g
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Just wondering what's up here. The patch this thread is about afaics was
supposed to fix a regression reported in July
(https://bugzilla.kernel.org/show_bug.cgi?id=217680 ), but has made not
steps closer to get mainlined during the past few weeks. Is there a
reason, or did it maybe fell through the cracks?

Jiaxun Yang, from it quick look it seems like you wanted to post a v3,
but never did so; but I might be mistaken there.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 20.09.23 14:33, Linux regression tracking (Thorsten Leemhuis) wrote:
> [CCing the regression list, as it should be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
> 
> On 07.09.23 07:08, Manivannan Sadhasivam wrote:
>> On Thu, Sep 07, 2023 at 11:13:00AM +0800, Jiaxun Yang wrote:
>>> 在 2023/9/7 9:18, Manivannan Sadhasivam 写道:
>>> [...]
>>>> Why do you need to walk through every single device instead of just bridges?
>>>> I'm not the maintainer, but my suggestion is to go for Huacai Chen's solution.
>>>
>>> Thanks for your reply, unfortunately Huacai's solution is impractical in
>>> this case.
>>>
>>> The problem we have, is firmware (or BIOS) setting improper MRRS for devices
>>> attached under those bridges. So we have to fix up MRRS for every single
>>> device.
>>> We can't iterate child device in bridge quirk because there is no guarantee
>>> that
>>> bridge will be probed before  it's child device, partly due to hotplug.
>>
>> Okay, this clarifies and also warrants improvement in commit message.
>>
>> You could also use pci_walk_bus() after pci_host_probe() to iterate over the
>> child devices under root bridge and set MRRS. IMO that would look neat.
> 
> Hi, Thorsten here, the Linux kernel's regression tracker. What's the
> status here? The regression that was supposed to be fixed by the patched
> that started this thread was reported 9 weeks ago[1] and the culprit
> made it to many stable kernels as well. Would be really good to finally
> fix this, as a regression like this should ideally be fixed within 2 to
> 3 weeks (in both mainline and stable). With a revert if necessary -- is
> this maybe still a option, or would that cause more trouble then it
> solved (I guess that's the case).
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217680
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
>>> This quirk has been in tree for a while, until Huacai refactored it and
>>> broke some
>>> systems in 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases").
>>>
>>> Also to note that ks_pcie_quirk in drivers/pci/controller/dwc/pci-keystone.c
>>> uses similar approach.
>>>> This avoids iterating over bridges/devices two times.
>>>>
>>>> Also, please rename firmware to BIOS, as firmware commonly represents the
>>>> software running on PCIe endpoint devices.
>>> Ack, will fix in next reversion.
>>>
>>> Thanks
>>> - Jiaxun
>>>>
>>>> - Mani
>>> [...]
>>
