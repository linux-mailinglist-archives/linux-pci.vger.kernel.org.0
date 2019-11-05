Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C6EEFBE2
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 11:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKEKzt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 05:55:49 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61976 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfKEKzt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2019 05:55:49 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 30ed470343694d0c; Tue, 5 Nov 2019 11:55:45 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, Sinan Kaya <okaya@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Andrew Murray <andrew.murray@arm.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
Date:   Tue, 05 Nov 2019 11:55:45 +0100
Message-ID: <11429373.7ySiFsEkgL@kreacher>
In-Reply-To: <20191104173904.GA122794@google.com>
References: <20191104173904.GA122794@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday, November 4, 2019 6:39:04 PM CET Bjorn Helgaas wrote:
> [+cc Andrew, Lukas]
> 
> On Tue, Oct 15, 2019 at 05:44:47PM +0530, Vidya Sagar wrote:
> > On 10/15/2019 4:40 PM, Sinan Kaya wrote:
> > > ...
> > > I think the PCI core should be putting the device back D0 state as one
> > > of the first actions before enumerating. Wake up could be a combination
> > > of ACPI and/or PCI wake up depending on where your device sits in the
> > > topology.
> >
> > Yup. It is indeed doing it as part of pci_power_up() in pci.c file.
> > But, what is confusing to me is the order of the calls.
> > pci_power_up() has following calls in the same order.
> > 	pci_raw_set_power_state(dev, PCI_D0);
> > 	pci_update_current_state(dev, PCI_D0);
> > But, pci_raw_set_power_state() is accessing config space without calling
> > pci_device_is_present() whereas pci_update_current_state() which is called
> > later in the flow is calling pci_device_is_present()...!
> 
> A device should always respond to config reads unless it is in D3cold
> or it is initializing after a reset.  IIUC you're doing a resume, not
> a reset, so I think your device must be coming out of D3cold.  That's
> typically done via ACPI, and I think we are missing some kind of delay
> before our first config access:
> 
>   pci_power_up
>     platform_pci_set_power_state(PCI_D0)    # eg, ACPI
>     pci_raw_set_power_state
>       pci_read_config_word(PCI_PM_CTRL)     # <-- first config access
>       pci_write_config_word(PCI_PM_CTRL)
>       pci_read_config_word(PCI_PM_CTRL)
>     pci_update_current_state
>       if (... || !pci_device_is_present())
> 
> Mika is working on some delays for the transition out of D3cold [1].
> He's more concerned with a secondary bus behind a bridge, so I don't
> think his patch addresses this case, but he's certainly familiar with
> this area.
> 
> Huh, I'm really confused about this, too.  I don't
> understand how resume ever works without any delay between
> platform_pci_power_manageable() and the config reads in
> pci_raw_set_power_state().  I must be missing something.

There is a delay in the runtime_d3cold case, see __pci_start_power_transition().

But overall platform_pci_power_manageable() only checks whether or not the
platform firmware can change the power state of the device.  If it can, it
is expected to take care of any necessary delays while doing that (because
there may be delays required by this particular instance of the platform
firmware, beyond what is mandated by the PCI spec, or there may not be any
need to wait at all).  If the platform firmware becomes responsible for
setting the device's power state, there is not reason why it should not be
responsible for the delay part too.

In any case, I'm not sure how useful it is to add delays for everyone in the
cases in which a specific system needs a delay because of its own PM
implementation limitations.  It may be better to quirk such systems explicitly
as long as there are not too many quirks in there, or we'll end up adding more
and more *implicit* quirks in the form of general delays.

Cheers!



