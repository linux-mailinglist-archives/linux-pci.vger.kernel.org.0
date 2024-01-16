Return-Path: <linux-pci+bounces-2233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D16782FCA8
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 23:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E886928F269
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 22:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3DB200C9;
	Tue, 16 Jan 2024 21:29:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F6B321BA
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705440546; cv=none; b=KTSh1ozt+0E7Qj0oc5Ai0cmWKAqWxvfFKUaMc8cR39ZYhVIAA4fOc+ScNIvseL7vfb29PqRi7WCcgWagiryZ/R3jX05nKunpsFYjxmjXkNBAMMp53XsQ2w03+Bbeio/mgJFcRwpAq6bT2iY6drvNlbPCPKXWTLVvUrjCCmLGhzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705440546; c=relaxed/simple;
	bh=l6q7v4ki1LypEs5VeKwmzU0U7uRPY25t3e94VPjfUQM=;
	h=Received:From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=UpWqMVua2sHomOuixeLPcOW2ylmaYjG9t9K4xGwm2qVl9h74IWav66oqy+ncemLIAfaluBB1oSFWU9D4Ntc9cBO5QETzwUx2HuTLzd6KGfWIggsbCOuxeHesReo2iHLLuFYqF1TvcRDPd0RvSSH0E8vwouEZQ2wKspeMIyn45G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-108.elisa-laajakaista.fi [88.113.24.108])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 1bdb063f-b4b6-11ee-b3cf-005056bd6ce9;
	Tue, 16 Jan 2024 23:27:54 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Tue, 16 Jan 2024 23:27:53 +0200
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
Subject: Re: [PATCH 02/10] pci: deprecate iomap-table functions
Message-ID: <Zab02RyfvP-IZTl4@surfacebook.localdomain>
References: <20240115144655.32046-2-pstanner@redhat.com>
 <20240115144655.32046-4-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115144655.32046-4-pstanner@redhat.com>

Mon, Jan 15, 2024 at 03:46:13PM +0100, Philipp Stanner kirjoitti:
> The old plural devres functions tie PCI's devres implementation to the
> iomap-table mechanism which unfortunately is not extensible.
> 
> As the purlal functions are almost never used with more than one bit set
> in their bit-mask, deprecating them and encouraging users to use the new
> singular functions instead is reasonable.
> 
> Furthermore, to make the implementation more consistent and extensible,
> the plural functions should use the singular functions.
> 
> Add new wrapper to request / release all BARs.
> Make the plural functions call into the singular functions.
> Mark the plural functions as deprecated.
> Remove as much of the iomap-table-mechanism as possible.
> Add comments describing the path towards a cleaned-up API.

...

>  static void pcim_iomap_release(struct device *gendev, void *res)
>  {
> -	struct pci_dev *dev = to_pci_dev(gendev);
> -	struct pcim_iomap_devres *this = res;
> -	int i;
> -
> -	for (i = 0; i < PCIM_IOMAP_MAX; i++)
> -		if (this->table[i])
> -			pci_iounmap(dev, this->table[i]);
> +	/*
> +	 * Do nothing. This is legacy code.
> +	 *
> +	 * Cleanup of the mappings is now done directly through the callbacks
> +	 * registered when creating them.
> +	 */
>  }

How many users we have? Can't we simply kill it for good?

...

> + * This function is DEPRECATED. Do not use it in new code.

We have __deprecated IIRC, can it be used?

...

> +	if (pcim_add_mapping_to_legacy_table(pdev, mapping, bar) != 0)

Redundant ' != 0' part.

> +		goto err_table;

...

> +static inline bool mask_contains_bar(int mask, int bar)
> +{
> +	return mask & (1 << bar);

BIT() ?

> +}

But I believe this function is not needed (see below).

...

>  /**
> - * pcim_iomap_regions - Request and iomap PCI BARs
> + * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
>   * @pdev: PCI device to map IO resources for
>   * @mask: Mask of BARs to request and iomap
>   * @name: Name associated with the requests
>   *
> + * Returns 0 on success, negative error code on failure.

Validate the kernel-doc.

>   * Request and iomap regions specified by @mask.
> + *
> + * This function is DEPRECATED. Don't use it in new code.
> + * Use pcim_iomap_region() instead.
>   */

...

> +	for (bar = 0; bar < DEVICE_COUNT_RESOURCE; bar++) {
> +		if (!mask_contains_bar(mask, bar))
> +			continue;

NIH for_each_set_bit().

...

> +		ret = pcim_add_mapping_to_legacy_table(pdev, mapping, bar);
> +		if (ret != 0)

		if (ret)

> +			goto err;
> +	}

...

> + err:

Better to name it like

err_unmap_and_remove:

> +	while (--bar >= 0) {

	while (bar--)

is easier to read.

> +		pcim_iounmap_region(pdev, bar);
> +		pcim_remove_bar_from_legacy_table(pdev, bar);
> +	}

...

> +/**
> + * pcim_request_all_regions - Request all regions
> + * @pdev: PCI device to map IO resources for
> + * @name: name associated with the request
> + *
> + * Requested regions will automatically be released at driver detach. If desired,
> + * release individual regions with pcim_release_region() or all of them at once
> + * with pcim_release_all_regions().
> + */

Validate kernel-doc.

...

> +		ret = pcim_request_region(pdev, bar, name);
> +		if (ret != 0)

		if (ret)

> +			goto err;


...

> +	short bar;

Why signed?

> +	int ret = -1;

Oy vei!

...

> +	ret = pcim_request_all_regions(pdev, name);
> +	if (ret != 0)

Here and in plenty other places

	if (ret)

> +		return ret;

> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> +		if (!mask_contains_bar(mask, bar))
> +			continue;

NIH for_each_set_bit()

> +		if (!pcim_iomap(pdev, bar, 0))
> +			goto err;
> +	}

...

> +	if (!legacy_iomap_table)

What's wrong with positive check?

> +		ret = -ENOMEM;
> +	else
> +		ret = -EINVAL;

Can be even one liner


What's wrong with positive check?

		ret = legacy_iomap_table ? -EINVAL : -ENOMEM;

...

> +	while (--bar >= 0)

	while (bar--)

> +		pcim_iounmap(pdev, legacy_iomap_table[bar]);

...

> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> +		if (!mask_contains_bar(mask, bar))
>  			continue;

NIH for_each_set_bit()

> -		pcim_iounmap(pdev, iomap[i]);
> -		pci_release_region(pdev, i);
> +		pcim_iounmap_region(pdev, bar);
> +		pcim_remove_bar_from_legacy_table(pdev, bar);
>  	}

-- 
With Best Regards,
Andy Shevchenko



