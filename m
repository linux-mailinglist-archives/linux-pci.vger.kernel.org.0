Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025C945A283
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 13:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhKWMaj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 07:30:39 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:61539 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbhKWMai (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 07:30:38 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id cd9ce2ae;
        Tue, 23 Nov 2021 13:27:28 +0100 (CET)
Date:   Tue, 23 Nov 2021 13:27:28 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Marc Zyngier <maz@kernel.org>
Cc:     luca@lucaceresoli.net, pali@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, kernel-team@android.com,
        alyssa@rosenzweig.io, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com
In-Reply-To: <87sfvncl59.wl-maz@kernel.org> (message from Marc Zyngier on Tue,
        23 Nov 2021 08:48:50 +0000)
Subject: Re: [PATCH v2] PCI: apple: Follow the PCIe specifications when
 resetting the port
References: <20211122104156.518063-1-maz@kernel.org>
 <20211122120347.6qyiycqqjkgqvtta@pali>
 <87zgpw5jza.wl-maz@kernel.org>
 <4fd0438e-b86b-2e1a-ea9a-2297d3580836@lucaceresoli.net> <87sfvncl59.wl-maz@kernel.org>
Message-ID: <d3caf6da9ba0ee58@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Date: Tue, 23 Nov 2021 08:48:50 +0000
> From: Marc Zyngier <maz@kernel.org>
> 
> Luca,
> 
> On Mon, 22 Nov 2021 21:32:15 +0000,
> Luca Ceresoli <luca@lucaceresoli.net> wrote:
> >
> > >> Just one comment. PERST# (PCIe Reset) is active-low signal. De-asserting
> > >> means to really set value to 1.
> > >>
> > >> But there was a discussion that de-asserting should be done by call:
> > >>   gpiod_set_value(reset, 0);
> > >>
> > >> https://lore.kernel.org/linux-pci/51be082a-ff10-8a19-5648-f279aabcac51@lucaceresoli.net/
> > >>
> > >> Could we make this new pcie-apple.c driver to use gpiod_set_value(reset, 0)
> > >> for de-asserting, like in other drivers?
> > 
> > I agree it should be done right from the beginning since this is a new
> > driver. Fixing it later is a painful process.
> 
> No more painful than anything else. At this stage, using a positive or
> negative polarity is immaterial, as there is no core infrastructure
> making any use of this behaviour (every single driver must reinvent
> its own square wheel). If such an infrastructure existed, that'd
> indeed be a requirement. For now, this is merely a convention.
> 
> > > I guess it depends whether you care about the assertion or the signal
> > > itself. I think we may have a bug in the way the GPIOs are handled at
> > > the moment, as it makes no difference whether I register the GPIO are
> > > active high or active low...
> > >
> > > I guess that will be yet another thing to debug, but in the meantime
> > > we have a reliable reset.
> > 
> > Strange, in my case the "active low" pin polarity is correctly picked up
> > from device tree by the gpiolib code, thus using gpio_set_value(gpiod,
> > 1) asserts the pin as it should, resulting in an electrically low pin.
> 
> As I said, this looks like a bug, probably in the M1 DT. I'll try to
> look into it when I get the time.

So the diff below is what the changes look like for U-Boot.  The
U-Boot Apple PCIe driver has not been submitted upstream yet, so
making this change is no problem.



diff --git a/arch/arm/dts/t8103-j274.dts b/arch/arm/dts/t8103-j274.dts
index aef1ae29b6..3777337033 100644
--- a/arch/arm/dts/t8103-j274.dts
+++ b/arch/arm/dts/t8103-j274.dts
@@ -65,7 +65,7 @@
 		device_type = "pci";
 		reg = <0x0 0x0 0x0 0x0 0x0>;
 		pwren-gpios = <&smc 13 0>;
-		reset-gpios = <&pinctrl_ap 152 0>;
+		reset-gpios = <&pinctrl_ap 152 GPIO_ACTIVE_LOW>;
 		max-link-speed = <2>;
 
 		#address-cells = <3>;
@@ -76,7 +76,7 @@
 	pci1: pci@1,0 {
 		device_type = "pci";
 		reg = <0x800 0x0 0x0 0x0 0x0>;
-		reset-gpios = <&pinctrl_ap 153 0>;
+		reset-gpios = <&pinctrl_ap 153 GPIO_ACTIVE_LOW>;
 		max-link-speed = <2>;
 
 		#address-cells = <3>;
@@ -87,7 +87,7 @@
 	pci2: pci@2,0 {
 		device_type = "pci";
 		reg = <0x1000 0x0 0x0 0x0 0x0>;
-		reset-gpios = <&pinctrl_ap 33 0>;
+		reset-gpios = <&pinctrl_ap 33 GPIO_ACTIVE_LOW>;
 		max-link-speed = <1>;
 
 		#address-cells = <3>;
diff --git a/drivers/pci/pcie_apple.c b/drivers/pci/pcie_apple.c
index bef6043adb..89eec70d81 100644
--- a/drivers/pci/pcie_apple.c
+++ b/drivers/pci/pcie_apple.c
@@ -210,7 +210,7 @@ static int apple_pcie_setup_port(struct apple_pcie_priv *pcie, unsigned idx)
 		return 0;
 
 	dm_gpio_set_dir_flags(&pcie->perstn[idx], GPIOD_IS_OUT);
-	dm_gpio_set_value(&pcie->perstn[idx], 0);
+	dm_gpio_set_value(&pcie->perstn[idx], 1);
 
 	rmwl(0, PORT_APPCLK_EN, pcie->base_port[idx] + PORT_APPCLK);
 
@@ -221,7 +221,7 @@ static int apple_pcie_setup_port(struct apple_pcie_priv *pcie, unsigned idx)
 	apple_pcie_port_pwren(pcie, idx);
 
 	rmwl(0, PORT_PERST_OFF, pcie->base_port[idx] + PORT_PERST);
-	dm_gpio_set_value(&pcie->perstn[idx], 1);
+	dm_gpio_set_value(&pcie->perstn[idx], 0);
 
 	res = readl_poll_timeout(pcie->base_port[idx] + PORT_STATUS, stat, (stat & PORT_STATUS_READY), 100, 250000);
 	if (res < 0) {
