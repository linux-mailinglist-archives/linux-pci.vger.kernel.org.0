Return-Path: <linux-pci+bounces-11381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 185F2949848
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 21:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5451C20987
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 19:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C03812C499;
	Tue,  6 Aug 2024 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="madRDZ/H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E217711F;
	Tue,  6 Aug 2024 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972658; cv=none; b=MN54brE8qMiG1sU1kFyY4IK1+s0t+d2sc6/AhQQ0nREpBBc9Tg47rcyMe1YXfTebCyUATZvv/DEOAnpOIq9CWUxsbTrvqfaY6CQOynKcnH/+JWN7avUjQgNcMqXa7raVI/mWzwMXu80MiYcjzz3K7zh/320htsaM60Lf0Urnzlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972658; c=relaxed/simple;
	bh=rhBS139heVK+dF947eTUWR6MBroxGP193A4ribCbGGA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mBFIS9ho6RUd16xBo9KgusCR520JVgF+r5KdfvKkivb9i4OlNRj43T+JeVW31chb0kP8SP+YUka6iWnQigQSv6Ot0+3ZpdCQMO2XibPIOCbpn+wHa7oDnEFfGxFXf0BzUxv013pHEJsNeA1YZL5flT17AwjoPwvtnqa+2sCNzsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=madRDZ/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B21C4AF13;
	Tue,  6 Aug 2024 19:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722972657;
	bh=rhBS139heVK+dF947eTUWR6MBroxGP193A4ribCbGGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=madRDZ/HZuGEcZCQJunnVX4EqVmwSbX1LdNqxcAGapjv/1XDZEefymEKxCZpXHc7n
	 dPmGfenqcbRMJb+jfrA5+zbQTDjgchNyT4yVBCoSlZBHsAGyzhWTD/2UH7FUUV9PId
	 vKriCeQGxkTAsGEQp32kGVHh7v2Nt73n7sNyQADLGQKwLvth768U3Ql+EvGV7JfUV5
	 rlFxUlk31YzmFw6K5+EfDzXEdrlDKyBcaiSQsJ2lYFlAYT7efriLuX0eYND3wTeFj8
	 QhFPBFTwqcrSFgcFJCRfw7vz21zMPfBaGATxALd7rbwq+qnQlqtWsntvmXA80UMH+R
	 GfRBmwBsROoYg==
Date: Tue, 6 Aug 2024 14:30:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org, Alistair Francis <alistair23@gmail.com>,
	Jonathan.Cameron@huawei.com, alex.williamson@redhat.com,
	christian.koenig@amd.com, kch@nvidia.com,
	gregkh@linuxfoundation.org, logang@deltatee.com,
	chaitanyak@nvidia.com, rdunlap@infradead.org,
	Alistair Francis <alistair.francis@wdc.com>,
	Sebastian Ott <sebott@redhat.com>
Subject: Re: [PATCH] s390/pci: Stop usurping pdev->dev.groups
Message-ID: <20240806193055.GA73910@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b970f7923e373d1b23784721208f93418720485.1722870934.git.lukas@wunner.de>

On Mon, Aug 05, 2024 at 05:24:05PM +0200, Lukas Wunner wrote:
> Bjorn suggests using pdev->dev.groups for attribute_groups constructed
> on PCI device enumeration:
> 
>    "Is it feasible to build an attribute group in pci_doe_init() and
>     add it to dev->groups so device_add() will automatically add them?"
>     https://msgid.link/20231019165829.GA1381099@bhelgaas

Huh, another new archive link format.  I guess I need to be educated
about this.  I see 127734e23aed ("Documentation: best practices for
using Link trailers"), which added the only mentions in the tree,
although it only mentions "https://patch.msgid.link" and specifically
in the context of the origin of a patch, which leaves it clear as mud
for me.

> Unfortunately on s390, pcibios_device_add() usurps pdev->dev.groups for
> arch-specific attribute_groups, preventing its use for anything else.
> 
> Introduce an ARCH_PCI_DEV_GROUPS macro which arches can define in
> <asm/pci.h>.  The macro is visible in drivers/pci/pci-sysfs.c through
> the inclusion of <linux/pci.h>, which in turn includes <asm/pci.h>.
> 
> On s390, define the macro to the three attribute_groups previously
> assigned to pdev->dev.groups.  Thereby pdev->dev.groups is made
> available for use by the PCI core.
> 
> As a side effect, arch/s390/pci/pci_sysfs.c no longer needs to be
> compiled into the kernel if CONFIG_SYSFS=n.

I like this, and propose to merge via the PCI tree because it might
help enable Alistair's work on exposing DOE via sysfs (part of the
conversation Lukas mentioned above).

