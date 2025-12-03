Return-Path: <linux-pci+bounces-42573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C32C9F540
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 15:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 3267D3001078
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBA62FFF8F;
	Wed,  3 Dec 2025 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xthtkq88"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC022FFDFA
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764772882; cv=none; b=GBqY+xBguwZHhX3S3a5z4AILpYdiU9gxHLv5tVGzgi0Z+Y5Hvw9qNIGEnT4djJr7nDYHiKBw8GR/Oo7ewKfuA5Voi15w/EPWHI3mC5JccblAlfQKYdTleWtBJZKPRkm9RYBey6c9LRrlwfsQ4O+6v0i93ogl7yqG9imDolh/YW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764772882; c=relaxed/simple;
	bh=bnQ6nnm+duPgx2WaTPlbGGwXVCIuJCV76LKyMp4W6Co=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uR1wrWnta2LSGNN/ZsU7CFjFpUFo8xecY1gwlEkfkqDd/lzXV1k73U784+2MwrjRdYYwEXaH31AO1DCw1oyRH0d/MI7Z37MsEQzdpOMzuFbehz3Gipgo44YOre0GwbF7ZmgpDZk8CbwmTDGlrxLoemMXVuq8LjAG16Pk8GYHpw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xthtkq88; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764772880; x=1796308880;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bnQ6nnm+duPgx2WaTPlbGGwXVCIuJCV76LKyMp4W6Co=;
  b=Xthtkq88/4g6syK0orJ/Ubc3wlBR7AXHtKenREMoCeZGzkRzao0I5sqI
   +Dc8bCEox6c5UWleqrXTWEt+Dyu5l9qFrHpZG1QxXy26q72/4mlgHKiVg
   V1CmRDxyAUlTWSLZmIVxXZZv1nZhpHJT/uNuZSmcXjK40/rA463b04OQH
   hfowqd6lqePURJD2kB5vvMsZjnOvM8rQ5Wt0BYWpe0pvfk3gSqVZ4V1Ql
   eYGbnMxvQUHymgMzlE0KRmFb17UGDzcfZHkp9zVJ11/qTbys662rQKr2R
   cuoXek+JTHfJjkmDQPdy7MGY527HhbBPRr5P7mCsV1VWEmaOAtk+Q/TKW
   w==;
