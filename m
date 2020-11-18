Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804242B7A5A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 10:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgKRJ1i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 04:27:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgKRJ1h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 04:27:37 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 542B021D7E;
        Wed, 18 Nov 2020 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605691656;
        bh=f6G8pxdYhnIMJQRgM2hNOuAUWn03LcK6O1NJIy7VVa8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=twifQt4Xmf9lrOxQ13kvJvbNsU3QyN9I2BVtYn7as8xGVAh/udffIUo1r8QT4Yi+F
         ulu9G6Py++JHAEWp+d2hAtHmKhtq7gNeqJ5yEfy81BOuL2BDgCorEAcrMo1YfoVtIl
         yPzktb4zb8q0aSHcl3Glr11H5MTIip55z11j6iW4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kfJkT-00BdFg-S2; Wed, 18 Nov 2020 09:27:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Nov 2020 09:27:33 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Chen Baozi <chenbaozi@phytium.com.cn>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH V2] acpi/irq: Add stacked IRQ domain support to PCI
 interrupt link
In-Reply-To: <20201117134214.970-1-chenbaozi@phytium.com.cn>
References: <20201117134214.970-1-chenbaozi@phytium.com.cn>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <c4bc3817074c0793615440c6220f3813@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: chenbaozi@phytium.com.cn, ardb@kernel.org, guohanjun@huawei.com, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Chen,

On top of Bjorn's comments:

On 2020-11-17 13:42, Chen Baozi wrote:
> Some PCIe designs require software to do extra acknowledgements for
> legacy INTx interrupts. If the driver is written only for device tree,
> things are simple. In that case, a new driver can be written under
> driver/pci/controller/ with a DT node of PCIe host written like:
> 
>   pcie {
>     ...
>     interrupt-map = <0 0 0  1  &pcie_intc 0>,
>                     <0 0 0  2  &pcie_intc 1>,
>                     <0 0 0  3  &pcie_intc 2>,
>                     <0 0 0  4  &pcie_intc 3>;
> 
>     pcie_intc: legacy-interrupt-controller {
>       interrupt-controller;
>       #interrupt-cells = <1>;
>       interrupt-parent = <&gic>;
>       interrupts = <0 226 4>;
>     };
>   };
> 
> Similar designs can be found on Aardvark, MediaTek Gen2 and Socionext
> UniPhier PCIe controller at the moment. Essentially, those designs are
> supported by inserting an extra interrupt controller between PCIe host
> and GIC and parse the topology in a DT-based PCI controller driver.
> As we turn to ACPI, All the PCIe hosts are described the same ID of
> "PNP0A03" and share driver/acpi/pci_root.c. It comes to be a problem
> to make this kind of PCI INTx work under ACPI.
> 
> Therefore, we introduce an stacked IRQ domain support to PCI interrupt
> link for ACPI. With this support, we can populate the ResourceSource
> to refer to a device object that describes an interrupt controller.
> That would allow us to refer to a dedicated driver which implements
> the logic needed to manage the interrupt state. With this patch,
> those PCI interrupt links can be supported by describing the INTx
> in ACPI table as the following example:
> 
>   Device (IXIU) {
>     ...
>   }
> 
>   Device(LINKA) {
>     Name(_HID, EISAID("PNP0C0F"))
>     Name(_PRS, ResourceTemplate(){
>       Interrupt(ResourceProducer, Level, ActiveHigh, Exclusive, 0, 
> "\\SB.IXIU")
>         { 60 }
>     })
>     ...
>   }
> 
>   Device(PCI0) {
>     ...
>     Name(_PRT, Package{
>       Package{ 0x0000FFFF, 0, LINKA, 0 }
>       ...
>     })
>   }
> 
> Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
> ---
>  drivers/acpi/irq.c          | 22 +++++++++++++++++++++-
>  drivers/acpi/pci_irq.c      |  6 ++++--
>  drivers/acpi/pci_link.c     | 17 +++++++++++++++--
>  include/acpi/acpi_drivers.h |  2 +-
>  include/linux/acpi.h        |  4 ++++
>  5 files changed, 45 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index e209081d644b..e78a44815c44 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -81,6 +81,25 @@ void acpi_unregister_gsi(u32 gsi)
>  }
>  EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
> 
> +int acpi_register_irq(struct device *dev, u32 irq, int trigger,
> +		      int polarity, struct fwnode_handle *domain_id)
> +{
> +	struct irq_fwspec fwspec;
> +
> +	if (WARN_ON(!domain_id)) {
> +		pr_warn("GSI: No registered irqchip, giving up\n");

A fwnode_handle is not an irqchip. It's just an opaque identifier
for a HW block. Furthermore, there is no need to have both a WARN_ON()
and a pr_warn(). Please pick one.

I'd also suggest you rename domain_id to fwnode, which is the commonly
used idiom (yes, I know about the unfortunate precedent in 
acpi_register_gsi()).

> +		return -EINVAL;
> +	}
> +
> +	fwspec.fwnode = domain_id;
> +	fwspec.param[0] = irq;
> +	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
> +	fwspec.param_count = 2;
> +
> +	return irq_create_fwspec_mapping(&fwspec);
> +}
> +EXPORT_SYMBOL_GPL(acpi_register_irq);

