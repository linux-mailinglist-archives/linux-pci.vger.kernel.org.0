Return-Path: <linux-pci+bounces-11743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3DC95426A
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 09:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4FF1C20F6F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 07:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A374112C7F9;
	Fri, 16 Aug 2024 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uXgabHWf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF557127B56
	for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792319; cv=none; b=QCs4zn1VlZ4sO1Kov0OSfrPbSlSHsdF5CSTjvklJFbDUdmeAvhh/AfXcaAUwdhECKNIsI4dPS+VSeRCTNLYwH6HbP8oviVxCDirm7YpsOCD6KuaPXrzKWbW9QtETmC66F7Gr83e6Se0Qi/mttPJVzhi9Y5kEU8RlApyJVJN67o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792319; c=relaxed/simple;
	bh=DQ1ujDX0PKjZizk/I/cE6Umn7NA2y6e5a8PJRYPAOwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAuTksCA882BpkOsgis2VpZJj0PKxEChjcK1JKNB4NU7lC35gtwaf4ZBnmcLiso/xgRrgkOWSD2gXR0WZ7SzeUoJEBmNjkLMi//lXJ903um3ln+1O9APaZCc4SFidIHQRDyN0oUhYNvAjrYxa1+FMFtEm+LG4W6sntoOWyJpMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uXgabHWf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20208830de8so3156085ad.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 00:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723792316; x=1724397116; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ClziXfrp8WE+Uwo9/zyuhiMED6I7Xz3m+9PJ+yYJRmg=;
        b=uXgabHWf7+v242E18V/q5XMitfb6v8Jd0tYu5oaNr9q2ryuZHJv9FMKI0YEhTO/uXA
         f9Ds8/T31CCtyQcqUeoemZdJ92Vk6M8nSLiH65hQr4NszoO5uL30sCWJU7z13yMNRSVK
         uGi4YvzGSl16WnR2tHIUdVmBm+Uw7h08cVR+tu1kAV8eZqM6RyW/89nCBgK1NbBqPpdZ
         EyJlq0y7wnfKB1zDZC1wiSwxk8sjr4472dNAXEOD9oFDaX412t4Leuj46i8jxlYyAPLo
         2CCjLGlIBi06BhYbw/T55B486OCkGA+STChb3IBpESEYSejfmV138ahECkNH4zGfG/jw
         jMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723792316; x=1724397116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ClziXfrp8WE+Uwo9/zyuhiMED6I7Xz3m+9PJ+yYJRmg=;
        b=NTBISvw/c5BA2Zfa5m7LCRRUiNho3xnPcIDPHepXrgtZ1DCQeM+/MTUWZ2jyIv9qqu
         /d47Rce0VdIjvpdIC5beLPM9P43Sj7o4aY7wI4HRDGzDsHRDVczOf5SVkQi9lcayilTK
         j/CTPC57jsSgViWioZRcwn5m2hF+R9SEj4ioV+5x2xbQ6jX8rCJk55O9JbIL66/akt7X
         sXh3uoFWAMT5ixBFlSDMhFefyNR6IXbyBrOeWbXP1fLRmV+CRsCWX2CE5cXWRIsvf9KZ
         mqupxY0ftukxbHFyLVOF5hWJq2drAnhiz6qpAN68CRojCWt151/kTUQPLZSqgevooZP5
         fRfg==
X-Gm-Message-State: AOJu0YwVrTsYTX8jhVHiFtly0YNZ7ZgEIE/pF9+ASrUiSNnWL796EaWZ
	J+rgJpCpd+V9DaoKQN4SbjtAEsqh8ELMWdwH/4ZVLMbYjFWnqPUAEHNov6BkvA==
X-Google-Smtp-Source: AGHT+IFO2o48SPtuLjCPPA7JFESGJT6ubCRsuiloKHkJSWmpzpTJseVdRUuw5Ko0xdKpy+RliqT1kw==
X-Received: by 2002:a17:903:2286:b0:201:fcd1:e430 with SMTP id d9443c01a7336-20203e4f514mr25737395ad.11.1723792315779;
        Fri, 16 Aug 2024 00:11:55 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03b15efsm19932765ad.306.2024.08.16.00.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:11:55 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:41:49 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 10/13] PCI: brcmstb: Refactor for chips with many
 regular inbound windows
Message-ID: <20240816071149.GL2331@thinkpad>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-11-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815225731.40276-11-james.quinlan@broadcom.com>

