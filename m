Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA18437CA5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhJVSk3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 14:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233803AbhJVSk2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 14:40:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8303B60238;
        Fri, 22 Oct 2021 18:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634927890;
        bh=dCm4xtYxwp5HabhpWiIUn/wplxFMoicjHU3dArZzlHI=;
        h=Date:From:To:Subject:From;
        b=pqX8sMctbtiwhEGjr/EM7/vlPYW1wmlEURVdnHc7vXZzNNAFk7VMG+p67+2/r0Xpm
         pihavqsuil3fhESuuznEF4CvstCJov/1WG0mmSvnU76QPN60Z6mwI2cP3oyDFhMR6v
         O3euAhcX97/c70moTofGPVoueyMC7weGCpnVtHNaOuoOWGX5Y/G4QeuZ/QHxd4Khao
         1uRTSmx30T0btk5Jb33qrOJk1Bzay4DPn5k1ZFgs8TZtpvCUCR6XPf7s6Cb8sS8WiG
         Kt0pcHxw9OVbcgXc6YfdXDJxW+PjisOWwlkySLl90qr6Kf/E/irKjYDmwglEk36f44
         xgXB0umC/QrbQ==
Received: by pali.im (Postfix)
        id 317787F6; Fri, 22 Oct 2021 20:38:08 +0200 (CEST)
Date:   Fri, 22 Oct 2021 20:38:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RFC: Extend probing of native PCIe controllers
Message-ID: <20211022183808.jdeo7vntnagqkg7g@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

In this email I'm describing how I see that probing of native PCIe
controller drivers is implemented, how it should be implemented and how
to extend / simplify core code for controller drivers.


Native PCIe controller drivers needs to fill struct pci_host_bridge and
then call pci_host_probe(). Function pci_host_probe() starts probing and
enumerating buses and register PCIe devices to system.

But initialization of PCIe controller and cards on buses (other end of
PCIe link) is more complicated and basically every native PCIe
controller driver needs to do initialization PCIe link prior calling
pci_host_probe(). Steps which controller drivers are doing are de-facto
standard steps defined in PCIe base or CEM specification.

The most problematic step is to reset endpoint card and wait until
endpoint card start. Reset of endpoint card is done by standard PERST#
signal (defined in PCIe CEM spec) and in most cases board export control
of this signal to OS via GPIO (few board and drivers have this signal
connected to PCIe controller and then PCIe controller has some specific
registers to control this signal). Reset via PERST# signal is defined in
PCIe CEM and base specs as "PCIe Warm Reset".

As discussed in the following email thread, this PCIe Warm Reset should
not depend on PCIe controller as it resets card on the other end of PCIe
controller. But currently every native PCIe controller driver does PCIe
Warm Reset by its own for randomly chosen time period. There is open
question how long should be endpoint card in Warm Reset state:
https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/

Initialization of PCIe endpoint card is described in PCIe CEM spec in
Figure 2-10: Power Up. Other informations are in PCIe base spec in 6.6.1
Conventional Reset section.

If I understand specifications correctly then OS initialization steps
should be following (please correct me if I'm wrong!):

1) Put PERST# to low which enter endpoint card into reset state
2) Enable AUX power (3.3V) and wait until is stable
3) Enable main power (12V/3.3V) and wait until is stable
4) Enable refclock and wait until is stable
5) Enable LTSSM on PCIe controller to start link training
6) Put PERST# to high which exit endpoint card from reset state
7) Wait until link training completes
8) Wait another 100ms prior accessing config space of endpoint card

Minimal time period between "after step 3)" and "before step 6)" is T_PVPERL = 100ms
Minimal time period between "after step 4)" and "before step 6)" is T_PERSTCLK = 100us

After step 6) is end of Fundamental Reset and PCIe controller needs to
be in LTSSM Detect state within 20ms. So enabling it prior putting
PERST# to high should achieve it.

Competition of link training is indicated by standard DLLLA bit in Root
Port config space. Support for DLLLA bit is optional and is indicated by
DLLLARC bit in Root Port config space. Lot of PCIe controllers do not
support this standard DLLLA bit, but have their own specific register
for it.

Similarly is defined power down of PCIe card in PCIe CEM spec in Figure
2-13: Power Down. If I understand it correctly steps are:

1) Put endpoint card into D3hot state, so PCIe link goes inactive
2) Put PERST# to low, so endpoint card enters reset state
3) Disable main power (12V/3.3V)
4) Disable refclock

In case of surprise power down, PERST# needs to go low in 500ns.

In PCIe base spec in section 5.2 Link State Power Management is
described that preparation for removing the main power source can be
done also by sending PCIe PME_Turn_Off Message by Root Complex. IIRC
there is no standard way how to send PCIe PME_Turn_Off message.




I see that basically every PCIe controller driver is doing its own
implementation of PCIe Warm Reset and waiting until PCIe link is ready
prior calling pci_host_probe().

Based on all above details I would like to propose following extending
of struct pci_host_bridge and pci_host_probe() function to de-duplicate
native PCIe controller driver code:

1) extend struct pci_host_bridge to provide callbacks for:
   * enable / disable main power source
   * enable / disable refclock
   * enable / disable LTSSM link training (if PCIe link should go into Detect / Polling state)
   * enable / disable PERST# signal
   * returning boolean if endpoint card is present (physically in PCIe/mPCIe/m.2/... slot)
   * returning boolean if link training completed
   * sending PCIe PME_Turn_Off message

2) implement asynchronous initialization of PCIe link and enumeration of
   PCIe bus behind the PCIe Root Port from pci_host_probe() based on new
   callbacks added in 1)
   --> so native PCIe controller drivers do not have to do it manually
   --> during this initialization can be done also PCIe Hot Reset

3) implement PCIe Hot Reset as reset method via PERST# signal and put it
   into pci_reset_fn_methods[] array

4) implement PCIe Cold Reset as reset method via power down / up and put
   it into pci_reset_fn_methods[] array

5) as enabling / disabling power supply and toggling PERST# signal is
   implemented via GPIO, add some generic implementation for callback
   functions which will use named gpios (e.g. from DT)

This could simplify implementations of native PCIe controller drivers by
calling initialization steps in correct order with correct timeouts and
drivers do not have to do copy+paste same common code or reimplement it
with own constants and macros for timeouts, etc...

Also it should enable access to PCIe Root Port as this device is part of
Root Complex and should be available also when link is down or link
training was not completed. Currently some PCIe controllers are not
registered into system when link is down (e.g. card is disconnected or
card has some issue). Which also prevents access to PCIe Root Port
device. And in some cases it could speed up boot process as pci
controller driver does not have to actively wait for link and let kernel
do initialization of other devices.

What do you think about this idea?


PS: Excuse me if I wrote some mistakes here, I'm still learning how PCIe
is working and how is PCI subsystem implemented.
