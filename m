Return-Path: <linux-pci+bounces-25096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4474AA78334
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 22:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4494D3B0289
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 20:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0721F30A4;
	Tue,  1 Apr 2025 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aApQExgO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FD413212A;
	Tue,  1 Apr 2025 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743538431; cv=none; b=W3f3vZgIBzuF/OAvgMG3amvQm+vmyCbYErhAnn4BRynNL4PF2H/+6d53RXbn+v+PtOb173ziwNxGsp+qyMZlvUHjwgsdaXo61YzEyZnnjXkNLdXDGyOuNgj4OwQMb4u+pm053zIzbZCQxC7lcc0ujWo0YJENubvSJEwhvgGdhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743538431; c=relaxed/simple;
	bh=TAU3yRCirznP64FHLdcFLDxK5Hfncrrs9R8Nl11FmC4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=m4oYl/vndgabV7sNRAa7GM3XnhS2t9A6g2vBV3ftwohE64+nAglEBzF8ckbBeu6OPmV8i09qMNXSCvpVcSaAUaN+Yde7KOpqLa8yOCr6vs5kELcumymZEngCf5GBG7Lew+8hahpJY9R7vFb7MFxhyzb8xwdRBp15ev44fD+5HoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aApQExgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36C3C4CEE4;
	Tue,  1 Apr 2025 20:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743538430;
	bh=TAU3yRCirznP64FHLdcFLDxK5Hfncrrs9R8Nl11FmC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aApQExgOS9A/bg1U5ffreDdTY/jfN0rgy424y0so7e0IKJn49lPVGB33r7LZxYM/p
	 H97g6qYL2pq8PySmeWgJkkUKlwIQKyN3fDARygqxgJ2gACJZ8RMEHtmxWYOf2XAQ60
	 k+e05ohRwFEb7LEpsdQ2HYW2C8nHQ5rSpeky6I/JquAMoKwSo7nvS5KtYkdHLXQklX
	 V1Tfyartjn8LdJcChAfcsuj/JWNJUCoTQBrx5yUHqYYADfQGFFJh83VN3c6VvgPYZR
	 aXSqD8mWiMln+8v5cOq0rfUPSuM576Un3M5eRmgkK9NRFxDJFcUMKpPG8UE+xvewF9
	 o73tiaZ8EMyCA==
Date: Tue, 1 Apr 2025 15:13:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com, rodrigo.vivi@intel.com,
	badal.nilawar@intel.com, varun.gupta@intel.com,
	ville.syrjala@linux.intel.com, uma.shankar@intel.com
Subject: Re: [PATCH 03/12] PCI/ACPI: Add aux power grant notifier
Message-ID: <20250401201349.GA1676401@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401153225.96379-4-anshuman.gupta@intel.com>

On Tue, Apr 01, 2025 at 09:02:16PM +0530, Anshuman Gupta wrote:
> Adding a notifier to notify all PCIe child devices about the
> block main power removal. It is needed because theoretically
> multiple PCIe Endpoint devices on same Root Port
> can request for AUX power and _DSM method can return with
> 80000000h signifies that the hierarchy connected via
> the slot cannot support main power removal when in D3Cold.

I wish the spec used different language here.  "D3cold" *means* "main
power is removed" (PCIe r6.0, sec 5.3.1.4.2), so it doesn't make sense
to say that "the slot cannot support main power removal when in
D3cold".  If a device is in D3cold, its main power has been removed by
definition.

I suppose the spec is trying to say if the driver has called this _DSM
with 80000000h, it means the platform must not remove main power from
the device while the system is in S0?  Is that what you think it
means?

The 2h return value description says it "indicates that the platform
will not remove main power from the slot while the system is in S0,"
so I guess that must be it.

In this series, pci_acpi_aux_power_setup() only supplies a 16-bit
aux_pwr_limit value, so the driver cannot *request* that the platform
not remove main power.

So I guess the only scenario where the _DSM returns 80000000h is when
the platform itself or other devices prevent the removal of main
power.  And the point of the notifier is to tell devices that their
main power will never be removed while the system is in S0.  Is that
right?

> This may disrupt functionality of other child device.

What sort of disruption could happen?  I would think that if the _DSM
returns 80000000h, it just means the device will not have main power
removed, so it won't see that power state transition.  The only
"disruption" would be that we're using more power.

