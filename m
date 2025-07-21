Return-Path: <linux-pci+bounces-32641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EF1B0C23E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 13:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0183C18C3134
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 11:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A06295519;
	Mon, 21 Jul 2025 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2Iwqp4D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0BB21CA0A;
	Mon, 21 Jul 2025 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096144; cv=none; b=V+oeRw51jYXXlginp0xb3ZBDQ2rwIjGx7mYhC8dE51u6PztI5/k/fjAWHMp9NDroV8GOsFxYpoc9lcNew5/eE0p94dlIvWKBHifuj4sxBiddYiBzopJLgs+H8OuYDfpNOyIqyQmF5xcVNVQZC3YcX+f24a8HPdc7PJgKNFWG6CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096144; c=relaxed/simple;
	bh=FY4CSPRbHnGtUTrzGgop5iipKH10dKMnMwEEENK6YLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9OQ9eApUDisjsyZfaa5P1N7vfQs609LSxToKZsAL420KonEqpe5NexMeJK/bS4NL1i2ANk6blxVbSxhlgEiSxaadQFrlk9FbAp2kXlsIPtBPuHRfJBEiOEiN/ZfFI63ICnATMkZckrwuFOmEvGqJ6sPd3iRPurdS7HgjkHc1pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2Iwqp4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672E7C4CEED;
	Mon, 21 Jul 2025 11:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753096143;
	bh=FY4CSPRbHnGtUTrzGgop5iipKH10dKMnMwEEENK6YLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2Iwqp4D6Xy2w607ZcBfyGxUQ+ADCXiljXuOVgY7TRQ1Vtoe4yZMtV2AQI/8OfPJo
	 hjp2e9X9Fgdp7+2qgAU6EnrFv4a7JPofRoSLC9w97/sU7nKtcRsFozt9hAiWW0uoq8
	 PjRPmclKGh75welK99aYH7ArSh2rUncPqG8m5HDdyrO1+pGL73lOHR1VX7rtjnmDI/
	 473hR+d7GxtA6mZR4NpRea0GldPHPu/jU/VLfqd2RiA1XyjsySOhjky93KQeFSxIaB
	 ZwVM+dtWGuy6t74W75lOnMAnkMNKtw0+C2it4xxBL2yv/VaFMvOjl3RZtb6uvTHR0m
	 VoO21ROhy9bBw==
Date: Mon, 21 Jul 2025 16:38:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-wireless@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, ath12k@lists.infradead.org, ath11k@lists.infradead.org, 
	ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 4/6] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
Message-ID: <je7sz6lgig3picksxv4ncfjcnnw2sdsp5ja6bwofqjuydhc4v6@b3kavwicxggu>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
 <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com>
 <7a97d075-2e37-5f40-5247-867146938613@linux.intel.com>
 <3q2gqo6ipzyqr7i64yhndtpg4etwep4lgffk7emxluxuhjfya5@vt7czmsgpbuw>
 <52baf40b-41ed-2588-7817-4d8cd859e0d1@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52baf40b-41ed-2588-7817-4d8cd859e0d1@linux.intel.com>

