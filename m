Return-Path: <linux-pci+bounces-33112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDE3B14E12
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 15:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5EC544A89
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 13:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB201624F7;
	Tue, 29 Jul 2025 13:06:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFC11442F4;
	Tue, 29 Jul 2025 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794392; cv=none; b=ERzZOio6jQ2bM+tef+n8alb9iIqY2mxkbyvwpQs7tlJ/QOWJ3Km7SaO72vh3POecsMwrGGyvNcDt4KfRZfLDc7jhDPK9FuCOcmPWcpbJJMy9vZL2FPCn7sX+CV5peqfBxlCbf5xoKW4quiNfdOA63gIO75g02NfkZAGb5/xxFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794392; c=relaxed/simple;
	bh=R5Ti7hVlly6Z9J0Chutm2pgVzpn7+W7qVHeQ0bar/O0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bz/IbcAgdMbwLBL1EA2hfOlmJ0+XTq8dvBCplt7e9K2ylfZVOcETSV/Kd8xty0Xndu6yYd9VI1Rv7y5yNeJAZGSnmsbue144dACslKnRi8xHw+9mBcWZCOrOPKVTaUK8WUUIJ7FtsGOK6iwgV2YjLYmExmYzHIkuA9RvcLP2HSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4brwVJ0Jlcz6J9lt;
	Tue, 29 Jul 2025 21:02:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 205671400E3;
	Tue, 29 Jul 2025 21:06:26 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Jul
 2025 15:06:25 +0200
Date: Tue, 29 Jul 2025 14:06:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v4 03/10] PCI: Introduce pci_walk_bus_reverse(),
 for_each_pci_dev_reverse()
Message-ID: <20250729140623.000068a8@huawei.com>
In-Reply-To: <20250717183358.1332417-4-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
	<20250717183358.1332417-4-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Jul 2025 11:33:51 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> PCI/TSM, the PCI core functionality for the PCIe TEE Device Interface
> Security Protocol (TDISP), has a need to walk all subordinate functions of
> a Device Security Manager (DSM) to setup a device security context. A DSM
> is physical function 0 of multi-function or SRIOV device endpoint, or it is
> an upstream switch port.
> 
> In error scenarios or when a TEE Security Manager (TSM) device is removed
> it needs to unwind all established DSM contexts.
> 
> Introduce reverse versions of PCI device iteration helpers to mirror the
> setup path and ensure that dependent children are handled before parents.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

A couple of trivial comments.

Probably want to +CC Greg KH on next version given bits in drivers/base

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 69048869ef1c..d894c87ce1fd 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c

include cleanup.h perhaps for access to guard()?


> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index 53840634fbfc..7a4623f65256 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -282,6 +282,46 @@ static struct pci_dev *pci_get_dev_by_id(const struct pci_device_id *id,
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
> +				      match_pci_dev_by_id);
> +	if (dev)
> +		pdev = to_pci_dev(dev);
> +	pci_dev_put(from);
> +	return pdev;
> +}
> +
> +enum pci_search_direction {
> +	PCI_SEARCH_FORWARD,
> +	PCI_SEARCH_REVERSE,
> +};
> +

I don't really care, but given there are only two sane directions maybe
a bool reverse as a parameter to __pci_get_subsys() would be sufficient? 

