Return-Path: <linux-pci+bounces-24283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A196A6B27A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3978D189CD28
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF9423DE;
	Fri, 21 Mar 2025 01:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PjCVa2Qj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6175C184F
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742518978; cv=none; b=Xi3MUMibIDexjbxhEzz+oFbMQfoAFpXQD8vHmHbrXHsmwHCbvRTkmzTB3GRp6c60LJ7t6X4j3wDWBwo5ot2L/b7YkVG8CZiL5tvOzEBRKuQHRfYD2kGjN4OZpMl747dnQww0JxsSJjN+OMfEWsCgx+pfIK6/n0FrcIfFbVVqRF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742518978; c=relaxed/simple;
	bh=lCvATjzGpY1VjE1dol8veYBNlJwsUnDtyWl6Xf1RMOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wr3a5rSGPOnsCHCJt7+XgzKeqrElLTfjENzqLX9ijHvTfuza9rxkYiE9Ubd3waVNHMzcGLjDlpFoplgfQos58z8nuBWgaIZG/Ya66om9I3PKXx7y1U9EQ9m9c0a1141KUtDJvGsKujEPHRAzSWjq0d8H/Z2Qvs+YUnFwZ5OunNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PjCVa2Qj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742518977; x=1774054977;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lCvATjzGpY1VjE1dol8veYBNlJwsUnDtyWl6Xf1RMOc=;
  b=PjCVa2QjxEWtlWzdM8SploZ/TegmIA5x6VhBffZUDypdLir0JPTsN5qQ
   urzHDwf0ijuLFJ46TNnvdtKaK7w0wzryMcaX+DHHxEu6nSnw2SRL4sp6B
   TBBrP5J93h1ubJgPnWM3GYyMp0gM4xtep9ZW2cKoeR0q0tzV9Nz4tw6cJ
   swd3EFikg7gNf/a/XEb1VPXX2UwJDn7QvDzm0npLFfWPiyN/CvXqrkX3a
   VCWRgUabqVv9lle3uAQcRammlaTvaFJI2HF7btnj0G6Ba9mz/2Wm3bCs9
   ye08iKbNvoYCdXjGwGUozhnusoAnyDd99xxIrOXZ5l/xZFgUjDkmRDsLk
   Q==;
X-CSE-ConnectionGUID: CVUA9WbPR3O/DUZcdj5M5A==
X-CSE-MsgGUID: Tl3fnvy8SiOiifS89yptxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="54772708"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="54772708"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:02:56 -0700
X-CSE-ConnectionGUID: TWdFI8ubQzu/5QCRW0guTA==
X-CSE-MsgGUID: jW0KH6uiSESx/fpziQEn4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="128368353"
Received: from jairdeje-mobl1.amr.corp.intel.com (HELO [10.124.221.27]) ([10.124.221.27])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:02:54 -0700
Message-ID: <d15a7845-dad5-47c9-acba-779c9b9ab5e0@linux.intel.com>
Date: Thu, 20 Mar 2025 18:02:54 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] PCI/AER: Add sysfs attributes for log ratelimits
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Terry Bowman <Terry.bowman@amd.com>
References: <20250320082057.622983-1-pandoh@google.com>
 <20250320082057.622983-8-pandoh@google.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250320082057.622983-8-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/20/25 1:20 AM, Jon Pan-Doh wrote:
> Allow userspace to read/write log ratelimits per device (including
> enable/disable). Create aer/ sysfs directory to store them and any
> future aer configs.
>
> Update AER sysfs ABI filename to reflect the broader scope of AER sysfs
> attributes (e.g. stats and ratelimits).
>
> Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats ->
> Documentation/ABI/testing/sysfs-bus-pci-devices-aer
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
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>   ...es-aer_stats => sysfs-bus-pci-devices-aer} | 34 +++++++
>   Documentation/PCI/pcieaer-howto.rst           |  5 +-
>   drivers/pci/pci-sysfs.c                       |  1 +
>   drivers/pci/pci.h                             |  1 +
>   drivers/pci/pcie/aer.c                        | 93 +++++++++++++++++++
>   5 files changed, 133 insertions(+), 1 deletion(-)
>   rename Documentation/ABI/testing/{sysfs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} (77%)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> similarity index 77%
> rename from Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> rename to Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> index d1f67bb81d5d..4561653fdbde 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> @@ -117,3 +117,37 @@ Date:		July 2018
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
> +What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_log_enable
> +Date:		March 2025
> +KernelVersion:	6.15.0
> +Contact:	linux-pci@vger.kernel.org, pandoh@google.com
> +Description:	Writing 1/0 enables/disables AER log ratelimiting. Reading
> +		gets whether or not AER is currently enabled. Enabled by
> +		default.
> +
> +What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_in_5secs_cor_log

Why not just use ratelimit_cor_log and ratelimit_uncor_log? Any way the
detail about 5 second window would be available in the Documentation.

