Return-Path: <linux-pci+bounces-21310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB68A330D4
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 21:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C173A720B
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 20:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3BB20126C;
	Wed, 12 Feb 2025 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3dtN+I5"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA5201100
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739392100; cv=none; b=C7Us/ZBPxiWGYCwzoTGEZTuH4I9xxbZHILWztcU8IZkXp1NlDTakKIvsj0o5oj2rql7H03EMPEXd41wPiRK/ha7XMM4vehRHagWERieekCj0muxwYe29Ekkg2YTJciaCLoJgov33z/yk/QLYotPUScipH8NZZZezgYyalX7nNdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739392100; c=relaxed/simple;
	bh=sjyb8CO9UDI0bkvCcVRPvdxFy6b8B/z8MMi7G+pzvSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFjMnumj3ZpUrodeizrf8fOWF3gxPX/vBBvjaTwiE2EVxJpgA3GabKzMajJXMSv5xZA7gZepfK4opIp/E7K8DsdcTrAYoZHxkzQDc7R47wS4Q5+v1O0a6ozMYspfcR8yreUjG6DQrSTWAKPyLmZTEgHYgTu5OHuKBd+6ys3nXt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3dtN+I5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739392096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEoeLSsS3aCEim/Ww8cGuMBb2a0y/QZooCtBWDiEWjA=;
	b=S3dtN+I55XaLdh8p0ehDOL+JzDJBJmMsnaNNPr7kwClBcM4f3hmmwLkz9eVY+Vm3E+I0/l
	MUAuIfr4OG1pO11Ysrtjr2KaCXseAdjHPkjy+/NTFjrSau284FCXl4fxjXG0lo8OoibpuL
	vG4m/MH8Xw+hmB7nSvx+1GQRFiFKzlw=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-391qEhpaPtSmCmnnvnR31Q-1; Wed, 12 Feb 2025 15:28:15 -0500
X-MC-Unique: 391qEhpaPtSmCmnnvnR31Q-1
X-Mimecast-MFC-AGG-ID: 391qEhpaPtSmCmnnvnR31Q_1739392095
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85525a681ecso2233139f.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 12:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739392095; x=1739996895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEoeLSsS3aCEim/Ww8cGuMBb2a0y/QZooCtBWDiEWjA=;
        b=hBXDRceUJDF6iOJuk+Vc0RTwhpzomSEv6RHb9ER61Omb/m0BahdNG2KAw0dRcP9bok
         GTKwogrWl9yQ/Mbp6ROLOjV75JU+2tETCznm40aUX5nlz3CpC5pCzDCAyEf7/Emo2CE6
         XBDQQsrnM2bBf7+057Mhsx8riHVVK35WUV4DlrIdCBOak0mOW5hRv0uN/7PFO1xXXGyh
         wIYdJduEWmdJ6a4XerczAkv6dPsSihRkVVvWgCC8gwoDrcI+YGTxZUL82ejuYyALLN2x
         wDAnkTKqtvtZkCOUE+bsJSil0bL6pGxuohppdvPu4LyCqw+H5L10srggO3Xzo1HHXVop
         tv4A==
X-Forwarded-Encrypted: i=1; AJvYcCXMAQOtEakW+ZiWYzmiLSv6Z0xB39101dNbs3lYkrMq/Q4UlCMMDfVTI1IVH+naZKogFpLzooFSOOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfwh0AkxK6sR7MNY+rNQW8YxB7yQBgvhs0tpHAY/6XuymPcgtr
	zsV6aBxGoJ72Pn9MXXsdG9cGt8bJw3lB+J2j0XWXDfHsy0Npn2rhz2p/+VTaQ6JegxDQuA7TCDR
	0Nqhivvq8rKqgw478M+lRFPKbxBAzvNsvPDmAMeLoGsl0zy3Yy4emYaPMug==
X-Gm-Gg: ASbGnctENnd/gO55wRDEEWkDf9uw+uzyIIdb1vyjrtTK0pOk1YI0zcR1WJG72JAUlZY
	Kruu8YqtXW/qZy3swJUakb3ayAwnG0Mk/y634OHlCkTnIHgKb5VAR5uK0+VHb4KV/J0p1rR9k7k
	jCWTuNDDqxrm6Fo6ppyyzG7yrA64a5vpg1F+72mC4CoIUqSUAbgGjJn+W2vbwPkA2FlpV3yhmUn
	6Oi81d97E615z4A3YgjSMOJHp06Tqbe16Dpr6HsU4ibfueShEsFZdma5Ia+JPueHAE93GAZqtyp
	CXhVmBZ9
