Return-Path: <linux-pci+bounces-10754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B4793BBD0
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 06:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603C41C2386F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 04:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B8BDF6C;
	Thu, 25 Jul 2024 04:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xp55q17U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623818633
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 04:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721882590; cv=none; b=FP96h1Yylz6vILAPywfoeveOTCGUwlVtD+i3mW/KroxJ/jm0Y9+4xLBs1lOwzwrts08OjQ4c35jbc9AhRkksaSrk+TBmHriypEB0a2J14We6h7LlcPpuP4DQ5dxt4vF5GJZvTTRCYH+pRcnKNBYC1p2dukOVfY1qUs9N5MtHckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721882590; c=relaxed/simple;
	bh=Cj1OdR8WHmYxJYIiurb013Ums4H2UVNMXpGZF5qHPwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2A9ezW4mV2xMZRfqFM2+xJ/5WKi1LyZV/ZF0LfblsclOhNejZyXnG6SljpBzk5rGJWS/D7qmhMwfGLfEZ+cU8kAXUaXDMuBmDEjHBMxTIAEHgIRt5AQU9GqgmReq4uDkttWY+bFJEbsJtp63ueCRMJ3D+Ntega8gQPjordVn+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xp55q17U; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so454036b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 21:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721882588; x=1722487388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kforIxrR32hXGERHtjq0u+nCqy7s7oB2GTNLcgTbBB0=;
        b=Xp55q17Um8XJD7AaKJcCEcRZQHIH2dXjhDf5kpDepXolIUme281LKQ7INimi/SO8hj
         5XbuoZN5wkJZFv2dHzSXK1hKgpL1/aY+HfoTyIRw8RgdXlM4HMtRj4E9590gvMF0GZR4
         q+TcPUwpqAzIEQvXBO7ONp1gxYnZQc2cXiRsEk1h1435XPc+YcM7oMpGGpgabJW6lCSU
         SkyZP3ItyZ55EdkxosbWWgOlrwiGzDvmAtrAAxwLOxM5KI+yQ02exHBZ4nCx/01JilSd
         BDiIqHSsNAmnV/rD+k84j9+EaSA4sezu4KZq+K1YcwY4tasO1CYv1vEfEG27BU9badNu
         spbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721882588; x=1722487388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kforIxrR32hXGERHtjq0u+nCqy7s7oB2GTNLcgTbBB0=;
        b=jWj8bWjjNapaqKgdXfUv4mP+InJzkNZ9s5jGhtvMpdib64lpVER69jgLZK02sEEW89
         SYXQq+XSf9SWR25E+W/0gPrxbqf1oZTB03h99J0yG2WoRPsMhQEOo5nwEIQN1XX4eHSg
         mZYwMi+EMzDHtGfEkRDjRUkEYlcirUwHjqxSqimTqBPkzIh+lkFVZJt/BP/+VBRetesh
         868O2zJbkW8plG3/hewW847yROAWvCB4JHw/zpLTA4+C88WVhxLl8eVwrAfzg8fM5eUK
         Epcz+HynMgb4pnpt/BNLYQFKdao49kiiclEhTXI4I378vjYcwCnz0LfxoyiM12HKl4Zh
         r9LQ==
X-Gm-Message-State: AOJu0YyD+y7APU0cU4/lpbiDkTL0NF7Yk254zbLrqJ5uV7sqk6vdvBKW
	y5kUx4rJnfn9UvLUh1L/44lwab0lh5SIanPGGqUNEQ/BQaF1pu5tS91RnvSj/Q==
X-Google-Smtp-Source: AGHT+IHejSYglU67gOhhrkzZa6hhL8uC7FSKZRpllYkdugTHOn/pFSyK/PB4UJ0WAa6BXbBcEvzKig==
X-Received: by 2002:a05:6a21:2d08:b0:1c2:8dcf:1b8f with SMTP id adf61e73a8af0-1c47b16661emr867852637.7.1721882588416;
        Wed, 24 Jul 2024 21:43:08 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead71592bsm358996b3a.86.2024.07.24.21.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:43:08 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:13:02 +0530
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
Subject: Re: [PATCH v4 06/12] PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG,
 INTR2_CPU_BASE offsets SoC-specific
