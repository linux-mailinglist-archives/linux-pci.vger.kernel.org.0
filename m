Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 331D89FEA7
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 11:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfH1Jhe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 05:37:34 -0400
Received: from foss.arm.com ([217.140.110.172]:56340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbfH1Jhe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 05:37:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1004337;
        Wed, 28 Aug 2019 02:37:33 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CC133F59C;
        Wed, 28 Aug 2019 02:37:33 -0700 (PDT)
Date:   Wed, 28 Aug 2019 10:37:31 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, robh+dt@kernel.org, jonathanh@nvidia.com,
        kishon@ti.com, gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH 6/6] PCI: tegra: Add support to enable slot regulators
Message-ID: <20190828093731.GT14582@e119886-lin.cambridge.arm.com>
References: <20190826073143.4582-1-vidyas@nvidia.com>
 <20190826073143.4582-7-vidyas@nvidia.com>
 <20190827154725.GP14582@e119886-lin.cambridge.arm.com>
 <91f8914a-22a9-8b7c-bc00-c309a21d83db@nvidia.com>
 <20190827171333.GQ14582@e119886-lin.cambridge.arm.com>
 <20190828090757.GA2917@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828090757.GA2917@ulmo>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 11:07:57AM +0200, Thierry Reding wrote:
> On Tue, Aug 27, 2019 at 06:13:34PM +0100, Andrew Murray wrote:
> > On Tue, Aug 27, 2019 at 09:54:17PM +0530, Vidya Sagar wrote:
> > > On 8/27/2019 9:17 PM, Andrew Murray wrote:
> > > > On Mon, Aug 26, 2019 at 01:01:43PM +0530, Vidya Sagar wrote:
> > > > > Add support to get regulator information of 3.3V and 12V supplies of a PCIe
> > > > > slot from the respective controller's device-tree node and enable those
> > > > > supplies. This is required in platforms like p2972-0000 where the supplies
> > > > > to x16 slot owned by C5 controller need to be enabled before attempting to
> > > > > enumerate the devices.
> > > > > 
> > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > ---
> > > > >   drivers/pci/controller/dwc/pcie-tegra194.c | 65 ++++++++++++++++++++++
> > > > >   1 file changed, 65 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > > index 8a27b25893c9..97de2151a738 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > > @@ -278,6 +278,8 @@ struct tegra_pcie_dw {
> > > > >   	u32 aspm_l0s_enter_lat;
> > > > >   	struct regulator *pex_ctl_supply;
> > > > > +	struct regulator *slot_ctl_3v3;
> > > > > +	struct regulator *slot_ctl_12v;
> > > > >   	unsigned int phy_count;
> > > > >   	struct phy **phys;
> > > > > @@ -1047,6 +1049,59 @@ static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
> > > > >   	}
> > > > >   }
> > > > > +static void tegra_pcie_get_slot_regulators(struct tegra_pcie_dw *pcie)
> > > > > +{
> > > > > +	pcie->slot_ctl_3v3 = devm_regulator_get_optional(pcie->dev, "vpcie3v3");
> > > > > +	if (IS_ERR(pcie->slot_ctl_3v3))
> > > > > +		pcie->slot_ctl_3v3 = NULL;
> > > > > +
> > > > > +	pcie->slot_ctl_12v = devm_regulator_get_optional(pcie->dev, "vpcie12v");
> > > > > +	if (IS_ERR(pcie->slot_ctl_12v))
> > > > > +		pcie->slot_ctl_12v = NULL;
> > > > 
> > > > Do these need to take into consideration -EPROBE_DEFER?
> > > Since these are devm_* APIs, isn't it taken care of automatically?
> > 
> > devm_regulator_get_optional can still return -EPROBE_DEFER - for times when
> > "lookup could succeed in the future".
> > 
> > It's probably helpful here for your driver to distinguish between there not
> > being a regulator specified in the DT, and there being a regulator but there
> > is no device for it yet. For the latter case - your driver would probe but
> > nothing would enumerate.
> > 
> > See pcie-rockchip-host.c for an example of where this is handled.
> > 
> > Of course if, for whatever reason it is unlikely you'll ever get -EPROBE_DEFER
> > then maybe it's OK as it is.
> 
> Let's not assume that. We've just recently encountered a case where we
> did not handle -EPROBE_DEFER because we had assumed too much, and that
> turned into a bit of a hassle to fix.
> 
> Vidya, I think what Andrew is saying is that you need to propagate the
> -EPROBE_DEFER error to the caller (i.e. the ->probe() callback) so that
> the PCI controller driver can be properly added to the defer queue in
> case the regulator isn't ready yet.

Indeed.

> 
> I think what we want here is something like:
> 
> 	pcie->slot_ctl_3v3 = devm_regulator_get_optional(pcie->dev, "vpcie3v3");
> 	if (IS_ERR(pcie->slot_ctl_3v3)) {
> 		if (PTR_ERR(pcie->slot_ctl_3v3) != -ENODEV)
> 			return PTR_ERR(pcie->slot_ctl_3v3);
> 
> 		pcie->slot_ctl_3v3 = NULL;
> 	}
> 
> Andrew, I'm not sure the handling in rockchip_pcie_parse_host_dt() is
> correct. It singles out -EPROBE_DEFER, which I think is the wrong way
> around. We should be special-casing -ENODEV, because regulator_get()
> can return a wide array of error cases, not all of which we actually
> want to consider successes. For example we could be getting -ENOMEM,
> which, I would argue, is something that we should propagate.

Yes I completely agree, given that the regulator is optional: we only want
to proceed if we find the regulator or if a regulator wasn't specified in the
DT. We should fail upon any other error, in case a regulator was specified
but the error prevented it from being returned.

> I think
> it'd be very confusing to take that as meaning "optional regulator
> wasn't specified", because in that case the DTS file would've had the
> regulator hooked up (we have to assume that it is needed in that case)
> but we won't be enabling it, so it's unlikely that devices will
> enumerate.

Thanks,

Andrew Murray

> 
> Thierry


