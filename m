Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D70449A41
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 17:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241394AbhKHQtx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 11:49:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240236AbhKHQtw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Nov 2021 11:49:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 145CC60187;
        Mon,  8 Nov 2021 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636390028;
        bh=0v2vAx4zwJjrUeKvAJOFU5qdcGwXo2bNYzZSlEtsylM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iwqOT5jAaYT/pQzkzlw4A0pUe8X9VSNbfIh3CVT3VoxixHhZ/3kS1dMZ54s74JNfI
         3dcLih53M8A6kdax0SwbfV2AjYQu/LW1kJTdETmpfTruy08uYUjra23zJgtplbfySZ
         qC7tPkEZ0FF8dhtLllbeEWoMuLYzGtF2kraIiBQDbYHdtgyf7Pec7kvrES2xD4vcUy
         bPD1C0L/a93gMyJ0k04BQhfd+1/BgTcMi2cwgIWLE2SzbfVY23sfAL/cs8IZffOQJO
         ltv7G2NNLV1MlQqj1nnWCG25nNGuELMp0Tp5pBl8ErDrWaBQYzj35Q5wjLCecU3BID
         bqJ8cT/IIWsuA==
Received: by pali.im (Postfix)
        id CD7F0A15; Mon,  8 Nov 2021 17:47:05 +0100 (CET)
Date:   Mon, 8 Nov 2021 17:47:05 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Extend probing of native PCIe controllers
Message-ID: <20211108164705.gcvd3qfx4jotpgwh@pali>
References: <20211022183808.jdeo7vntnagqkg7g@pali>
 <CAOSf1CG65t0OZuB87z3m9AVBOjAQL_5nNRak+UjX7fOQJDCH0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOSf1CG65t0OZuB87z3m9AVBOjAQL_5nNRak+UjX7fOQJDCH0A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Tuesday 09 November 2021 00:14:36 Oliver O'Halloran wrote:
> On Sat, Oct 23, 2021 at 5:38 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > Hello!
> >
> > In this email I'm describing how I see that probing of native PCIe
> > controller drivers is implemented, how it should be implemented and how
> > to extend / simplify core code for controller drivers.
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
> 
> 5) is a bit out of place here and it could be step 0). There's no real
> requirements around when the upstream device (the controller in our
> case) starts polling for downstream devices. #PERST is effectively a
> power good signal so the downstream device is required to ignore the
> link polls until #PERST is lifted.

Ok, currently I do not see any issue by moving step 5) before step 1).

> > Competition of link training is indicated by standard DLLLA bit in Root
> > Port config space. Support for DLLLA bit is optional and is indicated by
> > DLLLARC bit in Root Port config space. Lot of PCIe controllers do not
> > support this standard DLLLA bit, but have their own specific register
> > for it.
> 
> I thought DLLLA reporting was made mandatory in gen2? I suppose it
> doesn't really matter since we need to support gen1 devices anyway,
> but still...

I have PCIe 2.0 and also PCIe 3.0 controllers where Root Ports do not
provide DLLLA capability. I do not know if DLLLA is mandatory in PCIe
specifications, but we need to support also these devices.

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
> 
> Is there any real difference between sending this message and placing
> the device into D3hot? IIRC devices in D3hot are required to tolerate
> a transition to D3cold (i.e. power being removed) anyway.

Hm... I do not know right now. I think that this is just another option.
Maybe somebody else know more details about it?

I will try to look into my PCIe book if there is some more explanation
about it.

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
> 
> I don't have any real objections to adding this, but I do wonder what
> code would be using these calls.

My initial idea is that native controller drivers would provide these
callbacks and they would not do these steps in their probe callback.
Instead pci core function would implement "common" probe method which
would call these callbacks in correct order and with proper delays and
checks between them.

Next pci_reset_fn_methods[PERST] code would call some of these callbacks
to implement Warm reset.

> If you squint a bit you've got
> something that looks a lot like a pci hotplug slot driver (enable /
> disable / presence check calls). It might make sense to try use some
> of that infrastructure for what you want to do since the bus scanning
> code already knows how to deal with slot drivers.

Something could be implemented in pci hotplug / slot driver.

I think that PCIe Warm Reset fits better for "slot reset" mechanism than
PCIe Hot Reset. It is because PCIe Warm Reset is done via out-of-band
signal (dedicated PERST# line) as opposite of PCIe Hot Reset which is
done via in-band PCIe protocol.

Enable / disable power source also perfectly fits for "slot power on"
mechanism.

Also hotplug / slot driver can monitor change of DLLLA state via PCIe
HotPlug interrupt. So it looks like that this could be reused too. But
in more PCIe controllers do not provide interrupt to signal link up and
some of them even DLLLA capability in Root Port (they have custom way
how to read link state).

> > 2) implement asynchronous initialization of PCIe link and enumeration of
> >    PCIe bus behind the PCIe Root Port from pci_host_probe() based on new
> >    callbacks added in 1)
> >    --> so native PCIe controller drivers do not have to do it manually
> >    --> during this initialization can be done also PCIe Hot Reset
> >
> > 3) implement PCIe Hot Reset as reset method via PERST# signal and put it
> >    into pci_reset_fn_methods[] array
> 
> I assume you mean Warm reset here.

Yes, that is typo. I really mean PCIe Warm Reset here.

> I'll add a word of caution that
> there are badly behaved devices out there which will ignore #PERST
> being re-asserted after the card is powered on.

Thanks for information! I know that there are devices which do not like
PCIe Hot Reset (done via Secondary Bus Reset bit in PCI Bridge).
And kernel has already quirks for these devices which disallow usage of
this kind of reset.

So if there are issue also with PCIe Warm Reset via PERST# pin then we
can use this kind of reset as the last one (pci_reset_fn_methods has
priority of resets). This should not break existing cards and if no
other reset is possible then card would stay in broken state like
before. Also we could add quirks which disallow this kind of reset for
broken cards. I think that there are more options how to handle it.

At least lot of native PCIe controller drivers are doing PERST# reset
during kernel boot time more of these PCIe controllers are also
initialized in bootloader U-Boot. So this issue about re-asserting
PERST# pin is already affected by more PCIe controller drivers.

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
> > device.
> 
> Is there a good reason for skipping probing the controller when
> there's no downstream device present?

Either old code or hw bugs (accessing config space when link is down
cause CPU aborts). I saw on mailing list patch which is fixing this and
registering "host controller" even when link is down. So looks like
these issues are being fixing.

> Seems kinda dumb to make a whole
> pci domain disappear just because it didn't have a device at boot.

I agree.

> > And in some cases it could speed up boot process as pci
> > controller driver does not have to actively wait for link and let kernel
> > do initialization of other devices.
> 
> > What do you think about this idea?
> 
> Sounds like a good idea to me.

Thanks for checking it!
