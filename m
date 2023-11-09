Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41957E7393
	for <lists+linux-pci@lfdr.de>; Thu,  9 Nov 2023 22:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjKIV1J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Nov 2023 16:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjKIV1I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2023 16:27:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D216C3C05;
        Thu,  9 Nov 2023 13:27:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222B7C433C8;
        Thu,  9 Nov 2023 21:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699565226;
        bh=SxUz65qY9/xElgVVNgMtWU+DtVOVEYVev7kCL/Cbzqg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K5L3NxKnF7MZzKaDphtFwkZ6CK86qX2Trf5KtbJ1leQsx62y3OmIHg16d83ZZq31S
         +dgf5S3Aw6VfN+1ndBq/S9jPYuu8kwNA2sNnctf4ML6bPKKSA2NhJ8X7UDXUZmGm8l
         pzMY8ONsANF5EpXrbRrBWVQPGxzHpBJ+HjUtaQTyb+VIEn2gfRIe6gHRjFv4XEhdZb
         N6UolrtA7X3rhLqbJJErm97tKfl6QMu4NIMnTNIUnmCz8+yxKGS0zyROcKApokJQTd
         OLn9lFGPui7q4Mb76PEd4ytOZPnrATC1rlytUJ8b+TTcSU33JbYpyCvEZ1C4fXmq7v
         L9NowoBgCotug==
Date:   Thu, 9 Nov 2023 15:27:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] PCI: brcmstb: Configure HW CLKREQ# mode
 appropriate for downstream device
Message-ID: <20231109212703.GA491818@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109191355.27738-3-james.quinlan@broadcom.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 09, 2023 at 02:13:53PM -0500, Jim Quinlan wrote:
> The Broadcom STB/CM PCIe HW core, which is also used in RPi SOCs, must be
> deliberately set by the PCIe RC HW into one of three mutually exclusive
> modes:
> 
> "safe" -- No CLKREQ# expected or required, refclk is always provided.  This
>     mode should work for all devices but is not be capable of any refclk
>     power savings.
> 
> "no-l1ss" -- CLKREQ# is expected to be driven by the downstream device for
>     CPM and ASPM L0s and L1.  Provides Clock Power Management, L0s, and L1,
>     but cannot provide L1 substate (L1SS) power savings. If the downstream
>     device connected to the RC is L1SS capable AND the OS enables L1SS, all
>     PCIe traffic may abruptly halt, potentially hanging the system.
> 
> "default" -- Bidirectional CLKREQ# between the RC and downstream device.
>     Provides ASPM L0s, L1, and L1SS, but not compliant to provide Clock
>     Power Management; specifically, may not be able to meet the Tclron max
>     timing of 400ns as specified in "Dynamic Clock Control", section
>     3.2.5.2.2 of the PCIe spec.  This situation is atypical and should
>     happen only with older devices.

The PCIe base spec r6.0 has no section 3.2.5.2.2.  Looks like this
could be:

  PCIe Mini CEM r2.1, sec 3.2.5.2.2 (December, 2016), or
  PCIe CEM r5.1, sec 2.8.2 (August, 2023)

I don't know the relationship between the "Mini CEM" and the "CEM"
specs, but CEM r5.1 seems to have the same text as the Mini CEM r2.1
about Dynamic Clock Control.

We're hampered by the lack of clear subscripts here, but the text in
both capitalizes the "CRL" part, e.g., "T_CLRon".

