Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A81F71940C
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 09:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjFAHVM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 03:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFAHVL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 03:21:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278FA129;
        Thu,  1 Jun 2023 00:21:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B11A1641CA;
        Thu,  1 Jun 2023 07:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60119C433EF;
        Thu,  1 Jun 2023 07:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685604069;
        bh=pmLSdXbONq+1c2ihmwSq1qnFoYmgEOhAOEH7wiew6bM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VEIAx4GQHbvtTqupBoAb5aySjHXBYatSg7etJDzO6LN1ltog/4JpmzYFumg764eBF
         bzM2YY22VZvaYPlsllQ08j8HhXcmTjQEMMFstSB+AZ2zToPzhE6wbikGr0+crDQF/b
         RiK06qB1i1uTNek6gGCWGKTU1clyNx1iAKAEpKWyEQ4RD269S1whRxGZwl1aa56crK
         m7KKKeyS9daWIPB8mkjPtnxYQkcKt6sPZ1Pe3KF0b68xa+ShQ/jyefDa98lAmhTwmA
         EQMvw9fIlSnXLkf5lOZvmIWbKu77B/xSw9ZNysWl6Iwx77hmy+qw2hSsqkNVs2QHpg
         JvpfvErQnDy/Q==
Date:   Thu, 1 Jun 2023 12:51:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/15] dt-bindings: PCI: qcom: Fix sc8180x clocks and
 interrupts
Message-ID: <ZHhG4LOgfYgWbFt7@matsya>
References: <20230530162454.51708-1-vkoul@kernel.org>
 <20230530162454.51708-2-vkoul@kernel.org>
 <4fcbb3b7-ed44-d8e6-a601-e3e957c55ebf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fcbb3b7-ed44-d8e6-a601-e3e957c55ebf@linaro.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31-05-23, 10:19, Krzysztof Kozlowski wrote:
> On 30/05/2023 18:24, Vinod Koul wrote:
> > Commit 45a3ec891370 ("PCI: qcom: Add sc8180x compatible") added sc8180x
> > compatible and commit 075a9d55932e ("dt-bindings: PCI: qcom: Convert to
> > YAML") converted the description to yaml
> > 
> > But there are still some errors specific to sc8180x which this change
> > attempts to fix. The clocks and resets for sc8180 pcie controller are
> > different so need to be documented separately
> 
> I don't get what's the error here to fix. The clocks you list are
> already there as part of oneOf.

It was listed with sm8150 block which has different set of clocks than
used in sc81880x, so this needs to have its own block of clocks and
resets

> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  .../devicetree/bindings/pci/qcom,pcie.yaml    | 29 ++++++++++++++++++-
> >  1 file changed, 28 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > index 81971be4e554..40a1f451a3d3 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > @@ -476,6 +476,33 @@ allOf:
> >            items:
> >              - const: pci # PCIe core reset
> >  
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,pcie-sc8180x
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 8
> > +          maxItems: 8
> > +        clock-names:
> > +          items:
> > +            - const: pipe # PIPE clock
> > +            - const: aux # Auxiliary clock
> > +            - const: cfg # Configuration clock
> > +            - const: bus_master # Master AXI clock
> > +            - const: bus_slave # Slave AXI clock
> > +            - const: slave_q2a # Slave Q2A clock
> > +            - const: ref # REFERENCE clock
> > +            - const: tbu # PCIe TBU clock
> > +        resets:
> > +          maxItems: 1
> > +        reset-names:
> > +          items:
> > +            - const: pci # PCIe core reset
> > +
> >    - if:
> >        properties:
> >          compatible:
> > @@ -524,7 +551,6 @@ allOf:
> >          compatible:
> >            contains:
> >              enum:
> > -              - qcom,pcie-sc8180x
> >                - qcom,pcie-sm8150
> >                - qcom,pcie-sm8250
> >      then:
> > @@ -749,6 +775,7 @@ allOf:
> >            contains:
> >              enum:
> >                - qcom,pcie-sa8540p
> > +              - qcom,pcie-sc8180x
> >                - qcom,pcie-sc8280xp
> >      then:
> >        required:
> 
> Best regards,
> Krzysztof

-- 
~Vinod
