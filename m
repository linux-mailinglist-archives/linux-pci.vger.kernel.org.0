Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCB06A9DE3
	for <lists+linux-pci@lfdr.de>; Fri,  3 Mar 2023 18:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjCCRkw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 12:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCCRkv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 12:40:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA5A1B55B;
        Fri,  3 Mar 2023 09:40:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF70C618B0;
        Fri,  3 Mar 2023 17:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23E4C4339C;
        Fri,  3 Mar 2023 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677865249;
        bh=z/rHLZz/0hkO+xtkjFB3n0wD+uJunnsmtzF3M+39Xao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZ+6phsdT8C1M8DaZ/UHcrcw2rnOepaj/Dwo1ZXPNO49+Jo0PeXI7WeclV6K7pp3O
         vxOuBLYgJlSM5ylSQ2WxVdMZtzB75JeTd6x7aq2JD7crEVDBqT4gHY3QAypE7FTkEa
         RAOgYBRR+rXOCsfx7vmZl0FaY8SP8XnStYa3pfYgmzV6ad/VKyrgn4HI+SpSZ5QUD9
         Czmtoae2gseMWNI1p36kGBfVgGtpluGo63UEZNAy7zkxIcsMniQ0B2DWFqX+jh1TjJ
         dB9a3oo4HWwOtDY5lcVY907g4Sk0egabZ0KnCVsRF1AwKm9mSsh7J2lEfss5vMKYDC
         WY5d74vo6PJew==
Date:   Fri, 3 Mar 2023 23:10:36 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-clk@vger.kernel.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com
Subject: Re: [PATCH 1/7] dt-bindings: PCI: qcom: Add IPQ9574 specific
 compatible
Message-ID: <20230303174036.GB6782@thinkpad>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
 <20230214164135.17039-2-quic_devipriy@quicinc.com>
 <20230224082332.GA5443@thinkpad>
 <bd153038-4427-1f11-1941-5f13fec01cf7@quicinc.com>
 <20230228063358.GA4839@thinkpad>
 <9BD62D8E-4E14-4269-B72D-C83EF4D43040@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9BD62D8E-4E14-4269-B72D-C83EF4D43040@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 03, 2023 at 05:16:58PM +0200, Dmitry Baryshkov wrote:
> 28 февраля 2023 г. 08:33:58 GMT+02:00, Manivannan Sadhasivam <mani@kernel.org> пишет:
> >On Tue, Feb 28, 2023 at 10:56:53AM +0530, Devi Priya wrote:
> >> 
> >> 
> >> On 2/24/2023 1:53 PM, Manivannan Sadhasivam wrote:
> >> > On Tue, Feb 14, 2023 at 10:11:29PM +0530, Devi Priya wrote:
> >> > > Document the compatible for IPQ9574
> >> > > 
> >> Hi Mani, Thanks for taking time to review the patch.
> >> > 
> >> > You didn't mention about the "msi-parent" property that is being added
> >> > by this patch
> >> Sure, will update the commit message in the next spin
> >> > 
> >> > > Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> >> > > ---
> >> > >   .../devicetree/bindings/pci/qcom,pcie.yaml    | 72 ++++++++++++++++++-
> >> > >   1 file changed, 70 insertions(+), 2 deletions(-)
> >> > > 
> >> > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >> > > index 872817d6d2bd..dabdf2684e2d 100644
> >> > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >> > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >> > > @@ -26,6 +26,7 @@ properties:
> >> > >             - qcom,pcie-ipq8064-v2
> >> > >             - qcom,pcie-ipq8074
> >> > >             - qcom,pcie-ipq8074-gen3
> >> > > +          - qcom,pcie-ipq9574
> >> > >             - qcom,pcie-msm8996
> >> > >             - qcom,pcie-qcs404
> >> > >             - qcom,pcie-sa8540p
> >> > > @@ -44,11 +45,11 @@ properties:
> >> > >     reg:
> >> > >       minItems: 4
> >> > > -    maxItems: 5
> >> > > +    maxItems: 6
> >> > >     reg-names:
> >> > >       minItems: 4
> >> > > -    maxItems: 5
> >> > > +    maxItems: 6
> >> > >     interrupts:
> >> > >       minItems: 1
> >> > > @@ -105,6 +106,8 @@ properties:
> >> > >       items:
> >> > >         - const: pciephy
> >> > > +  msi-parent: true
> >> > > +
> >> > >     power-domains:
> >> > >       maxItems: 1
> >> > > @@ -173,6 +176,27 @@ allOf:
> >> > >               - const: parf # Qualcomm specific registers
> >> > >               - const: config # PCIe configuration space
> >> > > +  - if:
> >> > > +      properties:
> >> > > +        compatible:
> >> > > +          contains:
> >> > > +            enum:
> >> > > +              - qcom,pcie-ipq9574
> >> > > +    then:
> >> > > +      properties:
> >> > > +        reg:
> >> > > +          minItems: 5
> >> > > +          maxItems: 6
> >> > > +        reg-names:
> >> > > +          minItems: 5
> >> > > +          items:
> >> > > +            - const: dbi # DesignWare PCIe registers
> >> > > +            - const: elbi # External local bus interface registers
> >> > > +            - const: atu # ATU address space
> >> > > +            - const: parf # Qualcomm specific registers
> >> > > +            - const: config # PCIe configuration space
> >> > > +            - const: aggr_noc #PCIe aggr_noc
> >> > 
> >> > Why do you need this region unlike other SoCs? Is the driver making use of it?
> >> We have the aggr_noc region in ipq9574 to achieve higher throughput & to
> >> handle multiple PCIe instances. The driver uses it to rate adapt 1-lane PCIe
> >> clocks. My bad, missed it. Will add the driver changes in V2.
> >
> >Hmm, this is something new. How can you achieve higher throughput with this
> >region? Can you explain more on how it is used?
> 
> Based on the name of the region, it looks like it is an interconnect region. 
> 

