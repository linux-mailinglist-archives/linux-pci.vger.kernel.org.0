Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785EC3D98F2
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 00:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhG1WfO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 18:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232174AbhG1WfN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 18:35:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28FB061019;
        Wed, 28 Jul 2021 22:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627511711;
        bh=ZDuaNWwp28Ho8LJfbfmNOQLGMOZ4dSJK9TfRTeg9pSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZuzPRfYjIxtfYJrjEMIqQa8Dtl/gbQMqfEQxGg9ekvOur0xUsHE0Wdy7e/G3sx/u
         GulAYCmXH5E6Ey0YvCMaEHpcowy2feVtpVjzNB962Mft34Ekhftu5h+apkgQqQmNmM
         QAaXO0jotB4AqDQgfnZJiyCeb/A/HYuhaMAIx02hDYNo7wuDyR8beRGG0kQ5yx6rey
         gx9vZ7WO+j36H65YcWlPv5kNRn/14Ck0Oh9cLQgkG7/YYrBWSGRX27RobtG3xZbukb
         hL+1CYze410YVpPt8KXsb6VLrRvdjoThKN6loJrlCLScC2Op429lb8WD6DI7JOACzy
         zdlGSEzYHrXMg==
Received: by pali.im (Postfix)
        id CE4C196B; Thu, 29 Jul 2021 00:35:08 +0200 (CEST)
Date:   Thu, 29 Jul 2021 00:35:08 +0200
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
Message-ID: <20210728223508.iffjpmk6ipjpvddh@pali>
References: <20201124232037.GA595463@bjorn-Precision-5520>
 <20201125102328.GA31700@e121166-lin.cambridge.arm.com>
 <f49a236d-c5f8-c445-f74e-7aa4eea70c3a@socionext.com>
 <20210718005109.6xwe3z7gxhuop5xc@pali>
 <2dfa5ec9-2a33-ae72-3904-999d8b8a2f71@socionext.com>
 <20210722172627.i4n65lrz3j7pduiz@pali>
 <17c6eeee-692f-2e9a-5827-34f6939a21a6@socionext.com>
 <20210723083702.nvhurkgbzbvrrmv3@pali>
 <660e8597-bb7a-b5a0-e3d4-f108a211ae76@socionext.com>
 <d96880c4-75ab-50b5-3ecf-0dfd2aa3b8f3@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d96880c4-75ab-50b5-3ecf-0dfd2aa3b8f3@socionext.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 28 July 2021 14:29:15 Kunihiko Hayashi wrote:
> Hi Lorenzo, Pali,
> 
> On 2021/07/23 18:36, Kunihiko Hayashi wrote:
> > Hi Pali,
> 
> [snip]
> 
> > > Just you need to specify that new/private IRQ domain into
> > > irq_find_mapping() call.
> > 
> > I'll try to replace the events with new IRQ domain.
> According to Pali's suggestion, the bridge handles INTX and it isn't difficult
> to change IRQ's map for Root Port like the example.
> It seems that it can't be applied to MSI.

Hm... And it is hard to change mapping also for MSI via custom/new
callback?

> On the other hand, according to Lorenzo's suggestion,
> 
> >>>>>>> IMO this should be modelled with a separate IRQ domain and chip for
> >>>>>>> the root port (yes this implies describing the root port in the dts
> >>>>>>> file with a separate msi-parent).
> 
> Interrupts for PME/AER event is assigned to number 0 of MSI IRQ domain.

Yes. This is because Root Port of your PCIe controller provides this
information to OS.

> (pcie_port_enable_irq_vec() in portdrv_core.c)
> This expects MSI status bit 0 to be set when the event occurs.

Obviously (according to PCIe spec).

> However, in the uniphier PCIe controller, MSI status bit 0 is not set, but
> the PME/AER status bit in the glue logic is set.

And this "violates" PCIe spec and your controller needs custom handling
in driver to work...

> I think that it's hard to associate the new domain and "MSI-IRQ 0" event
> if the new IRQ domain and chip is modelled.

No. It was mean to assign all MSI IRQs (not only MSI number 0) which
comes from Root Port to new domain. Assigning just one MSI number to
separate domain is I guess impossible (and also does not make sense).

This is required to difference between MSI number 0 which comes from
real MSI path and "fake MSI number 0" which is just specific for Root
Port and does not share anything with real MSI interrupts. As MSI
interrupts are not shared it is required to prevent "mixing" interrupt
sources. And kernel can do it via different MSI domains.

So in the end you would have two different MSI numbers 0.

> So, I have no idea to handle both new IRQ domain and cascaded MSI event.

It was mean to define Root Port PCIe device in DTS. Then define a new
IRQ chip / domain in DTS. And specify in DTS that this Root Port PCIe
device should use this new IRQ chip / domain instead of default one.
And then you need to implement "driver" for this "virtual" IRQ chip /
domain to handle specific glue logic in this controller driver.

I was hoping that it is possible to set this mapping directly in
controller driver. But if you checked that only legacy IRQs can be done
in this way, and not MSI then it is either needed to go via this DTS
path OR try to figure out how to define this mapping in PCI subsystem
(maybe needs some changes?) also for MSI.

> Is there any example for that?

I do not know. I think you are the first one who have such buggy PCIe
controller which needs this specific kind of configuration and domains.

In my case in pci-aardvark.c, emulated kernel Root Port does not support
MSI interrupts (yet) so these "fake" interrupts are routed as legacy
INTA. And because legacy INTx are shared interrupts they can be mixed
together with real (as it is done prior my patch). My patch (link sent
in previous email) just separates "fake" INTA from "real" INTA via
separate domains for performance reasons.

But you use MSI interrupts, which means that it is required to have
logic to separate them into different domains to prevent mixing.

> Thank you,
> 
> ---
> Best Regards
> Kunihiko Hayashi
