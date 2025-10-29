Return-Path: <linux-pci+bounces-39653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E948C1B2AA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 15:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135601C246C4
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 14:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91288321F54;
	Wed, 29 Oct 2025 14:00:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2513314D4
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746410; cv=none; b=ZCn488pvP1Dp7CVQE6ipD+togAlHyIt6UL9aXt8Skgi1RwoBtd2nb9pnCpZQjDpk9ulLiXr2076ItaKjexhlQSjBLyt9kAOAoZthRiGdMJUpmxYe1T06I/26V6pSR91FVPRmgkPue65qohkUEaNHsmmK29FZg2eMp4X/nf7qnTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746410; c=relaxed/simple;
	bh=n78vuiFB36alAdum1oEPD8c15C51uU5Ec+YjMOpB55A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jy5yIBbP9t9S0RBvIQzbyd3mU0ghwbFsg7vLS0Xk134LRWyGcOWSmqCybgN+/fvL0JPqODn5yyBujbgVanuBaTWjyeGd6tT8WRM9K9aHvgBg9Am2Jpk8ZXfVQ6oT11iVkETbgwLRGriUhYvyGPrCpHNvErGnLB/ozyvaOLrkvRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cxTNV13sWz67D7n;
	Wed, 29 Oct 2025 21:58:18 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CF4D1402ED;
	Wed, 29 Oct 2025 22:00:04 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 14:00:03 +0000
Date: Wed, 29 Oct 2025 14:00:02 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <aik@amd.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <bhelgaas@google.com>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 3/9] PCI: Introduce pci_walk_bus_reverse(),
 for_each_pci_dev_reverse()
Message-ID: <20251029140002.0000596f@huawei.com>
In-Reply-To: <20251024020418.1366664-4-dan.j.williams@intel.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
	<20251024020418.1366664-4-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 23 Oct 2025 19:04:12 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> PCI/TSM, the PCI core functionality for the PCIe TEE Device Interface
> Security Protocol (TDISP), has a need to walk all subordinate functions of
> a Device Security Manager (DSM) to setup a device security context. A DSM
> is physical function 0 of multi-function or SR-IOV device endpoint, or it
> is an upstream switch port.
> 
> In error scenarios or when a TEE Security Manager (TSM) device is removed
> it needs to unwind all established DSM contexts.
> 
> Introduce reverse versions of PCI device iteration helpers to mirror the
> setup path and ensure that dependent children are handled before parents.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Bit of archaeology was needed as there are some existing oddities in the
functions this is based on.

My suggestions for this are don't use guard() and drop the void * cast that
we should cleanup in the existing code.

> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index f26aec6ff588..1c981ca72b03 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -8,6 +8,7 @@
>   */
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> +#include <linux/cleanup.h>
>  #include <linux/pci.h>
>  #include <linux/errno.h>
>  #include <linux/ioport.h>
> @@ -432,6 +433,27 @@ static int __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void
>  	return ret;
>  }
>  
> +static int __pci_walk_bus_reverse(struct pci_bus *top,
> +				  int (*cb)(struct pci_dev *, void *),
> +				  void *userdata)
> +{
> +	struct pci_dev *dev;
> +	int ret = 0;
> +
> +	list_for_each_entry_reverse(dev, &top->devices, bus_list) {
> +		if (dev->subordinate) {
> +			ret = __pci_walk_bus_reverse(dev->subordinate, cb,
> +						     userdata);
> +			if (ret)
> +				break;
> +		}
> +		ret = cb(dev, userdata);
> +		if (ret)
> +			break;
> +	}
> +	return ret;

I see this is local style so fair enough, but I'd have gone with early
returns as it's a simple case of return ret if it is ever set.

> +}

> +/**
> + * pci_walk_bus_reverse - walk devices on/under bus, calling callback.
> + * @top: bus whose devices should be walked
> + * @cb: callback to be called for each device found
> + * @userdata: arbitrary pointer to be passed to callback
> + *
> + * Same semantics as pci_walk_bus(), but walks the bus in reverse order.
> + */
> +void pci_walk_bus_reverse(struct pci_bus *top,
> +			  int (*cb)(struct pci_dev *, void *), void *userdata)
> +{
> +	guard(rwsem_read)(&pci_bus_sem);

So this ends up different to pci_walk_bus.  I'd be tempted to just
not bother bringing a single guard() usage here. Gain is trivial and
mixing and matching style in a file isn't particularly nice.

I'd not mind changing pci_walk_bus() as well but that would need
to be a trivial precursor patch I think.

> +	__pci_walk_bus_reverse(top, cb, userdata);
> +}
> +EXPORT_SYMBOL_GPL(pci_walk_bus_reverse);
> +

> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index 53840634fbfc..e6e84dc62e82 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -282,6 +282,45 @@ static struct pci_dev *pci_get_dev_by_id(const struct pci_device_id *id,
>  	return pdev;
>  }
>  
> +static struct pci_dev *pci_get_dev_by_id_reverse(const struct pci_device_id *id,
> +						 struct pci_dev *from)
> +{
> +	struct device *dev;
> +	struct device *dev_start = NULL;
> +	struct pci_dev *pdev = NULL;
> +
> +	if (from)
> +		dev_start = &from->dev;
> +	dev = bus_find_device_reverse(&pci_bus_type, dev_start, (void *)id,

That (void *) is casting away a const but bus_find_device_reverse takes
a const void *.
I think you are fine just relying on implicit cast for that parameter.

Not that important and pci_get_device_by_id() does have same odd casting.
Looks like way back bus_find_device() didn't take a const pointer 

Seems to be true in 3.19 (random choice jumping back through time on elixir)
but not sure when it changed.

Anyhow, would be nice to clean that up in existing code if anyone is bored
enough.

> +				      match_pci_dev_by_id);
> +	if (dev)
> +		pdev = to_pci_dev(dev);
> +	pci_dev_put(from);
> +	return pdev;
> +}



