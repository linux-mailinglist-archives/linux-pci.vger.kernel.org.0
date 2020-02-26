Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9718E16F7D9
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 07:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgBZGKb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 01:10:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42598 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgBZGKa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2020 01:10:30 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so1901157otd.9;
        Tue, 25 Feb 2020 22:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ifn+NNyVN913MBeGM2/bu4dOZv1ZXnQnqRtnV2d3aEw=;
        b=IY9HnMtvY3wXhhQJbieZobipuz04B0Ra7f89lDEI0yJWXsPT7mwgBdww5zWTapZK/J
         eU6cNJrJwjzbvqRxAiFnV/MiThWF0fPx2TEGVcxME2GJtRF1uZq+9pg7ypG5tLxiehkc
         mw2jUsBURHa0CoeGQ8PXcuIo4JlAFUUfRXYiuTv1OIOOGu47BLCxSQVAlsumu7m/DH1z
         TfuDeFfyruJePPCf0V1PJJcmdcLEpMh1IfJwsZU9ldhjBeBkRTdJNDUNZpWNMKirv2KF
         On9JeAGtJyUzLDAFeXxGyQwjHrA9gzbxaoh7c+3CbVuDrEviHXgyqj6OXqvu9PG5DAwr
         nT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ifn+NNyVN913MBeGM2/bu4dOZv1ZXnQnqRtnV2d3aEw=;
        b=AtfBjGsqevF8zaPwJU6n5FGcCq48X3oRhKqOLmMWENyw1ctTIPN+c3zow7f89BGWaR
         G3mte1XPLIoOVaMle5vMq9bT/X0dGklyn6GXzP8ypmfShvFSworgZC35UgNkHBJTpRC7
         YWFtUQ0Ko/eImOkOEjmAp/dhgBBZ8Zi7HeL4lYJlfS+ERLBkCyE85LTk7xy0VZDbGu4R
         nMs5KV49/qjiOszdhW0wLzg9MLR6zoYvkH8mJl2AyccKlQeDoOE3ffMBneZayvF0u96b
         9INfX28Rr115lKLewsDfUpMm8cyIoqHGBHDmktuU42GJM3kOQRB8mOS1+KqgqjgcLpUL
         zmGQ==
X-Gm-Message-State: APjAAAWCIVgnn5c8XDf0eu9YwiveQ8GmktO3wWKWLiNu5ysy8iduZNzA
        E2je20tM0fl3HRx4ES9g60zyalMtXJy0yCSL1oY=
X-Google-Smtp-Source: APXvYqxNlkFs8lRBsGBBItMATzlZD49iescGEtIRwUTubSnT+FL5F2jXAbkjNGyRIDlEWQG0QuSxjigszvvsAK77cbY=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr1624035otk.89.1582697428768;
 Tue, 25 Feb 2020 22:10:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:74d9:0:0:0:0:0 with HTTP; Tue, 25 Feb 2020 22:10:28
 -0800 (PST)
In-Reply-To: <20200225212054.09865e0b@fido6>
References: <20191029170250.GA43972@google.com> <20200222165617.GA207731@google.com>
 <CAPDyKFq_exHufHyibFCjS78PTZ7duS9ZSt3vi18CNM6+jMmwnw@mail.gmail.com>
 <20200226011310.GA2116625@rani.riverdale.lan> <CAFjuqNg_NW7hcssWmMTtt=ioY143qn76ooT7GRhxEEe9ZVCqeQ@mail.gmail.com>
 <6e9db1f6-60c4-872b-c7c8-96ee411aa3ca@aol.com> <20200226045104.GA2191053@rani.riverdale.lan>
 <20200225212054.09865e0b@fido6>
From:   "Michael ." <keltoiboy@gmail.com>
Date:   Wed, 26 Feb 2020 17:10:28 +1100
Message-ID: <CAFjuqNh8ja3maOFev4S9zOSi04yAvnyEo2GTTxjr1pbQvmAW=A@mail.gmail.com>
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not working
 on Panasonic Toughbook CF-29]
To:     Philip Langdale <philipl@overt.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Trevor Jacobs <trevor_jacobs@aol.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>,
        Morgan Klym <moklym@gmail.com>,
        Pierre Ossman <pierre@ossman.eu>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>Someone with access to real hardware could
>easily experiment with changing that magic value and seeing if it
>changes which function is disabled.

One of our members has offered to supply a machine to a dev that can
use it to test any theory.

