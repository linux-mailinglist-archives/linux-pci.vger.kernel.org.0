Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBE7297B36
	for <lists+linux-pci@lfdr.de>; Sat, 24 Oct 2020 09:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759861AbgJXHaq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Oct 2020 03:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759859AbgJXHaq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 24 Oct 2020 03:30:46 -0400
Received: from coco.lan (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17A45208E4;
        Sat, 24 Oct 2020 07:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603524645;
        bh=SHiTKCGrkGwFF0ORlgvYKwNjJ4j0nggqLo79XV+7E5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lfaY30C1cZvkHdbSkkIR4SXWW42YJs4+iJ6eu/6MaML4Dbd4A/M4CzSIlhfU591VP
         J6eHwSLgA2xqc/HSbayeaBT+Jh16Vz3Rtk0ETCWphbNbizOWKTRIjLbhy2OinH4TKR
         glIk2vx9Xfuh1vZkYZva+RB/K0YeSzln/m1ORAJk=
Date:   Sat, 24 Oct 2020 09:30:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 23/56] PCI: fix kernel-doc markups
Message-ID: <20201024093041.23ce7388@coco.lan>
In-Reply-To: <20201023174325.GA668264@bjorn-Precision-5520>
References: <f19caf7a68f8365c8b573a42b4ac89ec21925c73.1603469755.git.mchehab+huawei@kernel.org>
        <20201023174325.GA668264@bjorn-Precision-5520>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Fri, 23 Oct 2020 12:43:25 -0500
Bjorn Helgaas <helgaas@kernel.org> escreveu:

> If you have the opportunity, I would prefer to capitalize the subject
> to follow the drivers/pci convention, e.g.,
> 
>   PCI: Fix ...

Ok. If you want to apply it directly, feel free to change it
at the patch.

Otherwise, I'll do it on a next rebase.

> 
> On Fri, Oct 23, 2020 at 06:33:10PM +0200, Mauro Carvalho Chehab wrote:
> > Some identifiers have different names between their prototypes
> > and the kernel-doc markup.  
> 
> How did you find these?  I build with "make W=1", which finds some
> kernel-doc errors, but it didn't find these.  If there's a scanner for
> these, I could fix things like this before merging them.

This is a new check. See patch 56/56.

Right now, kernel-doc will just silently ignore the identifier
from kernel-doc markup and use the one defined at the function
or data struct prototype.

Once all the issues gets fixed, patch 56/56 can be merged.

> 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> I'd be happy to take this myself, but if you want to merge the whole
> series together:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Either way works for me, although IMO it should be simpler if
you could pick it directly, as it will avoid potential
merge conflicts if such patches go via their usual trees.

