Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C7D11E373
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 13:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfLMMRO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 07:17:14 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:24639 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfLMMRN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 07:17:13 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id B1372A42F7;
        Fri, 13 Dec 2019 13:17:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 1UVrYhGRk6XQ; Fri, 13 Dec 2019 13:17:06 +0100 (CET)
Subject: Re: PCIe hotplug resource issues with PEX switch (NVMe disks) on AMD
 Epyc system
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
References: <4fc407f8-2a24-4a04-20fb-5d07d5c24be4@denx.de>
 <PSXP216MB0438BE9DA58D0AF9F908070680540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <c9f154e5-4214-aa46-2ce2-443b508e1643@denx.de>
 <PSXP216MB0438AD1041F6BD7DB51363A380540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Stefan Roese <sr@denx.de>
Message-ID: <9aa45b1d-8afe-2d59-4bca-4d2beb983cfc@denx.de>
Date:   Fri, 13 Dec 2019 13:17:03 +0100
MIME-Version: 1.0
In-Reply-To: <PSXP216MB0438AD1041F6BD7DB51363A380540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13.12.19 12:52, Nicholas Johnson wrote:
> On Fri, Dec 13, 2019 at 11:58:53AM +0100, Stefan Roese wrote:
>> Hi Nicholas,
>>
>> On 13.12.19 10:00, Nicholas Johnson wrote:
>>> On Fri, Dec 13, 2019 at 09:35:19AM +0100, Stefan Roese wrote:
>>>> Hi!
>>> Hi,
>>>>
>>>> I am facing an issue with PCIe-Hotplug on an AMD Epyc based system.
>>>> Our system is equipped with an HBA for NVMe SSDs incl. PCIe switch
>>>> (Supermicro AOC-SLG3-4E2P) [1] and we would like to be able to hotplug
>>>> NVMe disks.
>>>>
>>>> Currently, I'm testing with v5.5.0-rc1 and series [2] applied. Here
>>>> a few tests and results that I did so far. All tests were done with
>>>> one Intel NVMe SSD connected to one of the 4 NVMe ports of the HBA
>>>> and the other 3 ports (currently) left unconnected:
>>>>
>>>> a) Kernel Parameter "pci=pcie_bus_safe"
>>>> The resources of the 3 unused PCIe slots of the PEX switch are not
>>>> assigned in this test.
>>>>
>>>> b) Kernel Parameter "pci=pcie_bus_safe,hpmemsize=0,hpiosize=0,hpmmiosize=1M,hpmmioprefsize=0"
>>>> With this test I restricted the resources of the HP slots to the
>>>> minimum. Still this results in unassigned resourced for the unused
>>>> PCIe slots of the PEX switch.
>>>>
>>>> c) Kernel Parameter "pci=realloc,pcie_bus_safe,hpmemsize=0,hpiosize=0,hpmmiosize=1M,hpmmioprefsize=0"
>>>> Again, not all resources are assigned.
>>>>
>>>> d) Kernel Parameter "pci=nocrs,realloc,pcie_bus_safe,hpmemsize=0,hpiosize=0,hpmmiosize=1M,hpmmioprefsize=0"
>>>> Now all requested resources are available for the HP PCIe slots of the
>>>> PEX switch. But the NVMe driver fails while probing. Debugging has
>>>> shown, that reading from the BAR of the NVMe disk returns 0xffffffff.
>>>> Also reading from the PLX PEX switch registers returns 0xfffffff in this
>>>> case (this works of course without nocrs, when the BARs are mapped at
>>>> a different address).
>>>>
>>>> Does anybody have a clue on why the access to the PEX switch and / or
>>>> the NVMe BAR does not work in the "nocrs" case? The BARs are located in
>>>> the same window that is provided by the BIOS in the ACPI list (but is
>>>> "ignored" in this case) [3].
>>>>
>>>> Or if it is possible to get the HP resource mapping done correctly without
>>>> setting "nocrs" for our setup with the PCIe/NVMe switch?
>>>>
>>>> I can provide all sorts of logs (dmegs, lspci etc) if needed - just let
>>>> me know.
>>>>
>>>> Many thanks in advance,
>>>> Stefan
>>> This will be a quick response for now. I will get more in depth tonight
>>> when I have more time.
>>>
>>> What I have taken away from this is:
>>>
>>> 1. Epyc -> Up to 4x PCIe Root Complexes, but from what I can gather,
>>> they are probably assigned on the same segment / domain, unfortunately,
>>> with non-overlapping bus numbers. Either way, multiple RCs may
>>> complicate using pci=nocrs and others. Unfortunately, I have not had the
>>> privilege of owning a system with multiple RCs, so I cannot be sure.
>>>
>>> 2. Not using Thunderbolt - [2] patch series only really makes a
>>> difference with nested hotplug bridges, such as in Thunderbolt.
>>> Although, it might help by not using additional resource lists, but I
>>> still do not think it will matter without nested hotplug bridges.
>>
>> I was not sure about those patches but since they have been queued for
>> 5.6, I included them in these tests. The results are similar (or even
>> identical, I would need to re-run the test to be sure) without them.
>>> 3. System not reallocating resources despite overridden -> is ACPI _DSM
>>> method evaluating to zero?
>>
>> Not sure if I follow you here. The kernel is reallocating the resources, or
>> at least trying to, if requested to via bootargs (Tests c) and d)). I've
>> attached the logs from all 4 tests in an archive [1]. It just fails to
>> reallocate the resources in test case c) and even though it successfully
>> reallocates the resources in test case d), the new addresses at the PEX
>> switch and its ports "don't work".
> It is unlikely to be the issue, but I thought it was worth a mention.
> 
>>
>>> I experienced this recently with an Intel Ice
>>> Lake system. I booted the laptop at the retail store into Linux off a
>>> USB to find out about the Thunderbolt implementation. I dumped "sudo
>>> lspci -xxxx" and dmesg and analysed the results at home.
>>
>> Very brave. ;)
> It's a retail store with display models for people to play with. If I do
> not damage it (or pay for any damage caused) then I do not have anything
> to be afraid of.

