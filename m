Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AA67979CA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Sep 2023 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242978AbjIGRUy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Sep 2023 13:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243118AbjIGRUt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2023 13:20:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013171997;
        Thu,  7 Sep 2023 10:20:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BAFC433BA;
        Thu,  7 Sep 2023 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694107178;
        bh=PDYzKzKBiT+TNRB0Vx9DGh637mV1YPZ7MK8eR9exGSM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JMkXUvGT/Y966Dbf7awJ/2xSLEzBMKgM2X9b5kTlxjxVl5sVC6scLZDEq69QyshBv
         MPNfAjyRobt7/cKZhggS1TQ1E5gZ4sMU22/F6OboC086P6ANUtmX5TM1AmSN4eD4JT
         DjA99JZd5+p9lwJF7ntmpu7RNgVfTyXBIPubtW3NXuR/wCfC1AOLp0fYn47glSHuSg
         dFO5+D/MvNUaFHh2PMqpx8YaLPe7qf4Mv0VSDqhVR6eLZhVkiVAwfFezotmKNTcFGz
         yIv0smcgHsTQbBZecI1B8q9oVf4jbxjSLXDOjCgigAU3U5vz8ByvUDTRpMUjwcF9oA
         nyozRGnecgqaA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b962c226ceso20790601fa.3;
        Thu, 07 Sep 2023 10:19:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YxQLZWJVMrvW4SZCTny3ZiBk5HWocTCS/bBhFT50cFn4+pjXd5h
        aD6Uq5G0LVCo6tq9pzKDr9uzsDYFv4z31OV/tw==
X-Google-Smtp-Source: AGHT+IHwjbAmkZ5Ec05zBPZFrd7GQGZKn4oCw4jlv8sjHh+612eF77vIQwMOoqyB67ypCSbg/TV0tjClokFnPf/SQgg=
X-Received: by 2002:a2e:9303:0:b0:2bc:f252:6cc4 with SMTP id
 e3-20020a2e9303000000b002bcf2526cc4mr4293480ljh.10.1694107176462; Thu, 07 Sep
 2023 10:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230907091058.125630-1-minda.chen@starfivetech.com> <20230907091058.125630-12-minda.chen@starfivetech.com>
In-Reply-To: <20230907091058.125630-12-minda.chen@starfivetech.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 7 Sep 2023 12:19:24 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+TeDK0Lh7Yf9CwLPDPfvuv9C8A6dKDEBVxMtncyuzQQg@mail.gmail.com>
Message-ID: <CAL_Jsq+TeDK0Lh7Yf9CwLPDPfvuv9C8A6dKDEBVxMtncyuzQQg@mail.gmail.com>
Subject: Re: [PATCH v5 11/11] riscv: dts: starfive: add PCIe dts configuration
 for JH7110
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 7, 2023 at 4:11=E2=80=AFAM Minda Chen <minda.chen@starfivetech.=
com> wrote:
>
> Add PCIe dts configuraion for JH7110 SoC platform.
>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 64 ++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 86 +++++++++++++++++++
>  2 files changed, 150 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dt=
si b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index de0f40a8be93..4dd61e2fec7d 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -15,6 +15,8 @@
>                 i2c2 =3D &i2c2;
>                 i2c5 =3D &i2c5;
>                 i2c6 =3D &i2c6;
> +               pcie0 =3D &pcie0;
> +               pcie1 =3D &pcie1;

That's not a defined alias. We already have "linux,pci-domain" if you
need to number PCI host bridges.

