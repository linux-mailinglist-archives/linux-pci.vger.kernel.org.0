Return-Path: <linux-pci+bounces-37765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9EDBC9A6A
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 16:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21643352AB0
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 14:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287A12EB84B;
	Thu,  9 Oct 2025 14:56:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D940F1991CA;
	Thu,  9 Oct 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021799; cv=none; b=lA0q+IlFvtSi+HIJaj7MKqiYUVXniw3WUm0+nd48A9JG3psjiP47iUFXPpwY9y59LrBtjK9DA8E6ZCULMN8yiFzLBKVERHv9U9EeSMn1dcyAl2ZLamqQcEqQVA/Cbdrp6snM8WYcPNw2XCt003Zgwwl1bRynN7DTNH5LzbRFq1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021799; c=relaxed/simple;
	bh=qHXrB1snGpJQeKTlYr4nFB6g3pR4szYtExQI0VqcDvw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUs50TjFWu45ccl70Xwvu3VeXXLxOFFw2fZPkukhgBydy0vJa6K8LaRKY7zAAmdM6dyJfOhxxQbp04okbK3PO2ft3J9eD21nvie/yptwBsHMFswM4F6JEvMAl1Y/7D5tbXYworhi13ZQbDlb25g41fgoTZbbmacQG/A4zTeb0VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cjCc638MTz6L5JJ;
	Thu,  9 Oct 2025 22:55:50 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A0EC1402FD;
	Thu,  9 Oct 2025 22:56:33 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 9 Oct
 2025 15:56:32 +0100
Date: Thu, 9 Oct 2025 15:56:30 +0100
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
Subject: Re: [RFC PATCH 07/13] pci: pcsc: introduce statistic gathering
 tools
Message-ID: <20251009155630.00003b8a@huawei.com>
In-Reply-To: <762a6242ba9688aeb432c738e297cc8d039d0273.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
	<762a6242ba9688aeb432c738e297cc8d039d0273.1759312886.git.epetron@amazon.de>
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


Mostly suggestions to move away from ifdefs.

Jonathan

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index c26162b58365..9b5275ef2d16 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -50,6 +50,13 @@ config PCSC
>  	  intercepts configuration space operations and maintains cached
>  	  copies of register values
>  
> +config PCSC_STATS
> +	bool "PCI Configuration Space Cache Statistics"
> +	depends on PCSC
> +	default n

No need, that's what you get if you don't specify a default.

> +	help
> +	  This option allows the collection of statistics for the PCSC.
> +
>  source "drivers/pci/pcie/Kconfig"
>  
>  config PCI_MSI
> diff --git a/drivers/pci/pcsc.c b/drivers/pci/pcsc.c
> index 5412dea23446..304239b7ff8a 100644
> --- a/drivers/pci/pcsc.c
> +++ b/drivers/pci/pcsc.c
> @@ -25,9 +25,84 @@ static int __init pcsc_enabled_setup(char *str)
>  }
>  __setup("pcsc_enabled=", pcsc_enabled_setup);
>  
> +#ifdef CONFIG_PCSC_STATS
Use IS_ENABLED() on this instead of defines below and let
dead code removal drop this without needing the ifdefs.

> +struct pcsc_stats {
> +	/* Operation Counters */
> +	unsigned long cache_hits;
> +	unsigned long cache_misses;
> +	unsigned long uncachable_reads;
> +	unsigned long writes;
> +	unsigned long cache_invalidations;
> +	unsigned long total_reads;
> +	unsigned long hw_reads;
> +	unsigned long device_resets;
> +	u64 total_cache_access_time; /* in milliseconds */
> +	u64 total_hw_access_time; /* in milliseconds */
> +	u64 hw_access_time_due_to_misses; /* in milliseconds */
> +};
> +#endif
> +
>  static bool pcsc_initialised;
>  static atomic_t num_nodes = ATOMIC_INIT(0);
>  
> +#ifdef CONFIG_PCSC_STATS
> +struct pcsc_stats pcsc_stats;
static?
> +
> +static inline void pcsc_count_cache_hit(void)
> +{
I'd drop the stubs and do
	if (IS_ENABLED_CONFIG_PCSC_STATS)) {
		pcsc_stats.cache_hits++;
		pcsc_stats.total_reads++;
	}

Compiler should then figure out they are stubs and drop them for you.

> +	pcsc_stats.cache_hits++;
> +	pcsc_stats.total_reads++;
> +}

