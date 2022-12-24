Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAA9655B07
	for <lists+linux-pci@lfdr.de>; Sat, 24 Dec 2022 20:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiLXTBN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Dec 2022 14:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXTBN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Dec 2022 14:01:13 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF4D10E1;
        Sat, 24 Dec 2022 11:01:10 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1p99lG-0007OA-2A;
        Sat, 24 Dec 2022 20:00:46 +0100
Date:   Sat, 24 Dec 2022 19:00:40 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org
Subject: Re: [next v7 8/8] arm64: dts: mt7986: add Bananapi R3
Message-ID: <Y6dMWFy7gChG88j0@makrotopia.org>
References: <20221127114142.156573-1-linux@fw-web.de>
 <20221127114142.156573-9-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127114142.156573-9-linux@fw-web.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

please see some comments inline below:

On Sun, Nov 27, 2022 at 12:41:42PM +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add support for Bananapi R3 SBC.
> 
> - SD/eMMC support (switching first 4 bits of data-bus with sw6/D)
> - SPI-NAND/NOR support (switched CS by sw5/C)
> - all rj45 ports and both SFP working (eth1/lan4)
> - all USB-Ports + SIM-Slot tested
> - i2c and all uarts tested
> - wifi tested (with eeprom calibration data)
> 
> The device can boot from all 4 storage options. Both, SPI and MMC, can
> be switched using hardware switches on the board, see
> https://wiki.banana-pi.org/Banana_Pi_BPI-R3#Jumper_setting
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes:
> v7:
> - squashed overlay-patch and converted sd/emmc dts to overlay too
> - moved mmc-regulators to base dts
> - changed common dtsi to (base dts) and overlay extension to dtso
> 
> v6:
> - drop usb 5v regulator from bpi-r3
>   based on chunfengs response it is only needed if regulator is
>   switched (like for otg), usb works without it.
> 
> v4:
> - add PCIe nodes
> - fix sfp-properties of sfp-1 (need to be plural)
>   thx to Denis Odintsov for this
> 
> v3:
> - rename factory-key to reset-key
> - add dcin regulator and add it as input for 3v3 (with renaming)
> - remove memory-node
> - dropped wifi eeprom (calibration) data
> - move mmc0 pinctrl to common dtsi and drop sdcard comment
> - change mmc pull-up/down to have generic bias-pull*
> 
> v2:
> - remove pcie to be added later (discussion about clocks)
> - some fixes based on suggestions on ML
>   - add key suffix like it's done in mt7622-bpi-r64 devicetree
>   - add dash in sfp node names
>   - use reg as unit for switch-node
>   - drop "-3-4" suffix from i2c-pins node name
>   - fix order in Makefile
> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |   5 +
>  .../mt7986a-bananapi-bpi-r3-emmc.dtso         |  30 ++
>  .../mt7986a-bananapi-bpi-r3-nand.dtso         |  55 +++
>  .../mediatek/mt7986a-bananapi-bpi-r3-nor.dtso |  68 +++
>  .../mediatek/mt7986a-bananapi-bpi-r3-sd.dtso  |  24 +
>  .../dts/mediatek/mt7986a-bananapi-bpi-r3.dts  | 448 ++++++++++++++++++
>  6 files changed, 630 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dtso
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dtso
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 813e735c5b96..d5cd7b3e09cf 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -8,6 +8,11 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtbo
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtbo
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dtso
> new file mode 100644
> index 000000000000..c15f2f5760ed
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dtso
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + * Author: Sam.Shih <sam.shih@mediatek.com>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +/ {
> +	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
> +	model = "Bananapi BPI-R3 (emmc)";

Why do you set the model string here?


> +
> +	fragment@0 {
> +		target-path = "/soc/mmc@11230000";
> +		__overlay__ {
> +			bus-width = <8>;
> +			max-frequency = <200000000>;
> +			cap-mmc-highspeed;
> +			mmc-hs200-1_8v;
> +			mmc-hs400-1_8v;
> +			hs400-ds-delay = <0x14014>;
> +			non-removable;
> +			no-sd;
> +			no-sdio;
> +			status = "okay";
> +		};
> +	};
> +};
> +
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso
> new file mode 100644
> index 000000000000..15ee8c568f3c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Authors: Daniel Golle <daniel@makrotopia.org>
> + *          Frank Wunderlich <frank-w@public-files.de>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +/ {
> +	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
> +
> +	fragment@0 {
> +		target-path = "/soc/spi@1100a000";
> +		__overlay__ {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			spi_nand: spi_nand@0 {
> +				compatible = "spi-nand";
> +				reg = <0>;
> +				spi-max-frequency = <10000000>;
> +				spi-tx-buswidth = <4>;
> +				spi-rx-buswidth = <4>;
> +
> +				partitions {
> +					compatible = "fixed-partitions";
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +
> +					partition@0 {
> +						label = "bl2";
> +						reg = <0x0 0x80000>;
> +						read-only;
> +					};
> +
> +					partition@80000 {
> +						label = "reserved";
> +						reg = <0x80000 0x300000>;
> +					};
> +
> +					partition@380000 {
> +						label = "fip";
> +						reg = <0x380000 0x200000>;
> +						read-only;
> +					};
> +
> +					partition@580000 {
> +						label = "ubi";
> +						reg = <0x580000 0x7a80000>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
> new file mode 100644
> index 000000000000..84aa229e80f3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Authors: Daniel Golle <daniel@makrotopia.org>
> + *          Frank Wunderlich <frank-w@public-files.de>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +/ {
> +	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
> +
> +	fragment@0 {
> +		target-path = "/soc/spi@1100a000";
> +		__overlay__ {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			flash@0 {
> +				compatible = "jedec,spi-nor";
> +				reg = <0>;
> +				spi-max-frequency = <10000000>;
> +
> +				partitions {
> +					compatible = "fixed-partitions";
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +
> +					partition@0 {
> +						label = "bl2";
> +						reg = <0x0 0x20000>;
> +						read-only;
> +					};
> +
> +					partition@20000 {
> +						label = "reserved";
> +						reg = <0x20000 0x20000>;
> +					};
> +
> +					partition@40000 {
> +						label = "u-boot-env";
> +						reg = <0x40000 0x40000>;
> +					};
> +
> +					partition@80000 {
> +						label = "reserved2";
> +						reg = <0x80000 0x80000>;
> +					};
> +
> +					partition@100000 {
> +						label = "fip";
> +						reg = <0x100000 0x80000>;
> +						read-only;
> +					};
> +
> +					partition@180000 {
> +						label = "recovery";
> +						reg = <0x180000 0xa80000>;
> +					};
> +
> +					partition@c00000 {
> +						label = "fit";
> +						reg = <0xc00000 0x1400000>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dtso
> new file mode 100644
> index 000000000000..08af778d8adc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dtso
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + * Author: Sam.Shih <sam.shih@mediatek.com>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +/ {
> +	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
> +	model = "Bananapi BPI-R3 (sdmmc)";
> +
> +	fragment@0 {
> +		target-path = "/soc/mmc@11230000";
> +		__overlay__ {
> +			bus-width = <4>;
> +			max-frequency = <52000000>;
> +			cap-sd-highspeed;
> +			status = "okay";
> +		};
> +	};
> +};
> +
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> new file mode 100644
> index 000000000000..618d3bb2f32f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> @@ -0,0 +1,448 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + * Authors: Sam.Shih <sam.shih@mediatek.com>
> + *          Frank Wunderlich <frank-w@public-files.de>
> + *          Daniel Golle <daniel@makrotopia.org>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/mt65xx.h>
> +
> +#include "mt7986a.dtsi"
> +
> +/ {
> +	model = "Bananapi BPI-R3";
> +	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	dcin: regulator-12vd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "12vd";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		reset-key {
> +			label = "reset";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&pio 9 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		wps-key {
> +			label = "wps";
> +			linux,code = <KEY_WPS_BUTTON>;
> +			gpios = <&pio 10 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	/* i2c of the left SFP cage (wan) */
> +	i2c_sfp1: i2c-gpio-0 {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&pio 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&pio 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	/* i2c of the right SFP cage (lan) */
> +	i2c_sfp2: i2c-gpio-1 {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&pio 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&pio 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		green_led: led-0 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_POWER;
> +			gpios = <&pio 69 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +		};
> +
> +		blue_led: led-1 {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&pio 86 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	reg_1p8v: regulator-1p8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1.8vd";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		vin-supply = <&dcin>;
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3.3vd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		vin-supply = <&dcin>;
> +	};
> +
> +	/* left SFP cage (wan) */
> +	sfp1: sfp-1 {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&i2c_sfp1>;
> +		los-gpios = <&pio 46 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpios = <&pio 49 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpios = <&pio 20 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	/* right SFP cage (lan) */
> +	sfp2: sfp-2 {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&i2c_sfp2>;
> +		los-gpios = <&pio 31 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpios = <&pio 47 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpios = <&pio 15 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpios = <&pio 48 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&crypto {
> +	status = "okay";
> +};
> +
> +&eth {
> +	status = "okay";
> +
> +	gmac0: mac@0 {
> +		compatible = "mediatek,eth-mac";
> +		reg = <0>;
> +		phy-mode = "2500base-x";
> +
> +		fixed-link {
> +			speed = <2500>;
> +			full-duplex;
> +			pause;
> +		};
> +	};
> +
> +	gmac1: mac@1 {
> +		compatible = "mediatek,eth-mac";
> +		reg = <1>;
> +		phy-mode = "2500base-x";
> +		sfp = <&sfp1>;
> +		managed = "in-band-status";
> +	};
> +
> +	mdio: mdio-bus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +};
> +
> +&mdio {
> +	switch: switch@31 {
> +		compatible = "mediatek,mt7531";
> +		reg = <31>;
> +		reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;

Please add:

                interrupt-controller;
                #interrupt-cells = <1>;
                interrupt-parent = <&pio>;
                interrupts = <66 IRQ_TYPE_LEVEL_HIGH>;

to have IRQ driven phy status instead of having to poll the link status
of the 5x rj-45 ports.
The value comes from schematics (pin AD24, GPIO66, 7531_INT) and I've
tested this on my board.


> +	};
> +};
> +
> +&mmc0 {
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc0_pins_default>;
> +	pinctrl-1 = <&mmc0_pins_uhs>;
> +	vmmc-supply = <&reg_3p3v>;
> +	vqmmc-supply = <&reg_1p8v>;
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c_pins>;
> +	status = "okay";
> +};
> +
> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_pins>;
> +	status = "okay";
> +};
> +
> +&pcie_phy {
> +	status = "okay";
> +};
> +
> +&pio {
> +	i2c_pins: i2c-pins {
> +		mux {
> +			function = "i2c";
> +			groups = "i2c";
> +		};
> +	};
> +
> +	mmc0_pins_default: mmc0-pins {
> +		mux {
> +			function = "emmc";
> +			groups = "emmc_51";
> +		};
> +		conf-cmd-dat {
> +			pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
> +			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
> +			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
> +			input-enable;
> +			drive-strength = <4>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
> +		};
> +		conf-clk {
> +			pins = "EMMC_CK";
> +			drive-strength = <6>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
> +		};
> +		conf-ds {
> +			pins = "EMMC_DSL";
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
> +		};
> +		conf-rst {
> +			pins = "EMMC_RSTB";
> +			drive-strength = <4>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
> +		};
> +	};
> +
> +	mmc0_pins_uhs: mmc0-uhs-pins {
> +		mux {
> +			function = "emmc";
> +			groups = "emmc_51";
> +		};
> +		conf-cmd-dat {
> +			pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
> +			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
> +			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
> +			input-enable;
> +			drive-strength = <4>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
> +		};
> +		conf-clk {
> +			pins = "EMMC_CK";
> +			drive-strength = <6>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
> +		};
> +		conf-ds {
> +			pins = "EMMC_DSL";
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
> +		};
> +		conf-rst {
> +			pins = "EMMC_RSTB";
> +			drive-strength = <4>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
> +		};
> +	};
> +
> +	pcie_pins: pcie-pins {
> +		mux {
> +			function = "pcie";
> +			groups = "pcie_clk", "pcie_pereset";
> +		};
> +	};
> +
> +	spi_flash_pins: spi-flash-pins {
> +		mux {
> +			function = "spi";
> +			groups = "spi0", "spi0_wp_hold";
> +		};
> +	};
> +
> +	spic_pins: spic-pins {
> +		mux {
> +			function = "spi";
> +			groups = "spi1_0";
> +		};
> +	};
> +
> +	uart1_pins: uart1-pins {
> +		mux {
> +			function = "uart";
> +			groups = "uart1_rx_tx";
> +		};
> +	};
> +
> +	uart2_pins: uart2-pins {
> +		mux {
> +			function = "uart";
> +			groups = "uart2_0_rx_tx";
> +		};
> +	};
> +
> +	wf_2g_5g_pins: wf-2g-5g-pins {
> +		mux {
> +			function = "wifi";
> +			groups = "wf_2g", "wf_5g";
> +		};
> +		conf {
> +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
> +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
> +			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
> +			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
> +			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
> +			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
> +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> +			drive-strength = <4>;
> +		};
> +	};
> +
> +	wf_dbdc_pins: wf-dbdc-pins {
> +		mux {
> +			function = "wifi";
> +			groups = "wf_dbdc";
> +		};
> +		conf {
> +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
> +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
> +			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
> +			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
> +			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
> +			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
> +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> +			drive-strength = <4>;
> +		};
> +	};
> +
> +	wf_led_pins: wf-led-pins {
> +		mux {
> +			function = "led";
> +			groups = "wifi_led";
> +		};
> +	};
> +};
> +
> +&spi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi_flash_pins>;
> +	cs-gpios = <0>, <0>;

I don't think those bogus cs-gpios here and for spi1 below are needed.

> +	status = "okay";
> +};
> +
> +&spi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spic_pins>;
> +	cs-gpios = <0>, <0>;
> +	status = "okay";
> +};
> +
> +&ssusb {
> +	status = "okay";
> +};
> +
> +&switch {
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +			label = "wan";
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +			label = "lan0";
> +		};
> +
> +		port@2 {
> +			reg = <2>;
> +			label = "lan1";
> +		};
> +
> +		port@3 {
> +			reg = <3>;
> +			label = "lan2";
> +		};
> +
> +		port@4 {
> +			reg = <4>;
> +			label = "lan3";
> +		};
> +
> +		port5: port@5 {
> +			reg = <5>;
> +			label = "lan4";
> +			phy-mode = "2500base-x";
> +			sfp = <&sfp2>;
> +			managed = "in-band-status";
> +		};
> +
> +		port@6 {
> +			reg = <6>;
> +			label = "cpu";
> +			ethernet = <&gmac0>;
> +			phy-mode = "2500base-x";
> +
> +			fixed-link {
> +				speed = <2500>;
> +				full-duplex;
> +				pause;
> +			};
> +		};
> +	};
> +};
> +
> +&trng {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2_pins>;
> +	status = "okay";
> +};
> +
> +&usb_phy {
> +	status = "okay";
> +};
> +
> +&watchdog {
> +	status = "okay";
> +};
> +
> +&wifi {
> +	status = "okay";
> +	pinctrl-names = "default", "dbdc";
> +	pinctrl-0 = <&wf_2g_5g_pins>, <&wf_led_pins>;
> +	pinctrl-1 = <&wf_dbdc_pins>, <&wf_led_pins>;
> +};
> +
> -- 
> 2.34.1
> 
> 
