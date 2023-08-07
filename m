Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C3077330A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 00:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjHGWl6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 18:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjHGWl5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 18:41:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBB7F1;
        Mon,  7 Aug 2023 15:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F2BE622DC;
        Mon,  7 Aug 2023 22:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB88C433C7;
        Mon,  7 Aug 2023 22:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691448114;
        bh=/wqwxDzojgw9myRfOZV564yc0J8qMQhJKtSUll8LP68=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Vto2ACVmYOtKrWbtwRsyoqYdXTD8QSqVm8z+hf0KtmIVU72Eb6ewshTEg26/gd0XE
         BerjH6Lzq5bu8HPW+skCACpfVrrH+8Y1EOxOnwEASJViWHyR3cMoCSt/jvzPiWIgS5
         P/f1B5s74dhXm+ya5L++o6/8YvuPorxWeh5F2t3XtDbq1qA0LYCQR0H7UYnlqkUjAb
         bPzcj/9jkML6UTYuux0i2oeMgp+mDyFi404BTE4f3mCB7AjAlcoFFXgp0bLiEwIk3h
         JVoHoB5WTIhshJwf10e+0acMiMuZMxQ1OE8SoDRMtB9rHXJN32FaTjr8cOpx97LTpG
         R2dpJFe4Xf0fw==
Date:   Mon, 7 Aug 2023 17:41:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [RFC PATCH v1 05/21] arm64: PCI: Migrate ACPI related functions
 to pci-acpi.c
Message-ID: <20230807224152.GA274647@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803175916.3174453-6-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 03, 2023 at 11:29:00PM +0530, Sunil V L wrote:
> The functions defined in arm64 for ACPI support are required
> for RISC-V also. To avoid duplication, copy these functions
> to common location.

I assume this is a "move" (not a copy) and the code being moved isn't
being changed.

If so,

  Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/arm64/kernel/pci.c | 193 ----------------------------------------
