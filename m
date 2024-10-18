Return-Path: <linux-pci+bounces-14881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAF89A45F6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 20:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBF01C20AD0
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 18:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264CB2038C8;
	Fri, 18 Oct 2024 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pg6H5Tjm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC3201101;
	Fri, 18 Oct 2024 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729276587; cv=none; b=Do8f02RYjw3pT9bVxqblw9Zg9rPSI6BxK0VXDa95oAcWSTUMJOYrbIVQFTzjON9ljgX+iYEacj9whVi79kpT9S/d6ljsLO2JUaIJAudFCFQNfehZJiPKK2/tnOvYHl2rblA8xkc9jb1qFg+80SNhF5JshifVGr1BL0h+NfLET4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729276587; c=relaxed/simple;
	bh=XJcaa9HkJtWZo6V1cjp8K2JPzBRWsxMIur2ExFOdd2c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LiEtVS7oesKO08wcNq0aeAHRAH6WIlb6YDSk/nK+olec/R1Ih+mRkD+KooQAXpDeI155D+XFmNKENQ+p3O2Com5uw/CAhMhsVtmCq7ZkXCTJ6m6zNOJqAlSXRQBqY0TBXEBA9bJQ8R6qvVT7/jm6ej0qAP+wcehSQBpO1d6/o/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pg6H5Tjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494CBC4CEC3;
	Fri, 18 Oct 2024 18:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729276586;
	bh=XJcaa9HkJtWZo6V1cjp8K2JPzBRWsxMIur2ExFOdd2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Pg6H5TjmogNp/lE+Sff+QDDwDkzW/m5HKA1UJmvFB37S3igzHLGjBB+r9p4LxFqXt
	 PMmR73vIeCvT2c6JsFWmZh3IT0oUquxcvDRbeeYgIRz+PuLuzHQUaOBQiAL8nSmMmK
	 UKFKUJ7CXqa0YTRt2Zl1w4m0sfGmS5MzHARLRhMiazFXekJndfv1Z1C+YAAAZQ8j+B
	 Bq9U0UIXUVQVrIUebA3yfkgVRj/lqwPVrf6O3joWIuTPB4MkwI0nI7Q2y7UJVwIfLY
	 C+vc43mLIG/5+1P355/zaVSp6hRXe1jBwdEgKC1fHWK8OBz/iRgALFDSfXLUiM5x7G
	 e6k5dRc9kwVTw==
Date: Fri, 18 Oct 2024 13:36:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: Remove unused PCI_SUBTRACTIVE_DECODE
Message-ID: <20241018183624.GA756809@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017141111.44612-1-ilpo.jarvinen@linux.intel.com>

On Thu, Oct 17, 2024 at 05:11:08PM +0300, Ilpo Järvinen wrote:
> The commit 2fe2abf896c1 ("PCI: augment bus resource table with a list")
> added PCI_SUBTRACTIVE_DECODE which is put into the struct
> pci_bus_resource flags field but is never read. There seems to never
> have been users for it. Remove both PCI_SUBTRACTIVE_DECODE and the
> flags field from the struct pci_bus_resource.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

All three applied with Jonathan's reviewed-by to pci/enumeration for
v6.13, thanks, Ilpo!

