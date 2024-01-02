Return-Path: <linux-pci+bounces-1614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FD8822589
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 00:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D501F22E1C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 23:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4FB17740;
	Tue,  2 Jan 2024 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0PE5hAi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465CE17982;
	Tue,  2 Jan 2024 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704238434; x=1735774434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hmnREbkJ1spni6quDzIEHXCaQXW3TktM92/lBSG23sI=;
  b=T0PE5hAiC4Xewm3C6culXzxpzHV4YvDgFq+hdbaV96FzOPk8/5HG2Iqn
   wvVF3Jb/0vjfdd/96jASXHAO1UFuk4jk/rFOE2OOOsiMOHc9SlE6Oik+v
   TzGS1yxcd8RXTc+/6i8ZJZK7ZyxMEqVssL9aEo412uRSyeCRCUYF7xB18
   FiECVJZ+1uWX2KwazMLLoqJDmZ4L7Jm4KP3KZ0bw3zuuSKcTXc0vQrT/a
   d20aWBLYm8gWam0iYuTBcHGmbFbl0pvUY/NvZExfny7yB6Ae+yPQii8Pn
   /wVvNTojt/jWFmFeoB36NceFxnZ3uM3t2ZlY4Q03k8IxiXL7boRdnlrQ0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3769991"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="3769991"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 15:33:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="1111182255"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="1111182255"
Received: from keithj1-mobl2.amr.corp.intel.com (HELO [10.209.44.31]) ([10.209.44.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 15:33:51 -0800
Message-ID: <20cd835e-f84c-4c43-812e-6706f7266150@linux.intel.com>
Date: Tue, 2 Jan 2024 15:33:51 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, Michael Schaller
 <michael@5challer.de>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Ajay Agarwal <ajayagarwal@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Johan Hovold <johan+linaro@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 stable@vger.kernel.org
References: <76c61361-b8b4-435f-a9f1-32b716763d62@5challer.de>
 <20240102232550.1751655-1-helgaas@kernel.org>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240102232550.1751655-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/2/2024 3:25 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This reverts commit 08d0cc5f34265d1a1e3031f319f594bd1970976c.
> 
> Michael reported that when attempting to resume from suspend to RAM on ASUS
> mini PC PN51-BB757MDE1 (DMI model: MINIPC PN51-E1), 08d0cc5f3426
> ("PCI/ASPM: Remove pcie_aspm_pm_state_change()") caused a 12-second delay
> with no output, followed by a reboot.
> 
> Workarounds include:
> 
>   - Reverting 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()")
>   - Booting with "pcie_aspm=off"
>   - Booting with "pcie_aspm.policy=performance"
>   - "echo 0 | sudo tee /sys/bus/pci/devices/0000:03:00.0/link/l1_aspm"
>     before suspending
>   - Connecting a USB flash drive
> 

Did you find the root cause? Is this issue specific to that particular
device? If yes, can we do a quirk?

> Fixes: 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()")
> Reported-by: Michael Schaller <michael@5challer.de>
> Link: https://lore.kernel.org/r/76c61361-b8b4-435f-a9f1-32b716763d62@5challer.de
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/pci/pci.c       |  6 ++++++
>  drivers/pci/pci.h       |  2 ++
>  drivers/pci/pcie/aspm.c | 19 +++++++++++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 55bc3576a985..bdbf8a94b4d0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1335,6 +1335,9 @@ static int pci_set_full_power_state(struct pci_dev *dev)
>  		pci_restore_bars(dev);
>  	}
>  
> +	if (dev->bus->self)
> +		pcie_aspm_pm_state_change(dev->bus->self);
> +
>  	return 0;
>  }
>  
> @@ -1429,6 +1432,9 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
>  				     pci_power_name(dev->current_state),
>  				     pci_power_name(state));
>  
> +	if (dev->bus->self)
> +		pcie_aspm_pm_state_change(dev->bus->self);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5ecbcf041179..f43873049d52 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -569,10 +569,12 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
>  #ifdef CONFIG_PCIEASPM
>  void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> +void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> +static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>  #endif
>  
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 50b04ae5c394..8715e951c491 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1008,6 +1008,25 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>  	up_read(&pci_bus_sem);
>  }
>  
> +/* @pdev: the root port or switch downstream port */
> +void pcie_aspm_pm_state_change(struct pci_dev *pdev)
> +{
> +	struct pcie_link_state *link = pdev->link_state;
> +
> +	if (aspm_disabled || !link)
> +		return;
> +	/*
> +	 * Devices changed PM state, we should recheck if latency
> +	 * meets all functions' requirement
> +	 */
> +	down_read(&pci_bus_sem);
> +	mutex_lock(&aspm_lock);
> +	pcie_update_aspm_capable(link->root);
> +	pcie_config_aspm_path(link);
> +	mutex_unlock(&aspm_lock);
> +	up_read(&pci_bus_sem);
> +}
> +
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
>  {
>  	struct pcie_link_state *link = pdev->link_state;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

