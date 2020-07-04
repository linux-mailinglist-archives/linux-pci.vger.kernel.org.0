Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D132145B9
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jul 2020 14:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgGDMFA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Jul 2020 08:05:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:19479 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgGDMFA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 4 Jul 2020 08:05:00 -0400
IronPort-SDR: eotly8Cuom/EUR9XvX4nBRqFTW3dWd3HcykrIJjgCzM48X0PkEtpbYaVLKiZXmLUByXehMo63G
 btudy1I2Q+kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="147261680"
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; 
   d="scan'208";a="147261680"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2020 05:04:52 -0700
IronPort-SDR: vSej1n7HHTFPMM2TyL5ry6L7JsmMJtOYExBvxm93XoVi1KFciB61q62oE8Y0fgb1jafSHJdbCN
 ierpiriN9XOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; 
   d="scan'208";a="322713761"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 04 Jul 2020 05:04:50 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jrguZ-00HYHF-UJ; Sat, 04 Jul 2020 15:04:51 +0300
Date:   Sat, 4 Jul 2020 15:04:51 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "Kalakota, SushmaX" <sushmax.kalakota@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: vmd: Keep fwnode allocated through VMD irqdomain
 life
Message-ID: <20200704120451.GZ3703480@smile.fi.intel.com>
References: <20200630163332.GA3437879@bjorn-Precision-5520>
 <225256cc0ef63a3e149bcac97999d06381c52830.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <225256cc0ef63a3e149bcac97999d06381c52830.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 04, 2020 at 01:44:59AM +0000, Derrick, Jonathan wrote:
> On Tue, 2020-06-30 at 11:33 -0500, Bjorn Helgaas wrote:
> > On Tue, Jun 30, 2020 at 12:39:08PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jun 29, 2020 at 06:20:11PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Jun 25, 2020 at 02:58:23PM -0500, Bjorn Helgaas wrote:
> > > > > [+cc Thomas]
> > > > > 
> > > > > On Thu, Jun 25, 2020 at 12:24:49PM -0400, Jon Derrick wrote:
> > > > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > > 
> > > > > > The VMD domain does not subscribe to ACPI, and so does not operate on
> > > > > > it's irqdomain fwnode. It was freeing the handle after allocation of the
> > > > > > domain. As of 181e9d4efaf6a (irqdomain: Make __irq_domain_add() less
> > > > > > OF-dependent), the fwnode is put during irq_domain_remove causing a page
> > > > > > fault. This patch keeps VMD's fwnode allocated through the lifetime of
> > > > > > the VMD irqdomain.
> > > > > > 
> > > > > > Fixes: ae904cafd59d ("PCI/vmd: Create named irq domain")
> > > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > > Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > > > > > ---
> > > > > > Hi Lorenzo, Bjorn,
> > > > > > 
> > > > > > Please take this patch for v5.8 fixes. It fixes an issue during VMD
> > > > > > unload.
> > > > > 
> > > > > I tentatively applied this to for-linus for v5.8.
> > > > > 
> > > > > But I would like to clarify the commit log.  It says this fixes
> > > > > Thomas' ae904cafd59d ("PCI/vmd: Create named irq domain").  That
> > > > > appeared in v4.13, which suggests that this patch should be backported
> > > > > to v4.13 and later.
> > > > 
> > > > I didn't word this correctly.  What I meant was "I will consider
> > > > applying this after the commit log is clarified."  Just FYI that this
> > > > isn't resolved yet.
> > > > 
> > > > Since this is proposed for v5.8, I really want to understand this
> > > > better before asking Linus to pull it as a fix.
> > > 
> > > The problem here is in the original patch which relies on the
> > > knowledge that fwnode is (was) not used anyhow specifically for ACPI
> > > case. That said, it makes fwnode a dangling pointer which I
> > > personally consider as a mine left for others. That's why the Fixes
> > > refers to the initial commit. The latter just has been blasted on
> > > that mine.
> > 
> > IIUC, you're saying this pattern:
> > 
> >   fwnode = irq_domain_alloc_named_id_fwnode(...)
> >   irq_domain = pci_msi_create_irq_domain(fwnode, ...)
> >   irq_domain_free_fwnode(fwnode)
> > 
> > leaves a dangling fwnode pointer.  That does look suspicious because
> > __irq_domain_add() saves fwnode:
> > 
> >   irq_domain = pci_msi_create_irq_domain(fwnode, ...)
> >     msi_create_irq_domain(fwnode, ...)
> >       irq_domain_create_hierarchy(..., fwnode, ...)
> > 	irq_domain_create_linear(fwnode, ...)
> > 	  __irq_domain_add(fwnode, ...)
> > 	    domain->fwnode = fwnode
> > 
> > and irq_domain_free_fwnode() frees it.  But I'm confused because there
> > are several other instances of this pattern:
> > 
> >   bridge_probe()                      # arch/mips/pci/pci-xtalk-bridge.c
> >   mp_irqdomain_create()
> >   arch_init_msi_domain()
> >   arch_create_remap_msi_irq_domain()
> >   dmar_get_irq_domain()
> >   hpet_create_irq_domain()
> >   ...
> > 
> > Are they all wrong?  I definitely think it's a bad idea to keep a copy
> > of a pointer after we free the data it points to.  But if they're all
> > wrong, I don't want to fix just one and leave all the others.
> > 
> > Thomas, can you enlighten us?
> > 
> 
> I see that struct irqchip_fwid contains the actual fwnode structure and
> when that is freed, it's causes the issue.
> 
> I'm noticing in each caller of irq_domain_free_fwnode, we have the
> domain itself available. It seems like it should be up to the caller to
> deal with the fwnode pointer, but we could just do:

