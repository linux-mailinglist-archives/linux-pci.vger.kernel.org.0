Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D557F4CA492
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 13:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiCBMQF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 07:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbiCBMQE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 07:16:04 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFD736E33
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 04:15:20 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id j9-20020a9d7d89000000b005ad5525ba09so1446200otn.10
        for <linux-pci@vger.kernel.org>; Wed, 02 Mar 2022 04:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUFwXsXEYZEu+oIGgcB91oEsPXGOrmtMLsIhR5CWlHQ=;
        b=K+GJnMnnmPy0xnpWKrcYJnOlm6Ixx9a5FVvnDP3g+SyduAfRbi2lB8QPphUS4rbGyB
         GPaz0mbh8ZEFWtYzTSFhgUHeK5jlhHBFAnoMDekkpeOxi4g35fyQEcbisU3TaqOX3lb1
         lFUvaXMiTJUnzMew5pbLGE9nfJtElDDKfxKlvbEjPaBGyPb/eGP2w3gsalvNlhutSMkS
         FIajQkxZUkM0rqsxW8UqSx17xl+3Q/LnyrMmdsoOBJ30l+wXGf7/Tf+VNYFPvDLCfJDY
         5oG6F2nzwfbloUwfii14mTvhSomzeIYf6dF5wef21+X9S0sEsZnV3ZIyb9RA0RK1XMUW
         nV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUFwXsXEYZEu+oIGgcB91oEsPXGOrmtMLsIhR5CWlHQ=;
        b=DveJzfQB4WXTdz9m/aRw+I0ccdPTvxco3b0Qm/DOdChe3frCAKlPGy3+9WBJCVt+lo
         i0BTPMp7YkGUQomQTCVRasyjzj0v1rHMRJXsHaCtV4vWieCX46hfYY/BIrPVVZn42smH
         fMGCgjz2FZz9/lOb4WtW64X9JUS59dBIioWfkB0x+Fp4jN4gOTTaO3svCM3bo0vrsNsi
         CN5DdnhPzKBtFRPQHVce1WEonE2YP+GeRr82gDDVhSqPWJ9HasSNTmxZ3vT9ysq/l0a3
         GTWMvGvCd64+p4CafyGsKRkictPgzPhNE468llVScO+0lsEPqNFopVLuN/tLIqFaLKdy
         d4NQ==
X-Gm-Message-State: AOAM533rAOamAja9OwxJR7EEwJGctYdPPfxzSIN6+VGyyQF1qGck3oD/
        A9jwL1BWahkuYqPpC0r6HPfJyt0PEtIxhFRdl1qByw==
X-Google-Smtp-Source: ABdhPJz7nabcdssWUBUzfv5B4rI9+/X2KC1yncAlsd3QDkMmGwGpF9fCFI3iMIfWq1YQ43PNoTpdJjkcHXpE7i/1ELw=
X-Received: by 2002:a05:6830:314c:b0:5af:dc8a:d066 with SMTP id
 c12-20020a056830314c00b005afdc8ad066mr12948434ots.28.1646223319755; Wed, 02
 Mar 2022 04:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
 <20220301072511.117818-7-bhupesh.sharma@linaro.org> <ce32cafe-8dd9-526d-5413-ad81df7b78eb@linaro.org>
In-Reply-To: <ce32cafe-8dd9-526d-5413-ad81df7b78eb@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 2 Mar 2022 17:45:08 +0530
Message-ID: <CAH=2NtxEvKmq-8ABiozmiizunXQSsUeTrD=+UzsaAeh9hmRfow@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: sm8150: Add pcie nodes for SM8150
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dmitry,

Thanks for the review.

