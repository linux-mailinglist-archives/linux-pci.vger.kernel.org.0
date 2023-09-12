Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2EC79C314
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 04:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239461AbjILCho convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 11 Sep 2023 22:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbjILCh3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 22:37:29 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E83161116;
        Mon, 11 Sep 2023 19:02:50 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1276724E2C7;
        Tue, 12 Sep 2023 10:02:41 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Sep
 2023 10:02:41 +0800
Received: from [192.168.125.136] (113.72.145.181) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Sep
 2023 10:02:39 +0800
Message-ID: <071513f5-941c-5152-f9c9-07406b6a0641@starfivetech.com>
Date:   Tue, 12 Sep 2023 10:02:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 11/11] riscv: dts: starfive: add PCIe dts configuration
 for JH7110
To:     Rob Herring <robh+dt@kernel.org>,
        Minda Chen <minda.chen@starfivetech.com>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
References: <20230907091058.125630-1-minda.chen@starfivetech.com>
 <20230907091058.125630-12-minda.chen@starfivetech.com>
 <CAL_Jsq+TeDK0Lh7Yf9CwLPDPfvuv9C8A6dKDEBVxMtncyuzQQg@mail.gmail.com>
Content-Language: en-US
From:   Kevin Xie <kevin.xie@starfivetech.com>
In-Reply-To: <CAL_Jsq+TeDK0Lh7Yf9CwLPDPfvuv9C8A6dKDEBVxMtncyuzQQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.145.181]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/9/8 1:19, Rob Herring wrote:
> On Thu, Sep 7, 2023 at 4:11 AM Minda Chen <minda.chen@starfivetech.com> wrote:
>>
>> Add PCIe dts configuraion for JH7110 SoC platform.
>>
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../jh7110-starfive-visionfive-2.dtsi         | 64 ++++++++++++++
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 86 +++++++++++++++++++
>>  2 files changed, 150 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> index de0f40a8be93..4dd61e2fec7d 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> @@ -15,6 +15,8 @@
>>                 i2c2 = &i2c2;
>>                 i2c5 = &i2c5;
>>                 i2c6 = &i2c6;
>> +               pcie0 = &pcie0;
>> +               pcie1 = &pcie1;
> 
> That's not a defined alias. We already have "linux,pci-domain" if you
> need to number PCI host bridges.
> 

Okay, we will number PCI host bridges by "linux,pci-domain".

