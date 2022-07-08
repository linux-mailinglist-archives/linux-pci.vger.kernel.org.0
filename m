Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F9156C389
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 01:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbiGHT7t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 15:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiGHT7s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 15:59:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD09C183A9;
        Fri,  8 Jul 2022 12:59:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 680A0B82953;
        Fri,  8 Jul 2022 19:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9456C341C0;
        Fri,  8 Jul 2022 19:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657310383;
        bh=+AjKQiF4LiPg6oDcpkDj0Ni0dwsq4oPqmWlRHGeGSZ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Vf43t8YXcF3M7+Fm1x/UndCN9D68h7a43YEztdFC5jWE8HfpGO5pyrmhDUXEXh7dA
         qrzG6nqr0eWq1RH/UPJqvzBeNVwKpNjR2Ou0yXZXEsmNAx7dpcFdLKZEef+vWU489s
         krfXv1B+WPRGqsFfggvICptBwv2rsxjV1WQXFp/Jhr9a3TlcsnRF7caTtFX0L++/ZV
         pkATJBeQV8reB39cUkPHd+5og7M+6w2VFSd8PYOyeHc1lmhAG/8EdNztKJc0Viyjh/
         uUO09x/5Xo4oZbk4rVU3Q+pBpYGnPAt0jLFRXB/bZ3K/pJBzGmB8j5NEb72yFDbCg8
         FI+aMvONTtfHA==
Date:   Fri, 8 Jul 2022 14:59:40 -0500
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
Subject: Re: [PATCH v1 1/4] PCI: brcmstb: Split brcm_pcie_setup() into two
 funcs
Message-ID: <20220708195940.GA369714@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNxTYz_yDSbaXc_UKRGr=BxPCa1Lk001uCSmRbVY-WVxvw@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 08, 2022 at 03:40:43PM -0400, Jim Quinlan wrote:
> On Fri, Jul 8, 2022 at 3:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jul 08, 2022 at 09:29:27AM -0400, Jim Quinlan wrote:
> > > On Wed, Jul 6, 2022 at 5:56 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, Jul 01, 2022 at 12:27:22PM -0400, Jim Quinlan wrote:
> > > > > We need to take some code in brcm_pcie_setup() and put it in a new function
> > > > > brcm_pcie_linkup().  In future commits the brcm_pcie_linkup() function will
> > > > > be called indirectly by pci_host_probe() as opposed to the host driver
> > > > > invoking it directly.
> > > > >
> > > > > Some code that was executed after the PCIe linkup is now placed so that it
> > > > > executes prior to linkup, since this code has to run prior to the
> > > > > invocation of pci_host_probe().
> > > >
> > > > This says we need to move some code from brcm_pcie_setup() to
> > > > brcm_pcie_linkup(), but not *why* we need to do that.
> > > I will elaborate in the commit message.
> > > >
> > > > In brcm_pcie_resume(), they're called together:
> > > >
> > > >   brcm_pcie_resume
> > > >     brcm_pcie_setup
> > > >     brcm_pcie_linkup
> > > >
> > > > In the probe path, they're not called together, but they're in the
> > > > same order:
> > > >
> > > >   brcm_pcie_probe
> > > >     brcm_pcie_setup
> > > >     pci_host_probe
> > > >       ...
> > > >         brcm_pcie_add_bus               # bus->ops->add_bus
> > > >           brcm_pcie_linkup
> > > >
> > > > Is there something that must happen *between* them in the probe path?
> > >
> > > Yes.  In the probe() case, we must do things in this order:
> > >
> > > 1. brcm_pcie_setup()
> > > 2. Turn on regulators
> > > 3. brcm_pcie_linkup()
> >
> > Ah, I see, both 2) and 3) happen in brcm_pcie_add_bus:
> >
> >   brcm_pcie_add_bus                    # bus->ops->add_bus
> >     pci_subdev_regulators_add_bus
> >       regulator_bulk_enable            # turn on regulators
> >     brcm_pcie_linkup
> >
> > > Since the voltage regulators are turned on during enumeration,
> > > pci_host_probe() must be invoked prior to 3.  Before regulators, we
> > > did not care.
> >
> > I guess in the pre-regulator case, i.e., pcie->sr not set, the power
> > for downstream devices must always be on.
> >
> > > In the resume case, there is no enumeration of course but our driver
> > > has a handle to the regulators and can turn them on/off w/o help.
> >
> > And I guess we don't need brcm_pcie_setup() in the resume path because
> > suspend turns off power only for downstream devices, not for the root
> > port itself, so the programming done by brcm_pcie_setup() doesn't need
> > to be done again.
> 
> I'm not sure I understand what you are saying -- brcm_pcie_setup()  is
> called by brcm_pcie_resume()
> because it is needed.  brcm_pcie_setup() isn't concerned with power it
>  just does the preparation
> required before attempting link-up.

Oh, sorry, I totally misread that.

But I wonder about the fact that probe and resume do these in
different orders:

  brcm_pcie_probe
    brcm_pcie_setup                          # setup
    pci_host_probe
      ...
        brcm_pcie_add_bus
	  pci_subdev_regulators_add_bus
	    regulator_bulk_enable            # regulators on
	  brcm_pcie_linkup                   # linkup

  brcm_pcie_resume
    regulator_bulk_enable                    # regulators on
    brcm_pcie_setup                          # setup
    brcm_pcie_linkup                         # linkup

Maybe pci_subdev_regulators_add_bus() could be done directly from
brcm_pcie_probe() instead of in brcm_pcie_add_bus()?  If the
regulators must be directly under the root port node in DT, it seems
like it would be reasonable to look for them in the probe path, which
seems like what pcie-dw-rockchip.c, pcie-tegra194.c, and
pcie-rockchip-host.c do.

Or maybe brcm_pcie_resume() should enable the regulators after
brcm_pcie_setup() so it's the same order as the probe path?

Bjorn
