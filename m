Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D739143AD5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389323AbfFMPYI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:24:08 -0400
Received: from foss.arm.com ([217.140.110.172]:42462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389298AbfFMPYI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 11:24:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E47D03EF;
        Thu, 13 Jun 2019 08:24:07 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90FD23F718;
        Thu, 13 Jun 2019 08:24:06 -0700 (PDT)
Date:   Thu, 13 Jun 2019 16:24:04 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V4 27/28] PCI: tegra: Add support for GPIO based PERST#
Message-ID: <20190613152404.GB30445@e121166-lin.cambridge.arm.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516055307.25737-28-mmaddireddy@nvidia.com>
 <20190604132233.GT16519@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604132233.GT16519@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 04, 2019 at 03:22:33PM +0200, Thierry Reding wrote:

[...]

> > +	} else {
> > +		value = afi_readl(port->pcie, ctrl);
> > +		value &= ~AFI_PEX_CTRL_RST;
> > +		afi_writel(port->pcie, value, ctrl);
> > +	}
> >  
> >  	usleep_range(1000, 2000);
> >  
> > -	value = afi_readl(port->pcie, ctrl);
> > -	value |= AFI_PEX_CTRL_RST;
> > -	afi_writel(port->pcie, value, ctrl);
> > +	if (port->reset_gpiod) {
> > +		gpiod_set_value(port->reset_gpiod, 1);
> 
> After this the port should be functional, right? I think it'd be better
> to reverse the logic here and move the polarity of the GPIO into device
> tree. gpiod_set_value() takes care of inverting the level internally if
> the GPIO is marked as low-active in DT.
> 
> The end result is obviously the same, but it makes the usage much
> clearer. If somebody want to write a DT for their board, they will look
> at the schematics and see a low-active reset line and may be tempted to
> describe it as such in DT, but with your current code that would be
> exactly the wrong way around.

I agree with Thierry here, you should change the logic.

Question: what's the advantage of adding GPIO reset support if that's
architected already in port registers ? I am pretty sure there is a
reason behind it (and forgive me the dumb question) and I would like to
have it written in the commit log.

Thanks,
Lorenzo

> > +	} else {
> > +		value = afi_readl(port->pcie, ctrl);
> > +		value |= AFI_PEX_CTRL_RST;
> > +		afi_writel(port->pcie, value, ctrl);
> > +	}
> >  }
> >  
> >  static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
> > @@ -2238,6 +2249,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
> >  		struct tegra_pcie_port *rp;
> >  		unsigned int index;
> >  		u32 value;
> > +		char *label;
> >  
> >  		err = of_pci_get_devfn(port);
> >  		if (err < 0) {
> > @@ -2296,6 +2308,23 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
> >  		if (IS_ERR(rp->base))
> >  			return PTR_ERR(rp->base);
> >  
> > +		label = kasprintf(GFP_KERNEL, "pex-reset-%u", index);
> 
> devm_kasprintf()?
> 
> Thierry
> 
> > +		if (!label) {
> > +			dev_err(dev, "failed to create reset GPIO label\n");
> > +			return -ENOMEM;
> > +		}
> > +
> > +		rp->reset_gpiod = devm_gpiod_get_from_of_node(dev, port,
> > +							      "reset-gpios", 0,
> > +							      GPIOD_OUT_LOW,
> > +							      label);
> > +		kfree(label);
> > +		if (IS_ERR(rp->reset_gpiod)) {
> > +			err = PTR_ERR(rp->reset_gpiod);
> > +			dev_err(dev, "failed to get reset GPIO: %d\n", err);
> > +			return err;
> > +		}
> > +
> >  		list_add_tail(&rp->list, &pcie->ports);
> >  	}
> >  
> > -- 
> > 2.17.1
> > 


