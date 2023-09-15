Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701C27A2845
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 22:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbjIOUik (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 16:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbjIOUih (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 16:38:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14F8F3;
        Fri, 15 Sep 2023 13:38:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35890C433C7;
        Fri, 15 Sep 2023 20:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694810312;
        bh=6Q5uD+Zu8AqpFSr7DdUZmiNzQVx8ArnIRoKFeBRbrQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qQ2iyLjwa7dvCYxKHf2pb1xYmjUKk31qUJTGag1QN09CHOP4ctdyYN9gCl+v1QvYY
         niCKla3y+gP0W69WjI3Q/wYqj2nZFcltdDlDYPh+9Nf0uvN10a5CABsdORmk4IlC8q
         +wpFBM+txR2+IvVsJmH3R+AJZEu31glf4ve6NUCfJU8XjRdGegYxCSSseVCwyyFIH1
         DKkOkH7POk0SwA3MmpEDjqK5jQ9DxnPZ726i0FIlhn4B+w4stGpSNNz7OQ77Pd7Ukc
         OFIb2fbnQzLF42hmO+mSVQY4om9vb2b/ySY0eVIJ0/lkeR91SAHYSnZsjCA7Fizl7C
         2NuyeF9VrsGXw==
Date:   Fri, 15 Sep 2023 15:38:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v20 16/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Message-ID: <20230915203830.GA105215@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB534112A636FAFB61A4038337D8F6A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 15, 2023 at 09:37:15AM +0000, Yoshihiro Shimoda wrote:
> > From: Bjorn Helgaas, Sent: Friday, September 15, 2023 1:35 AM
> > On Fri, Aug 25, 2023 at 06:32:16PM +0900, Yoshihiro Shimoda wrote:
> > > Add R-Car Gen4 PCIe Host support. This controller is based on
> > > Synopsys DesignWare PCIe, but this controller has vendor-specific
> > > registers so that requires initialization code like mode setting
> > > and retraining and so on.
> > >
> > > To reduce code delta, adds some helper functions which are used by
> > > both the host driver and the endpoint driver (which is added
> > > immediately afterwards) into a separate file.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > ---
> > >  drivers/pci/controller/dwc/Kconfig            |  10 +
> > >  drivers/pci/controller/dwc/Makefile           |   2 +
> > >  .../controller/dwc/pcie-rcar-gen4-host-drv.c  | 135 +++++++++++
> > >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 227 ++++++++++++++++++
> > >  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  44 ++++
> > >  5 files changed, 418 insertions(+)
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host-drv.c
> > 
> > Is "pcie-rcar-gen4-host-drv.c" following some pattern?  I don't see
> > "-drv" in any nearby filenames.  Typical names are "-host.c" for host
> > driver and "-ep.c" for endpoint driver.
> 
> This is not following some pattern on pcie subsystem. But, some
> other subsystems have "*drv.c" filenames. Manivannan suggested the
> filenames to rename the module filenames [1].
>
> < Now >
> The source code filenames : pcie-rcar-gen4-{host,ep}-drv.c
> The module filenames : pcie-rcar-gen4-{host,ep}.ko
> 
> < Previous >
> The source code filenames : pcie-rcar-gen4-{host,ep}.c
> The module filenames : pcie-rcar-gen4-{host,ep}-drv.ko
> 
> [1]
> https://lore.kernel.org/linux-pci/20230724122820.GM6291@thinkpad/
> 
> I don't have a strong opinion on which filenames are good.

I have an opinion :)  I think splitting this up into four files is way
more complicated than it needs to be.  This is all for driving a
single piece of hardware, and I don't think there's enough benefit to
split it into separate files.

Most drivers, even those that support both host and endpoint mode, are
in a single file, e.g., pcie-artpec6.c, pci-imx6.c, pcie-keembay.c,
pcie-tegra194.c, pci-dra7xx.c, pci-keystone.c.

That makes the Makefile very simple and there's only one module name
to worry about.

> > > +	msleep(100);	/* pe_rst requires 100msec delay */
> > 
> > Can we include a spec reference for this delay?  Ideally this would be
> > a #define and likely shared across drivers.
> 
> I think so. Some other PCIe drivers also call "msleep(100)".
> So, I'll add a #define into drivers/pci/pci.h.

Yes.  I'm trying to move away from "msleep(100)" for everybody so we
can make sure all the drivers include the appropriate delays and
they're all based on the same reasoning.

> > > +#define PCIEDMAINTSTSEN		0x0314
> > > +#define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
> > 
> > These register offsets are hard to decode whenthey'reallruntogether.
> 
> Unfortunately, these registers' offset names are from the datasheet.
> Perhaps, adding full register names as comments like below are helpful:
> -----
> /* PCIe Interrupt Status 0 */
> +#define PCIEINTSTS0		0x0084
> 
> /* PCIe DMA Interrupt Status Enable */
> #define PCIEDMAINTSTSEN		0x0314
> #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)

It's good to use names from the datasheet.  The comments should be
enough.

Bjorn
