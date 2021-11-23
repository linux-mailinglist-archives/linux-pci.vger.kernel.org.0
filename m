Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F26C45A281
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 13:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbhKWMaa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 07:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhKWMaa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Nov 2021 07:30:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F9F060F26;
        Tue, 23 Nov 2021 12:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637670442;
        bh=MaJ54cAwwIlMEp37uzRH5GIzKunKRdbFxDXDGYDcTCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7zwTNNq/A/blATlB3WOs7xfDhDPzd0jSsE11olJpbnMhXB5UhokZu7bOPM5p2NDU
         YvdI15FcPvX6WaCLywXU1/a92R9f0Vrbt73AsA27lv63ynz5mR1ViDVpv3tt6wa4Y/
         7TwH1KenDRNrzPMgy2UuQz462Tn2WtMItS9Unz7P3KSx9Eki4dRP+qUEvgvroFYi0Z
         Hd++mQY4rffN/+NxtIFLpJRo3KSoT3ER6qvpyidXSqo6Xs+SVhgyEzNdQL/oPThcez
         ZB3c7ixoOepHaH7+rmjOCKyRCVaLtHprTBScWGZAIhO/mx/2ot+KP/6+S7HN/wdnEm
         JhdsRqYNZxo1Q==
Received: by pali.im (Postfix)
        id C044F8A3; Tue, 23 Nov 2021 13:27:19 +0100 (CET)
Date:   Tue, 23 Nov 2021 13:27:19 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>, luca@lucaceresoli.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, kernel-team@android.com,
        alyssa@rosenzweig.io, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, joey.gouly@arm.com
Subject: Re: [PATCH v2] PCI: apple: Follow the PCIe specifications when
 resetting the port
Message-ID: <20211123122719.lput7rmn7qr5wkrj@pali>
References: <20211122104156.518063-1-maz@kernel.org>
 <20211122120347.6qyiycqqjkgqvtta@pali>
 <87zgpw5jza.wl-maz@kernel.org>
 <d3caf39f58b0528b@bloch.sibelius.xs4all.nl>
 <87k0gzcb6d.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0gzcb6d.wl-maz@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 23 November 2021 12:24:10 Marc Zyngier wrote:
