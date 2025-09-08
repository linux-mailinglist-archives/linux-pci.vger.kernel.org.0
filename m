Return-Path: <linux-pci+bounces-35654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9130EB48A10
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 12:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E821B252C9
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 10:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D2E2F3639;
	Mon,  8 Sep 2025 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnEc0ghm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360722F3621;
	Mon,  8 Sep 2025 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327029; cv=none; b=e6ALo2kd2a7AJux61tylut4KnwnF2O6NHrtH79ZyMhgVl6dBCMsBAjFUTfwgi1fhwHSexsyEBGEKk6yWKqe86Usa0xjImwGXGR9H4+gPJFrBWzIPOU/2IkRUBnHMC1gC9wIcYYL8IBWnlMEsLYzpu8Zyn0HX3N/DAB5Q3LOvmC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327029; c=relaxed/simple;
	bh=qjITIwO/jDHVoXZ3gVg7mnbAYHFbHzgspnrskS7+5/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=culg1Kb/A7qaO9n0bW54F2Uzjgz8hsLRgye15cnAkQWabdJ/jFqV9eLYSDLAGOnuz5yq2npoh26JY5MvtaiN3C4f43zQyr5pn7z1DH94gaXZoqCGWf2T4eCGuCsxjZqqI0OsQnmk6OtRuQpsIf5fW7l7Ri4IFo3dLFhx83LtFz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnEc0ghm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD12C4CEF1;
	Mon,  8 Sep 2025 10:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757327026;
	bh=qjITIwO/jDHVoXZ3gVg7mnbAYHFbHzgspnrskS7+5/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BnEc0ghmHEEYPpCdQMTjszVnNsLqBEGyBBQxxfY7MlDSRYKVWQhlkiNA1ofgOyTjp
	 RpU++Oo3m2wwWpBByVRZJWrBS5QqoPzAhga/qh0GoIUk2Wdgce9DlQWIJQO1OfiBF/
	 pM332FqW2D2ue+xHPy5EdC7WU1nxgBLaP+YHqnnQ3NNGJXJ/KpxgHxXe8coU8GCyg0
	 37EUJBzRIKHUkfxQKZk/a/SR+5GJzubHNb5fZRlF/cbrzxGx8XkdlD+FP2PsCesFuk
	 +UV1CbWz7JfeD7yb+ZhAP9KoU7WVNvseiCAb22+jIsIPj2CyWYJ+CBHHGdmMtR8G/v
	 Kx11ZoyypywXQ==
Date: Mon, 8 Sep 2025 15:53:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com, 
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 04/14] PCI: cadence: Add helper functions for
 supporting High Perf Architecture (HPA)
Message-ID: <dyqe6bczkzfrd77ixwuydclak2tfvkno6def77omg6nfzod2lr@ykj6b7npzbxs>
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
 <20250901092052.4051018-5-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250901092052.4051018-5-hans.zhang@cixtech.com>

On Mon, Sep 01, 2025 at 05:20:42PM GMT, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Add helper functions, register read, register write functions and update
> platform data structures for supporting High Performance Architecture (HPA)
> PCIe controllers from Cadence.
> 
> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>

Again, no need to split this into a separate patch.

- Mani

