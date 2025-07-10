Return-Path: <linux-pci+bounces-31864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A915AB009D9
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 19:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EC8188B84C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 17:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE1F2F0059;
	Thu, 10 Jul 2025 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+aamgVi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B3722423A;
	Thu, 10 Jul 2025 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168249; cv=none; b=Z3XqMTc2MKHi+Wb8QuvB21Ohc966WpaQvEinY7zcuaOWLYFvdBqdEUCqgDvxtjIPTOONJQ3TRmB7MoBtzdj1aOs1rZ8pvXR4GVFV3thRh7txFmXFUMAVStnYxnWWP8cdb3Zh7Hp7p/vQEX2vpQcAeLJNmb1ykARopD8jq0+4E7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168249; c=relaxed/simple;
	bh=bBY6G4CmoJPp3nvoRI7djJMZRFtwE43pIk9xRY4J9pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ1PpuUhlDUUw3useYuI4RAMO1NW2jQW+Gc77n8/dG/KKryXMDkD16wmoihwv1Rcs1k4q95v1yNTglwi49vSECSbt+CUj9Vn63jqLIb9u7rOsaHgRrngU67sYrINTCjN0h9F74Rc76OKClQUr28lb6am4q4i5xwgQjgFT8ISS1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+aamgVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900CEC4CEE3;
	Thu, 10 Jul 2025 17:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752168248;
	bh=bBY6G4CmoJPp3nvoRI7djJMZRFtwE43pIk9xRY4J9pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+aamgVi1bu3Jew7vJvGAoNSuEJ00hmNYGeKWpbG+sxZ2RDbfBm8X9GPK7oyw3Rls
	 J4eUm0PcYhQWqqiQo4INprz4jFsiTZZKPI319APm1YpjCD8GQmXK7mai+eHF8Dq1Xa
	 1yaABODAZn0QKIllj0+ZhHmG0vQeZeXXvh668ym48rxFmZNGr5j1yrrXZI/MxV5MLQ
	 6vsm/HAqMyypPUP3B0qSQpwNlmwWF4W+cJ6GUIF3gS21uB3nJtHg4u69o9BMC2LyD5
	 13s9C7GX+wDKdoJWEPg9ZYAr6Q1XYjAusmXDaNBr/VB2QNor9OKF1kH8IWKblBBRpi
	 jKZsGVzzqZlKA==
Date: Thu, 10 Jul 2025 22:53:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: brcmstb: Enable Broadcom Cable Modem SoCs
Message-ID: <a2ebnh3hmcbd5zr545cwu7bcbv6xbhvv7qnsjzovqbkar5apak@kviufeyk5ssr>
References: <20250609221710.10315-1-james.quinlan@broadcom.com>
 <20250609221710.10315-4-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609221710.10315-4-james.quinlan@broadcom.com>

On Mon, Jun 09, 2025 at 06:17:06PM GMT, Jim Quinlan wrote:
> Broadcom's Cable Modem (CM) group also uses this PCIe driver
> as it shares the PCIe HW core with the STB group.
> 
> Make the modifications to enable the CM SoCs.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 186 +++++++++++++++++++++-----
>  1 file changed, 152 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index db7872cda960..e25dbcdc56a7 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -51,6 +51,9 @@
>  #define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
>  #define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK	0xf8
>  
> +#define PCIE_RC_DL_PDL_CONTROL_4			0x1010
> +#define  PCIE_RC_DL_PDL_CONTROL_4_NPH_FC_INIT_MASK	0xff000000

Could you please use GENMASK()?