>  
>  	if (WARN_ON(!dev || !bus || !word))
>  		return -EINVAL;
> @@ -734,7 +813,6 @@ static int pcsc_get_and_insert_multiple(struct pci_dev *dev,
>  	if (WARN_ON(size != 1 && size != 2 && size != 4))
>  		return -EINVAL;
>  
> -	/* Check bounds */
Not sure why this is removed here.

>  	if (where + size > PCSC_CFG_SPC_SIZE)
>  		return -EINVAL;
>  
> @@ -746,8 +824,17 @@ static int pcsc_get_and_insert_multiple(struct pci_dev *dev,
>  			pcsc_get_byte(dev, where + i, &byte_val);
>  			word_cached |= ((u32)byte_val << (i * 8));
>  		}
> +		pcsc_count_cache_hit();
>  	} else {
> +#ifdef CONFIG_PCSC_STATS
> +		start_time = ktime_get();
> +#endif
>  		rc = pcsc_hw_config_read(bus, devfn, where, size, &word_cached);
> +#ifdef CONFIG_PCSC_STATS
> +		duration = ktime_to_ns(ktime_sub(ktime_get(), start_time));
> +		pcsc_stats.hw_access_time_due_to_misses += duration;
> +		pcsc_stats.total_hw_access_time += duration;
> +#endif
>  		if (rc) {
>  			pci_err(dev,
>  				"%s: Failed to read CFG Space where=%d size=%d",
> @@ -762,6 +849,7 @@ static int pcsc_get_and_insert_multiple(struct pci_dev *dev,
>  			byte_val = (word_cached >> (i * 8)) & 0xFF;
>  			pcsc_update_byte(dev, where + i, byte_val);
>  		}
> +		pcsc_count_cache_miss();
>  	}
>  
>  	*word = word_cached;
> @@ -773,6 +861,17 @@ int pcsc_cached_config_read(struct pci_bus *bus, unsigned int devfn, int where,
>  {
>  	int rc;
>  	struct pci_dev *dev;
> +#ifdef CONFIG_PCSC_STATS
> +	ktime_t hw_start_time;
> +	u64 hw_duration;
> +#endif
> +
> +#ifdef CONFIG_PCSC_STATS
> +	u64 duration;
> +	ktime_t start_time;
> +
> +	start_time = ktime_get();
> +#endif
>  
>  	if (unlikely(!pcsc_is_initialised()))
>  		goto read_from_dev;
> @@ -790,6 +889,10 @@ int pcsc_cached_config_read(struct pci_bus *bus, unsigned int devfn, int where,
>  	    pcsc_is_access_cacheable(dev, where, size)) {
>  		rc = pcsc_get_and_insert_multiple(dev, bus, devfn, where, val,
>  						  size);
> +#ifdef CONFIG_PCSC_STATS
As above. Stick this under and IS_ENABLED() and let dead code removal tidy it up.

> +		duration = ktime_to_ns(ktime_sub(ktime_get(), start_time));
> +		pcsc_stats.total_cache_access_time += duration;
> +#endif
>  		if (likely(!rc)) {
>  			pci_dev_put(dev);
>  			return 0;
> @@ -797,11 +900,23 @@ int pcsc_cached_config_read(struct pci_bus *bus, unsigned int devfn, int where,
>  		/* if reading from the cache failed continue and try reading
>  		 * from the actual device
>  		 */
> +	} else {
> +		if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL)
> +			pcsc_count_uncachable_read();
>  	}
>  read_from_dev:
> +#ifdef CONFIG_PCSC_STATS
> +	hw_start_time = ktime_get();
> +#endif
>  	if (dev)
>  		pci_dev_put(dev);
> -	return pcsc_hw_config_read(bus, devfn, where, size, val);
> +	rc = pcsc_hw_config_read(bus, devfn, where, size, val);
> +#ifdef CONFIG_PCSC_STATS
> +	hw_duration = ktime_to_ns(ktime_sub(ktime_get(), hw_start_time));
> +	/* Add timing for uncacheable reads */
> +	pcsc_stats.total_hw_access_time += hw_duration;
> +#endif
> +	return rc;
>  }
>  EXPORT_SYMBOL_GPL(pcsc_cached_config_read);
>  
> @@ -810,6 +925,11 @@ int pcsc_cached_config_write(struct pci_bus *bus, unsigned int devfn, int where,
>  {
>  	int i;
>  	struct pci_dev *dev;
> +	int rc;
> +#ifdef CONFIG_PCSC_STATS
> +	ktime_t hw_start_time;
> +	u64 hw_duration;
> +#endif
>  
>  	if (unlikely(!pcsc_is_initialised()))
>  		goto write_to_dev;
> @@ -828,12 +948,22 @@ int pcsc_cached_config_write(struct pci_bus *bus, unsigned int devfn, int where,
>  		if (pcsc_is_access_cacheable(dev, where, size)) {
>  			for (i = 0; i < size; i++)
>  				pcsc_set_cached(dev, where + i, false);
> +			pcsc_count_cache_invalidation();
>  		}
>  	}
>  write_to_dev:
> +	pcsc_count_write();
>  	if (dev)
>  		pci_dev_put(dev);
> -	return pcsc_hw_config_write(bus, devfn, where, size, val);
> +#ifdef CONFIG_PCSC_STATS
> +	hw_start_time = ktime_get();
> +#endif
> +	rc = pcsc_hw_config_write(bus, devfn, where, size, val);
> +#ifdef CONFIG_PCSC_STATS
> +	hw_duration = ktime_to_ns(ktime_sub(ktime_get(), hw_start_time));
> +	pcsc_stats.total_hw_access_time += hw_duration;
> +#endif
> +	return rc;
>  }
>  EXPORT_SYMBOL_GPL(pcsc_cached_config_write);
>  
> @@ -851,6 +981,7 @@ int pcsc_device_reset(struct pci_dev *dev)
>  	 * some of the HWInt values that are going to remain constant after a reset.
>  	 */
>  	bitmap_zero(dev->pcsc->cached_bitmask, PCSC_CFG_SPC_SIZE);
> +	pcsc_count_device_reset();
>  	return 0;
>  }
>  
> @@ -948,8 +1079,50 @@ static ssize_t pcsc_enabled_store(struct kobject *kobj,
>  static struct kobj_attribute pcsc_enabled_attribute =
>  	__ATTR(enabled, 0644, pcsc_enabled_show, pcsc_enabled_store);
>  
> +#ifdef CONFIG_PCSC_STATS
> +static ssize_t pcsc_stats_show(struct kobject *kobj,
> +			       struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(
> +		buf,
> +		"Cache Hits: %lu\n"
> +		"Cache Misses: %lu\n"
> +		"Uncachable Reads: %lu\n"
> +		"Writes: %lu\n"
> +		"Cache Invalidations: %lu\n"
> +		"Device Resets: %lu\n"
> +		"Total Reads: %lu\n"
> +		"Hardware Reads: %lu\n"
> +		"Hit Rate: %lu%%\n"
> +		"Total Cache Access Time: %llu us\n"
> +		"Cache Access Time (without HW reads due to Misses): %llu us\n"
> +		"HW Access Time due to misses: %llu us\n"
> +		"Total Hardware Access Time: %llu us\n",
> +		pcsc_stats.cache_hits, pcsc_stats.cache_misses,
> +		pcsc_stats.uncachable_reads, pcsc_stats.writes,
> +		pcsc_stats.cache_invalidations, pcsc_stats.device_resets,
> +		pcsc_stats.total_reads,
> +		pcsc_stats.hw_reads,
> +		pcsc_stats.total_reads ?
> +			      (pcsc_stats.cache_hits * 100) / pcsc_stats.total_reads :
> +			      0,
> +		pcsc_stats.total_cache_access_time / 1000,
> +		(pcsc_stats.total_cache_access_time -
> +		 pcsc_stats.hw_access_time_due_to_misses) /
> +			1000,
> +		pcsc_stats.hw_access_time_due_to_misses / 1000,
> +		pcsc_stats.total_hw_access_time / 1000);
> +}
> +
This would need a __maybe_unused
> +static struct kobj_attribute pcsc_stats_attribute =
> +	__ATTR(stats, 0444, pcsc_stats_show, NULL);
> +#endif
> +
>  static struct attribute *pcsc_attrs[] = {
>  	&pcsc_enabled_attribute.attr,
> +#ifdef CONFIG_PCSC_STATS
And this ifdef can't be as easily avoided.   You could use an
is_visible but probably not worth it.

> +	&pcsc_stats_attribute.attr,
> +#endif

>  	NULL,
>  };



