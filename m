Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18A117090D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 20:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgBZTqx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 14:46:53 -0500
Received: from mail.willitsonline.com ([216.7.65.54]:56263 "EHLO
        mail.willitsonline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbgBZTqx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2020 14:46:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.willitsonline.com (Postfix) with ESMTP id 91AC3111D8C
        for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2020 11:46:52 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at iredmail2.willitsonline.com
Received: from mail.willitsonline.com ([127.0.0.1])
        by localhost (iredmail2.willitsonline.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I4jTN0plhFCj for <linux-pci@vger.kernel.org>;
        Wed, 26 Feb 2020 11:46:52 -0800 (PST)
Received: from _ (localhost.localdomain [127.0.0.1])
        (Authenticated sender: bluerocksaddles@willitsonline.com)
        by mail.willitsonline.com (Postfix) with ESMTPSA id AF76A111D7A;
        Wed, 26 Feb 2020 11:46:36 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Feb 2020 11:46:36 -0800
From:   bluerocksaddles@willitsonline.com
To:     "Michael ." <keltoiboy@gmail.com>
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
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not working
 on Panasonic Toughbook CF-29]
In-Reply-To: <CAFjuqNh8ja3maOFev4S9zOSi04yAvnyEo2GTTxjr1pbQvmAW=A@mail.gmail.com>
References: <20191029170250.GA43972@google.com>
 <20200222165617.GA207731@google.com>
 <CAPDyKFq_exHufHyibFCjS78PTZ7duS9ZSt3vi18CNM6+jMmwnw@mail.gmail.com>
 <20200226011310.GA2116625@rani.riverdale.lan>
 <CAFjuqNg_NW7hcssWmMTtt=ioY143qn76ooT7GRhxEEe9ZVCqeQ@mail.gmail.com>
 <6e9db1f6-60c4-872b-c7c8-96ee411aa3ca@aol.com>
 <20200226045104.GA2191053@rani.riverdale.lan>
 <20200225212054.09865e0b@fido6>
 <CAFjuqNh8ja3maOFev4S9zOSi04yAvnyEo2GTTxjr1pbQvmAW=A@mail.gmail.com>
Message-ID: <edab20f582d4402baeca9bb80e612ee2@willitsonline.com>
X-Sender: bluerocksaddles@willitsonline.com
User-Agent: Roundcube Webmail
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Somewhere in these messages is a clue....in that SD reader was involved.

MK 4 and 5 have SD whilst MK 1, 2 and three do not.



On 2020-02-25 22:10, Michael . wrote:
>> Someone with access to real hardware could
>> easily experiment with changing that magic value and seeing if it
>> changes which function is disabled.
> 
> One of our members has offered to supply a machine to a dev that can
> use it to test any theory.
> 
> It is nearly beyond the scope of the majority of us to do much more
> than just testing. We appreciate all the effort the devs put in and
> are willing to help in anyway we can but we aren't kernel devs.
> 
> I, personally, use Debian. Others use Debian based distros such as MX
> and Mint. We have been able to test many different distros such as
> those listed in other comments but don't have the skills or expertise
> to do much more. It is our hope that this discussion and subsequent
> effort may enable others who prefer distros other than Debian based
> distros can use a CF-29 (and possibly earlier) Toughbook with the
> distro of their choice without having to rebuild a kernel so they can
> use hardware that worked back in 2010. To do this the fix needs to be
> at the kernel dev level not a local enthusiast level because while I
> can rebuild a Debian kernel I can't rebuild a Fedora or Arch or
> Slackware kernel.
> 
> I did a search about this issue before I made initial contact late
> last year and the issue was discovered on more than Toughbooks and
> posted about on various sites not long after distros moved from
> 2.6.32. It seems back then people just got new machines that didn't
> have a 2nd slot so the search for an answer stopped. Us Toughbook
> users are a loyal group we use our machines because they are exactly
> what we need and they take alot of "punishment" taht other machines
> simply cannot handle. Our machines are used rather than recycled or
> worse still just left to sit in waste management facilities in a
> country that the western world dumps its rubbish in, we are Linux and
> Toughbook enthusiasts and hope to be able to keep our machines running
> for many years to come with all their native capabilities working as
> they were designed to but using a modern Linux instead of Windows XP
> or Windows 7. (that wasn't a pep talk, its just an explanation of why
> we are passionate about this).
> 
> Let us know what you need us to do, we will let you know if we are
> capable of it and give you any feedback you ask for. Over the weekend
> I will try to rebuild a Debian kernel with the relevant option
> disabled, provide it to my peers for testing and report back here what
> the outcome is.
> 
> Thank you all for all your time and effort, it is truly appreciated.
> Cheers.
> Michael.
> 
> On 26/02/2020, Philip Langdale <philipl@overt.org> wrote:
>> On Tue, 25 Feb 2020 23:51:05 -0500
>> Arvind Sankar <nivedita@alum.mit.edu> wrote:
>> 
>>> On Tue, Feb 25, 2020 at 09:12:48PM -0600, Trevor Jacobs wrote:
>>> > That's correct, I tested a bunch of the old distros including
>>> > slackware, and 2.6.32 is where the problem began.
>>> >
>>> > Also, the Panasonic Toughbook CF-29s effected that we tested are
>>> > the later marks, MK4 and MK5 for certain. The MK2 CF-29 worked just
>>> > fine because it has different hardware supporting the PCMCIA slots.
>>> > I have not tested a MK3 but suspect it would work ok as it also
>>> > uses the older hardware.
>>> >
>>> > Thanks for your help guys!
>>> > Trevor
>>> >
>>> 
>>> Right, the distros probably all enabled MMC_RICOH_MMC earlier than
>>> upstream. Can you test a custom kernel based off your distro kernel
>>> but just disabling that config option? That's probably the easiest 
>>> fix
>>> currently, even though not ideal. Perhaps there should be a command
>>> line option to disable specific pci quirks to make this easier.
>>> 
>>> An ideal fix is I feel hard, given this quirk is based on 
>>> undocumented
>>> config registers -- it worked on Dell machines (that's where the
>>> original authors seem to have gotten their info from), perhaps they
>>> had only one Cardbus slot, but the code ends up disabling your second
>>> Cardbus slot instead of disabling the MMC controller.
>> 
>> Keeping in mind that this was 12+ years ago, you can at least still
>> read the original discussion in the archives. My original Dell laptop
>> (XPS m1330) had no cardbus slots at all, and used the r5c832
>> controller. There was a subsequent change that I was not involved with
>> which added support for the rl5c476, which is the problematic device 
>> in
>> this thread.
>> 
>> As a hypothesis, based on the observed behaviour, the quirk (keeping 
>> in
>> mind that these are magic configuration register values that are not
>> documented) probably disabled function 1, regardless of what it is, 
>> and
>> the original example that motivated adding the rl5c476 quirk probably
>> had one cardbus slot and the card reader functions were all moved up
>> one, or something along those lines.
>> 
>> Truly making this smart would then involve having the code enumerate
>> the pci functions and identify the one that is the unwanted mmc
>> controller, based on function ID or class or whatever, and then
>> disabling that (assuming the magic can be reverse engineered: eg, the
>> current magic ORs the disable flag with 0x02 - chances are, that's the
>> index of the function: 0x01 would be the 0th function, 0x04 would be
>> the 2nd function, etc). Someone with access to real hardware could
>> easily experiment with changing that magic value and seeing if it
>> changes which function is disabled.
>> 
>> Good luck.
>> 
>> --phil
>> 
