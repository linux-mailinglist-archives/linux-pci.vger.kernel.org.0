Return-Path: <linux-pci+bounces-3257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B77E84EAC8
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 22:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B8C282B60
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 21:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9725148CC6;
	Thu,  8 Feb 2024 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exI0UqNd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D54F5ED
	for <linux-pci@vger.kernel.org>; Thu,  8 Feb 2024 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707428660; cv=none; b=cHrzXEBiqmmI7FbZtwFKYyOXAoGZEQPnSZlrNcDeaGsnybD9dxSzfPKA4mDzBBHAR9SvztoMvdW8kWI+2r12CW79BG5QSVXlwMsBT/iV8vndj6ThB0/s8T2iDxv2+zJMm9U5aYkEyTq+Z66n7ZH6Bo3eTbIK2VUohjcTleWFPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707428660; c=relaxed/simple;
	bh=BZ563hRHo6NYH7QBePys44tVG3lBUSYbX9DI+8Wx2XU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ExIS8qUoJbVbdBGJzDLtpQKImn+SqV2Xe1z4F3kObnlvLdIczFrQxv6gBnRdj6HPGdEwmsOF54Ld5t8qA3LYAR6/qDEinXDj/svW7KFBwSGmtvLOAePd10ELsm5tG4Z4tMoifPBbQAvzhlxEoT9XYO0WyL4OMlwsWnRA6EtyD+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exI0UqNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4F5C433F1;
	Thu,  8 Feb 2024 21:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707428660;
	bh=BZ563hRHo6NYH7QBePys44tVG3lBUSYbX9DI+8Wx2XU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=exI0UqNd7c2YJo07b5ffUB8LZCuxLIm1O0EdGPRvHmKcVdQcmYe+XgwKiR+8Sn86C
	 gWxHHJLPk58cLSlN4htkegNL7tBttAgrpPIyv2kGs1wUmWcOfjKyhgLYAfadJVQN6Y
	 zNaGRJHL16++9yMGBH5N9SR09cVCWpmF7rCar5GVNhXpM2N6H7shuJbJaq4wdvu89m
	 j3tyLwF2/dM0LkGONNsw6oGEtMU0UQLf3L9uK4IPZV7Gf3Nk0w/aqpkN6KEn4qN1Ij
	 pUUaadJyGs7fuYKhAbJ4fHo2nmdyoXy9LHT20RJJy/+0UNe7Ar25cX7qdlo46i4682
	 2eZ2rdLk9BneQ==
Date: Thu, 8 Feb 2024 15:44:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Alistair Francis <alistair23@gmail.com>
Subject: Re: [PATCH 1/2] PCI: Compile pci-sysfs.c only if CONFIG_SYSFS=y
Message-ID: <20240208214418.GA974042@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85ca95ae8e4d57ccf082c5c069b8b21eb141846e.1698668982.git.lukas@wunner.de>

On Mon, Oct 30, 2023 at 01:32:12PM +0100, Lukas Wunner wrote:
> It is possible to enable CONFIG_PCI but disable CONFIG_SYSFS and for
> space-constrained devices such as routers, such a configuration may
> actually make sense.
> 
> However pci-sysfs.c is compiled even if CONFIG_SYSFS is disabled,
> unnecessarily increasing the kernel's size.
> 
> To rectify that:
> 
> * Move pci_mmap_fits() to mmap.c.  It is not only needed by
>   pci-sysfs.c, but also proc.c.
> 
> * Move pci_dev_type to probe.c and make it private.  It references
>   pci_dev_attr_groups in pci-sysfs.c.  Make that public instead for
>   consistency with pci_dev_groups, pcibus_groups and pci_bus_groups,
>   which are likewise public and referenced by struct definitions in
>   pci-driver.c and probe.c.
> 
> * Define pci_dev_groups, pci_dev_attr_groups, pcibus_groups and
>   pci_bus_groups to NULL if CONFIG_SYSFS is disabled.  Provide empty
>   static inlines for pci_{create,remove}_legacy_files() and
>   pci_{create,remove}_sysfs_dev_files().
> 
> Result:
> 
> vmlinux size is reduced by 122996 bytes in my arm 32-bit test build.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Both applied to pci/sysfs with Alistair's Reviewed-by, thanks!

