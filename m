Return-Path: <linux-pci+bounces-28309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35802AC1839
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21C8502988
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A50F2494F8;
	Thu, 22 May 2025 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDcAy742"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23314186295;
	Thu, 22 May 2025 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957865; cv=none; b=se3ZVrHbHKq3wDiZTlWYyv5jkYorccAzgqqWHhsc9Wf7pQRG8ElCHA4fV/Ryv2KUsvxP5T2w50gAnj0gkoMo6+4etYELDfN6IMoeZPy+yuCeWa9hsMW1Gv2/mp45gN/t6k0wDXqHplFEENnBH9tHa5w7YL+pAAcyJxMMaKv0LAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957865; c=relaxed/simple;
	bh=Zn+ucjjHqXaHvhZRtxjTufhtCPyOQzdr+n3oV2AG7Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyymob4OvAJDG+UVNlboNU5w2ELPGv8nCOfYp50F8KcAt+1tL4hrGRl4cymCOHSGuzGtTBi5pE/c1tNj7750HeW4c29F2rsT3ykKdoAi/Fyyiqb0kaBMPNQyTWy0cP0wzEuorPvUAOnj1NAT3u0BmKuYm/0k3wvvXjUghd30hsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDcAy742; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747957861; x=1779493861;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zn+ucjjHqXaHvhZRtxjTufhtCPyOQzdr+n3oV2AG7Ag=;
  b=cDcAy742Sn3NBNF0LYJEnFXHhoE+BbMF3PPN0sv7GEbY5TDLnZtE67Fx
   WJY2b2hEmdfcG2rkfSiWw+af1K7vkekPsZkAGgVmsbhkKZKtU/CeycRLW
   GmC86r7LWav10VxS4VuFPQ7Em0kHtPwSmBSZWp7z4UFldwvFXFzZTfC3Z
   hXXaIvJdbMq/NHBYFVCrs8cgB5tszMdsV9gAhay0cYyZJA5YNAKyL4TVG
   X53cBeJYLbfckgZOqBMvXf55XL+4+zMBORl0TgNkyw16s4oxcdKmDFv+x
   ftRyBJIZWzWYzXFPG18sTaQF3gNwMHmTtPk8vzagSautUbCWNj/aGM9Kc
   A==;
X-CSE-ConnectionGUID: DPhOFTfYT8y2ARYeum+GIg==
X-CSE-MsgGUID: jLsNb9WfQgOv8gWEuF3OpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="72534345"
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="72534345"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 16:51:00 -0700
X-CSE-ConnectionGUID: vUJfXozOSuOQ/nNYHg9X5A==
X-CSE-MsgGUID: Ijw220yQQhK7CjYW5CrcAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="140884664"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.223.120]) ([10.124.223.120])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 16:50:59 -0700
Message-ID: <97a45686-3b54-489f-b0f4-847b99312aa0@linux.intel.com>
Date: Thu, 22 May 2025 16:50:58 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 20/20] PCI/AER: Add sysfs attributes for log ratelimits
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Weinan Liu <wnliu@google.com>, Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20250522232339.1525671-1-helgaas@kernel.org>
 <20250522232339.1525671-21-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250522232339.1525671-21-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/22/25 4:21 PM, Bjorn Helgaas wrote:
