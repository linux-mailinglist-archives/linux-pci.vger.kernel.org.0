Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB9B749A64
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 13:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjGFLQO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 07:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjGFLQN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 07:16:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5876ADC;
        Thu,  6 Jul 2023 04:16:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB55761904;
        Thu,  6 Jul 2023 11:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FB5C433C7;
        Thu,  6 Jul 2023 11:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688642171;
        bh=EtLxxaDrtWDWMjtWpF0JDkHpy6Um3KDkSIFd31LcdXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qTkbQ5Njh0DaCBrrXUpooQS8SC9FQDlfJxuXnMuxd5cqSAgydbnIvHWW6sIQaquuS
         zeFfDDUhIJPkA+oOAnaP6qTJ8HQreaSaWRryZOwCf9OPrtjGrerqRRiZvIUXtxoprp
         7OtL0YDCmFr8QNiUZSdTzkNUafHgLlkA9y7Of1xNSHhWmV9jkzru1RCyEvGVKH7Y/h
         /4tolyVGqrMzHw30lYLD5W0hvzFI/QoWxog9ICIpH7U5CITykbfxd3BrjQwj1Kl7fc
         z88GJMkwcQHJJKBfpIbvEBEQtLP0ssQyGpERWKpwXorJ8kwK0lOHJDlFQqxSkqdZKM
         eEj6d5u+fb0+A==
Date:   Thu, 6 Jul 2023 16:45:53 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 5/6] arm64: dts: qcom: sa8775p: Add pcie0 and pcie1
 nodes
Message-ID: <20230706111553.GB4808@thinkpad>
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
 <1688545032-17748-6-git-send-email-quic_msarkar@quicinc.com>
 <e31564e1-31cf-2cda-df6f-6210e6a1c1fc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e31564e1-31cf-2cda-df6f-6210e6a1c1fc@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 06, 2023 at 12:01:37PM +0200, Konrad Dybcio wrote:
> On 5.07.2023 10:17, Mrinmay Sarkar wrote:
> > Add pcie dtsi nodes for two controllers found on sa8775p platform.
> > 
> > Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> > ---[...]
> 
> > +	pcie1_phy: phy@1c14000 {
> > +		compatible = "qcom,sa8775p-qmp-gen4x4-pcie-phy";
> > +		reg = <0x0 0x1c14000 0x0 0x4000>;
> > +
> > +		clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
> > +			 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> > +			 <&gcc GCC_PCIE_CLKREF_EN>,
> > +			 <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>,
> > +			 <&gcc GCC_PCIE_1_PHY_AUX_CLK>,
> > +			 <&gcc GCC_PCIE_1_PIPE_CLK>,
> > +			 <&gcc GCC_PCIE_1_PIPEDIV2_CLK>;
> > +
> > +		clock-names = "aux", "cfg_ahb", "ref", "rchng", "phy_aux",
> > +						"pipe", "pipediv2";
> > +
> > +		assigned-clocks = <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>;
> > +		assigned-clock-rates = <100000000>;
> > +
> > +		power-domains = <&gcc PCIE_1_GDSC>;
> Please check if it's the correct power domain. I've heard that the PCIe PHY
> may be hooked up to something else but have no way of confirming myself.
> 

Right, I missed it during my review. PHYs are powered by MX domain on all the
platforms I have seen so far, so this should be cross checked.

And someone should fix the existing dts.

- Mani

> Konrad
> > +
> > +		resets = <&gcc GCC_PCIE_1_PHY_BCR>;
> > +		reset-names = "phy";
> > +
> > +		#clock-cells = <0>;
> > +		clock-output-names = "pcie_1_pipe_clk";
> > +
> > +		#phy-cells = <0>;
> > +
> > +		status = "disabled";
> > +
> > +	};
> >  };

-- 
மணிவண்ணன் சதாசிவம்
