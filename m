Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294945221B6
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 18:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347670AbiEJQyp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 12:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347689AbiEJQyn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 12:54:43 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C250165B8;
        Tue, 10 May 2022 09:50:41 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id q10so4013224oia.9;
        Tue, 10 May 2022 09:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B3sdHtLCLqCtzcR8PT+tmEwLfguhQ3CqlLtMecSR1Vw=;
        b=bVI6ge+ebdCQw1aytBwaIVDl9XPGjHzOY6P8xf1wuL2otIwW/7RVjfCK2eTlgb0VVh
         goxLB5K9DjJqp4i/sr3/FpISLVQ+uXmuLarB6XyHsroaBTHGDz5MeeVAH5/ZxI4f2HeB
         OJ5WVydbCTHfykIjorJSG2oKM7x7I7j0hvLJoEEh9T/9nGUD3webXLp4zRUeaToNsIJh
         qi+AdjVSgfqXGjQHszM/Rq4CVM25pY0idaP8EG43Efx0N53rvKeTZZG1jkSWjKo/gCnf
         8umHMaoCHEYLFdxR5rxV1Mqb9+L/Vih5lIuPG7V+2ENuFxLLHK4ezvE1aOq3prztb0f6
         yi/Q==
X-Gm-Message-State: AOAM530AScCWgC5q25536ZToLBx+urSPap5I3fs1OqX3HJPm1Q/Wqouq
        lMbnWOcH+9F25OJH0yo8tg==
X-Google-Smtp-Source: ABdhPJwy45fRS0tiYahp1LC3/uI3tPz8OaNKpA9VxUOABysCHuGZ47sXiGRVMbOS3RgvlDnb6zvmtw==
X-Received: by 2002:aca:62c5:0:b0:326:b067:ac89 with SMTP id w188-20020aca62c5000000b00326b067ac89mr456323oib.281.1652201439460;
        Tue, 10 May 2022 09:50:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v8-20020a4ade88000000b0035eb4e5a6b2sm6265009oou.8.2022.05.10.09.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:50:39 -0700 (PDT)
Received: (nullmailer pid 2180926 invoked by uid 1000);
        Tue, 10 May 2022 16:50:38 -0000
Date:   Tue, 10 May 2022 11:50:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v6 4/8] dt-bindings: PCI: qcom: Add schema for sc7280
 chipset
Message-ID: <YnqX3hCJHoJfUB0V@robh.at.kernel.org>
References: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
 <20220506152107.1527552-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506152107.1527552-5-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 06 May 2022 18:21:03 +0300, Dmitry Baryshkov wrote:
> Add support for sc7280-specific clock and reset definitions.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
