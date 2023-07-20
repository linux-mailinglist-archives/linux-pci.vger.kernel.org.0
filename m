Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E0D75ABB1
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 12:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGTKMP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 06:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjGTKMO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 06:12:14 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C09DED;
        Thu, 20 Jul 2023 03:12:11 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id DD22F24E226;
        Thu, 20 Jul 2023 18:11:59 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Jul
 2023 18:11:59 +0800
Received: from [192.168.125.136] (113.72.147.86) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Jul
 2023 18:11:58 +0800
Message-ID: <be30446c-f350-471d-bfac-b4b8dc0a75a2@starfivetech.com>
Date:   Thu, 20 Jul 2023 18:11:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 8/9] PCI: PLDA: starfive: Add JH7110 PCIe controller
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Minda Chen <minda.chen@starfivetech.com>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
References: <20230719164851.GA505840@bhelgaas>
From:   Kevin Xie <kevin.xie@starfivetech.com>
In-Reply-To: <20230719164851.GA505840@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/7/20 0:48, Bjorn Helgaas wrote:
> On Wed, Jul 19, 2023 at 06:20:56PM +0800, Minda Chen wrote:
>> Add StarFive JH7110 SoC PCIe controller platform
>> driver codes.
> 
> Rewrap all the commit logs to fill 75 columns or so.
> 

OK.

>>  #define PCIE_PCI_IDS_DW1		0x9c
>> -
>> +#define  IDS_CLASS_CODE_SHIFT		16
>> +#define PCI_MISC			0xB4
> 
> Surrounding code uses lower-case hex.  Make it all match.
> 

OK, I will make it all match.

>> +#define STG_SYSCON_AXI4_SLVL_ARFUNC_MASK	GENMASK(22, 8)
>> +#define STG_SYSCON_AXI4_SLVL_ARFUNC_SHIFT	8
> 
> When practical, use FIELD_GET() and FIELD_PREP() to avoid the need for
> *_SHIFT macros.
> 

Got it.

>> +struct starfive_jh7110_pcie {
>> +	struct plda_pcie	plda;
>> +	struct reset_control *resets;
>> +	struct clk_bulk_data *clks;
>> +	struct regmap *reg_syscon;
>> +	struct gpio_desc *power_gpio;
>> +	struct gpio_desc *reset_gpio;
>> +
>> +	u32 stg_arfun;
>> +	u32 stg_awfun;
>> +	u32 stg_rp_nep;
>> +	u32 stg_lnksta;
>> +
>> +	int num_clks;
> 
> If you indent one member with tabs, e.g., "struct plda_pcie        plda",
> they should all be indented to match.
> 

OK, I will indent that member with white space.

>> + * The BAR0/1 of bridge should be hidden during enumeration to
>> + * avoid the sizing and resource allocation by PCIe core.
>> + */
>> +static bool starfive_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int  devfn,
>> +				      int offset)
>> +{
>> +	if (pci_is_root_bus(bus) && !devfn &&
>> +	    (offset == PCI_BASE_ADDRESS_0 || offset == PCI_BASE_ADDRESS_1))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +int starfive_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
>> +			       int where, int size, u32 value)
>> +{
>> +	if (starfive_pcie_hide_rc_bar(bus, devfn, where))
>> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> 
> I think you are trying present BARs 0 & 1 as unimplemented.  Such BARs
> are hardwired to zero, so you should make them behave that way (both
> read and write).  Many callers of config accessors don't check the
> return value, so I don't think it's reliable to just return
> PCIBIOS_BAD_REGISTER_NUMBER.
> 

This is a hardware defect that we did not hardwired those BARs to zero,
and it is configurable for software now.
We have to add this filter function for workaround.

>> +static int starfive_pcie_is_link_up(struct starfive_jh7110_pcie *pcie)
>> +{
>> +	struct device *dev = pcie->plda.dev;
>> +	int ret;
>> +	u32 stg_reg_val;
>> +
>> +	/* 100ms timeout value should be enough for Gen1/2 training */
>> +	ret = regmap_read_poll_timeout(pcie->reg_syscon,
>> +				       pcie->stg_lnksta,
>> +				       stg_reg_val,
>> +				       stg_reg_val & DATA_LINK_ACTIVE,
>> +				       10 * 1000, 100 * 1000);
>> +
>> +	/* If the link is down (no device in slot), then exit. */
>> +	if (ret == -ETIMEDOUT) {
>> +		dev_info(dev, "Port link down, exit.\n");
>> +		return 0;
>> +	} else if (ret == 0) {
>> +		dev_info(dev, "Port link up.\n");
>> +		return 1;
>> +	}
> 
> Please copy the naming and style of the "*_pcie_link_up()" functions
> in other drivers.  These are boolean functions with no side effects,
> including no timeouts.
> 
> Some drivers have "*wait_for_link()" functions if polling is needed.
> 

OK, I will refer to other drivers in this part.

>> +		return dev_err_probe(dev, ret,
>> +			"failed to initialize pcie phy\n");
> 
> Driver messages should match (all capitalized or none capitalized).
> 

OK, I will make them all matched.

>> +	/* Enable root port */
> 
> Superfluous comment, since the function name says the same.
> 

I will delete this comment.

>> +	plda_pcie_enable_root_port(plda);
> 
>> +	/* Ensure that PERST has been asserted for at least 100 ms */
>> +	msleep(300);
>> +	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> 
> At least 100 ms, but you sleep *300* ms?  This is probably related to
> https://lore.kernel.org/r/20230718155515.GA483233@bhelgaas
> 
> Please include a comment with the source of the delay value.  I assume
> it's T_PVPERL and T_PERST-CLK from the PCIe CEM spec.  This way we can
> someday share those #defines across drivers.
> 

Yes, the delay value here is T_PVPERL from PCIe CEM spec r2.0 (Table 2-4).
At the first time we set 100ms delay according to sector 2.2 of the spec:
"After there has been time (TPVPERL) for the power and clock to become stable,
PERST# is deasserted high and the PCI Express functions can start up."

However, in the compatibility testing with several NVMe SSD, we found that
Lenovo Thinklife ST8000 NVMe can not get ready in 100ms,
and it actually needs almost 200ms.
Thus, we increased the T_PVPERL value to 300ms for the better device compatibility.

We will use a macro to define T_PVPERL, and add comments for the source of it.
If the compatibility delay of 300ms is not reasonable, we can revert it to 100ms.

>> +#ifdef CONFIG_PM_SLEEP
>> +static int __maybe_unused starfive_pcie_suspend_noirq(struct device *dev)
> 
> I think you can dispense with some of these #ifdefs and the
> __maybe_unused as in
> https://lore.kernel.org/all/20220720224829.GA1667002@bhelgaas/
> 

Thanks, I will refer to your patch.

>> +{
>> +	struct starfive_jh7110_pcie *pcie = dev_get_drvdata(dev);
>> +
>> +	if (!pcie)
>> +		return 0;
> 
> How can this happen?  If we're only detecting memory corruption, it's
> not worth it.
> 
> Bjorn

OK, I will delete this condition.
