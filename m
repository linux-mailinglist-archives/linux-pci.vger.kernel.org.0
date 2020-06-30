Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716B020F1C5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 11:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731939AbgF3JjL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 05:39:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:20827 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731616AbgF3JjK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 05:39:10 -0400
IronPort-SDR: mZh3eeclmzZ+nTNCDt1Z/kHbDM1Jnr5PQxFc7jqShtsA818Vlkd7ZJUVEe987K2eZmw14J5uri
 /JxZomKr363Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="164198287"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="164198287"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 02:39:09 -0700
IronPort-SDR: LpttFbpjMuxtCTqxe6f4Y1hJgWrEbCvF1d03ltwPdc2br7oMIEyPr0d2pmZ/43oo+CVCwKCSNm
 a7/60Q+JJeEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="295159420"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 30 Jun 2020 02:39:07 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jqCjM-00GooW-Hw; Tue, 30 Jun 2020 12:39:08 +0300
Date:   Tue, 30 Jun 2020 12:39:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] PCI: vmd: Keep fwnode allocated through VMD irqdomain
 life
Message-ID: <20200630093908.GP3703480@smile.fi.intel.com>
References: <20200625195820.GA2701690@bjorn-Precision-5520>
 <20200629232011.GA3318849@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629232011.GA3318849@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 29, 2020 at 06:20:11PM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 25, 2020 at 02:58:23PM -0500, Bjorn Helgaas wrote:
> > [+cc Thomas]
> > 
> > On Thu, Jun 25, 2020 at 12:24:49PM -0400, Jon Derrick wrote:
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > The VMD domain does not subscribe to ACPI, and so does not operate on
> > > it's irqdomain fwnode. It was freeing the handle after allocation of the
> > > domain. As of 181e9d4efaf6a (irqdomain: Make __irq_domain_add() less
> > > OF-dependent), the fwnode is put during irq_domain_remove causing a page
> > > fault. This patch keeps VMD's fwnode allocated through the lifetime of
> > > the VMD irqdomain.
> > > 
> > > Fixes: ae904cafd59d ("PCI/vmd: Create named irq domain")
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > > ---
> > > Hi Lorenzo, Bjorn,
> > > 
> > > Please take this patch for v5.8 fixes. It fixes an issue during VMD
> > > unload.
> > 
> > I tentatively applied this to for-linus for v5.8.
> > 
> > But I would like to clarify the commit log.  It says this fixes
> > Thomas' ae904cafd59d ("PCI/vmd: Create named irq domain").  That
> > appeared in v4.13, which suggests that this patch should be backported
> > to v4.13 and later.
> 
> I didn't word this correctly.  What I meant was "I will consider
> applying this after the commit log is clarified."  Just FYI that this
> isn't resolved yet.
> 
> Since this is proposed for v5.8, I really want to understand this
> better before asking Linus to pull it as a fix.

The problem here is in the original patch which relies on the knowledge that
fwnode is (was) not used anyhow specifically for ACPI case. That said, it makes
fwnode a dangling pointer which I personally consider as a mine left for
others. That's why the Fixes refers to the initial commit. The latter just
has been blasted on that mine.

If you think that's fine to have such trick, feel free to update Fixes tag.

> > But it's not clear to me that ae904cafd59d is actually broken, since
> > the log also says the problem appeared after 181e9d4efaf6 ("irqdomain:
> > Make __irq_domain_add() less OF-dependent"), which we just merged for
> > v5.8-rc1.
> > 
> > And obviously, freeing the fwnode doesn't *cause* a page fault.  A
> > use-after-free might cause a fault, but it's not clear where that
> > happens.  I guess fwnode is used in the interval between:
> > 
> >   vmd_enable_domain
> >     pci_msi_create_irq_domain
> > 
> >   ...        <-- fwnode used here somewhere
> > 
> >   vmd_remove
> >     vmd_cleanup_srcu
> >       irq_domain_free_fwnode
> > 
> > But I can't tell how 181e9d4efaf6a and/or ae904cafd59d are related to
> > that.
> > 
> > >  drivers/pci/controller/vmd.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > > index e386d4eac407..ebec0a6e77ed 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -546,9 +546,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > >  
> > >  	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
> > >  						    x86_vector_domain);
> > > -	irq_domain_free_fwnode(fn);
> > > -	if (!vmd->irq_domain)
> > > +	if (!vmd->irq_domain) {
> > > +		irq_domain_free_fwnode(fn);
> > >  		return -ENODEV;
> > > +	}
> > >  
> > >  	pci_add_resource(&resources, &vmd->resources[0]);
> > >  	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
> > > @@ -559,6 +560,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > >  	if (!vmd->bus) {
> > >  		pci_free_resource_list(&resources);
> > >  		irq_domain_remove(vmd->irq_domain);
> > > +		irq_domain_free_fwnode(fn);
> > >  		return -ENODEV;
> > >  	}
> > >  
> > > @@ -672,6 +674,7 @@ static void vmd_cleanup_srcu(struct vmd_dev *vmd)
> > >  static void vmd_remove(struct pci_dev *dev)
> > >  {
> > >  	struct vmd_dev *vmd = pci_get_drvdata(dev);
> > > +	struct fwnode_handle *fn = vmd->irq_domain->fwnode;
> > >  
> > >  	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
> > >  	pci_stop_root_bus(vmd->bus);
> > > @@ -679,6 +682,7 @@ static void vmd_remove(struct pci_dev *dev)
> > >  	vmd_cleanup_srcu(vmd);
> > >  	vmd_detach_resources(vmd);
> > >  	irq_domain_remove(vmd->irq_domain);
> > > +	irq_domain_free_fwnode(fn);
> > >  }
> > >  
> > >  #ifdef CONFIG_PM_SLEEP
> > > -- 
> > > 2.18.1
> > > 

-- 
With Best Regards,
Andy Shevchenko


