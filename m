Return-Path: <linux-pci+bounces-22214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0623A425ED
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFEF5167D03
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B7A146A63;
	Mon, 24 Feb 2025 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YBHAtyno"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65E12837B;
	Mon, 24 Feb 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409596; cv=none; b=pcpdfsSNVeWLggoC39tDeyYHz6a3EU3SBXcmo0DCYiZ9A0Cj484JZwOOSRxy2UpejuFzIeQw0qSoSaZjXUMqYG6fPGWHxhXh5fxyc6PSOwt44iM6YxBZuI3fyFP+K4605epgbNvg4u/XeUgN6sNAa5aMEOd5KN5BIY1UjyzYO88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409596; c=relaxed/simple;
	bh=ADkd3+3KMUG431ZcMuR1LNMsm1DGaf17+eRj9yxje+o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oCyH+nmn0ZJQv7Fk+x/L01pjFRR9hmut9O4n32vbA7PmvbmePdUDemIOFZHTdtqSrVogwfX2oxK6+BdIxSS59WRVr/BFkhfy15frZpOHEyPHNXPd8g/yYh6YzrtmjJMprXlaBQ1ld1YTYTP92qrAyU9r4QYpu/0vXcSM51omhG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YBHAtyno; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740409595; x=1771945595;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ADkd3+3KMUG431ZcMuR1LNMsm1DGaf17+eRj9yxje+o=;
  b=YBHAtyno06JH5Y9vd5bF7GUKnxxRtgsnL6WpVK64wDio1d8oNsmCS+Ay
   c1IX8oV68ds7Hb1nlCOb3iPHOu2DH/kinqQzNf7XElocKjxZVVcIQYrGp
   yFKrwNFyg3SuNY+TdTWSks/0B7MP9OjWEXbCkOjDq3fF64DjJND5/F1wf
   UT2e73iguisMPBuoTrlQ9OrUxl8f83Umlw2jkXXb96g4WAwbU8cq2U0LC
   f6BJvNu5Oi8HR+tJpaX15Yi2LhbZBc8JadUMyi+Vx5z+j3CU3lC+oVbd0
   n5XPaiHTCELxuF2Iib2HE009OmoCo9Ldu5rdsXkHIGE+97u1+n7/cjI1b
   w==;
X-CSE-ConnectionGUID: FiBQEXOwRleiVegtP7+pdg==
X-CSE-MsgGUID: qMCjqTlNTwu6nJu87IDUEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58714594"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="58714594"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:06:34 -0800
X-CSE-ConnectionGUID: 4Shi8isOQ2WducwuaBvUYA==
X-CSE-MsgGUID: OCjgblENS+StDSIM8aV61w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116286008"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.233])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:06:29 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Feb 2025 17:06:26 +0200 (EET)
To: Feng Tang <feng.tang@linux.alibaba.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Liguang Zhang <zhangliguang@linux.alibaba.com>, 
    Guanghui Feng <guanghuifeng@linux.alibaba.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Markus Elfring <Markus.Elfring@web.de>, lkp@intel.com, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] PCI: portdrv: pciehp: Move PCIe hotplug command
 waiting logic to port driver
In-Reply-To: <20250224034500.23024-2-feng.tang@linux.alibaba.com>
Message-ID: <f0f8f376-9f9c-16ce-9683-f09e088bdc22@linux.intel.com>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com> <20250224034500.23024-2-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 24 Feb 2025, Feng Tang wrote:

> According to PCIe spec, after sending a hotplug command, software should
> wait some time for the command completion. Currently the waiting logic

Where is it in the spec, please put a more precise reference.

> is implemented in pciehp driver, as the same logic will be reused by
> PCIe port driver, move it to port driver, which complies with the logic
> of CONFIG_HOTPLUG_PCI_PCIE depending on CONFIG_PCIEPORTBUS.
> 
> Also convert the loop wait logic to helper read_poll_timeout() as
> suggested by Sathyanarayanan Kuppuswamy.

You could express the second part of this with a tag:

Suggested-by: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com> # Use to read_poll_timeout()

> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 38 ++++++++------------------------
>  drivers/pci/pci.h                |  5 +++++
>  drivers/pci/pcie/portdrv.c       | 25 +++++++++++++++++++++
>  3 files changed, 39 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index bb5a8d9f03ad..24e346f558db 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -83,32 +83,6 @@ static inline void pciehp_free_irq(struct controller *ctrl)
>  		free_irq(ctrl->pcie->irq, ctrl);
>  }
>  
> -static int pcie_poll_cmd(struct controller *ctrl, int timeout)
> -{
> -	struct pci_dev *pdev = ctrl_dev(ctrl);
> -	u16 slot_status;
> -
> -	do {
> -		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> -		if (PCI_POSSIBLE_ERROR(slot_status)) {
> -			ctrl_info(ctrl, "%s: no response from device\n",
> -				  __func__);
> -			return 0;
> -		}
> -
> -		if (slot_status & PCI_EXP_SLTSTA_CC) {
> -			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
> -						   PCI_EXP_SLTSTA_CC);
> -			ctrl->cmd_busy = 0;
> -			smp_mb();
> -			return 1;
> -		}
> -		msleep(10);
> -		timeout -= 10;
> -	} while (timeout >= 0);
> -	return 0;	/* timeout */
> -}
> -
>  static void pcie_wait_cmd(struct controller *ctrl)
>  {
>  	unsigned int msecs = pciehp_poll_mode ? 2500 : 1000;
> @@ -138,10 +112,16 @@ static void pcie_wait_cmd(struct controller *ctrl)
>  		timeout = cmd_timeout - now;
>  
>  	if (ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE &&
> -	    ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE)
> +	    ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE) {
>  		rc = wait_event_timeout(ctrl->queue, !ctrl->cmd_busy, timeout);
> -	else
> -		rc = pcie_poll_cmd(ctrl, jiffies_to_msecs(timeout));
> +	} else {
> +		rc = pcie_poll_sltctl_cmd(ctrl_dev(ctrl), jiffies_to_msecs(timeout));
> +		if (!rc) {
> +			ctrl->cmd_busy = 0;
> +			smp_mb();
> +			rc = 1;
> +		}
> +	}
>  
>  	if (!rc)
>  		ctrl_info(ctrl, "Timeout on hotplug command %#06x (issued %u msec ago)\n",
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 01e51db8d285..4c94a589de4a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -759,12 +759,17 @@ static inline void pcie_ecrc_get_policy(char *str) { }
>  #ifdef CONFIG_PCIEPORTBUS
>  void pcie_reset_lbms_count(struct pci_dev *port);
>  int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
> +int pcie_poll_sltctl_cmd(struct pci_dev *dev, int timeout_ms);
>  #else
>  static inline void pcie_reset_lbms_count(struct pci_dev *port) {}
>  static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int pcie_poll_sltctl_cmd(struct pci_dev *dev, int timeout_ms)
> +{
> +	return 0;
> +}
>  #endif
>  
>  struct pci_dev_reset_methods {
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 02e73099bad0..bb00ba45ee51 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -18,6 +18,7 @@
>  #include <linux/string.h>
>  #include <linux/slab.h>
>  #include <linux/aer.h>
> +#include <linux/iopoll.h>
>  
>  #include "../pci.h"
>  #include "portdrv.h"
> @@ -205,6 +206,30 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  	return 0;
>  }
>  
> +/* Return 0 on command completed on time, otherwise return -ETIMEOUT */

Since you're making this visible outside of the file, please document this 
properly using a kerneldoc compliant comment.

> +int pcie_poll_sltctl_cmd(struct pci_dev *dev, int timeout_ms)
> +{
> +	u16 slot_status = 0;
> +	u32 slot_cap;
> +	int ret = 0;

Unnecessary initialization.

> +	int __maybe_unused ret1;
> +
> +	/* Don't wait if the command complete event is not well supported */
> +	pcie_capability_read_dword(dev, PCI_EXP_SLTCAP, &slot_cap);
> +	if (!(slot_cap & PCI_EXP_SLTCAP_HPC) || slot_cap & PCI_EXP_SLTCAP_NCCS)
> +		return ret;
> +
> +	ret = read_poll_timeout(pcie_capability_read_word, ret1,
> +				(slot_status & PCI_EXP_SLTSTA_CC), 10000,
> +				timeout_ms * 1000, true, dev, PCI_EXP_SLTSTA,

Replace:
        10000 -> 10 * USEC_PER_MSEC
        timeout_ms * 1000 -> USEC_PER_SEC (the variable can be dropped)

Please also check you have linux/units.h included for those defines.

> +				&slot_status);
> +	if (!ret)

Use the normal error handling logic by reversing the condition.

> +		pcie_capability_write_word(dev, PCI_EXP_SLTSTA,
> +						PCI_EXP_SLTSTA_CC);
> +
> +	return  ret;

Remove extra space but this will become return 0; once the error handling 
is done with the usual pattern.

> +}
> +
>  /**
>   * get_port_device_capability - discover capabilities of a PCI Express port
>   * @dev: PCI Express port to examine
> 

-- 
 i.


