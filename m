Return-Path: <linux-pci+bounces-27078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AF2AA65B9
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 23:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9D3F7A5C2F
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 21:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273FF226D00;
	Thu,  1 May 2025 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZCb6p+6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014B21F4608
	for <linux-pci@vger.kernel.org>; Thu,  1 May 2025 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135813; cv=none; b=LbK3WLNnu2hBlawwRb1thhGyZHWBwmqqs6vaAaz5Udr9GMHBpK/OU5SwSJX3ShK4ZXGCvsDoh8xd2mpD31axODazdgqTIOrsdn5q5+NdDibEYJi5WxwqbF7uW6f4npbUrXRcuG2id38NU8e3LiJrbZwd7U0laxh6NiG5scYpVts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135813; c=relaxed/simple;
	bh=NCVkwU3Me6tu/j/7H8xvaLzczrU6JR8qeD5IGtliCMY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MQr9K7rF2A035o210scZVJGO1JMF5HO6tpJ0bNhQcnYtoAYksYXxMphPG8g7xgn6mwevHnRWmmr51y+wXdup+Y7ltdbc+SB5fqq9i4gOjP44kgtGcTt8+WOTzuT3mW+SYKwCtRnDH/lX60igdGTkj5yEZ+60dr5pzo2Wnuzv8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZCb6p+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53145C4CEE3;
	Thu,  1 May 2025 21:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746135812;
	bh=NCVkwU3Me6tu/j/7H8xvaLzczrU6JR8qeD5IGtliCMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sZCb6p+6Oh22sm4CX+ScoPK+E2tt0tHxqqnUWfJKDuiYITtAd2QCCEPHDykyLkafZ
	 MCvXJYrIiWHSLtG35PhqH99JT/EA0s5UXp+jKnWDP5S21MCnCcQJLQ6emehgUxqRBd
	 qujEByOMFlJNWCA2VlB65ua1Fr1XuMrjiBBHH0gd1xFmnGl9Yh+kHTDCh1MJtoHWew
	 h6IuxN3CqrqZQ3xhsluQrdgmxtvMzhoL5jWa4ZQFdviJItZTTi39EE8cGTHDCduWDm
	 9aDMixfsQAWGFsvbX9tfdkw0q6MjSB/vTKIbxjY9+Pn8GC4VbbhbEOoP+XTN7fXLKV
	 x8+YRLTFGTgiA==
Date: Thu, 1 May 2025 16:43:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v5 1/8] PCI/AER: Check log level once and propagate down
Message-ID: <20250501214331.GA782778@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321015806.954866-2-pandoh@google.com>

On Thu, Mar 20, 2025 at 06:57:59PM -0700, Jon Pan-Doh wrote:
> From: Karolina Stolarek <karolina.stolarek@oracle.com>
> 
> When reporting an AER error, we check its type multiple times
> to determine the log level for each message. Do this check only
> in the top-level functions (aer_isr_one_error(), pci_print_aer()) and
> propagate the result down the call chain.
> 
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Reported-by: Sargun Dhillon <sargun@meta.com>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Jon Pan-Doh <pandoh@google.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pci.h      |  2 +-
>  drivers/pci/pcie/aer.c | 34 +++++++++++++++++-----------------
>  drivers/pci/pcie/dpc.c |  2 +-
>  3 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b8911d1e10dc..75985b96ecc1 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -551,7 +551,7 @@ struct aer_err_info {
>  };
>  
>  int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
> -void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
> +void aer_print_error(struct pci_dev *dev, struct aer_err_info *info, const char *level);

I'm (finally) getting back to this series because it really needs to
make v6.16.

It would definitely be nice to determine the log level once instead of
several times, but I'm not sure I like passing "level" through the
whole chain because it seems like a lot of change to get that benefit:

  - it changes the prototype for __aer_print_error(),
    aer_print_error(), and aer_process_err_devices()

  - it removes the info->severity test from aer_print_error(), but
    leaves it in __aer_print_error() and pci_print_aer(), which need
    it for other reasons

All these functions take a pointer to a struct aer_err_info, and if we
want to compute the log level once, maybe we could stash the result in
struct aer_err_info, similar to what we did with ratelimited[] here:
https://lore.kernel.org/all/20250321015806.954866-7-pandoh@google.com/

I'm rebasing this series to v6.15-rc1 and will post a v6 proposal
soon.

