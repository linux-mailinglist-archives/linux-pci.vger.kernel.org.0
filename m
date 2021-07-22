Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695493D2AA8
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhGVQQn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 12:16:43 -0400
Received: from mx.socionext.com ([202.248.49.38]:45074 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234355AbhGVQNi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 12:13:38 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 23 Jul 2021 01:54:12 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 6FC982083C46;
        Fri, 23 Jul 2021 01:54:12 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 23 Jul 2021 01:54:12 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id ED269B632B;
        Fri, 23 Jul 2021 01:54:11 +0900 (JST)
Received: from [10.212.30.202] (unknown [10.212.30.202])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 2C500B1D52;
        Fri, 23 Jul 2021 01:54:11 +0900 (JST)
Subject: Re: [PATCH v8 3/3] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
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
References: <1603848703-21099-4-git-send-email-hayashi.kunihiko@socionext.com>
 <20201124232037.GA595463@bjorn-Precision-5520>
 <20201125102328.GA31700@e121166-lin.cambridge.arm.com>
 <f49a236d-c5f8-c445-f74e-7aa4eea70c3a@socionext.com>
 <20210718005109.6xwe3z7gxhuop5xc@pali>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <2dfa5ec9-2a33-ae72-3904-999d8b8a2f71@socionext.com>
Date:   Fri, 23 Jul 2021 01:54:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210718005109.6xwe3z7gxhuop5xc@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali.

On 2021/07/18 9:51, Pali Rohar wrote:

 > Hello Kunihiko! Now I found also this older email...
 >
 > On Friday 27 November 2020 21:02:05 Kunihiko Hayashi wrote:
 > > Hi Bjorn Lorenzo,
 > >
 > > On 2020/11/25 19:23, Lorenzo Pieralisi wrote:
 > > > On Tue, Nov 24, 2020 at 05:20:37PM -0600, Bjorn Helgaas wrote:
 > > > > On Wed, Oct 28, 2020 at 10:31:43AM +0900, Kunihiko Hayashi wrote:
 > > > > > This patch adds misc interrupt handler to detect and invoke PME/AER event.
 > > > > >
 > > > > > In UniPhier PCIe controller, PME/AER signals are assigned to the same
 > > > > > signal as MSI by the internal logic. These signals should be detected by
 > > > > > the internal register, however, DWC MSI handler can't handle these signals.
 > > > >
 > > > > I don't know what "PME/AER signals are assigned to the same signal as
 > > > > MSI" means.
 > > >
 > > > The host controller embeds an interrupt-controller whose IRQ wire output
 > > > is cascaded into the main interrupt controller.
 > > >
 > > > The host-bridge embedded controller receives MSI writes from devices
 > > > and it turns them into an edge IRQ into the main interrupt controller.
 > > >
 > > > To ack/mask the MSIs at host contoller interrupt controller level, there
 > > > is a control register in the host controller that needs handling upon
 > > > IRQ reception.
 > >
 > > Thanks for explaining that.
 > > In my understanding, PME/AER signals are cascaded to MSI by embedded
 > > interrupt controller (not "assigned").
 > >
 > >
 > > > The *RP* (and AFAIU the RP *only*) signals the PME/AER MSI using the
 > > > same wire to the main interrupt controller but its ack/mask is handled
 > > > by a different bit in the host bridge control register above, therefore
 > > > the cascaded IRQ isr needs to know which virq it is actually handling
 > > > to ack/mask accordingly.
 > >
 > > Sorry what is RP? Root complex or something?
 >
 > RP = Root Port
 >
 > In lspci output you can find it as "root" of the tree topology and
 > should have "PCI bridge" class/name.

Ok, I understand.

 >
 > > > IMO this should be modelled with a separate IRQ domain and chip for
 > > > the root port (yes this implies describing the root port in the dts
 > > > file with a separate msi-parent).
 > > >
 > > > This series as it stands is a kludge.
 > >
 > > I see. However I need some time to consider the way to separate IRQ domain.
 > > Is there any idea or example to handle PME/AER with IRQ domain?
 >
 > Seems that you are dealing with very similar issues as me with aardvark
 > driver.
 >
 > As an inspiration look at my aardvark patch which setup separate IRQ
 > domain for PME, AER and HP interrupts:
 > https://lore.kernel.org/linux-pci/20210506153153.30454-32-pali@kernel.org/
 >
 > Thanks to custom driver map_irq function, it is not needed to describe
 > root port with separate msi-parent in DTS.

I need to understand your solution, though, this might be the same situation as my driver.

 > > > > I'm trying to figure out if this is talking about PME/AER MSI vector
 > > > > numbers (probably not)
 >
 > Bjorn, see my email, based on my experience with aardvark controller I
 > think they are MSI vector numbers, but controller instead uses own
 > proprietary way how to signal PME and AER interrupts.
 > https://lore.kernel.org/linux-pci/20210718002614.3l74hlondwgthuby@pali/
 >
 > > > > or some internal wire that's not
 > > > > architecturally visible or what.
 > > > >
 > > > > Probably also not related to the fact that PME, hotplug, and bandwidth
 > > > > notifications share the same MSI/MSI-X vector.
 > > > >
 > > > > Is this something that's going to be applicable to all the DWC-based
 > > > > drivers?
 > >
 > > I think that this feature depends on the vendor specification.
 > > At least, the registers to control or check these signals are implemented
 > > in the vendor's logic.
 > >
 > >
 > > > > > DWC MSI handler calls .msi_host_isr() callback function, that detects
 > > > > > PME/AER signals with the internal register and invokes the interrupt
 > > > > > with PME/AER vIRQ numbers.
 > > > > >
 > > > > > These vIRQ numbers is obtained from portdrv in uniphier_add_pcie_port()
 > > > > > function.
 > > > > >
 > > > > > Cc: Marc Zyngier <maz@kernel.org>
 > > > > > Cc: Jingoo Han <jingoohan1@gmail.com>
 > > > > > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 > > > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 > > > > > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 > > > > > Reviewed-by: Rob Herring <robh@kernel.org>
 > > > > > ---
 > > > > >   drivers/pci/controller/dwc/pcie-uniphier.c | 77 +++++++++++++++++++++++++-----
 > > > > >   1 file changed, 66 insertions(+), 11 deletions(-)
 > > > > >
 > > > > > diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c 
b/drivers/pci/controller/dwc/pcie-uniphier.c
 > > > > > index 4817626..237537a 100644
 > > > > > --- a/drivers/pci/controller/dwc/pcie-uniphier.c
 > > > > > +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
 > > > > > @@ -21,6 +21,7 @@
 > > > > >   #include <linux/reset.h>
 > > > > >   #include "pcie-designware.h"
 > > > > > +#include "../../pcie/portdrv.h"
 > > > > >   #define PCL_PINCTRL0			0x002c
 > > > > >   #define PCL_PERST_PLDN_REGEN		BIT(12)
 > > > > > @@ -44,7 +45,9 @@
 > > > > >   #define PCL_SYS_AUX_PWR_DET		BIT(8)
 > > > > >   #define PCL_RCV_INT			0x8108
 > > > > > +#define PCL_RCV_INT_ALL_INT_MASK	GENMASK(28, 25)
 > > > > >   #define PCL_RCV_INT_ALL_ENABLE		GENMASK(20, 17)
 > > > > > +#define PCL_RCV_INT_ALL_MSI_MASK	GENMASK(12, 9)
 > > > > >   #define PCL_CFG_BW_MGT_STATUS		BIT(4)
 > > > > >   #define PCL_CFG_LINK_AUTO_BW_STATUS	BIT(3)
 > > > > >   #define PCL_CFG_AER_RC_ERR_MSI_STATUS	BIT(2)
 > > > > > @@ -68,6 +71,8 @@ struct uniphier_pcie_priv {
 > > > > >   	struct reset_control *rst;
 > > > > >   	struct phy *phy;
 > > > > >   	struct irq_domain *legacy_irq_domain;
 > > > > > +	int aer_irq;
 > > > > > +	int pme_irq;
 > > > > >   };
 > > > > >   #define to_uniphier_pcie(x)	dev_get_drvdata((x)->dev)
 > > > > > @@ -167,7 +172,15 @@ static void uniphier_pcie_stop_link(struct dw_pcie *pci)
 > > > > >   static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
 > > > > >   {
 > > > > > -	writel(PCL_RCV_INT_ALL_ENABLE, priv->base + PCL_RCV_INT);
 > > > > > +	u32 val;
 > > > > > +
 > > > > > +	val = PCL_RCV_INT_ALL_ENABLE;
 > > > > > +	if (pci_msi_enabled())
 > > > > > +		val |= PCL_RCV_INT_ALL_INT_MASK;
 > > > > > +	else
 > > > > > +		val |= PCL_RCV_INT_ALL_MSI_MASK;
 > > > >
 > > > > I'm confused about how this works.  Root Ports can signal AER errors
 > > > > with either INTx or MSI.  This is controlled by the architected
 > > > > Interrupt Disable bit and the MSI/MSI-X enable bits (I'm looking at
 > > > > PCIe r5.0, sec 6.2.4.1.2).
 > > > >
 > > > > The code here doesn't look related to those bits.  Does this code mean
 > > > > that if pci_msi_enabled(), the Root Port will always signal with MSI
 > > > > (if MSI Enable is set) and will *never* signal with INTx?
 > >
 > > According to the spec sheet, we need to set interrupt enable bit for either
 > > INTx or MSI, the other bit should be reset. These bits are in config space
 > > and handled by the framework.
 >
 > Is spec sheet available publicly?

Sorry the spec sheet isn't open to the public.
Currently initial configuration is to use MSI, and I assume MSI interrupt is used
as default.

Thank you,

---
Best Regards
Kunihiko Hayashi
