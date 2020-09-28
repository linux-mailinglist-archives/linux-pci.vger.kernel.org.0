Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED9227B828
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 01:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgI1XbC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 19:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgI1XbC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 19:31:02 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E2FC0613D3
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 16:31:01 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u6so2947961iow.9
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 16:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=229tMYDFtfUgwc0FBzxz0I0qX8Ka7EXzlu5eFFA0Yow=;
        b=W02XyBjOEBj/c7QhncKfF/7+lEX/KeSfDFIIClYLJ5ztqek0Jy4ZzgT0fOnHe673Lw
         rd/xSeHUP0k08X9YHnCFI1+6VqTNbqgQi7hiTlogna1Jc4nr63W0ckjl4u2JIBEssbnB
         oEGqkS87IbNGUfB/XA9evkW3odXpSAZkTRyx3j+2tZTjkGJv0eYlwG53hMNGT9ezzIQf
         s67PhwWA1d4W9BsLJ8Mv8hGlH+spr6t0VMa2byxskIwqMj15eoJjA12my1sPxczqf7QX
         t1bf2fsVi7c0EeUSAlXkC86U8yPslJaVsp+5OMnSBH600DZY41tUYmsMwjfR9sURRhAt
         Qz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=229tMYDFtfUgwc0FBzxz0I0qX8Ka7EXzlu5eFFA0Yow=;
        b=lqZCO/0byj85ZzMCc3AjFUBixwm6bWMtOfkTtn+sQ4gYBx59pA2ZWjW6qCit4wq1K3
         e1em73hsyYX/RLfQSmOT9igLl0vcPZO6Z4RRQdv69I6qrKmKNWhbXEr+9P+tskR4gC/2
         cRSWZQj9aZMvhRN8bKBHHWbbZnEWQ67awcWk25CXUcGztsGnkOYgYa3i2p1JSZXsnNXa
         i9Q0Od9H/vnqF46fEH/oZ4po7qvbQGYIOW+1gQnLi2/CMWfdn9xid/n0qJB/subVxKN+
         kTmcXqCE96TVyODxB4g743fo07o22/f0sJDcft4136mm0FhEY+v1C7KhUOiLR2Z/JGY0
         o3Og==
X-Gm-Message-State: AOAM533oOCP2cfkkWtj3x4k2PRV0+YLkyimHsuhzih2fdqCwPAs6wncP
        R1Oo9OY5slmQXltsK2uKpLJYFRldQz0DfLoCEMo=
X-Google-Smtp-Source: ABdhPJxGbML8lPeeQW32ZRbPdcdIEoB+HEOL9kYOACq8smxqBT7v4UvRn/3rgOcDXFODhknLYmZWHkTf8VLFMEUdbHw=
X-Received: by 2002:a02:c942:: with SMTP id u2mr791356jao.114.1601335860993;
 Mon, 28 Sep 2020 16:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZuexf2pqfHBCKKGRos8psg_6ZZFeXiFm3ncPz-6JtqEdQ@mail.gmail.com>
 <20200928170921.GA2485236@bjorn-Precision-5520> <CAA85sZuDVA1d_c7OQ3xyZiOVDneL6oN6bM-Sn2QfhfGAAoHhYg@mail.gmail.com>
 <CAKgT0UcQN77zrtRK8yKgNRR0pifGUceoRHXWW+cYukzmsQPNyQ@mail.gmail.com>
 <CAA85sZt7LQ0NrWFnR-fk0s+jqsO9FxsYiu4JavnH6V423Rba1w@mail.gmail.com> <CAA85sZuW4iy6hXEKrfQjLV-nmG-E8pe0joZpMSb_vzs7Pnc=wA@mail.gmail.com>
In-Reply-To: <CAA85sZuW4iy6hXEKrfQjLV-nmG-E8pe0joZpMSb_vzs7Pnc=wA@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 28 Sep 2020 16:30:49 -0700
Message-ID: <CAKgT0UfvSBQX4U2f_Qe3qVH67Oo=eyyrFipjHU6b2e9jCE+8pg@mail.gmail.com>
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

On Mon, Sep 28, 2020 at 1:33 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Mon, Sep 28, 2020 at 10:04 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> >
> > On Mon, Sep 28, 2020 at 9:53 PM Alexander Duyck
> > <alexander.duyck@gmail.com> wrote:

<snip>

