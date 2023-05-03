Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6B76F4FF5
	for <lists+linux-pci@lfdr.de>; Wed,  3 May 2023 08:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjECGKM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 May 2023 02:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjECGKL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 May 2023 02:10:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1532E1FE3;
        Tue,  2 May 2023 23:10:09 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N32y5-1qNGme09eP-013JEW; Wed, 03 May 2023 08:09:33 +0200
Message-ID: <161fe87c-3c74-8a68-f804-6e830e9648e5@i2se.com>
Date:   Wed, 3 May 2023 08:09:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/5] PCI: brcmstb: Configure HW CLKREQ# mode
 appropriate for downstream device
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230428223500.23337-1-jim2101024@gmail.com>
 <20230428223500.23337-3-jim2101024@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230428223500.23337-3-jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZYXqyF1DohyMJ9ZTC7VjqH0pbWG4rc9pvBUaisDKuR49DZAj3o4
 9OoxIjZHRwJxXa5v4ffn2xG1yrnb4bRSWbaKQEooOLk7Snc5ZkoX0K0Uwwk+zYn3RCyKic6
 zovzsu9CcMQR/z0QK/ty6Ed250qSpQacUNvYmwBGdqy+5Jl6YiGz/65V02xzidl7rn+AhBi
 oYNNCVmyPkOGOsmYvU+tA==
UI-OutboundReport: notjunk:1;M01:P0:VFwgE1Hkfac=;apJRj/3FpMheRqlTxE6/symofAV
 rRmERPRgs0x09v83qnita8QFbilLyCCVxwgrT3IeHTcayHIlG2ZNgUFu5+QvXu91L8FFOETf8
 knpjO9vfy2dAbWtAKfKPkC4UCz1sKp8b3mgl9+Cn190qctqts21jqhr8NPMPeHFefradge42f
 6fYEP1MYKR1qRw3KWtZUiMwecCOBNQ0ArXUERAa+j/jI0qzyXElVd+ulLAR3BLdS8gXSNgItD
 O32WgetM7Y/NKAX+fptgmRML6GzvbORbLqI/1qCGKL/wLk7R5VZxWV/xZJgNbbks0nX5J3EbL
 ogzsmk0etuTpXIPUnZyTRh4e7clVFLAFyPtdKWTbC3qQE+hn90INeOpuZJWCBshMCX5EVwV9U
 PTWFXu/9dlI4Y1AgHolJQ33HqBXdkQKebUN3U8cOuv54ir6+rYXazoYE7WEaoHkxDY8pQwKAZ
 R8pwewT2oGYvN/P0/gcv2/SkvEJW9efXvH2eZvb0JJS26RMTGw9bYROBt5/Kt5TAvbjVPgjja
 3CiF8m+bM4uJdkNsffuMdn36CD3J3G7fc1TbnVvkc9RJe8BpeqV6pzEJSA+64dPwgqxoJwYCT
 zmlwXjQKJ6ZPhw021BEKZKuPJp+xDhoYb0+UINYNPer4kjEW2qZ1+mwjq+o7Lgh+6t80ybxkM
 f5IBHKvTjWWtHRkfXGsRWNRg8WqcrqAVq4sA0Jgxaw==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Am 29.04.23 um 00:34 schrieb Jim Quinlan:
