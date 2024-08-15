Return-Path: <linux-pci+bounces-11696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D01953627
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 16:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CFD1C25336
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A172B3214;
	Thu, 15 Aug 2024 14:49:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CE31AC8B7
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733354; cv=none; b=ruWww8yS8X06F7HEg1BCR+x+dKsuo1gfKF9HlNGmeyhlfFtE75sa7cSwy1itTw+PBJBZH2wYp56Q11mgj7Jj51kZH2nC3S+QZfKbyGJh+blB62Wq7Y0GjskJ7gsjlRu3j1wF1JpjUhD8HVXrL+lR7F5P/lRGbHg/TJGafj1sF9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733354; c=relaxed/simple;
	bh=Zu9P5riTXSE9aPJQ7IneRmBIQMxsR2Awdaf43TsJtBQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9PEXkDRCiJLdW/LmQvu36JqkRy9eTRjgEgeG98nOGk3ubfqMti7/jiakvaIEb1DyYY5aqV1Gq+Nw7AFjL90E13h1JUOMuzf08Xrm4GLBdNzk2Ih/ndFjKfsNYyNL6w+wA9eboUSimGb6UFoquO2j15nD9A5zboo263Bgymelvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wl7Gq6xhSz6K9BF;
	Thu, 15 Aug 2024 22:46:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A3B81140119;
	Thu, 15 Aug 2024 22:49:08 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 15 Aug
 2024 15:49:08 +0100
Date: Thu, 15 Aug 2024 15:49:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Keith Busch <kbusch@meta.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>,
	<mika.westerberg@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RFC 6/8] pci: add helpers for stop and remove bus
Message-ID: <20240815154906.00006586@Huawei.com>
In-Reply-To: <20240722151936.1452299-7-kbusch@meta.com>
References: <20240722151936.1452299-1-kbusch@meta.com>
	<20240722151936.1452299-7-kbusch@meta.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 22 Jul 2024 08:19:34 -0700
Keith Busch <kbusch@meta.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> There are repeated patterns of tearing down pci buses, so combine to
> helper functions and use these.
There are some subtle changes in ordering in here. I'm not
immediately convinced by all of them.

Perhaps this should be broken down further so we get the direct
code replacements that are easy to review, the movement of calls
to different functions (e.g. addition of pci_clear_bus() in 
pci_remove_bus() and dropping that call, or the code that it matches
in two other places).


> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/remove.c | 46 +++++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 8284ab20949c9..288162a11ab19 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -4,6 +4,9 @@
>  #include <linux/of_platform.h>
>  #include "pci.h"
>  
> +static void pci_stop_bus(struct pci_bus *bus);
> +static void pci_remove_bus_device(struct pci_dev *dev);
> +
>  static void pci_free_resources(struct pci_dev *dev)
>  {
>  	struct resource *res;
> @@ -45,8 +48,17 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  	put_device(&dev->dev);
>  }
>  
> +static void pci_clear_bus(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev, *next;
> +
> +	list_for_each_entry_safe(dev, next, &bus->devices, bus_list)
> +		pci_remove_bus_device(dev);
> +}
> +
>  void pci_remove_bus(struct pci_bus *bus)
>  {
> +	pci_clear_bus(bus);
So this is replacing the list_for_each_entry_safe block that
was previously in pci_remove_root_bus / pci_remove_bus_device but there
are other callers of this function such as in xen-pcifront.c which
are going to see this change.

>  	pci_proc_detach_bus(bus);
>  
>  	down_write(&pci_bus_sem);
> @@ -66,7 +78,15 @@ EXPORT_SYMBOL(pci_remove_bus);

>  
>  static void pci_remove_bus_device(struct pci_dev *dev)
>  {
>  	struct pci_bus *bus = dev->subordinate;
> -	struct pci_dev *child, *tmp;
>  
>  	if (bus) {
> -		list_for_each_entry_safe(child, tmp,
> -					 &bus->devices, bus_list)
> -			pci_remove_bus_device(child);
> -
>  		pci_remove_bus(bus);
>  		dev->subordinate = NULL;
>  	}
> -
Grumpy reviewer hat.  Unrelated change.

>  	pci_destroy_dev(dev);
>  }
>  
> @@ -129,16 +138,13 @@ EXPORT_SYMBOL_GPL(pci_stop_and_remove_bus_device_locked);
>  
>  void pci_stop_root_bus(struct pci_bus *bus)
>  {
> -	struct pci_dev *child, *tmp;
>  	struct pci_host_bridge *host_bridge;
>  
>  	if (!pci_is_root_bus(bus))
>  		return;
>  
>  	host_bridge = to_pci_host_bridge(bus->bridge);
> -	list_for_each_entry_safe_reverse(child, tmp,
> -					 &bus->devices, bus_list)
> -		pci_stop_bus_device(child);
> +	pci_stop_bus(bus);
>  
>  	/* stop the host bridge */
>  	device_release_driver(&host_bridge->dev);
> @@ -147,16 +153,12 @@ EXPORT_SYMBOL_GPL(pci_stop_root_bus);
>  
>  void pci_remove_root_bus(struct pci_bus *bus)
>  {
> -	struct pci_dev *child, *tmp;
>  	struct pci_host_bridge *host_bridge;
>  
>  	if (!pci_is_root_bus(bus))
>  		return;
>  
>  	host_bridge = to_pci_host_bridge(bus->bridge);
> -	list_for_each_entry_safe(child, tmp,
> -				 &bus->devices, bus_list)
> -		pci_remove_bus_device(child);
>  
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
>  	/* Release domain_nr if it was dynamically allocated */


