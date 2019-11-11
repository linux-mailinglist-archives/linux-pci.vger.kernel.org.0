Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A12ACF74DA
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 14:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKKN3X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 08:29:23 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:52259 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726982AbfKKN3X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Nov 2019 08:29:23 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iU9km-0001uY-H2; Mon, 11 Nov 2019 14:29:12 +0100
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH 4/4] PCI: brcmstb: add MSI capability
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Nov 2019 14:38:33 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     Andrew Murray <andrew.murray@arm.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>, <mbrugger@suse.com>,
        <phil@raspberrypi.org>, <linux-kernel@vger.kernel.org>,
        <wahrenst@gmx.net>, <james.quinlan@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <86aeec16bc04d17372db5e33ffec0d5621973116.camel@suse.de>
References: <20191106214527.18736-1-nsaenzjulienne@suse.de>
 <20191106214527.18736-5-nsaenzjulienne@suse.de>
 <f1154b65d422e2e37e3b320e662d4268@www.loen.fr>
 <86aeec16bc04d17372db5e33ffec0d5621973116.camel@suse.de>
Message-ID: <e12adb8d4f3be328318c8b911f4ba611@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: nsaenzjulienne@suse.de, andrew.murray@arm.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, f.fainelli@gmail.com, mbrugger@suse.com, phil@raspberrypi.org, linux-kernel@vger.kernel.org, wahrenst@gmx.net, james.quinlan@broadcom.com, bhelgaas@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nicolas,

On 2019-11-11 12:31, Nicolas Saenz Julienne wrote:
> Hi Marc,
> thanks for the review!
>
> On Thu, 2019-11-07 at 16:49 +0109, Marc Zyngier wrote:
>> On 2019-11-06 22:54, Nicolas Saenz Julienne wrote:
>> > From: Jim Quinlan <james.quinlan@broadcom.com>
>> >
>> > This commit adds MSI to the Broadcom STB PCIe host controller. It
>> > does
>> > not add MSIX since that functionality is not in the HW.  The MSI
>> > controller is physically located within the PCIe block, however,
>> > there
>> > is no reason why the MSI controller could not be moved elsewhere 
>> in
>> > the future.
>> >
>> > Since the internal Brcmstb MSI controller is intertwined with the
>> > PCIe
>> > controller, it is not its own platform device but rather part of 
>> the
>> > PCIe platform device.
>> >
>> > This is based on Jim's original submission[1] with some slight
>> > changes
>> > regarding how pcie->msi_target_addr is decided.
>> >
>> > [1] https://patchwork.kernel.org/patch/10605955/
>> >
>> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>> > Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>> > ---
>> >  drivers/pci/controller/Kconfig        |   2 +-
>> >  drivers/pci/controller/pcie-brcmstb.c | 333
>> > +++++++++++++++++++++++++-
>> >  2 files changed, 332 insertions(+), 3 deletions(-)

[...]

>> > +static struct msi_domain_info brcm_msi_domain_info = {
>> > +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>> > +		   MSI_FLAG_PCI_MSIX),
>>
>> Is there a particular reason for not supporting MultiMSI? I won't 
>> miss
>> it, but it might be worth documenting the restriction if the HW 
>> cannot
>> support it (though I can't immediately see why).
>
> There is no actual restriction. As Jim tells me, there never was the 
> need for
> it. If it's fine with you, we'll leave that as an enhancement for the 
> future,
> specially since the RPi's XHCI device only uses one MSI interrupt.

Sure, that's fine. But as soon as someone takes this SoC and sticks it 
on
a different board (RPi CM4 anyone?), this will become a requirement (I 
thought
MultiMSI dead 4 years ago, and have been proved wrong many times 
since).

>
>> > +	.chip	= &brcm_msi_irq_chip,
>> > +};
>> > +
>> > +static void brcm_pcie_msi_isr(struct irq_desc *desc)
>> > +{
>> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> > +	struct brcm_msi *msi;
>> > +	unsigned long status, virq;
>> > +	u32 mask, bit, hwirq;
>> > +	struct device *dev;
>> > +
>> > +	chained_irq_enter(chip, desc);
>> > +	msi = irq_desc_get_handler_data(desc);
>> > +	mask = msi->intr_legacy_mask;
>> > +	dev = msi->dev;
>> > +
>> > +	while ((status = bcm_readl(msi->intr_base + STATUS) & mask)) {
>>
>> Is this loop really worth it? If, as I imagine, this register is at 
>> the
>> end of a wet piece of string, this additional read (likely to return
>> zero)
>> will have a measurable latency impact...
>
> I think this one was cargo-culted, TBH this pattern is all over the 
> place.
> Though, now that you point it out, I can't really provide a 
> justification for
> it. Maybe Jim can contradict me here, but It's working fine without 
> it.

I know this pattern is ultra common (hey, the GIC uses it), but I'm
somehow doubtful of its benefit. On GICv3, not reading the status
register again has given us a performance boost for most workloads.

[...]

>> > +	/*
>> > +	 * Make sure we are not masking MSIs.  Note that MSIs can be
>> > masked,
>> > +	 * but that occurs on the PCIe EP device
>>
>> That's not a guarantee, specially with plain MultiMSI. I'm actually
>> minded to move the masking to be purely local on the MSI controllers
>> I maintain.
>
> Sorry, I'm a little lost here. The way I understand it after reset, 
> even with
> multiMSI, on the EP side all vectors are umasked. So it would make
> sense to do
> the same on the controller.
>
> The way I see it, we want to avoid using this register anyway, as
> with multiMSI
> we'd only get function wide masking, which I guess is not all that 
> useful.

Yeah, I wasn't 100% clear. Unless you have MSI-X, there is no guarantee
to have a mask bit per MSI. Multi-MSI definitely has only this problem.

My advice would be to let the PCI layer deal with enabling/disabling
interrupts at the endpoint level, and let this driver manage the
masking at its own level, using the MASK registers.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
