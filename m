Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9E1605927
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 09:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiJTH51 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 03:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiJTH5Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 03:57:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848E517D872;
        Thu, 20 Oct 2022 00:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B295E61A5E;
        Thu, 20 Oct 2022 07:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B678C433C1;
        Thu, 20 Oct 2022 07:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666252643;
        bh=/25+cqbt4mdOvWwj1tRncSUFWAEXYfCK1XMU8Ih3Wfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKMTB3PbxAYXjK4E3aFxRztZxLImdaTVL1YtLp13eOaypLl8hvvPkKgLZmK2lViBt
         uANJOFraxhoCIEscKFklvRz+IIccDdGEnIvwP4EFcHchLgrQZHuo0vaHAeVhf+u1fK
         kjryITDXpSbhtK7LVbYUv13GxO/1mJ5EnQTUlacmIQ3eDW4L2cUqhk1hNTNOXt++AV
         f17Na3PdsiwN+LK0HEsCAA+goNpWKOf3i+ADUskSAAhpAeb1DZEWN4lVmWC8INUqK/
         BDXnImdJjUicuPYUroC2d/DX4t7Y+sfRgWBk7w1hChOFd3p/CNLd8vnJ7z58VM+GUP
         BDWDx4Sr66nQw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1olQQP-0000NY-6O; Thu, 20 Oct 2022 09:57:09 +0200
Date:   Thu, 20 Oct 2022 09:57:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: qcom: Add SC8280XP/SA8540P
 interconnects
Message-ID: <Y1D/Vaa/3zKP4Cxj@hovoldconsulting.com>
References: <20221017112449.2146-1-johan+linaro@kernel.org>
 <20221017112449.2146-2-johan+linaro@kernel.org>
 <010b6de2-5df6-77c9-2f04-43f2edc89ff2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010b6de2-5df6-77c9-2f04-43f2edc89ff2@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 19, 2022 at 10:37:31AM -0400, Krzysztof Kozlowski wrote:
> On 17/10/2022 07:24, Johan Hovold wrote:
> > Add the missing SC8280XP/SA8540P "pcie-mem" and "cpu-pcie" interconnect
> > paths to the bindings.
> > 
> > Fixes: 76d777ae045e ("dt-bindings: PCI: qcom: Add SC8280XP to binding")
> > Fixes: 76c4207f4085 ("dt-bindings: PCI: qcom: Add SA8540P to binding")
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  .../devicetree/bindings/pci/qcom,pcie.yaml    | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > index 22a2aac4c23f..a55434f95edd 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > @@ -62,6 +62,12 @@ properties:
> >      minItems: 3
> >      maxItems: 12
> >  
> > +  interconnects:
> > +    maxItems: 2
> > +
> > +  interconnect-names:
> > +    maxItems: 2
> > +
> >    resets:
> >      minItems: 1
> >      maxItems: 12
> > @@ -629,6 +635,25 @@ allOf:
> >            items:
> >              - const: pci # PCIe core reset
> >  
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,pcie-sa8540p
> > +              - qcom,pcie-sc8280xp
> > +    then:
> > +      properties:
> > +        interconnects:
> > +          maxItems: 2
> 
> No need for this.
> 
> > +        interconnect-names:
> > +          items:
> > +            - const: pcie-mem
> > +            - const: cpu-pcie
> > +      required:
> > +        - interconnects
> > +        - interconnect-names
> 
> else:
>   ??
> 
> Otherwise, you allow any names for other variants.

Are you suggesting something like moving the names to the common
constraints for now:

  interconnects:
    maxItems: 2

  interconnect-names:
    items:
      - const: pcie-mem
      - const: cpu-pcie

and then in the allOf:

  - if:
      properties:
        compatible:
          contains:
            enum:
              - qcom,pcie-sa8540p
              - qcom,pcie-sc8280xp
    then:
      required:
        - interconnects
        - interconnect-names
    else:
      properties:
        interconnects: false
        interconnect-names: false

This way we'd catch anyone adding interconnects to a DTS without first
updating the bindings, but it also seems to go against the idea of
bindings fully describing the hardware by saying that no other platforms
have interconnects (when they actually do even if we don't describe it
just yet).

Or should we do the above but without the else clause to have some
constraints in place on the names at least?

Johan
