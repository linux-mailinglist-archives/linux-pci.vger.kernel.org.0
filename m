Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E20344992A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 17:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbhKHQOY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 11:14:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231976AbhKHQOX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Nov 2021 11:14:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91AE461107;
        Mon,  8 Nov 2021 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636387898;
        bh=J9k46rZiY8H+bRpoH4kyCCvMTCOAhyiiap4OZ/iHvD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hdb3blKQePjDh/K4aFzf8cg3V4GorA3mAU3Mbl0rE1Ys5I43FrEsJp7tdS3ubdl8g
         KUXFMrQ1s7TD4AtTMwC6XUjpE9vZX3FFhwrPOFp1268tCSDR/hGvV3T2OMxD+R7QUo
         1QBOdH1ATDGfmemIz9f1xRP2oerg1lDei7/KM8bx54r98G9xpi5E4GYpyCfd786SdJ
         OFCoTprVt0CCRbkPXwK1Adna+pGYIw7ErxTxDdrbWyAWZRbrS6VYIWFZ1oNrG9z6eV
         /oyVf6HyzZU8mKDfB4wPTBqgibWtMy3Hx9GI7b0kQ9C2cuuuKPvZQQxGK0UqptEqHm
         F3RTR8vRsM6ew==
Received: by pali.im (Postfix)
        id 1BE5DA15; Mon,  8 Nov 2021 17:11:36 +0100 (CET)
Date:   Mon, 8 Nov 2021 17:11:35 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: Extend probing of native PCIe controllers
Message-ID: <20211108161135.ldvdu2m6fzliyer6@pali>
References: <20211022183808.jdeo7vntnagqkg7g@pali>
 <2744c8e0-5b69-ba1a-f750-6b5f8ad07998@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2744c8e0-5b69-ba1a-f750-6b5f8ad07998@lucaceresoli.net>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Monday 08 November 2021 09:50:51 Luca Ceresoli wrote:
> Hi Pali,
> 
> On 22/10/21 20:38, Pali Rohár wrote:
> > Hello!
> > 
> > In this email I'm describing how I see that probing of native PCIe
> > controller drivers is implemented, how it should be implemented and how
> > to extend / simplify core code for controller drivers.
> > 
> > 
> > Native PCIe controller drivers needs to fill struct pci_host_bridge and
> > then call pci_host_probe(). Function pci_host_probe() starts probing and
> > enumerating buses and register PCIe devices to system.
> > 
> > But initialization of PCIe controller and cards on buses (other end of
> > PCIe link) is more complicated and basically every native PCIe
> > controller driver needs to do initialization PCIe link prior calling
> > pci_host_probe(). Steps which controller drivers are doing are de-facto
> > standard steps defined in PCIe base or CEM specification.
> > 
> > The most problematic step is to reset endpoint card and wait until
> > endpoint card start. Reset of endpoint card is done by standard PERST#
> > signal (defined in PCIe CEM spec) and in most cases board export control
> > of this signal to OS via GPIO (few board and drivers have this signal
> > connected to PCIe controller and then PCIe controller has some specific
> > registers to control this signal). Reset via PERST# signal is defined in
> > PCIe CEM and base specs as "PCIe Warm Reset".
> > 
> > As discussed in the following email thread, this PCIe Warm Reset should
> > not depend on PCIe controller as it resets card on the other end of PCIe
> > controller. But currently every native PCIe controller driver does PCIe
> > Warm Reset by its own for randomly chosen time period. There is open
> > question how long should be endpoint card in Warm Reset state:
> > https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/
> > 
> > Initialization of PCIe endpoint card is described in PCIe CEM spec in
> > Figure 2-10: Power Up. Other informations are in PCIe base spec in 6.6.1
> > Conventional Reset section.
> > 
> > If I understand specifications correctly then OS initialization steps
> > should be following (please correct me if I'm wrong!):
> > 
> > 1) Put PERST# to low which enter endpoint card into reset state
> > 2) Enable AUX power (3.3V) and wait until is stable
> > 3) Enable main power (12V/3.3V) and wait until is stable
> > 4) Enable refclock and wait until is stable
> > 5) Enable LTSSM on PCIe controller to start link training
> > 6) Put PERST# to high which exit endpoint card from reset state
> > 7) Wait until link training completes
> > 8) Wait another 100ms prior accessing config space of endpoint card
> > 
> > Minimal time period between "after step 3)" and "before step 6)" is T_PVPERL = 100ms
> > Minimal time period between "after step 4)" and "before step 6)" is T_PERSTCLK = 100us
> > 
> > After step 6) is end of Fundamental Reset and PCIe controller needs to
> > be in LTSSM Detect state within 20ms. So enabling it prior putting
> > PERST# to high should achieve it.
> > 
> > Competition of link training is indicated by standard DLLLA bit in Root
> > Port config space. Support for DLLLA bit is optional and is indicated by
> > DLLLARC bit in Root Port config space. Lot of PCIe controllers do not
> > support this standard DLLLA bit, but have their own specific register
> > for it.
> > 
> > Similarly is defined power down of PCIe card in PCIe CEM spec in Figure
> > 2-13: Power Down. If I understand it correctly steps are:
> > 
> > 1) Put endpoint card into D3hot state, so PCIe link goes inactive
> > 2) Put PERST# to low, so endpoint card enters reset state
> > 3) Disable main power (12V/3.3V)
> > 4) Disable refclock
> > 
> > In case of surprise power down, PERST# needs to go low in 500ns.
> > 
> > In PCIe base spec in section 5.2 Link State Power Management is
> > described that preparation for removing the main power source can be
> > done also by sending PCIe PME_Turn_Off Message by Root Complex. IIRC
> > there is no standard way how to send PCIe PME_Turn_Off message.
> > 
> > 
> > 
> > 
> > I see that basically every PCIe controller driver is doing its own
> > implementation of PCIe Warm Reset and waiting until PCIe link is ready
> > prior calling pci_host_probe().
> > 
> > Based on all above details I would like to propose following extending
> > of struct pci_host_bridge and pci_host_probe() function to de-duplicate
> > native PCIe controller driver code:
> > 
> > 1) extend struct pci_host_bridge to provide callbacks for:
> >    * enable / disable main power source
> >    * enable / disable refclock
> >    * enable / disable LTSSM link training (if PCIe link should go into Detect / Polling state)
> >    * enable / disable PERST# signal
> >    * returning boolean if endpoint card is present (physically in PCIe/mPCIe/m.2/... slot)
> >    * returning boolean if link training completed
> >    * sending PCIe PME_Turn_Off message
> > 
> > 2) implement asynchronous initialization of PCIe link and enumeration of
> >    PCIe bus behind the PCIe Root Port from pci_host_probe() based on new
> >    callbacks added in 1)
> >    --> so native PCIe controller drivers do not have to do it manually
> >    --> during this initialization can be done also PCIe Hot Reset
> > 
> > 3) implement PCIe Hot Reset as reset method via PERST# signal and put it
> >    into pci_reset_fn_methods[] array
> > 
> > 4) implement PCIe Cold Reset as reset method via power down / up and put
> >    it into pci_reset_fn_methods[] array
> > 
> > 5) as enabling / disabling power supply and toggling PERST# signal is
> >    implemented via GPIO, add some generic implementation for callback
> >    functions which will use named gpios (e.g. from DT)
> > 
> > This could simplify implementations of native PCIe controller drivers by
> > calling initialization steps in correct order with correct timeouts and
> > drivers do not have to do copy+paste same common code or reimplement it
> > with own constants and macros for timeouts, etc...
> > 
> > Also it should enable access to PCIe Root Port as this device is part of
> > Root Complex and should be available also when link is down or link
> > training was not completed. Currently some PCIe controllers are not
> > registered into system when link is down (e.g. card is disconnected or
> > card has some issue). Which also prevents access to PCIe Root Port
> > device. And in some cases it could speed up boot process as pci
> > controller driver does not have to actively wait for link and let kernel
> > do initialization of other devices.
> > 
> > What do you think about this idea?
> 
> I'm afraid I know very little about PCI so I cannot give much valuable
> feedback.
> 
> For what I can understand yours seems like a good analysis and the plan
> seems correct: move control from drivers into the core as far as the
> actions to take are standard and leave drivers the duty to implement
> only hardware-specific pieces via function pointers.
> 
> We have discussed in detail the PERST# behavior in [0], and I have a
> comment about that.
> 
> First, from that discussion it was clear that some drivers drive PERST#
> with an inverted polarity when calling gpiod_set_value() or
> devm_gpiod_get_optional(), which is "fixed" by an inverted polarity
> setting in their device tree.

