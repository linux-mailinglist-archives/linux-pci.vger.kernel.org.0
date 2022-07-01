Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CCE562E81
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 10:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiGAIiq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 04:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiGAIip (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 04:38:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E5E3CA53;
        Fri,  1 Jul 2022 01:38:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5127A6214C;
        Fri,  1 Jul 2022 08:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A280DC3411E;
        Fri,  1 Jul 2022 08:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656664723;
        bh=5eFFXT1JqKLVXe2jGRHGNyXspF/REaC2gxRb5M8apLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ViMiP6TXBT06Rmk9M4S8gY06EImURRdD/2Gditmn0Kl8xzXEJZJjlZsRWUfEiqQda
         I7gcPD5rPpOeelnV8B/rpUam4v9sYVuIGcMoLuE89oHdRYA+sra7+QfzzadPlEYWDY
         OwVvEJia8w2LA7ZDWufFCKXfk1G5Mcl1XRQIyBxiYmkOUQt5QtUvIHglPSRzaMYh/1
         hcdeEXxisXrW8j09KwHr4Bd9nObqfMZ1Xcm38+HLTZMSe1qi+sCI6Gsym4CAZj7Tm9
         0xBfhHq6mem2DmJC3eC6LUTNeMgXVunKRPtBGRPbycmFu6qwC3kwsaSEKuS9C6BHTf
         GcMDlSTaL8dNg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o7CAk-0001WF-D5; Fri, 01 Jul 2022 10:38:43 +0200
Date:   Fri, 1 Jul 2022 10:38:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: PCI: qcom: Enumerate platforms with
 single msi interrupt
Message-ID: <Yr6ykvru52aDZhFm@hovoldconsulting.com>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-4-johan+linaro@kernel.org>
 <c20ba06c-b37a-e91c-84c6-6d2147bb2478@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c20ba06c-b37a-e91c-84c6-6d2147bb2478@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 01, 2022 at 10:33:35AM +0200, Krzysztof Kozlowski wrote:
> On 29/06/2022 16:09, Johan Hovold wrote:
> > Explicitly enumerate the older platforms that have a single msi host
> > interrupt. This allows for adding further platforms without resorting
> > to nested conditionals.
> > 
> > Drop the redundant comment about older chipsets instead of moving it.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> This does not exist in linux-next, so it should be squashed it with the
> previous series.

As mentioned in the cover letter this depends on the MSI series that has
unfortunately not yet been merged.

That series is self-contained and ready to be merged, so this follow-up
does not need to be squashed in.

> > ---
> >  .../devicetree/bindings/pci/qcom,pcie.yaml      | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > index a1b4fc70e162..8560c65e6f0b 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > @@ -625,7 +625,6 @@ allOf:
> >          - reset-names
> >  
> >      # On newer chipsets support either 1 or 8 msi interrupts
> > -    # On older chipsets it's always 1 msi interrupt
> >    - if:
> >        properties:
> >          compatible:
> > @@ -660,7 +659,21 @@ allOf:
> >                  - const: msi5
> >                  - const: msi6
> >                  - const: msi7
> > -    else:
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,pcie-apq8064
> > +              - qcom,pcie-apq8084
> > +              - qcom,pcie-ipq4019
> > +              - qcom,pcie-ipq6018
> > +              - qcom,pcie-ipq8064
> > +              - qcom,pcie-ipq8064-v2
> > +              - qcom,pcie-ipq8074
> > +              - qcom,pcie-qcs404
> 
> Otherwise I cannot even check the context...

Yeah, I realise that makes reviewing a bit harder, but hopefully the
maintainer will pick up the MSI series soon.

> 
> > +    then:
> >        properties:
> >          interrupts:
> >            maxItems: 1

Johan
