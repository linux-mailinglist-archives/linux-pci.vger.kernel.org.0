Return-Path: <linux-pci+bounces-11695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E1B95351C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 16:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997801C25222
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D0A1DFFB;
	Thu, 15 Aug 2024 14:33:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC39563D5
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732439; cv=none; b=GJkWzsW+Chz0rKr2vPjS7S1dPXbR85QeUgEvfnuTBt79WKq0BLQ72sFgxyWTI9mKzNFWhWm0b8LUwrpZcTQXMhtrzqtE9gNIl5J7pe3aX8tCcWCUmCLCsONKg0EyEqgCxVUJW1EEKQl6949kAx3Kpo5XQq5orHXS1yzPkLGETr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732439; c=relaxed/simple;
	bh=/9gJ04uCiwPbqZpssq46mFQUdbnj1ijZoFIC+Ny0uTQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lS+3l9Blq9WIBnpqhQL6T7oQ5IP+UOAZrFl8oA4637CU0DvqnH81ZfAoKkD7ekmB/6OvM8Z3f4Rk8P2J1jEpXb4TJ2n9zTblwVS1VwJ+2LW0D7fC7QyT4MrBx8Z4O9btxrzvzGjtnCLnjGlqSTTT/IRrOz/4DiSl5e74F9QIjPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wl6wp2vz8z6FGsg;
	Thu, 15 Aug 2024 22:30:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E152A140119;
	Thu, 15 Aug 2024 22:33:53 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 15 Aug
 2024 15:33:53 +0100
Date: Thu, 15 Aug 2024 15:33:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Keith Busch <kbusch@meta.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>,
	<mika.westerberg@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RFC 4/8] pci: walk bus recursively
Message-ID: <20240815153352.0000364c@Huawei.com>
In-Reply-To: <20240722151936.1452299-5-kbusch@meta.com>
References: <20240722151936.1452299-1-kbusch@meta.com>
	<20240722151936.1452299-5-kbusch@meta.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 22 Jul 2024 08:19:32 -0700
Keith Busch <kbusch@meta.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> The original implementation purposefully chose a non-recursive walk,
> presumably as a precaution on stack use. We do recursive bus walking in
> other places though. For example:
> 
>   pci_bus_resettable
>   pci_stop_bus_device
>   pci_remove_bus_device
>   pci_bus_allocate_dev_resources
> 
> So, recursive pci bus walking is well tested and safe, and the
> implementation is easier to follow. The motivation for changing it now
> is to make it easier to introduce finer grain locking in the future.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
Trivial naming question inline. Otherwise LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/bus.c | 34 ++++++++++------------------------
>  1 file changed, 10 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 7c07a141e8772..b7208e644c79f 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -389,37 +389,23 @@ void pci_bus_add_devices(const struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pci_bus_add_devices);
>  
> -static void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
> +static int __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
Keeping the parameter name of 'top' seems less than intuitive
now this is recursive as on the recursions it is no longer the top.
Maybe just call it bus?  That will make this diff really confusing however.

>  			   void *userdata)
>  {
>  	struct pci_dev *dev;
> -	struct pci_bus *bus;
> -	struct list_head *next;
> -	int retval;
> +	int ret = 0;
>  
> -	bus = top;
> -	next = top->devices.next;
> -	for (;;) {
> -		if (next == &bus->devices) {
> -			/* end of this bus, go up or finish */
> -			if (bus == top)
> +	list_for_each_entry(dev, &top->devices, bus_list) {
> +		ret = cb(dev, userdata);
> +		if (ret)
> +			break;
> +		if (dev->subordinate) {
> +			ret = __pci_walk_bus(dev->subordinate, cb, userdata);
> +			if (ret)
>  				break;
> -			next = bus->self->bus_list.next;
> -			bus = bus->self->bus;
> -			continue;
>  		}
> -		dev = list_entry(next, struct pci_dev, bus_list);
> -		if (dev->subordinate) {
> -			/* this is a pci-pci bridge, do its devices next */
> -			next = dev->subordinate->devices.next;
> -			bus = dev->subordinate;
> -		} else
> -			next = dev->bus_list.next;
> -
> -		retval = cb(dev, userdata);
> -		if (retval)
> -			break;
>  	}
> +	return ret;
>  }
>  
>  /**


