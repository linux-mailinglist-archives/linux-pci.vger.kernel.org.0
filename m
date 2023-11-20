Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0B47F0B9B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 06:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjKTFlv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 00:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjKTFlu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 00:41:50 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F738E3;
        Sun, 19 Nov 2023 21:41:46 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r4x2U-00032f-FD; Mon, 20 Nov 2023 06:41:42 +0100
Message-ID: <973830d2-e9db-4ffb-8862-ca08427e6ed9@leemhuis.info>
Date:   Mon, 20 Nov 2023 06:41:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from dcadfd7f7c74ef9ee415e072a19bdf6c085159eb
Content-Language: en-US, de-DE
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        a.mark.broadworth@gmail.com, matthias.schrumpf@freenet.de,
        LKML <linux-kernel@vger.kernel.org>, aros@gmx.com,
        bagasdotme@gmail.com,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <f878b188-3fe4-420c-9bcb-b431ac6088dd@amd.com>
 <20231107121756.GA168964@workstation.local>
 <318cc8da-f8d2-4307-866e-8c302dacf094@amd.com>
 <20231108051638.GA194133@workstation.local>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20231108051638.GA194133@workstation.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700458906;6182bc9b;
X-HE-SMSGID: 1r4x2U-00032f-FD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08.11.23 06:16, Takashi Sakamoto wrote:
> On Tue, Nov 07, 2023 at 03:27:08PM -0600, Mario Limonciello wrote:
>> +linux-pci / Bjorn
>> On 11/7/2023 06:17, Takashi Sakamoto wrote:
>>>
>>> Thanks for the report.
>>>
>>> I apologize for the inconvenience you and your reporter facing, however
>>> I can not avoid to say that the problem appears to be specific to the AMD
>>> Ryzen machines.

It nevertheless from the point of kernel development *afaics* is a
kernel regression, as it doesn't matter much if the root of the problem
is a hw problem; what matters primarily is that the problem apparently
did not happen before the commit mentioned in the subject.

Which bears the question: Can the culprit (and others commits that might
be depending on it) still be reverted without causing regression itself?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