By the way, this is almost an exact duplicate of acpi_register_gsi().
You definitely want to make this code common.

> +
>  /**
>   * acpi_get_irq_source_fwhandle() - Retrieve fwhandle from IRQ 
> resource source.
>   * @source: acpi_resource_source to use for the lookup.
> @@ -92,7 +111,7 @@ EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
>   * Return:
>   * The referenced device fwhandle or NULL on failure
>   */
> -static struct fwnode_handle *
> +struct fwnode_handle *
>  acpi_get_irq_source_fwhandle(const struct acpi_resource_source 
> *source)
>  {
>  	struct fwnode_handle *result;
> @@ -115,6 +134,7 @@ acpi_get_irq_source_fwhandle(const struct
> acpi_resource_source *source)
>  	acpi_bus_put_acpi_device(device);
>  	return result;
>  }
> +EXPORT_SYMBOL_GPL(acpi_get_irq_source_fwhandle);
> 
>  /*
>   * Context for the resource walk used to lookup IRQ resources.
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index 14ee631cb7cf..19296d70c95c 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -410,6 +410,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>  	char *link = NULL;
>  	char link_desc[16];
>  	int rc;
> +	struct fwnode_handle *irq_domain;

fwnode_handle is most definitely not an IRQ domain.

> 
>  	pin = dev->pin;
>  	if (!pin) {
> @@ -438,7 +439,8 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>  			gsi = acpi_pci_link_allocate_irq(entry->link,
>  							 entry->index,
>  							 &triggering, &polarity,
> -							 &link);
> +							 &link,
> +							 &irq_domain);
>  		else
>  			gsi = entry->index;
>  	} else
> @@ -462,7 +464,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>  		return 0;
>  	}
> 
> -	rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
> +	rc = acpi_register_irq(&dev->dev, gsi, triggering, polarity, 
> irq_domain);
>  	if (rc < 0) {
>  		dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
>  			 pin_name(pin));
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index fb4c5632a232..219a644d739a 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -59,6 +59,7 @@ struct acpi_pci_link_irq {
>  	u8 resource_type;
>  	u8 possible_count;
>  	u32 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
> +	struct acpi_resource_source resource_source;
>  	u8 initialized:1;
>  	u8 reserved:7;
>  };
> @@ -120,6 +121,8 @@ static acpi_status
> acpi_pci_link_check_possible(struct acpi_resource *resource,
>  		{
>  			struct acpi_resource_extended_irq *p =
>  			    &resource->data.extended_irq;
> +			struct acpi_resource_source *rs =
> +			    &link->irq.resource_source;
>  			if (!p || !p->interrupt_count) {
>  				printk(KERN_WARNING PREFIX
>  					      "Blank _PRS EXT IRQ resource\n");
> @@ -140,6 +143,12 @@ static acpi_status
> acpi_pci_link_check_possible(struct acpi_resource *resource,
>  			link->irq.triggering = p->triggering;
>  			link->irq.polarity = p->polarity;
>  			link->irq.resource_type = ACPI_RESOURCE_TYPE_EXTENDED_IRQ;
> +			if (p->resource_source.string_length) {
> +				rs->index = p->resource_source.index;
> +				rs->string_length = p->resource_source.string_length;
> +				rs->string_ptr = kmalloc(rs->string_length, GFP_KERNEL);
> +				strcpy(rs->string_ptr, p->resource_source.string_ptr);

We have kstrdup() for this kind of things, as using rs->string_length to 
allocate
the buffer and strcpy() to copy it feels... dangerous.

> +			}
>  			break;
>  		}
>  	default:
> @@ -326,7 +335,8 @@ static int acpi_pci_link_set(struct acpi_pci_link
> *link, int irq)
>  			resource->res.data.extended_irq.shareable = ACPI_SHARED;
>  		resource->res.data.extended_irq.interrupt_count = 1;
>  		resource->res.data.extended_irq.interrupts[0] = irq;
> -		/* ignore resource_source, it's optional */
> +		resource->res.data.extended_irq.resource_source =
> +			link->irq.resource_source;
>  		break;
>  	default:
>  		printk(KERN_ERR PREFIX "Invalid Resource_type %d\n",
> link->irq.resource_type);
> @@ -612,7 +622,7 @@ static int acpi_pci_link_allocate(struct
> acpi_pci_link *link)
>   * failure: return -1
>   */
>  int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int 
> *triggering,
> -			       int *polarity, char **name)
> +			       int *polarity, char **name, struct fwnode_handle 
> **irq_domain)

