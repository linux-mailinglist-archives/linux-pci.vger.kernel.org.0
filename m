Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748DC5873D4
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 00:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiHAWTV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 18:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiHAWTV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 18:19:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549F731230;
        Mon,  1 Aug 2022 15:19:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFD2C60BEF;
        Mon,  1 Aug 2022 22:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9BCC433C1;
        Mon,  1 Aug 2022 22:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659392359;
        bh=VuPZOuf958xM5rF1x2Ju4XLPmq5AxRetWWzkWL1/+Fk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DxSO+c25Vg0xVxE7Lrl7QO2SU3lL52zhFS8MLWxj5Cy3hfz1SugSQVkH8pL4Sy/Nl
         3eIrhkFHyzv+rWZ19rsgm3SGNRPi9bxk+aA3mm3OI5AKyQGyF1XwoUlIVtK5bSwEA4
         U6wSVLbtXPYI+ASn7WzkT5AUXyvdJUxePq4P8uetsVTpk3pYPcYzZBFuHdoXGr9tFT
         nnEYiv+bI7DgvPamuvoWI9UlFm3n+2iW1wQo12l4AXzYwR+J1bOCi5D9kburAzRd4+
         8NONz0roqE4F9W5UD5RGKRy3QF/sicW8vQrwK7dxadQlz71JKlLENpI47k9WnfuNb1
         sexri8nPrEmdw==
Date:   Mon, 1 Aug 2022 17:19:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Cyril Brulebois <kibi@debian.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 0/7] PCI: brcmstb: Re-submit reverted patchset
Message-ID: <20220801221916.GA677562@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4af7c132-1100-3d48-2311-e6be3bdf3629@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 26, 2022 at 04:41:09PM -0700, Florian Fainelli wrote:
> On 7/26/22 15:03, Bjorn Helgaas wrote:
> > On Mon, Jul 25, 2022 at 11:12:49AM -0400, Jim Quinlan wrote:
> >> ...
> >> Jim Quinlan (7):
> >>   PCI: brcmstb: Remove unnecessary forward declarations
> >>   PCI: brcmstb: Split brcm_pcie_setup() into two funcs
> >>   PCI: brcmstb: Gate config space access on link status
> >>   PCI: brcmstb: Add mechanism to turn on subdev regulators
> >>   PCI: brcmstb: Add control of subdevice voltage regulators
> >>   PCI: brcmstb: Do not turn off WOL regulators on suspend
> >>   PCI: brcmstb: Have .map_bus function names end with 'map_bus'
> >>
> >>  drivers/pci/controller/pcie-brcmstb.c | 476 ++++++++++++++++++--------
> >>  1 file changed, 341 insertions(+), 135 deletions(-)
> > 
> > I reworked these and put them on pci/ctrl/brcm for v5.20.  This is a
> > proposal, not something set in stone.  But time is of the essence to
> > figure out how we want to proceed.
> > 
> > I changed a lot of stuff and it's likely I broke something in the
> > process, so please take a look and test this out.  Here's an outline
> > of what I changed:
> > 
> >   - Moved the config access "link up" check earlier because it's not
> >     related to the power regulator patches.
> > 
> >   - Changed config access "link up" checks to use PCIE_ECAM_REG()
> >     instead of hard-coding 0xfff masks.  The 32-bit accessors already
> >     mask out the low two bits, so we don't need to do that here.
> > 
> >   - Squashed pci_subdev_regulators_add_bus() directly into
> >     brcm_pcie_add_bus() for readability.  Similarly for
> >     pci_subdev_regulators_remove_bus().
> > 
> >   - This makes a clear split between:
> > 
> >     * A patch that adds get/enable of regulators, and starting the
> >       link after enabling regulators, and
> > 
> >     * A patch that disables/enables regulators for suspend/resume.
> > 
> >   - Since we only support one set of subregulator info (for one Root
> >     Port, and brcm_pcie_suspend_noirq() depends on this since it uses
> >     the pcie->sr pointer), use pcie->sr always instead of
> >     dev->driver_data.
> > 
> >   - Squashed wakeup device checking into the suspend/resume patch so
> >     there's not a time when suspend might turn off power to a wakeup
> >     device.
> > 
> >   - Renamed brcm_pcie_map_bus32() to brcm7425_pcie_map_bus() so it
> >     ends in "_map_bus()" like other drivers.  Also,
> >     brcm7425_pcie_map_bus() doesn't actually depend on the 32-bitness.
> 
> Attached is the diff between Jim's and your branch just so it is easier to see what moved around.
> 
> Initial testing on an ARCH_BRCMSTB system with PCIe appears to be good, we don't have any regulator on that board so the dummy ones get picked up which is expected. Same thing with a Raspberry Pi 4B system.
> 
> I could unbind and bind again and there were no reference count leaks on the regulators, so this looks good to me.
> 
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> of course, we should have Jim's test results as well as Cyril's ideally to make sure there are no regressions on the CM4 board.

Cyril, any chance you could test this to be sure it fixes the problem
you reported?  This is in -next and hopefully headed for v5.20/v6.0
soon.

I see that we failed to reference
https://bugzilla.kernel.org/show_bug.cgi?id=215925 in the commit logs,
but IIUC, this *should* fix that.

Bjorn
