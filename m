Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A6D232C75
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 09:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgG3HTr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 30 Jul 2020 03:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgG3HTq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2020 03:19:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52B6C061794
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2020 00:19:45 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k12qZ-0000ZT-AD; Thu, 30 Jul 2020 09:19:23 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k12qW-0003Ph-MV; Thu, 30 Jul 2020 09:19:20 +0200
Message-ID: <0b541063e66e29b1dd0dad70f77a18a8591f224b.camel@pengutronix.de>
Subject: Re: [PATCH V3 3/3] pci: imx: Select RESET_IMX7 by default
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>, Rob Herring <robh@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Date:   Thu, 30 Jul 2020 09:19:20 +0200
In-Reply-To: <DB3PR0402MB391605E5B4F5E03F1E27B67DF5710@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1595254921-26050-1-git-send-email-Anson.Huang@nxp.com>
         <1595254921-26050-3-git-send-email-Anson.Huang@nxp.com>
         <CAL_JsqLXGduym51-Ej8Td4yOyP-UfGP-WCh2xeP_V90Yabm4XA@mail.gmail.com>
         <0cdecff564215de6711ca04e063fa696a160fad9.camel@pengutronix.de>
         <DB3PR0402MB391605E5B4F5E03F1E27B67DF5710@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Anson,

On Thu, 2020-07-30 at 02:11 +0000, Anson Huang wrote:
> Hi, Philipp/Rob
> 
> > Subject: Re: [PATCH V3 3/3] pci: imx: Select RESET_IMX7 by default
> > 
> > On Wed, 2020-07-29 at 09:26 -0600, Rob Herring wrote:
> > > On Mon, Jul 20, 2020 at 8:26 AM Anson Huang <Anson.Huang@nxp.com>
> > wrote:
> > > > i.MX7 reset driver now supports module build and it is no longer
> > > > built in by default, so i.MX PCI driver needs to select it
> > > > explicitly due to it is NOT supporting loadable module currently.
> > > > 
> > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > ---
> > > > No change.
> > > > ---
> > > >  drivers/pci/controller/dwc/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/Kconfig
> > > > b/drivers/pci/controller/dwc/Kconfig
> > > > index 044a376..bcf63ce 100644
> > > > --- a/drivers/pci/controller/dwc/Kconfig
> > > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > > @@ -90,6 +90,7 @@ config PCI_EXYNOS
> > > > 
> > > >  config PCI_IMX6
> > > >         bool "Freescale i.MX6/7/8 PCIe controller"
> > > > +       select RESET_IMX7
> > > 
> > > This will break as select will not cause all of RESET_IMX7's
> > > dependencies to be met. It also doesn't scale. Are you going to do the
> > > same thing for clocks, pinctrl, gpio, etc.?
> > > 
> > > You should make the PCI driver work as a module.
> > 
> > Oh, also PCI_IMX6 is used on (surprise) i.MX6, which doesn't need
> > RESET_IMX7 at all.
> > 
> > How about hiding the RESET_IMX7 option and setting it default y if
> > PCI_IMX6 is enabled, as an interim solution?
> 
> Like below, RESET_IMX7 is already default y when SOC_IMX7D, now added PCI_IMX6,
> let me know if it is OK for you, then I will send new patch for review.
> 
> +++ b/drivers/reset/Kconfig
> @@ -68,7 +68,7 @@ config RESET_IMX7
>         tristate "i.MX7/8 Reset Driver"

I was thinking something like

	tristate "i.MX7/8 Reset Driver" if COMPILE_TEST || !PCI_IMX6

>         depends on HAS_IOMEM
>         depends on SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
> -       default y if SOC_IMX7D
> +       default y if (SOC_IMX7D || PCI_IMX6)

Yes, although without the above I think it could still be disabled
manually or via oldconfig.

regards
Philipp