Same remark about the naming.

>  {
>  	int result;
>  	struct acpi_device *device;
> @@ -656,6 +666,9 @@ int acpi_pci_link_allocate_irq(acpi_handle handle,
> int index, int *triggering,
>  		*polarity = link->irq.polarity;
>  	if (name)
>  		*name = acpi_device_bid(link->device);
> +	if (irq_domain)
> +		*irq_domain = 
> acpi_get_irq_source_fwhandle(&link->irq.resource_source);
> +
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  			  "Link %s is referenced\n",
>  			  acpi_device_bid(link->device)));
> diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> index 5eb175933a5b..6ff1ea76d476 100644
> --- a/include/acpi/acpi_drivers.h
> +++ b/include/acpi/acpi_drivers.h
> @@ -68,7 +68,7 @@
> 
>  int acpi_irq_penalty_init(void);
>  int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int 
> *triggering,
> -			       int *polarity, char **name);
> +			       int *polarity, char **name, struct fwnode_handle 
> **irq_domain);
>  int acpi_pci_link_free_irq(acpi_handle handle);
> 
>  /* ACPI PCI Device Binding (pci_bind.c) */
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 39263c6b52e1..5f1d7d3192fb 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -324,6 +324,8 @@ extern int sbf_port;
>  extern unsigned long acpi_realmode_flags;
> 
>  int acpi_register_gsi (struct device *dev, u32 gsi, int triggering,
> int polarity);
> +int acpi_register_irq(struct device *dev, u32 gsi, int trigger,
> +		      int polarity, struct fwnode_handle *domain_id);
>  int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
>  int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
> 
> @@ -336,6 +338,8 @@ struct irq_domain
> *acpi_irq_create_hierarchy(unsigned int flags,
>  					     const struct irq_domain_ops *ops,
>  					     void *host_data);
> 
> +struct fwnode_handle *acpi_get_irq_source_fwhandle(const struct
> acpi_resource_source *source);
> +
>  #ifdef CONFIG_X86_IO_APIC
>  extern int acpi_get_override_irq(u32 gsi, int *trigger, int 
> *polarity);
>  #else

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