> > > You should be able to manually disable L1 on the realtek link
> > > (4:00.0<->2:04.0) instead of doing it on the upstream link on the
> > > switch. That may provide a datapoint on the L1 behavior of the setup.
> > > Basically if you took the realtek out of the equation in terms of the
> > > L1 exit time you should see the exit time drop to no more than 33us
> > > like what would be expected with just the i210.
> >
> > Yeah, will try it out with echo 0 >
> > /sys/devices/pci0000:00/0000:00:01.2/0000:01:00.0/0000:02:04.0/0000:04:00.0/link/l1_aspm
> > (which is the device reported by my patch)
>
> So, 04:00.0 is already disabled, the existing code apparently handled
> that correctly... *but*
>
> given the path:
> 00:01.2/01:00.0/02:04.0/04:00.0 Unassigned class [ff00]: Realtek
> Semiconductor Co., Ltd. Device 816e (rev 1a)
>
> Walking backwards:
> -- 04:00.0 has l1 disabled
> -- 02:04.0 doesn't have aspm?!
>
> lspci reports:
> Capabilities: [370 v1] L1 PM Substates
> L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+ L1_PM_Substates+
> L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
> L1SubCtl2:
> Capabilities: [400 v1] Data Link Feature <?>
> Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
> Capabilities: [440 v1] Lane Margining at the Receiver <?>
>
> However the link directory is empty.
>
> Anything we should know about these unknown capabilities? also aspm
> L1.1 and .1.2, heh =)
>
> -- 01:00.0 has L1, disabling it makes the intel nic work again

I recall that much. However the question is why? If there is already a
32us time to bring up the link between the NIC and the switch why
would the additional 1us to also bring up the upstream port have that
much of an effect? That is why I am thinking that it may be worthwhile
to try to isolate things further so that only the upstream port and
the NIC have L1 enabled. If we are still seeing issues in that state
then I can only assume there is something off with the
00:01.2<->1:00.0 link to where it either isn't advertising the actual
L1 recovery time. For example the "Width x4 (downgraded)" looks very
suspicious and could be responsible for something like that if the
link training is having to go through exception cases to work out the
x4 link instead of a x8.

> ASPM L1 enabled:
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  5.40 MBytes  45.3 Mbits/sec    0   62.2 KBytes
> [  5]   1.00-2.00   sec  4.47 MBytes  37.5 Mbits/sec    0   70.7 KBytes
> [  5]   2.00-3.00   sec  4.10 MBytes  34.4 Mbits/sec    0   42.4 KBytes
> [  5]   3.00-4.00   sec  4.47 MBytes  37.5 Mbits/sec    0   65.0 KBytes
> [  5]   4.00-5.00   sec  4.47 MBytes  37.5 Mbits/sec    0    105 KBytes
> [  5]   5.00-6.00   sec  4.47 MBytes  37.5 Mbits/sec    0   84.8 KBytes
> [  5]   6.00-7.00   sec  4.47 MBytes  37.5 Mbits/sec    0   65.0 KBytes
> [  5]   7.00-8.00   sec  4.10 MBytes  34.4 Mbits/sec    0   45.2 KBytes
> [  5]   8.00-9.00   sec  4.47 MBytes  37.5 Mbits/sec    0   56.6 KBytes
> [  5]   9.00-10.00  sec  4.47 MBytes  37.5 Mbits/sec    0   48.1 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  44.9 MBytes  37.7 Mbits/sec    0             sender
> [  5]   0.00-10.01  sec  44.0 MBytes  36.9 Mbits/sec                  receiver
>
> ASPM L1 disabled:
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec   111 MBytes   935 Mbits/sec  733    761 KBytes
> [  5]   1.00-2.00   sec   110 MBytes   923 Mbits/sec  733    662 KBytes
> [  5]   2.00-3.00   sec   109 MBytes   912 Mbits/sec  1036   1.20 MBytes
> [  5]   3.00-4.00   sec   109 MBytes   912 Mbits/sec  647    738 KBytes
> [  5]   4.00-5.00   sec   110 MBytes   923 Mbits/sec  852    744 KBytes
> [  5]   5.00-6.00   sec   109 MBytes   912 Mbits/sec  546    908 KBytes
> [  5]   6.00-7.00   sec   109 MBytes   912 Mbits/sec  303    727 KBytes
> [  5]   7.00-8.00   sec   109 MBytes   912 Mbits/sec  432    769 KBytes
> [  5]   8.00-9.00   sec   110 MBytes   923 Mbits/sec  462    652 KBytes
> [  5]   9.00-10.00  sec   109 MBytes   912 Mbits/sec  576    764 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  1.07 GBytes   918 Mbits/sec  6320             sender
> [  5]   0.00-10.01  sec  1.06 GBytes   912 Mbits/sec                  receiver
>
> (all measurements are over live internet - so thus variance)

I forgot there were 5 total devices that were hanging off of there as
well. You might try checking to see if disabling L1 on devices 5:00.0,
6:00.0 and/or 7:00.0 has any effect while leaving the L1 on 01:00.0
and the NIC active. The basic idea is to go through and make certain
we aren't seeing an L1 issue with one of the other downstream links on
the switch.

The more I think about it the entire setup for this does seem a bit
suspicious. I was looking over the lspci tree and the dump from the
system. From what I can tell the upstream switch link at 01.2 <->
1:00.0 is only a Gen4 x4 link. However coming off of that is 5
devices, two NICs using either Gen1 or 2 at x1, and then a USB
controller and 2 SATA controller reporting Gen 4 x16. Specifically
those last 3 devices have me a bit curious as they are all reporting
L0s and L1 exit latencies that are the absolute minimum which has me
wondering if they are even reporting actual values.
