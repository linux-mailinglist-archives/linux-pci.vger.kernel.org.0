Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784743F361E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 23:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhHTVoB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 17:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229760AbhHTVoA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 17:44:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48CFA6115A;
        Fri, 20 Aug 2021 21:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629495802;
        bh=uhrttP+Dc4KMRCsTH3cjMoa9e0kGIIwNGCBa9V9LMHw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mhbmu98hrXzy2qJrUz9g7Ags/VqHlIu6TCLi/VDZz9iMI9XsVgsTJKiGbH1zOY3K2
         QFn8G6SUbz3UIYMD81kxxURpHjdhDQye4gvBVjrFJSdDWGwQVEuiA0JoR3VkOwqPJ/
         nvXBs6bNqSBEFOHCF8oaGGRyRfMf0j/6MWPLsGDHqrlC3rzQ2mcSW9OrrCcplIAF9x
         V1YScI5I591xnKXPNPy6ctPJL5WVPkwOnCOZ3kG+sSQK/bV66naWX+vzsFlsG9B+K+
         2wCcdvsITgUmM5+F0nGkZbYcV/6Ss8N/ximNJ2bndz7qKEp+PjP+oL6KX1pnZI88iH
         ZnSqy2qAqEaOw==
Date:   Fri, 20 Aug 2021 16:43:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     bhelgaas@google.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mchehab+huawei@kernel.org,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        leon@kernel.org, schnelle@linux.ibm.com, bilbao@vt.edu,
        luzmaximilian@gmail.com, linuxarm@huawei.com,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] PCI/MSI: Clarify the irq sysfs ABI for PCI devices
Message-ID: <20210820214320.GA3362906@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813122650.25764-1-21cnbao@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 14, 2021 at 12:26:50AM +1200, Barry Song wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> /sys/bus/pci/devices/.../irq has been there for many years but it has never
> been documented. This patch is trying to document it. Plus, irq ABI is very
> confusing at this moment especially for MSI and MSI-x cases. MSI sets irq
> to the first number in the vector, but MSI-X does nothing for this though
> it saves default_irq in msix_setup_entries(). Weird the saved default_irq
> for MSI-X is never used in pci_msix_shutdown(), which is quite different
> with pci_msi_shutdown(). Thus, this patch also moves to show the first IRQ
> number which is from the first msi_entry for MSI-X. Hopefully, this can
> make irq ABI more clear and more consistent.

s/MSI-x/MSI-X/
s/irq/IRQ/

This looks like it should be two patches:

  - Update documentation

  - Some sort of bug fix in msix_capability_init() and pci_msix_shutdown()

Perhaps do the bug fix first if you want the doc to match the code.

> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 8 ++++++++
>  drivers/pci/msi.c                       | 6 ++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 793cbb7..8d42385 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -96,6 +96,14 @@ Description:
>  		This attribute indicates the mode that the irq vector named by
>  		the file is in (msi vs. msix)
>  
> +What:		/sys/bus/pci/devices/.../irq
> +Date:		August 2021
> +Contact:	Barry Song <song.bao.hua@hisilicon.com>
> +Description:
> +		Historically this attribute represent the IRQ line which runs
> +		from the PCI device to the Interrupt controller. With MSI and
> +		MSI-X, this attribute is the first IRQ number of IRQ vectors.
> +
>  What:		/sys/bus/pci/devices/.../remove
>  Date:		January 2009
>  Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 9232255..6bbf81b 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -771,6 +771,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>  	int ret;
>  	u16 control;
>  	void __iomem *base;
> +	struct msi_desc *desc;
>  
>  	/* Ensure MSI-X is disabled while it is set up */
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
> @@ -814,6 +815,10 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>  
>  	pcibios_free_irq(dev);
> +
> +	desc = first_pci_msi_entry(dev);
> +	dev->irq = desc->irq;
> +
>  	return 0;
>  
>  out_avail:
> @@ -1024,6 +1029,7 @@ static void pci_msix_shutdown(struct pci_dev *dev)
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
>  	pci_intx_for_msi(dev, 1);
>  	dev->msix_enabled = 0;
> +	dev->irq = entry->msi_attrib.default_irq;
>  	pcibios_alloc_irq(dev);
>  }
>  
> -- 
> 1.8.3.1
> 
