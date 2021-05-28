Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C1B394741
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 20:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhE1StW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 14:49:22 -0400
Received: from mout.web.de ([212.227.15.4]:54173 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhE1StV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 May 2021 14:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622227660;
        bh=pEKZzRzgqtVb5omRXvE53g0cO+fg2N5ajwx1z0/JOOM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=G2NwP1NL7TZFIo8g3tGVFEY0jcuBu5vYUC4s74JMkFMerfaoisIK0466hyylPlJ0K
         PLc8/CE8mBMZn1ClzveVoyPUrlcwpxxl8OExA3clRb++jMhIzFkk8EyU3GcoD9l2fL
         dRAXR6EvjU39tKB7+tc4tBSrU+lcyaUGd29C0exE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.2.53] ([178.4.39.16]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzCA3-1lRAGO49v1-00vt5K; Fri, 28
 May 2021 20:47:40 +0200
Subject: Re: QCA6174 pcie wifi: Add pci quirks
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210525221215.GA1235899@bjorn-Precision-5520>
 <19c3850e-e29c-3e39-9d44-9623a4f97346@web.de>
 <20210528182135.e7uiugoyuj7hjilb@pali>
From:   Ingmar Klein <ingmar_klein@web.de>
Message-ID: <8e443996-cead-a826-78ab-1c3f899228cb@web.de>
Date:   Fri, 28 May 2021 20:47:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210528182135.e7uiugoyuj7hjilb@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:69Y29BCdbD/8BvNm0m+GOwQTTqW1NpwsfX4wxdvVlqEOdT/24d6
 dqi4v57PAi0gi6IXycxXtkBJtpyPaZ4uttucxMHn/ucCBmc3YHfruXQv2wdarwaZWw2CCAx
 g1Vc/tIwKEaVXeQhNWyLJ/4P5FpexbRX/6bbU0UyY4OHymv1UjQscBXkuOGW4CxVRf8sF9d
 MaO3Ndic3VRACZig8j+qQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o0e2cnc6gHU=:A2p9/N7ULnz8FD2nvsYdk5
 47JcQBEYZoFr4Fzfr8koPeZTXEjdlXkH1LmaxH7RUG9lh29RqBH7ruwA5WQ0+6hBtUCt2mbC7
 qyXBGWryr1hcxtJFrrVdg4SG0EfRWqCMPd47eWHOTp+QOR3hP3N34mMbHTpP42g/acdQjUAlU
 OduC76kM6u2eeFmTnLgisFZk19oVWci0Kib85c5ftA7PA7awMZtR7iWkeIeNuPuapT8mW37sp
 CtD0EN8T+P7aXMzrTrW3LkqMvyw2jCX9Czst70wE+JP0gEyqF8MyldBVfKfT3m3MY355S/LcE
 VymOsDDby2Foe/rMPWPdTSIvn/l70LmLTfBPVy6ID7XnJjj9SZEbtenVLxyHFCdn0y4SmZEl9
 2AdJZpcQ1hRvrKXwen/9gFkb6f5QOjm/1zZaUloNU+wYgbfsMmtc6LGuIQ4ibvaEu33eBLRzB
 tlN4FzoiQZkJM5MxvSRFPC4O4NAnOJNdrXRcpe9fOewsgC9+WJraFt5LFcXaeeb4emCgidk96
 0kHS4u4EYlac0p/alOE+2wY8jIZhtBFpc6uJxxjZoi1xOEnPo27vXYGGfPAz9dZ4vZtplzi35
 VsVfUsUnQtTmdPWWjXxF8I/626lsGouYf3ROSllcNnYNdwZWP5bcpzwIpQKH3+/uJzITECGau
 dszlEb++t4Md3zLX1C1a7BuaQlh223JiOeQVnsGe1ndQ512CTf9cHp2G491hgoebMiUFXXuVy
 PRmoEeKuRXFAdjmhMlR8kCKCtsINWWz9We0kmmGH6cJcIkxH6z+UnNi1SkjxsybqLzquZ2/Ew
 NDxc/4kiYyK6isaDqn0UiOMyUHc0DKumXrzURfb3fTVwdfF3hBdJXCFDA9R1F+LJoKI8a7L/B
 2cF5i09xbEGjrOIx2VKUwHyAohEuDDWjVmcdIcFRufmOsepqxOVEXXwOkhMOay9uU33GKoaWp
 KGhGI7y5tHXm9HxPfrEB+CEk0+QJ5PmpdzhVgdFdcUw/FYgsxhVEV6TWTgHw8iLfOH43mvVTd
 bj7ZDQAoIbFsrsLIOYztUzoRbfNf96owA9AGKE/O6hMSuwon6m7AydFxLA5rFYJO3TCI0/MLQ
 fATIJrt/K4O9D888dgQaAo7PsK9ZIGoLbqn9iNhpRJqyKDcr2lCOcx+B5UdCTplGTJNvnk2ys
 JoUSZoiTe4vBqAe/1j48UpPWzgkGbjEOKNT3g9Hh+mRxNqqIxMSmIYFXoATFh8xorqUIg=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,
sorry for not checking that detail!
Of course no problem that you couldn't test that ID. Will be glad to do so=
.

I'll let you know how this turns out.

Best regards,
Ingmar


Am 28.05.2021 um 20:21 schrieb Pali Roh=C3=A1r:
> Hello Ingmar!
>
> Now I see that in your patch you have Atheros card with id 0x003e:
> https://lore.kernel.org/linux-pci/08982e05-b6e8-5a8d-24ab-da1488ee50a8@w=
eb.de/
>
> With my patch I have tested 5 different Atheros cards but none has id 0x=
003e:
> https://lore.kernel.org/linux-pci/20210505163357.16012-1-pali@kernel.org=
/
>
> So my patch does not fix that issue for your 0x003e card. I just do not
> have such card for testing.
>
> Could you try to apply my patch and then add your id 0x003e into quirk
> list if it helps?
>
> On Friday 28 May 2021 20:08:52 Ingmar Klein wrote:
>> Thanks to both of you, Bjorn and Pali!
>> I had hoped that Pali would come with an appropriate fix. Good to know,
>> that this is taken care of.
>>
>> Will test ASAP, but I am confident, that it will work anyway.
>> Should it unexpectedly not fix my issues, I'll let you know.
>> Have a nice weekend!
>> Best regards,
>> Ingmar
>>
>>
>> Am 26.05.2021 um 00:12 schrieb Bjorn Helgaas:
>>> On Thu, Apr 15, 2021 at 09:53:38PM +0200, Pali Roh=C3=A1r wrote:
>>>> Hello!
>>>>
>>>> On Thursday 15 April 2021 13:01:19 Alex Williamson wrote:
>>>>> [cc +Pali]
>>>>>
>>>>> On Thu, 15 Apr 2021 20:02:23 +0200
>>>>> Ingmar Klein <ingmar_klein@web.de> wrote:
>>>>>
>>>>>> First thanks to you both, Alex and Bjorn!
>>>>>> I am in no way an expert on this topic, so I have to fully rely on =
your
>>>>>> feedback, concerning this issue.
>>>>>>
>>>>>> If you should have any other solution approach, in form of patch-se=
t, I
>>>>>> would be glad to test it out. Just let me know, what you think migh=
t
>>>>>> make sense.
>>>>>> I will wait for your further feedback on the issue. In the meantime=
 I
>>>>>> have my current workaround via quirk entry.
>>>>>>
>>>>>> By the way, my layman's question:
>>>>>> Do you think, that the following topic might also apply for the QCA=
6174?
>>>>>> https://www.spinics.net/lists/linux-pci/msg106395.html
>>>> I have been testing more ath cards and I'm going to send a new versio=
n
>>>> of this patch with including more PCI ids.
>>> Dropping this patch in favor of Pali's new version.
>>>
>>>>>> Or in other words, should a similar approach be tried for the QCA61=
74
>>>>>> and if yes, would it bring any benefit at all?
>>>>>> I hope you can excuse me, in case the questions should not make too=
 much
>>>>>> sense.
>>>>> If you run lspci -vvv on your device, what do LnkCap and LnkSta repo=
rt
>>>>> under the express capability?  I wonder if your device even supports
>>>>>> Gen1 speeds, mine does not.
>>>>> I would not expect that patch to be relevant to you based on your
>>>>> report.  I understand it to resolve an issue during link retraining =
to a
>>>>> higher speed on boot, not during a bus reset.  Pali can correct if I=
'm
>>>>> wrong.  Thanks,
>>>> These two issues are are related. Both operations (PCIe Hot Reset and
>>>> PCIe Link Retraining) cause reset of ath chips. Seems that they cause
>>>> double reset. After reset these chips reads configuration from intern=
al
>>>> EEPROM/OTP and if another reset is triggered prior chip finishes
>>>> internal configuration read then it stops working. My testing showed
>>>> that ath10k chips completely disappear from the PCIe bus, some ath9k
>>>> chips works fine but starts reporting incorrect PCI ID (0xABCD) and s=
ome
>>>> other ath9k chips reports correct PCI ID but does not work. I had
>>>> discussion with Adrian Chadd who knows probably everything about ath9=
k
>>>> and confirmed me that this issue is there with ath9k and ath10k chips=
.
>>>>
>>>> He wrote me that workaround to turn card back from this "broken" stat=
e
>>>> is to do PCIe Cold Reset of the card, which means turning power suppl=
y
>>>> off for particular PCIe slot. Such thing is not supported on many
>>>> low-end boards, so workaround cannot be applied.
>>>>
>>>> I was able to recover my testing cards from this "broken" state by PC=
Ie
>>>> Warm Reset (=3D reset via PERST# pin).
>>>>
>>>> I have tried many other reset methods (PCIe PM reset, Link Down, PCIe
>>>> Hot Reset with bigger internal, ...) but nothing worked. So seems tha=
t
>>>> the only workaround is to do PCIe Cold Reset or PCIe Warm Reset.
>>>>
>>>> I will send V2 of my patch with details and explanation.
>>>>
>>>> As kernel does not have API for doing PCIe Warm Reset, I think is
>>>> another argument why kernel really needs it.
>>>>
>>>> I do not have any QCA6174 card for testing, but based on the fact I
>>>> reproduced this issue with more ath9k and ath10 cards and Adrian
>>>> confirmed that above reset issue is there, I think that it affects al=
l
>>>> AR9xxx and QCAxxxx cards handled by ath9k and ath10 drivers.
>>>>
>>>> I was told that AMI BIOS was patching their BIOSes found in notebooks=
 to
>>>> avoid triggering this issue on notebooks ath9k cards.
>>>>
>>>>> Alex
>>>>>
>>>>>> Am 15.04.2021 um 04:36 schrieb Alex Williamson:
>>>>>>> On Wed, 14 Apr 2021 16:03:50 -0500
>>>>>>> Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>>
>>>>>>>> [+cc Alex]
>>>>>>>>
>>>>>>>> On Fri, Apr 09, 2021 at 11:26:33AM +0200, Ingmar Klein wrote:
>>>>>>>>> Edit: Retry, as I did not consider, that my mail-client would ma=
ke this
>>>>>>>>> party html.
>>>>>>>>>
>>>>>>>>> Dear maintainers,
>>>>>>>>> I recently encountered an issue on my Proxmox server system, tha=
t
>>>>>>>>> includes a Qualcomm QCA6174 m.2 PCIe wifi module.
>>>>>>>>> https://deviwiki.com/wiki/AIRETOS_AFX-QCA6174-NX
>>>>>>>>>
>>>>>>>>> On system boot and subsequent virtual machine start (with passed=
-through
>>>>>>>>> QCA6174), the VM would just freeze/hang, at the point where the =
ath10k
>>>>>>>>> driver loads.
>>>>>>>>> Quick search in the proxmox related topics, brought me to the fo=
llowing
>>>>>>>>> discussion, which suggested a PCI quirk entry for the QCA6174 in=
 the kernel:
>>>>>>>>> https://forum.proxmox.com/threads/pcie-passthrough-freezes-proxm=
ox.27513/
>>>>>>>>>
>>>>>>>>> I then went ahead, got the Proxmox kernel source (v5.4.106) and =
applied
>>>>>>>>> the attached patch.
>>>>>>>>> Effect was as hoped, that the VM hangs are now gone. System boot=
s and
>>>>>>>>> runs as intended.
>>>>>>>>>
>>>>>>>>> Judging by the existing quirk entries for Atheros, I would think=
, that
>>>>>>>>> my proposed "fix" could be included in the vanilla kernel.
>>>>>>>>> As far as I saw, there is no entry yet, even in the latest kerne=
l sources.
>>>>>>>> This would need a signed-off-by; see
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/Documentation/process/submitting-patches.rst?id=3Dv5.11#n361
>>>>>>>>
>>>>>>>> This is an old issue, and likely we'll end up just applying this =
as
>>>>>>>> yet another quirk.  But looking at c3e59ee4e766 ("PCI: Mark Ather=
os
>>>>>>>> AR93xx to avoid bus reset"), where it started, it seems to be
>>>>>>>> connected to 425c1b223dac ("PCI: Add Virtual Channel to save/rest=
ore
>>>>>>>> support").
>>>>>>>>
>>>>>>>> I'd like to dig into that a bit more to see if there are any clue=
s.
>>>>>>>> AFAIK Linux itself still doesn't use VC at all, and 425c1b223dac =
added
>>>>>>>> a fair bit of code.  I wonder if we're restoring something out of
>>>>>>>> order or making some simple mistake in the way to restore VC conf=
ig.
>>>>>>> I don't really have any faith in that bisect report in commit
>>>>>>> c3e59ee4e766.  To double check I dug out the card from that commit=
,
>>>>>>> installed an old Fedora release so I could build kernel v3.13,
>>>>>>> pre-dating 425c1b223dac and tested triggering a bus reset both via
>>>>>>> setpci and by masking PM reset so that sysfs can trigger the bus r=
eset
>>>>>>> path with the kernel save/restore code.  Both result in the system
>>>>>>> hanging when the device is accessed either restoring from the kern=
el
>>>>>>> bus reset or reading from the device after the setpci reset.  Than=
ks,
>>>>>>>
>>>>>>> Alex
>>>>>>>
