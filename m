Return-Path: <linux-pci+bounces-7139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37678BD827
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 01:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0E72826AF
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 23:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E199F15B98F;
	Mon,  6 May 2024 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAMIomvT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA774155756;
	Mon,  6 May 2024 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715037633; cv=none; b=B+W8n2A5bm4Rmw7ZyGPixclIw85XT2enKFZ5ntyaLl4t2vsov5BSkg2HMg+tN+sJqpFFLO9/LeCjlWfFWNFCCckpTOUUprQawWELSophU46xzl1EERmwjm0bu4RkzTbHIu3qtpEz1RSMjwShL1WxF7oUkLqZRvaHohmlvDr8/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715037633; c=relaxed/simple;
	bh=mGeX55CzoNaQy2PcjaqTPvV937ILIAHgC31KgXutSvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UDiHWAv6SU/1B2XzuFHL5ek1joRVwmjSrOJh7K40aA0vMtkzzjHLOUbkcWVxaSki4RwBA8aTgaNjBPv+Pr2W4GYSkD3K6YyfwarrmsZbBWYSTt2Fn/2iIWvkOfJJdXP4DfkY4s+Khd4BsMzTPbOr0326MmWddtBRFszfmdLGLf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAMIomvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CEAC116B1;
	Mon,  6 May 2024 23:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715037633;
	bh=mGeX55CzoNaQy2PcjaqTPvV937ILIAHgC31KgXutSvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GAMIomvTmIkZRfJqwzloh1LX74EYz/yUn/GvaIWjZE4tMRoSo2ei0kIHuWPgKruCI
	 JGfKoxUKW8RhoLwfdfQ6aD4ZKGx9i1n2HQViXoerk6uRIM+8GSERXmLMHSB95VsaIF
	 W4idb0a5Z2Ygf9AYNnuX8JFPq2Td1qod8V9yoirPbDlRf9KE8/3eebmH2WEoEn0nMs
	 SlUSVNFvHvsPa8/NV91BEnQ21AvX1FRLBU+iafbRIZItBdkCyGAJ4CjXYL7NExfG/Q
	 EPT+YjYxG2/RISNHxgqr/WOVhmSC+17g6shU5oz2+psG6E8uM6aRGrtH2dXiuyhXSe
	 gv/kq7nLzbgyA==
Date: Mon, 6 May 2024 18:20:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Phil Elwell <phil@raspberrypi.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 4/4] PCI: brcmstb: Configure HW CLKREQ# mode
 appropriate for downstream device
Message-ID: <20240506232031.GA1714174@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403213902.26391-5-james.quinlan@broadcom.com>

On Wed, Apr 03, 2024 at 05:39:01PM -0400, Jim Quinlan wrote:
> The Broadcom STB/CM PCIe HW core, which is also used in RPi SOCs, must be
> deliberately set by the PCIe RC HW into one of three mutually exclusive
> modes:
> 
> "safe" -- No CLKREQ# expected or required, refclk is always provided.  This
>     mode should work for all devices but is not be capable of any refclk
>     power savings.

s/refclk is always provided/the Root Port always supplies Refclk/

At least, I assume that's what this means?  The Root Port always
supplies Refclk regardless of whether a downstream device deasserts
CLKREQ#?

The patch doesn't do anything to prevent aspm.c from setting
PCI_EXP_LNKCTL_CLKREQ_EN, so it looks like Linux may still set the
"Enable Clock Power Management" bit in downstream devices, but the
Root Port just ignores the CLKREQ# signal, right?

s/is not be/is not/

> "no-l1ss" -- CLKREQ# is expected to be driven by the downstream device for
>     CPM and ASPM L0s and L1.  Provides Clock Power Management, L0s, and L1,
>     but cannot provide L1 substate (L1SS) power savings. If the downstream
>     device connected to the RC is L1SS capable AND the OS enables L1SS, all
>     PCIe traffic may abruptly halt, potentially hanging the system.