Yes, that is truth.

> Second, you say "in most cases board export control of this signal to OS
> via GPIO".

Yes.

> For these two reasons you might consider, in addition to the
> pci_reset_fn_methods[] function to implement PERST#, to add a struct
> gpio_desc * to be filled by the driver and used by the core. If set, it
> would allow the core to assert/deassert PERST# without driver
> intervention.

Controlling PERST# via pci_reset_fn_methods[] is not enough.
pci_reset_fn_methods[PERST]() would do something like this:

1. Assert PERST# (put card into reset)
2. Delay some time period (this is open question how long it should be)
3. De-assert PERST# (put card from reset into normal state)

But in some other functions it would be needed to put card into reset
state and let it in this state (e.g. in power down, driver unbind,
etc...). So pci_reset_fn_methods[PERST] would not be possible to use it
here.

I was thinking to provide just callback bridge->set_perst(enable) and
then implement pci_reset_fn_methods[PERST] via this callback.

If that callback is NULL then PCI core code can assign default
"set_perst" callback which use gpiod_set_value. Like in your pseudocode
below.

Drivers which have inverted polarity of PERTST# gpio or drivers which
have custom way for controlling this pin would have to provide
appropriate callbacks.

> The idea in pseudocode is:
> 
>   [in drivers/pci/probe.c]
> 
>   if (bridge->perst_gpio) {
>       gpiod_set_value(reset, 1); // assert
>       usleep(...);
>       gpiod_set_value(reset, 0); // deassert
>       usleep(...);
>   } else if (bridge->pci_reset_fn_methods[PERST]) {
>       bridge->pci_reset_fn_methods[PERST]();
>   }
> 
> It would make drivers slightly simpler and less error prone.
> 
> [0]
> https://lore.kernel.org/linux-arm-kernel/e9ab9c22-f73b-fe72-820a-4f2825c3dabc@lucaceresoli.net/T/#mc4fc8c10ebeeff8c6d3593b0072afbcf7de9f2ae
> 
> My 2c,
> -- 
> Luca
> 
