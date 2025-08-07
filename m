Return-Path: <linux-pci+bounces-33592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9751EB1DF71
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 00:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E6318C6B06
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 22:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB36220696;
	Thu,  7 Aug 2025 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSMoqgQ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B2219A79;
	Thu,  7 Aug 2025 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754606898; cv=none; b=Ick3i5y3H3yylBp/BEQ4zIf9xXXfTijTIj+rxtMn1zmTCBG9KeFDpJy1mqZm2EYKBjoKZHUg7QVm1Nmp9/0y3qqoPmI8gFPP1Jg5wdPOscr+KBk1Nx7Ts8anH/LVnjbVhfePDf41kFT8ix42PLbZv9WtO3wMGUGvNodN3+uD7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754606898; c=relaxed/simple;
	bh=AmZfiOehCECtCxRnS0ppJfGeaHkBIRsk3xkVhQcrVwY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qc0oVZRY9ddb0Sn2+z8vpn+ruS24jnOm4s44LiIcP/YWBpscvOH96ubGXsNurPb5dGgE3Rni9SHOhLozZ2IuudFVtT8ShEyHz0hCWdmnt5XLqzHkqLaTHxnizU1l7HpQlruySZSR5+oocN8BCkU0VY73s5yIhvQK8MYrXNgGMUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSMoqgQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94993C4CEEB;
	Thu,  7 Aug 2025 22:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754606897;
	bh=AmZfiOehCECtCxRnS0ppJfGeaHkBIRsk3xkVhQcrVwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KSMoqgQ3n0l/SmB+x8LWYsqKdxry8iuhmRWKU5hFJZZr+tfcs2QB2bAbbx0WiSaHM
	 +SbzoO1S+52YT12bs757W/kunWfHgAk9cm6xX+y0DCj1kGJFffpksCVwpaw7Ds+lA3
	 po5Yr7V4Ccdy6Kx/VPGWpLVBDiaXVnzKV2J7AtkqYGoXRBxdtoHFPdiAB7kVGXNcAT
	 WWuVaIQfYcMjVMprHCakf3BX/O6DMyhQ4T/pUD1XsCsLffK6eUIOQbIz06dDxTDVAd
	 +WC/BJqBzF9A1U31nGlrUt3V+//VyU4TdrhChRBh++3KLbLbtIj+Mu/N6xg0VNmI36
	 2JOnvZFokEyYQ==
Date: Thu, 7 Aug 2025 17:48:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yi lun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v4 08/10] PCI/IDE: Report available IDE streams
Message-ID: <20250807224816.GA66766@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717183358.1332417-9-dan.j.williams@intel.com>