> ---
>  arch/s390/pci/pci_bus.c |  2 +-
>  arch/x86/pci/fixup.c    |  2 +-
>  drivers/pci/bus.c       |  4 +---
>  drivers/pci/probe.c     |  5 ++---
>  include/linux/pci.h     | 12 +-----------
>  5 files changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> index daa5d7450c7d..5630af5deb8b 100644
> --- a/arch/s390/pci/pci_bus.c
> +++ b/arch/s390/pci/pci_bus.c
> @@ -53,7 +53,7 @@ static int zpci_bus_prepare_device(struct zpci_dev *zdev)
>  		zpci_setup_bus_resources(zdev);
>  		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  			if (zdev->bars[i].res)
> -				pci_bus_add_resource(zdev->zbus->bus, zdev->bars[i].res, 0);
> +				pci_bus_add_resource(zdev->zbus->bus, zdev->bars[i].res);
>  		}
>  	}
>  
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 98a9bb92d75c..0681ecfe3430 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -757,7 +757,7 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
>  		dev_info(&dev->dev, "adding root bus resource %pR (tainting kernel)\n",
>  			 res);
>  		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> -		pci_bus_add_resource(dev->bus, res, 0);
> +		pci_bus_add_resource(dev->bus, res);
>  	}
>  
>  	base = ((res->start >> 8) & AMD_141b_MMIO_BASE_MMIOBASE_MASK) |
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 55c853686051..9cf6d0f3ab2b 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -46,8 +46,7 @@ void pci_free_resource_list(struct list_head *resources)
>  }
>  EXPORT_SYMBOL(pci_free_resource_list);
>  
> -void pci_bus_add_resource(struct pci_bus *bus, struct resource *res,
> -			  unsigned int flags)
> +void pci_bus_add_resource(struct pci_bus *bus, struct resource *res)
>  {
>  	struct pci_bus_resource *bus_res;
>  
> @@ -58,7 +57,6 @@ void pci_bus_add_resource(struct pci_bus *bus, struct resource *res,
>  	}
>  
>  	bus_res->res = res;
> -	bus_res->flags = flags;
>  	list_add_tail(&bus_res->list, &bus->resources);
>  }
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4f68414c3086..4243b1e6ece2 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -546,8 +546,7 @@ void pci_read_bridge_bases(struct pci_bus *child)
>  	if (dev->transparent) {
>  		pci_bus_for_each_resource(child->parent, res) {
>  			if (res && res->flags) {
> -				pci_bus_add_resource(child, res,
> -						     PCI_SUBTRACTIVE_DECODE);
> +				pci_bus_add_resource(child, res);
>  				pci_info(dev, "  bridge window %pR (subtractive decode)\n",
>  					   res);
>  			}
> @@ -1032,7 +1031,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  		if (res->flags & IORESOURCE_BUS)
>  			pci_bus_insert_busn_res(bus, bus->number, res->end);
>  		else
> -			pci_bus_add_resource(bus, res, 0);
> +			pci_bus_add_resource(bus, res);
>  
>  		if (offset) {
>  			if (resource_type(res) == IORESOURCE_IO)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4c2be6..6a9cf80d0d4b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -633,18 +633,9 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
>   * Use pci_bus_for_each_resource() to iterate through all the resources.
>   */
>  
> -/*
> - * PCI_SUBTRACTIVE_DECODE means the bridge forwards the window implicitly
> - * and there's no way to program the bridge with the details of the window.
> - * This does not apply to ACPI _CRS windows, even with the _DEC subtractive-
> - * decode bit set, because they are explicit and can be programmed with _SRS.
> - */
> -#define PCI_SUBTRACTIVE_DECODE	0x1
> -
>  struct pci_bus_resource {
>  	struct list_head	list;
>  	struct resource		*res;
> -	unsigned int		flags;
>  };
>  
>  #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */
> @@ -1498,8 +1489,7 @@ void pci_add_resource(struct list_head *resources, struct resource *res);
>  void pci_add_resource_offset(struct list_head *resources, struct resource *res,
>  			     resource_size_t offset);
>  void pci_free_resource_list(struct list_head *resources);
> -void pci_bus_add_resource(struct pci_bus *bus, struct resource *res,
> -			  unsigned int flags);
> +void pci_bus_add_resource(struct pci_bus *bus, struct resource *res);
>  struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n);
>  void pci_bus_remove_resources(struct pci_bus *bus);
>  void pci_bus_remove_resource(struct pci_bus *bus, struct resource *res);
> -- 
> 2.39.5
> 

