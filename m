Return-Path: <linux-pci+bounces-22213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA646A425D1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F573B0223
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D552714D28C;
	Mon, 24 Feb 2025 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eImADhw7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D161282F0;
	Mon, 24 Feb 2025 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409213; cv=none; b=TydejOLRhrfW2swnZNLapkfBr1O3K1PAR6LNOR/sxVyJMQSX2bF5PEUs/5goXj4zSTamRr0b7GBE55/QWl8Y2NF35Fq+b91NB9FMvD7jsb0NOoVITqLKjsndXinpzPNUCFLXKyOjdIqq+iheZy/vAODXl+0xff4iRVYi1c+nUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409213; c=relaxed/simple;
	bh=Q2sCY+UOVqT5oQg+ce4z7pL1L23zo2lBGkRIUVaef0M=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V84FDgO9bjh1cQbOGWvc15alvMlJtZjtG9gYmAdGhGYLszq/zppV1RGPqbDHW+83YHa2T72ABZweT/1TziB3V4A4vPzZ+ph4gzRMma/vMrYb2Ur9To0uLGN5uqA7d9rW35tMo7CgVYl5j6/7CBnFTtYrQRti01frt30JilEb6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eImADhw7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740409212; x=1771945212;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q2sCY+UOVqT5oQg+ce4z7pL1L23zo2lBGkRIUVaef0M=;
  b=eImADhw7yYaA65hErspMQ8w2UxhJRDipvEK8++23uhYQKFnGsU0ZiRy0
   l1cmDhu/HsCSfysEK8y15fmHGEG2XCuTCVvA8zaXIITbW5PiQXj2lqDOD
   sppSVXBXLjehdKG/73prEyKcDLtkGP6dVCj7V9ZBq930QtFPkFu8B7OAU
   1Qz9+VrFZLWa0vKUSVpUr+zSwn5Kx30BXUin38xb/JZ2+50S0c8Ijaj5R
   bXJESYFxqILFvuj8d9uzOVjrSJywIibeeXN3w6Gm/+51ULSKrS/aPECse
   7m5OA2cSNy+LeL3FfFP+xlzkrAKwttV55nHjBMZmFM4iHYX7DNaaROcNb
   w==;
X-CSE-ConnectionGUID: IaSlxWLISGe5s1cX+pjoSQ==
X-CSE-MsgGUID: c/iyyiExTge8On/qb5fhHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41044333"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41044333"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:00:11 -0800
X-CSE-ConnectionGUID: wiX6Aj1QQm+vGu/wnLyCMQ==
X-CSE-MsgGUID: RMIyOFcUQkid03ws0vvPYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116707650"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.233])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:00:06 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Feb 2025 17:00:03 +0200 (EET)
To: Feng Tang <feng.tang@linux.alibaba.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Liguang Zhang <zhangliguang@linux.alibaba.com>, 
    Guanghui Feng <guanghuifeng@linux.alibaba.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Markus Elfring <Markus.Elfring@web.de>, lkp@intel.com, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] PCI/portdrv: Add necessary wait for disabling
 hotplug events
In-Reply-To: <20250224034500.23024-3-feng.tang@linux.alibaba.com>
Message-ID: <abb50795-df83-511a-8850-cdf30f187935@linux.intel.com>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com> <20250224034500.23024-3-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 24 Feb 2025, Feng Tang wrote:

> There was problem reported by firmware developers that they received
> two PCIe hotplug commands in very short intervals on an ARM server,
> which doesn't comply with PCIe spec, and broke their state machine and
> work flow. According to PCIe 6.1 spec, section 6.7.3.2, software needs
> to wait at least 1 second for the command-complete event, before
> resending the command or sending a new command.
> 
> In the failure case, the first PCIe hotplug command firmware received
> is from get_port_device_capability(), which sends command to disable
> PCIe hotplug interrupts without waiting for its completion, and the
> second command comes from pcie_enable_notification() of pciehp driver,
> which enables hotplug interrupts again.
> 
> Fix it by adding the necessary wait to comply with PCIe spec.
> 
> Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")
> Originally-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> ---
>  drivers/pci/pci.h          |  2 ++
>  drivers/pci/pcie/portdrv.c | 19 +++++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4c94a589de4a..a1138ebc2689 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -760,6 +760,7 @@ static inline void pcie_ecrc_get_policy(char *str) { }
>  void pcie_reset_lbms_count(struct pci_dev *port);
>  int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
>  int pcie_poll_sltctl_cmd(struct pci_dev *dev, int timeout_ms);
> +void pcie_disable_hp_interrupts_early(struct pci_dev *dev);
>  #else
>  static inline void pcie_reset_lbms_count(struct pci_dev *port) {}
>  static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
> @@ -770,6 +771,7 @@ static inline int pcie_poll_sltctl_cmd(struct pci_dev *dev, int timeout_ms)
>  {
>  	return 0;
>  }
> +static inline void pcie_disable_hp_interrupts_early(struct pci_dev *dev) {}
>  #endif
>  
>  struct pci_dev_reset_methods {
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index bb00ba45ee51..ca4f21dff486 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -230,6 +230,22 @@ int pcie_poll_sltctl_cmd(struct pci_dev *dev, int timeout_ms)
>  	return  ret;
>  }
>  
> +void pcie_disable_hp_interrupts_early(struct pci_dev *dev)
> +{
> +	u16 slot_ctrl = 0;

Unnecessary initialization

> +
> +	pcie_capability_read_word(dev, PCI_EXP_SLTCTL, &slot_ctrl);
> +	/* Bail out early if it is already disabled */
> +	if (!(slot_ctrl & (PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE)))
> +		return;
> +
> +	pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> +		  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);

Align to (. You might need to put the bits to own lines.

> +
> +	if (pcie_poll_sltctl_cmd(dev, 1000))
> +		pci_info(dev, "Timeout on disabling PCIe hot-plug interrupt\n");
> +}
> +
>  /**
>   * get_port_device_capability - discover capabilities of a PCI Express port
>   * @dev: PCI Express port to examine
> @@ -255,8 +271,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  		 * Disable hot-plug interrupts in case they have been enabled
>  		 * by the BIOS and the hot-plug service driver is not loaded.
>  		 */
> -		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> -			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> +		pcie_disable_hp_interrupts_early(dev);

Doesn't calling this here delay setup for all portdrv services, not just 
hotplug? And the delay can be relatively long.

>  	}
>  
>  #ifdef CONFIG_PCIEAER
> 

-- 
 i.


