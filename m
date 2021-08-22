Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A97E3F3ECD
	for <lists+linux-pci@lfdr.de>; Sun, 22 Aug 2021 11:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhHVJHv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 05:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhHVJHt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 05:07:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF71C061575
        for <linux-pci@vger.kernel.org>; Sun, 22 Aug 2021 02:07:08 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u1so8605908wmm.0
        for <linux-pci@vger.kernel.org>; Sun, 22 Aug 2021 02:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pNxHGSp8vSHUeVN8S6Qm+9JGlYmCur4UZHN/VofsBho=;
        b=h/AxNzrj22p9dHw+rMnkoz9ieXloQDoFbd2T8FND2zNsXAt9Jn5EJnTOo/R9FKM29Y
         G471tagnzjXMGqZESXjF3Js6rG7oNnGLn4d3jmn7eDGtEkfCAzCieAJT9vl8ShsI5Q2w
         BW+supSIG1XvsVTzZQq6KK3PVWdCnuLhnhrB/WqTMejjFJfHyDFAMa7HDTz4o6QsYwq+
         IZVifBM70QVnKEmQAYhi6IEUvavi5Mbfo69aHT0y4ANZWvbg+aQybyJ9WHOcvf5db8mj
         Xx/wioGGQVhGxC1BdzG3SA5HWhsAHonUyJ1bm25d+uavyi+mqnmeYSNt4nhRw4gwIFvK
         RTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pNxHGSp8vSHUeVN8S6Qm+9JGlYmCur4UZHN/VofsBho=;
        b=A45k6/3NNqH4pwzyMDtKJhNYsPNBSJ4RHodiAwYlrAMcF0R3hbWFtdalVTHLuKwhrf
         ev4jw6nr459D9ohcF9+Sc/0SAXjiN1cOBMqjOpJ33eHUwnQBjLLz/IsQ4pJVkxh9q87G
         Yc4GwYDY5W+qbZcyY8Y7oeV9A/AYdAqkxoPVIigNniEZ7qrlXDIrgPb8PVWiSAQ+m9eg
         Q9tGepFmI9NDlKDeoYZXqs61PaGHzysRtnVeg11C3InUOE1CQoNgCnIKBVhNU9hWDhqF
         uCNmzn8b9/+UeCIfs27vJfAt9+K6shkA00tZjM3Y7fFvqsKs3HYcxDIsRq7OvMAIi2gi
         OFiw==
X-Gm-Message-State: AOAM531SndzAJdz66w1bZlnljGwfRjTYCtBUPBRR+Q6UZEj6iszE75Cf
        jn0DNxZR40SUO6GRx4kiEr0=
X-Google-Smtp-Source: ABdhPJxlEgSJpJ/DRDArN+OmpVHsze5EpQJ2vGYBVQw240IAgr/d6TlBEjpkjZGcuARFFfb6QPtW9Q==
X-Received: by 2002:a7b:ca4d:: with SMTP id m13mr11474636wml.121.1629623226101;
        Sun, 22 Aug 2021 02:07:06 -0700 (PDT)
Received: from [192.168.1.22] (amarseille-551-1-7-65.w92-145.abo.wanadoo.fr. [92.145.152.65])
        by smtp.gmail.com with ESMTPSA id f66sm4224346wma.34.2021.08.22.02.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 02:07:05 -0700 (PDT)
Subject: Re: [PATCH] PCI: brcmstb: implement BCM4908 support
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20210816125029.16879-1-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <afe78c58-c89e-e0c0-2f84-06e36dd44864@gmail.com>
Date:   Sun, 22 Aug 2021 11:07:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210816125029.16879-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+JimQ,

