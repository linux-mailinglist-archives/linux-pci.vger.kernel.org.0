Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59393DF896
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 01:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhHCXlt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 19:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234469AbhHCXls (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 19:41:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F38CE60F9C;
        Tue,  3 Aug 2021 23:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628034097;
        bh=60vc5YBOFHnJ/0fUzt8dSgNUf9l01ixqvdltGqLDIWw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IFDRNNxc9cPfp+H4DVLeIsysfdk0gqroJnqHN7YNbL1Zq0lE2KsTUuziF0E4BaPSZ
         XirCvFViPaUaVZEx1iOCPpwSa3hwh6yeIzhA+MEqsX/yhWHHmfnfEqTTiNqSL2Pqf/
         Sak0PmwP3n8x7c88lRwM3d7ZYqPul0hmvSzbRIjZeK94z8ELNdslMtckFfjD0/n09w
         HGJgwOwuEgxwSusKHnMIQ8BWhqCegrT0/eBQtqyvBsCo/AEipkTFLqOLZHralMCUoY
         CIyHKrfheVp9B43hxMRYqw945WtpJdcAKuRr0C2GIEQ4iVTvHRwJ3tzLqXlsSFCrhN
         OAFeUGiO6Bnsg==
Date:   Tue, 3 Aug 2021 18:41:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wasim Khan <wasim.khan@oss.nxp.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, V.Sethi@nxp.com,
        Wasim Khan <wasim.khan@nxp.com>
Subject: Re: [PATCH v3] PCI: Add ACS quirk for NXP LX2XX0 and LX2XX2 platforms
Message-ID: <20210803234135.GA1587049@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803180021.3252886-1-wasim.khan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 03, 2021 at 08:00:21PM +0200, Wasim Khan wrote:
> From: Wasim Khan <wasim.khan@nxp.com>
> 
> Root Ports in NXP LX2XX0 and LX2XX2 where each Root Port
> is a Root Complex with unique segment numbers do provide
> isolation features to disable peer transactions and
> validate bus numbers in requests, but do not provide an
> actual PCIe ACS capability.
> 
> Add ACS quirk for NXP LX2XX0 A/C/E/N and LX2XX2 A/C/E/N
> platforms
> 
> LX2XX0A : without security features + CAN-FD
> 	  LX2160A (0x8d81) - 16 cores
> 	  LX2120A (0x8da1) - 12 cores
> 	  LX2080A (0x8d83) - 8  cores
> 
> LX2XX0C : security features + CAN-FD
> 	  LX2160C (0x8d80) - 16 cores
> 	  LX2120C (0x8da0) - 12 cores
> 	  LX2080C (0x8d82) - 8  cores
> 
> LX2XX0E : security features + CAN
> 	  LX2160E (0x8d90) - 16 cores
> 	  LX2120E (0x8db0) - 12 cores
> 	  LX2080E (0x8d92) - 8  cores
> 
> LX2XX0N : without security features + CAN
> 	  LX2160N (0x8d91) - 16 cores
> 	  LX2120N (0x8db1) - 12 cores
> 	  LX2080N (0x8d93) - 8  cores
> 
> LX2XX2A : without security features + CAN-FD
> 	  LX2162A (0x8d89) - 16 cores
> 	  LX2122A (0x8da9) - 12 cores
> 	  LX2082A (0x8d8b) - 8  cores
> 
> LX2XX2C : security features + CAN-FD
> 	  LX2162C (0x8d88) - 16 cores
> 	  LX2122C (0x8da8) - 12 cores
> 	  LX2082C (0x8d8a) - 8  cores
> 
> LX2XX2E : security features + CAN
> 	  LX2162E (0x8d98) - 16 cores
> 	  LX2122E (0x8db8) - 12 cores
> 	  LX2082E (0x8d9a) - 8  cores
> 
> LX2XX2N : without security features + CAN
> 	  LX2162N (0x8d99) - 16 cores
> 	  LX2122N (0x8db9) - 12 cores
> 	  LX2082N (0x8d9b) - 8  cores
> 
> Signed-off-by: Wasim Khan <wasim.khan@nxp.com>

If I understand correctly, this is really an expansion of your
previous patch [1], so I just squashed them together into a single
patch and applied it to pci/virtualization for v5.15.

[1] https://lore.kernel.org/r/20210729121747.1823086-1-wasim.khan@oss.nxp.com

> ---
> Changes in v3:
> - Updated PCIe ID for LX2XX0 and LX2XX2 A/C/E/N
>   platforms and arranged then in order
> - Updated commit description and included
>   device to ID mapping
>  
>  drivers/pci/quirks.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 24343a76c034..d445d2944592 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4784,9 +4784,38 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_ZHAOXIN, 0x3104, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_ZHAOXIN, 0x9083, pci_quirk_mf_endpoint_acs },
>  	/* NXP root ports */
> +	/* LX2XX0A */
> +	{ PCI_VENDOR_ID_NXP, 0x8d81, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8da1, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d83, pci_quirk_nxp_rp_acs },
> +	/* LX2XX0C */
>  	{ PCI_VENDOR_ID_NXP, 0x8d80, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d88, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8da0, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d82, pci_quirk_nxp_rp_acs },
> +	/* LX2XX0E */
> +	{ PCI_VENDOR_ID_NXP, 0x8d90, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8db0, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d92, pci_quirk_nxp_rp_acs },
> +	/* LX2XX0N */
> +	{ PCI_VENDOR_ID_NXP, 0x8d91, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8db1, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d93, pci_quirk_nxp_rp_acs },
> +	/* LX2XX2A */
>  	{ PCI_VENDOR_ID_NXP, 0x8d89, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8da9, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d8b, pci_quirk_nxp_rp_acs },
> +	/* LX2XX2C */
> +	{ PCI_VENDOR_ID_NXP, 0x8d88, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8da8, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d8a, pci_quirk_nxp_rp_acs },
> +	/* LX2XX2E */
> +	{ PCI_VENDOR_ID_NXP, 0x8d98, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8db8, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d9a, pci_quirk_nxp_rp_acs },
> +	/* LX2XX2N */
> +	{ PCI_VENDOR_ID_NXP, 0x8d99, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8db9, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d9b, pci_quirk_nxp_rp_acs },
>  	/* Zhaoxin Root/Downstream Ports */
>  	{ PCI_VENDOR_ID_ZHAOXIN, PCI_ANY_ID, pci_quirk_zhaoxin_pcie_ports_acs },
>  	{ 0 }
> -- 
> 2.25.1
> 
