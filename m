Return-Path: <linux-pci+bounces-10757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C10B93BBD9
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 06:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1181F21DBF
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 04:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C491BC43;
	Thu, 25 Jul 2024 04:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9/m3Vsc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50E817565
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 04:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721883208; cv=none; b=UHubw36vtslh0ytKWQuxoJ2ypstDqNT8isJrdGdVTyV3P+PZmRFCFFwfQPDgTb1tmkG8Jdxf1/SiGq3aT9yOKAwr1MsqNJ0AouMzzjirKPETuS0P1DfSAgkpELca/+pFA2TVK2jq7jLBu4AxI5yz2I+neXy6KllPxw/yt43PWD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721883208; c=relaxed/simple;
	bh=YWi5i1LaKgMTHX2D3uXkmGLH8K2J/GsLer1eKMm/JCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUkdbHLDEE1B7dzhbzQzu9HRC/GEr9kdppcMi/GGcT0uQPoLCwzV47Na5DAzSE9IHrikkgv6hJJ2n6GfPjdcJDmbXigIGka67f9HVrDHZKwk8Oy36tqgX70w8cf2j34mwjxjah09jsgwoqj1pr9yv0Vfz8mAUxOy8fDEH+TdSsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k9/m3Vsc; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cd5d6b2581so378793a91.2
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 21:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721883205; x=1722488005; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XHka6xK/vM9dfzes1lmzo5qn8KCaxtxm6rlRDqclImw=;
        b=k9/m3VscX1soBpnyIEqxFyfltBqwemRWmdbHU0zhFTRw4qH+j6rpm9J3DH2PY9Fo0r
         BpFr0o0h/tZ5F+/0oll4KaxOZHXomp51jBsd2Xeg8ic52c3oPbFC+r4oNoyOdVeBr8oE
         bT1yy3j9O1TheBPmVJdRyxKq7h6kwXThqDzm9M5J1iEQrwaGdsmNIUyLTBkOUzsNZQ9g
         I9AAkNIU0NJrxMSrL2rXgYEeskJxr8edbjHoOxyZU2Y3QrFbLisnIXBl//rqmv/X9SzN
         cisIIZKjZbIyg45B7oAQAHGNjzKqn/kTqizrC/5Xx88J5ZkH7Wj7+GEQnAZQ6mE7bXBv
         zg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721883205; x=1722488005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHka6xK/vM9dfzes1lmzo5qn8KCaxtxm6rlRDqclImw=;
        b=n1r+axUavZWY5bPeN0NJkO0Y971qm5SfVqmvecbjp0jSTdJxbZzPgy0tPy48inbaBv
         xTiJ0VS0ybUGgWyhYk6BhgMIVD2rHROq1k8NyHIEH6T5e0RpbzNvQvn0lR7xuSySTTwB
         o/ivMM5FEnbJkLVvN8J0o4921grtdXZWWiaQbm/ySIQvmRUDQ0rYVTCOlkmgV+tv9jq2
         AfB1BwClp2ROqK6tOdbGOaO6VwrII4Hda0ILzqgz5kGhpzWjk8ppLIav57twvJpqSm03
         nhYzCliJUdl/z+YdssiqQQOrvzN6J39PAUC5QwmMQSyTlEsMkHNhmtNJ7h8IvQCAWwbF
         JXcg==
X-Gm-Message-State: AOJu0Yw+4vRdIFvVOSRj6OxEELyWEpSZUtlOj3jVgM7HzQ3YYHsFUT5t
	FmqRWcIexURSOedoATk4JghE7OMkUqIyOif9bmdTUsEqatWwbF12wIw9BU3xpg==
X-Google-Smtp-Source: AGHT+IGPV/IOkR/haWLlRHyuPuCoJxPZ/XqHcBV72Qwyp4LaL/uJZ+/YBE2A2SD4Y0Ja+QpmE/Oa3g==
X-Received: by 2002:a17:90b:4c8b:b0:2c8:8a5:c1b9 with SMTP id 98e67ed59e1d1-2cf2e9e1a57mr780707a91.13.1721883204777;
        Wed, 24 Jul 2024 21:53:24 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c7f7b0sm532091a91.23.2024.07.24.21.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:53:24 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:23:18 +0530
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
Subject: Re: [PATCH v4 09/12] PCI: brcmstb: Refactor for chips with many
 regular inbound BARs
