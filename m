Return-Path: <linux-pci+bounces-25694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFF4A86724
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 22:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2F69A7C32
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 20:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E91C20C470;
	Fri, 11 Apr 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YC5GPo+i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110978F45;
	Fri, 11 Apr 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403490; cv=none; b=jaAJamPi19ahzdGF6XO1CFHVDcnMdQlt4EqZ+ghFMFRn2OiKSH1ke3rBpdCnoun53hPDx1dUINgtqO4yp/0BRjx0n5WoatfkoxqVMsCOqFgNV25KmeZKNsZVf4eg4i0bHdhvvdelP6YWo5aQrJsAys+7w2mrxPkL+TOP/hUEWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403490; c=relaxed/simple;
	bh=rQ83jwcYQsuFhFXQ5Ke/S1V2qDSu9sNnyysgY9kpDTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+p4mmgPE/wOe7Wc+uIpdwx4ee+eHLU3doIjTL1QoWkcepEbE+C5cmCNAuBNpnvzU3/BYKgGAAkndD0qGDUeMfiW44uoZeaq8QrWfDs7VkidogDJXrVy3Za+ZoZQbP7zZo6SUnbptKt2xxf5a8QpufgAbmfATIXo+WN93/PGxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YC5GPo+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0ADC4CEE2;
	Fri, 11 Apr 2025 20:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744403489;
	bh=rQ83jwcYQsuFhFXQ5Ke/S1V2qDSu9sNnyysgY9kpDTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YC5GPo+idqDrzkOXainw4gdBkddPt9xgGF1ME65ZrTN9u+DHoqnWzRqwMIk5qjYj0
	 hU+1uh6nzM/+Ewpv1cww4qV0H1NSadhPhgOZBfJ72b0Kun2V8Yrv5REwSUr20xIUvb
	 PdB2HlfLxuqBgHCHFzjOnMGwnreoh60p4/RJkXv2ya+ZKsxk+ncq1dzXOVo7k/R3L/
	 QjmM+QNOlMOLAmrsbw4tPY60kSu0ILkVRo4Quxf6uEPkOMlDOTeh19A9zga/4gDnW3
	 0b9STozIW6bsSPl5dWpKEA9lmFNLfmoeXHpPAHoFGVKGE2bwueYgqwWueYtLK/e+3U
	 2gCfCJ+XxmL7Q==
Date: Fri, 11 Apr 2025 15:31:28 -0500
From: Rob Herring <robh@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>
Subject: Re: [PATCH v3 3/6] PCI: cadence: Add header support for PCIe HPA
 controller
Message-ID: <20250411203128.GA3920652-robh@kernel.org>
References: <20250411103656.2740517-1-hans.zhang@cixtech.com>
 <20250411103656.2740517-4-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411103656.2740517-4-hans.zhang@cixtech.com>

