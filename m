Return-Path: <linux-pci+bounces-24085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8918EA688CF
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 10:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0546B1897D83
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 09:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482A2116F4;
	Wed, 19 Mar 2025 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gv8GxDir"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA4251796
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377883; cv=none; b=rdTuNikxvZsAR3cBqAW+rssqQwJkfMNYCwaH09L0mwICqo2RF6oJBOSar9ux2IgroW6jgemj3e8bRdS4QX0UjwD1nsn1Sf52ZSQfg1x5Cn/cb6YQWsVVc/7r7JMWzfFtKL3bvpZP4qfs2tIeMHngdndIJa/lrrf2IP0IyPSt45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377883; c=relaxed/simple;
	bh=LxXkJ4RcYxcWEj/wSb04wClhmIdMFFdfkcRchZXi4tM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MA/GLYQtVUVZScsKat5cD7e7IUHmw3ZA5JUZOaVY/1qhd988GkdqjUmo5dc07VEMHz7JvvEtyew0XX6rTOHTQg15tQqH1kS4Dvh3093l4vz4UhksPNIjl0xHmTPHJ1D4WDROnY/9fSiCSolw+LYGl4K6PfI4x+qD4/qZCMIrJtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gv8GxDir; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742377881; x=1773913881;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LxXkJ4RcYxcWEj/wSb04wClhmIdMFFdfkcRchZXi4tM=;
  b=Gv8GxDirJr8dEAyqlnhfw9s03shw2I2+mX98MRDe+WLqszA36BFIVUll
   OFdOxT1Y4jl2+sazoE7vacjEnyQtGuGrIcudggerFLNvj9h0AydrUSBwp
   hKT5x8sAAnMR4p37KPQUNXTWBLyvIPXOUXQY+Q17ksuSn7EcPL0LHXL7F
   AtWXG48UFqsUg31NeZawKIl/zMV3BVUfGXeyymK2TCj4cpLBbuAtkyogD
   JmGxoCZ2TvmczDo7v2Zf2yEX7xo7B0D+IG0Abx/1f4EWZeU5bxec/0iAo
   u3mppepiyGaxeKGBMm2OfLBdQzWKDtAO0FbIc0cunlfGm1qn4akvnL+s7
   w==;
X-CSE-ConnectionGUID: ZLqtVhnGQlSsrk2xZLkxrA==
X-CSE-MsgGUID: tpOmb7mtSJi1VOg+E3UOsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43659532"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43659532"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 02:51:21 -0700
X-CSE-ConnectionGUID: Z7+alx1zRpiCWpJxw/4yVw==
X-CSE-MsgGUID: N+PN98L3S6GSExa5zMtMwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122549684"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 02:51:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 19 Mar 2025 11:51:14 +0200 (EET)
To: Jon Pan-Doh <pandoh@google.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Karolina Stolarek <karolina.stolarek@oracle.com>, 
    linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
    Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
    Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Terry Bowman <Terry.bowman@amd.com>
Subject: Re: [PATCH v3 7/8] PCI/AER: Add sysfs attributes for log
 ratelimits
In-Reply-To: <20250319084050.366718-8-pandoh@google.com>
Message-ID: <2c71292f-dcbd-b00f-36da-fb1a9747427c@linux.intel.com>
References: <20250319084050.366718-1-pandoh@google.com> <20250319084050.366718-8-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 19 Mar 2025, Jon Pan-Doh wrote:

> Allow userspace to read/write log ratelimits per device (including
> enable/disable). Create aer/ sysfs directory to store them and any
> future aer configs.
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
>  .../testing/sysfs-bus-pci-devices-aer_stats   | 34 +++++++
>  Documentation/PCI/pcieaer-howto.rst           |  3 +
>  drivers/pci/pci-sysfs.c                       |  1 +
>  drivers/pci/pci.h                             |  1 +
>  drivers/pci/pcie/aer.c                        | 93 +++++++++++++++++++
>  5 files changed, 132 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> index d1f67bb81d5d..4561653fdbde 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> @@ -117,3 +117,37 @@ Date:		July 2018
>  KernelVersion:	4.19.0
>  Contact:	linux-pci@vger.kernel.org, rajatja@google.com
>  Description:	Total number of ERR_NONFATAL messages reported to rootport.
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
> index 896d2a232a90..b45a2e18d1cf 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -96,6 +96,9 @@ type (correctable vs. uncorrectable).
>  AER uses the default ratelimit of DEFAULT_RATELIMIT_BURST (10 events) over
>  DEFAULT_RATELIMIT_INTERVAL (5 seconds).
>  
> +Ratelimits are exposed in the form of sysfs attributes and configurable.
> +See Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats.

Why does the next patch immediately modify this? A patch series should try 
to avoid back and forth changes like that.

-- 
 i.

>  AER Statistics / Counters
>  -------------------------
>  
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index b46ce1a2c554..16de3093294e 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1801,6 +1801,7 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>  	&pcie_dev_attr_group,
>  #ifdef CONFIG_PCIEAER
>  	&aer_stats_attr_group,
> +	&aer_attr_group,
>  #endif
>  #ifdef CONFIG_PCIEASPM
>  	&aspm_ctrl_attr_group,
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9d63d32f041c..34633fe12201 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -889,6 +889,7 @@ void pci_no_aer(void);
>  void pci_aer_init(struct pci_dev *dev);
>  void pci_aer_exit(struct pci_dev *dev);
>  extern const struct attribute_group aer_stats_attr_group;
> +extern const struct attribute_group aer_attr_group;
>  void pci_aer_clear_fatal_status(struct pci_dev *dev);
>  int pci_aer_clear_status(struct pci_dev *dev);
>  int pci_aer_raw_clear_status(struct pci_dev *dev);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 0bd20c4993d4..13227a94c9f9 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -631,6 +631,99 @@ const struct attribute_group aer_stats_attr_group = {
>  	.is_visible = aer_stats_attrs_are_visible,
>  };
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
>  void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info)
>  {
>  	unsigned long status = info->status & ~info->mask;
> 


