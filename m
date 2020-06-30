Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E32720F987
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 18:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgF3Qdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 12:33:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbgF3Qdf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 12:33:35 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E2C4206BE;
        Tue, 30 Jun 2020 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593534814;
        bh=TmHz8DGHOqml0apr+BZwB0ErlFOXBuxedj6hFvuKkWU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=zR0G0CcrzfpbGAxDdTupdXd6nQt0O1m8OD4+l/bda25b+lumO9y1UgcgAEyqpxxWo
         Ij0iyCyCH55OP2HE+3vGntR5fPEYXpVqqxQb9rPkSkTRuIE7K4CzKXGLT4lJdWTDbt
         VAs0nxZO8QvhCCn1fQU+hc6rcEgMA0gMTwRYHQ98=
Date:   Tue, 30 Jun 2020 11:33:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Sushma Kalakota <sushmax.kalakota@intel.com>
Subject: Re: [PATCH] PCI: vmd: Keep fwnode allocated through VMD irqdomain
 life
Message-ID: <20200630163332.GA3437879@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630093908.GP3703480@smile.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 30, 2020 at 12:39:08PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 29, 2020 at 06:20:11PM -0500, Bjorn Helgaas wrote:
> > On Thu, Jun 25, 2020 at 02:58:23PM -0500, Bjorn Helgaas wrote:
> > > [+cc Thomas]
> > > 
> > > On Thu, Jun 25, 2020 at 12:24:49PM -0400, Jon Derrick wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > 
> > > > The VMD domain does not subscribe to ACPI, and so does not operate on
> > > > it's irqdomain fwnode. It was freeing the handle after allocation of the
> > > > domain. As of 181e9d4efaf6a (irqdomain: Make __irq_domain_add() less
> > > > OF-dependent), the fwnode is put during irq_domain_remove causing a page
> > > > fault. This patch keeps VMD's fwnode allocated through the lifetime of
> > > > the VMD irqdomain.
> > > > 
> > > > Fixes: ae904cafd59d ("PCI/vmd: Create named irq domain")
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > > > ---
> > > > Hi Lorenzo, Bjorn,
> > > > 
> > > > Please take this patch for v5.8 fixes. It fixes an issue during VMD
> > > > unload.
> > > 
> > > I tentatively applied this to for-linus for v5.8.
> > > 
> > > But I would like to clarify the commit log.  It says this fixes
> > > Thomas' ae904cafd59d ("PCI/vmd: Create named irq domain").  That
> > > appeared in v4.13, which suggests that this patch should be backported
> > > to v4.13 and later.
> > 
> > I didn't word this correctly.  What I meant was "I will consider
> > applying this after the commit log is clarified."  Just FYI that this
> > isn't resolved yet.
> > 
> > Since this is proposed for v5.8, I really want to understand this
> > better before asking Linus to pull it as a fix.
> 
> The problem here is in the original patch which relies on the
> knowledge that fwnode is (was) not used anyhow specifically for ACPI
> case. That said, it makes fwnode a dangling pointer which I
> personally consider as a mine left for others. That's why the Fixes
> refers to the initial commit. The latter just has been blasted on
> that mine.

IIUC, you're saying this pattern:

  fwnode = irq_domain_alloc_named_id_fwnode(...)
  irq_domain = pci_msi_create_irq_domain(fwnode, ...)
  irq_domain_free_fwnode(fwnode)

leaves a dangling fwnode pointer.  That does look suspicious because
__irq_domain_add() saves fwnode:

  irq_domain = pci_msi_create_irq_domain(fwnode, ...)
    msi_create_irq_domain(fwnode, ...)
      irq_domain_create_hierarchy(..., fwnode, ...)
	irq_domain_create_linear(fwnode, ...)
	  __irq_domain_add(fwnode, ...)
	    domain->fwnode = fwnode

and irq_domain_free_fwnode() frees it.  But I'm confused because there
are several other instances of this pattern:

  bridge_probe()                      # arch/mips/pci/pci-xtalk-bridge.c
  mp_irqdomain_create()
  arch_init_msi_domain()
  arch_create_remap_msi_irq_domain()
  dmar_get_irq_domain()
  hpet_create_irq_domain()
  ...

Are they all wrong?  I definitely think it's a bad idea to keep a copy
of a pointer after we free the data it points to.  But if they're all
wrong, I don't want to fix just one and leave all the others.

Thomas, can you enlighten us?

> If you think that's fine to have such trick, feel free to update Fixes tag.
> 
> > > But it's not clear to me that ae904cafd59d is actually broken, since
> > > the log also says the problem appeared after 181e9d4efaf6 ("irqdomain:
> > > Make __irq_domain_add() less OF-dependent"), which we just merged for
> > > v5.8-rc1.
> > > 
> > > And obviously, freeing the fwnode doesn't *cause* a page fault.  A
> > > use-after-free might cause a fault, but it's not clear where that
> > > happens.  I guess fwnode is used in the interval between:
> > > 
> > >   vmd_enable_domain
> > >     pci_msi_create_irq_domain
> > > 
> > >   ...        <-- fwnode used here somewhere
> > > 
> > >   vmd_remove
> > >     vmd_cleanup_srcu
> > >       irq_domain_free_fwnode
> > > 
> > > But I can't tell how 181e9d4efaf6a and/or ae904cafd59d are related to
> > > that.
> > > 
> > > >  drivers/pci/controller/vmd.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > > > index e386d4eac407..ebec0a6e77ed 100644
> > > > --- a/drivers/pci/controller/vmd.c
> > > > +++ b/drivers/pci/controller/vmd.c
> > > > @@ -546,9 +546,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > > >  
> > > >  	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
> > > >  						    x86_vector_domain);
> > > > -	irq_domain_free_fwnode(fn);
> > > > -	if (!vmd->irq_domain)
> > > > +	if (!vmd->irq_domain) {
> > > > +		irq_domain_free_fwnode(fn);
> > > >  		return -ENODEV;
> > > > +	}
> > > >  
> > > >  	pci_add_resource(&resources, &vmd->resources[0]);
> > > >  	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
> > > > @@ -559,6 +560,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > > >  	if (!vmd->bus) {
> > > >  		pci_free_resource_list(&resources);
> > > >  		irq_domain_remove(vmd->irq_domain);
> > > > +		irq_domain_free_fwnode(fn);
> > > >  		return -ENODEV;
> > > >  	}
> > > >  
> > > > @@ -672,6 +674,7 @@ static void vmd_cleanup_srcu(struct vmd_dev *vmd)
> > > >  static void vmd_remove(struct pci_dev *dev)
> > > >  {
> > > >  	struct vmd_dev *vmd = pci_get_drvdata(dev);
> > > > +	struct fwnode_handle *fn = vmd->irq_domain->fwnode;
> > > >  
> > > >  	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
> > > >  	pci_stop_root_bus(vmd->bus);
> > > > @@ -679,6 +682,7 @@ static void vmd_remove(struct pci_dev *dev)
> > > >  	vmd_cleanup_srcu(vmd);
> > > >  	vmd_detach_resources(vmd);
> > > >  	irq_domain_remove(vmd->irq_domain);
> > > > +	irq_domain_free_fwnode(fn);
> > > >  }
> > > >  
> > > >  #ifdef CONFIG_PM_SLEEP
> > > > -- 
> > > > 2.18.1
> > > > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
