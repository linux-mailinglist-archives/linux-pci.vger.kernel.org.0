Return-Path: <linux-pci+bounces-4521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1488D872124
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 15:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A972AB23B3F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 14:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8188614C;
	Tue,  5 Mar 2024 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlcGZRPG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210935102B;
	Tue,  5 Mar 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647823; cv=none; b=Qa2MzxvRBeMQQtrGpWGG+0CA1S1+FktrHHtfWkBrz/LLq4Z8kPJGg+AdihYgRy1/tBYex5txDUSBKD8rxybvz6zy5Qitlu0H81FZfo82hmQ7ncDsrxS5ILU+b0h1nsI5IdwGwHueeCPZwJuVh5W4Ql4ANCOGJjUUPA0ktWji4z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647823; c=relaxed/simple;
	bh=yligJ8IXn0rMPUgLLCLFsqkXEZzbgJx9pASoGxdfXR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFXLlkfbN8mOlmwhn+yaxysdzKbxIufVFDjZ/nslE4Wsdr/b3i39EjFBcMhMT/NuJiC6y79CSQIvLd1wjEL/9hcr/S4iBZW1zYYevDwCB8k7spmZkL1Nle4N/VFi8t1AYEqEL6gwXmWdTUd/dErd5jjFQc6Z3pJahAgGNKlk3Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlcGZRPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E72C433C7;
	Tue,  5 Mar 2024 14:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709647822;
	bh=yligJ8IXn0rMPUgLLCLFsqkXEZzbgJx9pASoGxdfXR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlcGZRPGR3iQ3Rz6cSl+sC1Cd46r5Ye33DMAn5FrLL36CXD9BZQNfPcP+eD5kHU8P
	 erNmTTXjdJzUzz6MpO4rPA74t7oPJs/J1h3bl8qVKDCyB/V3PA/wAqnsBHoUGg8mlK
	 K/c8410PacOzLJ7pz2EhJ4+/OG0LzlthgNRgJds7EbXVB41PWzf0lKPtNbVRVIu0ps
	 1+8c8Nb1LLq4IVbq2OnGm6GOAE2JQSoZVVxA4ath12jYeOaeiDSH/3Ksisngcs6gVG
	 mMwYTdkTa0hLLZ7wMrGWN6Hh/FZvIbmSGo5qbKIt4LktOPc8uvkNwpxmtQd1K9araP
	 yTgfP0En4Nimw==
Date: Tue, 5 Mar 2024 08:10:20 -0600
From: Rob Herring <robh@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
	will@kernel.org, lpieralisi@kernel.org, kw@linux.com,
	frowand.list@gmail.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI: Add support for preserving boot configuration
Message-ID: <20240305141020.GA3259724-robh@kernel.org>
References: <20240222124110.2681455-1-vidyas@nvidia.com>
 <20240223080021.1692996-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223080021.1692996-1-vidyas@nvidia.com>

On Fri, Feb 23, 2024 at 01:30:21PM +0530, Vidya Sagar wrote:
> Add support for preserving the boot configuration done by the
> platform firmware per host bridge basis, based on the presence of
> 'linux,pci-probe-only' property in the respective PCI host bridge
> device-tree node. It also unifies the ACPI and DT based boot flows
> in this regard.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * Addressed Bjorn's review comments
> 
> V3:
> * Unified ACPI and DT flows as part of addressing Bjorn's review comments
> 
> V2:
> * Addressed issues reported by kernel test robot <lkp@intel.com>
> 
>  drivers/acpi/pci_root.c                  | 12 -------
>  drivers/pci/controller/pci-host-common.c |  4 ---
>  drivers/pci/of.c                         | 21 +++++++++++
>  drivers/pci/probe.c                      | 46 ++++++++++++++++++------
>  include/linux/of_pci.h                   |  6 ++++
>  5 files changed, 62 insertions(+), 27 deletions(-)
> 
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
> index 51e3dd0ea5ab..f0f1156040a5 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -258,6 +258,27 @@ void of_pci_check_probe_only(void)
>  }
>  EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>  
> +/**
> + * of_pci_bridge_preserve_resources - Return true if the boot configuration
> + *                                    needs to be preserved
> + * @node: Device tree node with the domain information.
> + *
> + * This function looks for "linux,pci-probe-only" property for a given
> + * PCI controller's node and returns true if found. Having this property
> + * for a PCI controller ensures that the kernel doesn't reconfigure the
> + * BARs and bridge windows that are already done by the platform firmware.
> + * NOTE: The scope of "linux,pci-probe-only" defined within a PCI bridge device
> + *       is limited to the hierarchy under that particular bridge device. whereas
> + *       the scope of "linux,pci-probe-only" defined within chosen node is
> + *       system wide.
> + *
> + * Return: true if the property exists false otherwise.
> + */
> +bool of_pci_bridge_preserve_resources(struct device_node *node)
> +{
> +	return of_property_read_bool(node, "linux,pci-probe-only");

This is the wrong type. The existing "linux,pci-probe-only" is a u32 and 
non-zero value means probe-only. This would return true for 
'linux,pci-probe-only = <0>'.

Also, this should also check chosen. If you make this work accepting 
NULL for node, then of_pci_check_probe_only() can be re-implemented to 
use it.



Rob

