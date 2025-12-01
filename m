Return-Path: <linux-pci+bounces-42349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 572EAC965C6
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 10:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB453A10FE
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 09:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC382FDC41;
	Mon,  1 Dec 2025 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDHjRXPk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9E2E3B0D;
	Mon,  1 Dec 2025 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764580918; cv=none; b=hxA/FPtZVZV7uKCB/lHiE1SVDCDiVLFhFHaK3P+MSYhYG15Ii89GJBQOZ5dcDZ0EjZ3fpMYxgs6Mbrez3min7ahz/XXr/mPCEVxq0iuRETTBZasTVimMvg7cKL8E9ULhXd+BrPYpwaa1MZ84z4bvcTY/H7/IFMJv9Iy/66a1C7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764580918; c=relaxed/simple;
	bh=4qUQcY3n/X7tkTCxTI3G1RUjLz3EyoGpcWk36bM6XMA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nglNDjxrs95BZ/31OpWHlgHdEIecF668wg8XShrTvSjoz40MzOXfBNEIH/7ViYSisEsfH/ycvE5MDdc2eIUXbxqJ8l3Cv3d1LtBCLuxz1OAoCB8Tkv7CHMMCCSBAkWlhqBqmigovPCvEHBKcK9mu6DHCnJXddzvgQksSbc/6c08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDHjRXPk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764580916; x=1796116916;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4qUQcY3n/X7tkTCxTI3G1RUjLz3EyoGpcWk36bM6XMA=;
  b=ZDHjRXPkF3IPYX2mSa1haJRtQN6itkjh+201RygqlhYr0DLJFTM8NXvX
   TqtDBdY52lU9vYEqZ+fEuxt/KaQqKYqqkRpgcmxiF00dfZ8unttLf3BON
   7B7dvCJ5PiYQEWR95DP1D3BPkVtZFhCh0GozmVdaUuALhRuxrYj6qoNqO
   n7IpEuPoXOlPcnYI+0ibYEUUFqHGKo49Mf2XO2faatqAxYWml7b1EzA8A
   2J6Ajk+uaIT2Q8FYfQMAYnCDGdnVMGDfHXV2QYiCUA3CdRVCta007Hr4k
   e85JWe5pSn/67ZCXF84JcS/Nrfr4syjuPpfp0IpveBD6DSuLQjmtL23Q+
   A==;
X-CSE-ConnectionGUID: TRNgzXA8Ss2CPhVdr3KbXQ==
X-CSE-MsgGUID: 3RlHBNh6QaSIw//Mq59GIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="65520508"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="65520508"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 01:21:56 -0800
X-CSE-ConnectionGUID: 8piECG3kQf+SM1t8B0foJA==
X-CSE-MsgGUID: r6yjjQdNQNGfLW5yfvsg4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="198506606"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.202])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 01:21:53 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 1 Dec 2025 11:21:49 +0200 (EET)
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, kanie@linux.alibaba.com, 
    alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v2] PCI: Fix PCIe SBR dev/link wait error
In-Reply-To: <20251129163631.2908340-1-guanghuifeng@linux.alibaba.com>
Message-ID: <74bcafc2-9d36-06d0-5ed4-66694356588d@linux.intel.com>
References: <2e3a1e6b-40ae-3878-e237-fb9032796af8@linux.intel.com> <20251129163631.2908340-1-guanghuifeng@linux.alibaba.com>
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

Hi,

In future, when posting an update, please always explain here 
below the --- line what was changed between the versions.

>  drivers/pci/pci.c | 138 ++++++++++++++++++++++++++++++++--------------
>  1 file changed, 97 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..76afecb11164 100644
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
> @@ -4867,41 +4926,40 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
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
> -	}
> +	return ret;
> +}
>  
> -	return pci_dev_wait(child, reset_type,
> -			    PCIE_RESET_READY_POLL_MS - delay);
> +int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
> +{
> +	int res = 0;
> +	unsigned long start_t = jiffies;
> +
> +	do {
> +		msleep(res);
> +		res = __pci_bridge_wait_for_secondary_bus(dev, start_t, reset_type);
> +	} while (res > 0);
> +
> +	return res;
>  }
>  
>  void pci_reset_secondary_bus(struct pci_dev *dev)
> @@ -5542,10 +5600,8 @@ static void pci_bus_restore_locked(struct pci_bus *bus)
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

???

Unfortunately, this takes a wrong turn and is very much against the 
feedback I gave to you.

>  
> @@ -5575,14 +5631,14 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
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


-- 
 i.


