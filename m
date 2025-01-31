Return-Path: <linux-pci+bounces-20596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7CCA23F4C
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 15:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DBD1889F5A
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A311C5486;
	Fri, 31 Jan 2025 14:55:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451354502A
	for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738335323; cv=none; b=T9cxR5h1p69jjucNgiX8GrZ+fvJXa7jyw/mWX7zasHB6GnfGJtL9Kfvxj3fqYo6ZR3ggWW6/H3yxCuTJxr4R2XLi8gWlnOfNui0+Hu9/ONJz0OPZSAHDnZJgc0f9b/9zza/zRg/8Rwq8G8BIkWbsO1H+zCfcuDTi22sjR5xcEus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738335323; c=relaxed/simple;
	bh=mFb8txXHPBIdVipBjj47tS0iypGjKd+2EOPw/B7HX+w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYfQooDcCtJiz7Ncfv+8m7v17oit7kKlXIGgunMHBigkvGO3X8mOwD6ASfNMuY9Yf+jnIi5Y5WOj3TUHKbiWFI1HGQG4rF2TgtaM67FVWhv+6TulbuJJxGkDMEUubY7qczpuIz93IQ7R3zAC1XLHF1f+GEcMUElk5oBoNOe8UZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkzQs08qgz6D92t;
	Fri, 31 Jan 2025 22:53:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 81DF1140155;
	Fri, 31 Jan 2025 22:55:17 +0800 (CST)
Received: from localhost (10.195.244.178) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 Jan
 2025 15:55:16 +0100
Date: Fri, 31 Jan 2025 14:55:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jon Pan-Doh <pandoh@google.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek
	<karolina.stolarek@oracle.com>, <linux-pci@vger.kernel.org>, Martin Petersen
	<martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, "Drew
 Walton" <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, Tony
 Luck <tony.luck@intel.com>
Subject: Re: [PATCH 5/8] PCI/AER: Introduce ratelimit for AER IRQs
Message-ID: <20250131145515.000049f9@huawei.com>
In-Reply-To: <20250115074301.3514927-6-pandoh@google.com>
References: <20250115074301.3514927-1-pandoh@google.com>
	<20250115074301.3514927-6-pandoh@google.com>
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

On Tue, 14 Jan 2025 23:42:57 -0800
Jon Pan-Doh <pandoh@google.com> wrote:

> After ratelimiting logs, spammy devices can still slow execution by
> continued AER IRQ servicing.
> 
> Add higher per-device ratelimits for AER errors to mask out those IRQs.
> Set the default rate to 3x default AER ratelimit (30 per 5s).
> 
> Tested using aer-inject[1] tool. Injected 32 AER errors. Observed IRQ
> masked via lspci and sysfs counters record 31 errors (1 masked).
> 
> Before: CEMsk: BadTLP-
> After:  CEMsk: BadTLP+
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> 
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Hi Jon,

Comment inline.

