Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED78C504E1E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiDRJFm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 05:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbiDRJFi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 05:05:38 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939521169;
        Mon, 18 Apr 2022 02:02:57 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 7631120CBF69
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2 6/8] ARM: dts: r9a06g032: Add internal PCI bridge node
To:     Herve Codina <herve.codina@bootlin.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     Rob Herring <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
 <20220414074011.500533-7-herve.codina@bootlin.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <05c96b4d-313b-1aad-0ee5-61e54672765e@omp.ru>
Date:   Mon, 18 Apr 2022 12:02:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220414074011.500533-7-herve.codina@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On 4/14/22 10:40 AM, Herve Codina wrote:

> Add the device node for the r9a06g032 internal PCI bridge device.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  arch/arm/boot/dts/r9a06g032.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
> index 636a6ab31c58..848dc034bb8c 100644
> --- a/arch/arm/boot/dts/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> @@ -211,6 +211,34 @@ gic: interrupt-controller@44101000 {
>  			interrupts =
>  				<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
>  		};
> +
> +		pci_usb: pci@40030000 {
> +			compatible = "renesas,pci-r9a06g032", "renesas,pci-rzn1";
> +			device_type = "pci";
> +			clocks = <&sysctrl R9A06G032_HCLK_USBH>,
> +				 <&sysctrl R9A06G032_HCLK_USBPM>,
> +				 <&sysctrl R9A06G032_CLK_PCI_USB>;
> +			clock-names = "hclk_usbh", "hclk_usbpm", "clk_pci_usb";
> +			reg = <0x40030000 0xc00>,
> +			      <0x40020000 0x1100>;
> +			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +
> +			bus-range = <0 0>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			#interrupt-cells = <1>;

   Really? I don't think this PCI bridge is also an interrupt controller...

> +			ranges = <0x02000000 0 0x40020000 0x40020000 0 0x00010000>;
> +			/* Should map all possible DDR as inbound ranges, but
> +			 * the IP only supports a 256MB, 512MB, or 1GB window.
> +			 * flags, PCI addr (64-bit), CPU addr, PCI size (64-bit)
> +			 */
> +			dma-ranges = <0x42000000 0 0x80000000 0x80000000 0 0x40000000>;
> +			interrupt-map-mask = <0xf800 0 0 0x7>;
> +			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH
> +					 0x0800 0 0 1 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH
> +					 0x1000 0 0 2 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> +		};
>  	};
>  
>  	timer {

MBR, Sergey
