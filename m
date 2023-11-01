Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688857DDC4A
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 06:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjKAF0z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 01:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjKAF0z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 01:26:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B30E4;
        Tue, 31 Oct 2023 22:26:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683D5C433C7;
        Wed,  1 Nov 2023 05:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698816412;
        bh=2X9/6ckDNk5SoeTLDxb6iS9COcY0QdR2px+L0/m87P8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/5i19JbLZHbZe2t8Frl+vNmtF0VGEFwyK0DRi5E9Yx80KNEiaEZ1hMWmZK8YjT83
         S2IXXWB0KG5SbftA5suyduf/CdX/6CquNH6IjwXaYfIHzjNZI53B+pwVB5XyTIhGGR
         lgH/V0uO5PccLghG8xbIFR8KbOwQLMXBFWioE3L/AzUYVq8UVUcn9v++aNIHltqyO8
         C8OlYiSUAC163xf/9JQfR7AVAUNZS6ozh0J0tuhMXUqOjNpak0klIJBGycAMa3s23y
         q7WDoUnhrxbPIVYtug6NVrGgNN+zaMu0K+2uWgiZOVlYLL/E0R2XNAphL8plkKWBlk
         H1jNrMAmerx1Q==
Date:   Wed, 1 Nov 2023 10:56:33 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org,
        robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        quic_schintav@quicinc.com, quic_shijose@quicinc.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev
Subject: Re: [PATCH v6 4/4] arm64: dts: qcom: sa8775p: Add ep pcie0
 controller node
Message-ID: <20231101052633.GF2897@thinkpad>
References: <1698729108-27356-1-git-send-email-quic_msarkar@quicinc.com>
 <1698729108-27356-5-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1698729108-27356-5-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 31, 2023 at 10:41:48AM +0530, Mrinmay Sarkar wrote:
> Add ep pcie dtsi node for pcie0 controller found on sa8775p platform.
> It supports gen4 and x2 link width. Limiting the speed to Gen3 due to
> stability issues.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One question below:

> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 46 +++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 13dd44d..7eab458 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -3586,6 +3586,52 @@
>  		status = "disabled";
>  	};
>  
> +	pcie0_ep: pcie-ep@1c00000 {
> +		compatible = "qcom,sa8775p-pcie-ep";
> +		reg = <0x0 0x01c00000 0x0 0x3000>,
> +		      <0x0 0x40000000 0x0 0xf20>,
> +		      <0x0 0x40000f20 0x0 0xa8>,
> +		      <0x0 0x40001000 0x0 0x4000>,
> +		      <0x0 0x40200000 0x0 0x100000>,
> +		      <0x0 0x01c03000 0x0 0x1000>,
> +		      <0x0 0x40005000 0x0 0x2000>;
> +		reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
> +			    "mmio", "dma";
> +
> +		clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> +			<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +			<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +			<&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +			<&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
> +
> +		clock-names = "aux",
> +			      "cfg",
> +			      "bus_master",
> +			      "bus_slave",
> +			      "slave_q2a";
> +
> +		interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 630 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		interrupt-names = "global", "doorbell", "dma";
> +
> +		interconnects = <&pcie_anoc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,
> +				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;
> +		interconnect-names = "pcie-mem", "cpu-pcie";
> +
> +		iommus = <&pcie_smmu 0x0000 0x7f>;

SID is really 0?

- Mani

> +		resets = <&gcc GCC_PCIE_0_BCR>;
> +		reset-names = "core";
> +		power-domains = <&gcc PCIE_0_GDSC>;
> +		phys = <&pcie0_phy>;
> +		phy-names = "pciephy";
> +		max-link-speed = <3>; /* FIXME: Limiting the Gen speed due to stability issues */
> +		num-lanes = <2>;
> +
> +		status = "disabled";
> +	};
> +
>  	pcie0_phy: phy@1c04000 {
>  		compatible = "qcom,sa8775p-qmp-gen4x2-pcie-phy";
>  		reg = <0x0 0x1c04000 0x0 0x2000>;
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
