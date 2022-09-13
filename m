Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201E75B767A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 18:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiIMQ17 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiIMQ1h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 12:27:37 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6767B2A4;
        Tue, 13 Sep 2022 08:23:03 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1280590722dso33060295fac.1;
        Tue, 13 Sep 2022 08:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Wk/p18xJMNComokJnouExLqevPYgY3WIuHduT5z5UaE=;
        b=LvEbm9VDVkG57pyliYr6qu0De9+H17QoDeY+ZGiTfH19xl10WNxXLxba7i6CPwUIan
         K4bTqo9D/He0ijMI+02PCSsz+36dBeCcRdafk0kbElEuWjq2xpjJxh19v8UX9bPlQDay
         N5j/92B0l23KVyMii0cXI6fkWqtuhEiTkMfXp6tRFvioO4euFe2CA9o2VBjmqYYGbrDM
         qBZoSjn8B8VH5224e/xoinAZRLHl3Rrtm7PcRJvWNErMX1vgZuedNXyBASwAEfLQJQ3n
         RZnaDI2mtJYdbaFIEIjQYjmMiBTe6c7F5cLGpLhPLmssUZIbapoZQGMDcmR4sjB6TRvc
         K2nw==
X-Gm-Message-State: ACgBeo2lH+htSpQuuVXVXyuBqzXpqmEf0OpBByKl2PTWNEy5472M0uDX
        QvMSG2EztCdS9L+FH74RdHJZTOxiJg==
X-Google-Smtp-Source: AA6agR7r0TwDiXVOXUGXZmyD9bayxsvjxqO1u/v0jvdTZFJic4WcZ4cxjERsdWDjKKY/rvsSto9+nA==
X-Received: by 2002:a05:6870:170b:b0:127:6654:6768 with SMTP id h11-20020a056870170b00b0012766546768mr2004800oae.256.1663082455510;
        Tue, 13 Sep 2022 08:20:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i34-20020a056870892200b0012644cc4feasm7055376oao.55.2022.09.13.08.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 08:20:55 -0700 (PDT)
Received: (nullmailer pid 3752130 invoked by uid 1000);
        Tue, 13 Sep 2022 15:20:54 -0000
Date:   Tue, 13 Sep 2022 10:20:54 -0500
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
Message-ID: <20220913152054.GA3736444-robh@kernel.org>
References: <20220911135547.23106-1-krzysztof.kozlowski@linaro.org>
 <11e61fa5-f770-9c9f-23b9-3d1dcb205bc5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11e61fa5-f770-9c9f-23b9-3d1dcb205bc5@linaro.org>
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

On Sun, Sep 11, 2022 at 04:14:54PM +0200, Krzysztof Kozlowski wrote:
> On 11/09/2022 15:55, Krzysztof Kozlowski wrote:
> > qcom,perst-regs is an phandle array of one item with a phandle and its
> > arguments.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > index 3d23599e5e91..077e002b07d3 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > @@ -60,8 +60,10 @@ properties:
> >                   enable registers
> >      $ref: "/schemas/types.yaml#/definitions/phandle-array"
> >      items:
> > -      minItems: 3
> > -      maxItems: 3
> > +      - items:
> > +          - description: Syscon to TCSR system registers
> > +          - description: Perst enable offset
> > +          - description: Perst separateion enable offset
> 
> Unfortunately this still complains:
> 
> qcom-sdx55-t55.dtb: pcie-ep@40000000: qcom,perst-regs:0: [28] is too short
> 
> 
> where 28 is the phandle...

Meaning the dt is wrong or there's a tooling issue?

Rob
