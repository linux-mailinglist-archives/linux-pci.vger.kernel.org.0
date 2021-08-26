Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CCA3F900E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 23:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243649AbhHZVNn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 17:13:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243642AbhHZVNn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 17:13:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61D5461037;
        Thu, 26 Aug 2021 21:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630012375;
        bh=b13YrLUqlYLVuNAmpQopOWT7ySiAsYjknbYe/IH6/mw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CeNJo6aq6FkmPOhgF/XxaIHUtSoE+kLrgJAeNGTmBVGfbdjzhf6vJ4z0BO4SUXUg8
         iWh74U0EocTho7hVQpLJDNmO0rEwPWLlRzinyVq6hyMKsL3JwNWZmXbJjwfbXFkYi+
         fCZDHaDIVZ8vCZuuKQIc4YGux809izu/HxZGNUYc/7fmLwXVwsnVp3PAtZ6g+SMNFh
         FvjjjTBfWYDqYIDoycbPcDZT/ST17T7D/W2Hlfpz3TSOkPwYKB7wCN9fx+nk3hz0cs
         nuGGlM1Bxo0iofezWLqYL2KnktufsukC4jXnGKO38RpIFWllSjeMzGhexe5zBcFzL9
         HnoHTZVsFT4OA==
Date:   Thu, 26 Aug 2021 16:12:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI/sysfs: Add pci_dev_resource_attr() macro
Message-ID: <20210826211254.GA3717803@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210825212255.878043-3-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 25, 2021 at 09:22:53PM +0000, Krzysztof Wilczyński wrote:
> The pci_dev_resource_attr() macro will be used to declare and define
> each of the PCI resource sysfs objects statically while also reducing
> unnecessary code repetition.
> 
> Internally this macro relies on the pci_dev_resource_attr_is_visible()
> helper which should correctly handle different types of PCI BAR address
> space while also providing support for creating either normal and/or
> write-combine attributes as required.

This makes a lot of sense.  To make it more approachable, I think we
might extend the commit log to mention that each BAR is independently
visible/hidden based on its existence, and each .is_visible() function
applies to the entire attribute group, which means we need a separate
attribute group for each BAR.  Actually I guess we need *two* for each
BAR -- the normal one and the WC one.  So 12 attribute groups per
device.

> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/pci/pci-sysfs.c | 47 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index c94ab9830932..6eba5c0887df 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1277,6 +1277,53 @@ static umode_t pci_dev_resource_attr_is_visible(struct kobject *kobj,
>  
>  	return attr->attr.mode;
>  }
> +
> +#define pci_dev_resource_attr(_bar)					\
> +static struct bin_attribute						\
> +pci_dev_resource##_bar##_attr = __BIN_ATTR(resource##_bar,		\
> +					   0600, NULL, NULL, 0);	\
> +									\
> +static struct bin_attribute *pci_dev_resource##_bar##_attrs[] = {	\
> +	&pci_dev_resource##_bar##_attr,					\
> +	NULL,								\
> +};									\
> +									\
> +static umode_t								\
> +pci_dev_resource##_bar##_attr_is_visible(struct kobject *kobj,		\
> +					 struct bin_attribute *a,	\
> +					 int n)				\
> +{									\
> +	return pci_dev_resource_attr_is_visible(kobj, a, _bar, false);	\
> +};									\
> +									\
> +static const struct							\
> +attribute_group pci_dev_resource##_bar##_attr_group = {			\
> +	.bin_attrs = pci_dev_resource##_bar##_attrs,			\
> +	.is_bin_visible = pci_dev_resource##_bar##_attr_is_visible,	\
> +};									\
> +									\
> +static struct bin_attribute						\
> +pci_dev_resource##_bar##_wc_attr = __BIN_ATTR(resource##_bar##_wc,	\
> +					      0600, NULL, NULL, 0);	\
> +									\
> +static struct bin_attribute *pci_dev_resource##_bar##_wc_attrs[] = {	\
> +	&pci_dev_resource##_bar##_wc_attr,				\
> +	NULL,								\
> +};									\
> +									\
> +static umode_t								\
> +pci_dev_resource##_bar##_wc_attr_is_visible(struct kobject *kobj,	\
> +					    struct bin_attribute *a,	\
> +					    int n)			\
> +{									\
> +	return pci_dev_resource_attr_is_visible(kobj, a, _bar, true);	\
> +};									\
> +									\
> +static const struct							\
> +attribute_group pci_dev_resource##_bar##_wc_attr_group = {		\
> +	.bin_attrs = pci_dev_resource##_bar##_wc_attrs,			\
> +	.is_bin_visible = pci_dev_resource##_bar##_wc_attr_is_visible,	\
> +}
>  #else /* !(defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)) */
>  int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
>  void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
> -- 
> 2.32.0
> 