> On Mon, 22 Nov 2021 21:50:48 +0000,
> Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > 
> > > Date: Mon, 22 Nov 2021 14:43:37 +0000
> > > From: Marc Zyngier <maz@kernel.org>
> > > 
> > > On Mon, 22 Nov 2021 12:03:47 +0000,
> > > Pali Rohár <pali@kernel.org> wrote:
> > > > 
> > > > On Monday 22 November 2021 10:41:56 Marc Zyngier wrote:
> > > > > While the Apple PCIe driver works correctly when directly booted
> > > > > from the firmware, it fails to initialise when the kernel is booted
> > > > > from a bootloader using PCIe such as u-boot.
> > > > > 
> > > > > That's beacuse we're missing a proper reset of the port (we only
> > > > > clear the reset, but never assert it).
> > > > > 
> > > > > The PCIe spec requirements are two-fold:
> > > > > 
> > > > > - #PERST must be asserted before setting up the clocks, and
> > > > >   stay asserted for at least 100us (Tperst-clk).
> > > > > 
> > > > > - Once #PERST is deasserted, the OS must wait for at least 100ms
> > > > >   "from the end of a Conventional Reset" before we can start talking
> > > > >   to the devices
> > > > > 
> > > > > Implementing this results in a booting system.
> > > > > 
> > > > > Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> > > > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > > > Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> > > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > Cc: Pali Rohár <pali@kernel.org>
> > > > 
> > > > Looks good, but see comment below.
> > > > 
> > > > Acked-by: Pali Rohár <pali@kernel.org>
> > > 
> > > Thanks for that.
> > > 
> > > > 
> > > > > ---
> > > > >  drivers/pci/controller/pcie-apple.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> > > > > index 1bf4d75b61be..957960a733c4 100644
> > > > > --- a/drivers/pci/controller/pcie-apple.c
> > > > > +++ b/drivers/pci/controller/pcie-apple.c
> > > > > @@ -539,13 +539,23 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
> > > > >  
> > > > >  	rmw_set(PORT_APPCLK_EN, port->base + PORT_APPCLK);
> > > > >  
> > > > > +	/* Engage #PERST before setting up the clock */
> > > > > +	gpiod_set_value(reset, 0);
> > > > > +
> > > > >  	ret = apple_pcie_setup_refclk(pcie, port);
> > > > >  	if (ret < 0)
> > > > >  		return ret;
> > > > >  
> > > > > +	/* The minimal Tperst-clk value is 100us (PCIe CMS r2.0, 2.6.2) */
> > > > > +	usleep_range(100, 200);
> > > > > +
> > > > > +	/* Deassert #PERST */
> > > > >  	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
> > > > >  	gpiod_set_value(reset, 1);
> > > > 
> > > > + Luca
> > > > 
> > > > Just one comment. PERST# (PCIe Reset) is active-low signal. De-asserting
> > > > means to really set value to 1.
> > > > 
> > > > But there was a discussion that de-asserting should be done by call:
> > > >   gpiod_set_value(reset, 0);
> > > > 
> > > > https://lore.kernel.org/linux-pci/51be082a-ff10-8a19-5648-f279aabcac51@lucaceresoli.net/
> > > > 
> > > > Could we make this new pcie-apple.c driver to use gpiod_set_value(reset, 0)
> > > > for de-asserting, like in other drivers?
> > > 
> > > I guess it depends whether you care about the assertion or the signal
> > > itself. I think we may have a bug in the way the GPIOs are handled at
> > > the moment, as it makes no difference whether I register the GPIO are
> > > active high or active low...
> > 
> > That's unfortunate.  But maybe that's an opportunity to fix the
> > devicetree to use GPIO_ACTIVE_LOW for these GPIOs?
> 
> Indeed. The following hack does the right thing, and I can then
> reverse the polarity of the reset in the Linux driver. Of course, it
> breaks u-boot at the same time (and I suspect OpenBSD would be equally
> affected).

U-Boot has its own copy of DTS files, right? So it can be fixed in
U-Boot driver together with U-Boot DTS file at the same time.

> So if we are going down that road, we may need a flag day where all
> the moving parts change. I don't really mind not being able to boot
> older kernels, but this goes beyond Linux at this point.
> 
> Thanks,
> 
> 	M.
> 
> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> index d2e9afde3729..cad1ab920304 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/interrupt-controller/apple-aic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/apple.h>
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	compatible = "apple,t8103", "apple,arm-platform";
> @@ -293,7 +294,7 @@ pcie0: pcie@690000000 {
>  			port00: pci@0,0 {
>  				device_type = "pci";
>  				reg = <0x0 0x0 0x0 0x0 0x0>;
> -				reset-gpios = <&pinctrl_ap 152 0>;
> +				reset-gpios = <&pinctrl_ap 152 GPIO_ACTIVE_LOW>;
>  				max-link-speed = <2>;
>  
>  				#address-cells = <3>;
> @@ -313,7 +314,7 @@ port00: pci@0,0 {
>  			port01: pci@1,0 {
>  				device_type = "pci";
>  				reg = <0x800 0x0 0x0 0x0 0x0>;
> -				reset-gpios = <&pinctrl_ap 153 0>;
> +				reset-gpios = <&pinctrl_ap 153 GPIO_ACTIVE_LOW>;
>  				max-link-speed = <2>;
>  
>  				#address-cells = <3>;
> @@ -333,7 +334,7 @@ port01: pci@1,0 {
>  			port02: pci@2,0 {
>  				device_type = "pci";
>  				reg = <0x1000 0x0 0x0 0x0 0x0>;
> -				reset-gpios = <&pinctrl_ap 33 0>;
> +				reset-gpios = <&pinctrl_ap 33 GPIO_ACTIVE_LOW>;
>  				max-link-speed = <1>;
>  
>  				#address-cells = <3>;
> 
> -- 
> Without deviation from the norm, progress is not possible.
