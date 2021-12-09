Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C3546EC64
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 16:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbhLIQD3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 11:03:29 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51546 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbhLIQD3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 11:03:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D428ACE26C5;
        Thu,  9 Dec 2021 15:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B019EC004DD;
        Thu,  9 Dec 2021 15:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639065592;
        bh=WCrvLQA0qeKw7bTS8wIW5Nl3xC+J6OUs03D0x9jEzIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rNx5d+TFrCHWybAFT3dWbZuPNlklvKrTG6LxOsF/BJ7+NcI7ICYjrQDFe+ZMVGU+u
         VVtVflRewfFmXRNkon0Q9ZevA+wBEBNGpDPysX0yyyM/jFnXL+ctsYF4inQBbF8/st
         Qe2TPEkWMf88sd9XFODQrpyxLyLRJ6BCM4b20jxdyQ8YwqIXTExSbZsl0WmrLdojBO
         TUcuEFf5ocpbigoQXFRPl1mC23s6JuqsSOyZfp8rQLCq93PiKaPXWX4h8fhotQrF+P
         njLNaMoi4uEZqSyxaLZ+vUUJQwMTIvnKxlTs68GPx6nWBvcQrxdHYHHkwB5K5WFF58
         3prbvPPZfr4RA==
Date:   Thu, 9 Dec 2021 09:59:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     "qizhong.cheng" <qizhong.cheng@mediatek.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
        lorenzo.pieralisi@arm.com, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chuanjia.liu@mediatek.com, maz@kernel.org, alyssa@rosenzweig.io,
        luca@lucaceresoli.net
Subject: Re: [RESEND PATCH v2] PCI: mediatek: Delay 100ms to wait power and
 clock to become stable
