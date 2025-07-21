Return-Path: <linux-pci+bounces-32625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85898B0BE5F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 10:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8973B2374
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 08:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0491E283FE1;
	Mon, 21 Jul 2025 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDq2/vpV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56625EEBA;
	Mon, 21 Jul 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085062; cv=none; b=omhCY31n9sY5BnCSR3TDxAthmokbXq14tq8+LZJS0s68/CM99KheBSqI050RglIw+fgZNMCk/rA/q53z2qRuQIdxsI9f+ftZYWmXFtLDM5aNPt3svxH1kB1GfrjKU5G7WyUgPDWtkDENzWBpSEsrt0KGnN3P2ODh8KiltN406PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085062; c=relaxed/simple;
	bh=2o9zyX3cerqp5g/7zwFTMs7Wun4Ck/BEYMqIIsd5pSI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jtXJzR1Kge2BNZmyMGFL4YVcS0g0A6LunENdGfTmluBNyBc9aMxrXWVfn4B6OU1EorTcGwfJ1rMTL3ZM3xLa09HUfZ5CaDoUhOEbeytJ08wbkjMi2GFSJLoZSH587KsGN/GoVL7zDNDW+HrId5Ri9jygutb5/+w7PEbVCvDgzX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDq2/vpV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753085061; x=1784621061;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2o9zyX3cerqp5g/7zwFTMs7Wun4Ck/BEYMqIIsd5pSI=;
  b=PDq2/vpV4msvoRAYA6gMK0OljYkd+TLbnHp6TMA/0ieKHPX9llPzwpPZ
   NVTYZlaIzhZBC1/sYH/dDHiWFQld/inr2mCIsQK02loLLFJ6A8/Qt4W22
   rARVIdsYtQ2gNrX7c4oIeUKdnW4Z2GDaSZGjwER33JICh4mZoBbpxEYmd
   HmSzcZK+5c265SLOlC2NbSy446uVkKq+pVSF7Ybf4KZXEklSXc3m4PfOq
   +kmY3BfTXxYmlQguBvvTEWw+BvnnL/ZMkJjTpWIUiwWd3U05sP6eiN28O
   UuvyybUE2EqbJiG9VlSQe+VFapBCz5Tqj5dEe3ES13fWhJTfEZ9kVZuZ1
   A==;
X-CSE-ConnectionGUID: uqZu/BOjTzWJqNNcTZc8og==
X-CSE-MsgGUID: pIJKFXH9RE6yphLiStge2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55447602"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55447602"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 01:04:21 -0700
X-CSE-ConnectionGUID: BWkutBHqS9af8EK7EQYPNw==
X-CSE-MsgGUID: YTV/OCYcRgOXDZIMMaHlpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="158888328"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 01:04:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Jul 2025 11:04:10 +0300 (EEST)
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
cc: Jeff Johnson <jjohnson@kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Nirmal Patel <nirmal.patel@linux.intel.com>, 
    Jonathan Derrick <jonathan.derrick@linux.dev>, 
    linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    ath12k@lists.infradead.org, ath11k@lists.infradead.org, 
    ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>, 
    linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
    Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 4/6] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
In-Reply-To: <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com>
Message-ID: <7a97d075-2e37-5f40-5247-867146938613@linux.intel.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com> <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 16 Jul 2025, Manivannan Sadhasivam via B4 Relay wrote:

> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> It is not recommended to enable/disable the ASPM states on the back of the
> PCI core directly using the LNKCTL register. It will break the PCI core's
> knowledge about the device ASPM states. So use the APIs exposed by the PCI
> core to enable/disable ASPM states.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Reported-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath.h        | 14 ++++++++++++++
>  drivers/net/wireless/ath/ath12k/pci.c | 10 ++++------
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
> index 34654f710d8a1e63f65a47d4602e2035262a4d9e..ef685123b66bf4f41428fec67c1967f242a9ef27 100644
> --- a/drivers/net/wireless/ath/ath.h
> +++ b/drivers/net/wireless/ath/ath.h
> @@ -21,6 +21,8 @@
>  #include <linux/skbuff.h>
>  #include <linux/if_ether.h>
>  #include <linux/spinlock.h>
> +#include <linux/pci.h>
> +#include <linux/pci_regs.h>
>  #include <net/mac80211.h>
>  
>  /*
> @@ -336,4 +338,16 @@ static inline const char *ath_bus_type_to_string(enum ath_bus_type bustype)
>  	return ath_bus_type_strings[bustype];
>  }
>  
> +static inline int ath_pci_aspm_state(u16 lnkctl)
> +{
> +	int state = 0;
> +
> +	if (lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
> +		state |= PCIE_LINK_STATE_L0S;
> +	if (lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
> +		state |= PCIE_LINK_STATE_L1;
> +
> +	return state;
> +}
> +
>  #endif /* ATH_H */
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index 489d546390fcdab8f615cc9184006a958d9f140a..a5e11509e3ab8faad6638ff78ce6a8a5e9c3cbbd 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -16,6 +16,8 @@
>  #include "mhi.h"
>  #include "debug.h"
>  
> +#include "../ath.h"
> +
>  #define ATH12K_PCI_BAR_NUM		0
>  #define ATH12K_PCI_DMA_MASK		36
>  
> @@ -928,8 +930,7 @@ static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
>  		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
>  
>  	/* disable L0s and L1 */
> -	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> -				   PCI_EXP_LNKCTL_ASPMC);
> +	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);

I'd remove to comment too as the code is self-explanatory after this 
change.

>  
>  	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
>  }
> @@ -958,10 +959,7 @@ static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
>  {
>  	if (ab_pci->ab->hw_params->supports_aspm &&
>  	    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
> -		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> -						   PCI_EXP_LNKCTL_ASPMC,
> -						   ab_pci->link_ctl &
> -						   PCI_EXP_LNKCTL_ASPMC);
> +		pci_enable_link_state(ab_pci->pdev, ath_pci_aspm_state(ab_pci->link_ctl));
>  }
>  
>  static void ath12k_pci_cancel_workqueue(struct ath12k_base *ab)

As you now depend on ASPM driver being there, these should also add to 
Kconfig:

depends on PCIEASPM

-- 
 i.


