Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AA866B22D
	for <lists+linux-pci@lfdr.de>; Sun, 15 Jan 2023 16:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjAOPle (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Jan 2023 10:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjAOPld (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Jan 2023 10:41:33 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBD859D6
        for <linux-pci@vger.kernel.org>; Sun, 15 Jan 2023 07:41:32 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pH58U-0002At-Kx; Sun, 15 Jan 2023 16:41:30 +0100
Message-ID: <2f866122-6a56-dfc7-9add-5168a4e796b2@leemhuis.info>
Date:   Sun, 15 Jan 2023 16:41:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Missing sriov_numvfs after removal of EfiMemoryMappedIO from E820
 map
Content-Language: en-US, de-DE
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Peifeng Qiu <linux@qiupf.dev>, bhelgaas@google.com,
        linux-pci@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <CAPH51bc1ZoP2ukJJh8nfrNY1FCp1nk7AP0jGGCvoskq2XbmAoA@mail.gmail.com>
 <029045a9-5006-e663-571f-b67344fa3a50@leemhuis.info>
In-Reply-To: <029045a9-5006-e663-571f-b67344fa3a50@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673797292;e68e2367;
X-HE-SMSGID: 1pH58U-0002At-Kx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Forget to mention one small detail:

On 15.01.23 15:21, Linux kernel regression tracking (Thorsten Leemhuis)
wrote:
> [CCing the regression list, as it should be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
> 
> Hi, this is your Linux kernel regression tracker.
> 
> On 15.01.23 10:21, Peifeng Qiu wrote:
>>
>> I'm using a dual Xeon system with Intel e810 25G network card and make use
>> of SRIOV feature heavily. I have a script to setup the NIC the first step is
>> echo $VFS > /sys/class/net/$DEVNAME/device/sriov_numvfs
>>
>> After switching from v6.1 to v6.2-rc1 "sriov_numvfs" is no longer present. If I
>> switch back to v6.1 it's back. Command line parameters are the same so it's
>> most likely kernel changes. I did git bisect and found the culprit to be
>> 07eab0901ed(efi/x86: Remove EfiMemoryMappedIO from E820 map)
> 
> This is not my area of expertise, but there is another report about an
> issue that was bisected to that particular commit:
> 
> https://lore.kernel.org/lkml/ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com/
> 
> A fix for that one was posted here:
> 
> https://lore.kernel.org/lkml/20230110180243.1590045-1-helgaas@kernel.org/
> 
> You might want to look into the report and if it looks like a possible
> duplicate give the proposed fix a try.

FWIW, that patch was recently mainlined and thus will be in 6.2-rc4 that
Linus will likely release in a few hours.

Ciao, Thorsten

> But as I said, this is not my area of expertise, you hence might want to
> wait for the expert to share their view of things.
> 
> Anyway, to be sure the issue doesn't fall through the cracks unnoticed,
> I'm adding it to regzbot, the Linux kernel regression tracking bot:
> 
> #regzbot ^introduced 07eab0901ed
> #regzbot title pci: sriov_numvfs missing after removal of
> EfiMemoryMappedIO from E820 map (possible duplicate)
> #regzbot ignore-activity
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
>> I tested v6.2-rc3 and it's the same. I reverted this commit on top of v6.2-rc3
>> then sriov_numvfs is back again. Comparing the dmesg output, I found that
>> with commit 07eab0901ed these lines are present:
>> [    0.000000] efi: Remove mem94: MMIO range=[0x80000000-0x8fffffff]
>> (256MB) from e820 map
>> [    0.000000] e820: remove [mem 0x80000000-0x8fffffff] reserved
>> [    0.000000] efi: Remove mem95: MMIO range=[0xfd000000-0xfe7fffff]
>> (24MB) from e820 map
>> [    0.000000] e820: remove [mem 0xfd000000-0xfe7fffff] reserved
>> [    0.000000] efi: Not removing mem96: MMIO
>> range=[0xfed20000-0xfed44fff] (148KB) from e820 map
>> [    0.000000] efi: Remove mem97: MMIO range=[0xff000000-0xffffffff]
>> (16MB) from e820 map
>> [    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
>> [    0.000000] efi: Remove mem99: MMIO
>> range=[0x1ffc00000000-0x1fffffffffff] (16384MB) from e820 map
>> [    0.000000] e820: remove [mem 0x1ffc00000000-0x1fffffffffff] reserved
>>
>> I think that's what the commit actually does. But the following are missing:
>> [    2.516119] pci 0000:ca:00.0: reg 0x184: [mem
>> 0x208ffd000000-0x208ffd01ffff 64bit pref]
>> [    2.516121] pci 0000:ca:00.0: VF(n) BAR0 space: [mem
>> 0x208ffd000000-0x208ffdffffff 64bit pref] (contains BAR0 for 128 VFs)
>> [    2.516134] pci 0000:ca:00.0: reg 0x190: [mem
>> 0x208ffe220000-0x208ffe223fff 64bit pref]
>> [    2.516136] pci 0000:ca:00.0: VF(n) BAR3 space: [mem
>> 0x208ffe220000-0x208ffe41ffff 64bit pref] (contains BAR3 for 128 VFs)
>>
>> Not sure whether this is a driver issue specific to Intel e810(module ice) or
>> a more general one. Any thoughts on this issue?
>>
>> Best regards,
>> Peifeng Qiu
