Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7955C42703
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 15:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbfFLNIV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 09:08:21 -0400
Received: from foss.arm.com ([217.140.110.172]:53052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbfFLNIV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 09:08:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8F4528;
        Wed, 12 Jun 2019 06:08:20 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EF2E3F557;
        Wed, 12 Jun 2019 06:08:18 -0700 (PDT)
Date:   Wed, 12 Jun 2019 14:08:13 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv5 04/20] PCI: mobiveil: Remove the flag
 MSI_FLAG_MULTI_PCI_MSI
Message-ID: <20190612130813.GA15747@redmoon>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
 <20190412083635.33626-5-Zhiqiang.Hou@nxp.com>
 <20190611165935.GA22836@redmoon>
 <AM0PR04MB67383023B81AEB33DAF9C35584EC0@AM0PR04MB6738.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB67383023B81AEB33DAF9C35584EC0@AM0PR04MB6738.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 12, 2019 at 11:34:51AM +0000, Z.q. Hou wrote:
> Hi Lorenzo,
> 
> Thanks a lot for your comments!
> 
> > -----Original Message-----
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Sent: 2019年6月12日 1:00
> > To: Z.q. Hou <zhiqiang.hou@nxp.com>
> > Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > bhelgaas@google.com; robh+dt@kernel.org; mark.rutland@arm.com;
> > l.subrahmanya@mobiveil.co.in; shawnguo@kernel.org; Leo Li
> > <leoyang.li@nxp.com>; catalin.marinas@arm.com; will.deacon@arm.com;
> > Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>;
> > Xiaowei Bao <xiaowei.bao@nxp.com>
> > Subject: Re: [PATCHv5 04/20] PCI: mobiveil: Remove the flag
> > MSI_FLAG_MULTI_PCI_MSI
> > 
> > On Fri, Apr 12, 2019 at 08:35:36AM +0000, Z.q. Hou wrote:
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >
> > > The current code does not support multiple MSIs, so remove the
> > > corresponding flag from the msi_domain_info structure.
> > 
> > Please explain me what's the problem before removing multi MSI support.
> 
> NXP LX2 PCIe use the GIC-ITS instead of Mobiveil IP internal MSI
> controller, so, I didn't encounter problem.

Well, you sent a patch to fix an issue, explain me the issue you
are fixing then, aka what have you sent this patch for ?

Lorenzo

> Subbu, did you test with Endpoint supporting multi MSI?
> 
> Thanks,
> Zhiqiang
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> > > Fixes: 1e913e58335f ("PCI: mobiveil: Add MSI support")
> > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> > > ---
> > > V5:
> > >  - Corrected the subject.
> > >
> > >  drivers/pci/controller/pcie-mobiveil.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-mobiveil.c
> > > b/drivers/pci/controller/pcie-mobiveil.c
> > > index 563210e731d3..a0dd337c6214 100644
> > > --- a/drivers/pci/controller/pcie-mobiveil.c
> > > +++ b/drivers/pci/controller/pcie-mobiveil.c
> > > @@ -703,7 +703,7 @@ static struct irq_chip mobiveil_msi_irq_chip = {
> > >
> > >  static struct msi_domain_info mobiveil_msi_domain_info = {
> > >  	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS |
> > MSI_FLAG_USE_DEF_CHIP_OPS |
> > > -		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
> > > +		   MSI_FLAG_PCI_MSIX),
> > >  	.chip	= &mobiveil_msi_irq_chip,
> > >  };
> > >
> > > --
> > > 2.17.1
> > >