X-CSE-ConnectionGUID: v3hfTC2pTpa0poYBJeIKyw==
X-CSE-MsgGUID: DDgKUDxgT26dQHa+p6XbJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="70616651"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="70616651"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 06:41:19 -0800
X-CSE-ConnectionGUID: LdmbtAlEQyuLRoMhLYIgSA==
X-CSE-MsgGUID: zy/sNxRFSCqh3haYcZDWkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="193788262"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.57])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 06:41:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 3 Dec 2025 16:41:12 +0200 (EET)
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
cc: linux-pci@vger.kernel.org, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v4 v4 1/1] PCI: Fix PCIe SBR dev/link wait error
In-Reply-To: <20251202043207.3924714-2-guanghuifeng@linux.alibaba.com>
Message-ID: <a9d344b5-8d24-f824-9fb7-3096c9cfdf4b@linux.intel.com>
References: <d285f1b6-8758-efd3-da0e-6448033519fc@linux.intel.com> <20251202043207.3924714-1-guanghuifeng@linux.alibaba.com> <20251202043207.3924714-2-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 2 Dec 2025, Guanghui Feng wrote:

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
> Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/pci/pci.c | 143 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 103 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..9cf0e58ef23f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4788,6 +4788,63 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
>  	return max(min_delay, max_delay);
>  }
>  
> +static int pci_readiness_check(struct pci_dev *pdev, struct pci_dev *child,
> +		unsigned long start_t, char *reset_type)
> +{
> +	int elapsed = jiffies_to_msecs(jiffies - start_t);
> +
> +	if (pci_dev_is_disconnected(pdev) || pci_dev_is_disconnected(child))
> +		return 0;
> +
> +	if (pcie_get_speed_cap(pdev) <= PCIE_SPEED_5_0GT) {
> +		u16 status;
> +
> +		pci_dbg(pdev, "waiting %d ms for downstream link\n", elapsed);
> +
> +		if (!pci_dev_wait(child, reset_type, 0))
> +			return 0;
> +
> +		if (PCI_RESET_WAIT > elapsed)
> +			return PCI_RESET_WAIT - elapsed;
> +
> +		/*
> +		 * If the port supports active link reporting we now check
> +		 * whether the link is active and if not bail out early with
> +		 * the assumption that the device is not present anymore.
> +		 */
> +		if (!pdev->link_active_reporting)
> +			return -ENOTTY;
> +
> +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &status);
> +		if (!(status & PCI_EXP_LNKSTA_DLLLA))
> +			return -ENOTTY;
> +
> +		if (!pci_dev_wait(child, reset_type, 0))
> +			return 0;
> +
> +		if (PCIE_RESET_READY_POLL_MS > elapsed)
> +			return PCIE_RESET_READY_POLL_MS - elapsed;
> +
> +		return -ENOTTY;
> +	}
> +
> +	pci_dbg(pdev, "waiting %d ms for downstream link, after activation\n",
> +		elapsed);
> +	if (!pcie_wait_for_link_delay(pdev, true, 0)) {
> +		/* Did not train, no need to wait any further */
> +		pci_info(pdev, "Data Link Layer Link Active not set in %d msec\n", elapsed);
> +		return -ENOTTY;
> +	}
> +
> +	if (!pci_dev_wait(child, reset_type, 0))
> +		return 0;
> +
> +	if (PCIE_RESET_READY_POLL_MS > elapsed)
> +		return PCIE_RESET_READY_POLL_MS - elapsed;
> +
> +	return -ENOTTY;
> +}
> +
>  /**
>   * pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be accessible
>   * @dev: PCI bridge
> @@ -4802,12 +4859,14 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
>   * 4.3.2.
>   *
>   * Return 0 on success or -ENOTTY if the first device on the secondary bus
> - * failed to become accessible.
> + * failed to become accessible or a value greater than 0 indicates the
> + * left required waiting time..
>   */
> -int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
> +static int __pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, unsigned long start_t,
> +		char *reset_type)
>  {
> -	struct pci_dev *child __free(pci_dev_put) = NULL;
> -	int delay;
> +	struct pci_dev *child;
> +	int delay, ret, elapsed = jiffies_to_msecs(jiffies - start_t);
>  
>  	if (pci_dev_is_disconnected(dev))
>  		return 0;
> @@ -4835,8 +4894,6 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  		return 0;
>  	}
>  
> -	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
> -					     struct pci_dev, bus_list));
>  	up_read(&pci_bus_sem);
>  
>  	/*
> @@ -4844,8 +4901,10 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  	 * accessing the device after reset (that is 1000 ms + 100 ms).
>  	 */
>  	if (!pci_is_pcie(dev)) {
> -		pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
> -		msleep(1000 + delay);
> +		if (1000 + delay > elapsed)
> +			return 1000 + delay - elapsed;
> +
> +		pci_dbg(dev, "waiting %d ms for secondary bus\n", elapsed);
>  		return 0;
>  	}
>  
> @@ -4867,41 +4926,47 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  	if (!pcie_downstream_port(dev))
>  		return 0;
>  
> -	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
> -		u16 status;
> -
> -		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
> -		msleep(delay);
> -
> -		if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
> -			return 0;
> +	if (delay > elapsed)
> +		return delay - elapsed;
>  
> +	down_read(&pci_bus_sem);
> +	list_for_each_entry(child, &dev->subordinate->devices, bus_list) {
>  		/*
> -		 * If the port supports active link reporting we now check
> -		 * whether the link is active and if not bail out early with
> -		 * the assumption that the device is not present anymore.
> +		 * Check if all devices under the same bus have completed
> +		 * the reset process, including multifunction devices in
> +		 * the same bus.
>  		 */
> -		if (!dev->link_active_reporting)
> -			return -ENOTTY;
> +		ret = pci_readiness_check(dev, child, start_t, reset_type);
>  
> -		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
> -		if (!(status & PCI_EXP_LNKSTA_DLLLA))
> -			return -ENOTTY;
> +		if (ret == 0 && child->subordinate) {
> +			pci_restore_config_space(child);
> +			ret = __pci_bridge_wait_for_secondary_bus(child, start_t, reset_type);

No! I'm getting tired of this. You've brushed Lukas' requests on more 
information aside and sent a new version instead (it doesn't really help 
your cause).

I've said now multiple times do not add recursion here. Instead of 
rearchitecting the approach, you're also duplicating config space restore 
here as well. Neither is justified.

The recursion is already in pci_bus_restore_locked() and it looks 
sufficient, you've never even tried to explain why it is not enough.

Also, to me looks there are two orthogonal problems which you try to mix 
up in this fix:

1. Waiting for all childs (devices multiple functions).

2. Performing waiting (an other actions) in case of nested topologies in 
   the correct order.

You should separate these on patch level to separate patch so each can be 
evaluated for its own merit.

AFAICT, 2. is only wrong in case of DPC recovery, if that's not the case 
you lack the explanation why the recursion in pci_bus_restore_locked() is 
not sufficient (don't mix up the explanation to 2. with 1. please).

It's submitters responsability to convince reviewers the patch is 
necessary, not the other way, so far I've not seen any convincing 
explanations to multiple points raised against this patch and approach it 
uses.

--
 i.

> +		}
>  
> -		return pci_dev_wait(child, reset_type,
> -				    PCIE_RESET_READY_POLL_MS - PCI_RESET_WAIT);
> +		if(ret)
> +			break;
>  	}
> +	up_read(&pci_bus_sem);
>  
> -	pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
> -		delay);
> -	if (!pcie_wait_for_link_delay(dev, true, delay)) {
> -		/* Did not train, no need to wait any further */
> -		pci_info(dev, "Data Link Layer Link Active not set in %d msec\n", delay);
> -		return -ENOTTY;
> +	return ret;
> +}
> +
> +int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
> +{
> +	int res, gap = 1;
> +	unsigned long start_t = jiffies;
> +
> +	res = __pci_bridge_wait_for_secondary_bus(dev, start_t, reset_type);
> +
> +	while (res > 0) {
> +		gap = gap < res ? gap : res;
> +		msleep(gap);
> +		gap <<= 1;
> +
> +		res = __pci_bridge_wait_for_secondary_bus(dev, start_t, reset_type);
>  	}
>  
> -	return pci_dev_wait(child, reset_type,
> -			    PCIE_RESET_READY_POLL_MS - delay);
> +	return res;
>  }
>  
>  void pci_reset_secondary_bus(struct pci_dev *dev)
> @@ -5542,10 +5607,8 @@ static void pci_bus_restore_locked(struct pci_bus *bus)
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		pci_dev_restore(dev);
> -		if (dev->subordinate) {
> -			pci_bridge_wait_for_secondary_bus(dev, "bus reset");
> +		if (dev->subordinate)
>  			pci_bus_restore_locked(dev->subordinate);
> -		}
>  	}
>  }
>  
> @@ -5575,14 +5638,14 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
>  {
>  	struct pci_dev *dev;
>  
> +	pci_bridge_wait_for_secondary_bus(slot->bus->self, "slot reset");
> +
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>  		if (!dev->slot || dev->slot != slot)
>  			continue;
>  		pci_dev_restore(dev);
> -		if (dev->subordinate) {
> -			pci_bridge_wait_for_secondary_bus(dev, "slot reset");
> +		if (dev->subordinate)
>  			pci_bus_restore_locked(dev->subordinate);
> -		}
>  	}
>  }
>  
> 