> +Date:		March 2025
> +KernelVersion:	6.15.0
> +Contact:	linux-pci@vger.kernel.org, pandoh@google.com
> +Description:	Ratelimit burst for correctable error logs. Writing a value
> +		changes the number of errors (burst) allowed per interval
> +		(5 second window) before ratelimiting. Reading gets the
> +		current ratelimit burst.
> +
> +What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_in_5secs_uncor_log
> +Date:		March 2025
> +KernelVersion:	6.15.0
> +Contact:	linux-pci@vger.kernel.org, pandoh@google.com
> +Description:	Ratelimit burst for uncorrectable error logs. Writing a
> +		value changes the number of errors (burst) allowed per
> +		interval (5 second window) before ratelimiting. Reading
> +		gets the current ratelimit burst.
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index 896d2a232a90..043cdb3194be 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -96,12 +96,15 @@ type (correctable vs. uncorrectable).
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
> index b46ce1a2c554..16de3093294e 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1801,6 +1801,7 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>   	&pcie_dev_attr_group,
>   #ifdef CONFIG_PCIEAER
>   	&aer_stats_attr_group,
> +	&aer_attr_group,
>   #endif
>   #ifdef CONFIG_PCIEASPM
>   	&aspm_ctrl_attr_group,
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9d63d32f041c..34633fe12201 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -889,6 +889,7 @@ void pci_no_aer(void);
>   void pci_aer_init(struct pci_dev *dev);
>   void pci_aer_exit(struct pci_dev *dev);
>   extern const struct attribute_group aer_stats_attr_group;
> +extern const struct attribute_group aer_attr_group;
>   void pci_aer_clear_fatal_status(struct pci_dev *dev);
>   int pci_aer_clear_status(struct pci_dev *dev);
>   int pci_aer_raw_clear_status(struct pci_dev *dev);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 081cef5fc678..f84ae1872fa3 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -631,6 +631,99 @@ const struct attribute_group aer_stats_attr_group = {
>   	.is_visible = aer_stats_attrs_are_visible,
>   };
>   
> +/*
> + * Ratelimit enable toggle uses interval value of
> + * 0: disabled
> + * DEFAULT_RATELIMIT_INTERVAL: enabled
> + */
> +static ssize_t ratelimit_log_enable_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	bool enable = pdev->aer_report->cor_log_ratelimit.interval != 0;
> +
> +	return sysfs_emit(buf, "%d\n", enable);
> +}
> +
> +static ssize_t ratelimit_log_enable_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	bool enable;
> +	int interval;
> +
> +	if (kstrtobool(buf, &enable) < 0)
> +		return -EINVAL;
> +
> +	if (enable)
> +		interval = DEFAULT_RATELIMIT_INTERVAL;
> +	else
> +		interval = 0;
> +
> +	pdev->aer_report->cor_log_ratelimit.interval = interval;
> +	pdev->aer_report->uncor_log_ratelimit.interval = interval;
> +	return count;
> +}
> +static DEVICE_ATTR_RW(ratelimit_log_enable);
> +
> +/*
> + * Ratelimits are doubled as a given error produces 2 logs (root port
> + * and endpoint) that should be under same ratelimit.
> + */
> +#define aer_ratelimit_burst_attr(name, ratelimit)			\
> +	static ssize_t							\
> +	name##_show(struct device *dev, struct device_attribute *attr,	\
> +		    char *buf)						\
> +{									\
> +	struct pci_dev *pdev = to_pci_dev(dev);				\
> +	return sysfs_emit(buf, "%d\n",					\
> +			  pdev->aer_report->ratelimit.burst / 2);	\
> +}									\
> +									\
> +	static ssize_t							\
> +	name##_store(struct device *dev, struct device_attribute *attr,	\
> +		     const char *buf, size_t count)			\
> +{									\
> +	struct pci_dev *pdev = to_pci_dev(dev);				\
> +	int burst;							\
> +									\
> +	if (kstrtoint(buf, 0, &burst) < 0)				\
> +		return -EINVAL;						\
> +									\
> +	pdev->aer_report->ratelimit.burst = burst * 2;			\
> +	return count;							\
> +}									\
> +static DEVICE_ATTR_RW(name)
> +
> +aer_ratelimit_burst_attr(ratelimit_in_5secs_cor_log, cor_log_ratelimit);
> +aer_ratelimit_burst_attr(ratelimit_in_5secs_uncor_log, uncor_log_ratelimit);
> +
> +static struct attribute *aer_attrs[] = {
> +	&dev_attr_ratelimit_log_enable.attr,
> +	&dev_attr_ratelimit_in_5secs_cor_log.attr,
> +	&dev_attr_ratelimit_in_5secs_uncor_log.attr,
> +	NULL
> +};
> +
> +static umode_t aer_attrs_are_visible(struct kobject *kobj,
> +				     struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (!pdev->aer_report)
> +		return 0;
> +	return a->mode;
> +}
> +
> +const struct attribute_group aer_attr_group = {
> +	.name = "aer",
> +	.attrs = aer_attrs,
> +	.is_visible = aer_attrs_are_visible,
> +};
> +
>   void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info)
>   {
>   	unsigned long status = info->status & ~info->mask;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


