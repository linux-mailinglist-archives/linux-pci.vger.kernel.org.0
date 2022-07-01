Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3ED562E9A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 10:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiGAImz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 04:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiGAImx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 04:42:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A37773584;
        Fri,  1 Jul 2022 01:42:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9421621F2;
        Fri,  1 Jul 2022 08:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC63C3411E;
        Fri,  1 Jul 2022 08:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656664972;
        bh=mEnpNa04cW7W2+foF0mx8jXYUwlICj51Uv92LnU2IG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ax5oSM90X/GgV5rdKmwlCZ6oma2twd9/gVwxV2np1EDjfKzqzQcGAZvtyMSzo4wU6
         Rhv5vbejaSonhpqum016w0B5nNvEFKLrF0MKuPFeysv4Mq6p4oTE8QKmDHBxIV8vzc
         OVuql1LFFgKXCRI+mXqQZ/In6m/XSwOY4hBWUhxX4PM+6weviaiL66eRaCVoYbAJUG
         rthD/bEtIox35R/h9W+pURSbbX++gd5Tw6AbO/zGB2qdRDlkWPOsuKp41qHI+KzjCV
         O0NQQUr9aI8pVNjvP42XBUIMcA3AdWobxxNureBMHEt8JGEC6U4aPzk5V2ZillqsT5
         NOhTlF7vJ5AaQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o7CEl-0001ZF-VB; Fri, 01 Jul 2022 10:42:52 +0200
Date:   Fri, 1 Jul 2022 10:42:51 +0200
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
Subject: Re: [PATCH 05/10] dt-bindings: PCI: qcom: Add SA8540P to binding
Message-ID: <Yr6zi6Jad5d0U1Ms@hovoldconsulting.com>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-6-johan+linaro@kernel.org>
 <63b8ec88-cb22-4644-e6dc-6878ad20c792@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63b8ec88-cb22-4644-e6dc-6878ad20c792@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 01, 2022 at 10:38:24AM +0200, Krzysztof Kozlowski wrote:
> On 29/06/2022 16:09, Johan Hovold wrote:
> > SA8540P is a new platform related to SC8280XP but which uses a single
> > host interrupt for MSI routing.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > index a039f6110322..e9a7c8c783e7 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > @@ -25,6 +25,7 @@ properties:
> >        - qcom,pcie-ipq4019
> >        - qcom,pcie-ipq8074
> >        - qcom,pcie-qcs404
> > +      - qcom,pcie-sa8540p
> >        - qcom,pcie-sc7280
> >        - qcom,pcie-sc8180x
> >        - qcom,pcie-sc8280xp
> > @@ -603,6 +604,7 @@ allOf:
> >          compatible:
> >            contains:
> >              enum:
> > +              - qcom,pcie-sa8540p
> >                - qcom,pcie-sc8280xp
> >      then:
> >        properties:
> > @@ -720,6 +722,7 @@ allOf:
> >                - qcom,pcie-ipq8064
> >                - qcom,pcie-ipq8064-v2
> >                - qcom,pcie-ipq8074
> > +              - qcom,pcie-sa8540p
> 
> Alphabetical order please.

Oops. Will fix.

> >                - qcom,pcie-qcs404

Johan
