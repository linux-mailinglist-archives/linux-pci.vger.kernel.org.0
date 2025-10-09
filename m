Return-Path: <linux-pci+bounces-37759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5FDBC936E
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 15:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848A93E2C6A
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 13:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8262E6CDA;
	Thu,  9 Oct 2025 13:13:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6C2E6CDF;
	Thu,  9 Oct 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015593; cv=none; b=Y2Jig4I3h/kn8UfArqOF/4xPT04zqOEnWfcVhc9eaAJZj1gwbyySuNVMmcoG6MOzeOLjLwzWkUgF17fGkgbYxneOjcidlTbLNMQ04/fvAIoMrp/QBObjVPGZlV1Cekptxp8/tWBme2uyvGQpU1oB3kpqf+h4z3+hze38nGKY+J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015593; c=relaxed/simple;
	bh=YmMkruOsvOrrXEBYVxe7Vw4brNWzYhyqCmO7lrXeEvw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYbK1jb8wUKdVRyx1af1PCpn67y5tkaf/jBAl9hrPTtisw5v/ebi4d5mNo/OnyIsAsuzRjg+7PZ7Wvp9QtuiGPWaPX5ofPFTdQdb7PmB0d4tz0hRcnfCxGGHE8EQJFQAhYnO6dayOXwCcnLjyHzt/wqL/w9jTzq6MD4KEs7OoNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cj9Jf4T7tz6L58t;
	Thu,  9 Oct 2025 21:12:18 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FBC21402F1;
	Thu,  9 Oct 2025 21:13:01 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 9 Oct
 2025 14:13:00 +0100
Date: Thu, 9 Oct 2025 14:12:58 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Evangelos Petrongonas <epetron@amazon.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
	<alex.williamson@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, David
 Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, Chris Li
	<chrisl@kernel.org>, Jason Miu <jasonmiu@google.com>, "Pratyush Yadav"
	<pratyush@kernel.org>, Stanislav Spassov <stanspas@amazon.de>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: Re: [RFC PATCH 02/13] pci: pcsc: implement basic functionality
Message-ID: <20251009141258.00006a69@huawei.com>
In-Reply-To: <de485efebd203fc0f69aabccd45917b8360ce47a.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
	<de485efebd203fc0f69aabccd45917b8360ce47a.1759312886.git.epetron@amazon.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 3 Oct 2025 09:00:38 +0000
Evangelos Petrongonas <epetron@amazon.de> wrote:

> Implement the core functionality of the PCI Configuration Space Cache
> using per-device cache nodes attached to struct pci_dev.
> 
> Each cache node stores:
> - A 256-byte array (4KB for PCIe) representing the configuration space
> - A cacheable bitmask indicating which registers can be cached
> - A cached bitmask tracking which bytes are currently cached
> 
> The implementation attaches cache nodes directly to pci_dev structures
> during `pci_device_add()` and removes them during `pci_device_remove()`.
> 
> The cache implements a write-invalidate policy where writes are
> propagated to the device while invalidating the cache. This design
> choice improves robustness and increases the number of cacheable
> registers, particularly for operations like BAR sizing which use
> write-read sequences to detect read-only bits.
> 
> Currently, the cacheable bitmask is zero-initialized,
> effectively disabling the cache. This will be changed in the next
> commits.
> 
> This implementation only supports endpoint devices; bridges and
> root complexes are not cached.
> 
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
>  drivers/pci/pci-driver.c |   5 +
>  drivers/pci/pcsc.c       | 244 ++++++++++++++++++++++++++++++++++++++-
>  drivers/pci/probe.c      |   9 ++
>  include/linux/pci.h      |   5 +
>  include/linux/pcsc.h     |  38 ++++++
>  5 files changed, 299 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 302d61783f6c..7c0cbbd50b32 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -21,6 +21,7 @@
>  #include <linux/acpi.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/iommu.h>
> +#include <linux/pcsc.h>
>  #include "pci.h"
>  #include "pcie/portdrv.h"
>  
> @@ -497,7 +498,11 @@ static void pci_device_remove(struct device *dev)
>  	 * horrible the crap we have to deal with is when we are awake...
>  	 */
>  
> + #ifdef CONFIG_PCSC

if (IS_ENABLED()) or a stub.

