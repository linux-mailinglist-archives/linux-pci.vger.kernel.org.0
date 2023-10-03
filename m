Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934F87B6CFA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 17:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjJCPXR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjJCPXQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 11:23:16 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83673A6
        for <linux-pci@vger.kernel.org>; Tue,  3 Oct 2023 08:23:12 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59f4f80d084so11953757b3.1
        for <linux-pci@vger.kernel.org>; Tue, 03 Oct 2023 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696346592; x=1696951392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AyCUhxsC/xRzFI1DSiEJgfkyYQMNQ9zjzH0+8vXmLBg=;
        b=vDs50P2nsjzvRMdii22wtsHAny6LxuXErabfpZcvVy3ulKFG9HQxTIpxKzFiTOoVGQ
         2B5HP4IC+NQi3sfM95mbyxUZjY8thjVj3Woqw0tBLC9a4vCrVmBO2hQz7aQVXfZhHrMA
         iii/tpApGPjveenFABCmnEZRRonKpWCG7WM++Fzi3xhzKzlVOUxyl8NoRu7HCSgzYIAv
         ePCDDfD0kZH8/99++BnlBUTXO64plmTeBBmUMjkaLuNJbK+gPr6hs1G+EkRwG1bq3YJ/
         RKshPY6VRvQaBRoZK69NhpGjYBE9LVMQpNbKpwMmfbegeiTzcAfrCdOxt4kgAmIkfWMj
         wfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346592; x=1696951392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AyCUhxsC/xRzFI1DSiEJgfkyYQMNQ9zjzH0+8vXmLBg=;
        b=J02NhzUGNcNBF/QguagWE09lA+QQlGVCjYnYH1/J4sctN8kye6q4eQUoFhhUgAr7IX
         SuddF6VQCBnMAl5R0prbNXTJS4mrkrCYeYZ2Zjc6m13uPcj5uqsRsd1tqVC0mK+ohpti
         d46UgwzfyiG34rV6/OS3GPHnGZQZgg5HZiJAWDtiDk2MNaIrbIGuCYiYKKEpu9g2kDKt
         1qEOkoR05FN57sLR3/Ha2kYKERZxvBYjaTd+gO2NgPWee8SxoQaCsEkTe9O2ghKrosRu
         5hqscOQ/Akq0X2ObJSTTqQY5+CGdLTAj9auukM96dH2WrwgbqAONo25jso8Jx6Hhe+dB
         x8JQ==
X-Gm-Message-State: AOJu0YyImWNqJ+mV0hRP/0PIrw5YSNz0+iLfqESBjjfu/Y3c99VrZAW7
        5Z1J2i/eCDdnvJydtmCKIs7y7zDMsHCNSqJqqmKqVw==
X-Google-Smtp-Source: AGHT+IH+PZ35FemJUWRj0WSQP7VIqgEZCKVT1MRfpltpmQOh6qjNq2qjOeZ0AIBw73huKepSXzObXMFSiH+lvZk+70A=
X-Received: by 2002:a0d:d587:0:b0:59f:4c52:2f5d with SMTP id
 x129-20020a0dd587000000b0059f4c522f5dmr14784646ywd.2.1696346591660; Tue, 03
 Oct 2023 08:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231003120846.28626-1-quic_nsekar@quicinc.com> <20231003120846.28626-6-quic_nsekar@quicinc.com>
