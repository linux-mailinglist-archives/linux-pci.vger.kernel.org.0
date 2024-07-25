Return-Path: <linux-pci+bounces-10798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A393C7B3
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 19:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA521B2198A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 17:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842F619DF7F;
	Thu, 25 Jul 2024 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrfZwzaX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A77E198E6D;
	Thu, 25 Jul 2024 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721928987; cv=none; b=Xpm5xOlao8LfSAy52m4RfZB3yBUc7v/PHTUvQs6NIW088XwdLGEAuMwVj8Ai5mrx1Mz6lPONK/cQMNx3YPGGP7/NLVgNoqBnnILJNgtncmJOqZLXXqtxfJbj4sWiJdJxT0XMl1qdsgwS4n9R+437faHMmNK9HRyJYccnW/W/XAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721928987; c=relaxed/simple;
	bh=wqWzraA34GyeuVscn1uWSNPbaFib2B/T/GEJV4L8vWI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R+z2crkH0XLEO1h4YOYfIpYP5QjfBLHOYyj7c0byYCL2bKwTE3r6lw7qT0XGWljJEDg8bBgA7KufJAWG/J9kl86nBHseO+SLtxKn1sSKQMdsaMjpncIaKAcfCywXkeZ0PCPMJh76TmV3rm9uwcyJrmIPgPCAprdWpOFHBSbAE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrfZwzaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4BCC116B1;
	Thu, 25 Jul 2024 17:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721928987;
	bh=wqWzraA34GyeuVscn1uWSNPbaFib2B/T/GEJV4L8vWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PrfZwzaXqL/UyPDYMz0fGULFnXJZaclnVw9A6ViPzQTuFr6NpHFYDoFNf2ild9kva
	 7Eo3ssD2FBOge1u7jSdgqWcUWPkXtbfjOBrUj2GZuQpmO3NuLvBZNMula+Og8Sfs+5
	 CyZbBm7Q/liHVt6VWkr018FwmFuTVMRNECvBfWNgZanx9jQxCa5OJLWDDHF+qtfdpp
	 95BTAnn+JgzZtJnj0DxuUggqS1IJzg2zB30+WkwRuGRBqI4MQhMdGHP5TMUx9Mjl/n
	 VqZKQLLEx5FADN7I+YvaXQAlmDtEUDIlikYIDD6gfbN23SSM0OWaLgcmHSeWM2+LwE
	 IgQ4UFiSwmKJg==
Date: Thu, 25 Jul 2024 12:36:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jim Harris <james.r.harris@intel.com>,
	Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
	Blazej Kucman <blazej.kucman@intel.com>
Subject: Re: [PATCHv3 2/2] x86/vmd: Add PCI domain specific LED option
Message-ID: <20240725173624.GA849156@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1473779140-4016-2-git-send-email-keith.busch@intel.com>

[+cc Nirmal, Jim, Paul, Blazej]

On Tue, Sep 13, 2016 at 09:05:40AM -0600, Keith Busch wrote:
> This patch adds a new function to set PCI domain specific options as
> devices are added. The usage included in this patch is for LED indicator
> control in VMD domains, but may be extended in the future as new domain
> specific options are required.
> 
> PCIe LED Slot Control in a VMD domain is repurposed to a non-standard
> implementation. As such, all devices in a VMD domain will be flagged so
> pciehp does not attempt to use LED indicators. This user_led flag
> has pciehp provide a different sysfs entry for user exclusive control
> over the domain's slot indicators.
> 
> In order to determine if a bus is within a PCI domain, the patch appends
> a bool to the pci_sysdata structure that the VMD driver sets during
> initialization.

This eventually turned into https://git.kernel.org/linus/3161832d58c7
("x86/PCI: VMD: Request userspace control of PCIe hotplug indicators")

More questions about this, prompted by Blazej's recent regression
report:
https://lore.kernel.org/r/20240722141440.7210-1-blazej.kucman@intel.com

I assume this patch was prompted by NVMe devices behind a VMD?  And
the non-standard slot indicator usage is specifically related to VMD
Root Ports?  Isn't it possible to add non-NVMe devices behind VMD,
e.g., a switch in an external enclosure where pciehp manages a switch
Downstream Port with standard slot indicators?

I'm wondering if pdev->hotplug_user_indicators should be more narrowly
targeted to just VMD Root Ports.

If there's any possibility of a Downstream Port behind VMD with
standard indicators, users are going to be very confused when the
sysfs "attention" file is basically backwards from normal.  IIUC
writing 0 to "attention" when hotplug_user_indicators is set writes 0
("reserved") to AIC, when it would otherwise write 11b ("off").

I'm also wondering whether there's a way to do this in the vmd driver
instead of in arch/x86/pci/common.c, but that's a secondary question.

>  arch/x86/include/asm/pci.h | 14 ++++++++++++++
>  arch/x86/pci/common.c      |  7 +++++++
>  arch/x86/pci/vmd.c         |  1 +
>  3 files changed, 22 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index 9ab7507..1411dbe 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -23,6 +23,9 @@ struct pci_sysdata {
>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
>  	void		*fwnode;	/* IRQ domain for MSI assignment */
>  #endif
> +#if IS_ENABLED(CONFIG_VMD)
> +	bool vmd_domain;		/* True if in Intel VMD domain */
> +#endif
>  };
>  
>  extern int pci_routeirq;
> @@ -56,6 +59,17 @@ static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
>  #define pci_root_bus_fwnode	_pci_root_bus_fwnode
>  #endif
>  
> +static inline bool is_vmd(struct pci_bus *bus)
> +{
> +#if IS_ENABLED(CONFIG_VMD)
> +	struct pci_sysdata *sd = bus->sysdata;
> +
> +	return sd->vmd_domain;
> +#else
> +	return false;
> +#endif
> +}
> +
>  /* Can be used to override the logic in pci_scan_bus for skipping
>     already-configured bus numbers - to be used for buggy BIOSes
>     or architectures with incomplete PCI setup by the loader */
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 7b6a9d1..ccf696c 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -677,6 +677,12 @@ static void set_dma_domain_ops(struct pci_dev *pdev)
>  static void set_dma_domain_ops(struct pci_dev *pdev) {}
>  #endif
>  
> +static void set_dev_domain_options(struct pci_dev *pdev)
> +{
> +	if (is_vmd(pdev->bus))
> +		pdev->user_leds = 1;
> +}
> +
>  int pcibios_add_device(struct pci_dev *dev)
>  {
>  	struct setup_data *data;
> @@ -707,6 +713,7 @@ int pcibios_add_device(struct pci_dev *dev)
>  		iounmap(data);
>  	}
>  	set_dma_domain_ops(dev);
> +	set_dev_domain_options(dev);
>  	return 0;
>  }
>  
> diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
> index b814ca6..a021b7b 100644
> --- a/arch/x86/pci/vmd.c
> +++ b/arch/x86/pci/vmd.c
> @@ -596,6 +596,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
>  		.parent = res,
>  	};
>  
> +	sd->vmd_domain = true;
>  	sd->domain = vmd_find_free_domain();
>  	if (sd->domain < 0)
>  		return sd->domain;
> -- 
> 2.7.2