On Mon, Jul 21, 2025 at 01:09:05PM GMT, Ilpo Järvinen wrote:
> On Mon, 21 Jul 2025, Manivannan Sadhasivam wrote:
> > On Mon, Jul 21, 2025 at 11:04:10AM GMT, Ilpo Järvinen wrote:
> > > On Wed, 16 Jul 2025, Manivannan Sadhasivam via B4 Relay wrote:
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > 
> > > > It is not recommended to enable/disable the ASPM states on the back of the
> > > > PCI core directly using the LNKCTL register. It will break the PCI core's
> > > > knowledge about the device ASPM states. So use the APIs exposed by the PCI
> > > > core to enable/disable ASPM states.
> > > > 
> > > > Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> > > > 
> > > > Reported-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > ---
> > > >  drivers/net/wireless/ath/ath.h        | 14 ++++++++++++++
> > > >  drivers/net/wireless/ath/ath12k/pci.c | 10 ++++------
> > > >  2 files changed, 18 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
> > > > index 34654f710d8a1e63f65a47d4602e2035262a4d9e..ef685123b66bf4f41428fec67c1967f242a9ef27 100644
> > > > --- a/drivers/net/wireless/ath/ath.h
> > > > +++ b/drivers/net/wireless/ath/ath.h
> > > > @@ -21,6 +21,8 @@
> > > >  #include <linux/skbuff.h>
> > > >  #include <linux/if_ether.h>
> > > >  #include <linux/spinlock.h>
> > > > +#include <linux/pci.h>
> > > > +#include <linux/pci_regs.h>
> > > >  #include <net/mac80211.h>
> > > >  
> > > >  /*
> > > > @@ -336,4 +338,16 @@ static inline const char *ath_bus_type_to_string(enum ath_bus_type bustype)
> > > >  	return ath_bus_type_strings[bustype];
> > > >  }
> > > >  
> > > > +static inline int ath_pci_aspm_state(u16 lnkctl)
> > > > +{
> > > > +	int state = 0;
> > > > +
> > > > +	if (lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
> > > > +		state |= PCIE_LINK_STATE_L0S;
> > > > +	if (lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
> > > > +		state |= PCIE_LINK_STATE_L1;
> > > > +
> > > > +	return state;
> > > > +}
> > > > +
> > > >  #endif /* ATH_H */
> > > > diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> > > > index 489d546390fcdab8f615cc9184006a958d9f140a..a5e11509e3ab8faad6638ff78ce6a8a5e9c3cbbd 100644
> > > > --- a/drivers/net/wireless/ath/ath12k/pci.c
> > > > +++ b/drivers/net/wireless/ath/ath12k/pci.c
> > > > @@ -16,6 +16,8 @@
> > > >  #include "mhi.h"
> > > >  #include "debug.h"
> > > >  
> > > > +#include "../ath.h"
> > > > +
> > > >  #define ATH12K_PCI_BAR_NUM		0
> > > >  #define ATH12K_PCI_DMA_MASK		36
> > > >  
> > > > @@ -928,8 +930,7 @@ static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
> > > >  		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
> > > >  
> > > >  	/* disable L0s and L1 */
> > > > -	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> > > > -				   PCI_EXP_LNKCTL_ASPMC);
> > > > +	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
> > > 
> > > I'd remove to comment too as the code is self-explanatory after this 
> > > change.
> > > 
> > 
> > Ack
> > 
> > > >  
> > > >  	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
> > > >  }
> > > > @@ -958,10 +959,7 @@ static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
> > > >  {
> > > >  	if (ab_pci->ab->hw_params->supports_aspm &&
> > > >  	    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
> > > > -		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> > > > -						   PCI_EXP_LNKCTL_ASPMC,
> > > > -						   ab_pci->link_ctl &
> > > > -						   PCI_EXP_LNKCTL_ASPMC);
> > > > +		pci_enable_link_state(ab_pci->pdev, ath_pci_aspm_state(ab_pci->link_ctl));
> > > >  }
> > > >  
> > > >  static void ath12k_pci_cancel_workqueue(struct ath12k_base *ab)
> > > 
> > > As you now depend on ASPM driver being there, these should also add to 
> > > Kconfig:
> > > 
> > > depends on PCIEASPM
> > > 
> > 
> > I thought about it, but since this driver doesn't necessarily enable ASPM for
> > all the devices it supports, I didn't add the dependency. But looking at it
> > again, I think makes sense to add the dependency since the driver cannot work
> > reliably without disabling ASPM (for the supported devices).
> 
> PCIEASPM is already default y and if EXPERT so it is not something 
> that is expected to be disabled.
> 
> You also no longer need to move the ASPM link state defines LKP found out 
> about after adding the depends on.
> 

Yes, it will fix the reported issue, but guarding the definitions feels wrong to
me still. Maybe that's something we can worry later.

> I'm a bit worried this series will regress in the cases where OS doesn't 
> control ASPM so it might be necessary to include something along the 
> lines of the patch below too (the earlier discussion on this is in Link 
> tags):
> 

atheros drivers didn't have such comment (why they were manually changing the
LNKCTL register), but I agree that there is a chance that they could cause issue
on platforms where BIOS didn't give ASPM control to the OS.

But as a non-ACPI developer, I don't know what does 'ACPI doesn't give
permission to manage ASPM' mean exactly. Does ACPI allow to disable ASPM but not
enable it?

- Mani

