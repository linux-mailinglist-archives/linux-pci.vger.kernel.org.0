Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1EF5BB269
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 20:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiIPSro (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 14:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiIPSrn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 14:47:43 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098C9B8A6B;
        Fri, 16 Sep 2022 11:47:43 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-11eab59db71so53315657fac.11;
        Fri, 16 Sep 2022 11:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jVuUrK9dbYpWhImD0AMyVwk622t4wxCeHcudfRIovfo=;
        b=iJ/hKkAX5LXGFtEze3H/aZdYyUntAiKcpsMqivEWvv/ypqHG3NVJsvRrYpmh+4vTJp
         kMexYDWqWHwZq91OdOowZWYEPobLM/GGNeGaFzb746mQ+comxRlQ3MreiXJyczmW8DHG
         goZOuF32wOLLP4K1uSi7duWvEWs+JOSFjWwhgSczHcoMOM4dtacEU/Dzlyig0XQKEB3+
         ktB2pGCvQrIzYqbhrUcDeI00RFzxLUhASIsmKFSpjhSR5A5aFgYEEMy0NdthtSrZFT6X
         KjRhIoxAKl7URuTsYJSwm6HuzXjun5sFLORB4/ytWxeY0oDlc6PxwVIgwBDxeroS2F6F
         MeCg==
X-Gm-Message-State: ACgBeo2gSY6O09EKsvqmBI8vTTRx6XoQISdEw5hfl+nSdhq1paTers7T
        XdSAEoOWPD49FM5t/7O/Lw==
X-Google-Smtp-Source: AA6agR4suQVf0qCWUScIjOPKR6YSv2cnYkMDp4GpWNbqFIUEP9mK152MBoOq/hukIdk1UMOaNrK6wg==
X-Received: by 2002:a05:6870:479a:b0:fe:3958:813e with SMTP id c26-20020a056870479a00b000fe3958813emr9373436oaq.279.1663354062216;
        Fri, 16 Sep 2022 11:47:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g25-20020a9d5f99000000b006540dd3daa8sm710535oti.51.2022.09.16.11.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:47:41 -0700 (PDT)
Received: (nullmailer pid 1059563 invoked by uid 1000);
        Fri, 16 Sep 2022 18:47:41 -0000
Date:   Fri, 16 Sep 2022 13:47:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] dt-bindings: pci: qcom,pcie-ep: correct qcom,perst-regs
Message-ID: <20220916184741.GA1057850-robh@kernel.org>
References: <20220911135547.23106-1-krzysztof.kozlowski@linaro.org>
 <11e61fa5-f770-9c9f-23b9-3d1dcb205bc5@linaro.org>
 <20220913152054.GA3736444-robh@kernel.org>
 <d22ed818-1a8d-4af8-d41d-2268806f3dea@linaro.org>
 <20220914014701.GA853152-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914014701.GA853152-robh@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 13, 2022 at 08:47:01PM -0500, Rob Herring wrote:
> On Tue, Sep 13, 2022 at 06:25:49PM +0200, Krzysztof Kozlowski wrote:
> > On 13/09/2022 17:20, Rob Herring wrote:
> > > On Sun, Sep 11, 2022 at 04:14:54PM +0200, Krzysztof Kozlowski wrote:
> > >> On 11/09/2022 15:55, Krzysztof Kozlowski wrote:
> > >>> qcom,perst-regs is an phandle array of one item with a phandle and its
> > >>> arguments.
> > >>>
> > >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > >>> ---
> > >>>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 6 ++++--
> > >>>  1 file changed, 4 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > >>> index 3d23599e5e91..077e002b07d3 100644
> > >>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > >>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > >>> @@ -60,8 +60,10 @@ properties:
> > >>>                   enable registers
> > >>>      $ref: "/schemas/types.yaml#/definitions/phandle-array"
> > >>>      items:
> > >>> -      minItems: 3
> > >>> -      maxItems: 3
> > >>> +      - items:
> > >>> +          - description: Syscon to TCSR system registers
> > >>> +          - description: Perst enable offset
> > >>> +          - description: Perst separateion enable offset
> > >>
> > >> Unfortunately this still complains:
> > >>
> > >> qcom-sdx55-t55.dtb: pcie-ep@40000000: qcom,perst-regs:0: [28] is too short
> > >>
> > >>
> > >> where 28 is the phandle...
> > > 
> > > Meaning the dt is wrong or there's a tooling issue?
> > 
> > I think tooling issue. I looked at this many times and code (schema and
> > DTS) seems to be correct, but tool doesn't like it.
> 
> Okay, I found the issue. Will test it a bit more and apply it tomorrow.

This and some other cases are now fixed. There's a new release, 
v2022.09.

Rob
