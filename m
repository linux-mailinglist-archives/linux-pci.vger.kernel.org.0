Return-Path: <linux-pci+bounces-20593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC3DA23F2C
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 15:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE36163534
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 14:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB5A1C3316;
	Fri, 31 Jan 2025 14:32:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72831145324
	for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2025 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738333975; cv=none; b=YmocQIcCsbgThYrytjsIvgXukzFdLeXiC+yjyJFRhRbadhbb+yYxVaQd3B3SemNK5f/nG0u01jhcaZ9cXDxM60akvhGwWM6vUKGDV2WmPCMB2pW+E4DcXhbAc3I2Hqp2JGqQOCRBPnruJ74/4RoGHU2Q5Qjx11x9tcsifYiq2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738333975; c=relaxed/simple;
	bh=a6YXLePIuW1xL2vCE3djiKsB007uorQ1dc5jwhlyXdE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiaRX/ytz+N8AYA9VuAftly4u+pC6yYV2c+ZfTiq6Eis501ogkcvJXyHbG2BoEOJqktL0sk3HVworVsWjVnWks3Hwg6rglgCJkuafit0iwn0WVwdpUPTfyEwQiYLkYizBNxmPG2GKReh6pfd8YVtFGdaQM66tiSOz8yZ3KFRvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ykyyb1HKZz6K7kc;
	Fri, 31 Jan 2025 22:32:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F1F4B140A9C;
	Fri, 31 Jan 2025 22:32:48 +0800 (CST)
Received: from localhost (10.195.244.178) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 Jan
 2025 15:32:48 +0100
Date: Fri, 31 Jan 2025 14:32:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jon Pan-Doh <pandoh@google.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek
	<karolina.stolarek@oracle.com>, <linux-pci@vger.kernel.org>, Martin Petersen
	<martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, "Drew
 Walton" <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, Tony
 Luck <tony.luck@intel.com>
Subject: Re: [PATCH 6/8] PCI/AER: Add AER sysfs attributes for ratelimits
Message-ID: <20250131143246.000037a2@huawei.com>
In-Reply-To: <20250115074301.3514927-7-pandoh@google.com>
References: <20250115074301.3514927-1-pandoh@google.com>
	<20250115074301.3514927-7-pandoh@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 14 Jan 2025 23:42:58 -0800
Jon Pan-Doh <pandoh@google.com> wrote:

> Allow userspace to read/write ratelimits per device. Create aer/ sysfs
> directory to store them and any future aer configs.
> 
> Tested using aer-inject[1] tool. Configured correctable log/irq ratelimits
> to 5/10 respectively. Sent 12 AER errors. Observed 5 errors logged while
> AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) shows 11
> (1 masked).
> 
> Before: CEMsk: BadTLP-
> After:  CEMsk: BadTLP+.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> 
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>  .../testing/sysfs-bus-pci-devices-aer_stats   | 32 +++++++++++
>  Documentation/PCI/pcieaer-howto.rst           |  4 +-
>  drivers/pci/pci-sysfs.c                       |  1 +
>  drivers/pci/pci.h                             |  1 +
>  drivers/pci/pcie/aer.c                        | 56 +++++++++++++++++++
>  5 files changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> index d1f67bb81d5d..c680a53af0f4 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> @@ -117,3 +117,35 @@ Date:		July 2018
>  KernelVersion:	4.19.0
>  Contact:	linux-pci@vger.kernel.org, rajatja@google.com
>  Description:	Total number of ERR_NONFATAL messages reported to rootport.
> +
> +PCIe AER ratelimits
> +----------------------------

Purely from an rst formatting point of view (this gets picked up in the docs
build) --- should extend I think only under the text.

> +
> +These attributes show up under all the devices that are AER capable. Provides
> +configurable ratelimits of logs/irq per error type. Writing a nonzero value
> +changes the number of errors (burst) allowed per 5 second window before
> +ratelimiting. Reading gets the current ratelimits.
> +
> +What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_cor_irq
> +Date:		Jan 2025
> +KernelVersion:	6.14.0
> +Contact:	linux-pci@vger.kernel.org, pandoh@google.com
> +Description:	IRQ ratelimit for correctable errors.

