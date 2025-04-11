Return-Path: <linux-pci+bounces-25644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A393BA851A1
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 04:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D291B869FA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 02:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83BF20C001;
	Fri, 11 Apr 2025 02:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKk78oAl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984382AE72;
	Fri, 11 Apr 2025 02:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744338894; cv=none; b=hB9fFZ0nBzzkau4OiL0+QvUWjMhlAGsrXPR1RzY9t7nBHHMw5n22lNUvyKJMvcmEp+IWOuNxtpqFZZQQqNWNrXnQnEEE879lgThsUOwkQr/pxU9bEuTjmYq0SY2x7ly860LCP+Srr9PMgCVFybP6Roy35aKX1//Mc8H2iPKX5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744338894; c=relaxed/simple;
	bh=OFle59saUCV+iJDdoYloF3RDr93uE7+rBccGr7GuX3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5LtafnpjuQWRjezM5LrUZ/6eJt3JeBvqy+/Lmxg5ZEd057ZK8rkxi/9Brui0Vhu1C4W9QZFRBOn6XyhteLKsiBl0nAQwxyDupxmO/TEbruYbwtlpT+ut1IsA68EcvSSfyUZC1Hb+wHFxDWlI8hkgyMEdb0Mpx+R1IyLg6BDYEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKk78oAl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744338893; x=1775874893;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OFle59saUCV+iJDdoYloF3RDr93uE7+rBccGr7GuX3Q=;
  b=BKk78oAlYwbBH8k20KUzL6PLs6s6ejttZInuHBQAHAh3Afh5NMO5jGjP
   5QtwMMSExqhLsC1ZuZVgJigFcGKT+qmRXyduwg5xuKpuAo5/gKad3xO3X
   UNR9GzWwIxEIm6DcXnG8QwK7yksmU4wJmQEnD0dk1g1NOvKJNiKKvaYN/
   AvS0Ogu+xWQ0rIGm80XlWw3YOgfryOR+GxnCFG1r1oJvaUhtpVRJRZOdh
   COBSKXIgs4+0B2+J99g0hUYwtj8as6MwETF0xM3Skm1S8I4vbc8u79yCF
   JlY25BTNA3pXsgSo3YHgS8wqcV155l3tNlV61qBOPwfIGGwyPpGKy7VS8
   Q==;