> ---
>  drivers/pci/Makefile    |  4 ++--
>  drivers/pci/mmap.c      | 29 +++++++++++++++++++++++++++++
>  drivers/pci/pci-sysfs.c | 29 +----------------------------
>  drivers/pci/pci.h       | 18 ++++++++++++++----
>  drivers/pci/probe.c     |  4 ++++
>  5 files changed, 50 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index cc8b4e01e29d..96f4759f2bd3 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -4,7 +4,7 @@
>  
>  obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
>  				   remove.o pci.o pci-driver.o search.o \
> -				   pci-sysfs.o rom.o setup-res.o irq.o vpd.o \
> +				   rom.o setup-res.o irq.o vpd.o \
>  				   setup-bus.o vc.o mmap.o setup-irq.o
>  
>  obj-$(CONFIG_PCI)		+= msi/
> @@ -12,7 +12,7 @@ obj-$(CONFIG_PCI)		+= pcie/
>  
>  ifdef CONFIG_PCI
>  obj-$(CONFIG_PROC_FS)		+= proc.o
> -obj-$(CONFIG_SYSFS)		+= slot.o
> +obj-$(CONFIG_SYSFS)		+= pci-sysfs.o slot.o
>  obj-$(CONFIG_ACPI)		+= pci-acpi.o
>  endif
>  
> diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
> index 4504039056d1..8da3347a95c4 100644
> --- a/drivers/pci/mmap.c
> +++ b/drivers/pci/mmap.c
> @@ -11,6 +11,8 @@
>  #include <linux/mm.h>
>  #include <linux/pci.h>
>  
> +#include "pci.h"
> +
>  #ifdef ARCH_GENERIC_PCI_MMAP_RESOURCE
>  
>  static const struct vm_operations_struct pci_phys_vm_ops = {
> @@ -50,3 +52,30 @@ int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
>  }
>  
>  #endif
> +
> +#if (defined(CONFIG_SYSFS) || defined(CONFIG_PROC_FS)) && \
> +    (defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE))
> +
> +int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vma,
> +		  enum pci_mmap_api mmap_api)
> +{
> +	resource_size_t pci_start = 0, pci_end;
> +	unsigned long nr, start, size;
> +
> +	if (pci_resource_len(pdev, resno) == 0)
> +		return 0;
> +	nr = vma_pages(vma);
> +	start = vma->vm_pgoff;
> +	size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
> +	if (mmap_api == PCI_MMAP_PROCFS) {
> +		pci_resource_to_user(pdev, resno, &pdev->resource[resno],
> +				     &pci_start, &pci_end);
> +		pci_start >>= PAGE_SHIFT;
> +	}
> +	if (start >= pci_start && start < pci_start + size &&
> +	    start + nr <= pci_start + size)
> +		return 1;
> +	return 0;
> +}
> +
> +#endif
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 2321fdfefd7d..44ed30df08c3 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1022,29 +1022,6 @@ void pci_remove_legacy_files(struct pci_bus *b)
>  #endif /* HAVE_PCI_LEGACY */
>  
>  #if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
> -
> -int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vma,
> -		  enum pci_mmap_api mmap_api)
> -{
> -	unsigned long nr, start, size;
> -	resource_size_t pci_start = 0, pci_end;
> -
> -	if (pci_resource_len(pdev, resno) == 0)
> -		return 0;
> -	nr = vma_pages(vma);
> -	start = vma->vm_pgoff;
> -	size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
> -	if (mmap_api == PCI_MMAP_PROCFS) {
> -		pci_resource_to_user(pdev, resno, &pdev->resource[resno],
> -				     &pci_start, &pci_end);
> -		pci_start >>= PAGE_SHIFT;
> -	}
> -	if (start >= pci_start && start < pci_start + size &&
> -			start + nr <= pci_start + size)
> -		return 1;
> -	return 0;
> -}
> -
>  /**
>   * pci_mmap_resource - map a PCI resource into user memory space
>   * @kobj: kobject for mapping
> @@ -1660,7 +1637,7 @@ static const struct attribute_group pcie_dev_attr_group = {
>  	.is_visible = pcie_dev_attrs_are_visible,
>  };
>  
> -static const struct attribute_group *pci_dev_attr_groups[] = {
> +const struct attribute_group *pci_dev_attr_groups[] = {
>  	&pci_dev_attr_group,
>  	&pci_dev_hp_attr_group,
>  #ifdef CONFIG_PCI_IOV
> @@ -1677,7 +1654,3 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
>  #endif
>  	NULL,
>  };
> -
> -const struct device_type pci_dev_type = {
> -	.groups = pci_dev_attr_groups,
> -};
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5ecbcf041179..aedaf4e51146 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -31,8 +31,6 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
>  
>  /* Functions internal to the PCI core code */
>  
> -int pci_create_sysfs_dev_files(struct pci_dev *pdev);
> -void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
>  void pci_cleanup_rom(struct pci_dev *dev);
>  #ifdef CONFIG_DMI
>  extern const struct attribute_group pci_dev_smbios_attr_group;
> @@ -152,7 +150,7 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
>  /* Functions for PCI Hotplug drivers to use */
>  int pci_hp_add_bridge(struct pci_dev *dev);
>  
> -#ifdef HAVE_PCI_LEGACY
> +#if defined(CONFIG_SYSFS) && defined(HAVE_PCI_LEGACY)
>  void pci_create_legacy_files(struct pci_bus *bus);
>  void pci_remove_legacy_files(struct pci_bus *bus);
>  #else
> @@ -185,10 +183,22 @@ static inline int pci_no_d1d2(struct pci_dev *dev)
>  	return (dev->no_d1d2 || parent_dstates);
>  
>  }
> +
> +#ifdef CONFIG_SYSFS
> +int pci_create_sysfs_dev_files(struct pci_dev *pdev);
> +void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
>  extern const struct attribute_group *pci_dev_groups[];
> +extern const struct attribute_group *pci_dev_attr_groups[];
>  extern const struct attribute_group *pcibus_groups[];
> -extern const struct device_type pci_dev_type;
>  extern const struct attribute_group *pci_bus_groups[];
> +#else
> +static inline int pci_create_sysfs_dev_files(struct pci_dev *pdev) { return 0; }
> +static inline void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
> +#define pci_dev_groups NULL
> +#define pci_dev_attr_groups NULL
> +#define pcibus_groups NULL
> +#define pci_bus_groups NULL
> +#endif
>  
>  extern unsigned long pci_hotplug_io_size;
>  extern unsigned long pci_hotplug_mmio_size;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ed6b7f48736a..500ac154fdfb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2307,6 +2307,10 @@ static void pci_release_dev(struct device *dev)
>  	kfree(pci_dev);
>  }
>  
> +static const struct device_type pci_dev_type = {
> +	.groups = pci_dev_attr_groups,
> +};
> +
>  struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>  {
>  	struct pci_dev *dev;
> -- 
> 2.40.1
> 