Message-ID: <20240725044302.GG2317@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-7-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716213131.6036-7-james.quinlan@broadcom.com>

On Tue, Jul 16, 2024 at 05:31:21PM -0400, Jim Quinlan wrote:
> Our HW design has again changed a register offset which used to be standard

Changed for which SoC? Please mention that this is a preparatory work.

> for all Broadcom SOCs with PCIe cores.  This difference is now reconciled
> for the registers HARD_DEBUG and INTR2_CPU_BASE.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

With that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 39 ++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 4dc2ff7f3167..073d790d97b7 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -122,7 +122,6 @@
>  #define PCIE_MEM_WIN0_LIMIT_HI(win)	\
>  		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
>  
> -#define PCIE_MISC_HARD_PCIE_HARD_DEBUG					0x4204
>  #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
>  #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK		0x200000
>  #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
> @@ -131,9 +130,9 @@
>  	  (PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK | \
>  	   PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK)
>  
> -#define PCIE_INTR2_CPU_BASE		0x4300
>  #define PCIE_MSI_INTR2_BASE		0x4500
> -/* Offsets from PCIE_INTR2_CPU_BASE and PCIE_MSI_INTR2_BASE */
> +
> +/* Offsets from INTR2_CPU and MSI_INTR2 BASE offsets */
>  #define  MSI_INT_STATUS			0x0
>  #define  MSI_INT_CLR			0x8
>  #define  MSI_INT_MASK_SET		0x10
> @@ -184,9 +183,11 @@
>  #define SSC_STATUS_PLL_LOCK_MASK	0x800
>  #define PCIE_BRCM_MAX_MEMC		3
>  
> -#define IDX_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_INDEX])
> -#define DATA_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_DATA])
> -#define PCIE_RGR1_SW_INIT_1(pcie)	(pcie->reg_offsets[RGR1_SW_INIT_1])
> +#define IDX_ADDR(pcie)			((pcie)->reg_offsets[EXT_CFG_INDEX])
> +#define DATA_ADDR(pcie)			((pcie)->reg_offsets[EXT_CFG_DATA])
> +#define PCIE_RGR1_SW_INIT_1(pcie)	((pcie)->reg_offsets[RGR1_SW_INIT_1])
> +#define HARD_DEBUG(pcie)		((pcie)->reg_offsets[PCIE_HARD_DEBUG])
> +#define INTR2_CPU_BASE(pcie)		((pcie)->reg_offsets[PCIE_INTR2_CPU_BASE])
>  
>  /* Rescal registers */
>  #define PCIE_DVT_PMU_PCIE_PHY_CTRL				0xc700
> @@ -205,6 +206,8 @@ enum {
>  	RGR1_SW_INIT_1,
>  	EXT_CFG_INDEX,
>  	EXT_CFG_DATA,
> +	PCIE_HARD_DEBUG,
> +	PCIE_INTR2_CPU_BASE,
>  };
>  
>  enum {
> @@ -651,7 +654,7 @@ static int brcm_pcie_enable_msi(struct brcm_pcie *pcie)
>  	BUILD_BUG_ON(BRCM_INT_PCI_MSI_LEGACY_NR > BRCM_INT_PCI_MSI_NR);
>  
>  	if (msi->legacy) {
> -		msi->intr_base = msi->base + PCIE_INTR2_CPU_BASE;
> +		msi->intr_base = msi->base + INTR2_CPU_BASE(pcie);
>  		msi->nr = BRCM_INT_PCI_MSI_LEGACY_NR;
>  		msi->legacy_shift = 24;
>  	} else {
> @@ -898,12 +901,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	/* Take the bridge out of reset */
>  	pcie->bridge_sw_init_set(pcie, 0);
>  
> -	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +	tmp = readl(base + HARD_DEBUG(pcie));
>  	if (is_bmips(pcie))
>  		tmp &= ~PCIE_BMIPS_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK;
>  	else
>  		tmp &= ~PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK;
> -	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +	writel(tmp, base + HARD_DEBUG(pcie));
>  	/* Wait for SerDes to be stable */
>  	usleep_range(100, 200);
>  
> @@ -1072,7 +1075,7 @@ static void brcm_config_clkreq(struct brcm_pcie *pcie)
>  	}
>  
>  	/* Start out assuming safe mode (both mode bits cleared) */
> -	clkreq_cntl = readl(pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +	clkreq_cntl = readl(pcie->base + HARD_DEBUG(pcie));
>  	clkreq_cntl &= ~PCIE_CLKREQ_MASK;
>  
>  	if (strcmp(mode, "no-l1ss") == 0) {
> @@ -1115,7 +1118,7 @@ static void brcm_config_clkreq(struct brcm_pcie *pcie)
>  			dev_err(pcie->dev, err_msg);
>  		mode = "safe";
>  	}
> -	writel(clkreq_cntl, pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +	writel(clkreq_cntl, pcie->base + HARD_DEBUG(pcie));
>  
>  	dev_info(pcie->dev, "clkreq-mode set to %s\n", mode);
>  }
> @@ -1337,9 +1340,9 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
>  	writel(tmp, base + PCIE_MISC_PCIE_CTRL);
>  
>  	/* Turn off SerDes */
> -	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +	tmp = readl(base + HARD_DEBUG(pcie));
>  	u32p_replace_bits(&tmp, 1, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
> -	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +	writel(tmp, base + HARD_DEBUG(pcie));
>  
>  	/* Shutdown PCIe bridge */
>  	pcie->bridge_sw_init_set(pcie, 1);
> @@ -1425,9 +1428,9 @@ static int brcm_pcie_resume_noirq(struct device *dev)
>  	pcie->bridge_sw_init_set(pcie, 0);
>  
>  	/* SERDES_IDDQ = 0 */
> -	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +	tmp = readl(base + HARD_DEBUG(pcie));
>  	u32p_replace_bits(&tmp, 0, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
> -	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +	writel(tmp, base + HARD_DEBUG(pcie));
>  
>  	/* wait for serdes to be stable */
>  	udelay(100);
> @@ -1499,12 +1502,16 @@ static const int pcie_offsets[] = {
>  	[RGR1_SW_INIT_1] = 0x9210,
>  	[EXT_CFG_INDEX]  = 0x9000,
>  	[EXT_CFG_DATA]   = 0x9004,
> +	[PCIE_HARD_DEBUG] = 0x4204,
> +	[PCIE_INTR2_CPU_BASE] = 0x4300,
>  };
>  
>  static const int pcie_offsets_bmips_7425[] = {
>  	[RGR1_SW_INIT_1] = 0x8010,
>  	[EXT_CFG_INDEX]  = 0x8300,
>  	[EXT_CFG_DATA]   = 0x8304,
> +	[PCIE_HARD_DEBUG] = 0x4204,
> +	[PCIE_INTR2_CPU_BASE] = 0x4300,
>  };
>  
>  static const struct pcie_cfg_data generic_cfg = {
> @@ -1539,6 +1546,8 @@ static const int pcie_offset_bcm7278[] = {
>  	[RGR1_SW_INIT_1] = 0xc010,
>  	[EXT_CFG_INDEX] = 0x9000,
>  	[EXT_CFG_DATA] = 0x9004,
> +	[PCIE_HARD_DEBUG] = 0x4204,
> +	[PCIE_INTR2_CPU_BASE] = 0x4300,
>  };
>  
>  static const struct pcie_cfg_data bcm7278_cfg = {
> -- 
> 2.17.1
> 



-- 
மணிவண்ணன் சதாசிவம்

