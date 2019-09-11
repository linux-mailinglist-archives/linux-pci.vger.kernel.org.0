Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E94BAFD6C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2019 15:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfIKNLP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Sep 2019 09:11:15 -0400
Received: from foss.arm.com ([217.140.110.172]:47408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbfIKNLO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Sep 2019 09:11:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0C341000;
        Wed, 11 Sep 2019 06:11:13 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 568163F67D;
        Wed, 11 Sep 2019 06:11:13 -0700 (PDT)
Date:   Wed, 11 Sep 2019 14:11:11 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, kishon@ti.com,
        repk@triplefau.lt, maz@kernel.org,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: khadas-vim3: add commented support for
 PCIe
Message-ID: <20190911131111.GX9720@e119886-lin.cambridge.arm.com>
References: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
 <1567950178-4466-7-git-send-email-narmstrong@baylibre.com>
 <20190911125035.GU9720@e119886-lin.cambridge.arm.com>
 <bf7b735d-e682-52db-ea8c-4ccd786f0ed9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf7b735d-e682-52db-ea8c-4ccd786f0ed9@baylibre.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 11, 2019 at 02:58:18PM +0200, Neil Armstrong wrote:
> On 11/09/2019 14:50, Andrew Murray wrote:
> > On Sun, Sep 08, 2019 at 01:42:58PM +0000, Neil Armstrong wrote:
> >> The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
> >> lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
> >> an USB3.0 Type A connector and a M.2 Key M slot.
> >> The PHY driving these differential lines is shared between
> >> the USB3.0 controller and the PCIe Controller, thus only
> >> a single controller can use it.
> >>
> >> The needed DT configuration when the MCU is configured to mux
> >> the PCIe/USB3.0 differential lines to the M.2 Key M slot is
> >> added commented and may uncommented to disable USB3.0 from the
> > 
> > *and may be*
> > 
> >> USB Complex and enable the PCIe controller.
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>  .../amlogic/meson-g12b-a311d-khadas-vim3.dts  | 22 +++++++++++++++++++
> >>  .../amlogic/meson-g12b-s922x-khadas-vim3.dts  | 22 +++++++++++++++++++
> >>  .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  4 ++++
> >>  .../dts/amlogic/meson-sm1-khadas-vim3l.dts    | 22 +++++++++++++++++++
> >>  4 files changed, 70 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
> >> index 3a6a1e0c1e32..0577b1435cbb 100644
> >> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
> >> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
> >> @@ -14,3 +14,25 @@
> >>  / {
> >>  	compatible = "khadas,vim3", "amlogic,a311d", "amlogic,g12b";
> >>  };
> >> +
> >> +/*
> >> + * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
> >> + * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
> >> + * an USB3.0 Type A connector and a M.2 Key M slot.
> >> + * The PHY driving these differential lines is shared between
> >> + * the USB3.0 controller and the PCIe Controller, thus only
> >> + * a single controller can use it.
> >> + * If the MCU is configured to mux the PCIe/USB3.0 differential lines
> >> + * to the M.2 Key M slot, uncomment the following block to disable
> >> + * USB3.0 from the USB Complex and enable the PCIe controller.
> >> + */
> >> +/*
> >> +&pcie {
> >> +	status = "okay";
> >> +};
> >> +
> >> +&usb {
> >> +	phys = <&usb2_phy0>, <&usb2_phy1>;
> >> +	phy-names = "usb2-phy0", "usb2-phy1";
> >> +};
> > 
> > I assume there is no way other way to determine from the hardware which way
> > the mux is set?
> 
> No, it would be simpler :-/ The MUX is on-board and the MCU drives the MUX selection.
> 
> You can look at the https://dl.khadas.com/Hardware/VIM3/Schematic/VIM3_V11_Sch.pdf
> The PCIE_EN signal is driven by the STM8S MCU.

Ah I see.

> 
> > 
> > Otherwise phy_g12a_usb3_pcie_xlate could determine the hardware mode, and
> > reject the phy instance with the wrong mode. Thus resulting in either the
> > PCI or USB to fail their probe. And avoiding the need to modify the DT on
> > boot.
> 
> Yep, it would have been simpler this way. Maybe a board vendor will set a gpio ?
> who knows, but for actual boards it's static or with 0ohm resistors, and for the
> VIM3 we only know by asking the MCU.
> 
> Maybe we could add a fake PHY as a MCU MFD subdevice, wrapping calls to the
> right PHY. But for now the MCU has no upstream driver anyway.

OK

Thanks,

Andrew Murray

> 
> Neil
> 
> > 
> > Thanks,
> > 
> > Andrew Murray
> > 
> >> + */
> >> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts
> >> index b73deb282120..1ef5c2f04f67 100644
> >> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts
> >> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts
> >> @@ -14,3 +14,25 @@
> >>  / {
> >>  	compatible = "khadas,vim3", "amlogic,s922x", "amlogic,g12b";
> >>  };
> >> +
> >> +/*
> >> + * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
> >> + * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
> >> + * an USB3.0 Type A connector and a M.2 Key M slot.
> >> + * The PHY driving these differential lines is shared between
> >> + * the USB3.0 controller and the PCIe Controller, thus only
> >> + * a single controller can use it.
> >> + * If the MCU is configured to mux the PCIe/USB3.0 differential lines
> >> + * to the M.2 Key M slot, uncomment the following block to disable
> >> + * USB3.0 from the USB Complex and enable the PCIe controller.
> >> + */
> >> +/*
> >> +&pcie {
> >> +	status = "okay";
> >> +};
> >> +
> >> +&usb {
> >> +	phys = <&usb2_phy0>, <&usb2_phy1>;
> >> +	phy-names = "usb2-phy0", "usb2-phy1";
> >> +};
> >> + */
> >> diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> >> index 8647da7d6609..eac5720dc15f 100644
> >> --- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> >> +++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> >> @@ -246,6 +246,10 @@
> >>  	linux,rc-map-name = "rc-khadas";
> >>  };
> >>  
> >> +&pcie {
> >> +	reset-gpios = <&gpio GPIOA_8 GPIO_ACTIVE_LOW>;
> >> +};
> >> +
> >>  &pwm_ef {
> >>          status = "okay";
> >>          pinctrl-0 = <&pwm_e_pins>;
> >> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> >> index 5233bd7cacfb..d9c7cbedce53 100644
> >> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> >> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> >> @@ -68,3 +68,25 @@
> >>  	clock-names = "clkin1";
> >>  	status = "okay";
> >>  };
> >> +
> >> +/*
> >> + * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
> >> + * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
> >> + * an USB3.0 Type A connector and a M.2 Key M slot.
> >> + * The PHY driving these differential lines is shared between
> >> + * the USB3.0 controller and the PCIe Controller, thus only
> >> + * a single controller can use it.
> >> + * If the MCU is configured to mux the PCIe/USB3.0 differential lines
> >> + * to the M.2 Key M slot, uncomment the following block to disable
> >> + * USB3.0 from the USB Complex and enable the PCIe controller.
> >> + */
> >> +/*
> >> +&pcie {
> >> +	status = "okay";
> >> +};
> >> +
> >> +&usb {
> >> +	phys = <&usb2_phy0>, <&usb2_phy1>;
> >> +	phy-names = "usb2-phy0", "usb2-phy1";
> >> +};
> >> + */
> >> -- 
> >> 2.17.1
> >>
> 