>  int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>  		      unsigned int tlp_len, bool flit,
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9cff7069577e..45629e1ea058 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -670,20 +670,18 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>  }
>  
>  static void __aer_print_error(struct pci_dev *dev,
> -			      struct aer_err_info *info)
> +			      struct aer_err_info *info,
> +			      const char *level)
>  {
>  	const char **strings;
>  	unsigned long status = info->status & ~info->mask;
> -	const char *level, *errmsg;
> +	const char *errmsg;
>  	int i;
>  
> -	if (info->severity == AER_CORRECTABLE) {
> +	if (info->severity == AER_CORRECTABLE)
>  		strings = aer_correctable_error_string;
> -		level = KERN_WARNING;
> -	} else {
> +	else
>  		strings = aer_uncorrectable_error_string;
> -		level = KERN_ERR;
> -	}
>  
>  	for_each_set_bit(i, &status, 32) {
>  		errmsg = strings[i];
> @@ -696,11 +694,11 @@ static void __aer_print_error(struct pci_dev *dev,
>  	pci_dev_aer_stats_incr(dev, info);
>  }
>  
> -void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> +void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
> +		     const char *level)
>  {
>  	int layer, agent;
>  	int id = pci_dev_id(dev);
> -	const char *level;
>  
>  	if (!info->status) {
>  		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> @@ -711,8 +709,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>  	agent = AER_GET_AGENT(info->severity, info->status);
>  
> -	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
> -
>  	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
>  		   aer_error_severity_string[info->severity],
>  		   aer_error_layer[layer], aer_agent_string[agent]);
> @@ -720,7 +716,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
>  		   dev->vendor, dev->device, info->status, info->mask);
>  
> -	__aer_print_error(dev, info);
> +	__aer_print_error(dev, info, level);
>  
>  	if (info->tlp_header_valid)
>  		pcie_print_tlp_log(dev, &info->tlp, dev_fmt("  "));
> @@ -765,15 +761,18 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  {
>  	int layer, agent, tlp_header_valid = 0;
>  	u32 status, mask;
> +	const char *level;
>  	struct aer_err_info info;
>  
>  	if (aer_severity == AER_CORRECTABLE) {
>  		status = aer->cor_status;
>  		mask = aer->cor_mask;
> +		level = KERN_WARNING;
>  	} else {
>  		status = aer->uncor_status;
>  		mask = aer->uncor_mask;
>  		tlp_header_valid = status & AER_LOG_TLP_MASKS;
> +		level = KERN_ERR;
>  	}
>  
>  	layer = AER_GET_LAYER_ERROR(aer_severity, status);
> @@ -786,7 +785,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>  
>  	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> -	__aer_print_error(dev, &info);
> +	__aer_print_error(dev, &info, level);
>  	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
>  		aer_error_layer[layer], aer_agent_string[agent]);
>  
> @@ -1257,14 +1256,15 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>  	return 1;
>  }
>  
> -static inline void aer_process_err_devices(struct aer_err_info *e_info)
> +static inline void aer_process_err_devices(struct aer_err_info *e_info,
> +					   const char *level)
>  {
>  	int i;
>  
>  	/* Report all before handle them, not to lost records by reset etc. */
>  	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>  		if (aer_get_device_error_info(e_info->dev[i], e_info))
> -			aer_print_error(e_info->dev[i], e_info);
> +			aer_print_error(e_info->dev[i], e_info, level);
>  	}
>  	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>  		if (aer_get_device_error_info(e_info->dev[i], e_info))
> @@ -1300,7 +1300,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  		aer_print_port_info(pdev, &e_info);
>  
>  		if (find_source_device(pdev, &e_info))
> -			aer_process_err_devices(&e_info);
> +			aer_process_err_devices(&e_info, KERN_WARNING);
>  	}
>  
>  	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
> @@ -1319,7 +1319,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  		aer_print_port_info(pdev, &e_info);
>  
>  		if (find_source_device(pdev, &e_info))
> -			aer_process_err_devices(&e_info);
> +			aer_process_err_devices(&e_info, KERN_ERR);
>  	}
>  }
>  
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index df42f15c9829..9e4c9ac737a7 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -289,7 +289,7 @@ void dpc_process_error(struct pci_dev *pdev)
>  	else if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR &&
>  		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
>  		 aer_get_device_error_info(pdev, &info)) {
> -		aer_print_error(pdev, &info);
> +		aer_print_error(pdev, &info, KERN_ERR);
>  		pci_aer_clear_nonfatal_status(pdev);
>  		pci_aer_clear_fatal_status(pdev);
>  	}
> -- 
> 2.49.0.395.g12beb8f557-goog
> 

