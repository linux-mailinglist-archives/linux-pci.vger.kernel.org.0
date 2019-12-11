Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71EC11A869
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 11:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfLKKAD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 05:00:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:7124 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbfLKKAD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Dec 2019 05:00:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 02:00:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="245186313"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 11 Dec 2019 02:00:02 -0800
Received: from [10.226.39.9] (unknown [10.226.39.9])
        by linux.intel.com (Postfix) with ESMTP id AD65558033E;
        Wed, 11 Dec 2019 01:59:59 -0800 (PST)
Subject: Re: [PATCH v10 2/3] PCI: dwc: intel: PCIe RC controller driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        gustavo.pimentel@synopsys.com, andrew.murray@arm.com,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <20191210234951.GA175479@google.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <7f5f0eec-465e-9c21-35ac-b6906119ed5e@linux.intel.com>
Date:   Wed, 11 Dec 2019 17:59:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191210234951.GA175479@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 12/11/2019 7:49 AM, Bjorn Helgaas wrote:
> On Fri, Dec 06, 2019 at 03:27:49PM +0800, Dilip Kota wrote:
>> Add support to PCIe RC controller on Intel Gateway SoCs.
>> PCIe controller is based of Synopsys DesignWare PCIe core.
>>
>> Intel PCIe driver requires Upconfigure support, Fast Training
>> Sequence and link speed configurations. So adding the respective
>> helper functions in the PCIe DesignWare framework.
>> It also programs hardware autonomous speed during speed
>> configuration so defining it in pci_regs.h.
>>
>> Also, mark Intel PCIe driver depends on MSI IRQ Domain
>> as Synopsys DesignWare framework depends on the
>> PCI_MSI_IRQ_DOMAIN.
>>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -14,6 +14,8 @@
>>   
>>   #include "pcie-designware.h"
>>   
>> +extern const unsigned char pcie_link_speed[];
> This shouldn't be needed; there's a declaration in drivers/pci/pci.h.
Sure, will do it. Thanks for pointing it.
>
>> +struct intel_pcie_soc {
>> +	unsigned int pcie_ver;
>> +	unsigned int pcie_atu_offset;
>> +	u32 num_viewport;
>> +};
> Looks a little strange to have the fields below lined up but the ones
> above not.
My miss, i will update it.
>
>> +struct intel_pcie_port {
>> +	struct dw_pcie		pci;
>> +	void __iomem		*app_base;
>> +	struct gpio_desc	*reset_gpio;
>> +	u32			rst_intrvl;
>> +	u32			max_speed;
>> +	u32			link_gen;
>> +	u32			max_width;
>> +	u32			n_fts;
>> +	struct clk		*core_clk;
>> +	struct reset_control	*core_rst;
>> +	struct phy		*phy;
>> +	u8			pcie_cap_ofst;
>> +};
>> +
>> +static void pcie_update_bits(void __iomem *base, u32 ofs, u32 mask, u32 val)
>> +{
>> +	u32 old;
>> +
>> +	old = readl(base + ofs);
>> +	val = (old & ~mask) | (val & mask);
>> +
>> +	if (val != old)
>> +		writel(val, base + ofs);
> I assume this is never used on registers where the "old & ~mask" part
> contains RW1C bits?  If there are RW1C bits in that part, this will
> corrupt them.
There is no impact because RW1C bits of respective registers are 0s at 
the time of this function call.
>
>> +	if (!lpp->pcie_cap_ofst) {
>> +		ret = dw_pcie_find_capability(&lpp->pci, PCI_CAP_ID_EXP);
>> +		if (!ret) {
>> +			ret = -ENXIO;
>> +			dev_err(dev, "Invalid PCIe capability offset\n");
> Some of your messages start with a capital letter, others not.
I will correct it.
>
>> +int intel_pcie_msi_init(struct pcie_port *pp)
> You might add a comment here like the one at
> ks_pcie_am654_msi_host_init().  Since the users of the
> .msi_host_init() function pointer only call the function if the
> pointer is non-NULL, it's not completely obvious why you have this
> stub function.
Ok, i will change it.
>
>> +{
>> +	/* PCIe MSI/MSIx is handled by MSI in x86 processor */
>> +	return 0;
>> +}
>> +	/*
>> +	 * Intel PCIe doesn't configure IO region, so set viewport
>> +	 * to not to perform IO region access.
> s/to not to/to not/
Ok, i will fix it.
>
>> +	 */
>> +	pci->num_viewport = data->num_viewport;
>> +
>> +	dev_info(dev, "Intel PCIe Root Complex Port init done\n");
> Probably superfluous.
I will remove the print then!
>
>> +
>> +	return ret;
> Since the return value is known here:
>
>    return 0;

Ok, i will update it.

I see, this patch series is merged in the maintainer tree.
Should i need to submit as a separate patch on top of maintainer tree or 
submit the new version of whole patch series?
Please let me know the best practice.

Regards,
Dilip

>
>> +}
