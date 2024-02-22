Return-Path: <linux-pci+bounces-3880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A18886017E
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 19:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192561F233E9
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 18:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEF815E5B9;
	Thu, 22 Feb 2024 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHBw1l36"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329415E5C1;
	Thu, 22 Feb 2024 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626009; cv=none; b=YVF5PzATnktkm6jtYQHMBB067ONbI3IO/5SS5fMWEzttz70IoyCH5GB0Qvq/b2Ydc3htM2oJzioKKzvfF4JrHZ9Cc5A3qSGY9t2l3h7P+9qY5bOi0BIMmbrN1twb1Bqij5cUubsIo20Qbto9JH6qjdll7Q3soTx4VrJKYeHwARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626009; c=relaxed/simple;
	bh=G2HcIEgeyj0zzkIAObPGJCNbc6FFcutORUYAPK63Hzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkD0z28sRnQU4MGdzvo1v7QmmB5JJGIC8ucBIHYjPxR+PF+Xiv2fwDOvvAoLM/n2BCwCvXGt7keutBbkUMGxStagIYStmnqOFdCQ63gu7FKsOABDskF3NDZv2EOZBwy1vztrMjJKzDx3LuT/cs5vxmzPDVuWDqnXRRiHPmXN/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RHBw1l36; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708626009; x=1740162009;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G2HcIEgeyj0zzkIAObPGJCNbc6FFcutORUYAPK63Hzs=;
  b=RHBw1l36hP1KnMTB5lhuXQ7FsUSBO+W70DXO/mD7QSwlQCIEyecn5x8B
   kZnWO47KZSSIX+mVEzhnCcaCSBphhxf8AVjEJMftTMS9x4xW3llJKaOAm
   EjO5VjydzXDsU5yRfDQjJLenVQOraatCAUEB9KuAg7PJwpX7VoJLWCdI3
   wiIovn2LPp961EpGuTbibeODuV2dnlHmKH/TvjA5Dj5mJB75ee+9Qw8iJ
   ixSqouwkqsdGQ7S7vgaKrZLCBia+siO+hhhK5BDIPzBZg63bEiSj9nKeu
   3acKSExhPm/XzzYUNL6p+4/2yja2TwdWCgafm9aYLQqjZVQqSmpqKr0/S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13435014"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13435014"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10264722"
Received: from rdegger-desk1.amr.corp.intel.com (HELO [10.209.74.18]) ([10.209.74.18])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:20:07 -0800
Message-ID: <83f0d77b-8ea4-4443-8077-6139bc905952@linux.intel.com>
Date: Thu, 22 Feb 2024 10:20:06 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] PCI/ASPM: Update saved buffers with latest ASPM
Content-Language: en-US
To: Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com, macro@orcam.me.uk,
 ajayagarwal@google.com, ilpo.jarvinen@linux.intel.com,
 david.e.box@linux.intel.com, hkallweit1@gmail.com, johan+linaro@kernel.org,
 xueshuai@linux.alibaba.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
 mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240108124248.1552420-1-vidyas@nvidia.com>
 <20240222174436.3565146-1-vidyas@nvidia.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240222174436.3565146-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/22/24 9:44 AM, Vidya Sagar wrote:
> Many PCIe device drivers save the configuration state of their respective
> devices during probe and restore the same when their 'slot_reset' hook
> is called through PCIe Error Recovery Handler.
>
> If the system has a change in ASPM policy after the driver's probe is
> called and before error event occurred, 'slot_reset' hook restores the
> PCIe configuration state to what it was at the time of probe but not to
> what it was just before the occurrence of the error event.
> This effectively leads to a mismatch in the ASPM configuration between
> the device and its upstream parent device.
>
> Update the saved configuration state of the device with the latest info
> whenever there is a change w.r.t ASPM policy.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * Rebased on top of pci/aspm branch
>
> V3:
> * Addressed sathyanarayanan.kuppuswamy's review comments
>
> V2:
> * Rebased on top of the tree code
> * Addressed Bjorn's review comments
>
>  drivers/pci/pcie/aspm.c | 28 ++++++++++++++++++++++++++--
>  3 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index cfc5b84dc9c9..3db606ba9344 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1648,7 +1648,7 @@ static int pci_save_pcie_state(struct pci_dev *dev)
>  	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &cap[i++]);
>  	pcie_capability_read_word(dev, PCI_EXP_SLTCTL2, &cap[i++]);
>  
> -	pci_save_aspm_state(dev);
> +	pci_save_aspm_l1ss_state(dev);
>  	pci_save_ltr_state(dev);
>  
>  	return 0;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b217e74966eb..9fe78eb8b07d 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -95,7 +95,7 @@ void pci_msix_init(struct pci_dev *dev);
>  bool pci_bridge_d3_possible(struct pci_dev *dev);
>  void pci_bridge_d3_update(struct pci_dev *dev);
>  void pci_aspm_get_l1ss(struct pci_dev *pdev);
> -void pci_save_aspm_state(struct pci_dev *pdev);
> +void pci_save_aspm_l1ss_state(struct pci_dev *pdev);

is this rename a review request? It is not clear from the commit log
why you are doing it?

>  void pci_restore_aspm_state(struct pci_dev *pdev);
>  void pci_save_ltr_state(struct pci_dev *dev);
>  void pci_restore_ltr_state(struct pci_dev *dev);
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 7f1d674ff171..a62648dd52bc 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -24,13 +24,29 @@
>  
>  #include "../pci.h"
>  
> +static void pci_save_aspm_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	u16 *cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
> +	if (!save_state)
> +		return;
> +
> +	cap = (u16 *)&save_state->cap.data[0];
> +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[1]);
> +}
> +
>  void pci_aspm_get_l1ss(struct pci_dev *pdev)
>  {
>  	/* Read L1 PM substate capabilities */
>  	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
>  }
>  
> -void pci_save_aspm_state(struct pci_dev *pdev)
> +void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
>  {
>  	struct pci_cap_saved_state *save_state;
>  	u16 l1ss = pdev->l1ss;
> @@ -309,10 +325,12 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
>  	struct pci_bus *linkbus = link->pdev->subordinate;
>  	u32 val = enable ? PCI_EXP_LNKCTL_CLKREQ_EN : 0;
>  
> -	list_for_each_entry(child, &linkbus->devices, bus_list)
> +	list_for_each_entry(child, &linkbus->devices, bus_list) {
>  		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
>  						   PCI_EXP_LNKCTL_CLKREQ_EN,
>  						   val);
> +		pci_save_aspm_state(child);
> +	}
>  	link->clkpm_enabled = !!enable;
>  }
>  
> @@ -931,6 +949,12 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>  		pcie_config_aspm_dev(parent, upstream);
>  
>  	link->aspm_enabled = state;
> +
> +	/* Update latest ASPM configuration in saved context */
> +	pci_save_aspm_state(link->downstream);
> +	pci_save_aspm_l1ss_state(link->downstream);
> +	pci_save_aspm_state(parent);
> +	pci_save_aspm_l1ss_state(parent);
>  }
>  
>  static void pcie_config_aspm_path(struct pcie_link_state *link)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


