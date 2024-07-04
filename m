Return-Path: <linux-pci+bounces-9804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 024AA92772E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 15:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDDA1F24DFE
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 13:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5823122067;
	Thu,  4 Jul 2024 13:30:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206D21AC22E;
	Thu,  4 Jul 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099816; cv=none; b=G7B0cXElhMeBrsFQGkXKPfwDXOqLXaJShKvpJvjl7aCc4jVMI/rZB6tVQXYQ9RF2u/R3HBrgKqM1v+r6PXvVHY7qTteg9Vk832B/4DbRBY+9qlUJ5V7GyC+Nk2UYWDlCIj/OUT6gheq7a5Eejzw4BT848eaChuEGrDN8v10gAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099816; c=relaxed/simple;
	bh=qyw+9BOLPFjApliCjvgcZJ9WV8peDn8Gi2IZ1+bzG5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TddBsFYshU/TO0EwBgIHqz0GZmFcHEsek4lCE2LUx8J1fv4jeU5555eSUwVTsvbghMCm7ZVpvHiJQ6phaeg7xTKJKn5KshIdquAEcjngWfffBqKCzdx5zUBYii1RB+S6oiRpNP2ofR0FAHnBZulB0Pb1uZdcypqvcQ8SCJE/ggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46C5D21A5B;
	Thu,  4 Jul 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74BB41369F;
	Thu,  4 Jul 2024 13:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 870IGuOjhmbAIAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 04 Jul 2024 13:30:11 +0000
Message-ID: <8433a148-47d5-49a0-b7ed-75801060bce7@suse.de>
Date: Thu, 4 Jul 2024 16:30:01 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] PCI: brcmstb: Refactor for chips with many
 regular inbound BARs
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
 <20240703180300.42959-10-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240703180300.42959-10-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 46C5D21A5B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi Jim,