> +
>  #define PCIE_RC_DL_MDIO_ADDR				0x1100
>  #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
>  #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
> @@ -60,6 +63,7 @@
>  #define  PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK	0xff
>  
>  #define PCIE_MISC_MISC_CTRL				0x4008
> +#define  PCIE_MISC_MISC_CTRL_PCIE_IN_CPL_RO_MASK	0x20
>  #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK	0x80
>  #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK	0x400
>  #define  PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK		0x1000
> @@ -170,6 +174,7 @@
>  /* MSI target addresses */
>  #define BRCM_MSI_TARGET_ADDR_LT_4GB	0x0fffffffcULL
>  #define BRCM_MSI_TARGET_ADDR_GT_4GB	0xffffffffcULL
> +#define BRCM_MSI_TARGET_ADDR_FOR_CM	0xfffffffffcULL
>  
>  /* MDIO registers */
>  #define MDIO_PORT0			0x0
> @@ -223,13 +228,23 @@ enum {
>  enum pcie_soc_base {
>  	GENERIC,
>  	BCM2711,
> +	BCM3162,
> +	BCM3392,
> +	BCM3390,
>  	BCM4908,
>  	BCM7278,
>  	BCM7425,
>  	BCM7435,
>  	BCM7712,
> +	BCM33940,
>  };
>  
> +/*
> + * BCM3390 CM chip actually conforms to STB design, so it
> + * is not present in the macro below.
> + */
> +#define IS_CM_SOC(t) ((t) == BCM3162 || (t) == BCM33940 || (t) == BCM3392)

TBH, I don't like these soc_base comparisions sprinkled throghout the driver.
They just make the code messy and it will become a nightmare to maintain if
these comparisions grow in the future (it already is).

I would rather like to have function specific flags that are set for specific
SoCs and those flags be used in the code for conditional check instead of the
soc_base.

It would make it easier to understand what functionalities are supported by each
SoC and where exactly those functionalities are implemented.

- Mani

> +
>  struct inbound_win {
>  	u64 size;
>  	u64 pci_offset;
> @@ -757,6 +772,9 @@ static int brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>  	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
>  	int ret = 0;
>  
> +	if (IS_CM_SOC(pcie->cfg->soc_base))
> +		return 0;
> +
>  	if (pcie->bridge_reset) {
>  		if (val)
>  			ret = reset_control_assert(pcie->bridge_reset);
> @@ -891,13 +909,13 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
>  	struct inbound_win *b = b_begin;
>  
>  	/*
> -	 * STB chips beside 7712 disable the first inbound window default.
> -	 * Rather being mapped to system memory it is mapped to the
> -	 * internal registers of the SoC.  This feature is deprecated, has
> -	 * security considerations, and is not implemented in our modern
> -	 * SoCs.
> +	 * STB chips beside CM chips and 7712 disable the first inbound
> +	 * window default.  Rather being mapped to system memory it is
> +	 * mapped to the internal registers of the SoC.  This feature is
> +	 * deprecated, has security considerations, and is not
> +	 * implemented in our modern SoCs.
>  	 */
> -	if (pcie->cfg->soc_base != BCM7712)
> +	if (pcie->cfg->soc_base != BCM7712 && !IS_CM_SOC(pcie->cfg->soc_base))
>  		add_inbound_win(b++, &n, 0, 0, 0);
>  
>  	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> @@ -905,16 +923,32 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
>  		u64 cpu_start = entry->res->start;
>  
>  		size = resource_size(entry->res);
> +
> +		/*
> +		 * For BCM3390, single dma-range may map to the SoC
> +		 * register space in [0xf0000000..0xffffffff].  If present,
> +		 * this has to be assigned to inbound window #1, as this is
> +		 * the only one that HW allows to map to register space.
> +		 * So if we see this range, place it in inbound_wins[1]
> +		 * which is previously disabled (zeroed out).
> +		 */
> +		if (pcie->cfg->soc_base == BCM3390 && cpu_start >= 0xf0000000
> +		    && cpu_start + size - 1 <= 0xffffffff) {
> +			add_inbound_win(b_begin, &n, size, cpu_start, pcie_start);
> +			n--;
> +			continue;
> +		}
> +
>  		tot_size += size;
>  		if (pcie_start < lowest_pcie_addr)
>  			lowest_pcie_addr = pcie_start;
>  		/*
> -		 * 7712 and newer chips may have many BARs, with each
> -		 * offering a non-overlapping viewport to system memory.
> -		 * That being said, each BARs size must still be a power of
> -		 * two.
> +		 * 7712, CM, and newer chips may have many inbound windows,
> +		 * with each offering a non-overlapping viewport to system
> +		 * memory.  That being said, each window's size must still
> +		 * be a power of two.
>  		 */
> -		if (pcie->cfg->soc_base == BCM7712)
> +		if (pcie->cfg->soc_base == BCM7712 || IS_CM_SOC(pcie->cfg->soc_base))
>  			add_inbound_win(b++, &n, size, cpu_start, pcie_start);
>  
>  		if (n > pcie->cfg->num_inbound_wins)
> @@ -927,11 +961,11 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
>  	}
>  
>  	/*
> -	 * 7712 and newer chips do not have an internal memory mapping system
> -	 * that enables multiple memory controllers.  As such, it can return
> -	 * now w/o doing special configuration.
> +	 * 7712, CM, and newer chips do not have an internal memory
> +	 * mapping system that enables multiple memory controllers.  As
> +	 * such, it can return now w/o doing special configuration.
>  	 */
> -	if (pcie->cfg->soc_base == BCM7712)
> +	if (pcie->cfg->soc_base == BCM7712 || IS_CM_SOC(pcie->cfg->soc_base))
>  		return n;
>  
>  	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
> @@ -1051,10 +1085,10 @@ static void set_inbound_win_registers(struct brcm_pcie *pcie,
>  		/*
>  		 * Most STB chips:
>  		 *     Do nothing.
> -		 * 7712:
> -		 *     All of their BARs need to be set.
> +		 * 7712, CM:
> +		 *     All of their inbound windows need to be set.
>  		 */
> -		if (pcie->cfg->soc_base == BCM7712) {
> +		if (pcie->cfg->soc_base == BCM7712 || IS_CM_SOC(pcie->cfg->soc_base)) {
>  			/* BUS remap register settings */
>  			reg_offset = brcm_ubus_reg_offset(i);
>  			tmp = lower_32_bits(cpu_addr) & ~0xfff;
> @@ -1118,6 +1152,8 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  		burst = 0x0; /* 128 bytes */
>  	else if (pcie->cfg->soc_base == BCM7278)
>  		burst = 0x3; /* 512 bytes */
> +	else if (pcie->cfg->soc_base == BCM3162 || pcie->cfg->soc_base == BCM33940)
> +		burst = 0x1; /* Encoding: 0=64, 1=128, 2=Rsvd, 3=Rsvd */
>  	else
>  		burst = 0x2; /* 512 bytes */
>  
> @@ -1144,18 +1180,20 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  		return -EINVAL;
>  	}
>  
> -	tmp = readl(base + PCIE_MISC_MISC_CTRL);
> -	for (memc = 0; memc < pcie->num_memc; memc++) {
> -		u32 scb_size_val = ilog2(pcie->memc_size[memc]) - 15;
> -
> -		if (memc == 0)
> -			u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(0));
> -		else if (memc == 1)
> -			u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(1));
> -		else if (memc == 2)
> -			u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(2));
> +	if (!IS_CM_SOC(pcie->cfg->soc_base)) {
> +		tmp = readl(base + PCIE_MISC_MISC_CTRL);
> +		for (memc = 0; memc < pcie->num_memc; memc++) {
> +			u32 scb_size_val = ilog2(pcie->memc_size[memc]) - 15;
> +
> +			if (memc == 0)
> +				u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(0));
> +			else if (memc == 1)
> +				u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(1));
> +			else if (memc == 2)
> +				u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(2));
> +		}
> +		writel(tmp, base + PCIE_MISC_MISC_CTRL);
>  	}
> -	writel(tmp, base + PCIE_MISC_MISC_CTRL);
>  
>  	/*
>  	 * We ideally want the MSI target address to be located in the 32bit
> @@ -1164,8 +1202,10 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	 * 4GB or when the inbound area is smaller than 4GB (taking into
>  	 * account the rounding-up we're forced to perform).
>  	 */
> -	if (inbound_wins[2].pci_offset >= SZ_4G ||
> -	    (inbound_wins[2].size + inbound_wins[2].pci_offset) < SZ_4G)
> +	if (IS_CM_SOC(pcie->cfg->soc_base))
> +		pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_FOR_CM;
> +	else if (inbound_wins[2].pci_offset >= SZ_4G ||
> +		 (inbound_wins[2].size + inbound_wins[2].pci_offset) < SZ_4G)
>  		pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_LT_4GB;
>  	else
>  		pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_GT_4GB;
> @@ -1226,6 +1266,29 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  		PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK);
>  	writel(tmp, base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
>  
> +	/*
> +	 * Relax read ordering for chip architectures using RBUS/SCB that
> +	 * use WiFi Runner offload (i.e. BCM3390) to avoid deadlock where
> +	 * reads are blocked by writes.
> +	 */
> +	if (pcie->cfg->soc_base == BCM3390) {
> +		tmp = readl(base + PCIE_MISC_MISC_CTRL);
> +		u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_IN_CPL_RO_MASK);
> +		writel(tmp, base + PCIE_MISC_MISC_CTRL);
> +	}
> +
> +	/*
> +	 * The 3392 has a bug that requires the NP credit advertised by the
> +	 * MAC to be overwritten with 0x10 in bits 31:24 of the following
> +	 * register.
> +	 */
> +	if (pcie->cfg->soc_base == BCM3392) {
> +		tmp = readl(base + PCIE_RC_DL_PDL_CONTROL_4);
> +		u32p_replace_bits(&tmp, 0x10,
> +				  PCIE_RC_DL_PDL_CONTROL_4_NPH_FC_INIT_MASK);
> +		writel(tmp, base + PCIE_RC_DL_PDL_CONTROL_4);
> +	}
> +
>  	if (pcie->cfg->post_setup) {
>  		ret = pcie->cfg->post_setup(pcie);
>  		if (ret < 0)
> @@ -1246,8 +1309,8 @@ static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
>  	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
>  	u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */
>  
> -	/* 7712 does not have this (RGR1) timer */
> -	if (pcie->cfg->soc_base == BCM7712)
> +	/* CM and 7712 do not have this (RGR1) timer */
> +	if (IS_CM_SOC(pcie->cfg->soc_base) || pcie->cfg->soc_base == BCM7712)
>  		return;
>  
>  	/* Each unit in timeout register is 1/216,000,000 seconds */
> @@ -1354,7 +1417,10 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>  
>  	brcm_config_clkreq(pcie);
>  
> -	if (pcie->ssc) {
> +	if (IS_CM_SOC(pcie->cfg->soc_base)) {
> +		/* This driver does configure SSC for CM chips */
> +		ssc_str = "";
> +	} else if (pcie->ssc) {
>  		ret = brcm_pcie_set_ssc(pcie);
>  		if (ret == 0)
>  			ssc_str = "(SSC)";
> @@ -1715,6 +1781,14 @@ static const int pcie_offsets[] = {
>  	[PCIE_INTR2_CPU_BASE]	= 0x4300,
>  };
>  
> +static const int pcie_offset_bcm3162[] = {
> +	[RGR1_SW_INIT_1] = 0x9210,
> +	[EXT_CFG_INDEX] = 0x9000,
> +	[EXT_CFG_DATA] = 0x9004,
> +	[PCIE_HARD_DEBUG] = 0x4204,
> +	[PCIE_INTR2_CPU_BASE] = 0x4300
> +};
> +
>  static const int pcie_offsets_bcm7278[] = {
>  	[RGR1_SW_INIT_1]	= 0xc010,
>  	[EXT_CFG_INDEX]		= 0x9000,
> @@ -1739,6 +1813,14 @@ static const int pcie_offsets_bcm7712[] = {
>  	[PCIE_INTR2_CPU_BASE]	= 0x4400,
>  };
>  
> +static const int pcie_offset_bcm33940[] = {
> +	[RGR1_SW_INIT_1] = 0x9210,
> +	[EXT_CFG_INDEX] = 0x9000,
> +	[EXT_CFG_DATA] = 0x9004,
> +	[PCIE_HARD_DEBUG] = 0x4304,
> +	[PCIE_INTR2_CPU_BASE] = 0x4400
> +};
> +
>  static const struct pcie_cfg_data generic_cfg = {
>  	.offsets	= pcie_offsets,
>  	.soc_base	= GENERIC,
> @@ -1765,6 +1847,30 @@ static const struct pcie_cfg_data bcm2712_cfg = {
>  	.num_inbound_wins = 10,
>  };
>  
> +static const struct pcie_cfg_data bcm3162_cfg = {
> +	.offsets	= pcie_offset_bcm3162,
> +	.soc_base	= BCM3162,
> +	.perst_set	= brcm_pcie_perst_set_7278,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.num_inbound_wins = 3,
> +};
> +
> +static const struct pcie_cfg_data bcm3392_cfg = {
> +	.offsets	= pcie_offset_bcm33940,
> +	.soc_base	= BCM3392,
> +	.perst_set	= brcm_pcie_perst_set_7278,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.num_inbound_wins = 10,
> +};
> +
> +static const struct pcie_cfg_data bcm3390_cfg = {
> +	.offsets	= pcie_offsets,
> +	.soc_base	= BCM3390,
> +	.perst_set	= brcm_pcie_perst_set_generic,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.num_inbound_wins = 3,
> +};
> +
>  static const struct pcie_cfg_data bcm4908_cfg = {
>  	.offsets	= pcie_offsets,
>  	.soc_base	= BCM4908,
> @@ -1814,9 +1920,20 @@ static const struct pcie_cfg_data bcm7712_cfg = {
>  	.num_inbound_wins = 10,
>  };
>  
> +static const struct pcie_cfg_data bcm33940_cfg = {
> +	.offsets	= pcie_offset_bcm33940,
> +	.soc_base	= BCM33940,
> +	.perst_set	= brcm_pcie_perst_set_7278,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.num_inbound_wins = 10,
> +};
> +
>  static const struct of_device_id brcm_pcie_match[] = {
>  	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
>  	{ .compatible = "brcm,bcm2712-pcie", .data = &bcm2712_cfg },
> +	{ .compatible = "brcm,bcm3162-pcie", .data = &bcm3162_cfg },
> +	{ .compatible = "brcm,bcm3390-pcie", .data = &bcm3390_cfg },
> +	{ .compatible = "brcm,bcm3392-pcie", .data = &bcm3392_cfg },
>  	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
>  	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
>  	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7216_cfg },
> @@ -1825,6 +1942,7 @@ static const struct of_device_id brcm_pcie_match[] = {
>  	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
>  	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
>  	{ .compatible = "brcm,bcm7712-pcie", .data = &bcm7712_cfg },
> +	{ .compatible = "brcm,bcm33940-pcie", .data = &bcm33940_cfg },
>  	{},
>  };
>  
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

