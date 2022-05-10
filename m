Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05E9522130
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 18:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243592AbiEJQaq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 12:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243079AbiEJQao (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 12:30:44 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CA928E34;
        Tue, 10 May 2022 09:26:46 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-ee1e7362caso14786999fac.10;
        Tue, 10 May 2022 09:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WzD+YTsz1rM2b7m6DngQD5N/Wzdxf9L3miiFkQ+qwo0=;
        b=2mvTryIRtowzgqqoWc/NjJhxxPNVI6Op3UDCbrdsw8NLd+gKtSsDqKgdwbSO0dsJOd
         0C/md49aMbX5CNiuO3164YbFijFW1TNCxPLMUPeumaDsiUs1DFUKHtp++YsnjMaqLDtl
         T4HypI64VF+CA570VAAeBS76o3giIeoJguKwSEtGq198Lh3CXFEhUFIh5HvcJTLiLAy0
         sH6az4IsZoUVJqihKIowGj9CxYIFs/fZzaOPf9Fju2MS0fx06zyPHLm2wYhiofIZK+Jj
         S2stT7yDx41wmMkva93ARlcs3ViU+rGFaZpuyDEoPU6AugZuKHjfrVEXb73hlBAcS1+X
         dyxg==
X-Gm-Message-State: AOAM53246c1PLppTzcmFHmvQGTDpp9aSEwpW3R5OhFua2U29bFY8EF37
        xGUdCmIAMpYxpwLFcGqKkLjtUfB+ww==
X-Google-Smtp-Source: ABdhPJwrz8UGPAoMf9vTtsdCcgxSA0IFnPgK1iwiTGabKH1cqAbPZ5gMCEfujVeb5JS6IxC1ST9zJg==
X-Received: by 2002:a05:6870:a54d:b0:ec:e635:a4aa with SMTP id p13-20020a056870a54d00b000ece635a4aamr538689oal.148.1652200006035;
        Tue, 10 May 2022 09:26:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l18-20020a05687040d200b000f10ad9478bsm359780oal.36.2022.05.10.09.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:26:45 -0700 (PDT)
Received: (nullmailer pid 2141500 invoked by uid 1000);
        Tue, 10 May 2022 16:26:44 -0000
Date:   Tue, 10 May 2022 11:26:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v6 1/8] dt-bindings: PCI: qcom: Convert to YAML
Message-ID: <YnqSRCa1EkjPZ/Ls@robh.at.kernel.org>
References: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
 <20220506152107.1527552-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506152107.1527552-2-dmitry.baryshkov@linaro.org>
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

On Fri, 06 May 2022 18:21:00 +0300, Dmitry Baryshkov wrote:
> Changes to the schema:
>  - Fixed the ordering of clock-names/reset-names according to
>    the dtsi files.
>  - Mark vdda-supply as required only for apq/ipq8064 (as it was marked
>    as generally required in the txt file).
> 
> Changes to examples:
>  - Inline clock and reset numbers rather than including dt-bindings
>    files because of conflicts between the headers
>  - Split ranges and reg properties to follow current practice
>  - Change -gpio to -gpios
>  - Update IRQ flags to LEVEL_HIGH rater than NONE
>  - Removed extra "snps,dw-pcie" compatibility.
> 
> Note: while it was not clearly described in text schema, the majority of
> Qualcomm platforms follow the snps,dw-pcie schema and use two
> compatibility strings in the DT files: platform-specific one and a
> fallback to the generic snps,dw-pcie one. However the platform itself is
> not compatible with the snps,dw-pcie interface, so we are going to
> remove it.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt     | 398 ------------
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 595 ++++++++++++++++++
>  2 files changed, 595 insertions(+), 398 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
