Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD2227B658
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 22:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgI1Ude (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 16:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgI1Ude (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 16:33:34 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB733C061755
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 13:33:33 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id db4so1179455qvb.4
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 13:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcVW6OCui9RWyBXSTXwZWouNWbUUW+lqsSbLZlQRFZ8=;
        b=bcmltrL+JjLLCs0uZwv8ewGuk+1/iAEJClu3wIMviiaaqhy85W0T7WC6JhK4+DYzxi
         rlGsyBnSt+yRXsY6YYDJoiIWguXKvMtsEQIRkKSjU7Iv7Vne6sPcapekhNxqhk2E3kZ3
         yG8iEZ4UNQMNlMkviagBPI0Mxw+e7d9T0xnA1huv0ES5EEVShH0L/uGFM9kFYdP9fCeG
         +UF577HxjGQYLW02ziHTDKSt1UDO3Nv/D/0fYJQ32IFk8wqEEbVa8bvwvl2nlFWXaGst
         h2W8ljy+n1VGdauYyI6MB+4eEULgCaUQWAXdXDSSkaGrKePoqXlNGLgpaTKEK2VYTLfi
         Kaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcVW6OCui9RWyBXSTXwZWouNWbUUW+lqsSbLZlQRFZ8=;
        b=egJxwM0BRIVPWbx4xLbDqbQxmOFQ7gskCvXPrGpReXINJCRd7PvGBa/dOdOvG2LMvz
         L64KdsjbY+3urGyZr4iXQ4WhudgCtA6vaAIMjWAVNn64uxnrFTLYIJcER3kjczR9Gjv1
         IRDGiYCFGwm62RJSrFHajkQxx/13sXiUqwkH203Pww9mIiJLtyKRICA0eXztnKUqCUTG
         xFnOd8oadxzgEbcYw2o0oVLkvSTBATE+3bsusqJ6XY4JEi2eTJr2HlS5tc4PlGTNPXWK
         PTkAOFZt3UF42fuIrXnyK8lI2fvJm5FBMRPBcEhcxInljj2QTSnsypvwFG454YykPABC
         Vv8w==
X-Gm-Message-State: AOAM532CtahJnPtSCZkjdiuROgJQxi1+uvVwLSDmhMD79d2yE2o531bj
        682kjjLC4g1RX0UNY2nRB2ZiecIRCQrUJOI1IeXvqac6ZOtq9g==
X-Google-Smtp-Source: ABdhPJxW5BUHy3xdfeYVTIzwJh9itcQ79WTQXFBjB+KlmHh2DvHbKmcCrPgrOlfkGYu3/KTcYW2t6s0prCuwA+rUx5I=
X-Received: by 2002:ad4:4e4e:: with SMTP id eb14mr1348010qvb.41.1601325212608;
 Mon, 28 Sep 2020 13:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZuexf2pqfHBCKKGRos8psg_6ZZFeXiFm3ncPz-6JtqEdQ@mail.gmail.com>
 <20200928170921.GA2485236@bjorn-Precision-5520> <CAA85sZuDVA1d_c7OQ3xyZiOVDneL6oN6bM-Sn2QfhfGAAoHhYg@mail.gmail.com>
 <CAKgT0UcQN77zrtRK8yKgNRR0pifGUceoRHXWW+cYukzmsQPNyQ@mail.gmail.com> <CAA85sZt7LQ0NrWFnR-fk0s+jqsO9FxsYiu4JavnH6V423Rba1w@mail.gmail.com>
In-Reply-To: <CAA85sZt7LQ0NrWFnR-fk0s+jqsO9FxsYiu4JavnH6V423Rba1w@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 28 Sep 2020 22:33:21 +0200
Message-ID: <CAA85sZuW4iy6hXEKrfQjLV-nmG-E8pe0joZpMSb_vzs7Pnc=wA@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 28, 2020 at 10:04 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Mon, Sep 28, 2020 at 9:53 PM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> >
> > On Mon, Sep 28, 2020 at 10:42 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > >
> > > On Mon, Sep 28, 2020 at 7:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > On Mon, Sep 28, 2020 at 12:24:11PM +0200, Ian Kumlien wrote:
> > > > > On Mon, Sep 28, 2020 at 2:06 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Sat, Sep 26, 2020 at 12:26:53AM +0200, Ian Kumlien wrote:
> > > > > > > On Fri, Sep 25, 2020 at 5:49 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > On Fri, Sep 25, 2020 at 03:54:11PM +0200, Ian Kumlien wrote:
> > > > > > > > > On Fri, Sep 25, 2020 at 3:39 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Sep 25, 2020 at 12:18:50PM +0200, Ian Kumlien wrote:
> > > > > > > > > > > So.......
> > > > > > > > > > > [    0.815843] pci 0000:04:00.0: L1 latency exceeded - path: 1000 - max: 64000
> > > > > > > > > > > [    0.815843] pci 0000:00:01.2: Upstream device - 32000
> > > > > > > > > > > [    0.815844] pci 0000:01:00.0: Downstream device - 32000
> > > > > > > > > >
> > > > > > > > > > Wait a minute.  I've been looking at *03:00.0*, not 04:00.0.  Based
> > > > > > > > > > on your bugzilla, here's the path:
> > > > > > > > >
> > > > > > > > > Correct, or you could do it like this:
> > > > > > > > > 00:01.2/01:00.0/02:03.0/03:00.0 Ethernet controller: Intel Corporation
> > > > > > > > > I211 Gigabit Network Connection (rev 03)
> > > > > > > > >
> > > > > > > > > >   00:01.2 Root Port              to [bus 01-07]
> > > > > > > > > >   01:00.0 Switch Upstream Port   to [bus 02-07]
> > > > > > > > > >   02:03.0 Switch Downstream Port to [bus 03]
> > > > > > > > > >   03:00.0 Endpoint (Intel I211 NIC)
> > > > > > > > > >
> > > > > > > > > > Your system does also have an 04:00.0 here:
> > > > > > > > > >
> > > > > > > > > >   00:01.2 Root Port              to [bus 01-07]
> > > > > > > > > >   01:00.0 Switch Upstream Port   to [bus 02-07]
> > > > > > > > > >   02:04.0 Switch Downstream Port to [bus 04]
> > > > > > > > > >   04:00.0 Endpoint (Realtek 816e)
> > > > > > > > > >   04:00.1 Endpoint (Realtek RTL8111/8168/8411 NIC)
> > > > > > > > > >   04:00.2 Endpoint (Realtek 816a)
> > > > > > > > > >   04:00.4 Endpoint (Realtek 816d EHCI USB)
> > > > > > > > > >   04:00.7 Endpoint (Realtek 816c IPMI)
> > > > > > > > > >
> > > > > > > > > > Which NIC is the problem?
> > > > > > > > >
> > > > > > > > > The intel one - so the side effect of the realtek nic is that it fixes
> > > > > > > > > the intel nics issues.
> > > > > > > > >
> > > > > > > > > It would be that the intel nic actually has a bug with L1 (and it
> > > > > > > > > would seem that it's to kind with latencies) so it actually has a
> > > > > > > > > smaller buffer...
> > > > > > > > >
> > > > > > > > > And afair, the realtek has a larger buffer, since it behaves better
> > > > > > > > > with L1 enabled.
> > > > > > > > >
> > > > > > > > > Either way, it's a fix that's needed ;)
> > > > > > > >
> > > > > > > > OK, what specifically is the fix that's needed?  The L0s change seems
> > > > > > > > like a "this looks wrong" thing that doesn't actually affect your
> > > > > > > > situation, so let's skip that for now.
> > > > > > >
> > > > > > > L1 latency calculation is not good enough, it assumes that *any*
> > > > > > > link is the highest latency link - which is incorrect.
> > > > > > >
> > > > > > > The latency to bring L1 up is number-of-hops*1000 +
> > > > > > > maximum-latency-along-the-path
> > > > > > >
> > > > > > > currently it's only doing number-of-hops*1000 +
> > > > > > > arbitrary-latency-of-current-link
> > > > > > >
> > > > > > > > And let's support the change you *do* need with the "lspci -vv" for
> > > > > > > > all the relevant devices (including both 03:00.0 and 04:00.x, I guess,
> > > > > > > > since they share the 00:01.2 - 01:00.0 link), before and after the
> > > > > > > > change.
> > > > > > >
> > > > > > > They are all included in all lspci output in the bug
> > > > > >
> > > > > > No doubt.  But I spent a long time going through those and the
> > > > > > differences I found are not enough to show a spec violation or a fix.
> > > > > >
> > > > > > Here's what I extracted (this is a repeat; I mentioned this before):
> > > > > >
> > > > > >                                                     LnkCtl    LnkCtl
> > > > > >            ------DevCap-------  ----LnkCap-------  -Before-  -After--
> > > > > >   00:01.2                                L1 <32us       L1+       L1-
> > > > > >   01:00.0                                L1 <32us       L1+       L1-
> > > > > >   02:03.0                                L1 <32us       L1+       L1+
> > > > > >   03:00.0  L0s <512ns L1 <64us  L0s <2us L1 <16us  L0s- L1-  L0s- L1-
> > > > > >
> > > > > > I don't see anything wrong here yet.  03:00.0 claims it can handle up
> > > > > > to 64us of L1 exit latency, and the L1 exit latency of the entire path
> > > > > > should be 33us.  What am I missing?
> > > > >
> > > > > it should be 32+3 so 35 us - but the intel nic claims something it
> > > > > can't live up to.
> > > >
> > > > How did you compute 35us?  Here's my math for 33us:
> > > >
> > > >   It looks like we *should* be able to enable L1 on both links since
> > > >   the exit latency should be <33us (first link starts exit at T=0,
> > > >   completes by T=32; second link starts exit at T=1, completes by
> > > >   T=33), and 03:00.0 can tolerate up to 64us.
> > >
> > > 03:00.0 + 0
> > > 02:03.0 + 1000
> > > 01:00.0 + 1000
> > > 00:01.2 + 1000
> > >
> > > so, 32 us + 3us or am I missing something?
> >
> > You are adding two too many. Specifically you should be counting the
> > links, not the endpoints. If I am not mistaken you only have two
> > links. 00:01.2<->01:00.0 and 02:03.0<->3:00.0. That is how Bjorn is
> > coming up with 33, because you only need to add 1 for the additional
> > link.
>
> Then I'm missing something, since i saw L1 transition to the power up
> step, and it's the link to link step that is 1us
>
> > > > If 03:00.0 advertises that it can tolerate 64us but it really can't,
> > > > the fix would be a quirk to override the DevCap value for that device.
> > >
> > > Yeah, I wonder what it should be - I assume we could calculate it from latencies
> > > or perhaps there is something hidden in pcie 4 or higher L1 modes...
> > >
> > > I'm very uncertain of what level lspci handles and how much of the
> > > data it extracts
> > > (And i don't know better myself either ;))
> >
> > The one question I would have is if we are actually seeing less than
> > 64us or not. In the testing you did, did we ever try disabling the L1
> > on just the realtek devices? That would help to eliminate that as a
> > possible source of issues. As per my other comments I am wondering if
> > we are seeing head-of-line blocking occurring where requests for the
> > realtek device are blocking the downstream PCIe bus while it is
> > waiting on the device to wake up. If we are held for 64us with a
> > transaction stuck on the switch waiting for the realtek link to wake
> > up that might be long enough to start causing us to see throughput
> > problems as we cannot move the data between the CPU and the NIC fast
> > enough due to the potential stalls.
>
> No, we did not try to disable it on this specific realtek device, I'll
> try it and see
>
> It also looks like i have a lot of aspm L1.1 supporting devices...
>
> Anyway, I have no clue of the head-of-line blocking but it does seem
> plausible since it's all serial.. .

> > > > > Since this is triggered by the realtek device
> > > >
> > > > I'm still under the impression that the throughput problem is with
> > > > 03:00.0, the Intel I211 NIC.  In what sense is this triggered by the
> > > > Realtek device?  Does the I211 work correctly until we add the Realtek
> > > > device below the same switch?
> > >
> > > They are both embedded devices on the motherboard
> > > Asus  Pro WS X570-ACE with bios: 2206
> > >
> > > So i can't test one without the other...
> >
> > You should be able to manually disable L1 on the realtek link
> > (4:00.0<->2:04.0) instead of doing it on the upstream link on the
> > switch. That may provide a datapoint on the L1 behavior of the setup.
> > Basically if you took the realtek out of the equation in terms of the
> > L1 exit time you should see the exit time drop to no more than 33us
> > like what would be expected with just the i210.
>
> Yeah, will try it out with echo 0 >
> /sys/devices/pci0000:00/0000:00:01.2/0000:01:00.0/0000:02:04.0/0000:04:00.0/link/l1_aspm
> (which is the device reported by my patch)

So, 04:00.0 is already disabled, the existing code apparently handled
that correctly... *but*

given the path:
00:01.2/01:00.0/02:04.0/04:00.0 Unassigned class [ff00]: Realtek
Semiconductor Co., Ltd. Device 816e (rev 1a)

Walking backwards:
-- 04:00.0 has l1 disabled
-- 02:04.0 doesn't have aspm?!

lspci reports:
Capabilities: [370 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+ L1_PM_Substates+
L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
L1SubCtl2:
Capabilities: [400 v1] Data Link Feature <?>
Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
Capabilities: [440 v1] Lane Margining at the Receiver <?>

However the link directory is empty.

Anything we should know about these unknown capabilities? also aspm
L1.1 and .1.2, heh =)

-- 01:00.0 has L1, disabling it makes the intel nic work again

ASPM L1 enabled:
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  5.40 MBytes  45.3 Mbits/sec    0   62.2 KBytes
[  5]   1.00-2.00   sec  4.47 MBytes  37.5 Mbits/sec    0   70.7 KBytes
[  5]   2.00-3.00   sec  4.10 MBytes  34.4 Mbits/sec    0   42.4 KBytes
[  5]   3.00-4.00   sec  4.47 MBytes  37.5 Mbits/sec    0   65.0 KBytes
[  5]   4.00-5.00   sec  4.47 MBytes  37.5 Mbits/sec    0    105 KBytes
[  5]   5.00-6.00   sec  4.47 MBytes  37.5 Mbits/sec    0   84.8 KBytes
[  5]   6.00-7.00   sec  4.47 MBytes  37.5 Mbits/sec    0   65.0 KBytes
[  5]   7.00-8.00   sec  4.10 MBytes  34.4 Mbits/sec    0   45.2 KBytes
[  5]   8.00-9.00   sec  4.47 MBytes  37.5 Mbits/sec    0   56.6 KBytes
[  5]   9.00-10.00  sec  4.47 MBytes  37.5 Mbits/sec    0   48.1 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  44.9 MBytes  37.7 Mbits/sec    0             sender
[  5]   0.00-10.01  sec  44.0 MBytes  36.9 Mbits/sec                  receiver

ASPM L1 disabled:
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   111 MBytes   935 Mbits/sec  733    761 KBytes
[  5]   1.00-2.00   sec   110 MBytes   923 Mbits/sec  733    662 KBytes
[  5]   2.00-3.00   sec   109 MBytes   912 Mbits/sec  1036   1.20 MBytes
[  5]   3.00-4.00   sec   109 MBytes   912 Mbits/sec  647    738 KBytes
[  5]   4.00-5.00   sec   110 MBytes   923 Mbits/sec  852    744 KBytes
[  5]   5.00-6.00   sec   109 MBytes   912 Mbits/sec  546    908 KBytes
[  5]   6.00-7.00   sec   109 MBytes   912 Mbits/sec  303    727 KBytes
[  5]   7.00-8.00   sec   109 MBytes   912 Mbits/sec  432    769 KBytes
[  5]   8.00-9.00   sec   110 MBytes   923 Mbits/sec  462    652 KBytes
[  5]   9.00-10.00  sec   109 MBytes   912 Mbits/sec  576    764 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1.07 GBytes   918 Mbits/sec  6320             sender
[  5]   0.00-10.01  sec  1.06 GBytes   912 Mbits/sec                  receiver

(all measurements are over live internet - so thus variance)

> > Also I wonder if we shouldn't prioritize the upstream side of the
> > switches for power savings versus the downstream side. In most cases
> > the upstream port on a switch will have more lanes than the downstream
> > side so enabling power saving there should result in greater power
> > savings versus the individual devices such as a i210 which is only a
> > single PCIe lane anyway.
>
> That makes sense it would also avoid a lot of errors due to buffering
> limitations, but L1 doesn't seem to be separated like that
> L0s is however...
>
> > > > >                                                      LnkCtl    LnkCtl
> > > > >             ------DevCap-------  ----LnkCap-------  -Before-  -After--
> > > > >    00:01.2                                L1 <32us       L1+       L1-
> > > > >    01:00.0                                L1 <32us       L1+       L1-
> > > > >    02:04.0                                L1 <32us       L1+       L1+
> > > > >    04:00.0  L0s <512 L1 <64us
> > > > >
> > > > > But exit for 04:00.0 is 64us which means it breaks its own latency
> > > > > requirements once it's behind anything
> > > >
> > > > From your "lspci-before" attachment, 04:00.0 advertises:
> > > >
> > > >   04:00.0 DevCap: Latency L1 <64us
> > > >           LnkCap: Exit Latency L1 <64us
> > > >
> > > > So I see what you mean; if it's behind a switch, the link on the
> > > > upstream side of the switch would add some L1 exit latency, so we
> > > > wouldn't be able to exit L1 for the entire path in <64us.  This isn't
> > > > broken in the sense of a hardware defect; it just means we won't be
> > > > able to enable L1 on some parts of the path.
> > >
> > > Yes, it just seems odd to have the same latency as max latency..
> > >
> > > It could also be that they are assuming that we will not check that
> > > endpoint's latency
> > > as we walk the path... I have heard that this is quite tricky to get
> > > right and that Microsoft also had problems with it.
> > >
> > > (I assume that they would have a bit more resources and devices to test with)
> >
> > I read that as this device is not configured to support stacked L1 ASPM.
>
> Yeah and since my reasoning was off by one, it makes more sense =)
>
> > > > I wouldn't be surprised if Linux is doing that wrong right now, but we
> > > > would just need to nail down exactly what's wrong.
> > >
> > > OK
> >
> > This is something we didn't enable until recently so that isn't too
> > surprising. Previously, we just disabled ASPM if a switch was present.
> >
> > > > > > > > I want to identify something in the "before" configuration that is
> > > > > > > > wrong according to the spec, and a change in the "after" config so it
> > > > > > > > now conforms to the spec.
> > > > > > >
> > > > > > > So there are a few issues here, the current code does not apply to spec.
> > > > > > >
> > > > > > > The intel nic gets fixed as a side effect (it should still get a
> > > > > > > proper fix) of making
> > > > > > > the code apply to spec.
> > > > > > >
> > > > > > > Basically, while hunting for the issue, I found that the L1 and L0s
> > > > > > > latency calculations used to determine
> > > > > > > if they should be enabled or not is wrong - that is what I'm currently
> > > > > > > trying to push - it also seems like the
> > > > > > > intel nic claims that it can handle 64us but apparently it can't.
> > > > > > >
> > > > > > > So, three bugs, two are "fixed" one needs additional fixing.
> > > > > >
> > > > > > OK, we just need to split these up as much as possible and support
> > > > > > them with the relevant lspci output, analysis of what specifically is
> > > > > > wrong, and the lspci output showing the effect of the fix.
> > > > >
> > > > > Could i have a copy of the pcie spec? I have found sections of it but
> > > > > it's really hard to find them again when you
> > > > > want to refer to something... Which I need to do to show that it
> > > > > doesn't conform...
> > > >
> > > > Wish I could give you the spec, but it's not public.  There are books
> > > > that cover most of this material, e.g., Mindshare's "PCI Express
> > > > System Architecture".  I have a 2004 copy and it covers ASPM (but not
> > > > the L1 Substates).  I have also heard rumors that it's possible to
> > > > find older copies of the spec on the web.
> > >
> > > Dang... :/
> >
> > Just do a google search for "pcie gen 2 specification" you should find
> > a few results that way.
> >
> > Thanks.
> >
> > - Alex
