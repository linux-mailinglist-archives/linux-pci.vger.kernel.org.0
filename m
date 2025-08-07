Return-Path: <linux-pci+bounces-33532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA75EB1D44B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 10:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873573A195E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 08:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FC11F09A8;
	Thu,  7 Aug 2025 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhyU4wYw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5244A18FC92;
	Thu,  7 Aug 2025 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754555642; cv=none; b=tc52qqP+1taLxuOgMB5HgrdJcnzy9sij//2C9rTqPivCT8Pe8N5qTXqtj8txTbSxrjgzx59NisD17bDSP0kjjcXooWq2q9wZpfygT1E5JhrbYNQtfsAPb+Xll2oWF0JK5JN0Z9FKEvaY+1QziE23nzq3osAEYjXzTGIWwTAsaUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754555642; c=relaxed/simple;
	bh=m8Wmo3xaDB+aWRD2CluuYq5IQa40NOivyY3r5ZFPsjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di72ChN9HitlrZtbEuVxmwaQgEJvZyjGmPXGQayBLT5aJ/Kg+bWKdPPU9A28N5y/ZICfv5Yx/7lb5yYCX8qMGW4jlC8Bbq1DPv01kZrxzJICl5Bk6D+CV413UX5sXtJbqENH5o7Ux8lHiy3o1ukAzrS1Ic5qP73B3gGfnN2DQk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhyU4wYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5544BC4CEEB;
	Thu,  7 Aug 2025 08:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754555641;
	bh=m8Wmo3xaDB+aWRD2CluuYq5IQa40NOivyY3r5ZFPsjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhyU4wYwRUAUWRwCWl4V6zMGJIaZnRU4rDCuwxJBjCDPT6aDRbAxlWNfh+/ni239U
	 61FBKFBVlPBbPvSNrfw7fFGN7qiOTriuIwx2PRy17SkGhSAhflhXthnLuaqM02JWw8
	 rqHPgg2x66lfuCqfk+8+/aGIQTVdzbkhP8gghU+t9w6wJopyHKXfmza1i3fi+Ivotv
	 AE+UqBvdFAGaw77+KOa4aCZzpY/dkllaRdD51UYCQLBtuubXgGmt+2vzXqAC8e3Czb
	 W0HOT9ZnZGQ/ue8iAiBLnB/EOOf9rpoweK2q1BNuSbc6Vrx4ACoEWf3cjsBO1oJHsO
	 ccDigjrF6uRtg==
Date: Thu, 7 Aug 2025 14:03:53 +0530
From: "mani@kernel.org" <mani@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Hans Zhang <hans.zhang@cixtech.com>, Frank Li <frank.li@nxp.com>, 
	"Z.Q. Hou" <zhiqiang.hou@nxp.com>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>, "Jonthan.Cameron@huawei.com" <Jonthan.Cameron@huawei.com>, 
	"lukas@wunner.de" <lukas@wunner.de>, "feng.tang@linux.alibaba.com" <feng.tang@linux.alibaba.com>, 
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v1 2/2] PCI: dwc: Fetch dedicated AER/PME interrupters
Message-ID: <pxes6n4nja4v2yfrr335b6ynggwbz3n6t5cgjx26462thefr64@po4bdjwp43h3>
References: <20250807070917.2245463-1-hongxing.zhu@nxp.com>
 <20250807070917.2245463-3-hongxing.zhu@nxp.com>
 <b721ecf5-5da6-4ab1-b352-b7ce19d1b13a@cixtech.com>
 <AS8PR04MB88331790CE4783BC0856A82A8C2CA@AS8PR04MB8833.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB88331790CE4783BC0856A82A8C2CA@AS8PR04MB8833.eurprd04.prod.outlook.com>

