Return-Path: <linux-pci+bounces-11434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479FB94A952
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 16:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03EC288FC5
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 14:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FB926AC3;
	Wed,  7 Aug 2024 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDnIpEkq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB82F3E
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039462; cv=none; b=t3rJ+D7KZ+wVMqVWmY9RITYyCLUd26a52lWB4N7znxIl183O/nEzdRtKh3sj0ApYZnMWWcTKStaa9ajdDTlIgRXmnyIVcvD4Ag0a1eK1uIOKW7zmzNYWiBszuFJeyGz3v3E7rVxV2kqYtv2sVjVw6+/W7Y2t08Lfukiiawx9T/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039462; c=relaxed/simple;
	bh=Oqk8W19JQLH4RO4d5JGfPj00g2qyw+4MbBGPwBzSI24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfSnFj16Z8SQO0JLvJbdTKuTJcFPuafBSwLYZhmmZ0Dqnk08lV3uwbix0pln8a1q4ghTMZocFzcZx/SBvBMEeZ88a8eLiLKDLkIDU+24StlyaGlhseCV/ZEKCtHcAUkEw0CsIr4rN8RFxesl3B82NKQtFYh1AoO0mHSHcai24hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qDnIpEkq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7105043330aso1657972b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Aug 2024 07:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723039460; x=1723644260; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S4jdBKTpkGJfqspl209rtfslRr/0REL1PGCVruLPf3A=;
        b=qDnIpEkqdvJYJuk5IBWteE3haOu5jr8E1ARejxODpEEHY9GL32VcenW/hlAx/5lJpy
         +eHydnbEHlwOr0SmBnMiBFlEWWSIlQeqLBkQRx2sG1qBUwHA6Q8ZeQ5Fy2D38vEdOx8X
         yrcSR11qNpVH6V+XRSBHkqIe4hbSAdYIgZ9EaN+yd4xsB4di5WQnWqHZDhNOCPzUR30c
         dyzF6cwo2BtqW3H8A3TSHRZ8IDOx10kN7ZbS3qngfFXL/r+MWuNABxY3WNlnPPyGyQTw
         gJor9IeBHG690ZHsVpMdNj5L/gACBl5WrbqVBwuzdRvETZu1OmrAzZ9sVHF51UUEd5CF
         2OsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723039460; x=1723644260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4jdBKTpkGJfqspl209rtfslRr/0REL1PGCVruLPf3A=;
        b=RACiNQgIk53t/OF6A5GF2+vXvK8LalTQ5Y2NzPLc75x6BDFLL4/Xigj9ljEQVv/3lj
         ShuWFlr4dGGyUx4zl57fTFFYsLtpR6GNMhvL2IxcWmrgEChTazXsl3Lg+mypHZEGS2be
         JdV+T+7lZEFSo49gKONVX4e6YX/yaqNYJfokUNM/pa9+7ojh8kDlXwj6Q+4N2h8uuxEu
         hRDVZX/0S9bwKNfFSoFI59135DApyDkNwmoJWhj2vCtiMjdT3AmoS1bBSF+ZO+BhAjfU
         2ldDg+DhxX++Q5XSmScMDiPkemCrbPhKLI6reSfSY+87Q34/wTtjNGojroFF6hKrKQ29
         8zbg==
X-Gm-Message-State: AOJu0YxgGYLz5bxAP1A4r0wC9pHBIL+lyyoQeSvSkbYCXfoZ8whXL7rm
	Og1K3/okw/1iyqbdlZplJPdbxfaoOe9D93kMFlIT7iz0zBMtvEqQhghb9MWvyQ==
X-Google-Smtp-Source: AGHT+IEfwCrKxsc3cHSMIAQKhdIc5MLETyvAQqowAavJWS2lY9QKae7V+EsgYnJuZ0xAlo6Yhy54gw==
X-Received: by 2002:a05:6a00:21cc:b0:70a:efd7:ada1 with SMTP id d2e1a72fcca58-7106cfe02abmr20049148b3a.17.1723039459919;
        Wed, 07 Aug 2024 07:04:19 -0700 (PDT)
Received: from thinkpad ([120.60.60.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed3389bsm8408159b3a.213.2024.08.07.07.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:04:19 -0700 (PDT)
Date: Wed, 7 Aug 2024 19:34:01 +0530
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
Subject: Re: [PATCH v5 09/12] PCI: brcmstb: Refactor for chips with many
 regular inbound windows
Message-ID: <20240807140401.GJ3412@thinkpad>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-10-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731222831.14895-10-james.quinlan@broadcom.com>

On Wed, Jul 31, 2024 at 06:28:23PM -0400, Jim Quinlan wrote:
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
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 228 ++++++++++++++++++++------
>  1 file changed, 177 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 4659208ae8da..0ecca3d9576f 100644
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
> +	unsigned int num_inbound_wins;
>  	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
>  	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>  };
> @@ -274,6 +290,7 @@ struct brcm_pcie {
>  	struct subdev_regulators *sr;
>  	bool			ep_wakeup_capable;
>  	bool			has_phy;
> +	int			num_inbound_wins;
>  };
>  
>  static inline bool is_bmips(const struct brcm_pcie *pcie)
> @@ -789,23 +806,61 @@ static void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
>  	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>  }
>  
> -static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
> -							u64 *rc_bar2_size,
> -							u64 *rc_bar2_offset)
> +static inline void set_bar(struct inbound_win *b, int *count, u64 size,
> +			   u64 cpu_addr, u64 pci_offset)

There is no need to pass 'inline' keyword in a .c file. Making a function inline
is upto the discretion of the compiler.

Also, set_bar() is quite misleading as you are not setting any BAR but just
populating the inbound_win struct. So how about, "add_inbound_window()"?

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
> -	int ret, i = 0;
> -	u64 size = 0;
> +	int ret, i = 0, n = 0;
> +
> +	/*
> +	 * The HW registers (and PCIe) use order-1 numbering for BARs. As
> +	 * such, we have inbound_wins[0] unused and BAR1 starts at inbound_wins[1].
> +	 */

Instead of wasting one array entry, you can start the array from 0 and just
decrement the index where needed? Like,

	reg_offset = brcm_bar_reg_offset(i - 1);

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
> +		set_bar(b++, &n, 0, 0, 0);
>  
>  	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
>  		u64 pcie_beg = entry->res->start - entry->offset;
> +		u64 cpu_beg = entry->res->start;

What does 'beg' mean?

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
> +		if (n > pcie->num_inbound_wins)
> +			break;
>  	}
>  
>  	if (lowest_pcie_addr == ~(u64)0) {
> @@ -813,13 +868,20 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
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
> @@ -828,10 +890,15 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
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
> @@ -866,25 +933,90 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
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
> +	set_bar(b++, &n, size, cpu_addr, pci_offset);
> +
> +	/*
> +	 * Disable inbound window 3.  On some chips presents the same
> +	 * window as #2 but the data appears in a settable endianness.
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
> +static void set_inbound_win_registers(struct brcm_pcie *pcie,
> +				      const struct inbound_win *inbound_wins,
> +				      int num_inbound_wins)
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
> +		writel(tmp, base + reg_offset);

Can you use writel_relaxed() instead? Here and below. I don't see a necessity to
use the barrier that comes with non-relaxed version of writel.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

