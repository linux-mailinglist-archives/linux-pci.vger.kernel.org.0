Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6F1327E5
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2019 07:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfFCFMt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 01:12:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35475 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFCFMt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2019 01:12:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id h11so14911370ljb.2
        for <linux-pci@vger.kernel.org>; Sun, 02 Jun 2019 22:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1hhBDceAp7DealibgpzRgQkbsVjG+SPyfDmMhWMC+1k=;
        b=jG9jP4nThSDZwaD/kp6Xib4Vyzog5fkGaOB9Mcgv4DXEGXAX3fPA+ceqLabquL17Cy
         7tX1tYLDfASqHNZdWw9421ZUVBGDAvLcloFKmmp0yrGGjo8RmoLOehp9xgiAKKaLYiez
         8RIVCutou53+Y/XUepTtiE9JghvqzS/w1te3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1hhBDceAp7DealibgpzRgQkbsVjG+SPyfDmMhWMC+1k=;
        b=uZBp07BrCF251XqRhS2aJ9HPEHL315yzPdOuuaEoIQMNikK3D+IRtlXLrFS+oPqFfl
         WmFle3ivemhjbATy7lp6K3+k2xxss5ytJb69XcIgisrdC5KQBn4vH7hsX8hNBORt/zUT
         Acg2yaZwxmqv4N9irvKMS5/xq9flI7mOJRAelBF9CIyN/kJkF7V+T0eUmizYAL++cGaK
         11ozXOETdLXmp56pvb1ctJ8hYAuzaY0ECnPS6O1jNFaB+Ti2jSTQlbKc8BjGYWIpwqC3
         +qZH1Fq+yw0yqJ1vvhrT8IrYP/a2XGNobW8ZX44M37Z9kW/C6O9epJueW9SLMqBml4f+
         s5Fg==
X-Gm-Message-State: APjAAAU8Gjlj75OP43kItfxlSb2TDNKyeGl4SUIiGjUfIMQrAtER23oT
        2vdX653N4YJndrrMd9OyM/6YdjedF+ba1E+Fd9SXG6RBudWylcgGU1DSams20cp28TsQj0vI/a2
        8dxjM7ZLo/2boNe9/2HDjEaMDb/utng==
X-Google-Smtp-Source: APXvYqyWjAc8SYG4ta2+f5Ybndd/TXrp1FQlRY75lQ4TqUbou9Kfolc0l0Jje5R6RKuhzCRFDrhia/kPvTtHFiIVU30=
X-Received: by 2002:a2e:8555:: with SMTP id u21mr12390145ljj.133.1559538766557;
 Sun, 02 Jun 2019 22:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190528065129.8769-1-Zhiqiang.Hou@nxp.com> <20190528065129.8769-6-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190528065129.8769-6-Zhiqiang.Hou@nxp.com>
From:   Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Date:   Mon, 3 Jun 2019 10:42:33 +0530
Message-ID: <CAKnKUHH8JU2Bqgq90rfgZ8r0xxB_RMRj16DBBLDhMpg3mwFU2Q@mail.gmail.com>
Subject: Re: [PATCHv6 5/6] arm64: dts: lx2160a: Add PCIe controller DT nodes
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hou Zhiqiang
   Two instances [@3600000 and @3800000] of the six has a different
window count, the RC can not have more than 8 windows.
apio-wins = <256>;  //Can we change it to 8
ppio-wins = <24>;    //Can we change it to 8