> +	pcsc_remove_device(pci_dev);
> +#endif
>  	pci_dev_put(pci_dev);
> +
Clean this out.
>  }
>  
>  static void pci_device_shutdown(struct device *dev)
> diff --git a/drivers/pci/pcsc.c b/drivers/pci/pcsc.c
> index dec7c51b5cfd..7531217925e8 100644
> --- a/drivers/pci/pcsc.c
> +++ b/drivers/pci/pcsc.c
>
> +/**
> + * pcsc_get_and_insert_multiple - Read multiple bytes from PCI cache or HW
> + * @dev: PCI device to read from
> + * @bus: PCI bus to read from
> + * @devfn: device and function number

Is this always the same as dev->devfn? 

> + * @where: offset in config space
> + * @word: pointer to store read value
> + * @size: number of bytes to read (1, 2 or 4)
> + *
> + * Reads consecutive bytes from PCI cache or hardware. If values are not cached,
> + * reads from hardware and inserts into cache.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int pcsc_get_and_insert_multiple(struct pci_dev *dev,
> +					struct pci_bus *bus, unsigned int devfn,
> +					int where, u32 *word, int size)
> +{
> +	u32 word_cached = 0;
> +	u8 byte_val;
> +	int rc, i;
> +
> +	if (WARN_ON(!dev || !bus || !word))
> +		return -EINVAL;
> +
> +	if (WARN_ON(size != 1 && size != 2 && size != 4))
> +		return -EINVAL;
> +
> +	/* Check bounds */
> +	if (where + size > PCSC_CFG_SPC_SIZE)
> +		return -EINVAL;
> +
> +	if (pcsc_is_cached(dev, where, size)) {
> +		/* Read bytes from cache and assemble them into word_cached

Multiline comment syntax as below. Same for others.

> +		 * in little-endian order (as per PCI spec)
> +		 */
> +		for (i = 0; i < size; i++) {
> +			pcsc_get_byte(dev, where + i, &byte_val);
> +			word_cached |= ((u32)byte_val << (i * 8));
> +		}
> +	} else {
> +		rc = pcsc_hw_config_read(bus, devfn, where, size, &word_cached);
> +		if (rc) {
> +			pci_err(dev,
> +				"%s: Failed to read CFG Space where=%d size=%d",
> +				__func__, where, size);
> +			return rc;
> +		}
> +
> +		/* Extract bytes from word_cached in little-endian order
> +		 * and store them in cache.
> +		 */
> +		for (i = 0; i < size; i++) {
> +			byte_val = (word_cached >> (i * 8)) & 0xFF;
> +			pcsc_update_byte(dev, where + i, byte_val);
> +		}
> +	}
> +
> +	*word = word_cached;
> +	return 0;
> +}
> +
>  int pcsc_cached_config_read(struct pci_bus *bus, unsigned int devfn, int where,
>  			    int size, u32 *val)
>  {
> -	if (!pcsc_initialised)
> +	int rc;
> +	struct pci_dev *dev;
> +
> +	if (unlikely(!pcsc_is_initialised()))

As below.  Just add a stub function to patch 1 for this.

>  		goto read_from_dev;
>  
> +	if (WARN_ON(!bus || !val || (size != 1 && size != 2 && size != 4) ||
> +		    where + size > PCSC_CFG_SPC_SIZE))
> +		return -EINVAL;
> +
> +	dev = pci_get_slot(bus, devfn);
> +
> +	if (unlikely(!dev || !dev->pcsc))

I'm curious how much difference that unlikely is making.  Generally don't
use them unless you have the perf numbers to back them up.
Letting the branch predictors do their thing is usually a better plan.

> +		goto read_from_dev;
> +
> +	if (dev->pcsc->cfg_space &&
> +	    pcsc_is_access_cacheable(dev, where, size)) {
> +		rc = pcsc_get_and_insert_multiple(dev, bus, devfn, where, val,
> +						  size);
> +		if (likely(!rc)) {
> +			pci_dev_put(dev);
> +			return 0;
> +		}
> +		/* if reading from the cache failed continue and try reading

Match multiline comment syntax for PCI.
		/*
		 * If reading...

> +		 * from the actual device
> +		 */
> +	}
>  read_from_dev:
> +	if (dev)
> +		pci_dev_put(dev);
>  	return pcsc_hw_config_read(bus, devfn, where, size, val);
>  }
>  EXPORT_SYMBOL_GPL(pcsc_cached_config_read);
> @@ -117,10 +336,31 @@ EXPORT_SYMBOL_GPL(pcsc_cached_config_read);
>  int pcsc_cached_config_write(struct pci_bus *bus, unsigned int devfn, int where,
>  			     int size, u32 val)
>  {
> -	if (!pcsc_initialised)
> +	int i;
> +	struct pci_dev *dev;
> +
> +	if (unlikely(!pcsc_is_initialised()))

Make it this from the start to reduce churn.

>  		goto write_to_dev;
>  
> +	if (WARN_ON(!bus || (size != 1 && size != 2 && size != 4) ||
> +		    where + size > PCSC_CFG_SPC_SIZE))
> +		return -EINVAL;
> +
> +	dev = pci_get_slot(bus, devfn);
> +
> +	if (unlikely(!dev || !dev->pcsc || !dev->pcsc->cfg_space)) {
> +		/* Do not add nodes on arbitrary writes  */
> +		goto write_to_dev;
> +	} else {

Can drop the else given the goto above.

> +		/* Mark the cache as dirty */
> +		if (pcsc_is_access_cacheable(dev, where, size)) {
> +			for (i = 0; i < size; i++)
> +				pcsc_set_cached(dev, where + i, false);
> +		}
> +	}
>  write_to_dev:
> +	if (dev)
> +		pci_dev_put(dev);
>  	return pcsc_hw_config_write(bus, devfn, where, size, val);
>  }
>  EXPORT_SYMBOL_GPL(pcsc_cached_config_write);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 33a186e4bf1e..c231e09e5a6e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -23,6 +23,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/bitfield.h>
> +#include <linux/pcsc.h>
>  #include "pci.h"
>  
>  #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
> @@ -2801,6 +2802,14 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  
>  	dev->state_saved = false;
>  
> +#ifdef CONFIG_PCSC

Similar request for if (IS_ENABLED()) etc.

> +	if (likely(pcsc_is_initialised()))
> +		if (!dev->pcsc)
> +			if (pcsc_add_device(dev))

Maybe combine some of that if stack.

> +				pci_warn(dev,
> +					 "Failed to add PCI device to PCSC\n");
> +#endif
> +
>  	pci_init_capabilities(dev);
>  
>  	/*

>  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> diff --git a/include/linux/pcsc.h b/include/linux/pcsc.h
> index 45816eb2b2c8..516d73931608 100644
> --- a/include/linux/pcsc.h
> +++ b/include/linux/pcsc.h

> +/**
> + * @brief Returns if the PCSC infrastructure is initialised
> + *

Run the kernel-doc script over these files it gets fussy about
partial documentation etc. I'm fairly sure this will trip it up.

> + */
> +bool pcsc_is_initialised(void);
> +
>  #endif /* _LINUX_PCSC_H */


