Return-Path: <linux-pci+bounces-42102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4211BC889CE
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 09:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 286474E2B7E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 08:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EDC29D269;
	Wed, 26 Nov 2025 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5J6Nj+M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E191E30FC1D
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764145253; cv=none; b=nhWQuYe9s9J4YOhUxhyWmlpm9lxatt6O0xT1EBIbRZ+EbhkVMKOGiyz3BouHR8sl97JTW2Z64agmD36bKLJr09KuL2iLnHRgtQgvfn6y0kvAEDdPsLzXb2qTlmqhAG0X7m7ocWYk/FUM+Gr4MOYZPiMgcBzDgu47WisgMDR7qBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764145253; c=relaxed/simple;
	bh=UNsPNZTcOByZ2yZ42dLf78QHyh4z6PJR1pD9m1BmZYc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VdY74fG6GhHqIWemsM7Al05PIm2hCgeZxv7sgKbvvhL5rz+Bl5bx4vJ8aDk/X0rd/Mv5G4Kw0Gx6ytpooZgZLVXTkzCDdqLnnQNMZpGiECQ0flZPhrolOIau9BMeMkZQPCRTYyRVTFxwlJVEv0vjYwPh4u4MoVEGNgMV7Dj3ek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5J6Nj+M; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764145251; x=1795681251;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UNsPNZTcOByZ2yZ42dLf78QHyh4z6PJR1pD9m1BmZYc=;
  b=B5J6Nj+Mlxr0LgVxxUl0nvS9X4mgHz4ussdwkh2eh19cSnl6LZjZkW1R
   7Ru6Dz1EbmbRnpvx5kHXHy/WpoIqI1glwscMroH8lFXZQ2w82PWk9UTyh
   2plX2aVHv1loM5i+AQXFROS/mIc5EN2jXmdGwjZCUimouW7lf/usCyBgZ
   PGHeDtpOXZq/xVYHN5aYlFR9AkhwnclyFGGfAYcJqnFayTLJ89/gw3DEx
   maF0TSQKkayzBr3QfINFUzWierTU4W9I3WLq4sqzAbt5NpapxiHq1opzN
   BA5i6CjiFZdnQnkqpa5lLmxjW73DFO7seT1id8Y4kJhWuPNhJ7cC/2486
   w==;
X-CSE-ConnectionGUID: XllTSIs3RtK5gPiBgstzOQ==
X-CSE-MsgGUID: kKh8SkndTPSj4C8OinaI2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="65362403"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="65362403"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 00:20:50 -0800
X-CSE-ConnectionGUID: 25oy/Mx1QEaOsMv1BYAKpQ==
X-CSE-MsgGUID: HGZPxo2BRNCpzlWekvhwSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="197197376"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 00:20:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 26 Nov 2025 10:20:44 +0200 (EET)
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, kanie@linux.alibaba.com, 
    alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH] PCI: Fix PCIe SBR dev/link wait error
In-Reply-To: <20251124104502.777141-1-guanghuifeng@linux.alibaba.com>
Message-ID: <bcc2c523-ed9e-59a7-d6f1-b39f4b2e8e30@linux.intel.com>
References: <20251124104502.777141-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 24 Nov 2025, Guanghui Feng wrote:

> When executing a PCIe secondary bus reset, all downstream switches and
> endpoints will generate reset events. Simultaneously, all PCIe links
> will undergo retraining, and each link will independently re-execute the
> LTSSM state machine training. Therefore, after executing the SBR, it is
> necessary to wait for all downstream links and devices to complete
> recovery. Otherwise, after the SBR returns, accessing devices with some
> links or endpoints not yet fully recovered may result in driver errors,
> or even trigger device offline issues.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/pci/pci.c | 112 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 94 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..9cf13fe69d94 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4788,9 +4788,74 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
>  	return max(min_delay, max_delay);
>  }
>  
> +int __pci_bridge_wait_for_secondary_bus(struct pci_dev *, unsigned long, char *);
> +
> +static int pci_dev_wait_child(struct pci_dev *pdev, unsigned long start_t, int timeout,
> +				char *reset_type)
> +{
> +	struct pci_dev *child, **dev = NULL;
> +	int ct = 0, i = 0, ret = 0, left = 1;
> +	unsigned long dev_start_t;
> +
> +	down_read(&pci_bus_sem);
> +
> +	list_for_each_entry(child, &pdev->subordinate->devices, bus_list)
> +		ct++;
> +
> +	if (ct) {
> +		dev = kzalloc(sizeof(struct pci_dev *) * ct, GFP_KERNEL);
> +
> +		if(!dev) {
> +			pci_err(pdev, "dev mem alloc err\n");
> +			up_read(&pci_bus_sem);
> +			return -ENOMEM;
> +		}
> +
> +		list_for_each_entry(child, &pdev->subordinate->devices, bus_list)
> +			dev[i++] = pci_dev_get(child);
> +	}
> +
> +	up_read(&pci_bus_sem);
> +
> +	for (i = 0; i < ct; ++i) {
> +		left = 1;
> +
> +dev_wait:
> +		dev_start_t = jiffies;
> +		ret = pci_dev_wait(dev[i], reset_type, left);
> +		timeout -= jiffies_to_msecs(jiffies - dev_start_t);
> +
> +		if (ret) {
> +			if (pci_dev_is_disconnected(dev[i]))
> +				continue;
> +
> +			if (timeout <= 0)
> +				goto end;
> +
> +			left <<= 1;
> +			left = timeout > left ? left : timeout;
> +			goto dev_wait;
> +		}
> +	}
> +
> +	for (i = 0; i < ct; ++i) {
> +		ret = __pci_bridge_wait_for_secondary_bus(dev[i], start_t, reset_type);

Does this add recursion without restoring config space on each level 
before starting the child wait?

> +		if (ret)
> +			break;
> +	}
> +
> +end:
> +	for (i = 0; i < ct; ++i)
> +		pci_dev_put(dev[i]);
> +
> +	kfree(dev);
> +	return ret;
> +}
> +
>  /**
> - * pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be accessible
> + * __pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be accessible
>   * @dev: PCI bridge
> + * @start_t: wait start jiffies time
>   * @reset_type: reset type in human-readable form
>   *
>   * Handle necessary delays before access to the devices on the secondary
> @@ -4804,10 +4869,9 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
>   * Return 0 on success or -ENOTTY if the first device on the secondary bus
>   * failed to become accessible.
>   */
> -int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
> +int __pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, unsigned long start_t, char *reset_type)
>  {
> -	struct pci_dev *child __free(pci_dev_put) = NULL;
> -	int delay;
> +	int delay, left;
>  
>  	if (pci_dev_is_disconnected(dev))
>  		return 0;
> @@ -4835,8 +4899,6 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  		return 0;
>  	}
>  
> -	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
> -					     struct pci_dev, bus_list));
>  	up_read(&pci_bus_sem);
>  
>  	/*
> @@ -4844,8 +4906,12 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  	 * accessing the device after reset (that is 1000 ms + 100 ms).
>  	 */
>  	if (!pci_is_pcie(dev)) {
> -		pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
> -		msleep(1000 + delay);
> +		left = 1000 + delay - jiffies_to_msecs(jiffies - start_t);
> +		pci_dbg(dev, "waiting %d ms for secondary bus\n", left > 0 ? left : 0);
> +
> +		if (left > 0)
> +			msleep(left);
> +
>  		return 0;
>  	}
>  
> @@ -4870,10 +4936,14 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
>  		u16 status;
>  
> -		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
> -		msleep(delay);
> +		left = delay - jiffies_to_msecs(jiffies - start_t);
> +		pci_dbg(dev, "waiting %d ms for downstream link\n", left > 0 ? left : 0);
> +
> +		if (left > 0)
> +			msleep(left);
>  
> -		if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
> +		left = PCI_RESET_WAIT - jiffies_to_msecs(jiffies - start_t);
> +		if(!pci_dev_wait_child(dev, start_t, left > 0 ? left : 0, reset_type))
>  			return 0;
>  
>  		/*
> @@ -4888,20 +4958,26 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  		if (!(status & PCI_EXP_LNKSTA_DLLLA))
>  			return -ENOTTY;
>  
> -		return pci_dev_wait(child, reset_type,
> -				    PCIE_RESET_READY_POLL_MS - PCI_RESET_WAIT);
> +		left = PCIE_RESET_READY_POLL_MS - jiffies_to_msecs(jiffies - start_t);
> +		return pci_dev_wait_child(dev, start_t, left > 0 ? left : 0, reset_type);
>  	}
>  
> -	pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
> -		delay);
> -	if (!pcie_wait_for_link_delay(dev, true, delay)) {
> +	left = delay - jiffies_to_msecs(jiffies - start_t);
> +	pci_dbg(dev, "waiting %d ms for downstream link, after activation\n", left > 0 ? left : 0);
> +
> +	if (!pcie_wait_for_link_delay(dev, true, left > 0 ? left : 0)) {
>  		/* Did not train, no need to wait any further */
>  		pci_info(dev, "Data Link Layer Link Active not set in %d msec\n", delay);
>  		return -ENOTTY;
>  	}
>  
> -	return pci_dev_wait(child, reset_type,
> -			    PCIE_RESET_READY_POLL_MS - delay);
> +	left = PCIE_RESET_READY_POLL_MS - jiffies_to_msecs(jiffies - start_t);
> +	return pci_dev_wait_child(dev, start_t, left > 0 ? left : 0, reset_type);
> +}
> +
> +int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
> +{
> +	return __pci_bridge_wait_for_secondary_bus(dev, jiffies, reset_type);
>  }
>  
>  void pci_reset_secondary_bus(struct pci_dev *dev)
> 

-- 
 i.


