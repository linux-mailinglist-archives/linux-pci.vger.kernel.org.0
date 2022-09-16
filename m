Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD205BB26C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 20:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiIPSsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiIPSsC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 14:48:02 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EE1B8F02;
        Fri, 16 Sep 2022 11:48:02 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-12803ac8113so53338942fac.8;
        Fri, 16 Sep 2022 11:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=I2pp5THAyINnO6w87sweoq/v2+vTPJEhlON9CiVyD5k=;
        b=QOTLMx071Pb45JJNTr4NpCWrntm4iDVb4ABFlSmDnXRoDJpwnGw8yIbh9+wkrh9bjv
         RRdHV+PVUy+Y+pEiACXg4PX9V2y1DVJ1Q1FfvJEGThTXmS4uibrYVmMeA9kgTFS2FpJA
         jwCuJOO9yKxGkCSZb0q+k4g/Jo+t7FDflCo82hHT26GrbKYwIO5rR0mXwdQVSWOm0Byj
         s7KPX+SLYLOfwT3byz6iLfPPtAE0Z1ir3eGxRvbeXOOs4DC4i+OU9K9vTF2ALQNNptBt
         Y14Yr6SItitKtUmd6XNK2gV25GfFpUa5Dpdo9sT4tPTPtOjCopUvAd5JezhTRGXIEXpI
         rlQQ==
X-Gm-Message-State: ACrzQf3jFrwTqqdCQ498CJFxfty/JM/+os7armTxZbb8bPISPwhcYAV1
        0ri8GEj6xJdLByrde5ltiQ==
X-Google-Smtp-Source: AMsMyM7xPAYZJi8iM/W5sWwT3u/51/+X6JXHwEA5DVlwD1sKlMT4A+NGWLh00u5OgFsjwLuvT6ySLg==
X-Received: by 2002:a05:6871:794:b0:12c:4bff:341d with SMTP id o20-20020a056871079400b0012c4bff341dmr3443500oap.127.1663354081276;
        Fri, 16 Sep 2022 11:48:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f78-20020a9d03d4000000b00638ef9bb847sm5624832otf.79.2022.09.16.11.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:48:00 -0700 (PDT)
Received: (nullmailer pid 1060223 invoked by uid 1000);
        Fri, 16 Sep 2022 18:48:00 -0000
Date:   Fri, 16 Sep 2022 13:48:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH] dt-bindings: pci: qcom,pcie-ep: correct qcom,perst-regs
Message-ID: <20220916184800.GA1060161-robh@kernel.org>
References: <20220911135547.23106-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911135547.23106-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 11 Sep 2022 15:55:47 +0200, Krzysztof Kozlowski wrote:
> qcom,perst-regs is an phandle array of one item with a phandle and its
> arguments.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
