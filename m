Return-Path: <linux-pci+bounces-1626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7538230AB
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 16:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB5A1F248BB
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 15:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD561A730;
	Wed,  3 Jan 2024 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ex+k0lhA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5741B29E;
	Wed,  3 Jan 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704296271; x=1735832271;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v3LfKKN9p0dVjzVKSF2rfOROCJLtzrWPy1Nor0Bhpb8=;
  b=ex+k0lhAcaIzQiJBo+ydns3a9F0rfnD7WTXL8KSRpijWehmM/6lA9oWR
   TjGIsjFWE4YbPwFbnRbHqoHllEPW6fbb2E9QkBu+uVc9tejXWvadigEDO
   dNUOlMyAIem+C44JMrbUaCA1DK6jCKdXkD50OfZSWvVQKZTwyzhP6UL+j
   vgZHWCvSSJA9gCQ2Qe9a9yZvpN/nTfkJtqFOydcdos3GuMMLG1ASfcf8x
   wiGh6oVqWJmLYYO1hTjdAHvrVAzvGuIZEwyVDL/AZYHKM+kRFTnpcXlrG
   EAm08S6YIHpfCjqRxl5es9+g7PKEs8Qp3hGFliL9FavGWbM4RmOsFiopr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="387473495"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="387473495"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 07:37:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="783542879"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="783542879"
Received: from posherof-mobl1.amr.corp.intel.com (HELO [10.209.84.213]) ([10.209.84.213])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 07:37:50 -0800
Message-ID: <3ab3281e-0e10-4af5-a7ab-f46d3fd1889f@linux.intel.com>
Date: Wed, 3 Jan 2024 07:37:50 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] PCI/ASPM: Update saved buffers with latest ASPM
Content-Language: en-US
To: Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
 rafael.j.wysocki@intel.com, kai.heng.feng@canonical.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
 mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20230125133830.20620-1-vidyas@nvidia.com>
 <20240103103501.2428197-1-vidyas@nvidia.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240103103501.2428197-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/3/2024 2:35 AM, Vidya Sagar wrote:
> Many PCIe device drivers save the configuration state of their respective
> devices during probe and restore the same when their 'slot_reset' hook
> is called through PCIe Error Recovery System.

Recovery System -> Recovery Handler?


> 
> If the system has a change in ASPM policy after the driver's probe is
> called and before error event occurred, 'slot_reset' hook restores the
> PCIe configuration state to what it was at the time of probe but not with
> what it was just before the occurrence of the error event.
> This effectively leads to a mismatch in the ASPM configuration between
> the device and its upstream parent device.
> 
> Update the saved configuration state of the device with the latest info
> whenever there is a change w.r.t ASPM policy.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * Rebased on top of the tree code
> * Addressed Bjorn's review comments
> 
>  drivers/pci/pcie/aspm.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 67b13f26ba7c..d247cabb5e4c 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -138,16 +138,36 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
>  	return 0;
>  }
>  
> +static void pci_save_aspm_state(struct pci_dev *dev)
> +{
> +	int i = 0;

I don't see a need for this variable. You can use index directly.

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
> +	i++;
> +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[i++]);
> +}
> +
>  static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
>  {
>  	struct pci_dev *child;
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
> @@ -767,6 +787,10 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>  		pcie_config_aspm_dev(parent, upstream);
>  
>  	link->aspm_enabled = state;
> +
> +	/* Update latest ASPM configuration in saved context */
> +	pci_save_aspm_state(link->downstream);
> +	pci_save_aspm_state(parent);
>  }
>  
>  static void pcie_config_aspm_path(struct pcie_link_state *link)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

