Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E56D46D768
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 16:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhLHPzl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 10:55:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49568 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbhLHPzi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 10:55:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73179B82182;
        Wed,  8 Dec 2021 15:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC856C00446;
        Wed,  8 Dec 2021 15:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638978724;
        bh=OBctGawUaTI9Q+mF3DH2vwOAicF08DuL30Jq4ELnZCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=B/xjj7I6jJtJGPSYC+DzsEZEkhtFYcXqOhe1IIbwTpXCa/huyo+TUz1Pc0Jv1QBEy
         IteGZROj2CQQqEHNtYau6/ddy9A3KaPKx1NiV7lZy+LGefCZ4LLiVr5vNPGg8UL2+1
         rW0M/VcSuohFNy+qjkEFM5stK+E5l835OGVFBY90CAZuutjjNuU1wt5s5kjYKmQgj3
         2vSO9hyfKulLDfVeCafPx5TksaU/ElI3Pwt+nP7qJsyRtlHLsTAWm1VVIoe4eFK6PC
         Bb4fkYkK2gfj4TV7nBw0XIMVnR7rtNqG5CCbmHkhk6jfi5+Rs1ThGufLkweCninqic
         pPjBBnXx1DQIA==
Date:   Wed, 8 Dec 2021 09:52:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: Extend probing of native PCIe controllers
Message-ID: <20211208155202.GA127232@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211022183808.jdeo7vntnagqkg7g@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 22, 2021 at 08:38:08PM +0200, Pali Rohár wrote:
> Hello!
> 
> In this email I'm describing how I see that probing of native PCIe
> controller drivers is implemented, how it should be implemented and how
> to extend / simplify core code for controller drivers.
>
> Native PCIe controller drivers needs to fill struct pci_host_bridge and
> then call pci_host_probe(). Function pci_host_probe() starts probing and
> enumerating buses and register PCIe devices to system.
> 
> But initialization of PCIe controller and cards on buses (other end of
> PCIe link) is more complicated and basically every native PCIe
> controller driver needs to do initialization PCIe link prior calling
> pci_host_probe(). Steps which controller drivers are doing are de-facto
> standard steps defined in PCIe base or CEM specification.
> 
> The most problematic step is to reset endpoint card and wait until
> endpoint card start. Reset of endpoint card is done by standard PERST#
> signal (defined in PCIe CEM spec) and in most cases board export control
> of this signal to OS via GPIO (few board and drivers have this signal
> connected to PCIe controller and then PCIe controller has some specific
> registers to control this signal). Reset via PERST# signal is defined in
> PCIe CEM and base specs as "PCIe Warm Reset".
> 
> As discussed in the following email thread, this PCIe Warm Reset should
> not depend on PCIe controller as it resets card on the other end of PCIe
> controller. But currently every native PCIe controller driver does PCIe
> Warm Reset by its own for randomly chosen time period. There is open
> question how long should be endpoint card in Warm Reset state:
> https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/
> 
> Initialization of PCIe endpoint card is described in PCIe CEM spec in
> Figure 2-10: Power Up. Other informations are in PCIe base spec in 6.6.1
> Conventional Reset section.
> 
> If I understand specifications correctly then OS initialization steps
> should be following (please correct me if I'm wrong!):
> 
> 1) Put PERST# to low which enter endpoint card into reset state
> 2) Enable AUX power (3.3V) and wait until is stable
> 3) Enable main power (12V/3.3V) and wait until is stable
> 4) Enable refclock and wait until is stable
> 5) Enable LTSSM on PCIe controller to start link training
> 6) Put PERST# to high which exit endpoint card from reset state
> 7) Wait until link training completes
> 8) Wait another 100ms prior accessing config space of endpoint card
> 
> Minimal time period between "after step 3)" and "before step 6)" is T_PVPERL = 100ms
> Minimal time period between "after step 4)" and "before step 6)" is T_PERSTCLK = 100us
> 
> After step 6) is end of Fundamental Reset and PCIe controller needs to
> be in LTSSM Detect state within 20ms. So enabling it prior putting
> PERST# to high should achieve it.
> 
> Competition of link training is indicated by standard DLLLA bit in Root
> Port config space. Support for DLLLA bit is optional and is indicated by
> DLLLARC bit in Root Port config space. Lot of PCIe controllers do not
> support this standard DLLLA bit, but have their own specific register
> for it.
> 
> Similarly is defined power down of PCIe card in PCIe CEM spec in Figure
> 2-13: Power Down. If I understand it correctly steps are:
> 
> 1) Put endpoint card into D3hot state, so PCIe link goes inactive
> 2) Put PERST# to low, so endpoint card enters reset state
> 3) Disable main power (12V/3.3V)
> 4) Disable refclock
> 
> In case of surprise power down, PERST# needs to go low in 500ns.
> 
> In PCIe base spec in section 5.2 Link State Power Management is
> described that preparation for removing the main power source can be
> done also by sending PCIe PME_Turn_Off Message by Root Complex. IIRC
> there is no standard way how to send PCIe PME_Turn_Off message.
> 
> 
> 
> 
> I see that basically every PCIe controller driver is doing its own
> implementation of PCIe Warm Reset and waiting until PCIe link is ready
> prior calling pci_host_probe().
> 
> Based on all above details I would like to propose following extending
> of struct pci_host_bridge and pci_host_probe() function to de-duplicate
> native PCIe controller driver code:
> 
> 1) extend struct pci_host_bridge to provide callbacks for:
>    * enable / disable main power source
>    * enable / disable refclock
>    * enable / disable LTSSM link training (if PCIe link should go into Detect / Polling state)
>    * enable / disable PERST# signal
>    * returning boolean if endpoint card is present (physically in PCIe/mPCIe/m.2/... slot)
>    * returning boolean if link training completed
>    * sending PCIe PME_Turn_Off message
> 
> 2) implement asynchronous initialization of PCIe link and enumeration of
>    PCIe bus behind the PCIe Root Port from pci_host_probe() based on new
>    callbacks added in 1)
>    --> so native PCIe controller drivers do not have to do it manually
>    --> during this initialization can be done also PCIe Hot Reset
> 
> 3) implement PCIe Hot Reset as reset method via PERST# signal and put it
>    into pci_reset_fn_methods[] array
> 
> 4) implement PCIe Cold Reset as reset method via power down / up and put
>    it into pci_reset_fn_methods[] array
> 
> 5) as enabling / disabling power supply and toggling PERST# signal is
>    implemented via GPIO, add some generic implementation for callback
>    functions which will use named gpios (e.g. from DT)
> 
> This could simplify implementations of native PCIe controller drivers by
> calling initialization steps in correct order with correct timeouts and
> drivers do not have to do copy+paste same common code or reimplement it
> with own constants and macros for timeouts, etc...
> 
> Also it should enable access to PCIe Root Port as this device is part of
> Root Complex and should be available also when link is down or link
> training was not completed. Currently some PCIe controllers are not
> registered into system when link is down (e.g. card is disconnected or
> card has some issue). Which also prevents access to PCIe Root Port
> device. And in some cases it could speed up boot process as pci
> controller driver does not have to actively wait for link and let kernel
> do initialization of other devices.
> 
> What do you think about this idea?

I would love to have somebody work on this because every native driver
does it differently and I'm guessing none of them really do it
correctly.

Note that struct pci_host_bridge is a 1:many situation with Root
Ports, which is where the link management is.  Unfortunately many
drivers have the single Root Port assumption baked into them.

I think I would start small, by adding some #defines for T_PVPERL,
T_PERSTCLK, etc, and using them, which will probably expose lots of
gaps and hidden assumptions.  Then maybe add the callback functions
but use them internally to the driver before moving the calls to the
shared core.  I like it best when reorganizations like moving all the
initialization steps into the core are simple "code move only, no
functional change" sort of things.
