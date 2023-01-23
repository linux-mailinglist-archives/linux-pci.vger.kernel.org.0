Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B676776BA
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 09:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjAWIv3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 03:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjAWIv2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 03:51:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E73CC2E;
        Mon, 23 Jan 2023 00:51:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83B5BB80B9F;
        Mon, 23 Jan 2023 08:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09460C4339B;
        Mon, 23 Jan 2023 08:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674463884;
        bh=5R0r5RNGt2ey5hflF/jJTiQCb4o00CqqvdoXWE5GF6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ifPKWQaCBY0RDEsj8Cf2hBAR/vYoIJIEwiVSsgv35TRYdmLEKiJIffr/TSrZyLv90
         a4DXPNCsPl+lXlMLm5tBWspXlD3YUlhrj/Gxj7OLLmA3xsIYm4bBq24dr+g9VSo1J8
         j3roIXvPBjrfcjY7clZWy6wnpLAzTqLpsHmRJrv1xiWcogs5UPwennVUomeLtl5OI0
         A/ri8H6S6QENz9vlYTFTYhfZpAFiWpoAcfFlt3TX7HXG9US+4uKqhXnl3k2PjNuoWT
         zgNT2zZPUjL6wNcTKRgo2a9oWDMbl7pA0sWmVXV3mHP9Wul1j8IroCfAK0slySZcFc
         ID1vsbPXMLHSQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pJsXw-00086s-5c; Mon, 23 Jan 2023 09:51:20 +0100
Date:   Mon, 23 Jan 2023 09:51:20 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 11/12] arm64: dts: qcom: sm8550: Add PCIe PHYs and
 controllers nodes
Message-ID: <Y85KiKD+iQamchB5@hovoldconsulting.com>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
 <20230119140453.3942340-12-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119140453.3942340-12-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 19, 2023 at 04:04:52PM +0200, Abel Vesa wrote:
> Add PCIe controllers and PHY nodes.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> This patch does not have a v3, but since it is now part of the same
> patchset with the controller and the phy drivers patches, I had to
> bump the version to 4.
> 
> Latest version was here (v2):
> https://lore.kernel.org/all/20230118230526.1499328-2-abel.vesa@linaro.org/
> 
> Changes since latest version (v2):
>  * renamed the pcie_1_link_down_reset to simply link_down
>  * dropped the pipe from clock-names
>  * renamed aggre clock-names to noc_aggr_4
>  * dropped the _pcie infix from cnoc_pcie_sf_axi
>  * dropped the aux_phy clock from the pcie1
> 
> Changes since v1:
>  * ordered pcie related nodes alphabetically in MTP dts
>  * dropped the pipe_mux, phy_pipe and ref clocks from the pcie nodes
>  * dropped the child node from the phy nodes, like Johan suggested,
>    and updated to use the sc8280xp binding scheme
>  * changed "pcie_1_nocsr_com_phy_reset" 2nd reset name of pcie1_phy
>    to "nocsr"
>  * reordered all pcie nodes properties to look similar to the ones
>    from sc8280xp
> 
> 
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 207 ++++++++++++++++++++++++++-
>  1 file changed, 204 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 3d47281a276b..8df226530d76 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -646,9 +646,9 @@ gcc: clock-controller@100000 {
>  			#reset-cells = <1>;
>  			#power-domain-cells = <1>;
>  			clocks = <&bi_tcxo_div2>, <&sleep_clk>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> +				 <&pcie0_phy>,
> +				 <&pcie1_phy>,
> +				 <&pcie_1_phy_aux_clk>,
>  				 <&ufs_mem_phy 0>,
>  				 <&ufs_mem_phy 1>,
>  				 <&ufs_mem_phy 2>,
> @@ -1547,6 +1547,207 @@ mmss_noc: interconnect@1780000 {
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> +		pcie0: pci@1c00000 {
> +			device_type = "pci";
> +			compatible = "qcom,pcie-sm8550";
> +			reg = <0 0x01c00000 0 0x3000>,
> +			      <0 0x60000000 0 0xf1d>,
> +			      <0 0x60000f20 0 0xa8>,
> +			      <0 0x60001000 0 0x1000>,
> +			      <0 0x60100000 0 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
> +			bus-range = <0x00 0xff>;
> +
> +			dma-coherent;
> +
> +			linux,pci-domain = <0>;
> +			num-lanes = <2>;
> +
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "ddrss_sf_tbu",

You're reusing a clock name which doesn't seem to match this SoC. I
don't know what "QTB" refers to here and if it's just some Qualcomm
alternate name for "TBU" which could make this ok.

> +				      "noc_aggr_4";

The 4 here comes from the fact that the clock was named this way on
sc8280xp. Perhaps 'noc_aggr' would have been a better generic name for
the interconnect clock.

> +
> +			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>;
> +			interconnect-names = "pcie-mem";
> +
> +			iommus = <&apps_smmu 0x1400 0x7f>;
> +			iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
> +				    <0x100 &apps_smmu 0x1401 0x1>;
> +
> +			resets = <&gcc GCC_PCIE_0_BCR>;
> +			reset-names = "pci";
> +
> +			power-domains = <&gcc PCIE_0_GDSC>;
> +
> +			phys = <&pcie0_phy>;
> +			phy-names = "pciephy";
> +
> +			perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +			wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pcie0_default_state>;

For sc8280xp we decided to keep all pin configuration (and the gpios
properties above) in the dts file. I believe this should be done also
for any new SoCs.

Either way, the pin nodes should be added along with the consumer.

> +
> +			status = "disabled";
> +		};
> +
> +		pcie0_phy: phy@1c06000 {
> +			compatible = "qcom,sm8550-qmp-gen3x2-pcie-phy";
> +			reg = <0 0x01c06000 0 0x2000>;
> +
> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&tcsr TCSR_PCIE_0_CLKREF_EN>,
> +				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE_0_PIPE_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref", "rchng",
> +				      "pipe";
> +
> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			power-domains = <&gcc PCIE_0_PHY_GDSC>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "pcie0_pipe_clk";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};

> +		pcie1_phy: phy@1c0e000 {
> +			compatible = "qcom,sm8550-qmp-gen4x2-pcie-phy";
> +			reg = <0x0 0x01c0e000 0x0 0x2000>;
> +
> +			clocks = <&gcc GCC_PCIE_1_PHY_AUX_CLK>,
> +				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +				 <&tcsr TCSR_PCIE_1_CLKREF_EN>,
> +				 <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE_1_PIPE_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref", "rchng",
> +				      "pipe";
> +
> +			resets = <&gcc GCC_PCIE_1_PHY_BCR>,
> +				 <&gcc GCC_PCIE_1_NOCSR_COM_PHY_BCR>;
> +			reset-names = "phy", "nocsr";

Do you know why only the second PHY uses two resets here? Did you intend
to add it also for the first PHY?

Both of these resets exists also on sc8280xp, and I believe downstream
used the NOCSR_COM variant, which does not reset all registers in the
PHY so you could unknowingly be relying on firmware to setup things up
for you.

I did a fair bit of reverse engineering to determine the init sequences
and opted to use the full reset for the PHYs here in the end.

I don't think you should be using both, but someone with access to
documentation may provide more insight.

Have you tested both pci0 and 1 by the way?

> +
> +			assigned-clocks = <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			power-domains = <&gcc PCIE_1_PHY_GDSC>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "pcie1_pipe_clk";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>  		cryptobam: dma-controller@1dc4000 {
>  			compatible = "qcom,bam-v1.7.0";
>  			reg = <0x0 0x01dc4000 0x0 0x28000>;

Johan
