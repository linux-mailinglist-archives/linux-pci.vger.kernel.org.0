Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D334FE571
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 17:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348933AbiDLP5T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 11:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357510AbiDLP5N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 11:57:13 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE051C928;
        Tue, 12 Apr 2022 08:54:19 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id a19so14954129oie.7;
        Tue, 12 Apr 2022 08:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D0GRUR+vVvtF2S/3CkHhGwTpe4mfomdQb7oA/XlL1lo=;
        b=mzbMSE/Pic5wWupL61AookTwylS9JypyYY95ahUmDZkELhj675LKoDl8mvbBz7gi+L
         5iOmhcS3juSyo0ItBXs8G8qQpFTOiF1SzYDhpcN6GRdB3Uclq07GQ2FtWi88WynroC+u
         q9ynM4tkg1UqCys+s4aPog57pHsq7yejANxzC+GMlaV2i0Rf33ChVrfAP38RmbXat9u/
         nqeI2bBjRmcFXuP5vknKuS4qd4chLvJf1nN9RJAoZ/4MjNjUI9etCK0sraDpPTmGKYZy
         /6yYjzXR49xnUoj8dhuOgo1CwbAe4za4xtnEgQgSLjU3tfBEAWFWilhVsdLkcjWS/HhA
         QiAA==
X-Gm-Message-State: AOAM531/HWcz0a9HNJCuYjyrOx27tTNE6FjXNhe3h4guT5mYjOAD81XY
        1PFlydEfHMiliUYaHGFf8YFdE93W5g==
X-Google-Smtp-Source: ABdhPJzq3SNk83P0TvMM+kOrjCziIl36Dzd/H3+CNa2g9jUoHR8FWOALhYIxzxPSYs89XzeYkROZug==
X-Received: by 2002:a05:6808:2005:b0:2f9:4e60:9a6e with SMTP id q5-20020a056808200500b002f94e609a6emr2112474oiw.77.1649778858453;
        Tue, 12 Apr 2022 08:54:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v17-20020a4a6951000000b00329d8b23f0dsm664629oof.5.2022.04.12.08.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 08:54:18 -0700 (PDT)
Received: (nullmailer pid 354373 invoked by uid 1000);
        Tue, 12 Apr 2022 15:54:17 -0000
Date:   Tue, 12 Apr 2022 10:54:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: pci: qcom: Document additional PCI MSI
 interrupts
Message-ID: <YlWgqd3bhZPCxbji@robh.at.kernel.org>
References: <20220411114926.1975363-1-dmitry.baryshkov@linaro.org>
 <20220411114926.1975363-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411114926.1975363-3-dmitry.baryshkov@linaro.org>
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

On Mon, Apr 11, 2022 at 02:49:24PM +0300, Dmitry Baryshkov wrote:
> On Qualcomm platforms each group of MSI interrupts is routed to the
> separate GIC interrupt. Document mapping of additional interrupts.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 0adb56d5645e..64632f3e4334 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -57,12 +57,14 @@
>  - interrupts:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> -	Definition: MSI interrupt
> +	Definition: MSI interrupt(s)
>  
>  - interrupt-names:
>  	Usage: required
>  	Value type: <stringlist>
>  	Definition: Should contain "msi"
> +		    May also contains "msi2", "msi3"... up to "msi8"
> +		    if the platform supports additional MSI interrupts.

This binding seems to see lots of small changes frequently. Please 
convert it to schema. (Maybe I already asked for that?)

Rob
