Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C8E3A1B86
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 19:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFIRKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 13:10:02 -0400
Received: from mout.web.de ([212.227.17.12]:47609 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhFIRKC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jun 2021 13:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1623258480;
        bh=Hqw5ywvRoUAMqPU4IJewXBNDS35T7IdqkCfrVT/cpQo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Aj8RSeRClZeJtTQJoe6Tsq6Ht7UfE0cXIDTQigUo78AP5jYvnbxGTdK+8lCkkgens
         bzsOUbhUuP8AzPC5ntMhKUSB7EDviwx0khSjPt06F5L487KG+L6+tLQuQwkVRW/3YH
         z7gR6Snpq8FA45z523sFWoJOcjl1lobv6lWAPFp4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.2.53] ([178.12.13.203]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mfc8o-1lOHZQ0avw-00fzT7; Wed, 09
 Jun 2021 19:08:00 +0200
Subject: Re: QCA6174 pcie wifi: Add pci quirks
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     bhelgaas@google.com, Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210525221215.GA1235899@bjorn-Precision-5520>
 <19c3850e-e29c-3e39-9d44-9623a4f97346@web.de>
 <20210528182135.e7uiugoyuj7hjilb@pali>
 <8e443996-cead-a826-78ab-1c3f899228cb@web.de>
 <f72fad24-3b4a-2c62-55be-041ab4e67371@web.de>
 <20210608183446.3qvj52tm6c2bhtvu@pali>
From:   Ingmar Klein <ingmar_klein@web.de>
Message-ID: <3c05bdbe-92d9-7969-4824-82a51e70a069@web.de>
Date:   Wed, 9 Jun 2021 19:07:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210608183446.3qvj52tm6c2bhtvu@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C9VhHisPLBeXiXEkZRLud4cDjwGOXEy9oujqXWxPU+CMmBol1ik
 n/XMewn1KNXxXf3gIyH2Av71Uz2/oopd08zd5gz7yfCUFlQ551rp/++BX4tFLQkkzVTTm1L
 C+57APZC2VnMu+ZUsaehvAnqz9QYSbi0DoVimLVZ4/1ao9a4YZwrWBS/ySeOU6DKI7PEo8H
 LpTO8BevXKKDqLDQsbaLg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8szMIlhYmoc=:2ezf5UGWmxoPD5hiRmEYrj
 OisI3/ubGeG4RFUz+qWcKCUmKBirxfMqHRZuohQMqwN/sEszF2mvhIATu4IYDmd5hHWiHXbXw
 BfGDlo4c6O7qVutKxgGFaJXJIJ6t4U/zVuZ+kjarVGkZ6hIKjZM9Qv6Kvqe35UxM6FWGdsjWL
 VcTCB0h3wwSg1VFou5qVjwBZFl+r1QOzqQxxcsivRYet3rm2oXJIedwYANfh0VK5Zg1nkzQlM
 6U41wRS19HY+3FdVcxfgOoGOz4I0HaHvot845f/zovJcDx87uOGVdVsO/Ww+bq+eAxE4oUvvu
 xeCN0thNJBuLZde7PiGrbWVVsHsolLlvM9Q5IPM9nAc9OtY7/YCuvBoPFMtI5LcK4NzhD0tas
 8K18WvajsCK5jFHbl2j1L0griEbVqGzswxRhvNt06AP5VsyWGasijCGOqkmLB7X1yTA/JmB4l
 9iovKziCwUbVIATmPFWfkZ1VCrz4ZHumA4iz0MyeNyAe62B6s63lpUI/IX4oLHS+lsFDaN+eU
 7LV4v6TDweJvGiL9KKFJsP0aBzO0Y0cJ3/sS8qclPWaq6S44Oa6Hl2/wgkKs7UGNBY3644DHL
 3VqUT+J7xPcu+CnZI8Hr3CubN9ztkYaaZHKgRrLMBGfOpAo7R0aVUBicuE9XvBo/c8eAQXJk7
 wVNB1O6mhUFr9exq92ezVedL9ODFKgephRqMglgSHYZRAlSBdWZIt0NQsEarHUxeMtSmupt0v
 gkEDAKOFKQroJznFg0lS9XnKyaP13/enLunzj5C3NSb0Y3zBb8DQPHQJrZfjT7j7zsDoQ0v95
 AkzniwuBQTHlAPOYtHQSOZciqllcw6Klwm55bi+FBAaUo1cAe8T8UrH+UsafGDHdA2mh2NoL1
 YlupYmyXlcBR/VTBXIv7OvM0NaIGOR/dwJ1iHACA7aik+NaxtnvGUNJWJ0Kvruf54PBhLFnIg
 8NXrIN8rhsVw8pyt951ttg5Tj0+COu3JEZM/3tMdp/7CLytLd/7P1hasGgKlW1BPQY/aLV6Ul
 b5/BhKizstbT+hhG2II2G3QD1tBwWfzh7H8dWxhsoDhKhb4EQdpcQ6aqUbmx0Pbjk7O8Q+Ix+
 X5WlKJaIXlu6C67tQXQkqHCNHsTqkfxVmA/
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Yes, would be really nice if you could do that.
Seems to work perfectly fine.

Thanks and have a nice rest of the day!
Best regards,
Ingmar


Am 08.06.2021 um 20:34 schrieb Pali Roh=C3=A1r:
> Hello! So should I add also 0x003e device id in next patch iteration?
>
> On Saturday 05 June 2021 16:46:36 Ingmar Klein wrote:
>> Hi Pali and Bjorn,
>>
>> finally found the time to test.
>> Pali's v3 patch seems to work like a charm for my card with "0x003e" id
>> as well.
>> Just finished compiling a pve-kernel v5.11.21 with Pali's patch,
>> slightly adjusted for my test card and the Ubuntu kernel source (no
>> functional differences, just minor adjustments to make it fit the
>> Proxmox pve-kernel).
>>
>> System works just fine, in contrast to without patch. Of course, no lon=
g
>> term tests, yet. However, it is looking really good.
>> Thanks guys!
>>
>> Best regards,
>> Ingmar
>>
>>
>> Am 28.05.2021 um 20:47 schrieb Ingmar Klein:
>>> Hi Pali,
>>> sorry for not checking that detail!
>>> Of course no problem that you couldn't test that ID. Will be glad to
>>> do so.
>>>
>>> I'll let you know how this turns out.
>>>
>>> Best regards,
>>> Ingmar
>>>
>>>
>>> Am 28.05.2021 um 20:21 schrieb Pali Roh=C3=A1r:
>>>> Hello Ingmar!
>>>>
>>>> Now I see that in your patch you have Atheros card with id 0x003e:
>>>> https://lore.kernel.org/linux-pci/08982e05-b6e8-5a8d-24ab-da1488ee50a=
8@web.de/
>>>>
>>>>
>>>> With my patch I have tested 5 different Atheros cards but none has id
>>>> 0x003e:
>>>> https://lore.kernel.org/linux-pci/20210505163357.16012-1-pali@kernel.=
org/
>>>>
>>>>
>>>> So my patch does not fix that issue for your 0x003e card. I just do n=
ot
>>>> have such card for testing.
>>>>
>>>> Could you try to apply my patch and then add your id 0x003e into quir=
k
>>>> list if it helps?
>>>>
>>>> On Friday 28 May 2021 20:08:52 Ingmar Klein wrote:
>>>>> Thanks to both of you, Bjorn and Pali!
>>>>> I had hoped that Pali would come with an appropriate fix. Good to kn=
ow,
>>>>> that this is taken care of.
>>>>>
>>>>> Will test ASAP, but I am confident, that it will work anyway.
>>>>> Should it unexpectedly not fix my issues, I'll let you know.
>>>>> Have a nice weekend!
>>>>> Best regards,
>>>>> Ingmar
>>>>>
>>>>>
>>>>> Am 26.05.2021 um 00:12 schrieb Bjorn Helgaas:
>>>>>> On Thu, Apr 15, 2021 at 09:53:38PM +0200, Pali Roh=C3=A1r wrote:
>>>>>>> Hello!
>>>>>>>
>>>>>>> On Thursday 15 April 2021 13:01:19 Alex Williamson wrote:
>>>>>>>> [cc +Pali]
>>>>>>>>
>>>>>>>> On Thu, 15 Apr 2021 20:02:23 +0200
>>>>>>>> Ingmar Klein <ingmar_klein@web.de> wrote:
>>>>>>>>
>>>>>>>>> First thanks to you both, Alex and Bjorn!
>>>>>>>>> I am in no way an expert on this topic, so I have to fully rely
>>>>>>>>> on your
>>>>>>>>> feedback, concerning this issue.
>>>>>>>>>
>>>>>>>>> If you should have any other solution approach, in form of
>>>>>>>>> patch-set, I
>>>>>>>>> would be glad to test it out. Just let me know, what you think
>>>>>>>>> might
>>>>>>>>> make sense.
>>>>>>>>> I will wait for your further feedback on the issue. In the
>>>>>>>>> meantime I
>>>>>>>>> have my current workaround via quirk entry.
>>>>>>>>>
>>>>>>>>> By the way, my layman's question:
>>>>>>>>> Do you think, that the following topic might also apply for the
>>>>>>>>> QCA6174?
>>>>>>>>> https://www.spinics.net/lists/linux-pci/msg106395.html
>>>>>>> I have been testing more ath cards and I'm going to send a new
>>>>>>> version
>>>>>>> of this patch with including more PCI ids.
>>>>>> Dropping this patch in favor of Pali's new version.
>>>>>>
>>>>>>>>> Or in other words, should a similar approach be tried for the
>>>>>>>>> QCA6174
>>>>>>>>> and if yes, would it bring any benefit at all?
>>>>>>>>> I hope you can excuse me, in case the questions should not make
>>>>>>>>> too much
>>>>>>>>> sense.
>>>>>>>> If you run lspci -vvv on your device, what do LnkCap and LnkSta
>>>>>>>> report
>>>>>>>> under the express capability?=C2=A0 I wonder if your device even =
supports
>>>>>>>>> Gen1 speeds, mine does not.
>>>>>>>> I would not expect that patch to be relevant to you based on your
>>>>>>>> report.=C2=A0 I understand it to resolve an issue during link
>>>>>>>> retraining to a
>>>>>>>> higher speed on boot, not during a bus reset.=C2=A0 Pali can corr=
ect
>>>>>>>> if I'm
>>>>>>>> wrong.=C2=A0 Thanks,
>>>>>>> These two issues are are related. Both operations (PCIe Hot Reset =
and
>>>>>>> PCIe Link Retraining) cause reset of ath chips. Seems that they ca=
use
>>>>>>> double reset. After reset these chips reads configuration from
>>>>>>> internal
>>>>>>> EEPROM/OTP and if another reset is triggered prior chip finishes
>>>>>>> internal configuration read then it stops working. My testing show=
ed
>>>>>>> that ath10k chips completely disappear from the PCIe bus, some ath=
9k
>>>>>>> chips works fine but starts reporting incorrect PCI ID (0xABCD)
>>>>>>> and some
>>>>>>> other ath9k chips reports correct PCI ID but does not work. I had
>>>>>>> discussion with Adrian Chadd who knows probably everything about
>>>>>>> ath9k
>>>>>>> and confirmed me that this issue is there with ath9k and ath10k
>>>>>>> chips.
>>>>>>>
>>>>>>> He wrote me that workaround to turn card back from this "broken"
>>>>>>> state
>>>>>>> is to do PCIe Cold Reset of the card, which means turning power
>>>>>>> supply
>>>>>>> off for particular PCIe slot. Such thing is not supported on many
>>>>>>> low-end boards, so workaround cannot be applied.
>>>>>>>
>>>>>>> I was able to recover my testing cards from this "broken" state by
>>>>>>> PCIe
>>>>>>> Warm Reset (=3D reset via PERST# pin).
>>>>>>>
>>>>>>> I have tried many other reset methods (PCIe PM reset, Link Down, P=
CIe
>>>>>>> Hot Reset with bigger internal, ...) but nothing worked. So seems
>>>>>>> that
>>>>>>> the only workaround is to do PCIe Cold Reset or PCIe Warm Reset.
>>>>>>>
>>>>>>> I will send V2 of my patch with details and explanation.
>>>>>>>
>>>>>>> As kernel does not have API for doing PCIe Warm Reset, I think is
>>>>>>> another argument why kernel really needs it.
>>>>>>>
>>>>>>> I do not have any QCA6174 card for testing, but based on the fact =
I
>>>>>>> reproduced this issue with more ath9k and ath10 cards and Adrian
>>>>>>> confirmed that above reset issue is there, I think that it affects
>>>>>>> all
>>>>>>> AR9xxx and QCAxxxx cards handled by ath9k and ath10 drivers.
>>>>>>>
>>>>>>> I was told that AMI BIOS was patching their BIOSes found in
>>>>>>> notebooks to
>>>>>>> avoid triggering this issue on notebooks ath9k cards.
>>>>>>>
>>>>>>>> Alex
>>>>>>>>
>>>>>>>>> Am 15.04.2021 um 04:36 schrieb Alex Williamson:
>>>>>>>>>> On Wed, 14 Apr 2021 16:03:50 -0500
>>>>>>>>>> Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>>>>>
>>>>>>>>>>> [+cc Alex]
>>>>>>>>>>>
>>>>>>>>>>> On Fri, Apr 09, 2021 at 11:26:33AM +0200, Ingmar Klein wrote:
>>>>>>>>>>>> Edit: Retry, as I did not consider, that my mail-client would
>>>>>>>>>>>> make this
>>>>>>>>>>>> party html.
>>>>>>>>>>>>
>>>>>>>>>>>> Dear maintainers,
>>>>>>>>>>>> I recently encountered an issue on my Proxmox server system,
>>>>>>>>>>>> that
>>>>>>>>>>>> includes a Qualcomm QCA6174 m.2 PCIe wifi module.
>>>>>>>>>>>> https://deviwiki.com/wiki/AIRETOS_AFX-QCA6174-NX
>>>>>>>>>>>>
>>>>>>>>>>>> On system boot and subsequent virtual machine start (with
>>>>>>>>>>>> passed-through
>>>>>>>>>>>> QCA6174), the VM would just freeze/hang, at the point where
>>>>>>>>>>>> the ath10k
>>>>>>>>>>>> driver loads.
>>>>>>>>>>>> Quick search in the proxmox related topics, brought me to the
>>>>>>>>>>>> following
>>>>>>>>>>>> discussion, which suggested a PCI quirk entry for the QCA6174
>>>>>>>>>>>> in the kernel:
>>>>>>>>>>>> https://forum.proxmox.com/threads/pcie-passthrough-freezes-pr=
oxmox.27513/
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I then went ahead, got the Proxmox kernel source (v5.4.106)
>>>>>>>>>>>> and applied
>>>>>>>>>>>> the attached patch.
>>>>>>>>>>>> Effect was as hoped, that the VM hangs are now gone. System
>>>>>>>>>>>> boots and
>>>>>>>>>>>> runs as intended.
>>>>>>>>>>>>
>>>>>>>>>>>> Judging by the existing quirk entries for Atheros, I would
>>>>>>>>>>>> think, that
>>>>>>>>>>>> my proposed "fix" could be included in the vanilla kernel.
>>>>>>>>>>>> As far as I saw, there is no entry yet, even in the latest
>>>>>>>>>>>> kernel sources.
>>>>>>>>>>> This would need a signed-off-by; see
>>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git/tree/Documentation/process/submitting-patches.rst?id=3Dv5.11#n361
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> This is an old issue, and likely we'll end up just applying
>>>>>>>>>>> this as
>>>>>>>>>>> yet another quirk.=C2=A0 But looking at c3e59ee4e766 ("PCI: Ma=
rk
>>>>>>>>>>> Atheros
>>>>>>>>>>> AR93xx to avoid bus reset"), where it started, it seems to be
>>>>>>>>>>> connected to 425c1b223dac ("PCI: Add Virtual Channel to
>>>>>>>>>>> save/restore
>>>>>>>>>>> support").
>>>>>>>>>>>
>>>>>>>>>>> I'd like to dig into that a bit more to see if there are any
>>>>>>>>>>> clues.
>>>>>>>>>>> AFAIK Linux itself still doesn't use VC at all, and
>>>>>>>>>>> 425c1b223dac added
>>>>>>>>>>> a fair bit of code.=C2=A0 I wonder if we're restoring somethin=
g out of
>>>>>>>>>>> order or making some simple mistake in the way to restore VC
>>>>>>>>>>> config.
>>>>>>>>>> I don't really have any faith in that bisect report in commit
>>>>>>>>>> c3e59ee4e766.=C2=A0 To double check I dug out the card from tha=
t
>>>>>>>>>> commit,
>>>>>>>>>> installed an old Fedora release so I could build kernel v3.13,
>>>>>>>>>> pre-dating 425c1b223dac and tested triggering a bus reset both =
via
>>>>>>>>>> setpci and by masking PM reset so that sysfs can trigger the
>>>>>>>>>> bus reset
>>>>>>>>>> path with the kernel save/restore code.=C2=A0 Both result in th=
e system
>>>>>>>>>> hanging when the device is accessed either restoring from the
>>>>>>>>>> kernel
>>>>>>>>>> bus reset or reading from the device after the setpci reset.
>>>>>>>>>> Thanks,
>>>>>>>>>>
>>>>>>>>>> Alex
>>>>>>>>>>
