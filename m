Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B8A285FB5
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 15:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgJGNDy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 09:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbgJGNDy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Oct 2020 09:03:54 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8363E206F4;
        Wed,  7 Oct 2020 13:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602075833;
        bh=Abf/kHoHzQbKZESvmRd9KXIWoPUi4+5bt5dpHv5IVAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KZu4VIrMaZ7VKNfV7shFjJr2iviUsoI0b1dHHmoI0tF0X88nLKfehsXDe02XMm7Al
         PBNK2Hxe6ofNfORqhLZKUX76qU6WZfXw39+cZOwo+Ag14BChcX4YAKinDNXNhvq2aG
         rnw3ci33Z7yKnIAK+TFiWZbDpIg73xzkik0AaHys=
Date:   Wed, 7 Oct 2020 08:03:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
Message-ID: <20201007130352.GA3235876@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA85sZsVKCbcHfxjNA83==YFDP_va=qp8JQEcbMFYJXNJP=1NQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 07, 2020 at 01:31:48PM +0200, Ian Kumlien wrote:
> On Mon, Oct 5, 2020 at 9:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Mon, Oct 05, 2020 at 08:38:55PM +0200, Ian Kumlien wrote:
> > > On Mon, Oct 5, 2020 at 8:31 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > On Mon, Aug 03, 2020 at 04:58:32PM +0200, Ian Kumlien wrote:
> > > > > Changes:
> > > > > * Handle L0s correclty as well, making it per direction
> > > > > * Moved the switch cost in to the if statement since a non L1 switch has
> > > > >   no additional cost.
> > > > >
> > > > > For L0s:
> > > > > We sumarize the entire latency per direction to see if it's acceptable
> > > > > for the PCIe endpoint.
> > > > >
> > > > > If it's not, we clear the link for the path that had too large latency.
> > > > >
> > > > > For L1:
> > > > > Currently we check the maximum latency of upstream and downstream
> > > > > per link, not the maximum for the path
> > > > >
> > > > > This would work if all links have the same latency, but:
> > > > > endpoint -> c -> b -> a -> root  (in the order we walk the path)
> > > > >
> > > > > If c or b has the higest latency, it will not register
> > > > >
> > > > > Fix this by maintaining the maximum latency value for the path
> > > > >
> > > > > This change fixes a regression introduced (but not caused) by:
> > > > > 66ff14e59e8a (PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges)
> > > > >
> > > > > Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> > > >
> > > > I'm not sure where we're at with this.  If we can come up with:
> > > >
> > > >   - "lspci -vv" for the entire affected hierarchy before the fix
> > > >
> > > >   - specific identification of incorrect configuration per spec
> > > >
> > > >   - patch that fixes that specific misconfiguration
> > > >
> > > >   - "lspci -vv" for the entire affected hierarchy after the fix
> > > >
> > > > then we have something to work with.  It doesn't have to (and should
> > > > not) fix all the problems at once.
> > >
> > > So detail the changes on my specific machine and then mention
> > > 5.4.1.2.2 of the pci spec
> > > detailing the exit from PCIe ASPM L1?
> >
> > Like I said, I need to see the current ASPM configuration, a note
> > about what is wrong with it (this probably involves a comparison with
> > what the spec says it *should* be), and the configuration after the
> > patch showing that it's now fixed.
> >
> > > Basically writing a better changelog for the first patch?
> > >
> > > Any comments on the L0s patch?
> >
> > Not yet.  When it's packaged up in mergeable form I'll review it.  I
> > just don't have time to extract everything myself.
> 
> So, did it like this, since I don't think the output from my system
> actually is important.
> (I added some descriptive text that is loosely based on the spec)

I think the before/after lspci from your system *is* important.
Concrete examples are a big help.

The commit log below looks accurate, but of course needs to be
attached to a specific patch.  Can you please post the complete patch
with commit log all by itself so it's not buried in the middle of this
long thread?

