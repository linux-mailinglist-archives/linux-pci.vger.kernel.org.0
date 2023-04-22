Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117086EB65E
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 02:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjDVATR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 20:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjDVATO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 20:19:14 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593D5199C
        for <linux-pci@vger.kernel.org>; Fri, 21 Apr 2023 17:19:12 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-555e853d3c5so12620037b3.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Apr 2023 17:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682122751; x=1684714751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ESHAo7g+MyXil/Szk2ev8aRxIS1miEenAzN6woVU7Lw=;
        b=RS0Krm0pZvCyvF1mLoPggvbtgHHFsAfiIP02OwyFDMlTE/tYNKF0wr0VmrVMpA2sj3
         nzDRyJad+kOWWKEmQN1HZ9Z3g9Ppq7JpHGAmt+6X5dKHUyHmZookXSBqPQ3nY9aY79/N
         zU4irG/ErQ/RV2usZ1PWr30oy9S9Oif3Rbo39m8aqC/kwfyVb07872/HbO8Az7I8nWLX
         Fic0apcOBgnSUV3PVJLk0iyvfLnp6OW/CdndfaWk7kI+fxhv8kzdqdar9/YbTF5UGbb0
         RgeVIVEpjKV5BK/b/al0WOs3D9/axsr8wpvPva+egaNEo6M/kbqJ7q+PT20ajng2peCf
         ii2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682122751; x=1684714751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESHAo7g+MyXil/Szk2ev8aRxIS1miEenAzN6woVU7Lw=;
        b=AlLKEGfZt3T64FsSkZXEq7YEyp8EjfzedwpuLEczu3mBiLIJ1R2PbK5tJo6ZuX4/Ho
         ypgqEFbEgLKGG8kkXsSyF5d+k5RYRKu5S1f6Jz0/X5VNu3tY7LCDl+/ks17/bD3NMqGX
         ytTjVdUwH1IRRuavaLXcVeaTJSF403yxs0H0p3Xnf84/GMSE4o04MpxKsPRojUqlYcmn
         /cMMZmq6HM7Ny80hUZVtyp1AhqTw8olXLM3uMfmcGF3psxzvojIQdUoWdzeIFISj33D7
         9zuFNGgtO1UVfNbZIrhWJUYola8gLv9M2NAOV0w7QqPRiV33+RUNDPz5+SO6VV2wlxnR
         Sj2Q==
X-Gm-Message-State: AAQBX9fW+TTVVqh+zRDbnEMew5LPp9ZusrTFOn6wKGEh3hl0ERxC8DjK
        JmUHzIN2OgUMj4DdkTdDH6BKwxn3erX1DyfHtlP1zw==
X-Google-Smtp-Source: AKy350bYi6sl1UOo+946VkOehVgt0eQvMyyMbFMwc7DtvoEky1L+WECf7Zv5EO/lnVVCi8/YpngujIDYsAraWyBmTX0=
X-Received: by 2002:a0d:dd86:0:b0:556:106f:c0c0 with SMTP id
 g128-20020a0ddd86000000b00556106fc0c0mr3581486ywe.41.1682122751404; Fri, 21
 Apr 2023 17:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230421124938.21974-1-quic_devipriy@quicinc.com> <20230421124938.21974-5-quic_devipriy@quicinc.com>
