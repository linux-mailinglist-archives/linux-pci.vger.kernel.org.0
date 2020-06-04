Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17171EE224
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 12:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgFDKLi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 06:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgFDKLh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jun 2020 06:11:37 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B352206DC;
        Thu,  4 Jun 2020 10:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591265496;
        bh=P44bAU+xwGFOgLsCT7QfTlM8tbyumARHwDqBHLn5mDE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SrQtJzCf1AJtitsKraIknR/lnhU0YiRvyRmRccq4pZYIyrxLx+HqWi5HrYNsNZPnH
         DOm4RMEJG2Y7SjqNIxy8lWcmbkoRQHZFv9H0wmXyRn8feHqHFURucKZfNw2sBt+qYI
         1+mNyTbBPSVZvHyBH7GB9aUTz+T+ftxLSzcW8W7c=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jgmqV-000Dcl-4B; Thu, 04 Jun 2020 11:11:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 04 Jun 2020 11:11:34 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v3 2/6] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
In-Reply-To: <2e07d3d3-515b-57e1-0a36-8892bc38bb7b@socionext.com>
References: <1591174481-13975-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1591174481-13975-3-git-send-email-hayashi.kunihiko@socionext.com>
 <78af3b11de9c513f9be2a1f42f273f27@kernel.org>
 <2e07d3d3-515b-57e1-0a36-8892bc38bb7b@socionext.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <9cbfdacba32c5e351fd9e14444768666@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: hayashi.kunihiko@socionext.com, bhelgaas@google.com, lorenzo.pieralisi@arm.com, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, robh+dt@kernel.org, yamada.masahiro@socionext.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-06-04 10:43, Kunihiko Hayashi wrote:

[...]

>>> -static void uniphier_pcie_irq_handler(struct irq_desc *desc)
>>> +static void uniphier_pcie_misc_isr(struct pcie_port *pp)
>>>  {
>>> -    struct pcie_port *pp = irq_desc_get_handler_data(desc);
>>>      struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>      struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
>>> -    struct irq_chip *chip = irq_desc_get_chip(desc);
>>> -    unsigned long reg;
>>> -    u32 val, bit, virq;
>>> +    u32 val, virq;
>>> 
>>> -    /* INT for debug */
>>>      val = readl(priv->base + PCL_RCV_INT);
>>> 
>>>      if (val & PCL_CFG_BW_MGT_STATUS)
>>>          dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
>>> +
>>>      if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
>>>          dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
>>> -    if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
>>> -        dev_dbg(pci->dev, "Root Error\n");
>>> -    if (val & PCL_CFG_PME_MSI_STATUS)
>>> -        dev_dbg(pci->dev, "PME Interrupt\n");
>>> +
>>> +    if (pci_msi_enabled()) {
>> 
>> This checks whether the kernel supports MSIs. Not that they are
>> enabled in your controller. Is that really what you want to do?
> 
> The below two status bits are valid when the interrupt for MSI is 
> asserted.
> That is, pci_msi_enabled() is wrong.
> 
> I'll modify the function to check the two bits only if this function is
> called from MSI handler.
> 
>> 
>>> +        if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS) {
>>> +            dev_dbg(pci->dev, "Root Error Status\n");
>>> +            virq = irq_linear_revmap(pp->irq_domain, 0);
>>> +            generic_handle_irq(virq);
>>> +        }
>>> +
>>> +        if (val & PCL_CFG_PME_MSI_STATUS) {
>>> +            dev_dbg(pci->dev, "PME Interrupt\n");
>>> +            virq = irq_linear_revmap(pp->irq_domain, 0);
>>> +            generic_handle_irq(virq);
>>> +        }
>> 
>> These two cases do the exact same thing, calling the same interrupt.
>> What is the point of dealing with them independently?
> 
> Both PME and AER are asserted from MSI-0, and each handler checks its 
> own
> status bit in the PCIe register (aer_irq() in pcie/aer.c and 
> pcie_pme_irq()
> in pcie/pme.c).
> So I think this handler calls generic_handle_irq() for the same MSI-0.

So what is wrong with

         if (val & (PCL_CFG_AER_RC_ERR_MSI_STATUS |
                    PCL_CFG_PME_MSI_STATUS)) {
                 // handle interrupt
         }

?

If you have two handlers for the same interrupt, this is a shared
interrupt and each handler will be called in turn.

         M.
-- 
Jazz is not dead. It just smells funny...
