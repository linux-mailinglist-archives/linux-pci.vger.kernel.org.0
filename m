Return-Path: <linux-pci+bounces-2231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2986D82FC97
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 23:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AA1291405
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 22:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851EE5BACC;
	Tue, 16 Jan 2024 21:16:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F92B2E401
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439812; cv=none; b=qsJMHrpmMmEYBXJ6Chs8CL/GLkHJuP5ByDJWOfknuE8re+EyNLs6oRgsxHnf0XLeTbqXJQMVr9s8m6Ljzzk9tqnxClArGHX1ktsuso0//8ci+mXIdnw5yCz2qkosQICNOBjvMfrlWnTlg93w75m/K41caneqxI5ZaiLeLIsIFuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439812; c=relaxed/simple;
	bh=xBHW4qYf3NcxxENUHmwdw0yhtGOW1i9//29Q4Cdd+0M=;
	h=Received:From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=FEpzkBV1TVoktOMAGlaz5V6pTEFiRMfy9x0BBS0OABMBDl5+Y+X1axBKHFE9YwDChWhmZuFm69fZ/4QzJqGAzQJI0LCJ/1qG5LRwQJxOZJpmSj762FhhEUK0G8eDhUIEaAVYDn/6v/tE7lmvT7mEUmbhaDpNbyaLLTJNNr3IAzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-108.elisa-laajakaista.fi [88.113.24.108])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 655d8f3c-b4b4-11ee-a9de-005056bdf889;
	Tue, 16 Jan 2024 23:15:39 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Tue, 16 Jan 2024 23:15:38 +0200
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 01/10] pci: add new set of devres functions
Message-ID: <Zabx-u-R-VsYIeIz@surfacebook.localdomain>
References: <20240115144655.32046-2-pstanner@redhat.com>
 <20240115144655.32046-3-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115144655.32046-3-pstanner@redhat.com>

Mon, Jan 15, 2024 at 03:46:12PM +0100, Philipp Stanner kirjoitti:
> PCI's devres API is not extensible to ranged mappings and has
> bug-provoking features. Improve that by providing better alternatives.
> 
> When the original devres API for PCI was implemented, priority was given
> to the creation of a set of "pural functions" such as
> pcim_request_regions(). These functions have bit masks as parameters to
> specify which BARs shall get mapped. Most users, however, only use those
> to mapp 1-3 BARs.
> A complete set of "singular functions" does not exist.
> 
> As functions mapping / requesting multiple BARs at once have (almost) no
> mechanism in C to return the resources to the caller of the plural
> function, the devres API utilizes the iomap-table administrated by the
> function pcim_iomap_table().
> 
> The entire PCI devres implementation was strongly tied to that table
> which only allows for mapping whole, complete BARs, as the BAR's index
> is used as table index. Consequently, it's not possible to, e.g., have a
> pcim_iomap_range() function with that mechanism.
> 
> An additional problem is that pci-devres has been ipmlemented in a sort
> of "hybrid-mode": Some unmanaged functions have managed counterparts
> (e.g.: pci_iomap() <-> pcim_iomap()), making their managed nature
> obvious to the programmer. However, the region-request functions in
> pci.c, prefixed with pci_, behave either managed or unmanaged, depending
> on whether pci_enable_device() or pcim_enable_device() has been called
> in advance.
> 
> This hybrid API is confusing and should be more cleanly separated by
> providing always-managed functions prefixed with pcim_.
> 
> Thus, the existing devres API is not desirable because:
> 	a) The vast majority of the users of the plural functions only
> 	   ever sets a single bit in the bit mask, consequently making
> 	   them singular functions anyways.
> 	b) There is no mechanism to request / iomap only part of a BAR.
> 	c) The iomap-table mechanism is over-engineered, complicated and
> 	   can by definition not perform bounds checks, thus, provoking
> 	   memory faults: pcim_iomap_table(pdev)[42]
> 	d) region-request functions being sometimes managed and
> 	   sometimes not is bug-provoking.
> 
> Implement a set of singular pcim_ functions that use devres directly
> and bypass the legacy iomap table mechanism.
> Add devres.c to driver-api documentation.

...

> +struct pcim_addr_devres {
> +	enum pcim_addr_devres_type type;
> +	void __iomem *baseaddr;
> +	unsigned long offset;
> +	unsigned long len;
> +	short bar;
> +};
> +
> +static inline void pcim_addr_devres_clear(struct pcim_addr_devres *res)
> +{
> +	res->type = PCIM_ADDR_DEVRES_TYPE_INVALID;
> +	res->bar = -1;
> +	res->baseaddr = NULL;
> +	res->offset = 0;
> +	res->len = 0;

More robust (in case the data type gets extended) is memset() + individual
(non-0) sets.

> +}

...

