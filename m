Return-Path: <linux-pci+bounces-6081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4518A017A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 22:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE50B254F3
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 20:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E11181CEB;
	Wed, 10 Apr 2024 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRQ0etzz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2122A1BB;
	Wed, 10 Apr 2024 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782247; cv=none; b=Fll+qfggvh2FKktSYfkWziM1iiygy4x6KxM9Ya9FQClVhVB0bK+Nw27GUvg06SlWnBWAcsSPR7yXLCB8tqAw7RqpsPjvd7QEcpcznlDFr9GxmUWz0sJsUxMgjGV1VL041sGKjIqNniGOMk/4/IPdwQNZA3WQVYWu0iorittqSqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782247; c=relaxed/simple;
	bh=eB8F1emKclv/cegBkvbScX9krBY6swdhdG182ONFVgU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ou04+ghEUcuB9f3Ugb58N/5IvQ1SPv7G+f/+5AJUOCswZQh+uHhgTfQBzHm+AMqnKFI31nt5WUUnOAPxMO9FR0Z1kwviawbixAN5Ttfo960uKcFxyk12UNNP9mp0J0Zs2nUvCRllYpAabjB1zxwqbdkQwh79NV0JeMMtH4gmkV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRQ0etzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5057C433C7;
	Wed, 10 Apr 2024 20:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712782247;
	bh=eB8F1emKclv/cegBkvbScX9krBY6swdhdG182ONFVgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kRQ0etzzwku1/DM/ph9MfK7RvzgvdXyCOgoLXHMxkkL23wWVCrmwu7NdMfw6v8DBC
	 rQ07jocdBdLKVWsVSK9ECjpj4+TdlKZidolsnuO4Af1corjFZnsdZvZk5p+FZsLaUC
	 SHvITxTQpQFN3a8z+DEsB6FWVDQtJQ81RHNofGEZ/Rd3xaDGr4kpQ6YvVtQz1iArMq
	 CSRgzP33duE0euMbzi8xlStkQ10NAqEAVwL+LIG3FTHt1w0XBBbEuZutRD8T46T/sL
	 iqGbw8R5LYq3LODnr9itw+1yHzCs9EjUUxf+Z1anG1Htz6MjCvX0vCglld22TXRpfM
	 ECFIV3H1+5NjA==
Date: Wed, 10 Apr 2024 15:50:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
	will@kernel.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, frowand.list@gmail.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5] PCI: Add support for preserving boot configuration
Message-ID: <20240410205044.GA2152821@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401075031.3337211-1-vidyas@nvidia.com>

On Mon, Apr 01, 2024 at 01:20:31PM +0530, Vidya Sagar wrote:
> Add support for preserving the boot configuration done by the
> platform firmware per host bridge basis, based on the presence of
> 'linux,pci-probe-only' property in the respective PCI host bridge
> device-tree node. It also unifies the ACPI and DT based boot flows
> in this regard.

>  drivers/acpi/pci_root.c                  | 12 -----
>  drivers/pci/controller/pci-host-common.c |  4 --
>  drivers/pci/of.c                         | 57 +++++++++++++++++++-----
>  drivers/pci/probe.c                      | 46 ++++++++++++++-----
>  include/linux/of_pci.h                   |  6 +++
>  5 files changed, 88 insertions(+), 37 deletions(-)

What does this apply to?  I tried v6.9-rc1:

  $ git checkout -b wip/2404-vidya-preserve-boot-v5 v6.9-rc1
  Switched to a new branch 'wip/2404-vidya-preserve-boot-v5'

  $ git am m/v5_20240401_vidyas_pci_add_support_for_preserving_boot_configuration.mbx
  Applying: PCI: Add support for preserving boot configuration
  error: patch failed: drivers/acpi/pci_root.c:1050
  error: drivers/acpi/pci_root.c: patch does not apply
  Patch failed at 0001 PCI: Add support for preserving boot configuration

> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 84030804a763..ddc2b3e89111 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -1008,7 +1008,6 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	int node = acpi_get_node(device->handle);
>  	struct pci_bus *bus;
>  	struct pci_host_bridge *host_bridge;
> -	union acpi_object *obj;
>  
>  	info->root = root;
>  	info->bridge = device;
> @@ -1050,17 +1049,6 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	if (!(root->osc_ext_control_set & OSC_CXL_ERROR_REPORTING_CONTROL))
>  		host_bridge->native_cxl_error = 0;
>  
> -	/*
> -	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> -	 * exists and returns 0, we must preserve any PCI resource
> -	 * assignments made by firmware for this host bridge.
> -	 */
> -	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
> -				DSM_PCI_PRESERVE_BOOT_CONFIG, NULL);
> -	if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0)
> -		host_bridge->preserve_config = 1;
> -	ACPI_FREE(obj);
> -
>  	acpi_dev_power_up_children_with_adr(device);
>  
>  	pci_scan_child_bus(bus);
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index 6be3266cd7b5..e2602e38ae45 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -73,10 +73,6 @@ int pci_host_common_probe(struct platform_device *pdev)
>  	if (IS_ERR(cfg))
>  		return PTR_ERR(cfg);
>  
> -	/* Do not reassign resources if probe only */
> -	if (!pci_has_flag(PCI_PROBE_ONLY))
> -		pci_add_flags(PCI_REASSIGN_ALL_BUS);
> -
>  	bridge->sysdata = cfg;
>  	bridge->ops = (struct pci_ops *)&ops->pci_ops;
>  	bridge->msi_domain = true;
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 51e3dd0ea5ab..e6da3654f9ac 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -239,24 +239,61 @@ EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
>   */
>  void of_pci_check_probe_only(void)
>  {
> -	u32 val;
> +	bool is_preserve_config = of_pci_bridge_preserve_resources(of_chosen);

No need for a bool here:

  if (of_pci_bridge_preserve_resources(of_chosen))
    pci_add_flags(PCI_PROBE_ONLY);

I think it would make more sense to add
of_pci_bridge_preserve_resources() *above* of_pci_check_probe_only()
since the usual order is to define functions earlier in the file than
the calls.

> +
> +	if (is_preserve_config)
> +		pci_add_flags(PCI_PROBE_ONLY);
> +	else
> +		pci_clear_flags(PCI_PROBE_ONLY);

Not related to *this* patch, but I see that of_pci_check_probe_only()
already clears PCI_PROBE_ONLY (added by f81c11af617c ("of/pci: Add
of_pci_check_probe_only to parse "linux,pci-probe-only"").

I'm concerned about clearing PCI_PROBE_ONLY because some platforms set
this unconditionally, and I don't think they necessarily have
"linux,pci-probe-only" in DT.

Apparently none of them currently calls of_pci_check_probe_only() so
PCI_PROBE_ONLY remains set, but clearing it here feels like a landmine
waiting for somebody to move this into a unified call path.

I guess if we were to drop pci_clear_flags(), that should be a
separate patch in case it breaks something.

> +	pr_info("PROBE_ONLY %s\n", is_preserve_config ? "enabled" : "disabled");
> +}
> +EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
> +
> +/**
> + * of_pci_bridge_preserve_resources - Return true if the boot configuration
> + *                                    needs to be preserved
> + * @node: Device tree node.
> + *
> + * This function looks for "linux,pci-probe-only" property for a given
> + * PCI controller's node and returns true if found. It will also look in the
> + * chosen node if the property is not found in the given controller's node.
> + * Having this property ensures that the kernel doesn't reconfigure the
> + * BARs and bridge windows that are already done by the platform firmware.
> + *
> + * Return: true if the property exists false otherwise.
> + */
> +bool of_pci_bridge_preserve_resources(struct device_node *node)
> +{
> +	u32 val = 0;
>  	int ret;
>  
> -	ret = of_property_read_u32(of_chosen, "linux,pci-probe-only", &val);
> +	if (!node) {
> +		pr_warn("device node is NULL, trying with of_chosen\n");
> +		node = of_chosen;
> +	}
> +
> +retry:
> +	ret = of_property_read_u32(node, "linux,pci-probe-only", &val);
>  	if (ret) {
> -		if (ret == -ENODATA || ret == -EOVERFLOW)
> -			pr_warn("linux,pci-probe-only without valid value, ignoring\n");
> -		return;
> +		if (ret == -ENODATA || ret == -EOVERFLOW) {
> +			pr_warn("Incorrect value for linux,pci-probe-only in %pOF, ignoring\n", node);
> +			return false;
> +		}
> +		if (ret == -EINVAL) {
> +			if (node == of_chosen)
> +				return false;
> +
> +			node = of_chosen;
> +			goto retry;
> +		}
>  	}
>  
>  	if (val)
> -		pci_add_flags(PCI_PROBE_ONLY);
> +		return true;
>  	else
> -		pci_clear_flags(PCI_PROBE_ONLY);
> -
> -	pr_info("PROBE_ONLY %s\n", val ? "enabled" : "disabled");
> +		return false;
>  }
> -EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>  
>  /**
>   * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 795534589b98..b0e0226a8da8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -15,6 +15,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/aer.h>
>  #include <linux/acpi.h>
> +#include <linux/pci-acpi.h>
>  #include <linux/hypervisor.h>
>  #include <linux/irqdomain.h>
>  #include <linux/pm_runtime.h>
> @@ -877,6 +878,28 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
>  	dev_set_msi_domain(&bus->dev, d);
>  }
>  
> +static void pci_check_config_preserve(struct pci_host_bridge *host_bridge)
> +{
> +	if (ACPI_HANDLE(&host_bridge->dev)) {
> +		union acpi_object *obj;
> +
> +		/*
> +		 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> +		 * exists and returns 0, we must preserve any PCI resource
> +		 * assignments made by firmware for this host bridge.
> +		 */
> +		obj = acpi_evaluate_dsm(ACPI_HANDLE(&host_bridge->dev), &pci_acpi_dsm_guid, 1,
> +					DSM_PCI_PRESERVE_BOOT_CONFIG, NULL);
> +		if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0)
> +			host_bridge->preserve_config = 1;
> +		ACPI_FREE(obj);
> +	}
> +
> +	if (host_bridge->dev.parent && host_bridge->dev.parent->of_node)
> +		host_bridge->preserve_config =
> +			of_pci_bridge_preserve_resources(host_bridge->dev.parent->of_node);
> +}
> +
>  static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  {
>  	struct device *parent = bridge->dev.parent;
> @@ -971,6 +994,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
>  		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
>  
> +	/* Check if the boot configuration by FW needs to be preserved */
> +	pci_check_config_preserve(bridge);

I really have an allergic reaction to functions named "..._check_..."
We can tell that the function has something to do with preserving
configuration, and it's void so obviously the side effects are the
important thing, but there's no clue in the caller about what the side
effects are.

I'd prefer something like:

  bridge->preserve_config = pci_must_preserve_config(bridge);

where pci_must_preserve_config() has no side effects, returns bool,
and the action is at the caller.

>  	/* Coalesce contiguous windows */
>  	resource_list_for_each_entry_safe(window, n, &resources) {
>  		if (list_is_last(&window->node, &resources))
> @@ -3080,20 +3106,18 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>  
>  	bus = bridge->bus;
>  
> +	/* If we must preserve the resource configuration, claim now */
> +	if (bridge->preserve_config)
> +		pci_bus_claim_resources(bus);
> +
>  	/*
> -	 * We insert PCI resources into the iomem_resource and
> -	 * ioport_resource trees in either pci_bus_claim_resources()
> -	 * or pci_bus_assign_resources().
> +	 * Assign whatever was left unassigned. If we didn't claim above,
> +	 * this will reassign everything.
>  	 */
> -	if (pci_has_flag(PCI_PROBE_ONLY)) {
> -		pci_bus_claim_resources(bus);
> -	} else {
> -		pci_bus_size_bridges(bus);
> -		pci_bus_assign_resources(bus);
> +	pci_assign_unassigned_root_bus_resources(bus);
>  
> -		list_for_each_entry(child, &bus->children, node)
> -			pcie_bus_configure_settings(child);
> -	}
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);
>  
>  	pci_bus_add_devices(bus);
>  	return 0;
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 29658c0ee71f..3f3909a5d55d 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -13,6 +13,7 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
>  					     unsigned int devfn);
>  int of_pci_get_devfn(struct device_node *np);
>  void of_pci_check_probe_only(void);
> +bool of_pci_bridge_preserve_resources(struct device_node *node);

This looks like it should be in drivers/pci/pci.h since it's not used
outside drivers/pci/.

>  #else
>  static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
>  					     unsigned int devfn)
> @@ -26,6 +27,11 @@ static inline int of_pci_get_devfn(struct device_node *np)
>  }
>  
>  static inline void of_pci_check_probe_only(void) { }
> +
> +static inline bool of_pci_bridge_preserve_resources(struct device_node *node)
> +{
> +	return false;
> +}
>  #endif
>  
>  #if IS_ENABLED(CONFIG_OF_IRQ)
> -- 
> 2.25.1
> 