In-Reply-To: <20230421124938.21974-5-quic_devipriy@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 22 Apr 2023 03:19:00 +0300
Message-ID: <CAA8EJppyro1wM3KmDU3DVjKCqXH5+KaNoT_7ObVuuYNMoZKpoA@mail.gmail.com>
Subject: Re: [PATCH V3 4/6] arm64: dts: qcom: ipq9574: Add PCIe PHYs and
 controller nodes
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, mani@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 21 Apr 2023 at 15:50, Devi Priya <quic_devipriy@quicinc.com> wrote:
>
> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
> found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane Gen3
> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
>
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V3:
>         - Fixed up the PCI I/O port ranges
>
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 375 +++++++++++++++++++++++++-
>  1 file changed, 370 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index e757b57957cf..953a839a1141 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -6,8 +6,8 @@
>   * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>
>  / {
> @@ -116,6 +116,58 @@
>                 #size-cells = <1>;
>                 ranges = <0 0 0 0xffffffff>;
>
> +               pcie0_phy: phy@84000 {
> +                       compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
> +                       reg = <0x00084000 0x1000>;
> +
> +                       clocks = <&gcc GCC_PCIE0_AUX_CLK>,
> +                                <&gcc GCC_PCIE0_AHB_CLK>,
> +                                <&gcc GCC_ANOC_PCIE0_1LANE_M_CLK>,
> +                                <&gcc GCC_SNOC_PCIE0_1LANE_S_CLK>,
> +                                <&gcc GCC_PCIE0_PIPE_CLK>;
> +                       clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane", "pipe";
> +
> +                       assigned-clocks = <&gcc GCC_PCIE0_AUX_CLK>;
> +                       assigned-clock-rates = <20000000>;
> +
> +                       resets = <&gcc GCC_PCIE0_PHY_BCR>,
> +                                <&gcc GCC_PCIE0PHY_PHY_BCR>;
> +                       reset-names = "phy", "common";
> +
> +                       #clock-cells = <0>;
> +                       clock-output-names = "gcc_pcie0_pipe_clk_src";
> +
> +                       #phy-cells = <0>;
> +                       status = "disabled";
> +
> +               };
> +
> +               pcie2_phy: phy@8c000 {
> +                       compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
> +                       reg = <0x0008c000 0x2000>;
> +
> +                       clocks = <&gcc GCC_PCIE2_AUX_CLK>,
> +                                <&gcc GCC_PCIE2_AHB_CLK>,
> +                                <&gcc GCC_ANOC_PCIE2_2LANE_M_CLK>,
> +                                <&gcc GCC_SNOC_PCIE2_2LANE_S_CLK>,
> +                                <&gcc GCC_PCIE2_PIPE_CLK>;
> +                       clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane", "pipe";
> +
> +                       assigned-clocks = <&gcc GCC_PCIE2_AUX_CLK>;
> +                       assigned-clock-rates = <20000000>;
> +
> +                       resets = <&gcc GCC_PCIE2_PHY_BCR>,
> +                                <&gcc GCC_PCIE2PHY_PHY_BCR>;
> +                       reset-names = "phy", "common";
> +
> +                       #clock-cells = <0>;
> +                       clock-output-names = "gcc_pcie2_pipe_clk_src";
> +
> +                       #phy-cells = <0>;
> +                       status = "disabled";
> +
> +               };
> +
>                 rng: rng@e3000 {
>                         compatible = "qcom,prng-ee";
>                         reg = <0x000e3000 0x1000>;
> @@ -123,6 +175,58 @@
>                         clock-names = "core";
>                 };
>
> +               pcie3_phy: phy@f4000 {
> +                       compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
> +                       reg = <0x000f4000 0x2000>;
> +
> +                       clocks = <&gcc GCC_PCIE3_AUX_CLK>,
> +                                <&gcc GCC_PCIE3_AHB_CLK>,
> +                                <&gcc GCC_ANOC_PCIE3_2LANE_M_CLK>,
> +                                <&gcc GCC_SNOC_PCIE3_2LANE_S_CLK>,
> +                                <&gcc GCC_PCIE3_PIPE_CLK>;
> +                       clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane", "pipe";
> +
> +                       assigned-clocks = <&gcc GCC_PCIE3_AUX_CLK>;
> +                       assigned-clock-rates = <20000000>;
> +
> +                       resets = <&gcc GCC_PCIE3_PHY_BCR>,
> +                                <&gcc GCC_PCIE3PHY_PHY_BCR>;
> +                       reset-names = "phy", "common";
> +
> +                       #clock-cells = <0>;
> +                       clock-output-names = "gcc_pcie3_pipe_clk_src";
> +
> +                       #phy-cells = <0>;
> +                       status = "disabled";
> +
> +               };
> +
> +               pcie1_phy: phy@fc000 {
> +                       compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
> +                       reg = <0x000fc000 0x1000>;
> +
> +                       clocks = <&gcc GCC_PCIE1_AUX_CLK>,
> +                                <&gcc GCC_PCIE1_AHB_CLK>,
> +                                <&gcc GCC_ANOC_PCIE1_1LANE_M_CLK>,
> +                                <&gcc GCC_SNOC_PCIE1_1LANE_S_CLK>,
> +                                <&gcc GCC_PCIE1_PIPE_CLK>;
> +                       clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane", "pipe";
> +
> +                       assigned-clocks = <&gcc GCC_PCIE1_AUX_CLK>;
> +                       assigned-clock-rates = <20000000>;
> +
> +                       resets = <&gcc GCC_PCIE1_PHY_BCR>,
> +                                <&gcc GCC_PCIE1PHY_PHY_BCR>;
> +                       reset-names = "phy", "common";
> +
> +                       #clock-cells = <0>;
> +                       clock-output-names = "gcc_pcie1_pipe_clk_src";
> +
> +                       #phy-cells = <0>;
> +                       status = "disabled";
> +
> +               };
> +
>                 tlmm: pinctrl@1000000 {
>                         compatible = "qcom,ipq9574-tlmm";
>                         reg = <0x01000000 0x300000>;
> @@ -146,10 +250,10 @@
>                         reg = <0x01800000 0x80000>;
>                         clocks = <&xo_board_clk>,
>                                  <&sleep_clk>,
> -                                <0>,
> -                                <0>,
> -                                <0>,
> -                                <0>,
> +                                <&pcie0_phy>,
> +                                <&pcie1_phy>,
> +                                <&pcie2_phy>,
> +                                <&pcie3_phy>,
>                                  <0>;
>                         #clock-cells = <1>;
>                         #reset-cells = <1>;
> @@ -478,6 +582,267 @@
>                                 status = "disabled";
>                         };
>                 };
> +
> +               pcie1: pci@10000000 {
> +                       compatible = "qcom,pcie-ipq9574";
> +                       reg =  <0x10000000 0xf1d>,
> +                              <0x10000F20 0xa8>,
> +                              <0x10001000 0x1000>,
> +                              <0x000F8000 0x4000>,
> +                              <0x10100000 0x1000>;
> +                       reg-names = "dbi", "elbi", "atu", "parf", "config";
> +                       device_type = "pci";
> +                       linux,pci-domain = <2>;
> +                       bus-range = <0x00 0xff>;
> +                       num-lanes = <1>;
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +
> +                       ranges = <0x01000000 0x0 0x00000000 0x10200000 0x0 0x100000>,  /* I/O */
> +                                <0x02000000 0x0 0x10300000 0x10300000 0x0 0x7d00000>; /* MEM */
> +
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0x7>;
> +                       interrupt-map = <0 0 0 1 &intc 0 35 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +                                       <0 0 0 2 &intc 0 49 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +                                       <0 0 0 3 &intc 0 84 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +                                       <0 0 0 4 &intc 0 85 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +

No iommu-map?

> +                       interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "global_irq";
> +
> +                       /* clocks and clock-names are used to enable the clock in CBCR */
> +                       clocks = <&gcc GCC_PCIE1_AHB_CLK>,
> +                                <&gcc GCC_PCIE1_AUX_CLK>,
> +                                <&gcc GCC_PCIE1_AXI_M_CLK>,
> +                                <&gcc GCC_PCIE1_AXI_S_CLK>,
> +                                <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>,
> +                                <&gcc GCC_PCIE1_RCHNG_CLK>;
> +                       clock-names = "ahb",
> +                                     "aux",
> +                                     "axi_m",
> +                                     "axi_s",
> +                                     "axi_bridge",
> +                                     "rchng";
> +
> +                       resets = <&gcc GCC_PCIE1_PIPE_ARES>,
> +                                <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
> +                                <&gcc GCC_PCIE1_AXI_S_STICKY_ARES>,
> +                                <&gcc GCC_PCIE1_AXI_S_ARES>,
> +                                <&gcc GCC_PCIE1_AXI_M_STICKY_ARES>,
> +                                <&gcc GCC_PCIE1_AXI_M_ARES>,
> +                                <&gcc GCC_PCIE1_AUX_ARES>,
> +                                <&gcc GCC_PCIE1_AHB_ARES>;
> +                       reset-names = "pipe",
> +                                     "sticky",
> +                                     "axi_s_sticky",
> +                                     "axi_s",
> +                                     "axi_m_sticky",
> +                                     "axi_m",
> +                                     "aux",
> +                                     "ahb";
> +
> +                       phys = <&pcie1_phy>;
> +                       phy-names = "pciephy";
> +                       msi-parent = <&v2m0>;
> +                       status = "disabled";
> +               };
> +
> +               pcie3: pci@18000000 {
> +                       compatible = "qcom,pcie-ipq9574";
> +                       reg =  <0x18000000 0xf1d>,
> +                              <0x18000F20 0xa8>,
> +                              <0x18001000 0x1000>,
> +                              <0x000F0000 0x4000>,
> +                              <0x18100000 0x1000>;
> +                       reg-names = "dbi", "elbi", "atu", "parf", "config";
> +                       device_type = "pci";
> +                       linux,pci-domain = <4>;
> +                       bus-range = <0x00 0xff>;
> +                       num-lanes = <2>;
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +
> +                       ranges = <0x01000000 0x0 0x00000000 0x18200000 0x0 0x100000>,  /* I/O */
> +                                <0x02000000 0x0 0x18300000 0x18300000 0x0 0x7d00000>; /* MEM */
> +
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0x7>;
> +                       interrupt-map = <0 0 0 1 &intc 0 189 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +                                       <0 0 0 2 &intc 0 190 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +                                       <0 0 0 3 &intc 0 191 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +                                       <0 0 0 4 &intc 0 192 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +                       interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "global_irq";
> +
> +                       /* clocks and clock-names are used to enable the clock in CBCR */
> +                       clocks = <&gcc GCC_PCIE3_AHB_CLK>,
> +                                <&gcc GCC_PCIE3_AUX_CLK>,
> +                                <&gcc GCC_PCIE3_AXI_M_CLK>,
> +                                <&gcc GCC_PCIE3_AXI_S_CLK>,
> +                                <&gcc GCC_PCIE3_AXI_S_BRIDGE_CLK>,
> +                                <&gcc GCC_PCIE3_RCHNG_CLK>;
> +                       clock-names = "ahb",
> +                                     "aux",
> +                                     "axi_m",
> +                                     "axi_s",
> +                                     "axi_bridge",
> +                                     "rchng";
> +
> +                       resets = <&gcc GCC_PCIE3_PIPE_ARES>,
> +                                <&gcc GCC_PCIE3_CORE_STICKY_ARES>,
> +                                <&gcc GCC_PCIE3_AXI_S_STICKY_ARES>,
> +                                <&gcc GCC_PCIE3_AXI_S_ARES>,
> +                                <&gcc GCC_PCIE3_AXI_M_STICKY_ARES>,
> +                                <&gcc GCC_PCIE3_AXI_M_ARES>,
> +                                <&gcc GCC_PCIE3_AUX_ARES>,
> +                                <&gcc GCC_PCIE3_AHB_ARES>;
> +                       reset-names = "pipe",
> +                                     "sticky",
> +                                     "axi_s_sticky",
> +                                     "axi_s",
> +                                     "axi_m_sticky",
> +                                     "axi_m",
> +                                     "aux",
> +                                     "ahb";
> +
> +                       phys = <&pcie3_phy>;
> +                       phy-names = "pciephy";
> +                       msi-parent = <&v2m0>;
> +                       status = "disabled";
> +               };
> +
> +               pcie2: pci@20000000 {
> +                       compatible = "qcom,pcie-ipq9574";
> +                       reg =  <0x20000000 0xf1d>,
> +                              <0x20000F20 0xa8>,
> +                              <0x20001000 0x1000>,
> +                              <0x00088000 0x4000>,
> +                              <0x20100000 0x1000>;
> +                       reg-names = "dbi", "elbi", "atu", "parf", "config";
> +                       device_type = "pci";
> +                       linux,pci-domain = <3>;
> +                       bus-range = <0x00 0xff>;
> +                       num-lanes = <2>;
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +
> +                       ranges = <0x01000000 0x0 0x00000000 0x20200000 0x0 0x100000>,  /* I/O */
> +                                <0x02000000 0x0 0x20300000 0x20300000 0x0 0x7d00000>; /* MEM */
> +
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0x7>;
> +                       interrupt-map = <0 0 0 1 &intc 0 164 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +                                       <0 0 0 2 &intc 0 165 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +                                       <0 0 0 3 &intc 0 186 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +                                       <0 0 0 4 &intc 0 187 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +                       interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "global_irq";
> +
> +                       /* clocks and clock-names are used to enable the clock in CBCR */
> +                       clocks = <&gcc GCC_PCIE2_AHB_CLK>,
> +                                <&gcc GCC_PCIE2_AUX_CLK>,
> +                                <&gcc GCC_PCIE2_AXI_M_CLK>,
> +                                <&gcc GCC_PCIE2_AXI_S_CLK>,
> +                                <&gcc GCC_PCIE2_AXI_S_BRIDGE_CLK>,
> +                                <&gcc GCC_PCIE2_RCHNG_CLK>;
> +                       clock-names = "ahb",
> +                                     "aux",
> +                                     "axi_m",
> +                                     "axi_s",
> +                                     "axi_bridge",
> +                                     "rchng";
> +
> +                       resets = <&gcc GCC_PCIE2_PIPE_ARES>,
> +                                <&gcc GCC_PCIE2_CORE_STICKY_ARES>,
> +                                <&gcc GCC_PCIE2_AXI_S_STICKY_ARES>,
> +                                <&gcc GCC_PCIE2_AXI_S_ARES>,
> +                                <&gcc GCC_PCIE2_AXI_M_STICKY_ARES>,
> +                                <&gcc GCC_PCIE2_AXI_M_ARES>,
> +                                <&gcc GCC_PCIE2_AUX_ARES>,
> +                                <&gcc GCC_PCIE2_AHB_ARES>;
> +                       reset-names = "pipe",
> +                                     "sticky",
> +                                     "axi_s_sticky",
> +                                     "axi_s",
> +                                     "axi_m_sticky",
> +                                     "axi_m",
> +                                     "aux",
> +                                     "ahb";
> +
> +                       phys = <&pcie2_phy>;
> +                       phy-names = "pciephy";
> +                       msi-parent = <&v2m0>;
> +                       status = "disabled";
> +               };
> +
> +               pcie0: pci@28000000 {
> +                       compatible = "qcom,pcie-ipq9574";
> +                       reg =  <0x28000000 0xf1d>,
> +                              <0x28000F20 0xa8>,
> +                              <0x28001000 0x1000>,
> +                              <0x00080000 0x4000>,
> +                              <0x28100000 0x1000>;
> +                       reg-names = "dbi", "elbi", "atu", "parf", "config";
> +                       device_type = "pci";
> +                       linux,pci-domain = <1>;
> +                       bus-range = <0x00 0xff>;
> +                       num-lanes = <1>;
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +
> +                       ranges = <0x01000000 0x0 0x00000000 0x28200000 0x0 0x100000>,  /* I/O */
> +                                <0x02000000 0x0 0x28300000 0x28300000 0x0 0x7d00000>; /* MEM */
> +
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0x7>;
> +                       interrupt-map = <0 0 0 1 &intc 0 75 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +                                       <0 0 0 2 &intc 0 78 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +                                       <0 0 0 3 &intc 0 79 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +                                       <0 0 0 4 &intc 0 83 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +                       interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "global_irq";
> +
> +                       /* clocks and clock-names are used to enable the clock in CBCR */
> +                       clocks = <&gcc GCC_PCIE0_AHB_CLK>,
> +                                <&gcc GCC_PCIE0_AUX_CLK>,
> +                                <&gcc GCC_PCIE0_AXI_M_CLK>,
> +                                <&gcc GCC_PCIE0_AXI_S_CLK>,
> +                                <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>,
> +                                <&gcc GCC_PCIE0_RCHNG_CLK>;
> +                       clock-names = "ahb",
> +                                     "aux",
> +                                     "axi_m",
> +                                     "axi_s",
> +                                     "axi_bridge",
> +                                     "rchng";
> +
> +                       resets = <&gcc GCC_PCIE0_PIPE_ARES>,
> +                                <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
> +                                <&gcc GCC_PCIE0_AXI_S_STICKY_ARES>,
> +                                <&gcc GCC_PCIE0_AXI_S_ARES>,
> +                                <&gcc GCC_PCIE0_AXI_M_STICKY_ARES>,
> +                                <&gcc GCC_PCIE0_AXI_M_ARES>,
> +                                <&gcc GCC_PCIE0_AUX_ARES>,
> +                                <&gcc GCC_PCIE0_AHB_ARES>;
> +                       reset-names = "pipe",
> +                                     "sticky",
> +                                     "axi_s_sticky",
> +                                     "axi_s",
> +                                     "axi_m_sticky",
> +                                     "axi_m",
> +                                     "aux",
> +                                     "ahb";
> +
> +                       phys = <&pcie0_phy>;
> +                       phy-names = "pciephy";
> +                       msi-parent = <&v2m0>;
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
