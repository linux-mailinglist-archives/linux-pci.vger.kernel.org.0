Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822E735AEFB
	for <lists+linux-pci@lfdr.de>; Sat, 10 Apr 2021 18:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhDJQGG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Apr 2021 12:06:06 -0400
Received: from mupuf.org ([167.71.42.210]:50896 "EHLO mupuf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234392AbhDJQGF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 10 Apr 2021 12:06:05 -0400
X-Greylist: delayed 857 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Apr 2021 12:06:05 EDT
Received: from [IPv6:2a01:4b00:86b9:100:3a72:2134:f4fb:f726] (unknown [IPv6:2a01:4b00:86b9:100:3a72:2134:f4fb:f726])
        by Neelix.spliet.org (Postfix) with ESMTPSA id 5964DF20111;
        Sat, 10 Apr 2021 16:51:29 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 Neelix.spliet.org 5964DF20111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spliet.org;
        s=default; t=1618069889;
        bh=k2lVuNhhyJZ9m1XrTo42m98YzGLcO7suMUeViVTMkQk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gBCPJoSz0yL9JpfaOx5UYCv5PCkdSVV0o2wQUAQVB0dP9ra1Tc7vfUTd4aVWQpHMn
         MvJ3ZE/ghE90wQGRwjiC0n5Bpg0AcZ41Ka2ibuOmkN7FQFSVst3xJK//ASD/P5dcpL
         iGNKsMJvNdcXp22p/zDect3Q+yFTZBVwNb55rEQQ=
Subject: Re: [Nouveau] [PATCH v2] ALSA: hda: Continue to probe when codec
 probe fails
To:     Karol Herbst <kherbst@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        nouveau <nouveau@lists.freedesktop.org>, tiwai@suse.com,
        open list <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mike Rapoport <rppt@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jaroslav Kysela <perex@perex.cz>
References: <20201214060621.1102931-1-kai.heng.feng@canonical.com>
 <20201216124726.2842197-1-kai.heng.feng@canonical.com>
 <s5h5z51oj12.wl-tiwai@suse.de>
 <CAAd53p6kORC1GsW5zt+=0=J5ki43iriO-OqtFvf5W67LWhyyhA@mail.gmail.com>
 <s5hzh2dn3oa.wl-tiwai@suse.de>
 <CAAd53p6Ef2zFX_t3y1c6O7BmHnxYGtGSfgzXAMQSom1ainWXzg@mail.gmail.com>
 <s5hsg85n2km.wl-tiwai@suse.de> <s5hmtydn0yg.wl-tiwai@suse.de>
 <CAAd53p6MMFh=HCNF9pyrJc9hVMZWFe7_8MvBcBHVWARqHU_TTA@mail.gmail.com>
 <s5h7dpfk06y.wl-tiwai@suse.de>
 <CAAd53p53w0H6tsb4JgQtFTkYinniicTYBs2uk7tc=heP2dM_Cw@mail.gmail.com>
 <CAKb7UvjWX7xbwMKtnad5EVy16nY1M-A13YJeRWyUwHzemcVswA@mail.gmail.com>
 <CAAd53p4=bSX26QzsPyV1sxADiuVn2sowWyb5JFDoPZQ+ZYoCzA@mail.gmail.com>
 <CACO55tsPx_UC3OPf9Hq9sGdnZg9jH1+B0zOi6EAxTZ13E1tf7A@mail.gmail.com>
From:   Roy Spliet <nouveau@spliet.org>
Message-ID: <d01e375f-bf16-a005-ec66-0910956cc616@spliet.org>
Date:   Sat, 10 Apr 2021 16:51:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CACO55tsPx_UC3OPf9Hq9sGdnZg9jH1+B0zOi6EAxTZ13E1tf7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A
        autolearn=unavailable autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on Neelix
X-Virus-Scanned: clamav-milter 0.103.2 at Neelix
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reviving this thread as we have another user (rightfully) complaining on 
IRC about this.

The way I see it there's two issues:
1) snd_hda_intel not allowing runpm (or w/e vgaswitcheroo needs) when 
there's missing codecs, inhibiting the entire GPU from performing runpm. 
This needlessly wastes lots of battery power.
2) HDMI audio not working on such machines unless it was plugged in at 
boot-time.

