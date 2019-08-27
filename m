Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E75499E940
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 15:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfH0NZI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 09:25:08 -0400
Received: from foss.arm.com ([217.140.110.172]:44808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730076AbfH0NZI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 09:25:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B8FE28;
        Tue, 27 Aug 2019 06:25:07 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA87A3F246;
        Tue, 27 Aug 2019 06:25:06 -0700 (PDT)
Date:   Tue, 27 Aug 2019 14:25:05 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.co" <lorenzo.pieralisi@arm.co>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 07/10] PCI: layerscape: Modify the MSIX to the
 doorbell way
Message-ID: <20190827132504.GL14582@e119886-lin.cambridge.arm.com>
References: <20190822112242.16309-1-xiaowei.bao@nxp.com>
 <20190822112242.16309-7-xiaowei.bao@nxp.com>
 <20190823135816.GH14582@e119886-lin.cambridge.arm.com>
 <AM5PR04MB3299E50BA5D7579D41B8B4F9F5A70@AM5PR04MB3299.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM5PR04MB3299E50BA5D7579D41B8B4F9F5A70@AM5PR04MB3299.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 24, 2019 at 12:08:40AM +0000, Xiaowei Bao wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Murray <andrew.murray@arm.com>
> > Sent: 2019年8月23日 21:58
> > To: Xiaowei Bao <xiaowei.bao@nxp.com>
> > Cc: bhelgaas@google.com; robh+dt@kernel.org; mark.rutland@arm.com;
> > shawnguo@kernel.org; Leo Li <leoyang.li@nxp.com>; kishon@ti.com;
> > lorenzo.pieralisi@arm.co; arnd@arndb.de; gregkh@linuxfoundation.org; M.h.
> > Lian <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; Roy
> > Zang <roy.zang@nxp.com>; jingoohan1@gmail.com;
> > gustavo.pimentel@synopsys.com; linux-pci@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH v2 07/10] PCI: layerscape: Modify the MSIX to the
> > doorbell way
> > 
> > On Thu, Aug 22, 2019 at 07:22:39PM +0800, Xiaowei Bao wrote:
> > > The layerscape platform use the doorbell way to trigger MSIX interrupt
> > > in EP mode.
> > >
> > 
> > I have no problems with this patch, however...
> > 
> > Are you able to add to this message a reason for why you are making this
> > change? Did dw_pcie_ep_raise_msix_irq not work when func_no != 0? Or did
> > it work yet dw_pcie_ep_raise_msix_irq_doorbell is more efficient?
> 
> The fact is that, this driver is verified in ls1046a platform of NXP before, and ls1046a don't
> support MSIX feature, so I set the msix_capable of pci_epc_features struct is false,
> but in other platform, e.g. ls1088a, it support the MSIX feature, I verified the MSIX
> feature in ls1088a, it is not OK, so I changed to another way. Thanks.

Right, so the existing pci-layerscape-ep.c driver never supported MSIX yet it
erroneously had a switch case statement to call dw_pcie_ep_raise_msix_irq which
would never get used.

Now that we're adding a platform with MSIX support the existing
dw_pcie_ep_raise_msix_irq doesn't work (for this platform) so we are adding a
different method.

Given that dw_pcie_ep_raise_msix_irq is used by pcie-designware-plat.c we
can assume this function at least works for it's use case.

Please update the commit message - It would be helpful to suggest that
dw_pcie_ep_raise_msix_irq was never called in the exisitng driver because
msix_capable was always set to false.

Thanks,

Andrew Murray

> 
> > 
> > Thanks,
> > 
> > Andrew Murray
> > 
> > > Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> > > ---
> > > v2:
> > >  - No change.
> > >
> > >  drivers/pci/controller/dwc/pci-layerscape-ep.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > > b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > > index 8461f62..7ca5fe8 100644
> > > --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > > +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > > @@ -74,7 +74,8 @@ static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep,
> > u8 func_no,
> > >  	case PCI_EPC_IRQ_MSI:
> > >  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > >  	case PCI_EPC_IRQ_MSIX:
> > > -		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> > > +		return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no,
> > > +							  interrupt_num);
> > >  	default:
> > >  		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> > >  		return -EINVAL;
> > > --
> > > 2.9.5
> > >