This would require an ack from the s390 folks, so I moved them to
the to: list.

> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  arch/s390/include/asm/pci.h |  9 ++++++++-
>  arch/s390/pci/Makefile      |  3 ++-
>  arch/s390/pci/pci.c         |  1 -
>  arch/s390/pci/pci_sysfs.c   | 14 ++++----------
>  drivers/pci/pci-sysfs.c     |  5 +++++
>  5 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 30820a6..9d920ce 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -191,7 +191,14 @@ static inline bool zdev_enabled(struct zpci_dev *zdev)
>  	return (zdev->fh & (1UL << 31)) ? true : false;
>  }
>  
> -extern const struct attribute_group *zpci_attr_groups[];
> +extern const struct attribute_group zpci_attr_group;
> +extern const struct attribute_group pfip_attr_group;
> +extern const struct attribute_group zpci_ident_attr_group;
> +
> +#define ARCH_PCI_DEV_GROUPS &zpci_attr_group,		 \
> +			    &pfip_attr_group,		 \
> +			    &zpci_ident_attr_group,
> +
>  extern unsigned int s390_pci_force_floating __initdata;
>  extern unsigned int s390_pci_no_rid;
>  
> diff --git a/arch/s390/pci/Makefile b/arch/s390/pci/Makefile
> index 0547a10..2c21f03 100644
> --- a/arch/s390/pci/Makefile
> +++ b/arch/s390/pci/Makefile
> @@ -3,7 +3,8 @@
>  # Makefile for the s390 PCI subsystem.
>  #
>  
> -obj-$(CONFIG_PCI)	+= pci.o pci_irq.o pci_clp.o pci_sysfs.o \
> +obj-$(CONFIG_PCI)	+= pci.o pci_irq.o pci_clp.o \
>  			   pci_event.o pci_debug.o pci_insn.o pci_mmio.o \
>  			   pci_bus.o pci_kvm_hook.o
>  obj-$(CONFIG_PCI_IOV)	+= pci_iov.o
> +obj-$(CONFIG_SYSFS)	+= pci_sysfs.o
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index cff4838..bd9624c 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -587,7 +587,6 @@ int pcibios_device_add(struct pci_dev *pdev)
>  	if (pdev->is_physfn)
>  		pdev->no_vf_scan = 1;
>  
> -	pdev->dev.groups = zpci_attr_groups;
>  	zpci_map_resources(pdev);
>  
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
> index 0f4f1e8..1f81f6f 100644
> --- a/arch/s390/pci/pci_sysfs.c
> +++ b/arch/s390/pci/pci_sysfs.c
> @@ -197,7 +197,7 @@ static umode_t zpci_index_is_visible(struct kobject *kobj,
>  	NULL,
>  };
>  
> -static struct attribute_group zpci_ident_attr_group = {
> +const struct attribute_group zpci_ident_attr_group = {
>  	.attrs = zpci_ident_attrs,
>  	.is_visible = zpci_index_is_visible,
>  };
> @@ -223,7 +223,7 @@ static umode_t zpci_index_is_visible(struct kobject *kobj,
>  	NULL,
>  };
>  
> -static struct attribute_group zpci_attr_group = {
> +const struct attribute_group zpci_attr_group = {
>  	.attrs = zpci_dev_attrs,
>  	.bin_attrs = zpci_bin_attrs,
>  };
> @@ -235,14 +235,8 @@ static umode_t zpci_index_is_visible(struct kobject *kobj,
>  	&dev_attr_segment3.attr,
>  	NULL,
>  };
> -static struct attribute_group pfip_attr_group = {
> +
> +const struct attribute_group pfip_attr_group = {
>  	.name = "pfip",
>  	.attrs = pfip_attrs,
>  };
> -
> -const struct attribute_group *zpci_attr_groups[] = {
> -	&zpci_attr_group,
> -	&pfip_attr_group,
> -	&zpci_ident_attr_group,
> -	NULL,
> -};
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 40cfa71..5d0f4db 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -31,6 +31,10 @@
>  #include <linux/aperture.h>
>  #include "pci.h"
>  
> +#ifndef ARCH_PCI_DEV_GROUPS
> +#define ARCH_PCI_DEV_GROUPS
> +#endif
> +
>  static int sysfs_initialized;	/* = 0 */
>  
>  /* show configuration fields */
> @@ -1624,6 +1628,7 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
>  	&pci_dev_acpi_attr_group,
>  #endif
>  	&pci_dev_resource_resize_group,
> +	ARCH_PCI_DEV_GROUPS
>  	NULL,
>  };
>  
> -- 
> 2.43.0
> 