On 8/16/2021 2:50 PM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> BCM4908 is Broadcom's 64-bit platform with Broadcom's own Brahma-B53
> CPU(s). It uses the same PCIe hardware block as STB (Set-Top-Box) family
> but in a slightly different revision & setup.
> 
> Registers in BCM4908 variant are mostly the same but controller setup
> differs a bit. It requires setting few extra registers and takes
> slightly different bars setup.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   drivers/pci/controller/pcie-brcmstb.c | 137 +++++++++++++++++++++++---
>   1 file changed, 123 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index cc30215f5a43..24bc7efcfdd5 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -51,15 +51,20 @@
>   #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
>   
>   #define PCIE_MISC_MISC_CTRL				0x4008
> +#define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE		0x00000080
> +#define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE		0x00000400
> +#define  PCIE_MISC_MISC_CTRL_PCIE_IN_WR_COMBINE		0x00000800
>   #define  PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK		0x1000
>   #define  PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK	0x2000
>   #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK	0x300000
> +#define  PCIE_MISC_MISC_CTRL_BURST_ALIGN_MASK		0x00080000
>   
>   #define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK		0xf8000000
>   #define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK		0x07c00000
>   #define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK		0x0000001f
>   #define  SCB_SIZE_MASK(x) PCIE_MISC_MISC_CTRL_SCB ## x ## _SIZE_MASK
>   
> +
>   #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
>   #define PCIE_MEM_WIN0_LO(win)	\
>   		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 8)
> @@ -115,6 +120,9 @@
>   #define PCIE_MEM_WIN0_LIMIT_HI(win)	\
>   		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
>   
> +#define PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_OFFSET		0x40ac
> +#define  PCIE_MISC_UBUS_BAR_CONFIG_ACCESS_EN		0x00000001
> +
>   #define PCIE_MISC_HARD_PCIE_HARD_DEBUG					0x4204
>   #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
>   #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
> @@ -131,6 +139,13 @@
>   #define PCIE_EXT_CFG_DATA				0x8000
>   #define PCIE_EXT_CFG_INDEX				0x9000
>   
> +#define PCIE_CPU_INTR1_INTR_MASK_CLEAR_OFFSET		0x940c
> +#define  PCIE_CPU_INTR1_PCIE_INTA_CPU_INTR		0x00000002
> +#define  PCIE_CPU_INTR1_PCIE_INTB_CPU_INTR		0x00000004
> +#define  PCIE_CPU_INTR1_PCIE_INTC_CPU_INTR		0x00000008
> +#define  PCIE_CPU_INTR1_PCIE_INTD_CPU_INTR		0x00000010
> +#define  PCIE_CPU_INTR1_PCIE_INTR_CPU_INTR		0x00000020
> +
>   #define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
>   #define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
>   
> @@ -746,13 +761,19 @@ static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32
>   
>   static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
>   {
> -	if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controller\n"))
> -		return;
> +	if (pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
> +		brcm_pcie_perst_set_7278(pcie, val);
> +	} else {
> +		if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controller\n"))
> +			return;
>   
> -	if (val)
> -		reset_control_assert(pcie->perst_reset);
> -	else
> -		reset_control_deassert(pcie->perst_reset);
> +		if (val)
> +			reset_control_assert(pcie->perst_reset);
> +		else
> +			reset_control_deassert(pcie->perst_reset);
> +	}
> +
> +	usleep_range(10000, 20000);

This delay would warrant a comment.

>   }
>   
>   static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
> @@ -861,6 +882,86 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
>   	return 0;
>   }
>   
> +static int brcm_pcie_setup_bcm4908(struct brcm_pcie *pcie)
> +{
> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> +	void __iomem *base = pcie->base;
> +	struct device *dev = pcie->dev;
> +	struct resource_entry *entry;
> +	u32 burst_align;
> +	u32 burst;
> +	u32 tmp;
> +	int win;
> +
> +	pcie->perst_set(pcie, 0);
> +
> +	msleep(500);
> +
> +	if (!brcm_pcie_link_up(pcie)) {
> +		dev_err(dev, "link down\n");
> +		return -ENODEV;
> +	}
> +
> +	/* setup lgacy outband interrupts */

s/lgacy/legacy/

> +	tmp = PCIE_CPU_INTR1_PCIE_INTA_CPU_INTR |
> +	      PCIE_CPU_INTR1_PCIE_INTB_CPU_INTR |
> +	      PCIE_CPU_INTR1_PCIE_INTC_CPU_INTR |
> +	      PCIE_CPU_INTR1_PCIE_INTD_CPU_INTR;
> +	writel(tmp, base + PCIE_CPU_INTR1_INTR_MASK_CLEAR_OFFSET);
> +
> +	win = 0;
> +	resource_list_for_each_entry(entry, &bridge->windows) {
> +		struct resource *res = entry->res;
> +		u64 pcie_addr;
> +
> +		if (resource_type(res) != IORESOURCE_MEM)
> +			continue;
> +
> +		if (win >= BRCM_NUM_PCIE_OUT_WINS) {
> +			dev_err(pcie->dev, "too many outbound wins\n");
> +			return -EINVAL;
> +		}
> +
> +		tmp = 0;
> +		u32p_replace_bits(&tmp, res->start / SZ_1M,
> +				  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_BASE_MASK);
> +		u32p_replace_bits(&tmp, res->end / SZ_1M,
> +				  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_MASK);
> +		writel(tmp, base + PCIE_MEM_WIN0_BASE_LIMIT(win));
> +
> +		pcie_addr = res->start - entry->offset;
> +		writel(lower_32_bits(pcie_addr), pcie->base + PCIE_MEM_WIN0_LO(win));
> +		writel(upper_32_bits(pcie_addr), pcie->base + PCIE_MEM_WIN0_HI(win));
> +
> +		win++;
> +	}
> +
> +	writel(0xf, base + PCIE_MISC_RC_BAR1_CONFIG_LO);
> +
> +	tmp = PCIE_MISC_UBUS_BAR_CONFIG_ACCESS_EN;
> +	writel(tmp, base + PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_OFFSET);
> +
> +	tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> +	u32p_replace_bits(&tmp, PCI_CLASS_BRIDGE_PCI << 8,
> +			  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
> +	writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> +
> +	/* Burst */
> +	burst = 0x1; /* 128 B */
> +	burst_align = 1;
> +
> +	tmp = readl(base + PCIE_MISC_MISC_CTRL);
> +	u32p_replace_bits(&tmp, burst_align, PCIE_MISC_MISC_CTRL_BURST_ALIGN_MASK);
> +	u32p_replace_bits(&tmp, burst, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
> +	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK);
> +	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_IN_WR_COMBINE);
> +	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE);
> +	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE);
> +	writel(tmp, base + PCIE_MISC_MISC_CTRL);

