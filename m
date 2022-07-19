Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B109C57A7EA
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 22:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiGSUDn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 16:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGSUDl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 16:03:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7832639A;
        Tue, 19 Jul 2022 13:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E4A0B81D0F;
        Tue, 19 Jul 2022 20:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821F9C341C6;
        Tue, 19 Jul 2022 20:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658261014;
        bh=jS9jQjpTvmqYvhCTf7jn23RARd5IlPstW3ENMHvmq8g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ahRgqb3cHCCHisn2K9IjgZKpl2nwmI7I0nY3MWiImk8xw0mwb2QiC/97Emk9F1GaZ
         T0CynCKRcV9qOZppEEQ6puxafZHmFo/11Mycxno+u6qlKUxYP4tRdeQDR26AhDMwKi
         nfBxarM2Njjxt+t+4/5WDzqhHyT2W2iMaNIk/d/ZgZx3mtIL8VoECIM95PYbF1VV8r
         fwY4hPaWwnJc8KQVPzW++uRN19zVc0pxtmDvE5YqpMKLe0MGxDpqWrbFkZmmIBhfxG
         tUgI/O7lJtf7QXv27tk8dFHUYcp8wJyq3QN2ZR3UcaBnx8nmlXOk4uvjxYKWkboXU1
         14bG4SztL5tmA==
Date:   Tue, 19 Jul 2022 15:03:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] PCI: brcmstb: Split brcm_pcie_setup() into two
 funcs
Message-ID: <20220719200332.GA1552587@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNz8DTjAMXnWuOd=0W=qa6J4uD03oH3RJezEk1WxaUN1NA@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 19, 2022 at 09:08:48AM -0400, Jim Quinlan wrote:
> On Mon, Jul 18, 2022 at 6:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Jul 18, 2022 at 02:56:03PM -0400, Jim Quinlan wrote:
> > > On Mon, Jul 18, 2022 at 2:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Sat, Jul 16, 2022 at 06:24:49PM -0400, Jim Quinlan wrote:
> > > > > Currently, the function does the setup for establishing PCIe link-up
> > > > > with the downstream device, and it does the actual link-up as well.
> > > > > The calling sequence is (roughly) the following in the probe:
> > > > >
> > > > > -> brcm_pcie_probe()
> > > > >     -> brcm_pcie_setup();                       /* Set-up and link-up */
> > > > >     -> pci_host_probe(bridge);
> > > > >
> > > > > This commit splits the setup function in two: brcm_pcie_setup(), which only
> > > > > does the set-up, and brcm_pcie_start_link(), which only does the link-up.
> > > > > The reason why we are doing this is to lay a foundation for subsequent
> > > > > commits so that we can turn on any power regulators, as described in the
> > > > > root port's DT node, prior to doing link-up.
> > > >
> > > > All drivers that care about power regulators turn them on before
> > > > link-up, but typically those regulators are described directly under
> > > > the host bridge itself.
> > >
> > > Actually, what you describe is what I proposed with my v1 back in Nov 2020.
> > > The binding commit message said,
> > >
> > >     "Quite similar to the regulator bindings found in
> > >     "rockchip-pcie-host.txt", this allows optional regulators to be
> > >     attached and controlled by the PCIe RC driver."
> > >
> > > > IIUC the difference here is that you have regulators described under
> > > > Root Ports (not the host bridge/Root Complex itself), so you don't
> > > > know about them until you've enumerated the Root Ports.
> > > > brcm_pcie_probe() can't turn them on directly because it doesn't know
> > > > what Root Ports are present and doesn't know about regulators below
> > > > them.
> > >
> > > The reviewer's requested me to move the regulator node(s)
> > > elsewhere, and at some point later it was requested to be placed
> > > under the Root Port driver.  I would love to return them under the
> > > host bridge, just say the word!
> >
> > Actually, I think my understanding is wrong.  Even though the PCI core
> > hasn't enumerated the Root Port as a pci_dev, brcm_pcie_setup() knows
> > about it and should be able to look up the regulators and turn them
> > on.
> 
> One can do this with
>         regulator_bulk_get(NULL, ...);
> 
> However, MarkB did not like the idea of a driver getting the
> regulator from the global DT namespace [1].
> 
> For the RC driver, one  cannot invoke  regulator_bulk_get(dev, ...)
> if there is not a direct child regulator node.  One needs to use the
> Port driver device.  The Port driver device does not exist at this
> point unless one tries to prematurely create it; I tried this and it
> was a mess to say the least.
> 
> > Can you dig up the previous discussion about why the regulators need
> > to be under the Root Port and why they can't be turned on before
> > calling pci_host_probe()?
> 
> RobH did not want the regulators to be under the RC as he said their
> DT location should resemble the HW [2].  The consensus evolved to
> place it under the port driver, which can provide a general
> mechanism for turning on regulators anywhere in the PCIe tree.

I don't want to redesign this whole thing.  I just want a crisp
rationale for the commit log.

All other drivers (exynos, imx6, rw-rockchip, histb, qcom, tegra194,
tegra, rockchip-host) have regulators for downstream PCIe power
directly under the RC.  If putting the regulators under an RP instead
is the direction of the future, I guess that might be OK, and I guess
the reasons are:

  1) Slot or device power regulators that are logically below the RP
     should be described that way in the DT.

  2) Associating regulators with a RP allows the possibility of
     selectively controlling power to slots/devices below the RP,
     e.g., to power down devices below RP A when suspending while
     leaving wakeup devices below RP B powered up.

I think in your case the motivating reason is 2).

Your commit log for "Add mechanism to turn on subdev regulators"
suggests that you want some user control of endpoint power, e.g., via
sysfs, but I don't see that implemented yet except possibly via a
"remove" file that would unbind the driver and remove the entire
device.

> [1] https://lore.kernel.org/linux-pci/20210329162539.GG5166@sirena.org.uk/
> [2] https://lore.kernel.org/linux-pci/CAL_JsqKPKk3cPO8DG3FQVSHrKnO+Zed1R=PV7n7iAC+qJKgHcw@mail.gmail.com/
