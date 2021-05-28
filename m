Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723993946C2
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 20:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbhE1SKg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 14:10:36 -0400
Received: from mout.web.de ([212.227.15.3]:47555 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhE1SKg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 May 2021 14:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622225334;
        bh=ZUsGct7xpCxA5eOgUkzGiDDOb/vfSxKmtWaohz0d3w0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ar/fZqYde6+3zwZxe3VB0a1GKPdEe2nH/cGujJVMLMHYNGTQdJmiaOA0T2TSLSNO+
         Pqv+UblH0tYKv5H++83rF/C7aqq2IFrFH2LzgTt0a5C24eKzlWMZMs5Ia+3RX4LF9Y
         zwyQBCOI+Jfu9wT//kmGmsH0sqU1b/63fPZLadfA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.2.53] ([178.4.39.16]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8Qqo-1lRQvv4AS2-00vx1p; Fri, 28
 May 2021 20:08:54 +0200
Subject: Re: QCA6174 pcie wifi: Add pci quirks
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210525221215.GA1235899@bjorn-Precision-5520>
From:   Ingmar Klein <ingmar_klein@web.de>
Message-ID: <19c3850e-e29c-3e39-9d44-9623a4f97346@web.de>
Date:   Fri, 28 May 2021 20:08:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525221215.GA1235899@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N5sqLqfO3nWNMNL5KGxUR8d8gH1V1+2iQyMoQSL5WlPR6sE3fCz
 d5NBnlIoXP78iLLGM3hXFBvnRz9uxvIZehRPy9nJ7UGQg5OhaAcQX2RAdBzGBbmaOVFqvkF
 0MStup/2gAC4VVA6qqF+8V9cDE+KkL0ex5YMuGwArkGRm14+MW7/SQTPscKGIFWv/0ZPvby
 I5PHafVs0W57rgeWLoQhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zyrlr/ujkhA=:C9fLLa8xljmjTnq3OnuBmR
 uqxnwCn19nVz0TEeUowlf54vS++w/aamjkX+KMnN/3nRh9K2erRy/0sT5GJbFuLc/iTm5SvNB
 GKwR9J/kFSbPqqQeJtbkvrxCUaVR1kVH8Fkg9dd9POrMICLsne8wfxrqSe1ScAnU2B66O1Aig
 IA0KDoIaodpE1D+Ge/2MHrrFzV6efVlv/mIYaE0dh6CQfVzAuJMYFwV9QEncb+ny4pP+g499i
 09dMBId+OCvbv8UIJRjq9ou1rDe5PUfU78CK9NTsibNZ53UUfSfySPzVLnCE/PXyS2Q9FxaPT
 eK3omGWGW/Gvs6mCh+rGqzuNE70Tq7J1Yrto8EMLbxkDrUkMOYbAwnI3MxlGjzscGt+k3QzMo
 symfNo/ceoG7eCZun3qzW+/eedNS6//E6sbkcXy2YZYkU92ToiYah9Raimu8FTsnrYdNupQbt
 E1RCyDX1uoxCbioK+DkkRhGOzpILfC5/gzZsVJsX2djOVun39JOYpkq0cgvHsYWZCmEgTufBC
 aysH33E+dSJOIz5v9Zc7TiAb9SF7G3c5UGEsRzeZmhQQpnBH8DdS2vISKO4bXqIH99cxC5/yG
 Vk576ygdBnCQD7Ca+OD0FPEDTPY3eeyLfSItk6K+hoBXBuboduMHxdk7euwJpXC7yagMafGus
 q63beezv2OdBljpTq4YfhE9c1BXOnZyF7YF8bcROMJc3sbuCZas3AgbQDNEnl/5cWsuqowu9o
 GlMCm558xaDL1uLfz0orh0356y6pbZvIEBM7t9WXsLA+fNNK4z1kI74O+yPvCLsKYEe74mC16
 7N/0o2PbvK4HqIKC9NKmeWo91rMK7ajzssI7PVW1VRV5WFogQG98s1zK26xyOwGnYJmtvutej
 J+yXltfvQcTfNIskoHLBPH0hIkNa6VbgojYoBbMX9q1Lk+y3WuMFuoJP3jK3FB+Q1amDxBM2C
 MqPKYqT026fvNjDkl5ZbjUIFmZdjlii+x1jatQM4kyNmrtrggoGBrEJEiu5AjYghKvsdW1QQt
 zJaVOj6nrETg3gAokGc7QoNHlqN1iozP7VmcmV1ZrtohbDiT+LyYry76uCeNW0JPKuDUG7f5m
 +59M77bF4ajJHbJsO7iUfRYlLSYXz0RsWi2
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks to both of you, Bjorn and Pali!
I had hoped that Pali would come with an appropriate fix. Good to know,
that this is taken care of.

Will test ASAP, but I am confident, that it will work anyway.
Should it unexpectedly not fix my issues, I'll let you know.
Have a nice weekend!
Best regards,
Ingmar


Am 26.05.2021 um 00:12 schrieb Bjorn Helgaas:
> On Thu, Apr 15, 2021 at 09:53:38PM +0200, Pali Roh=C3=A1r wrote:
>> Hello!
>>
>> On Thursday 15 April 2021 13:01:19 Alex Williamson wrote:
>>> [cc +Pali]
>>>
>>> On Thu, 15 Apr 2021 20:02:23 +0200
>>> Ingmar Klein <ingmar_klein@web.de> wrote:
>>>
>>>> First thanks to you both, Alex and Bjorn!
>>>> I am in no way an expert on this topic, so I have to fully rely on yo=
ur
>>>> feedback, concerning this issue.
>>>>
>>>> If you should have any other solution approach, in form of patch-set,=
 I
>>>> would be glad to test it out. Just let me know, what you think might
>>>> make sense.
>>>> I will wait for your further feedback on the issue. In the meantime I
>>>> have my current workaround via quirk entry.
>>>>
>>>> By the way, my layman's question:
>>>> Do you think, that the following topic might also apply for the QCA61=
74?
>>>> https://www.spinics.net/lists/linux-pci/msg106395.html
>> I have been testing more ath cards and I'm going to send a new version
>> of this patch with including more PCI ids.
> Dropping this patch in favor of Pali's new version.
>
>>>> Or in other words, should a similar approach be tried for the QCA6174
>>>> and if yes, would it bring any benefit at all?
>>>> I hope you can excuse me, in case the questions should not make too m=
uch
>>>> sense.
>>> If you run lspci -vvv on your device, what do LnkCap and LnkSta report
>>> under the express capability?  I wonder if your device even supports
>>>> Gen1 speeds, mine does not.
>>> I would not expect that patch to be relevant to you based on your
>>> report.  I understand it to resolve an issue during link retraining to=
 a
>>> higher speed on boot, not during a bus reset.  Pali can correct if I'm
>>> wrong.  Thanks,
>> These two issues are are related. Both operations (PCIe Hot Reset and
>> PCIe Link Retraining) cause reset of ath chips. Seems that they cause
>> double reset. After reset these chips reads configuration from internal
>> EEPROM/OTP and if another reset is triggered prior chip finishes
>> internal configuration read then it stops working. My testing showed
>> that ath10k chips completely disappear from the PCIe bus, some ath9k
>> chips works fine but starts reporting incorrect PCI ID (0xABCD) and som=
e
>> other ath9k chips reports correct PCI ID but does not work. I had
>> discussion with Adrian Chadd who knows probably everything about ath9k
>> and confirmed me that this issue is there with ath9k and ath10k chips.
>>
>> He wrote me that workaround to turn card back from this "broken" state
>> is to do PCIe Cold Reset of the card, which means turning power supply
>> off for particular PCIe slot. Such thing is not supported on many
>> low-end boards, so workaround cannot be applied.
>>
>> I was able to recover my testing cards from this "broken" state by PCIe
>> Warm Reset (=3D reset via PERST# pin).
>>
>> I have tried many other reset methods (PCIe PM reset, Link Down, PCIe
>> Hot Reset with bigger internal, ...) but nothing worked. So seems that
>> the only workaround is to do PCIe Cold Reset or PCIe Warm Reset.
>>
>> I will send V2 of my patch with details and explanation.
>>
>> As kernel does not have API for doing PCIe Warm Reset, I think is
>> another argument why kernel really needs it.
>>
>> I do not have any QCA6174 card for testing, but based on the fact I
>> reproduced this issue with more ath9k and ath10 cards and Adrian
>> confirmed that above reset issue is there, I think that it affects all
>> AR9xxx and QCAxxxx cards handled by ath9k and ath10 drivers.
>>
>> I was told that AMI BIOS was patching their BIOSes found in notebooks t=
o
>> avoid triggering this issue on notebooks ath9k cards.
>>
>>> Alex
>>>
>>>> Am 15.04.2021 um 04:36 schrieb Alex Williamson:
>>>>> On Wed, 14 Apr 2021 16:03:50 -0500
>>>>> Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>
>>>>>> [+cc Alex]
>>>>>>
>>>>>> On Fri, Apr 09, 2021 at 11:26:33AM +0200, Ingmar Klein wrote:
>>>>>>> Edit: Retry, as I did not consider, that my mail-client would make=
 this
>>>>>>> party html.
>>>>>>>
>>>>>>> Dear maintainers,
>>>>>>> I recently encountered an issue on my Proxmox server system, that
>>>>>>> includes a Qualcomm QCA6174 m.2 PCIe wifi module.
>>>>>>> https://deviwiki.com/wiki/AIRETOS_AFX-QCA6174-NX
>>>>>>>
>>>>>>> On system boot and subsequent virtual machine start (with passed-t=
hrough
>>>>>>> QCA6174), the VM would just freeze/hang, at the point where the at=
h10k
>>>>>>> driver loads.
>>>>>>> Quick search in the proxmox related topics, brought me to the foll=
owing
>>>>>>> discussion, which suggested a PCI quirk entry for the QCA6174 in t=
he kernel:
>>>>>>> https://forum.proxmox.com/threads/pcie-passthrough-freezes-proxmox=
.27513/
>>>>>>>
>>>>>>> I then went ahead, got the Proxmox kernel source (v5.4.106) and ap=
plied
>>>>>>> the attached patch.
>>>>>>> Effect was as hoped, that the VM hangs are now gone. System boots =
and
>>>>>>> runs as intended.
>>>>>>>
>>>>>>> Judging by the existing quirk entries for Atheros, I would think, =
that
>>>>>>> my proposed "fix" could be included in the vanilla kernel.
>>>>>>> As far as I saw, there is no entry yet, even in the latest kernel =
sources.
>>>>>> This would need a signed-off-by; see
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/process/submitting-patches.rst?id=3Dv5.11#n361
>>>>>>
>>>>>> This is an old issue, and likely we'll end up just applying this as
>>>>>> yet another quirk.  But looking at c3e59ee4e766 ("PCI: Mark Atheros
>>>>>> AR93xx to avoid bus reset"), where it started, it seems to be
>>>>>> connected to 425c1b223dac ("PCI: Add Virtual Channel to save/restor=
e
>>>>>> support").
>>>>>>
>>>>>> I'd like to dig into that a bit more to see if there are any clues.
>>>>>> AFAIK Linux itself still doesn't use VC at all, and 425c1b223dac ad=
ded
>>>>>> a fair bit of code.  I wonder if we're restoring something out of
>>>>>> order or making some simple mistake in the way to restore VC config=
.
>>>>> I don't really have any faith in that bisect report in commit
>>>>> c3e59ee4e766.  To double check I dug out the card from that commit,
>>>>> installed an old Fedora release so I could build kernel v3.13,
>>>>> pre-dating 425c1b223dac and tested triggering a bus reset both via
>>>>> setpci and by masking PM reset so that sysfs can trigger the bus res=
et
>>>>> path with the kernel save/restore code.  Both result in the system
>>>>> hanging when the device is accessed either restoring from the kernel
>>>>> bus reset or reading from the device after the setpci reset.  Thanks=
,
>>>>>
>>>>> Alex
>>>>>