On Thu, Aug 15, 2024 at 06:57:23PM -0400, Jim Quinlan wrote:
> Provide support for new chips with multiple inbound windows while
> keeping the legacy support for the older chips.
> 
> In existing chips there are three inbound windows with fixed purposes: the
> first was for mapping SoC internal registers, the second was for memory,
> and the third was for memory but with the endian swapped.  Typically, only
> one window was used.
> 
> Complicating the inbound window usage was the fact that the PCIe HW would
> do a baroque internal mapping of system memory, and concatenate the regions
> of multiple memory controllers.
> 
> Newer chips such as the 7712 and Cable Modem SOCs take a step forward and
> drop the internal mapping while providing for multiple inbound windows.
> This works in concert with the dma-ranges property, where each provided
> range becomes an inbound window.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

LGTM!

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

It would be great if someone with knowledge of Broadcom chipset could review
this patch.

- Mani

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 235 ++++++++++++++++++++------
>  1 file changed, 181 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 2431c5a75cde..c5d3a5e9e0fc 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -75,15 +75,19 @@
>  #define PCIE_MEM_WIN0_HI(win)	\
>  		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 8)
>  
> +/*
> + * NOTE: You may see the term "BAR" in a number of register names used by
> + *   this driver.  The term is an artifact of when the HW core was an
> + *   endpoint device (EP).  Now it is a root complex (RC) and anywhere a
> + *   register has the term "BAR" it is related to an inbound window.
> + */
> +
> +#define PCIE_BRCM_MAX_INBOUND_WINS			16
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
> @@ -130,6 +134,10 @@
>  	  (PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK | \
>  	   PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK)
>  
> +#define PCIE_MISC_UBUS_BAR1_CONFIG_REMAP			0x40ac
> +#define  PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_EN_MASK	BIT(0)
> +#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP			0x410c
> +
>  #define PCIE_MSI_INTR2_BASE		0x4500
>  
>  /* Offsets from INTR2_CPU and MSI_INTR2 BASE offsets */
> @@ -217,12 +225,20 @@ enum pcie_type {
>  	BCM4908,
>  	BCM7278,
>  	BCM2711,
> +	BCM7712,
> +};
> +
> +struct inbound_win {
> +	u64 size;
> +	u64 pci_offset;
> +	u64 cpu_addr;
>  };
>  
>  struct pcie_cfg_data {
>  	const int *offsets;
>  	const enum pcie_type type;
>  	const bool has_phy;
> +	u8 num_inbound_wins;
>  	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
>  	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>  };
> @@ -274,6 +290,7 @@ struct brcm_pcie {
>  	struct subdev_regulators *sr;
>  	bool			ep_wakeup_capable;
>  	bool			has_phy;
> +	u8			num_inbound_wins;
>  };
>  
>  static inline bool is_bmips(const struct brcm_pcie *pcie)
> @@ -396,7 +413,7 @@ static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
>  }
>  
>  static void brcm_pcie_set_outbound_win(struct brcm_pcie *pcie,
> -				       unsigned int win, u64 cpu_addr,
> +				       u8 win, u64 cpu_addr,
>  				       u64 pcie_addr, u64 size)
>  {
>  	u32 cpu_addr_mb_high, limit_addr_mb_high;
> @@ -789,23 +806,62 @@ static void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
>  	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>  }
>  
> -static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
> -							u64 *rc_bar2_size,
> -							u64 *rc_bar2_offset)
> +static void add_inbound_win(struct inbound_win *b, u8 *count, u64 size,
> +			    u64 cpu_addr, u64 pci_offset)
> +{
> +	b->size = size;
> +	b->cpu_addr = cpu_addr;
> +	b->pci_offset = pci_offset;
> +	(*count)++;
> +}
> +
> +static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
> +				      struct inbound_win inbound_wins[])
>  {
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> +	u64 pci_offset, cpu_addr, size = 0, tot_size = 0;
>  	struct resource_entry *entry;
>  	struct device *dev = pcie->dev;
>  	u64 lowest_pcie_addr = ~(u64)0;
>  	int ret, i = 0;
> -	u64 size = 0;
> +	u8 n = 0;
> +
> +	/*
> +	 * The HW registers (and PCIe) use order-1 numbering for BARs. As
> +	 * such, we have inbound_wins[0] unused and BAR1 starts at inbound_wins[1].
> +	 */
> +	struct inbound_win *b_begin = &inbound_wins[1];
> +	struct inbound_win *b = b_begin;
> +
> +	/*
> +	 * STB chips beside 7712 disable the first inbound window default.
> +	 * Rather being mapped to system memory it is mapped to the
> +	 * internal registers of the SoC.  This feature is deprecated, has
> +	 * security considerations, and is not implemented in our modern
> +	 * SoCs.
> +	 */
> +	if (pcie->type != BCM7712)
> +		add_inbound_win(b++, &n, 0, 0, 0);
>  
>  	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> -		u64 pcie_beg = entry->res->start - entry->offset;
> +		u64 pcie_start = entry->res->start - entry->offset;
> +		u64 cpu_start = entry->res->start;
>  
> -		size += entry->res->end - entry->res->start + 1;
> -		if (pcie_beg < lowest_pcie_addr)
> -			lowest_pcie_addr = pcie_beg;
> +		size = resource_size(entry->res);
> +		tot_size += size;
> +		if (pcie_start < lowest_pcie_addr)
> +			lowest_pcie_addr = pcie_start;
> +		/*
> +		 * 7712 and newer chips may have many BARs, with each
> +		 * offering a non-overlapping viewport to system memory.
> +		 * That being said, each BARs size must still be a power of
> +		 * two.
> +		 */
> +		if (pcie->type == BCM7712)
> +			add_inbound_win(b++, &n, size, cpu_start, pcie_start);
> +
> +		if (n > pcie->num_inbound_wins)
> +			break;
>  	}
>  
>  	if (lowest_pcie_addr == ~(u64)0) {
> @@ -813,13 +869,20 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
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
> @@ -828,10 +891,15 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
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
> @@ -866,25 +934,90 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
>  	 *   outbound memory @ 3GB). So instead it will  start at the 1x
>  	 *   multiple of its size
>  	 */
> -	if (!*rc_bar2_size || (*rc_bar2_offset & (*rc_bar2_size - 1)) ||
> -	    (*rc_bar2_offset < SZ_4G && *rc_bar2_offset > SZ_2G)) {
> -		dev_err(dev, "Invalid rc_bar2_offset/size: size 0x%llx, off 0x%llx\n",
> -			*rc_bar2_size, *rc_bar2_offset);
> +	if (!size || (pci_offset & (size - 1)) ||
> +	    (pci_offset < SZ_4G && pci_offset > SZ_2G)) {
> +		dev_err(dev, "Invalid inbound_win2_offset/size: size 0x%llx, off 0x%llx\n",
> +			size, pci_offset);
>  		return -EINVAL;
>  	}
>  
> -	return 0;
> +	/* Enable inbound window 2, the main inbound window for STB chips */
> +	add_inbound_win(b++, &n, size, cpu_addr, pci_offset);
> +
> +	/*
> +	 * Disable inbound window 3.  On some chips presents the same
> +	 * window as #2 but the data appears in a settable endianness.
> +	 */
> +	add_inbound_win(b++, &n, 0, 0, 0);
> +
> +	return n;
> +}
> +
> +static u32 brcm_bar_reg_offset(int bar)
> +{
> +	if (bar <= 3)
> +		return PCIE_MISC_RC_BAR1_CONFIG_LO + 8 * (bar - 1);
> +	else
> +		return PCIE_MISC_RC_BAR4_CONFIG_LO + 8 * (bar - 4);
> +}
> +
> +static u32 brcm_ubus_reg_offset(int bar)
> +{
> +	if (bar <= 3)
> +		return PCIE_MISC_UBUS_BAR1_CONFIG_REMAP + 8 * (bar - 1);
> +	else
> +		return PCIE_MISC_UBUS_BAR4_CONFIG_REMAP + 8 * (bar - 4);
> +}
> +
> +static void set_inbound_win_registers(struct brcm_pcie *pcie,
> +				      const struct inbound_win *inbound_wins,
> +				      u8 num_inbound_wins)
> +{
> +	void __iomem *base = pcie->base;
> +	int i;
> +
> +	for (i = 1; i <= num_inbound_wins; i++) {
> +		u64 pci_offset = inbound_wins[i].pci_offset;
> +		u64 cpu_addr = inbound_wins[i].cpu_addr;
> +		u64 size = inbound_wins[i].size;
> +		u32 reg_offset = brcm_bar_reg_offset(i);
> +		u32 tmp = lower_32_bits(pci_offset);
> +
> +		u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(size),
> +				  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK);
> +
> +		/* Write low */
> +		writel_relaxed(tmp, base + reg_offset);
> +		/* Write high */
> +		writel_relaxed(upper_32_bits(pci_offset), base + reg_offset + 4);
> +
> +		/*
> +		 * Most STB chips:
> +		 *     Do nothing.
> +		 * 7712:
> +		 *     All of their BARs need to be set.
> +		 */
> +		if (pcie->type == BCM7712) {
> +			/* BUS remap register settings */
> +			reg_offset = brcm_ubus_reg_offset(i);
> +			tmp = lower_32_bits(cpu_addr) & ~0xfff;
> +			tmp |= PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_EN_MASK;
> +			writel_relaxed(tmp, base + reg_offset);
> +			tmp = upper_32_bits(cpu_addr);
> +			writel_relaxed(tmp, base + reg_offset + 4);
> +		}
> +	}
>  }
>  
>  static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  {
> -	u64 rc_bar2_offset, rc_bar2_size;
> +	struct inbound_win inbound_wins[PCIE_BRCM_MAX_INBOUND_WINS];
>  	void __iomem *base = pcie->base;
>  	struct pci_host_bridge *bridge;
>  	struct resource_entry *entry;
>  	u32 tmp, burst, aspm_support;
> -	int num_out_wins = 0;
> -	int ret, memc;
> +	u8 num_out_wins = 0, num_inbound_wins = 0;
> +	int memc;
>  
>  	/* Reset the bridge */
>  	pcie->bridge_sw_init_set(pcie, 1);
> @@ -933,17 +1066,16 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
>  	writel(tmp, base + PCIE_MISC_MISC_CTRL);
>  
> -	ret = brcm_pcie_get_rc_bar2_size_and_offset(pcie, &rc_bar2_size,
> -						    &rc_bar2_offset);
> -	if (ret)
> -		return ret;
> +	num_inbound_wins = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
> +	if (num_inbound_wins < 0)
> +		return num_inbound_wins;
> +
> +	set_inbound_win_registers(pcie, inbound_wins, num_inbound_wins);
>  
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
> @@ -965,25 +1097,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	 * 4GB or when the inbound area is smaller than 4GB (taking into
>  	 * account the rounding-up we're forced to perform).
>  	 */
> -	if (rc_bar2_offset >= SZ_4G || (rc_bar2_size + rc_bar2_offset) < SZ_4G)
> +	if (inbound_wins[2].pci_offset >= SZ_4G ||
> +	    (inbound_wins[2].size + inbound_wins[2].pci_offset) < SZ_4G)
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
> @@ -1034,7 +1153,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  		num_out_wins++;
>  	}
>  
> -	/* PCIe->SCB endian mode for BAR */
> +	/* PCIe->SCB endian mode for inbound window */
>  	tmp = readl(base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
>  	u32p_replace_bits(&tmp, PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN,
>  		PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK);
> @@ -1516,6 +1635,7 @@ static const struct pcie_cfg_data generic_cfg = {
>  	.type		= GENERIC,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.num_inbound_wins = 3,
>  };
>  
>  static const struct pcie_cfg_data bcm7425_cfg = {
> @@ -1523,6 +1643,7 @@ static const struct pcie_cfg_data bcm7425_cfg = {
>  	.type		= BCM7425,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.num_inbound_wins = 3,
>  };
>  
>  static const struct pcie_cfg_data bcm7435_cfg = {
> @@ -1530,6 +1651,7 @@ static const struct pcie_cfg_data bcm7435_cfg = {
>  	.type		= BCM7435,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.num_inbound_wins = 3,
>  };
>  
>  static const struct pcie_cfg_data bcm4908_cfg = {
> @@ -1537,6 +1659,7 @@ static const struct pcie_cfg_data bcm4908_cfg = {
>  	.type		= BCM4908,
>  	.perst_set	= brcm_pcie_perst_set_4908,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.num_inbound_wins = 3,
>  };
>  
>  static const int pcie_offset_bcm7278[] = {
> @@ -1552,6 +1675,7 @@ static const struct pcie_cfg_data bcm7278_cfg = {
>  	.type		= BCM7278,
>  	.perst_set	= brcm_pcie_perst_set_7278,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
> +	.num_inbound_wins = 3,
>  };
>  
>  static const struct pcie_cfg_data bcm2711_cfg = {
> @@ -1559,6 +1683,7 @@ static const struct pcie_cfg_data bcm2711_cfg = {
>  	.type		= BCM2711,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.num_inbound_wins = 3,
>  };
>  
>  static const struct pcie_cfg_data bcm7216_cfg = {
> @@ -1567,6 +1692,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
>  	.perst_set	= brcm_pcie_perst_set_7278,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
>  	.has_phy	= true,
> +	.num_inbound_wins = 3,
>  };
>  
>  static const struct of_device_id brcm_pcie_match[] = {
> @@ -1623,6 +1749,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	pcie->perst_set = data->perst_set;
>  	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
>  	pcie->has_phy = data->has_phy;
> +	pcie->num_inbound_wins = data->num_inbound_wins;
>  
>  	pcie->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pcie->base))
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

