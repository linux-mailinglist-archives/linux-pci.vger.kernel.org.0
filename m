Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D601C3DAE74
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 23:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhG2VlM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 17:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhG2VlM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 17:41:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D2AE600D1;
        Thu, 29 Jul 2021 21:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627594868;
        bh=5HgGoPKa5E4g5DioG30ai6sH1ivRnZkWUP6NwynQikw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E6hk43nCaRtx9MnET9bCvyaYL2bkRpSjdrRid02W5W5wC2p7JRXTRJ5FYsKdLJX5I
         AS7AuL0rzT8FZkv/NRknE9s6gHl3W18hanklw3OMKti+5hxKNsWLFJhsQIVxkHjFcs
         fj4WurokjMUzja7siMMJgb4PGDCcrEilmup1fR3nlb+1VC+NJ0lH4tujLvpUQ9Xfcm
         TE9nGuGY7aHWQz/oNqgY+NToEHgofQC6P2/tYCS1dwh1feYRUl9N1l4et//HL2YPu2
         6FmZZcXTbhrx5uoaaQOsmI5HhEYSY3XsEYT9YBjPBZTuGwuNFJ0FijqD0PDKCc7fW9
         SL46qx6CqL3xQ==
Date:   Thu, 29 Jul 2021 16:41:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wasim Khan <wasim.khan@oss.nxp.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, V.Sethi@nxp.com,
        Wasim Khan <wasim.khan@nxp.com>
Subject: Re: [PATCH] PCI: Add ACS quirk for NXP LX2160A and LX2162A
Message-ID: <20210729214106.GA994382@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729121747.1823086-1-wasim.khan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 02:17:47PM +0200, Wasim Khan wrote:
> From: Wasim Khan <wasim.khan@nxp.com>
> 
> Root Ports in NXP LX2160A and LX2162A where each Root Port
> is a Root Complex with unique segment numbers do provide
> isolation features to disable peer transactions and
> validate bus numbers in requests, but do not provide an
> actual PCIe ACS capability.
> 
> Add ACS quirk for NXP LX2160A and LX2162A
> 
> Signed-off-by: Wasim Khan <wasim.khan@nxp.com>

Applied to pci/virtualization for v5.15, thanks!

> ---
>  drivers/pci/quirks.c    | 16 ++++++++++++++++
>  include/linux/pci_ids.h |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3ba9e..24343a76c034 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4527,6 +4527,18 @@ static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
>  		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  }
>  
> +/*
> + * These NXP Root Ports with each Root Port is a Root Complex
> + * with unique segment numbers do provide isolation features
> + * to disable peer transactions and validate bus numbers in
> + * requests, but do not provide an actual PCIe ACS capability.
> + */
> +static int pci_quirk_nxp_rp_acs(struct pci_dev *dev, u16 acs_flags)
> +{
> +	return pci_acs_ctrl_enabled(acs_flags,
> +		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
> +}
> +
>  static int pci_quirk_al_acs(struct pci_dev *dev, u16 acs_flags)
>  {
>  	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> @@ -4771,6 +4783,10 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_ZHAOXIN, 0x3038, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_ZHAOXIN, 0x3104, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_ZHAOXIN, 0x9083, pci_quirk_mf_endpoint_acs },
> +	/* NXP root ports */
> +	{ PCI_VENDOR_ID_NXP, 0x8d80, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d88, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_NXP, 0x8d89, pci_quirk_nxp_rp_acs },
>  	/* Zhaoxin Root/Downstream Ports */
>  	{ PCI_VENDOR_ID_ZHAOXIN, PCI_ANY_ID, pci_quirk_zhaoxin_pcie_ports_acs },
>  	{ 0 }
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index d8156a5dbee8..9eabf77d043a 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2537,6 +2537,7 @@
>  #define PCI_DEVICE_ID_MPC8641		0x7010
>  #define PCI_DEVICE_ID_MPC8641D		0x7011
>  #define PCI_DEVICE_ID_MPC8610		0x7018
> +#define PCI_VENDOR_ID_NXP		0x1957
>  
>  #define PCI_VENDOR_ID_PASEMI		0x1959
>  
> -- 
> 2.25.1
> 
