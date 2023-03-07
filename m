Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BAF6ADF4C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 13:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjCGM51 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 07:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCGM5Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 07:57:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E893C10;
        Tue,  7 Mar 2023 04:57:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53DB1B818B6;
        Tue,  7 Mar 2023 12:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A13C433EF;
        Tue,  7 Mar 2023 12:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678193829;
        bh=/6FWaTZ91tr7mn9JZhWid8/SD4XwCMsi0rdXaiPhcFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LnHqQENGqGMcpLzuaQisy/OOZl3Wc7gQV71bkPsINseY82j6IAMcnYXJEZosZ2J9o
         AvK/Q7OwO71dkyxeumiquEKBFZh9iDsQWjAc9eBDKVExdh/9uSRt5fLgUlwiZPQZ0C
         Ta+M5SERCeQ/HPhkDeljpJIvDiuFiUiJHFSt2VC4TCMQt2JvNZ8IO6nvLSYIM+9Y0m
         k0H2OEpyp1VTiV/otaWfYHfJ7bkUM7UDaoI2hrnAEUBaVpIG6neslNPQ8ixgLfnpe7
         pXSbnX4O6+ixIWbCxMrDsuj3rkKk5CDpzcQowqGHuoW4Fs1gCzGgsN2b3SuJm65yCe
         IktoDcs6uOi5w==
Date:   Tue, 7 Mar 2023 18:26:55 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, agross@kernel.org,
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
Message-ID: <20230307125655.GC5599@thinkpad>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
 <20230214164135.17039-2-quic_devipriy@quicinc.com>
 <20230224082332.GA5443@thinkpad>
 <bd153038-4427-1f11-1941-5f13fec01cf7@quicinc.com>
 <20230228063358.GA4839@thinkpad>
 <9BD62D8E-4E14-4269-B72D-C83EF4D43040@linaro.org>
 <20230303174036.GB6782@thinkpad>
 <30cf9717-dcca-e984-c506-c71b7f8e32cd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30cf9717-dcca-e984-c506-c71b7f8e32cd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 07, 2023 at 03:15:08PM +0530, Devi Priya wrote:
> 
> 
> On 3/3/2023 11:10 PM, Manivannan Sadhasivam wrote:
> > On Fri, Mar 03, 2023 at 05:16:58PM +0200, Dmitry Baryshkov wrote:
> > > 28 февраля 2023 г. 08:33:58 GMT+02:00, Manivannan Sadhasivam <mani@kernel.org> пишет:
> > > > On Tue, Feb 28, 2023 at 10:56:53AM +0530, Devi Priya wrote:
> > > > > 
> > > > > 
> > > > > On 2/24/2023 1:53 PM, Manivannan Sadhasivam wrote:
> > > > > > On Tue, Feb 14, 2023 at 10:11:29PM +0530, Devi Priya wrote:
> > > > > > > Document the compatible for IPQ9574
> > > > > > > 
> > > > > Hi Mani, Thanks for taking time to review the patch.
> > > > > > 
> > > > > > You didn't mention about the "msi-parent" property that is being added
> > > > > > by this patch
> > > > > Sure, will update the commit message in the next spin
> > > > > > 
> > > > > > > Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> > > > > > > ---
> > > > > > >    .../devicetree/bindings/pci/qcom,pcie.yaml    | 72 ++++++++++++++++++-
> > > > > > >    1 file changed, 70 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > > > > > index 872817d6d2bd..dabdf2684e2d 100644
> > > > > > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > > > > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > > > > > @@ -26,6 +26,7 @@ properties:
> > > > > > >              - qcom,pcie-ipq8064-v2
> > > > > > >              - qcom,pcie-ipq8074
> > > > > > >              - qcom,pcie-ipq8074-gen3
> > > > > > > +          - qcom,pcie-ipq9574
> > > > > > >              - qcom,pcie-msm8996
> > > > > > >              - qcom,pcie-qcs404
> > > > > > >              - qcom,pcie-sa8540p
> > > > > > > @@ -44,11 +45,11 @@ properties:
> > > > > > >      reg:
> > > > > > >        minItems: 4
> > > > > > > -    maxItems: 5
> > > > > > > +    maxItems: 6
> > > > > > >      reg-names:
> > > > > > >        minItems: 4
> > > > > > > -    maxItems: 5
> > > > > > > +    maxItems: 6
> > > > > > >      interrupts:
> > > > > > >        minItems: 1
> > > > > > > @@ -105,6 +106,8 @@ properties:
> > > > > > >        items:
> > > > > > >          - const: pciephy
> > > > > > > +  msi-parent: true
> > > > > > > +
> > > > > > >      power-domains:
> > > > > > >        maxItems: 1
> > > > > > > @@ -173,6 +176,27 @@ allOf:
> > > > > > >                - const: parf # Qualcomm specific registers
> > > > > > >                - const: config # PCIe configuration space
> > > > > > > +  - if:
> > > > > > > +      properties:
> > > > > > > +        compatible:
> > > > > > > +          contains:
> > > > > > > +            enum:
> > > > > > > +              - qcom,pcie-ipq9574
> > > > > > > +    then:
> > > > > > > +      properties:
> > > > > > > +        reg:
> > > > > > > +          minItems: 5
> > > > > > > +          maxItems: 6
> > > > > > > +        reg-names:
> > > > > > > +          minItems: 5
> > > > > > > +          items:
> > > > > > > +            - const: dbi # DesignWare PCIe registers
> > > > > > > +            - const: elbi # External local bus interface registers
> > > > > > > +            - const: atu # ATU address space
> > > > > > > +            - const: parf # Qualcomm specific registers
> > > > > > > +            - const: config # PCIe configuration space
> > > > > > > +            - const: aggr_noc #PCIe aggr_noc
> > > > > > 
> > > > > > Why do you need this region unlike other SoCs? Is the driver making use of it?
> > > > > We have the aggr_noc region in ipq9574 to achieve higher throughput & to
> > > > > handle multiple PCIe instances. The driver uses it to rate adapt 1-lane PCIe
> > > > > clocks. My bad, missed it. Will add the driver changes in V2.
> > > > 
> > > > Hmm, this is something new. How can you achieve higher throughput with this
> > > > region? Can you explain more on how it is used?
> > > 
> > > Based on the name of the region, it looks like it is an interconnect region.
> > > 
> > 
> > Well, we only have BCM based interconnects so far. That's why I was curious
> > about this region and its purpose.
> For connected PCIe slave devices that are running at frequency lesser
> than the ANOC frequency (342MHz), the rate adapter of ANOC needs to be
> configured
> > 
> > > Devi, if this is the case, then you have to handle it through the interconnect driver, rather than poking directly into these registers.
> > 
> > If that so, it doesn't need to be added in this series itself. I believe that
> > without aggr_noc region, the PCIe controller can still function properly with
> > reduced performance. But you can add the interconnect support later as a
> > separate series.
> Sure, okay. The ANOC runs at a fixed frequency of 342MHz and the
> interconnect clocks are not scaled. The aggr_noc register is just a magic
> register for configuring it's rate adapter to ensure no wait cycles are
> inserted.
> 

