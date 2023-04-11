Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEAC6DE30C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 19:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjDKRsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 13:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjDKRsG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 13:48:06 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810235BBA;
        Tue, 11 Apr 2023 10:47:44 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id m2so5554337oiw.0;
        Tue, 11 Apr 2023 10:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235264; x=1683827264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JG4o7reBA9+dOgW5E+9NKwVQ6lKpSokWVMLzqfn9oU=;
        b=BNpAY2bI2zbtBNftjj6xrtnkkowYJHsFePS5fjesSvxrWGLLb/zKZa3q5GJ28IvkRH
         /2G/yPfqz/YMqvpPRro8aXMETuuoMeJOa/fjOgamozBAN2KRHMWztI20B6JQToM1CG75
         cx5uFvNyrWWqRjuXTkS3e7JTzA83PjNX7x7+oz9vA/ISD0fN9u43MmjNfh5pi4tUFwDu
         grDG9brU2WnGJFwJOTvloAEzppN2d5EcHzty2Ytz8Rg20RuoA6uYaPsm8t41MnpMuUSH
         8/KLwUkEw8hbyLdv6cLV5FL42LoOZZpH7aucepq+pNWGQNb2ytROGZcYSjFLSw+HoB2C
         NxFQ==
X-Gm-Message-State: AAQBX9cz7NgbzeJ3fvNju1e45MvnohQJWplAjelrM9GdqeKe2BJzd5RS
        0C3SO9Q+ajxLKOvtALWcGw==
X-Google-Smtp-Source: AKy350Yvo5WLc4YeS8bcfayrFDiPJW7uJSUi3dEelGXL6x9fRMF9gtAHB8vKd+3V+GGoq5zwDWzX5g==
X-Received: by 2002:a05:6808:298b:b0:389:1c19:f684 with SMTP id ex11-20020a056808298b00b003891c19f684mr6016857oib.23.1681235263775;
        Tue, 11 Apr 2023 10:47:43 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p5-20020acabf05000000b003896f132821sm5827150oif.41.2023.04.11.10.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:47:43 -0700 (PDT)
Received: (nullmailer pid 3431192 invoked by uid 1000);
        Tue, 11 Apr 2023 17:47:42 -0000
Date:   Tue, 11 Apr 2023 12:47:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        bhelgaas@google.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lpieralisi@kernel.org
Subject: Re: [PATCH] Revert "dt-bindings: PCI: qcom: Add iommu-map properties"
Message-ID: <20230411174742.GA3428751-robh@kernel.org>
References: <20230411121533.22454-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411121533.22454-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 11, 2023 at 05:45:33PM +0530, Manivannan Sadhasivam wrote:
> This reverts commit 6ebfa40b63ae65eac20834ef4f45355fc5ef6899.
> 
> "iommu-map" property is already documented in commit

Need the commit hash here.

> ("dt-bindings: PCI: qcom: Add SM8550 compatible") along with the "iommus"
> property.

Shouldn't there be a patch removing "iommus" as discussed?

> 
> So let's revert the commit that just added "iommu-map" to avoid
> duplication.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 5d236bac99b6..a1318a4ecadf 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -78,8 +78,6 @@ properties:
>  
>    dma-coherent: true
>  
> -  iommu-map: true
> -
>    interconnects:
>      maxItems: 2
>  
> -- 
> 2.25.1
> 