X-Received: by 2002:a92:cd84:0:b0:3d0:17d2:a02a with SMTP id e9e14a558f8ab-3d17bffab44mr9449665ab.6.1739392094516;
        Wed, 12 Feb 2025 12:28:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyMnLl5ryneXcFqbJLdWXtkIqeCdaQ3vDzYtJyQFOGuNj5RmpgPu7yQTnc7ZA4uZtoSr3rVg==
X-Received: by 2002:a92:cd84:0:b0:3d0:17d2:a02a with SMTP id e9e14a558f8ab-3d17bffab44mr9449525ab.6.1739392094143;
        Wed, 12 Feb 2025 12:28:14 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccf9afc38sm3393858173.1.2025.02.12.12.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:28:12 -0800 (PST)
Date: Wed, 12 Feb 2025 13:28:08 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Alexandra Winter <wintera@linux.ibm.com>, Gerd Bayer
 <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Thorsten Winkler <twinkler@linux.ibm.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Julian Ruess <julianr@linux.ibm.com>, Halil
 Pasic <pasic@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 2/2] PCI: s390: Support mmap() of BARs and replace
 VFIO_PCI_MMAP by a device flag
Message-ID: <20250212132808.08dcf03c.alex.williamson@redhat.com>
In-Reply-To: <20250212-vfio_pci_mmap-v5-2-633ca5e056da@linux.ibm.com>
References: <20250212-vfio_pci_mmap-v5-0-633ca5e056da@linux.ibm.com>
	<20250212-vfio_pci_mmap-v5-2-633ca5e056da@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 16:28:32 +0100
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> On s390 there is a virtual PCI device called ISM which has a few
> peculiarities. For one, it presents a 256 TiB PCI BAR whose size leads
> to any attempt to ioremap() the whole BAR failing. This is problematic
> since mapping the whole BAR is the default behavior of for example
> vfio-pci in combination with QEMU and VFIO_PCI_MMAP enabled.
> 
> Even if one tried to map this BAR only partially, the mapping would not
> be usable without extra precautions on systems with MIO support enabled.
> This is because of another oddity, in that this virtual PCI device does
> not support the newer memory I/O (MIO) PCI instructions and legacy PCI
> instructions are not accessible through writeq()/readq() when MIO is in
> use.
> 
> In short the ISM device's BAR is not accessible through memory mappings.
> Indicate this by introducing a new non_mappable_bars flag for the ISM
> device and set it using a PCI quirk. Use this flag instead of the
> VFIO_PCI_MMAP Kconfig option to block mapping with vfio-pci. This was
> the only use of the Kconfig option so remove it. Note that there are no
> PCI resource sysfs files on s390x already as HAVE_PCI_MMAP is currently
> not set. If this were to be set in the future pdev->non_mappable_bars
> can be used to prevent unusable resource files for ISM from being
> created.

I think we should also look at it from the opposite side, not just
s390x maybe adding HAVE_PCI_MMAP in the future, but the fact that we're
currently adding a generic PCI device flag which isn't honored by the
one mechanism that PCI core provides to mmap MMIO BARs to userspace.
It seems easier to implement it in pci_mmap_resource() now rather than
someone later discovering there's no enforcement outside of the very
narrow s390x use case.  Thanks,

Alex