On Tue, 1 Mar 2022 at 17:29, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 01/03/2022 10:25, Bhupesh Sharma wrote:
> > Add nodes for the two PCIe controllers founds on the
> > SM8150 SoC.
> >
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/sm8150.dtsi | 243 +++++++++++++++++++++++++++
> >   1 file changed, 243 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > index 6012322a5984..b97f04ec9c6b 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > @@ -1626,6 +1626,203 @@ system-cache-controller@9200000 {
> >                       interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
> >               };
> >
> > +             pcie0: pci@1c00000 {
> > +                     compatible = "qcom,pcie-sm8150", "snps,dw-pcie";
> > +                     reg = <0 0x01c00000 0 0x3000>,
> > +                           <0 0x60000000 0 0xf1d>,
> > +                           <0 0x60000f20 0 0xa8>,
> > +                           <0 0x60001000 0 0x1000>,
> > +                           <0 0x60100000 0 0x100000>;
> > +                     reg-names = "parf", "dbi", "elbi", "atu", "config";
> > +                     device_type = "pci";
> > +                     linux,pci-domain = <0>;
> > +                     bus-range = <0x00 0xff>;
> > +                     num-lanes = <1>;
> > +
> > +                     #address-cells = <3>;
> > +                     #size-cells = <2>;
> > +
> > +                     ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
> > +                              <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
> > +
> > +                     interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> > +                     interrupt-names = "msi";
> > +                     #interrupt-cells = <1>;
> > +                     interrupt-map-mask = <0 0 0 0x7>;
> > +                     interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> > +                                     <0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> > +                                     <0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> > +                                     <0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> > +
> > +                     clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
> > +                              <&gcc GCC_PCIE_0_AUX_CLK>,
> > +                              <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> > +                              <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> > +                              <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> > +                              <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> > +                              <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
> > +                     clock-names = "pipe",
> > +                                   "aux",
> > +                                   "cfg",
> > +                                   "bus_master",
> > +                                   "bus_slave",
> > +                                   "slave_q2a",
> > +                                   "tbu";
> > +
> > +                     iommus = <&apps_smmu 0x1d80 0x7f>;
> > +                     iommu-map = <0x0   &apps_smmu 0x1d80 0x1>,
> > +                                 <0x100 &apps_smmu 0x1d81 0x1>;
> > +
> > +                     resets = <&gcc GCC_PCIE_0_BCR>;
> > +                     reset-names = "pci";
> > +
> > +                     power-domains = <&gcc PCIE_0_GDSC>;
> > +
> > +                     phys = <&pcie0_lane>;
> > +                     phy-names = "pciephy";
> > +
> > +                     perst-gpio = <&tlmm 35 GPIO_ACTIVE_HIGH>;
> > +                     enable-gpio = <&tlmm 37 GPIO_ACTIVE_HIGH>;
> > +
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&pcie0_default_state>;
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             pcie0_phy: phy@1c06000 {
> > +                     compatible = "qcom,sm8150-qmp-gen3x1-pcie-phy";
> > +                     reg = <0 0x01c06000 0 0x1c0>;
> > +                     #address-cells = <2>;
> > +                     #size-cells = <2>;
> > +                     ranges;
> > +                     clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
> > +                              <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> > +                              <&gcc GCC_PCIE0_PHY_REFGEN_CLK>;
> > +                     clock-names = "aux", "cfg_ahb", "refgen";
> > +
> > +                     resets = <&gcc GCC_PCIE_0_PHY_BCR>;
> > +                     reset-names = "phy";
> > +
> > +                     assigned-clocks = <&gcc GCC_PCIE0_PHY_REFGEN_CLK>;
> > +                     assigned-clock-rates = <100000000>;
> > +
> > +                     status = "disabled";
> > +
> > +                     pcie0_lane: phy@1c06200 {
> > +                             reg = <0 0x1c06200 0 0x170>, /* tx */
> > +                                   <0 0x1c06400 0 0x200>, /* rx */
> > +                                   <0 0x1c06800 0 0x1f0>, /* pcs */
> > +                                   <0 0x1c06c00 0 0xf4>; /* "pcs_lane" same as pcs_misc? */
> > +                             clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
> > +                             clock-names = "pipe0";
> > +
> > +                             #phy-cells = <0>;
> > +                             clock-output-names = "pcie_0_pipe_clk";
> > +                     };
> > +             };
> > +
> > +             pcie1: pci@1c08000 {
> > +                     compatible = "qcom,pcie-sm8150", "snps,dw-pcie";
> > +                     reg = <0 0x01c08000 0 0x3000>,
> > +                           <0 0x40000000 0 0xf1d>,
> > +                           <0 0x40000f20 0 0xa8>,
> > +                           <0 0x40001000 0 0x1000>,
> > +                           <0 0x40100000 0 0x100000>;
> > +                     reg-names = "parf", "dbi", "elbi", "atu", "config";
> > +                     device_type = "pci";
> > +                     linux,pci-domain = <1>;
> > +                     bus-range = <0x00 0xff>;
> > +                     num-lanes = <2>;
> > +
> > +                     #address-cells = <3>;
> > +                     #size-cells = <2>;
> > +
> > +                     ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
> > +                              <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
> > +
> > +                     interrupts = <GIC_SPI 306 IRQ_TYPE_EDGE_RISING>;
>
> This should be 307

Oops. Yes, I will fix it in v3.

Thanks,
Bhupesh

> > +                     interrupt-names = "msi";
> > +                     #interrupt-cells = <1>;
> > +                     interrupt-map-mask = <0 0 0 0x7>;
> > +                     interrupt-map = <0 0 0 1 &intc 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> > +                                     <0 0 0 2 &intc 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> > +                                     <0 0 0 3 &intc 0 438 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> > +                                     <0 0 0 4 &intc 0 439 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> > +
> > +                     clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
> > +                              <&gcc GCC_PCIE_1_AUX_CLK>,
> > +                              <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> > +                              <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
> > +                              <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
> > +                              <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
> > +                              <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
> > +                     clock-names = "pipe",
> > +                                   "aux",
> > +                                   "cfg",
> > +                                   "bus_master",
> > +                                   "bus_slave",
> > +                                   "slave_q2a",
> > +                                   "tbu";
> > +
> > +                     assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
> > +                     assigned-clock-rates = <19200000>;
> > +
> > +                     iommus = <&apps_smmu 0x1e00 0x7f>;
> > +                     iommu-map = <0x0   &apps_smmu 0x1e00 0x1>,
> > +                                 <0x100 &apps_smmu 0x1e01 0x1>;
> > +
> > +                     resets = <&gcc GCC_PCIE_1_BCR>;
> > +                     reset-names = "pci";
> > +
> > +                     power-domains = <&gcc PCIE_1_GDSC>;
> > +
> > +                     phys = <&pcie1_lane>;
> > +                     phy-names = "pciephy";
> > +
> > +                     perst-gpio = <&tlmm 102 GPIO_ACTIVE_HIGH>;
> > +                     enable-gpio = <&tlmm 104 GPIO_ACTIVE_HIGH>;
> > +
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&pcie1_default_state>;
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             pcie1_phy: phy@1c0e000 {
> > +                     compatible = "qcom,sm8150-qmp-gen3x2-pcie-phy";
> > +                     reg = <0 0x01c0e000 0 0x1c0>;
> > +                     #address-cells = <2>;
> > +                     #size-cells = <2>;
> > +                     ranges;
> > +                     clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
> > +                              <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> > +                              <&gcc GCC_PCIE1_PHY_REFGEN_CLK>;
> > +                     clock-names = "aux", "cfg_ahb", "refgen";
> > +
> > +                     resets = <&gcc GCC_PCIE_1_PHY_BCR>;
> > +                     reset-names = "phy";
> > +
> > +                     assigned-clocks = <&gcc GCC_PCIE1_PHY_REFGEN_CLK>;
> > +                     assigned-clock-rates = <100000000>;
> > +
> > +                     status = "disabled";
> > +
> > +                     pcie1_lane: phy@1c0e200 {
> > +                             reg = <0 0x1c0e200 0 0x170>, /* tx0 */
> > +                                   <0 0x1c0e400 0 0x200>, /* rx0 */
> > +                                   <0 0x1c0ea00 0 0x1f0>, /* pcs */
> > +                                   <0 0x1c0e600 0 0x170>, /* tx1 */
> > +                                   <0 0x1c0e800 0 0x200>, /* rx1 */
> > +                                   <0 0x1c0ee00 0 0xf4>; /* "pcs_com" same as pcs_misc? */
> > +                             clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
> > +                             clock-names = "pipe0";
> > +
> > +                             #phy-cells = <0>;
> > +                             clock-output-names = "pcie_1_pipe_clk";
> > +                     };
> > +             };
> > +
> >               ufs_mem_hc: ufshc@1d84000 {
> >                       compatible = "qcom,sm8150-ufshc", "qcom,ufshc",
> >                                    "jedec,ufs-2.0";
> > @@ -2327,6 +2524,52 @@ qup_spi19_default: qup-spi19-default {
> >                               drive-strength = <6>;
> >                               bias-disable;
> >                       };
> > +
> > +                     pcie0_default_state: pcie0-default {
> > +                             perst {
> > +                                     pins = "gpio35";
> > +                                     function = "gpio";
> > +                                     drive-strength = <2>;
> > +                                     bias-pull-down;
> > +                             };
> > +
> > +                             clkreq {
> > +                                     pins = "gpio36";
> > +                                     function = "pci_e0";
> > +                                     drive-strength = <2>;
> > +                                     bias-pull-up;
> > +                             };
> > +
> > +                             wake {
> > +                                     pins = "gpio37";
> > +                                     function = "gpio";
> > +                                     drive-strength = <2>;
> > +                                     bias-pull-up;
> > +                             };
> > +                     };
> > +
> > +                     pcie1_default_state: pcie1-default {
> > +                             perst {
> > +                                     pins = "gpio102";
> > +                                     function = "gpio";
> > +                                     drive-strength = <2>;
> > +                                     bias-pull-down;
> > +                             };
> > +
> > +                             clkreq {
> > +                                     pins = "gpio103";
> > +                                     function = "pci_e1";
> > +                                     drive-strength = <2>;
> > +                                     bias-pull-up;
> > +                             };
> > +
> > +                             wake {
> > +                                     pins = "gpio104";
> > +                                     function = "gpio";
> > +                                     drive-strength = <2>;
> > +                                     bias-pull-up;
> > +                             };
> > +                     };
> >               };
> >
> >               remoteproc_mpss: remoteproc@4080000 {
>
>
> --
> With best wishes
> Dmitry
