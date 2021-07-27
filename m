Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236C43D7AF4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 18:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhG0QcT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 12:32:19 -0400
Received: from foss.arm.com ([217.140.110.172]:41070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhG0QcR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 12:32:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79C5731B;
        Tue, 27 Jul 2021 09:32:16 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A09D3F70D;
        Tue, 27 Jul 2021 09:32:14 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:32:12 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH V6] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20210727163212.GB15814@lpieralisi>
References: <CAMuHMdWFeTP81pfsX0YG=qouGH8+d-0GDCw68MmamhSHjQdM_A@mail.gmail.com>
 <20210726174925.GA624246@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726174925.GA624246@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 26, 2021 at 12:49:25PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 26, 2021 at 04:47:54PM +0200, Geert Uytterhoeven wrote:
> > Hi Bjorn,
> > 
> > On Sat, Jul 17, 2021 at 7:33 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, May 14, 2021 at 10:05:49PM +0200, marek.vasut@gmail.com wrote:
> > > > From: Marek Vasut <marek.vasut+renesas@gmail.com>
> > > >
> > > > The R-Car PCIe controller is capable of handling L0s/L1 link states.
> > > > While the controller can enter and exit L0s link state, and exit L1
> > > > link state, without any additional action from the driver, to enter
> > > > L1 link state, the driver must complete the link state transition by
> > > > issuing additional commands to the controller.
> > > >
> > > > The problem is, this transition is not atomic. The controller sets
> > > > PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
> > > > the PCIe card, but then the controller enters some sort of inbetween
> > > > state. The driver must detect this condition and complete the link
> > > > state transition, by setting L1IATN bit in PMCTLR and waiting for
> > > > the link state transition to complete.
> > > >
> > > > If a PCIe access happens inside this window, where the controller
> > > > is between L0 and L1 link states, the access generates a fault and
> > > > the ARM 'imprecise external abort' handler is invoked.
> > > >
> > > > Just like other PCI controller drivers, here we hook the fault handler,
> > > > perform the fixup to help the controller enter L1 link state, and then
> > > > restart the instruction which triggered the fault. Since the controller
> > > > is in L1 link state now, the link can exit from L1 link state to L0 and
> > > > successfully complete the access.
> > > >
> > > > While it was suggested to disable L1 link state support completely on
> > > > the controller level, this would not prevent the L1 link state entry
> > > > initiated by the link partner. This happens e.g. in case a PCIe card
> > > > enters D3Hot state, which could be initiated from pci_set_power_state()
> > > > if the card indicates D3Hot support, which in turn means link must enter
> > > > L1 state. So instead, fix up the L1 link state after all.
> > > >
> > > > Note that this fixup is applicable only to Aarch32 R-Car controllers,
> > > > the Aarch64 R-Car perform the same fixup in TFA, see TFA commit [1]
> > > > 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
> > > > [1] https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf
> > >
> > > This patch is horribly ugly but it's working around a horrible
> > > hardware problem, and I don't have any better suggestions, so I guess
> > > we don't really have much choice.
> > >
> > > I do think the commit log is a bit glib:
> > >
> > >   - "The R-Car PCIe controller is capable of handling L0s/L1 link
> > >     states."  AFAICT every PCIe device is required to handle L0 and L1
> > >     without software assistance.  So saying R-Car is "capable" puts a
> > >     better face on this than seems warranted.
> > >
> > >     L0s doesn't seem relevant at all; at least it doesn't seem to play
> > >     a role in the patch.  There's no such thing as "returning to L0s"
> > >     as mentioned in the comment below; L0s is only reachable from L0.
> > >     Returns from L1 only go to L0 (PCIe r5.0, fig 5-1).
> > >
> > >   - "The problem is, this transition is not atomic."  I think the
> > >     *problem* is the hardware is broken in the first place.  This
> > >     transition is supposed to be invisible to software.
> > >
> > >   - "Just like other PCI controller drivers ..." suggests that this is
> > >     an ordinary situation that we shouldn't be concerned about.  This
> > >     patch may be the best we can do to work around a bad hardware
> > >     defect, but it's definitely not ordinary.
> > >
> > >     I think the other hook_fault_code() uses are for reporting
> > >     legitimate PCIe errors, which most controllers log and turn
> > >     into ~0 data responses without generating an abort or machine
> > >     check, not things caused by hardware defects, so they're not
> > >     really comparable.
> > >
> > > Has Renesas documented this as an erratum?  Will future devices
> > > require additions to rcar_pcie_abort_handler_of_match[]?
> > >
> > > It'd be nice if the commit log mentioned the user-visible effect of
> > > this problem.  I guess it does mention external aborts -- I assume you
> > > see those when downstream devices go to D3hot or when ASPM puts the
> > > link in L1?  And the abort results in a reboot?
> > >
> > > To be clear, I'm not objecting to the patch.  It's a hardware problem
> > > and we should work around it as best we can.
> > 
> > Cool! So what's missing for this patch, which we have been polishing
> > for almost one year, to be applied, so innocent people can no longer
> > lock up an R-Car system just by inserting an ubiquitous Intel Ethernet
> > card, and suspending the system?
> 
> Nothing missing from my point of view, so if Lorenzo is OK with it,
> he'll apply it.

I will apply it at some point for v5.15 - there is still some details I
would like to investigate (disclaimer: I am not picking on this
particular patch - it is just a really thorny issue and I want to
understand what's the best way forward); I will update the patch and log
accordingly, no need for a v7 (which I can post myself publicly so that
you can have a look before I merge it).

> If I were applying it, I would make the commit log
> something like this:

I will do it myself, see above.

>   When the link is in L1, hardware should return it to L0
>   automatically whenever a transaction targets a component on the
>   other end of the link (PCIe r5.0, sec 5.2).
> 
>   The R-Car PCIe controller doesn't handle this transition correctly.
>   If the link is not in L0, an MMIO transaction targeting a downstream
>   device fails, and the controller reports an ARM imprecise external
>   abort.
> 
>   Work around this by hooking the abort handler so the driver can
>   detect this situation and help the hardware complete the link state
>   transition.
> 
>   When the R-Car controller receives a PM_ENTER_L1 DLLP from the
>   downstream component, it sets PMEL1RX bit in PMSR register, but then
>   the controller enters some sort of in-between state.  A subsequent
>   MMIO transaction will fail, resulting in the external abort.  The
>   abort handler detects this condition and completes the link state
>   transition by setting the L1IATN bit in PMCTLR and waiting for the
>   link state transition to complete.
> 
> I assume that on the PCIe side, there must be an error like
> Unsupported Request or Malformed TLP, and the R-Car controller is
> logging that and turning it into the ARM external abort?
> 
> I didn't see a clear response to Pali's question about what happens if
> there's no MMIO access, e.g., what if the downstream device initiates
> a DMA or MSI transaction?

It'd be great if I could update the log with these questions answered -
along with others Pali asked [1] and that are very relevant.

Thanks,
Lorenzo

[1] https://lore.kernel.org/linux-pci/20210719172340.vvtnddbli2vgxndi@pali
