Return-Path: <linux-pci+bounces-37763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C4ABC9A3A
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 16:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E71EE4FA2C1
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5A2EA724;
	Thu,  9 Oct 2025 14:49:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7944020B21E;
	Thu,  9 Oct 2025 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021367; cv=none; b=PppmtBMwxgMIik4HcJyFu5YO+Ozb6SMZXO/E32ioNgtYCX4ye3fUJpeu/wTPtf+o6QVOyKRHdUW0cnGDe8F6mC08csy9yZL7oiCVSodY9PlJ0pbERZ66M1BC4vwIUYb767c6XmNr2WBy7cZtiU59+4+WzyC+3aSnIzxMMX+05/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021367; c=relaxed/simple;
	bh=9dpjBcmZz5pl+Hj8gon8cXH6oCPxRzysyVS2inFvLos=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKErzglE1Zm/odF1bgACd2T4Vk4SNnhbH8vILodRZtpNQKODyhEnAACRWl/ZprnbTU4eQqM3w/5EZKsvynn9ubVZ8030VAcJhxeG7iu6wSe//fKCALpA6zlcgdWxLq6JJHMuessf68fRiHRnxG3/7OpMXQgZr7UAUqE7b4olkOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cjCPd6xhLz6L4v1;
	Thu,  9 Oct 2025 22:46:45 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id CEE9B1402ED;
	Thu,  9 Oct 2025 22:49:21 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 9 Oct
 2025 15:49:20 +0100
Date: Thu, 9 Oct 2025 15:49:19 +0100
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
Subject: Re: [RFC PATCH 06/13] pci: pcsc: handle device resets
Message-ID: <20251009154919.00000ee2@huawei.com>
In-Reply-To: <0fa6f46439b535eedaa82c360e1ea19e7f052fca.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
	<0fa6f46439b535eedaa82c360e1ea19e7f052fca.1759312886.git.epetron@amazon.de>
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

On Fri, 3 Oct 2025 09:00:42 +0000
Evangelos Petrongonas <epetron@amazon.de> wrote:

> The PCI Configuration Space Cache (PCSC) maintains cached values of
> configuration space registers for performance optimization. When a PCI
> device is reset or bus operations are dynamically changed, cached values
> become stale and can cause incorrect behavior. This patch ensures cache
> coherency by invalidating the PCSC cache in all scenarios where the
> underlying configuration space values may have changed.
> 
> Device Reset Handling:
> ----------------------
> When PCI devices are reset, their configuration space registers return
> to default values. Add pcsc_device_reset() calls after all device reset
> operations to invalidate stale cached values:
> 
> - Function Level Resets (FLR) in `pcie_flr()`
> - Advanced Features FLR in `pci_af_flr()`
> - Power Management resets (D3hot->D0 transition) in `pci_pm_reset()`
> - Device-specific resets in `pci_dev_specific_reset()`
> - D3cold power state transitions in `__pci_set_power_state()`
> - ACPI-based resets in `pci_dev_acpi_reset()`
> - Bus restore operations in `pci_bus_restore_locked()`
> - Slot restore operations in `pci_slot_restore_locked()`
> - Secondary bus resets in `pci_bridge_secondary_bus_reset()`

cxl bus reset? 

> 
> For secondary bus resets, `pcsc_reset_bus_recursively()` invalidates the
> cache for all devices on the secondary bus and subordinate buses. This
> also covers hotplug slot reset operations since `pciehp_reset_slot()`
> calls `pci_bridge_secondary_bus_reset()`.
> 
> In addition, functions like `pci_dev_wait` are configured to bypass the
> cahce and reads the actual HW values.

cache

> 
> Dynamic Ops Changes:
> --------------------
> The patch also addresses cache consistency issues when bus operations
> are dynamically changed via `pci_bus_set_ops()``. Different ops
> implementations may return different values for the same registers, and
> hardware state may have changed while using the different ops. This
> commit resets the cache for all devices on the affected bus
> 
> Implementation Details:
> -----------------------
> The cache invalidation clears the cached_bitmask while preserving the
> cacheable_bitmask, as the configuration space layout remains unchanged
> after a reset. This allows the cache to be repopulated with fresh values
> on subsequent configuration space accesses.
> 
> Known Limitations:
> ------------------
> - There is currently a gap in handling PowerPC secondary bus resets, as
> the architecture-specific `pcibios_reset_secondary_bus()` can bypass the
> generic `pci_reset_secondary_bus()` where our cache invalidation occurs.
> 
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> Signed-off-by: Stanislav Spassov <stanspas@amazon.de>


> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f518cfa266b5..db940f8fd408 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -26,6 +26,7 @@
>  #include <linux/device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pci_hotplug.h>
> +#include <linux/pcsc.h>
>  #include <linux/vmalloc.h>
>  #include <asm/dma.h>
>  #include <linux/aer.h>
> @@ -1248,11 +1249,19 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  		}
>  
>  		if (root && root->config_rrs_sv) {
> +#ifdef CONFIG_PCSC
> +			pcsc_hw_config_read(dev->bus, dev->devfn, PCI_VENDOR_ID, 4, &id);
> +#else
>  			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
> +#endif
>  			if (!pci_bus_rrs_vendor_id(id))
>  				break;
>  		} else {
> +#ifdef CONFIG_PCSC
> +			pcsc_hw_config_read(dev->bus, dev->devfn, PCI_COMMAND, 4, &id);
In the !CONFIG case define this to be pci_read_config_dword()

> +#else
>  			pci_read_config_dword(dev, PCI_COMMAND, &id);
> +#endif
>  			if (!PCI_POSSIBLE_ERROR(id))
>  				break;
>  		}

>  void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
> @@ -5542,6 +5594,9 @@ static void pci_bus_restore_locked(struct pci_bus *bus)
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		pci_dev_restore(dev);
> +#ifdef CONFIG_PCSC
> +		pcsc_device_reset(dev);
> +#endif
>  		if (dev->subordinate) {
>  			pci_bridge_wait_for_secondary_bus(dev, "bus reset");
>  			pci_bus_restore_locked(dev->subordinate);
> @@ -5579,6 +5634,9 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
>  		if (!dev->slot || dev->slot != slot)
>  			continue;
>  		pci_dev_restore(dev);
> +#ifdef CONFIG_PCSC
> +		pcsc_device_reset(dev);

Definitely use a stub for these.

> +#endif
>  		if (dev->subordinate) {
>  			pci_bridge_wait_for_secondary_bus(dev, "slot reset");
>  			pci_bus_restore_locked(dev->subordinate);



