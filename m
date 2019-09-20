Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC10B909D
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2019 15:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfITN0r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Sep 2019 09:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbfITN0r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Sep 2019 09:26:47 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3E5A20644;
        Fri, 20 Sep 2019 13:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568986006;
        bh=l6trHkVRVi4Jtoy88rMW6wbwgrdI8cPoidRU+a4Nsio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJwu4kjg0I7EPoOxOCF9/xh8sTyrXKV0lUmPsvj4kB1vxJH9xuOBzn7f5vgJn8R4L
         gqF/dYYJPT7E+azdmsMGSglPJ61pl62C7tlTsYKAo70ctR53+WA7M71176sFajIWYB
         PNy0rNBhWw1Zo0iZRd4Gi9Ks4zX+ZGxEL7VfK0Ho=
Date:   Fri, 20 Sep 2019 08:26:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     tiwai@suse.com, Linux PCI <linux-pci@vger.kernel.org>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] PCI: Add a helper to check Power Resource
 Requirements _PR3 existence
Message-ID: <20190920132644.GA226476@google.com>
References: <20190827134756.10807-1-kai.heng.feng@canonical.com>
 <20190909114129.GT103977@google.com>
 <CAAd53p4mc0tgCBiwfZRowr4os_bqDP+7Ko=d+do8OW2aH1Whzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p4mc0tgCBiwfZRowr4os_bqDP+7Ko=d+do8OW2aH1Whzg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael]

On Fri, Sep 20, 2019 at 01:23:20PM +0200, Kai-Heng Feng wrote:
> On Mon, Sep 9, 2019 at 1:41 PM Bjorn Helgaas <helgaas@kernel.org> wrote:

> > > +bool pci_pr3_present(struct pci_dev *pdev)
> > > +{
> > > +     struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
> > > +     struct acpi_device *parent_adev;
> > > +
> > > +     if (acpi_disabled)
> > > +             return false;
> > > +
> > > +     if (!parent_pdev)
> > > +             return false;
> > > +
> > > +     parent_adev = ACPI_COMPANION(&parent_pdev->dev);
> > > +     if (!parent_adev)
> > > +             return false;
> > > +
> > > +     return parent_adev->power.flags.power_resources &&
> > > +             acpi_has_method(parent_adev->handle, "_PR3");
> >
> > I think this is generally OK, but it doesn't actually check whether
> > *pdev* has a _PR3; it checks whether pdev's *parent* does.  So does
> > that mean this is dependent on the GPU topology, i.e., does it assume
> > that there is an upstream bridge and that power for everything under
> > that bridge can be managed together?
> 
> Yes, the power resource is managed by its upstream port.
> 
> > I'm wondering whether the "parent_pdev = pci_upstream_bridge()" part
> > should be in the caller rather than in pci_pr3_present()?
> 
> This will make the function more align to its name, but needs more
> work from caller side.
> How about rename the function to pci_upstream_pr3_present()?

I cc'd Rafael because he knows all about how this stuff works, and I
don't.

_PR3 is defined in terms of the device itself and the doc (ACPI v6.3,
sec 7.3.11) doesn't mention any hierarchy.  I assume it would be legal
for firmware to supply a _PR3 for "pdev" as well as for "parent_pdev"?

If that is legal, I think it would be appropriate for the caller to
look up the upstream bridge.  That way this interface could be used
for both "pdev" and an upstream bridge.  If we look up the bridge
internally, we would have to add a second interface if we actually
want to know about _PR3 for the device itself.

> > I can't connect any of the dots from _PR3 through to
> > "need_eld_notify_link" (whatever "eld" is :)) and the uses of
> > hda_intel.need_eld_notify_link (and needs_eld_notify_link()).
> >
> > But that's beyond the scope of *this* patch and it makes sense that
> > you do want to discover the _PR3 existence, so I'm fine with this once
> > we figure out the pdev vs parent question.
> 
> Thanks for your review.
> 
> Kai-Heng
> 
> >
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_pr3_present);
> > > +
> > >  /**
> > >   * pci_add_dma_alias - Add a DMA devfn alias for a device
> > >   * @dev: the PCI device for which alias is added
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 82e4cd1b7ac3..9b6f7b67fac9 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -2348,9 +2348,11 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
> > >
> > >  void
> > >  pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
> > > +bool pci_pr3_present(struct pci_dev *pdev);
> > >  #else
> > >  static inline struct irq_domain *
> > >  pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
> > > +static bool pci_pr3_present(struct pci_dev *pdev) { return false; }
> > >  #endif
> > >
> > >  #ifdef CONFIG_EEH
> > > --
> > > 2.17.1
> > >
