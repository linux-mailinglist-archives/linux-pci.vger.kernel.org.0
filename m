Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F605B3BB5
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfIPNpu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 09:45:50 -0400
Received: from foss.arm.com ([217.140.110.172]:45100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbfIPNpu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Sep 2019 09:45:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CD1F337;
        Mon, 16 Sep 2019 06:45:49 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E84043F67D;
        Mon, 16 Sep 2019 06:45:48 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:45:47 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, lorenzo.pieralisi@arm.com, kishon@ti.com,
        bhelgaas@google.com, linux-amlogic@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yue.wang@Amlogic.com, maz@kernel.org,
        repk@triplefau.lt, nick@khadas.com, gouwa@khadas.com
Subject: Re: [PATCH v2 6/6] arm64: dts: khadas-vim3: add commented support
 for PCIe
Message-ID: <20190916134546.GS9720@e119886-lin.cambridge.arm.com>
References: <20190916125022.10754-1-narmstrong@baylibre.com>
 <20190916125022.10754-7-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916125022.10754-7-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 16, 2019 at 02:50:22PM +0200, Neil Armstrong wrote:
> The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
> lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
> an USB3.0 Type A connector and a M.2 Key M slot.
> The PHY driving these differential lines is shared between
> the USB3.0 controller and the PCIe Controller, thus only
> a single controller can use it.
> 
> The needed DT configuration when the MCU is configured to mux
> the PCIe/USB3.0 differential lines to the M.2 Key M slot is
> added commented and may be uncommented to disable USB3.0 from the
> USB Complex and enable the PCIe controller.
> 
> The End User is not expected to uncomment the following except for
> testing purposes, but instead rely on the firmware/bootloader to
> update these nodes accordingly if PCIe mode is selected by the MCU.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> ---
>  .../amlogic/meson-g12b-a311d-khadas-vim3.dts  | 25 +++++++++++++++++++
>  .../amlogic/meson-g12b-s922x-khadas-vim3.dts  | 25 +++++++++++++++++++
>  .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  4 +++
>  .../dts/amlogic/meson-sm1-khadas-vim3l.dts    | 25 +++++++++++++++++++
>  4 files changed, 79 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
> index 3a6a1e0c1e32..124a80901084 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
> @@ -14,3 +14,28 @@
>  / {
>  	compatible = "khadas,vim3", "amlogic,a311d", "amlogic,g12b";
>  };
> +
> +/*
> + * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
> + * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
> + * an USB3.0 Type A connector and a M.2 Key M slot.
> + * The PHY driving these differential lines is shared between
> + * the USB3.0 controller and the PCIe Controller, thus only
> + * a single controller can use it.
> + * If the MCU is configured to mux the PCIe/USB3.0 differential lines
> + * to the M.2 Key M slot, uncomment the following block to disable
> + * USB3.0 from the USB Complex and enable the PCIe controller.
> + * The End User is not expected to uncomment the following except for
> + * testing purposes, but instead rely on the firmware/bootloader to
> + * update these nodes accordingly if PCIe mode is selected by the MCU.
> + */
> +/*
> +&pcie {
> +	status = "okay";
> +};
> +
> +&usb {
> +	phys = <&usb2_phy0>, <&usb2_phy1>;
> +	phy-names = "usb2-phy0", "usb2-phy1";
> +};
> + */
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts
> index b73deb282120..bba98f982ad6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts
> @@ -14,3 +14,28 @@
>  / {
>  	compatible = "khadas,vim3", "amlogic,s922x", "amlogic,g12b";
>  };
> +
> +/*
> + * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
> + * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
> + * an USB3.0 Type A connector and a M.2 Key M slot.
> + * The PHY driving these differential lines is shared between
> + * the USB3.0 controller and the PCIe Controller, thus only
> + * a single controller can use it.
> + * If the MCU is configured to mux the PCIe/USB3.0 differential lines
> + * to the M.2 Key M slot, uncomment the following block to disable
> + * USB3.0 from the USB Complex and enable the PCIe controller.
> + * The End User is not expected to uncomment the following except for
> + * testing purposes, but instead rely on the firmware/bootloader to
> + * update these nodes accordingly if PCIe mode is selected by the MCU.
> + */
> +/*
> +&pcie {
> +	status = "okay";
> +};
> +
> +&usb {
> +	phys = <&usb2_phy0>, <&usb2_phy1>;
> +	phy-names = "usb2-phy0", "usb2-phy1";
> +};
> + */
> diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> index 4fe7d33ebe8a..90815fa25ec6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> @@ -246,6 +246,10 @@
>  	linux,rc-map-name = "rc-khadas";
>  };
>  
> +&pcie {
> +	reset-gpios = <&gpio GPIOA_8 GPIO_ACTIVE_LOW>;
> +};
> +
>  &pwm_ef {
>          status = "okay";
>          pinctrl-0 = <&pwm_e_pins>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> index 5233bd7cacfb..dbbf29a0dbf6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> @@ -68,3 +68,28 @@
>  	clock-names = "clkin1";
>  	status = "okay";
>  };
> +
> +/*
> + * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
> + * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
> + * an USB3.0 Type A connector and a M.2 Key M slot.
> + * The PHY driving these differential lines is shared between
> + * the USB3.0 controller and the PCIe Controller, thus only
> + * a single controller can use it.
> + * If the MCU is configured to mux the PCIe/USB3.0 differential lines
> + * to the M.2 Key M slot, uncomment the following block to disable
> + * USB3.0 from the USB Complex and enable the PCIe controller.
> + * The End User is not expected to uncomment the following except for
> + * testing purposes, but instead rely on the firmware/bootloader to
> + * update these nodes accordingly if PCIe mode is selected by the MCU.
> + */
> +/*
> +&pcie {
> +	status = "okay";
> +};
> +
> +&usb {
> +	phys = <&usb2_phy0>, <&usb2_phy1>;
> +	phy-names = "usb2-phy0", "usb2-phy1";
> +};
> + */
> -- 
> 2.22.0
> 
