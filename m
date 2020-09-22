Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C74274CFF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 01:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgIVXAf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 19:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVXAf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 19:00:35 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A40320672;
        Tue, 22 Sep 2020 23:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600815633;
        bh=U21I+/8tSG6uJIfhNRX/ouqzqww7SxvrUhM5JlUTJ44=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bp1uF9g7wmGYAKv9tGlwUhaGchL25SxEP4DS9YgbFySNDyymeQ5iRKmeEoYqgHcYQ
         uRXx/iRLpVBOSlY+Uy6dhnUjbP6urVITqw8C5z6UBJgBTZEYr/6DtB2w/GaYpSSV9C
         sdK4zsHGozEWWgCXEjbjdxJhApc1esYDw3DBk3mU=
Date:   Tue, 22 Sep 2020 18:00:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
Message-ID: <20200922230031.GA2230332@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA85sZvk_MqYKWBo3pHP+Z2sWyODuxS7Ni2DHfLikq6fJJ6g3Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alexander]

On Tue, Sep 22, 2020 at 11:02:35PM +0200, Ian Kumlien wrote:
> On Tue, Sep 22, 2020 at 10:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Aug 03, 2020 at 04:58:32PM +0200, Ian Kumlien wrote:

> > > @@ -469,11 +477,14 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> > >                * L1 exit latencies advertised by a device include L1
> > >                * substate latencies (and hence do not do any check).
> > >                */
> > > -             latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> > > -             if ((link->aspm_capable & ASPM_STATE_L1) &&
> > > -                 (latency + l1_switch_latency > acceptable->l1))
> > > -                     link->aspm_capable &= ~ASPM_STATE_L1;
> > > -             l1_switch_latency += 1000;
> > > +             if (link->aspm_capable & ASPM_STATE_L1) {
> > > +                     latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> > > +                     l1_max_latency = max_t(u32, latency, l1_max_latency);
> > > +                     if (l1_max_latency + l1_switch_latency > acceptable->l1)
> > > +                             link->aspm_capable &= ~ASPM_STATE_L1;
> > > +
> > > +                     l1_switch_latency += 1000;
> > > +             }
> >
> > This accumulates the 1 usec delays for a Switch to propagate the exit
> > transition from its Downstream Port to its Upstream Port, but it
> > doesn't accumulate the L1 exit latencies themselves for the entire
> > path, does it?  I.e., we don't accumulate "latency" for the whole
> > path.  Don't we need that?
> 
> Not for L1's apparently, from what I gather the maximum link latency
> is "largest latency" + 1us * number-of-hops
> 
> Ie, just like the comment above states - the L1 total time might be
> more but  1us is all that is needed to "start" and that propagates
> over the link.

Ah, you're right!  I don't think this is clear from the existing code
comment, but it *is* clear from the example in sec 5.4.1.2.2 (Figure
5-8) of the spec.

