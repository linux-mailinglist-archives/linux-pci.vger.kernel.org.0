Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E0751CB05
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 23:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385951AbiEEVd6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 17:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244043AbiEEVdw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 17:33:52 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B46050050;
        Thu,  5 May 2022 14:30:11 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id g11-20020a9d648b000000b00605e4278793so3768532otl.7;
        Thu, 05 May 2022 14:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WuCCq/QoQz31nZcRnikiqgLo1XDDILHAWjHAzyh3rxA=;
        b=35Pj+eX9p+OhXEJkbO6IjGA520XfhkCqPmbWMr8zY7RMz+1pL+mdaxblKYbuxDpFg4
         /QGqJ6Eleo/3RQwcAGsGPlx5tmhqgqd7l2GgSFKlsUGyA2S/xxK3QYTbdKd4HtoplWEx
         S6mt1rA0sGm9Pn15AAbl6MTxQjN5b/XTr0DVftU03pRVuy2Pzajn4vXvQEQ2GN6+0Rvl
         IWVf+Anm7HzMOyeexqd2cG92Ev5+m1NMIDfss9QKwR9cTDyFC/TJId1kyyG3dpFcxKbO
         saJSwM030uUyhfl3kC+9CjsIX2PSrQ51K+/o6bFa3dyezw+JthR43B2iWG2Qgj4X/tu9
         PF7g==
X-Gm-Message-State: AOAM533Pdmkud8ZDOvLsrmOIek/9+ms+g5xsYp1Om7/BBYngoSzZnc2p
        8hgpItvGFbzWA3H0aDdoiA==
X-Google-Smtp-Source: ABdhPJxYUiEwyjr9WAszU18QEmYlTm4u+uJ2LvGchyYa+Q0ug6SbmePmTLveBrcCeevGUpbYWTnCEg==
X-Received: by 2002:a05:6830:49:b0:605:5985:21b2 with SMTP id d9-20020a056830004900b00605598521b2mr69998otp.153.1651786211116;
        Thu, 05 May 2022 14:30:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d15-20020a05683025cf00b0060603221278sm975719otu.72.2022.05.05.14.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 14:30:10 -0700 (PDT)
Received: (nullmailer pid 224737 invoked by uid 1000);
        Thu, 05 May 2022 21:30:09 -0000
Date:   Thu, 5 May 2022 16:30:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 6/7] dt-bindings: PCI: qcom: Support additional MSI
 interrupts
Message-ID: <YnRB4UxBzFDmsls7@robh.at.kernel.org>
References: <20220505135407.1352382-1-dmitry.baryshkov@linaro.org>
 <20220505135407.1352382-7-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505135407.1352382-7-dmitry.baryshkov@linaro.org>
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

On Thu, May 05, 2022 at 04:54:06PM +0300, Dmitry Baryshkov wrote:
> On Qualcomm platforms each group of 32 MSI vectors is routed to the
> separate GIC interrupt. Document mapping of additional interrupts.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 45 ++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 0b69b12b849e..fd3290e0e220 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -43,11 +43,20 @@ properties:
>      maxItems: 5
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 8
>  
>    interrupt-names:
> +    minItems: 1
>      items:
>        - const: msi
> +      - const: msi2

Is 2 from some documentation or you made up. If the latter, software 
folks start numbering at 0, not 1. :) I wouldn't care, but I think this 
may become common. 

> +      - const: msi3
> +      - const: msi4
> +      - const: msi5
> +      - const: msi6
> +      - const: msi7
> +      - const: msi8
