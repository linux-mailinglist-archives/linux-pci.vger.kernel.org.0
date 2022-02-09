Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCFB4AFC11
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 19:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbiBISyH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 13:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbiBISxK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 13:53:10 -0500
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA08C102FF2;
        Wed,  9 Feb 2022 10:49:17 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 192so8598252ybd.10;
        Wed, 09 Feb 2022 10:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PeOBJrYtsjvPzGhlpO3z8teLSXpq96u2HwrZLSm0an8=;
        b=5XDWh2dOhoL6Ol0/kOfYT7mgRqpXKg/IKPaDBPMy+kd2tJIc0fNTkuKhtDqI8dzdtt
         1qSi5feQ9kbfSCuiIOOjBOFSgoeIo+idyq94OGJbCKKsJQ4IEUcR2nuulYIDm/W4+LyH
         zHK//Ke7D7+GeQljH1CfRuiHtlDhHMIme/3fLEUE4O4XTR5wxRMRDF9dOKnDGwPVN5hV
         SVop8iK2qdAZzBo/K6iCfQnWMFmuwgzA8XuU14vDFcXfTjk3wwfj1Pt//5HblHc4RzyA
         UgPbAS2OEVm4etsx99SjozUHbMuTxXOGB6nJWp/llsKWNMWy0eZhY3MKcLbm/crFjzGr
         6YQQ==
X-Gm-Message-State: AOAM531xekNT6m0AjXbBwqA+/H66HIefQ1bhnBMSMgr/tW1cEScObg9Z
        CBmNZJbM77XRwN24e0M2zctFky6g0i5NLDLaaPM=
X-Google-Smtp-Source: ABdhPJwT5FFqJKpGThs/6Gz9A6AC9UjzXMebOSEosJc0cqXyWoHchf77I20XaY5BX8aA9+P+ZYYkRMCnsz8ehXMYR88=
X-Received: by 2002:a81:e109:: with SMTP id w9mr3587221ywh.515.1644432556190;
 Wed, 09 Feb 2022 10:49:16 -0800 (PST)
MIME-Version: 1.0
References: <YgNVJKy0s8MGBRoa@kroah.com> <20220209183945.GA571585@bhelgaas>
In-Reply-To: <20220209183945.GA571585@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Feb 2022 19:49:05 +0100
Message-ID: <CAJZ5v0hYFRe-HseDnqh4AFpBzzmAjx9nfJo2yC5o=jzbWUqqOw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Allow internal devices to be marked as untrusted
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 9, 2022 at 7:39 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Feb 09, 2022 at 06:46:12AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Feb 08, 2022 at 04:23:27PM -0800, Rajat Jain wrote:
> > > On Tue, Feb 1, 2022 at 6:01 PM Rajat Jain <rajatja@google.com> wrote:
> > > >
> > > > Today the pci_dev->untrusted is set for any devices sitting downstream
> > > > an external facing port (determined via "ExternalFacingPort" or the
> > > > "external-facing" properties).
> > > >
> > > > However, currently there is no way for internal devices to be marked as
> > > > untrusted.
> > > >
> > > > There are use-cases though, where a platform would like to treat an
> > > > internal device as untrusted (perhaps because it runs untrusted firmware
> > > > or offers an attack surface by handling untrusted network data etc).
> > > >
> > > > Introduce a new "UntrustedDevice" property that can be used by the
> > > > firmware to mark any device as untrusted.
> > >
> > > Just to unite the threads (from
> > > https://www.spinics.net/lists/linux-pci/msg120221.html). I did reach
> > > out to Microsoft but they haven't acknowledged my email. I also pinged
> > > them again yesterday, but I suspect I may not be able to break the
> > > ice. So this patch may be ready to go in my opinion.
> > >
> > > I don't see any outstanding comments on this patch, but please let me
> > > know if you have any comments.
> > >
> > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > ---
> > > > v2: * Also use the same property for device tree based systems.
> > > >     * Add documentation (next patch)
> > > >
> > > >  drivers/pci/of.c       | 2 ++
> > > >  drivers/pci/pci-acpi.c | 1 +
> > > >  drivers/pci/pci.c      | 9 +++++++++
> > > >  drivers/pci/pci.h      | 2 ++
> > > >  4 files changed, 14 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > > index cb2e8351c2cc..e8b804664b69 100644
> > > > --- a/drivers/pci/of.c
> > > > +++ b/drivers/pci/of.c
> > > > @@ -24,6 +24,8 @@ void pci_set_of_node(struct pci_dev *dev)
> > > >                                                     dev->devfn);
> > > >         if (dev->dev.of_node)
> > > >                 dev->dev.fwnode = &dev->dev.of_node->fwnode;
> > > > +
> > > > +       pci_set_untrusted(dev);
> > > >  }
> > > >
> > > >  void pci_release_of_node(struct pci_dev *dev)
> > > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > > index a42dbf448860..2bffbd5c6114 100644
> > > > --- a/drivers/pci/pci-acpi.c
> > > > +++ b/drivers/pci/pci-acpi.c
> > > > @@ -1356,6 +1356,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> > > >
> > > >         pci_acpi_optimize_delay(pci_dev, adev->handle);
> > > >         pci_acpi_set_external_facing(pci_dev);
> > > > +       pci_set_untrusted(pci_dev);
> > > >         pci_acpi_add_edr_notifier(pci_dev);
> > > >
> > > >         pci_acpi_add_pm_notifier(adev, pci_dev);
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index 9ecce435fb3f..41e887c27004 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -6869,3 +6869,12 @@ static int __init pci_realloc_setup_params(void)
> > > >         return 0;
> > > >  }
> > > >  pure_initcall(pci_realloc_setup_params);
> > > > +
> > > > +void pci_set_untrusted(struct pci_dev *pdev)
> > > > +{
> > > > +       u8 val;
> > > > +
> > > > +       if (!device_property_read_u8(&pdev->dev, "UntrustedDevice", &val)
>
> If we do this, can we combine it with set_pcie_untrusted(), where we
> already set pdev->untrusted?  Maybe that needs to be renamed; I don't
> see anything PCIe-specific there, and it looks like it works for
> conventional PCI as well.
>
> > Please no, "Untrusted" does not really convey much, if anything here.
> > You are taking an odd in-kernel-value and making it a user api.
> >
> > Where is this "trust" defined?  Who defines it?  What policy does the
> > kernel impose on it?
>
> I'm a bit hesitant about this, too.  It really doesn't have anything
> in particular to do with the PCI core.  It's not part of the PCI
> specs, and it could apply to any kind of device, not just PCI (ACPI,
> platform, USB, etc).
>
> We have:
>
>   dev->removable                # struct device
>   pdev->is_thunderbolt
>   pdev->untrusted
>   pdev->external_facing
>
> and it feels a little hard to keep everything straight.  Most of them
> are "discovered" based on some DT or ACPI firmware property.  None of
> them really has anything specifically to do with *PCI*, and I don't
> think the PCI core depends on any of them.  I think
> pdev->is_thunderbolt is the only one we discover based on a PCI
> feature (the Thunderbolt Capability), and the things we *use* it for
> are actually not things specified by that capability [1].
>
> Could drivers just look for these properties directly instead of
> relying on the PCI core to get in the middle?  Most callers of
> device_property_read_*() are in drivers.  I do see that doing it in
> the PCI core might help enforce standard usage in DT/ACPI, but we
> could probably do that in other ways, too.

FWIW, I agree that looking at these things in drivers would be better.

> [1] https://lore.kernel.org/r/20220204222956.GA220908@bhelgaas
