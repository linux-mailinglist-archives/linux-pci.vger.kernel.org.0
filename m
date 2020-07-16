Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1214D2224DB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 16:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgGPOH0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 10:07:26 -0400
Received: from foss.arm.com ([217.140.110.172]:54064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgGPOH0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jul 2020 10:07:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE22031B;
        Thu, 16 Jul 2020 07:07:25 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4AEE3F66E;
        Thu, 16 Jul 2020 07:07:24 -0700 (PDT)
Date:   Thu, 16 Jul 2020 15:07:13 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: tegra: Remove PLL power supplies
Message-ID: <20200716140704.GA20249@e121166-lin.cambridge.arm.com>
References: <20200623145528.1658337-1-thierry.reding@gmail.com>
 <20200623145528.1658337-2-thierry.reding@gmail.com>
 <20200716130034.GE535268@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716130034.GE535268@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 16, 2020 at 03:00:34PM +0200, Thierry Reding wrote:
> On Tue, Jun 23, 2020 at 04:55:28PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The Tegra PCI controller driver doesn't need to control the PLL power
> > supplies directly, but rather uses the pads provided by the XUSB pad
> > controller, which in turn is responsible for supplying power to the
> > PLLs.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/pci/controller/pci-tegra.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> Hi Lorenzo,
> 
> do you have any comments on this? Can we get this into v5.9?

Yes we can if Rob is happy with patch (1).

Thanks,
Lorenzo

> Thanks,
> Thierry
> 
> > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> > index 235b456698fc..f87a09d21eb0 100644
> > --- a/drivers/pci/controller/pci-tegra.c
> > +++ b/drivers/pci/controller/pci-tegra.c
> > @@ -2025,7 +2025,7 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
> >  		pcie->supplies[i++].supply = "hvdd-pex";
> >  		pcie->supplies[i++].supply = "vddio-pexctl-aud";
> >  	} else if (of_device_is_compatible(np, "nvidia,tegra210-pcie")) {
> > -		pcie->num_supplies = 6;
> > +		pcie->num_supplies = 3;
> >  
> >  		pcie->supplies = devm_kcalloc(pcie->dev, pcie->num_supplies,
> >  					      sizeof(*pcie->supplies),
> > @@ -2033,14 +2033,11 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
> >  		if (!pcie->supplies)
> >  			return -ENOMEM;
> >  
> > -		pcie->supplies[i++].supply = "avdd-pll-uerefe";
> >  		pcie->supplies[i++].supply = "hvddio-pex";
> >  		pcie->supplies[i++].supply = "dvddio-pex";
> > -		pcie->supplies[i++].supply = "dvdd-pex-pll";
> > -		pcie->supplies[i++].supply = "hvdd-pex-pll-e";
> >  		pcie->supplies[i++].supply = "vddio-pex-ctl";
> >  	} else if (of_device_is_compatible(np, "nvidia,tegra124-pcie")) {
> > -		pcie->num_supplies = 7;
> > +		pcie->num_supplies = 4;
> >  
> >  		pcie->supplies = devm_kcalloc(dev, pcie->num_supplies,
> >  					      sizeof(*pcie->supplies),
> > @@ -2050,11 +2047,8 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
> >  
> >  		pcie->supplies[i++].supply = "avddio-pex";
> >  		pcie->supplies[i++].supply = "dvddio-pex";
> > -		pcie->supplies[i++].supply = "avdd-pex-pll";
> >  		pcie->supplies[i++].supply = "hvdd-pex";
> > -		pcie->supplies[i++].supply = "hvdd-pex-pll-e";
> >  		pcie->supplies[i++].supply = "vddio-pex-ctl";
> > -		pcie->supplies[i++].supply = "avdd-pll-erefe";
> >  	} else if (of_device_is_compatible(np, "nvidia,tegra30-pcie")) {
> >  		bool need_pexa = false, need_pexb = false;
> >  
> > -- 
> > 2.27.0
> > 


