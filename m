Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5A37742EF
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 19:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjHHRwe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 13:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjHHRwE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 13:52:04 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE6D2895F
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 09:23:15 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-76c64da0e46so230670439f.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Aug 2023 09:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691511789; x=1692116589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9XlmHUeaRUsL7m/s5aynviI2pipO5mYbmIClc7cRgQ0=;
        b=F4vf3O8yiysPWKjORfg4TuyomOc+XYKUuwDbEIYGL4RIjOU9puh0jCZqgY4mXPb8tu
         WQCRUtvoKrELK4py5GzmfxCtW3iJ+qN7nNrPuRKQbzMPmqmEBl4k1QGZ54Slx3Xq6YgL
         AkVeL4nU+r8Wyxd3PGGZ8SMWAru+qK0MhV1KaZV2Nm+8JI3j+hxj484/b6ccVFYx2Ll4
         szaAvsg/bKts+8Vdp6JDWYP/EvSvS1bHwrFIJX3qPUzeusxg8B9iDzHlhZilSzS8sv0o
         qUw+z2vRh+qJHC9vcJGll4XQTAob2PnSERUS+sZy3hLOBtT5B3YrhXhOckrMFBcMuAM3
         bUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511789; x=1692116589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XlmHUeaRUsL7m/s5aynviI2pipO5mYbmIClc7cRgQ0=;
        b=WyIog0w8uHike1tKx2z6gd7wEYEMDH2U3LoqjoWJnCwdsvNoYMoBcQAfht0q/zb1qi
         rxryIn/LfVX4bovbc3GqVsfl47xtW/e1NSVvgTyHHZGb0kvRpxIOpeCKmKC1IgV6XC1e
         vjyzTJwdtQH9ycFIR9XV8Xt3bzHkKb4MMdi5bkA5b5CVorCOz6jRRoID86OY/npuD2ZO
         DpqwXJh8CXXe/n1rr/rkxlEYkJu8tIEAfhNVDLuI9Zl637LrBoiEFA3culRrdvBRheT3
         i4Rb7v3+hm2KlrZdrl/FBDi2PVlfjl0WOCGv1r3rox8qr5NuzlItNozyQEe7KmNzUCe9
         +ASQ==
X-Gm-Message-State: AOJu0Yz3p57HgltcYjtGJJMkDQaHjbq5VZLC+rGTYeDzrnQCk+56yYqw
        aJDrav5k3968RD7GDZuwAkD6fEmZaympD+M5kxw=
X-Google-Smtp-Source: AGHT+IHwsRXoHKFn08OcPmdycooDY1/71tq7u8t1xFSVYxYNN+UDC9Vb8Pgycj4Y5erIS/ddW/bH7A==
X-Received: by 2002:a54:4e06:0:b0:3a1:dd1e:a726 with SMTP id a6-20020a544e06000000b003a1dd1ea726mr11019944oiy.44.1691470342166;
        Mon, 07 Aug 2023 21:52:22 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id e4-20020a6558c4000000b0056433b1b996sm5042200pgu.45.2023.08.07.21.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 21:52:21 -0700 (PDT)
Date:   Tue, 8 Aug 2023 10:22:10 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <ZNHJ+lO21c+0P4WN@sunil-laptop>
References: <20230803175916.3174453-6-sunilvl@ventanamicro.com>
 <20230807224152.GA274647@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807224152.GA274647@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 07, 2023 at 05:41:52PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 03, 2023 at 11:29:00PM +0530, Sunil V L wrote:
> > The functions defined in arm64 for ACPI support are required
> > for RISC-V also. To avoid duplication, copy these functions
> > to common location.
> 
> I assume this is a "move" (not a copy) and the code being moved isn't
> being changed.
> 
Hi Bjorn,

Thank you very much for the review!. Yes, it is a move as is. Let me
update the commit message in next version.