It might work as well, but also needs a good documentation.

> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index a4c2c915511d..61f0070285ff 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -101,7 +101,7 @@ EXPORT_SYMBOL_GPL(__irq_domain_alloc_fwnode);
>   *
>   * Free a fwnode_handle allocated with irq_domain_alloc_fwnode.
>   */

> -void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
> +void irq_domain_free_fwnode(struct irq_domain *domain, struct
> fwnode_handle *fwnode)

Isn't fwnode == domain->fwnode here and second parameter won't be necessary?

>  {
>         struct irqchip_fwid *fwid;
>  
> @@ -109,6 +109,7 @@ void irq_domain_free_fwnode(struct fwnode_handle
> *fwnode)
>                 return;
>  
>         fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
> +       domain->fwnode = NULL;
>         kfree(fwid->name);
>         kfree(fwid);
>  }
> 
> 
> 
> > > If you think that's fine to have such trick, feel free to update Fixes tag.
> > > 
> > > > > But it's not clear to me that ae904cafd59d is actually broken, since
> > > > > the log also says the problem appeared after 181e9d4efaf6 ("irqdomain:
> > > > > Make __irq_domain_add() less OF-dependent"), which we just merged for
> > > > > v5.8-rc1.
> > > > > 
> > > > > And obviously, freeing the fwnode doesn't *cause* a page fault.  A
> > > > > use-after-free might cause a fault, but it's not clear where that
> > > > > happens.  I guess fwnode is used in the interval between:
> > > > > 
> > > > >   vmd_enable_domain
> > > > >     pci_msi_create_irq_domain
> > > > > 
> > > > >   ...        <-- fwnode used here somewhere
> > > > > 
> > > > >   vmd_remove
> > > > >     vmd_cleanup_srcu
> > > > >       irq_domain_free_fwnode
> > > > > 
> > > > > But I can't tell how 181e9d4efaf6a and/or ae904cafd59d are related to
> > > > > that.
> > > > > 
> > > > > >  drivers/pci/controller/vmd.c | 8 ++++++--
> > > > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > > > > > index e386d4eac407..ebec0a6e77ed 100644
> > > > > > --- a/drivers/pci/controller/vmd.c
> > > > > > +++ b/drivers/pci/controller/vmd.c
> > > > > > @@ -546,9 +546,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > > > > >  
> > > > > >  	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
> > > > > >  						    x86_vector_domain);
> > > > > > -	irq_domain_free_fwnode(fn);
> > > > > > -	if (!vmd->irq_domain)
> > > > > > +	if (!vmd->irq_domain) {
> > > > > > +		irq_domain_free_fwnode(fn);
> > > > > >  		return -ENODEV;
> > > > > > +	}
> > > > > >  
> > > > > >  	pci_add_resource(&resources, &vmd->resources[0]);
> > > > > >  	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
> > > > > > @@ -559,6 +560,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > > > > >  	if (!vmd->bus) {
> > > > > >  		pci_free_resource_list(&resources);
> > > > > >  		irq_domain_remove(vmd->irq_domain);
> > > > > > +		irq_domain_free_fwnode(fn);
> > > > > >  		return -ENODEV;
> > > > > >  	}
> > > > > >  
> > > > > > @@ -672,6 +674,7 @@ static void vmd_cleanup_srcu(struct vmd_dev *vmd)
> > > > > >  static void vmd_remove(struct pci_dev *dev)
> > > > > >  {
> > > > > >  	struct vmd_dev *vmd = pci_get_drvdata(dev);
> > > > > > +	struct fwnode_handle *fn = vmd->irq_domain->fwnode;
> > > > > >  
> > > > > >  	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
> > > > > >  	pci_stop_root_bus(vmd->bus);
> > > > > > @@ -679,6 +682,7 @@ static void vmd_remove(struct pci_dev *dev)
> > > > > >  	vmd_cleanup_srcu(vmd);
> > > > > >  	vmd_detach_resources(vmd);
> > > > > >  	irq_domain_remove(vmd->irq_domain);
> > > > > > +	irq_domain_free_fwnode(fn);
> > > > > >  }
> > > > > >  
> > > > > >  #ifdef CONFIG_PM_SLEEP
> > > > > > -- 
> > > > > > 2.18.1
> > > > > > 
> > > 
> > > -- 
> > > With Best Regards,
> > > Andy Shevchenko
> > > 
> > > 

-- 
With Best Regards,
Andy Shevchenko