> Previously, this driver always set the mode to "no-l1ss", as almost all
> STB/CM boards operate in this mode.  But now there is interest in
> activating L1SS power savings from STB/CM customers, which requires "aspm"
> mode.  In addition, a bug was filed for RPi4 CM platform because most
> devices did not work in "no-l1ss" mode.
> 
> Note that the mode is specified by the DT property "brcm,clkreq-mode".  If
> this property is omitted, then "default" mode is chosen.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217276
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 65 ++++++++++++++++++++++-----
>  1 file changed, 55 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index f9dd6622fe10..f45c5d0168d3 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -121,9 +121,12 @@
>  
>  #define PCIE_MISC_HARD_PCIE_HARD_DEBUG					0x4204
>  #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
> +#define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK		0x200000
>  #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
>  #define  PCIE_BMIPS_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x00800000
> -
> +#define  PCIE_CLKREQ_MASK \
> +	  (PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK | \
> +	   PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK)
>  
>  #define PCIE_INTR2_CPU_BASE		0x4300
>  #define PCIE_MSI_INTR2_BASE		0x4500
> @@ -1028,13 +1031,61 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	return 0;
>  }
>  
> +static void brcm_config_clkreq(struct brcm_pcie *pcie)
> +{
> +	static const char err_msg[] = "invalid 'brcm,clkreq-mode' DT string\n";
> +	const char *mode = "default";
> +	u32 clkreq_cntl;
> +	int ret;
> +
> +	ret = of_property_read_string(pcie->np, "brcm,clkreq-mode", &mode);
> +	if (ret && ret != -EINVAL) {
> +		dev_err(pcie->dev, err_msg);
> +		mode = "safe";
> +	}
> +
> +	/* Start out assuming safe mode (both mode bits cleared) */
> +	clkreq_cntl = readl(pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +	clkreq_cntl &= ~PCIE_CLKREQ_MASK;
> +
> +	if (strcmp(mode, "no-l1ss") == 0) {
> +		/*
> +		 * "no-l1ss" -- Provides Clock Power Management, L0s, and
> +		 * L1, but cannot provide L1 substate (L1SS) power
> +		 * savings. If the downstream device connected to the RC is
> +		 * L1SS capable AND the OS enables L1SS, all PCIe traffic
> +		 * may abruptly halt, potentially hanging the system.
> +		 */
> +		clkreq_cntl |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK;

Does this somehow change the features advertised by the Root Port,
e.g., does it hide the L1 PM Substates Capability completely, or at
least clear the L1 PM Substates Supported bit?

It it doesn't, the PCI core may enable L1SS and cause this hang.
Every feature advertised in config space is expected to work.

> +	} else if (strcmp(mode, "default") == 0) {
> +		/*
> +		 * "default" -- Provides L0s, L1, and L1SS, but not
> +		 * compliant to provide Clock Power Management;
> +		 * specifically, may not be able to meet the Tclron max
> +		 * timing of 400ns as specified in "Dynamic Clock Control",
> +		 * section 3.2.5.2.2 of the PCIe spec.  This situation is
> +		 * atypical and should happen only with older devices.
> +		 */
> +		clkreq_cntl |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK;
> +	} else {
> +		/*
> +		 * "safe" -- No power savings; refclk is driven by RC
> +		 * unconditionally.
> +		 */
> +		if (strcmp(mode, "safe") != 0)
> +			dev_err(pcie->dev, err_msg);
> +		mode = "safe";
> +	}
> +	writel(clkreq_cntl, pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +	dev_info(pcie->dev, "clkreq-mode set to %s\n", mode);
> +}
> +
>  static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
>  	void __iomem *base = pcie->base;
>  	u16 nlw, cls, lnksta;
>  	bool ssc_good = false;
> -	u32 tmp;
>  	int ret, i;
>  
>  	/* Unassert the fundamental reset */
> @@ -1059,6 +1110,8 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>  		return -ENODEV;
>  	}
>  
> +	brcm_config_clkreq(pcie);
> +
>  	if (pcie->gen)
>  		brcm_pcie_set_gen(pcie, pcie->gen);
>  
> @@ -1077,14 +1130,6 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>  		 pci_speed_string(pcie_link_speed[cls]), nlw,
>  		 ssc_good ? "(SSC)" : "(!SSC)");
>  
> -	/*
> -	 * Refclk from RC should be gated with CLKREQ# input when ASPM L0s,L1
> -	 * is enabled => setting the CLKREQ_DEBUG_ENABLE field to 1.
> -	 */
> -	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> -	tmp |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK;
> -	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> -
>  	return 0;
>  }