X-CSE-ConnectionGUID: F9DDQqyFSQa9MDxZsbpDGg==
X-CSE-MsgGUID: vTJunJfHTe6F9GmIohgL5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="49534443"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="49534443"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 19:34:52 -0700
X-CSE-ConnectionGUID: PbRJzdT+QuGFiUve9bnPXQ==
X-CSE-MsgGUID: KUpm7ISrRDy1MaP1pALbGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="160043579"
Received: from lbogdanm-mobl3.ger.corp.intel.com (HELO [10.124.221.65]) ([10.124.221.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 19:34:51 -0700
Message-ID: <6b8cf94f-4264-46c5-bf08-77e77796c3ac@linux.intel.com>
Date: Thu, 10 Apr 2025 19:34:41 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: pciehp: Ignore Presence Detect Changed caused by
 DPC
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>,
 linux-pci@vger.kernel.org, Stuart Hayes <stuart.w.hayes@gmail.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Joel Mathew Thomas <proxy0@tutamail.com>, Russ Weight
 <russ.weight@linux.dev>, Matthew Gerlach <matthew.gerlach@altera.com>,
 Yilun Xu <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
 Moshe Shemesh <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <cover.1744298239.git.lukas@wunner.de>
 <fa264ff71952915c4e35a53c89eb0cde8455a5c5.1744298239.git.lukas@wunner.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <fa264ff71952915c4e35a53c89eb0cde8455a5c5.1744298239.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/10/25 8:27 AM, Lukas Wunner wrote:
> Commit a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC")
> amended PCIe hotplug to not bring down the slot upon Data Link Layer State
> Changed events caused by Downstream Port Containment.
>
> However Keith reports off-list that if the slot uses in-band presence
> detect (i.e. Presence Detect State is derived from Data Link Layer Link
> Active), DPC also causes a spurious Presence Detect Changed event.
>
> This needs to be ignored as well.
>
> Unfortunately there's no register indicating that in-band presence detect
> is used.  PCIe r5.0 sec 7.5.3.10 introduced the In-Band PD Disable bit in
> the Slot Control Register.  The PCIe hotplug driver sets this bit on
> ports supporting it.  But older ports may still use in-band presence
> detect.
>
> If in-band presence detect can be disabled, Presence Detect Changed events

It should be "in-band presence detect is disabled", right?

> occurring during DPC must not be ignored because they signal device
> replacement.  On all other ports, device replacement cannot be detected
> reliably because the Presence Detect Changed event could be a side effect
> of DPC.  On those (older) ports, perform a best-effort device replacement
> check by comparing the Vendor ID, Device ID and other data in Config Space
> with the values cached in struct pci_dev.  Use the existing helper
> pciehp_device_replaced() to accomplish this.  It is currently #ifdef'ed to
> CONFIG_PM_SLEEP in pciehp_core.c, so move it to pciehp_hpc.c where most
> other functions accessing config space reside.
>
> Reported-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---

Code looks fine to me

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/hotplug/pciehp.h      |  1 +
>   drivers/pci/hotplug/pciehp_core.c | 29 -----------------------
>   drivers/pci/hotplug/pciehp_hpc.c  | 49 +++++++++++++++++++++++++++++++++------
>   3 files changed, 43 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 273dd8c..debc79b0 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -187,6 +187,7 @@ struct controller {
>   int pciehp_card_present_or_link_active(struct controller *ctrl);
>   int pciehp_check_link_status(struct controller *ctrl);
>   int pciehp_check_link_active(struct controller *ctrl);
> +bool pciehp_device_replaced(struct controller *ctrl);
>   void pciehp_release_ctrl(struct controller *ctrl);
>   
>   int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index 997841c..f59baa9 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -284,35 +284,6 @@ static int pciehp_suspend(struct pcie_device *dev)
>   	return 0;
>   }
>   
> -static bool pciehp_device_replaced(struct controller *ctrl)
> -{
> -	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> -	u32 reg;
> -
> -	if (pci_dev_is_disconnected(ctrl->pcie->port))
> -		return false;
> -
> -	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
> -	if (!pdev)
> -		return true;
> -
> -	if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
> -	    reg != (pdev->vendor | (pdev->device << 16)) ||
> -	    pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
> -	    reg != (pdev->revision | (pdev->class << 8)))
> -		return true;
> -
> -	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
> -	    (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
> -	     reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16))))
> -		return true;
> -
> -	if (pci_get_dsn(pdev) != ctrl->dsn)
> -		return true;
> -
> -	return false;
> -}
> -
>   static int pciehp_resume_noirq(struct pcie_device *dev)
>   {
>   	struct controller *ctrl = get_service_data(dev);
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 8a09fb6..388fbed 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -563,18 +563,48 @@ void pciehp_power_off_slot(struct controller *ctrl)
>   		 PCI_EXP_SLTCTL_PWR_OFF);
>   }
>   
> +bool pciehp_device_replaced(struct controller *ctrl)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> +	u32 reg;
> +
> +	if (pci_dev_is_disconnected(ctrl->pcie->port))
> +		return false;
> +
> +	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
> +	if (!pdev)
> +		return true;
> +
> +	if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
> +	    reg != (pdev->vendor | (pdev->device << 16)) ||
> +	    pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
> +	    reg != (pdev->revision | (pdev->class << 8)))
> +		return true;
> +
> +	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
> +	    (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
> +	     reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16))))
> +		return true;
> +
> +	if (pci_get_dsn(pdev) != ctrl->dsn)
> +		return true;
> +
> +	return false;
> +}
> +
>   static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
> -					  struct pci_dev *pdev, int irq)
> +					  struct pci_dev *pdev, int irq,
> +					  u16 ignored_events)
>   {
>   	/*
>   	 * Ignore link changes which occurred while waiting for DPC recovery.
>   	 * Could be several if DPC triggered multiple times consecutively.
>   	 */
>   	synchronize_hardirq(irq);
> -	atomic_and(~PCI_EXP_SLTSTA_DLLSC, &ctrl->pending_events);
> +	atomic_and(~ignored_events, &ctrl->pending_events);
>   	if (pciehp_poll_mode)
>   		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
> -					   PCI_EXP_SLTSTA_DLLSC);
> +					   ignored_events);
>   	ctrl_info(ctrl, "Slot(%s): Link Down/Up ignored (recovered by DPC)\n",
>   		  slot_name(ctrl));
>   
> @@ -584,8 +614,8 @@ static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
>   	 * Synthesize it to ensure that it is acted on.
>   	 */
>   	down_read_nested(&ctrl->reset_lock, ctrl->depth);
> -	if (!pciehp_check_link_active(ctrl))
> -		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
> +	if (!pciehp_check_link_active(ctrl) || pciehp_device_replaced(ctrl))
> +		pciehp_request(ctrl, ignored_events);
>   	up_read(&ctrl->reset_lock);
>   }
>   
> @@ -736,8 +766,13 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>   	 */
>   	if ((events & PCI_EXP_SLTSTA_DLLSC) && pci_dpc_recovered(pdev) &&
>   	    ctrl->state == ON_STATE) {
> -		events &= ~PCI_EXP_SLTSTA_DLLSC;
> -		pciehp_ignore_dpc_link_change(ctrl, pdev, irq);
> +		u16 ignored_events = PCI_EXP_SLTSTA_DLLSC;
> +
> +		if (!ctrl->inband_presence_disabled)
> +			ignored_events |= events & PCI_EXP_SLTSTA_PDC;
> +
> +		events &= ~ignored_events;
> +		pciehp_ignore_dpc_link_change(ctrl, pdev, irq, ignored_events);
>   	}
>   
>   	/*

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