> From: Jon Pan-Doh <pandoh@google.com>
>
> Allow userspace to read/write log ratelimits per device (including
> enable/disable). Create aer/ sysfs directory to store them and any
> future AER configs.
>
> The new sysfs files are:
>
>    /sys/bus/pci/devices/*/aer/correctable_ratelimit_burst
>    /sys/bus/pci/devices/*/aer/correctable_ratelimit_interval_ms
>    /sys/bus/pci/devices/*/aer/nonfatal_ratelimit_burst
>    /sys/bus/pci/devices/*/aer/nonfatal_ratelimit_interval_ms
>
> The default values are ratelimit_burst=10, ratelimit_interval_ms=5000, so
> if we try to emit more than 10 messages in a 5 second period, some are
> suppressed.
>
> Update AER sysfs ABI filename to reflect the broader scope of AER sysfs
> attributes (e.g. stats and ratelimits).
>
>    Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats ->
>      sysfs-bus-pci-devices-aer
>
> Tested using aer-inject[1]. Configured correctable log ratelimit to 5.
> Sent 6 AER errors. Observed 5 errors logged while AER stats
> (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) shows 6.
>
> Disabled ratelimiting and sent 6 more AER errors. Observed all 6 errors
> logged and accounted in AER stats (12 total errors).
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
>
> [bhelgaas: note fatal errors are not ratelimited, "aer_report" ->
> "aer_info", replace ratelimit_log_enable toggle with *_ratelimit_interval_ms]
>
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://patch.msgid.link/20250520215047.1350603-18-helgaas@kernel.org
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   ...es-aer_stats => sysfs-bus-pci-devices-aer} |  44 ++++++++
>   Documentation/PCI/pcieaer-howto.rst           |   5 +-
>   drivers/pci/pci-sysfs.c                       |   1 +
>   drivers/pci/pci.h                             |   1 +
>   drivers/pci/pcie/aer.c                        | 105 ++++++++++++++++++
>   5 files changed, 155 insertions(+), 1 deletion(-)
>   rename Documentation/ABI/testing/{sysfs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} (72%)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> similarity index 72%
> rename from Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> rename to Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> index d1f67bb81d5d..5ed284523956 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> @@ -117,3 +117,47 @@ Date:		July 2018
>   KernelVersion:	4.19.0
>   Contact:	linux-pci@vger.kernel.org, rajatja@google.com
>   Description:	Total number of ERR_NONFATAL messages reported to rootport.
> +
> +PCIe AER ratelimits
> +-------------------
> +
> +These attributes show up under all the devices that are AER capable.
> +They represent configurable ratelimits of logs per error type.
> +
> +See Documentation/PCI/pcieaer-howto.rst for more info on ratelimits.
> +
> +What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_interval_ms
> +Date:		May 2025
> +KernelVersion:	6.16.0
> +Contact:	linux-pci@vger.kernel.org
> +Description:	Writing 0 disables AER correctable error log ratelimiting.
> +		Writing a positive value sets the ratelimit interval in ms.
> +		Default is DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> +
> +What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_burst
> +Date:		May 2025
> +KernelVersion:	6.16.0
> +Contact:	linux-pci@vger.kernel.org
> +Description:	Ratelimit burst for correctable error logs. Writing a value
> +		changes the number of errors (burst) allowed per interval
> +		before ratelimiting. Reading gets the current ratelimit
> +		burst. Default is DEFAULT_RATELIMIT_BURST (10).
> +
> +What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_interval_ms
> +Date:		May 2025
> +KernelVersion:	6.16.0
> +Contact:	linux-pci@vger.kernel.org
> +Description:	Writing 0 disables AER non-fatal uncorrectable error log
> +		ratelimiting. Writing a positive value sets the ratelimit
> +		interval in ms. Default is DEFAULT_RATELIMIT_INTERVAL
> +		(5000 ms).
> +
> +What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_burst
> +Date:		May 2025
> +KernelVersion:	6.16.0
> +Contact:	linux-pci@vger.kernel.org
> +Description:	Ratelimit burst for non-fatal uncorrectable error logs.
> +		Writing a value changes the number of errors (burst)
> +		allowed per interval before ratelimiting. Reading gets the
> +		current ratelimit burst. Default is DEFAULT_RATELIMIT_BURST
> +		(10).
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index 6fb31516fff1..4b71e2f43ca7 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -97,12 +97,15 @@ DPC errors, are not ratelimited.
>   AER uses the default ratelimit of DEFAULT_RATELIMIT_BURST (10 events) over
>   DEFAULT_RATELIMIT_INTERVAL (5 seconds).
>   
> +Ratelimits are exposed in the form of sysfs attributes and configurable.
> +See Documentation/ABI/testing/sysfs-bus-pci-devices-aer.
> +
>   AER Statistics / Counters
>   -------------------------
>   
>   When PCIe AER errors are captured, the counters / statistics are also exposed
>   in the form of sysfs attributes which are documented at
> -Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> +Documentation/ABI/testing/sysfs-bus-pci-devices-aer.
>   
>   Developer Guide
>   ===============
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index c6cda56ca52c..278de99b00ce 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1805,6 +1805,7 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>   	&pcie_dev_attr_group,
>   #ifdef CONFIG_PCIEAER
>   	&aer_stats_attr_group,
> +	&aer_attr_group,
>   #endif
>   #ifdef CONFIG_PCIEASPM
>   	&aspm_ctrl_attr_group,
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3023c68fe485..eca2812cfd25 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -965,6 +965,7 @@ void pci_no_aer(void);
>   void pci_aer_init(struct pci_dev *dev);
>   void pci_aer_exit(struct pci_dev *dev);
>   extern const struct attribute_group aer_stats_attr_group;
> +extern const struct attribute_group aer_attr_group;
>   void pci_aer_clear_fatal_status(struct pci_dev *dev);
>   int pci_aer_clear_status(struct pci_dev *dev);
>   int pci_aer_raw_clear_status(struct pci_dev *dev);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ebac126144fc..6c331695af58 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -627,6 +627,111 @@ const struct attribute_group aer_stats_attr_group = {
>   	.is_visible = aer_stats_attrs_are_visible,
>   };
>   
> +/*
> + * Ratelimit interval
> + * <=0: disabled with ratelimit.interval = 0
> + * >0: enabled with ratelimit.interval in ms
> + */
> +#define aer_ratelimit_interval_attr(name, ratelimit)			\
> +	static ssize_t							\
> +	name##_show(struct device *dev, struct device_attribute *attr,	\
> +					 char *buf)			\
> +	{								\
> +		struct pci_dev *pdev = to_pci_dev(dev);			\
> +									\
> +		return sysfs_emit(buf, "%d\n",				\
> +				  pdev->aer_info->ratelimit.interval);	\
> +	}								\
> +									\
> +	static ssize_t							\
> +	name##_store(struct device *dev, struct device_attribute *attr, \
> +		     const char *buf, size_t count) 			\
> +	{								\
> +		struct pci_dev *pdev = to_pci_dev(dev);			\
> +		int interval;						\
> +									\
> +		if (!capable(CAP_SYS_ADMIN))				\
> +			return -EPERM;					\
> +									\
> +		if (kstrtoint(buf, 0, &interval) < 0)			\
> +			return -EINVAL;					\
> +									\
> +		if (interval <= 0)					\
> +			interval = 0;					\
> +		else							\
> +			interval = msecs_to_jiffies(interval); 		\
> +									\
> +		pdev->aer_info->ratelimit.interval = interval;		\
> +									\
> +		return count;						\
> +	}								\
> +	static DEVICE_ATTR_RW(name);
> +
> +#define aer_ratelimit_burst_attr(name, ratelimit)			\
> +	static ssize_t							\
> +	name##_show(struct device *dev, struct device_attribute *attr,	\
> +		    char *buf)						\
> +	{								\
> +		struct pci_dev *pdev = to_pci_dev(dev);			\
> +									\
> +		return sysfs_emit(buf, "%d\n",				\
> +				  pdev->aer_info->ratelimit.burst);	\
> +	}								\
> +									\
> +	static ssize_t							\
> +	name##_store(struct device *dev, struct device_attribute *attr,	\
> +		     const char *buf, size_t count)			\
> +	{								\
> +		struct pci_dev *pdev = to_pci_dev(dev);			\
> +		int burst;						\
> +									\
> +		if (!capable(CAP_SYS_ADMIN))				\
> +			return -EPERM;					\
> +									\
> +		if (kstrtoint(buf, 0, &burst) < 0)			\
> +			return -EINVAL;					\
> +									\
> +		pdev->aer_info->ratelimit.burst = burst;		\
> +									\
> +		return count;						\
> +	}								\
> +	static DEVICE_ATTR_RW(name);
> +
> +#define aer_ratelimit_attrs(name)					\
> +	aer_ratelimit_interval_attr(name##_ratelimit_interval_ms,	\
> +				    name##_ratelimit)			\
> +	aer_ratelimit_burst_attr(name##_ratelimit_burst,		\
> +				 name##_ratelimit)
> +
> +aer_ratelimit_attrs(correctable)
> +aer_ratelimit_attrs(nonfatal)
> +
> +static struct attribute *aer_attrs[] = {
> +	&dev_attr_correctable_ratelimit_interval_ms.attr,
> +	&dev_attr_correctable_ratelimit_burst.attr,
> +	&dev_attr_nonfatal_ratelimit_interval_ms.attr,
> +	&dev_attr_nonfatal_ratelimit_burst.attr,
> +	NULL
> +};
> +
> +static umode_t aer_attrs_are_visible(struct kobject *kobj,
> +				     struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (!pdev->aer_info)
> +		return 0;
> +
> +	return a->mode;
> +}
> +
> +const struct attribute_group aer_attr_group = {
> +	.name = "aer",
> +	.attrs = aer_attrs,
> +	.is_visible = aer_attrs_are_visible,
> +};
> +
>   static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
>   				   struct aer_err_info *info)
>   {

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