> 
> > ---
> >  drivers/pci/p2pdma.c     | 10 +++++-----
> >  drivers/pci/pci-driver.c |  4 ++--
> >  drivers/pci/pci.c        |  2 +-
> >  drivers/pci/probe.c      |  4 ++--
> >  drivers/pci/slot.c       |  5 +++--
> >  5 files changed, 13 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index de1c331dbed4..bace04145c5f 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> > @@ -609,7 +609,7 @@ bool pci_has_p2pmem(struct pci_dev *pdev)
> >  EXPORT_SYMBOL_GPL(pci_has_p2pmem);
> >  
> >  /**
> > - * pci_p2pmem_find - find a peer-to-peer DMA memory device compatible with
> > + * pci_p2pmem_find_many - find a peer-to-peer DMA memory device compatible with
> >   *	the specified list of clients and shortest distance (as determined
> >   *	by pci_p2pmem_dma())
> >   * @clients: array of devices to check (NULL-terminated)
> > @@ -674,7 +674,7 @@ struct pci_dev *pci_p2pmem_find_many(struct device **clients, int num_clients)
> >  EXPORT_SYMBOL_GPL(pci_p2pmem_find_many);
> >  
> >  /**
> > - * pci_alloc_p2p_mem - allocate peer-to-peer DMA memory
> > + * pci_alloc_p2pmem - allocate peer-to-peer DMA memory
> >   * @pdev: the device to allocate memory from
> >   * @size: number of bytes to allocate
> >   *
> > @@ -727,7 +727,7 @@ void pci_free_p2pmem(struct pci_dev *pdev, void *addr, size_t size)
> >  EXPORT_SYMBOL_GPL(pci_free_p2pmem);
> >  
> >  /**
> > - * pci_virt_to_bus - return the PCI bus address for a given virtual
> > + * pci_p2pmem_virt_to_bus - return the PCI bus address for a given virtual
> >   *	address obtained with pci_alloc_p2pmem()
> >   * @pdev: the device the memory was allocated from
> >   * @addr: address of the memory that was allocated
> > @@ -859,7 +859,7 @@ static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
> >  }
> >  
> >  /**
> > - * pci_p2pdma_map_sg - map a PCI peer-to-peer scatterlist for DMA
> > + * pci_p2pdma_map_sg_attrs - map a PCI peer-to-peer scatterlist for DMA
> >   * @dev: device doing the DMA request
> >   * @sg: scatter list to map
> >   * @nents: elements in the scatterlist
> > @@ -896,7 +896,7 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
> >  EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
> >  
> >  /**
> > - * pci_p2pdma_unmap_sg - unmap a PCI peer-to-peer scatterlist that was
> > + * pci_p2pdma_unmap_sg_attrs - unmap a PCI peer-to-peer scatterlist that was
> >   *	mapped with pci_p2pdma_map_sg()
> >   * @dev: device doing the DMA request
> >   * @sg: scatter list to map
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 8b587fc97f7b..591ab353844a 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -90,7 +90,7 @@ static void pci_free_dynids(struct pci_driver *drv)
> >  }
> >  
> >  /**
> > - * store_new_id - sysfs frontend to pci_add_dynid()
> > + * new_id_store - sysfs frontend to pci_add_dynid()
> >   * @driver: target device driver
> >   * @buf: buffer for scanning device ID data
> >   * @count: input size
> > @@ -158,7 +158,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
> >  static DRIVER_ATTR_WO(new_id);
> >  
> >  /**
> > - * store_remove_id - remove a PCI device ID from this driver
> > + * remove_id_store - remove a PCI device ID from this driver
> >   * @driver: target device driver
> >   * @buf: buffer for scanning device ID data
> >   * @count: input size
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 6d4d5a2f923d..8b9bea8ba751 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3480,7 +3480,7 @@ bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
> >  }
> >  
> >  /**
> > - * pci_acs_path_enable - test ACS flags from start to end in a hierarchy
> > + * pci_acs_path_enabled - test ACS flags from start to end in a hierarchy
> >   * @start: starting downstream device
> >   * @end: ending upstream device or NULL to search to the root bus
> >   * @acs_flags: required flags
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 4289030b0fff..eb1ec037f9e7 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -165,7 +165,7 @@ static inline unsigned long decode_bar(struct pci_dev *dev, u32 bar)
> >  #define PCI_COMMAND_DECODE_ENABLE	(PCI_COMMAND_MEMORY | PCI_COMMAND_IO)
> >  
> >  /**
> > - * pci_read_base - Read a PCI BAR
> > + * __pci_read_base - Read a PCI BAR
> >   * @dev: the PCI device
> >   * @type: type of the BAR
> >   * @res: resource buffer to be filled in
> > @@ -1612,7 +1612,7 @@ static bool pci_ext_cfg_is_aliased(struct pci_dev *dev)
> >  }
> >  
> >  /**
> > - * pci_cfg_space_size - Get the configuration space size of the PCI device
> > + * pci_cfg_space_size_ext - Get the configuration space size of the PCI device
> >   * @dev: PCI device
> >   *
> >   * Regular PCI devices have 256 bytes, but PCI-X 2 and PCI Express devices
> > diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> > index 3861505741e6..bcc8b12ce5da 100644
> > --- a/drivers/pci/slot.c
> > +++ b/drivers/pci/slot.c
> > @@ -323,7 +323,7 @@ EXPORT_SYMBOL_GPL(pci_destroy_slot);
> >  #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
> >  #include <linux/pci_hotplug.h>
> >  /**
> > - * pci_hp_create_link - create symbolic link to the hotplug driver module.
> > + * pci_hp_create_module_link - create symbolic link to the hotplug driver module.
> >   * @pci_slot: struct pci_slot
> >   *
> >   * Helper function for pci_hotplug_core.c to create symbolic link to
> > @@ -349,7 +349,8 @@ void pci_hp_create_module_link(struct pci_slot *pci_slot)
> >  EXPORT_SYMBOL_GPL(pci_hp_create_module_link);
> >  
> >  /**
> > - * pci_hp_remove_link - remove symbolic link to the hotplug driver module.
> > + * pci_hp_remove_module_link - remove symbolic link to the hotplug driver
> > + * 	module.
> >   * @pci_slot: struct pci_slot
> >   *
> >   * Helper function for pci_hotplug_core.c to remove symbolic link to
> > -- 
> > 2.26.2
> >   



Thanks,
Mauro