On Thu, Aug 07, 2025 at 07:38:06AM GMT, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Hans Zhang <hans.zhang@cixtech.com>
> > Sent: 2025年8月7日 15:21
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; Frank Li <frank.li@nxp.com>;
> > Z.Q. Hou <zhiqiang.hou@nxp.com>; bhelgaas@google.com;
> > ilpo.jarvinen@linux.intel.com; Jonthan.Cameron@huawei.com;
> > lukas@wunner.de; feng.tang@linux.alibaba.com; jingoohan1@gmail.com;
> > mani@kernel.org; lpieralisi@kernel.org; kwilczynski@kernel.org;
> > robh@kernel.org
> > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > imx@lists.linux.dev
> > Subject: Re: [PATCH v1 2/2] PCI: dwc: Fetch dedicated AER/PME interrupters
> > 
> > 
> > 
> > On 2025/8/7 15:09, Richard Zhu wrote:
> > > EXTERNAL EMAIL
> > >
> > > Some PCI host bridges have limitation that AER/PME can't work over MSI.
> > > Vendors route the AER/PME via the dedicated SPI interrupter which is
> > > only handled by the controller driver.
> > >
> > > Because that aer and pme had been defined in the snps,dw-pcie.yaml
> > > document. Fetch the vendor specific AER/PME interrupters if they are
> > > defined in the fdt file by generic bridge->get_service_irqs hook.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >   .../pci/controller/dwc/pcie-designware-host.c | 32
> > +++++++++++++++++++
> > >   1 file changed, 32 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 906277f9ffaf7..9393dc99df81f 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -13,11 +13,13 @@
> > >   #include <linux/irqdomain.h>
> > >   #include <linux/msi.h>
> > >   #include <linux/of_address.h>
> > > +#include <linux/of_irq.h>
> > >   #include <linux/of_pci.h>
> > >   #include <linux/pci_regs.h>
> > >   #include <linux/platform_device.h>
> > >
> > >   #include "../../pci.h"
> > > +#include "../../pcie/portdrv.h"
> > >   #include "pcie-designware.h"
> > >
> > >   static struct pci_ops dw_pcie_ops;
> > > @@ -461,6 +463,35 @@ static int dw_pcie_host_get_resources(struct
> > dw_pcie_rp *pp)
> > >          return 0;
> > >   }
> > >
> > > +static int dw_pcie_get_service_irqs(struct pci_host_bridge *bridge,
> > > +                                   int *irqs, int mask) {
> > > +       struct device *dev = bridge->dev.parent;
> > > +       struct device_node *np = dev->of_node;
> > > +       int ret, count = 0;
> > > +
> > > +       if (!np)
> > > +               return 0;
> > > +
> > > +       if (mask & PCIE_PORT_SERVICE_AER) {
> > > +               ret = of_irq_get_byname(np, "aer");
> > > +               if (ret > 0) {
> > > +                       irqs[PCIE_PORT_SERVICE_AER_SHIFT] = ret;
> > > +                       count++;
> > > +               }
> > > +       }
> > > +
> > > +       if (mask & PCIE_PORT_SERVICE_PME) {
> > > +               ret = of_irq_get_byname(np, "pme");
> > > +               if (ret > 0) {
> > > +                       irqs[PCIE_PORT_SERVICE_PME_SHIFT] = ret;
> > > +                       count++;
> > > +               }
> > > +       }
> > > +
> > 
> > Hi Richard,
> > 
> > As far as I know, some SoCs directly use the misc SPI interrupt derived from
> > Synopsys PCIe IP. This includes PME, AER and other interrupts. So here, can
> > we assign the interrupt number ourselves?
> >
> [Richard Zhu] Yes, they can be assigned by vendor themselves. The
>  different PME, AER or other interrupts can be defined in the chip
>  specific dts files.
> > Also, whether to trigger the AER/PME interrupt in a similar way.
> > (generic_handle_domain_irq)
> [Richard Zhu] This patch-set is just fetch the dedicated AER/PME
> interrupt for portdrv in none MSI/MSI-x/INTx mode. The trigger of
>  AER/PME would be handled in portdrv.
> > Because there may be a misc SPI interrupt that requires a clear related state,
> > what is referred to here is not the AER/PME state.
> [Richard Zhu]How about to do the other misc SPI interrupts related state
>  clear in vendor local driver?
> 

I'd expect the controller drivers to call the relevant part of the AER/PME
handlers from their own platform IRQ handler. This will work for platforms using
the shared IRQ line, and platforms requiring clearing custom bits in their own
register space before handling the interrupts.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

