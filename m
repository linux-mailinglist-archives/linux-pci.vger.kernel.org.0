Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7286DFD0DD
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 23:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKNWRY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 17:17:24 -0500
Received: from ale.deltatee.com ([207.54.116.67]:40064 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfKNWRY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Nov 2019 17:17:24 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iVNQQ-000262-1G; Thu, 14 Nov 2019 15:17:20 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org
Cc:     George Cherian <george.cherian@marvell.com>,
        Robert Richter <rrichter@marvell.com>, Feng Kan <fkan@apm.com>,
        Abhinav Ratna <abhinav.ratna@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20191114220601.261647-1-helgaas@kernel.org>
 <20191114220601.261647-3-helgaas@kernel.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <884c6532-11a5-a157-37e5-ed62f1dc18a9@deltatee.com>
Date:   Thu, 14 Nov 2019 15:17:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114220601.261647-3-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: bhelgaas@google.com, abhinav.ratna@broadcom.com, fkan@apm.com, rrichter@marvell.com, george.cherian@marvell.com, linux-pci@vger.kernel.org, alex.williamson@redhat.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 2/2] PCI: Unify ACS quirk desired vs provided checking
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-11-14 3:06 p.m., Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Most of the ACS quirks have a similar pattern of:
> 
>   acs_flags &= ~( <controls provided by this device> );
>   return acs_flags ? 0 : 1;
> 
> Pull this out into a helper function to simplify the quirks slightly.  The
> helper function is also a convenient place for comments about what the list
> of ACS controls means.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks correct to me. For both patches:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/pci/quirks.c | 67 +++++++++++++++++++++++++++++---------------
>  1 file changed, 45 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 59f73d084e1d..9a1051071a81 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4296,6 +4296,24 @@ static void quirk_chelsio_T5_disable_root_port_attributes(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
>  			 quirk_chelsio_T5_disable_root_port_attributes);
>  
> +/*
> + * pci_acs_ctrl_enabled - compare desired ACS controls with those provided
> + *			  by a device
> + * @acs_ctrl_req: Bitmask of desired ACS controls
> + * @acs_ctrl_ena: Bitmask of ACS controls enabled or provided implicitly by
> + *		  the hardware design
> + *
> + * Return 1 if all ACS controls in the @acs_ctrl_req bitmask are included
> + * in @acs_ctrl_ena, i.e., the device provides all the access controls the
> + * caller desires.  Return 0 otherwise.
> + */
> +static int pci_acs_ctrl_enabled(u16 acs_ctrl_req, u16 acs_ctrl_ena)
> +{
> +	if ((acs_ctrl_req & acs_ctrl_ena) == acs_ctrl_req)
> +		return 1;
> +	return 0;
> +}
> +
>  /*
>   * AMD has indicated that the devices below do not support peer-to-peer
>   * in any system where they are found in the southbridge with an AMD
> @@ -4339,7 +4357,7 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
>  	/* Filter out flags not applicable to multifunction */
>  	acs_flags &= (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC | PCI_ACS_DT);
>  
> -	return acs_flags & ~(PCI_ACS_RR | PCI_ACS_CR) ? 0 : 1;
> +	return pci_acs_ctrl_enabled(acs_flags, PCI_ACS_RR | PCI_ACS_CR);
>  #else
>  	return -ENODEV;
>  #endif
> @@ -4377,9 +4395,8 @@ static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
>  	 * hardware implements and enables equivalent ACS functionality for
>  	 * these flags.
>  	 */
> -	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
> -
> -	return acs_flags ? 0 : 1;
> +	return pci_acs_ctrl_enabled(acs_flags,
> +		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  }
>  
>  static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
> @@ -4389,9 +4406,8 @@ static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
>  	 * transactions with others, allowing masking out these bits as if they
>  	 * were unimplemented in the ACS capability.
>  	 */
> -	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
> -
> -	return acs_flags ? 0 : 1;
> +	return pci_acs_ctrl_enabled(acs_flags,
> +		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  }
>  
>  /*
> @@ -4443,17 +4459,16 @@ static bool pci_quirk_intel_pch_acs_match(struct pci_dev *dev)
>  	return false;
>  }
>  
> -#define INTEL_PCH_ACS_FLAGS (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
> -
>  static int pci_quirk_intel_pch_acs(struct pci_dev *dev, u16 acs_flags)
>  {
>  	if (!pci_quirk_intel_pch_acs_match(dev))
>  		return -ENOTTY;
>  
>  	if (dev->dev_flags & PCI_DEV_FLAGS_ACS_ENABLED_QUIRK)
> -		acs_flags &= ~(INTEL_PCH_ACS_FLAGS);
> +		return pci_acs_ctrl_enabled(acs_flags,
> +			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  
> -	return acs_flags ? 0 : 1;
> +	return pci_acs_ctrl_enabled(acs_flags, 0);
>  }
>  
>  /*
> @@ -4468,9 +4483,8 @@ static int pci_quirk_intel_pch_acs(struct pci_dev *dev, u16 acs_flags)
>   */
>  static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
>  {
> -	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
> -
> -	return acs_flags ? 0 : 1;
> +	return pci_acs_ctrl_enabled(acs_flags,
> +		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  }
>  
>  static int pci_quirk_al_acs(struct pci_dev *dev, u16 acs_flags)
> @@ -4571,7 +4585,7 @@ static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags)
>  
>  	pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);
>  
> -	return acs_flags & ~ctrl ? 0 : 1;
> +	return pci_acs_ctrl_enabled(acs_flags, ctrl);
>  }
>  
>  static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
> @@ -4585,10 +4599,9 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
>  	 * perform peer-to-peer with other functions, allowing us to mask out
>  	 * these bits as if they were unimplemented in the ACS capability.
>  	 */
> -	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
> -		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
> -
> -	return acs_flags ? 0 : 1;
> +	return pci_acs_ctrl_enabled(acs_flags,
> +		PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
> +		PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
>  }
>  
>  static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
> @@ -4599,9 +4612,8 @@ static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
>  	 * Allow each Root Port to be in a separate IOMMU group by masking
>  	 * SV/RR/CR/UF bits.
>  	 */
> -	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
> -
> -	return acs_flags ? 0 : 1;
> +	return pci_acs_ctrl_enabled(acs_flags,
> +		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  }
>  
>  static const struct pci_dev_acs_enabled {
> @@ -4703,6 +4715,17 @@ static const struct pci_dev_acs_enabled {
>  	{ 0 }
>  };
>  
> +/*
> + * pci_dev_specific_acs_enabled - check whether device provides ACS controls
> + * @dev:	PCI device
> + * @acs_flags:	Bitmask of desired ACS controls
> + *
> + * Returns:
> + *   -ENOTTY:	No quirk applies to this device; we can't tell whether the
> + *		device provides the desired controls
> + *   0:		Device does not provide all the desired controls
> + *   >0:	Device provides all the controls in @acs_flags
> + */
>  int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags)
>  {
>  	const struct pci_dev_acs_enabled *i;
> 
