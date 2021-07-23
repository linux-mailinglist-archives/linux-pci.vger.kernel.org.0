Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0313D36E0
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 10:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhGWH4c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 03:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhGWH4b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Jul 2021 03:56:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 228D060E77;
        Fri, 23 Jul 2021 08:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627029425;
        bh=dWhTLXqakbXLA6nedRxVuPXSEgLwbVAi7l37hrF/PXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f+ZZMDys7LqJPzHHxea8nHy9lcafyc3756O6dF6rhZC39k5gzsvY799yYHL6o07Qs
         H/QAl1ASJfCP6UFakx6/X03KyNEXRbbRs1Xvu3CVGcZgzECC2UcM115KLtJFBpYmor
         7bKG549++6qQHsGsxRSOXzW08Nn7uNPjxWAougY2ohGUJK0T3JRNwZ/d6HJKyNTAS+
         IjPp48v8j7MivRuYg2OBAujxWEkTw+UggBvYZbQT69/UTdOkk8xGm7e0028cbO5UCM
         nSnhY6y/sq8eaaxRHZlu3v7hwTmc6OS0FMYQcKoPB/ZeEO/aDkJo9thL+Aot7lwKo2
         ncTtup37sSj7g==
Received: by pali.im (Postfix)
        id 9AE0A10D1; Fri, 23 Jul 2021 10:37:02 +0200 (CEST)
Date:   Fri, 23 Jul 2021 10:37:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 3/3] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
Message-ID: <20210723083702.nvhurkgbzbvrrmv3@pali>
References: <1603848703-21099-4-git-send-email-hayashi.kunihiko@socionext.com>
 <20201124232037.GA595463@bjorn-Precision-5520>
 <20201125102328.GA31700@e121166-lin.cambridge.arm.com>
 <f49a236d-c5f8-c445-f74e-7aa4eea70c3a@socionext.com>
 <20210718005109.6xwe3z7gxhuop5xc@pali>
 <2dfa5ec9-2a33-ae72-3904-999d8b8a2f71@socionext.com>
 <20210722172627.i4n65lrz3j7pduiz@pali>
 <17c6eeee-692f-2e9a-5827-34f6939a21a6@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17c6eeee-692f-2e9a-5827-34f6939a21a6@socionext.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 23 July 2021 15:59:12 Kunihiko Hayashi wrote:
> Hi Pali,
> 
> On 2021/07/23 2:26, Pali Rohár wrote:
> > On Friday 23 July 2021 01:54:10 Kunihiko Hayashi wrote:
> > > On 2021/07/18 9:51, Pali Rohar wrote:
> > > > > > IMO this should be modelled with a separate IRQ domain and chip for
> > > > > > the root port (yes this implies describing the root port in the dts
> > > > > > file with a separate msi-parent).
> > > > > > 
> > > > > > This series as it stands is a kludge.
> > > > > 
> > > > > I see. However I need some time to consider the way to separate IRQ domain.
> > > > > Is there any idea or example to handle PME/AER with IRQ domain?
> > > > 
> > > > Seems that you are dealing with very similar issues as me with aardvark
> > > > driver.
> > > > 
> > > > As an inspiration look at my aardvark patch which setup separate IRQ
> > > > domain for PME, AER and HP interrupts:
> > > > https://lore.kernel.org/linux-pci/20210506153153.30454-32-pali@kernel.org/
> > > > 
> > > > Thanks to custom driver map_irq function, it is not needed to describe
> > > > root port with separate msi-parent in DTS.
> > > 
> > > I need to understand your solution, though, this might be the same situation as my driver.
> > 
> > I think it is very very similar as aardvark also returns zero as hw irq
> > number (and it is not possible to change it).
> > 
> > So simple solution for you is also to register separate IRQ domain for
> > Root Port Bridge and then re-trigger interrupt with number 0 (which you
> > wrote that is default) as:
> > 
> >      virq = irq_find_mapping(priv->irq_domain, 0);
> >      generic_handle_irq(virq);
> > 
> > in your uniphier_pcie_misc_isr() function.
> 
> I'm not sure "register separate IRQ domain for Root Port Bridge".
> Do you mean that your suggestion is to create new IRQ domain, and add this domain to root port?

Yes.

> Or could you show me something example?

I have already sent link to patch above which it implements for
pci-aardvark.c driver.

https://lore.kernel.org/linux-pci/20210506153153.30454-32-pali@kernel.org/

In device prove callback register domain by irq_domain_add_linear().
In bridge map_irq() callback use irq_create_mapping() for Root Port
device (and otherwise default of_irq_parse_and_map_pci()). And in
uniphier_pcie_misc_isr() retrigger interrupt into new domain.

> The re-trigger part is the same method as v5 patch I wrote.

Just you need to specify that new/private IRQ domain into
irq_find_mapping() call.

> > There is no need to modify DTS. And also no need to use complicated
> > logic for finding registered virq number via pcie_port_service_get_irq()
> > and uniphier_pcie_port_get_irq() functions.
> 
> I see.
> GIC interrupt for MSI is handled by the MSI domain by pcie-designware-host.c.
> My concern is how to trigger PME/AER event with another IRQ domain.
> 
> Thank you,
> 
> ---
> Best Regards
> Kunihiko Hayashi