> ---
>  Documentation/PCI/pcieaer-howto.rst |  4 +-
>  drivers/pci/pcie/aer.c              | 64 +++++++++++++++++++++++++----
>  2 files changed, 57 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index 5546de60f184..d41272504b18 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -88,8 +88,8 @@ fields.
>  AER Ratelimits
>  -------------------------
>  
> -Error messages are ratelimited per device and error type. This prevents spammy
> -devices from flooding the console.
> +Errors, both at log and IRQ level, are ratelimited per device and error type.
> +This prevents spammy devices from stalling execution.
>  
>  AER Statistics / Counters
>  -------------------------
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 025c50b0f293..1db70ae87f52 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -87,6 +87,8 @@ struct aer_info {
>  	u64 rootport_total_nonfatal_errs;
>  
>  	/* Ratelimits for errors */
> +	struct ratelimit_state cor_irq_ratelimit;
> +	struct ratelimit_state uncor_irq_ratelimit;
>  	struct ratelimit_state cor_log_ratelimit;
>  	struct ratelimit_state uncor_log_ratelimit;
>  };
> @@ -379,6 +381,10 @@ void pci_aer_init(struct pci_dev *dev)
>  		return;
>  
>  	dev->aer_info = kzalloc(sizeof(struct aer_info), GFP_KERNEL);
> +	ratelimit_state_init(&dev->aer_info->cor_irq_ratelimit,
> +			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST*3);
> +	ratelimit_state_init(&dev->aer_info->uncor_irq_ratelimit,
> +			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST*3);
>  	ratelimit_state_init(&dev->aer_info->cor_log_ratelimit,
>  			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
>  	ratelimit_state_init(&dev->aer_info->uncor_log_ratelimit,
> @@ -676,6 +682,39 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>  	}
>  }
>  
> +static void mask_reported_error(struct pci_dev *dev, struct aer_err_info *info)
> +{
> +	const char **strings;
> +	const char *errmsg;
> +	u16 aer_offset = dev->aer_cap;
> +	u16 mask_reg_offset;
> +	u32 mask;
> +	unsigned long status = info->status;
> +	int i;
> +
> +	if (info->severity == AER_CORRECTABLE) {
> +		strings = aer_correctable_error_string;
> +		mask_reg_offset = PCI_ERR_COR_MASK;
> +	} else {
> +		strings = aer_uncorrectable_error_string;
> +		mask_reg_offset = PCI_ERR_UNCOR_MASK;
> +	}
> +
> +	pci_read_config_dword(dev, aer_offset + mask_reg_offset, &mask);
> +	mask |= status;
> +	pci_write_config_dword(dev, aer_offset + mask_reg_offset, mask);
> +
> +	pci_warn(dev, "%s error(s) masked due to rate-limiting:",
> +		 aer_error_severity_string[info->severity]);
> +	for_each_set_bit(i, &status, 32) {
> +		errmsg = strings[i];
> +		if (!errmsg)
> +			errmsg = "Unknown Error Bit";
> +
> +		pci_warn(dev, "   [%2d] %-22s\n", i, errmsg);
> +	}
> +}
> +
>  static void __print_tlp_header(struct pci_dev *dev, struct pcie_tlp_log *t)
>  {
>  	pci_err(dev, "  TLP Header: %08x %08x %08x %08x\n",
> @@ -713,7 +752,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  	int layer, agent;
>  	int id = pci_dev_id(dev);
>  	const char *level;
> -	struct ratelimit_state *ratelimit;
> +	struct ratelimit_state *irq_ratelimit;
> +	struct ratelimit_state *log_ratelimit;
>  
>  	if (!info->status) {
>  		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> @@ -722,14 +762,20 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  	}
>  
>  	if (info->severity == AER_CORRECTABLE) {
> -		ratelimit = &dev->aer_info->cor_log_ratelimit;
> +		irq_ratelimit = &dev->aer_info->cor_irq_ratelimit;
> +		log_ratelimit = &dev->aer_info->cor_log_ratelimit;
>  		level = KERN_WARNING;
>  	} else {
> -		ratelimit = &dev->aer_info->uncor_log_ratelimit;
> +		irq_ratelimit = &dev->aer_info->uncor_irq_ratelimit;
> +		log_ratelimit = &dev->aer_info->uncor_log_ratelimit;
>  		level = KERN_ERR;
>  	}
>  
> -	if (!__ratelimit(ratelimit))
> +	if (!__ratelimit(irq_ratelimit)) {
> +		mask_reported_error(dev, info);
> +		return;
So if I follow correctly.  We count irqs for any error type and
then mask whatever was set on one that triggered this rate_limit check?
That last one isn't reported other than via a log message.

Imagine that is a totally unrelated error to the earlier ones,
now RASDaemon has no info on it at all as the tracepoint never
fired.  To me that's a very different situation to it knowing there
were 10 errors of the type vs more.

I'd like to see that final trace point and also to see a tracepoint
that lets rasdaemon etc know you cut off errors after this point
+ rasdaemon support for using that.

Terry can address if we need to do anything different for CXL given
he is updating this handling for that.  Superficially I think we
need to driver the masking down into the CXL RAS capability registers.
Internal error in the AER capabilities is far to big a hammer to apply.

> +	}
> +	if (!__ratelimit(log_ratelimit))
>  		return;
>  
>  	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
> @@ -776,14 +822,14 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  	int layer, agent, tlp_header_valid = 0;
>  	u32 status, mask;
>  	struct aer_err_info info;
> -	struct ratelimit_state *ratelimit;
> +	struct ratelimit_state *log_ratelimit;
>  
>  	if (aer_severity == AER_CORRECTABLE) {
> -		ratelimit = &dev->aer_info->cor_log_ratelimit;
> +		log_ratelimit = &dev->aer_info->cor_log_ratelimit;
>  		status = aer->cor_status;
>  		mask = aer->cor_mask;
>  	} else {
> -		ratelimit = &dev->aer_info->uncor_log_ratelimit;
> +		log_ratelimit = &dev->aer_info->uncor_log_ratelimit;
>  		status = aer->uncor_status;
>  		mask = aer->uncor_mask;
>  		tlp_header_valid = status & AER_LOG_TLP_MASKS;
> @@ -799,8 +845,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>  
>  	pci_dev_aer_stats_incr(dev, &info);
> -
> -	if (!__ratelimit(ratelimit))
> +	/* Only ratelimit logs (no IRQ) as AERs reported via GHES/CXL (caller). */
> +	if (!__ratelimit(log_ratelimit))
>  		return;
>  
>  	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);