>                 serial0 =3D &uart0;
>         };
>
> @@ -208,6 +210,54 @@
>                 };
>         };
>
> +       pcie0_pins: pcie0-0 {
> +               wake-pins {
> +                       pinmux =3D <GPIOMUX(32, GPOUT_LOW,
> +                                             GPOEN_DISABLE,
> +                                             GPI_NONE)>;
> +                       bias-pull-up;
> +                       drive-strength =3D <2>;
> +                       input-enable;
> +                       input-schmitt-disable;
> +                       slew-rate =3D <0>;
> +               };
> +
> +               clkreq-pins {
> +                       pinmux =3D <GPIOMUX(27, GPOUT_LOW,
> +                                             GPOEN_DISABLE,
> +                                             GPI_NONE)>;
> +                       bias-pull-down;
> +                       drive-strength =3D <2>;
> +                       input-enable;
> +                       input-schmitt-disable;
> +                       slew-rate =3D <0>;
> +               };
> +       };
> +
> +       pcie1_pins: pcie1-0 {
> +               wake-pins {
> +                       pinmux =3D <GPIOMUX(21, GPOUT_LOW,
> +                                             GPOEN_DISABLE,
> +                                             GPI_NONE)>;
> +                       bias-pull-up;
> +                       drive-strength =3D <2>;
> +                       input-enable;
> +                       input-schmitt-disable;
> +                       slew-rate =3D <0>;
> +               };
> +
> +               clkreq-pins {
> +                       pinmux =3D <GPIOMUX(29, GPOUT_LOW,
> +                                             GPOEN_DISABLE,
> +                                             GPI_NONE)>;
> +                       bias-pull-down;
> +                       drive-strength =3D <2>;
> +                       input-enable;
> +                       input-schmitt-disable;
> +                       slew-rate =3D <0>;
> +               };
> +       };
> +
>         uart0_pins: uart0-0 {
>                 tx-pins {
>                         pinmux =3D <GPIOMUX(5, GPOUT_SYS_UART0_TX,
> @@ -233,6 +283,20 @@
>         };
>  };
>
> +&pcie0 {
> +       pinctrl-names =3D "default";
> +       perst-gpios =3D <&sysgpio 26 GPIO_ACTIVE_LOW>;
> +       pinctrl-0 =3D <&pcie0_pins>;
> +       status =3D "okay";
> +};
> +
> +&pcie1 {
> +       pinctrl-names =3D "default";
> +       perst-gpios =3D <&sysgpio 28 GPIO_ACTIVE_LOW>;
> +       pinctrl-0 =3D <&pcie1_pins>;
> +       status =3D "okay";
> +};
> +
>  &uart0 {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&uart0_pins>;
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> index 02354e642c44..7a5dc43cf63c 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -629,5 +629,91 @@
>                         #reset-cells =3D <1>;
>                         power-domains =3D <&pwrc JH7110_PD_VOUT>;
>                 };
> +
> +               pcie0: pcie@940000000 {
> +                       compatible =3D "starfive,jh7110-pcie";
> +                       reg =3D <0x9 0x40000000 0x0 0x1000000>,
> +                             <0x0 0x2b000000 0x0 0x100000>;
> +                       reg-names =3D "cfg", "apb";
> +                       #address-cells =3D <3>;
> +                       #size-cells =3D <2>;
> +                       #interrupt-cells =3D <1>;
> +                       ranges =3D <0x82000000  0x0 0x30000000  0x0 0x300=
00000 0x0 0x08000000>,
> +                                <0xc3000000  0x9 0x00000000  0x9 0x00000=
000 0x0 0x40000000>;
> +                       interrupts =3D <56>;
> +                       interrupt-parent =3D <&plic>;
> +                       interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
> +                       interrupt-map =3D <0x0 0x0 0x0 0x1 &pcie_intc0 0x=
1>,
> +                                       <0x0 0x0 0x0 0x2 &pcie_intc0 0x2>=
,
> +                                       <0x0 0x0 0x0 0x3 &pcie_intc0 0x3>=
,
> +                                       <0x0 0x0 0x0 0x4 &pcie_intc0 0x4>=
;
> +                       msi-controller;
> +                       device_type =3D "pci";
> +                       starfive,stg-syscon =3D <&stg_syscon>;
> +                       bus-range =3D <0x0 0xff>;
> +                       clocks =3D <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI=
>,
> +                                <&stgcrg JH7110_STGCLK_PCIE0_TL>,
> +                                <&stgcrg JH7110_STGCLK_PCIE0_AXI_MST0>,
> +                                <&stgcrg JH7110_STGCLK_PCIE0_APB>;
> +                       clock-names =3D "noc", "tl", "axi_mst0", "apb";
> +                       resets =3D <&stgcrg JH7110_STGRST_PCIE0_AXI_MST0>=
,
> +                                <&stgcrg JH7110_STGRST_PCIE0_AXI_SLV0>,
> +                                <&stgcrg JH7110_STGRST_PCIE0_AXI_SLV>,
> +                                <&stgcrg JH7110_STGRST_PCIE0_BRG>,
> +                                <&stgcrg JH7110_STGRST_PCIE0_CORE>,
> +                                <&stgcrg JH7110_STGRST_PCIE0_APB>;
> +                       reset-names =3D "mst0", "slv0", "slv", "brg",
> +                                     "core", "apb";
> +                       status =3D "disabled";
> +
> +                       pcie_intc0: interrupt-controller {
> +                               #address-cells =3D <0>;
> +                               #interrupt-cells =3D <1>;
> +                               interrupt-controller;
> +                       };
> +               };
> +
> +               pcie1: pcie@9c0000000 {
> +                       compatible =3D "starfive,jh7110-pcie";
> +                       reg =3D <0x9 0xc0000000 0x0 0x1000000>,
> +                             <0x0 0x2c000000 0x0 0x100000>;
> +                       reg-names =3D "cfg", "apb";
> +                       #address-cells =3D <3>;
> +                       #size-cells =3D <2>;
> +                       #interrupt-cells =3D <1>;
> +                       ranges =3D <0x82000000  0x0 0x38000000  0x0 0x380=
00000 0x0 0x08000000>,
> +                                <0xc3000000  0x9 0x80000000  0x9 0x80000=
000 0x0 0x40000000>;
> +                       interrupts =3D <57>;
> +                       interrupt-parent =3D <&plic>;
> +                       interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
> +                       interrupt-map =3D <0x0 0x0 0x0 0x1 &pcie_intc1 0x=
1>,
> +                                       <0x0 0x0 0x0 0x2 &pcie_intc1 0x2>=
,
> +                                       <0x0 0x0 0x0 0x3 &pcie_intc1 0x3>=
,
> +                                       <0x0 0x0 0x0 0x4 &pcie_intc1 0x4>=
;
> +                       msi-controller;
> +                       device_type =3D "pci";
> +                       starfive,stg-syscon =3D <&stg_syscon>;
> +                       bus-range =3D <0x0 0xff>;
> +                       clocks =3D <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI=
>,
> +                                <&stgcrg JH7110_STGCLK_PCIE1_TL>,
> +                                <&stgcrg JH7110_STGCLK_PCIE1_AXI_MST0>,
> +                                <&stgcrg JH7110_STGCLK_PCIE1_APB>;
> +                       clock-names =3D "noc", "tl", "axi_mst0", "apb";
> +                       resets =3D <&stgcrg JH7110_STGRST_PCIE1_AXI_MST0>=
,
> +                                <&stgcrg JH7110_STGRST_PCIE1_AXI_SLV0>,
> +                                <&stgcrg JH7110_STGRST_PCIE1_AXI_SLV>,
> +                                <&stgcrg JH7110_STGRST_PCIE1_BRG>,
> +                                <&stgcrg JH7110_STGRST_PCIE1_CORE>,
> +                                <&stgcrg JH7110_STGRST_PCIE1_APB>;
> +                       reset-names =3D "mst0", "slv0", "slv", "brg",
> +                                     "core", "apb";
> +                       status =3D "disabled";
> +
> +                       pcie_intc1: interrupt-controller {
> +                               #address-cells =3D <0>;
> +                               #interrupt-cells =3D <1>;
> +                               interrupt-controller;
> +                       };
> +               };
>         };
>  };
> --
> 2.17.1
>