The original workarounds proposed by Kai-Heng seem to fix 1), which is 
progress. I don't see a reason why that should be held off even if it 
doesn't fix 2).
To fix 2), more work is needed. On a high level, I suspect nouveau 
should start controlling the enabling/disabling of the HDA controller 
based on connector events and/or connector state at module load. 
Currently the PCI quirk seems to enable it wholesale, and I don't know 
why. If no GPU driver is loaded, it's pointless to turn the HDA device 
on. The blob presumably doesn't need this either, as it can control the 
device just as well as nouveau. If it doesn't, NVIDIA should fix it 
rather than rely on this quirk. The only reason I can think of is that 
snd_hda_intel or vgaswitcheroo isn't prepared for hot(un)plugging (or 
alternatively reprobing) devices. Without that, we presumably won't 
solve issue 2). Can I ask someone with more technical knowledge of 
snd_hda_intel and vgaswitcheroo to brainstorm about the possible 
challenges of nouveau taking matters into its own hand rather than 
keeping this PCI quirk around?

Roy

Op 04-01-2021 om 13:20 schreef Karol Herbst:
> On Tue, Dec 22, 2020 at 3:50 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>>
>> On Tue, Dec 22, 2020 at 1:56 AM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>>>
>>> On Mon, Dec 21, 2020 at 11:33 AM Kai-Heng Feng
>>> <kai.heng.feng@canonical.com> wrote:
>>>>
>>>> [+Cc nouveau]
>>>>
>>>> On Fri, Dec 18, 2020 at 4:06 PM Takashi Iwai <tiwai@suse.de> wrote:
>>>> [snip]
>>>>>> Quite possibly the system doesn't power up HDA controller when there's
>>>>>> no external monitor.
>>>>>> So when it's connected to external monitor, it's still needed for HDMI audio.
>>>>>> Let me ask the user to confirm this.
>>>>>
>>>>> Yeah, it's the basic question whether the HD-audio is supposed to work
>>>>> on this machine at all.  If yes, the current approach we take makes
>>>>> less sense - instead we should rather make the HD-audio controller
>>>>> working.
>>>>
>>>> Yea, confirmed that the Nvidia HDA works when HDMI is connected prior boot.
>>>>
>>>>>>> - The second problem is that pci_enable_device() ignores the error
>>>>>>>    returned from pci_set_power_state() if it's -EIO.  And the
>>>>>>>    inaccessible access error returns -EIO, although it's rather a fatal
>>>>>>>    problem.  So the driver believes as the PCI device gets enabled
>>>>>>>    properly.
>>>>>>
>>>>>> This was introduced in 2005, by Alan's 11f3859b1e85 ("[PATCH] PCI: Fix
>>>>>> regression in pci_enable_device_bars") to fix UHCI controller.
>>>>>>
>>>>>>>
>>>>>>> - The third problem is that HD-audio driver blindly believes the
>>>>>>>    codec_mask read from the register even if it's a read failure as I
>>>>>>>    already showed.
>>>>>>
>>>>>> This approach has least regression risk.
>>>>>
>>>>> Yes, but it assumes that HD-audio is really non-existent.
>>>>
>>>> I really don't know any good approach to address this.
>>>> On Windows, HDA PCI is "hidden" until HDMI cable is plugged, then the
>>>> driver will flag the magic bit to make HDA audio appear on the PCI
>>>> bus.
>>>> IIRC the current approach is to make nouveau and device link work.
>>>
>>> I don't have the full context of this discussion, but the kernel
>>> force-enables the HDA subfunction nowadays, irrespective of nouveau or
>>> nvidia or whatever:
>>
>> That's the problem.
>>
>> The nvidia HDA controller on the affected system only gets its power
>> after HDMI cable plugged, so the probe on boot fails.
>>
> 
> it might be that the code to enable the sub function is a bit broken
> :/ but it should work. Maybe the quirk_nvidia_hda function needs to be
> called on more occasions? No idea.
> 
>> Kai-Heng
>>
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/quirks.c?h=v5.10#n5267
>>>
>>> Cheers,
>>>
>>>    -ilia
>> _______________________________________________
>> Nouveau mailing list
>> Nouveau@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/nouveau
>>
> 
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
> 