> -----
> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Subject: [PATCH] PCI/ASPM: Always disable ASPM when driver requests it
> 
> PCI core/ASPM service driver allows controlling ASPM state through
> pci_disable_link_state() API. It was decided earlier (see the Link
> below), to not allow ASPM changes when OS does not have control over it
> but only log a warning about the problem (commit 2add0ec14c25
> ("PCI/ASPM: Warn when driver asks to disable ASPM, but we can't do
> it")).
> 
> A number of drivers have added workarounds to force ASPM off with own
> writes into the Link Control Register (some even with comments
> explaining why PCI core does not disable it under some circumstances).
> According to the comments, some drivers require ASPM to be off for
> reliable operation.
> 
> Having custom ASPM handling in drivers is problematic because the state
> kept in the ASPM service driver is not updated by the changes made
> outside the link state management API.
> 
> As the first step to address this issue, make pci_disable_link_state()
> to unconditionally disable ASPM so the motivation for drivers to come
> up with custom ASPM handling code is eliminated.
> 
> To fully take advantage of the ASPM handling core provides, the drivers
> that need to quirk ASPM have to be altered depend on PCIEASPM and the
> custom ASPM code is removed. This is to be done separately. As PCIEASPM
> is already behind EXPERT, it should be no problem to limit disabling it
> for configurations that do not require touching ASPM.
> 
> Make pci_disable_link_state() function comment to comply kerneldoc
> formatting while changing the description.
> 
> Link: https://lore.kernel.org/all/CANUX_P3F5YhbZX3WGU-j1AGpbXb_T9Bis2ErhvKkFMtDvzatVQ@mail.gmail.com/
> Link: https://lore.kernel.org/all/20230511131441.45704-1-ilpo.jarvinen@linux.intel.com/
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> ---
>  drivers/pci/pcie/aspm.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 5721ebfdea71..11732031e342 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1382,16 +1382,23 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked
>  		return -EINVAL;
>  	/*
>  	 * A driver requested that ASPM be disabled on this device, but
> -	 * if we don't have permission to manage ASPM (e.g., on ACPI
> +	 * if we might not have permission to manage ASPM (e.g., on ACPI
>  	 * systems we have to observe the FADT ACPI_FADT_NO_ASPM bit and
> -	 * the _OSC method), we can't honor that request.  Windows has
> -	 * a similar mechanism using "PciASPMOptOut", which is also
> -	 * ignored in this situation.
> +	 * the _OSC method), previously we chose to not honor disable
> +	 * request in that case. Windows has a similar mechanism using
> +	 * "PciASPMOptOut", which is also ignored in this situation.
> +	 *
> +	 * Not honoring the requests to disable ASPM, however, led to
> +	 * drivers forcing ASPM off on their own. As such changes of ASPM
> +	 * state are not tracked by this service driver, the state kept here
> +	 * became out of sync.
> +	 *
> +	 * Therefore, honor ASPM disable requests even when OS does not have
> +	 * ASPM control. Plain disable for ASPM is assumed to be slightly
> +	 * safer than fully managing it.
>  	 */
> -	if (aspm_disabled) {
> -		pci_warn(pdev, "can't disable ASPM; OS doesn't have ASPM control\n");
> -		return -EPERM;
> -	}
> +	if (aspm_disabled)
> +		pci_warn(pdev, "OS doesn't have ASPM control, disabling ASPM anyway\n");
>  
>  	if (!locked)
>  		down_read(&pci_bus_sem);
> @@ -1418,13 +1425,13 @@ int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
>  EXPORT_SYMBOL(pci_disable_link_state_locked);
>  
>  /**
> - * pci_disable_link_state - Disable device's link state, so the link will
> - * never enter specific states.  Note that if the BIOS didn't grant ASPM
> - * control to the OS, this does nothing because we can't touch the LNKCTL
> - * register. Returns 0 or a negative errno.
> - *
> + * pci_disable_link_state - Disable device's link state
>   * @pdev: PCI device
>   * @state: ASPM link state to disable
> + *
> + * Disable device's link state so the link will never enter specific states.
> + *
> + * Return: 0 or a negative errno
>   */
>  int pci_disable_link_state(struct pci_dev *pdev, int state)
>  {
> 
> -- 
> tg: (9f4972a5d481..) aspm/disable-always (depends on: pci/set-default-comment2)


-- 
மணிவண்ணன் சதாசிவம்

