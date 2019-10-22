Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E95EE0052
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2019 11:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfJVJHy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Oct 2019 05:07:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:25818 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731234AbfJVJHy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Oct 2019 05:07:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 02:07:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="196377052"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 22 Oct 2019 02:07:52 -0700
Received: from [10.226.39.21] (unknown [10.226.39.21])
        by linux.intel.com (Postfix) with ESMTP id F2EA9580127;
        Tue, 22 Oct 2019 02:07:48 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] dwc: PCI: intel: PCIe RC controller driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <20191021171736.GA233393@google.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <0914051f-b726-f15f-7f86-c0b26ff0f04c@linux.intel.com>
Date:   Tue, 22 Oct 2019 17:07:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021171736.GA233393@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn Helgaas,

On 10/22/2019 1:17 AM, Bjorn Helgaas wrote:
> On Mon, Oct 21, 2019 at 02:39:19PM +0800, Dilip Kota wrote:
>> Add support to PCIe RC controller on Intel Gateway SoCs.
>> PCIe controller is based of Synopsys DesignWare pci core.
>>
>> Intel PCIe driver requires Upconfig support, fast training
>> sequence configuration and link speed change. So adding the
>> respective helper functions in the pcie DesignWare framework.
>> It also programs hardware autonomous speed during speed
>> configuration so defining it in pci_regs.h.
>>
>> +static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
>> +{
>> +	u32 val;
>> +
>> +	val = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCAP);
>> +	lpp->max_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
>> +	lpp->max_width = FIELD_GET(PCI_EXP_LNKCAP_MLW, val);
>> +
>> +	val = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCTL);
>> +
>> +	val &= ~(PCI_EXP_LNKCTL_LD | PCI_EXP_LNKCTL_ASPMC);
>> +	val |= (PCI_EXP_LNKSTA_SLC << 16) | PCI_EXP_LNKCTL_CCC |
>> +	       PCI_EXP_LNKCTL_RCB;
> Link Control is only 16 bits wide, so "PCI_EXP_LNKSTA_SLC << 16"
> wouldn't make sense.  But I guess you're writing a device-specific
> register that is not actually the Link Control as documented in PCIe
> r5.0, sec 7.5.3.7, even though the bits are similar?
It is not device specific.
You are correct about register size that pcie spec mentions 
PCIE_EXP_LNKCTL at 0x10 and PCIE_EXP_LNKSTS at 0x12 each of 2bytes. 
Accessing 4bytes at offset 0x10 ends up accessing LNK control and status 
register.
In Synopsys PCIe controller LINK_CONTROL_LINK_STATUS_REG is of 4bytes 
size at offset 0x10,
In both the cases everything is same except the size of the register, so 
i used PCIE_EXP_LNKCTL macro which is already defined in pci_regs.h


>
> Likewise, PCI_EXP_LNKCTL_RCB is RO for Root Ports, but maybe you're
> telling the device what it should advertise in its Link Control?
You are correct, PCI_EXP_LNKCTL_RCB is RO. I will remove it.
>
> PCI_EXP_LNKCTL_CCC is RW.  But doesn't it depend on the components on
> both ends of the link?  Do you know what device is at the other end?
> I would have assumed that you'd have to start with CCC==0, which
> should be most conservative, then set CCC=1 only if you know both ends
> have a common clock.
PCIe RC and endpoint device are having the common clock so set the CCC=1.
>
>> +	pcie_rc_cfg_wr(lpp, val, PCIE_CAP_OFST + PCI_EXP_LNKCTL);
>> +}
>> +
>> +static void intel_pcie_max_speed_setup(struct intel_pcie_port *lpp)
>> +{
>> +	u32 reg, val;
>> +
>> +	reg = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCTL2);
>> +	switch (lpp->link_gen) {
>> +	case PCIE_LINK_SPEED_GEN1:
>> +		reg &= ~PCI_EXP_LNKCTL2_TLS;
>> +		reg |= PCI_EXP_LNKCTL2_HASD|
>> +			PCI_EXP_LNKCTL2_TLS_2_5GT;
>> +		break;
>> +	case PCIE_LINK_SPEED_GEN2:
>> +		reg &= ~PCI_EXP_LNKCTL2_TLS;
>> +		reg |= PCI_EXP_LNKCTL2_HASD|
>> +			PCI_EXP_LNKCTL2_TLS_5_0GT;
>> +		break;
>> +	case PCIE_LINK_SPEED_GEN3:
>> +		reg &= ~PCI_EXP_LNKCTL2_TLS;
>> +		reg |= PCI_EXP_LNKCTL2_HASD|
>> +			PCI_EXP_LNKCTL2_TLS_8_0GT;
>> +		break;
>> +	case PCIE_LINK_SPEED_GEN4:
>> +		reg &= ~PCI_EXP_LNKCTL2_TLS;
>> +		reg |= PCI_EXP_LNKCTL2_HASD|
>> +			PCI_EXP_LNKCTL2_TLS_16_0GT;
>> +		break;
>> +	default:
>> +		/* Use hardware capability */
>> +		val = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCAP);
>> +		val = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
>> +		reg &= ~PCI_EXP_LNKCTL2_HASD;
>> +		reg |= val;
>> +		break;
>> +	}
>> +
>> +	pcie_rc_cfg_wr(lpp, reg, PCIE_CAP_OFST + PCI_EXP_LNKCTL2);
>> +	dw_pcie_link_set_n_fts(&lpp->pci, lpp->n_fts);
> There are other users of of_pci_get_max_link_speed() that look sort of
> similar to this (dra7xx_pcie_establish_link(),
> ks_pcie_set_link_speed(), tegra_pcie_prepare_host()).  Do these *need*
> to be different, or is there something that could be factored out?
dra7xx_pcie_establish_link() and ks_pcie_set_link_speed() are doing 
speed configuration for GEN1 and GEN1 &2 respectively.

intel_pcie_max_speed_setup() can be moved to dwc framework and dra7xx and ks_pcie drivers can call.

>
>> +}
>> +
>> +
>> +
> Remove extra blank lines here.
i will remove it.
>
>> +static void intel_pcie_port_logic_setup(struct intel_pcie_port *lpp)
>> ...
>> +	/* Intel PCIe doesn't configure IO region, so configure
>> +	 * viewport to not to access IO region during register
>> +	 * read write operations.
>> +	 */
> This comment doesn't describe the code.  Is there supposed to be some
> code here that configures the viewport?  Where do we tell the viewport
> not to access IO?
>
> I guess maybe this means something like "tell
> dw_pcie_access_other_conf() not to program an outbound ATU for I/O"?
> I don't know that structure well enough to write this in a way that
> makes sense, but this code doesn't look like it's configuring any
> viewports.
Yes, you are correct. Telling not to program an outbound ATU for IO.
I will update the description.
> Please use usual multi-line comment style, i.e.,
>
>    /*
>     * Intel PCIe ...
>     */
Sure, i will correct it.

Thanks for reviewing and providing the valuable inputs!
Regards,
Dilip

>> +	pci->num_viewport = data->num_viewport;
>> +	dev_info(dev, "Intel PCIe Root Complex Port %d init done\n", lpp->id);
>> +
>> +	return ret;
>> +}
