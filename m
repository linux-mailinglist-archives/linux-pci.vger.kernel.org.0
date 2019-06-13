Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE6244ECD
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 23:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfFMV5L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 17:57:11 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:33497 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfFMV5L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 17:57:11 -0400
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E8A4A240005;
        Thu, 13 Jun 2019 21:57:06 +0000 (UTC)
Date:   Fri, 14 Jun 2019 00:06:54 +0200
From:   Remi Pommarel <repk@triplefau.lt>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ellie Reeves <ellierevves@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Fix PCI_EXP_RTCTL conf register writing
Message-ID: <20190613220653.GB12859@voidbox.localdomain>
References: <20190522213351.21366-1-repk@triplefau.lt>
 <20190613161441.GA2247@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613161441.GA2247@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 05:14:41PM +0100, Lorenzo Pieralisi wrote:
> On Wed, May 22, 2019 at 11:33:49PM +0200, Remi Pommarel wrote:
> > PCI_EXP_RTCTL is used to activate PME interrupt only, so writing into it
> > should not modify other interrupts' mask (such as ISR0).
> > 
> > Fixes: 6302bf3ef78d ("PCI: Init PCIe feature bits for managed host bridge alloc")
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> > ---
> > Please note that I will unlikely be able to answer any comments from May
> > 24th to June 10th.
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 134e0306ff00..27102d3b4f9c 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -451,10 +451,14 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
> >  		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
> >  		break;
> >  
> > -	case PCI_EXP_RTCTL:
> > -		new = (new & PCI_EXP_RTCTL_PMEIE) << 3;
> > -		advk_writel(pcie, new, PCIE_ISR0_MASK_REG);
> > +	case PCI_EXP_RTCTL: {
> > +		/* Only mask/unmask PME interrupt */
> > +		u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG) &
> > +			~PCIE_MSG_PM_PME_MASK;
> > +		val |= (new & PCI_EXP_RTCTL_PMEIE) << 3;
> 
> I know you have not introduced this code but maybe we can
> take an opportunity to clarify it (that << 3 shift obfuscates
> a bit):
> 
> 	u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG) &
> 			~PCIE_MSG_PM_PME_MASK;
> 
> 	if (new & PCI_EXP_RTCTL_PMEIE)
> 		val |= PCIE_MSG_PM_PME_MASK;
> 
> 	advk_writel(pcie, val, PCIE_ISR0_MASK_REG);
> 	break;
> 
> Or I am not reading the code correctly ?

Sure, that clarifies the code at the point where I realize that the
"<< 3" from the original code was off by one and the mask polarity was
inverted. So I'll fix all that in the v2.

Thanks.

-- 
Remi