On Fri, Apr 11, 2025 at 06:36:53PM +0800, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Add the required definitions for register addresses and register bits
> for the  Cadence PCIe HPA controllers. Add the register bank offsets
> for different platform architecture and update the global platform
> data - platform architecture, EP or RP configuration and the correct
> values of register offsets for different register banks during the
> platform probe.
> 
> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
>  .../controller/cadence/pcie-cadence-host.c    |  13 +-
>  .../controller/cadence/pcie-cadence-plat.c    |  87 +++++
>  drivers/pci/controller/cadence/pcie-cadence.h | 320 +++++++++++++++++-
>  3 files changed, 410 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 8af95e9da7ce..ce035eef0a5c 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -175,7 +175,7 @@ static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
>  	return ret;
>  }
>  
> -static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
> +int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  {
>  	struct cdns_pcie *pcie = &rc->pcie;
>  	u32 value, ctrl;
> @@ -215,10 +215,10 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  	return 0;
>  }
>  
> -static int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
> -					enum cdns_pcie_rp_bar bar,
> -					u64 cpu_addr, u64 size,
> -					unsigned long flags)
> +int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
> +				 enum cdns_pcie_rp_bar bar,
> +				 u64 cpu_addr, u64 size,
> +				 unsigned long flags)
>  {
>  	struct cdns_pcie *pcie = &rc->pcie;
>  	u32 addr0, addr1, aperture, value;
> @@ -428,7 +428,7 @@ static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
>  	return 0;
>  }
>  
> -static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
> +int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>  {
>  	struct cdns_pcie *pcie = &rc->pcie;
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
> @@ -536,7 +536,6 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  		return -ENOMEM;
>  
>  	pcie = &rc->pcie;
> -	pcie->is_rc = true;
>  
>  	rc->vendor_id = 0xffff;
>  	of_property_read_u32(np, "vendor-id", &rc->vendor_id);
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> index 0456845dabb9..b24176d4df1f 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -24,6 +24,15 @@ struct cdns_plat_pcie {
>  
>  struct cdns_plat_pcie_of_data {
>  	bool is_rc;
> +	bool is_hpa;

These can be bitfields (e.g. "is_rc: 1").

> +	u32  ip_reg_bank_off;
> +	u32  ip_cfg_ctrl_reg_off;
> +	u32  axi_mstr_common_off;
> +	u32  axi_slave_off;
> +	u32  axi_master_off;
> +	u32  axi_hls_off;
> +	u32  axi_ras_off;
> +	u32  axi_dti_off;
>  };
>  
>  static const struct of_device_id cdns_plat_pcie_of_match[];
> @@ -72,6 +81,19 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  		rc = pci_host_bridge_priv(bridge);
>  		rc->pcie.dev = dev;
>  		rc->pcie.ops = &cdns_plat_ops;
> +		rc->pcie.is_hpa = data->is_hpa;
> +		rc->pcie.is_rc = data->is_rc;
> +
> +		/* Store all the register bank offsets */
> +		rc->pcie.cdns_pcie_reg_offsets.ip_reg_bank_off = data->ip_reg_bank_off;
> +		rc->pcie.cdns_pcie_reg_offsets.ip_cfg_ctrl_reg_off = data->ip_cfg_ctrl_reg_off;
> +		rc->pcie.cdns_pcie_reg_offsets.axi_mstr_common_off = data->axi_mstr_common_off;
> +		rc->pcie.cdns_pcie_reg_offsets.axi_master_off = data->axi_master_off;
> +		rc->pcie.cdns_pcie_reg_offsets.axi_slave_off = data->axi_slave_off;
> +		rc->pcie.cdns_pcie_reg_offsets.axi_hls_off = data->axi_hls_off;
> +		rc->pcie.cdns_pcie_reg_offsets.axi_ras_off = data->axi_ras_off;
> +		rc->pcie.cdns_pcie_reg_offsets.axi_dti_off = data->axi_dti_off;

Why not just store the match data ptr instead of having 2 copies of the 
information?

> +
>  		cdns_plat_pcie->pcie = &rc->pcie;
>  
>  		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
> @@ -99,6 +121,19 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  
>  		ep->pcie.dev = dev;
>  		ep->pcie.ops = &cdns_plat_ops;
> +		ep->pcie.is_hpa = data->is_hpa;
> +		ep->pcie.is_rc = data->is_rc;
> +
> +		/* Store all the register bank offset */
> +		ep->pcie.cdns_pcie_reg_offsets.ip_reg_bank_off = data->ip_reg_bank_off;
> +		ep->pcie.cdns_pcie_reg_offsets.ip_cfg_ctrl_reg_off = data->ip_cfg_ctrl_reg_off;
> +		ep->pcie.cdns_pcie_reg_offsets.axi_mstr_common_off = data->axi_mstr_common_off;
> +		ep->pcie.cdns_pcie_reg_offsets.axi_master_off = data->axi_master_off;
> +		ep->pcie.cdns_pcie_reg_offsets.axi_slave_off = data->axi_slave_off;
> +		ep->pcie.cdns_pcie_reg_offsets.axi_hls_off = data->axi_hls_off;
> +		ep->pcie.cdns_pcie_reg_offsets.axi_ras_off = data->axi_ras_off;
> +		ep->pcie.cdns_pcie_reg_offsets.axi_dti_off = data->axi_dti_off;
> +
>  		cdns_plat_pcie->pcie = &ep->pcie;
>  
>  		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
> @@ -150,10 +185,54 @@ static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
>  
>  static const struct cdns_plat_pcie_of_data cdns_plat_pcie_host_of_data = {
>  	.is_rc = true,
> +	.is_hpa = false,
> +	.ip_reg_bank_off = 0x0,
> +	.ip_cfg_ctrl_reg_off = 0x0,
> +	.axi_mstr_common_off = 0x0,
> +	.axi_slave_off = 0x0,
> +	.axi_master_off = 0x0,
> +	.axi_hls_off = 0x0,
> +	.axi_ras_off = 0x0,
> +	.axi_dti_off = 0x0,

You can omit anything initialized to 0.

>  };
>  
>  static const struct cdns_plat_pcie_of_data cdns_plat_pcie_ep_of_data = {
>  	.is_rc = false,
> +	.is_hpa = false,
> +	.ip_reg_bank_off = 0x0,
> +	.ip_cfg_ctrl_reg_off = 0x0,
> +	.axi_mstr_common_off = 0x0,
> +	.axi_slave_off = 0x0,
> +	.axi_master_off = 0x0,
> +	.axi_hls_off = 0x0,
> +	.axi_ras_off = 0x0,
> +	.axi_dti_off = 0x0,
> +};
> +
> +static const struct cdns_plat_pcie_of_data cdns_plat_pcie_hpa_host_of_data = {
> +	.is_rc = true,
> +	.is_hpa = true,
> +	.ip_reg_bank_off = CDNS_PCIE_HPA_IP_REG_BANK,
> +	.ip_cfg_ctrl_reg_off = CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK,
> +	.axi_mstr_common_off = CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON,
> +	.axi_slave_off = CDNS_PCIE_HPA_AXI_SLAVE,
> +	.axi_master_off = CDNS_PCIE_HPA_AXI_MASTER,
> +	.axi_hls_off = 0,
> +	.axi_ras_off = 0,
> +	.axi_dti_off = 0,
> +};
> +
> +static const struct cdns_plat_pcie_of_data cdns_plat_pcie_hpa_ep_of_data = {
> +	.is_rc = false,
> +	.is_hpa = true,
> +	.ip_reg_bank_off = CDNS_PCIE_HPA_IP_REG_BANK,
> +	.ip_cfg_ctrl_reg_off = CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK,
> +	.axi_mstr_common_off = CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON,
> +	.axi_slave_off = CDNS_PCIE_HPA_AXI_SLAVE,
> +	.axi_master_off = CDNS_PCIE_HPA_AXI_MASTER,
> +	.axi_hls_off = 0,
> +	.axi_ras_off = 0,
> +	.axi_dti_off = 0,
>  };