On 7/3/24 21:02, Jim Quinlan wrote:
> Previously, our chips provided three inbound "BARS" with fixed purposes:
> the first was for mapping SOC registers, the second was for memory, and the
> third was for memory but with the endian swapped.  We typically only used
> one of these BARs.
> 
> Complicating that BARs usage was the fact that the PCIe HW would do a
> baroque internal mapping of system memory, and concatenate the regions of
> multiple memory controllers.
> 
> Newer chips such as the 7712 and Cable Modem SOCs have taken a step forward
> and now provide multiple inbound BARs.  This works in concert with the
> dma-ranges property, where each provided range becomes an inbound BAR.
> 
> This commit provides support for these new chips and their multiple
> inbound BARs but also keeps the legacy support for the older system.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 199 +++++++++++++++++++-------
>  1 file changed, 150 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index ffb3e8d8fb2a..5f632fdc0052 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -75,15 +75,12 @@
>  #define PCIE_MEM_WIN0_HI(win)	\
>  		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 8)
>  
> +#define PCIE_BRCM_MAX_RC_BARS				16
>  #define PCIE_MISC_RC_BAR1_CONFIG_LO			0x402c
>  #define  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK		0x1f
>  
> -#define PCIE_MISC_RC_BAR2_CONFIG_LO			0x4034
> -#define  PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK		0x1f
> -#define PCIE_MISC_RC_BAR2_CONFIG_HI			0x4038
> +#define PCIE_MISC_RC_BAR4_CONFIG_LO			0x40d4
>  
> -#define PCIE_MISC_RC_BAR3_CONFIG_LO			0x403c
> -#define  PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_MASK		0x1f
>  
>  #define PCIE_MISC_MSI_BAR_CONFIG_LO			0x4044
>  #define PCIE_MISC_MSI_BAR_CONFIG_HI			0x4048
> @@ -130,6 +127,10 @@
>  	  (PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK | \
>  	   PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK)
>  
> +#define PCIE_MISC_UBUS_BAR1_CONFIG_REMAP			0x40ac
> +#define  PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_EN_MASK	0x1
> +#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP			0x410c
> +
>  #define PCIE_MSI_INTR2_BASE		0x4500
>  
>  /* Offsets from INTR2_CPU and MSI_INTR2 BASE offsets */
> @@ -217,6 +218,13 @@ enum pcie_type {
>  	BCM4908,
>  	BCM7278,
>  	BCM2711,
> +	BCM7712,
> +};
> +
> +struct rc_bar {
> +	u64 size;
> +	u64 pci_offset;
> +	u64 cpu_addr;
>  };
>  
>  struct pcie_cfg_data {
> @@ -274,6 +282,7 @@ struct brcm_pcie {
>  	struct subdev_regulators *sr;
>  	bool			ep_wakeup_capable;
>  	bool			has_phy;
> +	int			num_inbound;
>  };
>  
>  static inline bool is_bmips(const struct brcm_pcie *pcie)
> @@ -789,23 +798,60 @@ static void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
>  	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>  }
>  
> -static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
> -							u64 *rc_bar2_size,
> -							u64 *rc_bar2_offset)
> +static inline void set_bar(struct rc_bar *b, int *count, u64 size,
> +			   u64 cpu_addr, u64 pci_offset)
> +{
> +	b->size = size;
> +	b->cpu_addr = cpu_addr;
> +	b->pci_offset = pci_offset;
> +	(*count)++;
> +}
> +
> +static int brcm_pcie_get_rc_bar_sizes_and_offsets(struct brcm_pcie *pcie,
> +						  struct rc_bar rc_bars[])
>  {
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> +	u64 pci_offset, cpu_addr, size = 0, tot_size = 0;
>  	struct resource_entry *entry;
>  	struct device *dev = pcie->dev;
>  	u64 lowest_pcie_addr = ~(u64)0;
> -	int ret, i = 0;
> -	u64 size = 0;
> +

Drop this ^^^ blank line.

> +	int ret, i = 0, n = 0;
> +
> +	/*
> +	 * The HW registers (and PCIe) use order-1 numbering for BARs. As
> +	 * such, we have rc_bars[0] unused and BAR1 starts at rc_bars[1].
> +	 */
> +	struct rc_bar *b_begin = &rc_bars[1];
> +	struct rc_bar *b = b_begin;
> +
> +	/*
> +	 * STB chips beside 7712 disable BAR1 by default.  It is mapped not
> +	 * to system memory but to a regiion all of the SOC registers.  No

typo.

Also I really do not understand the sentence "but to a regiion all of
the SOC registers" can you improve it, please?

> +	 * one uses this anymore.
> +	 */
> +	if (pcie->type != BCM7712)
> +		set_bar(b++, &n, 0, 0, 0);

It'd be nice if we can avoid such type (model) checks in the common
functions, but I don't have better idea.

>  
>  	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
>  		u64 pcie_beg = entry->res->start - entry->offset;
> +		u64 cpu_beg = entry->res->start;
>  
> -		size += entry->res->end - entry->res->start + 1;
> +		size = entry->res->end - entry->res->start + 1;

resource_size(entry->res) ?

> +		tot_size += size;
>  		if (pcie_beg < lowest_pcie_addr)
>  			lowest_pcie_addr = pcie_beg;
> +		/*
> +		 * 7712 and newer chips may have many BARs, with each
> +		 * offering a non-overlapping viewport to system memory.
> +		 * That being said, each BARs size must still be a power of
> +		 * two.
> +		 */
> +		if (pcie->type == BCM7712)
> +			set_bar(b++, &n, size, cpu_beg, pcie_beg);
> +
> +		if (n > pcie->num_inbound)
> +			break;
>  	}
>  
>  	if (lowest_pcie_addr == ~(u64)0) {
> @@ -813,13 +859,20 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * 7712 and newer chips do not have an internal memory mapping system
> +	 * that enables multiple memory controllers.  As such, it can return
> +	 * now w/o doing special configuration.
> +	 */
> +	if (pcie->type == BCM7712)
> +		return n;
> +
>  	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
>  						  PCIE_BRCM_MAX_MEMC);
> -
>  	if (ret <= 0) {
>  		/* Make an educated guess */
>  		pcie->num_memc = 1;
> -		pcie->memc_size[0] = 1ULL << fls64(size - 1);
> +		pcie->memc_size[0] = 1ULL << fls64(tot_size - 1);
>  	} else {
>  		pcie->num_memc = ret;
>  	}
> @@ -828,10 +881,15 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
>  	for (i = 0, size = 0; i < pcie->num_memc; i++)
>  		size += pcie->memc_size[i];
>  
> -	/* System memory starts at this address in PCIe-space */
> -	*rc_bar2_offset = lowest_pcie_addr;
> -	/* The sum of all memc views must also be a power of 2 */
> -	*rc_bar2_size = 1ULL << fls64(size - 1);
> +	/* Our HW mandates that the window size must be a power of 2 */
> +	size = 1ULL << fls64(size - 1);
> +
> +	/*
> +	 * For STB chips, the BAR2 cpu_addr is hardwired to the start
> +	 * of system memory, so we set it to 0.
> +	 */
> +	cpu_addr = 0;
> +	pci_offset = lowest_pcie_addr;
>  
>  	/*
>  	 * We validate the inbound memory view even though we should trust
> @@ -866,25 +924,50 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
>  	 *   outbound memory @ 3GB). So instead it will  start at the 1x
>  	 *   multiple of its size
>  	 */
> -	if (!*rc_bar2_size || (*rc_bar2_offset & (*rc_bar2_size - 1)) ||
> -	    (*rc_bar2_offset < SZ_4G && *rc_bar2_offset > SZ_2G)) {
> +	if (!size || (pci_offset & (size - 1)) ||
> +	    (pci_offset < SZ_4G && pci_offset > SZ_2G)) {
>  		dev_err(dev, "Invalid rc_bar2_offset/size: size 0x%llx, off 0x%llx\n",
> -			*rc_bar2_size, *rc_bar2_offset);
> +			size, pci_offset);
>  		return -EINVAL;
>  	}
>  
> -	return 0;
> +	/* Enable BAR2, the inbound window for STB chips */
> +	set_bar(b++, &n, size, cpu_addr, pci_offset);
> +
> +	/*
> +	 * Disable BAR3.  On some chips presents the same window as BAR2
> +	 * but the data appears in a settable endianness.
> +	 */
> +	set_bar(b++, &n, 0, 0, 0);
> +
> +	return n;
> +}
> +
> +static unsigned int brcm_calc_bar_reg_offset(int bar)

