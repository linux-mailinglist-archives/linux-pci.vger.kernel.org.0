Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4983D6603
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jul 2021 19:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhGZRI6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jul 2021 13:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229680AbhGZRI6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Jul 2021 13:08:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D44260F6B;
        Mon, 26 Jul 2021 17:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627321766;
        bh=nwK1ATvhZ0brOfjn20QH7d7aZdI0DmJLCiKJsQRN6l4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BpSMme7cl0O24QNj9gwfaCYZ6fmuIjbVWjNc1bRe3lJ4RBkeiWIecK9LlhLgaauUw
         WBUZ1+Qz5M2oWm/6l6ZQlsO0stm//X5JKYQChXToW5bI2Cc8M/mmhc73iEgfeaChdB
         QKIjaTXKRVxaDI3i5vZkPENVsx+g0r7cteKbIiIPzxbUQMi6KQAF21RxKxrzVu+hyb
         TK+fDUBo7eoU0JJrsFoDdY83VqA0Yo9S1ZHSUYqqWf9+EPRcqmdS4kf8oJFS+LBdDA
         Qy42UK6QmbBHmDLX/zctSQzdD70uGBKsEN6+/WsqZ9F485fCmmMgH6xCy2mQ3RaYgm
         3oJ5tv2cMIfzA==
Date:   Mon, 26 Jul 2021 12:49:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH V6] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20210726174925.GA624246@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWFeTP81pfsX0YG=qouGH8+d-0GDCw68MmamhSHjQdM_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 26, 2021 at 04:47:54PM +0200, Geert Uytterhoeven wrote:
> Hi Bjorn,
> 
> On Sat, Jul 17, 2021 at 7:33 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, May 14, 2021 at 10:05:49PM +0200, marek.vasut@gmail.com wrote:
> > > From: Marek Vasut <marek.vasut+renesas@gmail.com>
> > >
> > > The R-Car PCIe controller is capable of handling L0s/L1 link states.
> > > While the controller can enter and exit L0s link state, and exit L1
> > > link state, without any additional action from the driver, to enter
> > > L1 link state, the driver must complete the link state transition by
> > > issuing additional commands to the controller.
> > >
> > > The problem is, this transition is not atomic. The controller sets
> > > PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
> > > the PCIe card, but then the controller enters some sort of inbetween
> > > state. The driver must detect this condition and complete the link
> > > state transition, by setting L1IATN bit in PMCTLR and waiting for
> > > the link state transition to complete.
> > >
> > > If a PCIe access happens inside this window, where the controller
> > > is between L0 and L1 link states, the access generates a fault and
> > > the ARM 'imprecise external abort' handler is invoked.
> > >
> > > Just like other PCI controller drivers, here we hook the fault handler,
> > > perform the fixup to help the controller enter L1 link state, and then
> > > restart the instruction which triggered the fault. Since the controller
> > > is in L1 link state now, the link can exit from L1 link state to L0 and
> > > successfully complete the access.
> > >
> > > While it was suggested to disable L1 link state support completely on
> > > the controller level, this would not prevent the L1 link state entry
> > > initiated by the link partner. This happens e.g. in case a PCIe card
> > > enters D3Hot state, which could be initiated from pci_set_power_state()
> > > if the card indicates D3Hot support, which in turn means link must enter
> > > L1 state. So instead, fix up the L1 link state after all.
> > >
> > > Note that this fixup is applicable only to Aarch32 R-Car controllers,
> > > the Aarch64 R-Car perform the same fixup in TFA, see TFA commit [1]
> > > 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
> > > [1] https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf
> >
> > This patch is horribly ugly but it's working around a horrible
> > hardware problem, and I don't have any better suggestions, so I guess
> > we don't really have much choice.
> >
> > I do think the commit log is a bit glib:
> >
> >   - "The R-Car PCIe controller is capable of handling L0s/L1 link
> >     states."  AFAICT every PCIe device is required to handle L0 and L1
> >     without software assistance.  So saying R-Car is "capable" puts a
> >     better face on this than seems warranted.
> >
> >     L0s doesn't seem relevant at all; at least it doesn't seem to play
> >     a role in the patch.  There's no such thing as "returning to L0s"
> >     as mentioned in the comment below; L0s is only reachable from L0.
> >     Returns from L1 only go to L0 (PCIe r5.0, fig 5-1).
> >
> >   - "The problem is, this transition is not atomic."  I think the
> >     *problem* is the hardware is broken in the first place.  This
> >     transition is supposed to be invisible to software.
> >
> >   - "Just like other PCI controller drivers ..." suggests that this is
> >     an ordinary situation that we shouldn't be concerned about.  This
> >     patch may be the best we can do to work around a bad hardware
> >     defect, but it's definitely not ordinary.
> >
> >     I think the other hook_fault_code() uses are for reporting
> >     legitimate PCIe errors, which most controllers log and turn
> >     into ~0 data responses without generating an abort or machine
> >     check, not things caused by hardware defects, so they're not
> >     really comparable.
> >
> > Has Renesas documented this as an erratum?  Will future devices
> > require additions to rcar_pcie_abort_handler_of_match[]?
> >
> > It'd be nice if the commit log mentioned the user-visible effect of
> > this problem.  I guess it does mention external aborts -- I assume you
> > see those when downstream devices go to D3hot or when ASPM puts the
> > link in L1?  And the abort results in a reboot?
> >
> > To be clear, I'm not objecting to the patch.  It's a hardware problem
> > and we should work around it as best we can.
> 
> Cool! So what's missing for this patch, which we have been polishing
> for almost one year, to be applied, so innocent people can no longer
> lock up an R-Car system just by inserting an ubiquitous Intel Ethernet
> card, and suspending the system?

Nothing missing from my point of view, so if Lorenzo is OK with it,
he'll apply it.  If I were applying it, I would make the commit log
something like this:

  When the link is in L1, hardware should return it to L0
  automatically whenever a transaction targets a component on the
  other end of the link (PCIe r5.0, sec 5.2).

  The R-Car PCIe controller doesn't handle this transition correctly.
  If the link is not in L0, an MMIO transaction targeting a downstream
  device fails, and the controller reports an ARM imprecise external
  abort.

  Work around this by hooking the abort handler so the driver can
  detect this situation and help the hardware complete the link state
  transition.

  When the R-Car controller receives a PM_ENTER_L1 DLLP from the
  downstream component, it sets PMEL1RX bit in PMSR register, but then
  the controller enters some sort of in-between state.  A subsequent
  MMIO transaction will fail, resulting in the external abort.  The
  abort handler detects this condition and completes the link state
  transition by setting the L1IATN bit in PMCTLR and waiting for the
  link state transition to complete.

I assume that on the PCIe side, there must be an error like
Unsupported Request or Malformed TLP, and the R-Car controller is
logging that and turning it into the ARM external abort?

I didn't see a clear response to Pali's question about what happens if
there's no MMIO access, e.g., what if the downstream device initiates
a DMA or MSI transaction?

Bjorn
