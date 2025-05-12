Return-Path: <linux-pci+bounces-27575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 966FEAB3637
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 13:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BCB189D7C3
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 11:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAA925D548;
	Mon, 12 May 2025 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OumfE6uM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F043151;
	Mon, 12 May 2025 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050626; cv=none; b=Z9epcWzR0U3b6YYugaVcbI5/a3iO3FqHGqHMt66a+k6j1qnEi+jL/47PUWPXNmhR9RbBkR4WJgn0dAhfU2frCQzSCbxW3tij4fEwvTJjK11kX9Gaqtax8J7suRseVKXZ1QwZ0m+XR/FNFUywe2uWZt3xzX+b5A+nSNx8sVs2Npo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050626; c=relaxed/simple;
	bh=qlsm2lXyI7mGR3rZEp8nzymCQHOGCbhsBqDeR80vvZ4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=izf0QYTkCawGGlbQ55+SbB6wifSvVzA+ogkEcujlyarGkF/9fRHtNKXbp+YtRhE60v/I8H8lOqvTsz1SH+/xpwt9aHVoLC6+M/9HyoImu29qsAqShuq+vIb6Ft05Uc7wE2wdg5rDlH9nABXwaa+UYiDQeMSqnZmPbtFO0JUEhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OumfE6uM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747050625; x=1778586625;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qlsm2lXyI7mGR3rZEp8nzymCQHOGCbhsBqDeR80vvZ4=;
  b=OumfE6uMBndui/RGQf9xkTUGZ+Y5I5gJfS7is1fRQS8NoNSQi3wljIQo
   sCXO9L8QtbiJInIL9jPTOC2Mm79C02EbG65NtF/YBYSA8ke/ZJzKYz3VN
   s4DQZv/+u2nt6/yJGre1ishFDbSaIGFuHlPk2luIWvLljKUs/FL1E7976
   vNQXJMJGsDQHIYKiOCc+9Sjisv767bW4Xt8o8/8VYaIlwQ8BwHcZxmUg4
   VXRxvLas2rxfXb7g5weVFb5xfxOf6KNAkNCwxA1nlI9a9INLLY6mju4Ct
   8FxKs5mqM3L+KPsYiGj3ttTGyyIUYfkzJHt7nrhMhtB9vgNHlrVBDGoCF
   w==;
X-CSE-ConnectionGUID: G82nsaE8TaGNHIqx0iEKJw==
X-CSE-MsgGUID: NZldsaf3Rp6mcFyBMXkAJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="60245575"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="60245575"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 04:50:13 -0700
X-CSE-ConnectionGUID: bScezBlwR/qpq5GXxZqdsg==
X-CSE-MsgGUID: dBin6FTRSbOl2zKFKNr6Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="174489726"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 04:50:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 May 2025 14:50:01 +0300 (EEST)
To: Shawn Anastasio <sanastasio@raptorengineering.com>
cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
    Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Rob Herring <robh@kernel.o>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    chaitanya chundru <quic_krichai@quicinc.com>, 
    Bjorn Andersson <andersson@kernel.org>, 
    Konrad Dybcio <konradybcio@kernel.org>, 
    cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>, 
    Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com, 
    amitk@kernel.org, devicetree@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, 
    jorge.ramirez@oss.qualcomm.com, Dmitry Baryshkov <lumag@kernel.org>, 
    Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [RESEND PATCH v6] PCI: PCI: Add pcie_link_is_active() to determine
 if the PCIe link is active
In-Reply-To: <20250509180813.2200312-1-sanastasio@raptorengineering.com>
Message-ID: <84ce803d-b9b6-0ae7-44fa-c793dca06421@linux.intel.com>
References: <20250509180813.2200312-1-sanastasio@raptorengineering.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 May 2025, Shawn Anastasio wrote:

In shortlog:

PCI: PCI: ... -> PCI: ...

