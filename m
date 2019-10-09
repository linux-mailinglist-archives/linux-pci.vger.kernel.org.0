Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD00D0F26
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 14:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfJIMtl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 08:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729784AbfJIMtl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Oct 2019 08:49:41 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C2C920B7C;
        Wed,  9 Oct 2019 12:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570625380;
        bh=BS4jso9hypNio5lXJwUJxoGbh/2wvN6PY7GhM+KUNGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jH2fwKYGgUAT3yvVwlPaj40RpZcpMd28Pv1P0XTRASzDbfUec6elVvevVNgQPnl5L
         SUolQjQLJky2IL2PxOIjStpZNm3Mnb717g61/tSzlO+i2tTIQjv1Iuy6WMQv+h9rJA
         n0oJqlQTsS8MU9UPyPVj6ija2LN0Ad0y9AwzM7es=
Date:   Wed, 9 Oct 2019 07:49:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Subject: Re: [PATCH v3 1/2] PCI: PCIe: ASPM: Introduce pcie_aspm_enabled()
Message-ID: <20191009124938.GA67585@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j-uSM2gheHViommWcrSaLVfzbwV3M7OOWz3GyzhHSwRA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 09, 2019 at 12:54:37AM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 8, 2019 at 11:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, Oct 08, 2019 at 11:27:51AM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Oct 8, 2019 at 12:34 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Thu, Aug 08, 2019 at 11:55:07PM +0200, Rafael J. Wysocki wrote:
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > Add a function checking whether or not PCIe ASPM has been enabled for
> > > > > a given device.
> > > > >
> > > > > It will be used by the NVMe driver to decide how to handle the
> > > > > device during system suspend.
> > > > >
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > ---
> > > > >
> > > > > v2 -> v3:
> > > > >   * Make the new function return bool.
> > > > >   * Change its name back to pcie_aspm_enabled().
> > > > >   * Fix kerneldoc comment formatting.
> > > > >
> > > > > -> v2:
> > > > >   * Move the PCI/PCIe ASPM changes to a separate patch.
> > > > >   * Add the _mask suffix to the new function name.
> > > > >   * Add EXPORT_SYMBOL_GPL() to the new function.
> > > > >   * Avoid adding an unnecessary blank line.
> > > > >
> > > > > ---
> > > > >  drivers/pci/pcie/aspm.c |   20 ++++++++++++++++++++
> > > > >  include/linux/pci.h     |    3 +++
> > > > >  2 files changed, 23 insertions(+)
> > > > >
> > > > > Index: linux-pm/drivers/pci/pcie/aspm.c
> > > > > ===================================================================
> > > > > --- linux-pm.orig/drivers/pci/pcie/aspm.c
> > > > > +++ linux-pm/drivers/pci/pcie/aspm.c
> > > > > @@ -1170,6 +1170,26 @@ static int pcie_aspm_get_policy(char *bu
> > > > >  module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
> > > > >       NULL, 0644);
> > > > >
> > > > > +/**
> > > > > + * pcie_aspm_enabled - Check if PCIe ASPM has been enabled for a device.
> > > > > + * @pci_device: Target device.
> > > > > + */
> > > > > +bool pcie_aspm_enabled(struct pci_dev *pci_device)
> > > > > +{
> > > > > +     struct pci_dev *bridge = pci_upstream_bridge(pci_device);
> > > > > +     bool ret;
> > > > > +
> > > > > +     if (!bridge)
> > > > > +             return false;
> > > > > +
> > > > > +     mutex_lock(&aspm_lock);
> > > > > +     ret = bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
> > > > > +     mutex_unlock(&aspm_lock);
> > > >
> > > > Why do we need to acquire aspm_lock here?  We aren't modifying
> > > > anything, and I don't think we're preventing a race.  If this races
> > > > with another thread that changes aspm_enabled, we'll return either the
> > > > old state or the new one, and I think that's still the case even if we
> > > > don't acquire aspm_lock.
> > >
> > > Well, if we can guarantee that pci_remove_bus_device() will never be
> > > called in parallel with this helper, then I agree, but can we
> > > guarantee that?
> >
> > Hmm, yeah, I guess that's the question.  It's not a race with another
> > thread changing aspm_enabled; the potential race is with another
> > thread removing the last child of "bridge", which will free the
> > link_state and set bridge->link_state = NULL.
> >
> > I think it should be safe to call device-related PCI interfaces if
> > you're holding a reference to the device, e.g., from a driver bound to
> > the device or a sysfs accessor.  Since we call pcie_aspm_enabled(dev)
> > from a driver bound to "dev", another thread should not be able to
> > remove "dev" while we're using it.
> >
> > I know that's a little hand-wavey, but if it weren't true, I think
> > we'd have a lot more locking sprinkled everywhere in the PCI core than
> > we do.
> >
> > This has implications for Heiner's ASPM sysfs patches because we're
> > currently doing this in sysfs accessors:
> >
> >   static ssize_t aspm_attr_show_common(struct device *dev, ...)
> >   {
> >     ...
> >     link = pcie_aspm_get_link(pdev);
> >
> >     mutex_lock(&aspm_lock);
> >     enabled = link->aspm_enabled & state;
> >     mutex_unlock(&aspm_lock);
> >     ...
> >   }
> >
> > I assume sysfs must be holding a reference that guarantees "dev" is
> > valid througout this code, and therefore we should not need to hold
> > aspm_lock.
> 
> In principle, pcie_aspm_enabled() need not be called via sysfs.
> 
> In the particular NVMe use case, it is called from the driver's own PM
> callback, so it would be safe without the locking AFAICS.

Right, pcie_aspm_enabled() is only used by drivers (actually only by
the nvme driver so far).  And aspm_attr_show_common() is only used via
new sysfs code being added by Heiner.

> I guess it is safe to drop the locking from there, but then it would
> be good to mention in the kerneldoc that calling it is only safe under
> the assumption that the link_state object cannot go away while it is
> running.

I'll post a patch to that effect.  Thanks!

Bjorn
