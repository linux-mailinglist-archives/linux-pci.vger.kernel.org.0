Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B137648A52
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 22:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiLIVsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 16:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIVsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 16:48:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9045E1581B
        for <linux-pci@vger.kernel.org>; Fri,  9 Dec 2022 13:48:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B52662298
        for <linux-pci@vger.kernel.org>; Fri,  9 Dec 2022 21:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59523C433D2;
        Fri,  9 Dec 2022 21:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670622517;
        bh=M7ekN4tqr0DAKabdAy7RH5C9B886BBLT+/wHR/tEVK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rLC0nu83CgRKQIKXvZsKVq4FiQOHQcoHr6k0xe3ohL0XN58X1NPQVqoQNRAqEoAJ+
         Hl3RwMpf0WlbL04L6GnBVelceZorLdqTzT1MUYUY41WX0Gu6QCA8f5G8EoMlGbvO4c
         T6aYcBa+FfgxHsHpl0K0VvuU2FiQyQFABCQbNeO8OEgjV1eeNQTe2i9vTSdnmMJ+83
         GMRxXaebJxvwuftk8OlXamkKWAoF03+W6jGgM/I1SdzJrnSX4+b25yOyOgPUcJB8bl
         xkezDeZow+t5QR1vE6QN9V36AcCkMyTvPqqgHn2GQRz0cCzJr/ecFAymQvt4Xc4o5Y
         uToazLjZXT71Q==
Date:   Fri, 9 Dec 2022 15:48:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Do not require an interrupt for all AER
 capable ports
Message-ID: <20221209214835.GA1734545@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cd41027-bda8-a57a-ea18-33308fd681f1@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 01:04:22PM -0800, Sathyanarayanan Kuppuswamy wrote:
> On 12/9/22 9:07 AM, Bjorn Helgaas wrote:
> > On Wed, Dec 07, 2022 at 10:41:05AM +0200, Mika Westerberg wrote:
> >> Only Root Ports and Event Collectors use MSI for AER. PCIe Switch ports
> >> or endpoints on the other hand only send messages (that get collected by
> >> the former). For this reason do not require PCIe switch ports and
> >> endpoints to use interrupt if they support AER.
> >>
> >> This allows portdrv to attach PCIe switch ports of Intel DG1 and DG2
> >> discrete graphics cards. These do not declare MSI or legacy interrupts.
> >>
> >> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > Thanks for the additional info!  This seems like something we should
> > definitely do.
> > 
> > I'm wondering whether we should check for this in
> > get_port_device_capability().  It already has similar checks for
> > device type for other services.  This would skip pci_set_master() for
> > these non-RP, non-RCEC devices, which is probably harmless, since I
> > assume we only need that to make sure MSI works.
> 
> Currently, we only have high level (cap or enable/disable) checks in 
> get_port_device_capability(). Why bring in more AER specific checks
> there and make it complicated? Is there any benefit in doing this?

Thanks a lot for taking a look!

I agree, I hate how complicated the expressions in
get_port_device_capability() are, but I don't think my idea is
significantly worse than what's already there.

Here's some existing code from get_port_device_capability():

        /* Root Ports and Root Complex Event Collectors may generate PMEs */
        if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
             pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
            (pcie_ports_native || host->native_pme)) {
                services |= PCIE_PORT_SERVICE_PME;

And here's what the corresponding AER code would look like:

        if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
             pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
            dev->aer_cap && pci_aer_available() &&
            (pcie_ports_native || host->native_aer))
                services |= PCIE_PORT_SERVICE_AER;

I do have some ideas about simplifying these, see below.

The benefits would be to make similar checks in the same place, avoid
setting Bus Master when we don't need it, and remove the AER child
service for non-RP/RCECs (it wouldn't appear in sysfs and they
wouldn't be eligible for PCIE_PORT_SERVICE_AER registration).

> > It would also prevent allocation of the AER service for non-RP,
> > non-RCEC devices.  That's also probably harmless, since aer_probe()
> > ignores those devices anyway.
> > 
> > What do you think of something like this?  (This is based on my
> > pci/portdrv branch which squashed everything into portdrv.c:
> > https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/portdrv)
> > 
> > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > index a6c4225505d5..8b16e96ec15c 100644
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -232,7 +232,9 @@ static int get_port_device_capability(struct pci_dev *dev)
> >  	}
> >  
> >  #ifdef CONFIG_PCIEAER
> > -	if (dev->aer_cap && pci_aer_available() &&
> > +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > +             pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
> > +	    dev->aer_cap && pci_aer_available() &&
> >  	    (pcie_ports_native || host->native_aer))
> >  		services |= PCIE_PORT_SERVICE_AER;
> >  #endif
> 
> If you want to do it, will you remove the relevant check in AER driver
> probe?

That would be a good idea, although I was hoping to squeeze this into
v6.2, and I would probably postpone the rest until the next cycle.

I think aer_probe() could also be simplified by dropping the
set_downstream_devices_error_reporting() stuff.  pci_aer_init()
already takes care of that, IIUC, and that's a more natural place for
it since it handles the hot-add case.

There may also be opportunity to simplify some of these ugly checks of
pci_aer_available(), pcie_ports_native, and host->native_aer that are
littered all over the place by doing them in pci_aer_init() and
setting dev->aer_cap only if they are satisfied.

Bjorn
