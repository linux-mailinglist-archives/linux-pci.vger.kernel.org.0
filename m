Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5344A813A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 10:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbiBCJNW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 04:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiBCJNW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 04:13:22 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE1EC061714
        for <linux-pci@vger.kernel.org>; Thu,  3 Feb 2022 01:13:21 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nFYB2-0004dv-4h; Thu, 03 Feb 2022 10:13:17 +0100
Message-ID: <0ce2529b-f27c-08b9-fd0c-0a0e3a5cd354@leemhuis.info>
Date:   Thu, 3 Feb 2022 10:13:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Bug 215525] New: HotPlug does not work on upstream kernel
 5.17.0-rc1
Content-Language: en-BS
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Blazej Kucman <blazej.kucman@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        linux-pci@vger.kernel.org, Blazej Kucman <blazej.kucman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
References: <20220202164308.GA17822@bhelgaas>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220202164308.GA17822@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1643879601;c6521928;
X-HE-SMSGID: 1nFYB2-0004dv-4h
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi, this is your Linux kernel regression tracker speaking.

On 02.02.22 17:43, Bjorn Helgaas wrote:
> On Wed, Feb 02, 2022 at 04:48:01PM +0100, Blazej Kucman wrote:
>> On Fri, 28 Jan 2022 08:03:28 -0600
>> Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Fri, Jan 28, 2022 at 09:49:34PM +0800, Kai-Heng Feng wrote:
>>>> On Fri, Jan 28, 2022 at 9:08 PM Bjorn Helgaas <helgaas@kernel.org>
>>>> wrote:  
>>>>> On Fri, Jan 28, 2022 at 09:29:31AM +0100, Mariusz Tkaczyk wrote:  
>>>>>> On Thu, 27 Jan 2022 20:52:12 -0600
>>>>>> Bjorn Helgaas <helgaas@kernel.org> wrote:  
>>>>>>> On Thu, Jan 27, 2022 at 03:46:15PM +0100, Mariusz Tkaczyk
>>>>>>> wrote:  
>>>>>>>> ...
>>>>>>>> Thanks for your suggestions. Blazej did some tests and
>>>>>>>> results were inconclusive. He tested it on two same
>>>>>>>> platforms. On the first one it didn't work, even if he
>>>>>>>> reverted all suggested patches. On the second one hotplugs
>>>>>>>> always worked.
>>>>>>>>
>>>>>>>> He noticed that on first platform where issue has been found
>>>>>>>> initally, there was boot parameter "pci=nommconf". After
>>>>>>>> adding this parameter on the second platform, hotplugs
>>>>>>>> stopped working too.
>>>>>>>>
>>>>>>>> Tested on tag pci-v5.17-changes. He have
>>>>>>>> CONFIG_HOTPLUG_PCI_PCIE and CONFIG_DYNAMIC_DEBUG enabled in
>>>>>>>> config. He also attached two dmesg logs to bugzilla with
>>>>>>>> boot parameter 'dyndbg="file pciehp* +p" as requested. One
>>>>>>>> with "pci=nommconf" and one without.
>>>>>>>>
>>>>>>>> Issue seems to related to "pci=nommconf" and it is probably
>>>>>>>> caused by change outside pciehp.  
>>>>>>>
>>>>>>> Maybe I'm missing something.  If I understand correctly, the
>>>>>>> problem has nothing to do with the kernel version (correct me
>>>>>>> if I'm wrong!)  
>>>>>>
>>>>>> The problem occurred after the merge commit. It is some kind of
>>>>>> regression.  
>>>>>
>>>>> The bug report doesn't yet contain the evidence showing this.  It
>>>>> only contains dmesg logs with "pci=nommconf" where pciehp doesn't
>>>>> work (which is the expected behavior) and a log without
>>>>> "pci=nommconf" where pciehp does work (which is again the
>>>>> expected behavior). 
>>>>>>> PCIe native hotplug doesn't work when booted with
>>>>>>> "pci=nommconf". When using "pci=nommconf", obviously we can't
>>>>>>> access the extended PCI config space (offset 0x100-0xfff), so
>>>>>>> none of the extended capabilities are available.
>>>>>>>
>>>>>>> In that case, we don't even ask the platform for control of
>>>>>>> PCIe hotplug via _OSC.  From the dmesg diff from normal
>>>>>>> (working) to "pci=nommconf" (not working):
>>>>>>>
>>>>>>>   -Command line: BOOT_IMAGE=/boot/vmlinuz-smp ...
>>>>>>>   +Command line: BOOT_IMAGE=/boot/vmlinuz-smp pci=nommconf ...
>>>>>>>   ...
>>>>>>>   -acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
>>>>>>> ClockPM Segments MSI HPX-Type3] -acpi PNP0A08:00: _OSC:
>>>>>>> platform does not support [AER LTR] -acpi PNP0A08:00: _OSC:
>>>>>>> OS now controls [PCIeHotplug PME PCIeCapability] +acpi
>>>>>>> PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MSI
>>>>>>> HPX-Type3] +acpi PNP0A08:00: _OSC: not requesting OS control;
>>>>>>> OS requires [ExtendedConfig ASPM ClockPM MSI] +acpi
>>>>>>> PNP0A08:00: MMCONFIG is disabled, can't access extended PCI
>>>>>>> configuration space under this bridge.  
>>>>>>
>>>>>> So, it shouldn't work from years but it has been broken
>>>>>> recently, that is the only objection I have. Could you tell why
>>>>>> it was working? According to your words- it shouldn't. We are
>>>>>> using VMD driver, is that matter?  
>>>>>
>>>>> 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") looks
>>>>> like a it could be related.  Try reverting that commit and see
>>>>> whether it makes a difference.  
>>>>
>>>> The affected NVMe is indeed behind VMD domain, so I think the commit
>>>> can make a difference.
>>>>
>>>> Does VMD behave differently on laptops and servers?
>>>> Anyway, I agree that the issue really lies in "pci=nommconf".  
>>>
>>> Oh, I have a guess:
>>>
>>>   - With "pci=nommconf", prior to v5.17-rc1, pciehp did not work in
>>>     general, but *did* work for NVMe behind a VMD.  As of v5.17-rc1,
>>>     pciehp no longer works for NVMe behind VMD.
>>>
>>>   - Without "pci=nommconf", pciehp works as expected for all devices
>>>     including NVMe behind VMD, both before and after v5.17-rc1.
>>>
>>> Is that what you're observing?
>>>
>>> If so, I doubt there's anything to fix other than getting rid of
>>> "pci=nommconf".
>>
>> I haven't tested with VMD disabled earlier. I verified it and my
>> observations are as follows:
>>
>> OS: RHEL 8.4
>> NO - hotplug not working
>> YES - hotplug working
>>
>> pci=nommconf added:
>> +--------------+-------------------+---------------------+--------------+
>> |              | pci-v5.17-changes | revert-04b12ef163d1 | inbox kernel
>> +--------------+-------------------+---------------------+--------------+
>> | VMD enabled  | NO                | YES                 | YES         
>> +--------------+-------------------+---------------------+--------------+
>> | VMD disabled | NO                | NO                  | NO
>> +--------------+-------------------+---------------------+--------------+
>>
>> without pci=nommconf:
>> +--------------+-------------------+---------------------+--------------+
>> |              | pci-v5.17-changes | revert-04b12ef163d1 | inbox kernel
>> +--------------+-------------------+---------------------+--------------+
>> | VMD enabled  | YES               | YES                 | YES
>> +--------------+-------------------+---------------------+--------------+
>> | VMD disabled | YES               | YES                 | YES
>> +--------------+-------------------+---------------------+--------------+
>>
>> So, results confirmed your assumptions, but I also confirmed that
>> revert of 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features")
>> makes it to work as in inbox kernel.
>>
>> We will drop the legacy parameter in our tests. According to my results
>> there is a regression in VMD caused by: 04b12ef163d1 commit, even if it
>> is not working for nvme anyway. Should it be fixed?
> 
> I don't know what the "inbox kernel" is.  I guess that's unmodified
> RHEL 8.4?
> 
> And revert-04b12ef163d1 means the pci-v5.17-changes tag plus a revert
> of 04b12ef163d1?
> 
> I think your "hotplug working" or "hotplug not working" notes refer
> specifically to devices behind VMD, right?  They do not refer to
> devices outside the VMD hierarchy?
> 
> So IIUC, the regression is that hotplug of devices behind VMD used to
> work with "pci=nommconf", but it does not work after 04b12ef163d1.
> IMO that does not need to be fixed because it was arguably a bug that
> it *did* work before.

