Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E6B27D388
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 18:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgI2QXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 12:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgI2QXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 12:23:20 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E24C061755
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 09:23:20 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z13so5419578iom.8
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 09:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3PHApNtvko5cx0mu84BJB//gjJ/yB/iYxrN5viWBTiI=;
        b=J3psSTG0HgG8pbrTMPmdjVZpfiQGNMNmnDQZu4Dmu8WUwuh+kXo3qD6b4Gku8eVZUX
         OWGOZ+oJsbp9Yd5uTXe0ElJDjB6ftutk1aGClnreDXOI8+oI4QhBRxvfTeuvbLSQtb/P
         SUgop4T8e3Ny0Yx6UJkaWYLuPa3y5b5pTE7VbcO2UeMgEuwhqjGuMqtlP0WLwxgjcfAW
         U3b4hJKSG5vTjMtHy41DOWAm1oeryn94Njb/jUB8jqJyEbx3I0Rwy/qXTA5ue/uaqTEi
         gBx0jsl+5VySIERF4s2MbwYgooMmWM4WNp9Ig3c4Xjnn5uat2bcLFIvOcyqD1/pwq3/Q
         QVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3PHApNtvko5cx0mu84BJB//gjJ/yB/iYxrN5viWBTiI=;
        b=pdGLuLzky+cd9j4FrMipXC17dsAuLlYZ/GkZocPcFblJ3E5EpU2hJVGtBTqm92y9eK
         xR2P2TlM2tMFDOVs5sUD9RS/8GTXD4fm4hyMP9eoUPbe/3N9A/EAlO4pEx0MMa3Zp8II
         MdY8zDE3Xmd2IDCDFevA88V0k9LpEQYiPXgyWKvJkExjaDyzZO3N51ciADTOufdavEWf
         G+uW7gk1Ngk8eyn8Bm+LZGchamPkAolJxooBl5//4WY5VsIZhdMxod1gMC615W1BD8NR
         jipsPdUz/qjMwZO3C4F/n7ui/dvyPn4c9+18W0EBgT8Wlzp0V5RVxWiSn12naYp8b7yo
         QJAw==
X-Gm-Message-State: AOAM532WNwUoBUHPKzOYFLV4IB4Wzjz1vElafjtBgNQPIwBgK+2j/Iml
        SK5uXkQ4NpR1v4QOqUt7n6WThLDEQsWdOa3d98Q=
X-Google-Smtp-Source: ABdhPJy/SyKDpMuQAOTHWkFRtlsxcWeZTiOOhaXKqJPY2SrozK/jDEWcoTR/vP7VxW6/Nvxh+jGKig3k1trHQCUaGpI=
X-Received: by 2002:a5e:8f4c:: with SMTP id x12mr3125071iop.38.1601396599453;
 Tue, 29 Sep 2020 09:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZuexf2pqfHBCKKGRos8psg_6ZZFeXiFm3ncPz-6JtqEdQ@mail.gmail.com>
 <20200928170921.GA2485236@bjorn-Precision-5520> <CAA85sZuDVA1d_c7OQ3xyZiOVDneL6oN6bM-Sn2QfhfGAAoHhYg@mail.gmail.com>
 <CAKgT0UcQN77zrtRK8yKgNRR0pifGUceoRHXWW+cYukzmsQPNyQ@mail.gmail.com>
 <CAA85sZt7LQ0NrWFnR-fk0s+jqsO9FxsYiu4JavnH6V423Rba1w@mail.gmail.com>
 <CAA85sZuW4iy6hXEKrfQjLV-nmG-E8pe0joZpMSb_vzs7Pnc=wA@mail.gmail.com>
 <CAKgT0UfvSBQX4U2f_Qe3qVH67Oo=eyyrFipjHU6b2e9jCE+8pg@mail.gmail.com> <CAA85sZvtMWyaOYx+GhQUy4+3+5MAWt3JP=ANJ2ggQu2ONrh4Wg@mail.gmail.com>
