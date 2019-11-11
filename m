Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44109F6F6D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 09:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfKKIId (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 03:08:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:15070 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfKKIIc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 03:08:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 00:08:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; 
   d="scan'208";a="206666258"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 11 Nov 2019 00:08:30 -0800
Received: from [10.226.39.46] (ekotax-mobl.gar.corp.intel.com [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id CC57C580261;
        Mon, 11 Nov 2019 00:08:22 -0800 (PST)
Subject: Re: [PATCH v5 2/3] dwc: PCI: intel: PCIe RC controller driver
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, helgaas@kernel.org, jingoohan1@gmail.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1572950559.git.eswara.kota@linux.intel.com>
 <ac63d9856323555736c5b361612df3ee49b0f998.1572950559.git.eswara.kota@linux.intel.com>
 <20191106122452.GA32742@smile.fi.intel.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <eee3e6ee-fd55-9c88-a628-34f883b19988@linux.intel.com>
Date:   Mon, 11 Nov 2019 16:08:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106122452.GA32742@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/6/2019 8:24 PM, Andy Shevchenko wrote:
> On Wed, Nov 06, 2019 at 11:44:02AM +0800, Dilip Kota wrote:
>> Add support to PCIe RC controller on Intel Gateway SoCs.
>> PCIe controller is based of Synopsys DesignWare PCIe core.
>>
>> Intel PCIe driver requires Upconfigure support, fast training
>> sequence and link speed configuration. So adding the respective
>> helper functions in the PCIe DesignWare framework.
>> It also programs hardware autonomous speed during speed
>> configuration so defining it in pci_regs.h.
> My comments below, though I may miss the discussion and comment on the settled
> things.
>
>> +config PCIE_INTEL_GW
>> +        bool "Intel Gateway PCIe host controller support"
>> +	depends on OF && (X86 || COMPILE_TEST)
>> +	select PCIE_DW_HOST
>> +	help
>> +          Say 'Y' here to enable PCIe Host controller support on Intel
>> +	  Gateway SoCs.
>> +	  The PCIe controller uses the DesignWare core plus Intel-specific
>> +	  hardware wrappers.
> Above has indentation issues.

Typo error, i will fix it.
Thanks for pointing.

>
>> +void dw_pcie_upconfig_setup(struct dw_pcie *pci)
>> +{
>> +	u32 val;
>> +
>> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
>> +	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL,
>> +			   val | PORT_MLTI_UPCFG_SUPPORT);
> Why not to use similar pattern as below?
>
> 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
> 	val |= PORT_MLTI_UPCFG_SUPPORT;
> 	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL, val);
Ok, i will update it.
>> +}
>> +void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>> +{
>> +	u32 reg, val;
>> +	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +
>> +	reg = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
>> +	reg &= ~PCI_EXP_LNKCTL2_TLS;
>> +
>> +	switch (pcie_link_speed[link_gen]) {
>> +	case PCIE_SPEED_2_5GT:
>> +		reg |= PCI_EXP_LNKCTL2_TLS_2_5GT;
>> +	break;
> Is this a style or indentation issue?
While writing this switch case, i observed couple of drivers doing like 
this(I dont remember the driver names).
I checked now other PCIe controller drivers, break is inline to 'reg |=' 
line.
I will update it.
>
>> +	case PCIE_SPEED_5_0GT:
>> +		reg |= PCI_EXP_LNKCTL2_TLS_5_0GT;
>> +	break;
> Ditto.
>
>> +	case PCIE_SPEED_8_0GT:
>> +		reg |= PCI_EXP_LNKCTL2_TLS_8_0GT;
>> +	break;
> Ditto.
>
>> +	case PCIE_SPEED_16_0GT:
>> +		reg |= PCI_EXP_LNKCTL2_TLS_16_0GT;
>> +	break;
> Ditto.
>
>> +	default:
>> +	/* Use hardware capability */
> Ditto.
I will correct it.
>
>> +		val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>> +		val = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
>> +		reg &= ~PCI_EXP_LNKCTL2_HASD;
>> +		reg |= FIELD_PREP(PCI_EXP_LNKCTL2_TLS, val);
>> +	break;
> Ditto.
>
>> +	}
>> +
>> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, reg);
>> +}
>> +void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts)
>> +{
>> +	u32 val;
>> +
>> +	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>> +	val &= ~PORT_LOGIC_N_FTS;
>> +	val |= n_fts;
> What if somebody supplies bits outside of the mask? I guess you need to apply
> proper masks to both values.
Agree, i will update it.
>
>> +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
>> +}
>> +#define PORT_LOGIC_N_FTS		GENMASK(7, 0)
> Shouldn't you use _MASK suffix here?
Agree, i will update it to PORT_LOGIC_N_FTS_MASK .
>
>> +#define BUS_IATU_OFFS			SZ_256M
> Perhaps less cryptic name?
I will update it to BUS_IATU_OFFSET
>
>> +#define RST_INTRVL_DFT_MS		100
> Less cryptic name would be
>
> 	RESET_INTERVAL_MS
Agree, I will update it.
>
>
>> +static void pcie_update_bits(void __iomem *base, u32 mask, u32 val, u32 ofs)
>> +{
>> +	u32 old, new;
>> +
>> +	old = readl(base + ofs);
>> +	new = old & ~mask;
>> +	new |= val & mask;
> Standard pattern
>
> 	new = (old & ~mask) | (val & mask);
>
> And actually you may re-use 'val' variable and get rid of 'new' one.

Agree, will reuse the val:
val = (old & ~mask) | (val & mask);

>
>> +
>> +	if (new != old)
>> +		writel(new, base + ofs);
>> +}
>> +static int intel_pcie_get_resources(struct platform_device *pdev)
>> +{
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
>> +
> No need to have this blank line.
Agree, will remove it.
>
>> +	pci->dbi_base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(pci->dbi_base))
>> +		return PTR_ERR(pci->dbi_base);
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
>> +
> Ditto.
Agree, will remove it.
>
>> +	lpp->app_base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(lpp->app_base))
>> +		return PTR_ERR(lpp->app_base);
>> +	return 0;
>> +}
>> +	/* Read PMC status and wait for falling into L2 link state */
>> +	ret = readl_poll_timeout(lpp->app_base + PCIE_APP_PMC, value,
>> +				 (value & PCIE_APP_PMC_IN_L2), 20,
> Too many parentheses.
Agree, will remove it.
>
>> +				 jiffies_to_usecs(5 * HZ));
>> +	if (!lpp->pcie_cap_ofst) {
>> +		lpp->pcie_cap_ofst = dw_pcie_find_capability(&lpp->pci,
>> +							     PCI_CAP_ID_EXP);
>> +	}
> Wouldn't be slightly better to have something like
>
> 	ret = dw_pcie_find_capability(&lpp->pci, PCI_CAP_ID_EXP);
> 	if (ret >= 0 && !lpp->pcie_cap_ofst)
> 		lpp->pcie_cap_ofst = ret;
>
> ?
>
> (It can be expanded to print error / warning messages if needed)
This function gets called during initialization and system resume. I 
have kept the if check to do dw_pcie_find_capability() only once.(not to 
do for system resume)
For error check, i will update this to
if (!lpp->pcie_cap_ofst) {    /*pcie_cap_ofst will be 0 for the very 
first time as kzalloc() is used for memory allocation for lpp structure*/
      ret = dw_pcie_find_capability(&lpp->pci, PCI_CAP_ID_EXP);
      if (!ret) { /* Function returns 0 in error case */
          ret = -ENXIO;
          dev_err();
          goto app_init_err;
       }
       lpp->pcie_cap_ofst = ret;
}
>
>> +	return ret;
>> +}
>> +	platform_set_drvdata(pdev, lpp);
> I think it makes sense to setup at the end of the function (before dev_info()
> call).
I have done it immediately after the memory allocation.
Ok, i will move it before dev_info().
>
>> +	data = device_get_match_data(dev);
> Perhaps
> 	if (!data)
> 		return -ENODEV; // -EINVAL?

Sure i will add it and ENODEV looks appropriate.

>
>> +	/*
>> +	 * Intel PCIe doesn't configure IO region, so set viewport
>> +	 * to not to perform IO region access.
>> +	 */
>> +	pci->num_viewport = data->num_viewport;
> Missed blank line?
I will add it.

Thanks a lot for reviewing and giving the inputs. I will update the new 
patch version according to your inputs and submit for review.

Regards,
Dilip

>
>> +	dev_info(dev, "Intel PCIe Root Complex Port init done\n");
