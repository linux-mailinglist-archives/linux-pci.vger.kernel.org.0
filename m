Return-Path: <linux-pci+bounces-33535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23F9B1D560
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 12:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88D387A12D7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03632236E0;
	Thu,  7 Aug 2025 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQLXgkfT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8176722256F;
	Thu,  7 Aug 2025 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754561034; cv=none; b=glgYAXiI1VknrqVc3BxzRMA7r3mmjtX986ENCr5d4M0LfJIP1yZXOOOoGAkrC9kwudRG7Tk2fRhj75vysfsU6/ZuiTA+vpDSr+8Dw1gM6fM+wA5YPewtyeCNKOrJWPGwrbSnjoV13Zrz80n84oCxXpXilXszF+4839AkN1YpjFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754561034; c=relaxed/simple;
	bh=YsqhzwTGXsR1Inz4NSQKc7b929mseLNbPE/51iSw51I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUxf3O9UCj/TCpQqhkRFzwD3zyIR4N/AXEsVhwyp/b8r7b9fTH4LuYTNov7kJI2IDQRMqEf5w0Fem2WoWHLYpg6jRgNp277NzhJaH/jnJMj9/9l2xlyxYMcC5yaOJZUOk+qEN+L0nRFfYGQIyIcvtS6txRtMzuzd2vrhP9+OjYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQLXgkfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6A6C4CEEB;
	Thu,  7 Aug 2025 10:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754561033;
	bh=YsqhzwTGXsR1Inz4NSQKc7b929mseLNbPE/51iSw51I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQLXgkfT6CABBvINOQd0JkgipyPhzRY4X9At4aPhH2YDexocOd/T49lHaLOQ9T55Q
	 Fhjf1afz77KsJXqa5Qdn4/MkvJXaAjnBUQRhvuKx/CM6HCAt5LMN63ago/pVK2cPUy
	 JNY3NsFeOlWFqo1P90D3aPZvelkDYwTCiL9q+px3Jlu+MezxMrHFr6Rtg7wftkNQeJ
	 VJ3G8TshAj3JGk98t5Pb9pyj5aXLp9VyDlWsSrK0WMKb11i/5GeB3ZCMFs/o7dqyy5
	 0GOdUVfXBsUw2vU39ErMupqgB7vk98M5i+V/wA6NPK1LMM+Mt9aboc11Fr08iv4vnw
	 Khl6HMDo18RkQ==
Date: Thu, 7 Aug 2025 15:33:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Jeff Johnson <jjohnson@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick <jonathan.derrick@linux.dev>, 
	linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, ath12k@lists.infradead.org, 
	ath11k@lists.infradead.org, ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 4/6] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
Message-ID: <poam3nvpyeahyvuyyow63u7hl63kq7ju6rondfonjjv6mix4vh@gflqxihdm2yk>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
 <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com>
 <7a97d075-2e37-5f40-5247-867146938613@linux.intel.com>
 <3q2gqo6ipzyqr7i64yhndtpg4etwep4lgffk7emxluxuhjfya5@vt7czmsgpbuw>
 <52baf40b-41ed-2588-7817-4d8cd859e0d1@linux.intel.com>
 <je7sz6lgig3picksxv4ncfjcnnw2sdsp5ja6bwofqjuydhc4v6@b3kavwicxggu>
 <fdfcc2c8-c749-2616-9295-7f4aa37fb0a4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdfcc2c8-c749-2616-9295-7f4aa37fb0a4@linux.intel.com>

