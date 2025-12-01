Return-Path: <linux-pci+bounces-42350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFB8C965E7
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 10:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BEFE4E03ED
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641942D97A9;
	Mon,  1 Dec 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5CORQfq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8AE1FDA
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764581099; cv=none; b=lDKqo1Tzi88OvzGNH3OJqzKCE5ASm2/btYAWJ8Tss6sHwRXbLRHd3QZTUkEOcTVVVxyiwXiNLlj5pcleGqip+HxaHAJ7ULoqNAIq2NMBXjLkyRKPhmDO/szuZY0IzVjHmIudCioyzeYCszCk7YwyXuHrHhfymmbBYuljkig9+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764581099; c=relaxed/simple;
	bh=rEsItsVqH3cXcNraoFgLVgV3/Rr/bC0qaGDyAZ8/J9U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q9fBBAna9s9w2elNkn3ME/ERb8/E8L1Sl+LJV+rYzXy4J7p2LPZ2UWp5R2OieJA1vs6ZNhBa8gn9l9azXTyb2m+Z+3QuoMpjpZRyO/cZ72lyoenPn4YrPQAiRq8ZuBFOD9cg1Fphgl1AFlsseq+CqaLEQRVH28zXt4JCzFi9GCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W5CORQfq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764581097; x=1796117097;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rEsItsVqH3cXcNraoFgLVgV3/Rr/bC0qaGDyAZ8/J9U=;
  b=W5CORQfqJp13air81fxOachz6a2ta9SQEMLwzxQ3LTf2IgPL7DpaAFaK
   1DfNHN3H1UzjX+au+QHAQz/Jvve6arTMIdkfoia753rxmDML506cByZp0
   tQil/fOnxuJUh/zM38vSqWed3/uKf8fIqvmG0em//wtTTIZoQOQVH4bro
   A9RlCEt2n6Fen3JLrRxIAtZsaNFxRDCxRBzDvdfUAvKqnl6jwxpiu0DcP
   MrdqudXB/zfKRwIjsf39WE3iVitceiYZ2BUCDzY3V1+zBHP/epLJwq1Hp
   /R2s/Z0A9u5f9mSFu9qpgvW1jIZZ2Udg9vPZRj3lI3y4cGY1pe64uHopx
   Q==;
X-CSE-ConnectionGUID: P6nTnxwQTdiKWXOMxoJoWw==
X-CSE-MsgGUID: 4gI4YcUMRBu5UpRI7Qb5Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="70126922"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="70126922"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 01:24:57 -0800
X-CSE-ConnectionGUID: VsK7u9QXQGGT948UiQxcMQ==
X-CSE-MsgGUID: H99B5n/pQw+c3MydUre9ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="198218320"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.202])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 01:24:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 1 Dec 2025 11:24:51 +0200 (EET)
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v3] PCI: Fix PCIe SBR dev/link wait error
In-Reply-To: <20251130051735.3123755-1-guanghuifeng@linux.alibaba.com>
Message-ID: <1086aed0-584b-4ab3-1b84-687e53ddddf9@linux.intel.com>
References: <2e3a1e6b-40ae-3878-e237-fb9032796af8@linux.intel.com> <20251130051735.3123755-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 30 Nov 2025, Guanghui Feng wrote:

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

The review comment I gave to v2 still stands to this v3 as well.

Please don't send new versions too rapidly but give people time to comment 
on the previous version. And please remember to explain what you changed 
in each version (below the -- line).

-- 
 i.

>  drivers/pci/pci.c | 141 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 101 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..d91c65145739 100644
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
> @@ -4867,41 +4926,45 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
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
> +		if (ret == 0 && child->subordinate)
> +			ret = __pci_bridge_wait_for_secondary_bus(child, start_t, reset_type);
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
> @@ -5542,10 +5605,8 @@ static void pci_bus_restore_locked(struct pci_bus *bus)
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
> @@ -5575,14 +5636,14 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
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