>> Unfortunately I don't have this 1394 hardware myself.  I was just looking at
>> another completely unrelated issue on Bugzilla and noticed the report come
>> up in my search and wanted to ensure it's on your radar already as the
>> author as it's lingered a while.
> 
> It is your misfortune to face this kind of machine trouble.
> 
> In the report[1], Matthias Schrumpf and Mark Broadworth noted to use AMD
> Ryzen 7 5800X on B550/X570 chipsets, and insert VT6307 in their PCIe bus.
> I guess that the device attends PCI bridge (ASM1083) since VT6307 has PCI
> interface only.
> 
> We can see MCE error in another report[2]. Unfortunately, the reporter,
> Ian Donnelly, have less suspiction about machine architecture, and never
> provides hardware information. But I believe that it comes from AMD Ryzen
> machine. I transcribe the error here:
> 
> ```
> [    0.860834] mce: [Hardware Error]: Machine check events logged
> [    0.860834] microcode: CPU20: patch_level=0x0a201025
> [    0.860835] microcode: CPU21: patch_level=0x0a201025
> [    0.860836] microcode: CPU23: patch_level=0x0a201025
> [    0.860836] microcode: CPU22: patch_level=0x0a201025
> [    0.860837] mce: [Hardware Error]: CPU 17: Machine Check: 0 Bank 0: bc00080001010135
> [    0.860845] fbcon: Taking over console
> [    0.860847] mce: [Hardware Error]: TSC 0 ADDR fca000f0 MISC d012000000000000 IPID 1000b000000000 
> [    0.860854] mce: [Hardware Error]: PROCESSOR 2:a20f10 TIME 1696955537 SOCKET 0 APIC b microcode a201025
> [    0.860860] microcode: CPU0: patch_level=0x0a201025
> [    0.861676] microcode: Microcode Update Driver: v2.2.
> ```
> 
> Additionally, as I note in the PR[3], I observed cache-coherence failure
> over memory dedicated for DMA transmission. The mapping is created by
> `dmam_alloc_coherent()` and no need to have extra care such as streaming
> API. However, the combination of ASM1083 and VT6307 provides me bogus
> values from the memory in AMD Ryzen machine, and I can see no issue in
> Intel machines.
> 
> Essentially, the host system reboots when firewire-ohci module in guest
> system probes the PCI device for 1394 OHCI hardware provided by PCI
> pass-though[4].
> 
>>> I've already received the similar report[1], and have been
>>> investigating it in the last few weeks, then got the insight. Please take
>>> a look at my short report about it in PR to Linus for 6.7-rc1:
>>> https://lore.kernel.org/lkml/20231105144852.GA165906@workstation.local/
>>>
>>> I can confirm that I have been abe to reproduce the problem on AMD Ryzen
>>> machine. However, it's important to note that I have not observed the
>>> problem on the following systems:
>>
>> Any chance you (or anyone with the issue) has a serial output available?
>> I think it would be really good to look at the circumstances surrounding the
>> reboot.
>>
>>>
>>> * Intel machine (Sandy Bridge and Skylake generations)
>>> * AMD machines predating Ryzen (Sempron 145)
>>> * Machines using different 1394 OHCI hardware from other vendors such as
>>>    TI
>>> * VIA VT6307 connected directly to PCI slot (i.e. without the issued
>>>    PCIe/PCI bridge)
>>>
>>> Currently, I have not been able to obtain any useful debug output from
>>> the Linux system or any hardware error reports when the system reboots.
>>> It seems that the system reboots spontaneously. My assumption at this
>>> point is that AMD Ryzen machines detect a specific hardware error
>>> triggered by Ryzen machine quirk related to the combination of the Asmedia
>>> ASM1083/1085 and VIA VT6306/6307/6308, leading to power reset.
>>>
>>
>> Recent kernels have enabled PCI AER.  Could that be factoring in perhaps?
> 
> I ordered equipments for the workflow, and waiting for shipping, since
> my motherboard has no interface for serial output.
> 
> (However, I predict that we can no helpful output via the interface.)
> 
>>> I genuinely appreciate your assistance in debugging this elusive
>>> hardware issue. If any workaround specific to AMD Ryzen machine quirk is
>>> required in PCI driver for 1394 OHCI hardware, I'm willing to apply it.
>>> However, it is preferable to figure out the reboot mechanism at first,
>>> I think.
>>
>> Does the BIOS on these machines enable a watchdog timer?  If so, I'd suggest
>> disabling that for a starting point.
>  
> For consumer use, the machine has no such function, I think. For
> your information, this is the machine information I used:
> 
> * Ryzen 5 2400G
> * Gigabyte Technology Co., Ltd. AX370-Gaming 5/AX370-Gaming 5
>     * BIOS F51h 02/09/2023
> 
>> How about if you compile as a module and then modprobe.blacklist the module
>> on kernel command line and load it later.  Can you trigger the fault/reboot
>> this way?  If so, it at least rules out some conditions that happen during a
>> race at boot.
> 
> Nowadays FireWire software stack is optional in the most of
> distributions. I can encounter the same issue at deferred probing enough
> after booting up, even if the load of system is very low.
> 
>> Looking more closely at the change, I would guess the fault is specifically
>> in get_cycle_time().  I can see that the VIA devices do set
>> QUIRK_CYCLE_TIMER which will cause additional reads.
> 
> I've already tested with the driver compiled without these codes, but the
> system reboots again.
> 
>> Another guesses worth looking at is to see if iommu=pt or amd_iommu=off
>> help.
>>
>> If either of those help it could point at being a problem with
>> get_cycle_time() and IOMMU.  The older systems you mentioned working
>> probably didn't enable IOMMU by default but most AMD Ryzen systems do.
> 
> I already suspect platform IOMMU and kernel implementation, however it
> is helpless to disable AMD SVM and IOMMU in BIOS settings. Of course, it
> is helpless as well to provide any options to iommu in kernel command line.
> 
> If I had any opportunity to access to AMD machines for enterprise-grade
> usage somehow, I would have done it. However, I am a private-time
> contributor and what I can access to is the ones for consumer use
> without any hardware support for RAS reporting.
> 
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217993
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=217994
> [3] https://lore.kernel.org/lkml/20231105144852.GA165906@workstation.local/
> [4] https://lore.kernel.org/lkml/20231016155657.GA7904@workstation.local/
> 
> Thanks
> 
> Takashi Sakamoto
> 
> 
