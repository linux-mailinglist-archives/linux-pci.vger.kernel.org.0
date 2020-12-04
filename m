Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1570A2CF3AC
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 19:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgLDSM0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 13:12:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgLDSM0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Dec 2020 13:12:26 -0500
Date:   Fri, 4 Dec 2020 12:11:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607105505;
        bh=x5IfepdnUmNjQDocS8xxeAbEXP8MU+G8Dwqt4FgmJ5g=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=sde1f/Xl6reji6Y+v8uf6u2eOxeU/aXk/Rpv9OA2AUG/CsJhXXqqrz4kV7JLakv6P
         iFSPM5nwuxC/E7Z/++vfQUbi7v2bNin6JFDE2S4JcKNnleHz7XU75VhBA5vlalFEpH
         vGDihTQC8swE/HaChSA7ToCIUkxzrKoh5p7JdosSncdvqHXU/z9877jDUyU5zDM3oM
         47iraJdiO0r3KPnViTnlD61iegPAUmjUwSKzCTurnjTBXdzptWa8J2atcRVkvn+Prw
         VsOzcYR5aAYMdZCAgfPFNa3GOVBZzJomTwkPOA0ZJu+EwfW1kDChcM+R4XcfFtUqgu
         N+5lo8UA4KA0g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Kishore <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 1/3] PCI/MSI: Move MSI/MSI-X init to msi.c
Message-ID: <20201204181143.GA1917523@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8oX61zRwV7ykLAy@ulmo>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 04, 2020 at 12:05:15PM +0100, Thierry Reding wrote:
> On Thu, Dec 03, 2020 at 12:51:08PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Move pci_msi_setup_pci_dev(), which disables MSI and MSI-X interrupts, from
> > probe.c to msi.c so it's with all the other MSI code and more consistent
> > with other capability initialization.  This means we must compile msi.c
> > always, even without CONFIG_PCI_MSI, so wrap the rest of msi.c in an #ifdef
> > and adjust the Makefile accordingly.  No functional change intended.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/Makefile |  3 +--
> >  drivers/pci/msi.c    | 36 ++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.h    |  2 ++
> >  drivers/pci/probe.c  | 21 ++-------------------
> >  4 files changed, 41 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> > index 522d2b974e91..11cc79411e2d 100644
> > --- a/drivers/pci/Makefile
> > +++ b/drivers/pci/Makefile
> > @@ -5,7 +5,7 @@
> >  obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
> >  				   remove.o pci.o pci-driver.o search.o \
> >  				   pci-sysfs.o rom.o setup-res.o irq.o vpd.o \
> > -				   setup-bus.o vc.o mmap.o setup-irq.o
> > +				   setup-bus.o vc.o mmap.o setup-irq.o msi.o
> >  
> >  obj-$(CONFIG_PCI)		+= pcie/
> >  
> > @@ -18,7 +18,6 @@ endif
> >  obj-$(CONFIG_OF)		+= of.o
> >  obj-$(CONFIG_PCI_QUIRKS)	+= quirks.o
> >  obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
> > -obj-$(CONFIG_PCI_MSI)		+= msi.o
> >  obj-$(CONFIG_PCI_ATS)		+= ats.o
> >  obj-$(CONFIG_PCI_IOV)		+= iov.o
> >  obj-$(CONFIG_PCI_BRIDGE_EMUL)	+= pci-bridge-emul.o
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index d52d118979a6..555791c0ee1a 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -26,6 +26,8 @@
> >  
> >  #include "pci.h"
> >  
> > +#ifdef CONFIG_MSI
> > +
> >  static int pci_msi_enable = 1;
> >  int pci_msi_ignore_mask;
> >  
> > @@ -1577,3 +1579,37 @@ bool pci_dev_has_special_msi_domain(struct pci_dev *pdev)
> >  }
> >  
> >  #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
> > +#endif /* CONFIG_PCI_MSI */
> > +
> > +void pci_msi_init(struct pci_dev *dev)
> > +{
> > +	u16 ctrl;
> > +
> > +	/*
> > +	 * Disable the MSI hardware to avoid screaming interrupts
> > +	 * during boot.  This is the power on reset default so
> > +	 * usually this should be a noop.
> > +	 */
> > +	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
> > +	if (!dev->msi_cap)
> > +		return;
> > +
> > +	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &ctrl);
> > +	if (ctrl & PCI_MSI_FLAGS_ENABLE)
> > +		pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS,
> > +				      ctrl & ~PCI_MSI_FLAGS_ENABLE);
> > +}
> 
> The old code used the pci_msi_set_enable() helper here...
> 
> > +
> > +void pci_msix_init(struct pci_dev *dev)
> > +{
> > +	u16 ctrl;
> > +
> > +	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
> > +	if (!dev->msix_cap)
> > +		return;
> > +
> > +	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
> > +	if (ctrl & PCI_MSIX_FLAGS_ENABLE)
> > +		pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
> > +				      ctrl & ~PCI_MSIX_FLAGS_ENABLE);
> > +}
> 
> ... and pci_msix_clear_and_set_ctrl() here. I like your version here
> better because it avoids the unnecessary write in case the flag isn't
> set. But it got me thinking if perhaps the helpers aren't very useful
> and perhaps should be dropped in favour of open-coded variants.
> Especially since there seem to be only 4 and 6 occurrences of them after
> this patch.

I agree, they might be overkill.  I didn't want to spend that much
time on it, so I just left them for now.  Thanks for your review!

> Anyway, this patch looks correct to me and is a nice improvement, so:
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>


