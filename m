Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E64C23559D
	for <lists+linux-pci@lfdr.de>; Sun,  2 Aug 2020 07:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgHBF6m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Aug 2020 01:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgHBF6m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Aug 2020 01:58:42 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0AEC06174A;
        Sat,  1 Aug 2020 22:58:41 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j8so23172194ioe.9;
        Sat, 01 Aug 2020 22:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m3t3RNk/1onNft0zrB9q4E9lIMyfRkyT8V1CJuWlqX4=;
        b=i1/pwa8JSJ6Ns70X4ySb2bv5vd7X/uTyhIfgoZ021IHWci/vvy+RHgDK5krf8J7D7q
         1v4jX0PeZAu7EbjPM/ObCNR8k+IwxfWsry+WgFJgcjRuEwWmGmdX/i1NXCqzcdI1+Rnt
         uV899uWM9mw4BF37uKTuoEgGPKjILzSdGVWTdi2oswYLIL3nV0S2CBYFvLU2PDvxDcXh
         i74XLBtFtGVF7qM05BPNosP8WPnGJXwLgSz5sinS8rQRFNIVPG/44/b4DfRKzRRcuCI5
         s/6QNOgJucDsrVxJJAgqjcawnsf8zFP+Ts+M+kFsReXA9fM4RVmKbkmueiJ2BIiTEOdT
         zwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m3t3RNk/1onNft0zrB9q4E9lIMyfRkyT8V1CJuWlqX4=;
        b=SqXrOdjd+nmith/KVBLPLZJmjOGjkWluKNHXcEy3tP/o83hxe3R3kKKxCigfOStJ76
         Pc7hs50+HZ3LoiWjqdgVaG1940ynfPuGjg30+/uFVrla7pk1oEFhczUhQ5XjL4J2XJfJ
         zWWSmXKVALcb89X2vDM3QQX380BRjkQan+bpFMdKeqW3E/kKxBVNJ0uiurOv59bzksL7
         vhV0Gr+1A6bzPqaDSWvrs6KrFfHWgHO2Z9tk7RUMbWcqawbNMB601X5VCCE+Ybg0YuQ1
         +zcDO0nLPvKa5Z+ECFanL8L0S1n8uIeXVwmBEu40nxHKJxvwcuZZTCv6qG/Cnjn+Vssq
         spcw==
X-Gm-Message-State: AOAM531z4VLiPdSVUtLHLRI7MCyr6s2rjVe80Fio37da77TSXgUQfGWe
        /Re/obhzJgxP/3k4mDAhlBwLrvN3OI1Elwpu/u8=
X-Google-Smtp-Source: ABdhPJzi1KOHlidCDADPjx+ro4rQhHpKG7SNvlCKpT1tLcQmL1RQ7yk41Zz5dzr3XtxS6Cf9/WzSD7BZOFVDkYNd5XA=
X-Received: by 2002:a05:6602:2549:: with SMTP id j9mr10776881ioe.89.1596347921017;
 Sat, 01 Aug 2020 22:58:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:9bd8:0:0:0:0:0 with HTTP; Sat, 1 Aug 2020 22:58:40 -0700 (PDT)
In-Reply-To: <CAFjuqNgAxTjHMw9AX+yoHxug-+hHVExsiccWG6eb=QZJsV3fSQ@mail.gmail.com>
References: <20191029170250.GA43972@google.com> <20200222165617.GA207731@google.com>
 <CAPDyKFq_exHufHyibFCjS78PTZ7duS9ZSt3vi18CNM6+jMmwnw@mail.gmail.com>
 <20200226011310.GA2116625@rani.riverdale.lan> <CAFjuqNg_NW7hcssWmMTtt=ioY143qn76ooT7GRhxEEe9ZVCqeQ@mail.gmail.com>
 <6e9db1f6-60c4-872b-c7c8-96ee411aa3ca@aol.com> <20200226045104.GA2191053@rani.riverdale.lan>
 <20200225212054.09865e0b@fido6> <CAFjuqNh8ja3maOFev4S9zOSi04yAvnyEo2GTTxjr1pbQvmAW=A@mail.gmail.com>
 <edab20f582d4402baeca9bb80e612ee2@willitsonline.com> <CAFjuqNgAxTjHMw9AX+yoHxug-+hHVExsiccWG6eb=QZJsV3fSQ@mail.gmail.com>
