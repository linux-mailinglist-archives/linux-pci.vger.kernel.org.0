Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8A34AFAD7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 19:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbiBISle (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 13:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbiBISk2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 13:40:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B5FC03E92D;
        Wed,  9 Feb 2022 10:39:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96B70B82384;
        Wed,  9 Feb 2022 18:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC95C340E9;
        Wed,  9 Feb 2022 18:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644431988;
        bh=0CUNFDq1i8SMYF2bfSV/C/M1uogY/iqh5qhEyXLr8kA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WbAuiMszliganrStT1NXHJce/DBmAI7MzT/RPt+oRna9pXiYTF7iSZeJaYdsDBeLa
         sMZjj5vmEZxk3yK2BxCdcepZUY81d60UaqcXH9ugrfohUIenfY+I+s1Xw7WA1kA/Ll
         eyiH4ic7gvMwnJOPWIFwYFUBfHSiIcbmz/+YKbKuESfAqycz5AC+5aN68AwI9HVMxe
         CS5TMRGCJNym9zZb/pa1hJ0hin9dki1IRknwFSEFlKJpxC9Q6WoFnceGquuUHmZvog
         H+/ImzyTDVyrjjtfTZkuA+/hi6BvVVQ316V8d+ieXNxN94e4Bg8SHqGs6Us97/3nPl
         gygEKr7Cqum3Q==
Date:   Wed, 9 Feb 2022 12:39:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rajat Jain <rajatja@google.com>, Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/2] PCI: Allow internal devices to be marked as
 untrusted
Message-ID: <20220209183945.GA571585@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgNVJKy0s8MGBRoa@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 09, 2022 at 06:46:12AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 08, 2022 at 04:23:27PM -0800, Rajat Jain wrote:
> > On Tue, Feb 1, 2022 at 6:01 PM Rajat Jain <rajatja@google.com> wrote:
> > >
> > > Today the pci_dev->untrusted is set for any devices sitting downstream
> > > an external facing port (determined via "ExternalFacingPort" or the
> > > "external-facing" properties).
> > >
> > > However, currently there is no way for internal devices to be marked as
> > > untrusted.
> > >
> > > There are use-cases though, where a platform would like to treat an
> > > internal device as untrusted (perhaps because it runs untrusted firmware
> > > or offers an attack surface by handling untrusted network data etc).
> > >
> > > Introduce a new "UntrustedDevice" property that can be used by the
> > > firmware to mark any device as untrusted.
> > 
> > Just to unite the threads (from
> > https://www.spinics.net/lists/linux-pci/msg120221.html). I did reach
> > out to Microsoft but they haven't acknowledged my email. I also pinged
> > them again yesterday, but I suspect I may not be able to break the
> > ice. So this patch may be ready to go in my opinion.
> > 
> > I don't see any outstanding comments on this patch, but please let me
> > know if you have any comments.
> > 
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > ---
> > > v2: * Also use the same property for device tree based systems.
> > >     * Add documentation (next patch)
> > >
> > >  drivers/pci/of.c       | 2 ++
> > >  drivers/pci/pci-acpi.c | 1 +
> > >  drivers/pci/pci.c      | 9 +++++++++
> > >  drivers/pci/pci.h      | 2 ++
> > >  4 files changed, 14 insertions(+)
> > >
> > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > index cb2e8351c2cc..e8b804664b69 100644
> > > --- a/drivers/pci/of.c
> > > +++ b/drivers/pci/of.c
> > > @@ -24,6 +24,8 @@ void pci_set_of_node(struct pci_dev *dev)
> > >                                                     dev->devfn);
> > >         if (dev->dev.of_node)
> > >                 dev->dev.fwnode = &dev->dev.of_node->fwnode;
> > > +
> > > +       pci_set_untrusted(dev);
> > >  }
> > >
> > >  void pci_release_of_node(struct pci_dev *dev)
> > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > index a42dbf448860..2bffbd5c6114 100644
> > > --- a/drivers/pci/pci-acpi.c
> > > +++ b/drivers/pci/pci-acpi.c
> > > @@ -1356,6 +1356,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> > >
> > >         pci_acpi_optimize_delay(pci_dev, adev->handle);
> > >         pci_acpi_set_external_facing(pci_dev);
> > > +       pci_set_untrusted(pci_dev);
> > >         pci_acpi_add_edr_notifier(pci_dev);
> > >
> > >         pci_acpi_add_pm_notifier(adev, pci_dev);
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 9ecce435fb3f..41e887c27004 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -6869,3 +6869,12 @@ static int __init pci_realloc_setup_params(void)
> > >         return 0;
> > >  }
> > >  pure_initcall(pci_realloc_setup_params);
> > > +
> > > +void pci_set_untrusted(struct pci_dev *pdev)
> > > +{
> > > +       u8 val;
> > > +
> > > +       if (!device_property_read_u8(&pdev->dev, "UntrustedDevice", &val)

If we do this, can we combine it with set_pcie_untrusted(), where we
already set pdev->untrusted?  Maybe that needs to be renamed; I don't
see anything PCIe-specific there, and it looks like it works for
conventional PCI as well.

> Please no, "Untrusted" does not really convey much, if anything here.
> You are taking an odd in-kernel-value and making it a user api.
> 
> Where is this "trust" defined?  Who defines it?  What policy does the
> kernel impose on it?

I'm a bit hesitant about this, too.  It really doesn't have anything
in particular to do with the PCI core.  It's not part of the PCI
specs, and it could apply to any kind of device, not just PCI (ACPI,
platform, USB, etc).

We have:

  dev->removable                # struct device
  pdev->is_thunderbolt
  pdev->untrusted
  pdev->external_facing

and it feels a little hard to keep everything straight.  Most of them
are "discovered" based on some DT or ACPI firmware property.  None of
them really has anything specifically to do with *PCI*, and I don't
think the PCI core depends on any of them.  I think
pdev->is_thunderbolt is the only one we discover based on a PCI
feature (the Thunderbolt Capability), and the things we *use* it for
are actually not things specified by that capability [1].

Could drivers just look for these properties directly instead of
relying on the PCI core to get in the middle?  Most callers of
device_property_read_*() are in drivers.  I do see that doing it in
the PCI core might help enforce standard usage in DT/ACPI, but we
could probably do that in other ways, too.

Bjorn

[1] https://lore.kernel.org/r/20220204222956.GA220908@bhelgaas