> ---
>  .../controller/cadence/pcie-cadence-plat.c    |   4 -
>  drivers/pci/controller/cadence/pcie-cadence.h | 111 ++++++++++++++++--
>  2 files changed, 103 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> index ebd5c3afdfcd..b067a3296dd3 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -22,10 +22,6 @@ struct cdns_plat_pcie {
>  	struct cdns_pcie        *pcie;
>  };
>  
> -struct cdns_plat_pcie_of_data {
> -	bool is_rc;
> -};
> -
>  static const struct of_device_id cdns_plat_pcie_of_match[];
>  
>  static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index ddfc44f8d3ef..1174cf597bb0 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -26,6 +26,20 @@ struct cdns_pcie_rp_ib_bar {
>  };
>  
>  struct cdns_pcie;
> +struct cdns_pcie_rc;
> +
> +enum cdns_pcie_reg_bank {
> +	REG_BANK_RP,
> +	REG_BANK_IP_REG,
> +	REG_BANK_IP_CFG_CTRL_REG,
> +	REG_BANK_AXI_MASTER_COMMON,
> +	REG_BANK_AXI_MASTER,
> +	REG_BANK_AXI_SLAVE,
> +	REG_BANK_AXI_HLS,
> +	REG_BANK_AXI_RAS,
> +	REG_BANK_AXI_DTI,
> +	REG_BANKS_MAX,
> +};
>  
>  struct cdns_pcie_ops {
>  	int	(*start_link)(struct cdns_pcie *pcie);
> @@ -34,6 +48,30 @@ struct cdns_pcie_ops {
>  	u64     (*cpu_addr_fixup)(struct cdns_pcie *pcie, u64 cpu_addr);
>  };
>  
> +/**
> + * struct cdns_plat_pcie_of_data - Register bank offset for a platform
> + * @is_rc: controller is a RC
> + * @ip_reg_bank_offset: ip register bank start offset
> + * @ip_cfg_ctrl_reg_offset: ip config control register start offset
> + * @axi_mstr_common_offset: AXI master common register start offset
> + * @axi_slave_offset: AXI slave start offset
> + * @axi_master_offset: AXI master start offset
> + * @axi_hls_offset: AXI HLS offset start
> + * @axi_ras_offset: AXI RAS offset
> + * @axi_dti_offset: AXI DTI offset
> + */
> +struct cdns_plat_pcie_of_data {
> +	u32 is_rc:1;
> +	u32 ip_reg_bank_offset;
> +	u32 ip_cfg_ctrl_reg_offset;
> +	u32 axi_mstr_common_offset;
> +	u32 axi_slave_offset;
> +	u32 axi_master_offset;
> +	u32 axi_hls_offset;
> +	u32 axi_ras_offset;
> +	u32 axi_dti_offset;
> +};
> +
>  /**
>   * struct cdns_pcie - private data for Cadence PCIe controller drivers
>   * @reg_base: IO mapped register base
> @@ -45,16 +83,18 @@ struct cdns_pcie_ops {
>   * @link: list of pointers to corresponding device link representations
>   * @ops: Platform-specific ops to control various inputs from Cadence PCIe
>   *       wrapper
> + * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
>   */
>  struct cdns_pcie {
> -	void __iomem		*reg_base;
> -	struct resource		*mem_res;
> -	struct device		*dev;
> -	bool			is_rc;
> -	int			phy_count;
> -	struct phy		**phy;
> -	struct device_link	**link;
> -	const struct cdns_pcie_ops *ops;
> +	void __iomem		             *reg_base;
> +	struct resource		             *mem_res;
> +	struct device		             *dev;
> +	bool			             is_rc;
> +	int			             phy_count;
> +	struct phy		             **phy;
> +	struct device_link	             **link;
> +	const  struct cdns_pcie_ops          *ops;
> +	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
>  };
>  
>  /**
> @@ -132,6 +172,40 @@ struct cdns_pcie_ep {
>  	unsigned int		quirk_disable_flr:1;
>  };
>  
> +static inline u32 cdns_reg_bank_to_off(struct cdns_pcie *pcie, enum cdns_pcie_reg_bank bank)
> +{
> +	u32 offset = 0x0;
> +
> +	switch (bank) {
> +	case REG_BANK_IP_REG:
> +		offset = pcie->cdns_pcie_reg_offsets->ip_reg_bank_offset;
> +		break;
> +	case REG_BANK_IP_CFG_CTRL_REG:
> +		offset = pcie->cdns_pcie_reg_offsets->ip_cfg_ctrl_reg_offset;
> +		break;
> +	case REG_BANK_AXI_MASTER_COMMON:
> +		offset = pcie->cdns_pcie_reg_offsets->axi_mstr_common_offset;
> +		break;
> +	case REG_BANK_AXI_MASTER:
> +		offset = pcie->cdns_pcie_reg_offsets->axi_master_offset;
> +		break;
> +	case REG_BANK_AXI_SLAVE:
> +		offset = pcie->cdns_pcie_reg_offsets->axi_slave_offset;
> +		break;
> +	case REG_BANK_AXI_HLS:
> +		offset = pcie->cdns_pcie_reg_offsets->axi_hls_offset;
> +		break;
> +	case REG_BANK_AXI_RAS:
> +		offset = pcie->cdns_pcie_reg_offsets->axi_ras_offset;
> +		break;
> +	case REG_BANK_AXI_DTI:
> +		offset = pcie->cdns_pcie_reg_offsets->axi_dti_offset;
> +		break;
> +	default:
> +		break;
> +	};
> +	return offset;
> +}
>  
>  /* Register access */
>  static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 value)
> @@ -144,6 +218,27 @@ static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
>  	return readl(pcie->reg_base + reg);
>  }
>  
> +static inline void cdns_pcie_hpa_writel(struct cdns_pcie *pcie,
> +					enum cdns_pcie_reg_bank bank,
> +					u32 reg,
> +					u32 value)
> +{
> +	u32 offset = cdns_reg_bank_to_off(pcie, bank);
> +
> +	reg += offset;
> +	writel(value, pcie->reg_base + reg);
> +}
> +
> +static inline u32 cdns_pcie_hpa_readl(struct cdns_pcie *pcie,
> +				      enum cdns_pcie_reg_bank bank,
> +				      u32 reg)
> +{
> +	u32 offset = cdns_reg_bank_to_off(pcie, bank);
> +
> +	reg += offset;
> +	return readl(pcie->reg_base + reg);
> +}
> +
>  static inline u32 cdns_pcie_read_sz(void __iomem *addr, int size)
>  {
>  	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
> -- 
> 2.49.0
> 

-- 
மணிவண்ணன் சதாசிவம்