> Let's notify all PCIe devices requested Aux power resource
> and Let PCIe End Point driver handle it in its callback.

Wrap to fill 75 columns.

s/Adding/Add/
s/Let's notify/Notify/
s/and Let/and let/
s/End Point/Endpoint/ (several places here and below)

> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
>  drivers/pci/pci-acpi.c   | 34 +++++++++++++++++++++++++++++++---
>  include/linux/pci-acpi.h | 13 +++++++++++++
>  2 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 04149f037664..d1ca1649e6e8 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1421,6 +1421,32 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>  	ACPI_FREE(obj);
>  }
>  
> +static BLOCKING_NOTIFIER_HEAD(pci_acpi_aux_power_notify_list);
> +
> +/**
> + * pci_acpi_register_aux_power_notifier - Register driver notifier
> + * @nb: notifier block
> + *
> + * This function shall be called by PCIe End Point device requested the Aux
> + * power resource in order to handle the any scenario gracefully when other
> + * child PCIe devices Aux power request returns with No main power removal.
> + * PCIe devices which register this notifier shall handle No main power
> + * removal scenario accordingly.

This would actually be called by the *driver* (not by the device).

Reword in imperative mood if possible.

> + *
> + * Return: Returns 0 on success and errno on failure.
> + */
> +int pci_acpi_register_aux_power_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&pci_acpi_aux_power_notify_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(pci_acpi_register_aux_power_notifier);
> +
> +void pci_acpi_unregister_aux_power_notifier(struct notifier_block *nb)
> +{
> +	blocking_notifier_chain_unregister(&pci_acpi_aux_power_notify_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(pci_acpi_unregister_aux_power_notifier);
> +
>  /**
>   * pci_acpi_request_d3cold_aux_power - Request D3cold aux power via ACPI DSM
>   * @dev: PCI device instance
> @@ -1466,17 +1492,19 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power)
>  	result = out_obj->integer.value;
>  
>  	switch (result) {
> -	case 0x0:
> +	case ACPI_AUX_PW_DENIED:

Add these constants in the patch that adds the _DSM.  Then this patch
will be just notifier-related code.

>  		dev_dbg(&dev->dev, "D3cold Aux Power %umW request denied\n",
>  			requested_power);
>  		break;
> -	case 0x1:
> +	case ACPI_AUX_PW_GRANTED:
>  		dev_info(&dev->dev, "D3cold Aux Power request granted: %umW\n",
>  			 requested_power);
>  		ret = 0;
>  		break;
> -	case 0x2:
> +	case ACPI_NO_MAIN_PW_REMOVAL:
>  		dev_info(&dev->dev, "D3cold Aux Power: Main power won't be removed\n");
> +		blocking_notifier_call_chain(&pci_acpi_aux_power_notify_list,
> +					     ACPI_NO_MAIN_PW_REMOVAL, dev);
>  		ret = -EBUSY;
>  		break;
>  	default:
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 4b7373f91a9a..793b979af98b 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -124,6 +124,10 @@ extern const guid_t pci_acpi_dsm_guid;
>  #define DSM_PCI_D3COLD_AUX_POWER_LIMIT		0x0A
>  #define DSM_PCI_PERST_ASSERTION_DELAY		0x0B
>  
> +#define ACPI_AUX_PW_DENIED			0x0
> +#define ACPI_AUX_PW_GRANTED			0x1
> +#define ACPI_NO_MAIN_PW_REMOVAL			0x2
> +
>  #ifdef CONFIG_PCIE_EDR
>  void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
>  void pci_acpi_remove_edr_notifier(struct pci_dev *pdev);
> @@ -134,12 +138,21 @@ static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
>  
>  int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
>  void pci_acpi_clear_companion_lookup_hook(void);
> +int pci_acpi_register_aux_power_notifier(struct notifier_block *nb);
> +void pci_acpi_unregister_aux_power_notifier(struct notifier_block *nb);
>  int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power);
>  int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us);
>  
>  #else	/* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> +int pci_acpi_register_aux_power_notifier(struct notifier_block *nb)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +void pci_acpi_unregister_aux_power_notifier(struct notifier_block *nb) { }
> +
>  int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power)
>  {
>  	return -EOPNOTSUPP;
> -- 
> 2.43.0
> 