Message-ID: <20240725045318.GJ2317@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-10-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716213131.6036-10-james.quinlan@broadcom.com>

On Tue, Jul 16, 2024 at 05:31:24PM -0400, Jim Quinlan wrote:
> Previously, our chips provided three inbound "BARS" with fixed purposes:
> the first was for mapping SoC internal registers, the second was for
> memory, and the third was for memory but with the endian swapped.  We
> typically only used one of these BARs.
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

BAR belongs to the endpoints not to the RC. How can the RC have 'BARs'? RC can
only map endpoint BARs to MEM region. What you are referring to is 'MEM region'
maybe?

- Mani

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 216 ++++++++++++++++++++------
>  1 file changed, 167 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 8ab5a8ca05b4..c44a92217855 100644
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
> +#define  PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_EN_MASK	BIT(0)
> +#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP			0x410c
> +
>  #define PCIE_MSI_INTR2_BASE		0x4500
>  
>  /* Offsets from INTR2_CPU and MSI_INTR2 BASE offsets */
> @@ -217,12 +218,20 @@ enum pcie_type {
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
>  	const int *offsets;
>  	const enum pcie_type type;
>  	const bool has_phy;
> +	unsigned int num_inbound;
>  	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
>  	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>  };
> @@ -274,6 +283,7 @@ struct brcm_pcie {
>  	struct subdev_regulators *sr;
>  	bool			ep_wakeup_capable;
>  	bool			has_phy;
> +	int			num_inbound;
>  };
>  
>  static inline bool is_bmips(const struct brcm_pcie *pcie)
> @@ -789,23 +799,61 @@ static void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
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
> +static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
> +				      struct rc_bar rc_bars[])
>  {
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> +	u64 pci_offset, cpu_addr, size = 0, tot_size = 0;
>  	struct resource_entry *entry;
>  	struct device *dev = pcie->dev;
>  	u64 lowest_pcie_addr = ~(u64)0;
> -	int ret, i = 0;
> -	u64 size = 0;
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
> +	 * STB chips beside 7712 disable the first inbound window default.
> +	 * Rather being mapped to system memory it is mapped to the
> +	 * internal registers of the SoC.  This feature is deprecated, has
> +	 * security considerations, and is not implemented in our modern
> +	 * SoCs.
> +	 */
> +	if (pcie->type != BCM7712)
> +		set_bar(b++, &n, 0, 0, 0);
>  
>  	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
>  		u64 pcie_beg = entry->res->start - entry->offset;
> +		u64 cpu_beg = entry->res->start;
>  
> -		size += entry->res->end - entry->res->start + 1;
> +		size = resource_size(entry->res);
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
> @@ -813,13 +861,20 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
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
> @@ -828,10 +883,15 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
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
> @@ -866,25 +926,89 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
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
> +static void set_inbound_win_registers(struct brcm_pcie *pcie, const struct rc_bar *rc_bars,
> +				      int num_rc_bars)
> +{
> +	void __iomem *base = pcie->base;
> +	int i;
> +
> +	for (i = 1; i <= num_rc_bars; i++) {
> +		u64 pci_offset = rc_bars[i].pci_offset;
> +		u64 cpu_addr = rc_bars[i].cpu_addr;
> +		u64 size = rc_bars[i].size;
> +		u32 reg_offset = brcm_bar_reg_offset(i);
> +		u32 tmp = lower_32_bits(pci_offset);
> +
> +		u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(size),
> +				  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK);
> +
> +		/* Write low */
> +		writel(tmp, base + reg_offset);
> +		/* Write high */
> +		writel(upper_32_bits(pci_offset), base + reg_offset + 4);
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
> +			writel(tmp, base + reg_offset);
> +			tmp = upper_32_bits(cpu_addr);
> +			writel(tmp, base + reg_offset + 4);
> +		}
> +	}
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
> +	int memc;
>  
>  	/* Reset the bridge */
>  	pcie->bridge_sw_init_set(pcie, 1);
> @@ -933,17 +1057,16 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
>  	writel(tmp, base + PCIE_MISC_MISC_CTRL);
>  
> -	ret = brcm_pcie_get_rc_bar2_size_and_offset(pcie, &rc_bar2_size,
> -						    &rc_bar2_offset);
> -	if (ret)
> -		return ret;
> +	num_rc_bars = brcm_pcie_get_inbound_wins(pcie, rc_bars);
> +	if (num_rc_bars < 0)
> +		return num_rc_bars;
>  
> -	tmp = lower_32_bits(rc_bar2_offset);
> -	u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(rc_bar2_size),
> -			  PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK);
> -	writel(tmp, base + PCIE_MISC_RC_BAR2_CONFIG_LO);
> -	writel(upper_32_bits(rc_bar2_offset),
> -	       base + PCIE_MISC_RC_BAR2_CONFIG_HI);
> +	set_inbound_win_registers(pcie, rc_bars, num_rc_bars);
> +
> +	if (!brcm_pcie_rc_mode(pcie)) {
> +		dev_err(pcie->dev, "PCIe RC controller misconfigured as Endpoint\n");
> +		return -EINVAL;
> +	}
>  
>  	tmp = readl(base + PCIE_MISC_MISC_CTRL);
>  	for (memc = 0; memc < pcie->num_memc; memc++) {
> @@ -965,25 +1088,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
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
> @@ -1516,6 +1626,7 @@ static const struct pcie_cfg_data generic_cfg = {
>  	.type		= GENERIC,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.num_inbound	= 3,
>  };
>  
>  static const struct pcie_cfg_data bcm7425_cfg = {
> @@ -1523,6 +1634,7 @@ static const struct pcie_cfg_data bcm7425_cfg = {
>  	.type		= BCM7425,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.num_inbound	= 3,
>  };
>  
>  static const struct pcie_cfg_data bcm7435_cfg = {
> @@ -1530,6 +1642,7 @@ static const struct pcie_cfg_data bcm7435_cfg = {
>  	.type		= BCM7435,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.num_inbound	= 3,
>  };
>  
>  static const struct pcie_cfg_data bcm4908_cfg = {
> @@ -1537,6 +1650,7 @@ static const struct pcie_cfg_data bcm4908_cfg = {
>  	.type		= BCM4908,
>  	.perst_set	= brcm_pcie_perst_set_4908,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.num_inbound	= 3,
>  };
>  
>  static const int pcie_offset_bcm7278[] = {
> @@ -1552,6 +1666,7 @@ static const struct pcie_cfg_data bcm7278_cfg = {
>  	.type		= BCM7278,
>  	.perst_set	= brcm_pcie_perst_set_7278,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
> +	.num_inbound	= 3,
>  };
>  
>  static const struct pcie_cfg_data bcm2711_cfg = {
> @@ -1559,6 +1674,7 @@ static const struct pcie_cfg_data bcm2711_cfg = {
>  	.type		= BCM2711,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.num_inbound	= 3,
>  };
>  
>  static const struct pcie_cfg_data bcm7216_cfg = {
> @@ -1567,6 +1683,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
>  	.perst_set	= brcm_pcie_perst_set_7278,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
>  	.has_phy	= true,
> +	.num_inbound	= 3,
>  };
>  
>  static const struct of_device_id brcm_pcie_match[] = {
> @@ -1623,6 +1740,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	pcie->perst_set = data->perst_set;
>  	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
>  	pcie->has_phy = data->has_phy;
> +	pcie->num_inbound = data->num_inbound;
>  
>  	pcie->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pcie->base))
> -- 
> 2.17.1
> 



-- 
மணிவண்ணன் சதாசிவம்