Well, we only have BCM based interconnects so far. That's why I was curious
about this region and its purpose.

> Devi, if this is the case, then you have to handle it through the interconnect driver, rather than poking directly into these registers.

If that so, it doesn't need to be added in this series itself. I believe that
without aggr_noc region, the PCIe controller can still function properly with
reduced performance. But you can add the interconnect support later as a
separate series.

Thanks,
Mani

> 
> 
> >
> >Thanks,
> >Mani
> >
> >> > 
> >> > Thanks,
> >> > Mani
> >> > 
> >> > > +
> >> > >     - if:
> >> > >         properties:
> >> > >           compatible:
> >> > > @@ -365,6 +389,39 @@ allOf:
> >> > >               - const: ahb # AHB Reset
> >> > >               - const: axi_m_sticky # AXI Master Sticky reset
> >> > > +  - if:
> >> > > +      properties:
> >> > > +        compatible:
> >> > > +          contains:
> >> > > +            enum:
> >> > > +              - qcom,pcie-ipq9574
> >> > > +    then:
> >> > > +      properties:
> >> > > +        clocks:
> >> > > +          minItems: 6
> >> > > +          maxItems: 6
> >> > > +        clock-names:
> >> > > +          items:
> >> > > +            - const: ahb  # AHB clock
> >> > > +            - const: aux  # Auxiliary clock
> >> > > +            - const: axi_m # AXI Master clock
> >> > > +            - const: axi_s # AXI Slave clock
> >> > > +            - const: axi_bridge # AXI bridge clock
> >> > > +            - const: rchng
> >> > > +        resets:
> >> > > +          minItems: 8
> >> > > +          maxItems: 8
> >> > > +        reset-names:
> >> > > +          items:
> >> > > +            - const: pipe # PIPE reset
> >> > > +            - const: sticky # Core Sticky reset
> >> > > +            - const: axi_s_sticky # AXI Slave Sticky reset
> >> > > +            - const: axi_s # AXI Slave reset
> >> > > +            - const: axi_m_sticky # AXI Master Sticky reset
> >> > > +            - const: axi_m # AXI Master reset
> >> > > +            - const: aux # AUX Reset
> >> > > +            - const: ahb # AHB Reset
> >> > > +
> >> > >     - if:
> >> > >         properties:
> >> > >           compatible:
> >> > > @@ -681,6 +738,16 @@ allOf:
> >> > >           - interconnects
> >> > >           - interconnect-names
> >> > > +  - if:
> >> > > +      properties:
> >> > > +        compatible:
> >> > > +          contains:
> >> > > +            enum:
> >> > > +              - qcom,pcie-ipq9574
> >> > > +    then:
> >> > > +      required:
> >> > > +        - msi-parent
> >> > > +
> >> > >     - if:
> >> > >         not:
> >> > >           properties:
> >> > > @@ -693,6 +760,7 @@ allOf:
> >> > >                   - qcom,pcie-ipq8064v2
> >> > >                   - qcom,pcie-ipq8074
> >> > >                   - qcom,pcie-ipq8074-gen3
> >> > > +                - qcom,pcie-ipq9574
> >> > >                   - qcom,pcie-qcs404
> >> > >       then:
> >> > >         required:
> >> > > -- 
> >> > > 2.17.1
> >> > > 
> >> > 
> >> Thanks,
> >> Devi Priya
> >
> 

-- 
மணிவண்ணன் சதாசிவம்
