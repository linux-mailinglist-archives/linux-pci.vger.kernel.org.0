Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0967275F3C4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 12:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGXKtI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 06:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjGXKtA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 06:49:00 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D297102;
        Mon, 24 Jul 2023 03:48:56 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 4D52F7FD6;
        Mon, 24 Jul 2023 18:48:49 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Jul
 2023 18:48:49 +0800
Received: from [192.168.125.136] (183.27.99.135) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Jul
 2023 18:48:48 +0800
Message-ID: <a687c273-48b1-651e-313f-d8140732c5d8@starfivetech.com>
Date:   Mon, 24 Jul 2023 18:48:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 8/9] PCI: PLDA: starfive: Add JH7110 PCIe controller
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Minda Chen <minda.chen@starfivetech.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
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
References: <20230720161555.GA526946@bhelgaas>
From:   Kevin Xie <kevin.xie@starfivetech.com>
In-Reply-To: <20230720161555.GA526946@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.99.135]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/7/21 0:15, Bjorn Helgaas wrote:
> On Thu, Jul 20, 2023 at 06:11:59PM +0800, Kevin Xie wrote:
>> On 2023/7/20 0:48, Bjorn Helgaas wrote:
>> > On Wed, Jul 19, 2023 at 06:20:56PM +0800, Minda Chen wrote:
>> >> Add StarFive JH7110 SoC PCIe controller platform
>> >> driver codes.
> 
>> >> + * The BAR0/1 of bridge should be hidden during enumeration to
>> >> + * avoid the sizing and resource allocation by PCIe core.
>> >> + */
>> >> +static bool starfive_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int  devfn,
>> >> +				      int offset)
>> >> +{
>> >> +	if (pci_is_root_bus(bus) && !devfn &&
>> >> +	    (offset == PCI_BASE_ADDRESS_0 || offset == PCI_BASE_ADDRESS_1))
>> >> +		return true;
>> >> +
>> >> +	return false;
>> >> +}
>> >> +
>> >> +int starfive_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
>> >> +			       int where, int size, u32 value)
>> >> +{
>> >> +	if (starfive_pcie_hide_rc_bar(bus, devfn, where))
>> >> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>> > 
>> > I think you are trying present BARs 0 & 1 as unimplemented.  Such BARs
>> > are hardwired to zero, so you should make them behave that way (both
>> > read and write).  Many callers of config accessors don't check the
>> > return value, so I don't think it's reliable to just return
>> > PCIBIOS_BAD_REGISTER_NUMBER.
>> 
>> This is a hardware defect that we did not hardwired those BARs to
>> zero, and it is configurable for software now.  We have to add this
>> filter function for workaround.
> 
> Yes.  My point is that this only affects the write path, and the read
> probably does not read 0 as it should.  This means lspci will show the
> wrong thing, and the PCI core will try to size the BAR when it doesn't
> need to.  I haven't looked at the BAR sizing code; it might even come
> up with a bogus size and address, when it *should* just conclude the
> BAR doesn't exist at all.
> 

Got it, I will try to hide those BARs both in read and write operations.

>> >> +	/* Ensure that PERST has been asserted for at least 100 ms */
>> >> +	msleep(300);
>> >> +	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
>> > 
>> > At least 100 ms, but you sleep *300* ms?  This is probably related to
>> > https://lore.kernel.org/r/20230718155515.GA483233@bhelgaas
>> > 
>> > Please include a comment with the source of the delay value.  I assume
>> > it's T_PVPERL and T_PERST-CLK from the PCIe CEM spec.  This way we can
>> > someday share those #defines across drivers.
>> 
>> Yes, the delay value here is T_PVPERL from PCIe CEM spec r2.0 (Table
>> 2-4).  At the first time we set 100ms delay according to sector 2.2
>> of the spec: "After there has been time (TPVPERL) for the power and
>> clock to become stable, PERST# is deasserted high and the PCI
>> Express functions can start up."
>> 
>> However, in the compatibility testing with several NVMe SSD, we
>> found that Lenovo Thinklife ST8000 NVMe can not get ready in 100ms,
>> and it actually needs almost 200ms.  Thus, we increased the T_PVPERL
>> value to 300ms for the better device compatibility.
>>
>> We will use a macro to define T_PVPERL, and add comments for the
>> source of it.  If the compatibility delay of 300ms is not
>> reasonable, we can revert it to 100ms.
> 
> Thanks for this valuable information!  This NVMe issue potentially
> affects many similar drivers, and we may need a more generic fix so
> this device works well with all of them.
> 
> T_PVPERL is defined to start when power is stable.  Do you have a way
> to accurately determine that point?  I'm guessing this:
> 
>   gpiod_set_value_cansleep(pcie->power_gpio, 1)
> 
> turns the power on?  But of course that doesn't mean it is instantly
> stable.  Maybe your testing is telling you that your driver should
> have a hardware-specific 200ms delay to wait for power to become
> stable, followed by the standard 100ms for T_PVPERL?
> 

You are right, we did not take the power stable cost into account.
T_PVPERL is enough for Lenovo Thinklife ST8000 NVMe SSD to get ready,
and the extra cost is from the power circuit of a PCIe to M.2 connector,
which is used to verify M.2 SSD with our EVB at early stage.

As the Thinklife NVMe SSD may be a halted product,
and the onboard power circuit of VisionFive V2 is no problem,
we decided revert the sleep time to be 100ms.

We will add a comment for the source of T_PVPERL until your define in pci.h is accepted.

> Bjorn