On Thu, Jul 17, 2025 at 11:33:56AM -0700, Dan Williams wrote:
> The limited number of link-encryption (IDE) streams that a given set of
> host bridges supports is a platform specific detail. Provide
> pci_ide_init_nr_streams() as a generic facility for either platform TSM
> drivers, or PCI core native IDE, to report the number available streams.
> After invoking pci_ide_init_nr_streams() an "available_secure_streams"
> attribute appears in PCI host bridge sysfs to convey that count.
> 
> Introduce a device-type, @pci_host_bridge_type, now that both a release
> method and sysfs attribute groups are being specified for all 'struct
> pci_host_bridge' instances.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yi lun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  .../ABI/testing/sysfs-devices-pci-host-bridge | 13 ++++
>  drivers/pci/ide.c                             | 59 +++++++++++++++++++
>  drivers/pci/pci.h                             |  3 +
>  drivers/pci/probe.c                           | 12 +++-
>  include/linux/pci.h                           |  8 +++
>  5 files changed, 94 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> index c67d7c30efa0..067d0879e353 100644
> --- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> @@ -33,3 +33,16 @@ Description:
>  		resources shared by the Root Ports in a host bridge. See
>  		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
>  		format.
> +
> +What:		pciDDDD:BB/available_secure_streams
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a host bridge has Root Ports that support PCIe IDE
> +		(link encryption and integrity protection) there may be a
> +		limited number of Selective IDE Streams that can be used for
> +		establishing new end-to-end secure links. This attribute
> +		decrements upon secure link setup, and increments upon secure
> +		link teardown. The in-use stream count is determined by counting
> +		stream symlinks.  See /sys/devices/pciDDDD:BB entry for details
> +		about the DDDD:BB format.
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index cdc773a8b381..cafbc740a9da 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -513,3 +513,62 @@ void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
>  	settings->enable = 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
> +
> +static ssize_t available_secure_streams_show(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
> +	int avail;
> +
> +	if (!hb->nr_ide_streams)
> +		return -ENXIO;
> +
> +	avail = hb->nr_ide_streams -
> +		bitmap_weight(hb->ide_stream_map, hb->nr_ide_streams);
> +	return sysfs_emit(buf, "%d\n", avail);
> +}
> +static DEVICE_ATTR_RO(available_secure_streams);
> +
> +static struct attribute *pci_ide_attrs[] = {
> +	&dev_attr_available_secure_streams.attr,
> +	NULL
> +};
> +
> +static umode_t pci_ide_attr_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
> +
> +	if (a == &dev_attr_available_secure_streams.attr)
> +		if (!hb->nr_ide_streams)
> +			return 0;
> +
> +	return a->mode;
> +}
> +
> +struct attribute_group pci_ide_attr_group = {
> +	.attrs = pci_ide_attrs,
> +	.is_visible = pci_ide_attr_visible,
> +};
> +
> +/**
> + * pci_ide_init_nr_streams() - sets size of the pool of IDE Stream resources
> + * @hb: host bridge boundary for the stream pool
> + * @nr: number of streams
> + *
> + * Platform PCI init and/or expert test module use only. Enable IDE
> + * Stream establishment by setting the number of stream resources
> + * available at the host bridge. Platform init code must set this before
> + * the first pci_ide_stream_alloc() call.
> + *
> + * The "PCI_IDE" symbol namespace is required because this is typically
> + * a detail that is settled in early PCI init. I.e. this export is not
> + * for endpoint drivers.
> + */
> +void pci_ide_init_nr_streams(struct pci_host_bridge *hb, u8 nr)
> +{
> +	hb->nr_ide_streams = nr;
> +	sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);
> +}
> +EXPORT_SYMBOL_NS_GPL(pci_ide_init_nr_streams, "PCI_IDE");
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3b282c24dde8..8154f829d303 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -517,8 +517,11 @@ static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
>  
>  #ifdef CONFIG_PCI_IDE
>  void pci_ide_init(struct pci_dev *dev);
> +extern struct attribute_group pci_ide_attr_group;
> +#define PCI_IDE_ATTR_GROUP (&pci_ide_attr_group)
>  #else
>  static inline void pci_ide_init(struct pci_dev *dev) { }
> +#define PCI_IDE_ATTR_GROUP NULL
>  #endif
>  
>  #ifdef CONFIG_PCI_TSM
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9ed25035a06d..a84aaad462ca 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -640,6 +640,16 @@ static void pci_release_host_bridge_dev(struct device *dev)
>  	kfree(bridge);
>  }
>  
> +static const struct attribute_group *pci_host_bridge_groups[] = {
> +	PCI_IDE_ATTR_GROUP,
> +	NULL
> +};
> +
> +static const struct device_type pci_host_bridge_type = {
> +	.groups = pci_host_bridge_groups,
> +	.release = pci_release_host_bridge_dev,
> +};
> +
>  static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  {
>  	INIT_LIST_HEAD(&bridge->windows);
> @@ -659,6 +669,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	bridge->native_dpc = 1;
>  	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
>  	bridge->native_cxl_error = 1;
> +	bridge->dev.type = &pci_host_bridge_type;
>  
>  	device_initialize(&bridge->dev);
>  }
> @@ -672,7 +683,6 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
>  		return NULL;
>  
>  	pci_init_host_bridge(bridge);
> -	bridge->dev.release = pci_release_host_bridge_dev;
>  
>  	return bridge;
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cc83ae274601..ae5f32539a91 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -664,6 +664,14 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
>  				 void (*release_fn)(struct pci_host_bridge *),
>  				 void *release_data);
>  
> +#ifdef CONFIG_PCI_IDE
> +void pci_ide_init_nr_streams(struct pci_host_bridge *hb, u8 nr);
> +#else
> +static inline void pci_ide_init_nr_streams(struct pci_host_bridge *hb, u8 nr)
> +{
> +}
> +#endif
> +
>  int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
>  
>  #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */
> -- 
> 2.50.1
> 