> As s390x has no PCI quirk handling add basic support modeled after x86's
> arch/x86/pci/fixup.c and move the ISM device's PCI ID to the common
> header to make it accessible. Also enable CONFIG_PCI_QUIRKS whenever
> CONFIG_PCI is enabled.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/Kconfig                |  4 +---
>  arch/s390/pci/Makefile           |  2 +-
>  arch/s390/pci/pci_fixup.c        | 23 +++++++++++++++++++++++
>  drivers/s390/net/ism_drv.c       |  1 -
>  drivers/vfio/pci/Kconfig         |  4 ----
>  drivers/vfio/pci/vfio_pci_core.c |  2 +-
>  include/linux/pci.h              |  1 +
>  include/linux/pci_ids.h          |  1 +
>  8 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 9c9ec08d78c71b4d227beeafab1b82d6434cb5c7..e48741e001476f765e8aba0037a1b386df393683 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -41,9 +41,6 @@ config AUDIT_ARCH
>  config NO_IOPORT_MAP
>  	def_bool y
>  
> -config PCI_QUIRKS
> -	def_bool n
> -
>  config ARCH_SUPPORTS_UPROBES
>  	def_bool y
>  
> @@ -258,6 +255,7 @@ config S390
>  	select PCI_DOMAINS		if PCI
>  	select PCI_MSI			if PCI
>  	select PCI_MSI_ARCH_FALLBACKS	if PCI_MSI
> +	select PCI_QUIRKS		if PCI
>  	select SPARSE_IRQ
>  	select SWIOTLB
>  	select SYSCTL_EXCEPTION_TRACE
> diff --git a/arch/s390/pci/Makefile b/arch/s390/pci/Makefile
> index df73c5182990ad3ae4ed5a785953011feb9a093c..1810e0944a4ed9d31261788f0f6eb341e5316546 100644
> --- a/arch/s390/pci/Makefile
> +++ b/arch/s390/pci/Makefile
> @@ -5,6 +5,6 @@
>  
>  obj-$(CONFIG_PCI)	+= pci.o pci_irq.o pci_clp.o \
>  			   pci_event.o pci_debug.o pci_insn.o pci_mmio.o \
> -			   pci_bus.o pci_kvm_hook.o pci_report.o
> +			   pci_bus.o pci_kvm_hook.o pci_report.o pci_fixup.o
>  obj-$(CONFIG_PCI_IOV)	+= pci_iov.o
>  obj-$(CONFIG_SYSFS)	+= pci_sysfs.o
> diff --git a/arch/s390/pci/pci_fixup.c b/arch/s390/pci/pci_fixup.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..35688b645098329f082d0c40cc8c59231c390eaa
> --- /dev/null
> +++ b/arch/s390/pci/pci_fixup.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Exceptions for specific devices,
> + *
> + * Copyright IBM Corp. 2025
> + *
> + * Author(s):
> + *   Niklas Schnelle <schnelle@linux.ibm.com>
> + */
> +#include <linux/pci.h>
> +
> +static void zpci_ism_bar_no_mmap(struct pci_dev *pdev)
> +{
> +	/*
> +	 * ISM's BAR is special. Drivers written for ISM know
> +	 * how to handle this but others need to be aware of their
> +	 * special nature e.g. to prevent attempts to mmap() it.
> +	 */
> +	pdev->non_mappable_bars = 1;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM,
> +			PCI_DEVICE_ID_IBM_ISM,
> +			zpci_ism_bar_no_mmap);
> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index e36e3ea165d3b2b01d68e53634676cb8c2c40220..d32633ed9fa80c1764724f493b363bfd6cb4f9cf 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -20,7 +20,6 @@
>  MODULE_DESCRIPTION("ISM driver for s390");
>  MODULE_LICENSE("GPL");
>  
> -#define PCI_DEVICE_ID_IBM_ISM 0x04ED
>  #define DRV_NAME "ism"
>  
>  static const struct pci_device_id ism_device_table[] = {
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index bf50ffa10bdea9e52a9d01cc3d6ee4cade39a08c..c3bcb6911c538286f7985f9c5e938d587fc04b56 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -7,10 +7,6 @@ config VFIO_PCI_CORE
>  	select VFIO_VIRQFD
>  	select IRQ_BYPASS_MANAGER
>  
> -config VFIO_PCI_MMAP
> -	def_bool y if !S390
> -	depends on VFIO_PCI_CORE
> -
>  config VFIO_PCI_INTX
>  	def_bool y if !S390
>  	depends on VFIO_PCI_CORE
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 586e49efb81be32ccb50ca554a60cec684c37402..c8586d47704c74cf9a5256d65bbf888db72b2f91 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -116,7 +116,7 @@ static void vfio_pci_probe_mmaps(struct vfio_pci_core_device *vdev)
>  
>  		res = &vdev->pdev->resource[bar];
>  
> -		if (!IS_ENABLED(CONFIG_VFIO_PCI_MMAP))
> +		if (vdev->pdev->non_mappable_bars)
>  			goto no_mmap;
>  
>  		if (!(res->flags & IORESOURCE_MEM))
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 47b31ad724fa5bf7abd7c3dc572947551b0f2148..7192b9d78d7e337ce6144190325458fe3c0f1696 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -476,6 +476,7 @@ struct pci_dev {
>  	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
>  	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
>  	unsigned int	rom_attr_enabled:1;	/* Display of ROM attribute enabled? */
> +	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped to user-space  */
>  	pci_dev_flags_t dev_flags;
>  	atomic_t	enable_cnt;	/* pci_enable_device has been called */
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index de5deb1a0118fcf56570d461cbe7a501d4bd0da3..ec6d311ed12e174dc0bad2ce8c92454bed668fee 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -518,6 +518,7 @@
>  #define PCI_DEVICE_ID_IBM_ICOM_V2_ONE_PORT_RVX_ONE_PORT_MDM	0x0251
>  #define PCI_DEVICE_ID_IBM_ICOM_V2_ONE_PORT_RVX_ONE_PORT_MDM_PCIE 0x0361
>  #define PCI_DEVICE_ID_IBM_ICOM_FOUR_PORT_MODEL	0x252
> +#define PCI_DEVICE_ID_IBM_ISM		0x04ED
>  
>  #define PCI_SUBVENDOR_ID_IBM		0x1014
>  #define PCI_SUBDEVICE_ID_IBM_SATURN_SERIAL_ONE_PORT	0x03d4
> 