IMO brcm_bar_reg_offset name is better, i.e. drop "calc"

> +{
> +	if (bar <= 3)
> +		return PCIE_MISC_RC_BAR1_CONFIG_LO + 8 * (bar - 1);
> +	else
> +		return PCIE_MISC_RC_BAR4_CONFIG_LO + 8 * (bar - 4);
> +}
> +
> +static unsigned int brcm_calc_ubus_reg_offset(int bar)

ditto

> +{
> +	if (bar <= 3)
> +		return PCIE_MISC_UBUS_BAR1_CONFIG_REMAP + 8 * (bar - 1);
> +	else
> +		return PCIE_MISC_UBUS_BAR4_CONFIG_REMAP + 8 * (bar - 4);
>  }
>  
>  static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  {
> -	u64 rc_bar2_offset, rc_bar2_size;
> +	struct rc_bar rc_bars[PCIE_BRCM_MAX_RC_BARS];
>  	void __iomem *base = pcie->base;
>  	struct pci_host_bridge *bridge;
>  	struct resource_entry *entry;
>  	u32 tmp, burst, aspm_support;
> -	int num_out_wins = 0;
> -	int ret, memc;
> +	int num_out_wins = 0, num_rc_bars = 0;
> +	int i, memc;
>  
>  	/* Reset the bridge */
>  	pcie->bridge_sw_init_set(pcie, 1);
> @@ -933,17 +1016,47 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
>  	writel(tmp, base + PCIE_MISC_MISC_CTRL);
>  
> -	ret = brcm_pcie_get_rc_bar2_size_and_offset(pcie, &rc_bar2_size,
> -						    &rc_bar2_offset);
> -	if (ret)
> -		return ret;
> +	num_rc_bars = brcm_pcie_get_rc_bar_sizes_and_offsets(pcie, rc_bars);

Can we change the function name to brcm_pcie_get_inbound_regions? ...

> +	if (num_rc_bars < 0)
> +		return num_rc_bars;
> +
> +	for (i = 1; i <= num_rc_bars; i++) {
> +		u64 pci_offset = rc_bars[i].pci_offset;
> +		u64 cpu_addr = rc_bars[i].cpu_addr;
> +		u64 size = rc_bars[i].size;
> +		u32 reg_offset = brcm_calc_bar_reg_offset(i);

u32 is good type for reg offset but brcm_calc_bar_reg_offset() is
returning "unsigned int", could you unify the types to u32?

> +
> +		tmp = lower_32_bits(pci_offset);
> +		u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(size),
> +				  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK);
> +
> +		/* Write low */
> +		writel(tmp, base + reg_offset);
> +		/* Write high */
> +		writel(upper_32_bits(pci_offset),
> +		       base + reg_offset + 4);

no need of a new line for the second function argument.

> +
> +		/*
> +		 * Most STB chips:
> +		 *     Do nothing.
> +		 * 7712:
> +		 *     All of their BARs need to be set.
> +		 */
> +		if (pcie->type == BCM7712) {
> +			/* BUS remap register settings */
> +			reg_offset = brcm_calc_ubus_reg_offset(i);
> +			tmp = lower_32_bits(cpu_addr) & ~0xfff;
> +			tmp |= PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_EN_MASK;
> +			writel(tmp, base + reg_offset);
> +			tmp = upper_32_bits(cpu_addr);
> +			writel(tmp, base + reg_offset + 4);
> +		}
> +	}
>  

