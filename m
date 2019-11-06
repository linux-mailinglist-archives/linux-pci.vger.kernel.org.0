Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78CCEF15FF
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 13:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfKFMY6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 07:24:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:33358 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728716AbfKFMY5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 07:24:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 04:24:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; 
   d="scan'208";a="402339963"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 06 Nov 2019 04:24:53 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iSKMm-0002Vi-JG; Wed, 06 Nov 2019 14:24:52 +0200
Date:   Wed, 6 Nov 2019 14:24:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, helgaas@kernel.org, jingoohan1@gmail.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v5 2/3] dwc: PCI: intel: PCIe RC controller driver
Message-ID: <20191106122452.GA32742@smile.fi.intel.com>
References: <cover.1572950559.git.eswara.kota@linux.intel.com>
 <ac63d9856323555736c5b361612df3ee49b0f998.1572950559.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac63d9856323555736c5b361612df3ee49b0f998.1572950559.git.eswara.kota@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 11:44:02AM +0800, Dilip Kota wrote:
> Add support to PCIe RC controller on Intel Gateway SoCs.
> PCIe controller is based of Synopsys DesignWare PCIe core.
> 
> Intel PCIe driver requires Upconfigure support, fast training
> sequence and link speed configuration. So adding the respective
> helper functions in the PCIe DesignWare framework.
> It also programs hardware autonomous speed during speed
> configuration so defining it in pci_regs.h.

My comments below, though I may miss the discussion and comment on the settled
things.

> +config PCIE_INTEL_GW
> +        bool "Intel Gateway PCIe host controller support"
> +	depends on OF && (X86 || COMPILE_TEST)
> +	select PCIE_DW_HOST
> +	help
> +          Say 'Y' here to enable PCIe Host controller support on Intel
> +	  Gateway SoCs.
> +	  The PCIe controller uses the DesignWare core plus Intel-specific
> +	  hardware wrappers.

Above has indentation issues.

> +void dw_pcie_upconfig_setup(struct dw_pcie *pci)
> +{
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL,
> +			   val | PORT_MLTI_UPCFG_SUPPORT);

Why not to use similar pattern as below?

	val = dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
	val |= PORT_MLTI_UPCFG_SUPPORT;
	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL, val);

> +}

> +void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
> +{
> +	u32 reg, val;
> +	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +
> +	reg = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
> +	reg &= ~PCI_EXP_LNKCTL2_TLS;
> +
> +	switch (pcie_link_speed[link_gen]) {
> +	case PCIE_SPEED_2_5GT:
> +		reg |= PCI_EXP_LNKCTL2_TLS_2_5GT;

> +	break;

Is this a style or indentation issue?

> +	case PCIE_SPEED_5_0GT:
> +		reg |= PCI_EXP_LNKCTL2_TLS_5_0GT;
> +	break;

Ditto.

> +	case PCIE_SPEED_8_0GT:
> +		reg |= PCI_EXP_LNKCTL2_TLS_8_0GT;

> +	break;

Ditto.

> +	case PCIE_SPEED_16_0GT:
> +		reg |= PCI_EXP_LNKCTL2_TLS_16_0GT;

> +	break;

Ditto.

> +	default:

> +	/* Use hardware capability */

Ditto.

> +		val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> +		val = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
> +		reg &= ~PCI_EXP_LNKCTL2_HASD;
> +		reg |= FIELD_PREP(PCI_EXP_LNKCTL2_TLS, val);

> +	break;

Ditto.

> +	}
> +
> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, reg);
> +}

> +void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts)
> +{
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);

> +	val &= ~PORT_LOGIC_N_FTS;
> +	val |= n_fts;

What if somebody supplies bits outside of the mask? I guess you need to apply
proper masks to both values.

> +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +}

> +#define PORT_LOGIC_N_FTS		GENMASK(7, 0)

Shouldn't you use _MASK suffix here?

> +#define BUS_IATU_OFFS			SZ_256M

Perhaps less cryptic name?

> +#define RST_INTRVL_DFT_MS		100

Less cryptic name would be

	RESET_INTERVAL_MS


> +static void pcie_update_bits(void __iomem *base, u32 mask, u32 val, u32 ofs)
> +{
> +	u32 old, new;
> +
> +	old = readl(base + ofs);

> +	new = old & ~mask;
> +	new |= val & mask;

Standard pattern

	new = (old & ~mask) | (val & mask);

And actually you may re-use 'val' variable and get rid of 'new' one.

> +
> +	if (new != old)
> +		writel(new, base + ofs);
> +}

> +static int intel_pcie_get_resources(struct platform_device *pdev)
> +{

> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");

> +

No need to have this blank line.

> +	pci->dbi_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pci->dbi_base))
> +		return PTR_ERR(pci->dbi_base);

> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");

> +

Ditto.

> +	lpp->app_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(lpp->app_base))
> +		return PTR_ERR(lpp->app_base);

> +	return 0;
> +}

> +	/* Read PMC status and wait for falling into L2 link state */
> +	ret = readl_poll_timeout(lpp->app_base + PCIE_APP_PMC, value,

> +				 (value & PCIE_APP_PMC_IN_L2), 20,

Too many parentheses.

> +				 jiffies_to_usecs(5 * HZ));

> +	if (!lpp->pcie_cap_ofst) {
> +		lpp->pcie_cap_ofst = dw_pcie_find_capability(&lpp->pci,
> +							     PCI_CAP_ID_EXP);
> +	}

Wouldn't be slightly better to have something like

	ret = dw_pcie_find_capability(&lpp->pci, PCI_CAP_ID_EXP);
	if (ret >= 0 && !lpp->pcie_cap_ofst)
		lpp->pcie_cap_ofst = ret;

?

(It can be expanded to print error / warning messages if needed)

> +	return ret;
> +}

> +	platform_set_drvdata(pdev, lpp);

I think it makes sense to setup at the end of the function (before dev_info()
call).

> +	data = device_get_match_data(dev);

Perhaps
	if (!data)
		return -ENODEV; // -EINVAL?

> +	/*
> +	 * Intel PCIe doesn't configure IO region, so set viewport
> +	 * to not to perform IO region access.
> +	 */
> +	pci->num_viewport = data->num_viewport;

Missed blank line?

> +	dev_info(dev, "Intel PCIe Root Complex Port init done\n");

-- 
With Best Regards,
Andy Shevchenko


