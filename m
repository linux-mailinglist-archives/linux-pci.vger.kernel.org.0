Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD1D0D6644
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 17:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfJNPjX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 11:39:23 -0400
Received: from foss.arm.com ([217.140.110.172]:47186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730005AbfJNPjX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Oct 2019 11:39:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7942B28;
        Mon, 14 Oct 2019 08:39:22 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 761AF3F68E;
        Mon, 14 Oct 2019 08:39:21 -0700 (PDT)
Date:   Mon, 14 Oct 2019 16:39:19 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Remi Pommarel <repk@triplefau.lt>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ellie Reeves <ellierevves@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: aardvark: Wait for endpoint to be ready before
 training link
Message-ID: <20191014153919.GB2928@e121166-lin.cambridge.arm.com>
References: <20190522213351.21366-2-repk@triplefau.lt>
 <20190806184945.GU12859@voidbox.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806184945.GU12859@voidbox.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 06, 2019 at 08:49:46PM +0200, Remi Pommarel wrote:
> On Wed, May 22, 2019 at 11:33:50PM +0200, Remi Pommarel wrote:
> > When configuring pcie reset pin from gpio (e.g. initially set by
> > u-boot) to pcie function this pin goes low for a brief moment
> > asserting the PERST# signal. Thus connected device enters fundamental
> > reset process and link configuration can only begin after a minimal
> > 100ms delay (see [1]).
> > 
> > Because the pin configuration comes from the "default" pinctrl it is
> > implicitly configured before the probe callback is called:
> > 
> > driver_probe_device()
> >   really_probe()
> >     ...
> >     pinctrl_bind_pins() /* Here pin goes from gpio to PCIE reset
> >                            function and PERST# is asserted */
> >     ...
> >     drv->probe()
> > 
> > [1] "PCI Express Base Specification", REV. 4.0
> >     PCI Express, February 19 2014, 6.6.1 Conventional Reset
> > 
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> > ---
> > Changes since v1:
> >   - Add a comment about pinctrl implicit pin configuration
> >   - Use more legible msleep
> >   - Use PCI_PM_D3COLD_WAIT macro
> > 
> > Please note that I will unlikely be able to answer any comments from May
> > 24th to June 10th.
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 134e0306ff00..d998c2b9cd04 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -324,6 +324,14 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> >  	reg |= PIO_CTRL_ADDR_WIN_DISABLE;
> >  	advk_writel(pcie, reg, PIO_CTRL);
> >  
> > +	/*
> > +	 * PERST# signal could have been asserted by pinctrl subsystem before
> > +	 * probe() callback has been called, making the endpoint going into
> > +	 * fundamental reset. As required by PCI Express spec a delay for at
> > +	 * least 100ms after such a reset before link training is needed.
> > +	 */
> > +	msleep(PCI_PM_D3COLD_WAIT);
> > +
> >  	/* Start link training */
> >  	reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
> >  	reg |= PCIE_CORE_LINK_TRAINING;
> > -- 
> > 2.20.1
> 
> Gentle ping.

Thomas, sorry for the delay, unless you object I would merge this
patch, I need your ACK to proceed though.

Thanks,
Lorenzo
