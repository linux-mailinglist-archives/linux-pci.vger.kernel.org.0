Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D774250B4AC
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 12:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356967AbiDVKKL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 06:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiDVKKK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 06:10:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391B053737;
        Fri, 22 Apr 2022 03:07:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1B3061E0C;
        Fri, 22 Apr 2022 10:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34217C385A0;
        Fri, 22 Apr 2022 10:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650622037;
        bh=0yawq57opbcFXdcIH0roNewMtfcjckMA1vUB5NwgbJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ahfXL6IIYcRZR0IorZG5eaC6uXloOgECvMsnb33CugSy6kgDAezyHUi+CMUqRBmyk
         tnS0YM+XdWiHR0vlO1GtvOBczW1aZreIFNJHlBuwwlzRf2Hj28M/Iy+Wo0Dzh120zS
         fye4SQOST9LaV+NK9zQwmAwG7x29nDCG6rHHElggozoDy/nPstosu52kGykPBpSf04
         664MwKKMK40tOU3zv2qLfByYqTQRYUL18MXMaVNt+OThd+oXWZUqLsoGbJ45H9q2EV
         bVJvSp/B9tKvn1dU1Lm8BvGttHm59bVT/u1gHygiOTsMFqIrpiM55gAPbaKo376GoK
         rnDVPvmnFeq8g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nhqBy-0002JI-J5; Fri, 22 Apr 2022 12:07:10 +0200
Date:   Fri, 22 Apr 2022 12:07:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH RFC 2/5] arm64: dts: qcom: sc7280: move pipe mux handling
 to phy
Message-ID: <YmJ+Ti81el2MzsHG@hovoldconsulting.com>
References: <20220421102041.17345-1-johan+linaro@kernel.org>
 <20220421102041.17345-3-johan+linaro@kernel.org>
 <55d6e32b-9cf4-384c-1036-1adfb867ece8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55d6e32b-9cf4-384c-1036-1adfb867ece8@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 21, 2022 at 01:59:04PM +0300, Dmitry Baryshkov wrote:
> On 21/04/2022 13:20, Johan Hovold wrote:
> > The QMP PHY pipe clock remuxing is part of the PHY, which is both the
> > producer and the consumer of the pipe clock.
> > 
> > Update the PCIe controller and PHY node to reflect the new binding.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   arch/arm64/boot/dts/qcom/sc7280.dtsi | 18 ++++++------------
> >   1 file changed, 6 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > index c07765df9303..b3a9630262dc 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > @@ -1837,11 +1837,7 @@ pcie1: pci@1c08000 {
> >   					<0 0 0 3 &intc 0 0 0 438 IRQ_TYPE_LEVEL_HIGH>,
> >   					<0 0 0 4 &intc 0 0 0 439 IRQ_TYPE_LEVEL_HIGH>;
> >   
> > -			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
> > -				 <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
> > -				 <&pcie1_lane 0>,
> > -				 <&rpmhcc RPMH_CXO_CLK>,
> > -				 <&gcc GCC_PCIE_1_AUX_CLK>,
> > +			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
> >   				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> >   				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
> >   				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
> > @@ -1849,11 +1845,7 @@ pcie1: pci@1c08000 {
> >   				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
> >   				 <&gcc GCC_DDRSS_PCIE_SF_CLK>;
> >   
> > -			clock-names = "pipe",
> > -				      "pipe_mux",
> > -				      "phy_pipe",
> > -				      "ref",
> > -				      "aux",
> > +			clock-names = "aux",
> >   				      "cfg",
> >   				      "bus_master",
> >   				      "bus_slave",
> > @@ -1910,8 +1902,10 @@ pcie1_lane: lanes@1c0e200 {
> >   				      <0 0x01c0e600 0 0x170>,
> >   				      <0 0x01c0e800 0 0x200>,
> >   				      <0 0x01c0ee00 0 0xf4>;
> > -				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
> > -				clock-names = "pipe0";
> > +				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
> > +					 <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
> > +					 <&rpmhcc RPMH_CXO_CLK>;
> > +				clock-names = "pipe0", "mux", "ref";
> 
> This will not be compatible with earlier DTB files, which was a problem 
> up to now.

That depends. The above wasn't added until 5.16 so we may still be able
to fix it.

The NAK you got from Rob earlier was when you removed clocks that have
been in the devicetree for several years:

	https://lore.kernel.org/all/YgQ+tGhLqwUCsTUo@robh.at.kernel.org/

and would still be needed by older kernels.

Worst case, we need to keep both sets for sc7280 (i.e. like we need to
do with the pipe clocks that have been around for years).

Johan
