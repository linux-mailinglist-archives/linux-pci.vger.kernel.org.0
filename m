Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D64228546F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 00:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgJFWWZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 18:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgJFWWZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Oct 2020 18:22:25 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C100E208E4;
        Tue,  6 Oct 2020 22:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602022944;
        bh=1dw57jndG1w0rY5pSxG5+iaWD+GIZRZxtFESIzn87pY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MTGoZLbjAPzoAY4B+lnKXwl3Knthrwu+scEjzJ4zt1sKXW/azDMwSgTrtSVkbhpNy
         YxZh8+Mj0OSpGLgv32M2CXmZTqx2PZkJpTJorja6s7RJBjRRTKgx2cp6cVVoDPrE8/
         Re9EnlyLW2FaSNR4i2nN0La0r5ESTr56/B1y+vpg=
Date:   Tue, 6 Oct 2020 17:22:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files
Message-ID: <20201006222222.GA3221382@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200909112850.hbtgkvwqy2rlixst@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof, Yinghai]

On Wed, Sep 09, 2020 at 01:28:50PM +0200, Pali Rohár wrote:
> Hello! I'm adding more people to loop.
> 
> Can somebody look at these race conditions and my patch?
> 
> On Friday 14 August 2020 10:08:24 Pali Rohár wrote:
> > Hello! I would like to remind this issue which I reported month ago.
> > 
> > On Thursday 16 July 2020 13:04:23 Pali Rohár wrote:
> > > Hello Bjorn!
> > > 
> > > I see following error message in dmesg which looks like a race condition:
> > > 
> > > sysfs: cannot create duplicate filename '/devices/platform/soc/d0070000.pcie/pci0000:00/0000:00:00.0/config'
> > > 
> > > I looked at it deeper and found out that in PCI subsystem code is race
> > > condition between pci_bus_add_device() and pci_sysfs_init() calls. Both
> > > of these functions calls pci_create_sysfs_dev_files() and calling this
> > > function more times for same pci device throws above error message.
> > > 
> > > There can be two different race conditions:
> > > 
> > > 1. pci_bus_add_device() called pcibios_bus_add_device() or
> > > pci_fixup_device() but have not called pci_create_sysfs_dev_files() yet.
> > > Meanwhile pci_sysfs_init() is running and pci_create_sysfs_dev_files()
> > > was called for newly registered device. In this case function
> > > pci_create_sysfs_dev_files() is called two times, ones from
> > > pci_bus_add_device() and once from pci_sysfs_init().
> > > 
> > > 2. pci_sysfs_init() is called. It first sets sysfs_initialized to 1
> > > which unblock calling pci_create_sysfs_dev_files(). Then another bus
> > > registers new PCI device and calls pci_bus_add_device() which calls
> > > pci_create_sysfs_dev_files() and registers sysfs files. Function
> > > pci_sysfs_init() continues execution and calls function
> > > pci_create_sysfs_dev_files() also for this newly registered device. So
> > > pci_create_sysfs_dev_files() is again called two times.
> > > 
> > > 
> > > I workaround both race conditions I created following hack patch. After
> > > applying it I'm not getting that 'sysfs: cannot create duplicate filename'
> > > error message anymore.
> > > 
> > > Can you look at it how to fix both race conditions in proper way?
> > 
> > Is this workaround diff enough? Or are you going to prepare
> > something better?
> > 
> > Please let me know if I should send this diff as regular patch.

I'm not really a fan of this because pci_sysfs_init() is a bit of a
hack to begin with, and this makes it even more complicated.

It's not obvious from the code why we need pci_sysfs_init(), but
Yinghai hinted [1] that we need to create sysfs after assigning
resources.  I experimented by removing pci_sysfs_init() and skipping
the ROM BAR sizing.  In that case, we create sysfs files in
pci_bus_add_device() and later assign space for the ROM BAR, so we
fail to create the "rom" sysfs file.

The current solution to that is to delay the sysfs files until
pci_sysfs_init(), a late_initcall(), which runs after resource
assignments.  But I think it would be better if we could create the
sysfs file when we assign the BAR.  Then we could get rid of the
late_initcall() and that implicit ordering requirement.

But I haven't tried to code it up, so it's probably more complicated
than this.  I guess ideally we would assign all the resources before
pci_bus_add_device().  If we could do that, we could just remove
pci_sysfs_init() and everything would just work, but I think that's a
HUGE can of worms.

[1] https://lore.kernel.org/linux-pci/CAE9FiQWBXHgz-gWCmpWLaBOfQQJwtRZemV6Ut9GVw_KJ-dTGTA@mail.gmail.com/

> > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > index 8e40b3e6da77..691be2258c4e 100644
> > > --- a/drivers/pci/bus.c
> > > +++ b/drivers/pci/bus.c
> > > @@ -316,7 +316,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> > >  	 */
> > >  	pcibios_bus_add_device(dev);
> > >  	pci_fixup_device(pci_fixup_final, dev);
> > > -	pci_create_sysfs_dev_files(dev);
> > > +	pci_create_sysfs_dev_files(dev, false);
> > >  	pci_proc_attach_device(dev);
> > >  	pci_bridge_d3_update(dev);
> > >  
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index 6d78df981d41..b0c4852a51dd 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -1328,13 +1328,13 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
> > >  	return retval;
> > >  }
> > >  
> > > -int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
> > > +int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev, bool sysfs_initializing)
> > >  {
> > >  	int retval;
> > >  	int rom_size;
> > >  	struct bin_attribute *attr;
> > >  
> > > -	if (!sysfs_initialized)
> > > +	if (!sysfs_initializing && !sysfs_initialized)
> > >  		return -EACCES;
> > >  
> > >  	if (pdev->cfg_size > PCI_CFG_SPACE_SIZE)
> > > @@ -1437,18 +1437,21 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
> > >  static int __init pci_sysfs_init(void)
> > >  {
> > >  	struct pci_dev *pdev = NULL;
> > > -	int retval;
> > > +	int retval = 0;
> > >  
> > > -	sysfs_initialized = 1;
> > >  	for_each_pci_dev(pdev) {
> > > -		retval = pci_create_sysfs_dev_files(pdev);
> > > +		if (!pci_dev_is_added(pdev))
> > > +			continue;
> > > +		retval = pci_create_sysfs_dev_files(pdev, true);
> > >  		if (retval) {
> > >  			pci_dev_put(pdev);
> > > -			return retval;
> > > +			goto out;
> > >  		}
> > >  	}
> > >  
> > > -	return 0;
> > > +out:
> > > +	sysfs_initialized = 1;
> > > +	return retval;
> > >  }
> > >  late_initcall(pci_sysfs_init);
> > >  
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index 6d3f75867106..304294c7171e 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -19,7 +19,7 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
> > >  
> > >  /* Functions internal to the PCI core code */
> > >  
> > > -int pci_create_sysfs_dev_files(struct pci_dev *pdev);
> > > +int pci_create_sysfs_dev_files(struct pci_dev *pdev, bool sysfs_initializing);
> > >  void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
> > >  #if !defined(CONFIG_DMI) && !defined(CONFIG_ACPI)
> > >  static inline void pci_create_firmware_label_files(struct pci_dev *pdev)
> > > 