From:   "Michael ." <keltoiboy@gmail.com>
Date:   Sun, 2 Aug 2020 15:58:40 +1000
Message-ID: <CAFjuqNi09cHvJLesYSRdgScFx4yBouJ3+QROzoFH5OETy-uNBg@mail.gmail.com>
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not working
 on Panasonic Toughbook CF-29]
To:     bluerocksaddles@willitsonline.com
Cc:     Philip Langdale <philipl@overt.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Trevor Jacobs <trevor_jacobs@aol.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Morgan Klym <moklym@gmail.com>,
        Pierre Ossman <pierre@ossman.eu>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Have just had confirmation that the mmc_ricoh_mmc change works and
both PCMCIA slots now work as intended on Panasonic Toughbook CF-29 Mk
4 and 5.

Thank you to all who have made suggestions for this, your dedication
to Linux is amazing and your help with this is appreciated.

Stay safe.
Michael.

On 28/07/2020, Michael . <keltoiboy@gmail.com> wrote:
> I have just compiled and uploaded a kernel to test for this issue,
> members of the Toughbook community have been provided with the link,
> though a forum discussion, to download the kernel and test it.
> Hopefully we will get positive results and can confirm the
> MMC_RICOH_MMC flag is the culprit.
> Regards.
> Stay safe.
> Michael.
>
> On 27/02/2020, bluerocksaddles@willitsonline.com
> <bluerocksaddles@willitsonline.com> wrote:
>> Somewhere in these messages is a clue....in that SD reader was involved.
>>
>> MK 4 and 5 have SD whilst MK 1, 2 and three do not.
>>
>>
>>
>> On 2020-02-25 22:10, Michael . wrote:
>>>> Someone with access to real hardware could
>>>> easily experiment with changing that magic value and seeing if it
>>>> changes which function is disabled.
>>>
>>> One of our members has offered to supply a machine to a dev that can
>>> use it to test any theory.
>>>
>>> It is nearly beyond the scope of the majority of us to do much more
>>> than just testing. We appreciate all the effort the devs put in and
>>> are willing to help in anyway we can but we aren't kernel devs.
>>>
>>> I, personally, use Debian. Others use Debian based distros such as MX
>>> and Mint. We have been able to test many different distros such as
>>> those listed in other comments but don't have the skills or expertise
>>> to do much more. It is our hope that this discussion and subsequent
>>> effort may enable others who prefer distros other than Debian based
>>> distros can use a CF-29 (and possibly earlier) Toughbook with the
>>> distro of their choice without having to rebuild a kernel so they can
>>> use hardware that worked back in 2010. To do this the fix needs to be
>>> at the kernel dev level not a local enthusiast level because while I
>>> can rebuild a Debian kernel I can't rebuild a Fedora or Arch or
>>> Slackware kernel.
>>>
>>> I did a search about this issue before I made initial contact late
>>> last year and the issue was discovered on more than Toughbooks and
>>> posted about on various sites not long after distros moved from
>>> 2.6.32. It seems back then people just got new machines that didn't
>>> have a 2nd slot so the search for an answer stopped. Us Toughbook
>>> users are a loyal group we use our machines because they are exactly
>>> what we need and they take alot of "punishment" taht other machines
>>> simply cannot handle. Our machines are used rather than recycled or
>>> worse still just left to sit in waste management facilities in a
>>> country that the western world dumps its rubbish in, we are Linux and
>>> Toughbook enthusiasts and hope to be able to keep our machines running
>>> for many years to come with all their native capabilities working as
>>> they were designed to but using a modern Linux instead of Windows XP
>>> or Windows 7. (that wasn't a pep talk, its just an explanation of why
>>> we are passionate about this).
>>>
>>> Let us know what you need us to do, we will let you know if we are
>>> capable of it and give you any feedback you ask for. Over the weekend
>>> I will try to rebuild a Debian kernel with the relevant option
>>> disabled, provide it to my peers for testing and report back here what
>>> the outcome is.
>>>
>>> Thank you all for all your time and effort, it is truly appreciated.
>>> Cheers.
>>> Michael.
>>>
>>> On 26/02/2020, Philip Langdale <philipl@overt.org> wrote:
>>>> On Tue, 25 Feb 2020 23:51:05 -0500
>>>> Arvind Sankar <nivedita@alum.mit.edu> wrote:
>>>>
>>>>> On Tue, Feb 25, 2020 at 09:12:48PM -0600, Trevor Jacobs wrote:
>>>>> > That's correct, I tested a bunch of the old distros including
>>>>> > slackware, and 2.6.32 is where the problem began.
>>>>> >
>>>>> > Also, the Panasonic Toughbook CF-29s effected that we tested are
>>>>> > the later marks, MK4 and MK5 for certain. The MK2 CF-29 worked just
>>>>> > fine because it has different hardware supporting the PCMCIA slots.
>>>>> > I have not tested a MK3 but suspect it would work ok as it also
>>>>> > uses the older hardware.
>>>>> >
>>>>> > Thanks for your help guys!
>>>>> > Trevor
>>>>> >
>>>>>
>>>>> Right, the distros probably all enabled MMC_RICOH_MMC earlier than
>>>>> upstream. Can you test a custom kernel based off your distro kernel
>>>>> but just disabling that config option? That's probably the easiest
>>>>> fix
>>>>> currently, even though not ideal. Perhaps there should be a command
>>>>> line option to disable specific pci quirks to make this easier.
>>>>>
>>>>> An ideal fix is I feel hard, given this quirk is based on
>>>>> undocumented
>>>>> config registers -- it worked on Dell machines (that's where the
>>>>> original authors seem to have gotten their info from), perhaps they
>>>>> had only one Cardbus slot, but the code ends up disabling your second
>>>>> Cardbus slot instead of disabling the MMC controller.
>>>>
>>>> Keeping in mind that this was 12+ years ago, you can at least still
>>>> read the original discussion in the archives. My original Dell laptop
>>>> (XPS m1330) had no cardbus slots at all, and used the r5c832
>>>> controller. There was a subsequent change that I was not involved with
>>>> which added support for the rl5c476, which is the problematic device
>>>> in
>>>> this thread.
>>>>
>>>> As a hypothesis, based on the observed behaviour, the quirk (keeping
>>>> in
>>>> mind that these are magic configuration register values that are not
>>>> documented) probably disabled function 1, regardless of what it is,
>>>> and
>>>> the original example that motivated adding the rl5c476 quirk probably
>>>> had one cardbus slot and the card reader functions were all moved up
>>>> one, or something along those lines.
>>>>
>>>> Truly making this smart would then involve having the code enumerate
>>>> the pci functions and identify the one that is the unwanted mmc
>>>> controller, based on function ID or class or whatever, and then
>>>> disabling that (assuming the magic can be reverse engineered: eg, the
>>>> current magic ORs the disable flag with 0x02 - chances are, that's the
>>>> index of the function: 0x01 would be the 0th function, 0x04 would be
>>>> the 2nd function, etc). Someone with access to real hardware could
>>>> easily experiment with changing that magic value and seeing if it
>>>> changes which function is disabled.
>>>>
>>>> Good luck.
>>>>
>>>> --phil
>>>>
>>
>