I see why you have made the 4908 bridge setup completely indepdent from 
the STB version of brcm_pcie_setup() however in the process there is a 
number of possibly equally relevant initialization that is not done and 
may assume firmware initialized or hardware default values (those would 
not survive suspend/resume states). Can you see about making minimal 
changes to brcm_pcie_setup() such that it supports the way 4908 should 
be initialized?

> +
> +	return 0;
> +}
> +
>   static int brcm_pcie_setup(struct brcm_pcie *pcie)
>   {
>   	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> @@ -1284,6 +1385,13 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>   		return PTR_ERR(pcie->perst_reset);
>   	}
>   
> +	if (pcie->type == BCM4908) {
> +		/* On BCM4908 we can read rev early and perst_set needs it */
> +		pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
> +
> +		pcie->perst_set(pcie, 1);
> +	}
> +
>   	ret = reset_control_reset(pcie->rescal);
>   	if (ret)
>   		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> @@ -1295,16 +1403,17 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	ret = brcm_pcie_setup(pcie);
> -	if (ret)
> -		goto fail;
> +	if (pcie->type == BCM4908) {
> +		ret = brcm_pcie_setup_bcm4908(pcie);
> +		if (ret)
> +			goto fail;
> +	} else {
> +		ret = brcm_pcie_setup(pcie);
> +		if (ret)
> +			goto fail;
> +	}
>   
>   	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
> -	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
> -		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
> -		ret = -ENODEV;
> -		goto fail;
> -	}
>   
>   	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
>   	if (pci_msi_enabled() && msi_np == pcie->np) {
> 

-- 
Florian
