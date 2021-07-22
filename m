Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06993D2B13
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 19:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhGVQpz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 12:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhGVQpz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 12:45:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C645261358;
        Thu, 22 Jul 2021 17:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626974789;
        bh=4IqU9Z+o6ET0kK08k5QR9PdfMOnEz4ti7H4G7+Yim0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U/8MEsGya6dK4aOoSlnwj+dO6eiagMt6rDAgYrQjX8anfzcLCYQIcyZO5VlNH4/yF
         1xRzwMm0mu60EM4T7FuTVOl3OvTCTDadkk2u6M1+yaaBerxVpz65IEUBv9SRdeaCBR
         NhzKPRi8ZzP/BS9veRpCaEvgqxVTs+G0hn8KACF0q6qOjJtKk1I1S3LLLq+qL6ciem
         i23BGDWvWx4gIK8KhrNp+R4BnysfiyXArasgHC3ciBPPT5cTRb5WCYB5abulGb0f3b
         xhplA5OyTAXdVUg+Z1FLyjQRUXPWqiRXdpN46Sh1OLMLSUiJJG082b2ecfHlKohkeE
         O07XBLpyxG+ow==
Received: by pali.im (Postfix)
        id 620D5805; Thu, 22 Jul 2021 19:26:27 +0200 (CEST)
Date:   Thu, 22 Jul 2021 19:26:27 +0200
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
Message-ID: <20210722172627.i4n65lrz3j7pduiz@pali>
References: <1603848703-21099-4-git-send-email-hayashi.kunihiko@socionext.com>
 <20201124232037.GA595463@bjorn-Precision-5520>
 <20201125102328.GA31700@e121166-lin.cambridge.arm.com>
 <f49a236d-c5f8-c445-f74e-7aa4eea70c3a@socionext.com>
 <20210718005109.6xwe3z7gxhuop5xc@pali>
 <2dfa5ec9-2a33-ae72-3904-999d8b8a2f71@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dfa5ec9-2a33-ae72-3904-999d8b8a2f71@socionext.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 23 July 2021 01:54:10 Kunihiko Hayashi wrote:
> On 2021/07/18 9:51, Pali Rohar wrote:
> > > > IMO this should be modelled with a separate IRQ domain and chip for
> > > > the root port (yes this implies describing the root port in the dts
> > > > file with a separate msi-parent).
> > > >
> > > > This series as it stands is a kludge.
> > >
> > > I see. However I need some time to consider the way to separate IRQ domain.
> > > Is there any idea or example to handle PME/AER with IRQ domain?
> >
> > Seems that you are dealing with very similar issues as me with aardvark
> > driver.
> >
> > As an inspiration look at my aardvark patch which setup separate IRQ
> > domain for PME, AER and HP interrupts:
> > https://lore.kernel.org/linux-pci/20210506153153.30454-32-pali@kernel.org/
> >
> > Thanks to custom driver map_irq function, it is not needed to describe
> > root port with separate msi-parent in DTS.
> 
> I need to understand your solution, though, this might be the same situation as my driver.

I think it is very very similar as aardvark also returns zero as hw irq
number (and it is not possible to change it).

So simple solution for you is also to register separate IRQ domain for
Root Port Bridge and then re-trigger interrupt with number 0 (which you
wrote that is default) as:

    virq = irq_find_mapping(priv->irq_domain, 0);
    generic_handle_irq(virq);

in your uniphier_pcie_misc_isr() function.

There is no need to modify DTS. And also no need to use complicated
logic for finding registered virq number via pcie_port_service_get_irq()
and uniphier_pcie_port_get_irq() functions.
