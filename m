Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B7F534621
	for <lists+linux-pci@lfdr.de>; Wed, 25 May 2022 23:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiEYV5o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 May 2022 17:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiEYV5n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2022 17:57:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CD4B8BFA;
        Wed, 25 May 2022 14:57:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16C4C61AC2;
        Wed, 25 May 2022 21:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299DAC385B8;
        Wed, 25 May 2022 21:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653515861;
        bh=LX20+QZZxM2G5xQ2EcmXl+cIxppSf56YnZwziPZLmts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dBv2TKRnilrhMIZdMoLxLfq2KT55fIqOzS1KPIrHU31yeDkVvV4XvNoQf8/tLAPgs
         GiKBZf/iVZIw0rF/4kBQc7Pw0UnvBbKXwjGyDv2+ChG9kbZ8k/IiSEydRKC5QZ3QK0
         1fNBy8mD8G01y1dnkpWDgczJMIzrGsRXgUxtCekQR6fwimyEIOxmn4ssaWa1hD+ebW
         toestfEK530B5GYBXnHZTKBPXjVyh2nvSdAhX7XQs43811cJbxdg4hAHSWI/KuLe5D
         FwhLZJFTvsgsahpdRb/+u8OU/Z4YWk6mJUG7jAazzIILfdT7gIx0Rk3XI5SHSBSwYv
         jFlx9gD9eE70g==
Date:   Wed, 25 May 2022 16:57:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe
 linkup
Message-ID: <20220525215739.GA275957@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBsEjkbdWCB4D22iamPr7YP0qUX=M1dZNNgxkfk1EwjjZQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 24, 2022 at 12:54:48PM -0400, Jim Quinlan wrote:
> On Mon, May 23, 2022 at 6:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Sat, May 21, 2022 at 02:51:42PM -0400, Jim Quinlan wrote:
> > > On Sat, May 21,
> > > 2CONFIG_INITRAMFS_SOURCE="/work3/jq921458/cpio/54-arm64-rootfs.cpio022
> > > at 12:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Wed, May 18, 2022 at 03:42:11PM -0400, Jim Quinlan wrote:
> > > > > commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice
> > > > > voltage regulators")
> > > > >
> > > > > introduced a regression on the PCIe RPi4 Compute Module.  If the
> > > > > PCIe endpoint node described in [2] was missing, no linkup would
> > > > > be attempted, and subsequent accesses would cause a panic
> > > > > because this particular PCIe HW causes a CPU abort on illegal
> > > > > accesses (instead of returning 0xffffffff).
> > > > >
> > > > > We fix this by allowing the DT endpoint subnode to be missing.
> > > > > This is important for platforms like the CM4 which have a
> > > > > standard PCIe socket and the endpoint device is unknown.

> > But above you say it's the *endpoint* node that doesn't exist.  The
> > existing code looks like it's checking for the *bridge* node
> > (bus->dev->of_node).  We haven't even enumerated the devices on the
> > child bus, so we don't know about them at this point.
>
> You are absolutely correct and I must change the commit message
> to say the "root port DT node".   I'm sorry; this mistake likely did not
> help you understand the fix. :-(

Great, that will help me out!  I think including the relevant DT
snippet would also make it more concrete and might conceivably be
helpful to somebody working around it on a kernel without the fix.

> > What happens if there is a DT node for the bridge, but it doesn't
> > describe any regulators?  I assume regulator_bulk_get() will fail, and
> > it looks like that might still keep us from bringing the link up?
>
> The regulator_bulk_get() func does not fail if the regulators are
> not present.  Instead it "gets" a dummy device and issues a warning
> per missing regulator.  A version of my pullreq submitted code to
> prescan the DT node and call regulator_bulk_get() with only the
> names of the regulators present, but IIRC this was NAKd.  Hopefully
> I will not be swamped with RPi developers' emails when they think
> these warnings are an issue.

Ah, I see, this is the IS_ERR (but not -ENODEV) NORMAL_GET case in
_regulator_get().  You might get some emails, but I guess it must be a
fairly common situation :)

> > > >  What happens if we turn on the power but don't find any
> > > >  downstream devices?
> > >
> > > They are turned off to conserve power.
> ...

> When brcm_pcie_add_bus() is invoked, we will "get" and enable any
> regulators that are present in the DT node.  If the busno==1, we will
> will also attempt pcie-linkup.  If PCIe linkup fails, which can happen for
> multiple reasons but most due to a  missing device, we turn
> on "refusal" mode to prevent our unforgiving PCIe HW from causing an
> abort on any subsequent PCIe config-space accesses.

> Further, a failed linkup will have brcm_pcie_probe() stopping and
> removing the root bus, which in turn invokes  brcm_pcie_remove_bus()
> (actually named pci_subdev_regulators_remove_bus() as it may someday
> find its way into bus.c), which invokes regulator_bulk_disable() on
> any regulators that were enabled by the probe.

Ah, thanks!  This is the detail I missed.  If pci_host_probe()
succeeds and the link is down, we call brcm_pcie_remove() (the
driver's .remove() method).  That's unusual and possibly unique among
native host bridge drivers.  I'm not sure that's the best pattern
here.  Most drivers can't do that because they expect multiple devices
on the root bus.  And the Root Port is still a functional device on
its own, even if its link is down.  Users likely expect to see it in
lspci and manipulate it via setpci.  It may have AER logs with clues
about why the link didn't come up.

Again something for future discussion, not for this regression.

> Unless you object, I plan on sending you a v2 of my regression fix
> which will correct the commit message, change the "if (busno == 1)"
> conditional to only guard the pcie linkup call, and add further
> comments.

I don't really *like* comparing "busno == 1" because the root bus
number is programmable on most devices.  It would be more obvious if
we could test for a Root Port directly.  But maybe it's the best we
can do for now.

Someday it seems like we should figure out how to make the PCI core
smart enough to turn on any regulators for devices below the Root Port
when we put the Root Port in D0.  But I don't know how to do that or
even whether it's feasible.

Bjorn