On Tue, May 28, 2019 at 12:20 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> The LX2160A integrated 6 PCIe Gen4 controllers.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V6:
>  - No change.
>
>  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 163 ++++++++++++++++++
>  1 file changed, 163 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index 125a8cc2c5b3..7a2b91ff1fbc 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -964,5 +964,168 @@
>                                 };
>                         };
>                 };
> +
> +               pcie@3400000 {
> +                       compatible = "fsl,lx2160a-pcie";
> +                       reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
> +                              0x80 0x00000000 0x0 0x00001000>; /* configuration space */
> +                       reg-names = "csr_axi_slave", "config_axi_slave";
> +                       interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
> +                                    <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +                                    <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> +                       interrupt-names = "aer", "pme", "intr";
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       device_type = "pci";
> +                       dma-coherent;
> +                       apio-wins = <8>;
> +                       ppio-wins = <8>;
> +                       bus-range = <0x0 0xff>;
> +                       ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +                       msi-parent = <&its>;
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 7>;
> +                       interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +               };
> +
> +               pcie@3500000 {
> +                       compatible = "fsl,lx2160a-pcie";
> +                       reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
> +                              0x88 0x00000000 0x0 0x00001000>; /* configuration space */
> +                       reg-names = "csr_axi_slave", "config_axi_slave";
> +                       interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
> +                                    <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +                                    <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> +                       interrupt-names = "aer", "pme", "intr";
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       device_type = "pci";
> +                       dma-coherent;
> +                       apio-wins = <8>;
> +                       ppio-wins = <8>;
> +                       bus-range = <0x0 0xff>;
> +                       ranges = <0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +                       msi-parent = <&its>;
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 7>;
> +                       interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 2 &gic 0 0 GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 3 &gic 0 0 GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 4 &gic 0 0 GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +               };
> +
> +               pcie@3600000 {
> +                       compatible = "fsl,lx2160a-pcie";
> +                       reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
> +                              0x90 0x00000000 0x0 0x00001000>; /* configuration space */
> +                       reg-names = "csr_axi_slave", "config_axi_slave";
> +                       interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
> +                                    <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +                                    <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> +                       interrupt-names = "aer", "pme", "intr";
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       device_type = "pci";
> +                       dma-coherent;
> +                       apio-wins = <256>;
> +                       ppio-wins = <24>;
> +                       bus-range = <0x0 0xff>;
> +                       ranges = <0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +                       msi-parent = <&its>;
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 7>;
> +                       interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 2 &gic 0 0 GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 3 &gic 0 0 GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 4 &gic 0 0 GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +               };
> +
> +               pcie@3700000 {
> +                       compatible = "fsl,lx2160a-pcie";
> +                       reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
> +                              0x98 0x00000000 0x0 0x00001000>; /* configuration space */
> +                       reg-names = "csr_axi_slave", "config_axi_slave";
> +                       interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
> +                                    <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +                                    <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> +                       interrupt-names = "aer", "pme", "intr";
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       device_type = "pci";
> +                       dma-coherent;
> +                       apio-wins = <8>;
> +                       ppio-wins = <8>;
> +                       bus-range = <0x0 0xff>;
> +                       ranges = <0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +                       msi-parent = <&its>;
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 7>;
> +                       interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 2 &gic 0 0 GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 3 &gic 0 0 GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 4 &gic 0 0 GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +               };
> +
> +               pcie@3800000 {
> +                       compatible = "fsl,lx2160a-pcie";
> +                       reg = <0x00 0x03800000 0x0 0x00100000   /* controller registers */
> +                              0xa0 0x00000000 0x0 0x00001000>; /* configuration space */
> +                       reg-names = "csr_axi_slave", "config_axi_slave";
> +                       interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
> +                                    <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +                                    <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> +                       interrupt-names = "aer", "pme", "intr";
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       device_type = "pci";
> +                       dma-coherent;
> +                       apio-wins = <256>;
> +                       ppio-wins = <24>;
> +                       bus-range = <0x0 0xff>;
> +                       ranges = <0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +                       msi-parent = <&its>;
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 7>;
> +                       interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 2 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 3 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 4 &gic 0 0 GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +               };
> +
> +               pcie@3900000 {
> +                       compatible = "fsl,lx2160a-pcie";
> +                       reg = <0x00 0x03900000 0x0 0x00100000   /* controller registers */
> +                              0xa8 0x00000000 0x0 0x00001000>; /* configuration space */
> +                       reg-names = "csr_axi_slave", "config_axi_slave";
> +                       interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
> +                                    <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +                                    <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> +                       interrupt-names = "aer", "pme", "intr";
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       device_type = "pci";
> +                       dma-coherent;
> +                       apio-wins = <8>;
> +                       ppio-wins = <8>;
> +                       bus-range = <0x0 0xff>;
> +                       ranges = <0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +                       msi-parent = <&its>;
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 7>;
> +                       interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 2 &gic 0 0 GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 3 &gic 0 0 GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0000 0 0 4 &gic 0 0 GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +               };
> +
>         };
>  };
> --
> 2.17.1
>


-- 
Thanks,
Regards,
Karthikeyan Mitran

-- 
Mobiveil INC., CONFIDENTIALITY NOTICE: This e-mail message, including any 
attachments, is for the sole use of the intended recipient(s) and may 
contain proprietary confidential or privileged information or otherwise be 
protected by law. Any unauthorized review, use, disclosure or distribution 
is prohibited. If you are not the intended recipient, please notify the 
sender and destroy all copies and the original message.
