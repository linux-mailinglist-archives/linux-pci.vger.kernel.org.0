Return-Path: <linux-pci+bounces-26411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6101A9717D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 17:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E457A3276
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E3728FFE1;
	Tue, 22 Apr 2025 15:45:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2AD156F5D
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336745; cv=none; b=MP5Dxlx7SCYJLtKnlvonFRJzK071Z8nUu1FyruixEGqR7r5gPAqavqekGYdo5Bqim/MeSY4a61itSH2RmuVU1SriL6smHxhnNz+z+WG0JsIH64vrCeyDBNzl5Ki/MvubmkcW3dA+rZgzhzWBcdNA0uCddf09KnH22lCnC8M26t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336745; c=relaxed/simple;
	bh=Yc/njjikLB7pJek5qNVZjux+lwf0ItxDzbn6A5IGiV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxp6dpKGlzbuZrp4Th1DYcuzGwcoGT/e7pou6FijiIQ/EP44PoQVKQQBIuYzSq3Kw0ozs8VP1LT4LLO61uTnxLWsMHou4L/8jjH6Z6unv8Q9ItTIG/mEvugobU6Lr5xCh4jS/gxK5Swij2GkMfInWCahJKr0RtKnmd+2/px/xak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BB5F152B;
	Tue, 22 Apr 2025 08:45:36 -0700 (PDT)
