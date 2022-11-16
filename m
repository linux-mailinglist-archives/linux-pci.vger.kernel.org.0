Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F6D62CA7A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 21:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiKPURO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 15:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKPURL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 15:17:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAC666C95;
        Wed, 16 Nov 2022 12:17:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03C9D61F8C;
        Wed, 16 Nov 2022 20:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAF6C433C1;
        Wed, 16 Nov 2022 20:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668629829;
        bh=JCMrWzNi17gtVdAgGb8ljLb3cjAgUw/SAysa1qozUjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SUASEvR/9cGSaHC1omhFU1BTdkOqIgpp/dvw74Pb1nG8IFwkdnUGBUPbxvhGw+ngW
         5DtGKGAjd5WrzvHxvifvDV8xQBTISWT1fmUKBVTixbxMDDaShbohDQgl35MCOoN0xs
         1nWFU9rBTw6ksa6Ka7FB1tJvF9yaZv2+KtwpR0TyncmnczLjJ86JdC+IDmm7goFSXd
         ZzKDJY/esve5yc0NMPYBymqZW57+7C7fTmbHqu1Ot4+ZLYF2Hc6Qv+wU7EbTy9V+kW
         DEQ1r9R6z66Y57k96Eggcl65oGrDgXw1mIo0wq2bHdIh3xiP1l3LTJkUHR7IRVHPZH
         QvMjNaxmaUvmA==
Date:   Wed, 16 Nov 2022 14:17:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 28/33] PCI/MSI: Provide IMS (Interrupt Message Store)
 support
Message-ID: <20221116201707.GA1133795@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135206.855773120@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:55PM +0100, Thomas Gleixner wrote:
> IMS (Interrupt Message Store) is a new specification which allows
> implementation specific storage of MSI messages contrary to the
> strict standard specified MSI and MSI-X message stores.
> 
> This requires new device specific interrupt domains to handle the
> implementation defined storage which can be an array in device memory or
> host/guest memory which is shared with hardware queues.
> 
> Add a function to create IMS domains for PCI devices. IMS domains are using
> the new per device domain mechanism and are configured by the device driver
> via a template. IMS domains are created as secondary device domains so they
> work side on side with MSI[-X] on the same device.
> 
> The IMS domains have a few constraints:
> 
>   - The index space is managed by the core code.
> 
>     Device memory based IMS provides a storage array with a fixed size
>     which obviously requires an index. But there is no association between
>     index and functionality so the core can randomly allocate an index in
>     the array.
> 
>     Queue memory based IMS does not have the concept of an index as the
>     storage is somewhere in memory. In that case the index is purely
>     software based to keep track of the allocations.
> 
>   - There is no requirement for consecutive index ranges
> 
>     This is currently a limitation of the MSI core and can be implemented
>     if there is a justified use case by changing the internal storage from
>     xarray to maple_tree. For now it's single vector allocation.
> 
>   - The interrupt chip must provide the following callbacks:
> 
>   	- irq_mask()
> 	- irq_unmask()
> 	- irq_write_msi_msg()
> 
>    - The interrupt chip must provide the following optional callbacks
>      when the irq_mask(), irq_unmask() and irq_write_msi_msg() callbacks
>      cannot operate directly on hardware, e.g. in the case that the
>      interrupt message store is in queue memory:
> 
>      	- irq_bus_lock()
> 	- irq_bus_unlock()
> 
>      These callbacks are invoked from preemptible task context and are
>      allowed to sleep. In this case the mandatory callbacks above just
>      store the information. The irq_bus_unlock() callback is supposed to
>      make the change effective before returning.
> 
>    - Interrupt affinity setting is handled by the underlying parent
>      interrupt domain and communicated to the IMS domain via
>      irq_write_msi_msg(). IMS domains cannot have a irq_set_affinity()
>      callback. That's a reasonable restriction similar to the PCI/MSI
>      device domain implementations.
> 
> The domain is automatically destroyed when the PCI device is removed.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

A couple typos below.

> ---
>  drivers/pci/msi/irqdomain.c |   59 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h         |    5 +++
>  2 files changed, 64 insertions(+)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -355,6 +355,65 @@ bool pci_msi_domain_supports(struct pci_
>  	return (supported & feature_mask) == feature_mask;
>  }
>  
> +/**
> + * pci_create_ims_domain - Create a secondary IMS domain for a PCI device
> + * @pdev:	The PCI device to operate on
> + * @template:	The MSI info template which describes the domain
> + * @hwsize:	The size of the hardware entry table or 0 if the domain
> + *		is purely software managed
> + * @data:	Optional pointer to domain specific data to be stored
> + *		in msi_domain_info::data
> + *
> + * Return: True on success, false otherwise
> + *
> + * A IMS domain is expected to have the following constraints:

An IMS ...

> + *	- The index space is managed by the core code
> + *
> + *	- There is no requirement for consecutive index ranges
> + *
> + *	- The interrupt chip must provide the following callbacks:
> + *		- irq_mask()
> + *		- irq_unmask()
> + *		- irq_write_msi_msg()
> + *
> + *	- The interrupt chip must provide the following optional callbacks
> + *	  when the irq_mask(), irq_unmask() and irq_write_msi_msg() callbacks
> + *	  cannot operate directly on hardware, e.g. in the case that the
> + *	  interrupt message store is in queue memory:
> + *		- irq_bus_lock()
> + *		- irq_bus_unlock()
> + *
> + *	  These callbacks are invoked from preemptible task context and are
> + *	  allowed to sleep. In this case the mandatory callbacks above just
> + *	  store the information. The irq_bus_unlock() callback is supposed
> + *	  to make the change effective before returning.
> + *
> + *     - Interrupt affinity setting is handled by the underlying parent
> + *	 interrupt domain and communicated to the IMS domain via
> + *	 irq_write_msi_msg().

Different indentation than the bullet items above.

> + *
> + * The domain is automatically destroyed when the PCI device is removed.
> + */
> +bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
> +			   unsigned int hwsize, void *data)
> +{
> +	struct irq_domain *domain = dev_get_msi_domain(&pdev->dev);
> +
> +	if (!domain || !irq_domain_is_msi_parent(domain))
> +		return -ENOTSUPP;
> +
> +	if (template->info.bus_token != DOMAIN_BUS_PCI_DEVICE_IMS ||
> +	    !(template->info.flags & MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS) ||
> +	    !(template->info.flags & MSI_FLAG_FREE_MSI_DESCS) ||
> +	    !template->chip.irq_mask || !template->chip.irq_unmask ||
> +	    !template->chip.irq_write_msi_msg || template->chip.irq_set_affinity)
> +		return -EINVAL;
> +
> +	return msi_create_device_irq_domain(&pdev->dev, MSI_SECONDARY_DOMAIN, template,
> +					    hwsize, data, NULL);
> +}
> +EXPORT_SYMBOL_GPL(pci_create_ims_domain);
> +
>  /*
>   * Users of the generic MSI infrastructure expect a device to have a single ID,
>   * so with DMA aliases we have to pick the least-worst compromise. Devices with
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2481,6 +2481,11 @@ static inline bool pci_is_thunderbolt_at
>  void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
>  #endif
>  
> +struct msi_domain_template;
> +
> +bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
> +			   unsigned int hwsize, void *data);
> +
>  #include <linux/dma-mapping.h>
>  
>  #define pci_printk(level, pdev, fmt, arg...) \
> 