I would add enough info that we can understand what values to write and what
to read to each description.  This doc didn't lead me to the comment below
and it should have done...

> +
> +What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_uncor_irq
> +Date:		Jan 2025
> +KernelVersion:	6.14.0
> +Contact:	linux-pci@vger.kernel.org, pandoh@google.com
> +Description:	IRQ ratelimit for uncorrectable errors.
> +
> +What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_cor_log
> +Date:		Jan 2025
> +KernelVersion:	6.14.0
> +Contact:	linux-pci@vger.kernel.org, pandoh@google.com
> +Description:	Log ratelimit for correctable errors.
> +
> +What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_uncor_log
> +Date:		Jan 2025
> +KernelVersion:	6.14.0
> +Contact:	linux-pci@vger.kernel.org, pandoh@google.com
> +Description:	Log ratelimit for uncorrectable errors.
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index d41272504b18..4d5b0638f120 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -89,7 +89,9 @@ AER Ratelimits
>  -------------------------
>  
>  Errors, both at log and IRQ level, are ratelimited per device and error type.
> -This prevents spammy devices from stalling execution.
> +This prevents spammy devices from stalling execution. Ratelimits are exposed
> +in the form of sysfs attributes and configurable. See
> +Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
>  
>  AER Statistics / Counters
>  -------------------------
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 7679d75d71e5..41acb6713e2d 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1693,6 +1693,7 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>  	&pcie_dev_attr_group,
>  #ifdef CONFIG_PCIEAER
>  	&aer_stats_attr_group,
> +	&aer_attr_group,
>  #endif
>  #ifdef CONFIG_PCIEASPM
>  	&aspm_ctrl_attr_group,
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e40fc63ba31..9d0272a890ef 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -881,6 +881,7 @@ void pci_no_aer(void);
>  void pci_aer_init(struct pci_dev *dev);
>  void pci_aer_exit(struct pci_dev *dev);
>  extern const struct attribute_group aer_stats_attr_group;
> +extern const struct attribute_group aer_attr_group;
>  void pci_aer_clear_fatal_status(struct pci_dev *dev);
>  int pci_aer_clear_status(struct pci_dev *dev);
>  int pci_aer_raw_clear_status(struct pci_dev *dev);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 1db70ae87f52..e48e2951baae 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -630,6 +630,62 @@ const struct attribute_group aer_stats_attr_group = {
>  	.is_visible = aer_stats_attrs_are_visible,
>  };
>  
> +#define aer_ratelimit_attr(name, ratelimit)				\
> +	static ssize_t							\
> +	name##_show(struct device *dev, struct device_attribute *attr,	\
> +		     char *buf)						\
> +{									\
> +	struct pci_dev *pdev = to_pci_dev(dev);				\
> +	return sysfs_emit(buf, "%u errors every %u seconds\n",	\
> +			  pdev->aer_info->ratelimit.burst,		\
> +			  pdev->aer_info->ratelimit.interval / HZ);	\

Usual rule of thumb is you need a very strong reason to read something
different from what was written to a sysfs file.


I think your interval is fixed? If so name the files so that is apparent
and just have a count returned here.  Or if you want to future proof
add a read only ratelimit_period_secs file that prints 5


ratelimit_in_5secs_uncor_log etc.


> +}									\
> +									\
> +	static ssize_t							\
> +	name##_store(struct device *dev, struct device_attribute *attr,	\
> +		     const char *buf, size_t count)				\
> +{									\
> +	struct pci_dev *pdev = to_pci_dev(dev);				\
> +	int burst;							\
> +									\
> +	if (kstrtoint(buf, 0, &burst) < 0)				\
> +		return -EINVAL;						\
> +									\
> +	pdev->aer_info->ratelimit.burst = burst;			\
> +	return count;							\
> +}									\
> +static DEVICE_ATTR_RW(name)


