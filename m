Return-Path: <linux-pci+bounces-34869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F755B37A36
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 08:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB39D1B661CC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 06:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B727930BB96;
	Wed, 27 Aug 2025 06:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I5nuQvlW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2C30497A;
	Wed, 27 Aug 2025 06:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756275285; cv=none; b=KUEZiSo4kP9fhXOmaEw79G2j8xZ2PSFGHxIJ1228FiM2WyelQ7NmfFqYqkdbI2FrVDnqDA6daMpISj+/KvZlPwKlsl6m3zBoBmojzgN3YJxQShDLVHDOPzHd6ic8yNV1KrxlvekZtR68bCc+6olR5vVRFqvrVpQrAfG3obsGUQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756275285; c=relaxed/simple;
	bh=6d8HFXRBXSEpXSDXb2MxjyqwrI8R+nAqsKFEvmj6q5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdcRt26zuqkRA6OsIVEYqU1jhysDkZYWG/9JVgyOu6fZchfpXDX+PE81zYuxHargWeRFyh/0BNBLWir90npiIKCscC2oNdcCIo8d0K+OW8CvNpiUDJ9AibDpi8Ncc0VzX7i2h5yFKtzeo3RXD9PKvAkew07BS58qjHWzZ7vK9y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I5nuQvlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82698C4CEEB;
	Wed, 27 Aug 2025 06:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756275285;
	bh=6d8HFXRBXSEpXSDXb2MxjyqwrI8R+nAqsKFEvmj6q5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I5nuQvlWPAP5lQde/OpfNn4j017r+iO/EGT6JTBFoXGIiaxTFIm5ald0UT/cf3ksp
	 loD0E+dbO5OKrYUvp7gENha9LgUWFq/SczesDNT+zF2xwVYbXLxANngoMThQK0123S
	 bJ6oSOw/v071o3ashfeyH9lG/ZC5gJ1tArMCe4qg=
Date: Wed, 27 Aug 2025 08:14:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	bhelgaas@google.com, yilun.xu@linux.intel.com,
	aneesh.kumar@kernel.org, aik@amd.com,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 3/7] device core: Introduce confidential device acceptance
Message-ID: <2025082717-fresh-catty-3394@gregkh>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-4-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827035259.1356758-4-dan.j.williams@intel.com>

On Tue, Aug 26, 2025 at 08:52:55PM -0700, Dan Williams wrote:
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -98,6 +98,8 @@ struct driver_private {
>   *	the device; typically because it depends on another driver getting
>   *	probed first.
>   * @async_driver - pointer to device driver awaiting probe via async_probe
> + * @cc_accepted - track the TEE acceptance state of the device for deferred
> + *	probing, MMIO mapping type, and SWIOTLB bypass for private memory DMA.
>   * @device - pointer back to the struct device that this structure is
>   * associated with.
>   * @dead - This device is currently either in the process of or has been
> @@ -115,6 +117,9 @@ struct device_private {
>  	struct list_head deferred_probe;
>  	const struct device_driver *async_driver;
>  	char *deferred_probe_reason;
> +#ifdef CONFIG_CONFIDENTIAL_DEVICES
> +	bool cc_accepted;
> +#endif
>  	struct device *device;
>  	u8 dead:1;

Why did you not just use another u8:1 at the end?  You kind of added a
big hole in the structure that is created for every device :(


>  };
> diff --git a/drivers/base/coco.c b/drivers/base/coco.c
> new file mode 100644
> index 000000000000..97c22d0e9247
> --- /dev/null
> +++ b/drivers/base/coco.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0

No copyright at the top?  Bold :)

> +#include <linux/device.h>
> +#include <linux/dev_printk.h>
> +#include <linux/lockdep.h>
> +#include "base.h"
> +
> +/*
> + * Confidential devices implement encrypted + integrity protected MMIO and have
> + * the ability to issue DMA to encrypted + integrity protected System RAM. The
> + * device_cc_*() helpers aid buses in setting the acceptance state, drivers in
> + * preparing and probing the acceptance state, and other kernel subsystem in
> + * augmenting behavior in the presence of accepted devices (e.g.
> + * ioremap_encrypted()).
> + */
> +
> +/**
> + * device_cc_accept(): Mark a device as accepted for TEE operation

What does TEE mean here?  I feel you mix "confidential" and TEE a bunch.

> + * @dev: device to accept
> + *
> + * Confidential bus drivers use this helper to accept devices at initial
> + * enumeration, or dynamically one attestation has been performed.
> + *
> + * Given that moving a device into confidential / private operation implicates
> + * any of MMIO mapping attributes, physical address, and IOMMU mappings this
> + * transition must be done while the device is idle (driver detached).
> + *
> + * This is an internal helper for buses not device drivers.
> + */
> +int device_cc_accept(struct device *dev)
> +{
> +	lockdep_assert_held(&dev->mutex);
> +
> +	if (dev->driver)
> +		return -EBUSY;
> +	dev->p->cc_accepted = true;
> +
> +	return 0;
> +}
> +
> +int device_cc_reject(struct device *dev)
> +{
> +	lockdep_assert_held(&dev->mutex);
> +
> +	if (dev->driver)
> +		return -EBUSY;
> +	dev->p->cc_accepted = false;
> +
> +	return 0;
> +}
> +
> +/**
> + * device_cc_accepted(): Get the TEE operational state of a device
> + * @dev: device to check
> + *
> + * Various subsystems, mm/ioremap, drivers/iommu, drivers/vfio, kernel/dma...
> + * need to augment their behavior in the presence of confidential devices. This
> + * simple, deliberately not exported, helper is for those built-in consumers.
> + *
> + * This is an internal helper for subsystems not device drivers.
> + */
> +bool device_cc_accepted(struct device *dev)
> +{
> +	return dev->p->cc_accepted;
> +}
> +
> +/**
> + * device_cc_probe(): Coordinate dynamic acceptance with a device driver
> + * @dev: device to defer probing while acceptance pending
> + *
> + * Dynamically accepted devices may need a driver to perform initial
> + * configuration to get the device into a state where it can be accepted. Use
> + * this helper to exit driver probe at that partial device-init point and log
> + * this TEE acceptance specific deferral reason.
> + *
> + * This is an exported helper for device drivers that need to coordinate device
> + * configuration state and acceptance.
> + */
> +int device_cc_probe(struct device *dev)
> +{
> +	/*
> +	 * See work_on_cpu() in local_pci_probe() for one reason why
> +	 * lockdep_assert_held() can not be used here.
> +	 */
> +	WARN_ON_ONCE(!mutex_is_locked(&dev->mutex));

If not locked you just keep going?  Why not return an error?

thanks,

greg k-h

