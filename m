Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B86D0399
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 00:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfJHWyu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 18:54:50 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35420 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWyu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2019 18:54:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id x3so171586oig.2;
        Tue, 08 Oct 2019 15:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SggbRRKNXqQlH49P3KzPfRoT4FOY8o89Xl8C5FlY+KA=;
        b=SPc7Wo/xlhNBDSK+mjqXICQ8FyFQMeZ29jL29NzY1ngXkmv2/8vxP99YnTZzZ2Y9tF
         uS6y/MXBEIBquJW9zKQzNi3pRI9WjbqTeAPQIqNYLg9XftTR8TRpuU6EvNsnk/0DcgE9
         u9zJaVfNBEy9urK/XXrPKZANeoEKO3eJ2hl5Z1SRROu4jszB8HEwEcEbijmJuvnTPcHF
         brmnGa6sEyLgq6eZEeMsd4VV9cAsj4o3kSDVhlKwuEhMg/26wBNYfOD2K/CnJO2r6dA5
         8lXKryPt1IbMABOiIH+kCJ7XjVRZdW2IQtRkcLslronRC9QGpCy8K0ShqWUM8ltnVJSN
         KkMA==
X-Gm-Message-State: APjAAAUwy+rF4zejMQRlDW7ml/F2chTEVw0kn3fW1sIPb+i81uywfRGs
        iI4k18ndyWjx3q7+FT/QWigKh7uidJus9ki2VHY=
X-Google-Smtp-Source: APXvYqzAHIWDALJmWxny85y+zNIHc6fYu7ABhv0L9fiH6TsA/vMVV+jisYkSGZMtPlgYlfymiNkZrvEQvyEMSGQl7Vo=
X-Received: by 2002:aca:d706:: with SMTP id o6mr7215oig.57.1570575288501; Tue,
 08 Oct 2019 15:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0iL4Rv=AQ-Qnma=wWaqBBbOdfRqu9uS9Gesa-G75oQpzQ@mail.gmail.com>
 <20191008211656.GA163302@google.com>
In-Reply-To: <20191008211656.GA163302@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Oct 2019 00:54:37 +0200
Message-ID: <CAJZ5v0j-uSM2gheHViommWcrSaLVfzbwV3M7OOWz3GyzhHSwRA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: PCIe: ASPM: Introduce pcie_aspm_enabled()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 8, 2019 at 11:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Oct 08, 2019 at 11:27:51AM +0200, Rafael J. Wysocki wrote:
> > On Tue, Oct 8, 2019 at 12:34 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Aug 08, 2019 at 11:55:07PM +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Add a function checking whether or not PCIe ASPM has been enabled for
> > > > a given device.
> > > >
> > > > It will be used by the NVMe driver to decide how to handle the
> > > > device during system suspend.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >
> > > > v2 -> v3:
> > > >   * Make the new function return bool.
> > > >   * Change its name back to pcie_aspm_enabled().
> > > >   * Fix kerneldoc comment formatting.
> > > >
> > > > -> v2:
> > > >   * Move the PCI/PCIe ASPM changes to a separate patch.
> > > >   * Add the _mask suffix to the new function name.
> > > >   * Add EXPORT_SYMBOL_GPL() to the new function.
> > > >   * Avoid adding an unnecessary blank line.
> > > >
> > > > ---
> > > >  drivers/pci/pcie/aspm.c |   20 ++++++++++++++++++++
> > > >  include/linux/pci.h     |    3 +++
> > > >  2 files changed, 23 insertions(+)
> > > >
> > > > Index: linux-pm/drivers/pci/pcie/aspm.c
> > > > ===================================================================
> > > > --- linux-pm.orig/drivers/pci/pcie/aspm.c
> > > > +++ linux-pm/drivers/pci/pcie/aspm.c
> > > > @@ -1170,6 +1170,26 @@ static int pcie_aspm_get_policy(char *bu
> > > >  module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
> > > >       NULL, 0644);
> > > >
> > > > +/**
> > > > + * pcie_aspm_enabled - Check if PCIe ASPM has been enabled for a device.
> > > > + * @pci_device: Target device.
> > > > + */
> > > > +bool pcie_aspm_enabled(struct pci_dev *pci_device)
> > > > +{
> > > > +     struct pci_dev *bridge = pci_upstream_bridge(pci_device);
> > > > +     bool ret;
> > > > +
> > > > +     if (!bridge)
> > > > +             return false;
> > > > +
> > > > +     mutex_lock(&aspm_lock);
> > > > +     ret = bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
> > > > +     mutex_unlock(&aspm_lock);
> > >
> > > Why do we need to acquire aspm_lock here?  We aren't modifying
> > > anything, and I don't think we're preventing a race.  If this races
> > > with another thread that changes aspm_enabled, we'll return either the
> > > old state or the new one, and I think that's still the case even if we
> > > don't acquire aspm_lock.
> >
> > Well, if we can guarantee that pci_remove_bus_device() will never be
> > called in parallel with this helper, then I agree, but can we
> > guarantee that?
>
> Hmm, yeah, I guess that's the question.  It's not a race with another
> thread changing aspm_enabled; the potential race is with another
> thread removing the last child of "bridge", which will free the
> link_state and set bridge->link_state = NULL.
>
> I think it should be safe to call device-related PCI interfaces if
> you're holding a reference to the device, e.g., from a driver bound to
> the device or a sysfs accessor.  Since we call pcie_aspm_enabled(dev)
> from a driver bound to "dev", another thread should not be able to
> remove "dev" while we're using it.
>
> I know that's a little hand-wavey, but if it weren't true, I think
> we'd have a lot more locking sprinkled everywhere in the PCI core than
> we do.
>
> This has implications for Heiner's ASPM sysfs patches because we're
> currently doing this in sysfs accessors:
>
>   static ssize_t aspm_attr_show_common(struct device *dev, ...)
>   {
>     ...
>     link = pcie_aspm_get_link(pdev);
>
>     mutex_lock(&aspm_lock);
>     enabled = link->aspm_enabled & state;
>     mutex_unlock(&aspm_lock);
>     ...
>   }
>
> I assume sysfs must be holding a reference that guarantees "dev" is
> valid througout this code, and therefore we should not need to hold
> aspm_lock.

In principle, pcie_aspm_enabled() need not be called via sysfs.

In the particular NVMe use case, it is called from the driver's own PM
callback, so it would be safe without the locking AFAICS.

I guess it is safe to drop the locking from there, but then it would
be good to mention in the kerneldoc that calling it is only safe under
the assumption that the link_state object cannot go away while it is
running.
