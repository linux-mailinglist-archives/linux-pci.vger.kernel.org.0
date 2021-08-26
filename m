Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88643F90FA
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 01:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhHZXgY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 19:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhHZXgY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 19:36:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 367F960725;
        Thu, 26 Aug 2021 23:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630020936;
        bh=QGKyKynXxwlgHxHh8UEQ1gukhmkptrriCiW2BfTbel0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HFwG2THisnukF+Y1qGnMTw1jQ5NLGyYe1db+z3Sic8prok/bovcz9Od+LKN4M7ebo
         b9zGO7GjkkfPDn4OzfAMtkSyBQV4ZTy7SRRnV4qr+5KCZI624SO/PEFL8Nd4XCZpiJ
         aS9E1a6oXN81cynun2CLmqDbE/T3XMWfT9OvMoEvz2T3CAJLBnlqQ2y8ImO6ullX8K
         NNNkl213geKsIAj6hOoz0IoxFcuqqtaV+Ae/M/UmpBPZDByxB0lPEyHyKyQg9Eruig
         lK1mYoVdmdVlpDQA758hVDH1PuPXmh1RYMDF7ZMo5/XDuGbNJs3f4oDem2ifHTXCxe
         11af0zOg5zVUQ==
Date:   Thu, 26 Aug 2021 18:35:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] PCI/sysfs: Add pci_dev_resource_attr_is_visible()
 helper
Message-ID: <20210826233534.GA3726492@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210825212255.878043-2-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Greg, sorry for the ill-formed sysfs question below]

On Wed, Aug 25, 2021 at 09:22:52PM +0000, Krzysztof Wilczyński wrote:
> This helper aims to replace functions pci_create_resource_files() and
> pci_create_attr() that are currently involved in the PCI resource sysfs
> objects dynamic creation and set up once the.
> 
> After the conversion to use static sysfs objects when exposing the PCI
> BAR address space this helper is to be called from the .is_bin_visible()
> callback for each of the PCI resources attributes.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/pci/pci-sysfs.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index b70f61fbcd4b..c94ab9830932 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1237,6 +1237,46 @@ static int pci_create_resource_files(struct pci_dev *pdev)
>  	}
>  	return 0;
>  }
> +
> +static umode_t pci_dev_resource_attr_is_visible(struct kobject *kobj,
> +						struct bin_attribute *attr,
> +						int bar, bool write_combine)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +	resource_size_t resource_size = pci_resource_len(pdev, bar);
> +	unsigned long flags = pci_resource_flags(pdev, bar);
> +
> +	if (!resource_size)
> +		return 0;
> +
> +	if (write_combine) {
> +		if (arch_can_pci_mmap_wc() && (flags &
> +		    (IORESOURCE_MEM | IORESOURCE_PREFETCH)) ==
> +			(IORESOURCE_MEM | IORESOURCE_PREFETCH))
> +			attr->mmap = pci_mmap_resource_wc;

Is it legal to update attr here in an .is_visible() method?  Is attr
the single static struct bin_attribute here, or is it a per-device
copy?

I'm assuming the static bin_attribute is a template and when we add a
device that uses it, we alloc a new copy so each device has its own
size, mapping function, etc.

If that's the case, we only want to update the *copy*, not the
template.  I don't see an alloc before the call in create_files(),
so I'm worried that this .is_visible() method might get the template,
in which case we'd be updating ->mmap for *all* devices.

> +		else
> +			return 0;
> +	} else {
> +		if (flags & IORESOURCE_MEM) {
> +			attr->mmap = pci_mmap_resource_uc;
> +		} else if (flags & IORESOURCE_IO) {
> +			attr->read = pci_read_resource_io;
> +			attr->write = pci_write_resource_io;
> +			if (arch_can_pci_mmap_io())
> +				attr->mmap = pci_mmap_resource_uc;
> +		} else {
> +			return 0;
> +		}
> +	}
> +
> +	attr->size = resource_size;
> +	if (attr->mmap)
> +		attr->f_mapping = iomem_get_mapping;
> +
> +	attr->private = (void *)(unsigned long)bar;
> +
> +	return attr->attr.mode;
> +}
>  #else /* !(defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)) */
>  int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
>  void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
> -- 
> 2.32.0
> 