s/CPM/Clock Power Management (CPM)/ and then you can use "CPM" for the
*second* reference here.

It *looks* like we should never see this PCIe hang because with this
setting you don't advertise L1SS in the Root Port, so the OS should
never enable L1SS, at least for that link.  Right?

If we never enable L1SS in the case where it could cause a hang, why
mention the possibility here?

I assume that if the downstream device is a Switch, L1SS is unsafe for
the Root Port to Switch link, but it could still be used for the link
between the Switch and whatever is below it?

> "default" -- Bidirectional CLKREQ# between the RC and downstream device.
>     Provides ASPM L0s, L1, and L1SS, but not compliant to provide Clock
>     Power Management; specifically, may not be able to meet the T_CLRon max
>     timing of 400ns as specified in "Dynamic Clock Control", section
>     3.2.5.2.2 of the PCIe Express Mini CEM 2.1 specification.  This
>     situation is atypical and should happen only with older devices.

IIUC this T_CLRon timing issue is with the STB/CM *Root Port*, but the
last sentence refers to "older devices," which sounds like it means
"older devices that might be plugged into the Root Port."  That would
suggest the issue is with those devices, not iwth the STB/CM Root
Port.

Or maybe this is meant to refer to older STB/CM Root Ports?

> Previously, this driver always set the mode to "no-l1ss", as almost all
> STB/CM boards operate in this mode.  But now there is interest in
> activating L1SS power savings from STB/CM customers, which requires
> "default" mode.  In addition, a bug was filed for RPi4 CM platform because
> most devices did not work in "no-l1ss" mode (see link below).

I'm having a hard time reconciling "almost all STB/CM boards operate
in 'no-l1ss' mode" with "most devices did not work in 'no-l1ss' mode."
They sound contradictory.

> Note that the mode is specified by the DT property "brcm,clkreq-mode".  If
> this property is omitted, then "default" mode is chosen.

As a user, how do I determine which setting to use?

Trial and error?  If so, how do I identify the errors?

Obviously "default" is the best, so I assume I would try that first.
If something is flaky (whatever that means), I would fall back to
"no-l1ss", which gets me Clock PM, L0s, and L1, right?  In what
situation does "no-l1ss" fail, and how do I tell that it fails?

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217276
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 79 ++++++++++++++++++++++++---
>  1 file changed, 70 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 3d08b92d5bb8..3dc8511e6f58 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -48,6 +48,9 @@
>  #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
>  #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
>  
> +#define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
> +#define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK	0xf8
> +
>  #define PCIE_RC_DL_MDIO_ADDR				0x1100
>  #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
>  #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
> @@ -121,9 +124,12 @@
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
> @@ -1100,13 +1106,73 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	return 0;
>  }
>  
> +static void brcm_config_clkreq(struct brcm_pcie *pcie)
> +{
> +	static const char err_msg[] = "invalid 'brcm,clkreq-mode' DT string\n";
> +	const char *mode = "default";
> +	u32 clkreq_cntl;
> +	int ret, tmp;
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
> +		/*
> +		 * We want to un-advertise L1 substates because if the OS
> +		 * tries to configure the controller into using L1 substate
> +		 * power savings it may fail or hang when the RC HW is in
> +		 * "no-l1ss" mode.
> +		 */
> +		tmp = readl(pcie->base + PCIE_RC_CFG_PRIV1_ROOT_CAP);
> +		u32p_replace_bits(&tmp, 2, PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK);
> +		writel(tmp, pcie->base + PCIE_RC_CFG_PRIV1_ROOT_CAP);
> +
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
> +
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
> +
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
> @@ -1138,6 +1204,8 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>  	 */
>  	brcm_extend_internal_bus_timeout(pcie, BRCM_LTR_MAX_NS + 1000);
>  
> +	brcm_config_clkreq(pcie);
> +
>  	if (pcie->gen)
>  		brcm_pcie_set_gen(pcie, pcie->gen);
>  
> @@ -1156,13 +1224,6 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
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
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 