Message-ID: <20211209155950.GA238105@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211209130034.z3d47hc4qzsrc3mt@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 09, 2021 at 02:00:34PM +0100, Pali Rohár wrote:
> On Thursday 09 December 2021 19:51:03 qizhong.cheng wrote:
> > On Wed, 2021-12-08 at 11:18 +0100, Pali Rohár wrote:
> > > On Wednesday 08 December 2021 14:07:57 qizhong.cheng wrote:
> > > > On Tue, 2021-12-07 at 22:12 -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Dec 07, 2021 at 10:00:43PM +0100, Mark Kettenis wrote:
> > > > > > > Date: Tue, 7 Dec 2021 11:54:16 -0600
> > > > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > > > 
> > > > > > > [+cc Marc, Alyssa, Mark, Luca for reset timing questions]
> > > > > > 
> > > > > > Hi Bjorn,
> > > > > > 
> > > > > > > On Tue, Dec 07, 2021 at 04:41:53PM +0800, qizhong cheng
> > > > > > > wrote:
> > > > > > > > Described in PCIe CEM specification sections 2.2 (PERST#
> > > > > > > > Signal) and
> > > > > > > > 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of
> > > > > > > > PERST#
> > > > > > > > should
> > > > > > > > be delayed 100ms (TPVPERL) for the power and clock to
> > > > > > > > become
> > > > > > > > stable.
> > > > > > > > 
> > > > > > > > Signed-off-by: qizhong cheng <qizhong.cheng@mediatek.com>
> > > > > > > > Acked-by: Pali Rohár <pali@kernel.org>
> > > > > > > 
> > > > > > > ...
> > > > 
> > > > 1)
> > > > 2)
> > > > Thanks for your reminding and suggestion.
> > > > 
> > > > > > > 3) Most importantly, this needs to be reconciled with the
> > > > > > > similar
> > > > > > > change to the apple driver:
> > > > > > > 
> > > > > > >   
> > > > > > > https://lore.kernel.org/r/20211123180636.80558-2-maz@kernel.org
> > > > > > > 
> > > > > > > In the apple driver, we're doing:
> > > > > > > 
> > > > > > >   - Assert PERST#
> > > > > > >   - Set up REFCLK
> > > > > > >   - Sleep 100us (T_perst-clk, CEM r5 2.2, 2.9.2)
> > > > > > >   - Deassert PERST#
> > > > > > >   - Sleep 100ms (not sure there's a name? PCIe r5 6.6.1)
> > > > > > > 
> > > > > > > But here in mediatek, we're doing:
> > > > > > > 
> > > > > > >   - Assert PERST#
> > > > > > >   - Sleep 100ms (T_pvperl, CEM r5 2.2, 2.2.1, 2.9.2)
> > > > > > >   - Deassert PERST#
> > > > > > > 
> > > > > > > My questions:
> > > > > > 
> > > > > > My understanding of the the Apple PCIe hardware is somewhat
> > > > > > limited
> > > > > > but:
> > > > > > 
> > > > > > >   - Where does apple enforce T_pvperl?  I can't tell where
> > > > > > > power
> > > > > > > to
> > > > > > >     the slot is turned on.
> > > > > > 
> > > > > > So far all available machines only have PCIe devices that are
> > > > > > soldered
> > > > > > onto the motherboard, so there are no "real" slots.  As far as
> > > > > > we
> > > > > > can
> > > > > > tell the PCIe power domain is already powered on at the point
> > > > > > where
> > > > > > the m1n1 bootloader takes control.  There is a GPIO that
> > > > > > controls
> > > > > > power to some devices (WiFi, SDHC on the M1 Pro/Max laptops)
> > > > > > and
> > > > > > those
> > > > > > devices are initially powered off.  The Linux driver doesn't
> > > > > > currently
> > > > > > attempt to power these devices on, but U-Boot will power them
> > > > > > on if
> > > > > > the appropriate GPIO is defined in the device tree.  The way
> > > > > > this
> > > > > > is
> > > > > > specified in the device tree is still under discussion.
> > > > > 
> > > > > Does this mean we basically assume that m1n1 and early Linux boot
> > > > > takes at least the 100ms T_pvperl required by CEM sec 2.2, but we
> > > > > take
> > > > > pains to delay the 100us T_perst-clk?  That seems a little weird,
> > > > > but
> > > > > I guess it is clear that REFCLK is *not* enabled before we enable
> > > > > it,
> > > > > so we do need at least the 100us there.
> > > > > 
> > > > > It also niggles at me a little that the spec says T_pvperl starts
> > > > > from
> > > > > *power stable* (not from power enable) and T_perst-clk starts
> > > > > from
> > > > > *REFCLK stable* (not REFCLK enable).  Since we don't know the
> > > > > time
> > > > > from enable to stable, it seems like native drivers should add
> > > > > some
> > > > > circuit-specific constants to the spec values.
> > > > > 
> > > > 
> > > > Reset of endpoint card via PERST# signal is defined in PCIe CEM r5
> > > > 2.2:
> > > > "On power-up, the de-assertion of PERST# is delayed 100 ms
> > > > (TPVPERL)
> > > > from the power rails achieving specified operating limits. Also,
> > > > within
> > > > this time, the reference clocks (REFCLK+, REFCLK-) also become
> > > > stable,
> > > > at least TPERST-CLK before PERST# is de-asserted."
> > > > 
> > > > - Tpvperl - PERST# must remain active at least this long after
> > > > power
> > > > becomes valid
> > > > 
> > > > Initialize steps as following(please correct me if I'm wrong):
> > > >  1) Enable main power
> > > >  2) Assert PERST#
> > > >  3) Sleep 100ms (TPVPERL, within this time, the REFCLK and power
> > > > also
> > > > become stable)(CEM r5 figure 8: power up)
> > > >  4) Deassert PERST#
> > > >  5) wait until link training completes by software polling the Data
> > > > Link Layer Link Active bit
> > > >  6) if speed is greater than 5GT/s, wait another 100ms
> > > 
> > > Hello! About month ago I was investigating correct order of
> > > steps and I wrote email about it, please look at it:
> > > 
> > https://lore.kernel.org/linux-pci/20211022183808.jdeo7vntnagqkg7g@pali/
> > 
> > Hi Pali,
> > 
> > Thanks for your investigating.
> > Modify the code to refer to your steps as following(please correct me
> > if I'm wrong):
> > 1) pcie_assert_reset();
> > 2) pcie_power_on();
> > 3) pcie_setup_refclk();
> > 4) msleep(100);
> > 5) pcie_deassert_reset();
> > 6) polling_link_active_bit();
> > 7) msleep(100);
> 
> If I understood it correctly then above steps should be OK.
> 
> > > > > > >   - Where does mediatek enforce the PCIe sec 6.6.1 delay
> > > > > > >   after deasserting PERST# and before config requests?
> > > > 
> > > > Software can determine when Link training completes by polling
> > > > the Data Link Layer Link Active bit for maximum 100ms.
> > > 
> > > My understanding is that it is needed to wait another 100ms
> > > _after_ link training completes.
> > 
> > I still have some doubt the two cases that the spec proposes to be
> > greater than 5GT/s and not greater than 5GT/s, and even divided
> > into two paragraphs.(spec r6.6.1)
> 
> IIRC support for DLLA bit was introduced in PCIe base spec 3.0,
> which also introduced support for 8GT/s (= greater than 5GT/s). I
> guess that split between "not grater than 5GT/s" and "greater than
> 5GT/s" could be due to fact that on older HW there do not have to be
> support for DLLA bit and so SW does not have generic way to check if
> link training completed. This is how I see it, I may be wrong. But
> there can be controller specific way how to access link training
> state, which lot of pcie drivers already do. If I'm looking at
> comparison of "not greater than 5GT/s" and "greater than 5GT/s", the
> only difference is that "grater than 5GT/s" has additional
> requirement to wait until link training completes.
> 
> Therefore I would suggest following: if your PCIe HW can provide
> link training status also for devices "not greater than 5GT/s" then
> wait for link training complete also for them. And so do not
> distinguish between "not greater than 5GT/s" and "greater than
> 5GT/s" at all.
> 
> But this is just my opinion.
> 
> Bjorn, do you have any other comments regarding this? Or maybe
> different opinion how it should be handled?

