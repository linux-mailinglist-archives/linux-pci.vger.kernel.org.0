Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2ED18FB5B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Mar 2020 18:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgCWRWC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 13:22:02 -0400
Received: from foss.arm.com ([217.140.110.172]:52460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbgCWRWB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 13:22:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED1911FB;
        Mon, 23 Mar 2020 10:22:00 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBBEC3F7C3;
        Mon, 23 Mar 2020 10:21:59 -0700 (PDT)
Date:   Mon, 23 Mar 2020 17:21:49 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Print -EPROBE_DEFER error message at debug
 level
Message-ID: <20200323172137.GA17018@e121166-lin.cambridge.arm.com>
References: <20200319131230.3216305-1-thierry.reding@gmail.com>
 <20200319180529.GB7433@e121166-lin.cambridge.arm.com>
 <20200323133456.GG3883508@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323133456.GG3883508@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 23, 2020 at 02:34:56PM +0100, Thierry Reding wrote:
> On Thu, Mar 19, 2020 at 06:05:30PM +0000, Lorenzo Pieralisi wrote:
> > On Thu, Mar 19, 2020 at 02:12:30PM +0100, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > > 
> > > Probe deferral is an expected error condition that will usually be
> > > recovered from. Print such error messages at debug level to make them
> > > available for diagnostic purposes when building with debugging enabled
> > > and hide them otherwise to not spam the kernel log with them.
> > > 
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-tegra194.c | 42 ++++++++++++++++++----
> > >  1 file changed, 35 insertions(+), 7 deletions(-)
> > 
> > Hi Thierry,
> > 
> > what tree/branch is it based on ? I assume it may depend on some
> > patches queued in one of my branches so please let me know and
> > I will apply accordingly.
> 
> Hi Lorenzo,
> 
> This should apply on top of commit 5b645b7fade9 ("PCI: tegra: Add
> support for PCIe endpoint mode in Tegra194") which is currently in
> linux-next.
> 
> Looking at your "pci" tree, that commit seems to be in a branch
> called pci/endpoint, though the equivalent commit there has a slightly
> different SHA:
> 
>     f4746b0ccef9 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> 
> git range-diff shows that the only difference is that in the patch in
> linux-next there are a couple of additional exported symbols that are
> not in your pci/endpoint branch. That shouldn't be relevant, though,
> since this patch touches another area of the code, so applying this to
> your pci/endpoint branch should work.

Applied to pci/endpoint, thanks !

Lorenzo

> Thierry
> 
> > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > index 97d3f3db1020..e4870fa6ce9c 100644
> > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > @@ -1159,17 +1159,31 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
> > >  	/* Endpoint mode specific DT entries */
> > >  	pcie->pex_rst_gpiod = devm_gpiod_get(pcie->dev, "reset", GPIOD_IN);
> > >  	if (IS_ERR(pcie->pex_rst_gpiod)) {
> > > -		dev_err(pcie->dev, "Failed to get PERST GPIO: %ld\n",
> > > -			PTR_ERR(pcie->pex_rst_gpiod));
> > > -		return PTR_ERR(pcie->pex_rst_gpiod);
> > > +		int err = PTR_ERR(pcie->pex_rst_gpiod);
> > > +		const char *level = KERN_ERR;
> > > +
> > > +		if (err == -EPROBE_DEFER)
> > > +			level = KERN_DEBUG;
> > > +
> > > +		dev_printk(level, pcie->dev,
> > > +			   dev_fmt("Failed to get PERST GPIO: %d\n"),
> > > +			   err);
> > > +		return err;
> > >  	}
> > >  
> > >  	pcie->pex_refclk_sel_gpiod = devm_gpiod_get(pcie->dev,
> > >  						    "nvidia,refclk-select",
> > >  						    GPIOD_OUT_HIGH);
> > >  	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
> > > -		dev_info(pcie->dev, "Failed to get REFCLK select GPIOs: %ld\n",
> > > -			 PTR_ERR(pcie->pex_refclk_sel_gpiod));
> > > +		int err = PTR_ERR(pcie->pex_refclk_sel_gpiod);
> > > +		const char *level = KERN_ERR;
> > > +
> > > +		if (err == -EPROBE_DEFER)
> > > +			level = KERN_DEBUG;
> > > +
> > > +		dev_printk(level, pcie->dev,
> > > +			   dev_fmt("Failed to get REFCLK select GPIOs: %d\n"),
> > > +			   err);
> > >  		pcie->pex_refclk_sel_gpiod = NULL;
> > >  	}
> > >  
> > > @@ -2058,13 +2072,27 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
> > >  
> > >  	ret = tegra_pcie_dw_parse_dt(pcie);
> > >  	if (ret < 0) {
> > > -		dev_err(dev, "Failed to parse device tree: %d\n", ret);
> > > +		const char *level = KERN_ERR;
> > > +
> > > +		if (ret == -EPROBE_DEFER)
> > > +			level = KERN_DEBUG;
> > > +
> > > +		dev_printk(level, dev,
> > > +			   dev_fmt("Failed to parse device tree: %d\n"),
> > > +			   ret);
> > >  		return ret;
> > >  	}
> > >  
> > >  	ret = tegra_pcie_get_slot_regulators(pcie);
> > >  	if (ret < 0) {
> > > -		dev_err(dev, "Failed to get slot regulators: %d\n", ret);
> > > +		const char *level = KERN_ERR;
> > > +
> > > +		if (ret == -EPROBE_DEFER)
> > > +			level = KERN_DEBUG;
> > > +
> > > +		dev_printk(level, dev,
> > > +			   dev_fmt("Failed to get slot regulators: %d\n"),
> > > +			   ret);
> > >  		return ret;
> > >  	}
> > >  
> > > -- 
> > > 2.24.1
> > > 