Thanks!
Sunil
> If so,
> 
>   Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  arch/arm64/kernel/pci.c | 193 ----------------------------------------
> >  drivers/pci/pci-acpi.c  | 182 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 182 insertions(+), 193 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > index 2276689b5411..fd9a7bed83ce 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -6,30 +6,7 @@
> >   * Copyright (C) 2014 ARM Ltd.
> >   */
> >  
> > -#include <linux/acpi.h>
> > -#include <linux/init.h>
> > -#include <linux/io.h>
> > -#include <linux/kernel.h>
> > -#include <linux/mm.h>
> > -#include <linux/of_pci.h>
> > -#include <linux/of_platform.h>
> >  #include <linux/pci.h>
> > -#include <linux/pci-acpi.h>
> > -#include <linux/pci-ecam.h>
> > -#include <linux/slab.h>
> > -
> > -#ifdef CONFIG_ACPI
> > -/*
> > - * Try to assign the IRQ number when probing a new device
> > - */
> > -int pcibios_alloc_irq(struct pci_dev *dev)
> > -{
> > -	if (!acpi_disabled)
> > -		acpi_pci_irq_enable(dev);
> > -
> > -	return 0;
> > -}
> > -#endif
> >  
> >  /*
> >   * raw_pci_read/write - Platform-specific PCI config space access.
> > @@ -63,173 +40,3 @@ int pcibus_to_node(struct pci_bus *bus)
> >  EXPORT_SYMBOL(pcibus_to_node);
> >  
> >  #endif
> > -
> > -#ifdef CONFIG_ACPI
> > -
> > -struct acpi_pci_generic_root_info {
> > -	struct acpi_pci_root_info	common;
> > -	struct pci_config_window	*cfg;	/* config space mapping */
> > -};
> > -
> > -int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
> > -{
> > -	struct pci_config_window *cfg = bus->sysdata;
> > -	struct acpi_device *adev = to_acpi_device(cfg->parent);
> > -	struct acpi_pci_root *root = acpi_driver_data(adev);
> > -
> > -	return root->segment;
> > -}
> > -
> > -int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> > -{
> > -	struct pci_config_window *cfg;
> > -	struct acpi_device *adev;
> > -	struct device *bus_dev;
> > -
> > -	if (acpi_disabled)
> > -		return 0;
> > -
> > -	cfg = bridge->bus->sysdata;
> > -
> > -	/*
> > -	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
> > -	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
> > -	 * NULL in this case because there is no proper ACPI device.
> > -	 */
> > -	if (!cfg->parent)
> > -		adev = NULL;
> > -	else
> > -		adev = to_acpi_device(cfg->parent);
> > -
> > -	bus_dev = &bridge->bus->dev;
> > -
> > -	ACPI_COMPANION_SET(&bridge->dev, adev);
> > -	set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
> > -
> > -	return 0;
> > -}
> > -
> > -static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
> > -{
> > -	struct resource_entry *entry, *tmp;
> > -	int status;
> > -
> > -	status = acpi_pci_probe_root_resources(ci);
> > -	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
> > -		if (!(entry->res->flags & IORESOURCE_WINDOW))
> > -			resource_list_destroy_entry(entry);
> > -	}
> > -	return status;
> > -}
> > -
> > -/*
> > - * Lookup the bus range for the domain in MCFG, and set up config space
> > - * mapping.
> > - */
> > -static struct pci_config_window *
> > -pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
> > -{
> > -	struct device *dev = &root->device->dev;
> > -	struct resource *bus_res = &root->secondary;
> > -	u16 seg = root->segment;
> > -	const struct pci_ecam_ops *ecam_ops;
> > -	struct resource cfgres;
> > -	struct acpi_device *adev;
> > -	struct pci_config_window *cfg;
> > -	int ret;
> > -
> > -	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
> > -	if (ret) {
> > -		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
> > -		return NULL;
> > -	}
> > -
> > -	adev = acpi_resource_consumer(&cfgres);
> > -	if (adev)
> > -		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
> > -			 dev_name(&adev->dev));
> > -	else
> > -		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
> > -			 &cfgres);
> > -
> > -	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
> > -	if (IS_ERR(cfg)) {
> > -		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
> > -			PTR_ERR(cfg));
> > -		return NULL;
> > -	}
> > -
> > -	return cfg;
> > -}
> > -
> > -/* release_info: free resources allocated by init_info */
> > -static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
> > -{
> > -	struct acpi_pci_generic_root_info *ri;
> > -
> > -	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
> > -	pci_ecam_free(ri->cfg);
> > -	kfree(ci->ops);
> > -	kfree(ri);
> > -}
> > -
> > -/* Interface called from ACPI code to setup PCI host controller */
> > -struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> > -{
> > -	struct acpi_pci_generic_root_info *ri;
> > -	struct pci_bus *bus, *child;
> > -	struct acpi_pci_root_ops *root_ops;
> > -	struct pci_host_bridge *host;
> > -
> > -	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
> > -	if (!ri)
> > -		return NULL;
> > -
> > -	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
> > -	if (!root_ops) {
> > -		kfree(ri);
> > -		return NULL;
> > -	}
> > -
> > -	ri->cfg = pci_acpi_setup_ecam_mapping(root);
> > -	if (!ri->cfg) {
> > -		kfree(ri);
> > -		kfree(root_ops);
> > -		return NULL;
> > -	}
> > -
> > -	root_ops->release_info = pci_acpi_generic_release_info;
> > -	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
> > -	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
> > -	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
> > -	if (!bus)
> > -		return NULL;
> > -
> > -	/* If we must preserve the resource configuration, claim now */
> > -	host = pci_find_host_bridge(bus);
> > -	if (host->preserve_config)
> > -		pci_bus_claim_resources(bus);
> > -
> > -	/*
> > -	 * Assign whatever was left unassigned. If we didn't claim above,
> > -	 * this will reassign everything.
> > -	 */
> > -	pci_assign_unassigned_root_bus_resources(bus);
> > -
> > -	list_for_each_entry(child, &bus->children, node)
> > -		pcie_bus_configure_settings(child);
> > -
> > -	return bus;
> > -}
> > -
> > -void pcibios_add_bus(struct pci_bus *bus)
> > -{
> > -	acpi_pci_add_bus(bus);
> > -}
> > -
> > -void pcibios_remove_bus(struct pci_bus *bus)
> > -{
> > -	acpi_pci_remove_bus(bus);
> > -}
> > -
> > -#endif
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index a05350a4e49c..d6b2d64b8237 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/pci_hotplug.h>
> >  #include <linux/module.h>
> >  #include <linux/pci-acpi.h>
> > +#include <linux/pci-ecam.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/pm_qos.h>
> >  #include <linux/rwsem.h>
> > @@ -1517,4 +1518,185 @@ static int __init acpi_pci_init(void)
> >  
> >  	return 0;
> >  }
> > +
> >  arch_initcall(acpi_pci_init);
> > +
> > +#if defined(CONFIG_ARM64)
> > +/*
> > + * Try to assign the IRQ number when probing a new device
> > + */
> > +int pcibios_alloc_irq(struct pci_dev *dev)
> > +{
> > +	if (!acpi_disabled)
> > +		acpi_pci_irq_enable(dev);
> > +
> > +	return 0;
> > +}
> > +
> > +struct acpi_pci_generic_root_info {
> > +	struct acpi_pci_root_info	common;
> > +	struct pci_config_window	*cfg;	/* config space mapping */
> > +};
> > +
> > +int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
> > +{
> > +	struct pci_config_window *cfg = bus->sysdata;
> > +	struct acpi_device *adev = to_acpi_device(cfg->parent);
> > +	struct acpi_pci_root *root = acpi_driver_data(adev);
> > +
> > +	return root->segment;
> > +}
> > +
> > +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> > +{
> > +	struct pci_config_window *cfg;
> > +	struct acpi_device *adev;
> > +	struct device *bus_dev;
> > +
> > +	if (acpi_disabled)
> > +		return 0;
> > +
> > +	cfg = bridge->bus->sysdata;
> > +
> > +	/*
> > +	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
> > +	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
> > +	 * NULL in this case because there is no proper ACPI device.
> > +	 */
> > +	if (!cfg->parent)
> > +		adev = NULL;
> > +	else
> > +		adev = to_acpi_device(cfg->parent);
> > +
> > +	bus_dev = &bridge->bus->dev;
> > +
> > +	ACPI_COMPANION_SET(&bridge->dev, adev);
> > +	set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
> > +
> > +	return 0;
> > +}
> > +
> > +static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
> > +{
> > +	struct resource_entry *entry, *tmp;
> > +	int status;
> > +
> > +	status = acpi_pci_probe_root_resources(ci);
> > +	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
> > +		if (!(entry->res->flags & IORESOURCE_WINDOW))
> > +			resource_list_destroy_entry(entry);
> > +	}
> > +	return status;
> > +}
> > +
> > +/*
> > + * Lookup the bus range for the domain in MCFG, and set up config space
> > + * mapping.
> > + */
> > +static struct pci_config_window *
> > +pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
> > +{
> > +	struct device *dev = &root->device->dev;
> > +	struct resource *bus_res = &root->secondary;
> > +	u16 seg = root->segment;
> > +	const struct pci_ecam_ops *ecam_ops;
> > +	struct resource cfgres;
> > +	struct acpi_device *adev;
> > +	struct pci_config_window *cfg;
> > +	int ret;
> > +
> > +	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
> > +	if (ret) {
> > +		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
> > +		return NULL;
> > +	}
> > +
> > +	adev = acpi_resource_consumer(&cfgres);
> > +	if (adev)
> > +		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
> > +			 dev_name(&adev->dev));
> > +	else
> > +		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
> > +			 &cfgres);
> > +
> > +	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
> > +	if (IS_ERR(cfg)) {
> > +		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
> > +			PTR_ERR(cfg));
> > +		return NULL;
> > +	}
> > +
> > +	return cfg;
> > +}
> > +
> > +/* release_info: free resources allocated by init_info */
> > +static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
> > +{
> > +	struct acpi_pci_generic_root_info *ri;
> > +
> > +	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
> > +	pci_ecam_free(ri->cfg);
> > +	kfree(ci->ops);
> > +	kfree(ri);
> > +}
> > +
> > +/* Interface called from ACPI code to setup PCI host controller */
> > +struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> > +{
> > +	struct acpi_pci_generic_root_info *ri;
> > +	struct pci_bus *bus, *child;
> > +	struct acpi_pci_root_ops *root_ops;
> > +	struct pci_host_bridge *host;
> > +
> > +	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
> > +	if (!ri)
> > +		return NULL;
> > +
> > +	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
> > +	if (!root_ops) {
> > +		kfree(ri);
> > +		return NULL;
> > +	}
> > +
> > +	ri->cfg = pci_acpi_setup_ecam_mapping(root);
> > +	if (!ri->cfg) {
> > +		kfree(ri);
> > +		kfree(root_ops);
> > +		return NULL;
> > +	}
> > +
> > +	root_ops->release_info = pci_acpi_generic_release_info;
> > +	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
> > +	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
> > +	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
> > +	if (!bus)
> > +		return NULL;
> > +
> > +	/* If we must preserve the resource configuration, claim now */
> > +	host = pci_find_host_bridge(bus);
> > +	if (host->preserve_config)
> > +		pci_bus_claim_resources(bus);
> > +
> > +	/*
> > +	 * Assign whatever was left unassigned. If we didn't claim above,
> > +	 * this will reassign everything.
> > +	 */
> > +	pci_assign_unassigned_root_bus_resources(bus);
> > +
> > +	list_for_each_entry(child, &bus->children, node)
> > +		pcie_bus_configure_settings(child);
> > +
> > +	return bus;
> > +}
> > +
> > +void pcibios_add_bus(struct pci_bus *bus)
> > +{
> > +	acpi_pci_add_bus(bus);
> > +}
> > +
> > +void pcibios_remove_bus(struct pci_bus *bus)
> > +{
> > +	acpi_pci_remove_bus(bus);
> > +}
> > +
> > +#endif
> > -- 
> > 2.39.2
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