IIUC, you're proposing something like this:

  deassert PERST#
  if (device advertises PCI_EXP_LNKCAP_DLLLARC) {
    poll until PCI_EXP_LNKSTA_DLLLA is set
  } 
  wait 100ms
  issue config request

I'm sure the spec would have said "if the device advertises
PCI_EXP_LNKCAP_DLLLARC, wait 100ms after PCI_EXP_LNKSTA_DLLLA is set"
if that were the intent, because that's the obvious wording.

But the spec calls out > 5 GT/s links specifically, and the physical
encoding changed significantly for those links (128b/130b encoding
instead of 8b/10b, etc), so it's plausible that they may require more
time for training.

Hotplug ports have always been required to advertise
PCI_EXP_LNKCAP_DLLLARC, and if they only support 5 GT/s or less, they
would not require more training time.

So I'm inclined to decide based on the max link speed instead of
PCI_EXP_LNKCAP_DLLLARC.  pci_bridge_wait_for_secondary_bus() does
something similar.

If we decide based on PCI_EXP_LNKCAP_DLLLARC, I guess the down side is
that we'll wait longer than necessary for ports like gen2 hotplug
ports.  Probably not a huge deal, since we only wait an extra link
training time, but why do it differently than what the spec says?
Would it make the implementation significantly simpler?

> > > > > > >   - Does either apple or mediatek support speeds greater than
> > > > > > > 5
> > > > > > > GT/s,
> > > > > > >     and if so, shouldn't we start the sec 6.6.1 100ms delay
> > > > > > > *after*
> > > > > > >     Link training completes?
> > > > > > 
> > > > > > The Apple hardware advertises support for 8 GT/s, but all the
> > > > > > devices
> > > > > > integrated on the Mac mini support only 2.5 GT/s or 5 GT/s.
> > > > > 
> > > > > The spec doesn't say anything about what the downstream devices
> > > > > support (obviously it can't because we don't *know* what those
> > > > > devices
> > > > > are until after we enumerate them).  So to be pedantically
> > > > > correct,
> > > > > I'd argue that we should pay attention to what the Root Port
> > > > > advertises.  Of course, I don't think we do this correctly
> > > > > *anywhere*
> > > > > today.
> > > > 
> > > > Thanks