Received: from [10.57.44.84] (unknown [10.57.44.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC87C3F5A1;
	Tue, 22 Apr 2025 08:45:38 -0700 (PDT)
Message-ID: <5fc4564e-e076-4575-ac23-90747a62ae2a@arm.com>
Date: Tue, 22 Apr 2025 16:45:38 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH 3/3] samples: devsec: Add support for
 PCI_DOMAINS_GENERIC
To: Dan Williams <dan.j.williams@intel.com>
Cc: lpieralisi@kernel.org, robin.murphy@arm.com, aneesh.kumar@kernel.org,
 linux-coco@lists.linux.dev, bhelgaas@google.com, lukas@wunner.de,
 sameo@rivosinc.com, aik@amd.com, yilun.xu@linux.intel.com,
 linux-pci@vger.kernel.org
References: <20250311141712.145625-1-suzuki.poulose@arm.com>
 <20250311144601.145736-1-suzuki.poulose@arm.com>
 <20250311144601.145736-3-suzuki.poulose@arm.com>
 <68053cf43bb54_7205294cc@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-GB
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <68053cf43bb54_7205294cc@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dan

On 20/04/2025 19:29, Dan Williams wrote:
> Suzuki K Poulose wrote:
>> Allocate/free a domain at runtime for the sample devsec TSM.
>>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   samples/Kconfig         |  1 -
>>   samples/devsec/bus.c    | 32 +++++++++++++++++++++-----------
>>   samples/devsec/common.c |  2 +-
>>   samples/devsec/devsec.h |  2 +-
>>   4 files changed, 23 insertions(+), 14 deletions(-)
>>
>> diff --git a/samples/Kconfig b/samples/Kconfig
>> index 6bd64fc54ac1..f23be5088b9e 100644
>> --- a/samples/Kconfig
>> +++ b/samples/Kconfig
>> @@ -308,7 +308,6 @@ config SAMPLE_DEVSEC
>>   	tristate "Build a sample TEE Security Manager with an emulated PCI endpoint"
>>   	depends on PCI
>>   	depends on VIRT_DRIVERS
>> -	depends on X86 # TODO: PCI_DOMAINS_GENERIC support
>>   	select PCI_BRIDGE_EMUL
>>   	select PCI_TSM
>>   	select TSM
>> diff --git a/samples/devsec/bus.c b/samples/devsec/bus.c
>> index b78c04b21eb9..8ec04b3549f0 100644
>> --- a/samples/devsec/bus.c
>> +++ b/samples/devsec/bus.c
>> @@ -21,7 +21,7 @@
>>   #define NR_DEVSEC_DEVS 1
>>   
>>   struct devsec {
>> -	struct pci_sysdata sysdata;
>> +	int domain;
>>   	struct gen_pool *iomem_pool;
>>   	struct resource resource[2];
>>   	struct pci_bus *bus;
>> @@ -70,7 +70,7 @@ struct devsec {
>>   
>>   static struct devsec *bus_to_devsec(struct pci_bus *bus)
>>   {
>> -	return container_of(bus->sysdata, struct devsec, sysdata);
>> +	return container_of(bus->sysdata, struct devsec, domain);
>>   }
>>   
>>   static int devsec_dev_config_read(struct devsec *devsec, struct pci_bus *bus,
>> @@ -309,6 +309,17 @@ static struct pci_ops devsec_ops = {
>>   };
>>   
>>   /* borrowed from vmd_find_free_domain() */
>> +#ifdef CONFIG_PCI_GENERIC_DOMAINS
> 
> The config symbol name is PCI_DOMAINS_GENERIC, so the only way I can see
> this patch working is if you have ACPI=n in your build? See below.

You're right. But I did have ACPI=y, but built it for only arm64 (but 
only booted with DT).

>> @@ -633,15 +645,13 @@ static int __init devsec_bus_probe(struct platform_device *pdev)
>>   	};
>>   	pci_add_resource(&resources, &devsec->resource[1]);
>>   
>> -	sd = &devsec->sysdata;
>> -	devsec_sysdata = sd;
>> -	sd->domain = find_free_domain();
>> -	if (sd->domain < 0)
>> -		return sd->domain;
>> -
>> +	devsec_sysdata = &devsec->domain;
>> +	devsec->domain = find_free_domain();
>> +	if (devsec->domain < 0)
>> +		return devsec->domain;
>>   
>>   	devsec->bus = pci_create_root_bus(dev, 0, &devsec_ops,
>> -					  &devsec->sysdata, &resources);
>> +					  &devsec->domain, &resources);
> 
> See pci_register_host_bridge()... I don't think this works unless you
> have CONFIG_ACPI=n to avoid trying to lookup the non-existent ACPI
> device associated with this fake bridge.
> 
> I think the path here is to make emulated host bridges a first-class
> citizen of the PCI core.
> 
> The below seems to work. It adds a new pci_bus_find_emul_domain_nr() to
> unify a few cases where PCI domain host-bridges are being emulated, and
> it allows to the emulated domain_nr to be established between
> pci_alloc_host_bridge() and pci_register_host_bridge(). It still needs
> to play pci_sysdata hiding games for now:

I have tested this on arm64 (Juno board) with ACPI and DT and it works*

I have spotted a crash with an unrelated bug in the GICv2M driver, with
ACPI. I will send out a fix for that.

Thanks for reworking the patch !

FWIW:

Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com> # on Arm64

Suzuki


> 
> -- 8< --
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 8df064b62a2f..efef329c359a 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -565,22 +565,6 @@ static void vmd_detach_resources(struct vmd_dev *vmd)
>   	vmd->dev->resource[VMD_MEMBAR2].child = NULL;
>   }
>   
> -/*
> - * VMD domains start at 0x10000 to not clash with ACPI _SEG domains.
> - * Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of which the lower
> - * 16 bits are the PCI Segment Group (domain) number.  Other bits are
> - * currently reserved.
> - */
> -static int vmd_find_free_domain(void)
> -{
> -	int domain = 0xffff;
> -	struct pci_bus *bus = NULL;
> -
> -	while ((bus = pci_find_next_bus(bus)) != NULL)
> -		domain = max_t(int, domain, pci_domain_nr(bus));
> -	return domain + 1;
> -}
> -
>   static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
>   				resource_size_t *offset1,
>   				resource_size_t *offset2)
> @@ -866,7 +850,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>   	};
>   
>   	sd->vmd_dev = vmd->dev;
> -	sd->domain = vmd_find_free_domain();
> +	sd->domain = pci_bus_find_emul_domain_nr();
>   	if (sd->domain < 0)
>   		return sd->domain;
>   
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4d7c9f64ea24..0d5a08583197 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6774,7 +6774,7 @@ static void of_pci_bus_release_domain_nr(struct device *parent, int domain_nr)
>   		return;
>   
>   	/* Release domain from IDA where it was allocated. */
> -	if (of_get_pci_domain_nr(parent->of_node) == domain_nr)
> +	if (parent && of_get_pci_domain_nr(parent->of_node) == domain_nr)
>   		ida_free(&pci_domain_nr_static_ida, domain_nr);
>   	else
>   		ida_free(&pci_domain_nr_dynamic_ida, domain_nr);
> @@ -6794,6 +6794,42 @@ void pci_bus_release_domain_nr(struct device *parent, int domain_nr)
>   }
>   #endif
>   
> +/*
> + * Find a free domain_nr either allocated by of_pci_bus_find_domain_nr()
> + * or fallback to the first free domain number above the last ACPI
> + * segment number, do not ask acpi_pci_bus_find_domain_nr() it has no
> + * information about emulated host bridges
> + */
> +int pci_bus_find_emul_domain_nr(void)
> +{
> +	/*
> +	 * Emulated domains start at 0x10000 to not clash with ACPI _SEG
> +	 * domains.  Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of
> +	 * which the lower 16 bits are the PCI Segment Group (domain) number.
> +	 * Other bits are currently reserved.
> +	 */
> +	int domain = 0xffff;
> +	struct pci_bus *bus = NULL;
> +
> +#ifdef CONFIG_PCI_DOMAINS_GENERIC
> +	if (acpi_disabled)
> +		return of_pci_bus_find_domain_nr(NULL);
> +#endif
> +
> +	while ((bus = pci_find_next_bus(bus)) != NULL)
> +		domain = max_t(int, domain, pci_domain_nr(bus));
> +	return domain + 1;
> +}
> +EXPORT_SYMBOL_GPL(pci_bus_find_emul_domain_nr);
> +
> +void pci_bus_release_emul_domain_nr(int domain_nr)
> +{
> +#ifdef CONFIG_PCI_DOMAINS_GENERIC
> +	/* Note that in the in the ACPI emulation case this is a nop */
> +	pci_bus_release_domain_nr(NULL, domain_nr);
> +#endif
> +}
> +
>   /**
>    * pci_ext_cfg_avail - can we access extended PCI config space?
>    *
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index c090289b70be..1e65692efc0a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -632,6 +632,11 @@ static void pci_release_host_bridge_dev(struct device *dev)
>   
>   	pci_free_resource_list(&bridge->windows);
>   	pci_free_resource_list(&bridge->dma_ranges);
> +
> +	/* Host bridges only have domain_nr set in the emulation case */
> +	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
> +		pci_bus_release_emul_domain_nr(bridge->domain_nr);
> +
>   	kfree(bridge);
>   }
>   
> @@ -949,7 +954,7 @@ static bool pci_preserve_config(struct pci_host_bridge *host_bridge)
>   	return false;
>   }
>   
> -static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> +int pci_register_host_bridge(struct pci_host_bridge *bridge)
>   {
>   	struct device *parent = bridge->dev.parent;
>   	struct resource_entry *window, *next, *n;
> @@ -1112,7 +1117,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>   	device_del(&bridge->dev);
>   free:
>   #ifdef CONFIG_PCI_DOMAINS_GENERIC
> -	pci_bus_release_domain_nr(parent, bus->domain_nr);
> +	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
> +		pci_bus_release_domain_nr(parent, bus->domain_nr);
>   #endif
>   	if (bus_registered)
>   		put_device(&bus->dev);
> @@ -1121,6 +1127,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>   
>   	return err;
>   }
> +EXPORT_SYMBOL_GPL(pci_register_host_bridge);
>   
>   static bool pci_bridge_child_ext_cfg_accessible(struct pci_dev *bridge)
>   {
> @@ -3176,6 +3183,22 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
>   {
>   }
>   
> +void pci_setup_host_bridge(struct pci_host_bridge *bridge,
> +			   struct device *parent, int bus, struct pci_ops *ops,
> +			   void *sysdata, struct list_head *resources,
> +			   int domain_nr)
> +{
> +	WARN_ON(device_is_registered(&bridge->dev));
> +	bridge->dev.parent = parent;
> +
> +	list_splice_init(resources, &bridge->windows);
> +	bridge->sysdata = sysdata;
> +	bridge->busnr = bus;
> +	bridge->ops = ops;
> +	bridge->domain_nr = domain_nr;
> +}
> +EXPORT_SYMBOL_GPL(pci_setup_host_bridge);
> +
>   struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>   		struct pci_ops *ops, void *sysdata, struct list_head *resources)
>   {
> @@ -3186,12 +3209,8 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>   	if (!bridge)
>   		return NULL;
>   
> -	bridge->dev.parent = parent;
> -
> -	list_splice_init(resources, &bridge->windows);
> -	bridge->sysdata = sysdata;
> -	bridge->busnr = bus;
> -	bridge->ops = ops;
> +	pci_setup_host_bridge(bridge, parent, bus, ops, sysdata, resources,
> +			      PCI_DOMAIN_NR_NOT_SET);
>   
>   	error = pci_register_host_bridge(bridge);
>   	if (error < 0)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 72d07ad994fa..f3bed5462279 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1165,6 +1165,11 @@ struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
>   struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>   				    struct pci_ops *ops, void *sysdata,
>   				    struct list_head *resources);
> +void pci_setup_host_bridge(struct pci_host_bridge *bridge,
> +			   struct device *parent, int bus, struct pci_ops *ops,
> +			   void *sysdata, struct list_head *resources,
> +			   int domain_nr);
> +int pci_register_host_bridge(struct pci_host_bridge *bridge);
>   int pci_host_probe(struct pci_host_bridge *bridge);
>   int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
>   int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
> @@ -1919,6 +1924,8 @@ static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
>   int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
>   void pci_bus_release_domain_nr(struct device *parent, int domain_nr);
>   #endif
> +int pci_bus_find_emul_domain_nr(void);
> +void pci_bus_release_emul_domain_nr(int domain_nr);
>   
>   /* Some architectures require additional setup to direct VGA traffic */
>   typedef int (*arch_set_vga_state_t)(struct pci_dev *pdev, bool decode,
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 6d6aeb736c8f..523a7129aed3 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -317,7 +317,7 @@ config SAMPLE_DEVSEC
>   	tristate "Build a sample TEE Security Manager with an emulated PCI endpoint"
>   	depends on PCI
>   	depends on VIRT_DRIVERS
> -	depends on X86 # TODO: PCI_DOMAINS_GENERIC support
> +	depends on PCI_DOMAINS_GENERIC || X86
>   	select PCI_BRIDGE_EMUL
>   	select PCI_TSM
>   	select TSM
> diff --git a/samples/devsec/bus.c b/samples/devsec/bus.c
> index 69117db10897..0ca8acaf2204 100644
> --- a/samples/devsec/bus.c
> +++ b/samples/devsec/bus.c
> @@ -20,7 +20,7 @@
>   #define NR_DEVSEC_DEVS 1
>   
>   struct devsec {
> -	struct pci_sysdata sysdata;
> +	struct devsec_sysdata sysdata;
>   	struct gen_pool *iomem_pool;
>   	struct resource resource[2];
>   	struct pci_bus *bus;
> @@ -307,17 +307,6 @@ static struct pci_ops devsec_ops = {
>   	.write = devsec_pci_write,
>   };
>   
> -/* borrowed from vmd_find_free_domain() */
> -static int find_free_domain(void)
> -{
> -	int domain = 0xffff;
> -	struct pci_bus *bus = NULL;
> -
> -	while ((bus = pci_find_next_bus(bus)) != NULL)
> -		domain = max_t(int, domain, pci_domain_nr(bus));
> -	return domain + 1;
> -}
> -
>   static void destroy_bus(void *data)
>   {
>   	struct devsec *devsec = data;
> @@ -582,12 +571,60 @@ static int alloc_ports(struct devsec *devsec)
>   	return 0;
>   }
>   
> +static struct list_head *devsec_add_resources(struct devsec *devsec,
> +					      struct list_head *resources,
> +					      u64 mmio_start, u64 mmio_size)
> +{
> +	devsec->resource[0] = (struct resource) {
> +		.name = "DEVSEC BUSES",
> +		.start = 0,
> +		.end = NR_DEVSEC_BUSES + NR_DEVSEC_ROOT_PORTS - 1,
> +		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
> +	};
> +	pci_add_resource(resources, &devsec->resource[0]);
> +
> +	devsec->resource[1] = (struct resource) {
> +		.name = "DEVSEC MMIO",
> +		.start = mmio_start,
> +		.end = mmio_start + mmio_size - 1,
> +		.flags = IORESOURCE_MEM | IORESOURCE_MEM_64,
> +	};
> +	pci_add_resource(resources, &devsec->resource[1]);
> +
> +	return resources;
> +}
> +
> +static int devsec_autofree_bus(struct devsec *devsec, struct pci_bus *bus,
> +			       struct list_head *resources)
> +{
> +	devsec->bus = bus;
> +	return devm_add_action_or_reset(devsec->dev, destroy_bus, devsec);
> +}
> +
> +static int *devsec_alloc_domain_nr(int *domain_nr)
> +{
> +	*domain_nr = pci_bus_find_emul_domain_nr();
> +	if (*domain_nr < 0)
> +		return NULL;
> +	return domain_nr;
> +}
> +
> +static void devsec_free_domain_nr(int *domain_nr)
> +{
> +	if (domain_nr)
> +		pci_bus_release_emul_domain_nr(*domain_nr);
> +}
> +
> +DEFINE_FREE(free_resource_list, struct list_head *, if (_T) pci_free_resource_list(_T))
> +DEFINE_FREE(free_bridge, struct pci_host_bridge *, if (_T) put_device(&_T->dev));
> +DEFINE_FREE(free_domain_nr, int *, if (_T) devsec_free_domain_nr(_T))
> +
>   static int __init devsec_bus_probe(struct platform_device *pdev)
>   {
> -	int rc;
> -	LIST_HEAD(resources);
> +	int rc, __domain_nr;
> +	LIST_HEAD(__resources);
>   	struct devsec *devsec;
> -	struct pci_sysdata *sd;
> +	struct devsec_sysdata *sd;
>   	u64 mmio_size = SZ_64G;
>   	struct device *dev = &pdev->dev;
>   	u64 mmio_start = iomem_resource.end + 1 - SZ_64G;
> @@ -615,37 +652,34 @@ static int __init devsec_bus_probe(struct platform_device *pdev)
>   	if (rc)
>   		return rc;
>   
> -	devsec->resource[0] = (struct resource) {
> -		.name = "DEVSEC BUSES",
> -		.start = 0,
> -		.end = NR_DEVSEC_BUSES + NR_DEVSEC_ROOT_PORTS - 1,
> -		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
> -	};
> -	pci_add_resource(&resources, &devsec->resource[0]);
> +	struct list_head *resources __free(free_resource_list) =
> +		devsec_add_resources(devsec, &__resources, mmio_start,
> +				     mmio_size);
>   
> -	devsec->resource[1] = (struct resource) {
> -		.name = "DEVSEC MMIO",
> -		.start = mmio_start,
> -		.end = mmio_start + mmio_size - 1,
> -		.flags = IORESOURCE_MEM | IORESOURCE_MEM_64,
> -	};
> -	pci_add_resource(&resources, &devsec->resource[1]);
> +	struct pci_host_bridge *hb __free(free_bridge) = pci_alloc_host_bridge(0);
> +	if (!hb)
> +		return -ENOMEM;
>   
>   	sd = &devsec->sysdata;
>   	devsec_sysdata = sd;
> -	sd->domain = find_free_domain();
> -	if (sd->domain < 0)
> -		return sd->domain;
> -
> -
> -	devsec->bus = pci_create_root_bus(dev, 0, &devsec_ops,
> -					  &devsec->sysdata, &resources);
> -	if (!devsec->bus) {
> -		pci_free_resource_list(&resources);
> -		return -ENOMEM;
> -	}
> +	int *domain_nr __free(free_domain_nr) = devsec_alloc_domain_nr(&__domain_nr);
> +	if (!domain_nr)
> +		return __domain_nr;
> +
> +	/*
> +	 * Note, domain_nr is set in devsec_sysdata for
> +	 * !CONFIG_PCI_DOMAINS_GENERIC platforms
> +	 */
> +	devsec_set_domain_nr(sd, *no_free_ptr(domain_nr));
> +	pci_setup_host_bridge(hb, dev, 0, &devsec_ops, &devsec->sysdata,
> +			      resources, devsec_get_domain_nr(sd));
> +
> +	rc = pci_register_host_bridge(hb);
> +	if (rc)
> +		return rc;
>   
> -	rc = devm_add_action_or_reset(dev, destroy_bus, devsec);
> +	rc = devsec_autofree_bus(devsec, no_free_ptr(hb)->bus,
> +				 no_free_ptr(resources));
>   	if (rc)
>   		return rc;
>   
> diff --git a/samples/devsec/devsec.h b/samples/devsec/devsec.h
> index 794a9898ee2d..64e35731325b 100644
> --- a/samples/devsec/devsec.h
> +++ b/samples/devsec/devsec.h
> @@ -3,5 +3,38 @@
>   
>   #ifndef __DEVSEC_H__
>   #define __DEVSEC_H__
> -extern struct pci_sysdata *devsec_sysdata;
> +struct devsec_sysdata {
> +#ifdef CONFIG_X86
> +	/*
> +	 * Must be first member to that x86::pci_domain_nr() can type
> +	 * pun devsec_sysdata and pci_sysdata.
> +	 */
> +	struct pci_sysdata sd;
> +#else
> +	int domain_nr;
> +#endif
> +};
> +
> +#ifdef CONFIG_X86
> +static inline void devsec_set_domain_nr(struct devsec_sysdata *sd,
> +					int domain_nr)
> +{
> +	sd->sd.domain = domain_nr;
> +}
> +static inline int devsec_get_domain_nr(struct devsec_sysdata *sd)
> +{
> +	return sd->sd.domain;
> +}
> +#else
> +static inline void devsec_set_domain_nr(struct devsec_sysdata *sd,
> +					int domain_nr)
> +{
> +	sd->domain_nr = domain_nr;
> +}
> +static inline int devsec_get_domain_nr(struct devsec_sysdata *sd)
> +{
> +	return sd->domain_nr;
> +}
> +#endif
> +extern struct devsec_sysdata *devsec_sysdata;
>   #endif /* __DEVSEC_H__ */