> From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
> Date: Sat, 12 Apr 2025 07:19:56 +0530
> 
> Introduce a common API to check if the PCIe link is active, replacing
> duplicate code in multiple locations.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> ---
> (Resent since git-send-email failed to detect the Subject field from the patch
> file previously -- apologies!)
> 
> This is an updated patch pulled from Krishna's v5 series:
> https://patchwork.kernel.org/project/linux-pci/list/?series=952665
> 
> The following changes to Krishna's v5 were made by me:
>   - Revert pcie_link_is_active return type back to int per Lukas' review
>     comments
>   - Handle non-zero error returns at call site of the new function in
>     pci.c/pci_bridge_wait_for_secondary_bus
> 
>  drivers/pci/hotplug/pciehp.h      |  1 -
>  drivers/pci/hotplug/pciehp_ctrl.c |  2 +-
>  drivers/pci/hotplug/pciehp_hpc.c  | 33 +++----------------------------
>  drivers/pci/pci.c                 | 26 +++++++++++++++++++++---
>  include/linux/pci.h               |  4 ++++
>  5 files changed, 31 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 273dd8c66f4e..acef728530e3 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -186,7 +186,6 @@ int pciehp_query_power_fault(struct controller *ctrl);
>  int pciehp_card_present(struct controller *ctrl);
>  int pciehp_card_present_or_link_active(struct controller *ctrl);
>  int pciehp_check_link_status(struct controller *ctrl);
> -int pciehp_check_link_active(struct controller *ctrl);
>  void pciehp_release_ctrl(struct controller *ctrl);
> 
>  int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index d603a7aa7483..4bb58ba1c766 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -260,7 +260,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	/* Turn the slot on if it's occupied or link is up */
>  	mutex_lock(&ctrl->state_lock);
>  	present = pciehp_card_present(ctrl);
> -	link_active = pciehp_check_link_active(ctrl);
> +	link_active = pcie_link_is_active(ctrl->pcie->port);
>  	if (present <= 0 && link_active <= 0) {
>  		if (ctrl->state == BLINKINGON_STATE) {
>  			ctrl->state = OFF_STATE;
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 8a09fb6083e2..278bc21d531d 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -221,33 +221,6 @@ static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
>  	pcie_do_write_cmd(ctrl, cmd, mask, false);
>  }
> 
> -/**
> - * pciehp_check_link_active() - Is the link active
> - * @ctrl: PCIe hotplug controller
> - *
> - * Check whether the downstream link is currently active. Note it is
> - * possible that the card is removed immediately after this so the
> - * caller may need to take it into account.
> - *
> - * If the hotplug controller itself is not available anymore returns
> - * %-ENODEV.
> - */
> -int pciehp_check_link_active(struct controller *ctrl)
> -{
> -	struct pci_dev *pdev = ctrl_dev(ctrl);
> -	u16 lnk_status;
> -	int ret;
> -
> -	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> -	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
> -		return -ENODEV;
> -
> -	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> -	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
> -
> -	return ret;
> -}
> -
>  static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
>  {
>  	u32 l;
> @@ -467,7 +440,7 @@ int pciehp_card_present_or_link_active(struct controller *ctrl)
>  	if (ret)
>  		return ret;
> 
> -	return pciehp_check_link_active(ctrl);
> +	return pcie_link_is_active(ctrl_dev(ctrl));
>  }
> 
>  int pciehp_query_power_fault(struct controller *ctrl)
> @@ -584,7 +557,7 @@ static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
>  	 * Synthesize it to ensure that it is acted on.
>  	 */
>  	down_read_nested(&ctrl->reset_lock, ctrl->depth);
> -	if (!pciehp_check_link_active(ctrl))
> +	if (!pcie_link_is_active(ctrl_dev(ctrl)))
>  		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
>  	up_read(&ctrl->reset_lock);
>  }
> @@ -884,7 +857,7 @@ int pciehp_slot_reset(struct pcie_device *dev)
>  	pcie_capability_write_word(dev->port, PCI_EXP_SLTSTA,
>  				   PCI_EXP_SLTSTA_DLLSC);
> 
> -	if (!pciehp_check_link_active(ctrl))
> +	if (!pcie_link_is_active(ctrl_dev(ctrl)))
>  		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
> 
>  	return 0;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e77d5b53c0ce..3bb8354b14bf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4926,7 +4926,6 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  		return 0;
> 
>  	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
> -		u16 status;
> 
>  		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
>  		msleep(delay);
> @@ -4942,8 +4941,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  		if (!dev->link_active_reporting)
>  			return -ENOTTY;
> 
> -		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
> -		if (!(status & PCI_EXP_LNKSTA_DLLLA))
> +		if (pcie_link_is_active(dev) <= 0)
>  			return -ENOTTY;
> 
>  		return pci_dev_wait(child, reset_type,
> @@ -6247,6 +6245,28 @@ void pcie_print_link_status(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pcie_print_link_status);
> 
> +/**
> + * pcie_link_is_active() - Checks if the link is active or not
> + * @pdev: PCI device to query
> + *
> + * Check whether the link is active or not.
> + *
> + * Return: link state, or -ENODEV if the config read failes.

"link state" is bit vague, it would be better to document the values 
returned more precisely.

> + */
> +int pcie_link_is_active(struct pci_dev *pdev)
> +{
> +	u16 lnk_status;
> +	int ret;
> +
> +	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
> +		return -ENODEV;
> +
> +	pci_dbg(pdev, "lnk_status = %x\n", lnk_status);
> +	return !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> +}
> +EXPORT_SYMBOL(pcie_link_is_active);
> +
>  /**
>   * pci_select_bars - Make BAR mask from the type of resource
>   * @dev: the PCI device for which BAR mask is made
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 51e2bd6405cd..a79a9919320c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1945,6 +1945,7 @@ pci_release_mem_regions(struct pci_dev *pdev)
>  			    pci_select_bars(pdev, IORESOURCE_MEM));
>  }
> 
> +int pcie_link_is_active(struct pci_dev *dev);

Is this really needed in include/linux/pci.h, isn't drivers/pci/pci.h 
enough (for pwrctrl in the Krishna's series)?

>  #else /* CONFIG_PCI is not enabled */
> 
>  static inline void pci_set_flags(int flags) { }
> @@ -2093,6 +2094,9 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  {
>  	return -ENOSPC;
>  }
> +
> +static inline bool pcie_link_is_active(struct pci_dev *dev)
> +{ return false; }

This fits on one line just fine.

-- 
 i.

>  #endif /* CONFIG_PCI */
> 
>  /* Include architecture-dependent settings and functions */
> --
> 2.30.2
> 
> 