> The Broadcom STB/CM PCIe HW core, which is also used in RPi SOCs, must be
> deliberately set by the RC probe() into one of three mutually exclusive
> modes:
> 
>    (a) No CLKREQ# expected or required, refclk is always available.
>    (b) CLKREQ# is expected to be driven by downstream device when needed.
>    (c) Bidirectional CLKREQ# for L1SS capable devices.
> 
> Previously, only (b) was supported by the driver, as almost all STB/CM
> boards operate in this mode.  But now there is interest in activating L1SS
> power savings from STB/CM customers, and also interest in accommodating
> mode (a) for designs such as the RPi CM4 with IO board.
> 
> The HW+driver is able to tell us when mode (a) or (b) is needed.  All
> devices should be functional using the RC-driver selected (a) or (b) mode.
> For those with L1SS-capable devices that desire the power savings that come
> with mode (c) we rely on the DT prop "brcm,enable-l1ss".  It would be nice
> to do this automatically but there is no easy way to determine this at the
> time the PCI RC driver executes its probe().  Using this mode only makes
> sense when the downstream device is L1SS-capable and the OS has been
> configured to activate L1SS (e.g. policy==powersupersave).
> 
> The "brcm,enable-l1ss" property has already been in use by Raspian Linux,
> but this implementation adds more details and discerns between (a) and (b)
> automatically.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217276
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>   drivers/pci/controller/pcie-brcmstb.c | 69 +++++++++++++++++++++++----
>   1 file changed, 59 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index edf283e2b5dd..c4b076ea5180 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -48,10 +48,17 @@
>   #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
>   #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
>   
> +#define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
> +#define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK	0xf8
> +
>   #define PCIE_RC_DL_MDIO_ADDR				0x1100
>   #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
>   #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
>   
> +#define PCIE_0_RC_PL_PHY_DBG_CLKREQ2_0			0x1e30
> +#define  CLKREQ2_0_CLKREQ_IN_CNT_MASK			0x3f000000
> +#define  CLKREQ2_0_CLKREQ_IN_MASK			0x40000000
> +
>   #define PCIE_MISC_MISC_CTRL				0x4008
>   #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK	0x80
>   #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK	0x400
> @@ -121,9 +128,12 @@
>   
>   #define PCIE_MISC_HARD_PCIE_HARD_DEBUG					0x4204
>   #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
> +#define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK		0x200000
>   #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
>   #define  PCIE_BMIPS_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x00800000
> -
> +#define  PCIE_CLKREQ_MASK \
> +	  (PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK | \
> +	   PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK)
>   
>   #define PCIE_INTR2_CPU_BASE		0x4300
>   #define PCIE_MSI_INTR2_BASE		0x4500
> @@ -1024,13 +1034,58 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>   	return 0;
>   }
>   
> +static void brcm_config_clkreq(struct brcm_pcie *pcie)
> +{
> +	bool l1ss = of_property_read_bool(pcie->np, "brcm,enable-l1ss");
> +	void __iomem *base = pcie->base;
> +	u32 clkreq_set, tmp = readl(base + PCIE_0_RC_PL_PHY_DBG_CLKREQ2_0);
> +	bool clkreq_in_seen;
> +
> +	/*
> +	 * We have "seen" CLKREQ# if it is asserted or has been in the past.
> +	 * Note that the CLKREQ_IN_MASK is 1 if CLKREQ# is asserted.
> +	 */
> +	clkreq_in_seen = !!(tmp & CLKREQ2_0_CLKREQ_IN_MASK) ||
> +		!!FIELD_GET(CLKREQ2_0_CLKREQ_IN_CNT_MASK, tmp);
> +
> +	/* Start with safest setting where we provide refclk regardless */
> +	clkreq_set = readl(pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG) &
> +		~PCIE_CLKREQ_MASK;
> +
> +	if (l1ss && IS_ENABLED(CONFIG_PCIEASPM)) {
> +		/*
> +		 * Note: For boards using a mini-card connector, this mode
> +		 * may not meet the TCRLon maximum time of 400ns, as
> +		 * specified in 3.2.5.2.5 of the PCI Express Mini CEM 2.0
> +		 * specification.
> +		 */
> +		clkreq_set |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK;
> +		dev_info(pcie->dev, "bi-dir CLKREQ# for L1SS power savings");

Please append the missing newline to the log message

> +	} else {
> +		if (clkreq_in_seen && IS_ENABLED(CONFIG_PCIEASPM)) {
> +			clkreq_set |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK;
> +			dev_info(pcie->dev, "uni-dir CLKREQ# for L0s, L1 ASPM\n");
> +		} else {
> +			dev_info(pcie->dev, "CLKREQ# ignored; no ASPM\n");
> +			/* Might as well unadvertise ASPM */
> +			tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY) &
> +				~PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK;
> +			writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> +		}
> +		/* Setting the field to 2 unadvertises L1SS support */
> +		tmp = readl(base + PCIE_RC_CFG_PRIV1_ROOT_CAP);
> +		u32p_replace_bits(&tmp, 2, PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK);
> +		writel(tmp, base + PCIE_RC_CFG_PRIV1_ROOT_CAP);
> +	}
> +	writel(clkreq_set, pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +}
> +
>   static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>   {
>   	struct device *dev = pcie->dev;
>   	void __iomem *base = pcie->base;
>   	u16 nlw, cls, lnksta;
>   	bool ssc_good = false;
> -	u32 tmp;
>   	int ret, i;
>   
>   	/* Unassert the fundamental reset */
> @@ -1055,6 +1110,8 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>   		return -ENODEV;
>   	}
>   
> +	brcm_config_clkreq(pcie);
> +
>   	if (pcie->gen)
>   		brcm_pcie_set_gen(pcie, pcie->gen);
>   
> @@ -1073,14 +1130,6 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>   		 pci_speed_string(pcie_link_speed[cls]), nlw,
>   		 ssc_good ? "(SSC)" : "(!SSC)");
>   
> -	/*
> -	 * Refclk from RC should be gated with CLKREQ# input when ASPM L0s,L1
> -	 * is enabled => setting the CLKREQ_DEBUG_ENABLE field to 1.
> -	 */
> -	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> -	tmp |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK;
> -	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> -
>   	return 0;
>   }
>   
