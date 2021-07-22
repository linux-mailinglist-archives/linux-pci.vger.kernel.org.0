Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF2D3D2AA7
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhGVQQm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 12:16:42 -0400
Received: from mx.socionext.com ([202.248.49.38]:14382 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234879AbhGVQNe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 12:13:34 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 23 Jul 2021 01:54:08 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id CFA342083C46;
        Fri, 23 Jul 2021 01:54:08 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 23 Jul 2021 01:54:08 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 4F4DEB631E;
        Fri, 23 Jul 2021 01:54:08 +0900 (JST)
Received: from [10.212.30.202] (unknown [10.212.30.202])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 8CBCEB1D52;
        Fri, 23 Jul 2021 01:54:07 +0900 (JST)
Subject: Re: [PATCH v11 3/3] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1619111097-10232-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1619111097-10232-4-git-send-email-hayashi.kunihiko@socionext.com>
 <20210718002614.3l74hlondwgthuby@pali>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <464b94bd-b848-ecca-be5a-6b2c667cf0ea@socionext.com>
Date:   Fri, 23 Jul 2021 01:54:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210718002614.3l74hlondwgthuby@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

Thank you for considering about my patch.

On 2021/07/18 9:26, Pali Rohar wrote:

 > Hello Kunihiko!
 >
 > On Friday 23 April 2021 02:04:57 Kunihiko Hayashi wrote:
 > > This patch adds misc interrupt handler to detect and invoke PME/AER event.
 > >
 > > In UniPhier PCIe controller, PME/AER signals are assigned to the same
 > > signal as MSI by the internal logic. These signals should be detected by
 > > the internal register, however, DWC MSI handler can't handle these signals.
 > >
 > > DWC MSI handler calls .msi_host_isr() callback function, that detects
 > > PME/AER signals using the internal register and invokes the interrupt
 > > with PME/AER IRQ numbers.
 > >
 > > These IRQ numbers is obtained by uniphier_pcie_port_get_irq() function,
 > > that finds the device that matches PME/AER from the devices associated
 > > with Root Port, and returns its IRQ number.
 >
 > If I understood this issue correctly, it means that your PCIe controller
 > does not issue regular MSI interrupt for PME and AER events, but rather
 > it issue controller specific interrupt and you need to figure out what
 > kind of controller-specific event happened (e.g. PME or AER or something
 > else).

Your view is almost correct.
This controller consists of Synopsys DWC and the glue logic, and regular
MSI interrupt is handled in dw_pcie_msi_isr() for DWC.

The interrupt for PME/AER event is issued to CPU as the same interrupt
as MSI, though, PME/AER event is detected by the glue logic instead of DWC.
So the regular MSI handler can't handle the interrupt for PME/AER event
directly.


 > But if your controller supports PME or AER then it expose in its PCIe
 > Root Port capabilities register MSI number for these PME and AER events.
 > Kernel PCIe PME and AER drivers read from capabilities register these
 > numbers and register irq functions to be called when interrupt happens.

Yes, the controller also has the MSI number for PME/AER in Root Port
capability register (defined as PCI_ERR_ROOT_AER_IRQ and PCI_EXP_FLAGS_IRQ).

These interrupts are registered with these capability values in
pcie_port_enable_irq_vec().


 > So it means that you do not need to implement uniphier_pcie_port_get_irq
 > function via this "ugly" foreach and call pcie_port_service_get_irq. But
 > you can read this MSI interrupt number directly from your controller in
 > this pcie-uniphier.c driver and then use irq_find_mapping() to convert
 > hw MSI number to kernel's virq (used in generic_handle_irq()).
 >
 > Because currently you use in pcie-uniphier.c call to function
 > pcie_port_service_get_irq() which returns cached interrupt number value
 > which was read from PCIe Root Port capability register by PCI subsystem
 > callbacked back to the pcie-uniphier.c driver.
 >
 > For me this looks like "ugly" if you need to do something in
 > "complicated" way and add dependency e.g. on compile options like
 > "if (!IS_ENABLED(CONFIG_PCIEAER) && !IS_ENABLED(CONFIG_PCIE_PME))" if it
 > can be easily avoided.
 >
 > I'm writing this because I was solving exactly same problem for aardvark
 > PCIe controller with PME, AER and HP interrupts (patches are on ML). So
 > I think that this pcie-uniphier.c implementation can be simplified
 > without need to use checks for CONFIG_* options and calling
 > pcie_port_service_get_irq() in list_for_each_entry loop.

The interrupt for PME/AER event is detected by the glue logic.

When the handler needs to read the status register for PME/AER in the glue
logic and issue the correspond MSI interrupt using generic_handle_irq().

If the driver gets the MSI interrupt number directly like
pcie_message_numbers() function, I think this complicated method is
no longer necessary, too.


 > Could you please post output of 'lspci -nn -vv'? In my opinion MSI
 > numbers for AER and PME in Root Port could be constant so it may
 > simplify implementation even more. (Just to note that in my case
 > aardvark returns zero as MSI number and it is also documented in spec).

I already posted the lspci output[1].

[1] 
https://lore.kernel.org/linux-pci/1592469493-1549-3-git-send-email-hayashi.kunihiko@socionext.com/T/#e1145dab891debed1eadcddbf2b9f5fabb357f8b0

According to the spec, the initial MSI number for PME/AER is zero.
And this series up to v5 used fixed zero as the MSI number for PME/AER.

Thank you,

---
Best Regards
Kunihiko Hayashi
