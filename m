Return-Path: <linux-pci+bounces-11698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5569536B5
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 17:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44081C20AE9
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541131A76B5;
	Thu, 15 Aug 2024 15:10:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9EE19DF9C
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734619; cv=none; b=j0IrYeG8r50vTNUv1C19zPTSt190jDqCY/6BY9uRgJ8dp6mqTt4eBGx/xk8BTf13mWzUkr7cq5MuczZD1Nf6AqSoTPjrOQSUDJOUsHprR6qg7fPOaIY8u5ZGpdoOltyvSqDNZvY6vBV/cfilTtv7vLo5esgL5CYAQkuk+W84PAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734619; c=relaxed/simple;
	bh=6ifo5LP10q7T/H21+S/PzrstiCBDWkBlcRZ2ye6+2Tc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWn9H+AVs7WG7XFrzMTzGUHyioSuEpP3RxlOOV1Lwe6v4Mc7O4uhVTiVqMxEskw/lxcEd5daVgOcQowbNOctTYjAxjGva1mGwK3ExKljBoKXuyPgfGkp2vwVccZHzLBzFGa6dG5mH1/cRW4a/vd6UDlFAOOSBMEkHbM8Bs/yJnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wl7lR4kScz6K9BD;
	Thu, 15 Aug 2024 23:07:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EC738140119;
	Thu, 15 Aug 2024 23:10:12 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 15 Aug
 2024 16:10:12 +0100
Date: Thu, 15 Aug 2024 16:10:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Keith Busch <kbusch@meta.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>,
	<mika.westerberg@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RFC 7/8] pci: reference count subordinate
Message-ID: <20240815161011.00001baa@Huawei.com>
In-Reply-To: <20240722151936.1452299-8-kbusch@meta.com>
References: <20240722151936.1452299-1-kbusch@meta.com>
	<20240722151936.1452299-8-kbusch@meta.com>
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

On Mon, 22 Jul 2024 08:19:35 -0700
Keith Busch <kbusch@meta.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> The subordinate is accessed under the pci_bus_sem (or often times no
> lock at at all), but unset under the rescan_remove_lock. Access the
> subordinate buses with reference counts to guard against a concurrent
> removal and use-after-free.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---

Hi Keith,

A few comments inline.

Jonathan



> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e3a49f66982d5..0cd36b7772c8b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3113,9 +3113,14 @@ void pci_bridge_d3_update(struct pci_dev *dev)
>  	 * so we need to go through all children to find out if one of them
>  	 * continues to block D3.
>  	 */
> -	if (d3cold_ok && !bridge->bridge_d3)
> -		pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
> -			     &d3cold_ok);
> +	if (d3cold_ok && !bridge->bridge_d3) {
> +		struct pci_bus *bus = pci_dev_get_subordinate(bridge);
> +
> +		if (bus) {
> +			pci_walk_bus(bus, pci_dev_check_d3cold, &d3cold_ok);
> +			pci_bus_put(bus);
I'd be tempted to call pci_bus_put(bus) unconditionally but doesn't matter
a lot.
> +		}
> +	}
>  
>  	if (bridge->bridge_d3 != d3cold_ok) {
>  		bridge->bridge_d3 = d3cold_ok;
> @@ -4824,6 +4829,7 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
>  int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  {
>  	struct pci_dev *child __free(pci_dev_put) = NULL;

I would moan about constructors and desctructors together, but unrelated
to this patch and would actually break the change I suggest below given
the lifetime of child is longer than the loop where it's gotten.
So I won't moan about it :)

> +	struct pci_bus *bus;
>  	int delay;
>  
>  	if (pci_dev_is_disconnected(dev))
> @@ -4840,7 +4846,17 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  	 * board_added(). In case of ACPI hotplug the firmware is expected
>  	 * to configure the devices before OS is notified.
>  	 */
> -	if (!dev->subordinate || list_empty(&dev->subordinate->devices)) {
> +	bus = pci_dev_get_subordinate(dev);
> +	if (!bus) {
> +		up_read(&pci_bus_sem);
> +		return 0;
> +	}
> +
> +	child = pci_dev_get(list_first_entry_or_null(&bus->devices,
> +						     struct pci_dev,
> +						     bus_list));
> +	if (!child) {
> +		pci_bus_put(bus);
>  		up_read(&pci_bus_sem);
>  		return 0;
>  	}
> @@ -4848,12 +4864,12 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  	/* Take d3cold_delay requirements into account */
>  	delay = pci_bus_max_d3cold_delay(dev->subordinate);
>  	if (!delay) {
> +		pci_bus_put(bus);
>  		up_read(&pci_bus_sem);
>  		return 0;
>  	}
>  
> -	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
> -					     struct pci_dev, bus_list));
> +	pci_bus_put(bus);
>  	up_read(&pci_bus_sem);

I'd like scoped_guard() {
	struct pci_bus *bus __free(pci_bus_put) = pci_dev_get_sub...
	here so that the manual cleanup can be avoided in the early return paths.

}
}
>  
>  	/*

...

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index cee2365e54b8b..3c0c83d35ab86 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1212,9 +1212,11 @@ static void pcie_update_aspm_capable(struct pcie_link_state *root)
>  		link->aspm_capable = link->aspm_support;
>  	}
>  	list_for_each_entry(link, &link_list, sibling) {
> +		struct pci_bus *linkbus;
>  		struct pci_dev *child;
> -		struct pci_bus *linkbus = link->pdev->subordinate;
> -		if (link->root != root)
> +
> +		linkbus = pci_dev_get_subordinate(link->pdev);
Maybe worth a 
DEFINE_FREE() for pci_bus_put to match the one for pci_dev_put?

> +		if (!linkbus || link->root != root)
>  			continue;
>  		list_for_each_entry(child, &linkbus->devices, bus_list) {
>  			if ((pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT) &&
> @@ -1222,6 +1224,7 @@ static void pcie_update_aspm_capable(struct pcie_link_state *root)
>  				continue;
>  			pcie_aspm_check_latency(child);
>  		}
> +		pci_bus_put(linkbus);
>  	}
>  }
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b14b9876c0303..53522685193da 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c

...

> @@ -3380,7 +3383,7 @@ int pci_hp_add_bridge(struct pci_dev *dev)

As far as I can tell the return value of this function is never used.
So could just drop the code below. Maybe clean up this function
to return void or start handling the return value.

>  	/* Scan bridges that need to be reconfigured */
>  	pci_scan_bridge_extend(parent, dev, busnr, available_buses, 1);
>  
> -	if (!dev->subordinate)
> +	if (!READ_ONCE(dev->subordinate))
>  		return -1;
>  
>  	return 0;

