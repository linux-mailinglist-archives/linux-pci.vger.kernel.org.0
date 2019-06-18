Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 527F44A25A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 15:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfFRNgA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 09:36:00 -0400
Received: from foss.arm.com ([217.140.110.172]:41510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfFRNgA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Jun 2019 09:36:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C2E42B;
        Tue, 18 Jun 2019 06:35:59 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAA443F718;
        Tue, 18 Jun 2019 06:35:57 -0700 (PDT)
Date:   Tue, 18 Jun 2019 14:35:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, thierry.reding@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V5 20/27] PCI: tegra: Use legacy IRQ for port service
 drivers
Message-ID: <20190618133555.GB9002@e121166-lin.cambridge.arm.com>
References: <20190617173952.29363-1-mmaddireddy@nvidia.com>
 <20190617173952.29363-21-mmaddireddy@nvidia.com>
 <8a8746f8-3e0f-c724-761e-8bc47b2cc3b6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a8746f8-3e0f-c724-761e-8bc47b2cc3b6@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 11:17:49AM +0530, Manikanta Maddireddy wrote:
> 
> 
> On 17-Jun-19 11:09 PM, Manikanta Maddireddy wrote:
> > Tegra signals PCIe services like AER, PME, etc. over legacy IRQ line.
> > By default, service drivers register interrupt routine over MSI IRQ line.
> > Use pcie_pme_disable_msi() function to disable MSI for service drivers.
> >
> > PME and AER interrupts registered to MSI without this change,
> > cat /proc/interrupts | grep -i pci
> > 36: 21 0 0 0 0 0 GICv2 104 Level       PCIE
> > 37: 35 0 0 0 0 0 GICv2 105 Level       Tegra PCIe MSI
> > 76: 0  0 0 0 0 0 Tegra PCIe MSI 0 Edge PCIe PME, aerdrv, PCIe BW notif
> >
> > PME and AER interrupts registered to legacy IRQ with this change,
> > cat /proc/interrupts | grep -i pci
> > 36: 33 0 0 0 0 0 GICv2 104 Level      PCIE, PCIe PME, aerdrv, PCIe BW notif
> > 37: 52 0 0 0 0 0 GICv2 105 Level      Tegra PCIe MSI
> >
> > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > Acked-by: Thierry Reding <treding@nvidia.com>
> > ---
> > V5: No change
> >
> > V4: No change
> >
> > V3: Corrected typo in commit log
> >
> > V2: No change
> >
> >  drivers/pci/controller/pci-tegra.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> > index 73d5a8841405..9429c0c6a1f3 100644
> > --- a/drivers/pci/controller/pci-tegra.c
> > +++ b/drivers/pci/controller/pci-tegra.c
> > @@ -41,6 +41,7 @@
> >  #include <soc/tegra/pmc.h>
> >  
> >  #include "../pci.h"
> > +#include "../pcie/portdrv.h"
> >  
> >  #define INT_PCI_MSI_NR (8 * 32)
> >  
> > @@ -2725,6 +2726,9 @@ static int tegra_pcie_probe(struct platform_device *pdev)
> >  		goto put_resources;
> >  	}
> >  
> > +	/* Switch to legacy IRQ for PCIe services like AER, PME*/
> > +	pcie_pme_disable_msi();
> > +
> >  	pm_runtime_enable(pcie->dev);
> >  	err = pm_runtime_get_sync(pcie->dev);
> >  	if (err) {
> 
> Hi Lorenzo,
> 
> I forgot to address Bjorn's comment here, I will correct this in V6.
> Let me know if I can publish it today or you want me to wait until
> you look into other patches.

It should be fine to post v6 but please pay attention next time, it has
been a while since this patch should have been updated.

Lorenzo