Sure. I was referring to you being "brave" to do all this analyzing /
debugging without having the system at your hands while doing this for any
further tests. ;)
  
>>
>>> I noticed it
>>> did not override the resources, and from examining the source code, it
>>> likely evaluated _DSM to 0, which may have overridden pci=realloc. Try
>>> modifying the source code to unconditionally apply realloc in
>>> drivers/pci/setup-bus.c and see what happens. I have not bothered doing
>>> this myself and going back to the store to try to test this hypothesis.
>>
>> realloc is enabled via boot args and active in the kernel as you can see
>> from the dmesg log [2].
>>> 4. It would be helpful if you attached full dmesg and "sudo lspci -xxxx"
>>> which dumps full PCI config, allowing us to run any lspci query as if we
>>> were on your system, from the file. I will be able to tell a lot more
>>> after seeing that. Possibly do one with no kernel parameters, and do
>>> another set of results with all of the kernel parameters. Use
>>> hpmmiosize=64M and hpmmioprefsize=1G for it to be noticeable, I reckon.
>>> But this will answer questions I have about which ports are hotplug
>>> bridges and other things.
>>
>> Okay, I added the following test cases:
>>
>> e) Kernel Parameter ""
>> f) Kernel Parameter "pci=nocrs,realloc,hpmmiosize=64M,hpmmioprefsize=1G"
>>
>> The logs are also included. Please let me know, if I should do any other
>> tests and provide the logs.
>>
>>> 5. There is a good chance it will not even boot since kernel since
>>> around ~v5.3 with acpi=off but it is worth a shot there, also. Since a
>>> recent kernel, I have found that acpi=off only removes HyperThreading,
>>> and not all the physical cores like it used to. So there must have been
>>> a patch which allowed it to guess the MADT table information. I have not
>>> investigated. But now, some of my computers crash upon loading the
>>> kernel with acpi=off. It must get it wrong at times.
>>
>> Booting this 5.5 kernel with "acpi=off" increases the bootup time quite
>> a bit. The resources are distributed behind the PLX switch (similar to
>> using "pci=nocrs" but again accessing the BARs doesn't work (0xffffffff
>> is read back).
> It was only to see if ACPI was part of the issue. You would not run in
> production with it off.
> 
>>
>>> What about
>>> pci=noacpi instead?
>>
>> I also tested using pci=noacpi and it did not resolve the resource
>> mapping problems.
>>> Sorry if I missed something you said.
>>>
>>> Best of luck, and I am interested into looking into this further. :)
>>
>> Very much appreciated. :)
>>
>> Thanks,
>> Stefan
>>
>> [1] logs.tar.bz2
>> [2] 5.5.0-rc1-custom-test-c/dmesg.log
> 
>  From the logs, it looks like MMIO_PREF was assigned 1G but not MMIO.
> 
> This looks tricky. Please revert my commit:
> c13704f5685deb7d6eb21e293233e0901ed77377
> 
> And see if it is the problem.

I reverted this patch and did a few test (some of my test cases). None
turned out differently than before. Either the resources are not mapped
completely or they are mapped  (with pci=nocrs) and not accessible.

> It is entirely possible, but because of
> the very old code and how there are multiple passes, it might be
> impossible to use realloc without side effects for somebody. If you fix
> it for one scenario, it is possible that there is another scenario for
> which it will break due to the change. The only way to make everything
> work is a near complete rewrite of drivers/pci/setup-bus.c and
> potentially others, something I am working on, but is going to take a
> long time. And unlikely to ever be accepted.

While working on this issue, I looked (again) at this resource (re-)
allocation code. This is really confusing (at least to me) and I also think
that it needs a "near complete rewrite".
  
> Otherwise, it will take me a lot of grepping through dmesg to find the
> cause, which will take more time.

Sure.
  
> FYI, "lspci -vvv" is redundant because it can be produced from "lspci
> -xxxx" output.

I know. Its mainly for me to easily see the PCI devices listed quickly.
  
> A final note, Epyc CPUs can bifurcate x16 slots into x4/x4/x4/x4 in the
> BIOS setup, although you will probably not have the hotplug services
> provided by the PEX switch.

I think it should not matter for my current test with resource assignment,
how many PCIe lanes the PEX switch has connected to the PCI root port. Its
of course important for the bandwidth, but this is a completely different
issue.

Thanks,
Stefan
