Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572FB5B7E9A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 03:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiINBrH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 21:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiINBrF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 21:47:05 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850306E881;
        Tue, 13 Sep 2022 18:47:03 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-12b542cb1d3so27347767fac.13;
        Tue, 13 Sep 2022 18:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=K8MoQkRZmi/LYNPtYXflW9XvtwbZnRwT9HzOjVCpu2I=;
        b=ItRVdaMyWZBTVjZkrBOPBtnn43+SSCF7xnF0zw3R/2vlNmaTpg97ywN2vuKtHdg/b5
         iSS6hxDOCPoBuq1ateMXukTJ3ZonIbcyIrWerdhbHgcr64jaZne4oa6eu47uMAzwZzpH
         kJjUf8OwsCjxKOfeebJ4Zl2P19JQ07QZ6R4NZqlpm9f7qecs2jgURBRcu/4QMGgxbuW0
         YZhzgvKYV3SRQthvLlu38N9JyeNggmjbOC9hnAp2cAK0PvQMqN1UI22uSP46onakhDpS
         rwbpBKb4aJAMZqqSlcHL8LhiEWoPsrKDEwfE8ckMKjvRYnJxOdYlAaNLnCPCeNRxgE1X
         YyzQ==
X-Gm-Message-State: ACgBeo3qiTb59IemdpaxsDuj0Enm2Xsm9f+FsW2maK6rq7b8CQynhDfo
        OF1e4gdr28OJwEboRhgynw==
X-Google-Smtp-Source: AA6agR4/cxoFs9ujzvZIWMAn2AwSGI1SC0yWBkdjv34kuvc4s+2XIo9pRsbzsknDlY+3sLHnu4NQ6w==
X-Received: by 2002:a05:6808:2190:b0:34d:8ea6:3e9d with SMTP id be16-20020a056808219000b0034d8ea63e9dmr997459oib.40.1663120022627;
        Tue, 13 Sep 2022 18:47:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p7-20020a056870830700b0011d23ed5365sm7900993oae.43.2022.09.13.18.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 18:47:02 -0700 (PDT)
Received: (nullmailer pid 909955 invoked by uid 1000);
        Wed, 14 Sep 2022 01:47:01 -0000
Date:   Tue, 13 Sep 2022 20:47:01 -0500
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
Message-ID: <20220914014701.GA853152-robh@kernel.org>
References: <20220911135547.23106-1-krzysztof.kozlowski@linaro.org>
 <11e61fa5-f770-9c9f-23b9-3d1dcb205bc5@linaro.org>
 <20220913152054.GA3736444-robh@kernel.org>
 <d22ed818-1a8d-4af8-d41d-2268806f3dea@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d22ed818-1a8d-4af8-d41d-2268806f3dea@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 13, 2022 at 06:25:49PM +0200, Krzysztof Kozlowski wrote:
> On 13/09/2022 17:20, Rob Herring wrote:
> > On Sun, Sep 11, 2022 at 04:14:54PM +0200, Krzysztof Kozlowski wrote:
> >> On 11/09/2022 15:55, Krzysztof Kozlowski wrote:
> >>> qcom,perst-regs is an phandle array of one item with a phandle and its
> >>> arguments.
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> ---
> >>>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 6 ++++--
> >>>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> >>> index 3d23599e5e91..077e002b07d3 100644
> >>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> >>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> >>> @@ -60,8 +60,10 @@ properties:
> >>>                   enable registers
> >>>      $ref: "/schemas/types.yaml#/definitions/phandle-array"
> >>>      items:
> >>> -      minItems: 3
> >>> -      maxItems: 3
> >>> +      - items:
> >>> +          - description: Syscon to TCSR system registers
> >>> +          - description: Perst enable offset
> >>> +          - description: Perst separateion enable offset
> >>
> >> Unfortunately this still complains:
> >>
> >> qcom-sdx55-t55.dtb: pcie-ep@40000000: qcom,perst-regs:0: [28] is too short
> >>
> >>
> >> where 28 is the phandle...
> > 
> > Meaning the dt is wrong or there's a tooling issue?
> 
> I think tooling issue. I looked at this many times and code (schema and
> DTS) seems to be correct, but tool doesn't like it.

Okay, I found the issue. Will test it a bit more and apply it tomorrow.

Rob