On Mon, Jul 21, 2025 at 02:28:24PM GMT, Ilpo Järvinen wrote:
> On Mon, 21 Jul 2025, Manivannan Sadhasivam wrote:
> 
> > On Mon, Jul 21, 2025 at 01:09:05PM GMT, Ilpo Järvinen wrote:
> > > On Mon, 21 Jul 2025, Manivannan Sadhasivam wrote:
> > > > On Mon, Jul 21, 2025 at 11:04:10AM GMT, Ilpo Järvinen wrote:
> > > > > On Wed, 16 Jul 2025, Manivannan Sadhasivam via B4 Relay wrote:
> > > > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > > > 
> > > > > > It is not recommended to enable/disable the ASPM states on the back of the
> > > > > > PCI core directly using the LNKCTL register. It will break the PCI core's
> > > > > > knowledge about the device ASPM states. So use the APIs exposed by the PCI
> > > > > > core to enable/disable ASPM states.
> > > > > > 
> > > > > > Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> > > > > > 
> > > > > > Reported-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > > > ---
> > > > > >  drivers/net/wireless/ath/ath.h        | 14 ++++++++++++++
> > > > > >  drivers/net/wireless/ath/ath12k/pci.c | 10 ++++------
> > > > > >  2 files changed, 18 insertions(+), 6 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
> > > > > > index 34654f710d8a1e63f65a47d4602e2035262a4d9e..ef685123b66bf4f41428fec67c1967f242a9ef27 100644
> > > > > > --- a/drivers/net/wireless/ath/ath.h
> > > > > > +++ b/drivers/net/wireless/ath/ath.h
> > > > > > @@ -21,6 +21,8 @@
> > > > > >  #include <linux/skbuff.h>
> > > > > >  #include <linux/if_ether.h>
> > > > > >  #include <linux/spinlock.h>
> > > > > > +#include <linux/pci.h>
> > > > > > +#include <linux/pci_regs.h>
> > > > > >  #include <net/mac80211.h>
> > > > > >  
> > > > > >  /*
> > > > > > @@ -336,4 +338,16 @@ static inline const char *ath_bus_type_to_string(enum ath_bus_type bustype)
> > > > > >  	return ath_bus_type_strings[bustype];
> > > > > >  }
> > > > > >  
> > > > > > +static inline int ath_pci_aspm_state(u16 lnkctl)
> > > > > > +{
> > > > > > +	int state = 0;
> > > > > > +
> > > > > > +	if (lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
> > > > > > +		state |= PCIE_LINK_STATE_L0S;
> > > > > > +	if (lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
> > > > > > +		state |= PCIE_LINK_STATE_L1;
> > > > > > +
> > > > > > +	return state;
> > > > > > +}
> > > > > > +
> > > > > >  #endif /* ATH_H */
> > > > > > diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> > > > > > index 489d546390fcdab8f615cc9184006a958d9f140a..a5e11509e3ab8faad6638ff78ce6a8a5e9c3cbbd 100644
> > > > > > --- a/drivers/net/wireless/ath/ath12k/pci.c
> > > > > > +++ b/drivers/net/wireless/ath/ath12k/pci.c
> > > > > > @@ -16,6 +16,8 @@
> > > > > >  #include "mhi.h"
> > > > > >  #include "debug.h"
> > > > > >  
> > > > > > +#include "../ath.h"
> > > > > > +
> > > > > >  #define ATH12K_PCI_BAR_NUM		0
> > > > > >  #define ATH12K_PCI_DMA_MASK		36
> > > > > >  
> > > > > > @@ -928,8 +930,7 @@ static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
> > > > > >  		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
> > > > > >  
> > > > > >  	/* disable L0s and L1 */
> > > > > > -	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> > > > > > -				   PCI_EXP_LNKCTL_ASPMC);
> > > > > > +	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
> > > > > 
> > > > > I'd remove to comment too as the code is self-explanatory after this 
> > > > > change.
> > > > > 
> > > > 
> > > > Ack
> > > > 
> > > > > >  
> > > > > >  	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
> > > > > >  }
> > > > > > @@ -958,10 +959,7 @@ static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
> > > > > >  {
> > > > > >  	if (ab_pci->ab->hw_params->supports_aspm &&
> > > > > >  	    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
> > > > > > -		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> > > > > > -						   PCI_EXP_LNKCTL_ASPMC,
> > > > > > -						   ab_pci->link_ctl &
> > > > > > -						   PCI_EXP_LNKCTL_ASPMC);
> > > > > > +		pci_enable_link_state(ab_pci->pdev, ath_pci_aspm_state(ab_pci->link_ctl));
> > > > > >  }
> > > > > >  
> > > > > >  static void ath12k_pci_cancel_workqueue(struct ath12k_base *ab)
> > > > > 
> > > > > As you now depend on ASPM driver being there, these should also add to 
> > > > > Kconfig:
> > > > > 
> > > > > depends on PCIEASPM
> > > > > 
> > > > 
> > > > I thought about it, but since this driver doesn't necessarily enable ASPM for
> > > > all the devices it supports, I didn't add the dependency. But looking at it
> > > > again, I think makes sense to add the dependency since the driver cannot work
> > > > reliably without disabling ASPM (for the supported devices).
> > > 
> > > PCIEASPM is already default y and if EXPERT so it is not something 
> > > that is expected to be disabled.
> > > 
> > > You also no longer need to move the ASPM link state defines LKP found out 
> > > about after adding the depends on.
> > > 
> > 
> > Yes, it will fix the reported issue, but guarding the definitions feels wrong to
> > me still. Maybe that's something we can worry later.
> > 
> > > I'm a bit worried this series will regress in the cases where OS doesn't 
> > > control ASPM so it might be necessary to include something along the 
> > > lines of the patch below too (the earlier discussion on this is in Link 
> > > tags):
> > > 
> > 
> > atheros drivers didn't have such comment (why they were manually changing the
> > LNKCTL register), but I agree that there is a chance that they could cause issue
> > on platforms where BIOS didn't give ASPM control to the OS.
> > 
> > But as a non-ACPI developer, I don't know what does 'ACPI doesn't give
> > permission to manage ASPM' mean exactly. Does ACPI allow to disable ASPM but not
> > enable it?
> 
> While others are likely better qualified to answer this, my impression is 
> that even disabling ASPM is not allowed when OS does has not been granted 
> control over ASPM (OS should not change the value of ASPM Control in 
> LNKCTL at all).
> 
> The obvious trouble then is, if a driver/hw needs ASPM to be disabled over 
> certain period of its operation or entirely to ensure stable operation, 
> and ASPM is enabled, we're between a rock and a hard place when changes to 
> ASPM Control field are disallowed.
> 
> Because the ASPM driver took a hard stance of conformance here and did 
> not let touching the ASPM Control field, we ended up having drivers that 
> then write ASPM Control on their own to work around HW problems (see e.g. 
> the comments in drivers/net/ethernet/intel/e1000e/netdev.c that make it 
> very clear it was intentional from the driver) so it was considered that 
> allowing disabling ASPM might be acceptable compromise over drivers doing 
> it on their own (and leaving the ASPM driver out of the loop because it 
> cannot be relied to disable ASPM consistently in all cases).
> 

Since there was no comments from ACPI folks, I will go ahead with your patch. I
will also CC them in the next version so that they can yell at me if they want.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

