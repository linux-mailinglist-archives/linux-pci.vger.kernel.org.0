Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095685B778D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 19:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbiIMROy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 13:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiIMRO2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 13:14:28 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92448D021A;
        Tue, 13 Sep 2022 09:02:52 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-127f5411b9cso33343951fac.4;
        Tue, 13 Sep 2022 09:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=GtTTov0T06uIiJuUKruKJyUrwBkCGa7vjtJb2xNlITY=;
        b=PapFfJ+4oVw2KA6uxzEXi7s5X8aG/GfnBqcxeIglWTt9hBSwBkz6mhRaMyXOSIaa76
         bkgyG2tM05ZjiEqopwoII1Xcfz85eifC7RTh/9kdv91eKZb/8X35a69MufDwlDawH0qn
         ZhU5/3m47r/iK1LzENkfTwTwQRyrxwDoLoUjKc1OlG87sVKQCP53mIgBbyUdubD92den
         dmw6Td8/mrh2U9gEYlkyH+4/HlgBodr1a7BKQCWdUljfvSEXKzMGp4dkNARfrBwiTaxx
         kI61GdC+jmWYtCpUghL7VMkgu5poUFzSov4VxKjkaweCbiGwFMon9lR8yk+zOe7iv2vK
         ACNw==
X-Gm-Message-State: ACgBeo1MIOPkYm8503izW7X41caNas+w/t7vEj1qNNnD6d/AiXkM5XSc
        XRm4pPQKqcIe8m8NoeZ3rofoX9Yfog==
X-Google-Smtp-Source: AA6agR6UMqdbCDoRd6wsJDwcQyg7o1JLfwFQj1cvGvrGlJncB9YfGiNYIy7HsMNh1oqW9xxioxbFgw==
X-Received: by 2002:a05:6808:1294:b0:344:9e65:915e with SMTP id a20-20020a056808129400b003449e65915emr1632255oiw.251.1663080272864;
        Tue, 13 Sep 2022 07:44:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v8-20020a4aaec8000000b00441b98453d8sm5483084oon.8.2022.09.13.07.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:44:32 -0700 (PDT)
Received: (nullmailer pid 3645311 invoked by uid 1000);
        Tue, 13 Sep 2022 14:44:31 -0000
Date:   Tue, 13 Sep 2022 09:44:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, lpieralisi@kernel.org, bhelgaas@google.com,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.baryshkov@linaro.org, linux-pci@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v3 11/12] dt-bindings: PCI: qcom-ep: Add support for
 SM8450 SoC
Message-ID: <20220913144431.GA3645220-robh@kernel.org>
References: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
 <20220910063045.16648-12-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910063045.16648-12-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 10 Sep 2022 12:00:44 +0530, Manivannan Sadhasivam wrote:
> Add devicetree bindings support for SM8450 SoC. Only the clocks are
> different on this platform, rest is same as SDX55.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 39 +++++++++++++++++--
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