>  drivers/pci/pci-acpi.c  | 182 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 182 insertions(+), 193 deletions(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 2276689b5411..fd9a7bed83ce 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -6,30 +6,7 @@
>   * Copyright (C) 2014 ARM Ltd.
>   */
>  
> -#include <linux/acpi.h>
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/kernel.h>
> -#include <linux/mm.h>
> -#include <linux/of_pci.h>
> -#include <linux/of_platform.h>
>  #include <linux/pci.h>
> -#include <linux/pci-acpi.h>
> -#include <linux/pci-ecam.h>
> -#include <linux/slab.h>
> -
> -#ifdef CONFIG_ACPI
> -/*
> - * Try to assign the IRQ number when probing a new device
> - */
> -int pcibios_alloc_irq(struct pci_dev *dev)
> -{
> -	if (!acpi_disabled)
> -		acpi_pci_irq_enable(dev);
> -
> -	return 0;
> -}
> -#endif
>  
>  /*
>   * raw_pci_read/write - Platform-specific PCI config space access.
> @@ -63,173 +40,3 @@ int pcibus_to_node(struct pci_bus *bus)
>  EXPORT_SYMBOL(pcibus_to_node);
>  
>  #endif
> -
> -#ifdef CONFIG_ACPI
> -
> -struct acpi_pci_generic_root_info {
> -	struct acpi_pci_root_info	common;
> -	struct pci_config_window	*cfg;	/* config space mapping */
> -};
> -
> -int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
> -{
> -	struct pci_config_window *cfg = bus->sysdata;
> -	struct acpi_device *adev = to_acpi_device(cfg->parent);
> -	struct acpi_pci_root *root = acpi_driver_data(adev);
> -
> -	return root->segment;
> -}
> -
> -int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> -{
> -	struct pci_config_window *cfg;
> -	struct acpi_device *adev;
> -	struct device *bus_dev;
> -
> -	if (acpi_disabled)
> -		return 0;
> -
> -	cfg = bridge->bus->sysdata;
> -
> -	/*
> -	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
> -	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
> -	 * NULL in this case because there is no proper ACPI device.
> -	 */
> -	if (!cfg->parent)
> -		adev = NULL;
> -	else
> -		adev = to_acpi_device(cfg->parent);
> -
> -	bus_dev = &bridge->bus->dev;
> -
> -	ACPI_COMPANION_SET(&bridge->dev, adev);
> -	set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
> -
> -	return 0;
> -}
> -
> -static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
> -{
> -	struct resource_entry *entry, *tmp;
> -	int status;
> -
> -	status = acpi_pci_probe_root_resources(ci);
> -	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
> -		if (!(entry->res->flags & IORESOURCE_WINDOW))
> -			resource_list_destroy_entry(entry);
> -	}
> -	return status;
> -}
> -
> -/*
> - * Lookup the bus range for the domain in MCFG, and set up config space
> - * mapping.
> - */
> -static struct pci_config_window *
> -pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
> -{
> -	struct device *dev = &root->device->dev;
> -	struct resource *bus_res = &root->secondary;
> -	u16 seg = root->segment;
> -	const struct pci_ecam_ops *ecam_ops;
> -	struct resource cfgres;
> -	struct acpi_device *adev;
> -	struct pci_config_window *cfg;
> -	int ret;
> -
> -	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
> -	if (ret) {
> -		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
> -		return NULL;
> -	}
> -
> -	adev = acpi_resource_consumer(&cfgres);
> -	if (adev)
> -		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
> -			 dev_name(&adev->dev));
> -	else
> -		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
> -			 &cfgres);
> -
> -	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
> -	if (IS_ERR(cfg)) {
> -		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
> -			PTR_ERR(cfg));
> -		return NULL;
> -	}
> -
> -	return cfg;
> -}
> -
> -/* release_info: free resources allocated by init_info */
> -static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
> -{
> -	struct acpi_pci_generic_root_info *ri;
> -
> -	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
> -	pci_ecam_free(ri->cfg);
> -	kfree(ci->ops);
> -	kfree(ri);
> -}
> -
> -/* Interface called from ACPI code to setup PCI host controller */
> -struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> -{
> -	struct acpi_pci_generic_root_info *ri;
> -	struct pci_bus *bus, *child;
> -	struct acpi_pci_root_ops *root_ops;
> -	struct pci_host_bridge *host;
> -
> -	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
> -	if (!ri)
> -		return NULL;
> -
> -	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
> -	if (!root_ops) {
> -		kfree(ri);
> -		return NULL;
> -	}
> -
> -	ri->cfg = pci_acpi_setup_ecam_mapping(root);
> -	if (!ri->cfg) {
> -		kfree(ri);
> -		kfree(root_ops);
> -		return NULL;
> -	}
> -
> -	root_ops->release_info = pci_acpi_generic_release_info;
> -	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
> -	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
> -	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
> -	if (!bus)
> -		return NULL;
> -
> -	/* If we must preserve the resource configuration, claim now */
> -	host = pci_find_host_bridge(bus);
> -	if (host->preserve_config)
> -		pci_bus_claim_resources(bus);
> -
> -	/*
> -	 * Assign whatever was left unassigned. If we didn't claim above,
> -	 * this will reassign everything.
> -	 */
> -	pci_assign_unassigned_root_bus_resources(bus);
> -
> -	list_for_each_entry(child, &bus->children, node)
> -		pcie_bus_configure_settings(child);
> -
> -	return bus;
> -}
> -
> -void pcibios_add_bus(struct pci_bus *bus)
> -{
> -	acpi_pci_add_bus(bus);
> -}
> -
> -void pcibios_remove_bus(struct pci_bus *bus)
> -{
> -	acpi_pci_remove_bus(bus);
> -}
> -
> -#endif
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a05350a4e49c..d6b2d64b8237 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -15,6 +15,7 @@
>  #include <linux/pci_hotplug.h>
>  #include <linux/module.h>
>  #include <linux/pci-acpi.h>
> +#include <linux/pci-ecam.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_qos.h>
>  #include <linux/rwsem.h>
> @@ -1517,4 +1518,185 @@ static int __init acpi_pci_init(void)
>  
>  	return 0;
>  }
> +
>  arch_initcall(acpi_pci_init);
> +
> +#if defined(CONFIG_ARM64)
> +/*
> + * Try to assign the IRQ number when probing a new device
> + */
> +int pcibios_alloc_irq(struct pci_dev *dev)
> +{
> +	if (!acpi_disabled)
> +		acpi_pci_irq_enable(dev);
> +
> +	return 0;
> +}
> +
> +struct acpi_pci_generic_root_info {
> +	struct acpi_pci_root_info	common;
> +	struct pci_config_window	*cfg;	/* config space mapping */
> +};
> +
> +int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +	struct acpi_device *adev = to_acpi_device(cfg->parent);
> +	struct acpi_pci_root *root = acpi_driver_data(adev);
> +
> +	return root->segment;
> +}
> +
> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	struct pci_config_window *cfg;
> +	struct acpi_device *adev;
> +	struct device *bus_dev;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	cfg = bridge->bus->sysdata;
> +
> +	/*
> +	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
> +	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
> +	 * NULL in this case because there is no proper ACPI device.
> +	 */
> +	if (!cfg->parent)
> +		adev = NULL;
> +	else
> +		adev = to_acpi_device(cfg->parent);
> +
> +	bus_dev = &bridge->bus->dev;
> +
> +	ACPI_COMPANION_SET(&bridge->dev, adev);
> +	set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
> +
> +	return 0;
> +}
> +
> +static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
> +{
> +	struct resource_entry *entry, *tmp;
> +	int status;
> +
> +	status = acpi_pci_probe_root_resources(ci);
> +	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
> +		if (!(entry->res->flags & IORESOURCE_WINDOW))
> +			resource_list_destroy_entry(entry);
> +	}
> +	return status;
> +}
> +
> +/*
> + * Lookup the bus range for the domain in MCFG, and set up config space
> + * mapping.
> + */
> +static struct pci_config_window *
> +pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
> +{
> +	struct device *dev = &root->device->dev;
> +	struct resource *bus_res = &root->secondary;
> +	u16 seg = root->segment;
> +	const struct pci_ecam_ops *ecam_ops;
> +	struct resource cfgres;
> +	struct acpi_device *adev;
> +	struct pci_config_window *cfg;
> +	int ret;
> +
> +	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
> +	if (ret) {
> +		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
> +		return NULL;
> +	}
> +
> +	adev = acpi_resource_consumer(&cfgres);
> +	if (adev)
> +		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
> +			 dev_name(&adev->dev));
> +	else
> +		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
> +			 &cfgres);
> +
> +	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
> +	if (IS_ERR(cfg)) {
> +		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
> +			PTR_ERR(cfg));
> +		return NULL;
> +	}
> +
> +	return cfg;
> +}
> +
> +/* release_info: free resources allocated by init_info */
> +static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
> +{
> +	struct acpi_pci_generic_root_info *ri;
> +
> +	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
> +	pci_ecam_free(ri->cfg);
> +	kfree(ci->ops);
> +	kfree(ri);
> +}
> +
> +/* Interface called from ACPI code to setup PCI host controller */
> +struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> +{
> +	struct acpi_pci_generic_root_info *ri;
> +	struct pci_bus *bus, *child;
> +	struct acpi_pci_root_ops *root_ops;
> +	struct pci_host_bridge *host;
> +
> +	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
> +	if (!ri)
> +		return NULL;
> +
> +	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
> +	if (!root_ops) {
> +		kfree(ri);
> +		return NULL;
> +	}
> +
> +	ri->cfg = pci_acpi_setup_ecam_mapping(root);
> +	if (!ri->cfg) {
> +		kfree(ri);
> +		kfree(root_ops);
> +		return NULL;
> +	}
> +
> +	root_ops->release_info = pci_acpi_generic_release_info;
> +	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
> +	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
> +	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
> +	if (!bus)
> +		return NULL;
> +
> +	/* If we must preserve the resource configuration, claim now */
> +	host = pci_find_host_bridge(bus);
> +	if (host->preserve_config)
> +		pci_bus_claim_resources(bus);
> +
> +	/*
> +	 * Assign whatever was left unassigned. If we didn't claim above,
> +	 * this will reassign everything.
> +	 */
> +	pci_assign_unassigned_root_bus_resources(bus);
> +
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);
> +
> +	return bus;
> +}
> +
> +void pcibios_add_bus(struct pci_bus *bus)
> +{
> +	acpi_pci_add_bus(bus);
> +}
> +
> +void pcibios_remove_bus(struct pci_bus *bus)
> +{
> +	acpi_pci_remove_bus(bus);
> +}
> +
> +#endif
> -- 
> 2.39.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
