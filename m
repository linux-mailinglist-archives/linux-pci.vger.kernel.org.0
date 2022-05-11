Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30E152367E
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 17:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243896AbiEKPAy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 11:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245581AbiEKPAa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 11:00:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C02122241A;
        Wed, 11 May 2022 08:00:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15FE5ED1;
        Wed, 11 May 2022 08:00:11 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24F493F66F;
        Wed, 11 May 2022 08:00:09 -0700 (PDT)
Date:   Wed, 11 May 2022 16:00:05 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: Re: [PATCH v9 2/5] PCI: rockchip-dwc: Reset core at driver probe
Message-ID: <YnvPdSPUm85Bg9zE@lpieralisi>
References: <20220429123832.2376381-1-pgwipeout@gmail.com>
 <20220429123832.2376381-3-pgwipeout@gmail.com>
 <Ynu/D4hXTRVy9IBF@lpieralisi>
 <CAMdYzYqdDPUFPhAZqA71dLaf6rT9CwFqQ1dFMRbGpVMyzgT8bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYqdDPUFPhAZqA71dLaf6rT9CwFqQ1dFMRbGpVMyzgT8bg@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 11, 2022 at 10:26:20AM -0400, Peter Geis wrote:
> On Wed, May 11, 2022 at 9:50 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Fri, Apr 29, 2022 at 08:38:28AM -0400, Peter Geis wrote:
> > > The PCIe controller is in an unknown state at driver probe. This can
> > > lead to undesireable effects when the driver attempts to configure the
> > > controller.
> > >
> > > Prevent issues in the future by resetting the core during probe.
> > >
> > > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > > Tested-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 ++++++++-----------
> > >  1 file changed, 10 insertions(+), 13 deletions(-)
> >
> > I fear that the controller reset behaviour is bootloader/firmware
> > dependent.
> >
> > Are we sure we are not triggering any regressions by resetting the
> > controller in the middle of probe (aka is the driver implicitly
> > relying on existing behaviour on systems that are not the ones
> > you are testing on) ?
> >
> > Just asking, the rockchip maintainers should be able to answer this
> > question.
> 
> This is a new driver with no current users, this series enables the
> first user. It does not support ACPI nor any sort of handoff at this
> time.

Ok. I will take patches [1-3], dts changes will have to go via
platform trees, I hope that's fine.

Thanks,
Lorenzo

> > Thanks,
> > Lorenzo
> >
> > > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > index c9b341e55cbb..faedbd6ebc20 100644
> > > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > @@ -152,6 +152,11 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
> > >       if (IS_ERR(rockchip->rst_gpio))
> > >               return PTR_ERR(rockchip->rst_gpio);
> > >
> > > +     rockchip->rst = devm_reset_control_array_get_exclusive(&pdev->dev);
> > > +     if (IS_ERR(rockchip->rst))
> > > +             return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
> > > +                                  "failed to get reset lines\n");
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -182,18 +187,6 @@ static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
> > >       phy_power_off(rockchip->phy);
> > >  }
> > >
> > > -static int rockchip_pcie_reset_control_release(struct rockchip_pcie *rockchip)
> > > -{
> > > -     struct device *dev = rockchip->pci.dev;
> > > -
> > > -     rockchip->rst = devm_reset_control_array_get_exclusive(dev);
> > > -     if (IS_ERR(rockchip->rst))
> > > -             return dev_err_probe(dev, PTR_ERR(rockchip->rst),
> > > -                                  "failed to get reset lines\n");
> > > -
> > > -     return reset_control_deassert(rockchip->rst);
> > > -}
> > > -
> > >  static const struct dw_pcie_ops dw_pcie_ops = {
> > >       .link_up = rockchip_pcie_link_up,
> > >       .start_link = rockchip_pcie_start_link,
> > > @@ -222,6 +215,10 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> > >       if (ret)
> > >               return ret;
> > >
> > > +     ret = reset_control_assert(rockchip->rst);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > >       /* DON'T MOVE ME: must be enable before PHY init */
> > >       rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
> > >       if (IS_ERR(rockchip->vpcie3v3)) {
> > > @@ -241,7 +238,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> > >       if (ret)
> > >               goto disable_regulator;
> > >
> > > -     ret = rockchip_pcie_reset_control_release(rockchip);
> > > +     ret = reset_control_deassert(rockchip->rst);
> > >       if (ret)
> > >               goto deinit_phy;
> > >
> > > --
> > > 2.25.1
> > >