> ----
> Use maximum latency when determining L1 ASPM
> 
> Make pcie_aspm_check_latency comply with the PCIe spec, specifically:
> "5.4.1.2.2. Exit from the L1 State"
> 
> Which makes it clear that each switch is required to initiate a
> transition within 1μs from receiving it, accumulating this latency and
> then we have to wait for the slowest link along the path before
> entering L0 state from L1.
> 
> The current code doesn't take the maximum latency into account.
> 
> From the example:
>    +----------------+
>    |                |
>    |  Root complex  |
>    |                |
>    |    +-----+     |
>    |    |32 μs|     |
>    +----------------+
>            |
>            |  Link 1
>            |
>    +----------------+
>    |     |8 μs|     |
>    |     +----+     |
>    |    Switch A    |
>    |     +----+     |
>    |     |8 μs|     |
>    +----------------+
>            |
>            |  Link 2
>            |
>    +----------------+
>    |    |32 μs|     |
>    |    +-----+     |
>    |    Switch B    |
>    |    +-----+     |
>    |    |32 μs|     |
>    +----------------+
>            |
>            |  Link 3
>            |
>    +----------------+
>    |     |8μs|      |
>    |     +---+      |
>    |   Endpoint C   |
>    |                |
>    |                |
>    +----------------+
> 
> Links 1, 2 and 3 are all in L1 state - endpoint C initiates the
> transition to L0 at time T. Since switch B takes 32 μs to exit L1 on
> it's ports, Link 3 will transition to L0 at T+32 (longest time
> considering T+8 for endpoint C and T+32 for switch B).
> 
> Switch B is required to initiate a transition from the L1 state on it's
> upstream port after no more than 1 μs from the beginning of the
> transition from L1 state on the downstream port. Therefore, transition from
> L1 to L0 will begin on link 2 at T+1, this will cascade up the path.
> 
> The path will exit L1 at T+34.
> 
> Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> ----
> 
> > > > > ---
> > > > >  drivers/pci/pcie/aspm.c | 41 ++++++++++++++++++++++++++---------------
> > > > >  1 file changed, 26 insertions(+), 15 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > > index b17e5ffd31b1..bc512e217258 100644
> > > > > --- a/drivers/pci/pcie/aspm.c
> > > > > +++ b/drivers/pci/pcie/aspm.c
> > > > > @@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
> > > > >
> > > > >  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> > > > >  {
> > > > > -     u32 latency, l1_switch_latency = 0;
> > > > > +     u32 latency, l1_max_latency = 0, l1_switch_latency = 0,
> > > > > +             l0s_latency_up = 0, l0s_latency_dw = 0;
> > > > >       struct aspm_latency *acceptable;
> > > > >       struct pcie_link_state *link;
> > > > >
> > > > > @@ -447,15 +448,22 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> > > > >       acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
> > > > >
> > > > >       while (link) {
> > > > > -             /* Check upstream direction L0s latency */
> > > > > -             if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
> > > > > -                 (link->latency_up.l0s > acceptable->l0s))
> > > > > -                     link->aspm_capable &= ~ASPM_STATE_L0S_UP;
> > > > > -
> > > > > -             /* Check downstream direction L0s latency */
> > > > > -             if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
> > > > > -                 (link->latency_dw.l0s > acceptable->l0s))
> > > > > -                     link->aspm_capable &= ~ASPM_STATE_L0S_DW;
> > > > > +             if (link->aspm_capable & ASPM_STATE_L0S) {
> > > > > +                     /* Check upstream direction L0s latency */
> > > > > +                     if (link->aspm_capable & ASPM_STATE_L0S_UP) {
> > > > > +                             l0s_latency_up += link->latency_up.l0s;
> > > > > +                             if (l0s_latency_up > acceptable->l0s)
> > > > > +                                     link->aspm_capable &= ~ASPM_STATE_L0S_UP;
> > > > > +                     }
> > > > > +
> > > > > +                     /* Check downstream direction L0s latency */
> > > > > +                     if (link->aspm_capable & ASPM_STATE_L0S_DW) {
> > > > > +                             l0s_latency_dw += link->latency_dw.l0s;
> > > > > +                             if (l0s_latency_dw > acceptable->l0s)
> > > > > +                                     link->aspm_capable &= ~ASPM_STATE_L0S_DW;
> > > > > +                     }
> > > > > +             }
> > > > > +
> > > > >               /*
> > > > >                * Check L1 latency.
> > > > >                * Every switch on the path to root complex need 1
> > > > > @@ -469,11 +477,14 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> > > > >                * L1 exit latencies advertised by a device include L1
> > > > >                * substate latencies (and hence do not do any check).
> > > > >                */
> > > > > -             latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> > > > > -             if ((link->aspm_capable & ASPM_STATE_L1) &&
> > > > > -                 (latency + l1_switch_latency > acceptable->l1))
> > > > > -                     link->aspm_capable &= ~ASPM_STATE_L1;
> > > > > -             l1_switch_latency += 1000;
> > > > > +             if (link->aspm_capable & ASPM_STATE_L1) {
> > > > > +                     latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> > > > > +                     l1_max_latency = max_t(u32, latency, l1_max_latency);
> > > > > +                     if (l1_max_latency + l1_switch_latency > acceptable->l1)
> > > > > +                             link->aspm_capable &= ~ASPM_STATE_L1;
> > > > > +
> > > > > +                     l1_switch_latency += 1000;
> > > > > +             }
> > > > >
> > > > >               link = link->parent;
> > > > >       }
> > > > > --
> > > > > 2.28.0
> > > > >
