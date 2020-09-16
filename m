Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31F926CF2D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 00:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIPWzi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 18:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgIPWzi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 18:55:38 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC10C061756
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 15:55:37 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g96so108239otb.12
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 15:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MbTYK9R4eYcwLAa22Zq0SVs8G1ku9wPeHggwYVL9t+0=;
        b=VZKKhd25V0vp+PPBPd8N+CyMicBd9guD95ku8v1RW6KS1YRVgka4gQYXvSFxPWhmsE
         3ZDv7BT8Zq8h8xo/YHBuQEgPMsYUfzuNYYT1JAYaqpu7ZUKYitDJ2bHRFeW4JpVfHscJ
         +HUs9hATlrRmCknNnrnFg6o6BiYfx+d8QGLKmtOnkZR/k4OA+TS2H6nJ36ZxYDfZqeLs
         PBjWgDu8A3lnamU7GCSNOYkt0w2loZuiwL4Lxr+YLBjv7felodbJ+F9GZT0nAANRlSjd
         PU8pNuToKwj59zVH4FAMCHZTgEjU5BquEc+88IXSCXfWhGVO2UeCc/W3+AggsrXVg6vF
         2owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MbTYK9R4eYcwLAa22Zq0SVs8G1ku9wPeHggwYVL9t+0=;
        b=NL91IeqHxvyrhnKvUTq7M7dU9jGDDrhd9aLI2X9d0Ce9hGMhyEGHmlJPHUou8BtolH
         9SZ7R83cBEaOYA7ExHFJrx7AACMU/soTyyyjlBXczPPqnM0qMxeEQhfutTIkLijXn3jN
         gJJVz/+YXQGp2w6DJ/6REUKf6sqfzGwJs4jV1jUgconxrc7FgDq1jLAwQixWgSx1u53E
         F1CbuyIRWPoPm61UlZI2Z2kvavr9xmSJmHwgmG0QFdHVOl2xkDX+4UNY3ciwtyRBf2dC
         NGbt1kkRX/MHXrbGlpVFMiv09dESfceKcdKjcdoXGm5MxBA1ZNbP7kw6LqYb1bBbNbOK
         HA+g==
X-Gm-Message-State: AOAM533D1FKtKw0xsP550hb/dg+OAPgDhtaAbMWYcAwbKDqhoEMaSrBq
        m3xbs28QOcKhhsxPaDt93Vi6tA==
X-Google-Smtp-Source: ABdhPJzS7TDFcKrCHlyNXME33Jizng1OgJIqHOmi2hbpLL707jiZUT6FJrl7mwfFkaSzHlviEkoRHw==
X-Received: by 2002:a9d:335:: with SMTP id 50mr3726092otv.90.1600296936634;
        Wed, 16 Sep 2020 15:55:36 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:7cad:6eff:fec8:37e4])
        by smtp.gmail.com with ESMTPSA id s196sm10232928oih.26.2020.09.16.15.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 15:55:36 -0700 (PDT)
Date:   Wed, 16 Sep 2020 17:55:32 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: pci: qcom: Document PCIe bindings for
 SM8250 SoC
Message-ID: <20200916225532.GH1893@yoga>
References: <20200916132000.1850-1-manivannan.sadhasivam@linaro.org>
 <20200916132000.1850-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916132000.1850-4-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed 16 Sep 08:19 CDT 2020, Manivannan Sadhasivam wrote:

> Document the PCIe DT bindings for SM8250 SoC. The PCIe IP is similar to
> the one used on SDM845, hence just add the compatible.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 02bc81bb8b2d..7fc328c54c39 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -13,6 +13,7 @@
>  			- "qcom,pcie-ipq8074" for ipq8074
>  			- "qcom,pcie-qcs404" for qcs404
>  			- "qcom,pcie-sdm845" for sdm845
> +			- "qcom,pcie-sm8250" for sm8250
>  
>  - reg:
>  	Usage: required

reg-names is missing "atu"

Regards,
Bjorn

> @@ -131,7 +132,7 @@
>  			- "slave_bus"	AXI Slave clock
>  
>  -clock-names:
> -	Usage: required for sdm845
> +	Usage: required for sdm845 and sm8250
>  	Value type: <stringlist>
>  	Definition: Should contain the following entries
>  			- "aux"		Auxiliary clock
> @@ -206,7 +207,7 @@
>  			- "ahb"			AHB reset
>  
>  - reset-names:
> -	Usage: required for sdm845
> +	Usage: required for sdm845 and sm8250
>  	Value type: <stringlist>
>  	Definition: Should contain the following entries
>  			- "pci"			PCIe core reset
> -- 
> 2.17.1
> 
