Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9ED48E9F6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 13:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbiANMew (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jan 2022 07:34:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50534 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiANMeu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jan 2022 07:34:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2565061F3C
        for <linux-pci@vger.kernel.org>; Fri, 14 Jan 2022 12:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C73C36AEA;
        Fri, 14 Jan 2022 12:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642163689;
        bh=Wfem4QUjP1Tpgo+k+PagPUjfeICdbo0mZko6z7LoTjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ml7Y4OYxDRhYuXmMcW4glxKyzyOMyZ0UAnmV+Jk0fdCfzPxtvNJR+Ewd69QQEHd2G
         HCju5oYmQLo9OIrPPl4xACuS4DK5lVm2a/cSsl8WvVNPTzbIuDwcAwDaM9T7KpK3Ac
         zydM4bVTrdSybTUxbj/17eqGDLcaJW9k0pYLFOZRv6163hkSbnILRWwTxkabQrk8EC
         46IDSd+OFX19fe8KbQBxEwKNF/oukbZs6ZxMmqFGsrObaXv/LyqQxAuWvqHwPa73nt
         GHecNmgZjZ6Fbl6Ht5AsAAm6lt2HSwMTmm9ouWjVf+JAwv4XzBHVLMP02xbl5e0M8Q
         TYboA3MG2zalw==
Received: by pali.im (Postfix)
        id A27637D1; Fri, 14 Jan 2022 13:34:46 +0100 (CET)
Date:   Fri, 14 Jan 2022 13:34:46 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v4 2/2] PCI: xilinx-nwl: Add method to
 init_platform_service_irqs hook
Message-ID: <20220114123446.f2boleizo4yex7ow@pali>
References: <20220114075834.1938409-1-sr@denx.de>
 <20220114075834.1938409-3-sr@denx.de>
 <20220114114836.o5pjxsp6rjdemavr@pali>
 <22b93b6c-5942-6d60-dc41-0efba27910f6@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22b93b6c-5942-6d60-dc41-0efba27910f6@denx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 14 January 2022 13:13:16 Stefan Roese wrote:
> On 1/14/22 12:48, Pali Rohár wrote:
> > On Friday 14 January 2022 08:58:34 Stefan Roese wrote:
> > > From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > > 
> > > Add nwl_init_platform_service_irqs() hook to init_platform_service_irqs
> > > to register the platform-specific Service Errors IRQs for this PCIe
> > > controller to fully support e.g. AER on this platform.
> > > 
> > > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > > Signed-off-by: Stefan Roese <sr@denx.de>
> > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > Cc: Pali Rohár <pali@kernel.org>
> > > Cc: Michal Simek <michal.simek@xilinx.com>
> > 
> > Reviewed-by: Pali Rohár <pali@kernel.org>
> > 
> > > ---
> > >   drivers/pci/controller/pcie-xilinx-nwl.c | 18 ++++++++++++++++++
> > >   1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> > > index 414b679175b3..540536bbe3f8 100644
> > > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > > @@ -24,6 +24,7 @@
> > >   #include <linux/irqchip/chained_irq.h>
> > >   #include "../pci.h"
> > > +#include "../pcie/portdrv.h"
> > >   /* Bridge core config registers */
> > >   #define BRCFG_PCIE_RX0			0x00000000
> > > @@ -806,6 +807,22 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
> > >   	return 0;
> > >   }
> > > +static int nwl_init_platform_service_irqs(struct pci_dev *dev, int *irqs,
> > > +					  int plat_mask)
> > > +{
> > > +	struct pci_host_bridge *bridge;
> > > +	struct nwl_pcie *pcie;
> > > +
> > > +	bridge = pci_find_host_bridge(dev->bus);
> > > +	pcie = pci_host_bridge_priv(bridge);
> > > +	if (plat_mask & PCIE_PORT_SERVICE_AER) {
> > > +		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pcie->irq_misc;
> > > +		return 0; /* platform-specific service IRQ installed */
> > > +	}
> > 
> > Just I want to be sure, with this change PME and HP interrupts are not
> > provided even when plat_mask argument contains them.
> 
> This function is only used for Root Ports.

Technically, also Root Ports can support hot plugging. But that it
probably not the case of your board if it has PCIe switch connected to
the Root Port which is not removable.

But hot plug interrupt can be optionally used also for signalling change
of Data Link Layer state. And this information can be useful also in
Root Port if to it is connected non-removable device.

So if init_platform_service_irqs callback explicitly do not specify PME
or HP interrupts for the Root Port then kernel would not load pme or
pciehp service for the Root Port.

This is note for me, that when I will go to use this callback in other
drivers, I need to check that I provide interrupts for all supported
services...

> E.g. HP at the downstream
> ports of the PCIe switch still works in our case, as here
> pcie_init_service_irqs() still gets called:
> 
> # cat /proc/interrupts | grep pci
>  44:          0          0          0          0     GICv2 150 Level
> nwl_pcie:misc, aerdrv
>  61:          2          0          0          0  nwl_pcie:msi 1064960 Edge
> pciehp
>  63:          0          0          0          0  nwl_pcie:msi 1081344 Edge
> pciehp
>  65:          4          0          0          0  nwl_pcie:msi 1097728 Edge
> pciehp

Yes, as PCIe switch is different device it should work fine.

> Thanks,
> Stefan
> 
> > > +
> > > +	return -ENODEV; /* platform-specific service IRQ not installed */
> > > +}
> > > +
> > >   static const struct of_device_id nwl_pcie_of_match[] = {
> > >   	{ .compatible = "xlnx,nwl-pcie-2.11", },
> > >   	{}
> > > @@ -857,6 +874,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
> > >   	bridge->sysdata = pcie;
> > >   	bridge->ops = &nwl_pcie_ops;
> > > +	bridge->init_platform_service_irqs = nwl_init_platform_service_irqs;
> > >   	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > >   		err = nwl_pcie_enable_msi(pcie);
> > > -- 
> > > 2.34.1
> > > 
> 
> Viele Grüße,
> Stefan Roese
> 
> -- 
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
