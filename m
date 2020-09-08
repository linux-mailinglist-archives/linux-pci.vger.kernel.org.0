Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3278C2607F0
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 03:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgIHBNa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 21:13:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10834 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728056AbgIHBN1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 21:13:27 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 11018EBBDC1252A3F360;
        Tue,  8 Sep 2020 09:13:25 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 8 Sep 2020
 09:13:18 +0800
Subject: Re: [PATCH] PCI: Factor functions of PCI function reset
To:     <helgaas@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1599477387-49777-1-git-send-email-yangyicong@hisilicon.com>
CC:     <linuxarm@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <541a6bfc-c39f-f827-6cd0-d88216bbc7cf@hisilicon.com>
Date:   Tue, 8 Sep 2020 09:13:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1599477387-49777-1-git-send-email-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+cc linux-pci as I forgot to 


On 2020/9/7 19:16, Yicong Yang wrote:
> Previosly we use pci_probe_reset_function() to probe whehter a function
> can be reset and use __pci_reset_function_locked() to perform a function
> reset. These two functions have lots of common lines.
>
> Factor the two functions and reduce the redundancy.
>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/pci/pci.c   | 61 ++++++++++++++++-------------------------------------
>  drivers/pci/pci.h   |  2 +-
>  drivers/pci/probe.c |  2 +-
>  3 files changed, 20 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e39c549..e3e5f0f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5006,9 +5006,11 @@ static void pci_dev_restore(struct pci_dev *dev)
>  }
>  
>  /**
> - * __pci_reset_function_locked - reset a PCI device function while holding
> - * the @dev mutex lock.
> + * pci_probe_reset_function - check whether the device can be safely reset
> + *                            or reset a PCI device function while holding
> + *                            the @dev mutex lock.
>   * @dev: PCI device to reset
> + * @probe: Probe or not whether the device can be reset.
>   *
>   * Some devices allow an individual function to be reset without affecting
>   * other functions in the same device.  The PCI device must be responsive
> @@ -5022,10 +5024,10 @@ static void pci_dev_restore(struct pci_dev *dev)
>   * device including MSI, bus mastering, BARs, decoding IO and memory spaces,
>   * etc.
>   *
> - * Returns 0 if the device function was successfully reset or negative if the
> - * device doesn't support resetting a single function.
> + * Returns 0 if the device function can be reset or was successfully reset.
> + * negative if the device doesn't support resetting a single function.
>   */
> -int __pci_reset_function_locked(struct pci_dev *dev)
> +int pci_probe_reset_function(struct pci_dev *dev, int probe)
>  {
>  	int rc;
>  
> @@ -5039,61 +5041,34 @@ int __pci_reset_function_locked(struct pci_dev *dev)
>  	 * other error, we're also finished: this indicates that further
>  	 * reset mechanisms might be broken on the device.
>  	 */
> -	rc = pci_dev_specific_reset(dev, 0);
> +	rc = pci_dev_specific_reset(dev, probe);
>  	if (rc != -ENOTTY)
>  		return rc;
>  	if (pcie_has_flr(dev)) {
> +		if (probe)
> +			return 0;
>  		rc = pcie_flr(dev);
>  		if (rc != -ENOTTY)
>  			return rc;
>  	}
> -	rc = pci_af_flr(dev, 0);
> +	rc = pci_af_flr(dev, probe);
>  	if (rc != -ENOTTY)
>  		return rc;
> -	rc = pci_pm_reset(dev, 0);
> +	rc = pci_pm_reset(dev, probe);
>  	if (rc != -ENOTTY)
>  		return rc;
> -	rc = pci_dev_reset_slot_function(dev, 0);
> +	rc = pci_dev_reset_slot_function(dev, probe);
>  	if (rc != -ENOTTY)
>  		return rc;
> -	return pci_parent_bus_reset(dev, 0);
> +
> +	return pci_parent_bus_reset(dev, probe);
>  }
> -EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
>  
> -/**
> - * pci_probe_reset_function - check whether the device can be safely reset
> - * @dev: PCI device to reset
> - *
> - * Some devices allow an individual function to be reset without affecting
> - * other functions in the same device.  The PCI device must be responsive
> - * to PCI config space in order to use this function.
> - *
> - * Returns 0 if the device function can be reset or negative if the
> - * device doesn't support resetting a single function.
> - */
> -int pci_probe_reset_function(struct pci_dev *dev)
> +int __pci_reset_function_locked(struct pci_dev *dev)
>  {
> -	int rc;
> -
> -	might_sleep();
> -
> -	rc = pci_dev_specific_reset(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	if (pcie_has_flr(dev))
> -		return 0;
> -	rc = pci_af_flr(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pci_pm_reset(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pci_dev_reset_slot_function(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> -
> -	return pci_parent_bus_reset(dev, 1);
> +	return pci_probe_reset_function(dev, 0);
>  }
> +EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
>  
>  /**
>   * pci_reset_function - quiesce and reset a PCI device function
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fa12f7c..73740dd 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -39,7 +39,7 @@ enum pci_mmap_api {
>  int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
>  		  enum pci_mmap_api mmap_api);
>  
> -int pci_probe_reset_function(struct pci_dev *dev);
> +int pci_probe_reset_function(struct pci_dev *dev, int probe);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  int pci_bus_error_reset(struct pci_dev *dev);
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 03d3712..793cc8a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2403,7 +2403,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  
>  	pcie_report_downtraining(dev);
>  
> -	if (pci_probe_reset_function(dev) == 0)
> +	if (pci_probe_reset_function(dev, 1) == 0)
>  		dev->reset_fn = 1;
>  }
>  