> @@ -448,14 +449,18 @@ static void pcie_aspm_check_latency(struct
> pci_dev *endpoint)
> 
>         while (link) {
>                 /* Check upstream direction L0s latency */
> -               if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
> -                   (link->latency_up.l0s > acceptable->l0s))
> -                       link->aspm_capable &= ~ASPM_STATE_L0S_UP;
> +               if (link->aspm_capable & ASPM_STATE_L0S_UP) {
> +                       l0s_latency_up += link->latency_up.l0s;

It's pretty clear from sec 5.4.1.2.2 that we *don't* need to
accumulate the L1 exit latencies.  Unfortunately sec 5.4.1.1.2 about
L0s exit doesn't have such a nice example.

The L0s *language* is similar though:

  5.4.1.1.2: If the Upstream component is a Switch (i.e., it is not
  the Root Complex), then it must initiate a transition on its
  Upstream Port Transmit Lanes (if the Upstream Port's Transmit Lanes
  are in a low-power state) as soon as it detects an exit from L0s on
  any of its Downstream Ports.

  5.4.1.2.1: A Switch is required to initiate an L1 exit transition on
  its Upstream Port Link after no more than 1 μs from the beginning of
  an L1 exit transition on any of its Downstream Port Links.  during
  L1 exit.

So a switch must start upstream L0s exit "as soon as" it sees L0s exit
on any downstream port, while it must start L1 exit "no more than 1 μs"
after seeing an L1 exit.

And I really can't tell from the spec whether we need to accumulate
the L0s exit latencies or not.  Maybe somebody can clarify this.

> commit db3d9c4baf4ab177d87b5cd41f624f5901e7390f
> Author: Ian Kumlien <ian.kumlien@gmail.com>
> Date:   Sun Jul 26 16:01:15 2020 +0200
> 
>     Use maximum latency when determining L1 ASPM
> 
>     If it's not, we clear the link for the path that had too large latency.
> 
>     Currently we check the maximum latency of upstream and downstream
>     per link, not the maximum for the path
> 
>     This would work if all links have the same latency, but:
>     endpoint -> c -> b -> a -> root  (in the order we walk the path)
> 
>     If c or b has the higest latency, it will not register
> 
>     Fix this by maintaining the maximum latency value for the path
> 
>     See this bugzilla for more information:
>     https://bugzilla.kernel.org/show_bug.cgi?id=208741
> 
>     This fixes an issue for me where my desktops machines maximum bandwidth
>     for remote connections dropped from 933 MBit to ~40 MBit.
> 
>     The bug became obvious once we enabled ASPM on all links:
>     66ff14e59e8a (PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges)

I can't connect the dots here yet.  I don't see a PCIe-to-PCI/PCI-X
bridge in your lspci, so I can't figure out why this commit would make
a difference for you.

IIUC, the problem device is 03:00.0, the Intel I211 NIC.  Here's the
path to it:

  00:01.2 Root Port              to [bus 01-07]
  01:00.0 Switch Upstream Port   to [bus 02-07]
  02:03.0 Switch Downstream Port to [bus 03]
  03:00.0 Endpoint (Intel I211 NIC)

And I think this is the relevant info:

						    LnkCtl    LnkCtl
	   ------DevCap-------  ----LnkCap-------  -Before-  -After--
  00:01.2                                L1 <32us       L1+       L1-
  01:00.0                                L1 <32us       L1+       L1-
  02:03.0                                L1 <32us       L1+       L1+
  03:00.0  L0s <512ns L1 <64us  L0s <2us L1 <16us  L0s- L1-  L0s- L1-

The NIC says it can tolerate at most 512ns of L0s exit latency and at
most 64us of L1 exit latency.

02:03.0 doesn't support L0s, and the NIC itself can't exit L0s that
fast anyway (it can only do <2us), so L0s should be out of the picture
completely.

Before your patch, apparently we (or BIOS) enabled L1 on the link from
00:01.2 to 01:00.0, and partially enabled it on the link from 02:03.0
to 03:00.0.

It looks like we *should* be able to enable L1 on both links since the
exit latency should be <33us (first link starts exit at T=0, completes
by T=32; second link starts exit at T=1, completes by T=33), and
03:00.0 can tolerate up to 64us.

I guess the effect of your patch is to disable L1 on the 00:01.2 -
01:00.0 link?  And that makes the NIC work better?  I am obviously
missing something because I don't understand why the patch does that
or why it works better.

I added Alexander to cc since it sounds like he's helped debug this,
too.

>     Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 253c30cc1967..893b37669087 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
> 
>  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  {
> -       u32 latency, l1_switch_latency = 0;
> +       u32 latency, l1_max_latency = 0, l1_switch_latency = 0;
>         struct aspm_latency *acceptable;
>         struct pcie_link_state *link;
> 
> @@ -456,10 +456,14 @@ static void pcie_aspm_check_latency(struct
> pci_dev *endpoint)
>                 if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
>                     (link->latency_dw.l0s > acceptable->l0s))
>                         link->aspm_capable &= ~ASPM_STATE_L0S_DW;
> +
>                 /*
>                  * Check L1 latency.
> -                * Every switch on the path to root complex need 1
> -                * more microsecond for L1. Spec doesn't mention L0s.
> +                *
> +                * PCIe r5.0, sec 5.4.1.2.2 states:
> +                * A Switch is required to initiate an L1 exit transition on its
> +                * Upstream Port Link after no more than 1 μs from the
> beginning of an
> +                * L1 exit transition on any of its Downstream Port Links.
>                  *
>                  * The exit latencies for L1 substates are not advertised
>                  * by a device.  Since the spec also doesn't mention a way
> @@ -469,11 +473,14 @@ static void pcie_aspm_check_latency(struct
> pci_dev *endpoint)
>                  * L1 exit latencies advertised by a device include L1
>                  * substate latencies (and hence do not do any check).
>                  */
> -               latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> -               if ((link->aspm_capable & ASPM_STATE_L1) &&
> -                   (latency + l1_switch_latency > acceptable->l1))
> -                       link->aspm_capable &= ~ASPM_STATE_L1;
> -               l1_switch_latency += 1000;
> +               if (link->aspm_capable & ASPM_STATE_L1) {
> +                       latency = max_t(u32, link->latency_up.l1,
> link->latency_dw.l1);
> +                       l1_max_latency = max_t(u32, latency, l1_max_latency);
> +                       if (l1_max_latency + l1_switch_latency > acceptable->l1)
> +                               link->aspm_capable &= ~ASPM_STATE_L1;
> +
> +                       l1_switch_latency += 1000;
> +               }
> 
>                 link = link->parent;
>         }
> ----------------------