If the purpose of the aggr_noc region is to configure the interconnect clock,
then it should be modeled as an interconnect driver.

Thanks,
Mani

> > 
> > Thanks,
> > Mani
> > 
> > > 
> > > 
> > > > 
> > > > Thanks,
> > > > Mani
> > > > 
> > > > > > 
> > > > > > Thanks,
> > > > > > Mani
> > > > > > 
> > > > > > > +
> > > > > > >      - if:
> > > > > > >          properties:
> > > > > > >            compatible:
> > > > > > > @@ -365,6 +389,39 @@ allOf:
> > > > > > >                - const: ahb # AHB Reset
> > > > > > >                - const: axi_m_sticky # AXI Master Sticky reset
> > > > > > > +  - if:
> > > > > > > +      properties:
> > > > > > > +        compatible:
> > > > > > > +          contains:
> > > > > > > +            enum:
> > > > > > > +              - qcom,pcie-ipq9574
> > > > > > > +    then:
> > > > > > > +      properties:
> > > > > > > +        clocks:
> > > > > > > +          minItems: 6
> > > > > > > +          maxItems: 6
> > > > > > > +        clock-names:
> > > > > > > +          items:
> > > > > > > +            - const: ahb  # AHB clock
> > > > > > > +            - const: aux  # Auxiliary clock
> > > > > > > +            - const: axi_m # AXI Master clock
> > > > > > > +            - const: axi_s # AXI Slave clock
> > > > > > > +            - const: axi_bridge # AXI bridge clock
> > > > > > > +            - const: rchng
> > > > > > > +        resets:
> > > > > > > +          minItems: 8
> > > > > > > +          maxItems: 8
> > > > > > > +        reset-names:
> > > > > > > +          items:
> > > > > > > +            - const: pipe # PIPE reset
> > > > > > > +            - const: sticky # Core Sticky reset
> > > > > > > +            - const: axi_s_sticky # AXI Slave Sticky reset
> > > > > > > +            - const: axi_s # AXI Slave reset
> > > > > > > +            - const: axi_m_sticky # AXI Master Sticky reset
> > > > > > > +            - const: axi_m # AXI Master reset
> > > > > > > +            - const: aux # AUX Reset
> > > > > > > +            - const: ahb # AHB Reset
> > > > > > > +
> > > > > > >      - if:
> > > > > > >          properties:
> > > > > > >            compatible:
> > > > > > > @@ -681,6 +738,16 @@ allOf:
> > > > > > >            - interconnects
> > > > > > >            - interconnect-names
> > > > > > > +  - if:
> > > > > > > +      properties:
> > > > > > > +        compatible:
> > > > > > > +          contains:
> > > > > > > +            enum:
> > > > > > > +              - qcom,pcie-ipq9574
> > > > > > > +    then:
> > > > > > > +      required:
> > > > > > > +        - msi-parent
> > > > > > > +
> > > > > > >      - if:
> > > > > > >          not:
> > > > > > >            properties:
> > > > > > > @@ -693,6 +760,7 @@ allOf:
> > > > > > >                    - qcom,pcie-ipq8064v2
> > > > > > >                    - qcom,pcie-ipq8074
> > > > > > >                    - qcom,pcie-ipq8074-gen3
> > > > > > > +                - qcom,pcie-ipq9574
> > > > > > >                    - qcom,pcie-qcs404
> > > > > > >        then:
> > > > > > >          required:
> > > > > > > -- 
> > > > > > > 2.17.1
> > > > > > > 
> > > > > > 
> > > > > Thanks,
> > > > > Devi Priya
> > > > 
> > > 
> > 
> Thanks,
> Devi Priya

-- 
மணிவண்ணன் சதாசிவம்
