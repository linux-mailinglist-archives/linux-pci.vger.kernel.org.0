Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4608C2A812D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 15:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbgKEOoy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 09:44:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730461AbgKEOox (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 09:44:53 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F9A720936;
        Thu,  5 Nov 2020 14:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604587492;
        bh=5FiNUpBTWnS1+JvY0Wfv3Bkzj003q4PW+FPEf75maAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fX9IGv8JC7Dgu3NaU2ko8n+eNJaA5s/NHK3pK5EX3h7SZrhcdkW+KT2H8X2MKeNRH
         7PfKTrappw4QILDVRJ8PYcYaXtavJc8uwSP47KFdLP6+dSaqoe0Gvj7EEdRA+rfOOI
         mE2kZDtNx1T1eLhWrEgU9FSmTUXdFLI4pUZVdLPA=
Date:   Thu, 5 Nov 2020 08:44:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 23/56] PCI: fix kernel-doc markups
Message-ID: <20201105144451.GA496849@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f19caf7a68f8365c8b573a42b4ac89ec21925c73.1603469755.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 23, 2020 at 06:33:10PM +0200, Mauro Carvalho Chehab wrote:
> Some identifiers have different names between their prototypes
> and the kernel-doc markup.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied to pci/misc for v5.11, thanks!

> ---
>  drivers/pci/p2pdma.c     | 10 +++++-----
>  drivers/pci/pci-driver.c |  4 ++--
>  drivers/pci/pci.c        |  2 +-
>  drivers/pci/probe.c      |  4 ++--
>  drivers/pci/slot.c       |  5 +++--
>  5 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index de1c331dbed4..bace04145c5f 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -609,7 +609,7 @@ bool pci_has_p2pmem(struct pci_dev *pdev)
>  EXPORT_SYMBOL_GPL(pci_has_p2pmem);
>  
>  /**
> - * pci_p2pmem_find - find a peer-to-peer DMA memory device compatible with
> + * pci_p2pmem_find_many - find a peer-to-peer DMA memory device compatible with
>   *	the specified list of clients and shortest distance (as determined
>   *	by pci_p2pmem_dma())
>   * @clients: array of devices to check (NULL-terminated)
> @@ -674,7 +674,7 @@ struct pci_dev *pci_p2pmem_find_many(struct device **clients, int num_clients)
>  EXPORT_SYMBOL_GPL(pci_p2pmem_find_many);
>  
>  /**
> - * pci_alloc_p2p_mem - allocate peer-to-peer DMA memory
> + * pci_alloc_p2pmem - allocate peer-to-peer DMA memory
>   * @pdev: the device to allocate memory from
>   * @size: number of bytes to allocate
>   *
> @@ -727,7 +727,7 @@ void pci_free_p2pmem(struct pci_dev *pdev, void *addr, size_t size)
>  EXPORT_SYMBOL_GPL(pci_free_p2pmem);
>  
>  /**
> - * pci_virt_to_bus - return the PCI bus address for a given virtual
> + * pci_p2pmem_virt_to_bus - return the PCI bus address for a given virtual
>   *	address obtained with pci_alloc_p2pmem()
>   * @pdev: the device the memory was allocated from
>   * @addr: address of the memory that was allocated
> @@ -859,7 +859,7 @@ static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
>  }
>  
>  /**
> - * pci_p2pdma_map_sg - map a PCI peer-to-peer scatterlist for DMA
> + * pci_p2pdma_map_sg_attrs - map a PCI peer-to-peer scatterlist for DMA
>   * @dev: device doing the DMA request
>   * @sg: scatter list to map
>   * @nents: elements in the scatterlist
> @@ -896,7 +896,7 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>  EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
>  
>  /**
> - * pci_p2pdma_unmap_sg - unmap a PCI peer-to-peer scatterlist that was
> + * pci_p2pdma_unmap_sg_attrs - unmap a PCI peer-to-peer scatterlist that was
>   *	mapped with pci_p2pdma_map_sg()
>   * @dev: device doing the DMA request
>   * @sg: scatter list to map
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 8b587fc97f7b..591ab353844a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -90,7 +90,7 @@ static void pci_free_dynids(struct pci_driver *drv)
>  }
>  
>  /**
> - * store_new_id - sysfs frontend to pci_add_dynid()
> + * new_id_store - sysfs frontend to pci_add_dynid()
>   * @driver: target device driver
>   * @buf: buffer for scanning device ID data
>   * @count: input size
> @@ -158,7 +158,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
>  static DRIVER_ATTR_WO(new_id);
>  
>  /**
> - * store_remove_id - remove a PCI device ID from this driver
> + * remove_id_store - remove a PCI device ID from this driver
>   * @driver: target device driver
>   * @buf: buffer for scanning device ID data
>   * @count: input size
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6d4d5a2f923d..8b9bea8ba751 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3480,7 +3480,7 @@ bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
>  }
>  
>  /**
> - * pci_acs_path_enable - test ACS flags from start to end in a hierarchy
> + * pci_acs_path_enabled - test ACS flags from start to end in a hierarchy
>   * @start: starting downstream device
>   * @end: ending upstream device or NULL to search to the root bus
>   * @acs_flags: required flags
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4289030b0fff..eb1ec037f9e7 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -165,7 +165,7 @@ static inline unsigned long decode_bar(struct pci_dev *dev, u32 bar)
>  #define PCI_COMMAND_DECODE_ENABLE	(PCI_COMMAND_MEMORY | PCI_COMMAND_IO)
>  
>  /**
> - * pci_read_base - Read a PCI BAR
> + * __pci_read_base - Read a PCI BAR
>   * @dev: the PCI device
>   * @type: type of the BAR
>   * @res: resource buffer to be filled in
> @@ -1612,7 +1612,7 @@ static bool pci_ext_cfg_is_aliased(struct pci_dev *dev)
>  }
>  
>  /**
> - * pci_cfg_space_size - Get the configuration space size of the PCI device
> + * pci_cfg_space_size_ext - Get the configuration space size of the PCI device
>   * @dev: PCI device
>   *
>   * Regular PCI devices have 256 bytes, but PCI-X 2 and PCI Express devices
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 3861505741e6..bcc8b12ce5da 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -323,7 +323,7 @@ EXPORT_SYMBOL_GPL(pci_destroy_slot);
>  #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
>  #include <linux/pci_hotplug.h>
>  /**
> - * pci_hp_create_link - create symbolic link to the hotplug driver module.
> + * pci_hp_create_module_link - create symbolic link to the hotplug driver module.
>   * @pci_slot: struct pci_slot
>   *
>   * Helper function for pci_hotplug_core.c to create symbolic link to
> @@ -349,7 +349,8 @@ void pci_hp_create_module_link(struct pci_slot *pci_slot)
>  EXPORT_SYMBOL_GPL(pci_hp_create_module_link);
>  
>  /**
> - * pci_hp_remove_link - remove symbolic link to the hotplug driver module.
> + * pci_hp_remove_module_link - remove symbolic link to the hotplug driver
> + * 	module.
>   * @pci_slot: struct pci_slot
>   *
>   * Helper function for pci_hotplug_core.c to remove symbolic link to
> -- 
> 2.26.2
> 