It is nearly beyond the scope of the majority of us to do much more
than just testing. We appreciate all the effort the devs put in and
are willing to help in anyway we can but we aren't kernel devs.

I, personally, use Debian. Others use Debian based distros such as MX
and Mint. We have been able to test many different distros such as
those listed in other comments but don't have the skills or expertise
to do much more. It is our hope that this discussion and subsequent
effort may enable others who prefer distros other than Debian based
distros can use a CF-29 (and possibly earlier) Toughbook with the
distro of their choice without having to rebuild a kernel so they can
use hardware that worked back in 2010. To do this the fix needs to be
at the kernel dev level not a local enthusiast level because while I
can rebuild a Debian kernel I can't rebuild a Fedora or Arch or
Slackware kernel.

I did a search about this issue before I made initial contact late
last year and the issue was discovered on more than Toughbooks and
posted about on various sites not long after distros moved from
2.6.32. It seems back then people just got new machines that didn't
have a 2nd slot so the search for an answer stopped. Us Toughbook
users are a loyal group we use our machines because they are exactly
what we need and they take alot of "punishment" taht other machines
simply cannot handle. Our machines are used rather than recycled or
worse still just left to sit in waste management facilities in a
country that the western world dumps its rubbish in, we are Linux and
Toughbook enthusiasts and hope to be able to keep our machines running
for many years to come with all their native capabilities working as
they were designed to but using a modern Linux instead of Windows XP
or Windows 7. (that wasn't a pep talk, its just an explanation of why
we are passionate about this).

Let us know what you need us to do, we will let you know if we are
capable of it and give you any feedback you ask for. Over the weekend
I will try to rebuild a Debian kernel with the relevant option
disabled, provide it to my peers for testing and report back here what
the outcome is.

Thank you all for all your time and effort, it is truly appreciated.
Cheers.
Michael.

On 26/02/2020, Philip Langdale <philipl@overt.org> wrote:
> On Tue, 25 Feb 2020 23:51:05 -0500
> Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
>> On Tue, Feb 25, 2020 at 09:12:48PM -0600, Trevor Jacobs wrote:
>> > That's correct, I tested a bunch of the old distros including
>> > slackware, and 2.6.32 is where the problem began.
>> >
>> > Also, the Panasonic Toughbook CF-29s effected that we tested are
>> > the later marks, MK4 and MK5 for certain. The MK2 CF-29 worked just
>> > fine because it has different hardware supporting the PCMCIA slots.
>> > I have not tested a MK3 but suspect it would work ok as it also
>> > uses the older hardware.
>> >
>> > Thanks for your help guys!
>> > Trevor
>> >
>>
>> Right, the distros probably all enabled MMC_RICOH_MMC earlier than
>> upstream. Can you test a custom kernel based off your distro kernel
>> but just disabling that config option? That's probably the easiest fix
>> currently, even though not ideal. Perhaps there should be a command
>> line option to disable specific pci quirks to make this easier.
>>
>> An ideal fix is I feel hard, given this quirk is based on undocumented
>> config registers -- it worked on Dell machines (that's where the
>> original authors seem to have gotten their info from), perhaps they
>> had only one Cardbus slot, but the code ends up disabling your second
>> Cardbus slot instead of disabling the MMC controller.
>
> Keeping in mind that this was 12+ years ago, you can at least still
> read the original discussion in the archives. My original Dell laptop
> (XPS m1330) had no cardbus slots at all, and used the r5c832
> controller. There was a subsequent change that I was not involved with
> which added support for the rl5c476, which is the problematic device in
> this thread.
>
> As a hypothesis, based on the observed behaviour, the quirk (keeping in
> mind that these are magic configuration register values that are not
> documented) probably disabled function 1, regardless of what it is, and
> the original example that motivated adding the rl5c476 quirk probably
> had one cardbus slot and the card reader functions were all moved up
> one, or something along those lines.
>
> Truly making this smart would then involve having the code enumerate
> the pci functions and identify the one that is the unwanted mmc
> controller, based on function ID or class or whatever, and then
> disabling that (assuming the magic can be reverse engineered: eg, the
> current magic ORs the disable flag with 0x02 - chances are, that's the
> index of the function: 0x01 would be the 0th function, 0x04 would be
> the 2nd function, etc). Someone with access to real hardware could
> easily experiment with changing that magic value and seeing if it
> changes which function is disabled.
>
> Good luck.
>
> --phil
>