In-Reply-To: <CAA85sZvtMWyaOYx+GhQUy4+3+5MAWt3JP=ANJ2ggQu2ONrh4Wg@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 29 Sep 2020 09:23:07 -0700
Message-ID: <CAKgT0UfRKjOUSZfcVqJ1b2Pfv97_RkJy5=v=xyYrt8dJ-5RYkw@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 5:51 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Tue, Sep 29, 2020 at 1:31 AM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> >
> > On Mon, Sep 28, 2020 at 1:33 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > >
> > > On Mon, Sep 28, 2020 at 10:04 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > > >
> > > > On Mon, Sep 28, 2020 at 9:53 PM Alexander Duyck
> > > > <alexander.duyck@gmail.com> wrote:
> >
> > <snip>
> >
> > > > > You should be able to manually disable L1 on the realtek link
> > > > > (4:00.0<->2:04.0) instead of doing it on the upstream link on the
> > > > > switch. That may provide a datapoint on the L1 behavior of the setup.
> > > > > Basically if you took the realtek out of the equation in terms of the
> > > > > L1 exit time you should see the exit time drop to no more than 33us
> > > > > like what would be expected with just the i210.
> > > >
> > > > Yeah, will try it out with echo 0 >
> > > > /sys/devices/pci0000:00/0000:00:01.2/0000:01:00.0/0000:02:04.0/0000:04:00.0/link/l1_aspm
> > > > (which is the device reported by my patch)
> > >
> > > So, 04:00.0 is already disabled, the existing code apparently handled
> > > that correctly... *but*
> > >
> > > given the path:
> > > 00:01.2/01:00.0/02:04.0/04:00.0 Unassigned class [ff00]: Realtek
> > > Semiconductor Co., Ltd. Device 816e (rev 1a)
> > >
> > > Walking backwards:
> > > -- 04:00.0 has l1 disabled
> > > -- 02:04.0 doesn't have aspm?!
> > >
> > > lspci reports:
> > > Capabilities: [370 v1] L1 PM Substates
> > > L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+ L1_PM_Substates+
> > > L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
> > > L1SubCtl2:
> > > Capabilities: [400 v1] Data Link Feature <?>
> > > Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
> > > Capabilities: [440 v1] Lane Margining at the Receiver <?>
> > >
> > > However the link directory is empty.
> > >
> > > Anything we should know about these unknown capabilities? also aspm
> > > L1.1 and .1.2, heh =)
> > >
> > > -- 01:00.0 has L1, disabling it makes the intel nic work again
> >
> > I recall that much. However the question is why? If there is already a
> > 32us time to bring up the link between the NIC and the switch why
> > would the additional 1us to also bring up the upstream port have that
> > much of an effect? That is why I am thinking that it may be worthwhile
> > to try to isolate things further so that only the upstream port and
> > the NIC have L1 enabled. If we are still seeing issues in that state
> > then I can only assume there is something off with the
> > 00:01.2<->1:00.0 link to where it either isn't advertising the actual
> > L1 recovery time. For example the "Width x4 (downgraded)" looks very
> > suspicious and could be responsible for something like that if the
> > link training is having to go through exception cases to work out the
> > x4 link instead of a x8.
>
> It is a x4 link, all links that aren't "fully populated" or "fully
> utilized" are listed as downgraded...
>
> So, x16 card in x8 slot or pcie 3 card in pcie 2 slot - all lists as downgraded

Right, but when both sides say they are capable of x8 and are
reporting a x4 as is the case in the 00:01.2 <-> 01:00.0 link, that
raises some eyebrows as both sides say they are capable of x8 so it
makes me wonder if the lanes were only run for x4 and BIOS/firmware
wasn't configured correctly, or if only 4 of the lanes are working
resulting in a x4 due to an electrical issue:

00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse GPP Bridge (prog-if 00 [Normal decode])
LnkCap: Port #0, Speed 16GT/s, Width x8, ASPM L1, Exit Latency L1 <32us
LnkSta: Speed 16GT/s (ok), Width x4 (downgraded)

01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Matisse Switch
LnkCap: Port #0, Speed 16GT/s, Width x8, ASPM L1, Exit Latency L1 <32us
LnkSta: Speed 16GT/s (ok), Width x4 (downgraded)

I bring it up because in the past I have seen some NICs that start out
x4 and after a week with ASPM on and moderate activity end up dropping
to a x1 and eventually fall off the bus due to electrical issues on
the motherboard. I recall you mentioning that this has always
connected at no higher than x4, but I still don't know if that is by
design or simply because it cannot due to some other issue.