> +static int __pcim_request_region_range(struct pci_dev *pdev, int bar,
> +		unsigned long offset, unsigned long maxlen,
> +		const char *name, int exclusive)
> +{
> +	resource_size_t start = pci_resource_start(pdev, bar);
> +	resource_size_t len = pci_resource_len(pdev, bar);
> +	unsigned long flags = pci_resource_flags(pdev, bar);
> +
> +	if (start == 0 || len == 0) /* that's an unused BAR. */
> +		return 0;
> +	if (len <= offset)
> +		return  -EINVAL;
> +
> +	start += offset;
> +	len -= offset;

> +	if (len > maxlen && maxlen != 0)
> +		len = maxlen;

	if (maxlen && ...)

?

> +	if (flags & IORESOURCE_IO) {
> +		if (!request_region(start, len, name))
> +			return -EBUSY;
> +	} else if (flags & IORESOURCE_MEM) {
> +		if (!__request_mem_region(start, len, name, exclusive))
> +			return -EBUSY;
> +	} else {
> +		/* That's not a device we can request anything on. */
> +		return -ENODEV;
> +	}

Hmm... Not sure, but the switch-case against type might be considered:

	switch (resource_type(...)) {
		...
	}

> +	return 0;
> +}

> +static void __pcim_release_region_range(struct pci_dev *pdev, int bar,
> +		unsigned long offset, unsigned long maxlen)
> +{
> +	resource_size_t start = pci_resource_start(pdev, bar);
> +	resource_size_t len = pci_resource_len(pdev, bar);
> +	unsigned long flags = pci_resource_flags(pdev, bar);
> +
> +	if (len <= offset || start == 0)
> +		return;
> +
> +	if (len == 0 || maxlen == 0) /* This an unused BAR. Do nothing. */
> +		return;
> +
> +	start += offset;
> +	len -= offset;
> +
> +	if (len > maxlen)
> +		len = maxlen;

This part is quite a duplication of the above function, no?

> +	if (flags & IORESOURCE_IO)
> +		release_region(start, len);
> +	else if (flags & IORESOURCE_MEM)
> +		release_mem_region(start, len);
> +}

...

> +static int __pcim_request_region(struct pci_dev *pdev, int bar,
> +		const char *name, int exclusive)
> +{
> +	const unsigned long offset = 0;
> +	const unsigned long len = pci_resource_len(pdev, bar);

How const anyhow useful here?
Ditto for other places like this.

> +	return __pcim_request_region_range(pdev, bar, offset, len, name, exclusive);
> +}

...

> +static int pcim_addr_resources_match(struct device *dev, void *a_raw, void *b_raw)
> +{
> +	struct pcim_addr_devres *a, *b;
> +
> +	a = a_raw;
> +	b = b_raw;

> +	(void)dev; /* unused. */

Why do we need this?

> +	if (a->type != b->type)
> +		return 0;
> +
> +	switch (a->type) {
> +	case PCIM_ADDR_DEVRES_TYPE_REGION:
> +	case PCIM_ADDR_DEVRES_TYPE_REGION_MAPPING:
> +		return a->bar == b->bar;
> +	case PCIM_ADDR_DEVRES_TYPE_MAPPING:
> +		return a->baseaddr == b->baseaddr;
> +	case PCIM_ADDR_DEVRES_TYPE_REGION_RANGE_MAPPING:
> +		return a->bar == b->bar &&
> +			a->offset == b->offset && a->len == b->len;

Indentation or made it a single line.

> +	default:
> +		break;
> +	}
> +
> +	return 0;

return directly from default case.

> +}

...

> +/**
> + * pcim_iomap_region - Request and iomap a PCI BAR
> + * @pdev: PCI device to map IO resources for
> + * @bar: Index of a BAR to map
> + * @name: Name associated with the request
> + *
> + * Returns __iomem pointer on success, an IOMEM_ERR_PTR on failure.

Please, make sure the kernel-doc won't complain

	scripts/kernel-doc -v -none -Wall ...

> + * Mapping and region will get automatically released on driver detach. If
> + * desired, release manually only with pcim_iounmap_region().
> + */
> +void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar, const char *name)
> +{
> +	int ret = 0;

Redundant assignment.

> +	struct pcim_addr_devres *res;

Perhaps reversed xmas tree order?

> +	res = pcim_addr_devres_alloc(pdev);
> +	if (!res)
> +		return IOMEM_ERR_PTR(-ENOMEM);
> +
> +	res->type = PCIM_ADDR_DEVRES_TYPE_REGION_MAPPING;
> +	res->bar = bar;
> +
> +	ret = __pcim_request_region(pdev, bar, name, 0);
> +	if (ret != 0)
> +		goto err_region;
> +
> +	res->baseaddr = pci_iomap(pdev, bar, 0);
> +	if (!res->baseaddr) {
> +		ret = -EINVAL;
> +		goto err_iomap;
> +	}
> +
> +	devres_add(&pdev->dev, res);
> +	return res->baseaddr;
> +
> +err_iomap:
> +	__pcim_release_region(pdev, bar);
> +err_region:
> +	pcim_addr_devres_free(res);
> +
> +	return IOMEM_ERR_PTR(ret);
> +}

...

> +static int _pcim_request_region(struct pci_dev *pdev, int bar, const char *name,
> +		int request_flags)

Indentation?

> +{
> +	int ret = 0;

Unneded assignment. Also fix this in other places.

> +	struct pcim_addr_devres *res;
> +
> +	res = pcim_addr_devres_alloc(pdev);
> +	if (!res)
> +		return -ENOMEM;
> +	res->type = PCIM_ADDR_DEVRES_TYPE_REGION;
> +	res->bar = bar;
> +
> +	ret = __pcim_request_region(pdev, bar, name, request_flags);
> +	if (ret != 0) {

	if (ret)

Also fix this in other places.

> +		pcim_addr_devres_free(res);
> +		return ret;
> +	}
> +
> +	devres_add(&pdev->dev, res);
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