>>                 serial0 = &uart0;
>>         };
>>
>> @@ -208,6 +210,54 @@
>>                 };
>>         };
>>
>> +       pcie0_pins: pcie0-0 {
>> +               wake-pins {
>> +                       pinmux = <GPIOMUX(32, GPOUT_LOW,
>> +                                             GPOEN_DISABLE,
>> +                                             GPI_NONE)>;
>> +                       bias-pull-up;
>> +                       drive-strength = <2>;
>> +                       input-enable;
>> +                       input-schmitt-disable;
>> +                       slew-rate = <0>;
>> +               };
>> +
>> +               clkreq-pins {
>> +                       pinmux = <GPIOMUX(27, GPOUT_LOW,
>> +                                             GPOEN_DISABLE,
>> +                                             GPI_NONE)>;
>> +                       bias-pull-down;
>> +                       drive-strength = <2>;
>> +                       input-enable;
>> +                       input-schmitt-disable;
>> +                       slew-rate = <0>;
>> +               };
>> +       };
>> +
>> +       pcie1_pins: pcie1-0 {
>> +               wake-pins {
>> +                       pinmux = <GPIOMUX(21, GPOUT_LOW,
>> +                                             GPOEN_DISABLE,
>> +                                             GPI_NONE)>;
>> +                       bias-pull-up;
>> +                       drive-strength = <2>;
>> +                       input-enable;
>> +                       input-schmitt-disable;
>> +                       slew-rate = <0>;
>> +               };
>> +
>> +               clkreq-pins {
>> +                       pinmux = <GPIOMUX(29, GPOUT_LOW,
>> +                                             GPOEN_DISABLE,
>> +                                             GPI_NONE)>;
>> +                       bias-pull-down;
>> +                       drive-strength = <2>;
>> +                       input-enable;
>> +                       input-schmitt-disable;
>> +                       slew-rate = <0>;
>> +               };
>> +       };
>> +
>>         uart0_pins: uart0-0 {
>>                 tx-pins {
>>                         pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
>> @@ -233,6 +283,20 @@
>>         };
>>  };
>>
>> +&pcie0 {
>> +       pinctrl-names = "default";
>> +       perst-gpios = <&sysgpio 26 GPIO_ACTIVE_LOW>;
>> +       pinctrl-0 = <&pcie0_pins>;
>> +       status = "okay";
>> +};
>> +
>> +&pcie1 {
>> +       pinctrl-names = "default";
>> +       perst-gpios = <&sysgpio 28 GPIO_ACTIVE_LOW>;
>> +       pinctrl-0 = <&pcie1_pins>;
>> +       status = "okay";
>> +};
>> +
>>  &uart0 {
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&uart0_pins>;
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> index 02354e642c44..7a5dc43cf63c 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -629,5 +629,91 @@
>>                         #reset-cells = <1>;
>>                         power-domains = <&pwrc JH7110_PD_VOUT>;
>>                 };
>> +
>> +               pcie0: pcie@940000000 {
>> +                       compatible = "starfive,jh7110-pcie";
>> +                       reg = <0x9 0x40000000 0x0 0x1000000>,
>> +                             <0x0 0x2b000000 0x0 0x100000>;
>> +                       reg-names = "cfg", "apb";
>> +                       #address-cells = <3>;
>> +                       #size-cells = <2>;
>> +                       #interrupt-cells = <1>;
>> +                       ranges = <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0x08000000>,
>> +                                <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x40000000>;
>> +                       interrupts = <56>;
>> +                       interrupt-parent = <&plic>;
>> +                       interrupt-map-mask = <0x0 0x0 0x0 0x7>;
>> +                       interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc0 0x1>,
>> +                                       <0x0 0x0 0x0 0x2 &pcie_intc0 0x2>,
>> +                                       <0x0 0x0 0x0 0x3 &pcie_intc0 0x3>,
>> +                                       <0x0 0x0 0x0 0x4 &pcie_intc0 0x4>;
>> +                       msi-controller;
>> +                       device_type = "pci";
>> +                       starfive,stg-syscon = <&stg_syscon>;
>> +                       bus-range = <0x0 0xff>;
>> +                       clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
>> +                                <&stgcrg JH7110_STGCLK_PCIE0_TL>,
>> +                                <&stgcrg JH7110_STGCLK_PCIE0_AXI_MST0>,
>> +                                <&stgcrg JH7110_STGCLK_PCIE0_APB>;
>> +                       clock-names = "noc", "tl", "axi_mst0", "apb";
>> +                       resets = <&stgcrg JH7110_STGRST_PCIE0_AXI_MST0>,
>> +                                <&stgcrg JH7110_STGRST_PCIE0_AXI_SLV0>,
>> +                                <&stgcrg JH7110_STGRST_PCIE0_AXI_SLV>,
>> +                                <&stgcrg JH7110_STGRST_PCIE0_BRG>,
>> +                                <&stgcrg JH7110_STGRST_PCIE0_CORE>,
>> +                                <&stgcrg JH7110_STGRST_PCIE0_APB>;
>> +                       reset-names = "mst0", "slv0", "slv", "brg",
>> +                                     "core", "apb";
>> +                       status = "disabled";
>> +
>> +                       pcie_intc0: interrupt-controller {
>> +                               #address-cells = <0>;
>> +                               #interrupt-cells = <1>;
>> +                               interrupt-controller;
>> +                       };
>> +               };
>> +
>> +               pcie1: pcie@9c0000000 {
>> +                       compatible = "starfive,jh7110-pcie";
>> +                       reg = <0x9 0xc0000000 0x0 0x1000000>,
>> +                             <0x0 0x2c000000 0x0 0x100000>;
>> +                       reg-names = "cfg", "apb";
>> +                       #address-cells = <3>;
>> +                       #size-cells = <2>;
>> +                       #interrupt-cells = <1>;
>> +                       ranges = <0x82000000  0x0 0x38000000  0x0 0x38000000 0x0 0x08000000>,
>> +                                <0xc3000000  0x9 0x80000000  0x9 0x80000000 0x0 0x40000000>;
>> +                       interrupts = <57>;
>> +                       interrupt-parent = <&plic>;
>> +                       interrupt-map-mask = <0x0 0x0 0x0 0x7>;
>> +                       interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc1 0x1>,
>> +                                       <0x0 0x0 0x0 0x2 &pcie_intc1 0x2>,
>> +                                       <0x0 0x0 0x0 0x3 &pcie_intc1 0x3>,
>> +                                       <0x0 0x0 0x0 0x4 &pcie_intc1 0x4>;
>> +                       msi-controller;
>> +                       device_type = "pci";
>> +                       starfive,stg-syscon = <&stg_syscon>;
>> +                       bus-range = <0x0 0xff>;
>> +                       clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
>> +                                <&stgcrg JH7110_STGCLK_PCIE1_TL>,
>> +                                <&stgcrg JH7110_STGCLK_PCIE1_AXI_MST0>,
>> +                                <&stgcrg JH7110_STGCLK_PCIE1_APB>;
>> +                       clock-names = "noc", "tl", "axi_mst0", "apb";
>> +                       resets = <&stgcrg JH7110_STGRST_PCIE1_AXI_MST0>,
>> +                                <&stgcrg JH7110_STGRST_PCIE1_AXI_SLV0>,
>> +                                <&stgcrg JH7110_STGRST_PCIE1_AXI_SLV>,
>> +                                <&stgcrg JH7110_STGRST_PCIE1_BRG>,
>> +                                <&stgcrg JH7110_STGRST_PCIE1_CORE>,
>> +                                <&stgcrg JH7110_STGRST_PCIE1_APB>;
>> +                       reset-names = "mst0", "slv0", "slv", "brg",
>> +                                     "core", "apb";
>> +                       status = "disabled";
>> +
>> +                       pcie_intc1: interrupt-controller {
>> +                               #address-cells = <0>;
>> +                               #interrupt-cells = <1>;
>> +                               interrupt-controller;
>> +                       };
>> +               };
>>         };
>>  };
>> --
>> 2.17.1
>>