> +static struct pci_dev *__pci_get_subsys(unsigned int vendor, unsigned int device,
> +				 unsigned int ss_vendor, unsigned int ss_device,
> +				 struct pci_dev *from, enum pci_search_direction dir)
> +{
> +	struct pci_device_id id = {
> +		.vendor = vendor,
> +		.device = device,
> +		.subvendor = ss_vendor,
> +		.subdevice = ss_device,
> +	};
> +
> +	if (dir == PCI_SEARCH_FORWARD)
> +		return pci_get_dev_by_id(&id, from);
> +	else
> +		return pci_get_dev_by_id_reverse(&id, from);
> +}
> +
This file seems to use 1 blank line only between functions.
> +
>  /**
>   * pci_get_subsys - begin or continue searching for a PCI device by vendor/subvendor/device/subdevice id
>   * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
> @@ -302,14 +342,8 @@ struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
>  			       unsigned int ss_vendor, unsigned int ss_device,
>  			       struct pci_dev *from)
>  {
> -	struct pci_device_id id = {
> -		.vendor = vendor,
> -		.device = device,
> -		.subvendor = ss_vendor,
> -		.subdevice = ss_device,
> -	};
> -
> -	return pci_get_dev_by_id(&id, from);
> +	return __pci_get_subsys(vendor, device, ss_vendor, ss_device, from,
> +				PCI_SEARCH_FORWARD);
>  }
>  EXPORT_SYMBOL(pci_get_subsys);
>  
> @@ -334,6 +368,19 @@ struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
>  }
>  EXPORT_SYMBOL(pci_get_device);
>  
> +/*
> + * Same semantics as pci_get_device(), except walks the PCI device list
> + * in reverse discovery order.
> + */
> +struct pci_dev *pci_get_device_reverse(unsigned int vendor,
> +				       unsigned int device,
> +				       struct pci_dev *from)
> +{
> +	return __pci_get_subsys(vendor, device, PCI_ANY_ID, PCI_ANY_ID, from,
> +				PCI_SEARCH_REVERSE);
> +}
> +EXPORT_SYMBOL(pci_get_device_reverse);
> +
>  /**
>   * pci_get_class - begin or continue searching for a PCI device by class
>   * @class: search for a PCI device with this class designation
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index f5a56efd2bd6..99b1002b3e31 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -150,6 +150,9 @@ int bus_for_each_dev(const struct bus_type *bus, struct device *start,
>  		     void *data, device_iter_t fn);
>  struct device *bus_find_device(const struct bus_type *bus, struct device *start,
>  			       const void *data, device_match_t match);
> +struct device *bus_find_device_reverse(const struct bus_type *bus,
> +				       struct device *start, const void *data,
> +				       device_match_t match);
>  /**
>   * bus_find_device_by_name - device iterator for locating a particular device
>   * of a specific name.
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3fac811376b5..b8bca0711967 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -575,6 +575,8 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
>  
>  #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
>  #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
> +#define for_each_pci_dev_reverse(d) \
> +	while ((d = pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
>  
>  static inline int pci_channel_offline(struct pci_dev *pdev)
>  {
> @@ -1220,6 +1222,8 @@ u64 pci_get_dsn(struct pci_dev *dev);
>  
>  struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
>  			       struct pci_dev *from);
> +struct pci_dev *pci_get_device_reverse(unsigned int vendor, unsigned int device,
> +				       struct pci_dev *from);
>  struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
>  			       unsigned int ss_vendor, unsigned int ss_device,
>  			       struct pci_dev *from);
> @@ -1639,6 +1643,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
>  
>  void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>  		  void *userdata);
> +void pci_walk_bus_reverse(struct pci_bus *top,
> +			  int (*cb)(struct pci_dev *, void *), void *userdata);
>  int pci_cfg_space_size(struct pci_dev *dev);
>  unsigned char pci_bus_max_busnr(struct pci_bus *bus);
>  resource_size_t pcibios_window_alignment(struct pci_bus *bus,
> @@ -2031,6 +2037,11 @@ static inline struct pci_dev *pci_get_device(unsigned int vendor,
>  					     struct pci_dev *from)
>  { return NULL; }
>  
> +static inline struct pci_dev *pci_get_device_reverse(unsigned int vendor,
> +						     unsigned int device,
> +						     struct pci_dev *from)
> +{ return NULL; }
> +
>  static inline struct pci_dev *pci_get_subsys(unsigned int vendor,
>  					     unsigned int device,
>  					     unsigned int ss_vendor,


