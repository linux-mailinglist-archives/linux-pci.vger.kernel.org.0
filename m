Return-Path: <linux-pci+bounces-3288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEF284F8CC
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 16:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5681C21522
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 15:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A506C71B3A;
	Fri,  9 Feb 2024 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIUlqcik"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F0745C8;
	Fri,  9 Feb 2024 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493509; cv=none; b=G68tDPxh4splpHcxK1KS8Qk95iyjLWI7DHcouYA89p2gwwulAg4JTf38EE6UgVdCpnmbIJTcaRw83vSketMnW0FAneouMfSEAQSzMChOYKZgqCAd/ioxyal8oek6EE3iea/LDY7SAvkl0Ej96WuJ3ZJcGhdlwR+6VehCxm+3fsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493509; c=relaxed/simple;
	bh=BzgEjFy21abm8ou95D52xk4UJcg0gHu4yXLP7PFRrXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gd9Xocl6U/D/6lzkNZr8BYN4ePjrCexEFTOvEJVgFJnRz0HorF7Ey7F35NsWD7EJm9ePokMR1JWaiIWk2Z6TSOhzahIgHpc6OaYAEOGFXYJsSX1KSnr//b68wU0lmBKL5wlRWBunaniPB7XMRXf6ah4Lw6pLI/laKCMwXAIZYoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QIUlqcik; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707493508; x=1739029508;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BzgEjFy21abm8ou95D52xk4UJcg0gHu4yXLP7PFRrXs=;
  b=QIUlqcikrzXV6ZR+dtfKZJO/KqkEWaEVv8z5k6DHNg1pjYHgyWFkf7P2
   3QGOIpdc79XMpIcY3f9zI+rnzvNGXa1J8SUM/1N+ttBLQ2xn17LJZFj/r
   9MTMTcDhWn3hsM5egE31PyNhBdtzSwbZ2I1zEqWHoXJrJfM0R6hdYPvAo
   jWRkUVJtHoa95ihcpvlPw9poBJ0tLROcUm0vXIukmubxy/nBTY72qzSnV
   pr2KdVdRVG3xfMpqmPhfJh9gp3fbiSxZ08igZJSMN9v6aBxR1nIM+8Fc0
   uNQ8QVsAVpXRpQh9rg7iuxsfxA9mZh1Y+NVtJcVUakZKMY0oW0WxB1Rdg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="18863190"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="18863190"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:45:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="910744564"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="910744564"
Received: from lesliemu-mobl1.amr.corp.intel.com (HELO [10.209.54.206]) ([10.209.54.206])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:45:06 -0800
Message-ID: <64ad8d52-ba67-4156-8e36-7346605bdf48@linux.intel.com>
Date: Fri, 9 Feb 2024 07:45:05 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/AER: Block runtime suspend when handling errors
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>
References: <20240209140841.1854711-1-stanislaw.gruszka@linux.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240209140841.1854711-1-stanislaw.gruszka@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/9/24 6:08 AM, Stanislaw Gruszka wrote:
> PM runtime can be done simultaneously with AER error handling.
> Avoid that by using pm_runtime_get_sync() before and pm_runtime_put()
> after reset in pcie_do_recovery() for all recovering devices.
>
> pm_runtime_get_sync() will increase dev->power.usage_count counter
> to prevent any possible future request to runtime suspend a device,
> as well as resume device is was in D3hot state.
runtime suspend a device or resume a device that was in D3hot state.
>
> I tested with igc device by doing simultaneous aer_inject and
> rpm suspend/resume via /sys/bus/pci/devices/PCI_ID/power/control
> and can reproduce:
>
> igc 0000:02:00.0: not ready 65535ms after bus reset; giving up
> pcieport 0000:00:1c.2: AER: Root Port link has been reset (-25)
> pcieport 0000:00:1c.2: AER: subordinate device reset failed
> pcieport 0000:00:1c.2: AER: device recovery failed
> igc 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
>
> The problem disappears when applied this patch.
>
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> ---

since it is a bug fix, may be Cc: stable@vger.kernel.org

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> RFC -> v1:
>  add runtime callbacks to pcie_do_recovery(), this covers DPC case
>  as well as case of recovering multiple devices under same port.
>  
>  drivers/pci/pcie/err.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 59c90d04a609..705893b5f7b0 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -13,6 +13,7 @@
>  #define dev_fmt(fmt) "AER: " fmt
>  
>  #include <linux/pci.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
> @@ -85,6 +86,18 @@ static int report_error_detected(struct pci_dev *dev,
>  	return 0;
>  }
>  
> +static int pci_pm_runtime_get_sync(struct pci_dev *pdev, void *data)
> +{
> +	pm_runtime_get_sync(&pdev->dev);
> +	return 0;
> +}
> +
> +static int pci_pm_runtime_put(struct pci_dev *pdev, void *data)
> +{
> +	pm_runtime_put(&pdev->dev);
> +	return 0;
> +}
> +
>  static int report_frozen_detected(struct pci_dev *dev, void *data)
>  {
>  	return report_error_detected(dev, pci_channel_io_frozen, data);
> @@ -207,6 +220,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	else
>  		bridge = pci_upstream_bridge(dev);
>  
> +	pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
> +
>  	pci_dbg(bridge, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
>  		pci_walk_bridge(bridge, report_frozen_detected, &status);
> @@ -251,10 +266,15 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		pcie_clear_device_status(dev);
>  		pci_aer_clear_nonfatal_status(dev);
>  	}
> +
> +	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
> +
>  	pci_info(bridge, "device recovery successful\n");
>  	return status;
>  
>  failed:
> +	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
> +
>  	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
>  
>  	/* TODO: Should kernel panic here? */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