FWIW, that afaics does matter. To quote Linus:

```
Users are literally the _only_ thing that matters.

No amount of "you shouldn't have used this" or "that behavior was
undefined, it's your own fault your app broke" or "that used to work
simply because of a kernel bug" is at all relevant.
```

That quote is from:
https://lore.kernel.org/all/CAHk-=wiVi7mSrsMP=fLXQrXK_UimybW=ziLOwSzFTtoXUacWVQ@mail.gmail.com/

So from my point of view as a regression tracker I currently think this
still needs to be fixed.

> That said, I'm not 100% confident about 04b12ef163d1 because _OSC is a
> way to negotiate ownership of things that could be owned either by
> platform firmware or by the OS, and the commit log doesn't make it
> clear that's the situation here.  It's more of a "the problem doesn't
> happen when we do this" sort of commit log.
> 
> If there's anything more to do here, it would be helpful to attach
> complete dmesg logs from the scenarios of interest to the bugzilla.
> That will help remove ambiguity about what's being tested and what the
> results are.

Ciao, Thorsten (wearing his 'Linux kernel regression tracker' hat)

P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Unfortunately
therefore I sometimes will get things wrong or miss something important.
I hope that's not the case here; if you think it is, don't hesitate to
tell me about it in a public reply, that's in everyone's interest.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activities wrt to this regression.
