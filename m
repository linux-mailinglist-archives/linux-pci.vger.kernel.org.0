Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B24677DC4
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 15:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjAWOQO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 09:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjAWOQN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 09:16:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72A6B46F;
        Mon, 23 Jan 2023 06:16:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6531360F33;
        Mon, 23 Jan 2023 14:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBBBC433D2;
        Mon, 23 Jan 2023 14:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674483371;
        bh=fdbBkGEuP0Gh5UZdPFq0V4UcjB89c8oJftHuLUcb4nQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LbzIQT2eTPow8cVLsHqbOewixD+CyhOK2EafEM7zPwUsH2p3KC0FHmQ+onjm2FC0I
         ZNqI760ErbCEMjh9FBdobnkKQujtCoNtoXGBOCKzYK9EVhaBXE3Q7+zw379strY4iW
         hUhi5Qty+kixtGB1ISEAcveVN4cu2BpwhOJmBCHeZBVu7E5o7q/+9KwUMNCnJMQ3wd
         o5JxonmYj3cSuHsjEOnxOZcbxqQs4UVBP6FTJ23ItWJo8OvGIeVndvpYClcT9V7GWn
         NF/FlvrKlKleAS/Nti2odcfh8jfax4tOMYlY/hCb+r19lfEGVtSLyxemIRkVATDJjP
         xsBjD6LA4Cw5A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pJxcG-0003c1-Em; Mon, 23 Jan 2023 15:16:09 +0100
Date:   Mon, 23 Jan 2023 15:16:08 +0100
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
Message-ID: <Y86WqGW6pj5re3FU@hovoldconsulting.com>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
 <20230119140453.3942340-12-abel.vesa@linaro.org>
 <Y85KiKD+iQamchB5@hovoldconsulting.com>
 <Y86AG7ev++wYiza4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y86AG7ev++wYiza4@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 23, 2023 at 02:39:55PM +0200, Abel Vesa wrote:
> On 23-01-23 09:51:20, Johan Hovold wrote:
> > On Thu, Jan 19, 2023 at 04:04:52PM +0200, Abel Vesa wrote:
> > > Add PCIe controllers and PHY nodes.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---

> > > +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> > > +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> > > +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> > > +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> > > +				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> > > +				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
> > > +				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>;
> > > +			clock-names = "aux",
> > > +				      "cfg",
> > > +				      "bus_master",
> > > +				      "bus_slave",
> > > +				      "slave_q2a",
> > > +				      "ddrss_sf_tbu",
> > 
> > You're reusing a clock name which doesn't seem to match this SoC. I
> > don't know what "QTB" refers to here and if it's just some Qualcomm
> > alternate name for "TBU" which could make this ok.
> 
> I'll come back later with an answer here, once I know exactly what QTB
> means.
> 
> > 
> > > +				      "noc_aggr_4";
> > 
> > The 4 here comes from the fact that the clock was named this way on
> > sc8280xp. Perhaps 'noc_aggr' would have been a better generic name for
> > the interconnect clock.
> > 
> 
> So should I rename it to noc_aggr as part of this patchset then?

Yes, or rather add that as the name this (and possible coming) SoCs use.

> > > +
> > > +			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>;
> > > +			interconnect-names = "pcie-mem";
> > > +
> > > +			iommus = <&apps_smmu 0x1400 0x7f>;
> > > +			iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
> > > +				    <0x100 &apps_smmu 0x1401 0x1>;
> > > +
> > > +			resets = <&gcc GCC_PCIE_0_BCR>;
> > > +			reset-names = "pci";
> > > +
> > > +			power-domains = <&gcc PCIE_0_GDSC>;
> > > +
> > > +			phys = <&pcie0_phy>;
> > > +			phy-names = "pciephy";
> > > +
> > > +			perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> > > +			wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> > > +
> > > +			pinctrl-names = "default";
> > > +			pinctrl-0 = <&pcie0_default_state>;
> > 
> > For sc8280xp we decided to keep all pin configuration (and the gpios
> > properties above) in the dts file. I believe this should be done also
> > for any new SoCs.
> 
> Right, I'll move the pinctrl properties to the dts node instead.
> 
> > 
> > Either way, the pin nodes should be added along with the consumer.
> > 
> 
> The pin nodes have been added already, back when the initial dtsi was sent.

Ok.
 
> > > +		pcie1_phy: phy@1c0e000 {
> > > +			compatible = "qcom,sm8550-qmp-gen4x2-pcie-phy";
> > > +			reg = <0x0 0x01c0e000 0x0 0x2000>;
> > > +
> > > +			clocks = <&gcc GCC_PCIE_1_PHY_AUX_CLK>,
> > > +				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> > > +				 <&tcsr TCSR_PCIE_1_CLKREF_EN>,
> > > +				 <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>,
> > > +				 <&gcc GCC_PCIE_1_PIPE_CLK>;
> > > +			clock-names = "aux", "cfg_ahb", "ref", "rchng",
> > > +				      "pipe";
> > > +
> > > +			resets = <&gcc GCC_PCIE_1_PHY_BCR>,
> > > +				 <&gcc GCC_PCIE_1_NOCSR_COM_PHY_BCR>;
> > > +			reset-names = "phy", "nocsr";
> > 
> > Do you know why only the second PHY uses two resets here? Did you intend
> > to add it also for the first PHY?
> 
> Please notice that this is a g4x2 phy. The documentation specifically
> says that both the pciephy_reset and pciephy_nocsr_reset should be
> asserted on power-up. Now, even the g3x2 has the nocsr reset (at least
> in GCC) but its documentation doesn't seem to say anything about
> nocsr needed to be asserted (ever).

Ok. Thanks for confirming. I did not notice the difference in generation
at first.

> > Both of these resets exists also on sc8280xp, and I believe downstream
> > used the NOCSR_COM variant, which does not reset all registers in the
> > PHY so you could unknowingly be relying on firmware to setup things up
> > for you.
> 
> That is also the case for the g3x2 phy on sm8550.
> 
> > 
> > I did a fair bit of reverse engineering to determine the init sequences
> > and opted to use the full reset for the PHYs here in the end.
> > 
> > I don't think you should be using both, but someone with access to
> > documentation may provide more insight.
> 
> Again, the documentation I have access to, seems to suggest otherwise.

If that's what the documentation says then let's go with that.

> > Have you tested both pci0 and 1 by the way?
> 
> Only the pcie0 can be tested with the MTP I have access to. So only
> pcie0 was tested.

Ok.

Johan