In-Reply-To: <20231003120846.28626-6-quic_nsekar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 3 Oct 2023 18:23:00 +0300
Message-ID: <CAA8EJpoKq4TVzNHKLjgezTk9je-3OPv4g852anr7SnECJNw2xQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
To:     Nitheesh Sekar <quic_nsekar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        mani@kernel.org, p.zabel@pengutronix.de, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, quic_ipkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 3 Oct 2023 at 15:10, Nitheesh Sekar <quic_nsekar@quicinc.com> wrote:
>
> Add phy and controller nodes for PCIe_x2 and PCIe_x1.
> PCIe_x2 is 2-lane Gen2 and PCIe_x1 is 1-lane Gen2.
>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 186 +++++++++++++++++++++++++-
>  1 file changed, 184 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 38ffdc3cbdcd..0818fdd1e693 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>  #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
> +#include <dt-bindings/gpio/gpio.h>
>
>  / {
>         interrupt-parent = <&intc>;
> @@ -94,6 +95,38 @@
>                 #size-cells = <1>;
>                 ranges = <0 0 0 0xffffffff>;
>
> +               pcie_x1phy: phy@7e000{
> +                       compatible = "qcom,ipq5018-uniphy-pcie-gen2x1";
> +                       reg = <0x0007e000 0x800>;
> +                       #phy-cells = <0>;
> +                       #clock-cells = <0>;
> +                       clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
> +                       clock-names = "pipe_clk";
> +                       clock-output-names = "pcie1_pipe_clk";
> +                       assigned-clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
> +                       assigned-clock-rates = <125000000>;
> +                       resets = <&gcc GCC_PCIE1_PHY_BCR>,
> +                                <&gcc GCC_PCIE1PHY_PHY_BCR>;
> +                       reset-names = "phy", "phy_phy";
> +                       status = "disabled";
> +               };
> +
> +               pcie_x2phy: phy@86000{
> +                       compatible = "qcom,ipq5018-uniphy-pcie-gen2x2";
> +                       reg = <0x00086000 0x800>;
> +                       #phy-cells = <0>;
> +                       #clock-cells = <0>;
> +                       clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
> +                       clock-names = "pipe_clk";
> +                       clock-output-names = "pcie0_pipe_clk";
> +                       assigned-clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
> +                       assigned-clock-rates = <125000000>;

Can this go into the PHY driver?

> +                       resets = <&gcc GCC_PCIE0_PHY_BCR>,
> +                                <&gcc GCC_PCIE0PHY_PHY_BCR>;
> +                       reset-names = "phy", "phy_phy";
> +                       status = "disabled";
> +               };
> +
>                 tlmm: pinctrl@1000000 {
>                         compatible = "qcom,ipq5018-tlmm";
>                         reg = <0x01000000 0x300000>;
> @@ -117,8 +150,8 @@
>                         reg = <0x01800000 0x80000>;
>                         clocks = <&xo_board_clk>,
>                                  <&sleep_clk>,
> -                                <0>,
> -                                <0>,
> +                                <&pcie_x2phy>,
> +                                <&pcie_x1phy>,
>                                  <0>,
>                                  <0>,
>                                  <0>,
> @@ -246,6 +279,155 @@
>                                 status = "disabled";
>                         };
>                 };
> +
> +               pcie_x1: pci@80000000 {
> +                       compatible = "qcom,pcie-ipq5018";
> +                       reg =  <0x80000000 0xf1d

Each address/size tuple should be a separate <> entry.

> +                               0x80000F20 0xa8

lowercase

> +                               0x80001000 0x1000
> +                               0x78000 0x3000

Would you notice why this line stands away from the rest of entries here?

> +                               0x80100000 0x1000>;
> +                       reg-names = "dbi", "elbi", "atu", "parf", "config";
> +                       device_type = "pci";
> +                       linux,pci-domain = <0>;
> +                       bus-range = <0x00 0xff>;
> +                       num-lanes = <1>;
> +                       max-link-speed = <2>;
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +
> +                       phys = <&pcie_x1phy>;
> +                       phy-names ="pciephy";
> +
> +                       ranges = <0x81000000 0 0x80200000 0x80200000
> +                                 0 0x00100000   /* downstream I/O */
> +                                 0x82000000 0 0x80300000 0x80300000
> +                                 0 0x10000000>; /* non-prefetchable memory */
> +
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0x7>;
> +                       interrupt-map = <0 0 0 1 &intc 0 142
> +                                        IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +                                       <0 0 0 2 &intc 0 143
> +                                        IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +                                       <0 0 0 3 &intc 0 144
> +                                        IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +                                       <0 0 0 4 &intc 0 145
> +                                        IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +                       interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "global_irq";
> +
> +                       clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
> +                                <&gcc GCC_PCIE1_AXI_M_CLK>,
> +                                <&gcc GCC_PCIE1_AXI_S_CLK>,
> +                                <&gcc GCC_PCIE1_AHB_CLK>,
> +                                <&gcc GCC_PCIE1_AUX_CLK>,
> +                                <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>;
> +
> +                       clock-names = "iface",
> +                                     "axi_m",
> +                                     "axi_s",
> +                                     "ahb",
> +                                     "aux",
> +                                     "axi_bridge";
> +
> +                       resets = <&gcc GCC_PCIE1_PIPE_ARES>,
> +                                <&gcc GCC_PCIE1_SLEEP_ARES>,
> +                                <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
> +                                <&gcc GCC_PCIE1_AXI_MASTER_ARES>,
> +                                <&gcc GCC_PCIE1_AXI_SLAVE_ARES>,
> +                                <&gcc GCC_PCIE1_AHB_ARES>,
> +                                <&gcc GCC_PCIE1_AXI_MASTER_STICKY_ARES>,
> +                                <&gcc GCC_PCIE1_AXI_SLAVE_STICKY_ARES>;
> +
> +                       reset-names = "pipe",
> +                                     "sleep",
> +                                     "sticky",
> +                                     "axi_m",
> +                                     "axi_s",
> +                                     "ahb",
> +                                     "axi_m_sticky",
> +                                     "axi_s_sticky";
> +
> +                       msi-map = <0x0 &v2m0 0x0 0xff8>;
> +                       status = "disabled";
> +               };
> +
> +               pcie_x2: pci@a0000000 {
> +                       compatible = "qcom,pcie-ipq5018";
> +                       reg =  <0xa0000000 0xf1d
> +                               0xa0000F20 0xa8
> +                               0xa0001000 0x1000
> +                               0x80000 0x3000
> +                               0xa0100000 0x1000>;
> +                       reg-names = "dbi", "elbi", "atu", "parf", "config";
> +                       device_type = "pci";
> +                       linux,pci-domain = <1>;
> +                       bus-range = <0x00 0xff>;
> +                       num-lanes = <2>;
> +                       max-link-speed = <2>;
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +
> +                       phys = <&pcie_x2phy>;
> +                       phy-names ="pciephy";
> +
> +                       ranges = <0x81000000 0 0xa0200000 0xa0200000
> +                                 0 0x00100000   /* downstream I/O */
> +                                 0x82000000 0 0xa0300000 0xa0300000
> +                                 0 0x10000000>; /* non-prefetchable memory */
> +
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0x7>;
> +                       interrupt-map = <0 0 0 1 &intc 0 75
> +                                        IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +                                       <0 0 0 2 &intc 0 78
> +                                        IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +                                       <0 0 0 3 &intc 0 79
> +                                        IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +                                       <0 0 0 4 &intc 0 83
> +                                        IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +                       interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "global_irq";
> +
> +                       clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
> +                                <&gcc GCC_PCIE0_AXI_M_CLK>,
> +                                <&gcc GCC_PCIE0_AXI_S_CLK>,
> +                                <&gcc GCC_PCIE0_AHB_CLK>,
> +                                <&gcc GCC_PCIE0_AUX_CLK>,
> +                                <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>;
> +
> +                       clock-names = "iface",
> +                                     "axi_m",
> +                                     "axi_s",
> +                                     "ahb",
> +                                     "aux",
> +                                     "axi_bridge";
> +
> +                       resets = <&gcc GCC_PCIE0_PIPE_ARES>,
> +                                <&gcc GCC_PCIE0_SLEEP_ARES>,
> +                                <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
> +                                <&gcc GCC_PCIE0_AXI_MASTER_ARES>,
> +                                <&gcc GCC_PCIE0_AXI_SLAVE_ARES>,
> +                                <&gcc GCC_PCIE0_AHB_ARES>,
> +                                <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>,
> +                                <&gcc GCC_PCIE0_AXI_SLAVE_STICKY_ARES>;
> +
> +                       reset-names = "pipe",
> +                                     "sleep",
> +                                     "sticky",
> +                                     "axi_m",
> +                                     "axi_s",
> +                                     "ahb",
> +                                     "axi_m_sticky",
> +                                     "axi_s_sticky";
> +
> +                       msi-map = <0x0 &v2m0 0x0 0xff8>;
> +                       status = "disabled";
> +               };
> +
>         };
>
>         timer {
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
