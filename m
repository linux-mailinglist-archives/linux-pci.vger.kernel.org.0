Return-Path: <linux-pci+bounces-23754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4701BA613AB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 15:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19D267A3D4B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 14:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D8F1FDE0E;
	Fri, 14 Mar 2025 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJxuKbS1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A351FBC94
	for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962770; cv=none; b=hUwsqyAhN2TY2hseK3BGoLAy0v9FxYnhjm23uBtOdB80Gq2q0eE9eWii43XhyHKBc5x6ojF63j14E29y58OLl7CCvue1mjwA7C5q90dQ1BhpqIq9E2V4e/DnJzXM3kAi+5mlY01w2gZB+/QTwhx/07AfLpAg4BirlhLhZw6+F5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962770; c=relaxed/simple;
	bh=JnEIc1RHaA57P56c2Uh4SctTOinIUtpfaEj10Ofs1W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/qRPJelM1jGNA9aAcsMxjFU5RiY+g83ACmBL78/8t9Q7ofwQ8X8Jotmer65DNKqDn099BzvT2RvIbf4XBjXD35GqyJwIXOdehG4pKkHwBrWnonGWUEJ0OatqRmlvouMTVzC9gzH+ndU/i+xTMK9PYRTz3HvotDTxFUcO+2npsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJxuKbS1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741962769; x=1773498769;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JnEIc1RHaA57P56c2Uh4SctTOinIUtpfaEj10Ofs1W8=;
  b=RJxuKbS1jg3sXgHn4KGTKj1/i2+PclvPmGPaWNWyJmReajSBx99Fs/c9
   db0HtIbuMFPmxNQ8X9FBaWM1sAVu1RCk+8aBTACkw6GFvPtAw+EOx+dYN
   KeYJUzjIQOUt++uBv1wlTzVeatEJbSfVVNFjWg0Rqym9z7dCCyM8F3HpR
   DDy6Uui7KGo1LphmpOoyZeP8IFSPMYnxqTdUNFUY5ZbZjY4/7PceVBTWA
   R+eK7vQp4MqCkiqMm2oKQQaoZTOztumL41QqqXuLihJRH/GyEKVRbtnXY
   X5KqmYSTbe/PZWSFXVTrHiqbidl3oFd4n4KjDMkMfFr4vTD80QvKsMM+t
   w==;
X-CSE-ConnectionGUID: JfYq1MNwSO6CN6fyKewaaw==
X-CSE-MsgGUID: HL0wjoh2QTyvbcQ3sHBvKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43290986"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43290986"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 07:32:49 -0700
X-CSE-ConnectionGUID: 4auBtmziSB2SW/CP67YrMg==
X-CSE-MsgGUID: 4tqDGldASGS7ksVNjX4IpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121340452"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO [10.124.222.198]) ([10.124.222.198])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 07:32:47 -0700
Message-ID: <4f08e084-db97-4fd2-acf8-c86f4b66b7db@linux.intel.com>
Date: Fri, 14 Mar 2025 07:32:47 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: pciehp: Avoid unnecessary device replacement check
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Kenneth Crudup <kenny@panix.com>,
 "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Ricky Wu <ricky_wu@realtek.com>
References: <02f166e24c87d6cde4085865cce9adfdfd969688.1741674172.git.lukas@wunner.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <02f166e24c87d6cde4085865cce9adfdfd969688.1741674172.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/10/25 11:27 PM, Lukas Wunner wrote:
> Hot-removal of nested PCI hotplug ports suffers from a long-standing
> race condition which can lead to a deadlock:  A parent hotplug port
> acquires pci_lock_rescan_remove(), then waits for pciehp to unbind
> from a child hotplug port.  Meanwhile that child hotplug port tries to
> acquire pci_lock_rescan_remove() as well in order to remove its own
> children.
>
> The deadlock only occurs if the parent acquires pci_lock_rescan_remove()
> first, not if the child happens to acquire it first.
>
> Several workarounds to avoid the issue have been proposed and discarded
> over the years, e.g.:
>
> https://lore.kernel.org/r/4c882e25194ba8282b78fe963fec8faae7cf23eb.1529173804.git.lukas@wunner.de/
>
> A proper fix is being worked on, but needs more time as it is nontrivial
> and necessarily intrusive.
>
> Recent commit 9d573d19547b ("PCI: pciehp: Detect device replacement
> during system sleep") provokes more frequent occurrence of the deadlock
> when removing more than one Thunderbolt device during system sleep.
> The commit sought to detect device replacement, but also triggered on
> device removal.  Differentiating reliably between replacement and
> removal is impossible because pci_get_dsn() returns 0 both if the device
> was removed, as well as if it was replaced with one lacking a Device
> Serial Number.
>
> Avoid the more frequent occurrence of the deadlock by checking whether
> the hotplug port itself was hot-removed.  If so, there's no sense in
> checking whether its child device was replaced.
>
> This works because the ->resume_noirq() callback is invoked in top-down
> order for the entire hierarchy:  A parent hotplug port detecting device
> replacement (or removal) marks all children as removed using
> pci_dev_set_disconnected() and a child hotplug port can then reliably
> detect being removed.
>
> Fixes: 9d573d19547b ("PCI: pciehp: Detect device replacement during system sleep")
> Reported-by: Kenneth Crudup <kenny@panix.com>
> Closes: https://lore.kernel.org/r/83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com/
> Reported-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> Closes: https://lore.kernel.org/r/20240926125909.2362244-1-acelan.kao@canonical.com/
> Tested-by: Kenneth Crudup <kenny@panix.com>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.11+
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/hotplug/pciehp_core.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index ff458e6..997841c 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -286,9 +286,12 @@ static int pciehp_suspend(struct pcie_device *dev)
>   
>   static bool pciehp_device_replaced(struct controller *ctrl)
>   {
> -	struct pci_dev *pdev __free(pci_dev_put);
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
>   	u32 reg;
>   
> +	if (pci_dev_is_disconnected(ctrl->pcie->port))
> +		return false;
> +
>   	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
>   	if (!pdev)
>   		return true;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