> > > ASPM L1 enabled:
> > > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > > [  5]   0.00-1.00   sec  5.40 MBytes  45.3 Mbits/sec    0   62.2 KBytes
> > > [  5]   1.00-2.00   sec  4.47 MBytes  37.5 Mbits/sec    0   70.7 KBytes
> > > [  5]   2.00-3.00   sec  4.10 MBytes  34.4 Mbits/sec    0   42.4 KBytes
> > > [  5]   3.00-4.00   sec  4.47 MBytes  37.5 Mbits/sec    0   65.0 KBytes
> > > [  5]   4.00-5.00   sec  4.47 MBytes  37.5 Mbits/sec    0    105 KBytes
> > > [  5]   5.00-6.00   sec  4.47 MBytes  37.5 Mbits/sec    0   84.8 KBytes
> > > [  5]   6.00-7.00   sec  4.47 MBytes  37.5 Mbits/sec    0   65.0 KBytes
> > > [  5]   7.00-8.00   sec  4.10 MBytes  34.4 Mbits/sec    0   45.2 KBytes
> > > [  5]   8.00-9.00   sec  4.47 MBytes  37.5 Mbits/sec    0   56.6 KBytes
> > > [  5]   9.00-10.00  sec  4.47 MBytes  37.5 Mbits/sec    0   48.1 KBytes
> > > - - - - - - - - - - - - - - - - - - - - - - - - -
> > > [ ID] Interval           Transfer     Bitrate         Retr
> > > [  5]   0.00-10.00  sec  44.9 MBytes  37.7 Mbits/sec    0             sender
> > > [  5]   0.00-10.01  sec  44.0 MBytes  36.9 Mbits/sec                  receiver
> > >
> > > ASPM L1 disabled:
> > > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > > [  5]   0.00-1.00   sec   111 MBytes   935 Mbits/sec  733    761 KBytes
> > > [  5]   1.00-2.00   sec   110 MBytes   923 Mbits/sec  733    662 KBytes
> > > [  5]   2.00-3.00   sec   109 MBytes   912 Mbits/sec  1036   1.20 MBytes
> > > [  5]   3.00-4.00   sec   109 MBytes   912 Mbits/sec  647    738 KBytes
> > > [  5]   4.00-5.00   sec   110 MBytes   923 Mbits/sec  852    744 KBytes
> > > [  5]   5.00-6.00   sec   109 MBytes   912 Mbits/sec  546    908 KBytes
> > > [  5]   6.00-7.00   sec   109 MBytes   912 Mbits/sec  303    727 KBytes
> > > [  5]   7.00-8.00   sec   109 MBytes   912 Mbits/sec  432    769 KBytes
> > > [  5]   8.00-9.00   sec   110 MBytes   923 Mbits/sec  462    652 KBytes
> > > [  5]   9.00-10.00  sec   109 MBytes   912 Mbits/sec  576    764 KBytes
> > > - - - - - - - - - - - - - - - - - - - - - - - - -
> > > [ ID] Interval           Transfer     Bitrate         Retr
> > > [  5]   0.00-10.00  sec  1.07 GBytes   918 Mbits/sec  6320             sender
> > > [  5]   0.00-10.01  sec  1.06 GBytes   912 Mbits/sec                  receiver
> > >
> > > (all measurements are over live internet - so thus variance)
> >
> > I forgot there were 5 total devices that were hanging off of there as
> > well. You might try checking to see if disabling L1 on devices 5:00.0,
> > 6:00.0 and/or 7:00.0 has any effect while leaving the L1 on 01:00.0
> > and the NIC active. The basic idea is to go through and make certain
> > we aren't seeing an L1 issue with one of the other downstream links on
> > the switch.
>
> I did, and i saw no change, only disabling L1 on 01:00.0 gives any effect.
> But i'd say you're right in your thinking - with L0s head-of-queue
> stalling can happen
> due to retry buffers and so on, was interesting to see it detailed...

Okay, so the issue then is definitely the use of L1 on the 00:01.2 <->
01:00.0 link. The only piece we don't have the answer to is why, which
is something we might only be able to answer if we had a PCIe
analyzer.

> > The more I think about it the entire setup for this does seem a bit
> > suspicious. I was looking over the lspci tree and the dump from the
> > system. From what I can tell the upstream switch link at 01.2 <->
> > 1:00.0 is only a Gen4 x4 link. However coming off of that is 5
> > devices, two NICs using either Gen1 or 2 at x1, and then a USB
> > controller and 2 SATA controller reporting Gen 4 x16. Specifically
> > those last 3 devices have me a bit curious as they are all reporting
> > L0s and L1 exit latencies that are the absolute minimum which has me
> > wondering if they are even reporting actual values.
>
> Heh, I have been trying to google for erratas wrt to:
> 01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Matisse Switch
> Upstream aka 1022:57ad
>
> and the cpu, to see if there is something else I could have missed,
> but i haven't found anything relating to this yet...

The thing is this could be something that there isn't an errata for.
All it takes is a bad component somewhere and you can have one lane
that is a bit flaky and causes the link establishment to take longer
than it is supposed to.

The fact that the patch resolves the issue ends up being more
coincidental than intentional though. We should be able to have the
NIC work with just the upstream and NIC link on the switch running
with ASPM enabled, the fact that we can't makes me wonder about that
upstream port link. Did you only have this one system or were there
other similar systems you could test with?

If we only have the one system it might make sense to just update the
description for the patch and get away from focusing on this issue,
and instead focus on the fact that the PCIe spec indicates that this
is the way it is supposed to be calculated. If we had more of these
systems to test with and found this is a common thing then we could
look at adding a PCI quirk for the device to just disable ASPM
whenever we saw it.