... and move this for loop in separate brcm_pcie_set_inbound_regions()
function?

> -	tmp = lower_32_bits(rc_bar2_offset);
> -	u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(rc_bar2_size),
> -			  PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK);
> -	writel(tmp, base + PCIE_MISC_RC_BAR2_CONFIG_LO);
> -	writel(upper_32_bits(rc_bar2_offset),
> -	       base + PCIE_MISC_RC_BAR2_CONFIG_HI);
> +	if (!brcm_pcie_rc_mode(pcie)) {
> +		dev_err(pcie->dev, "PCIe RC controller misconfigured as Endpoint\n");
> +		return -EINVAL;
> +	}
>  
>  	tmp = readl(base + PCIE_MISC_MISC_CTRL);
>  	for (memc = 0; memc < pcie->num_memc; memc++) {
> @@ -965,25 +1078,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	 * 4GB or when the inbound area is smaller than 4GB (taking into
>  	 * account the rounding-up we're forced to perform).
>  	 */
> -	if (rc_bar2_offset >= SZ_4G || (rc_bar2_size + rc_bar2_offset) < SZ_4G)
> +	if (rc_bars[2].pci_offset >= SZ_4G ||
> +	    (rc_bars[2].size + rc_bars[2].pci_offset) < SZ_4G)
>  		pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_LT_4GB;
>  	else
>  		pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_GT_4GB;
>  
> -	if (!brcm_pcie_rc_mode(pcie)) {
> -		dev_err(pcie->dev, "PCIe RC controller misconfigured as Endpoint\n");
> -		return -EINVAL;
> -	}
> -
> -	/* disable the PCIe->GISB memory window (RC_BAR1) */
> -	tmp = readl(base + PCIE_MISC_RC_BAR1_CONFIG_LO);
> -	tmp &= ~PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK;
> -	writel(tmp, base + PCIE_MISC_RC_BAR1_CONFIG_LO);
> -
> -	/* disable the PCIe->SCB memory window (RC_BAR3) */
> -	tmp = readl(base + PCIE_MISC_RC_BAR3_CONFIG_LO);
> -	tmp &= ~PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_MASK;
> -	writel(tmp, base + PCIE_MISC_RC_BAR3_CONFIG_LO);
>  
>  	/* Don't advertise L0s capability if 'aspm-no-l0s' */
>  	aspm_support = PCIE_LINK_STATE_L1;
> @@ -1623,6 +1723,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	pcie->perst_set = data->perst_set;
>  	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
>  	pcie->has_phy = data->has_phy;
> +	pcie->num_inbound = (pcie->type == BCM7712) ? 10 : 3;

num_inbound could be part of struct pcie_cfg_data ?

>  
>  	pcie->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pcie->base))

regards,
Stan

